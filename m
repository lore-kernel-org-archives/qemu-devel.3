Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1227BFF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMMP-0004di-EZ; Tue, 05 May 2026 16:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMML-0004ZQ-MB
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMMJ-0002fZ-I7
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778012830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J6hDMSlX8QSa9powGt5inke+kVsGYViV0WMedvJhWK4=;
 b=Rn+lBjVF/Gr8El9kFMc401e8T+dxIxIlP941MVAZy38f2zP9dCSVNZJv2EIFRr0dO6+4H/
 k6MXk9vJ4FCzBQUncMPv1Va3QupbncLTsJonne2uTQ2knAICjRSszpw6ybk+u1+qzmFGvD
 p02PsNy28tuEPTMVSQBirbeEtekS/70=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-pYTfOn0vPBS15ph958ChYA-1; Tue, 05 May 2026 16:27:09 -0400
X-MC-Unique: pYTfOn0vPBS15ph958ChYA-1
X-Mimecast-MFC-AGG-ID: pYTfOn0vPBS15ph958ChYA_1778012829
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8b459fa5f76so77892786d6.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 13:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778012829; x=1778617629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6hDMSlX8QSa9powGt5inke+kVsGYViV0WMedvJhWK4=;
 b=PFUhKFcOHtAZ6QgRevYeTULJ7REDN+BtBVe2+yFkjxscxWE6hCwqH3lyJrVCa4UopC
 n/tzodjXhouMZnR/ohePc6zx5CCzURQDvYVjwvoZIQnaZ9xULdE0C91Tg65GhhZmWK68
 N72j/XE5zRZnz/JlpZtWa9jEYZKUKEtudUkHrik2RVVV29DZm87MQJfl7+9EY9swBp2K
 WGywnbjIi4e1nZb8m7CYXTl/uAiX6Z7Z4H+v6gFaJR9G2Y/+kGRHjBFHR1dKPjaBobdS
 vLGbX/w9T0CTIl6DR/izcmwoh6QzSN3e3x7c5Zp255G8RnhBoRNY1bHtzUIUBMcIezhZ
 kNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778012829; x=1778617629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J6hDMSlX8QSa9powGt5inke+kVsGYViV0WMedvJhWK4=;
 b=kKuwAyVrp0fdngfRyA6ynGtiXrejSzcvE8ZVEmuFJSmH/Tbx6TyaT6S2c0YIB8hvP8
 0az82N8atXureYlqLte2I3/8slPjdUDQLaTyUhabRq+fVbY5hhH99dSKwG22zMqlm1dQ
 SgxzpKGwcCU6uo68xoJH1Hp/V81vrjs68O47AI4ac3yxQELksCWyj42hKzmq54fqnzp+
 xfEXnhKuoDDx1k1GqJKCJXM+V3zWyxyuRGo2YoaRQ2lls+VpGebla/0GKrRa0ocvMf2C
 tT1UxKvOTDDTbJdpF8aam5A792JiC4JzJSXwmCDMcY/GR8PtT7HG0l9xsUY43Al/ZJL6
 aRlQ==
X-Gm-Message-State: AOJu0Yzm3zJ6rb3xG7DxBXwG1gadTq5bmRNH2x1LXChFtL/opQmit/uZ
 sdIfvV26V/LspbcCb3bMVJEg9z38GW9YBTJS0ZWczh3YJJJM4+5+LDXZmfZShq172TiE9FxzYK+
 4f0uTewTQkQSoCUpdv4fqJh+ZqRROd+wUjrq2u/7QtWVcCCP/AHo1PJH7H0g1rCtHlExMivWsSh
 p8LNZz5tYXJKPjtZ6MiVKS3122seryGMc6yBTVgQ==
X-Gm-Gg: AeBDiethUJoRYPdgMYOb42xzi9TbYFqohF/On4tpECoXxU4EwI9BrLCCYrojnBxaIXr
 VIFLU4MeIdTFxwqvNVqx9uOwPNpa4hglq53N6mEwTbv9vD6uujZAio6LM+aVT1TdrAWaLNNs/th
 XoxZMtx79PGcrQ38P2r5t1jLiQbzEDrQnVXseQpeTQxWAxdufB8c8ikEXQH83l7QFHr+qT8e/tM
 0vDjf6mzlTzXciTjHialk+H5tNMEadhrSHUGW68LPocCCyX8mMguUSobWqSs/7kHk66YbRrUtI8
 X+MgVXC6gpqPW3yM0pQf+ZUYUoRQjsbb4Ta83zXJrxT01fOSOTAeJKmHSWsk/f5vNk2HE/+Ic36
 vcL83Tkbn/U6jCVS4o9El76koQsFMNNT8J3P18ifzi3nXV+oVADNjp9A=
X-Received: by 2002:a05:6214:c4f:b0:8a1:8f74:3eab with SMTP id
 6a1803df08f44-8bc4249d7a3mr5224056d6.9.1778012828747; 
 Tue, 05 May 2026 13:27:08 -0700 (PDT)
X-Received: by 2002:a05:6214:c4f:b0:8a1:8f74:3eab with SMTP id
 6a1803df08f44-8bc4249d7a3mr5223336d6.9.1778012827948; 
 Tue, 05 May 2026 13:27:07 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53c6b8123sm155283806d6.35.2026.05.05.13.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 13:27:07 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 CJ Chen <cjchen@igel.co.jp>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 21/23] hw/xtensa/mx_pic: Specify xtensa_mx_pic_ops .impl
 settings
Date: Tue,  5 May 2026 16:26:38 -0400
Message-ID: <20260505202640.1011006-22-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505202640.1011006-1-peterx@redhat.com>
References: <20260505202640.1011006-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

The xtensa mx-pic interrupt controller has a rather odd register
setup, where some registers are 32 bits but are decoded at offsets
only one apart from each other.  The QEMU implementation handles this
correctly, but it did not set .impl.unaligned = true.  This has
worked up til now because QEMU has entirely ignored .impl.unaligned,
and just allowed through unaligned accesses when
.valid.unaligned is set.

To allow the possibility of properly implementing synthesis of
unaligned accesses by the memory subsystem when they are valid but
the device doesn't implement them, and for clarity of intention,
state explicitly that this MR's read and write functions directly
handle unaligned accesses, by setting .impl.unaligned = true.

While we are adjusting the MemoryRegionOps, we set also the minimum
and maximum allowed access sizes.  Since the only way to get at this
device is via the CPU's RER and WER instructions, which always
operate at 32-bit sizes (see the HELPER(rer) and HELPER(wer)
functions in target/xtensa/op_helper.c), we know we will always get
32-bit accesses.  Specify explicitly that that is what is valid and
implemented for the MR.

Add a comment to clarify that the hardware behaviour here is not
"true memory-mapped registers", so the odd-looking implementation is
correct.

Based-on-a-patch-by: CJ Chen <cjchen@igel.co.jp>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Link: https://lore.kernel.org/r/20260428093339.2087081-4-peter.maydell@linaro.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/xtensa/mx_pic.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/xtensa/mx_pic.c b/hw/xtensa/mx_pic.c
index 07c3731aef..098c1aaf85 100644
--- a/hw/xtensa/mx_pic.c
+++ b/hw/xtensa/mx_pic.c
@@ -69,6 +69,26 @@ struct XtensaMxPic {
     } cpu[MX_MAX_CPU];
 };
 
+/*
+ * Note that decode for these registers is rather strange by the usual
+ * MMIO standards -- the MIROUT and MIPICAUSE areas can be read and
+ * written at 32-bit length, returning different values for each byte
+ * offset, because the low bits of the address are treated as selecting
+ * an IRQ or a processor:
+ *
+ * 00nn         0...0p..p       Interrupt Routing, route IRQ n to processor p
+ * 01pp         0...0d..d       16 bits (d) 'ored' as single IPI to processor p
+ *
+ * This is because (like x86 IO port in/out accesses) the offset is
+ * not a memory-mapped address but is really a register number,
+ * accessed via the Xtensa RER/WER "external register" instructions.
+ *
+ * We set .valid and .impl to both allow unaligned = true to permit
+ * these byte-offsets. Because this device is not a true memory mapped
+ * device but is accessible only via the Xtensa RER/WER "external
+ * register" interface, all accesses are guaranteed 32 bits.
+ */
+
 static uint64_t xtensa_mx_pic_ext_reg_read(void *opaque, hwaddr offset,
                                            unsigned size)
 {
@@ -267,7 +287,14 @@ static const MemoryRegionOps xtensa_mx_pic_ops = {
     .read = xtensa_mx_pic_ext_reg_read,
     .write = xtensa_mx_pic_ext_reg_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = true,
+    },
     .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
         .unaligned = true,
     },
 };
-- 
2.53.0


