Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24267E77171
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 22:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJKFN-0004b7-VK; Thu, 05 Dec 2024 17:22:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJKFM-0004Wa-6B
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:22:56 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJKFJ-00080Q-Hu
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:22:55 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-215936688aeso13261155ad.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 14:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733437371; x=1734042171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5Lu6p0mGuoLuKswKHrT0wMtIc0NP1LmOkh8ZXYhnho=;
 b=qyYwzXPmhpbPCuvT50Se07vK7QlhId1BpDqM5S0JeOxyNhg31yvinM7TIXO8H0hNHI
 fSEkYXF7GerQdu2O5Mo/dVjeXH6JTHtEDyzNP2QOQYYlNKWExfFBBZwzMXvLIwnnLsOa
 UDPULez2Mc3+9wJ5AkgIYeZpOfMfYAgM9Z2aLCYcs8oONykqOjCdYcVpuo/EH86MvfQX
 7EV+ZlDWCQvD/TDQwUGUCeMiAQRu4ggOMyZ4veqW7vgUeIsk/w0rl+Pv6hyGxJuXkaFH
 IBJF7V0m6jSb62YHO1mElLgCQhgJw4d2GCSmprbJVJH0oeeZJBUtGt+3XinV6VDPU35D
 WANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733437371; x=1734042171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H5Lu6p0mGuoLuKswKHrT0wMtIc0NP1LmOkh8ZXYhnho=;
 b=OAW0VRP5/iG7rXSY9UV/Xt+uU976426Ofgx8cOTyCPw6T1LXhuUyU4Ail88L79/KJ7
 SqRKKA1MVqzR8tNkcEYyfvwj7UqeNxDci0xirJUwWJ5TkZUOs83unCM0yTZ4JihygBoo
 b0q8B5Y2c2L3+02G5KlUNbmEdd0jJtrCpKxlyizQXK/eOskDKO+4ovoFXxEWis0I3kOT
 IUBkFCw07a8gvIJaQQTQ46Xu8WnvmIgXXrOzROqKq0pIn83OHtWcozW9oUOWvKEDJ7ng
 493xg6Hy67WAkT5WAD8fsG+0OuEgtISUjLY8cUWBBDX5ptli84g5LXbgLaZFtIFDyanT
 2q0A==
X-Gm-Message-State: AOJu0YxybtmnpBkX+JKdef0BO7rAq1NRyb5YqmaeSYGgWOj6GaD1IkT9
 tNpNUc2OOanJpDbPwJvljzu5Uy033jMaqGyuCp6oKvgu4hMHPNnyhnOdai8iwH3iXoOxAR7w69h
 w6xk=
X-Gm-Gg: ASbGncvHnlOF4YeGcITQN1W2nAq3/j3MbwXOTme4ob0UkquF5uVSmAyCnO6D3Rc9lDM
 D1V+cgPD/lmjS5aPNZzvtTPsilCFVqHpaXFGjM6ryrM9VcDOCcWmQCTb5/aXMmGX8KmjSiur78o
 tdQUDyrtxkz7gjPvdh9/nwOn6GnGX9z54nFvlEOjy7rnvQLyar5rs1hDYXmjgB14MjzA0njoOzF
 7toeHvUKhqYZCQOw242Hsd9herKLNkKH7n7DQYq0MsR3KKTdvSqeffEmev8b+V6cLK+7MpGCHAH
 5I+AqR9g
X-Google-Smtp-Source: AGHT+IFyCwATFotsgQSxoCFijjdMuigGb94TLzAYgWFUObwOD3XnGp5ahGX4zbRs/+b89VCEbBA1vA==
X-Received: by 2002:a17:903:240a:b0:215:a05d:fb05 with SMTP id
 d9443c01a7336-21614d781cbmr10834045ad.32.1733437370969; 
 Thu, 05 Dec 2024 14:22:50 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8f0b571sm17310435ad.183.2024.12.05.14.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 14:22:50 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 gustavo.romero@linaro.org, Andrew Melnychenko <andrew@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 manos.pitsidianakis@linaro.org, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 2/6] docs/devel: add git-publish for patch submitting
Date: Thu,  5 Dec 2024 14:22:37 -0800
Message-Id: <20241205222241.3789437-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241205222241.3789437-1-pierrick.bouvier@linaro.org>
References: <20241205222241.3789437-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/submitting-a-patch.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index 03b2ac298aa..f8b7fc59544 100644
--- a/docs/devel/submitting-a-patch.rst
+++ b/docs/devel/submitting-a-patch.rst
@@ -235,6 +235,25 @@ to another list.) ``git send-email`` (`step-by-step setup guide
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
 .. _if_you_cannot_send_patch_emails:
 
 If you cannot send patch emails
-- 
2.39.5


