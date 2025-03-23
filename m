Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8090CC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 15:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twNHV-0002Kv-1A; Sun, 23 Mar 2025 11:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twNHQ-0002K8-EG
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 11:30:28 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twNHM-0006ae-7l
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 11:30:26 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso35943905e9.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 08:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742743821; x=1743348621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yerTe46hOeOx/6uzV6bvMyIILUze4DRGCFduLBD+Bkg=;
 b=byU6n4qzC+VX7bMMXEcX+PU7IhDXehkl/Ql0EqND4i2XGa7ePakGvW8Y1n+ss+I3xE
 /NiD3LxAm6QouXg1esHic+IUF+8rqi/y+5upZheGVYhJy9CC3ijfsNZa0XCOg80oegq9
 EvboMv3X+VscDOYdgD6YucnMqombEd+8Gmp94rLW0fgQwnciiTldHa7Kcy7SIh5gBJik
 vJjUkIaWNM+8x13in5F1Zf47v2bm9MmOpOuGjJjHrC2k8A88115Tzs7iP0gs2xb50+GS
 IjbM/NcMxxXWZCXGAtmjr3SYoELwCHfIHjg1d+3Uv+MF/Vx9qM8lXVbE/KrAlKlThm0W
 UgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742743821; x=1743348621;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yerTe46hOeOx/6uzV6bvMyIILUze4DRGCFduLBD+Bkg=;
 b=Ac2tetUpMUQHT5e47h0gfFb+CF3LlRVuhVcbl2m6y94b3NK3cPwo2KoWVQYaI/OAqi
 abVwXNWTlvrFRlCLDjdvx1eGUzP5aZ6uY/3DvBsiw2NUvO/ou3AnKAauK0ytJB+G1pRV
 0Uhmv9MbLvtEZ69uN8yZReOlcwPYzpOsGzwm9PZaqH0XeCSG+aQ+3b/su5Xz0DTtFJLy
 TNbnnkwcR+z0loBHxCI8VpGx6j1++l4dIcAzPPdhjMjRceJJM/npvdNaypd7wslfarw8
 rxwJ4kN6sm3VtXJBZrJSnxbPsRB4yBfibku8HbT2hcFrE0iyzzfcpmtCuR1v/pp8rgvn
 Encw==
X-Gm-Message-State: AOJu0Yyyrsh/VXyD5ADymrIyG8j4hFbirtyYIO+wuohCIQtXjmGAFHhX
 fzulnFryRZGfH2j5p0qfIcLnTnPpeojb7SIRw7mXHWxXc8tDFXRZAaWqksw+yWlZn013CEJHDaV
 I
X-Gm-Gg: ASbGncvFcLuWquC/ADAgS/ZERscsOg28wCNQ980w87KQDegjScOOCDsSYkKe4ltkuZh
 HMUT0w1Qn8OUloTWplkLGR9w85oQo9Edl67Fm4Hr5Y2HM6zb8EdYkjCtzSS3NPCpIHcsMmmfCO7
 fKiUZRlaSqM+G6rWWWAvdZrffnZKddDneIIuHX4AZUovBkBajvzU8OTJgxX7pnxb8XiRKIUpIXd
 nF2kjDCYVeR4ZZNtC8AP3XcoahB79OGMxqFkrBiCbZo3z9HpYSRpVIIuz6jOnyRyE4dgZrYLNqz
 zFtQ9u6mGU44AHvW8cQssE8P3gjV/yfDb2ttCLbgpGQY9CiH8PwYxYT234pKPfoVMAy1s3OC0fW
 Pi1n8D3YPzRpHgtxn/CA=
X-Google-Smtp-Source: AGHT+IHJksFDBl5nsv06LwH7ppCxJvcRLA5hTkOPQiPn9haa6/QvOluDnPtq/QDPVFWj/f5X3esmmQ==
X-Received: by 2002:a05:600c:4693:b0:43c:fda5:41e9 with SMTP id
 5b1f17b1804b1-43d50a5237fmr72353295e9.31.1742743820868; 
 Sun, 23 Mar 2025 08:30:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b517csm8215543f8f.51.2025.03.23.08.30.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 23 Mar 2025 08:30:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/s390x: Fix a typo in s390_cpu_class_init()
Date: Sun, 23 Mar 2025 16:30:18 +0100
Message-ID: <20250323153018.73491-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fixes: 41868f846d2 ("s390x/cpumodel: "host" and "qemu" as CPU subclasses")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index d73142600bf..1f75629ddc2 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -377,7 +377,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     resettable_class_set_parent_phases(rc, NULL, s390_cpu_reset_hold, NULL,
                                        &scc->parent_phases);
 
-    cc->class_by_name = s390_cpu_class_by_name,
+    cc->class_by_name = s390_cpu_class_by_name;
     cc->mmu_index = s390x_cpu_mmu_index;
     cc->dump_state = s390_cpu_dump_state;
     cc->query_cpu_fast = s390_query_cpu_fast;
-- 
2.47.1


