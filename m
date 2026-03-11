Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A691125807
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 13:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0JPo-0000rE-1R; Wed, 11 Mar 2026 09:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w0JPR-0000mm-Bf; Wed, 11 Mar 2026 09:15:33 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w0JPN-0000MZ-DP; Wed, 11 Mar 2026 09:15:31 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 18C7EC01F7;
 Wed, 11 Mar 2026 16:15:24 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:d28::1:5])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id MFGaO30AdeA0-utayagAb; Wed, 11 Mar 2026 16:15:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1773234923;
 bh=iz6p7m9EDk2Vrc5w/nLOhSrRhal4+0T/3hF17eQnydo=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=FiI3+Rf3FT6ap8Pc5DxNEqqh5C2eKHelIcuXpoDMmBvjB4aolMQs1ht/j9DI4TJ4E
 bQ4osiO/XKrd6odMhPqdJznBdAr1NsteegSvv4Dj8Auw1Ky2ZTG+ezKQ7S12KQtMqA
 /BchWcgZMqwH4WAP4ulQRU4MaGygCjFT++fWbKug=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-trivial@nongnu.org
Subject: [PATCH v4 0/4] Fix a few minor issues reported by Coverity
Date: Wed, 11 Mar 2026 18:15:18 +0500
Message-Id: <20260311131522.58600-1-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Hi. This patch series fixes several minor issues reported by our local
Coverity installation.

Changes in v4:
- Included Peter's explanation why `assert` is redundant in the commit
  message of the third patch.
- Added `Reviewed-by` tags that I missed in v2 to the other three patches.

Changes in v3:
- Nothing. I sent the second version of the series without the corresponding
'v2' suffix by mistake. I apologise.

Changes in v2:
- Remove assert(block) in system/physmem.c instead of placing it
  before the dereference.

Sergei Heifetz (4):
  migration/savevm.c: reorder usage and assertion of mis->from_src_file
  dump/dump.c: reorder usage and assertion of block
  system/physmem.c: remove useless assertion of block
  hw/usb/core.c: reorder usage and assertion of p->ep

 dump/dump.c        | 2 +-
 hw/usb/core.c      | 2 +-
 migration/savevm.c | 3 ++-
 system/physmem.c   | 2 --
 4 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.34.1


