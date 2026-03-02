Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B74E9B356
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0PQ-000819-IL; Mon, 02 Mar 2026 05:21:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0Nz-0006Zf-7l
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:23 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0Nv-0007Ha-UY
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446810; x=1773051610; i=lukasstraub2@web.de;
 bh=r+zl0+p3LpV+Wr6A/5LQfpj3b0cZ/sqTXYBDLm7685Q=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=RHRgVDFzjcLiFEk0X9fXDBt2nWBJY1WQhCwUA95XUZvMz1fPBtbEdCBGnGziXHmp
 08oqDTX4DlWQP7xfoSlSZx0dH8haizjp5a4VUmbIbV5oP+9VDxKv+OJrbwTusRtau
 j4G1oWmxWsc9Tp0N3imY5SDeDQKxTEOFCi5kNzaGdKZR+DFm+7FS5FKe9Qz0aOIZY
 EKpgHqysp0j8NtSi5pMfm0/Kf2NuT3RHZaGRo6AZuhjyOHCt3TV8HFBwTt9lQaOmC
 K96kWdYbpXsUeW5JmNquud0dcKHLovNW3Xbv9FRocFhescrKWg0UqyjaZw85IByK/
 pk100u7oHXONNy51Cg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N79RI-1vcA9G2gMG-00xpGi; Mon, 02
 Mar 2026 11:20:10 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Juan Quintela <quintela@trasno.org>
Subject: [PATCH v11 00/21] migration: Add COLO multifd support and COLO
 migration unit test
Date: Mon,  2 Mar 2026 11:19:42 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251230-colo_unit_test_multifd-8bf58dcebd46
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5037; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=CJ9NqnKPLFKru4y8Cid4pevm+FERcyb1EkQ+daaESyc=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWQf60yU4uVyQP+xCtXphyfvurynqwFBe7VzC
 H6UKz/9GkqJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVkHwAKCRA1qwsonF2y
 WNQZD/9xJAn6degBhCwG2Wi7IVD5nIRtBQsWTrinoQLP1rJuxg6YEOUwK6hA7Kv+mGa51BFz5n0
 hxdJctA68APdwu1Mcp90Ug3qsSt1kGKRIvOM7X28/a2J7+t4x1mJIRMkpTm/t5kiITdk3y6aKUk
 wIU5+lRouys7ZbIhZthyz3eMJsYMgd6Pz1+w01pPtOwDCnbr62jNKOOeCin+Pgly3SjD6R1y9ZI
 Xs2paFHwaRQZi1Fv9uNUMMvxoAVM60+3u+cKwnucMc6ur65BVZJ4I+c203ZkbqIX/AK8YNNmt+o
 UmM/TzxaFm21AKVLqFFoH5WmQQIonFgNk4U1/a2qVXAdXuOkim/hLrV3Oo6zsTTgsfk5RPrnQ8Y
 hmqnOtwASWM5mJcizvQZGjbhMxsz77jzomQov3P3BRuo0ao5GAsPh7+EZr4BfIw76qsaY+K5xQA
 smHVqF8UHVAwexygaOF/OqgpA0pG1meQJF1EA1UAf/Eq3zHGJ3mUVoXjdyQ8zaKtpBWBOXcOTkk
 SyrPprLsecvJ0hUPipLe34mgPmVab0AYGVfTCMMWhibvbRRz+j5YjTMcm2dHhrmhW55YDqtPuIb
 TX0L/kUioBhsFdl71hRJ5Yj2S+w3AHwwUMl5UUvcR/zmHs4a3lDVQ/v5tbwWuhEiPg6cFUtjF9/
 zXDxofQzKR9APGQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OisPp2wruDDHgeVg+SZ/V8Ydb7CioXBw9tAhKn8BSJO9kO+h0M2
 97oS+eyOQPC9RGChj/CUeckdbEZnwPLjIM1DiJlWOpxKneWnp9iY+4kgRS+BpxqnDXbYW+8
 qk+FictfcQm1Ms9oRXX8LfcifLRuSKvaUOETgg5t9liFd/h27+qlWcOuTNWSC3aETLFS1GR
 K07MEDXfWjj1FuqGlEtnQ==
UI-OutboundReport: notjunk:1;M01:P0:VWQ/l2EPm/4=;QwG00DPqUILZuHWqyjNvWENiuAS
 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
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
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

Screw b4, I'm back to git send-email again.

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


