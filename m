Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84900C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 15:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb017-0007rf-VS; Mon, 05 Aug 2024 11:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb015-0007j7-Ik; Mon, 05 Aug 2024 11:52:59 -0400
Received: from esa.hc4959-67.iphmx.com ([216.71.153.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb013-0003o3-QP; Mon, 05 Aug 2024 11:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1722873177; x=1754409177;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yBUuwYe1RumimG7s1APfwYRTHe2/dVbSy6IAO5eoAGs=;
 b=Dy8tka0Yc8TUMVLRbN66boWM2Yo+2+kRJyR3aQAfdUJQa1Ah1r3HwVA/
 MeRBQWejV937kl9zti3cBj0vy0C9nsAFDYs4z11jxhh5/TwzQiTkrXC1d
 E3f6z3zq4DJXtMIkergcxEde+0a4qlebvk0CXzQ7Qdb5Qmmz6IsH0lGhO Y=;
X-CSE-ConnectionGUID: wX//03nyTlGTJ9S7RMqhZA==
X-CSE-MsgGUID: GPR/6rbZTmOuE5pty/NrWA==
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2024 08:52:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+aMH8XaDttC6/X9mQAYLcsmF2Gbq/SGjA1o9E7W08CUdGZP9BBC/ZckToGrhASytVihDqNBgCj8sLGiWj/z8/9J+23HO+xj9QWSoQeP9lJqRuQAswOoya1GNdSzApUknFvsa+nLiOtKHIDekQTLKGPMri0CfHNUT8ZE/SRz0vsIhpjZ49OpONYn05bDPU9iURNF7bIB8OsQzeR/+VaNaTPCJAm53CKQMbA/pBxZrJ8ZhO0UUZrIKuUWqA2hqx2/zPLqsV5OPRqFzi3C6VIDYiYJb/n579kD4PR0NEPsIkcTTWfXGEL2ltlfEHj0BE0sX3LpvFlCGw7hG6VaCM+nng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuIWH7hKv3rHqAI1K7OylgWYSlekB1h/ulCjPBW4OZo=;
 b=vtZOWCx1T87W0WoqI0hNjwb5P/4KF7A7NLhp0SQIA1pstmCaiS6yTc4w2bsrulykmmmmrALYaZ0GYb4yUA84UyVwcD8S+0Ku4EDRBkx2pj1HFZlPTl9g7GC4HQpALbdhCL/m/WVfvCvgJ+0vcgGosTCahc5nbRGf4WbDbIh15TbHZ8fIGNKzTt76hv0FLoOeJLReZzfwLDiz7d6aWFGV1Ay+cDMsr2maxPigYZU7fPtqccelYRClAqqGHDT5c1RhDnm/HyVeQ1OIgAyCTuJ1LbociCdfI133SN4RpmuWKca4jJaLasjgtVMd5wah4W5aqBZ3x+LV7Mvot9g4g6PN5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 134.204.222.53) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuIWH7hKv3rHqAI1K7OylgWYSlekB1h/ulCjPBW4OZo=;
 b=FpoZC6a7khV+1V/o+0VUelX1wLyb8oDbhshmeRb7q1OJzniM4irDqllEeyMnPLwQMde/XYT2cf6krDFM+EJi/9nky88Rb1zNGZj/hyFHl6SmYsnQNzKKPLqu9hhUIfleao3G4j4axA5lCFSIdb2LGEe3QU5Wc2VVjg2/9N2riug=
Received: from MW4PR04CA0363.namprd04.prod.outlook.com (2603:10b6:303:81::8)
 by DM4PR20MB4968.namprd20.prod.outlook.com (2603:10b6:8:8a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 15:52:53 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::f1) by MW4PR04CA0363.outlook.office365.com
 (2603:10b6:303:81::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26 via Frontend
 Transport; Mon, 5 Aug 2024 15:52:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 134.204.222.53) smtp.mailfrom=seagate.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from lcopzesaa002.seagate.com (134.204.222.53) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Mon, 5 Aug 2024 15:52:52 +0000
X-CSE-ConnectionGUID: NSBIonBsQFCkh9H4MlTsdg==
X-CSE-MsgGUID: yR2Yd2e/Rr241zJRAlRhuA==
Received: from lcopiesaa001.seagate.com ([10.230.120.52])
 by lcopzesaa002.seagate.com with ESMTP; 05 Aug 2024 08:57:44 -0700
X-CSE-ConnectionGUID: 3VAPqAfBT+ersI21d+pulg==
X-CSE-MsgGUID: mjHBWRNqQDKi4vRROOg+lg==
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; d="scan'208";a="106920681"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by lcopiesaa001.seagate.com with ESMTP; 05 Aug 2024 08:52:44 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 02/12] crypto/hash-glib: Remove old hash API implementation
Date: Mon,  5 Aug 2024 15:50:37 +0000
Message-Id: <20240805155047.3151540-3-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
References: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|DM4PR20MB4968:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 51303e72-7571-46a7-d8d1-08dcb566aa76
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NN3geoq9ZSq1gbi/6D8ZNs7W8IPjlXuXYUK1Kip2jPTJ6nsGOrgmIgXhTQI+?=
 =?us-ascii?Q?L/B+eeWR2Ee6LyhhJCou2tMCYOdsUkJ4NQ5SIUYL1SyJZ4MpalIix79mF7d4?=
 =?us-ascii?Q?6N2wid6Ip6xfc7zC8sQtZBlje4EasTZkubvY231OgdWqd/74iUbak1JOVRLe?=
 =?us-ascii?Q?OsNoo7fIxjc+X/NtpbGf6KFtGS/6xPG+lvOnzivA4rX8/OXw63GbvhPlT0C7?=
 =?us-ascii?Q?VcxmR+QZs1oJz54ALzABGhcnZTwXiV+4z7Tl3UjppyVE16ee5PAQ+jm46hLk?=
 =?us-ascii?Q?JP2lY+RIycM61KTEST14AZQvRzRFhL1feMXkobofpMu1Obj3VtkbYVZHuZ9c?=
 =?us-ascii?Q?HZSImbBe2u/ms+QEv49rFLvhHJwRAemSuLpuK9SteUwWjTPebzors0/gJGxt?=
 =?us-ascii?Q?FIt9zApIZzDHCLExmBjPirO+Q7ZdnFrEsiqZls5s6OWewUD/Q6N40+OrGRi4?=
 =?us-ascii?Q?CFJ7b7xnliJygO0c2+hPaaxrPDoQrX5lWv8DQxtP6TuCtFPt1MqWy8deh7hL?=
 =?us-ascii?Q?NbzXHg8Jy6zr/XHfI1YCIwdfw7ZxAPmyixzQJIXDJdt2PNTYD/SpHfolNNTq?=
 =?us-ascii?Q?sLd7bs3QSVzpqElUBqDiVnLP0aa8Ggc+zXl8WybputiRjcNfoYXrZZBFrK3z?=
 =?us-ascii?Q?dqqPyw51WeBytgNxsuu4JIRiozIAzK/o4Je0zuyqFr5jFH1aNXF/RHxiDDRq?=
 =?us-ascii?Q?rF701lXkYQgWzHZiny5aZ+gUmc/QAvD6w8/zf+EKZG9YcRs/DFFe+4hSMsAm?=
 =?us-ascii?Q?hR8hhK1mSzDy+uKom1nRCeX+dpa3rsHJ0JLuEKZ8rUr8hPE2JnfHX6igbBqg?=
 =?us-ascii?Q?i9cF+RRdm3nctOSkLT4SaSbfqVSybEuZQi/wWhkZSggzeV4zuXmeujsrfTHx?=
 =?us-ascii?Q?gs1k9b67hJTwfok3Z2pM2K+iW4tJ3r9seVXArCRHm5iTSVcdc/3KYGYuaL69?=
 =?us-ascii?Q?CPYn22DEvW1a35wJXsyMrPjtCV6U2Z7c5O4/LOu+VojMN3LhdpilL3QsJwiI?=
 =?us-ascii?Q?GV6ll0artQspyYpLe5mP9D31/H+FEaBtwGGmlkqSxaQDhRS8ecsVuwvcln0S?=
 =?us-ascii?Q?DKz/ENpTTtZAGsQMvcL4PF2htNWhd8IxL24pgFAeEaBqseo4j4+LhKv+8d3J?=
 =?us-ascii?Q?QTUgz//o/3ohPCH4uTeJAbmikDTgxiZXnS8F60D36JePkeVwc0jqVDUhbgYC?=
 =?us-ascii?Q?0eLf9oHO5bRmH94t2zdFITUyxNWJtVVKwSskSoOr1E1es9bKmcbOhHCsyy4Y?=
 =?us-ascii?Q?PodG+ucyMYZamyxQn+w+uAngTXfFr0u3X1wJtdQV8ORYeyRUU+HMlPmMI98Y?=
 =?us-ascii?Q?3qlol/JIKvwCvZNWOO6tPTDeMiogPKNs0JekGO3uJaBA9JZfEd8iuuEMShe1?=
 =?us-ascii?Q?gqrM9pJjMpZMofMNJwVWgMcJ2nTeWw/JDzcpWPolYTaFt8r7JDVbN7MXgLD3?=
 =?us-ascii?Q?ukH65LbKyIflQC1VwU683OfZkoDGDEK5?=
X-Forefront-Antispam-Report: CIP:134.204.222.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:lcopzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +KVWFSuiKDhInNdSUQXxCeSwUOGXJBM5CAjwwmq3ofp5zSplQaAuXFizRv7eMJnNMW/KI02JJM1AOFzViEFriFAFkbi9+iPpffOAoCry118o5wfhh9dj2Pi9ZpjZhvPNs3jogkq9sfkLYfwrkv3l5tAAMPUyXTA8i/TdmVZO/sPsyf+rVSihlmFJq7HIXlMaIX77NusW3nGIPZvvm35hj5VDQJF8u52QY78OJgdBjet5IsCIKLQ9u/mIAD20n1Gd4li6DILmXgKExg7rA01lBZURF8yEoqjQa8fKaid0CKMmbo80euZd+gWkdwA/5WUbieN9O4mw/ubeRcopg6eymgW+4zVvyvhwIkbRc3ik+6VvEsTiekQif1GkMqhPMaA6lelhfL1sRFxd2fR5lmN2FSrEUybbUC9rQc6ZwqVzUm9TTWV5+fdbq8npipDp4LwTHsgD84RYI+5R1MLD/DFVN40q3Rc38B1L5uK92zdL0F2iup197+5tQWDHWg1SbFsAnfku42RDEpT8QRA7ChpFfm8WpSB3vB92/han6UxmRtCJgb85bfb+ndWaRfgzgJ4qpUOeYFCHNLsaYh8wq1RvnMwof2caaF+R1uktl+eIQujBLrJC7CETcApaysilYlzq
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:52:52.5662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51303e72-7571-46a7-d8d1-08dcb566aa76
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[134.204.222.53];
 Helo=[lcopzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR20MB4968
Received-SPF: pass client-ip=216.71.153.94;
 envelope-from=alejandro.zeise@seagate.com; helo=esa.hc4959-67.iphmx.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Removes old implemention in the GLib hash driver. Will
be replaced with a new implementation in accordance
with the accumulative hashing changes in the patch series.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 crypto/hash-glib.c | 53 ++--------------------------------------------
 1 file changed, 2 insertions(+), 51 deletions(-)

diff --git a/crypto/hash-glib.c b/crypto/hash-glib.c
index 82de9db705..ceaf346bf4 100644
--- a/crypto/hash-glib.c
+++ b/crypto/hash-glib.c
@@ -1,6 +1,7 @@
 /*
  * QEMU Crypto hash algorithms
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (c) 2016 Red Hat, Inc.
  *
  * This library is free software; you can redistribute it and/or
@@ -44,57 +45,7 @@ gboolean qcrypto_hash_supports(QCryptoHashAlgorithm alg)
 }
 
 
-static int
-qcrypto_glib_hash_bytesv(QCryptoHashAlgorithm alg,
-                         const struct iovec *iov,
-                         size_t niov,
-                         uint8_t **result,
-                         size_t *resultlen,
-                         Error **errp)
-{
-    int i, ret;
-    GChecksum *cs;
-
-    if (!qcrypto_hash_supports(alg)) {
-        error_setg(errp,
-                   "Unknown hash algorithm %d",
-                   alg);
-        return -1;
-    }
-
-    cs = g_checksum_new(qcrypto_hash_alg_map[alg]);
-
-    for (i = 0; i < niov; i++) {
-        g_checksum_update(cs, iov[i].iov_base, iov[i].iov_len);
-    }
-
-    ret = g_checksum_type_get_length(qcrypto_hash_alg_map[alg]);
-    if (ret < 0) {
-        error_setg(errp, "%s",
-                   "Unable to get hash length");
-        goto error;
-    }
-    if (*resultlen == 0) {
-        *resultlen = ret;
-        *result = g_new0(uint8_t, *resultlen);
-    } else if (*resultlen != ret) {
-        error_setg(errp,
-                   "Result buffer size %zu is smaller than hash %d",
-                   *resultlen, ret);
-        goto error;
-    }
-
-    g_checksum_get_digest(cs, *result, resultlen);
-
-    g_checksum_free(cs);
-    return 0;
-
- error:
-    g_checksum_free(cs);
-    return -1;
-}
-
 
 QCryptoHashDriver qcrypto_hash_lib_driver = {
-    .hash_bytesv = qcrypto_glib_hash_bytesv,
+
 };
-- 
2.34.1


