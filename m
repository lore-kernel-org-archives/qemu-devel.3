Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83520C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 12:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrcq9-0008Og-8o; Tue, 02 Apr 2024 08:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrcpK-0007dp-6m
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 08:01:19 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrcoL-0003O7-VV
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 08:01:16 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41551639550so22453605e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 05:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712059215; x=1712664015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XLtSFJIR+pdlVJvy9cvj3GhXFmD3XkdoFwgLyOSTVnw=;
 b=AZAvNpTe2jtmJ2Ayuu52EzK37dnF2svpTnT6M4s6/eDtaoWfTQNKp218Pr2lkF/7YG
 KcVSi35JSMBsMGYIkoD92LK+GpViqjbXee4J0hpJAUSiTe0oBg+RyupTwAlxabnSHJe6
 hAPpPx0sOq3o1czziVOFkigGT9xWjfR6gbS73KKiNwcXs9pQfOldeug4a+MXKsJdqwb8
 YJMvh0wwC1+vkFLrf6jZcnAYf17Cx36lCESskpET7Cvd8I8XC5gInWLmO/BH3CzgwiJX
 +IyWmmYnGUiKW52cehUfPVNcyYnsodVpO2eYXhxAGNDwSVVLcy2Dl4OmYP6yrnTV/VX8
 7Edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712059215; x=1712664015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XLtSFJIR+pdlVJvy9cvj3GhXFmD3XkdoFwgLyOSTVnw=;
 b=J48YbcMdZqEj9CI9uZrbnXuASO3nb/6e0Sd0ZdTBfiW2y+l8tW5c4ufgXoPWAQwmf5
 CMK/dJYfu+FrdiAk+hnhnR/3nS8x70qEnWpjdLpXZoSwwtHUthYuQj73pne5M7M2Cw91
 sU5V2aWNkepmbTNLJMAMiwg/2qn7W+CCBHn5A7wUFcLzoaJyyIct+69nqyiFCWslJbZR
 DLuIaz8uCXhILDbJxyiwHXDi5A7bw1VeOpiI9iJs0jh914tUXqHqOgqaAmw6Wbf82WXs
 v1wG0U07t+i+fcmqwSRnp6s+6SlUsRhbVknsd0HCkFrWy6PI7sOZa0MMcG98DSIcHaU3
 tytA==
X-Gm-Message-State: AOJu0Yz4mxW2QCms0wXjtkUPFh6pPOkc0IFaR/UaO2HlIK0Bp6h9Iauc
 neWous28dTATMmpyz0RSY2haMcj8WX+s3DX+g/V33xP9bXD1Vj5AALZLUAEHX2SIMoRYTR9967Y
 tpQg=
X-Google-Smtp-Source: AGHT+IGdp3cLjKZrqYZS5LCwWv3bSsCGzZNkzl7KHVeZCKOh3YCpLvW0XOQ7+n6s2QyD5hondVse1A==
X-Received: by 2002:a05:600c:a47:b0:414:cbd:1ee2 with SMTP id
 c7-20020a05600c0a4700b004140cbd1ee2mr9128870wmq.35.1712059215639; 
 Tue, 02 Apr 2024 05:00:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 w7-20020a05600c474700b004156ca1df95sm3946167wmo.18.2024.04.02.05.00.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Apr 2024 05:00:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/2] scripts/checkpatch: Do not use mailmap
Date: Tue,  2 Apr 2024 13:59:58 +0200
Message-ID: <20240402115958.67615-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240402115958.67615-1-philmd@linaro.org>
References: <20240402115958.67615-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

The .mailmap file fixes mistake we already did.
Do not use it when running checkpatch.pl, otherwise
we might commit the very same mistakes.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/checkpatch.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 12e9028b10..76a0b79266 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -435,8 +435,8 @@ if ($chk_branch) {
 	my @patches;
 	my %git_commits = ();
 	my $HASH;
-	open($HASH, "-|", "git", "log", "--reverse", "--no-merges", "--format=%H %s", $ARGV[0]) ||
-		die "$P: git log --reverse --no-merges --format='%H %s' $ARGV[0] failed - $!\n";
+	open($HASH, "-|", "git", "log", "--reverse", "--no-merges", "--no-mailmap", "--format=%H %s", $ARGV[0]) ||
+		die "$P: git log --reverse --no-merges --no-mailmap --format='%H %s' $ARGV[0] failed - $!\n";
 
 	for my $line (<$HASH>) {
 		$line =~ /^([0-9a-fA-F]{40,40}) (.*)$/;
@@ -460,7 +460,7 @@ if ($chk_branch) {
                      "-c", "diff.renamelimit=0",
                      "-c", "diff.renames=True",
                      "-c", "diff.algorithm=histogram",
-                     "show",
+                     "show", "--no-mailmap",
                      "--patch-with-stat", $hash) ||
 			die "$P: git show $hash - $!\n";
 		while (<$FILE>) {
-- 
2.41.0


