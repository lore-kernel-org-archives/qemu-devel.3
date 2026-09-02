Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80DBC624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 13:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1lSm-0006AQ-0U; Wed, 02 Sep 2026 09:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1x1lSh-00067z-FV
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 09:57:12 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1x1lSf-00044k-Ip
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 09:57:11 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-495590dde14so11024935e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 06:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788357428; x=1788962228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=O+sc3G9cvYiUykcdGl5g9NIzz1mVCaBhGVgsU1n/A+4=;
 b=qIsG4eXttKVrFCkSVpI9uT5dUUIUYFFClznVdvVX8F5c8fepfgsTPHiMQz+sOIrsvB
 d3oquhGS9NBHdswpnZhWvS6v4Lp/WujsXXeGGdSCwK8t8GMu/q6mmEIqjsDihoiceCV5
 MWaJN9DlfbfNwLOkFCA0pZjGOCvJtUafc5+GVqevcQ3c/uzkP2MxLRG/ZoO/SApeRiCg
 DWaphAXYzM9xyz6Ps39q9J5KTNLT3N0vT9ibCOEXCjDKh7u4acMQU2wcs+v6MQi4LnU2
 TjXe0cbu9EVI+zJ6kae5zl4B7yRoo6I7HKUdoUO0Qq2caK23iwaOl7kioMndPJrwwk/V
 pKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788357428; x=1788962228;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O+sc3G9cvYiUykcdGl5g9NIzz1mVCaBhGVgsU1n/A+4=;
 b=lryJsSR9K56w3rggmyTuUpJqZvto2toMxhxVinAiZfOEsSoyZlFezM6lgb6XShyzzr
 xHu7kvWmEJhJo0VGgM3JEUuKpogUr4vZblXgwjpTlczPwQyAziMOBVaI+o1A51cVlg3G
 rokylNeNKTURzb1c/k9KgWtyRgZtCthk3Vi2gA5EF995tSKkdUmEYbtg/20tMiRyQNeV
 4zRKXGXQVgnycDx9Ak6+7GZnQB9VHDM/TyqfSe7oP6ZhkGZ3W0HI3Y21hn+LTPiYN2Hp
 5IsOINoDoTg0xlFL+OGgLo1CZVLSwXRjbuJFhLpPYt5Q4SMcVthZf4oyHMRXs3uZNF04
 H1Xg==
X-Gm-Message-State: AFuF++nLzoMAIVXgsL2HfB+qcx+wdC5kywrBKkSuVej0G6Zpmrk/GkXe
 KCrR64BBDp4h39SaanVFrdgsMTTIb0N5VkdRJm27FKiMyuwxwZJj4Rjr2qTeRCTsDzQ=
X-Gm-Gg: AR+sD12fs+vfeldzzsEhUOFzOJgjdNj5qtvBBnkIZwIH8UKhqhxHYjtlsOzd6D8AxvF
 u0S6gjMFfX5HaghjJEKCt5YoCWasdWoDA6E9IMCyQugow1rHVUUaUCvC2YtAft5dMhd/AbUMnvR
 zVt16EeCTZ9sC/qEKLPoW8Q6nIVdqx/otaQLHcC39N8wP7ad0vHmAkvSQxMthVnLzjbczk8KLdH
 v7Mqsvp881CICaxokM9BLlSZihGo7fLizUr9OtWj6q930L0wzVigHGK2BX5eswtX3PVCx9bxi7Q
 1J7rkV5aA/v2QauPI2PUgmI0I7kYeRMfhkSnwA2qyzpVAqtF9idEw7gtakhxYqbBtXXNamVk7EA
 KwSgpb5hGJqQzxqEXmvyae71ZmUxty3JrtTL1pzzHVWbeeV4priMmONkUbP65JYecCSQHfIReXi
 zAtxBkgvUrMe6DwHA+ChoEX+QxCcrnj2d+dH3TplTpu6xlFHasBpkDRr9iLPBjz/QfgVegZ0D9Z
 7qUK3sQgSJiB7uK6YiJEKLObOSVe/JLkGgSl4Ln4o8egX3XpHv9PTbFA/jWtlDxGXnkkehym2+w
 LGqkb0C7JSfmql3KGcYcmkU4gIfH+YI=
X-Received: by 2002:a05:600c:a40f:b0:49c:edfe:d525 with SMTP id
 5b1f17b1804b1-49cedfed583mr5870725e9.10.1788357427628; 
 Wed, 02 Sep 2026 06:57:07 -0700 (PDT)
Received: from simon-macbookpro.tugraz.local (tug-swl-225-161.tugraz.at.
 [129.27.225.161]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce47885b1sm71891635e9.14.2026.09.02.06.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 06:57:07 -0700 (PDT)
From: Simon Scherer <scherer.simon89@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 Simon Scherer <scherer.simon89@gmail.com>
Subject: [PATCH v3] target/i386: Clear C1 for FCOM/FUCOM/FICOM
Date: Wed,  2 Sep 2026 15:57:05 +0200
Message-ID: <20260902135705.261863-1-scherer.simon89@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=scherer.simon89@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The SDM specifies that FCOM/FCOMP/FCOMPP/FUCOM/FUCOMP/FUCOMPP/FICOM/FICOMP
unconditionally clear C1 in the FPU status word, regardless of the
comparison result.

helper_fcom_ST0_FT0/helper_fucom_ST0_FT0 only cleared C3, C2, C0 (mask
0x4500) before OR-ing in the comparison result, leaving C1 (bit 9) at
whatever value it already had. FICOM/FICOMP dispatch through the same
helpers after converting their integer operand, so they inherited the
same bug.

This patch folds the C1 clear into the existing fpus mask
for both helpers, since fcom_ccval never sets bit 9 itself.

The SDM also lists "C1 Set to 0" for FCOMI/FCOMIP/FUCOMI/FUCOMIP.
Testing against real x86-64 hardware shows this instruction group
does not actually clear C1, unlike FCOM/FUCOM/FICOM. QEMU's
existing behavior for those four is already correct, so
they are intentionally left unchanged.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4378
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
---
v3: drop the C1 clear in helper_fcomi_ST0_FT0/helper_fucomi_ST0_FT0.
    Hardware testing shows FCOMI/FCOMIP/FUCOMI/FUCOMIP do not actually
    clear C1, unlike FCOM/FUCOM/FICOM.
v2: merge the C1 clear into the existing fpus mask for
    fcom_ST0_FT0/fucom_ST0_FT0 (Richard Henderson)

Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>

 target/i386/tcg/fpu_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index b812125efa..34670a1c2b 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -531,7 +531,8 @@ void helper_fcom_ST0_FT0(CPUX86State *env)
     FloatRelation ret;
 
     ret = floatx80_compare(ST0, FT0, &env->fp_status);
-    env->fpus = (env->fpus & ~0x4500) | fcom_ccval[ret + 1];
+    /* C1 is unconditionally cleared to 0 */
+    env->fpus = (env->fpus & ~0x4700) | fcom_ccval[ret + 1];
     merge_exception_flags(env, old_flags);
 }
 
@@ -541,7 +542,8 @@ void helper_fucom_ST0_FT0(CPUX86State *env)
     FloatRelation ret;
 
     ret = floatx80_compare_quiet(ST0, FT0, &env->fp_status);
-    env->fpus = (env->fpus & ~0x4500) | fcom_ccval[ret + 1];
+    /* C1 is unconditionally cleared to 0 */
+    env->fpus = (env->fpus & ~0x4700) | fcom_ccval[ret + 1];
     merge_exception_flags(env, old_flags);
 }
 
-- 
2.53.0


