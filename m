Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCBFC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 03:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjWK2-0007CV-4f; Sun, 10 Mar 2024 23:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjWJy-0006gf-F7; Sun, 10 Mar 2024 23:27:26 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjWJr-00084P-Qo; Sun, 10 Mar 2024 23:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710127639; x=1741663639;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FUBNZoVYFulMqFdKGFhCzM+sKaGWCnMsBZAUCnXGKvA=;
 b=Js5ntsC+jF5IUyJ3jA8/875ojawdxu6kmPnggRQboD54D+MLAO3iy/6Z
 pbFF3doq6H9u/xeZkQUC44GQuPle0Xx3KlsbpjGpmSzMTooWNvx7+p12r
 2CEK4QaA0kD2ilJ6oJqWUeltlPiBzMEfj63K5Y7Qwivm4QglAzFCpAsg2
 Up8b/r1X6tLJVxJzfGnz5+hZETjTBbZDoanw7mqfJgc5cpyxC14MGztmb
 KrpJiwud/yEMIfOCxogZXzXRqIHsvl+4lewX2NUwX6PP/uDsaqal0u4pC
 SZx1ljvh/iwMd0WzGXDe9Na/Fo/EkJDXC+VtGbXgxpVT/4ZRRLdGxEPAw g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="22229864"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="22229864"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2024 20:26:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="15594103"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 10 Mar 2024 20:26:05 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: [PATCH v2 29/29] target/s390x/cpu_models: Fix missing ERRP_GUARD()
 for error_prepend()
Date: Mon, 11 Mar 2024 11:38:22 +0800
Message-Id: <20240311033822.3142585-30-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311033822.3142585-1-zhao1.liu@linux.intel.com>
References: <20240311033822.3142585-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.10;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

As the comment in qapi/error, passing @errp to error_prepend() requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
...
* - It should not be passed to error_prepend(), error_vprepend() or
*   error_append_hint(), because that doesn't work with &error_fatal.
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.

ERRP_GUARD() could avoid the case when @errp is &error_fatal, the user
can't see this additional information, because exit() happens in
error_setg earlier than information is added [1].

In target/s390x/cpu_models.c, there are 2 functions passing @errp to
error_prepend() without ERRP_GUARD():
- check_compatibility()
- s390_realize_cpu_model()

Though both their @errp parameters point to their callers' local @err
virables and don't cause the issue as [1] said, to follow the
requirement of @errp, also add missing ERRP_GUARD() at their beginning.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: qemu-s390x@nongnu.org
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/s390x/cpu_models.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index a63d990e4e8e..1a1c09612271 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -503,6 +503,7 @@ static void error_prepend_missing_feat(const char *name, void *opaque)
 static void check_compatibility(const S390CPUModel *max_model,
                                 const S390CPUModel *model, Error **errp)
 {
+    ERRP_GUARD();
     S390FeatBitmap missing;
 
     if (model->def->gen > max_model->def->gen) {
@@ -566,6 +567,7 @@ S390CPUModel *get_max_cpu_model(Error **errp)
 
 void s390_realize_cpu_model(CPUState *cs, Error **errp)
 {
+    ERRP_GUARD();
     Error *err = NULL;
     S390CPUClass *xcc = S390_CPU_GET_CLASS(cs);
     S390CPU *cpu = S390_CPU(cs);
-- 
2.34.1


