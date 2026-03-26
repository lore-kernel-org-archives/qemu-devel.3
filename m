Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BEF109C047
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 07:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5fMp-0001LI-LZ; Thu, 26 Mar 2026 03:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w5fMn-0001KV-Ng
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 03:42:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w5fMm-0003OS-60
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 03:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774510975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cVIlzVVU0BV2W/zlbX8zJHPv6yoJcAsAC9Wkm7xhtBs=;
 b=Sv3NL2IiMhfvqrZYCSyJOolimjn+S+weCaF65dMRNbLF48EU1EZj+TbsMz27ba7FqpEFwp
 06fxSgpga/4S4rpICkFoBMgu+z21FyqWCJaCTSuZ4gFeyJfIWpsjxyS/4YfLA/5L5nDNrD
 0xyExZZtd6RH88r7QgkSoYVnUYky9tY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-PUdOWBFkMPa2DqqqatG1Eg-1; Thu,
 26 Mar 2026 03:42:51 -0400
X-MC-Unique: PUdOWBFkMPa2DqqqatG1Eg-1
X-Mimecast-MFC-AGG-ID: PUdOWBFkMPa2DqqqatG1Eg_1774510971
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E98A118005B3; Thu, 26 Mar 2026 07:42:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98BF219560B1; Thu, 26 Mar 2026 07:42:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DC36E21E6742; Thu, 26 Mar 2026 08:42:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de
Subject: [PATCH 1/3] migration: Fix up error message for max-cpu-throttle
Date: Thu, 26 Mar 2026 08:42:45 +0100
Message-ID: <20260326074247.188674-2-armbru@redhat.com>
In-Reply-To: <20260326074247.188674-1-armbru@redhat.com>
References: <20260326074247.188674-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fixes: 1a739d301232 (migration: Do away with usage of QERR_INVALID_PARAMETER_VALUE)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/options.c b/migration/options.c
index 658c578191..3eb5b39186 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1207,7 +1207,7 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 
     if (params->max_cpu_throttle < params->cpu_throttle_initial ||
         params->max_cpu_throttle > 99) {
-        error_setg(errp, "max_Option cpu_throttle expects "
+        error_setg(errp, "Option max_cpu_throttle expects "
                    "an integer in the range of cpu_throttle_initial to 99");
         return false;
     }
-- 
2.53.0


