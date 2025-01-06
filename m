Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F269E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 20:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUtJk-0002Yk-25; Mon, 06 Jan 2025 15:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUtJh-0002Xb-8L
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 15:03:13 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUtJf-00039t-1g
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 15:03:13 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so9136537f8f.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 12:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736193789; x=1736798589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gw/8miEe/PnaBFePSWTnOg3qI2ZvVUjrjdrVrAxgzBI=;
 b=px94p8GTMutot+SHUgInntlxuc3KrdY9cMjay+uyCuTvj7o0bEtZhFjtiEDyvrVejT
 MuDVODS4PYfHutEAn/g+Tg7RCF/BlMk2gNSX6Dw9tEfIfqsnHHwydriIbv028d07/waj
 2iHCsMYBEEjJtjntVB6ihxFgIWyBG6OWhLCh23LW0EbfWluU4mgYdljo2dlyHguMx1dM
 BdGi65sVqkXTN8zl8UfKa/VKjcLv4EnprtSeja7pEGiCU2AD4R/Wx7mqlQdEKAt2aOtH
 ZAY5P5YPaPVQQTxgKgzvTiyPecLOgblrNqOf25TjTyLH4YDiKU0dFnKBGPeaWqKjawX7
 e1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736193789; x=1736798589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gw/8miEe/PnaBFePSWTnOg3qI2ZvVUjrjdrVrAxgzBI=;
 b=M0/fjsOT5s0v2Q12qwWaNylqTYC9LajlCKtQbB0PGcUOdfJT7+XKr6upPc7an0Fr57
 V8r/JFlfNFR+LXhA+KlYzbfsItW02AESdWxcNUEdp0XaosNya7At05FywQqeWe3YDDLt
 yiPuuPD0RZDDgVK60qdNIznx4Au/pxQRwJHutZ2mnfgU2X5zVqhCWwf/MHnMObETf/zW
 8K4dHOrhDcXWYSMLMTUecaYz/FPWcskbbhd5+tkczpCUy1uQrIgZ2M4og3lcFioE273/
 ibgFSZU35HjKC8/AtyNu67JRx2rh4AcJnOrkBofK3bhZAtO+bVqO716s7cx2QyphWKTw
 qfCQ==
X-Gm-Message-State: AOJu0Yx7TcgKQEojuSgafS4BDAaT7IrqryJy+buxrQzuUvA963Obc88Y
 k6raust9lMqOboajg9aEvkxyH81MxBsqQhJEcYtata+NCYc0e3rMO7FeKBxidRHi2UaACPB1FgQ
 7RaI=
X-Gm-Gg: ASbGncslsmmZPznTJbYNdsZ9ess3g1a6HtpPuHdrNh/OrocZK9s3lgRGe1hXBn0gbO7
 p+q9qOfWlvJPtWLrZaV1SXA9JdZUULshrTjxViGrMTawO4RsOhdibQq9IN+6ddDfAeN1HJVw2v4
 OVWcP1PyBxIyXBt8DeD9EvNm6OrS/PiDvYNxcKLyWDCSWOwJvFtUlFJtOjXNlfbGEubehwAv02Q
 17AJeZOUJVfz209xp1gvWc6fSVPs4nz/iQnmHgGhRwUgFr4JEn/ijyDQRzG7ZQYb2YbTh4AQqeC
 RA5A4fgG+/IA+VDGnRkGWTAI+kc/TQw=
X-Google-Smtp-Source: AGHT+IE81N1RplBD8FCsdoj95sqyVSqitqWpe38bLlQuumoNL1lLDdZMOpwBwgd43Npz//MFxfo/tw==
X-Received: by 2002:a5d:64ac:0:b0:38a:4df5:a08 with SMTP id
 ffacd0b85a97d-38a7923b959mr440924f8f.22.1736193788891; 
 Mon, 06 Jan 2025 12:03:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43665cd9c29sm559552815e9.14.2025.01.06.12.03.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jan 2025 12:03:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Alexander Graf <agraf@csgraf.de>, Paul Durrant <paul@xen.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Riku Voipio <riku.voipio@iki.fi>, Anthony PERARD <anthony@xenproject.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 David Woodhouse <dwmw2@infradead.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH 1/7] cpus: Restrict CPU_FOREACH_SAFE() to user emulation
Date: Mon,  6 Jan 2025 21:02:52 +0100
Message-ID: <20250106200258.37008-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106200258.37008-1-philmd@linaro.org>
References: <20250106200258.37008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c3ca0babcb3..48d90f50a71 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -594,8 +594,11 @@ extern CPUTailQ cpus_queue;
 #define first_cpu        QTAILQ_FIRST_RCU(&cpus_queue)
 #define CPU_NEXT(cpu)    QTAILQ_NEXT_RCU(cpu, node)
 #define CPU_FOREACH(cpu) QTAILQ_FOREACH_RCU(cpu, &cpus_queue, node)
+
+#if defined(CONFIG_USER_ONLY)
 #define CPU_FOREACH_SAFE(cpu, next_cpu) \
     QTAILQ_FOREACH_SAFE_RCU(cpu, &cpus_queue, node, next_cpu)
+#endif
 
 extern __thread CPUState *current_cpu;
 
-- 
2.47.1


