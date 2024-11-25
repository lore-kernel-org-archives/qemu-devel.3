Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BEBD58D5A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFayq-0006zt-C5; Mon, 25 Nov 2024 10:26:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFaym-0006ws-Ef
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:26:24 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFayg-0002YE-GM
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:26:20 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-382442b7d9aso3508281f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548377; x=1733153177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a2fXEZ40BYTZpxwqr81qDeJmktd3tot0XA64fsee8Sk=;
 b=m5RC1SLZacH0sCo5RcGZL4t/RqbD+GUJoub5tl3tOJ5US9Vg7AAPTTr6hApB8eQvVr
 WQIblMjl9R0hvUPIYBPSKPBu4uwGRNO7aa5OWSlOgHCW4nXDS1TsOGUmomB8p0KayHy9
 06ZxBIxNszJcyIRcdRuFhhGcooQ4LHt+Kwh2Fe48fljww06F0ezRC+eNdm7VpOKNM9gR
 oyMgPiLxdgKBQ+JN9qRhnQbVtR3qYQNsmTiQJolLjIiQshQDSH5fOvgZemE1yx3h2+Aw
 ROhyDwvnYG62f7vL0DtkeNpb8HN87p7JXIslSEKy+7lJ4XfJrRLaGdmM5+SHRg6ztfAQ
 ZrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548377; x=1733153177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a2fXEZ40BYTZpxwqr81qDeJmktd3tot0XA64fsee8Sk=;
 b=qRL1eD8gvakYDIWl+B0TV58Fjlv1ceGj90Zj9860eJepzMxSr3rjl1Q0bCdRsuzD1Y
 rZpj+tNkthWe9xDtVcIw2L/kcuIe+bfjjqksuaagzifEYIldkE1v62KKxB6p7654wIZb
 aVYoEStZlxBq+UNNy6Gb1DZQ1uuaRlZpzC9+KPjPwKlcNJkmRmIUxv+7C3c+1MspiK9Y
 9GIDX2b46UmRofuOMWr8+oAbPgydwaSr9n8jG5/sYk2UfEHy0naAHM/3HVwaLjPaVtD5
 KWvMUCSk2IcP3NISpqyib7rLoDews69Huz2DDJBQCQ/nFsm+hP08FbxJ9uV4orkKxu2L
 Q4kQ==
X-Gm-Message-State: AOJu0YylRdZS+nRi7ZSGCU+uvNxT2diK6RFMvcT8F17lBTl0E6o4ogRm
 Sd+pAHi4PF3lI2IIXVQ43W8kQvvYL70bPHP275qKibZpVGWDWXCj6FdytP4OT0g=
X-Gm-Gg: ASbGncua8xsiTkF8/i5mTFEyBOGd9EShIJVZ6ueoZku3AcKc0uMAQO3gjbYCn1xerov
 q+Xswi7QOjZ9AqM9tSo+EgkbQMuPobdhXYZcCsPAwSBXSi2oJNNTpmsBxZqgnoGDE2Ng4lodqET
 OnvlL5IfNuIJgEBBlCRjaZGy+fg0wap0ePUfKaHxZRKVat6Lkme/vtC9iw5zM/YXzfvEI2wUxeo
 P2sMP8W7vL9BMV9NldLwXlPRkT2cu7UZbsty9/g/S2N089B
X-Google-Smtp-Source: AGHT+IHLFKXVbfrWbEJ2k0TaxAtiGiJ5Zz01ioXL6R/DB3CMfOz6JI1ww3hZgY61mfYdL9p51Fs6aQ==
X-Received: by 2002:a05:6000:401f:b0:382:2cbd:9a4b with SMTP id
 ffacd0b85a97d-38260b6df0amr10466459f8f.24.1732548376874; 
 Mon, 25 Nov 2024 07:26:16 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd04ef5sm10611647f8f.111.2024.11.25.07.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:26:14 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 14E675F8FE;
 Mon, 25 Nov 2024 15:21:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 25/28] docs: explicitly permit a "commonly known identity" with
 SoB
Date: Mon, 25 Nov 2024 15:21:02 +0000
Message-Id: <20241125152105.2100395-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

The docs for submitting a patch describe using your "Real Name" with
the Signed-off-by line. Although somewhat ambiguous, this has often
been interpreted to mean someone's legal name.

In recent times, there's been a general push back[1] against the notion
that use of Signed-off-by in a project automatically requires / implies
the use of legal ("real") names and greater awareness of the downsides.

Full discussion of the problems of such policies is beyond the scope of
this commit message, but at a high level they are liable to marginalize,
disadvantage, and potentially result in harm, to contributors.

TL;DR: there are compelling reasons for a person to choose distinct
identities in different contexts & a decision to override that choice
should not be taken lightly.

A number of key projects have responded to the issues raised by making
it clear that a contributor is free to determine the identity used in
SoB lines:

 * Linux has clarified[2] that they merely expect use of the
   contributor's "known identity", removing the previous explicit
   rejection of pseudonyms.

 * CNCF has clarified[3] that the real name is simply the identity
   the contributor chooses to use in the context of the community
   and does not have to be a legal name, nor birth name, nor appear
   on any government ID.

Since we have no intention of ever routinely checking any form of ID
documents for contributors[4], realistically we have no way of knowing
anything about the name they are using, except through chance, or
through the contributor volunteering the information. IOW, we almost
certainly already have people using pseudonyms for contributions.

This proposes to accept that reality and eliminate unnecessary friction,
by following Linux & the CNCF in merely asking that a contributors'
commonly known identity, of their choosing, be used with the SoB line.

[1] Raised in many contexts at many times, but a decent overall summary
    can be read at https://drewdevault.com/2023/10/31/On-real-names.html
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d4563201f33a022fc0353033d9dfeb1606a88330
[3] https://github.com/cncf/foundation/blob/659fd32c86dc/dco-guidelines.md
[4] Excluding the rare GPG key signing parties for regular maintainers

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241021190939.1482466-1-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-40-alex.bennee@linaro.org>

diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index 83e9092b8c..10b062eec2 100644
--- a/docs/devel/submitting-a-patch.rst
+++ b/docs/devel/submitting-a-patch.rst
@@ -18,7 +18,7 @@ one-shot fix, the bare minimum we ask is that:
 
    * - Check
      - Reason
-   * - Patches contain Signed-off-by: Real Name <author@email>
+   * - Patches contain Signed-off-by: Your Name <author@email>
      - States you are legally able to contribute the code. See :ref:`patch_emails_must_include_a_signed_off_by_line`
    * - Sent as patch emails to ``qemu-devel@nongnu.org``
      - The project uses an email list based workflow. See :ref:`submitting_your_patches`
@@ -335,6 +335,11 @@ include a "From:" line in the body of the email (different from your
 envelope From:) that will give credit to the correct author; but again,
 that author's Signed-off-by: line is mandatory, with the same spelling.
 
+The name used with "Signed-off-by" does not need to be your legal name,
+nor birth name, nor appear on any government ID. It is the identity you
+choose to be known by in the community, but should not be anonymous,
+nor misrepresent whom you are.
+
 There are various tooling options for automatically adding these tags
 include using ``git commit -s`` or ``git format-patch -s``. For more
 information see `SubmittingPatches 1.12
diff --git a/.gitlab-ci.d/check-dco.py b/.gitlab-ci.d/check-dco.py
index d221b16bd5..70dec7d6ee 100755
--- a/.gitlab-ci.d/check-dco.py
+++ b/.gitlab-ci.d/check-dco.py
@@ -78,7 +78,10 @@
 
 To indicate acceptance of the DCO every commit must have a tag
 
-  Signed-off-by: REAL NAME <EMAIL>
+  Signed-off-by: YOUR NAME <EMAIL>
+
+where "YOUR NAME" is your commonly known identity in the context
+of the community.
 
 This can be achieved by passing the "-s" flag to the "git commit" command.
 
-- 
2.39.5


