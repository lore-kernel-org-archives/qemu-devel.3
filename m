Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD194D1CDD5
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3CYx-0001nH-9V; Tue, 22 Oct 2024 06:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3CYs-0001k7-MC
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:56:26 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3CYq-00020f-SE
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:56:26 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c94861ee25so2818022a12.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729594582; x=1730199382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/thHQrDD74xWhDO5ZvpNfmAfgwRl7ohsH8B1mB/WTo0=;
 b=z3VxdBuIQO1qI0fcyld3DpbT56IOFAqliutNPX6YkU1mNlB1opS5kinbDeEx+7TVXH
 g+145zLUcrbwIsVuw15PiZSj1w/L8f4/Oxd8cPsQ9Cr0zNXE0X/rUgse8i5KCazG85lF
 IBIqiG+EKF4YxD16S1SJHvrbP3gmqMnM7+iEN/S4uin9RzuN0kUHo3NMxkxdeNQpYjb7
 GOgJneIVeY+Q0RzZ2buAgnJS7lIXQQyYngZkCPLjzbq/mqxVe1NLwlPxv98pzTI3jm/M
 NtEfltg1oX6vV45ZqYP+RyUZCy5AHyZfWL4z0WxKYpI7esjPyxo0XBI3MzlYJDJvAOh+
 vhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729594582; x=1730199382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/thHQrDD74xWhDO5ZvpNfmAfgwRl7ohsH8B1mB/WTo0=;
 b=ndF10IIrQ7wwYzihGVE6/Du6wlW6cvvDHZQ7zRaCdLPSzAs59QD3cJgCNVvMwCJ7m0
 COqRtu/bFyvZg6cl+Mu9mYsIuCZEjD4UbElRVGdvHkB41zQtEnQlNyczTpGuOAopnWSO
 YkmhhawMINAvqko2nFYO+OFkvh1H6W0yNpPibd2C6hiBpK758fgd1HUdCPQHYUZqC9FZ
 VlqaQgHDTIGG9/T+xegb1inCeS6tnWPhH+zcsFI5q4AVY1pW0q6lba6aHCj8X/xf2Z14
 M9RNhDCIzBcdYcl5DDP3M8bCfkUjvbESM+IvXHFs16WgYkL6I7My+czQT/a56is3Mz6w
 PqSA==
X-Gm-Message-State: AOJu0Yy0c+mHdh7UazbOMxQcSSC/VEPchlorN0/exc5K6d4hg+wNcaDH
 uFdXFjACbyCdbBILxHkDP1jbIHU74nxGDnpVVoSmr0OIcHRuRpQAlgnAnuMpc1s=
X-Google-Smtp-Source: AGHT+IFBxLhqkcFc083FyPJREjZC/bdX6TenkPZv3cJUb/crfFR4k5TS849WsfGhqyrMbpgpzkF9Rg==
X-Received: by 2002:a05:6402:909:b0:5c9:21aa:b145 with SMTP id
 4fb4d7f45d1cf-5ca0af87099mr17318763a12.36.1729594582079; 
 Tue, 22 Oct 2024 03:56:22 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66c72581sm3010588a12.86.2024.10.22.03.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:56:19 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 86BD95F9EC;
 Tue, 22 Oct 2024 11:56:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, devel@lists.libvirt.org,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 10/20] gitlab: make check-[dco|patch] a little more verbose
Date: Tue, 22 Oct 2024 11:56:04 +0100
Message-Id: <20241022105614.839199-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241022105614.839199-1-alex.bennee@linaro.org>
References: <20241022105614.839199-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

When git fails the rather terse backtrace only indicates it failed
without some useful context. Add some to make the log a little more
useful.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/check-dco.py   | 9 +++++----
 .gitlab-ci.d/check-patch.py | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/.gitlab-ci.d/check-dco.py b/.gitlab-ci.d/check-dco.py
index 632c8bcce8..d29c580d63 100755
--- a/.gitlab-ci.d/check-dco.py
+++ b/.gitlab-ci.d/check-dco.py
@@ -19,10 +19,11 @@
 reponame = os.path.basename(cwd)
 repourl = "https://gitlab.com/%s/%s.git" % (namespace, reponame)
 
-subprocess.check_call(["git", "remote", "add", "check-dco", repourl])
-subprocess.check_call(["git", "fetch", "check-dco", "master"],
-                      stdout=subprocess.DEVNULL,
-                      stderr=subprocess.DEVNULL)
+print(f"adding upstream git repo @ {repourl}")
+subprocess.run(["git", "remote", "add", "check-dco", repourl],
+               check=True, capture_output=True)
+subprocess.run(["git", "fetch", "check-dco", "master"],
+               check=True, capture_output=True)
 
 ancestor = subprocess.check_output(["git", "merge-base",
                                     "check-dco/master", "HEAD"],
diff --git a/.gitlab-ci.d/check-patch.py b/.gitlab-ci.d/check-patch.py
index 39e2b403c9..94afdce555 100755
--- a/.gitlab-ci.d/check-patch.py
+++ b/.gitlab-ci.d/check-patch.py
@@ -19,13 +19,14 @@
 reponame = os.path.basename(cwd)
 repourl = "https://gitlab.com/%s/%s.git" % (namespace, reponame)
 
+print(f"adding upstream git repo @ {repourl}")
 # GitLab CI environment does not give us any direct info about the
 # base for the user's branch. We thus need to figure out a common
 # ancestor between the user's branch and current git master.
-subprocess.check_call(["git", "remote", "add", "check-patch", repourl])
-subprocess.check_call(["git", "fetch", "check-patch", "master"],
-                      stdout=subprocess.DEVNULL,
-                      stderr=subprocess.DEVNULL)
+subprocess.run(["git", "remote", "add", "check-patch", repourl],
+               check=True, capture_output=True)
+subprocess.run(["git", "fetch", "check-patch", "master"],
+               check=True, capture_output=True)
 
 ancestor = subprocess.check_output(["git", "merge-base",
                                     "check-patch/master", "HEAD"],
-- 
2.39.5


