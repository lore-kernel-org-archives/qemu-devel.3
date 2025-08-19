Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15BFCA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 11:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoKxX-0006jt-LD; Tue, 19 Aug 2025 07:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoKxU-0006jG-Bz
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:56:56 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoKxR-0002ZG-JH
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:56:55 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45a1b0c82eeso42891315e9.3
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 04:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755604611; x=1756209411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V90N7hHJ90As9MQNLBhWQghWj065zetAKg5HrlYQZK0=;
 b=sqboL9FmOXLEjGr5k3Xu1XkaU19izHLHCCvy3lfdXulzEQG1kKbefjX1HT5MU176rz
 YxviZnroPHcgK6Ohy0xl3TtKzGl3j60d0pek29P96AMeDQhr+Ygxp29t5RDgvVelyhrx
 qMQy0lAiVW2UYe3f9V8LNzOUi1TjDCmZfWOxGz3RM0MaQnagEInMDyFaA9gvXb6GMr2g
 22gtWWfOEWivvyN/jmMxNBTWeitOc+FTA96XYT4t3w8cyTSo1+2Y1fWgMuxzGL1F0XHR
 Rhug01pegoBRE0olzYnzBsWF9Pa4ZSt7Ab0TA+zT/vT9IE687sefFUD/dhxCpHPnXvVb
 VYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755604611; x=1756209411;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V90N7hHJ90As9MQNLBhWQghWj065zetAKg5HrlYQZK0=;
 b=HW/aWWWC8UIdHNXUcepdQM20+xlEhXJcjVF3/KM38ZtId7fFvBJhnwMDmhHcCtQnUM
 7ebDlS74xiFEdXsDupFkxzgBR2gLAUn+oCI21lzgGakyvMcnx/jJPWu9yZXFU8CoDc94
 ZhtzTzP6fSevpQdadmzAhMQzeX4G7LmUDwrhJGUViIka2jKIcgf5KGq3nAz/euZ07mNj
 F6nSeGHMBo48dqropY9l1X/OGk/a781Dgkh6f86ySSF/OkBtnmVcfXoM+W/EEnWKqRQl
 6TGyaxyvMmtog14CFmwA0+1C4uOwCSKtoZj+64Vc7MIpyPWXadmfQ3ldFdjvINxAeq7/
 3k4w==
X-Gm-Message-State: AOJu0YwjSJV/5hQ4vcodb9/wvM4onvQHOLi3myBIk87m1zVl1Tq7F5FV
 bkfTUTkrm/0DwHWHZf9DpCMvEwTK/bOBAW0ZE0OIYSklr8qG4jLNZWLL0CCoMiASuTnGQkAGVZf
 WFZTi
X-Gm-Gg: ASbGnctBqCtLF/0zt1/qYQeyH4Hphi5YEaxUYXDk/k1Ls8U5Gh1kSdQIHLe9TXg6IHW
 K/h6LRUKB2V2FCOJJnh+F+cENzoCqKsjmfnQHVVhEPGlHInD4I8B1fee0R8mkUJDKYJ9Pqx3aWX
 Li2cmniDdW09A9TxV6+DzvEjdJxRPeo5FyFxYUqny6i5YXdNXFiMiDDSHpAdbgGVGoWyxF8RH5J
 jWgnJHFfrzDRTEIogk5k2musJ15dLExCbF90H6pbNzOn30EofBSoEwAJ8qapxEMWGRHGJFfPNx3
 LxbMBUZByEOUNBqgSfWV4Uaa6e8hjmfimA/GTohnfbV/pPVUE/MPh/2bWit5t6CXcHlklFoC2hY
 7fq7gU8CeP4Q21ACfK3jT/Rcvm1XB
X-Google-Smtp-Source: AGHT+IE7ymsWAdNgwaFSuLzwvPq5RZ4hUfRa14Aqgpx5yXvKHrsfzDGAa1l5956wXokCbCWfU9K7+g==
X-Received: by 2002:a05:600c:628c:b0:456:1752:2b43 with SMTP id
 5b1f17b1804b1-45b43df3c79mr19644735e9.21.1755604611121; 
 Tue, 19 Aug 2025 04:56:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074d43bc6sm3465957f8f.25.2025.08.19.04.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 04:56:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH] scripts/kernel-doc: Avoid new Perl precedence warning
Date: Tue, 19 Aug 2025 12:56:48 +0100
Message-ID: <20250819115648.2125709-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Newer versions of Perl (5.41.x and up) emit a warning for code in
kernel-doc:
 Possible precedence problem between ! and pattern match (m//) at /scripts/kernel-doc line 1597.

This is because the code does:
            if (!$param =~ /\w\.\.\.$/) {

In Perl, the !  operator has higher precedence than the =~
pattern-match binding, so the effect of this condition is to first
logically-negate the string $param into a true-or-false value and
then try to pattern match it against the regex, which in this case
will always fail.  This is almost certainly not what the author
intended.

In the new Python version of kernel-doc in the Linux kernel,
the equivalent code is written:

            if KernRe(r'\w\.\.\.$').search(param):
                # For named variable parameters of the form `x...`,
                # remove the dots
                param = param[:-3]
            else:
                # Handles unnamed variable parameters
                param = "..."

which is a more sensible way of writing the behaviour you would
get if you put in brackets to make the regex match first and
then negate the result.

Take this as the intended behaviour, and update the Perl to match.

For QEMU, this produces no change in output, presumably because we
never used the "unnamed variable parameters" syntax.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This obviously will clash with the "import the python script"
patchseries, but I figured it was worth providing the minimal
fix for the benefit of stable backports.

The kernel's copy of kernel-doc.pl still has this bug.
---
 scripts/kernel-doc | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index fec83f53eda..117ec8fcd1f 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1594,13 +1594,12 @@ sub push_parameter($$$$$) {
 
 	if ($type eq "" && $param =~ /\.\.\.$/)
 	{
-	    if (!$param =~ /\w\.\.\.$/) {
-	      # handles unnamed variable parameters
-	      $param = "...";
-	    }
-	    elsif ($param =~ /\w\.\.\.$/) {
+	    if ($param =~ /\w\.\.\.$/) {
 	      # for named variable parameters of the form `x...`, remove the dots
 	      $param =~ s/\.\.\.$//;
+	    } else {
+	      # handles unnamed variable parameters
+	      $param = "...";
 	    }
 	    if (!defined $parameterdescs{$param} || $parameterdescs{$param} eq "") {
 		$parameterdescs{$param} = "variable arguments";
-- 
2.43.0


