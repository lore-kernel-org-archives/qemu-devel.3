Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27513C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 11:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpRW8-0006Lk-DD; Wed, 27 Mar 2024 07:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rpRW7-0006LZ-8z
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 07:32:27 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rpRW4-0000eq-Bu
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 07:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711539145; x=1743075145;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VLCDtnrRT1O3HvbiUBardQSY/S+PhjGzXYwBEypmBWo=;
 b=kMrEty1/cAC7npSRwC1V+6r3iAJgXi/HzV79sJNLSwIxKR2pjxWtnAoj
 CVcbdOYvFztcu5gXu0n3QCRkG7YP7suBsrm/n2ZhrZFY7xe+HLE0+1Vm2
 SOEbcCq3PZbbwHaRfdlfFjNpon9m9+m7emh0NGn0lSJSi25TC94UNyq4m
 +YcMCPOW12KSio1uN1yNd2SmS2FUgvMdt7Hshal8H3upI4oTpLNe6cbz7
 Oyi8S+inyYGoCvzQwIW+jv2HJCn1VFm3olvwp64It/83rI8ONpCL5T0vL
 qk1NgR2t6bJGX30VtinSw/KUZ5wxD8NLUJdKRJSfGPv3k6VkeM7WABRYT Q==;
X-CSE-ConnectionGUID: P9J8im2iT7q0qy3PEIKqTA==
X-CSE-MsgGUID: MgnpZGy/Svi9o05OCv4wlA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17362971"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; d="scan'208";a="17362971"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 04:32:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; d="scan'208";a="16323444"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 27 Mar 2024 04:32:20 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC] util/error-report: Add "error: " prefix for error-level report
Date: Wed, 27 Mar 2024 19:46:09 +0800
Message-Id: <20240327114609.3858483-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.9;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

When vreport() was introduced, there was no prefix for error-level
(REPORT_TYPE_ERROR) report. The original reason is "To maintain
compatibility we don't add anything here" as Alistair said in his
RFC v3 series [1].

This was done in the context of inheriting the original error_report()
interface without the prefix style. And it was also useful to have a
means of error handling, such as exit(), when error occurs, so that the
error message - the most serious level - can be noticed by the user.

Nowadays, however, error_report() and its variants have a tendency to be
"abused": it is used a lot just for the sake of logging something more
noticeable than the "warn" or "info" level, in the absence of
appropriate error handling logic.

But, in the use case above, due to the lack of a prefix, it is in fact
less informative to the user than warn_report()/info_report() (with
"warn:" or "info: " prfix), which does not match its highest level.

Therefore, add "error: " prefix for error-level report.

[1]: https://lore.kernel.org/qemu-devel/87r2xuay5h.fsf@dusky.pond.sub.org/#t

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 util/error-report.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/error-report.c b/util/error-report.c
index 6e44a5573217..e981c0b032f0 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -213,6 +213,7 @@ static void vreport(report_type type, const char *fmt, va_list ap)
 
     switch (type) {
     case REPORT_TYPE_ERROR:
+        error_printf("error: ");
         break;
     case REPORT_TYPE_WARNING:
         error_printf("warning: ");
-- 
2.34.1


