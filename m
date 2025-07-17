Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CE8C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 15:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucR08-0005Aw-07; Thu, 17 Jul 2025 11:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucP3V-0008Dh-Mf
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 09:53:51 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucP3T-0007vO-Dd
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 09:53:49 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a4ef2c2ef3so709795f8f.2
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 06:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752760425; x=1753365225; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LzewdzpqFpfBQFP61xJOpJ3PUU3dzgjBbzbtY/UpeNQ=;
 b=GN3ts574DtjnhuHShSmt2vuuVAg+vaXlKGRLgGBd0shcY31c1g0wfqeq9nw71sDz9d
 rDh41f/gqPo06fDn033cuVT13Em8uKQe+B84VJiP1jDk4oyrU1vLegPiZXfR7TSz4ENo
 cVWg+nHtSNqRueJBXnQLMbuUROeNfhBRxhrUpHW+YsHregx+IYbv5uE7gajLPddq4l+8
 ZBibpD4r1sMDNeHahEjsvOsu0GQo+t+Isqc6gY5SYobb/A4QDDghCLJ7HX4raADXxNT5
 jbQeBt4G/DbnvBRvbTAUF7aJTtwma9WUZdYWNh1F+3Xrbyf1jqJL+5kB1al65d3CJvcn
 BaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752760425; x=1753365225;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LzewdzpqFpfBQFP61xJOpJ3PUU3dzgjBbzbtY/UpeNQ=;
 b=Z3TnPXXAfHPO1+wcabSCaGz7S3Tx3Q3p9JjpNNzB+MfvjAoy4iOI1YyjhyVK9WYfbl
 QR7828A1zIfBLEP35cRrkuVK2c5v9jdgHlvynVQbPGcz68goSqqUplYVLHKYAz4PLqwf
 r4wqm/KWDVjajDacdLSzqokn7FLcJkKofFW6pMuh9EDy5NO+JvlsFTHz0mWR4Z+j/n9p
 IkpU3Kui8q+9URzEedZgHozq99KsLBfZMXrhJSUlovMc/IIYAXIwlzioXn/C0lLw4/u7
 20EzIECgDJiAkYjY+s2i34HoGDlgKKPd7f6aJZz9gIy6Rt3Rb1MTG8fMvGT3PYJkqV6r
 q6uA==
X-Gm-Message-State: AOJu0YzdtXiF4T5ZL2YzpFLpkvJBctt/AJiYWNYoJSLSjRQv5v4dnKd9
 mImwRJ/advr/wSIEq2ncf9S1QU8VtYgUmXpfssI6ReLAJwaJF5nzXOehhWtC36zdDik=
X-Gm-Gg: ASbGncvyV6pkKLTsc68jGcYySnFWc7FXa8VaC3ca46dXXTrkPh2NP7wc7abVkTFAZvq
 XYx7TjO9i/bD8q2XphOoKdDDewwgmkJdeP781PF9cTh22bUtuQqnTVbeM6rsKMg+P8xSOCXGhLT
 zrgxawZAD75zhIPmTxTlCxo/Jmqa/pZOi91B1BykWqSRV9UBdX+PK7B5gBRYy4U00PFFZEgB3B0
 KkghuBKI9LLNaOPhA/4tXs6ixIvA29UGeq2pVsUE+j5c9CAZuTKTDQx2hAOu3JFY7JCJLJeW0FN
 CPuVBRb+cE6ii29bipNVoaE5ZLLN/ocCZiPzpbxaukMNPODxAd3ePERTpq+2OSGVuS3ND5ehjGz
 dVx3m53lHpii8ba8HC6Fc1b1/iaAiSlVDdN5fC74u64Eof6EW3Co7gyrXClhzGzPh7YI=
X-Google-Smtp-Source: AGHT+IEy2BgBThwLrChUFAaKffrjhpxBNgkuq+HcNFmQnSCdDCapBoLkHUMWMiyaxk6XajKNC+o2/g==
X-Received: by 2002:a05:6000:2c08:b0:3a4:fbd9:58e6 with SMTP id
 ffacd0b85a97d-3b60e517ff8mr5494862f8f.50.1752760424853; 
 Thu, 17 Jul 2025 06:53:44 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-210-241.home.otenet.gr. [2.86.210.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e26c8bsm20689626f8f.88.2025.07.17.06.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 06:53:44 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 17 Jul 2025 16:53:34 +0300
Subject: [PATCH] docs/devel/submitting-a-patch.rst: add b4 section
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250717-docs_add_b4_section-v1-1-2dfb4ad2fe07@linaro.org>
X-B4-Tracking: v=1; b=H4sIAF0AeWgC/x2MQQqAIBAAvyJ7TlArjL4SIalb7SXDjQjCvycdB
 2bmBcZMyDCKFzLexJSOCroREPbl2FBSrAxGmV5ZbWVMgd0So/OdYwxX9eUaWot9O3ijPNTyzLj
 S81+nuZQPW0404mUAAAA=
X-Change-ID: 20250717-docs_add_b4_section-fc37e538b20b
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3185;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=3fnyCgGwZpizbPQzQHbsKnJJNzB4xKSky6cAYbnB21E=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9lUUJuVHJxSnVKdFM0cGxaaEd3ekxPZHdhQkEvCkZXUDZKSDVPaFZQTXNUakIx
 dzZKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUhrQVp3QUt
 DUkIzS2Nkd2YzNEowUFZ4RC8wU3ZYTDdmQnBPdmFLdFBQYVNJTkIvb3U5SmgybWR4ZVVJN2EvNQ
 pHb3MxSkl4TkN6Vy8valliMDBlVHU5alhxU3ZIRGR1em4xTE5UbHJob1AvVGN1ajRjTUJrUFhGS
 i9DU2srZmYrClIyb3JTc0tLMGlWTlBsQUFWNzc4Y0JJQytFakhJS3ROcVBwR1A2d01IQkkzVnZL
 c1FsbHBDL3B3T1ExbkEweEgKemlVQitHVDN4bjJlbloyQnNHZFNqMXA1SGxTemx3NzJZelNtWHR
 JTU5tdU1LeDduWWI5blJiUXc3cnIvNExSRQpBc0RtN3A1RkFMRTZZUTNETUdld3pmNTR2TlhLY0
 hoajh5aktQMmlyK0Z2Y20yQjErSGc3aVdBTHhyaEVMVGUxCnJYclJabTFOQ0tzNTIzSUFOcWFKQ
 3dVUm13NGVmdVZCOCtMT29CNXFEdDNGMWIvdWRHNVNjdk56NFdWRjQwS20KaUFRbkdRQ2ltaGpo
 N2FXbWM4K3JZWDkrTU5FYTZTWFR0ODlJb0lXVGVwbnRDWVk1TEFwZ1ZDQlAwbVJrNkZiNgp3K3h
 mUWFkMklrWkZFQ2xqdjFBRlBxK2RZZUNMdlRTeHFsRkJiQzhucERRMkMybVNDSGFsM2VpUDdsU2
 pYUTZJCmUzQjhaeE9RSm9IaXJ1OUZWOVFqN2xqUGgvS2FCUVViaWdPTG11QUs5bnpZbDJaMDlGT
 DJUaHFJa0ZUWVNldkcKckR0UFlpSkEzNHFvNUpYd1FLaW5uUkxmcTRHQ1dSclJieXZKWWlEeEEx
 QmhRZFNlUUpKR1ppWExPWkFoVGF4TwoyTlBJcXZQVElvN1d6Sk4rNFJ6c3F1QUU5S2NmVWVWb1p
 wQlhTNmtQci96ZTh5NkNHRGxocDNUV0JaTUU1clNsCkFwaHBDdz09Cj1mRHJJCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42c.google.com
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

Add a section about b4, an actively maintained and widely packaged CLI
tool for contributing to patch-based development projects.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 docs/devel/submitting-a-patch.rst | 40 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index f7917b899f6892ef74908fe8f1399b6ae5a30324..5160813ca8cf12c0547b88586059487d1e90fe18 100644
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
+4. Write a descriptive cover later with ``b4 prep --edit-cover``.
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
 

---
base-commit: f96b157ebb93f94cd56ebbc99bc20982b8fd86ef
change-id: 20250717-docs_add_b4_section-fc37e538b20b

--
γαῖα πυρί μιχθήτω


