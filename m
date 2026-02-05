Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47582EA7959
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 03:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnpe9-0008Rw-Mn; Wed, 04 Feb 2026 22:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnpe6-0008RE-OZ
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:03:07 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnpe4-0007XF-3j
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:03:06 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82310b74496so198666b3a.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 19:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770260583; x=1770865383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oae4Zu78+hbg+Js4jZa798pu2F6IkQ9/V191S2SAJTs=;
 b=vlB9V0Arwm7VAvSqKknFnhvEqE11xi2C9GzDE+mjzP1jCQZYOQm54X+HVVgAuwsXY0
 lHkOpZjFosXkIY7TE6sjHEIoUbrMu26UR7JNO6A+cVV4E0AedIYsbWJjlX3Cg75DOhFa
 w3xEQNV39mdj03dpU0Jfphxf16e4ZMbVwc3nuOZfgVEsWYp2zaQjKV4bjP2D04iqpmnb
 i0ML38ixexmMjV4UeQkZnElLMmXqnI+C0qTGzzT+HJn9Hq7zQ9/H3cVQV8paS0YzyS15
 LLgRRb9ai3+5E+PR/Atzw/QonzbzUcdB6abUHysuHJQ0v4U6hb2bvM9eHl0uy/YN0s4s
 jloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770260583; x=1770865383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oae4Zu78+hbg+Js4jZa798pu2F6IkQ9/V191S2SAJTs=;
 b=ub82D5wQs5nqi7laVETkZPZfw4o8Ss38wUHYuwTK6G8VRAnDu5/US9c7R7bq67397J
 raYLPkNMMF+7VXsmK0+UnS2oi/FgiQjBpldNOkaamBTLL4jvusctcdtvwh9zU+t1m7EM
 Cw6zaXnH3cVwD7o2ZUzC8uzyWr3cKUJdGjyX14CnWIfqcGgsfP/8YfDTPqlR+4MPa3UQ
 6j8sOGNVHh7juBJ6GatnFnukWbswhPHGzlVRIjl0AF0iNoeOD4WrR7if18QazL31Amed
 D6BuMB99HCZ42qUvQfGlLVyoDxC7pe4D7V090KR3T0S+G4RlaGiCFkSowd+M81HHf3ZO
 RNHA==
X-Gm-Message-State: AOJu0YyPekfithm38zPgNvFBTGpLN+W+HaYLIUnmF9N3hl9Gr75Rgb17
 fl46r2elujMb+HaGMdTZql8el2HykvUeWj3K/cWwBBg7cDSBNsX6pgAcsYmhVcyHzyKqMjA9+Jb
 IMereUKoZwg==
X-Gm-Gg: AZuq6aJe4kvnWbP4AzV7Ly1Sx3jJlvbEHCS0Xy5HQMJJY5+T5MyDnckHCN5ODhk8Ew2
 MtfqrCI/dwRsxK2D3KbJWe1ZK/PTTpUeh0KfA81I3KrXXRwMKEONkJ2dUqI2QNwpEGS8bZ8Kqwn
 m2YR6PLM70krto4NVDCOvQsQAL8bdoj1tjctbMx2kDCZ5iPqlfhqwlkmZRFKtIdgHF3sPyK8SLe
 h2uRXmG0SucZfwHcMLcWA97EKvGAYnJtEc3+PBiBNhYowOSRhIezHxcR+Cx9CyJDhryOINMCLq9
 vpN7XPpgmqlwc7gf2cMjhJuToewncX6W/12sHxxYq/U8luLie6pvGn02slwhrF5MqSjxlGMMEBu
 iuytIPRpWkrW4fKJMd2vW0OfD2U8hTP6GdcudQIjipWAIvMyuUZaVnpA7BmLi1bsnD9WIT0wZ8t
 7c1tVyv3IUT+IgnTGek/Ey
X-Received: by 2002:a05:6a20:12d0:b0:350:b8e:f9a9 with SMTP id
 adf61e73a8af0-393723ce739mr5400426637.42.1770260582551; 
 Wed, 04 Feb 2026 19:03:02 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6c8572b4e7sm3395480a12.33.2026.02.04.19.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 19:03:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	shorne@gmail.com
Subject: [PATCH 4/6] tests/tcg/or1k: Rename from openrisc
Date: Thu,  5 Feb 2026 13:02:42 +1000
Message-ID: <20260205030244.266447-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205030244.266447-1-richard.henderson@linaro.org>
References: <20260205030244.266447-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/{openrisc => or1k}/test_add.c    | 0
 tests/tcg/{openrisc => or1k}/test_addc.c   | 0
 tests/tcg/{openrisc => or1k}/test_addi.c   | 0
 tests/tcg/{openrisc => or1k}/test_addic.c  | 0
 tests/tcg/{openrisc => or1k}/test_and_or.c | 0
 tests/tcg/{openrisc => or1k}/test_bf.c     | 0
 tests/tcg/{openrisc => or1k}/test_bnf.c    | 0
 tests/tcg/{openrisc => or1k}/test_div.c    | 0
 tests/tcg/{openrisc => or1k}/test_divu.c   | 0
 tests/tcg/{openrisc => or1k}/test_extx.c   | 0
 tests/tcg/{openrisc => or1k}/test_fx.c     | 0
 tests/tcg/{openrisc => or1k}/test_j.c      | 0
 tests/tcg/{openrisc => or1k}/test_jal.c    | 0
 tests/tcg/{openrisc => or1k}/test_lf_add.c | 0
 tests/tcg/{openrisc => or1k}/test_lf_div.c | 0
 tests/tcg/{openrisc => or1k}/test_lf_eqs.c | 0
 tests/tcg/{openrisc => or1k}/test_lf_ges.c | 0
 tests/tcg/{openrisc => or1k}/test_lf_gts.c | 0
 tests/tcg/{openrisc => or1k}/test_lf_les.c | 0
 tests/tcg/{openrisc => or1k}/test_lf_lts.c | 0
 tests/tcg/{openrisc => or1k}/test_lf_mul.c | 0
 tests/tcg/{openrisc => or1k}/test_lf_nes.c | 0
 tests/tcg/{openrisc => or1k}/test_lf_rem.c | 0
 tests/tcg/{openrisc => or1k}/test_lf_sub.c | 0
 tests/tcg/{openrisc => or1k}/test_logic.c  | 0
 tests/tcg/{openrisc => or1k}/test_lx.c     | 0
 tests/tcg/{openrisc => or1k}/test_movhi.c  | 0
 tests/tcg/{openrisc => or1k}/test_mul.c    | 0
 tests/tcg/{openrisc => or1k}/test_muli.c   | 0
 tests/tcg/{openrisc => or1k}/test_mulu.c   | 0
 tests/tcg/{openrisc => or1k}/test_sfeq.c   | 0
 tests/tcg/{openrisc => or1k}/test_sfeqi.c  | 0
 tests/tcg/{openrisc => or1k}/test_sfges.c  | 0
 tests/tcg/{openrisc => or1k}/test_sfgesi.c | 0
 tests/tcg/{openrisc => or1k}/test_sfgeu.c  | 0
 tests/tcg/{openrisc => or1k}/test_sfgeui.c | 0
 tests/tcg/{openrisc => or1k}/test_sfgts.c  | 0
 tests/tcg/{openrisc => or1k}/test_sfgtsi.c | 0
 tests/tcg/{openrisc => or1k}/test_sfgtu.c  | 0
 tests/tcg/{openrisc => or1k}/test_sfgtui.c | 0
 tests/tcg/{openrisc => or1k}/test_sfles.c  | 0
 tests/tcg/{openrisc => or1k}/test_sflesi.c | 0
 tests/tcg/{openrisc => or1k}/test_sfleu.c  | 0
 tests/tcg/{openrisc => or1k}/test_sfleui.c | 0
 tests/tcg/{openrisc => or1k}/test_sflts.c  | 0
 tests/tcg/{openrisc => or1k}/test_sfltsi.c | 0
 tests/tcg/{openrisc => or1k}/test_sfltu.c  | 0
 tests/tcg/{openrisc => or1k}/test_sfltui.c | 0
 tests/tcg/{openrisc => or1k}/test_sfne.c   | 0
 tests/tcg/{openrisc => or1k}/test_sfnei.c  | 0
 tests/tcg/{openrisc => or1k}/test_sub.c    | 0
 MAINTAINERS                                | 2 +-
 tests/tcg/{openrisc => or1k}/Makefile      | 0
 53 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/tcg/{openrisc => or1k}/test_add.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_addc.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_addi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_addic.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_and_or.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_bf.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_bnf.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_div.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_divu.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_extx.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_fx.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_j.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_jal.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_add.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_div.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_eqs.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_ges.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_gts.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_les.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_lts.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_mul.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_nes.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_rem.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_sub.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_logic.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lx.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_movhi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_mul.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_muli.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_mulu.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfeq.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfeqi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfges.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgesi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgeu.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgeui.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgts.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgtsi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgtu.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgtui.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfles.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sflesi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfleu.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfleui.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sflts.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfltsi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfltu.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfltui.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfne.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfnei.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sub.c (100%)
 rename tests/tcg/{openrisc => or1k}/Makefile (100%)

diff --git a/tests/tcg/openrisc/test_add.c b/tests/tcg/or1k/test_add.c
similarity index 100%
rename from tests/tcg/openrisc/test_add.c
rename to tests/tcg/or1k/test_add.c
diff --git a/tests/tcg/openrisc/test_addc.c b/tests/tcg/or1k/test_addc.c
similarity index 100%
rename from tests/tcg/openrisc/test_addc.c
rename to tests/tcg/or1k/test_addc.c
diff --git a/tests/tcg/openrisc/test_addi.c b/tests/tcg/or1k/test_addi.c
similarity index 100%
rename from tests/tcg/openrisc/test_addi.c
rename to tests/tcg/or1k/test_addi.c
diff --git a/tests/tcg/openrisc/test_addic.c b/tests/tcg/or1k/test_addic.c
similarity index 100%
rename from tests/tcg/openrisc/test_addic.c
rename to tests/tcg/or1k/test_addic.c
diff --git a/tests/tcg/openrisc/test_and_or.c b/tests/tcg/or1k/test_and_or.c
similarity index 100%
rename from tests/tcg/openrisc/test_and_or.c
rename to tests/tcg/or1k/test_and_or.c
diff --git a/tests/tcg/openrisc/test_bf.c b/tests/tcg/or1k/test_bf.c
similarity index 100%
rename from tests/tcg/openrisc/test_bf.c
rename to tests/tcg/or1k/test_bf.c
diff --git a/tests/tcg/openrisc/test_bnf.c b/tests/tcg/or1k/test_bnf.c
similarity index 100%
rename from tests/tcg/openrisc/test_bnf.c
rename to tests/tcg/or1k/test_bnf.c
diff --git a/tests/tcg/openrisc/test_div.c b/tests/tcg/or1k/test_div.c
similarity index 100%
rename from tests/tcg/openrisc/test_div.c
rename to tests/tcg/or1k/test_div.c
diff --git a/tests/tcg/openrisc/test_divu.c b/tests/tcg/or1k/test_divu.c
similarity index 100%
rename from tests/tcg/openrisc/test_divu.c
rename to tests/tcg/or1k/test_divu.c
diff --git a/tests/tcg/openrisc/test_extx.c b/tests/tcg/or1k/test_extx.c
similarity index 100%
rename from tests/tcg/openrisc/test_extx.c
rename to tests/tcg/or1k/test_extx.c
diff --git a/tests/tcg/openrisc/test_fx.c b/tests/tcg/or1k/test_fx.c
similarity index 100%
rename from tests/tcg/openrisc/test_fx.c
rename to tests/tcg/or1k/test_fx.c
diff --git a/tests/tcg/openrisc/test_j.c b/tests/tcg/or1k/test_j.c
similarity index 100%
rename from tests/tcg/openrisc/test_j.c
rename to tests/tcg/or1k/test_j.c
diff --git a/tests/tcg/openrisc/test_jal.c b/tests/tcg/or1k/test_jal.c
similarity index 100%
rename from tests/tcg/openrisc/test_jal.c
rename to tests/tcg/or1k/test_jal.c
diff --git a/tests/tcg/openrisc/test_lf_add.c b/tests/tcg/or1k/test_lf_add.c
similarity index 100%
rename from tests/tcg/openrisc/test_lf_add.c
rename to tests/tcg/or1k/test_lf_add.c
diff --git a/tests/tcg/openrisc/test_lf_div.c b/tests/tcg/or1k/test_lf_div.c
similarity index 100%
rename from tests/tcg/openrisc/test_lf_div.c
rename to tests/tcg/or1k/test_lf_div.c
diff --git a/tests/tcg/openrisc/test_lf_eqs.c b/tests/tcg/or1k/test_lf_eqs.c
similarity index 100%
rename from tests/tcg/openrisc/test_lf_eqs.c
rename to tests/tcg/or1k/test_lf_eqs.c
diff --git a/tests/tcg/openrisc/test_lf_ges.c b/tests/tcg/or1k/test_lf_ges.c
similarity index 100%
rename from tests/tcg/openrisc/test_lf_ges.c
rename to tests/tcg/or1k/test_lf_ges.c
diff --git a/tests/tcg/openrisc/test_lf_gts.c b/tests/tcg/or1k/test_lf_gts.c
similarity index 100%
rename from tests/tcg/openrisc/test_lf_gts.c
rename to tests/tcg/or1k/test_lf_gts.c
diff --git a/tests/tcg/openrisc/test_lf_les.c b/tests/tcg/or1k/test_lf_les.c
similarity index 100%
rename from tests/tcg/openrisc/test_lf_les.c
rename to tests/tcg/or1k/test_lf_les.c
diff --git a/tests/tcg/openrisc/test_lf_lts.c b/tests/tcg/or1k/test_lf_lts.c
similarity index 100%
rename from tests/tcg/openrisc/test_lf_lts.c
rename to tests/tcg/or1k/test_lf_lts.c
diff --git a/tests/tcg/openrisc/test_lf_mul.c b/tests/tcg/or1k/test_lf_mul.c
similarity index 100%
rename from tests/tcg/openrisc/test_lf_mul.c
rename to tests/tcg/or1k/test_lf_mul.c
diff --git a/tests/tcg/openrisc/test_lf_nes.c b/tests/tcg/or1k/test_lf_nes.c
similarity index 100%
rename from tests/tcg/openrisc/test_lf_nes.c
rename to tests/tcg/or1k/test_lf_nes.c
diff --git a/tests/tcg/openrisc/test_lf_rem.c b/tests/tcg/or1k/test_lf_rem.c
similarity index 100%
rename from tests/tcg/openrisc/test_lf_rem.c
rename to tests/tcg/or1k/test_lf_rem.c
diff --git a/tests/tcg/openrisc/test_lf_sub.c b/tests/tcg/or1k/test_lf_sub.c
similarity index 100%
rename from tests/tcg/openrisc/test_lf_sub.c
rename to tests/tcg/or1k/test_lf_sub.c
diff --git a/tests/tcg/openrisc/test_logic.c b/tests/tcg/or1k/test_logic.c
similarity index 100%
rename from tests/tcg/openrisc/test_logic.c
rename to tests/tcg/or1k/test_logic.c
diff --git a/tests/tcg/openrisc/test_lx.c b/tests/tcg/or1k/test_lx.c
similarity index 100%
rename from tests/tcg/openrisc/test_lx.c
rename to tests/tcg/or1k/test_lx.c
diff --git a/tests/tcg/openrisc/test_movhi.c b/tests/tcg/or1k/test_movhi.c
similarity index 100%
rename from tests/tcg/openrisc/test_movhi.c
rename to tests/tcg/or1k/test_movhi.c
diff --git a/tests/tcg/openrisc/test_mul.c b/tests/tcg/or1k/test_mul.c
similarity index 100%
rename from tests/tcg/openrisc/test_mul.c
rename to tests/tcg/or1k/test_mul.c
diff --git a/tests/tcg/openrisc/test_muli.c b/tests/tcg/or1k/test_muli.c
similarity index 100%
rename from tests/tcg/openrisc/test_muli.c
rename to tests/tcg/or1k/test_muli.c
diff --git a/tests/tcg/openrisc/test_mulu.c b/tests/tcg/or1k/test_mulu.c
similarity index 100%
rename from tests/tcg/openrisc/test_mulu.c
rename to tests/tcg/or1k/test_mulu.c
diff --git a/tests/tcg/openrisc/test_sfeq.c b/tests/tcg/or1k/test_sfeq.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfeq.c
rename to tests/tcg/or1k/test_sfeq.c
diff --git a/tests/tcg/openrisc/test_sfeqi.c b/tests/tcg/or1k/test_sfeqi.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfeqi.c
rename to tests/tcg/or1k/test_sfeqi.c
diff --git a/tests/tcg/openrisc/test_sfges.c b/tests/tcg/or1k/test_sfges.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfges.c
rename to tests/tcg/or1k/test_sfges.c
diff --git a/tests/tcg/openrisc/test_sfgesi.c b/tests/tcg/or1k/test_sfgesi.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfgesi.c
rename to tests/tcg/or1k/test_sfgesi.c
diff --git a/tests/tcg/openrisc/test_sfgeu.c b/tests/tcg/or1k/test_sfgeu.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfgeu.c
rename to tests/tcg/or1k/test_sfgeu.c
diff --git a/tests/tcg/openrisc/test_sfgeui.c b/tests/tcg/or1k/test_sfgeui.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfgeui.c
rename to tests/tcg/or1k/test_sfgeui.c
diff --git a/tests/tcg/openrisc/test_sfgts.c b/tests/tcg/or1k/test_sfgts.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfgts.c
rename to tests/tcg/or1k/test_sfgts.c
diff --git a/tests/tcg/openrisc/test_sfgtsi.c b/tests/tcg/or1k/test_sfgtsi.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfgtsi.c
rename to tests/tcg/or1k/test_sfgtsi.c
diff --git a/tests/tcg/openrisc/test_sfgtu.c b/tests/tcg/or1k/test_sfgtu.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfgtu.c
rename to tests/tcg/or1k/test_sfgtu.c
diff --git a/tests/tcg/openrisc/test_sfgtui.c b/tests/tcg/or1k/test_sfgtui.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfgtui.c
rename to tests/tcg/or1k/test_sfgtui.c
diff --git a/tests/tcg/openrisc/test_sfles.c b/tests/tcg/or1k/test_sfles.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfles.c
rename to tests/tcg/or1k/test_sfles.c
diff --git a/tests/tcg/openrisc/test_sflesi.c b/tests/tcg/or1k/test_sflesi.c
similarity index 100%
rename from tests/tcg/openrisc/test_sflesi.c
rename to tests/tcg/or1k/test_sflesi.c
diff --git a/tests/tcg/openrisc/test_sfleu.c b/tests/tcg/or1k/test_sfleu.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfleu.c
rename to tests/tcg/or1k/test_sfleu.c
diff --git a/tests/tcg/openrisc/test_sfleui.c b/tests/tcg/or1k/test_sfleui.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfleui.c
rename to tests/tcg/or1k/test_sfleui.c
diff --git a/tests/tcg/openrisc/test_sflts.c b/tests/tcg/or1k/test_sflts.c
similarity index 100%
rename from tests/tcg/openrisc/test_sflts.c
rename to tests/tcg/or1k/test_sflts.c
diff --git a/tests/tcg/openrisc/test_sfltsi.c b/tests/tcg/or1k/test_sfltsi.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfltsi.c
rename to tests/tcg/or1k/test_sfltsi.c
diff --git a/tests/tcg/openrisc/test_sfltu.c b/tests/tcg/or1k/test_sfltu.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfltu.c
rename to tests/tcg/or1k/test_sfltu.c
diff --git a/tests/tcg/openrisc/test_sfltui.c b/tests/tcg/or1k/test_sfltui.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfltui.c
rename to tests/tcg/or1k/test_sfltui.c
diff --git a/tests/tcg/openrisc/test_sfne.c b/tests/tcg/or1k/test_sfne.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfne.c
rename to tests/tcg/or1k/test_sfne.c
diff --git a/tests/tcg/openrisc/test_sfnei.c b/tests/tcg/or1k/test_sfnei.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfnei.c
rename to tests/tcg/or1k/test_sfnei.c
diff --git a/tests/tcg/openrisc/test_sub.c b/tests/tcg/or1k/test_sub.c
similarity index 100%
rename from tests/tcg/openrisc/test_sub.c
rename to tests/tcg/or1k/test_sub.c
diff --git a/MAINTAINERS b/MAINTAINERS
index 00aa4f2a41..208628cb8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -307,7 +307,7 @@ F: target/or1k/
 F: hw/or1k/
 F: include/hw/or1k/
 F: tests/functional/or1k/meson.build
-F: tests/tcg/openrisc/
+F: tests/tcg/or1k/
 
 PowerPC TCG CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
diff --git a/tests/tcg/openrisc/Makefile b/tests/tcg/or1k/Makefile
similarity index 100%
rename from tests/tcg/openrisc/Makefile
rename to tests/tcg/or1k/Makefile
-- 
2.43.0


