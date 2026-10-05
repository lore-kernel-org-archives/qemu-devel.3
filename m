Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D85CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkCA-0008IR-MJ; Mon, 05 Oct 2026 11:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkC4-0008GR-V0
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:33 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkC3-00058M-FP
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKwsyhPLvrgPGK+Iv4V5ijl6sipcQvZkRHb2QEL4rIYEjR6HJp4rv7usQ5K28G1u3NWPfh8+y6lC+KFPVfL0sgpVjVHcDrre5z8xZ8N5oisPYUF3KKWbzW0gi/dA2AK6GuovIez4i0sZwU0d2r9F8gecYH38PYr+oaZRsKSRDZcO7A9CwrrrXxp4snFdtQ/7rTcli7pMv3rbfZZlhRF4fib4aOJSK+FxlNMYnq3NZpqeBN6wGEMfyQxd5zKetEIAp/YYISSUJBnA7CPP+gUM11oAEXVxmswSspkjm9n7vzhvuomsvEUsLqkz8FUwkl/kVfd4wP1YZb+DBGWT0kfuUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFLHrTXYn30DKBGfZX9XawwQGNuxnOEL0tX4YglZD1Y=;
 b=Lli+Ce9/+y7r8wrl3c4NxKBS2bloq4R8XVhvw/eDMF/iUtsBFvZLndh17nrLXJU0posodae+R7p0FYJ7O60lTQQoH/lYxJSeLOrwF3zms2WfEhNSQTtAUBPnhI3ZTxb6+IvTFPpBKbrfVrEddsTDV1tw/wW3EEBPa8609/hNeyg4k3kpRPsyEfw20GLifRN/cBztSZ5w/E75SIqIhADw4BPZlhiLkiLUJ6HblWuYsmxbRKx+rkiRve1yn3ci7ivckTfVZDwkFASpVI3n+scZ561SfshrldabJ+NjPju2GjOd265fnUEuFYWbA6bpPRUudELD5wcFZvrxTaTQWAHu5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFLHrTXYn30DKBGfZX9XawwQGNuxnOEL0tX4YglZD1Y=;
 b=lLrl8NKi9oqqIBG7D5klG6f59oQ4xK+tptMLJmNt0RZj/929c2Zm7HfM0WQhOyoujPeETslgNjqZGz97GXpyU1lsx6IdC2lwE9BELMHReKL9gKBDncqlncIha2EUd1xC3qbhHSvTkNc9hZ3f9XrPpylht5M/Xn6skzZ1ri+o1/WAAQJ7p/TXP1JQYVSgRay/i6w9XDTb/hLJsJ0N2mSaqI7apfnX/J20gY4kZp4vzI2sjzFggcqEP5z+faeHZaHMifkUUT6lPkMhwjn29nSbph9bQ+R52GGeI9qEfqHRkD7QPdh/KJVmvWYFmcflJqA2ekwe+GvMz83zA0WoEZUIyw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB9736.eurprd08.prod.outlook.com
 (2603:10a6:102:2ea::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 5 Oct
 2026 15:01:17 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 15:01:17 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 05 Oct 2026 18:00:48 +0300
Subject: [PATCH v12 09/21] vhost-vsock: fix FD leak in realize()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-up-vsock-vhost-v5-v12-9-40162390c68a@virtuozzo.com>
References: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
In-Reply-To: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, clg@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 mark.kanda@oracle.com, bchaney@akamai.com, mst@redhat.com, 
 sgarzare@redhat.com, peterx@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, den@openvz.org, 
 dwmw2@infradead.org, farosas@suse.de, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: WA0P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::19) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: 403b826a-6f08-40e5-25c8-08df22f181f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|366016|23010399003|376014|38350700014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XQSeOV57pDCC0B80zTjep4bIMtxVzlEGwRk6AXCyrj4jSwBmdHYEJHeHCpFbhpGJH7SUElKf39RsnbpxmOtn4Sw47H2ufrYnCkwENrEEDUcs4pSy0jF0X9KpPCBc7nlWw0wMr57L4zQGsiJ7aMsiEl10XM/ESumcGlpCZcns6NDiFebhM4ZXZskotdzrUUUCG9XLJ9U5puxJ5TrXnKeGx8meXp5zmvDf7lKZZk9OPUIb22HspFtjOO99Cbgujg06L6w5UvxGlZwxwQlaOcERSzPCgFmM3OAtbowwbsMBjZVCIYlyBxUZUeR3dCCW55HLUmLf5lTL6FtwJT3wKILeX5HGjxYXE206pIG/mfoKxnfkdkHPtktjuUha+z2m+LIZDn7wvzhy7333Ac9ckLSaPo2Ka9VJ5gg5bk0a8LKgKBtjB/GvHxhzlTo8xbQ7yhobckGuadyTndAOHTmaF0fI/KaWIXpCpb2rAKFr+v1rcGLoyjtIzxsnweCXZMxetFK3QgMF39zUGPKaplD4+zMaHbN9hxrrmJcNfXAEl5PFj+a2wRFRredCMYgwAo9fWjrHtjS2NMOXUjXFQg3OPdRFT8aj8jGdAVRE/oHpy6ozDt4ARFsJs9pOrcz25khWCCVhUlrS41WvJCECFYMwyU0y7leCUXGlmUGfR5dfR/Ggvw7xcixNtH8i6MTZ1UW1HWYyDxiDXoMwOKG8yzvAW+xu7wjGon2Ycb5Bt/l3GVp4QeM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(23010399003)(376014)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnZQUFFNN2paZ1JYYk54L0I2SjVpalN2N1VEUnhuRDZnMDcyNDBVaTJjRVRR?=
 =?utf-8?B?aU02TFF0Y0R5Tm8zc2V6MzRRRmc5RFZkSVFleTR0a2s5U2lsUDhGQjZ0c0xw?=
 =?utf-8?B?NjZRR2JSVUJ0WTBOem5iS1R6Z1dFN0gyQWNMVnpnYi9hMXJwZ0sxWEpLekZK?=
 =?utf-8?B?RVU4MGdTNmdaY1hZRHhTQzBKODFrTzJLelR2YVJUK2hKVk9yZHUxR2k4WTNs?=
 =?utf-8?B?MThxRks1VE4rMU1VMlZ3amFhWG54L0JzVUZBUUdRbEkyL3JDNmJJSUlWY0dS?=
 =?utf-8?B?QmVEUHJsN1U2aFk0T1FXdzZEcDI1Y0ZReUU5eGtYbmpyWHl5TURnUTFla3Rs?=
 =?utf-8?B?TFRXMTEyY2hHME1Va0NXOHpPWWxHMmVaOTIyT1E0Wmc1UE5STHZ5QU1pZ0dL?=
 =?utf-8?B?bUNkRVJkb01Wb0kwVW5oaTV6Vm1QcFRQMEZkWitoNU5wSGdJWWNIaVFrZmdX?=
 =?utf-8?B?ek53NHBrUkhaN0tpRGh6cTFIWWkvc0duemt0V2ZTMm9pUllSdVppVkNqNWhH?=
 =?utf-8?B?SnV4L21XSU45ZHdoTUdLdW5Fei9iV1RtSHBDbFpDc2FDcEkySkhGMFNsL0Fl?=
 =?utf-8?B?QWxuT3I5NFJsVWs3ZmQwV0pjU2VDTnlQZU9YczllamRnbzRzNXBTekdQdTRC?=
 =?utf-8?B?QWZIY3lDU0d6UDRaZDdTZFJNbnVwNkpMMHZPNE5VdExDQ2JqYXBGTHBiRC9u?=
 =?utf-8?B?ekthdDNTNGVERmpOc2lHcXVlUmE2RWduOFFWbXVSQVdFSGFEalErUDIvOTR6?=
 =?utf-8?B?WXRqbWNuOUdieXVVRW5oUmhFaSsydnhJaDhVM2Q4bWFkdEVxMEh5ajZ0ZGlT?=
 =?utf-8?B?dENiK2lycm1UZm13cUdnNVlqR2lHU0hTM2diRjE4c0QrRUhzOVhidmdFckln?=
 =?utf-8?B?ajhlOFlvNVhmcGhyVm9QdVdVdVBZSUpZL2ZEeWFDdDdjejdQWG41ODV1SUtW?=
 =?utf-8?B?RXJwNElVM0JYaHJPYkxyRlNBUmVHYkFHNTR4L2c1ZUdPOVM5VjlaWlpPRkVB?=
 =?utf-8?B?K3hmdGw4Q05rcCtoOVZIYVpXWGtROGlmYUgwRFYwNEZTZGluZFJUeWZmMGxt?=
 =?utf-8?B?SXkybGVrS3pBQnZ5UUtMVmZmNEFLZXcyTDhOWHVPejRJaXp2UDVWTGpTWmtt?=
 =?utf-8?B?d2dtSGNMSEZRRkpVY01KL2FSc0x0TWZwTmZXekZlV1NDSnJyUFcxbkE2blBo?=
 =?utf-8?B?eXo3S2tUMDFEMTlDL2pvT0V4SjZ4WktwOXYzT21qL00zcUdETnV4WHhRSitk?=
 =?utf-8?B?Yld1cExQUDc5ZStTUmlsdXdmbGRkTHRNZmFnMlFRSGpQenV3akQ3Y3Y2cDhk?=
 =?utf-8?B?azJSSHdCajFUVmkwbGF3UGUzZ1hkYm5aZmJpQUZXVzdVNXlSWUlrbWpZQTJq?=
 =?utf-8?B?V1FhVUVNa2l2L1U1TkNxMHExa3JsVkFXOEFhOXdtQkE2emgvakIyZVhFQ3Bt?=
 =?utf-8?B?elordE9JODdlMk8rVFdiWkdHdVRSQlVjUUIvMXcrbUxOTUh1QzdCTFFGRStD?=
 =?utf-8?B?VzRqNFNKK1RSTmxVSGxHb3FIQi9GanFnT0lZRGQvUXdjMzMxT3F0NVg1TmJB?=
 =?utf-8?B?YXlzNkJQWjY1YmRvVjZKZnB6TForSE0yOFpqTzNnaUZpeGl3Slc4TUdGeXht?=
 =?utf-8?B?Tm0vbjVMSTB3Mm9VUVJYMk5QUFVScktqYVZvNzR2cTdVZk51SGNrVUVRNm80?=
 =?utf-8?B?azQzeS9WSU50cFR2ekoxR0ZnSUc5Q093Y1N4SW1pdHFrN0NaTDRaRHRjU2N6?=
 =?utf-8?B?cXVYOGd3c2kxMWV4NHFla0F3c2g4Snl4VVFpdGMyMHFSeUpEQzBvNjBrNTh6?=
 =?utf-8?B?c3p2aGk4c0ZEWENKTnZPWDhPR0IyTzVScHhmUXUvSjRJaE5IVzNobFRDdVVM?=
 =?utf-8?B?VS9jM1plc0ZkQkhSOGZGbmVpcUhzWDlVZ21VVTVYVVphTDAyb2oxOG92TVAy?=
 =?utf-8?B?MXJDZjN0bUFkZVVlWmE0WTZRZnZlQzVna3lmYTdMV05WL1R5b2QzN2lyNFdC?=
 =?utf-8?B?SU1lV2JqVkRKT2lqdFQyRThGSllYMWV4eThqclVRUFc4UkpsaEFqUStHcklC?=
 =?utf-8?B?ZUk1eC9iTXRjdDBReUh2NDJ4TTdLMWRNMWFTREpFeWxpMGRXWnk1NFdVOFBs?=
 =?utf-8?B?eW55anlRbnlqWFE5VjIrWC9WbXhuQWdyYmNIMEFXdnEraklVUkRqdDB1OThi?=
 =?utf-8?B?SlNENWRINUJkNEtrR1lnUzNNblZMd0NuMVZJdkFQQllOOVRVMXdMYjZjbFBI?=
 =?utf-8?B?dnJIRVRSSXQ5SFZjRG5UOWJjNSszTnFRRGY3NWJtSzlWQTlBOEhUczl1MC9j?=
 =?utf-8?B?MElYZFJGQXc1ZktOWFEwRmpxaHpaSGFuQ09RRVBnMjE1Zk9GMmROK2dWOFpU?=
 =?utf-8?Q?l7i2345zCQnHxgzE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 403b826a-6f08-40e5-25c8-08df22f181f7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:01:17.3921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTDIHQk9mWzh4/csDaqrpVBJbCJpZWJjuYkXxG9p62n1Utobcyolhvos4a6HbfPJ5cjxU+RN4vTUZ9b27iSfZofKOfO5GwDvbptpR5rrrDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9736
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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


