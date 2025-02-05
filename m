Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B522C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 09:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfbKD-0006EI-N3; Wed, 05 Feb 2025 04:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=dc2d=U4=miszr.win=git@fe-bounces.miszr.win>)
 id 1tfbK9-0006DP-W8
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 04:03:58 -0500
Received: from smtp.forwardemail.net ([149.28.215.223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <SRS0=dc2d=U4=miszr.win=git@fe-bounces.miszr.win>)
 id 1tfbK8-0002iX-A1
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 04:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=miszr.win;
 h=Content-Transfer-Encoding: MIME-Version: Content-Type: Message-ID: Date:
 Subject: Cc: To: From; q=dns/txt; s=fe-257304d8b2; t=1738746235;
 bh=3w2VIAIREy/+WO6ZjyNNwHywKxbLZtSmN5GkmYfi9Hs=;
 b=FkrU11ppYdvpg0lhcDLjTX16etbAyzx4bAoKQbodJsJSnuKQP/NQY/tCA2Cwsm+khg5WhO4nY
 OyxL5t0HQ4dMgaVQp94+5hfEg1iZ/mcQYkn1WqeuKathZsxCJmOfldE+KLbz4Aiw6D7fy1+JEHy
 jAJE5pbw3CGM5ENTKg0b9sA=
X-Forward-Email-ID: 67a32975f2c6eba60196806f
X-Forward-Email-Sender: rfc822; git@miszr.win, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Mikael Szreder <git@miszr.win>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Mikael Szreder <git@miszr.win>
Subject: [PATCH v2 0/2] target/sparc: Fix register selection for all F*TOx and
 FxTO* instructions
Date: Wed,  5 Feb 2025 10:03:31 +0100
Message-ID: <20250205090333.19626-1-git@miszr.win>
X-Mailer: git-send-email 2.48.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=149.28.215.223;
 envelope-from=SRS0=dc2d=U4=miszr.win=git@fe-bounces.miszr.win;
 helo=smtp.forwardemail.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_FMBLA_NEWDOM=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

This patchset resolves issues with incorrect register selection for the=0D
F*TOx(destination registers) and FxTO*(source registers) instructions=0D
in the Sparc architecture.=0D
=0D
An updated testing program can be found in issue #2802[1].=0D
=0D
[1]: https://gitlab.com/qemu-project/qemu/-/issues/2802=0D
=0D
Changelog:=0D
v2:=0D
- Corrected a mistake I made in the FqTOx instruction=0D
- Fixed issues in the FsTOx, FxTOs, FxTOd, FxTOq instructions as well=0D
=0D
Mikael Szreder (2):=0D
  target/sparc: Fix register selection for the fdtox and fqtox=0D
    instructions=0D
  target/sparc: Fix register selection for all F*TOx and FxTO*=0D
    instructions=0D
=0D
 target/sparc/insns.decode | 12 ++++++------=0D
 1 file changed, 6 insertions(+), 6 deletions(-)=0D
=0D
-- =0D
2.48.1=0D
=0D

