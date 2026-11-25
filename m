Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4850B606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=Xt6dEb4+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWEdV-0006t6-0d; Wed, 25 Nov 2026 10:10:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWEdS-0006rx-8N
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 10:10:14 -0500
Received: from mr-2006i-snip6-11.eps.apple.com ([2a01:b747:3000:204::5b]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWEdK-0007UV-Sg
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 10:10:14 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-3 (Postfix) with ESMTPS id
 6CA411803019; Wed, 25 Nov 2026 15:09:59 +0000 (UTC)
X-ICL-RepId: 01a21341-a6de-7044-a22f-7cb88d9a9101
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1795619400; x=1827155400;
 bh=wYOS3pSSlXXyqdlgT1zcD1HzILB42eAVzbUlqTedvLM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Xt6dEb4+2BVYd5T48X6YwtiqjAQ7C46aPz11KwT9Al7lRhN7Pm5rWeSEDzU3ZJNYhMMeaJSQvo5pGN2AEDKF8Ab0zsLJwJuQFpBiCBvx2TIUk4aBgmAxf4EMqnkIyyITT0Cyloo2bSNPeKAXRv7WIZqh/WJ631epW3cxkWyxjGGGhwAZvlKCXNudDRI8crsNIN/yoZ/lwyxOsrc/0XnEpD3/RTpSpc38xMT7HUsytLcLEtzpGSlqgvDXd1k4I+XodOQkhV6wkVr7VxIKsLD+WeZgOSWHNzM+NQS16HniWWGVCH/00I1iNcqQf0wtYuT8rSEp3BhtFmS/970uW3L1xg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-3 (Postfix) with ESMTPSA id
 418BF1801DB2; Wed, 25 Nov 2026 15:09:58 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 2/2] whpx: i386: make nested virtualisation init failure
 non-fatal
Date: Wed, 25 Nov 2026 16:09:52 +0100
Message-ID: <20261125150952.48332-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261125150952.48332-1-mohamed@unpredictable.fr>
References: <20261125150952.48332-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Qp3LTlyd c=1 sm=1 tr=0 ts=6b06fa47
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=wbbCu9YnSpm8ZdSLOl1R:22 a=x5V6o3jQhs1ZutABD8oB:22 a=p0WdMEafAAAA:8
 a=p5XUOwc6s_shZ6Vv324A:9
X-Proofpoint-ORIG-GUID: T2OWEmQ2vjO8y77gn5mFKS9f4PpRNGDM
X-Proofpoint-GUID: T2OWEmQ2vjO8y77gn5mFKS9f4PpRNGDM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2MCBTYWx0ZWRfX/hhVrSuYA/rN
 AZsweuj+KHD0gC0/9KrSPN7dqBPgdd3RW4/qNTtkYE+UPkpQk/iKLLE1VVE623V6nn9K4/RNQ5H
 YCIlKB9RiXz1/OA5MKTy72Vhcomw4JA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2MCBTYWx0ZWRfX7MAhiw7UBxMl
 MGPpktdYqzWPpxUgqWbsZWlWGaMfF2dbJXt5u/6ucuS0vA9jzpqEeoGj3Fp3YZpwuLeEGh+z3O2
 819TiZo5Ha5satZm9Iux+r/F+hqOVpUVoUUO63ZQUEbW1sISGwF061brgPpF5YKoos4u8egHmLK
 v+9aXE754LrO0Li9pYrdhc7rV0toCPCZEqrdsyrgaJnxJdI6gmGgqRA86acnaPGscfpTwX3B1ph
 FOW1DaJYBw/czQaSxEqGSwAhSi0jracGkKqyJCMJ1z8Yz+StBiA/Qgy+8Sy5dXnTUvjxYYo1fC2
 sUSXWpGkXEofqMdXnbF7ollsnu3ulpBbfA7rOeYabU8sqWUG9hz3zj4pe2Ir6A=
X-JNJ: AAAAAAABxCyb9Rdp2v5Z2Eom09XlbIJuSlgF0O5glVKCJgzNlqVZJiydjNGebxX3hkEHqZ
 NbshpvB5ODU7h/PP+fHa2sUADES3oEP5iGtdO7yEgPZsR0R8RSoVsIDOsmidQZrb6CYXHL
 XmlHKjenUF2SOQO6IEUQosVKV6yftCTutee0sSQg6LmLJA48NCzh7LEKFZzqS5CPLH6Ymr
 gQotrHTp+Ybmb3Ehom7v0I40oh26ATj7gVDrsH1siRMJ0zBJjiFZlfcUyZrmH24OlfLL66
 UdJ0KADE7HL+ynJV5qAycgaGKVcjeWtg/yTEQQ4OO3glT9OcRRReAeN0iYaIJdxaLoQOj/
 a5jNseuqE18OQ92ge/xSVM+nN/WMI83Rap1T6UWfuMN0wFLXxBOX+/r1xXnWZvpTZuRzKH
 45IN/ivr1YMiM7kScVgCaP1nrVggcSwk28aFWrp0hcuMv6OgmUZqtjqDy6SrQVUInQMp0l
 lG0xOcVHfgIpa0DH6RXcGUWkujBShyGEYJ3ZDgx2eTY4siHFa2QPved9CJ79rAGBYO5fcP
 hk/obiuF5yGjOypwCuYiTJyi9GGdmwacQGXRvOWDbHIxzRSagNPOG+zVN+a42ZzPd4FRWN
 u8LzSrkus5IH1ZRh0OuoQDK3vfAgeQ70umkzp5rGqsy1O8Vm5/PyWdHNNb01vcCCb76SFt
 wo68631sO/1SoGcgEWUr9QZ+rcqOvMQ3kJ3pc4iTKyhu5VT/rFmC/AInuPhqLg==
Received-SPF: pass client-ip=2a01:b747:3000:204::5b;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On some CPUs too old for Windows 11 (Skylake) support but running
it anyway, WHP advertises nested virt despite it
being unavailable.

As such, make failures to initialise nested virt even when advertised
non-fatal.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4383
Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 6c6af6c4d5..7731d672e1 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -3300,9 +3300,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
             &prop,
             sizeof(WHV_PARTITION_PROPERTY));
             if (FAILED(hr)) {
-                error_report("WHPX: Failed to enable nested virtualization, hr=%08lx", hr);
-                ret = -EINVAL;
-                goto error;
+                warn_report("WHPX: Failed to enable nested virtualization, hr=%08lx", hr);
         }
     }
 
-- 
2.54.0 (Apple Git-157)


