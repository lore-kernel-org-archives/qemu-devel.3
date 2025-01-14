Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31BBC02184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfO1-0004Ls-Gf; Tue, 14 Jan 2025 06:47:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfNp-0004KY-Cl
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:46:58 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfNn-0006eC-C0
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:46:57 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso38362725e9.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736855214; x=1737460014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E36UvEspsa4mA6pTf+HFiwfFj5ukjbDFpFJX/Z8z6wQ=;
 b=RXyXKs29vn7XmlNwu70R7mfWR/vdkzTiX9zl9PtrF5xBHnkIBFVW5Bh27qFhmZ9Ive
 plnCqQO1nmbtCIDnjqyt0+0tuKhzkdVOz/eSt+yF7kwJMjKDSdcJNUNXD4cATpdP9tjl
 6vb6BSaUQWiIOE+3SuLyFyCLamKwKsKt/esNHcUQ8EKQQPxbUTLIEyzRBsl33FmHRZUt
 V9BO6LSHddARvRqFPno0FncYhSx2944Wp0nRAS3v1lz07qJ8pvg6G++acP9w1vPAX2zQ
 ODJfo4WzsTRkECYdvDac3jtf2YnDWxPq0OO6IbHqS1vvrqrJ27mur+lRyUZqZJHyJC0/
 ZIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736855214; x=1737460014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E36UvEspsa4mA6pTf+HFiwfFj5ukjbDFpFJX/Z8z6wQ=;
 b=E2q/pyKcFagFuHo6WEz10e7u9nPaCmYTwjsM5tpSR5YKNxbERvffWPAvs0VgMP7HIV
 EldOIsqdduKaDW4pIUsixG+OoWBpqGD/4O4Ow7B+1mJXglubLy9bpzm8vIR2HRAiurFs
 7Qpc4Tk8BrmYNwGS8h5UEwjW/UCIBvzeyGd5KpjayliPQVc/Af+mwRjmIEFAS71FKuqL
 CZCIEEIQEipWWie0i4OWrDuBBeVGfFEd1wtibdFFt1ZFaSTK7v+U+qAw5msXaUBIZ7dB
 AU28xxoP96mGmyhOr9HoqkZBTFGtUoRIRIPL+Wo2fo31rkVcUt/SEo/wMZSMB4ia2dvl
 Zxng==
X-Gm-Message-State: AOJu0YxpvFw4qf20Kt9inV3hFzrEA6eVRFnV4NjOPbQdqkEqH/B/vhZT
 luePDgKFh7QbrbGyTndRC2bNcwZEiVcObfbUXKXXisk9NZChhE5diJ7tH9u/E1c=
X-Gm-Gg: ASbGncugB6DGHu9hzn9luXs+sr5NwjDTipgLuZiFdMnlCDMznmm5d1H5HkPdWO/UlMV
 R5Df6NNmfjyN9hAopwG0oYOGm+T+mvkZmbejlqJvpN0N4aWtDQqBhap4LLxJW9f31cNi3byry/k
 6ir7hmRC4GL5DFBt5IsJYiAV3cU9WUG9GjKhA8Xx11z9Jdm53ACfWJocxiIwEuOwC880upG1fmR
 DEUVQOpegsXvHS5IpTwuzFVvyEn23ZbYwY4EAn6cgFGaY2ZDRwi0YM=
X-Google-Smtp-Source: AGHT+IFr7EzaV4CWWFx0LE0WKXeeliasgiUOgkIt/xIxRudTbwaqQ8bgs5LlaUAWPHV9yBNVOCcqiw==
X-Received: by 2002:a05:6000:18a8:b0:388:c790:1dff with SMTP id
 ffacd0b85a97d-38a8733fd71mr20588495f8f.47.1736855213952; 
 Tue, 14 Jan 2025 03:46:53 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37e36asm14303670f8f.5.2025.01.14.03.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:46:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CBF985FC92;
 Tue, 14 Jan 2025 11:38:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 32/37] docs/devel: add git-publish for patch submitting
Date: Tue, 14 Jan 2025 11:38:16 +0000
Message-Id: <20250114113821.768750-33-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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


