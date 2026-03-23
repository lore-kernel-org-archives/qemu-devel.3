Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA36FF483C8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iUR-000090-2I; Mon, 23 Mar 2026 12:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w4iUO-00005e-Bp; Mon, 23 Mar 2026 12:50:52 -0400
Received: from m16.mail.163.com ([220.197.31.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w4iUH-0000H0-Su; Mon, 23 Mar 2026 12:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=5w
 TG5D7tlDMVTIGoMZqtLsa+6llUlkwvDFg7Y04EAYA=; b=qZfBZyzH8nS+2Kney0
 QC8OiXKcjYfl7cgmeDZcuQGZlLqFbZi4INyLGl1KzOvQUKKbdCWRVE+GoESYXP2S
 aIyhJ1JL/DiRTblK8Byg7aaK6cQ+C820Yqa02L6psGv4JuFW7Rs1EGGqijzfeJiO
 L5ijkor6xclbcLqEMTh4nuaVY=
Received: from dt-VM.localdomain (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PygvCgAH5qxAb8FpwWGXTQ--.954S2;
 Tue, 24 Mar 2026 00:50:11 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Tao Ding <dingtao0430@163.com>
Subject: [PATCH v2 0/1] Fix transfer size register decrement
Date: Tue, 24 Mar 2026 00:50:06 +0800
Message-ID: <cover.1774282897.git.dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <7e7677f4-9cd9-4d33-995e-f7645786e1ce@163.com>
References: <7e7677f4-9cd9-4d33-995e-f7645786e1ce@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PygvCgAH5qxAb8FpwWGXTQ--.954S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RiqXlUUUUU
X-Originating-IP: [119.4.67.184]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC-gO29GnBb0ObzQAA3t
Received-SPF: pass client-ip=220.197.31.5; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

When source and destination widths are different, the transfer size
register was not being decremented correctly, causing data corruption.

Compared to the previous version(PATCH v1 2/3), simplified the code and
the judgment of constraint relationships between size, swidth, and dwidth has been added.

Tao Ding (1):
  Fix transfer size register decrement in pl080

 hw/dma/pl080.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)


base-commit: 8e711856d7639cbffa51405f2cc2366e3d9e3a23
-- 
2.43.0


