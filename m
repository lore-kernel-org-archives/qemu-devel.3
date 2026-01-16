Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC45ED4899A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 12:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgj8r-0002iD-JE; Fri, 16 Jan 2026 07:41:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgj7d-000247-Jj
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:40:14 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgj7b-0004gF-Uy
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:40:13 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42fbbc3df8fso1092164f8f.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 04:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768567209; x=1769172009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a0wgjb5PW8AjpxMtNWI1pQBRJl7CsYfLGacp91OKMNE=;
 b=yd9eRq0SnFLy+TBpt3WL4muWW10EIOHnMcg7Qten7YfrB8Jy1dr6R6gwik8VhT5EpM
 IYqC5ZMdtOVPTgFv/qSFBJaM4msvjxvVleLJtfGcg11VGh7F4fR9y+s3wBtKsxZKwW5r
 hlDZERpt+CVQNE+FrYlQ4wXm6zX7//LoLFwzFOcjXCv+5GPhuR+M+P6ItMdm2o0nWSbN
 yPyJFO7e+yQls50h63CmOFqrAae8XDZVH1zmXMgQfT4XLrrl/+OOGW+3Kyq5ofOyIVJ6
 pfkOx6VlJkiv1P8AMcDGJDgijh0VLAIyuJOGr//v/wBBk4Anw7ROqm0+0ZDvftVhJ+XG
 F9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768567209; x=1769172009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a0wgjb5PW8AjpxMtNWI1pQBRJl7CsYfLGacp91OKMNE=;
 b=GebLhwkCSLG5jOGNevCNVB2CiJyemqM7nGchgsinad+6RdqBZUsNxlXDrrXkx2BAnL
 ktdZVX04HcGeM48gq8G5uz896o6LLan+pFW3EZVaLkXFbe5BGbJZ6WKJcZZcHmtyNYWf
 H9F4wFi8ilXirUhM3VWI51fcs6YyQCfLdm1VFaJkoMCahC4fEOO+SluRJ8aufzloBUGQ
 ga1wkSX1BU3OeekBgPaPFD6a1wQSiaQBQ7RUDUfY/1mi89N4d8a1OCxi3QLcHMaUQ20S
 AmC4J5P4s5QIOE+GWpcFusb9WYQoq1Omf16PvacOEooQFNz72aicJX1ZDrcSYFhZ+lin
 7TvA==
X-Gm-Message-State: AOJu0Yy4z+K054EWEARdsSvTEEVOhUx9j5CG1aK/aTiy+7TP6SHUiCdY
 mwVG0n3NRFAh8x+Q7Hg2rC+7+n7U4lK8PSsCjFGWLgf9LIJAGFclEsuDWXCEWsNYYGS5o1Z/f2I
 ddK3x
X-Gm-Gg: AY/fxX5+nKl9+w/rgIHxQ2n6axhdz0cPjpY1FbSIsIw5969P4ck+0oSSJchIuiRJbiQ
 +dRldA2i8WFLi7YRuokDVZM92NyFI+ECHpW3sKA2hAFu/QLvCCQVXNkImvfudRg67UvXD2L0i8m
 zrNyUr+iqPkGRhJ4t8ZK3NNEiQbWea0dGci2wOqwH4NrNO0K5yrwaiDOYQLgXCT1iCOq51J4IET
 NEp1aPutzSWT6GO1ebqZ8vFlpwrmbOK5doryd984LJZ9w5tSI+A6NywLIl2hO3+evObiVFYJw9y
 a/MZj4G/t598UOCPYd9ddFuGizvWLrtfzAc4X+9ptfxVpXAf5M3Y0qHdyWvEG/xw25ktzYP10cL
 Pw5u1ifV0LckRuSF1mV5lOUVP491feiu4JSW6GSfWUXQJMwgu3TRUx8mKhAQ4meLJgChu+Ti5Nw
 XVZIdTpaVjMtpBCflZuLQxqXsr8lItdl8aekS9n/KIGGm5r2LfMHDaro10u26pcSR/PM7qh1UBZ
 eM74zJ1hJPTb1omgHTBl3bH7HYSuncoxeaoXRQPIuMVzg==
X-Received: by 2002:a05:6000:2f83:b0:430:fd9f:e705 with SMTP id
 ffacd0b85a97d-4356999c900mr3789276f8f.27.1768567209547; 
 Fri, 16 Jan 2026 04:40:09 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992c6f2sm5192566f8f.19.2026.01.16.04.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 04:40:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 2/6] scripts/clean-includes: Remove outdated comment
Date: Fri, 16 Jan 2026 12:40:01 +0000
Message-ID: <20260116124005.925382-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116124005.925382-1-peter.maydell@linaro.org>
References: <20260116124005.925382-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Remove an old comment suggesting a manual shell line to use to find
files to run the script on. The script's exclude-list and its
support for directory names make this irrelevant.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/clean-includes | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/scripts/clean-includes b/scripts/clean-includes
index 07c0fd44e4..568033ee9c 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -39,15 +39,6 @@
 # removed.
 # Other files (including C++ and ObjectiveC) can't be handled by this script.
 
-# The following one-liner may be handy for finding files to run this on.
-# However some caution is required regarding files that might be part
-# of the guest agent or standalone tests.
-
-# for i in $(git ls-tree --name-only HEAD) ; do test -f $i && \
-#   grep -E '^# *include' $i | head -1 | grep 'osdep.h' ; test $? != 0 && \
-#   echo $i ; done
-
-
 GIT=no
 DUPHEAD=no
 
-- 
2.47.3


