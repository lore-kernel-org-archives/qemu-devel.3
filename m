Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BD1E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 18:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKiXK-0002Sp-S2; Mon, 09 Dec 2024 13:31:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tKiXJ-0002Rv-Vb
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 13:31:14 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tKiXH-0006tT-7s
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 13:31:13 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7258bce5289so3670455b3a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 10:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733769070; x=1734373870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oUKq6vEd08BNHFL5xy+IGBW1qUyoIpn1SmzghDG21Ks=;
 b=suP7GaWbcb/NqWo9BY4r1ChUGurpmSk6CApq7rSSGn5GRz26K4H41FAD9c2jiGSszD
 JBpqzYI+K0yOlyKtg89Q9kQiQxU+qmc5iGK/RU7wb42YHXP3KgIPuMmEU9G+bwEJdoub
 to+oktZTVi/vysktOEcSfmIEKAi49jwZl6yU7C3f6LlUkqJLdfiEziI1Ygn2LPDHijIY
 +odI9T7w/lI7/1B+17F79ed1wSaqWQcYR+SNndx1lrxBkmXkbQSBTaCY3Uk3iRIqLHRZ
 ymHiLbOSxrMQ+9dXQK2sYNT1293poZ9FmRNAWzG2ctG/VdL0YZSvfh6226VmN1rtjokY
 MOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733769070; x=1734373870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oUKq6vEd08BNHFL5xy+IGBW1qUyoIpn1SmzghDG21Ks=;
 b=Mm6OcgbHrMWrl4SvBYoth53G72MnP24t3mrt3tFeGxDn5cQ53Ie/BO6t//15Kpbjge
 0pjI5h7SePkCyt0B48EaOMsSW0VJzX7cdFpEIoBEUjL5kWerDwVQn4z8OqZz4xvH4XeF
 mjA3A4xfdBRhFfFk42V9kgQUUv3IG0VRWvVn33oSJco+DWydjgv5M2/13QEE+RdVpMs+
 pozpm3eXHBvTGnpuu5q+Ypl3MzP0HdPU6z9oE3RzjEmhksPOZUnkG10bOAhSZgjmyH63
 mlYkgrfCrTm1nRSWAUOHzBDuoUbImZrA206ZJXTBy+Q6gtLzBvmA0SgwJacWF4RYrZ3i
 zsgQ==
X-Gm-Message-State: AOJu0YwcfTN/3pjTHi6DL1y5tNSE8AGxE5iuchdp9aaxXF7bq6bIesLM
 CLcQr8cHDhkl9f3PmIJ7abYvCfmkgE7WmnmIoJVVyOkseMv01J3sQ9i4dPaV2pir8NNO9LbiQcF
 Xseg=
X-Gm-Gg: ASbGncs20i6WCc3a+zpSXwt61XEz72GatYjVI+kDhY/4un8uMFeR65LH/oJJnmUmZg8
 tNVjN1/ZsgPOOtVWAQTFzaD7lD1FE2AHz6A+uu1awvLUe8MQ4kc9FsQAl5xOJNyG3UQcWW2dPh1
 9xrUDL8tk5KvLwEOhqYRNYjP0iRsX0Nkfg6ZpyJdP6vvBE/d9D9JFyWilsZLuxUBgtWaGB4pTIJ
 SvO41WBAt3/lGTn9z4g6hCGfiKq2GYDvVvxznJPytTjMelkYSrut+YSxB3wBe45X0bjsxz9f+bC
 ueu+uogs/l1B
X-Google-Smtp-Source: AGHT+IGHgMJ38Jmr7nbffgCDllf16U7JHr53zhYSJkDuJ8Dm6v3gmzXLAgJmZrZFftLzkhyV7DOVuA==
X-Received: by 2002:a05:6a00:174b:b0:727:3c8f:3707 with SMTP id
 d2e1a72fcca58-7273c8f3efemr2557724b3a.23.1733769069981; 
 Mon, 09 Dec 2024 10:31:09 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725e2388d37sm3322821b3a.73.2024.12.09.10.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 10:31:09 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, Andrew Melnychenko <andrew@daynix.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 philmd@linaro.org, Fabiano Rosas <farosas@suse.de>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, gustavo.romero@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 2/6] docs/devel: add git-publish for patch submitting
Date: Mon,  9 Dec 2024 10:31:00 -0800
Message-Id: <20241209183104.365796-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241209183104.365796-1-pierrick.bouvier@linaro.org>
References: <20241209183104.365796-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/submitting-a-patch.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index 03b2ac298aa..69df7682c5e 100644
--- a/docs/devel/submitting-a-patch.rst
+++ b/docs/devel/submitting-a-patch.rst
@@ -235,6 +235,31 @@ to another list.) ``git send-email`` (`step-by-step setup guide
 works best for delivering the patch without mangling it, but
 attachments can be used as a last resort on a first-time submission.
 
+.. _use_git_publish:
+
+Use git-publish
+~~~~~~~~~~~~~~~
+
+If you already configured git send-email, you can simply use `git-publish
+<https://github.com/stefanha/git-publish>`__ to send series.
+
+::
+
+    $ git checkout master -b my-feature
+    $ # work on new commits, add your 'Signed-off-by' lines to each
+    $ git publish
+    $ ... more work, rebase on master, ...
+    $ git publish # will send a v2
+
+Each time you post a series, git-publish will create a local tag with the format
+``<branchname>-v<version>`` to record the patch series.
+
+When sending patch emails, 'git publish' will consult the output of
+'scripts/get_maintainers.pl' and automatically CC anyone listed as maintainers
+of the affected code. Generally you should accept the suggested CC list, but
+there may sometimes be scenarios where it is appropriate to cut it down (eg on
+certain large tree-wide cleanups), or augment it with other interested people.
+
 .. _if_you_cannot_send_patch_emails:
 
 If you cannot send patch emails
-- 
2.39.5


