Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4896BC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urauF-0003Vs-4U; Thu, 28 Aug 2025 07:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urauB-0003RP-57
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:59 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urau8-0005o6-Bz
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:58 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45a20c51c40so6759235e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380895; x=1756985695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yXdNwBtixAVHyZNqVndinWYHb5cWF2hyLP2f+EbgbMU=;
 b=YJXxtGw5xp/woNUMj6MKT3jsssb2vFur0ZMmo4ZBri1/SRwf8elwZzWDC/EIrAQRL7
 jazZPc30lrx8xyA5/b+bjLBcmvKVQCYRPRm0r/YbF5d+KdhvoKvG4tZSO9wSuRq3MeMb
 T21+b/RLg6v++tsyZ21j3kVvASvzpT95HjXKtEtZiOeZu1UvVHsGZoifQeHowf2gs6EY
 ymFvQ7J86LkjhSgTle597ST2E5rlW2nQdaSz7DJdPPyo+bqSd8DCpPqjuUEfQ/5yG28Y
 Df8pmUjf4mGtCs/bchj9TACvaQgCtoqUahxvuyTIOusxJloKeVIFBdL/ZwsbiezUENlt
 1g3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380895; x=1756985695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yXdNwBtixAVHyZNqVndinWYHb5cWF2hyLP2f+EbgbMU=;
 b=lKjHVo5oVEllD0RXuQ5k3I9HCrgJtsVl7J5ss35aizgHbJ36aFQRZmL3nsz7f/gV8V
 sD+ThYpZHx+qmCydAUEXZQOnK7jBaRKEXu7JwzFR0nR64TbpCNqPs21hqHx8YJi8kqfw
 ORwNhBYK+kDDi6o95hpQRj5jkn323p9jwd0bYUbp3XcyE85yJvGtpO26v0TLrJiZg+0w
 SyTudA0AhlYj6m0lxp3A4Qu1v2aCFNSI2zDqt9uIfI7hZi8t4h0kB/BWL0b+8kDCGElj
 Y+utTcrfxQFgDq96tMhP5AOM4FN72ke/7ycKAVko/tFfURLGJGs1npd8HI3r0Vhx5WyX
 EbCg==
X-Gm-Message-State: AOJu0YyzUY9ipqX+WY4mif2dRVgL6yPnxHGQ1DVybBUhjW9Vo/apXC+/
 hVsWnDy87fm2+Oyrdp85S5NGM+sbWkVu+GYOMJl5adxKq/PATn7s6GWPoANGE8OoW+0xbcfQBmr
 0rihX
X-Gm-Gg: ASbGncu0AMshO+UQ4u9Vw26cGobwYm4kOvlEOY29vpV6yyKV5MCRyRB8W/mNpmlv/Kp
 ESHllbHm25ob2UaKaPbPKzLEypProh/gE1QI8ykurCDSe+ZBysaU8P851JYVyp+1HbReoIWkA4y
 Aq8fGMkgb/p4wiTF8JpS1dozgyCdP8fwQ7yEw2zgpWOL/iBspq/FFa4/2E9PAgec5kXB//knmhc
 LL+53Z54OZOlFyZWgDIQtJid5U11Is50sFwFYVZcC17Z0dCnivJuLv+Om5hHnFOXBzBXhpnHANn
 mD52Y8Fu0w32KGFKp70dFW2DaW9YOaXAEhW83aBbk+jxcJcsxekcJR7GqIKxfYrfbDbbpJeD9Wp
 m2nVPJGfTrmzG4MDY3zwFvDKyqE7wPIAvb1CC1Wo=
X-Google-Smtp-Source: AGHT+IF8isbF8xnM0P6C3I6yTTEMZbml1/3kGyqyXKCRpxEk+InxD4Xa+zj42jYc8hCDzTscUUkYMA==
X-Received: by 2002:a05:600c:3b29:b0:45b:6269:d257 with SMTP id
 5b1f17b1804b1-45b71f46f24mr47617505e9.35.1756380894843; 
 Thu, 28 Aug 2025 04:34:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.34.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:34:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/32] scripts/kernel-doc: tweak for QEMU coding standards
Date: Thu, 28 Aug 2025 12:34:17 +0100
Message-ID: <20250828113430.3214314-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

This commit makes the equivalent changes to the Python script that we
had for the old Perl script in commit 4cf41794411f ("docs: tweak
kernel-doc for QEMU coding standards").  To repeat the rationale from
that commit:

    Surprisingly, QEMU does have a pretty consistent doc comment style and
    it is not very different from the Linux kernel's.  Of the documentation
    "sigils", only "#" separates the QEMU doc comment style from Linux's,
    and it has 200+ instances vs. 6 for the kernel's '&struct foo' (all in
    accel/tcg/translate-all.c), so it's clear that the two standards are
    different in this respect.  In addition, our structs are typedefed and
    recognized by CamelCase names.

Note that in 4cf41794411f we used '(?!)' as our type_fallback regex;
this is strictly not quite a replacement for the upstream
'\&([_\w]+)', because the latter includes a group that can later be
matched with \1, and the former does not.  The old perl script did
not care about this, but the python version does, so we must include
the extra set of brackets to ensure we have a group.

This commit does not include all the same changes that 4cf41794411f
did.  Of the missing pieces, some had already gone in an earlier
kernel-doc update; the parts we still had but do not include here are:

    @@ -2057,7 +2060,7 @@
         }
         elsif (/$doc_decl/o) {
            $identifier = $1;
    -       if (/\s*([\w\s]+?)(\(\))?\s*-/) {
    +       if (/\s*([\w\s]+?)(\s*-|:)/) {
                $identifier = $1;
            }

    @@ -2067,7 +2070,7 @@
            $contents = "";
            $section = $section_default;
            $new_start_line = $. + 1;
    -       if (/-(.*)/) {
    +       if (/[-:](.*)/) {
                # strip leading/trailing/multiple spaces
                $descr= $1;
                $descr =~ s/^\s*//;

The second of these is already in the upstream version: the line r =
KernRe("[-:](.*)") in process_name() matches the regex we have.  The
first change has been refactored into the doc_begin_data and
doc_begin_func changes.  Since the output HTML for QEMU's
documentation has no relevant changes with the new kerneldoc, we
assume that this too has been handled upstream.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Message-id: 20250814171324.1614516-6-peter.maydell@linaro.org
---
 scripts/lib/kdoc/kdoc_output.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
index ea8914537ba..39fa872dfca 100644
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -38,12 +38,12 @@
 type_fp_param2 = KernRe(r"\@(\w+->\S+)\(\)", cache=False)
 
 type_env = KernRe(r"(\$\w+)", cache=False)
-type_enum = KernRe(r"\&(enum\s*([_\w]+))", cache=False)
-type_struct = KernRe(r"\&(struct\s*([_\w]+))", cache=False)
-type_typedef = KernRe(r"\&(typedef\s*([_\w]+))", cache=False)
-type_union = KernRe(r"\&(union\s*([_\w]+))", cache=False)
-type_member = KernRe(r"\&([_\w]+)(\.|->)([_\w]+)", cache=False)
-type_fallback = KernRe(r"\&([_\w]+)", cache=False)
+type_enum = KernRe(r"#(enum\s*([_\w]+))", cache=False)
+type_struct = KernRe(r"#(struct\s*([_\w]+))", cache=False)
+type_typedef = KernRe(r"#(([A-Z][_\w]*))", cache=False)
+type_union = KernRe(r"#(union\s*([_\w]+))", cache=False)
+type_member = KernRe(r"#([_\w]+)(\.|->)([_\w]+)", cache=False)
+type_fallback = KernRe(r"((?!))", cache=False) # this never matches
 type_member_func = type_member + KernRe(r"\(\)", cache=False)
 
 
-- 
2.43.0


