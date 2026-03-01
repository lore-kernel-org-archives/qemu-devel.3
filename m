Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FFBFD0047
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 19:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwmHh-000132-00; Sun, 01 Mar 2026 14:16:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHg-00012U-05
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:16:56 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHd-0003Un-RL
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772392608; x=1772997408; i=lukasstraub2@web.de;
 bh=IXFjwhGkzg/daKFGYYq3G+n8eTTkmQTTEAxLFKgpXWA=;
 h=X-UI-Sender-Class:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:To:Cc:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=sOxcjfIzdFbhNM7tP7suzl95elg4IMxi5wvdI5sSOfzdok33Z3sKp6fTNh4Eypa3
 VG7qaa9kGgEiAhJs1VZIT7jO8Ou2HNTq8SI3uRfpTc3vTzDwby4yR3BzScruAM2Vz
 QWTxwpzAt47jMzsW8VoyQ8l5hNqgLFNwR3WyNVQEQMrnaB4d0vI7JkJBWN96ITAbZ
 WYloMWRvlMKkmiYZQPVv1g2h+acJgjRvQT2cYGBg/eJLEkGLum74nbBraezg6J9wL
 VtlAX9ZY39E/Gg8NGGypAqFOSlNDXuHml4CCx+tiOp54L98XM/0jkt6nPDFzqztBw
 9Gl/9nYhqiK6OUp/IQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4vNe-1vVFVE2rTQ-015URC; Sun, 01
 Mar 2026 20:16:48 +0100
From: Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH v11 00/21] migration: Add COLO multifd support and COLO
 migration unit test
Date: Sun, 01 Mar 2026 20:16:25 +0100
Message-Id: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIAImQpGkC/43SwWrDMAwA0F8pOS/DlmPL3mn/MUaxLXk1tMlI0
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppJCToVonNlPaTXx8adqIzp9vY08nLe9rrUo1a
 QmOKgr3mjmJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSQkwAKCRA1qwsonF2y
 WJZAD/0Q/ll2Ur06IeCqzrBnVqR0l/nbRd9A+wCVqvJbBHMStohMZEFoO5palCX20jzVefhGY2A
 PfDC+GA0YQPRGxc4YdNh73ESvEy6Rf4dZ5IsT3ljdefpXlrxECgnPyzoX6eK0BtzKsHPfeRnLeS
 CUt5ZThBkz9I5D9dXaCmfIZxztlKRwbLiN5ALvqVNfwaTB83FpZAfK2TnVWchl7IB8I6CQwNJ0f
 iNqpiEhViLMQMYS59QhHBCipq+o6c0ye+fNj8uNc4E+ExMPmE9wAbByORQYYzjqomeFnkQ+gtLt
 55CkKrVS6woyyR29Ov5zJSK+VYj4Jl+XCqWY9g7UQjMRi9W5UVC7wKtc5BsaVkdx96wbd3SeVlt
 xzq0HHuSBufDsvOUDwufKfl2l2PijCJbmnqcxoYBq3bEWx1XzisY4VVFFb9Jfm5O+1dHz/9Imbu
 mQHcSD3XO9jA2bXxNzju9ou41FMGo8aohGhJ5l8ZPmfBUHoJpUa4tNKVnD+epN6lEUHcH+A9eeY
 6CthcIzGeZ8W6wVT9oroU8ra5aGG3ooXFRlka2uPxQbjVWwlGKO57JU1FHJotUfDI/UHAzk+e6o
 wSZ/UwnbRjweskEigveTIyuO4BTd4rR7zyWA8/2QBPxHcGBIzo04RDyTZJZ5nU2uKuLeEUjXn4L
 +1w7abfQFic5ioA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:Icwnuq3xEn3ovyNIUNKyVSwNBjeXZOa9kH5r0BZN+Io719s0xgA
 JeQAcbxTdc2C3byujbSErrnHzXOQ/PO07IOlJKEWbVvkFWLVPD9ivIhOVqlrTi+JSMcANDh
 MctlAyzU7N/sPeX+6NgrAyqlSpoeZM17V1qfEol83OPQnnobUzveNiqi/coQBfQdtXqtbpS
 9hL2826IY9LwI8KuF0tGA==
UI-OutboundReport: notjunk:1;M01:P0:KFTkSn/Jhxk=;q3piJQp5iCADk9fuIImqr02+fq3
 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
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


