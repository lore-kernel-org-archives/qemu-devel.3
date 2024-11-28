Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DCCD70DEF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 19:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGkL2-0005zD-JS; Thu, 28 Nov 2024 14:38:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <eaab44ccc59b83d8dff60fca3361a9b98ec7fee6@kylie.crudebyte.com>)
 id 1tGkL1-0005yR-Eg; Thu, 28 Nov 2024 14:38:07 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <eaab44ccc59b83d8dff60fca3361a9b98ec7fee6@kylie.crudebyte.com>)
 id 1tGkL0-0001gP-0Q; Thu, 28 Nov 2024 14:38:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=1US0Hku5DQ0cBnjtRjsuV3eRaQ77PkQst+RVXHW9Nwk=; b=V7svI
 8srFXNpSLQ7FkyUkSCiS3U+1ADObziya6LIbCzI7kLcibor2Nyl4Otape1abWYWX6bxGPKaGiCKVC
 n+I8CzffWpZ4xMYyTvMmxnKriTrgQHWVfHLOXtfRmMpZgdg+BZTUOv8dNpjO8Rh7FpJI/R7jLlu1E
 6NiH1t1C2g9wIwTRi4CtbLE93JINm7vOXrf6MOC+8IqbJNTRbsBkufKsWZTwkZ0lNsyAaDE5RSAGm
 EMwmaY074glsbnV93ewdIthIb1aBjXc12FC77OQIErrOUPGtkqClaRzf7ah+nqN0dgV0zyMx/cDKZ
 rWnuznqyc+DjZxHwqRvaHQcIRtv6ndokjiZjrwbvuEdAM85JWNh8/phBadwZ7wKh86VQ2axYbLWwY
 q/acAkBTmoop2OUopBvxHfCU4XcK9pmd+gVm19ehAzyAEEtfxMUqlJfy1CcadUrpQ/gmdpsdV7lJV
 LubcCDgDp+8ToPG81VJdPRkaAvVpzv64uv2QNIYFTxRyBbyrfnzoLG9HgaWxF1/t5LKbkRFjDoe7/
 BN4IQ0i2XmNFnWVQnZ3RCnO45rCR1SOxmccL2ulfVpw5ynVWc8N9yutW+OXSKBwc4rBhDPt9YBDOW
 mcBb3tInZLSosYJoJma+NMxH63XhxzgkjacLCbY5G/o9PRMXYL1O6oOYNumtlQ=;
Message-Id: <cover.1732820037.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 28 Nov 2024 19:53:58 +0100
Subject: [PULL for-9.2 0/7] 9p queue 2024-11-28
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org,
    Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=eaab44ccc59b83d8dff60fca3361a9b98ec7fee6@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 24602b77f5658ae8377958c15fdef2f44affc743:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2024-11-28 10:50:20 +0000)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20241128

for you to fetch changes up to eaab44ccc59b83d8dff60fca3361a9b98ec7fee6:

  tests/9p: also check 'Tgetattr' in 'use-after-unlink' test (2024-11-28 18:54:00 +0100)

----------------------------------------------------------------
* Fix open-unlink-fstat idiom on Linux guests.

* Add test to verify this behaviour.

* Cleanup patches.

----------------------------------------------------------------
Christian Schoenebeck (7):
      9pfs: cleanup V9fsFidState
      tests/9p: add 'use-after-unlink' test
      tests/9p: fix Rreaddir response name
      tests/9p: add missing Rgetattr response name
      9pfs: remove obsolete comment in v9fs_getattr()
      9pfs: fix 'Tgetattr' after unlink
      tests/9p: also check 'Tgetattr' in 'use-after-unlink' test

 hw/9pfs/9p.c                          | 12 +++++----
 hw/9pfs/9p.h                          |  1 -
 tests/qtest/libqos/virtio-9p-client.c |  3 ++-
 tests/qtest/virtio-9p-test.c          | 46 +++++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 7 deletions(-)

