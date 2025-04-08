Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A3DC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 20:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2FLc-00029p-Qd; Tue, 08 Apr 2025 16:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.granados@kernel.org>)
 id 1u2FLa-00029f-Gw
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 16:15:02 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.granados@kernel.org>)
 id 1u2FLW-0004yB-CE
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 16:15:02 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3C17D614BB;
 Tue,  8 Apr 2025 20:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E87B4C4CEE9;
 Tue,  8 Apr 2025 20:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744143293;
 bh=jDZDxLJWDYW927mYZ8/+pBOhs25t9wQSY97XH11aeAA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Ls3e1SlEcfiwY+v0N7cOA7J0Fa2qYrqrok0PaNyBh8ib/yEce1NcePptmZ1pgFY+L
 HG/pIIHrSgLDl4WGU130xQhIjpgu3ipli5vE0idnXcNS4I3P9nSxDFhVuS0wR73IeT
 gsjCwLVgD+NHQskxw2TqWQy0I0V0B2vSgzmDqXbsbk+vDmNRa0/pDAG+FUBt0krjbN
 s384Ys1048Tt9gK9IsCZWBJ/oJnTY35eVrCnyKgEPZGhqsVcpVTwBLxDLLfgVjZG+F
 FtnwvHARZXMODKfjvfTwVfbdNQ79YiF8u0PE0IZMU1SVNOiAvE0boqyEX7Mq6jhixq
 Ddc9NyVCyZFHw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id CB9ECC369A1;
 Tue,  8 Apr 2025 20:14:53 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Tue, 08 Apr 2025 22:14:46 +0200
Subject: [PATCH 1/3] scripts: nixify archive-source.sh
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-jag-sysctl-v1-1-3f4f38b751be@kernel.org>
References: <20250408-jag-sysctl-v1-0-3f4f38b751be@kernel.org>
In-Reply-To: <20250408-jag-sysctl-v1-0-3f4f38b751be@kernel.org>
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc: qemu-devel@nongnu.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=650;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=jDZDxLJWDYW927mYZ8/+pBOhs25t9wQSY97XH11aeAA=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGf1g7rJbMQQkzbdZqLcZJzh0WcwjGuMQApmR
 33bK9Y0z2YQv4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJn9YO6AAoJELqXzVK3
 lkFPlu8L/i9v4XmyqdS1lNI3HCDOjistZIit3XDMeA+Ovd83zSGGEk+kUjK4JitVQbg0Nk/3f+t
 y3zydEuvQ5+9PAOmLbBklYA5tyJUNZzdJYTXLXtE3e9iJz00yo/mQPHp11YzwMWX40Mw7N4ZVvx
 dzzQtmq0CY0eNDT3y67Jvo0wgX+Wpw23u6lUnqnIzo5+WkLmgn8dpr00G1FVq/7dpdfgjuwzCmJ
 xQaTeS/eu9q0wcpWRLPrikkWZXFrPFtZrB/L1aJV9Al87qFhO/jfst42PHjtzsczfr7QUX7G9G1
 JWD29hg2F3rlfTwfThN3kp1kyUFiqRt2bTK8I3H8hkeiUyRAHdZxkGruVJ376QgvL5flgf2iEdz
 R2j1+Pe5EwMogmkIsSlmKo1k7Mj6BEdSQxXWUlWJch27XagCbX5Vpg5teS7GRpL4RbxIh/c4r4n
 1y2oybLqA4HSp8on0r4Pi9SnQsQ9ycId9RgQSF/6YQJwtUG4HnFWIFtygbQkULJZe1cn9uZsuq6
 sI=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=joel.granados@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use "#!/usr/bin/env bash" instead of "#!/bin/bash". This is necessary
for nix environments as they only provide /usr/bin/env at the standard
location.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 scripts/archive-source.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 30677c3ec9032ea01090f74602d839d1c571d012..a469a5e2dec4b05e51474f0a1af190c1ccf23c7e 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 #
 # Author: Fam Zheng <famz@redhat.com>
 #

-- 
2.44.1



