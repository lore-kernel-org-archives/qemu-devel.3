Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8ED3E668AC
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Dec 2025 01:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWlq4-0003NK-4C; Fri, 19 Dec 2025 20:32:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1vWjXH-0003rc-8g
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 18:05:23 -0500
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1vWjXE-0004Mh-8W
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 18:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1766185504; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=4JE2nXK2rTWOs2s4RAnt1JI82mRkDkxHskcIVY2zNo8=;
 b=J03dlR/1rTo3j4FYWmSxbK/vFLQDwy9rL1/ZeM5riGWjefTnxkJMoNdgPcQC+g0K67h8o0+NG8r898ZEZE2IADiGmoPCreLJ9tTc2ZGeFWbKD2gKbrzoWERiUOQnc1o9dNT78aXuDvUIP/QHaFb3jfjLbs4quPMmbi+qbzip3Y4=
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0WvEDBhv_1766185496 cluster:ay36) by smtp.aliyun-inc.com;
 Sat, 20 Dec 2025 07:05:03 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	berrange@redhat.com,
	philmd@linaro.org
Subject: [PATCH] meson: Optimize summary_info about directories
Date: Sat, 20 Dec 2025 07:04:55 +0800
Message-ID: <20251219230456.37178-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.99;
 envelope-from=guobin@linux.alibaba.com; helo=out30-99.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Dec 2025 20:32:52 -0500
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

Clear summary_info first, otherwise there will be redundant output
about build environment.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index d9293294d8..73aa535d10 100644
--- a/meson.build
+++ b/meson.build
@@ -4634,6 +4634,7 @@ summary_info += {'Download dependencies': get_option('wrap_mode') != 'nodownload
 summary(summary_info, bool_yn: true, section: 'Build environment')
 
 # Directories
+summary_info = {}
 summary_info += {'Install prefix':    get_option('prefix')}
 summary_info += {'BIOS directory':    qemu_datadir}
 pathsep = host_os == 'windows' ? ';' : ':'
-- 
2.50.1 (Apple Git-155)


