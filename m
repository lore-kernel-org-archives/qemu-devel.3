Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5764ECA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 17:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umbWI-0008Ne-BI; Thu, 14 Aug 2025 13:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umbWE-0008MK-Kw
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:13:39 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umbWC-0001ol-8b
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:13:38 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b9e41669d6so976215f8f.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 10:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755191611; x=1755796411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GD2+pWQi5I5BSGyGawdBjG69hOWuCmkwcY8uG5kPViQ=;
 b=vmQSigdSc86+RGhldYbwVn5L2dmqyMWQTERgSuLWsFpUzjoyNHG5cLDh3KgZat4KBI
 RxAyCKVz1klOXAFPsDGlB56jpL6cRwog9yRjDBR7sVUyKhrEQCkUAmnV2ARcQXFreXgI
 cDJD6ceELk5Ml2u7uojXRYlDwvFX85ddXVi+LdWkFCuiAJVn27o75L/4j/imXViLH1yi
 904SO2yTCn8wEzBKLOxbGt9ZSbIkIqB3sXtTj6O5sMbuGxQ2Y4wPztg+VCUBs+iL6iOv
 FS4trTjDcCmZ0mC/OTI5x6XhtY9v+tn/OT36oG16VmXFx/uWqisp4BVQLBqn4vdHNbgc
 J3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755191611; x=1755796411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GD2+pWQi5I5BSGyGawdBjG69hOWuCmkwcY8uG5kPViQ=;
 b=lxLgWb70RgzQ7SYiA23JsLfZMHbKe6vs3cGVS/34/Ym3ZRkiBe28JRwvN/eACPZHgK
 PnFuXJcxcpbE+7wetl5Zc3iY/oYsGJdNR7HqpV1iw//ylWgZq2XGDmWAJzo3RdtVtLRE
 tMY9cCZG84EA2rntgCdIq8T7i5eMoZrxAXbVo/nF38tk1gmHnb43avguC2YrRC3Sbgks
 KdGsTWrhggXqzxgzhgnoyC2j2b5WT9VRcqIsbMfNCrxQql6jKkLKy0X2wcIN/Lw421+/
 oJk7SRYbHXWOoACk34M0fHB0GIWL8qo8KqpfzNfWItKMMByWmlzrO5Fc/9FW7FaKaBWt
 +qcQ==
X-Gm-Message-State: AOJu0Yy8vbHYsRyK+bqIDahdjaW0Qt6HtZyhtlSh3HfpISTEgx7HnGWg
 30Y5A2mOdCkE6xx9RR4f4Km+0mmnD0+CZi4WS0EiyXH3GpqRpb2DETVvAeoDJYkkWCNVY8+N1+2
 UJYPd
X-Gm-Gg: ASbGncsBfSOHwpppKeMcedqIDoxLE0gk8TaTTojDFX6RiHgjivm8vIY3a1CYexsuMne
 ntT/hg4XEu8U17IrNZNIBf/DIB5maXssN5ICczR8I+uOHeJ1+yrxOwYoM+gfh1jzXqsaJj3qfV7
 544VRqGa2y7Mg3t3eXoJM49iXIjkAHvI5wac+EwMMHwzvMgbRiar3CQbmXvdi3gLGRdwQYWXbUZ
 6uTzChrJU9tw1BpFZ7+xVYnbqwz+cXNlEQMrbutqqFqN86CV8clEZ2/fa3wIGVMZWecszfSpVO8
 FgpJFIuNseXMGiVyF5AefQFYQuY9H+qCSspVeWCSGOTaWGXIqHfnUfmC7JPEvlZEDHKIOvbraNP
 LNA+EgnbltIcNnmwI3o9H2xJH/Xwa
X-Google-Smtp-Source: AGHT+IH/32rKpvLeNK0K6BCleTZRnd6FhNqd09+p9dNjTx4Le5948KaeW6ccMCXgOcQU3ePqXevXjA==
X-Received: by 2002:a5d:5d88:0:b0:3b8:d337:cc12 with SMTP id
 ffacd0b85a97d-3b9edf2c797mr3185489f8f.22.1755191611306; 
 Thu, 14 Aug 2025 10:13:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c76e9basm29489165e9.21.2025.08.14.10.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 10:13:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH for-10.2 5/8] scripts/kernel-doc: tweak for QEMU coding
 standards
Date: Thu, 14 Aug 2025 18:13:20 +0100
Message-ID: <20250814171324.1614516-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814171324.1614516-1-peter.maydell@linaro.org>
References: <20250814171324.1614516-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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


