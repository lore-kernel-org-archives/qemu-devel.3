Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D78C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urau6-0003Nb-SK; Thu, 28 Aug 2025 07:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urau5-0003MX-72
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:53 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urau3-0005lp-Fy
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:52 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45a1b05a59fso6040515e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380890; x=1756985690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S+zSf5gKYyiBX8RYazhXjiVCPsv19NY1x2MGbwfSWFo=;
 b=JOMn4hzZQoQ4k7845Pl0Vd7o316UBqfcBKCbxbFr3edNTkaFCNwI7Dnopk3VTDdwe4
 kjVms/dq1RWjbOmJpb6Sc1PVNLc5kwAt2KV0eZodkZzM+Uy6nqPOU2U3UC7mOXP3id4X
 Ff0bIBkbjqZ7T6w6GzdYqi9k++YWNheatnfES6YZaYDhW9rsiTwQhBTpi7UZZsJdG7yX
 6kBt9lNU59NnvJAQbGXKaVkf29nXalomYDvmGbkx8+CaNPCLOE1zPMK8LXJOvsMk6FPE
 j+FgbxgXWKs1ZVIOBikKP0NFF3AbqEr6xkIBPFlW5fxYOGr/aI6+0Rss6Nap5NZHl/KK
 mvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380890; x=1756985690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S+zSf5gKYyiBX8RYazhXjiVCPsv19NY1x2MGbwfSWFo=;
 b=XlPe0EbjyiNOZwp9WZm9n+TkPFEfHob/rytR5ul0DqOWOscXJBVqhVWwhTTLLru4p7
 y14sKafKlTWPgQ5sHH0PFgJK/GWB66xIKRbukgJjMVb0hfTQZup0jNdOp2ptiYcXrq5N
 /aHdocqgo+gWQvIhwj254H7CIvUOVvdMcjgvNHUCgbSTSy4l8eTtS9xR1tN/ozuZsDN6
 rFfxSXg76o34tQDB8uD7u3Qs77mSnQAoi0tBNA+aeZCZXDxfKP8e2h/lnEfMiZuo7eUV
 Kh0DU94ab+o6qsmgBsvhE6VEd3PBJLdg+mD2oBwqaptC0cgf61hgzcQwUrvzMxoYGNJY
 1FCQ==
X-Gm-Message-State: AOJu0Yy/oVFpV2Son6nsesXTGt8/YoIM8Nqj5HaxhCfLLM7ejb/xVB7m
 8Q97xgM9npMCFXi8WoCkUy5EMK3FYU+SowJmHjCcst+l9KYiKvcoGcXG5ibyMZebhkdTounzli9
 xhYtu
X-Gm-Gg: ASbGncs6Jqha/LwaaViemzed8HU2xHFUhz++bY4bXOzbCYP65xvLIyq+sUFjVs8A35W
 MBuSKhbrKDP0yr9q96bOlya0w026lQo5mBrDYMS0UtQomnAZYUye0PGZDIgBkidH/GT+WO4a372
 HWO9ISJ1TNjNTleGZ2noZUejXB7JIAfWZzrbHMfyn++B1K5T4VFI8CKknsgalDjHHWQI9Mbt/88
 p8hlSL8a+9gX4q3962dOQrXd+G/eRagDWQ1eZ4AktD9Qk1YoILZ5yAZpJY9eNPSzbsCI4NzB58J
 Dfq7Yd8pYg/4/H/KtAeN7OvBODELUbk51LrMNgDQAzgv3fDbr2yztrHGR5T242QK3KC2KLkmaRR
 hQSbXRRdq6y2YA1YHjFoC2JWfwj1s9fQxeaovnvQ=
X-Google-Smtp-Source: AGHT+IHCxIRmghgd5YWev+N653pMKjUbocl/9emiHYoEgLRyNtDVp7cYAdDQpRc6uhvAln0EUoz9vg==
X-Received: by 2002:a05:600c:4fc8:b0:45b:7be1:be1f with SMTP id
 5b1f17b1804b1-45b7be1bfcemr11182345e9.32.1756380889613; 
 Thu, 28 Aug 2025 04:34:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.34.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:34:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/32] scripts/kernel-doc: Avoid new Perl precedence warning
Date: Thu, 28 Aug 2025 12:34:12 +0100
Message-ID: <20250828113430.3214314-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Message-id: 20250819115648.2125709-1-peter.maydell@linaro.org
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


