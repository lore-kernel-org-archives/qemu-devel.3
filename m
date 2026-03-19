Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343C3109190D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 18:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ITz-0003UN-D3; Thu, 19 Mar 2026 14:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3ITx-0003RY-V8
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:52:33 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3ITw-00012F-Fz
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:52:33 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48540d21f7dso14150775e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773946351; x=1774551151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m5+9Mze0q86tdRWOd/Rf1eSQxbgALAi5yY69KbTLuW0=;
 b=LqILi/iBFqYivgJiJEYhmm6g6UJLsHpT+nXSDGizB3NG9Da5+hHY8VmIkOPSAebvsc
 yuzHIu3pWLWXkeVIVbj43WrjHgRGYAzGvPrNBgp62gGTRLHOv/7Cp1tcw6HH14Ae6A4X
 z8FT1SAZxLOo2Z7ysLvloYKlUO+Q/JV/VuPYfku40Qxzs/bz96diRffSFzOezpDCveQQ
 8XCMjwnHgvsa19WfwSLkJ2xOVUeBuwfo3JNvE7TNrMWJiXQqRdU6iScast8WZGMjPaQp
 5flUG8G/ukay3c4RaDQPERuGytVQxXzou5FAqOjKdjklfAv3RphM2e/MgHruwBybDLIJ
 3Tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773946351; x=1774551151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m5+9Mze0q86tdRWOd/Rf1eSQxbgALAi5yY69KbTLuW0=;
 b=TVJeDZTemuBYqUJKw/anO4VOVoaW4xD/qzGkIiXbr1eOjxelF5VMVO4uTtfbWlFbqW
 yWkEUUF2sKztVDoSyMWy5tuAK0Iwt79RH7ZwgD6FWEnCRZbK0rZvR0sLR+OADQS3n/TP
 T5enEE9Ajsyb4E6DItBKngEDnIq0kkGTZoslPZSIuY59oG72gWGR3X0yqliS7QKAkLlt
 qMACTs46ftZQ/0vd1Wb6upR5vQTO2tylQRYgECMCxeyaLmo89J8rRct127o5DPedhDWY
 l+vl5DRtJFBfugdOBwggW/dxOcWd17KwdUttc50z3vRet8/SAxQIzi+5v1ydfrZU1q8/
 liPQ==
X-Gm-Message-State: AOJu0YwapTJ9gKzYFKEFlNTNHySiiU32Yn9GizllyqFFvxGVTK3RyW4N
 m5NLCLZuFbcy/vG7zZ1JjhvDp4JebhInqvqgi7I2QECDjIgAbD9OYveV1Ge4Xi8FxhZsqcZLqY/
 86w9ZjNA=
X-Gm-Gg: ATEYQzwaNRlP8XPKPuaWERRu7cn9M4TlwnbJwaeV3MDlI7nWouixjnstLrePRyKSRiq
 +yAw8DM074MG7cqSDkLcPFK21AQtdf9oi1SuQ4WC3NbqFlSrkUWen1J8eJeAB20lxiMeAJNaksq
 K1jD8ZnQPAU1kZF0ccQmQ5QYNbxeEO0oFOBt8xK9YPYEm5pUc7e1y9C22XsJUbvuUO/uEGY65E8
 d8sPah3NwYemgP6Hj5O4eWTtO1LGy3G9oYdf3+U80gnupKazJBv9qgcRkcCCMZbvV9QPYHbo3DP
 276wCCoFfoxrN+HQ8TaTPU+bhcsCNRN7ASkMcvQzQFfo84gi5Wvh3Y4hlDz7rM1EuLWZFI8wuh0
 zNsKhVE+M9pX2oGpas3K8YTsQ1xowa2SKQ+cXN2wSX9FawB3DifpRJn7cFa3qjfHONTRdogEG/x
 gZy51MS/ZhfxKVNxbXu/hEleN9cWgYxj5L3UXUzo9qJkZXezfwTm9euW+g1YGHH2dZnC8Cnrcz+
 em2jEUaWdo=
X-Received: by 2002:a05:600c:4fc9:b0:485:2ce2:4c8a with SMTP id
 5b1f17b1804b1-486fede737dmr3537345e9.1.1773946350604; 
 Thu, 19 Mar 2026 11:52:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644bd923sm543334f8f.12.2026.03.19.11.52.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 11:52:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/5] target/s390x: Replace legacy ld/st_phys ->
 address_space_ld/st (tcg)
Date: Thu, 19 Mar 2026 19:52:01 +0100
Message-ID: <20260319185203.11799-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319185203.11799-1-philmd@linaro.org>
References: <20260319185203.11799-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Prefer the address_space_ld/st API over the legacy ld_phys()
because it allow checking for bus access fault.
This code however doesn't check for fault, so we simply inline
the calls (not specifying any memory transaction attribute nor
expecting transation result). No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/cpu-system.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index 881171d71a2..285f5999661 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -63,7 +63,7 @@ static void s390_cpu_load_normal(CPUState *s)
     uint64_t spsw;
 
     if (!s390_is_pv()) {
-        spsw = ldq_be_phys(s->as, 0);
+        spsw = address_space_ldq_be(s->as, 0, MEMTXATTRS_UNSPECIFIED, NULL);
         cpu->env.psw.mask = spsw & PSW_MASK_SHORT_CTRL;
         /*
          * Invert short psw indication, so SIE will report a specification
-- 
2.53.0


