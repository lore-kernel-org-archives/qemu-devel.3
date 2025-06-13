Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127C6C61DB2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 07:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPzDR-00041z-H6; Fri, 13 Jun 2025 03:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1uPzDO-00041J-T5
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 03:52:42 -0400
Received: from [115.124.28.125] (helo=out28-125.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1uPzDI-0007KS-W9
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 03:52:42 -0400
Received: from TC-DZ-03-0020.tc.local(mailfrom:lc00631@tecorigin.com
 fp:SMTPD_---.dKtfGTk_1749801016 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 13 Jun 2025 15:50:19 +0800
From: Chao Liu <lc00631@tecorigin.com>
To: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, armbru@redhat.com, balaton@eik.bme.hu
Cc: lc00631@tecorigin.com,
	chao.liu@yeah.net,
	qemu-devel@nongnu.org
Subject: [PATCH v7 0/1] Optimizing the print format of the QEMU monitor 'info
 mtree'
Date: Fri, 13 Jun 2025 15:49:28 +0800
Message-ID: <cover.1749800810.git.chao.liu@yeah.net>
X-Mailer: git-send-email 2.47.0.windows.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.125 (deferred)
Received-SPF: pass client-ip=115.124.28.125;
 envelope-from=lc00631@tecorigin.com; helo=out28-125.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

From: Chao Liu <chao.liu@yeah.net>

Hi, all:

After several rounds of discussion, I think that adding a -t option to the
`info mtree` command, which enables the display of tree-like node characters
(e.g., +--, |--), is a better approach.

As BALATON Zoltan pointed out, retaining space-based indentation for displaying
memory region (mr) nodes helps ensure that the output remains easily parseable
by other programs. This also provides better compatibility with existing tools
and scripts.

Users can choose between:

- Without '-t': The default format using spaces for indentation, suitable for
  scripting and parsing;
- With '-t': The tree-style format using visual characters, ideal for
  human-readable output.

This way, both usability and compatibility are preserved.

---

v7:
- Rebased on the top of current upstream:
  d9ce74873a6a ("Merge tag 'pull-vfio-20250611' of https://github.com/legoater/qemu
  into staging")
- Add -t option to 'info mtree' for tree-style node display

v6:
- Replaced the bool type with enum mtree_node_type to improve code readability;
- Modified the output to use only one horizontal dash instead of two, and
  aligned character printing for a cleaner look.

v5:
- Fix one comment, level 0 no longer prints line characters.

v4:
- When printing the child nodes of a single node, the line characters from the
  parent node's level are no longer printed, making the output more concise
  and clear overall;
- Use more commonly used ASCII characters, such as '|--' instead of '├──',
  and '`--' instead of '└──';
- Control the number of prefix characters to reduce unnecessary output.

v3:
- Use more maintainable c functions instead of macros, as per review comments.

v2:
- Enrich the commit message, add 'info mtree' print example;
- Optimize the code implementation according to the review comments.

--
Regards,
Chao

Chao Liu (1):
  system: improve visual representation of node hierarchy in 'info
    mtree' output for qemu monitor

 hmp-commands-info.hx    |   5 +-
 include/system/memory.h |   3 +-
 monitor/hmp-cmds.c      |   3 +-
 system/memory.c         | 150 ++++++++++++++++++++++++++++++++++++----
 4 files changed, 143 insertions(+), 18 deletions(-)

-- 
2.48.1


