Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD25D47CDE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 12:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgj8E-000286-Te; Fri, 16 Jan 2026 07:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgj7c-000220-9O
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:40:12 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgj7a-0004g1-08
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:40:11 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-430f3ef2d37so1468765f8f.3
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 04:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768567208; x=1769172008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tP5WdEw2SWqsSQRDCQEyx/TDMvYDo3Lw58Gf9MWPLqc=;
 b=ltmqnkig0lk0YMX988KWbITW4IjjsLNXfvAl8AeU7p9m1R70EpLbB42johZEavmcx3
 6mer3oQEr+bW354EK0bzOdotoZrrQf/Jm1EjrsfcVVJhdWtzYhOYzcgVuU0ELfmhFKQc
 HlgHQYye6gODymPDo+nlNZA/Tb7JtGmB2+g356XAqsXgUrJ/CIY1S16PUYQZUJBP5Ic+
 yMayi91cUqdOQipUJi1cfvA61wBCOv+ZnH+9BKhsjhx6sayXHFN71t/UYQo8/7DJ5WkS
 ffXZTG8fAMSfDuSn53VGklGXPxHEsAp9V33JWQ2UGKSZkkiyf4s40nLoQ1flSAVgtfEp
 FYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768567208; x=1769172008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tP5WdEw2SWqsSQRDCQEyx/TDMvYDo3Lw58Gf9MWPLqc=;
 b=cvMrZfX9OBbU6kUG7T3IrWebpWGJ8IDWpp4401EIXPkhWQvXF9mfF/FX3Ik9LGzOSs
 56HkFP8UORb96vY9ljx0gYeUbdsuvktOenb8VUFBo9E1aIrhcjpBLxlCOJjWWLa1FuWk
 JF0K5JyfW0P9R6Q5aTun1wwhyqYXkbCMOLd4KlnApIZTTdmoHQPDdKF+LH0S+AkZNwnt
 FpKWSzV3ZZLLVcRC2apyNVaNCeDFUU5e7vL00m5zerbemKoPOTaGETtGbRkgeX9ADTpk
 McSyrqjbxVQZGejdgqm9aHckqnkIGhHknnQPsb9E9XK9Fy/p84ZdCDTYXOD7P2P3lIBT
 wJXw==
X-Gm-Message-State: AOJu0YzSKGTs2D2McIon6SdSoClH7RK9J2badsuCt6Jfdxhe984rqiq5
 pbGA+JC988oipirVnlivs2daciV7Fz4ea1HXqjmBUoBrccqpYHYIdjArKs9KLW7ZNEXjw6PFiNC
 BfK2F
X-Gm-Gg: AY/fxX4aRBc2Qt9GO8VLVBUPiA7weLtG/ftMhauIQcoL+Q5O1jg4D7B5oHVAucq84Pz
 rPnUBAiym4qLgxTRxTcy58i9fbE46fVUicXdaJpuNIDawJg6VM4z+0y/eLKns9mK1UDlU7uTavb
 srYQxaaxttyFS9grJz5o6oAW8U7VsNDukA/MwznNas0PN6Z/cJC7tmiQVHPGyuR73gutR+E5puM
 HaRyNPRbIujfkID5vnXVuHOxiT6jXWDFNexXI1/NAzc5/SUGbGlgGLsEV9r0OPIX+KFrA+F3F/J
 /i5Hpcm7Px6vPD0WmveZazKzksje1R7E/m4jsBDpKWym7sEyIC8FGbcpYNzLg1vWRWvVTOywiyQ
 KLbpWSJ+N5GWFa63l1aVaj/DG73NHWR5df1A9ioZOUq2OfOkTcBAPD4YL6APr7V3WAlZ6S7B801
 tjUbj9B0wE2Zo6Hh+GhNjwYSYap8MGMAqFU0ghQhQnhXOGcbgubAVFidwhKnPRJ9JJDcY+bDkSN
 Cn4WlZiQk0fc7rAvCp9pFZhe4f/EYGwZKY0VRM+CWzoDA==
X-Received: by 2002:a05:6000:40e1:b0:430:fdb8:8510 with SMTP id
 ffacd0b85a97d-43569989668mr3238891f8f.24.1768567208339; 
 Fri, 16 Jan 2026 04:40:08 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992c6f2sm5192566f8f.19.2026.01.16.04.40.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 04:40:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 1/6] scripts/clean-includes: Allow directories on command
 line
Date: Fri, 16 Jan 2026 12:40:00 +0000
Message-ID: <20260116124005.925382-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116124005.925382-1-peter.maydell@linaro.org>
References: <20260116124005.925382-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Currently clean-includes supports two ways of specifying files to check:
 * --all to run on everything
 * specific files
There's no way to say "check everything in target/arm".

Add support for handling directory names, by always running
the arguments through git ls-files.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/clean-includes | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/scripts/clean-includes b/scripts/clean-includes
index 25dbf16c02..07c0fd44e4 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -14,7 +14,7 @@
 # the top-level directory.
 
 # Usage:
-#   clean-includes [--git subjectprefix] [--check-dup-head] file ...
+#   clean-includes [--git subjectprefix] [--check-dup-head] file-or-dir ...
 # or
 #   clean-includes [--git subjectprefix] [--check-dup-head] --all
 #
@@ -28,7 +28,8 @@
 #
 # Using --all will cause clean-includes to run on the whole source
 # tree (excluding certain directories which are known not to need
-# handling).
+# handling). This is equivalent to passing '.' as the directory to
+# scan.
 
 # This script requires Coccinelle to be installed.
 
@@ -86,11 +87,14 @@ if [ $# -eq 0 ]; then
     exit 1
 fi
 
+# --all means "scan everything starting from the current directory"
 if [ "$1" = "--all" ]; then
-    # We assume there are no files in the tree with spaces in their name
-    set -- $(git ls-files '*.[ch]' | grep -E -v "$XDIRREGEX")
+    set -- '.'
 fi
 
+# We assume there are no files in the tree with spaces in their name
+set -- $(git ls-files "$@" | grep '\.[ch]$' | grep -E -v "$XDIRREGEX")
+
 # Annoyingly coccinelle won't read a scriptfile unless its
 # name ends '.cocci', so write it out to a tempfile with the
 # right kind of name.
-- 
2.47.3


