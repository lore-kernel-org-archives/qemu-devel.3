Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D3BC88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62FU-0004Py-2j; Mon, 14 Sep 2026 04:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62FS-0004OK-0g
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:41:10 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62FQ-0005Pw-3y
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:41:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBKRLLVTZmugEVraYf44pz+vrBKmpmFZh5xtor5CXiSseeVvw67PmNiZpZoqht9KO2RO4YKGgTGM18DtFt0/POtvMBCAsJ+z1Rw4Db1HrIa3o+mwfwWKeKC4dQ8JpEwU4GMZZ1xZLJhw0HzKv3IS2RM+5wNr93bUrvmHcZWR4teszy1fCGghdDYCZs02KifahMh2jhE3RweUeXZ4YO7bjuLHI2NBuphiXiGd/WhOytpagYq64LQKr6MuqBQvAqJuF5ROxDHrJ9zZ8mpyR7dXfN7UQUekBNr9+FPSNSwtjKlJR6vbAuF+FEE0powBL5CHbB6dWZhddPtPZrdrQOf9EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Qhx5YB+bipET/P1bDqTnBNWBwASq6LmhMuZ87nFNqs=;
 b=jOjadzrkuqSbXf+RJNs4ThbokIt7nZ9qn824auVC6NLBRXK24LX81x2RjeUvqs8+62X4AcdOoBuc76VnODijCD0Fz3WaqBgjI+ZLVT1FFguggYgLuFFQZbXnhFN49IuK8KYAw8ujDiptdQgkTlj4JQyL8UEujokIWQ01c9lnjMmg+Z2m8OMZJJRKh2k2RBXOuBK1yy23DcDYB+Q1RDLOIj2vR/cgxGiNeNhJC+zo8sQiY+IeI6Wbl8aJJLMyYxS0eGms6Q4KgDbBYSiHu9KCf64ioFGa3VhQey89YJvqXviQ5tk5r1jhTX9+g106D0BaJI74Qm39z+EmZ3ip9i3Uwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Qhx5YB+bipET/P1bDqTnBNWBwASq6LmhMuZ87nFNqs=;
 b=uPuFCm2r84jKqrK1avubC51PtNHEWG2kln0GKz3Gj0Yzqo0xxHDNFWL7tyOe2suDFyucX0zi9Z1M9nrgkbVZDxR/vvVjoiI23n7kLMVVJDpNJYDezCqc+OrNVNVP5/h19pEi6quCAH3z6enwTiZ5bDNutAPFsG4wtcZKP3kZeuho+Ih5uESzulhgtT2Pd5PyOXrOxxCvnsvuFdsEq2DrBDQ2EyEGO/OBgk+YA3Mfx9am3GkT+iaEibXwEnH+OYKsvRLMtVtectrmEWihdtjY4Py3YDqnzZouiMXnkX/FMy473segQx+xxkwS27DAXTXKHGugr9uzxH0+0q0Fn66pEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GVXPR08MB10916.eurprd08.prod.outlook.com
 (2603:10a6:150:1f7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Mon, 14 Sep
 2026 08:40:31 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.004; Mon, 14 Sep 2026
 08:40:31 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 14 Sep 2026 11:37:43 +0300
Subject: [PATCH v5 12/14] vhost: add vhost_dev_set_owner() /
 vhost_dev_reset_owner() helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-up-vsock-vhost-v5-v5-12-d17423589f48@virtuozzo.com>
References: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
In-Reply-To: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, philmd@oss.qualcomm.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org, farosas@suse.de, 
 peterx@redhat.com, clg@redhat.com, andrey.drobyshev@virtuozzo.com, 
 sgarzare@redhat.com, dongli.zhang@oracle.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIXP296CA0028.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36e::13) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GVXPR08MB10916:EE_
X-MS-Office365-Filtering-Correlation-Id: a83cc22b-c5d8-4763-88ea-08df123bd39a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|23010399003|1800799024|366016|10067099003|22082099003|18002099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: dGJcEj/IFQYOVmW0L1mwGgU+fZOMVuKkMBqtfCkHDrLIwdUqIJGWwdLrXkUKdIhmaAb99gHrkxJaNp0qMPOZTbzW7rWFIAqkfSCbeKKLZN5d2TgImtOw5sImWkGHZDHrqmEZBfDAMtTUBREuEdKoUkSdOubEGr73K2BOmAN6NHLkgnA6Te28z97JffmxEqZrL+ZYv8i8sv+s97fpFWpUZFkBNz6EEUiY/fUCK72oh9Zpvtad/2dT5PiYjvi7PJxgePOKJXJewsfZGwrE69gnbarLF+9TSZ84DOIDNseELOgJXMgle1oI5ccfl5q/+2yc/9IFVzhDuMYC33vjDqkSrlq/NKXZrNKSGsgC38vG7qLnQHcLEw7sEBmOBtBvzSwIfu5WLXHPN/jo2EphzRHeREtnOdfB0e9zj2+qcUUJyh7f8RMUfqJ2iBM1P/j29x+DJTnGvrjNVBzmkrU/dDtwYzdNx/tqkEmDsbdaSpdJq7qHNe93+RN3kN2VXVfAetcoUotJiT5PA14vLAV5Of4nPU1z39vnsPd4/mDay+AuhlS7kTKjjbbzqlDA86dc7qnJWkdjQxJZ7EgsUm128kn1VD+oU+WXDWsFA4M4vFLloR+QUuAvqWNLZ9+OAfvMmP6uz58PqIP3EW/JWDm3ZA+u1GOHkiDCSUPDjYsqdnYatq3m9cjFYlOHCyndZ3s8x8zUlDWubtSxXxsi4Tqmo3E5Ji8yVNPKfscPrdnNrgo/+1U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czhDZHIxb0RQVCtDeDk3a3BHU2ZVSzhLdHpzOStyYUdJVUJXR3NUY3BDQ2JS?=
 =?utf-8?B?dTRIMmwyL2NpcnVyTlYwQnFYcS93K0JHNlk2T3VKcnFvS2lEa0FSZVIvTG9n?=
 =?utf-8?B?cXlZN281blp1THkrSXF5SDZtaWZFTDJrVkE1aTRQb2lHV2RSY0ZobGlQSk5y?=
 =?utf-8?B?Zk9EeVlTcEhWeldhdkZoYXF1QlRlQnNTQXpuZ3FTS1lXa25uNEtGemNSV1NM?=
 =?utf-8?B?VXp0NWdKblVJc0xXL3VoUlkyeGIzbXlXYVBYVlRIdEtGZkRLcmtlS3FUenUx?=
 =?utf-8?B?VjJmb1ZrUDdkSWl1cTQwNjBKZXIrY3F0bUFGTGJMNTZhK1VqMnhVTGkrK1VK?=
 =?utf-8?B?YjNwak52aHdoZXkvcXdIWk56OTZtM3kvVXVuVldueXpNQkJyL1c4SWNmbFVn?=
 =?utf-8?B?V3VmeW0zaXRqeDBQOW9COTIvdXdGYlJwSHVSV0Z2T3lkNzdQVzZDSjlCMmV2?=
 =?utf-8?B?TmV1bzhLTmNMalcrdGs2OTU2aGE0dzB1dWtXQ3lBVnpQMkxMejFhM0VFRDZr?=
 =?utf-8?B?UGFyVSswNkc4RUdQUXluZ3BlK1NabjFlaEV5Q2dXSzhUK0F4VVV0ZFo2QWsv?=
 =?utf-8?B?RWxkRWdiN0ZRV3Y0SXZDT1BoMnd0Y1pXY2tsVjZsbGd3eXQ3RG9qTloydHNM?=
 =?utf-8?B?UWZVZThxNG1PV1owZ21PWDZ4R281czZiOVNoeFc5cXI2L1A1dUF4NDU4Z2JW?=
 =?utf-8?B?WUhsN3VkNFNNTDJRbFlpelZpV0xOS1g5QVZmY21Pam9MUFpjcEg0b3VMU29P?=
 =?utf-8?B?M0VxY1J2NVFvdndTcnptaWIvYXpmMEMzVTR5eHdVNDlwczJ2WFB2WjZRVDJt?=
 =?utf-8?B?K2hxalBLUHAvbFRNRHlWVXVFNDcvUktUeXlwYldpTS91dWR0MTB4K2grNkxR?=
 =?utf-8?B?cjZWMHpYRC92MzBNWDEySFUxL0VsUWtrUDBEZEc2NFlJb2dXK1VMTU1yMFBS?=
 =?utf-8?B?WFZrNy9zMDN0U24vOE1qYTNZdTFrQjMyTFlMcEM3VUVpbVQzT2t0ZGhZVHlv?=
 =?utf-8?B?SXU0UUdoR3BPM3ZkcTJqOEEzeGt6Wngvakowb1ZaVmlCNW03MmZDR2xNbXpo?=
 =?utf-8?B?ZVh0NEFmcHZFcUR0ZWNuZDFlTlNWTWhvOXIvM2c0ZXFTdHhuMEZqa2duamRv?=
 =?utf-8?B?a1VxdzBpZ1JLQzdrSWtXTFNmVm9xOFd4bjRWUFJrcnl3T1pSN3RIVXFic3ps?=
 =?utf-8?B?WkhET0gyZXhNZW4vSWpDbVF2MzUxTXpHQWdwNmJNRDRaZGlyNzQzVWxsVlMz?=
 =?utf-8?B?ZW9vYlQrKzV6VklGNWRTMmhPbnVlK1VDMzF4ZjV5YVg0R1ZNM3VpKzBYekxP?=
 =?utf-8?B?THZkQURIODZ6KzVXdmRWWWhWMW1oYmx3djFGczNjVnlHVXd1WnprdUgyMTBq?=
 =?utf-8?B?OVNiWUFUWHRwWm5pZmxpdG9UaFJIdWgrRGNGbkg2bDlPVEVnZ2JLa2FWaC9m?=
 =?utf-8?B?SU50Uk8rQStKdXI4MTE4TlhFaFlGZ1NZcVFuNVJPOXp6cjJzN2ZKc3htWVVl?=
 =?utf-8?B?RkxXYTlDNGRMZDhPNXkzNGJyNmVWKzRKWEFDS3Z1Y3lGcS9QbkJ0b091ZGs2?=
 =?utf-8?B?eDhaMkJZdisyWE8zenhWVXlyRE5VSG9kbEw2aERldy8xN2RMa2l1bURROG0z?=
 =?utf-8?B?N3ZPdUEvQUE1dWJDYis1NnR5ZGwwZUlKWTZPNnNFeUlQWDJJdUtUTHI2V0NB?=
 =?utf-8?B?b0U0WFdiVXlPdno3dUZHbVcyVnJXR2o4WDQ2c1E5cDFQb1E1WW5xL0RvUTRu?=
 =?utf-8?B?Wmp6bXVOeUswVmh4TFJyMENXU3NTZThMWno3ZllNNU8yekpUUTZtMlVseWlm?=
 =?utf-8?B?RmhudDNDTG0wNmFIdER2TlQ1cCt1NU1HdkNkZ3Fra0VObzZEUDFFaHM0WGxa?=
 =?utf-8?B?bDVYZUVHbW81cTQ4bWtySXgrTXdzU1JINFJocjNuRGswTHpTZ2RYOVJmcGlw?=
 =?utf-8?B?SmxrSUd0MitDcDMzeDUzK2JEU1EvRlJWeHpMQ3NEdGV5ejJlZGsrblZBallv?=
 =?utf-8?B?akN1bFVadm1oMlhpc0o3Z1FRZERqOHM3RzRSSmVJRnhaODd3czRpbEZ1ZXEr?=
 =?utf-8?B?Yk9MdzdIS2VxdDhzQUw1d3FYblVFRFA0Y2Y0K0g2TlRUdFA3NDROTzRvZFNH?=
 =?utf-8?B?T0hLS1RzL2pxVmcyR3BaazFHRlBJa0FmTlFEZndMQVRQZnpSaGU2SkppRmht?=
 =?utf-8?B?cnRKdzRtblg3c2ViVEx1NnpSRHdpWmxkUEd5ZFVVNlV3enRHMDJNdUhIVTlh?=
 =?utf-8?B?cHlYRUpLWEdQZGMybmhMSGFBNnFPd1ZFNGxXUHY3VzVoYU13RjJ6Q3kvWXFC?=
 =?utf-8?B?cEZkaFZPY2wwQ01YVUFGV3RoTmpwcytyallCY3ROZU1SMmtiZnk4MWZPcnMy?=
 =?utf-8?Q?6biTO1HjaJMY41Ss=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a83cc22b-c5d8-4763-88ea-08df123bd39a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:40:27.3507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmsm64U5eLBb0T0ktmb801sgNfVuME9gEdr3muio9VOpAm2guqmMEnnQymuyep2R3jwzbmCrKvRNtLuw91OI3PEeQrHyLvCEWNKU74B2zeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10916
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Wrap the set_owner/reset_owner backend ops in dev-level helpers, matching
other vhost_dev_* wrappers, so device code can take or release ownership
without reaching into vhost_ops directly.  vhost_dev_init() now uses
vhost_dev_set_owner(). Both return -ENOSYS if the backend has no such op.

No functional change.  These are used by the following vhost-vsock patch to
hand a device between owners during CPR.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 20 +++++++++++++++++++-
 include/hw/virtio/vhost.h | 25 +++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 2bb9a23fee4..ea17bf01080 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1690,6 +1690,24 @@ int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
     return 0;
 }
 
+int vhost_dev_set_owner(struct vhost_dev *hdev)
+{
+    assert(hdev->vhost_ops);
+    if (!hdev->vhost_ops->vhost_set_owner) {
+        return -ENOSYS;
+    }
+    return hdev->vhost_ops->vhost_set_owner(hdev);
+}
+
+int vhost_dev_reset_owner(struct vhost_dev *hdev)
+{
+    assert(hdev->vhost_ops);
+    if (!hdev->vhost_ops->vhost_reset_owner) {
+        return -ENOSYS;
+    }
+    return hdev->vhost_ops->vhost_reset_owner(hdev);
+}
+
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
@@ -1707,7 +1725,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    r = hdev->vhost_ops->vhost_set_owner(hdev);
+    r = vhost_dev_set_owner(hdev);
     if (r < 0) {
         error_setg_errno(errp, -r, "vhost_set_owner failed");
         goto fail;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 9b98d34dd04..94cc52f870d 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -178,6 +178,31 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
 int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
                            VhostBackendType backend_type, Error **errp);
 
+/**
+ * vhost_dev_set_owner() - take ownership of a vhost device
+ * @hdev: the common vhost_dev structure
+ *
+ * Issue VHOST_SET_OWNER on a device that has already been set up, e.g. to
+ * complete a CPR handoff on the destination, or to take the device back on
+ * the source after a failed CPR.
+ *
+ * Return: 0 on success, -ENOSYS if the backend has no such op, negative
+ * errno on failure.
+ */
+int vhost_dev_set_owner(struct vhost_dev *hdev);
+
+/**
+ * vhost_dev_reset_owner() - release ownership of a vhost device
+ * @hdev: the common vhost_dev structure
+ *
+ * Issue VHOST_RESET_OWNER so that another process can take the device over
+ * with vhost_dev_set_owner(), e.g. on the CPR source once the VM is stopped.
+ *
+ * Return: 0 on success, -ENOSYS if the backend has no such op, negative
+ * errno on failure.
+ */
+int vhost_dev_reset_owner(struct vhost_dev *hdev);
+
 /**
  * vhost_dev_cleanup() - tear down and cleanup vhost interface
  * @hdev: the common vhost_dev structure

-- 
2.47.1


