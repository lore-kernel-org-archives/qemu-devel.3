Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8661AFD0078
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 21:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwoUP-0004F4-6R; Sun, 01 Mar 2026 16:38:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoUN-0004Ew-Uk
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:38:11 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoUK-00045C-Vd
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:38:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772401061; x=1773005861; i=lukasstraub2@web.de;
 bh=IXFjwhGkzg/daKFGYYq3G+n8eTTkmQTTEAxLFKgpXWA=;
 h=X-UI-Sender-Class:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:To:Cc:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=coXDpYmkWLYUG2ngA/NEokRYzHXZ7xLgAbC9vGnyhFQsEPzoeiEsKCMMiaRNPZeo
 42fdP8mt3lkWxEC9FTLvg+w7bLunJbVtlICDWsparajXT/sp5Ud2EI08eZSrvXi0W
 Xvv3pDiXlCJcRF9sm0T/+gHszYkXZp6uhEshbcx0zyz7MNS6nIvI1l2SYcs9S5rMq
 ynfBomBJHJWlUZN2NWtkOq/5QzXml+Cs8SO/3lwT3zOsbq7C3heqkz+VWYMMGZlNh
 sNb53taSPpHdk90KXlST5kwl6SrJE0JkY2s80DeS1UMt7P9H0A4M6sZvxJpTxuq8g
 FRuGPboiXULjztuxQw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXXRF-1wBy7H3vqR-00UVQl; Sun, 01
 Mar 2026 22:37:41 +0100
From: Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH v11 00/21] migration: Add COLO multifd support and COLO
 migration unit test
Date: Sun, 01 Mar 2026 22:37:20 +0100
Message-Id: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIAJCxpGkC/43SwWrDMAwA0F8pOS/DlmPL3mn/MUaxLXk1tMlI0
 m6j9N/nFEaTQbodJaMnS+hcDdxnHqqnzbnq+ZSH3LUlkPJhU8Wdb9+4zlQSFQjQEpSoY7fvtsc
 2j9uRh3F7OO7HnKi2IWlLkQM1pirFwQ9ch963cTeVH/wwcj89vPec8ue15ctriXd5GLv+6/qDk
 5yyf/Y6yVrUyaFqQsQmonz+4PBIXE3eCX4MI6TEVQOK4YMGiYjJ66WhZgboVUNNBjswMZJlzwu
 jmRl3ZmmKgVJqH0wSjLgw9M0AoVYNXQyNWtiAyrpkFoaZG2bVMMWAsgtH5KVytDBwZsj1WXAyV
 CAFSRkLdmHY/xl22kdyrBOSsBAWhpsbdtVwxSBLgYKI3vzahxQzBO4cmShKSGyQGgBOtwu5XC7
 fruVe0TkDAAA=
X-Change-ID: 20251230-colo_unit_test_multifd-8bf58dcebd46
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>, Juan Quintela <quintela@trasno.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4990; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=aZCxY3+Sgn4B4fN6XeMKjfN4fu0UKIOwFuJGUujpdsg=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppLGX1gmycKd6Rk7cFmwWmaD4wBXFPG+t1qt2J
 LwrXQPmZ6qJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSxlwAKCRA1qwsonF2y
 WJAfD/955t2w+w1ekbagY+Lf+Mijw5D8kXVGhZrmBT+hE2lOf+PIMeiXPjjMx/CNPraE0ll3Sxs
 eDb5i39uBeQM0uqTrI8++u7TmMt5ny22E7AmKFHts5GaYzsKmLHW+7zw/fEi56BgBOGg+Vsa75M
 J7bNE80rEP5WM6IKesj6NuQpDKY9dmnJ6d8q5nAudAKTKqjwYR5Sqxn6vmTMry9kKFkRVioVgiU
 whKjBx2K02lYJVaokbgmWOlxDqiTgQgr3T2gPI40k52Ja4xhb0pgmzSuKmGXeHZOiH+mNpZVPdW
 OtQkjx8fAMBxplcaYX4IUy+KR0lBNHDDybPoCsL1+/7Dl7vjl+1kC90XrsbSAPgj2PhbBKb5jVY
 KoGhhC8YNts0Hy7Rk96OlK6LaxoRFNMjg34Sps5/IAbLCJafWfOKonjvAuijKdntupPgsKf+yjM
 OZ+LLYIydNDHZjZjxS+bWdIuQnwc9jyVG2sED1Ox/Ii2ru8N4/FKpYWce/p4wH43ZyJmdM01yOP
 HimkMIRfgQpW1N6kuDbbSP9f8Dt+bNlvXQCfXTy70W/7v1TI3aNAtFKN5uNbhiCriAHUpHY7lJO
 qFuaaEdp8h+1rP+SE5EBNWk5Np/RlNQiqIpWXakk1JGcv6MqgmaGRPGCDXR3wlLaVG4I11zx4dq
 pkRvmIvXQ4bGWLw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:k1ib0NOPuRtmet1tEWDwugoHSgGs4JH0p2Fgpwds1Xip+OUMol2
 ol/fGpBxjFMnHe04eBowcOF3qL0BG3saEsz99PikEUf6Ay0GfnfLoVA11ogbsPNz2C1+FuZ
 MSgexJi7sRnmCPLofzMzHSFOZMr0VGk0tllWmL6sN41Dp1hT8NXwSok1228gLOTZOloDnz2
 72lPlbO8MyJB5UyfrCjvA==
UI-OutboundReport: notjunk:1;M01:P0:XnbbIQiGTm0=;+Q3fV/uo+bj2R87UMPzCmJZ6HcT
 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
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hello everyone,
This has some cleanups for and adds multifd support and migration unit tes=
ts
for COLO migration.

Regards,
Lukas

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
Changes in v11:
- Use colo with return-path capability
- Link to v10: https://lore.kernel.org/qemu-devel/20260220-colo_unit_test_=
multifd-v10-0-bfe67d422ef1@web.de

Changes in v10:
- multifd: always kick the main thread
- always open the return path socket on source
- Link to v9: https://lore.kernel.org/qemu-devel/20260218-colo_unit_test_m=
ultifd-v9-0-d8dbdb0ca6f6@web.de

Changes in v9:
- Rebase onto master
- Fix two rare bugs discovered during sresstesting the colo unit test
- Link to v8: https://lore.kernel.org/qemu-devel/20260210-colo_unit_test_m=
ultifd-v8-0-7f9e5f7d082b@web.de

Changes in v8:
- Fix peter's review comments
- Link to v7: https://lore.kernel.org/qemu-devel/20260210-colo_unit_test_m=
ultifd-v7-0-23bd32f36828@web.de

Changes in v7:
- Fix peter's review comments
- Link to v6: https://lore.kernel.org/qemu-devel/20260206-colo_unit_test_m=
ultifd-v6-0-27779dda139d@web.de

Changes in v6:
- Fix the crash when running COLO with TCG accel.
- Link to v5: https://lore.kernel.org/qemu-devel/20260203-colo_unit_test_m=
ultifd-v5-0-57508b7389f6@web.de

Changes in v5:
- Remove unused inmports from multifd-colo.c
- Mention the checkpoint overhead of reset to the Q35 fix
- Link to v4: https://lore.kernel.org/qemu-devel/20260130-colo_unit_test_m=
ultifd-v4-0-7115ab6f0e77@web.de

Changes in v4:
- Add cleanup patches to remove migration_incoming_colo_enabled() and MIG_=
CMD_ENABLE_COLO
- Add more comments to the colo unit test
- Call colo_release_ram_cache() after multifd threads terminate
- Link to v3: https://lore.kernel.org/qemu-devel/20260125-colo_unit_test_m=
ultifd-v3-0-ae926ccd8eae@web.de

Changes in v3:
- Fix peter's review comments.
- Fix COLO with Q35 machine
- Link to v2: https://lore.kernel.org/qemu-devel/20260117-colo_unit_test_m=
ultifd-v2-0-ab521777fa51@web.de

Changes in v2:
- Fix review comments
- Hide stderr in colo migration test since the logged errors are expected
- Add benchmarking data for multifd
- Add myself as maintainer for COLO migration framework
- Link to v1: https://lore.kernel.org/qemu-devel/20251230-colo_unit_test_m=
ultifd-v1-0-f9734bc74c71@web.de

=2D--
Lukas Straub (21):
      MAINTAINERS: Add myself as maintainer for COLO migration framework
      MAINTAINERS: Remove Hailiang Zhang from COLO migration framework
      colo: Setup ram cache in normal migration path
      colo: Replace migration_incoming_colo_enabled() with migrate_colo()
      colo: Remove ENABLE_COLO savevm command and mark it as deprecated
      ram: Remove colo special-casing
      multifd: Move ram state receive into multifd_ram_state_recv()
      multifd: Add COLO support
      Call colo_release_ram_cache() after multifd threads terminate
      colo: Fix crash during device vmstate load
      colo: Hold the BQL while sending ram state
      colo: Do not hold the BQL while receiving ram state.
      migration-test: Add COLO migration unit test
      Convert colo main documentation to restructuredText
      qemu-colo.rst: Miscellaneous changes
      qemu-colo.rst: Add my copyright
      qemu-colo.rst: Simplify the block replication setup
      multifd: Fix hang if send thread errors during sync
      colo: Use file lock in primary_vm_do_failover()
      migration: Keep s->rp_state.from_dst_file open until migration ends
      colo: Reuse the return path from migration on primary and secondary =
side

 MAINTAINERS                        |   6 +-
 docs/COLO-FT.txt                   | 334 --------------------------------=
=2D-
 docs/system/index.rst              |   1 +
 docs/system/qemu-colo.rst          | 362 ++++++++++++++++++++++++++++++++=
+++++
 include/migration/colo.h           |   3 -
 migration/colo.c                   |  59 +++---
 migration/meson.build              |   2 +-
 migration/migration.c              |  80 ++++----
 migration/multifd-colo.c           |  44 +++++
 migration/multifd-colo.h           |  26 +++
 migration/multifd-nocomp.c         |  10 +-
 migration/multifd.c                |  26 ++-
 migration/multifd.h                |   5 +-
 migration/options.c                |  10 +-
 migration/ram.c                    |  12 +-
 migration/savevm.c                 |  37 +---
 migration/savevm.h                 |   1 -
 migration/trace-events             |   1 -
 tests/qtest/meson.build            |   7 +-
 tests/qtest/migration-test.c       |   1 +
 tests/qtest/migration/colo-tests.c | 199 ++++++++++++++++++++
 tests/qtest/migration/framework.c  |  13 ++
 tests/qtest/migration/framework.h  |   5 +
 23 files changed, 777 insertions(+), 467 deletions(-)
=2D--
base-commit: d8a9d97317d03190b34498741f98f22e2a9afe3e
change-id: 20251230-colo_unit_test_multifd-8bf58dcebd46

Best regards,
=2D-=20
Lukas Straub <lukasstraub2@web.de>


