Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E62C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 19:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbmk3-0008RO-Ly; Wed, 07 Aug 2024 15:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjs-0007Py-Up; Wed, 07 Aug 2024 15:54:30 -0400
Received: from esa.hc4959-67.iphmx.com ([216.71.153.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjm-00024f-2t; Wed, 07 Aug 2024 15:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1723060461; x=1754596461;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ibwgwBa9pkwRbtz4M93TlKUDDvjjK+tdjN8PsRms6Co=;
 b=W8lOFW8+ZXNntaPLbck6NkRDOFlM0Mq8aUzCDsj7zH81a/iZdwCFS/Ib
 M6PxZhB4UNUO6VdVSCM0MQOeZKCd0ymrmzAsXX1yqQCDnVoUgfCyCTqUY
 MaZgwXSUOKYJ6FDX82QGCqzTJcc64093Q1f1Eek0FVJZzrGY06cCTsaj4 w=;
X-CSE-ConnectionGUID: 6REMsjA8RbmPCZCl2Wy+mQ==
X-CSE-MsgGUID: rGzxA+NbQomXYmLZQ4aCxw==
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2024 12:54:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlTPEiCP0CI0FMMD2XoHAdbCByGPBmkT7KNaXF/09FedETu20omfhaemJFFvOyN27aS02DksEmbuB31c+dURv9FzAkkB7hs9JW9q3V6EkECXvEC+YjQ/iO0fwdBfv4l0jL4u1CTdZI4QAtpq7C8GbDUG/hbGughEro6ih4nG/1Qo07Cgr/RbbLKBI25lFlSuYBRdBSvVDsh4Bjqialza26hRYlOKIeqhbRj+md0reXuYGE8D0v7DnEoGSMo1sYV1DK/ENZmpicgFyPyC18QtIkGyUeofl0S1Cs4HffiEjU1gsHFeYcim3ECffr++cJTbOGm/hIih5poS/ZllBLiydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKE6AiOdm1mL3yH+gTCq2JlGvZUixH5hbD5RCyXVWgw=;
 b=BOyFgC2Hn/eYHZT12oZQCIuKFZGTnVTdbTB0bUvo3gtkwxaJ3BrG80nI7nuZOJHm1quUzo8vg36o/x1lHKcfvzRjxRmOnqlU2bmOARBYUnXg9dCzgJV8ks9bdPw9s458GmC76J4KKEe85ygqiT7i6FkRjGOTJ6I3kkc8O50UUG7Sl600L9t4+seKdZ2v3/BCoTiXb2N7rhxrf2rw4yZAA2cMB8B6Bpi35eeqhauxidcBMkUG7MkeLubBYM6zVHIeY+wrC5mT/NRr1cghUr7UhRedG+mjGDA6yDW0ewD+Cqmgh+i1Sz/YvEeDgB1IGG4BTqTMH1GZGt3LYb3GCXBGBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 192.55.16.51) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKE6AiOdm1mL3yH+gTCq2JlGvZUixH5hbD5RCyXVWgw=;
 b=FhkPdYPesz9z8sHw5tWsU6jS2lYPx+UR03zqi5osYx/+EkV40dGmqtFUOT15OiCFduOXgK4iv3SGXmIbZVOw9pjGIheF1xf/K+Je+gvDGCDO4Z3IXGyrtCsHzk8IRwk4bZONonJaEOclkxzTK4QbDkW2k1MWueqyjuzJz5iAZzk=
Received: from MW2PR2101CA0019.namprd21.prod.outlook.com (2603:10b6:302:1::32)
 by PH7PR20MB4483.namprd20.prod.outlook.com (2603:10b6:510:125::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.30; Wed, 7 Aug
 2024 19:54:15 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:302:1:cafe::e) by MW2PR2101CA0019.outlook.office365.com
 (2603:10b6:302:1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.7 via Frontend
 Transport; Wed, 7 Aug 2024 19:53:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 192.55.16.51)
 smtp.mailfrom=seagate.com;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from sgspzesaa002.seagate.com (192.55.16.51) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 19:54:13 +0000
X-CSE-ConnectionGUID: 86saOjqGQTylghDf/Yx4xg==
X-CSE-MsgGUID: ehR1YJFlTFOJAepassdZmw==
Received: from sgspiesaa002.seagate.com ([10.4.144.53])
 by sgspzesaa002.seagate.com with ESMTP; 07 Aug 2024 12:54:03 -0700
X-CSE-ConnectionGUID: G3xlsgXsR0G7bncltrIy8w==
X-CSE-MsgGUID: KK1+qEnHQqGmqQD3olsrkg==
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="122235491"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by sgspiesaa002.seagate.com with ESMTP; 07 Aug 2024 12:53:55 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 13/15] crypto/hash-afalg: Remove old hash API functions
Date: Wed,  7 Aug 2024 19:51:20 +0000
Message-Id: <20240807195122.2827364-14-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|PH7PR20MB4483:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 68b575b1-d6e9-4a44-559e-08dcb71ab6a2
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s3sQLk66gPdMhAWid6XYqwsuDrQSCdoAvpigK67nrEW/KJYeQHLH4Dj19T1M?=
 =?us-ascii?Q?iretJDzm4nWyCZMlvtLFcyJWlVhHBLZIyn9wAXeGXAliXdg8Eak+bxSe66D8?=
 =?us-ascii?Q?nbc4TraT+k1TgYyNRyHZ/Cgml0PalF2kFc5uSS76tE863ZgXAkKOlp0N0sov?=
 =?us-ascii?Q?MWZ8ZLjozDU7K/8eSFYs21hMPsEpV5JqRTpYJdv0c1wCxlFtiAnixY2ZTuqP?=
 =?us-ascii?Q?bALLHLykJtqmd73SlSZdSW6iduDtwdI/pffCksvWDTsZxZ18rp2n+GdGKvmT?=
 =?us-ascii?Q?ynus8/+O2Hpqq6aRBf9WVJaSInl78MWBlgcpex4h6VXDthSaiqWrgbLhwI+W?=
 =?us-ascii?Q?3UikYsDUu/inEBuCaxia7NP7nbuIBlwlhcgrLA7pIiAdY7BfO6OORWD8vAhg?=
 =?us-ascii?Q?/PXz9Si471mJhlTqNGKZRO4Fn8u6g3IQ9J3JFHIS1kbVGGDQ2q/jJb5+0Fs7?=
 =?us-ascii?Q?ujBLk1QvHUQbC2vWAnom5PtUxx9i2odmEdepOMi+Bpn8S5GJ54Jq1e4o7Rl6?=
 =?us-ascii?Q?dbhFPYLWqs5ni7V/3jaU2L9K+HpE3D/rJz7z37hAxnpVc0l7fdmQLZDdQnWo?=
 =?us-ascii?Q?5dsfcyuNWndihE/jF8SR7KgTqu/R5IWlzjtHAuBmIBpF8HIld9GhQ1ks1oV3?=
 =?us-ascii?Q?8Nwgp0aewh6eaqQmBcDgrtm80stjmVxmZcBDBXU9bygH1+6DBdcRPyI1Btqo?=
 =?us-ascii?Q?pgTEwjQTEeUj/uIqSFxXEoU/5oM8PSjx7OTD/smpors+475OS6By2lY6Ssk3?=
 =?us-ascii?Q?bb94vp6Ay2QtMqFgdUhPZ+Ajq7UM5qOWshTLT7GzYadBiL818CassqCI730P?=
 =?us-ascii?Q?tpzU/CoBs7Ww+PGutBLL9Y7nRaOKqhke5aVsLP9g2L3QNkxlHd2QTPl4WjnQ?=
 =?us-ascii?Q?B1ZAxBgrjze/q98/Ti1sJlwb6drayDOy01AWjl4X9Oaknft3OtoxVxLSzXkF?=
 =?us-ascii?Q?T6iO4p5IusHPMFhqDX5eXjoYVbD0N4iOrsf4Wt3745cotziIPm5DtzK9MT+i?=
 =?us-ascii?Q?4jpZTbn6Honv3UghLuwN3ETt3QUupQRUIpZwlxIUu+uEQpECLGl5nVME5wlC?=
 =?us-ascii?Q?c9DdfXcxItAbC9ei3FtO5S/0KlXPGQ75enh7KOaxVyuxnLHaALCqrk39nyF8?=
 =?us-ascii?Q?D3/lnwKtqMpnsHKHpYQ5EmiftQEE6HxnswhUu1pA57Le/EA1Suw4nb3dxov5?=
 =?us-ascii?Q?Gr9Dkt47IfkWSPKcqAef5CSFaWYJRwqgQhIY7u2ncFgvEF99YRjfLS428i00?=
 =?us-ascii?Q?jY1KE1eieIGoCRONhIXIldVjni2gbuScH2hPQSKd2CbUsqs+FABF9JRd+GkI?=
 =?us-ascii?Q?Z6Ye5IifQfBKxSHAkWOPXORe0IHorRIYpJuLiChVk8Kq2jKdCRo/ZhdzcGFH?=
 =?us-ascii?Q?N7UzXCrBxcrcDDwFxrhHm8tGEksjegM9RDvAPV7GcAmirPDLRT/ZVelbHjhz?=
 =?us-ascii?Q?PJhCivQtX2W0jzRRaVq/rROyJwhYtZY7?=
X-Forefront-Antispam-Report: CIP:192.55.16.51; CTRY:SG; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:sgspzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PLMDIeHIKgygMba99AN2/c1e0q4rfDJxxHee+9ojG+E8qD/qssvPxtibE8M7gZtFwmSsg2WrlJ01nb617EBrDbKGBo79HuVXhgdh4nIjIwg3cHuKkUapvt0oF94dIX6bBFl9wikeCnnxOIOt7+UYgDS4aialnISshfuV86Jj2JLCeXV1wstWH8UI4OFDflOfctkkyA+E+SgytutVVTPE59gYSj2bAHAsppjlskK3XeYg4JytyFXQ/BYroIdCja44IEQ0g/SSxeACjnyomimteXl95IYbxlMlEwIF6Ufns34CqxUjCj56FWM7hRw5AmcV2nq7uIo/nN1xUQNYUKtGJrdUBNT8fzAwpGIPbvS9LsXkJnTzN9KRaJCVcYfAtNl7qk0Q4wxA/VcvoJkjChZZSbcO95byC91AQ7YznVRQpX01DhMDP3IwPmCdY2giHmWWxJpljjryU/Rf7yF4bOSXPFXXdSHCrGIAByn4GLIgU3k8HUXPdMCrJTaex39qIP6t9F1eZcFpo+JgdNd/SNQeRwDuH8y+PAaeL9AwNifHT8+B97PoXq0rlxi+GtPT5B+9o5+L1glKaHuEy1/DqdRgLWC3dHio5TiT5QdvwIz5nllMgN6hATfG5F7eK1O2XHz7
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 19:54:13.4017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b575b1-d6e9-4a44-559e-08dcb71ab6a2
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[192.55.16.51];
 Helo=[sgspzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB4483
Received-SPF: pass client-ip=216.71.153.94;
 envelope-from=alejandro.zeise@seagate.com; helo=esa.hc4959-67.iphmx.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Removes the old hash API functions in the afalg driver,
and modifies the hmac function to use the new helper functions.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 crypto/hash-afalg.c | 59 +++------------------------------------------
 1 file changed, 3 insertions(+), 56 deletions(-)

diff --git a/crypto/hash-afalg.c b/crypto/hash-afalg.c
index 9548c04933..351f931995 100644
--- a/crypto/hash-afalg.c
+++ b/crypto/hash-afalg.c
@@ -243,68 +243,16 @@ qcrypto_afalg_hash_hmac_bytesv(QCryptoAFAlg *hmac,
                                size_t *resultlen,
                                Error **errp)
 {
-    QCryptoAFAlg *afalg;
-    struct iovec outv;
     int ret = 0;
-    bool is_hmac = (hmac != NULL) ? true : false;
-    const int expect_len = qcrypto_hash_digest_len(alg);
-
-    if (*resultlen == 0) {
-        *resultlen = expect_len;
-        *result = g_new0(uint8_t, *resultlen);
-    } else if (*resultlen != expect_len) {
-        error_setg(errp,
-                   "Result buffer size %zu is not match hash %d",
-                   *resultlen, expect_len);
-        return -1;
-    }
 
-    if (is_hmac) {
-        afalg = hmac;
-    } else {
-        afalg = qcrypto_afalg_hash_ctx_new(alg, errp);
-        if (!afalg) {
-            return -1;
-        }
-    }
-
-    /* send data to kernel's crypto core */
-    ret = iov_send_recv(afalg->opfd, iov, niov,
-                        0, iov_size(iov, niov), true);
-    if (ret < 0) {
-        error_setg_errno(errp, errno, "Send data to afalg-core failed");
-        goto out;
-    }
-
-    /* hash && get result */
-    outv.iov_base = *result;
-    outv.iov_len = *resultlen;
-    ret = iov_send_recv(afalg->opfd, &outv, 1,
-                        0, iov_size(&outv, 1), false);
-    if (ret < 0) {
-        error_setg_errno(errp, errno, "Recv result from afalg-core failed");
-    } else {
-        ret = 0;
+    ret = qcrypto_afalg_send_to_kernel(hmac, iov, niov, false, errp);
+    if (ret == 0) {
+        ret = qcrypto_afalg_recv_from_kernel(hmac, alg, result, resultlen, errp);
     }
 
-out:
-    if (!is_hmac) {
-        qcrypto_afalg_comm_free(afalg);
-    }
     return ret;
 }
 
-static int
-qcrypto_afalg_hash_bytesv(QCryptoHashAlgorithm alg,
-                          const struct iovec *iov,
-                          size_t niov, uint8_t **result,
-                          size_t *resultlen,
-                          Error **errp)
-{
-    return qcrypto_afalg_hash_hmac_bytesv(NULL, alg, iov, niov, result,
-                                          resultlen, errp);
-}
-
 static int
 qcrypto_afalg_hmac_bytesv(QCryptoHmac *hmac,
                           const struct iovec *iov,
@@ -326,7 +274,6 @@ static void qcrypto_afalg_hmac_ctx_free(QCryptoHmac *hmac)
 }
 
 QCryptoHashDriver qcrypto_hash_afalg_driver = {
-    .hash_bytesv = qcrypto_afalg_hash_bytesv,
     .hash_new      = qcrypto_afalg_hash_new,
     .hash_free     = qcrypto_afalg_hash_free,
     .hash_update   = qcrypto_afalg_hash_update,
-- 
2.34.1


