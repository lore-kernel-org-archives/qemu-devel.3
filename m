Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417EACCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 09:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAmVx-00075Z-RE; Mon, 20 Oct 2025 05:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAmVv-000750-0Q
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:49:15 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAmVt-0001dM-6s
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:49:14 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-471076f819bso33175165e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 02:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760953750; x=1761558550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4HKXcyz/2clxRpS46l0Vexb09ZBfH6sW5WdctLeLR9Q=;
 b=vbjQhIDR6JBGTVWD/Eljeo3OWKpGn9WhwNnSRnvYwFs3QUcfLXPknYOVnszMYGHzpP
 tjEj6an7it6fsI0v1YU8nsF7Y+rms4u9K2zC8JrxWf0eFTACkyI9OrTMLWkcArl0z5wM
 GMPD60kNLT8QAr6JHxjVGayHqFMKJVjVOA1Dq6v0wON6ItJNWEswekFQFOW/Li1Ej5Vs
 He7YOKKU3xdz+SXTuWEkrgvc1Ltidi1iasCZPtlLaEvWQF/HQk/BcWjLoJR0yp1bo318
 KBYQUzrljB5Db5Oeho0YPLuWsQChwgtk/Y3OO9FnuJZCZp6mQxGjZX46RbcnOCJA6/WP
 tbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760953750; x=1761558550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4HKXcyz/2clxRpS46l0Vexb09ZBfH6sW5WdctLeLR9Q=;
 b=MsyPxvabUGKb8a/RbVVLKDwHVD/xl44zZYuYkswHuERM6MuhXz/Tl74nSq43BFxwDP
 QJ1MgvRE8yz2NvoKaJVx/vB4CBhKiHagzkNlKaBQnjs6IbC01XvapYYKB4snGhfjkzQk
 yt9HekqqpML+csynd+8AEnf9QQT5+F9FgP1Z/u/NV/K84Zpo+MmLL0Yl3UWFalto9v5Z
 Xary+7hkRhdEZ9NQA2LkBjSo8RHhxjX3eWHpMkoAC2+l7XsDJJJgEBEhddDZlXsT0mYu
 8hzqL+vj3+GhTbAtbpz/IC0rP7m32/ppKh9JocBEfpKZ75fIG4bdbj8p0Ci48WX1rHWR
 FFuQ==
X-Gm-Message-State: AOJu0YxVtbWUiMskJMAZkcuIwvf90v9nVdNJAowMRUse077HX0NXQ9e3
 zCR+qGxwA8Cw/ovAWwZIwYEguIeCTJm9WJWTTvW+n+hBtP38xMLcBX57XULrM+ENsRKzyyB9eft
 ghp1srFk=
X-Gm-Gg: ASbGncuH3mm/yxuOcSX76+1lWsobaUbhjP14mXqaee6oaFnxqEPESpqtCW/YR9wDqwR
 LxpjzMJ5Lu9QForqaYs2s1i+yuTJSuFGhswIOnEj0MqlTEYZRorShMG83jsqCZaEIKPOWLYRjT2
 mdsbqY0Xr4lklmrcYeCUq/WyKjaadZ7q+gH48Xoq8HMmuGixujPsPKgrKnLDI29OmT7jp7kEAri
 BCMN224QDJNmJgp0fBxmnKlqwRDuOhg4PSt5MGMNuIAd5zCAasWqFjfnY6vd1+n0/QFZRSjfkRs
 wA2w8da46SwmSkRDY2aTdOEVBtGoI22vttX7i8mxgSrRqpS2nsjVFi77ErDOtcByoH1nW78AyLs
 kW2UFFyoR8kyhRC4xJB52IQGs2ryQEUQawA0rXPPoPTJS4HAaxXWwbvDyr0N5oznTOSIXnN+qmT
 F/STKTDzBYMFYfMf81KlG4w25wug9XSXznYfkVAv/HuN7IPub22m17h89KS5jXY9JSirxyekM=
X-Google-Smtp-Source: AGHT+IEOD348iuHr6ywW2js24djhFGfz7W33unbZqE2zoiAS9OpAq2JBOSB/Negj+LaIlFH7rpqpgA==
X-Received: by 2002:a05:600c:1d9b:b0:471:a3b:56d with SMTP id
 5b1f17b1804b1-4711792006bmr102464465e9.34.1760953750028; 
 Mon, 20 Oct 2025 02:49:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711442d6c6sm216578845e9.6.2025.10.20.02.49.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 02:49:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v2 1/3] hw/s390x/ccw: Remove deprecated s390-ccw-virtio-4.2
 machine
Date: Mon, 20 Oct 2025 11:49:00 +0200
Message-ID: <20251020094903.72182-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020094903.72182-1-philmd@linaro.org>
References: <20251020094903.72182-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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


