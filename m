Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD214C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 17:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiyX5-0001zV-KC; Mon, 04 Aug 2025 12:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uiwup-0000hp-Lg
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 11:15:55 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uiwul-0000Zv-JS
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 11:15:54 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-459d40d16bdso9707765e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 08:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754320550; x=1754925350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E+Wh1VP6DOxrn+VlvqLuE2O5pLk0j4qlYRsPTraobhg=;
 b=UzWMTinQF1vv2//eO3kgA40nWwVzq/mxnDDwtTCMQiASF3xjJx6JfQXir16xiWt29x
 uKog57vH4nNHuWqXMAuDROOCuFXdozdpzdO/w/Rwjzw7KvOOgO07Z1NYIzECveAs000V
 WfjOUIWT4k4VLMucakC2boowfvj3aWQyKU56VRICAtaYTlb4OWyIlIxSfwtOtuIwSvsx
 doz9AjU70fQCb028KeTRefbekzzfbqLjj/FSUAib8ZqT5IqMyTEAdiJ5D7wjmQwa7u6/
 b7197Yxy02thCPU/gVe6DekC7Gugup4DegttfUCBvIFGM+aaKQnCONCpECY9eX7RPBEa
 ue9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754320550; x=1754925350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E+Wh1VP6DOxrn+VlvqLuE2O5pLk0j4qlYRsPTraobhg=;
 b=YuVP0e5EEUAIxToRMgIKdHmnHgp7TpWj9vwIR+/6pfmZu8KH2LQp57rf4ccVw+zRw+
 CGVK0qQJWatxqJCt5+vktqcxmgo0hovjWbXXTFrtgdGEWjDZVaEe8vYoqnNrTgjwm3iS
 OCKeXwLgAAeYm9BBgMTmj/QxfVt1COhLI9VdfCbTYz7UvE+2t8OJlzTif8b5EsR9gddN
 6OKyt+YmKoMVZHtGJ0o7cA1422jnisRA5Q7/0SDeY2T2CRp35znuZDJn1ulqFIHF8OAp
 70baoh3SlkXZwlwvfcnQade80uDpQCfQYQ2lN5QxO/F0YfchVqwF9uY0dKoVRaRlRQ6O
 6RIQ==
X-Gm-Message-State: AOJu0Yx1iUZSqjE2kJbxl7cMOE2yHns1yz3wmm2oNZFzKr5Do0LeMVFR
 RZyih2QB8+PVZYYBK8cP5dn5vXYE8zS/+GpVEEfrZBULuM+/OCijcRZuJt7LCnh29P8=
X-Gm-Gg: ASbGncu+Ap39ugvEjzckOhLp9CGxijw7I/QPpRY0AMnPJ3ypcw7jeRIlZSIYYVmZ5Js
 TuzmkxxGSmoqKNrXuJClpyyT7NAeBK4Euv2iTW+AjuEzkVvFGxpJhGSgW3qxmvCbhAP+WwwMehF
 oGia+t0NFd9//RDdzJGW7JmmQZQCDE/kBs0Y965V4BnIUTz49v0sxVYUsBZ88woW5wB+jsQDPir
 j4uTLm0rHbTN9Zk4Z1eB9dLDv8gsk8fVdIVSMgtkjNchAiz9ji33vLyPA7ZplOF1jDhXDCPeu36
 X2gMGspdM6K7GGFOI74Zcb1bG2wvPE8bQE/N6HoipFn+7ZS/F1Ts9KKq64LAgJ9RqPzeEAepAQQ
 Bm7IbIcqLWCMxxtET3bRGh9E=
X-Google-Smtp-Source: AGHT+IGoxwLPYZYAX4bPbMYhrbjYfSngR483Ks3jO4CteVFsUqxuivuPHxUip/X0DACqR5JYn7M99w==
X-Received: by 2002:a05:600c:4f14:b0:458:bdd1:b7ef with SMTP id
 5b1f17b1804b1-458bdd1b9a3mr64003455e9.19.1754320549948; 
 Mon, 04 Aug 2025 08:15:49 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4a2f03sm15670698f8f.72.2025.08.04.08.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 08:15:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 26BEA5F88D;
 Mon, 04 Aug 2025 16:15:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/3] docs/devel/submitting-a-patch.rst: add b4 section
Date: Mon,  4 Aug 2025 16:15:43 +0100
Message-ID: <20250804151545.311042-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804151545.311042-1-alex.bennee@linaro.org>
References: <20250804151545.311042-1-alex.bennee@linaro.org>
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Add a section about b4, an actively maintained and widely packaged CLI
tool for contributing to patch-based development projects.

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20250717-docs_add_b4_section-v2-1-69212ed39299@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index f7917b899f6..dd1cf32ad35 100644
--- a/docs/devel/submitting-a-patch.rst
+++ b/docs/devel/submitting-a-patch.rst
@@ -235,6 +235,38 @@ to another list.) ``git send-email`` (`step-by-step setup guide
 works best for delivering the patch without mangling it, but
 attachments can be used as a last resort on a first-time submission.
 
+.. _use_b4:
+
+Use B4
+~~~~~~
+
+The `b4`_ tool, used for Linux kernel development, can also be used for QEMU
+development. It is packaged in most distros and PyPi. The QEMU source tree
+includes a ``b4`` project configuration file at the root: ``.b4-config``.
+
+Example workflow to prepare a patch series:
+
+1. Start with a clean checkout of the ``master`` branch.
+2. Create a new series with a topical branch name using ``b4 prep -n descriptive-name``.
+   ``b4`` will create a ``b4/descriptive-name`` branch and switch to it.
+3. Commit your changes, following this page's guidelines about proper commit messages etc.
+4. Write a descriptive cover letter with ``b4 prep --edit-cover``.
+5. Add maintainer and reviewer CCs with ``b4 prep --auto-to-cc``. You can make
+   changes to Cc: and To: recipients by editing the cover letter.
+6. Run patch checks with ``b4 prep --check``.
+7. Optionally review the patches with ``b4 send --dry-run`` which will print the
+   raw patches in standard output.
+
+To send the patches, you can:
+
+- Setup ``git-send-email`` and use ``b4 send``, or
+- Export the patches to files using ``b4 send -o OUTPUT_DIR`` and send them manually.
+
+For more details, consult the `b4 documentation`_.
+
+.. _b4 documentation: https://b4.docs.kernel.org/
+.. _b4: https://github.com/mricon/b4/
+
 .. _use_git_publish:
 
 Use git-publish
@@ -418,7 +450,7 @@ Retrieve an existing series
 ---------------------------
 
 If you want to apply an existing series on top of your tree, you can simply use
-`b4 <https://github.com/mricon/b4>`__.
+`b4`_.
 
 ::
 
@@ -533,7 +565,11 @@ summary belongs. The `git-publish
 <https://github.com/stefanha/git-publish>`__ script can help with
 tracking a good summary across versions. Also, the `git-backport-diff
 <https://github.com/codyprime/git-scripts>`__ script can help focus
-reviewers on what changed between revisions.
+reviewers on what changed between revisions. The ``b4`` tool automatically
+generates a version history section in the cover letter, including links to the
+previous versions on `Lore`_.
+
+.. _Lore: https://lore.kernel.org/
 
 .. _tips_and_tricks:
 
-- 
2.47.2


