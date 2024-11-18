Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F412D591A9
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 17:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD5UR-0008TY-KI; Mon, 18 Nov 2024 12:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tD5U5-0008NB-RQ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:24:24 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tD5U2-0002oY-Gy
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:24:21 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20c714cd9c8so18860345ad.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 09:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731950656; x=1732555456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QaxpMkzADG4IGRoaMKuDLbk1XxCkXT1oglYVymp2yRk=;
 b=Mq6U8nG3SIweCq2IKbeoEcsYU5/DftrTO6hPPADcZRArwhKp03HY0BFe73OkppFsO5
 nq6X6QRjdio4/vBAlzMLeRhDzcCJd8NgA9DOqrN6weKMsiil+SbV7Xb8W3+mk828WtLH
 CFiHXqWnxY8bkn23+XQgmrQK1fr+lENkBYXYIgP7k/BM7+zwgmY528QpkH62S3jF/oIy
 wlbMBnPo6WmnmHmxYA6JPppNopwmdnrYt7tRG8ATF6INMz7I80AZr1EJKEJtF4ncttX+
 bZ+icm0gXYZLBHvmTE50ZIjnL7E3IKKIX/vS4vmxnkiaV4aEkmooBZ2MKLz87ckoYdVZ
 aJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731950656; x=1732555456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QaxpMkzADG4IGRoaMKuDLbk1XxCkXT1oglYVymp2yRk=;
 b=AkDdJ0ehjyLP7fh3HzPEfg6KHyZ8SBxZ3617zi2vrqXNo7W393Jn8NCEW8Id8gwopd
 j/IS7DpyLjY6WD4If7cxj56mwMza/v1Gh4cK/UGTP9TiqdGt05Nq3sCuFzyJFpUXLlPA
 obE0OYBOl1ee0c+yb7bf3b706x5U7KwPVZyKhLYDAEFdtFSG8q7Ft2SKBPVujoAbJNg2
 b4LGAtNoB2AqzTpWF+60eMWPFsmWX4XMhI/HV6wiR66fqdpXjRx8CZS7Qay7alTmiPA8
 deWtY3KO5Y5wiKKK6CTog10Pcl0YgA1urDzLjED3whd9q9CL1ctKAL+Afrj6ZSgvzDf1
 uUxQ==
X-Gm-Message-State: AOJu0YyUFcuCdAPA8NH/289yt66LURL26GKS9iVV591dEAAj60+8ZdBk
 aLLoK+5g8+SkNgdvfq9cynVKkmUwwmk0B422JPn/y/M4vxUjNhKR5Lqffy28jHBJOPv7NUL5dTj
 Lmef6tw==
X-Google-Smtp-Source: AGHT+IFnMWEzRgiYq/B3mYM/U/z+PUqF1APKbd5/ZA8bwDsu0j2FORNnIWlcrwKq/X5tQE+U6piRrg==
X-Received: by 2002:a17:902:d508:b0:20c:5c13:732e with SMTP id
 d9443c01a7336-211d0ebf9ffmr195717105ad.38.1731950656051; 
 Mon, 18 Nov 2024 09:24:16 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211d0f55d04sm59469765ad.264.2024.11.18.09.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 09:24:15 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Melnychenko <andrew@daynix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>,
 alex.bennee@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 manos.pitsidianakis@linaro.org, qemu-block@nongnu.org,
 Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 gustavo.romero@linaro.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 2/7] docs/devel: add git-publish for patch submitting
Date: Mon, 18 Nov 2024 09:23:52 -0800
Message-Id: <20241118172357.475281-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
References: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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
 docs/devel/submitting-a-patch.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index 349c32ee3a9..953682f20cb 100644
--- a/docs/devel/submitting-a-patch.rst
+++ b/docs/devel/submitting-a-patch.rst
@@ -237,6 +237,20 @@ attachments can be used as a last resort on a first-time submission.
 
 .. _if_you_cannot_send_patch_emails:
 
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
 If you cannot send patch emails
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.39.5


