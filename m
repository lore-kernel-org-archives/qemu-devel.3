Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6140CC87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 19:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukSJO-0006Gr-Fx; Fri, 08 Aug 2025 14:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ukSJM-0006G9-HJ
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:59:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ukSJL-0006gV-5R
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754679565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eYQcv6qlBgnWelc57LUkepuCpfhOAkj1K2N9G/HXj+M=;
 b=MxIjN4doXVJ3SNlIdF0bCrBQG+hV5Lzy3u8xG4UY7QJyHKE5fvFaxYxyu0XEYAFRlJ1hOV
 p3+PD9v2M7Db0Xgd1ZQEYdPsvZ69Ek0gTATVgA0j2V+kynQ88xY7HHH+pbkx6IUqLysRC6
 cmamSZHwru8EiGW+mxFEaWpBwyjghvA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-Iy9ZX7rBNE2MO2wOT7Aavg-1; Fri, 08 Aug 2025 14:59:23 -0400
X-MC-Unique: Iy9ZX7rBNE2MO2wOT7Aavg-1
X-Mimecast-MFC-AGG-ID: Iy9ZX7rBNE2MO2wOT7Aavg_1754679563
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3b7892c42b7so1610455f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 11:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754679561; x=1755284361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eYQcv6qlBgnWelc57LUkepuCpfhOAkj1K2N9G/HXj+M=;
 b=qN4tKWWzftsKmqc693NpCuiQfaewO7+ctXm/kQPE8DOaMb2Zu7F4irTegTOVJLhkel
 zCClo9b9oF284BYTFdFAxr91KDeo4puwh9cRB1W/ze7N672xGKIxx4M0I/g1e7Lb/+pG
 xypIUjHGUjjP6h2l7kLkysAHIlH6VuLZQu3JZTNpy8ViZUMC4JHrYF8OKu+cpgkE1S9W
 AwOg4LrjH+LK9B0pjUV6WV3mADAnT0LXqc1hzFcaWVtHpN3U9k0kDB0bfUNWAIsfl4f3
 I5QY+VMBq5QSyMSHlnICh+Ek8+zzVQNkDogfLn4tDGy0c5HBBNVcSo6FlSY6W+ni4zFk
 kqCQ==
X-Gm-Message-State: AOJu0Yygr/SV09zgzDvE2tm+ZawI0FkTrbFgGUz6trYgmZfm9X+M/nIM
 ZdbSb0N3ccFX436u+SZE2ZRPMnTwUAWz0OfZn0EX1Fb1hc9IGEsP95AsklFvEJ4i2WpywncGc/A
 vUSUu7sYLmDD7DXjEGnAoG6Sd6k22znm9/BeSwIJ3dlI5GA7Y1+AygDwTfEZkfYFsLf+3pS85K2
 Zu5Qh1f8Jfk03IzsENEmsJiGjl1qJvvd/LFyyJ4+4t
X-Gm-Gg: ASbGncvxaQJ5uc9LFnWFviZ5ofN44M/GFsKHjJljgZ9AteOMfgZRwud9+KHgTHprLnz
 XwroQ2YtgE5hHtZVoXTvPBdb52Te/L9sWW10RWcDqjqxUOHYj1FFcvNOdc+CWVnL8HLKzCMVFni
 Hp5I0CkoxmjurQYtO2QZQk5UxWXbvdUhEHbN69Kv65AieiqSWesHD93kczYR/95IivLodpi6u7l
 bkEuDXaloTVR2ICAZYpwHqVhVUczL+ykL3tpkFVuONUlzw1So2WAWTFntslWQuBuRztWL9i071+
 wdywLHL+IAtQehkI8Sed0IDDoxih613Vl0Sle/SljAsu
X-Received: by 2002:a05:6000:26ca:b0:3b7:9bfe:4f6f with SMTP id
 ffacd0b85a97d-3b900b7be30mr3244466f8f.44.1754679561351; 
 Fri, 08 Aug 2025 11:59:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRNJSHOUZbKQt3AdENiHJb0x+mHxo9v3+VaApJalxphvkHuxZNDUb+RfcypKuuZL9NMZTZCw==
X-Received: by 2002:a05:6000:26ca:b0:3b7:9bfe:4f6f with SMTP id
 ffacd0b85a97d-3b900b7be30mr3244451f8f.44.1754679560891; 
 Fri, 08 Aug 2025 11:59:20 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.234.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e586a011sm160547325e9.19.2025.08.08.11.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 11:59:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com,
	richard.henderson@linaro.org,
	peterx@redhat.com
Subject: [PATCH 5/8] cpus: remove TCG-ism from cpu_exit()
Date: Fri,  8 Aug 2025 20:59:02 +0200
Message-ID: <20250808185905.62776-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808185905.62776-1-pbonzini@redhat.com>
References: <20250808185905.62776-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/cpu-common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index f189ce861c9..045b1778236 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -86,9 +86,7 @@ void cpu_exit(CPUState *cpu)
 {
     /* Ensure cpu_exec will see the reason why the exit request was set.  */
     qatomic_store_release(&cpu->exit_request, 1);
-    /* Ensure cpu_exec will see the exit request after TCG has exited.  */
-    smp_wmb();
-    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
+    qemu_cpu_kick(cpu);
 }
 
 static int cpu_common_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
-- 
2.50.1


