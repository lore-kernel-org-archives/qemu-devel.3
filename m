Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07721C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2026 12:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdRsT-0004BK-0K; Sat, 27 Jun 2026 08:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wdMal-0003f2-OT; Sat, 27 Jun 2026 02:32:40 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wdMaj-0000vV-MU; Sat, 27 Jun 2026 02:32:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OP8qO/iFY0abvGhHEjZ+txYoAGRmEn1B21AN6EitbBlGahaOT+xOI60fSMXN9tuD4iq6NeQQVaRvLQ3Za7plC0Ey18d7rtxqqrtwn6uub5FrCM9HxnM78wGsLam/vFuDE49RVzsF34QvAK7yxIuh9eODZQB25GrU/VSP7ObCQnjqbXUdbmOG+TmJSam95OAbPzRQ/Y8i4RXP+Oh6XkW8WgmDn8Nlnn9CrzSzFxbryKB5ccqx/8+VROrhr3EmXxq3OkiE5uEMIMJfWtp7pt3KokYofMzpH8+gHf/+qWpWNN5lxvtHmPIqPKlQcfYTzDdQNzacaE8MRerWT0wwGVtCYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcR8L0WC/Ee3sh1/HeRViPr1GzlOHSGGVXj0ax8e8Dc=;
 b=DDzLSuXzSbutvSFZV3cl2pGgZfTOwtrpVHukHIlS14ekQv1tQRgZ3QdC3kaVy3imkC9DmwQxaComL0PNd7RM5eMyjR+/eFGNBI/usAE8j7D8pMuq/uI8Nut2cZ1mfNDEIeosK62llbdBqe3r89J34VrZud7Ysm4FZU5ke6cjJB+nlbOad/9QHQMaJguQXl5/7VbcW1RjIKI+Fb009Pi4iZbD229moDqFGcsSvwBs/ynoiB/aEmAGchM7WJauuNJkYDunC38ArZfrZ9NmIOckVuVTzxFldC4NRno8ibbx2CWE8hDslX2rUDPUOxU7y4b+aq8ZGtmRSwfbRrEpKcUOWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcR8L0WC/Ee3sh1/HeRViPr1GzlOHSGGVXj0ax8e8Dc=;
 b=M1GmuYT0OksQA2gsEqGfM0bCVVH7zblMrIXBaquDWGGD2jIfZUoKZV/fYsFi1CfjuPNKplckJ4Qp1zRTlGDpc4cUVg76Uy1GoMq6poSuovLIzAWuzFZt6Uxg/x+73VmNrmlDnPTHnOZkDMIWB4oAwSPjSawVHchu2wAOrVLeE68+h4FBhUoOhIkc3oonBrCgZS5F1YryGzpcIKyjpzplVh4meYs8RpcjZtj8+ilHl9l4iW7HZLM2wu2lYUu0bUVMGVYuvNVFt3+pTSIOG1ekZxnOZWrReRwb6oUW/5uCtuOMOJBnnxnhgxtpPa4hBb+W9WQhKi/1/lbv18gdb97Img==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by PUZPR02MB6234.apcprd02.prod.outlook.com (2603:1096:301:f6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 06:32:29 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0159.018; Sat, 27 Jun 2026
 06:32:28 +0000
From: Bin Meng <bin.meng@processmission.com>
To: qemu-devel@nongnu.org
Cc: Hao Wu <wuhaotsh@google.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Tyrone Ting <kfting@nuvoton.com>, qemu-arm@nongnu.org
Subject: [PATCH] docs/system/arm: Update Nuvoton OpenBMC image guidance
Date: Sat, 27 Jun 2026 14:32:08 +0800
Message-Id: <20260627063208.33642-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0066.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::10) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|PUZPR02MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df396c5-c1ce-4ba4-85a7-08ded415dbf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|34096008|376014|586017|366016|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: H39gWi6ijmOKVxrmzu8fRN+5TThL5bDR1G7Qg5hzjY47L/68YVVRDAbnRMxkylLwGhVP68PlczXeO83Z13bQ0hl3LKAVKUwMGew4bC2k/HWlG+ECOP57bG33Ea2fqvt9X5aK8mkwdwSnxUQOpzoOfRHNm5ayVP3ZpG8cOjKZhnET32QWervwws58S60USyK3mkRmvo/bwyE9luWVc9YPTFoctimd/wWDpOWVNsPVHyFwHoZ1zAn15HrUu7Ml5q/iQQIcAJifSNBHolSaGwZXieZOuHwMeNCKMpBo9ljyCxiipOK5gP7I7Qs9dgIbBqlsb8etEKQloyybURdxuPdEcdEuL52LMgzpUbZDkiS5GtNSEoLsVDgUPgLR0SsDj0xubNHoJvSGueyhKNhirIe0AO9HrWztwWA1BqC/pnS31YN7hX0wR2GmLX/k7I3I0A55fFlyoQ99Qb0FK5ruKiyAiB/HdDjK/ITTgnqCBPoLCCvR1CrGCN6oboQlKbR/0SqkxtnYXPEURSXnEUM45lIE4S8Trm47kiQ6GzdJ1vAYZNLiqfgLEVdUXAQTXKvl/xcjvF3YxVDBN3eOOMwO92/lYm0qBzkqv9PqhmiZa3KZS5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(34096008)(376014)(586017)(366016)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k5DEmbgc/N/XoAI4wh7OatrntD4kQw+lQkKe2T+IuWOEG1jr4ECflTeEDFv2?=
 =?us-ascii?Q?Se/LSYPrZe2tXXm2STSA5uwR8yyxawaj/XqX0ovKj09uL+84OHHgEdj0/u4F?=
 =?us-ascii?Q?59KKEWc8Ri5J6AFc7XsALBaqKIKxhoxVXcAekNOSzLVUI9yhyi7lJ/F6xZhs?=
 =?us-ascii?Q?LejuA/EVimCeZmZazcAuDiZHa2HSwu6RGm0PIOOf7iKdnKBLZRSWrxti8cO2?=
 =?us-ascii?Q?M9ognQc64WsobyGqPs3PrnflINnv6v50k7kKDV2KGrtRmnksUyo7ZW/ywqLY?=
 =?us-ascii?Q?IoGB5RKnjDvgftPYiSkj+NPTjrN+Wuh7v1evNEKmfonQftGvxB4JUFgxrx1d?=
 =?us-ascii?Q?eK7MrVknt57q163QPhHjwGT5JLF/HJo9fUb969ki4/P95B/Of1YitTSEr5Uy?=
 =?us-ascii?Q?Y3I5Waxj32t3Ab/PJ1vc0V6yTarm4pStuFvag2jnjOf44x42hbmtiqssjmqf?=
 =?us-ascii?Q?oM6NawOn/yW9fuyQjkfgT8fKT8Wv7O45KgGoM0JoF5V2hicJu7ata9BEHQiG?=
 =?us-ascii?Q?wLzW3GW8TR8TlsH8o/2a6ew5sVaW+SniDeJWaHfMH1gaYoRYrL4+z1N8jUEI?=
 =?us-ascii?Q?teTXDWgm0i4OqxHMd0Qc1xRwu6ZLh7rMaIpFIBeOadzhgs0Ihrxo2cnY7U9c?=
 =?us-ascii?Q?vaWiuN6l0OFGLonQ8ORKAdbc9mWyR5SR8LAQ/btwainlrBzSO4dQMm1WMQri?=
 =?us-ascii?Q?VDE8Up3kE0ae6DSycIVM8DNAj5yE9D9LqviVv5Q8frT/98E3i3R9uIYnmDow?=
 =?us-ascii?Q?9bmlUahDVeqEsAP1NT0DDwz8e+M8E/ulejDsU1qDfoxww5t58Jt0MfPLcFEr?=
 =?us-ascii?Q?lvqOUayVFrrhOy8LXHUz1cTkg0VjasHqziRXHnd4qqmte+lTD7ep7dDlqsD2?=
 =?us-ascii?Q?rBj19IZV4Voo9poUgYgbwTMkFKkkyrbV941aVDmtRxqsU7y1Jf2r9vinWh84?=
 =?us-ascii?Q?+iydGz1U56mFQosBdOmZh0wnMenr+8xrXGCqYgGW06WdIa4me/am3v2aLjWU?=
 =?us-ascii?Q?0ya9hWNzHVh2OQTSGtPMyukgAMcEgh+7GkOg3SVdzZl4f5fgO8uU+mdK2ms6?=
 =?us-ascii?Q?jMroCR4M7x26mWL2T1Xcf8R/nzoCaPQ8a9huXSWeAoUCvtd26neAAzWXn+85?=
 =?us-ascii?Q?siOmhprfoiYJv2Pva54Vrd9L2rwwgsfOM3eZXIjzqWTN4YR6yLjXNYtsABIB?=
 =?us-ascii?Q?ijsLVxjcV3amgRpzkssHo9woVNyAHTxXacKd89IGTCmId2RDzUn3gZL3Qvw9?=
 =?us-ascii?Q?M447in2+StzQUR2KA05ClWA3MsYuVoZW1pwncPjdpf268VBgToLn+KjCAa3z?=
 =?us-ascii?Q?7ZDWwlcc3M8vlWPRAxeLWLIAakFzZ79Phje/6FgniVk1KiSaYfgR9fXeA8JP?=
 =?us-ascii?Q?QBUVr+N1T5PkUDaod16RxrwhxsuTtcKbwTcOl7gzdw+h1igcX1ZTblf5QXOz?=
 =?us-ascii?Q?MElw/d8ZtCsG+ajf6CSn1YDAMi4rSTLrmmC77LY/Y4nM0kI8+t0NhHIksBo2?=
 =?us-ascii?Q?G0zPJlKVz3gNSr7i7AVQGjmmMqRH1a0v0vqaVK1d66zQ1/fQG6GfGH/x72nD?=
 =?us-ascii?Q?t/S9aSYTGzbNDFYccNCnXMK5KyC2dgOgfK2teWQAYc/LMYkLDju8R9zDeeDj?=
 =?us-ascii?Q?PHsNV1pjd4aPDdPLOaDJTSW1i/vlPjLn/q1EMuUh5y01LYBZ6WVfAQXaoWR6?=
 =?us-ascii?Q?4nHgI8isWXCwJnewIBkYhhIMCjg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df396c5-c1ce-4ba4-85a7-08ded415dbf0
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 06:32:28.7193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZDsJuNXEPLLfY/+zP406JAcFiequ6UVVqA+dcGfH0rURRt8Hjj0i71T1fKRFGN8KZ1Qd0Tf4QfCMHT0E305kosVuShC9O83FoW3wKx21+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR02MB6234
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 27 Jun 2026 08:11:15 -0400
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

Describe the current OpenBMC target naming and release status for
Nuvoton machines. The latest 2.18.0 release no longer includes GSJ,
so point users at older 2.14.0 sources and explain how to find
Jenkins MTD artifacts.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

 docs/system/arm/nuvoton.rst | 54 +++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
index e4827fb43a..51d36b2bc0 100644
--- a/docs/system/arm/nuvoton.rst
+++ b/docs/system/arm/nuvoton.rst
@@ -94,16 +94,60 @@ Boot options
 ------------
 
 The Nuvoton machines can boot from an OpenBMC firmware image, or directly into
-a kernel using the ``-kernel`` option. OpenBMC images for ``quanta-gsj`` and
-possibly others can be downloaded from the OpenBMC jenkins :
+a kernel using the ``-kernel`` option. OpenBMC machine names do not always
+match QEMU machine names. Check the OpenBMC supported-machine list and Jenkins
+for currently available source and pre-built images.
+
+Known OpenBMC (v2.18.0) target names for QEMU Nuvoton machines per:
+
+   https://github.com/openbmc/openbmc/blob/2.18.0/meta-phosphor/docs/supported-machines.md
+
+.. list-table::
+   :header-rows: 1
+
+   * - QEMU machine
+     - OpenBMC machine
+   * - ``npcm750-evb``
+     - ``evb-npcm750``
+   * - ``npcm845-evb``
+     - ``evb-npcm845``
+   * - ``quanta-gbs-bmc``
+     - ``gbs``
+   * - ``kudo-bmc``
+     - ``kudo``
+   * - ``mori-bmc``
+     - ``mori``
+
+As of June 2026, the latest OpenBMC release, ``2.18.0``, no longer lists a
+``gsj`` machine. To build an image for QEMU's ``quanta-gsj`` machine, use an
+older OpenBMC release that still contains ``meta-quanta/meta-gsj``. The
+``2.14.0`` release contains the ``gsj`` machine:
+
+   https://github.com/openbmc/openbmc/tree/2.14.0/meta-quanta/meta-gsj
+
+Some pre-built OpenBMC images for QEMU Nuvoton machines may be available on
+Jenkins:
 
    https://jenkins.openbmc.org/
 
-The firmware image should be attached as an MTD drive. Example :
+To find a pre-built MTD image on Jenkins, start from the Jenkins home page and
+open the ``latest-master`` job. Select the matrix configuration whose
+``target`` matches the OpenBMC machine name, for example
+``label=docker-builder,target=gbs``, then open its latest successful build's
+artifacts. The MTD image is usually published under
+``openbmc/build/tmp/deploy/images/<machine>/`` as
+``obmc-phosphor-image-<machine>-<timestamp>.static.mtd``. If Jenkins does not
+list a matching target, or the build artifacts do not include an MTD image,
+there is no current pre-built MTD image for that machine.
+
+The firmware image should be attached as an MTD drive. Example:
 
 .. code-block:: bash
 
-  $ qemu-system-arm -machine quanta-gsj -nographic \
-      -drive file=image-bmc,if=mtd,bus=0,unit=0,format=raw
+  $ qemu-system-arm -machine quanta-gbs-bmc -nographic \
+      -drive file=obmc-phosphor-image-gbs-xxxxxx.static.mtd,if=mtd,bus=0,unit=0,format=raw
 
 The default root password for test images is usually ``0penBmc``.
+
+For other machines that don't have pre-built images on Jenkins, build an image
+from source by following the OpenBMC build documentation.
-- 
2.34.1


