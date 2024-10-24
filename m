Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43FECFA451
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 09:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3ua3-0001Ej-Pf; Thu, 24 Oct 2024 05:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZk-00018c-Gr
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:16 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZi-0003o7-5D
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:15 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5cb72918bddso924291a12.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 02:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729763772; x=1730368572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oznrXdsmNzi0LevvMQ+H5t+DJg+P+IM2tS40pZyVrfA=;
 b=x0q0xeHBKxpNhFsIyXY/YHQvE74daImtzAciR+yBHLzJAgiHzzJ0ebmyRGwzkw15PU
 0x6aT/xPhtr6jaByFAAIEYV/YoNWrMMV+9r7ACt0FEJR7+sEsIt20zrflEY+LKqeSRfK
 fDrVLdArDZ4uAnB6wwustEbnF3gHfOeICQhF//o3rcYjaJ2csafvhPMa2uH4lIHouIe0
 iIAdgtSoRlV3XDlVV7aaNi2BhYVsLDHqA5P7X005ri9nPj/2XvcU5sqrtRsONo2Xzlm6
 IaSWEv+OnRxFbe05jjO3VjGHZOXagaImfYpDs0gZgpllKjEZBHuZPP2OB4HWFSbA+2s0
 BThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729763772; x=1730368572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oznrXdsmNzi0LevvMQ+H5t+DJg+P+IM2tS40pZyVrfA=;
 b=MSyT9C2rjjcykjFthMiyuDOE8lJvbsSo+gRMQRo4ObK6exJTxXv0jnh3PhH0SmhOxC
 5PObsgIVZVB/A4DVUBbH8KyLMExiyitBNY2dU9EWllOMo8I305o047KANhZ9NHCLbsIX
 Rz1lPCch/CG/9VpiN9f6pea6OyIEjvyvYRAooFaJke8PDiceYcMUgjSp3JwyjFaCCk8P
 Xch4uUUFSQ5FmOvgP2PbovNrkGrNlDog4n4wXphOReaxJX9GzjtO3mNbHPUaI0Gv7U1Y
 EEFu9bC4GxDL8xN9cG42bV3TZQljbqOqYU0oX2YxNRBmMWeTzL9NlfXPscfakIQBmSZ1
 sLuw==
X-Gm-Message-State: AOJu0YxUklAfZcY40deCSuAbeoOoAz2673MnmtAMTwD1eXY9sBOg6Ggf
 c6H/uY462VolY5QgDB4Sa7bx8J2sFr7nDqFbZNrV6u5Gp6nVf1FMn2VbhcHTTVI=
X-Google-Smtp-Source: AGHT+IEAt4uQRfFQMY1XCHNNH9YcWuMTzIuRnlV7XfaHyMRK555hRQferXZcRgvyPr4sFdu1oGtJOA==
X-Received: by 2002:a05:6402:254b:b0:5ca:da2:b2ca with SMTP id
 4fb4d7f45d1cf-5cb8acba591mr5400530a12.19.1729763772509; 
 Thu, 24 Oct 2024 02:56:12 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66c73b50sm5442472a12.97.2024.10.24.02.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 02:56:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DF8A25F9DD;
 Thu, 24 Oct 2024 10:56:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PULL 10/17] gitlab: make check-[dco|patch] a little more verbose
Date: Thu, 24 Oct 2024 10:55:56 +0100
Message-Id: <20241024095603.1813285-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024095603.1813285-1-alex.bennee@linaro.org>
References: <20241024095603.1813285-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

When git fails the rather terse backtrace only indicates it failed
without some useful context. Add some to make the log a little more
useful.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241023113406.1284676-11-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/check-dco.py b/.gitlab-ci.d/check-dco.py
index 632c8bcce8..d221b16bd5 100755
--- a/.gitlab-ci.d/check-dco.py
+++ b/.gitlab-ci.d/check-dco.py
@@ -19,10 +19,9 @@
 reponame = os.path.basename(cwd)
 repourl = "https://gitlab.com/%s/%s.git" % (namespace, reponame)
 
+print(f"adding upstream git repo @ {repourl}")
 subprocess.check_call(["git", "remote", "add", "check-dco", repourl])
-subprocess.check_call(["git", "fetch", "check-dco", "master"],
-                      stdout=subprocess.DEVNULL,
-                      stderr=subprocess.DEVNULL)
+subprocess.check_call(["git", "fetch", "check-dco", "master"])
 
 ancestor = subprocess.check_output(["git", "merge-base",
                                     "check-dco/master", "HEAD"],
diff --git a/.gitlab-ci.d/check-patch.py b/.gitlab-ci.d/check-patch.py
index 39e2b403c9..68c549a146 100755
--- a/.gitlab-ci.d/check-patch.py
+++ b/.gitlab-ci.d/check-patch.py
@@ -19,13 +19,12 @@
 reponame = os.path.basename(cwd)
 repourl = "https://gitlab.com/%s/%s.git" % (namespace, reponame)
 
+print(f"adding upstream git repo @ {repourl}")
 # GitLab CI environment does not give us any direct info about the
 # base for the user's branch. We thus need to figure out a common
 # ancestor between the user's branch and current git master.
 subprocess.check_call(["git", "remote", "add", "check-patch", repourl])
-subprocess.check_call(["git", "fetch", "check-patch", "master"],
-                      stdout=subprocess.DEVNULL,
-                      stderr=subprocess.DEVNULL)
+subprocess.check_call(["git", "fetch", "check-patch", "master"])
 
 ancestor = subprocess.check_output(["git", "merge-base",
                                     "check-patch/master", "HEAD"],
-- 
2.39.5


