Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6F8C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 16:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x69w4-0005rt-Po; Mon, 14 Sep 2026 12:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1x69vc-0005io-V6
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:53:16 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1x69vb-000501-5H
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:53:12 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 bb2e5cb2e53dd7be5ba358f67a5357a1f7b9a7e75983b4a90ce6fec89fc54ad8 with SMTP id
 6aa82675470ab31dcebc8912; Mon, 14 Sep 2026 16:53:09 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1789404788;
 bh=FS40ADQQA/p2HGqyuU1VDFZncGirTT+l+NcQCfz610k=;
 h=X-Mailgun-Dkim:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Type:X-Developer-Signature:X-Developer-Key:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=H92Bn0vOLKBYv2LliyCSZjZQMwppWwxtyAfCqZAKYMvkto2YeSUacSD/wyoTRcRtO
 IAlXxUH69SaK6b7gwmIGyq4IYa/P9kRZgFSgIs9x55T8rB7oXUFkpZcXw0E3UrJDYZ
 wBPGQwdlev7C/D3ky/MIPuxgGA+zn18wkeABST0ChF1pAwwjCRYyiRn/GplTE1i8Yx
 2XGeMu5IZVELTOdWw0dn+tq+XOYC9EILfVm+Zpod6rQqfD/J5U1V6CO8A9G96WQFsY
 dvtyd+Bp1Y5v/AGY+DCJnCtkQk4hlKFHRmSO6R7QmovP7La2I+bwn20EICD0Rxgv1Z
 /VMaePByi6pzg==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: "Yodel Eldar" <yodel.eldar@yodel.dev>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Yodel Eldar <yodel.eldar@yodel.dev>
Subject: [PATCH 0/2] vhost-user-bridge: Fix stdbuf and ASAN interaction
Date: Mon, 14 Sep 2026 11:52:48 -0500
Message-ID: <20260914165250.88382-1-yodel.eldar@yodel.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=yodel.eldar@yodel.dev;
 h=from:subject; bh=lfrKMDWnNhuwxIkPLBcoN6zkIuCq7ssvcSrPGKcibfs=;
 b=owGbwMvMwCU29Z3/drNU3zWMp9WSGLJWqFbXPt/EEib4+/6f1wfF+Cc2r/csXRhc8dU2ca2a+
 Trr4hOXOkpZGMS4GGTFFFkun5U465C7uytt5Y/7MHNYmUCGMHBxCsBEWhczMixwmzJX7eb0UltL
 uwlBkvtXy13gzdg8uWgpU/mPLyrGmx0Z/vCZtRy8cqEwsjru/L7ZXZKXEgz1mbgOfQvP2ZUvuP9
 hDAsA
X-Developer-Key: i=yodel.eldar@yodel.dev; a=openpgp;
 fpr=D3CD18CD406DBB8A66A9F8DF95EE4FB736654DAC
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HELO_STATIC_HOST=-0.001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Yodel Eldar <yodel.eldar@yodel.dev>

Hi,

As reported by Marc-André in (1), the functional test of
vhost-user-bridge (vubr) encounters a runtime error when
vubr is built with ASAN, because the "ASan runtime does
not come first in initial library list."

Upon Michael's suggestion, this series converts the DPRINT
debug output macro in vubr to use stderr instead of stdout
for output. With that change, the functional test no longer
needs to invoke stdbuf, so it is removed.

Thanks,
Yodel

(1) https://lore.kernel.org/qemu-devel/20260906-nohmp-next-v1-2-2b21e63974f3@redhat.com/

Yodel Eldar (2):
  contrib/vhost-user-bridge: Use stderr for debug output
  tests/functional/x86_64/test_vhost_user_bridge: Eliminate stdbuf usage

 contrib/vhost-user-bridge/vhost-user-bridge.c     | 2 +-
 tests/functional/x86_64/test_vhost_user_bridge.py | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

-- 
2.55.0


