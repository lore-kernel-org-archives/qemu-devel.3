Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE381077603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2vxZ-0006hk-59; Wed, 18 Mar 2026 14:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2vxV-0006hN-Sk; Wed, 18 Mar 2026 14:49:34 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2vxU-0004dv-BW; Wed, 18 Mar 2026 14:49:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oliJ5eUJl/9kb/eyyGGTyGgYZDophjYhqHpb9IQq5++CYhqgTsM3bSwoUkwKydHFRJZu/3ER0v3cxtZ4FfJezZovhnl8yVwvq3Zjt9rxowkxG5XE9o3ZOJp+kJVo3KOR0RlE/xYj4T31h5ALKJzjXpe1+jVveBlQyqt20yfFk7Gr3Tq/KFbOWbYGZq7cxiAN/NiV716IUGWGoBrG+6PCt9Wch2dREU929OTKqdO9q8QRdL1qLjij7D4m8SMNJjJzxx7xzPB2Cp0jsCBZrVchnkQleFoG+TzU7UbfMCwX6jFVUW27OBTE7DZWIkpbkQNpR0AV8ZWsLnY/3TYOAXvCqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TF7jJjjspkqIJYNPBGNYSRIOHMgisbni4i6DUzhJKyI=;
 b=sg1RshVYgCJIwVoDbObL5roJdzsOdOBWs0v5SDphq8i56aO8XazyKks0FY9YAzp2iv4TAMvMMebR0248A+RsJLACqfEmqC9eo8j2/Cg7LAJr9T9bzUJBXy9kbXmOAUj3Vj2vN4jmWZZsPu9y4yA1U5hJcXHEVNdfMMWB6JumxP5y7afHZASf3WIaKqSt1R7RdXZuKP6zIrbzD9q2Gw1mTNVsQkXjWdBKSgIOBrAmsbVTkVbhh9sUDpmhOW+sERYwgvuGcSMMDJJpr93/tHIheFskQRxlAzV8PoTbZcCSb0Cupv33mNAnekfxpsWcZS6IPfLlFv0GucR1+tkPuUX5hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TF7jJjjspkqIJYNPBGNYSRIOHMgisbni4i6DUzhJKyI=;
 b=Q8pcSBZBVb/Nyow/csOTZbJoi5eNNERKB8SOdVZUWNO2F2+PaNlxBgdPqeZUsqRz8C/Lb0lolA4ZfPW7lwhez4W0HYDedtreDq45xKxq4FPdieYrUGDdU30hooC7jxSY483OJnRXknOc+hgBYazIHmhpoEMeOmI9b7p3xV9dIAjJNBfnw7a/JHDQjvp/CsNCpePhS+dmePkw4gkJ/z3EiC3LsMUZT9+hdZ+dUP3kzQkDcanvmkpSDbQIQA2HDVbcP8wZ4GHzN+WSWtH30M0wraqEnkYRv676Bken6S09F3uKx/Fn3H7NFMIfuV8ega3x1gTd76ep6KEAd9Saf+OYFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 18:49:26 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 18:49:25 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v4 1/8] hw/arm/smmuv3-accel: Check ATS compatibility between
 host and guest
Date: Wed, 18 Mar 2026 11:49:00 -0700
Message-ID: <20260318184907.4060030-2-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318184907.4060030-1-nathanc@nvidia.com>
References: <20260318184907.4060030-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::12) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e5201a-c7e5-4bb3-c66a-08de851f1390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 8hyexyYiiRJdSNmV0PINeNQ1jYm0ZxtmQouoOkt10HABCj+iFrGiFYjNs6S9WCp2bbx4BGPG+ntk5adatMqQIDNYuB3xQpAkIYCaz6hgEZQYh+nwWj4rbb8K67Z/NfdihhyaHcd1otIvvjuSOPL6dc4q/feO41P+hKirgdXCV/fCqb774uB9CmWMEJ+wA24S3CwNBryxrR5XpQg7pZ9ci2xB+Aq9CeC9dXjK2FXqhyuavDefNth5icKactQ9wrWJpdO9StqVY/inhqSHlShsm43im/wNUWor9q6HnPx9b3dzM9aDy66DpvJ3ymTgH6nj2NbZTjJVN1bPT+4lrdyiqPDS+04iaeFO0Of1Zjq+uzdbOHFyiBhYu2JAsox1eQtecIKSd2GfscQ0khF+JUItcNskMXUaFGQ7xW97lFsDA7PShS975EJPc/hSaMbVEIaS3zlKb0qs6+p1kGRw1F7RZlOJK1v7jNDhWGV7j9fJ/ZwEJKPSr3Nrd52JkwmNaQygjApldB7g1pjacT5XmHFFuUZC9tqknwj/SP0iJxbjp95BVB0kzF+jx1FXgTrW4sHgElRamcm6S/Z9gmGERSICFZUn5DsH4ydhCekoSt+nKnqcFSu215QuPNfe24uhOmxLbaMrmeBHKUHOW91IHeN48D5th7T3QmR2hFjr7ijwN5POKO7cCxvKfTrc2z968YDkP03jdrSDUn9R7kARkflYCHgrhachZHSXP27mMM/r0g0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Ue6c9ENxdXD92mcJqRgjifJrtb8YIwcRex/11Ozs0oBdJDBOpF293Gkd5ao?=
 =?us-ascii?Q?U3TbxBlXRIhZGTctk0D2sC3NnraSEHS468Hi1tEBIm9TnNnhK8l0mihIs7O/?=
 =?us-ascii?Q?ppGrDG2US2XRfgrPv7JgFKRDPsXc3/WJhh7qSCD7MzjX0TaMG7SrdsZ5jgyC?=
 =?us-ascii?Q?oEGaXStnyCiQfmieHiHW94nMeTEjOtnd+1YCMRVBPZxKFQjhnM/StNs6dj1L?=
 =?us-ascii?Q?o7rTFUYMY8MX/j9Ju9TgTaOzxtRKX8mk/4BKLtPX/EDU3sB38JkGd4wq7LvA?=
 =?us-ascii?Q?JQrmOjKrQEeVootb93Wzn7QVDYEPvJI3d+Ue4IXmVRdLeyZateR5x43/pdzG?=
 =?us-ascii?Q?qYUEZYhAVFE5wlHNP+ToAaM5TscTJ9oFeYcp5qqrgZH6kKTdRNv3kTRwCmBZ?=
 =?us-ascii?Q?Y0niDRP6Ekx2Ub8JG2HVepCjc7+btrLqCXagHlWXW7I/i7hIQwbNX2eIA7iM?=
 =?us-ascii?Q?oftuyoWXdnXzO/ZvYZBw7Ra3wnR+PTf7qcDkd9gt+bVQ5R2bNxs03s84ZZhH?=
 =?us-ascii?Q?IvKwEu69S98EVmI7VoGG2DaGP3o/GIDs4gppRsM3TMm2GuuGk8ugi8u3TtIi?=
 =?us-ascii?Q?OShVm7Kn+XFsDPeYR0bsHw0MNprN5Qki40XFNQcuvz3RNpdsC/YjV2eaUF+g?=
 =?us-ascii?Q?GFkKHRH8idrizUmJJFBzNB+ur3Q7QCnZ4mqx+M5t0kCgn4bfTtjECoFq5YST?=
 =?us-ascii?Q?1D2DoeD+QIgEhU2ZoexKVCIdrR8t5Dpc/6aurc2JhHVG426guLUPWaGPr6jx?=
 =?us-ascii?Q?tnpeMTjrHNRAXBWLwb50ZEZWk6rHNalIzElWUMLnHsT6+y36Q/IKeClWTXkl?=
 =?us-ascii?Q?vcHKXoDvpM7Eo2DkvFMbtRyUXndTueufiYhccVnRD0AopCeLg+8NhHGxHlud?=
 =?us-ascii?Q?7MLp4Bn27Sda/Gw8Wnn2EiJT/KwYJfGIjXE7cSmejgMvSxOGs3wG3utPT5/b?=
 =?us-ascii?Q?jAP8xzWhMJTEqyyDvFWVbNWUpjpZxv/TvwA5Knu9ZedrYl5Z/n2KQKG8pqlq?=
 =?us-ascii?Q?/rML6qQRo2EeFlVdsH0EPFWuwDAgmSgT3BD+PAXNUEo45KDKcoSvJo/kZBF4?=
 =?us-ascii?Q?mg5MUSGy9F6MRPmdn2iTDnISZwLqdnnyBbh84bEbpHzop8I9M1GBHv53IvER?=
 =?us-ascii?Q?x8oywHcW6lYvHr8ZG1h24bXXZtJCLJ624pW7cjxu2cUmm1XC1NLr8AgevB9A?=
 =?us-ascii?Q?xC15ir5QkfByPFYGPHEpt5fcYM98l8Ak9iEUUlq8rE4u/ZFlnrQ20nwJ6zp4?=
 =?us-ascii?Q?Ef8fXonG4YYw74AMnGC/2wdEyWH7VbHpmDs9/fX0Xl4R8IkutxrQo8pQ9ME0?=
 =?us-ascii?Q?C2FdRYFbyv2vMVnb7WJ22Wq4X9+UFydKBigTVE5qNqZCf9i/dxokJLPxVCkv?=
 =?us-ascii?Q?awvUPLkYKaTYsUcQY63IhkfFzlpc/al5nQedriinDF9+aJABveP2lqmFEkYR?=
 =?us-ascii?Q?tFvJl4B3dbdoPHHYi2QwrafYJmyzx18imCUhMlmPvEqrftWWYqjfedez0QLB?=
 =?us-ascii?Q?aPaqH7W1Itkewv7nXzFmfRwHC+FsxD3eOxcUp700ey/ByyehQULXT7Mk2UQW?=
 =?us-ascii?Q?x/Z4YLs/VzExnk2QsoLPftgmg5a913GB+73UKIfaahGJdsZMpetB7JVS7Anu?=
 =?us-ascii?Q?6i81lWR4JY73M3zdLhnYpWv/J/qH0trm6H9Eu4E5DI4Q4DF5nsyUW4SivHrJ?=
 =?us-ascii?Q?YRxw9M7doPg/yboHXUy7vKURydzKCMaHMdK8E9ETIhlbNQbttZyNNAKXyYT6?=
 =?us-ascii?Q?psBMaZ8vJg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e5201a-c7e5-4bb3-c66a-08de851f1390
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 18:49:25.3241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIJu/nOnajhCeqGYFktHUg3dZ0aIAxxiycPtxwTJeaKlGcMKAGWdILy2QLWj22x7Yz4JFU04H6GvRFakQzbGIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=nathanc@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

From: Nathan Chen <nathanc@nvidia.com>

Compare the host SMMUv3 ATS support bit with the guest SMMUv3 ATS support
bit in IDR0 and fail the compatibility check if ATS support is opted as
enabled on the guest SMMUv3 when it is not supported on host SMMUv3.

Fixes: f7f5013a55a3 ("hw/arm/smmuv3-accel: Add support for ATS")
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 17306cd04b..2bb142c47f 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -101,6 +101,12 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
                    smmuv3_oas_bits(FIELD_EX32(s->idr[5], IDR5, OAS)));
         return false;
     }
+    /* Check ATS value opted is compatible with Host SMMUv3 */
+    if (FIELD_EX32(info->idr[0], IDR0, ATS) <
+                FIELD_EX32(s->idr[0], IDR0, ATS)) {
+        error_setg(errp, "Host SMMUv3 doesn't support Address Translation Services");
+        return false;
+    }
 
     /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
     if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
-- 
2.43.0


