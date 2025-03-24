Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CF9C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 16:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twl3y-0002po-2o; Mon, 24 Mar 2025 12:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twl3r-0002n7-Bl
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:54:06 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twl3o-0002bP-QE
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:54:03 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3913fdd003bso2370804f8f.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 09:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742835238; x=1743440038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qBgkYdbh7NfvXrXT6YdVCi2W3fse996zrsxnUtkRRIo=;
 b=s5xRnS6zuf95frfwauSFqtwNWYFF5WBsMbmw7l8em8cNQ6MSSBK3sFCvjzqR/vVIkQ
 9iYO1qYMz+THIJ4So5bmu3hBpjryjUgQrSRWTwVH0JwmzUTNh/hJMljE0o2KPuGandyx
 EXPUXj/41HZRl5aacDh+GbLrayxyNSyxCgHz5z+cXWmJAfffwrqivxbPJQRG8A7FM4F2
 pl7dKb3I0aPSrLOrwOCagEosLl6tkRmrUFusuE8OWlPuv5Ry5HjPOlgY+przqXKkhX5B
 /a7cluC/i3CB/bEb9DqaSvgmb6Ug/MVitx9vufFov8CaOYMAMnigjMpSdcEziilh6cU8
 4N8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742835238; x=1743440038;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qBgkYdbh7NfvXrXT6YdVCi2W3fse996zrsxnUtkRRIo=;
 b=PJLu3x4OI7QX7KPzS2Qd1BFpOu7Ct06dmvqfWC90jeEUOunHolzBlSTrHBTWdIL+YA
 NgKhsb058scWFb7UPo7rnjpDbgnkx4qAmeYo+KLRBnyQSh/192rYPheqCPKBDJGJQ2jm
 9n2gscww0ufcGtfkReozLgPdztOeP2UC1mYjuxQg1EdtB0EXuH+8u+yBnF4N9CKcbzVC
 Fb+3+hoMOpUCf7/XSz08uR+7S5Cs66j9N82yzDrmqA3Tjoj2qFWmDDTHU3UTiEUFWqE8
 tutugfqcFWiBT4HLxnm4vcwpIpkZ7vBlLVize9jMpcp5EvYlnGuwzxriYzpVXXGHv6am
 MRhA==
X-Gm-Message-State: AOJu0YzjdWtKyJBMgOJgxpwceQyUZRoi9clq6MiNQWWiI4vyqnCX4VxW
 eT72zvfDY25ZbGGA3CfGpwmEuPNicv/LgmHkfbK2/Iez4LipxJwjbP91yXgBhT+QU4roxthGMzV
 Y
X-Gm-Gg: ASbGncvM49c+m6kRlGMNqoaqO5Enu17Tc/GJsQ8xSNSGpPOWSYlcsJowhy/RSVbLeLt
 ux+ut1C5ohZwLoye5JdWsTfGioeCaFVZQe2uXhPKHdFZn7EJXwKnMA0IBWqQv7Js7uGZ0920wLQ
 oa7zWND5Xj2uUoWpb0rNlH+h57UBukBmXh9ZGjTkW/l1sy5Ny4Vy9H2a7p/j+uU4+yM87y9ooz/
 PWPF7SyS4tu9l33Bs/R9DMcSHBeBOTV6x88UryzMzxqKGfqJLcoEwmi8PAzbl9V+FVsCU+7ZTUC
 r7aXqxCUTbtWyHT845lGrqJenlmOF7aCOgfU7DVh694BSnOnZW3zdGj4/Ei4zHJF24qMCxSq63V
 gGrpygr3czBDyypCIz7fvMr7E
X-Google-Smtp-Source: AGHT+IHTSnqAT23pwL4/N4lDzowNxvDDIn75g1I0D7+t1cx4SxyzfN3XJso3lH06h+R3SW4hlBg+rw==
X-Received: by 2002:a5d:59ab:0:b0:391:2884:9dfa with SMTP id
 ffacd0b85a97d-39979575675mr17371832f8f.13.1742835238499; 
 Mon, 24 Mar 2025 09:53:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9a3b4bsm11331697f8f.25.2025.03.24.09.53.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Mar 2025 09:53:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] target/s390x: Fix a typo in s390_cpu_class_init()
Date: Mon, 24 Mar 2025 17:53:56 +0100
Message-ID: <20250324165356.39540-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Replace the comma at the end of the line by a semicolon.

Fixes: 41868f846d2 ("s390x/cpumodel: "host" and "qemu" as CPU subclasses")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 7ca34002d37..8449bfee5a9 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -384,7 +384,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     resettable_class_set_parent_phases(rc, NULL, s390_cpu_reset_hold, NULL,
                                        &scc->parent_phases);
 
-    cc->class_by_name = s390_cpu_class_by_name,
+    cc->class_by_name = s390_cpu_class_by_name;
     cc->mmu_index = s390x_cpu_mmu_index;
     cc->dump_state = s390_cpu_dump_state;
     cc->query_cpu_fast = s390_query_cpu_fast;
-- 
2.47.1


