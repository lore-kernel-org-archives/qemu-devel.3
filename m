Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10365CA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCC8S-0005kh-KY; Thu, 01 Oct 2026 04:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC84-0005C6-1w
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:27:01 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC82-0003QQ-11
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:26:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jX3ozfln0XY4xExhtYsIs03n/68oVMjMqT6f+dY0KJF48iFP5Ml90Kikk+QAs1O3l9SCzOZP4b8y2qsYHQ8Io0z26/WBJprPBdJTsQfldb9bNHm2YG08gd01YldjSVUa8HpJwm11lzhprAG/EbkOlj8iqMvacnUxq4BEpRnA7zMC1FzRx5Y+PIpoiB1exwBbx5eBpCwxjxNTFf6vbk75TZveGF3OOQTMAnKQIjRJTqf3FqEaTsqD3qD/a33FwXQGHFKHKSCJMCRZNUypvhCm6SkWke6TFcWozigder0IcnFr3Ee2tYO687q5D/2L7Tn25bMFIYqij4DDwgGHZVg1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFLHrTXYn30DKBGfZX9XawwQGNuxnOEL0tX4YglZD1Y=;
 b=pgig9R1dnCN27E22qPQyYI2qg0VdVYOKZm1GcGp4y2Oe6xUfxyw+WbsheEj5YdU64yCSlNHDJ7tPEr1n0QQEPP15SByPkyzHqH56EUQsacX9+zUl7ryxO2DPjGMyCYUiR+6vgt9/WtN/ZkdlobbIRZRpArupP+4+AY7rcM/yhta58RWTG7NM6ayXcQ1XMOehi9OMMViBhdAeV70pmKWUfBXoTb8BTbJ8khKbpt40ipG+M8ndXMxQj+BPM9Fx7G10LzYymOeSvW5RwvlbyXmrw6URm1sNaoS2hq9emokAgOpQQL9v58syu9XH87fJm6Jzn5ZAc2trQ8/ZL/z8ceKMkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFLHrTXYn30DKBGfZX9XawwQGNuxnOEL0tX4YglZD1Y=;
 b=nc8J48uvjzytwLGn1KsrWiCAxxpGPTSB38GP/xDtmQO2c60EMg9pb5rzXV6ccD56m5dYXur+2oT0yLn+HoGJIPkmi2d8jryBmRSadfnA/Jjd9ccZT918egkHHkSe2hhWLNfQsVVUaYDvwtwaZ4pTnVgKyY+RCTCCrz0oXbWF7beqbt91GpnO7TR/AZpW+jW9/vYzO193sf7YVO/umE/+NJsnDr3+E1MW/ToNueCXb5yI2EoUKPqXd7t1BGeypfxwcm8T1eA6AGgwpD5YRaAc2leLFQCmgmHeYxRo30YYHYXbnvONNIuNJdyCVbNmoA8NUAlp10ZfxpX721a3lx1c+A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB9442.eurprd08.prod.outlook.com
 (2603:10a6:10:458::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 08:26:47 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Thu, 1 Oct 2026
 08:26:46 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 01 Oct 2026 11:25:09 +0300
Subject: [PATCH v10 09/18] vhost-vsock: fix FD leak in realize()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-up-vsock-vhost-v5-v10-9-8c094843e98b@virtuozzo.com>
References: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
In-Reply-To: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org, 
 peterx@redhat.com, mst@redhat.com, sgarzare@redhat.com, 
 vsementsov@yandex-team.ru, farosas@suse.de, mark.kanda@oracle.com, 
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com, 
 andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR07CA0284.eurprd07.prod.outlook.com
 (2603:10a6:800:130::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: 511fceb7-fc25-4e25-8778-08df1f95b9e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|23010399003|18002099003|22082099003|38350700014|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: razlBFIw5cgD8l6PANobaMG7NUW7TPFsPafWjgOJ/m6SgP+qLodekavhQpwXt9bfX0QvZ0pycXOpvC8MAoVuxB6iu1ltnw17j8946WjLLEqDq2GgLh8GoN94FcUu4pd3azH6q0RDH3yONaCeUucwePiKQjSk7bFr7+TZdOZ1d/A1RSP0ce7JF8sKMnLdBj2NEbs4EC7w4OJfCKtQEcMp1zxjbzcP41tM/gOD4AH1oj8y8Y7pNIh63MLFbHVdWPcgthb5D7XtZRShSH4XWAWjO6csaTbQ3CyZ2Nl+EwtOu/iZUf4BG0RtAtlUYXLZP1fxxHznsLSvM1TDX50PjXvGdVxV0AYcNaHlSCRyMqgyd4jEI4M/Z8IFLohuN1rWGWIS4wJoPmArvdwPrDGo+cYNXWKAMI0nS+QzbMoB8ZuU717+XjIJf9ippTd4upMuIG2A+y7E5Lblfvk/laPRL6uqAO8iDTDfp2r8O6vpqABViKolsSSqbAvqog6mfPOuAjPpRrWvORRoiq07CMVrWeAaWtHKbzKEJEfb/5uLiSeqXd+yyBmUBMGmT2Jibnv49FbUyJ34ctq7Ak+YSCoztn94gJ+ZWGUEXsxWJZpnYjn3UY1SgepDanZ+234nW/bx5Ql151SPvsWNcEqILez2gwEKPBQ/Is1Gbqt/z6I/55xWiuVTzzbwULRyd4MZhvKasie7qWk6JBOiBuCAgxApRX2Ig+93/rTis3dSvt5sQsoScVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(23010399003)(18002099003)(22082099003)(38350700014)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akVSM2V2VUxQNitTa1BiMXlkeWFMRnBLZXhkYkU1TnZvSGRGdmF6UmhnclBZ?=
 =?utf-8?B?QThoUmpkWTRVckVDVG9GWUlDZGhwc29LOHB2TlMxREdKaUdLVjYzdkJsZE40?=
 =?utf-8?B?YkdvcE11RlhHWlFweVBIa2t6aGZJblBOWUpodlBnSWxUTzZ5QnVnc0JnZVly?=
 =?utf-8?B?SUhrR2tFdjNYbDlXYlZ1T1FxUHlIWmxBNll2eHhKUzNCY01YS3dUM2RacGdX?=
 =?utf-8?B?OHZwUURpV1d5K1M2anp6RUwrdUtFelRnZEVib3FLemhDdlVnTXphMnF5WGpo?=
 =?utf-8?B?ZXpheEJiaHdyYXAyKzFncElIckpVNUZGMU1GbThxTVBNZEdpVUtVNGd4U2Nw?=
 =?utf-8?B?UUxrTHdhQ0VFTVNrb3VzWWhpTzVnUE5LMWphUkx5VlJJN294bG1vTVhYYlVi?=
 =?utf-8?B?Tkkzem9JK3FvNTVSK3YrZmhwcW80ZXd4bnM1ekJKS3RvNFhGbW8wRDlIeDQ0?=
 =?utf-8?B?bitZKzZaK1JWVEFvaG44QkFad3pXUXR6Q0F6dUJuMDZtOG0yRjZ5WkRuR0hG?=
 =?utf-8?B?N0tiYm1wYzlwVitFTmRjTlpXZUdyenV0YlNxRzhVZm1CK00ySXRwbGlwWVFm?=
 =?utf-8?B?N0FBaFp4emlBVGVOc05HQmpBK3JseUV4S1BvMC9KT2c2Mjk0NytIOHZSSE9P?=
 =?utf-8?B?TTZwSWlOMStCYkl3WllFeE9EZ1lrdHVXdE9udGhBNnAzQm5aMlhtVmUzMS9t?=
 =?utf-8?B?bTM5RExyeHdlSS9VSEhwa242Sit2RFNXdXJDS1BEaWhLQXcxbEl0ekVvR05E?=
 =?utf-8?B?aTlOV3hXL1NDeGFSZ05CcmZEdFQrampIb1kyekNsR213bCthWFBSQmNoL21B?=
 =?utf-8?B?NTdZUlpnQWlKbjBISm9OSVQxaWx4U0FLSW5aVzIvaEd0QkZCMk9OZzFFSHBq?=
 =?utf-8?B?cEVwaVdtQUxBNWNxQmNJSVYxUUs1S3BxYkNDNUxvOHJROFQ0RlhldUNudFNn?=
 =?utf-8?B?WUFidmk1dkp5OVNFQXIrLy90OThnRE1kdFRQQ3FXQWZOOUVTQkhIVWRzd3Zr?=
 =?utf-8?B?WmJNZ3dPbVRsQ0NtRlhvamdvY3ZsZG52dEVudWFySUVIMHAvVFVKTmNZdnZn?=
 =?utf-8?B?ZjUxbHB1VUZXWXdLa2xnZm1vTlRYeXFNNWVwMS9JODBRZ3BIRjdNMUtYSE9V?=
 =?utf-8?B?SFRYZityT25ZVEJreXJaZ2kxRlJ6akd4dTBCRmVraTk1V1RaajVBc3BWdGc3?=
 =?utf-8?B?ejJ6U0lYc2dYMWxFOFRuNEk2eWlscnJYTzAwbWZyREhwdzA4ZjVidWM5RzNk?=
 =?utf-8?B?Wm1adEtqOHZYdjlxY2huRW9HcUdqZ2o1WmF3SkVPdC9nK3lNU1I0aGwxN0Nm?=
 =?utf-8?B?L1JSbmU5VlYwcGw0RUM4ekF1d0pMaHpvU09WNTN5amQxUlIrQW5aTG43bmd1?=
 =?utf-8?B?VnYvZnNkWHJOb05OMWdnNFNCcnF6T2xUVmpqSUppbTlhKzFWek9ZRUtPd09r?=
 =?utf-8?B?QTVNWmZWc3RKOUlQQ1N3V2VraEd1YzJ0QUtsVy9KVEIzc25kUjdYbURvVXZV?=
 =?utf-8?B?cDVDRzE0U2wrY3ZoWHNFM1dKQTdKd0JzeWwxTmZoeXV3WEFIWHpWQW5zeVZJ?=
 =?utf-8?B?UmZEZTcwTjF4eDkrcFR3VXJ3aGdWMytnNUZFclc1ZFdNckllS3RJajZ0eVlF?=
 =?utf-8?B?bDBlWU10b1lsYWt0ai9ramxMMitybW5PVkVGNUtIOE8rV250WXQ3UUFhOHdT?=
 =?utf-8?B?THE0eURUTkg1MjBNTnFQNE1rQU5YWGI0MnY2RFlrcFRDM3VRVFYzWVhZaHh0?=
 =?utf-8?B?VEtXMXBxdFRvR3RkU1ZVMEtCNEZqSSswV0ROQWNTRkVlTmV0RUs4OHdjL0sw?=
 =?utf-8?B?QzhBRXFOZ0VnMHgzZWhJUTV2S3NRdkpmZ29xWkR5RWpPOWVWTUxpTTBEYkZ3?=
 =?utf-8?B?aUJXd21uekFLdVpCQVRwV2lUMVltU2ttZkRFWUxzbEMzOFBEMkRrSnNXLyt0?=
 =?utf-8?B?bFhSQXA4SlBEbmhsTkJZQXRxZGROVUFGaGc5OEF1Nmw2T3diKzN5aVQ0aitM?=
 =?utf-8?B?c2dmUUVKQkM1L3REdnd6K3VaOExyZDZYaysrZkd4V3c0bk4zK1RrcVFzc2Jv?=
 =?utf-8?B?ODBBaTBtUWJ6SVB5TmlhMkRxaGJ5enZhSHNsUzE1Yk1HZk95bk83VDlUZ1Z5?=
 =?utf-8?B?OXVIL1o0WnYrQXBHY1JZajZGb2tGdklBc3F0eUtaMTY2bXdWc0tuV1BqRjRR?=
 =?utf-8?B?ZlJTd21GSStqeTFJU0F2cC9hMkFyNUxPSCt0RkMvZlkvWTBVZnpIelF2T1Ex?=
 =?utf-8?B?T3NTREpkQTNIdGhjbm0rT09CcU0zUkVaeTZET3hlQjNieTMyMWVsN3NKc2xr?=
 =?utf-8?B?M0FaTzl0dWFiR3dTQVNKWkVndkk2Ukt0bVVtblNQaWYyTTVjR1NiRlhGbVNR?=
 =?utf-8?Q?VZgheO2qvE67t4Sc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 511fceb7-fc25-4e25-8778-08df1f95b9e2
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 08:26:44.0136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BT/zk2GhLIGl4bhJh2a4yBKdJ+AiewAchwlhhc++SFcljQUUwvTP+/UOnGgyo6FYpvmoc98jToHonEguiHhwsz0KeuBglAxMZFbVvLhv5ZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9442
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

In vhost_vsock_device_realize(), after unsuccessful call to
qemu_set_blocking(vhostfd, false), vhostfd gets leaked.  Let's close it
explicitly in this case.  CPR-saved FDs don't get automatically closed,
thus it is safe both for vhostfd obtained from cpr_find_fd() and from
open(/dev/vhost-vsock).

Fixes: 384c2561bddf ("vhost-vsock: set vhostfd to non-blocking mode")
Fixes: 701544cfaf46 ("hw: replace qemu_set_nonblock()")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index c582ac9fcc8..3ec20d87606 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -176,20 +176,17 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
             goto err_blocker;
         }
-
-        if (!qemu_set_blocking(vhostfd, false, errp)) {
-            goto err_blocker;
-        }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
             goto err_blocker;
         }
+    }
 
-        if (!qemu_set_blocking(vhostfd, false, errp)) {
-            goto err_blocker;
-        }
+    if (!qemu_set_blocking(vhostfd, false, errp)) {
+        close(vhostfd);
+        goto err_blocker;
     }
 
     vhost_vsock_common_realize(vdev);

-- 
2.47.1


