Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3CCC52D73
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 11:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbf2Y-00067a-RT; Wed, 07 Aug 2024 07:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbf2V-00061r-BF
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 07:41:11 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbf2S-0003Aw-2v
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 07:41:10 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5b3fff87e6bso2071496a12.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 04:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723030866; x=1723635666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d0QPEqtA+qpDzt7i0lZe0ZnMA0wLtKuzxZzR6bJALDk=;
 b=iKiG3saLhsSfZosd05qJMJpe7uNecCh409uXaTPXQ08n4Vn/5BMSkz5zhJTQWah5Dc
 +fiomGCArdl4YlnxYzotSCCrrPyCdJJz5euHPM9BQp6c7onNAe7nYvk9OZvDx6EfmS7p
 upUcPmaFd3Web03O7eEjf85FLBDtX1CdxFeTK5K9+1fj4qE/1IJ0/JPCne5rOM535NIG
 gm6QqctFXp3YRlORbJrhBJ5NzJPgNiqnNAvvVWi9eRJ9CRUNZ0n+IHcYFOafc6POYLd5
 nC5oGzIJMGvLrlMZBAUdN6jcVRnC1oEKpVehoAfATP1xeWhUKjoSy6SXv2CollbeS7Mn
 //Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723030866; x=1723635666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d0QPEqtA+qpDzt7i0lZe0ZnMA0wLtKuzxZzR6bJALDk=;
 b=XkPTHYbNADWDLyA2Ug7jJ98wH6+hvjdlxsnBrgl9s7WHNr8BvqGw4pN+Ull1HECJWl
 uJ5B6uR4v6OViP9domEMyMzuqTZ/uYAAEmEEtfApPdACuY+w2tcI0KXOqKh0c+E8K8Mw
 hdxx46ly4ZP1f9SoBE5oeQuONomU9dgXuLP1NQNowQwSTBuACyG0JSd27hvRh4rSnpFG
 UnuARQJIbe8PjDWg7uYVRUaqaxl+JPwSbgZ7tARY+5cLH0iW1u3kOvdizr97BGtG4fRW
 wbZpcbakHuvcsXmoEwI5XK9d4S3Yd4yT0QCyRi/j6x2+nNFiSjxTXpIaz10hAmOhXFIO
 WfMg==
X-Gm-Message-State: AOJu0Yw/qQZ9KAZIusGe3yAoyMO8k9tOOrMmueFaxZMwF5CfK9J1JEOm
 rYvrJCfEuUxvI17ZjjEAY8qDlVTnx9KrxilH+WiJqIRdsoSvQ8fsfGGCRiu8XCo=
X-Google-Smtp-Source: AGHT+IGXfhMo4WKM08xR1ijUVkUY2acH2LQ5WRnPWtiEulanBGCcoTaNxAzcAmHrg4vPybmMDq4HJQ==
X-Received: by 2002:a05:6402:1a3c:b0:5a3:5ac1:ed57 with SMTP id
 4fb4d7f45d1cf-5b7f36f5898mr14248901a12.5.1723030866202; 
 Wed, 07 Aug 2024 04:41:06 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5b83bf3ad38sm6969960a12.84.2024.08.07.04.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 04:41:01 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 430ED5F950;
 Wed,  7 Aug 2024 12:41:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 4/6] configure: Avoid use of param. expansion when using
 gdb_version
Date: Wed,  7 Aug 2024 12:40:57 +0100
Message-Id: <20240807114059.2339021-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240807114059.2339021-1-alex.bennee@linaro.org>
References: <20240807114059.2339021-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

$gdb_version is now used in more than one conditional case and its usage
in such cases may increase in the future. Therefore, avoid using shell
parameter expansion when using it by setting gdb_version to its final
form.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-Id: <20240804161850.2646299-3-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index a3aa257fd3..97de85d710 100755
--- a/configure
+++ b/configure
@@ -1103,8 +1103,10 @@ fi
 # gdb test
 
 if test -n "$gdb_bin"; then
-    gdb_version=$($gdb_bin --version | head -n 1)
-    if version_ge ${gdb_version##* } 9.1; then
+    gdb_version_string=$($gdb_bin --version | head -n 1)
+    # Extract last field in the version string
+    gdb_version=${gdb_version_string##* }
+    if version_ge $gdb_version 9.1; then
         gdb_arches=$($python "$source_path/scripts/probe-gdb-support.py" $gdb_bin)
     else
         gdb_bin=""
@@ -1673,7 +1675,7 @@ for target in $target_list; do
           echo "GDB=$gdb_bin" >> $config_target_mak
       fi
 
-      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge ${gdb_version##* } 15.0; then
+      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 15.0; then
           echo "GDB_HAS_MTE=y" >> $config_target_mak
       fi
 
-- 
2.39.2


