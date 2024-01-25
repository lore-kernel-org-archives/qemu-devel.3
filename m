Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95C8C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 11:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSyLS-0003HJ-Qo; Thu, 25 Jan 2024 06:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rSyLR-0003Gx-9d
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 06:56:33 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rSyLP-0004yr-Ct
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 06:56:33 -0500
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c29:fcc6:0:640:eb21:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 1B03960B5D;
 Thu, 25 Jan 2024 14:56:24 +0300 (MSK)
Received: from davydov-max-nux.yandex-team.ru (unknown
 [2a02:6b8:b081:1220::1:4])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id AuSJvL1IYeA0-wFmYrPCR; Thu, 25 Jan 2024 14:56:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1706183783;
 bh=0uiZeGyMSUa2QmI5W8xm1E0pgZzN4f5fA8o0yfSG2BA=;
 h=Cc:To:Message-Id:Date:Subject:From;
 b=N5+JEVYDSC/LUjDFuzzYLcKUerxQvYWTASoSRHWasvA0lx9GzkWIick0wpf4akMNs
 TmNiNhLhuv84pqKvZjtsrDcPZk4GTys3MtfGG+wt45l5XaepjtkDxsIi7f3ncW4bEu
 /lclutDVjAvQaTaTmlGNlAz38JpBZGOpLCLLJvJg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Maksim Davydov <davydov-max@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, jsnow@redhat.com, eblake@redhat.com,
 armbru@redhat.com, pbonzini@redhat.com, berrange@redhat.com, alxndr@bu.edu,
 davydov-max@yandex-team.ru, vsementsov@yandex-team.ru,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 michael.labiuk@virtuozzo.com
Subject: [PATCH v8 0/4] compare machine type compat_props
Date: Thu, 25 Jan 2024 14:56:06 +0300
Message-Id: <20240125115610.23697-1-davydov-max@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=davydov-max@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This script can be used to choose the best machine type in the
appropriate cases. Also we have to check compat_props of the old MT
after changes to be sure that they haven't broken old the MT. For
example, pc_compat_3_1 of pc-q35-3.1 has Icelake-Client which was
removed.

v8 -> v7:
* rebase
* fix encoding

v7 -> v6:
* minor fixes

v6 -> v5:
* add ability to compare different QEMU binaries
* replace abstract drivers by its implementations
* improve human-readable format
* code refactoring

v5 -> v4:
* minor fixes

v4 -> v3:
* increase read buffer limit to limit value in libvirt
* add caching of qmp requests to speed up the script 

v3 -> v2:
* simplify adding new methods for getting QEMU default values
* add typing
* change concept from fixed dictionaries to classes

v2 -> v1:
* fix script code style and descriptions
* reorder patches
 
v1 -> previous iteration:
* new default value print concept
* QEMU python library is used to collect qmp data
* remove auxiliary patches (that was used to fix `->get` sematics)
* print compat_props in the correct order
* delete `absract` field to reduce output JSON size


Maksim Davydov (4):
  qom: qom-list-properties: add default value
  qmp: add dump machine type compatibility properties
  python/qemu/machine: add method to retrieve QEMUMachine::binary field
  scripts: add script to compare compatibility properties

 hw/core/machine-qmp-cmds.c       |  23 +-
 python/qemu/machine/machine.py   |   5 +
 qapi/machine.json                |  64 +++-
 qom/qom-qmp-cmds.c               |   1 +
 scripts/compare-machine-types.py | 486 +++++++++++++++++++++++++++++++
 tests/qtest/fuzz/qos_fuzz.c      |   2 +-
 6 files changed, 577 insertions(+), 4 deletions(-)
 create mode 100755 scripts/compare-machine-types.py

-- 
2.34.1


