Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3033FC83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 20:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucVcY-00049L-Ar; Thu, 17 Jul 2025 16:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucTpT-0000DZ-Ri
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:59:40 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucTpR-0003cI-Ki
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:59:39 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-605b9488c28so2203069a12.2
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 11:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752778775; x=1753383575; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wwCBjGg0rvzX7woBxqV7/6npQcI6/kwHBj6TfJr3YEo=;
 b=ZdsUmTDrqpOavCVE6NXtRxRVXvXvxX5t5NpqSdM1b8OM93nJHNTupoBwGY+UhbEx5R
 SOdSg+rLViTIzUKxw61yNIKVXtER/C9bzkqv4XPvZlrRO28Qqn3DAfVDJOCUjYBSan+r
 tNnRWy6UTglj8B1RG52vpUfIKH6vFf4FKA3WHNK8Z4m/GtC0eaErwELRLW2glizroJQz
 u41tj+d3wIzxZEiAeUcqcjsk0WyHPonvv7dNw3sMu8s+eGbJJ7mt/DRUwLk0durJo3kY
 L+EErTyR2JBrE0cQXveJ6KnEi5UV7J4z8etJqP3Ouz/OEV3zQY1+q102+jogirVanbDd
 wxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752778775; x=1753383575;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wwCBjGg0rvzX7woBxqV7/6npQcI6/kwHBj6TfJr3YEo=;
 b=VyZ9H7rGDSQOirmvcuBye2u1zjxPVIdyNJPyTJ09zPhsK9uf3uoWHQDVL8216mhEdF
 hr6OF8dPY9sjXBPMQmqAdoOB2CfG1nZlAtNlRr+l4r7hQUi0Duqi6uI6PxvxIbqKy0Os
 JW/138KGNtiELGFs+B0K+V2ASTbP31GMRm5QmD2sSQtYsdl7An/ZxLBzUFpPdRHLpdl4
 ys2SNQ+SqdiVSmS5VtBOk9xyJ9a+Y6rqzBuh5SszgzXabpCtORPZjX8boA/3SlK5Qg++
 OnmJRJzmx3VTBnaanT15CknPvPbe1Odk3Oj1buzpd1Bh+ExziNwZz7jKV2Mk2jrhHL/E
 7+YA==
X-Gm-Message-State: AOJu0YzDN81JveZwEDPTBgZI7ulPIQ0DB/fQMLpw0QejeXf7E6mhzW52
 cf/IReIIUjoyVMabuIqtT/3sdPoz/zgdIBnAI1KP7pVAiqozNjB5HNGxeefruVupv5U=
X-Gm-Gg: ASbGncvyEtzldtqKbZ1jLnA0GkcT9TKi0ScgrQMlnK1Hsx7+hdjBAX7/0j9exrvmW3w
 vihBMgUHLzC2xeEoB9b/WQbXFLAHRkM+80DfCyWUQHANDztGXpH97vnkt1dw//3hRzIFuLh/60p
 /XHr6LS2ViVI2qpgPZIj6BhxTxVnF9tN/xj438ipDl/2e8iRmoyqJ5iYk1TOySY7/2l5+jSD8t2
 13PLYEHXZbP/Iqj2s9SDZHPmkdnjZSyI42zzFur1klq75nvPUbQ7CWGCCm2/nuwxdm0Tvbb5A59
 DHW3/ddM82iCWYHPzFyU0xjwI+au7lPjDpJJEat7qcJU5Ll43qYZ6iYOlEykNfY4+XoIj+cWBZy
 +jeB8iCcvoqlm3eQeMn4OqVpcuDYUQYU99x3opY+W0CYsm1NQObLvLItmh6u0Hv0dmXI=
X-Google-Smtp-Source: AGHT+IFBqbbXDUCzAUNSLVIKdjylU24w6Cam/+8beaM7wfImh0+OUG1IW0bMa3tei7LELZhrM9uMoQ==
X-Received: by 2002:aa7:dcc3:0:b0:60c:3c23:2935 with SMTP id
 4fb4d7f45d1cf-61285c0c948mr5211976a12.29.1752778775436; 
 Thu, 17 Jul 2025 11:59:35 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-210-241.home.otenet.gr. [2.86.210.241])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-611c9523a75sm10551714a12.25.2025.07.17.11.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 11:59:35 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 17 Jul 2025 21:59:28 +0300
Subject: [PATCH v2] docs/devel/submitting-a-patch.rst: add b4 section
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250717-docs_add_b4_section-v2-1-69212ed39299@linaro.org>
X-B4-Tracking: v=1; b=H4sIAA9IeWgC/32NWwrDIBREtxLudy1qEiz96j5CEB/X5EKJRYO0B
 PdemwX08wwzZw7ImAgz3LsDEhbKFLcG8tKBW822ICPfGCSXI1dCMR9d1sZ7bQed0e2tz4LrFY7
 9zUpuoS1fCQO9T+s0N14p7zF9zpMiful/XxFMMOmDHYyXAbl6PGkzKV5jWmCutX4B/sCdD7cAA
 AA=
X-Change-ID: 20250717-docs_add_b4_section-fc37e538b20b
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3431;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=aJ/wLrwOs8D/j7Cwkp0R5JgbMFdFWu9mNBieQnVZ8ic=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9lVWdXampBQlhzelE1WEJERTR0STZYOUM3UlkwCmtiY0cxT1M3WFVTRmFhdXhS
 TGFKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUhsSUZnQUt
 DUkIzS2Nkd2YzNEowRGNoRUFDSUVtcW5aVjlKR1hGL3FNUUNJR0xDenJxZTJzcjdkOGRBVHdQLw
 pWS0gxTGhyL1hwTEFOekRWZUhSaU9WR2xDY2RJS1lvRHZ1RHpBVUkrOGpLVzBrUlJoWjQwVkNoS
 DQxR2JMTitJCmNTdjZnQTA0Vm53SytPL3RsL1N0bk9rYnUxNVpmenFQSzFrN05XcmltVStFKzdV
 OC96Vyttbi9WbTcrYTVHNUsKVjdJK1hzc1I5em52M3RPRlJvRzY5aXZ2MHBveHpMMXB1REhYTmt
 KcEYwZVluamtkQ0lKZkEzNHE3USttTmRGcwpMSUpBUTdjaEYrczl2MXdyWlJGR0Z2NXp5dmt4MT
 VjT3loWnZQeWNkSklDWEJMWWdLeUkvY1BTZnhsMlZ0U3dYCkJQbTBxNlQ5OUdpbnlzd0U5djVwS
 lFqQkM3S1Z4dFdNQVJJQWNTZ2JLckJBc2FCYzJ3TmRzLzdGUUdQNVVSZkEKcWNwTTVQN1IxYzg0
 RlluZjNaVVVOaklURkxFU1hHVmw4YzhQUnAzR3dVZlNpNlduOTRGRkFCcEFMdk55dHVWYwpSbGV
 Kb0FPUW5ZN3NDUlRWRzFvVlcyL0pENFZ3dmxxWlhndFpPdFd2ZysvUFJkSHZTZGJjS2ozNjlENV
 pIUi9kCmdtNk5abHBGWmorZEs1T21lYlJjMmFQKzBNRnMrM1AvMGhVQXl5L2YrV05ObGxra1dud
 kR3WnBRd1UwSU9WdkgKbGNjVEhDSzlFdEpFbzB3a1dzUWpIbFNvR05tREl3cUZVaXBxQkRjWWpK
 NnBzaU1Tbm0rUnMzM0RMMlM2TG1PNwp4eWJSa096TnBBdjM2Rk9sSUpHTUxnd2llU1RHdi9ELzQ
 5aE9EcWlucmdpVUxDbTEzM082SUtXa2dKQ01TUGo1CmhYMDJDUT09Cj11Z1JNCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x536.google.com
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

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Changes in v2:
- s/later/letter and add review trailers (thanks Gustavo)
- Link to v1: https://lore.kernel.org/qemu-devel/20250717-docs_add_b4_section-v1-1-2dfb4ad2fe07@linaro.org
---
 docs/devel/submitting-a-patch.rst | 40 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index f7917b899f6892ef74908fe8f1399b6ae5a30324..dd1cf32ad35a98528f43918eceb2cc8a4847c5b6 100644
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
 

---
base-commit: f96b157ebb93f94cd56ebbc99bc20982b8fd86ef
change-id: 20250717-docs_add_b4_section-fc37e538b20b

--
γαῖα πυρί μιχθήτω


