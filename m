Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4D3CA5FBE
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrJY-0000ft-0Z; Wed, 30 Sep 2026 06:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJX-0000fK-7N
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:27 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJU-00045p-GD
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pw5LZWx2j2ENEBKTXXCbzyUm8ERzysgM/IpYzi93wKAfTTbNw2C7id/18Qx3uuiH2wU8afAZmV/UhiS8iSMFcAxeIGhmWn1/wBlqLntbl+P7UH7F4ENAhJy4V/glCGOr/joM54BzrpXvzTUTA/yQd9/U98vjTBKue4DI+svfIkZkDlLYUtApF8Wr+h2+VqaoDEoRCx+y3UeeFpMpGC+9N9eejN445+cwPzANt9eRg9dm1WDnKTpLeJckDgq4iDcflLGsDSJX2Sf4BKzm7eNOt53KXVoAVu/tU8WCpy2bcZa2aAIhgQx/1cBUzD0N0RREw6kCA/BtfricJEFS8nEjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrnP6454thqKAnh8JqgAnhdSAaYcplaIL4eTHi+Fs1k=;
 b=Z35/Be15A/mRvep+bl9fe+3e71SisCHXlVXKUIHJsAqVj+lsSz7QAG/iC7pABoCoFmdspD5eJV4UlXJzDY8Hox+ECr9tSQT3PlD+bBQ7THaAjPYLVqh/QiCjNh1SpZE8lPyeJmJ74ZDpwpKIsCrTvvE+gIKzrTWLlH+RX6nrrZr3N1PGdMG78FFfM8Vm4cIaAlgro5ywoiB9YmsV3699pc+fSmcV1ODOD+/Tuh/3Qu/eaG6oivioKfzPY01+nYsjkgA9hq11WlN+BmBKU4V5kOtYfP8mvU1NxEPjvhLOM1ltnR+bhpX2GH/b9SF+G0+OuJexESniFpDtrhOLKukGtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrnP6454thqKAnh8JqgAnhdSAaYcplaIL4eTHi+Fs1k=;
 b=gdvxeNG78Rg6+sQJhdOOD0iTeG9wR22Cn+ctpxsgNXaXyo/zw7BknIo02Xp7ZqfQYRjPiGW5NK4wbUMNKpSd7imF9/WjpSnZYLDhsVKe9MLEAKRTmDdTlH3EgYQDACaDo2ORBSRsx6hUTdEVJ1Q7Ke2c5iXG3DNIz68hXfpF31nBot4K36yxPY5gtM2frcOzBWPd539EdJtuL5i2GKsw6DBKzXD+43fUfDvqT6hrg9oaZEY8YZ2uX1XL+3whDHvyJqZwJx4vqrIGBBOcGrYuPkFd+vkcUFywgvhyPM9+kBsBZbxKizHCy/Wfp6v9QrLyd33kSemRz+zm94hK5Qlnlw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB6420.eurprd08.prod.outlook.com
 (2603:10a6:20b:314::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Wed, 30 Sep
 2026 10:13:16 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 10:13:16 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v9 00/18] migration/cpr: support vhost-vsock devices
Date: Wed, 30 Sep 2026 13:12:59 +0300
Message-Id: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKvgvGoC/23QzW7DIAwH8FepOI+K78BOe49ph2BgYdNKBQnaW
 uXdS9oeognJl79k/yz7iorP0Rf0erii7GssMZ1aMC8HBNN4+vQ4upYRI0wRQzRezriWBN+4Tqn
 MuEoMg6aWm0CBjqjNnbMP8fduvn88clnsl4d5g7aOKZY55b/70iq3vqdPRcdvRbCjg2BcahOEf
 qsxz0u6XNIR0g/adlS1V2RPUU0RjlPLHKgxuJ4y7JXerXVoivLB+EA4By57it4pzPQU3RTKLLS
 fEavF+F9Z1/UGAbmLqZoBAAA=
X-Change-ID: 20260908-up-vsock-vhost-v5-c781b39f1c1a
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, clg@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, 
 bchaney@akamai.com, philmd@oss.qualcomm.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 farosas@suse.de, mark.kanda@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, vsementsov@yandex-team.ru, den@openvz.org
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0066.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::10) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM8PR08MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 280400a3-8a41-41c5-e50e-08df1edb717b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: EpT3iOHeGSvtoJv8P9k8cXoZ+Ii75AXpjjPd0bH0qQ0K/BplkZ8h2yViGtPjYz/wpKBl7i4yH5M1r2zl86g+2eHE4g/B0Cw4wGZJsycUoRuzN6KiSh5R78Ft+IC8F0ejvmFOxNr+Zsm1iqWvko6k4kAbmXQAjU+gXmj2FF8/SpQbiwSqmcY5QaS8uiufXCsvCeYBr1gjMvPIIKTsnfKE14Kn8snQ43mFd4WcE2pUJeKDKZROyHhtpSdeZnfCuxlzhxbd5YXTtFmCD274+F86LnALGogprSsfY7ecg3lFmugX4f0UbdldkcQQVAf1FwS+rlvSxmj317+lhLz4WSrjscWewO8u72nRJNMCvmiLLi0nxA79CZno4UB6u2ZUHxj8UiXCzRongSy0HWinbtFrPvjN5wE1I4E1NCwk+DSOdr3IUkF80NQL5q4Dg0i6wbD/ehwbq5kHVQVHhGTnigVRphXESPVxMktucWlzZy6uWiZHOSGSxRKHOFPcFgDK/gSrQZ6e+7GZEvnaJCe2I7QF3XhR7xsgot0OJNzDYzmYs6QC8UfZRliFTqr3BaDpmC+QNnUiyoyOe/xKT0uGsGvHum4GQIHbh2mlUo+ug1e9jWv0qArkpyKBB8+3wSw/+VTGJFDXkANi+rWNHpycuq0IUVUU8mBspWAlQaVEeNK7ZB4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEtFSlk0NEtlcFNydDV6TUs1UkgySjA0WG9GSjhkeU4vQmZOVmNzcVpFZW51?=
 =?utf-8?B?bllPVTNoaHk4VVpHMGVyajljVGFqSVRUVXk0S016eWlLT043SUFtVWRNak0w?=
 =?utf-8?B?MSt4dmFnQTJXQjBXWXBsei9ScVZ6OFZKVW9WcXhZenQ5ZUdJWVBLOWIwVVVE?=
 =?utf-8?B?c3VwRHBOZ0kyQ0NnR0EyWjdLNVVwZmVRK1I2ODR6VitVb2xCand1a0NadlFo?=
 =?utf-8?B?bHd5UXVjRlJ4YWZLdDFBM2dIcVovVTIwS0xKbWlkWGtScnJDZjlqZXdEWDVm?=
 =?utf-8?B?eFBkaWJXbmcwZjF5MFV4M0cvMUhxelNDcEg5SC9zSXFZaHV5RnViL25UV1Zt?=
 =?utf-8?B?aFlsV1pybDllTFRMbkZTYWk1N1NaK1FSc0pCMFU3VVNjWW1Td2FEOTkxVmF4?=
 =?utf-8?B?SmY4MktQVm1KRFIycklHMW9iY1IwVEhPNWluT0ZUcXBHckVLa0p2c0FtSmZL?=
 =?utf-8?B?R0xGTHFtRi9OY0JJempjRm5IR2ZCU09uc2ZwOUVXYzJNMkdjbXp6dCswREFu?=
 =?utf-8?B?Qk5sVENQckxvRVJaWkFheTUzbHJFSFFaSmc4RlJ2S3ZKQ0lsd1dqaGpPNmhp?=
 =?utf-8?B?Zk9kZFQyaWNsWkhIdkJpTklXSzk5THF3bzNGYVUrZnJkQWtjWXlZdzM3VjNP?=
 =?utf-8?B?dm00a293cmJGdjVYQkY2R284U3JKQTdNZWJwbE11MHdOL2xHdkhFRWxpVGdr?=
 =?utf-8?B?UEFnWDZDVnhPVFlSdkg3SVE1SVVuaEJUejRlbCtYa2ZrdVpJR1NVMzB3enJZ?=
 =?utf-8?B?WUF0VzZrRDk2cjZKUHVDaGIzUERaejRvWkhzdTNkWE1rcHRYRmJheTZkTWh2?=
 =?utf-8?B?UHcxc0JuUzROU1FJeGdUWXl5WUNjZmVrMmdzVzN4bUNPRmtDR2FRWUhkcVVH?=
 =?utf-8?B?dnRqeXZTMHNXbDhUSWduOGtYRVJtb2llMnczRWtETXBudUhWa2hIcDBtNjFo?=
 =?utf-8?B?Qis4MG5kd2hnYkNIVDZkYnh5S3J4a1p4bU5YNXpCa1orbTdDbUcwQXlvd1Zo?=
 =?utf-8?B?a09JRTM4dmRsWFhBS3pYbWU0QUtnS0UvaXphUGg3bWY4R1p6N21CWlBxLzRx?=
 =?utf-8?B?b3dpNDVRVU93N1dpMjBvUzgyV3Vjd21VWVEzYU9Ic1dYWkZaNmpSSjlFSjEv?=
 =?utf-8?B?OExYVnNFd0p1WGFFSUZ4VjgzMzVVd0hqQlVCU212ODAvQllLU2dQZXR1QTJ2?=
 =?utf-8?B?aTlMem81NUhJRWpYaXRmcUpKc3JZM1JkeGZYNlNJWEo1TThKWnpLY2pqcytW?=
 =?utf-8?B?RHZYZ096emlpQk13NWFZY2JuSlVrNm9uWXFlQjdmQ1E0RERnVWREbGIyL2Nz?=
 =?utf-8?B?V2xlQ0xwNUY2WUIxQ3pERUdIMTMzbDdUS1VTLzgxQTVCZzRpK3ovb2VxcXlO?=
 =?utf-8?B?OVJpMlVTbzBtWnB5QlpKTlZDMlhzSVJFcmJ3RlpDZGFIRWpGdFBwYzlWZGhW?=
 =?utf-8?B?blk4NDl5MUVpOXozWG16dUVOMjZyKzhJUzFDbHp6a3ZPN293UUFJdG1ydmtl?=
 =?utf-8?B?dHNwdThaeEhXNHF4YUVuWnFtclZZb0RsdVlJTHplck9hOVlkTkdTSlJ3ejhB?=
 =?utf-8?B?RnJXLzJVbTJzUGRjSW5zRFJiZ3hHcWdnQ2tUTXNMR0gyb3dkWFVWZnJpS05j?=
 =?utf-8?B?cXAyQVpqUUNLQkRtL3EvaG9Na0xRTjNFV1FnRDkyNlBpbGVXbmpBNlRsVHQr?=
 =?utf-8?B?bFp0NXRiQ053T1Zrb1BjYmxJTDIzdjlyUm9NWk5zZ3IxWk5FcHVvbS9qQnNR?=
 =?utf-8?B?enl0bjhKYmgxbnQ2SERSNC9OSGswdXZBUS91RlA4UXhTN01ZZW9NYXBTMlk4?=
 =?utf-8?B?Yjc3YWo3b0Q4SlpmdUdRa0UxUFFVQkkrcE5tZm5nR2xsTGhMNVQrZ2p6KzIx?=
 =?utf-8?B?YzZhc2pDa1FLVWg2UHAwWDRLc3BSTXRnUlpuNGhDRFN2aTNUdFN1YnpxVi9o?=
 =?utf-8?B?WjhvMS9qU1l1U2llbk1oRkFTSUhuWEJXeDZCenV6VVgzKy9xWlFsMmtBeW91?=
 =?utf-8?B?Y1JNaGx6bEZUTjRBZmpDNHFLNmxIaytBbXlFT2x2bVY0MldkSE8rd1FiYVlS?=
 =?utf-8?B?d0lEVmpOMWt2VDhGaklTTSt0UHdEbWZEYUJaS29BRCtrd3BGMUc4WW9QRVVk?=
 =?utf-8?B?b1Y4dkhIaW90cTdVVEQ4eDRweGlwbHY1bzNNYTJmaTFZeEZjNzJ5QzJiYUE5?=
 =?utf-8?B?a2dOcjdYQVNyVU4rSzgyWHAyY2pLN05GTXBIcDZscEJuMkNnYnRyaDErc0dC?=
 =?utf-8?B?V1RkUkJjZlh2QmsyYm1LN25WSUhxRFowWU93WHI0Mzk3TWJKMXBjSEJORlhN?=
 =?utf-8?B?UFZ6UnFHL0xXTXJ5c0RTc3NNNHlwVEpzZnBPVDA1YnFtcmo0OW5SWkVEZGxL?=
 =?utf-8?Q?iXJtDp1pZwt8uubc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280400a3-8a41-41c5-e50e-08df1edb717b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:13:16.2540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SstK1dQIO9RIML/FvCxGvXutc+fuuRRyG/5aSU81AWuUBzvDh3VaCe2UA3B+2JCk4R6FtXue8cM7J2swEFrX6Quc94QK4AlAL3jZwEksi8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6420
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

v8 -> v9:

  * Patch 5:
    - add '-machine none' so that the test works on targets without a
      default machine;
    - add a comment on what's being checked in normal mode.

  * Patch 15 (NEW):
    - release device ownership if vhost_dev_init() fails after SET_OWNER.

v8: https://lore.kernel.org/qemu-devel/20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
Andrey Drobyshev (18):
      migration/cpr: forbid saving duplicate CprFds into hash table
      tests/unit: add test for duplicate keys in CPR FD table
      migration: forbid snapshots in CPR migration modes
      migration: forbid snapshots under Xen
      tests/qtest/migration: add test for snapshot rejection in CPR modes
      vhost-vsock: block CPR migration modes
      vhost: add vhost_reset_owner op
      vhost-vsock: don't reset connections during CPR
      vhost-vsock: fix FD leak in realize()
      vhost-vsock: preserve vhost FD during CPR
      vhost: factor out vhost_dev_init_backend()
      vhost: make vhost_dev_cleanup() safe on a partially initialized device
      vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
      vhost: add vhost_dev_is_initialized() helper
      vhost: release ownership if vhost_dev_init() fails after SET_OWNER
      vhost-vsock: hand off device ownership across CPR
      tests/qtest/migration: add vhost-vsock tests for cpr-transfer and cpr-exec
      tests/functional: add vhost-vsock CPR test with a live guest

 backends/hostmem-memfd.c                        |   5 +-
 backends/hostmem-shm.c                          |   5 +-
 backends/iommufd.c                              |   4 +-
 hw/vfio/container-legacy.c                      |   7 +-
 hw/vfio/cpr-legacy.c                            |  29 ++-
 hw/vfio/cpr.c                                   |   6 +-
 hw/vfio/pci.c                                   |   5 +-
 hw/virtio/vhost-kernel.c                        |   6 +
 hw/virtio/vhost-vsock.c                         | 193 +++++++++++++++++--
 hw/virtio/vhost.c                               |  67 +++++--
 include/hw/vfio/vfio-cpr.h                      |   7 +-
 include/hw/virtio/vhost-backend.h               |   2 +
 include/hw/virtio/vhost-vsock.h                 |   1 +
 include/hw/virtio/vhost.h                       |  61 ++++++
 include/migration/cpr.h                         |   2 +-
 migration/cpr.c                                 |  64 ++++---
 migration/options.c                             |  13 ++
 system/physmem.c                                |   5 +-
 tests/functional/x86_64/meson.build             |   2 +
 tests/functional/x86_64/test_vhost_vsock_cpr.py | 245 ++++++++++++++++++++++++
 tests/qtest/migration/cpr-tests.c               | 133 ++++++++++++-
 tests/unit/meson.build                          |   1 +
 tests/unit/test-cpr.c                           |  98 ++++++++++
 23 files changed, 876 insertions(+), 85 deletions(-)
---
base-commit: 9c88811b81a935a172c5c873b2ada2d9b38a5f74
change-id: 20260908-up-vsock-vhost-v5-c781b39f1c1a

Best regards,
--  
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>


