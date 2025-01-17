Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C0EC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmm7-0002Xg-AM; Fri, 17 Jan 2025 08:52:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmlv-0002Uq-Lr
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:52:29 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmlr-0003kf-Bp
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:52:27 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aaf57c2e0beso433348266b.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121937; x=1737726737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ryjDq6SVbM3rFJynOdzdzyOyu6l/v62KzXYJQB4a/Jc=;
 b=nOipSmuNGruHMzjrAW3L1DjxFQRGZpLDnZG1XX4h6xmPErNfcihZz+JzuZB2Dy8U44
 bX2aNgMBaJ4iGaVSOiMxS16PnL8JlWmA7BsvqzF0ttwwvWKA9A7iG7M1y6ofpaQQd0qk
 9PolqW7f8X4hESvhjouhidD3CUJEHkK+btXW6zvi6Sx4UgBVd21tj+lzzIZELdSV+lNh
 Oi3iiID0rGg/IiFJXOsuLqeF3C0qXa3EUaeG0QCUA3LSU6Yi6WK3fDC4siFAxUodBM3E
 pjWm8FdNAmnalDKE9xLNrb47JCiKiOBchrGdXUmraUQ8EcFP+vTcVLr7UR3rL1l2QLIx
 Lm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121937; x=1737726737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ryjDq6SVbM3rFJynOdzdzyOyu6l/v62KzXYJQB4a/Jc=;
 b=n6nTD0ZPhRavHxGCVFVkX0rQ3hq0KUWN1i2uaJG88D1GhdP8pU9YPdLYMwvOaP8rv8
 nKrrMeR6EJq6cKzII9QARGopth40jnoF4ThkQrttDJtvK9UwR7VcgIlqoYHQUzCUOCp+
 16a+1HHyAOIvoaT/JM/2K0STiwA5RxvJMXhmGgdN1PMYfrzusMFQkFakL3s0g15CX9kk
 mXO8pGd74G1AzDqHG7icWvBI90LW5ht+YtexSRvUGjW4HyyE1HaNVFAIKnRYCO4Nhn0M
 KVKExZ4F108JMX2DSwi6/e732FWYoe5ZPQIV4U0v5Ramg7D40s4/u/LB2pFHBT4/8mj4
 sO4w==
X-Gm-Message-State: AOJu0YxIpzuZjDwrrdfCuKKmSbV3svXsJhVU57Ynom+4+MQk4HMKDQ9/
 i+PIU4Qm/OR+chyuVHjBQepeCxmHeyZTAam+Bh7I/KXDGECfuqIfSmBopYTkwU0=
X-Gm-Gg: ASbGncv3vnzxOYSHGoOhZgMmukaskklVddbFwwVo47nMqz4lQ1JXu4FbfQx84j7l23u
 ObHzWfXQzIbT0tDA/naf5SH7fpTmwqxwlQJ4i7ByF+lc8o6EsBjmK6WlbXADUPcsG0PlF4AgCdX
 uEUl8Hkf3GmUYb1D44biQ4+/zm8SU8zQnyhDZQppNxEGyYDSuVKG7DEjNYW8uqc85ZJ++w/fGiL
 vjebQRXFgk/c4z7o/Jgs6qlO5wE0OVG8LdjKs3SsRoeRA22dUvhDoc=
X-Google-Smtp-Source: AGHT+IHsd+PcqI9MeXCO5b5vAfss7QvLlIiAUHz+LDZYrsB+pFJYLV32MqWLnVwLr8Upss5cWL059Q==
X-Received: by 2002:a17:907:2cc2:b0:aab:e07c:78b7 with SMTP id
 a640c23a62f3a-ab38b27a5dcmr267547566b.23.1737121937122; 
 Fri, 17 Jan 2025 05:52:17 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384fcec76sm170997366b.184.2025.01.17.05.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:52:16 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F0FCD608E6;
 Fri, 17 Jan 2025 13:42:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 32/37] docs/devel: add git-publish for patch submitting
Date: Fri, 17 Jan 2025 13:42:51 +0000
Message-Id: <20250117134256.2079356-33-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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
Message-Id: <20250116160306.1709518-33-alex.bennee@linaro.org>

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


