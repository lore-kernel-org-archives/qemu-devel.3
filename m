Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7620CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYst-00028q-II; Mon, 08 Sep 2025 06:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYsV-0001uA-T7
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYsK-0000yi-Mr
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757326399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7joNFhlKCq/65i2RHs9pqNw9LGInItxc9SYTL3XBLRM=;
 b=ZlyhELw+54BWda4fTs2NcQD5nkcknU5vggajS/IeH8NxNZUgnJTc3PJ/Fi0jF14DCLhSL7
 s1PXAwym7TDSilD1HFe5dl+Lsc3mfeZRW8re3mBU4iEYCfkOF58Nx+kpKIH2DfneZ2lrIi
 zJtvwu9/lITKpfgOZViBNcbS3qECQiE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-igiFS-i9MhmzylMlGJqG3A-1; Mon, 08 Sep 2025 06:13:18 -0400
X-MC-Unique: igiFS-i9MhmzylMlGJqG3A-1
X-Mimecast-MFC-AGG-ID: igiFS-i9MhmzylMlGJqG3A_1757326397
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3dbf3054ac4so2451761f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757326396; x=1757931196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7joNFhlKCq/65i2RHs9pqNw9LGInItxc9SYTL3XBLRM=;
 b=rw9BDUdJ318CUl2GufsNQHuXM/X2YvfKXMBKiWYZ9j+uYboTpdNGm7tWpvzum0v0Yc
 iDhyxUql8SLGR/YfIMJKGHNMVXXPF/sdLVfJfO+P5CZCI0mTIhbMQu48h3L9uYFI9q1B
 +My4GlwMtf2LZC0R9PNOeyH8FRXa+XWUX3UYBhtwGAlcg02hSe+EfWxVgoEOC7kQ70fM
 bd2SbQBYFXWMM4NdenmltgJqHcI/5QjFLGVtctGGye7KBe9upowbHcMMciUBDiqeFVgW
 kyXY4il/LsgaUR/QOJEPQVNsMn1uAxV3YOm8x1PDrGxdToGsBjm2mDKXbFubydPIMvbZ
 2U3g==
X-Gm-Message-State: AOJu0YyDSmwCFWoh00h/meH5lkWFeEjFs25RwrlfHsKZa7NuWhw57Vot
 ULNxtMrBU4VOXM1nhVeskWXCrvdNccslml7YMfjbHNi6SmgNHa82MOw8nRhOMUi6KK2w4t1o9/n
 blgke+37pOT4/mB7TzEy5p4e6kkkQvmRbx3XDqBZ57ujO46tnQCjcj7qweCPYyrCLaOSpbDpTw1
 rEz67GnsvLimyeonPKCLz/3v2AO5V2ji4C+YQjVmtR
X-Gm-Gg: ASbGncuiT6HA9fKKoSiYXXV6CpCZc/7wvnRsT6JfeZ1s8dILPNZXT/8R1hn9dya9r2/
 UIMA2cxIYgSLfcRK/f8qqEiYv2xSZWzb9prk64RgXIlVmuMHmT+XxaryPr5jP5iHBjXheHddNbj
 DPP8hESeVS5nAYpgmnvyxRCFLWdHoRp5wDtnIP2FG2rWYpsGNOe+TaatkQLi9TfFbukALR14L7T
 nOvufe0oRaLRZlX0c7Q9NCPX4R5DeBxpae7KPyLdbau2rn/PPNVBviJpTdz79Eh9Wy1LelLA+Sv
 jvgCDVHi8UWfi3zOHEYWm+sYzqi727OtX7HL2UT3MSGzP3rFfr7MUBzNsZ+OuV958rQTcx/TxlJ
 8wmKlj8ZTJK3j9STEe9N5SYP+eAFp9Dnd2WCXAaPo7ZY=
X-Received: by 2002:a5d:584a:0:b0:3e0:152a:87b8 with SMTP id
 ffacd0b85a97d-3e636d8fe92mr4845535f8f.8.1757326396447; 
 Mon, 08 Sep 2025 03:13:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6wpkvhjlwFo5OKt5dWh6HWDtHXYSRjcuxnI1ZhwafTs5xV2Yy7275cyqfro4trZUvCxEPAA==
X-Received: by 2002:a5d:584a:0:b0:3e0:152a:87b8 with SMTP id
 ffacd0b85a97d-3e636d8fe92mr4845511f8f.8.1757326395999; 
 Mon, 08 Sep 2025 03:13:15 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dcfc481b5sm88404475e9.0.2025.09.08.03.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:13:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH 13/19] cpus: remove TCG-ism from cpu_exit()
Date: Mon,  8 Sep 2025 12:12:35 +0200
Message-ID: <20250908101241.2110068-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908101241.2110068-1-pbonzini@redhat.com>
References: <20250908101241.2110068-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now that TCG has its own kick function, make cpu_exit() do the right kick
for all accelerators.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/cpu-common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 42463e6258d..41a339903ca 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -76,9 +76,7 @@ void cpu_exit(CPUState *cpu)
 {
     /* Ensure cpu_exec will see the reason why the exit request was set.  */
     qatomic_store_release(&cpu->exit_request, true);
-    /* Ensure cpu_exec will see the exit request after TCG has exited.  */
-    smp_wmb();
-    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
+    qemu_cpu_kick(cpu);
 }
 
 static int cpu_common_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
-- 
2.51.0


