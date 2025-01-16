Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C1CC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSU9-0003l1-00; Thu, 16 Jan 2025 11:12:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTf-0003Gt-Jm
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:15 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTc-0004RN-2b
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:14 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3862b40a6e0so686914f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043930; x=1737648730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E36UvEspsa4mA6pTf+HFiwfFj5ukjbDFpFJX/Z8z6wQ=;
 b=kHS8rKRz5YSXwuv4zaMFKCjtxWCWUVWAs0vfmKTwEGd7NHRnb1e38EcDDudOYHK0XI
 keRbdHMkx5MkwvpfteUz4pxJI3tyUJfFymBZcdFwesc+xsy/T0vGdBo5Y6jr7+6/KHyS
 LDvNyZR6b+kIpAfXG322U664xqgzMM2iQFCbNjvhP+sn3IKQb1CGG/+4ICpcbHipNe9u
 NX01LM0DYYvWV3HiGH07ZTeXRz0NAX7rFu1PmejPFMsvb8x68M3fxxJyxLckJ0XzO2pH
 72eKuOdRIxYUq1FT7wtaHnRy+rUWyyev7EAPVq/obVVGnuqPCg/Xe/kI0v9TaddkrGqf
 RSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043930; x=1737648730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E36UvEspsa4mA6pTf+HFiwfFj5ukjbDFpFJX/Z8z6wQ=;
 b=rOQx4qh4Eqak+3Vg5XGlKfInD+6lvW/qf60GXFAsuCJf61mChukrzueDVBFo7BL2jy
 HTTlNp+1/2WAZlCt6dIhvxWtow3oktQrd58HqxMJjcDlPq/AHF59SMZ4FfDrtBXnWCfC
 SIAoRtvWFraKOJ9MYnOTxO0Gel1bIBHeXvRtfXB8GCi7zk7QL1iUDpEv8vxpd575M1U0
 BLvbowoMXAljbwZhx6Sc5cLyKh43nNp1+aKfUtiJT6ciCyzbpWfxwBuE5sBZwJZ4EvKP
 X4+Krw8ksmC7Dkm14s6Sw0hpJy7J33cQiMUAZ+WftIPpY08UxmDmaMGmD2wj5qFuX8fc
 /wOw==
X-Gm-Message-State: AOJu0YzuvC4KTm21r7MJLSNOKmVN91//Jl6eVumQQY8paJLWzaSCLkYv
 gxSQOF6PFWgKK9q/iK4pwRfGEB6xYaxZo1DIiGPGM9btlwfzCSUUjKeCjduUs/g=
X-Gm-Gg: ASbGnctXEqME5EzK7FojITyKekwIPGlDz6oqN+DIgiaUQT21QqOOZGhH4XI8Veexkv8
 6cQuMgP7eIklNZpQJ0VRmq1yPsrqs9IrCQAWsoZWVlVrfgm6tuobljGUke35Ul9Q7NkIXnmopnP
 vN6NDVaQ4tnFzVD9aVQPLMiKOnO3PkuchijGnnehXt5uzfBkdFYOp6bIdi699GEBuBB6iZD/2m/
 D08uq/8CVUwKocZjulbAHpiYQXu1Rxdwr0gsZyECM5KZdSS6aHFWtU=
X-Google-Smtp-Source: AGHT+IH3vaU+v6dN/JMm52Exyu46TgukewzGeHzgNp80kwA6ceGEi95555Fd0S0Sx7+b+07jAsA2Eg==
X-Received: by 2002:a05:6000:1869:b0:38a:8b2c:53ad with SMTP id
 ffacd0b85a97d-38a8b2c5601mr32435195f8f.39.1737043929874; 
 Thu, 16 Jan 2025 08:12:09 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf328847esm215843f8f.98.2025.01.16.08.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:12:09 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 984F3608E4;
 Thu, 16 Jan 2025 16:03:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 32/37] docs/devel: add git-publish for patch submitting
Date: Thu, 16 Jan 2025 16:03:01 +0000
Message-Id: <20250116160306.1709518-33-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241209183104.365796-3-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/submitting-a-patch.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index 03b2ac298a..69df7682c5 100644
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


