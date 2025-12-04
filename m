Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9CBD1D883
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 07:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR3vt-0001cn-4Z; Thu, 04 Dec 2025 02:39:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vR3vr-0001cf-Mt
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 02:39:19 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vR3vn-0006PV-OB
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 02:39:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1ySp4vwOV29qmFpOqRzA4x6rpKPr5xoLRleCbwwQQs70rzKuCrPB+1us2XvqgnTIAK+78RJBMzybqInKdb7OQebJqzShJe7STC6Jkc9NCcr7xWu73ozpg2Wnkqy3ypDfHcTkGanCP3AdnH58EOOohgesSK+QFQ83jovCWiz/9/tbd3tSw46Csw2Hvtg67iTipp14Ncybp3i/DVcu56fbDl5XgYU2+Caih/vjHxoEs8Mhov/wi0z9WvIK7+P9vVnD2Dl7JZytAEkZ0ouMxxCSO64BVn8IB6MNew0E39p1HrY7msvTwGY3/rEYoOvOAS/FY+FOBQ19ThJr18WnRrEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHM3abx0GUKkgAghNpRvSM4D1AM1Zyl/mlP+oP92cw0=;
 b=Ti7dWgCSG8gIGb63lM7Zw7lYXmd4jmtGO+fCB5wGNmeZqM3FmEByguhpANpy3w1/52gDB28IabXVWlX96AIlWTlow9cG8DFntpXUUHH4BoMH4ngpfoErO7AdnFdQI4uesllKByqHo/Ky0DgCSjgpbuWwRxkLo2kZyrfKf6MQwPXeU0/AJQ9Yp6N29evZ5gpthTe4rykp2Vc0DjnZWXJA9z8VxARl9whQeaBdequkWpr5f/nDLccO26BWh7ElQ9DwR4ZQ2agGgtbWjzPGVFCS1KG6Uz5AlzeazyoMJTGbJqXcJIeY3Rm9LTXhsB1WuCqRC9Mi4L+jBKJUG4T/v5Ou1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHM3abx0GUKkgAghNpRvSM4D1AM1Zyl/mlP+oP92cw0=;
 b=DbCmFDlNeiwsn/YCjkJAc54/C65XNRUFnAuTPy0slNhr15T1WQ5EflLniIbK5QQgt7Z53ADAAGau9xoACeItuT4vTCOhWhBfRsONOGDWVAw2rvQRsOo8MsEuvk7yLoFR3y9Maa7Zgjc9v+gyDoUfTC6TsCOjp7WuCerbuq2XNWo3EZDzxFpD5HE8YINQsh7CTq8s5hzg1rrYGtErKjqouUySlANU0xbZkhwjuESlGe5KWKxaeZOJLOJoWnRK538cKCkGXmCbMfePNKM7WRkSH6CRgaZKkSBso0nzYNVHStfSq/c1nVkFaA9tlYmz9qHQORYJVCf+CSZEWmJIP1/Qgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by KU2PPFDF24F4212.apcprd06.prod.outlook.com (2603:1096:d18::4b0)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 07:38:37 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 07:38:37 +0000
From: Wafer Xie <wafer@jaguarmicro.com>
To: mst@redhat.com, eperezma@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com,
 wafer@jaguarmicro.com
Subject: [PATCH 1/4] vhost: add data structure of virtio indirect descriptors
 in SVQ
Date: Thu,  4 Dec 2025 15:37:47 +0800
Message-Id: <20251204073750.8953-2-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251204073750.8953-1-wafer@jaguarmicro.com>
References: <20251204073750.8953-1-wafer@jaguarmicro.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0035.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::7)
 To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|KU2PPFDF24F4212:EE_
X-MS-Office365-Filtering-Correlation-Id: aa83afcc-b387-41f4-39cf-08de33082306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4DnLNHBjWiLTiC7fG//d7tzZUwtUu5MzgACkyDRtk0wsoD04u3V5iekkSdbq?=
 =?us-ascii?Q?pBBzkEz4OtizTNRJxT/10hLnr7Ss4cM0+Okgtn3Xl7PYCiczzM4EJZLt8uVF?=
 =?us-ascii?Q?C+iW7UPswZmQg8p9v1lYhYw6sQ0yv37BDE3x8JbrpK65ly32ga0UwpUZGSk3?=
 =?us-ascii?Q?W1Szb9RogKCZqgr0N7goDl0Tco4QWS3/3gUQwu/SZtaziR/MnSOcO65JgOju?=
 =?us-ascii?Q?RmhPdEWWoVfkgN/OLEPiuJ69LGf1Y8bVfDgEEznxMODVZX+8+2qgbc8B3bbm?=
 =?us-ascii?Q?9j9sCJCXVp3rDkMlKxAgVennPBRzjWP4SQ4TVvbdLg7fYsQog4HZg2KXkECL?=
 =?us-ascii?Q?0neZuMYVosZo3/LOzddTxB/fg2qcFkBRtDbTXzYENKnYjWH+GUYqybYWmGw9?=
 =?us-ascii?Q?dF4DJZreCjh7q3IGjRhPlVWs6t9HpxM6DMjVCmperjmCb3+KSUMglDwN+xZk?=
 =?us-ascii?Q?Y1hwKY8rMFq1SluH9QVo2u4K5g4mPL9V863hhANCXrsTBz+Ob1lJPudEkBCg?=
 =?us-ascii?Q?0Apwh6fC1kj+g3oM7Lvc5AstKgsnQ46Ip/aV7oMQoSDUVU/a+uD5B9uITLlv?=
 =?us-ascii?Q?RR/Wl1x+ACiP2L96zhnPeacvTxXfF1k2hb43cPLNuYivzoFlZiykVG3SaOZN?=
 =?us-ascii?Q?Oa3A4JjUJLMwWY1boc701ytgnM3sruhPwuRouH5RyKYcDXUlc8uvtwTT0fDD?=
 =?us-ascii?Q?z9H6ddhgvOdJylEH6FNYwb/gLuajH0AL2lgk2M4/y6M1DipEHKq98qymPbtj?=
 =?us-ascii?Q?5cw7OJIz0vDDRyZp+4LxuPqNRtyrthzfbM1ffKkqRMTsqfYgXmHMoFqdLjgs?=
 =?us-ascii?Q?CoHnWBjtF0WWYxMRhlx22plrzbQAw29ODy7hD4vhEadKS2P83zygQ6CJpsfi?=
 =?us-ascii?Q?2BQpLT1EfoHm3tJayZRq6PXZR1Qr89nmlJOPfEfF0KvjZDM+qcJ/Dhj5UaS5?=
 =?us-ascii?Q?0zyyhhUWC++aTiD96VqAHdYwi3lUpAEJb23+A132d46UUJx6W/JLkDcVDth6?=
 =?us-ascii?Q?Aa1ocY5D3xXufTw80XB0/dRO6/okosCen0YYj7IKOLSj6SB0ZMGT9hO5Op+D?=
 =?us-ascii?Q?ats+Kr5Spl7ff5YOwsfn9hCCUQQgSeyBHO2jqxtuXw7JiCrmq7k7tJpq4fcG?=
 =?us-ascii?Q?fT10KLOu+NGxd6HlfpIl84NQadhRIHedn+rrm5GtMPww2S/wkWAjVycHhbCv?=
 =?us-ascii?Q?8UvSNZ9gISvEYZG5gYKAskWeM5DJgF2RaPFaVkGR1NCabIR+jQwf9/+Sw9Ti?=
 =?us-ascii?Q?EZ54MsUG9Kn7D+ONWb+FVvhK8oJGJAPPp2rWdslLyeaLihj0jCU+SBbFqblt?=
 =?us-ascii?Q?MfK0w9uBmcEDGPY8bGpyTRhdZBgB+ptGGj5m7fgAyVO1ciPyR7xVSZ3+4adH?=
 =?us-ascii?Q?CmSigbrT2Q9VK1OM9e0Bp/E5EMy2/QAcABGbop3+Qn1twY2I8spMBoSo0Nbx?=
 =?us-ascii?Q?bc7InEdn9eA89+KwHjMFfYrOUtuL8oDbLLkfqekF2wHorNAuDuNScnX6ieEc?=
 =?us-ascii?Q?ri/18fH5MpzrNs185MgTS2fUJOCl4f/iEi39?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D+hvIh8H4d50vrp4033MBZkAWPrYJKFHQBMuYOXMLY9VRA/cvXBaOuxZj4WD?=
 =?us-ascii?Q?8ekTbjJH5jJqelWCbi6CYgBbBMHBuLKG+jT5YLaSuAXySjPndE0R5RXxvLrw?=
 =?us-ascii?Q?EWOQOHRGtCKEAV+HCkXx2iQrH7qEO9enTCBIK5brimmesPE5NBXrz1m02XZj?=
 =?us-ascii?Q?RLA0RdQUijy9LRflKBP9tb+8HaqYlpCZiDGnDMSv6Zn+QAQ+40nBcLfDd1Z5?=
 =?us-ascii?Q?FmU9U40fNHnDUJCr1Y5IfJwvaayn+Rqk1I4xPIYRWEpcwVBHigiVo8U7GBCN?=
 =?us-ascii?Q?hAHRuyb01iqTtIXdxIzwUW7o6N41kjsgCWo8rZGc2pD5VOeahTCMIqHWrO9F?=
 =?us-ascii?Q?DLds533I0QsQs5Vww0+i29sUv1Cx0RN4m6VmTy6u6bJm2Lwxjb8OzgqeJPWe?=
 =?us-ascii?Q?ZlYZGQEx8rszI6Vt6YlsXzROMhYwFNDOwFss1PURvL4ERg3q6lgTld2rgv/O?=
 =?us-ascii?Q?QXdQ33StrQkkDyzmWgjWcuW5Vo5GVdO24z1D9TH3g5y232BoxG+vqtXXdu09?=
 =?us-ascii?Q?nGx47AXg6XhHr6ysrO5EyBNBtYKiWX8786y4gnoq7RdwsXfXZqWBmHVKX8iZ?=
 =?us-ascii?Q?zCRPTttaWyGkEQcejS4LRswFN1mRlO78iWcODB52N2jS30emy3LSiHcLAo9n?=
 =?us-ascii?Q?6xE6HcI7y7bAmVpcIj5Ilm6z7spKt5wGfNbh/T7YQGvwzXbjoAJid79qKZV7?=
 =?us-ascii?Q?wWrDVrNePGqurulleaeOn5CJHRAse1N79XHiBNmG9aU9OSmRGuY3gG8lTHnR?=
 =?us-ascii?Q?jazM4vykA1uhvVLzAdCUFq17QyZKa7cxaDjf34/k3jn0CaSGuLuaEv7sfWnO?=
 =?us-ascii?Q?1bBoeNn0qUf8FX1cchjZ9txARh1AJ7YkiJBJiAjYmTlXa6Egy7W+0IyYfrzu?=
 =?us-ascii?Q?XyBo3Wxi1Orcm/JInlNDhTfuG4ezuVfRI6hSvBkBw+DySTKpG2BcRu8w8J54?=
 =?us-ascii?Q?92kQDw3Ydrr4XUJn8YKjfACWBOcWA+VyRpAV1EXLG+8Fzkhj3CGyAeZIJG80?=
 =?us-ascii?Q?q5makuywwE+1tYhc5dKvhOtn00M8Lch15owdVfjGHuslMZyqTCLrgoO+9IHI?=
 =?us-ascii?Q?mEoJHuq6Y46Su1PiApD5ITp5uLJi3ZIv86q0Y33cgFPLladSkZxsm0Vs1nlX?=
 =?us-ascii?Q?r7zh5Ni7wG0SaSOfLzeOw8AJEflV83zBCBOTHPcVkvy60z/5p6k5BDnKd9k4?=
 =?us-ascii?Q?46s/npjOVpOoUzMbS8kV2HTDrRUB2BS1vE7Ue0wW/NlOAtyx6Iurq3EUxyrD?=
 =?us-ascii?Q?oibXqJsOOyGJpAvWuRJ7Py347Ad0XSpTUwwOThA4emvnJO756i2nlgfXgeAW?=
 =?us-ascii?Q?Ps8ubpylmwYKdszIwyWWZfUGor5gZuyFoQQSaIP0DkRmpLzPuUb9tVrdt/h7?=
 =?us-ascii?Q?qvcJv4bwkwpRsiOtNA726dVL9X5kRGeTVJjYNDUV5TrQ3L6U/FcJ1VY51WKu?=
 =?us-ascii?Q?OS8XEogHCf6slOvlFpXRXKJWGFyazSnHqDzey68z6RY5iuE7Xb56iUih9bFm?=
 =?us-ascii?Q?BRFUginKJL4F/ifZ3fX/lI+3gm6opJvkYM+nxXkCbCrSM+/zU8uTxhZ9yiI0?=
 =?us-ascii?Q?pswgFWJWUl91Eili3uUA7Lrz99ztpHq+ho2MR760?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa83afcc-b387-41f4-39cf-08de33082306
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 07:38:37.5300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsPlUp+UATu7GtPY4s061fzWwIiseX8UDni2WHLRU22GtyiWwHe9/fyJyW/n6EYNKFUEmKIhCeVujnm8h7Gh6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFDF24F4212
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=wafer@jaguarmicro.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

Store the virtio indirect descriptor in the SVQDescState structure

Signed-off-by: Wafer Xie <wafer@jaguarmicro.com>
---
 hw/virtio/vhost-shadow-virtqueue.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index 9c273739d6..2b36df4dd5 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -23,6 +23,14 @@ typedef struct SVQDescState {
      * guest's
      */
     unsigned int ndescs;
+
+    /*
+     * Indirect descriptor table for this descriptor chain.
+     * NULL if not using indirect descriptors.
+     */
+    vring_desc_t *indirect_desc;
+    hwaddr indirect_iova;
+    size_t indirect_size;
 } SVQDescState;
 
 typedef struct VhostShadowVirtqueue VhostShadowVirtqueue;
-- 
2.34.1


