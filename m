Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E262DC369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7krX-0004aO-OE; Wed, 23 Apr 2025 20:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqL-0000yV-79
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:34 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kpw-0004gI-Mn
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:10 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso501724b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455987; x=1746060787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5QmVx49VUNvE0VebpWYF9vpR8W6QUfLccSgTbYDwMAs=;
 b=OO6un2jpPtenSOAQ4VE3iyz75FjqT7bH5XFkcxSFwUylszwz4rY7V+VcdP88NNzpz1
 hr7dIca0w6CAbosxbN4kHDRZga31Vyk1qp26heUHlqTA79J22eBU3AJstkEKmk68jpdT
 26BqE9/R32826+8eKT4gmjfElFtCnHSsMJkrF/GhTTB9gwpChQERSJikYvcWhtTDviu/
 ADsT+FsOjVGFF/56uYJEv+LBosVjbLZyV2vr+0AWJ7C1wuS2TW2IGhJ1+41L6ivhsdyN
 h7zhNup6yNZ3qOFjGpu/ViXmK1kEJUT3ThpKtGOdxkEvcuw6bDZMPo7npWXSdlt6AAIt
 FbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455987; x=1746060787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5QmVx49VUNvE0VebpWYF9vpR8W6QUfLccSgTbYDwMAs=;
 b=Q2kUL/5KgiDyTwMDIF/7j+7g8LdokODak5a8zy+tAfhUg52etNkubUVLCVLPtUJOoR
 6a+qut3voCfEUftBQMsjTWHzmkMy8x8TwO07Dohv5zHwGe7YEMcrI9LBleActrQSKO41
 x6dQDfAl+/1SbngAnsNfIzs5y1rEW/HrMY0KeoKEPsM1MsL6ZHcSuYHhZiG8mJeekTKk
 q6+F0p1alQK+ylYcFU/hVlTbtVXAu+YT/qEqTANxljNMkCf2EHSF2UeqPKFqHin9OqxK
 cLd6FXGAtxoxRjR2C4cY12Qob1xkBuU9ia3556FQtquM/8TJBz29VFyaVgniK8BlEmKD
 1DAg==
X-Gm-Message-State: AOJu0YxqUaf1MvbNFYGIE0b15worRdPRLy7Xa0IbrxPDEMDv+Q09DqXO
 cS+2aPUEGdCwnLkBjiTwVepIyYDuT+r+yDSZmaWK8gRIKR1r9FLvACi8MrwNMpX7doGxxlV3mvg
 S
X-Gm-Gg: ASbGncvRRUgqC37wWRx1ELpCRiLswMIgygPWMSPwWORjLvpVHZf2w+bHxatU4wLqUEO
 aAg61hbsaiB4NKwaHvGCp3wSsncfwrEjdI9flK/vuj3s8veJMxBuPg7qeS5ysQl2VPArf1F7DoS
 YW0SArOd/klqNMxw4xISKGzffclJI86S2Qwf6eUSBhvh27QojpDn0YiFTXXcmK45cAj6zumRJ9i
 Hr2/ezVuOFMbg4F3rOM1QYUyMVvhRK6QhJQOFs0G4Em6xlTy95fR9Ng9WuT3azn8AviGkndc5Oo
 WGOKyO+QB0WW70CcCO7wSVbxlbAj3i3hU0+f5ZZcH8kwpRbkcRakS28/paKA6nh3G7X7y8VtYEM
 =
X-Google-Smtp-Source: AGHT+IHlej6VuUrGIU2IvmUdhzoBAFYbo9xxJHCv1CP6XSs9NxfPMBs1P/C3LfwTmBmMs3+y2QAX9Q==
X-Received: by 2002:a05:6a00:2d8e:b0:736:5822:74b4 with SMTP id
 d2e1a72fcca58-73e24ae60c2mr1020405b3a.21.1745455987044; 
 Wed, 23 Apr 2025 17:53:07 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 043/148] accel/tcg: Use libuser_ss and libsystem_ss
Date: Wed, 23 Apr 2025 17:47:48 -0700
Message-ID: <20250424004934.598783-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

While some of these files are built exactly once, due
to being in only libuser_ss or libsystem_ss, some of
the includes that they depend on require CONFIG_USER_ONLY.
So make use of the common infrastructure to allow that.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/meson.build | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 185830d0f5..72d4acfe5e 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -1,12 +1,21 @@
-common_ss.add(when: 'CONFIG_TCG', if_true: files(
+if not get_option('tcg').allowed()
+   subdir_done()
+endif
+
+tcg_ss = ss.source_set()
+
+tcg_ss.add(files(
   'cpu-exec-common.c',
   'tcg-runtime.c',
   'tcg-runtime-gvec.c',
 ))
 if get_option('plugins')
-  common_ss.add(when: 'CONFIG_TCG', if_true: files('plugin-gen.c'))
+  tcg_ss.add(files('plugin-gen.c'))
 endif
 
+libuser_ss.add_all(tcg_ss)
+libsystem_ss.add_all(tcg_ss)
+
 tcg_specific_ss = ss.source_set()
 tcg_specific_ss.add(files(
   'tcg-all.c',
@@ -22,11 +31,11 @@ specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'cputlb.c',
 ))
 
-user_ss.add(when: ['CONFIG_TCG'], if_true: files(
+libuser_ss.add(files(
   'user-exec-stub.c',
 ))
 
-system_ss.add(when: ['CONFIG_TCG'], if_true: files(
+libsystem_ss.add(files(
   'icount-common.c',
   'monitor.c',
   'tcg-accel-ops.c',
-- 
2.43.0


