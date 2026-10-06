Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAF2CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN8g-0005fS-Hq; Wed, 07 Oct 2026 04:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEI4V-0001BN-JX
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:11:59 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEI4H-0000jy-78
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:11:57 -0400
Received: from MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) by DBBPR08MB6155.eurprd08.prod.outlook.com
 (2603:10a6:10:1f5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 01:08:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSmuupq0hUokbp3aGI13bCmUMb44cHl3QeCB9pPidxMeagaBP+7Zle8/mqazUvcr8gcGRIejPQvl8ZJJvb3iUVHHDr1uo5HtFtMuvheVj9jg3fp/206G6H2WmXfFXcPh5qHOXHYgmd72m/KXDWKq7QuGDQvIYDUgfKpO5NmNykd92KuVVLfxsHoQcqxw7x0Xz75cdRYLI4XdHTT7HGwvFFYW7/3V4P4/v1hPfTXlCvztLA9eiW+UtN+Een5tyflhIqztcCHjzRVRV6uXCi2ETFwj9FzXE784TjpNlECXg2aRqyLuyoyfVIL4Pg7n30167lDQou+rAuKj7NK9v9XAaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9uyq7mQIpionRYH4TGd39qHDkvCHjkKh3DniesFcmA=;
 b=ukMPZRROLlj7jQAKpxkMSPEKYH1ogUYOGBx5PKyou0PdcL71p/dYemg9DyehHcXJ83Bk1KyHnV2WzXazBCRVZ01EQFEW7Q2G7LcSOsUTUBlozZlJhvHRK7jTQTCghVY7BbTwcN1nDno9QI4t4kNO2KNjmaHhjpqrgQj9gkpSVa3C6JybeJ/Pez+6NjiRSYJQC8ngg+p/RnYxYvFf1nbX0yP3TwZssluykLqFFZ1SLFvEYn9Lbk2+OFDZKGYEyLdkv61k085xKicN8vg2WQmz37uxrrfwLNAJ1nYslsMiAndFBoBMW3qW0MeAatcns1rCqGEIWXXlNp2wWGoWeDy72A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9uyq7mQIpionRYH4TGd39qHDkvCHjkKh3DniesFcmA=;
 b=EJ0xdMK8XNxklrrZzdvFp6mbG95KmpSioHfrnbfXTcpgdwW5K9T2Vdvg+mknFEKqlnrldkinrnWjjoG6V0wj4gJZ2tuf84F7GWFKY5GDLzCw9BcfxHAOh7ZnGX8txLMV1DA29dsSqCw4yzc8ubXjIZ/NrGOmf1rtfiotcFZ7UoXej0ZI4sWNWl+jotoiIWW7jKvJ96wKZ9fuj3P1ZnWzko9ujXRPRxsim3IA1Bio3Pyi3YmG5QR3D93RmszjFF0r12oOZszCpBp/879Yab7sP4+Bu5RWMF+NlD5NQM0cnsDlFHloHQuv0Z4lZwQaFerUACUSIa3Boue1LzWGq6k30w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 13:59:03 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 13:59:03 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 06 Oct 2026 16:58:45 +0300
Subject: [PATCH v13 22/22] tests/functional: cover a cpr-transfer target
 going away with vhost-vsock
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-up-vsock-vhost-v5-v13-22-2ea78fd1b7ed@virtuozzo.com>
References: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
In-Reply-To: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, peterx@redhat.com, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org, dongli.zhang@oracle.com, 
 bchaney@akamai.com, den@openvz.org, farosas@suse.de, 
 andrey.drobyshev@virtuozzo.com, clg@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, sgarzare@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000229.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f3) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB285920:EE_|DBBPR08MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: d61666c6-389a-4027-59dc-08df23b1faed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|23010399003|38350700014|56012099006|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: cbvSXFEhMOl530H9WMncqDrVz9tbwhmiQNlJQKl32Ml796y+WenuUS2HL/IapKlGb+8TKoVpouXmm1lurDgGY/G91txPJaWG6zktPZ+MpJoHMnqPY90A9opxI+7bSz+vysYto2Qq/hipEy9r45J/OKNYXrVvz1+r+4qnQ+ztTOEejO21EecnQkeF7H2Rwpo58Mh4fgBCWS9v77RPYqH9yzrbtkZ8Id16qyaZ/3dF+PASGYiLsAP0e2Gja5vbJltRdsh7hAz04QuxFI/OiyFStpOiOJdFXLF5hVaQ3Tzd+kMKT6vts//zbfKRc0aYQB4dJbUHDUWXU9EGgC09f9AKQHtJoYe+22/giV/Qd19wV4rhdz108jqsTixQLAGIDsIprSjydBfuARLTuLnpHlXtgFIQDlMqqS3mlKXTziTx8rO9+s18GoccpDGFZxU6YmOKhX5MSsSzIYMqgt3fTxojSZZXVIR+KiESlmcMvMGER4JZIYpB3jm7DTChXQ5l2mmQs6U3mzGZ7L/Bm87VGy8VDF18L5u68Wz4DuE/fyhbeQUgkVxitWNZCe2towOimOxFUP4CMXy6tZuXpX9hck8XaTuS0ry1iZXYl2pOo+278Gck0hEcTyJL2H5JaBISiK5ixPbuRSq9lYtD+y/jI3HyLO/JzZybPcA7hm1lAP3XzribVT+IKBE9OZYIFP/ZYe/9g+JB0DM6Bw3R0LPjckjEirfVdf3J6ahBgVKmb5IO6vo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(23010399003)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTdmM080TVpnKzJURHZnWjVBV2FjU1BwZ2w1aUJyQ29hOTh3eWxVZU1iRlVR?=
 =?utf-8?B?dG1ibVQybVdlYU1BWlhPSzduOWY5YTI1ZEtMcVFWaStPWTg0M2lBY05wTURo?=
 =?utf-8?B?c09xTDB2OS90UVI3WlRLZWhRV05lZmlYSndvN2xER2M4V2ZoZkJyclVONHdJ?=
 =?utf-8?B?aE9MTkwxOHJwbExudm9nV0RTbS8yM3ljTThDc0ZWL2ZNczBPeVZHUHdzYnEx?=
 =?utf-8?B?YUxIYmdtTGhtSEk4S0RncE1ZYlpsZnBrUitvYWpMY0F4NGpJVWViR1hvWUh0?=
 =?utf-8?B?NFlwT1FqSWdRU3dqSmFMNVZOSkwzY0RqU1d2emtHWWJadHRDY1BCVUpPb2Rl?=
 =?utf-8?B?M1MxUXlYd0JDQ2oxckE3aHJwS1l0WGFtQVRDcXRWSGRYSExSeGtlWXo1RVJN?=
 =?utf-8?B?TjVqcHIzaldjb05GcnNCRmxQaDNjZkZialI2RGg4c0NrLzlqVWVaTVcyY2FE?=
 =?utf-8?B?L3ZiSXU0Wkh4dWRPY1lPMlpsZFBpenFPbEJzK3RxQk1zd2JWWnRlLzZxL29P?=
 =?utf-8?B?cmpHbHJFWWpob1hVMWNsNjVzcXkwbkdGYmJZQTVXQmpYWnJuWUJ6ZnRaTjNI?=
 =?utf-8?B?Y1pKWmk0cXkwZHF0Sk93UzFoMnBmamxVRy9ONVpaaS9mNWRPYlpLa2JSSTNn?=
 =?utf-8?B?TzhBUEQ5YzBPQ3QzRlpobHM5YURFVTYxbWVTNUlhZ0paTS81aTFtV2F5MVdG?=
 =?utf-8?B?MUo2bVBHZHczSDBKZ2dOUUltVk5UQ055SHpVV2FhUTFJWnFDMmw4RlhqYUdI?=
 =?utf-8?B?YU9ENXVqbFA0OXpiQlg3WDJGMnZtMVc2QWxmTnNaMi9lbGtqdmR4dFlIdVpV?=
 =?utf-8?B?emtCcElsK1Z0L3M0eUtJZFIxMk1mN3RCY3BCQU4rZ3hwSzJ1bkJWc2kvM0ZX?=
 =?utf-8?B?a0greFBkaG1WenJydHdCZkhFeTNDelJwR3NCcmJtZS80OFhuTmVrQ0lKcXZL?=
 =?utf-8?B?NHVUMlRUMHNkNmxPZnFNMnBnRjJZeEdEdkNHN1Y5eW9tb2x5bHdZMTJ6WHF0?=
 =?utf-8?B?RW15SXkvVFZPOGtzNUJmajRCVUd0VjdlV08rRzVyUlJGSDgvTFZhZFl2UXJ6?=
 =?utf-8?B?c0xKWFFFQVlHQktLdWlnNFd1TWFCR1ozS3FVL2lta3pBS1crN3o4WitpZUla?=
 =?utf-8?B?Y3ZiWDY4bFkrbTZxM3pxM2w3VEFLMEV0bkc2OWFtZGhKY3gxYVBMRitjdysw?=
 =?utf-8?B?QmtPN05Ja0hkYldvVDZZNEp2V1g4SlFWR3ZHMk0rdjFhSXZsRXpaY1RCU09a?=
 =?utf-8?B?VnZSYkdodVNQcm1xM1d0OHoxMWsxM1FZR2JXckNMVk9DejhtZ0YxQjF2RXN6?=
 =?utf-8?B?bGpWWDZnN0M1a0s2R0I1UjRCaVNxSzFoaFhJcE5IeFRtbERWUmZPZ3M2VTZL?=
 =?utf-8?B?V25HMjdxZTNpTXphZFZHZXFuTjdCdGE2RHIwS0VzcTlnOW44U2ZtR2JHVHpK?=
 =?utf-8?B?ZW1yL0dCYms1SW41Vit4QmpBN2tpczFVSTdmd0k2RnA3cmh1enJNK1dxOEd4?=
 =?utf-8?B?TU5YNzdwUFU5R1FzamtONVZHbktqeC8rSGlpV0p3TE1aL2NMeThhUG5nOGda?=
 =?utf-8?B?cC9iOTZvakZxckowSXZVSGpZcGJhSkxJYndmaTloUjc5U3dkdTBZcFltY0Rv?=
 =?utf-8?B?Q09QbnpaU0Q3Y3gyV0FKaHQxcFVaZEg1cHV2bWdTUWRlMk5JdHhrMTFoZ2NZ?=
 =?utf-8?B?NVQrVEhacG02bmVnTWp3N3VnK2E5eG5XV0NISHlSeEN6di9hTWpHWi9qcFhT?=
 =?utf-8?B?a0FoUUdYcnBLcHJzSkt5VElHaWl6L1NKOWpIR0g5MVlTdEROYjdSa2ZFbmFu?=
 =?utf-8?B?TFpCUnd4NDVGT3RCaGhrT0YrV0lLY3FLd1VUb1h1WFFxREVQZm4xQWJ1c2hJ?=
 =?utf-8?B?MVdKTXo2VlFvL0lOTlNvYnVHckhHbWZLNmlXNGVkL1lCRHF2SnUyeGI2cGRV?=
 =?utf-8?B?alFWT3Ayd2U1dERKUjBaY29MTkVSOUgvYWN0cndDbDBzcjQ1ZlVYZ0ZjL0sw?=
 =?utf-8?B?aWltbUlrY2lXWEFubHJxcDBqOUFxOXFxdzQ2VURYdkNoLytiS0d4QVdydHV3?=
 =?utf-8?B?dUxZT3VuMmRZVTQ0MFFHWkVVTnZKbnprM2ZKMUJwb05jekQydFRTVVR0Y1Vx?=
 =?utf-8?B?Y3QxTWZNVUxFSStGK1dkL0FYQ1VXTjFPUWYyckZuSEo5MnlVUWJUV2tPYzY4?=
 =?utf-8?B?SHphZjR2Y0pjb0xmQ1hLdU9lVVlvZWRvZ29vMWhHamYxb3FqNGQyanRNeTRW?=
 =?utf-8?B?VUpESFlwWkhSRC8xeXFXOUpvS2JNZGlyMG51alVvaU91aStoTFpCekQ2amlR?=
 =?utf-8?B?QkxKUE1JRUlIbzE0emdoeUg2VktiajdTTHFFc3F5NWhTNGZPUlMzWlpqRVdP?=
 =?utf-8?Q?EnCWrKDvU+PhR8RU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d61666c6-389a-4027-59dc-08df23b1faed
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:59:03.7312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNG6tO5bxFI1/nCNrqoivwqEjYPmpFQKCjhMH+kRMP5ny9n6NEC/oN0G7Rj9zm0HI81Wv/iTg67p6ISyTkkkBZCKuskre7X5XrXvtYfkLhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB285920
X-OriginatorOrg: virtuozzo.com
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

A cpr-transfer target takes the vsock device over in post_load().  Make
sure the source gets it back when the target goes away afterwards.
Three cases, in the first two the target is made to fail the load by
lacking a device the source has:

  - the target exits on the failure (default exit-on-error); the source
    is stopped beforehand, so it stays paused until we 'cont' it once
    the target is gone;

  - the target stays alive (exit-on-error=false) and the source resumes
    on its own (return-path capability);

  - the target loads the state while the source is stopped, stays
    paused and is quit normally; the source is resumed instead.

In all cases a host<->guest transfer must then work on the source.

The transfer helpers get a payload size parameter, since the plain
checks don't need the 512M of the stress cases, and the target start
code is moved into a helper shared with the existing cpr-transfer test.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/functional/x86_64/test_vhost_vsock_cpr.py | 178 +++++++++++++++++++-----
 1 file changed, 140 insertions(+), 38 deletions(-)

diff --git a/tests/functional/x86_64/test_vhost_vsock_cpr.py b/tests/functional/x86_64/test_vhost_vsock_cpr.py
index 035307fc82f..3ac0a80c5ed 100755
--- a/tests/functional/x86_64/test_vhost_vsock_cpr.py
+++ b/tests/functional/x86_64/test_vhost_vsock_cpr.py
@@ -24,6 +24,7 @@
 VSOCK_PORT = 5000
 
 TRANSFER_SIZE = 512 * 1024 * 1024    # file size for host<->guest transfer
+CHECK_SIZE = 16 * 1024 * 1024        # enough to just check that vsock works
 CPR_INTERVAL = 0.2                   # interval between CPR ops
 
 VHOST_SET_OWNER = 0xAF01      # _IO(VHOST_VIRTIO, 0x01)
@@ -71,11 +72,6 @@ def setUp(self):
                                'qcow2', '-b', self.ASSET_DISKIMAGE.fetch(),
                                '-F', 'qcow2', self.disk])
 
-        self.payload = self.scratch_file('payload')
-        with open(self.payload, 'wb') as f:
-            for _ in range(TRANSFER_SIZE >> 20):
-                f.write(os.urandom(1 << 20))
-
         self.sock_dir = self.socket_dir().name
         self.cpr_count = 0
 
@@ -121,12 +117,16 @@ def attempt():
                 return None
         return self.wait_for('QMP to come up', attempt)
 
-    def wait_migration(self, qmp):
-        def completed():
+    def wait_migration(self, qmp, expect='completed'):
+        def finished():
             status = qmp.cmd('query-migrate').get('status')
-            self.assertNotEqual(status, 'failed', 'migration failed')
-            return status == 'completed'
-        self.wait_for('migration completion', completed)
+            if status in ('completed', 'failed'):
+                if expect:
+                    self.assertEqual(status, expect,
+                                     'unexpected migration result')
+                return True
+            return False
+        self.wait_for('migration completion', finished)
 
     def wait_running(self, qmp_path):
         # Make sure we're dealing with the new QEMU after CPR
@@ -139,13 +139,37 @@ def wait_running(self, qmp_path):
             except QMP_GONE:
                 pass
 
-    def boot(self):
+    def boot(self, *extra_args):
         self.guest = self.vm
-        self.qmp_path = self.prepare_vm(self.guest, 'source')
+        self.qmp_path = self.prepare_vm(self.guest, 'source', *extra_args)
         self.guest.launch()
         self.wait_for_console_pattern('login:')
         exec_command_and_wait_for_pattern(self, 'root', 'root@localhost:~#')
 
+    def start_target(self, name, main_incoming=None):
+        """
+        Start a cpr-transfer target listening on the CPR channel.  Return
+        the VM, its QMP socket path and the channels for 'migrate'.
+        """
+        mig_sock = os.path.join(self.sock_dir, f'{name}-mig.sock')
+        cpr_sock = os.path.join(self.sock_dir, f'{name}-cpr.sock')
+        channels = [
+            {'channel-type': 'main',
+             'addr': {'transport': 'socket', 'type': 'unix',
+                      'path': mig_sock}},
+            {'channel-type': 'cpr',
+             'addr': {'transport': 'socket', 'type': 'unix',
+                      'path': cpr_sock}}]
+
+        target = self.get_vm(name=name)
+        qmp_path = self.prepare_vm(
+            target, name, '-incoming', main_incoming or f'unix:{mig_sock}',
+            '-incoming', 'cpr,addr.transport=socket,addr.type=unix,'
+                         f'addr.path={cpr_sock}')
+        target.launch()
+        self.wait_for('the CPR socket', lambda: os.path.exists(cpr_sock))
+        return target, qmp_path, channels
+
     def transfer(self, guest_cmd, host_cmd, cpr):
         """
         Run a socat transfer between the guest and the host, and keep
@@ -160,21 +184,26 @@ def transfer(self, guest_cmd, host_cmd, cpr):
         exec_command_and_wait_for_pattern(self, 'wait %1; echo RC_$?',
                                           'RC_0', vm=self.guest)
 
-    def transfer_both_ways(self, cpr):
+    def transfer_both_ways(self, cpr, size=TRANSFER_SIZE):
         """
-        Send the payload to a file on the guest's disk, get it back into
-        another file on the host, then compare.
+        Send a random payload to a file on the guest's disk, get it back
+        into another file on the host, then compare.
         """
+        payload = self.scratch_file('payload')
+        with open(payload, 'wb') as f:
+            for _ in range(size >> 20):
+                f.write(os.urandom(1 << 20))
+
         echo = self.scratch_file('echo')
         connect = f'VSOCK-CONNECT:{GUEST_CID}:{VSOCK_PORT},retry=10'
 
         self.transfer(f'socat -u VSOCK-LISTEN:{VSOCK_PORT} CREATE:/root/data',
-                      ['socat', '-u', f'FILE:{self.payload}', connect], cpr)
+                      ['socat', '-u', f'FILE:{payload}', connect], cpr)
         self.transfer(f'socat -u FILE:/root/data VSOCK-LISTEN:{VSOCK_PORT}',
                       ['socat', '-u', connect, f'CREATE:{echo}'], cpr)
 
         self.log.info('%d CPR migrations performed', self.cpr_count)
-        self.assertTrue(filecmp.cmp(self.payload, echo, shallow=False),
+        self.assertTrue(filecmp.cmp(payload, echo, shallow=False),
                         'the data came back different')
 
     def test_cpr_transfer(self):
@@ -184,29 +213,11 @@ def test_cpr_transfer(self):
         it and shutting down the source
         """
         def cpr():
-            n = self.cpr_count
-            mig_sock = os.path.join(self.sock_dir, f'mig{n}.sock')
-            cpr_sock = os.path.join(self.sock_dir, f'cpr{n}.sock')
-            target = self.get_vm(name=f'target{n}')
-            target_qmp_path = self.prepare_vm(
-                target, f'target{n}',
-                '-incoming', f'unix:{mig_sock}',
-                '-incoming', 'cpr,addr.transport=socket,addr.type=unix,'
-                             f'addr.path={cpr_sock}')
-
-            # The target listens on the CPR channel: wait for it to be there
-            target.launch()
-            self.wait_for('the CPR socket', lambda: os.path.exists(cpr_sock))
-
+            target, target_qmp_path, channels = self.start_target(
+                f'target{self.cpr_count}')
             with self.qmp_connect(self.qmp_path) as qmp:
                 qmp.cmd('migrate-set-parameters', mode='cpr-transfer')
-                qmp.cmd('migrate', channels=[
-                    {'channel-type': 'main',
-                     'addr': {'transport': 'socket', 'type': 'unix',
-                              'path': mig_sock}},
-                    {'channel-type': 'cpr',
-                     'addr': {'transport': 'socket', 'type': 'unix',
-                              'path': cpr_sock}}])
+                qmp.cmd('migrate', channels=channels)
                 self.wait_migration(qmp)
             self.wait_running(target_qmp_path)
 
@@ -217,6 +228,97 @@ def cpr():
         self.boot()
         self.transfer_both_ways(cpr)
 
+    def test_cpr_transfer_dead_target(self):
+        """
+        A cpr-transfer target which exits on a load error after having
+        taken the vsock device over must release it on exit, so that the
+        source can be resumed afterwards.  The target lacks a device the
+        source has.  The source is stopped beforehand, so it stays paused
+        on failure until we 'cont' it.
+        """
+        self.boot('-device', 'virtio-rng-pci')
+        target, _, channels = self.start_target('target')
+
+        with self.qmp_connect(self.qmp_path) as qmp:
+            qmp.cmd('stop')
+            qmp.cmd('migrate-set-parameters', mode='cpr-transfer')
+            qmp.cmd('migrate', channels=channels)
+            self.wait_migration(qmp, expect=None)
+            self.wait_for('the target to exit',
+                          lambda: not target.is_running())
+            self.assertEqual(target.exitcode(), 1,
+                             'the target did not exit on the load error')
+            qmp.cmd('cont')
+
+        self.wait_running(self.qmp_path)
+        self.transfer_both_ways(lambda: None, size=CHECK_SIZE)
+
+    def test_cpr_transfer_target_quit(self):
+        """
+        A cpr-transfer target which has loaded the state but hasn't been
+        started yet may quit normally, and the source resume instead.
+        The target doesn't unrealize its devices on quit, so it must
+        release the vsock device on exit.
+        """
+        self.boot()
+        target, target_qmp_path, channels = self.start_target(
+            'target', main_incoming='defer')
+
+        with self.qmp_connect(self.qmp_path) as qmp:
+            qmp.cmd('stop')
+            qmp.cmd('migrate-set-parameters', mode='cpr-transfer')
+            qmp.cmd('migrate', channels=channels)
+
+            target_qmp = self.qmp_connect(target_qmp_path)
+            target_qmp.cmd('migrate-incoming', channels=channels[:1])
+            self.wait_migration(qmp)
+            self.wait_migration(target_qmp)
+            self.assertEqual(target_qmp.cmd('query-status')['status'],
+                             'paused')
+            try:
+                target_qmp.cmd('quit')
+                target_qmp.close()
+            except QMP_GONE:
+                pass
+
+            self.wait_for('the target to quit',
+                          lambda: not target.is_running())
+            self.assertEqual(target.exitcode(), 0, 'the target did not quit')
+            qmp.cmd('cont')
+
+        self.wait_running(self.qmp_path)
+        self.transfer_both_ways(lambda: None, size=CHECK_SIZE)
+
+    def test_cpr_transfer_failed_target(self):
+        """
+        A cpr-transfer target which fails to load the state after having
+        taken the vsock device over must give it back to the source.
+        The target lacks a device the source has, stays alive on failure
+        (exit-on-error=false), and the source resumes on its own
+        (return-path).  Then vsock must still work on the source.
+        """
+        self.boot('-device', 'virtio-rng-pci')
+        target, target_qmp_path, channels = self.start_target(
+            'target', main_incoming='defer')
+
+        with self.qmp_connect(self.qmp_path) as qmp:
+            qmp.cmd('migrate-set-parameters', mode='cpr-transfer')
+            qmp.cmd('migrate-set-capabilities', capabilities=[
+                {'capability': 'return-path', 'state': True}])
+            qmp.cmd('migrate', channels=channels)
+
+            # The target opens its monitor once it has read the CPR state
+            with self.qmp_connect(target_qmp_path) as target_qmp:
+                target_qmp.cmd('migrate-incoming', channels=channels[:1],
+                               **{'exit-on-error': False})
+                self.wait_migration(qmp, expect='failed')
+                self.wait_migration(target_qmp, expect='failed')
+
+        # The source resumes by itself, and vsock must work on it
+        self.wait_running(self.qmp_path)
+        self.transfer_both_ways(lambda: None, size=CHECK_SIZE)
+        target.shutdown()
+
     def test_cpr_exec(self):
         """
         Perform consecutive cpr-exec migration during vsock file transfer,

-- 
2.47.1


