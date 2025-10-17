Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE82CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kXp-0008WT-SC; Fri, 17 Oct 2025 09:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kXJ-0008Q8-SJ
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:30:31 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kXC-0007uX-Mo
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:30:24 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-471131d6121so15214175e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760707810; x=1761312610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4HKXcyz/2clxRpS46l0Vexb09ZBfH6sW5WdctLeLR9Q=;
 b=TM1HLQambANHm8tun/EDbl4cNmyC7N7uHwXIH56A0z+gD6zo/RYPBL55Ih+qwXzX5o
 arOorzPylkMjMg5vB2L/vWu12HuztiHXkTL3eZcMewtXLmyy4YGMOEL3VUlyf2tYWYcQ
 mmt0hDreE3qmp9psAoXHSe/mVd9W07NcB25maFl/iOvVgJvNxBsQorp9WSCDJcRW9dCt
 6eGlSVd1puxzBX7xS7hi4UKDfNK0IIcyJpDF10jiZT9YX9Vu7grZkY3S5nbt1XkxymMM
 h/GgyyopCCHCf+LG2KIV2GRxYr+oTyEbJdRcQnD1u/+L0UxXCmfOLdVRBPtqLo/NohQ5
 lMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760707810; x=1761312610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4HKXcyz/2clxRpS46l0Vexb09ZBfH6sW5WdctLeLR9Q=;
 b=CX1CjOgn2k3QZ+dnyDQxp6hoKg9jJZDp6L7ZeEs794O3uQbYtr+dliZSphJztPTHtD
 7iTD+hYMMdy0JvJc6yHnChbMQ/jEFMSDG0/AQ73+R0tvKC76lAMruulEVzu3Zv616tgb
 dkIAvj69lVGNGQSsngup2Z7b3+Kr9dHBPFjTtt7aroD4GByiw9tzOjrJdJm0NwL5Gjcj
 xNrlxCXxXS5ho2Wm3Zuf92bpV/rbsabcM0kI17pQTumuZzO6oD1upaXKe0mmwwR6ePWl
 dYoSgMvVGYtT27a3PX5Y+DJXuYROSx6c+uK1SU16Mh4AU4WkBEFiliEtOEUBAoYkLnhZ
 w4og==
X-Gm-Message-State: AOJu0YwdBY8Vc4MgECnNyyr7fSGblBXkRXlzqv6gbWQiuGjRvDmlJyEz
 ir+l+YJlRia08Bi1l1Zh7cUzpHKu5q8HBgfh0Kf8V5RmewKYxhjmR87EuyUTBB9h9R4VCCcJbyw
 U04KQ+hE=
X-Gm-Gg: ASbGncvOYRq3rFbsgdmh3we3cgtFiMGZUjgHjrkkY/z4DTjJGeaXecJ44/maRVTHtDd
 D/HMcBz6eBPWWmMj5r6mG9UVdgQXtVD3GOB/M+8dkoN13l+LGGQFk6yFhRbSBeIthIBwAOFizHM
 E+pbkenhL05s5046EabIfivs7STzsFaf71PU2XLfoHwGbR1PoRyhof4VFbLPIZ8pn0uLWejcZ+f
 hWOeGLohrpEY+o/HgqROMI5g4WP/I81cHgmOEIfWuh6Qb/nI5+oNunCXej4q6Utm/rb/HVXDjvq
 BO9Z0kN6y1NkpHFd+D3DYj2khF1GJp6jpwyaT7F4/J9ymIKxw6mH6PQOWct4uqEDkpkKCHDt2WC
 UziWVv2Fsm5l3rFMDHMPp4bsxy/b048dkT+7md+SlxNqLc2JXupbDngW+y2JCHH97DEoRIfBhl9
 uFpVqpmbqK2H3eJK1oauDcjA7QRnSJs7GNuwvlj6AzCXA8QI2IC/h6U+YM/8Jv
X-Google-Smtp-Source: AGHT+IH7/sb/CTqOwFozAJIGzWAs6yn+Cyn7enFix7virXvNF1xQUDJ/t7Bjo3QErpfp83rQFX1SWg==
X-Received: by 2002:a05:600c:5298:b0:471:734:53c3 with SMTP id
 5b1f17b1804b1-47117901407mr22304335e9.24.1760707810155; 
 Fri, 17 Oct 2025 06:30:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47114429679sm79540135e9.8.2025.10.17.06.30.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:30:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/12] hw/s390x/ccw: Remove deprecated s390-ccw-virtio-4.2
 machine
Date: Fri, 17 Oct 2025 15:29:50 +0200
Message-ID: <20251017133002.61410-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017133002.61410-1-philmd@linaro.org>
References: <20251017133002.61410-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/s390-virtio-ccw.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index ad2c48188a8..64b81345f1e 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -715,26 +715,6 @@ static void s390_nmi(NMIState *n, int cpu_index, Error **errp)
     s390_cpu_restart(S390_CPU(cs));
 }
 
-static ram_addr_t s390_fixup_ram_size(ram_addr_t sz)
-{
-    /* same logic as in sclp.c */
-    int increment_size = 20;
-    ram_addr_t newsz;
-
-    while ((sz >> increment_size) > MAX_STORAGE_INCREMENTS) {
-        increment_size++;
-    }
-    newsz = sz >> increment_size << increment_size;
-
-    if (sz != newsz) {
-        qemu_printf("Ram size %" PRIu64 "MB was fixed up to %" PRIu64
-                    "MB to match machine restrictions. Consider updating "
-                    "the guest definition.\n", (uint64_t) (sz / MiB),
-                    (uint64_t) (newsz / MiB));
-    }
-    return newsz;
-}
-
 static inline bool machine_get_aes_key_wrap(Object *obj, Error **errp)
 {
     S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
@@ -1165,19 +1145,6 @@ static void ccw_machine_5_0_class_options(MachineClass *mc)
 }
 DEFINE_CCW_MACHINE(5, 0);
 
-static void ccw_machine_4_2_instance_options(MachineState *machine)
-{
-    ccw_machine_5_0_instance_options(machine);
-}
-
-static void ccw_machine_4_2_class_options(MachineClass *mc)
-{
-    ccw_machine_5_0_class_options(mc);
-    mc->fixup_ram_size = s390_fixup_ram_size;
-    compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
-}
-DEFINE_CCW_MACHINE(4, 2);
-
 static void ccw_machine_register_types(void)
 {
     type_register_static(&ccw_machine_info);
-- 
2.51.0


