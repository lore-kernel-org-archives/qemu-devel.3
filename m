Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3611CC3ABC3
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 06:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDdWM-0002bj-95; Sat, 10 May 2025 02:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDdWG-0002Qm-HL
 for qemu-devel@nongnu.org; Sat, 10 May 2025 02:17:09 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDdWE-0007oy-9G
 for qemu-devel@nongnu.org; Sat, 10 May 2025 02:17:08 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-739525d4e12so2758081b3a.3
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 23:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746857825; x=1747462625;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=snxR6Tf4837ucEUccRrRLlGIQOdYmeLTDj3OfwCYzvQ=;
 b=zcjWY8+PljIiKnnrTP4423vBxcg4eh2GgKNbTGebffx5/m4bwAMHmV9tmhI7RTMgxb
 1tsicxX3ftTfWxMeqBNl8YS9VwyOOkdlmF03rZU6gJSjRwPOsLpLYSkFUsBkJE6tIGwT
 DOmpQM5fEsyi2ko/rKCG+z7u1hqJm71dKJtq5SiLVYJQhqXAeTPAwA4cBQRbx1ugUNde
 QTZCP9Ct2rgCS8kPDVGtix+zzUZDTPXp/vQlVwKwzTbzy0ej+K+qdpsBFYHYm4S9Vovy
 lCw73Wzset0YETmy8HfUDS45/m72UzqfwYY9/ySUkiTeSRsixWAcNSl+w1jiPRzLHI1S
 HqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746857825; x=1747462625;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=snxR6Tf4837ucEUccRrRLlGIQOdYmeLTDj3OfwCYzvQ=;
 b=DTX/UPNsNf3QXWeyE2Hn1t67uYGa56aJZ24IubYeqQgdB7hJW5JMn18RlJRQAJXvrK
 j3Ny92UFWPU9JK5x6QeMbzob1U2mXM3JJZ68y5be9WLbtuPuEfEr7/0FpO4mgnVCddiz
 H4Uhd2QdGntgMnVhZighmiMux2go8wxfTDzxyMe+LLFhz5HZGaw1lNhhxXoSZJ3yDP/L
 9ps2/5cCK8KbHX+Oa45eKgDElzJHsw6upIDOYQVhLNp7+kl1cejdsjJ94kyCD/D9fFGB
 PlY65PwjQjSTKB0HVw7eZDuwWe9lXfdeFUmEy1qL8gn8o6rF2Q/zcFzt6GBBzFj0qQ7q
 27Fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCgmXZl3jT+SnwYsMPS8cNONUOKs14Qd7DF0lX9zoSoEcM8BasJ/TBII8OjNKrKdM1sGV6Bw8xMoLw@nongnu.org
X-Gm-Message-State: AOJu0YxCt6KoEUfQCIeE2jK8BJmgneOJLTwyqU9Q1jyZUOJD3a3HXBzs
 2xoI/Jr9rneZYJnpotOp5HtNctllF8MAnjrGGdXAY6gQYk7/fTJ9uZKmYMNQ004=
X-Gm-Gg: ASbGncuRidM5tvQMAJk6XLXjzPUFpj2fIZWnyCMIdkh5fMZCtfOUMRsqtpWilMYfk/c
 50EX4AVuZtgJtJSE7z/vGsD0Zn5gYIj8YflYQDZTtjcGJwHgxfo/37N44HiYvMe+9qjNlC2pZ6k
 PkX6QOTrxLQDOPtorV1fD0EpGBeZ0t/pvUVpoaudNmAXJFqZ7xOmNWHRRD/JjPGmWesHVtvwaKc
 YXbRHKxjgc5JSrqdO0YFahvLpeCfTi8OOJsa6ExMWjkZqEYLl9Lid4j5s96TmCRnpmJ3kcRuyF9
 JAcIjXf5mZDoAi4gOE971ufzYynEaZhO7HcPv4IpSkee9IRLLZgHZmjpI2LF/FE=
X-Google-Smtp-Source: AGHT+IFh1/oOgfS7SNz4V7zoZb0gZlfOWG28cRtJW3u1nO686uWLgIQnlm7ChFZCCKRjXRxq8X8AKw==
X-Received: by 2002:a05:6a00:190f:b0:736:a6e0:e66d with SMTP id
 d2e1a72fcca58-7423bc58f29mr8051247b3a.6.1746857824283; 
 Fri, 09 May 2025 23:17:04 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-74237a10867sm2656035b3a.110.2025.05.09.23.17.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 23:17:04 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 10 May 2025 15:16:54 +0900
Subject: [PATCH 1/3] docs: Bump sphinx to 6.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-sphinx72-v1-1-2358e0c68bbe@daynix.com>
References: <20250510-sphinx72-v1-0-2358e0c68bbe@daynix.com>
In-Reply-To: <20250510-sphinx72-v1-0-2358e0c68bbe@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: devel@daynix.com, John Snow <jsnow@redhat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

sphinx 5.3.0 fails with Python 3.13.1:

../docs/meson.build:37: WARNING: /home/me/qemu/build/pyvenv/bin/sphinx-build:
Extension error:
Could not import extension sphinx.builders.epub3 (exception: No module named 'imghdr')

../docs/meson.build:39:6: ERROR: Problem encountered: Install a Python 3 version of python-sphinx and the readthedoc theme

Bump sphinx to 6.2.1 and also sphinx_rtd_theme as required for the new
sphinx version.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/requirements.txt | 4 ++--
 pythondeps.toml       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/requirements.txt b/docs/requirements.txt
index 02583f209aa6..87f7afcb2e79 100644
--- a/docs/requirements.txt
+++ b/docs/requirements.txt
@@ -1,5 +1,5 @@
 # Used by readthedocs.io
 # Should be in sync with the "installed" key of pythondeps.toml
 
-sphinx==5.3.0
-sphinx_rtd_theme==1.1.1
+sphinx==6.2.1
+sphinx_rtd_theme==1.2.2
diff --git a/pythondeps.toml b/pythondeps.toml
index c03c9df81b5c..4f6b6f01e0d0 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -24,8 +24,8 @@ pycotap = { accepted = ">=1.1.0", installed = "1.3.1" }
 
 [docs]
 # Please keep the installed versions in sync with docs/requirements.txt
-sphinx = { accepted = ">=3.4.3", installed = "5.3.0", canary = "sphinx-build" }
-sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.1.1" }
+sphinx = { accepted = ">=3.4.3", installed = "6.2.1", canary = "sphinx-build" }
+sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
 
 [avocado]
 # Note that qemu.git/python/ is always implicitly installed.

-- 
2.49.0


