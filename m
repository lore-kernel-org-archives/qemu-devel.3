Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DF6E83856
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 06:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsEfp-0006X9-OX; Tue, 17 Feb 2026 01:35:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vsEfo-0006Vq-Bf
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 01:35:04 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vsEfm-0004Sg-E3
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 01:35:04 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61H6Yfkf030238
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 17 Feb 2026 15:34:42 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=+jSeD27nf4R/+FSHJiv6T3JBfTslbGrXgZQQ/ab9Mt0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Subject:Date:Message-Id:To;
 s=rs20250326; t=1771310082; v=1;
 b=Grxy6bun1jxYd3o+9msPmf0dPd+hxRxJFLlIkDVidA45t4EBXctf5BYFYxyeLxph
 YspM6GQ0iwcUlcob5jjYTCTpOt6sKeJTdb1hNlY/qX38zhVNR6uajLiHcfTqmdcT
 6x0dDPZTyjwWv8dVODERDVd4iFYBylnTJAtg9JEKLhCrDNIUm41IBOypnd43WNsb
 ThCwowQnq/4/VrAZO3JJNTZgYjDNwkGLGK9srArXPrpSmml8ajCFnqjt2kpRd8y2
 YCuyfj791d1Z2Dm90SEaFnBVGrIBOUd4jZePfWYK98uMZ5RkVKLTnHnhz9p+jy30
 ueAocoKMQyrAQy6VzM2lsg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 0/2] Reapply "rcu: Unify force quiescent state"
Date: Tue, 17 Feb 2026 15:34:28 +0900
Message-Id: <20260217-alpha-v1-0-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPQLlGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDI0Mz3cScgoxEXRMjA3OjVEuLFNOkFCWg2oKi1LTMCrA50bG1tQD20WG
 /VwAAAA==
X-Change-ID: 20260216-alpha-42072e98d5bd
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Yodel Eldar <yodel.eldar@yodel.dev>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-67ece
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This reverts commit ddb4d9d1748681cfde824d765af6cda4334fcce3.

The commit says:
> This reverts commit 55d98e3edeeb17dd8445db27605d2b34f4c3ba85.
>
> The commit introduced a regression in the replay functional test
> on alpha (tests/functional/alpha/test_replay.py), that causes CI
> failures regularly. Thus revert this change until someone has
> figured out what is going wrong here.

I could not reproduce the alpha issue when I tried a bit while ago, but
trying on a more conventional setup (x86 without ASan where I usually
use Apple M2 with ASan) did a trick. So here is a fix for alpha and a
patch to reapply commit 55d98e3edeeb17dd8445db27605d2b34f4c3ba85. I
confirmed no failure occurs in 100 trials with the alpha fix.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Akihiko Odaki (2):
      target/alpha: Reset CPU
      Reapply "rcu: Unify force quiescent state"

 target/alpha/cpu.c |  1 +
 util/rcu.c         | 79 +++++++++++++++++++++++++++++++++++-------------------
 2 files changed, 52 insertions(+), 28 deletions(-)
---
base-commit: ece408818d27f745ef1b05fb3cc99a1e7a5bf580
change-id: 20260216-alpha-42072e98d5bd

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


