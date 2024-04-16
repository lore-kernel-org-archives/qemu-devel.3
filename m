Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E429DC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 19:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwoul-0000Ga-Le; Tue, 16 Apr 2024 15:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rwoug-0000Bg-5P; Tue, 16 Apr 2024 15:56:18 -0400
Received: from mail-he1eur01on0700.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::700]
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rwoue-0006Jq-1h; Tue, 16 Apr 2024 15:56:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrU/wQ28SukjYvH+ywUHLCisbUjxIVsBJM42hBgMjE6y+jVcRcXcuxvGRcRfJOEUXRBF73YzqfRR5yZQpO1McHxd5FYU2Txj0yf3FL+AFuHIa3LyC6vPIqVKtZx65ktA54ghmsW18EF4WiHVsrYnQCP5V/kO1ferWTNF6zIndikhfRuek4zZNQFupa2Eb15HQ0LZ7r+EdTCGWEPGzJOi0iO4TbEKEEkof64saBu9pMmlOa5ZZYzyuHhbD0xc6ZmOnQenOziarTQq+a9nHojSq7fJaodhwZ/TI8a30fUcElTbMVQtdRL2vbMYkAdwD6lSDHa/PhlSZerYyA038aMMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPob7Oob0rB66Hqd5q0OFwqPo8Z/yQ2OYNjh2RmhP5U=;
 b=SeBAT2ct80bQrADx+E1n0siX22a4zcYuu5lMmIe/gcZQCG0TIQwzuhzlaO2637WakYP7qiWxPDkobTW+C0zkyzac7Z/AXu17rnjK0P2fnJLUrcWonUiW5IkExHcJkDx/BDzWRh9mGK90bUSEvPZBwVI/eghstPC3BSoSPFPRiSJAMPk/m3wvrR17UJ5AvoIH5gjVY26QySpY6EOEj16dhY1HIbmYsuSFM7U3tIgYHxSlFmGKDXSZcX3Fiz6jkfOHQs2a5ioDlGhiV831ZEcyUUEcJwUz5FdJQPvpK0fj8UhOFHnyQk5TO98DbZfzHeWjcfwkBkwJlXU4jAHW07INqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPob7Oob0rB66Hqd5q0OFwqPo8Z/yQ2OYNjh2RmhP5U=;
 b=fBorXoLZ17BbxnWEY5M45VRCBrV6hhWtA2kAVPrFNCL/ROVHuVscLj/QBJJ+y7N2k8L97Eqz8/mTBhIHJ6SMQdQNukQIF9fFBySgmGK+2hkh5KthfHY1PZAiSUgNNlkvhCxAs5SfHQ7obDbKIosu/SHiWYhnntOAXryZhYKN06H06aBknrL7jWo8wk/JoEVcOAuA/rL3EzJX6er4SzYlA4ovsAaJneups8zWYtjCDYtKJw1+RbcnbShbPiRdj+/wOnhsp7DS8xRlO//hrBflqZyKcrw/iug4xT2zZ8TkVBWVuvQ0yPIhQ9dkxo7qqJoqGRKXU72WhOuakbZPcLaQdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB8PR08MB5435.eurprd08.prod.outlook.com
 (2603:10a6:10:113::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 19:56:08 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 19:56:02 +0000
Message-ID: <9fcebaf5-bdac-435f-8582-0dab75ff7afc@virtuozzo.com>
Date: Tue, 16 Apr 2024 22:56:37 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] qcow2: make subclusters discardable
To: Jean-Louis Dupond <jean-louis@dupond.be>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, den@virtuozzo.com
References: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
 <20231020215622.789260-5-andrey.drobyshev@virtuozzo.com>
 <b92c8ede-604f-4859-b3b8-7e2fd7824274@dupond.be>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <b92c8ede-604f-4859-b3b8-7e2fd7824274@dupond.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::14) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB8PR08MB5435:EE_
X-MS-Office365-Filtering-Correlation-Id: 3795a7e8-90aa-477e-6ba8-08dc5e4f3e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLzfsqyQARsy0XHpT16QUCgHnjw+bxIJJoy+4LFh2orw4CwPDhUhXUwQSs9seR3UWAu/gKawMFuE7e3Iv6M/iBoqxgLx1eIb4K/atJV56ah3urTaBZTlExh0OiFW3UGYxNyGB11mbaYw3TTmY1GCTs319w6iU0AUy/ZmX9jLh7fL/1dLatrz/ZGLXl2rR9Tsbqr0ifSqjM7fM5tU/m7BwqQ7srMgmD9S7YlA3sFwlVb7LtzyKU/6ZwZRhJCVJLUC/GMbPAtJkYfWg2N4J0tI4Q6t2nw9M8VrMuiXl2Z52oVlfOJ6o761mJdNEZagvUuZd+cOVzBuwEptwNXYJzZVni898+1S4kqdqrAhF6JqU/XifgKy6gKz2V2wSFmPVDCg5HlLXCv7MBEYnWInJhNok84MMEnNBBPcAwVMKCFbPfSQE46sLDObNb3EppxhuFPscB+PFtD2VIu9d4UboeJqAyup2KfNaIdgg0CcijUk4U7PPzvfSa4yGNeK3RsI3Ev5K2cJ16LjIy1vb0WrDfHhLB05aBMwpFQAZ8N3RVzte7WgNFm4xlscfVdyeyQ8TT9bYVw8Xy1mGRIXQphVOAm0xGmddriiz3zZ1wxXhiLqWYKXUuqrBKGf9ERNai2E8filY/bnfLtZIc/gaBKmwm0XOWI6FyHqqMeEPWw4/a9SQ+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czdtbURueE5jeEt1bERNWlhSNjB2NWFZTjUvNnRIQkRraVBiNFFNOWZSMjkv?=
 =?utf-8?B?MXZ4Wk9tMllsRXBiVThGcExVYStkL2FIcEk3Vmt0aU85dHVEa29rbHJTZDdK?=
 =?utf-8?B?dC9wWTdPMWRQR2JjL05uMWpwa0NqV0NFYTJYNHBMWnlpTEpOeFREOHRoSURp?=
 =?utf-8?B?YnVBdUx5azFnYU04a1BQVko1RGg1eUQzVlZzekhaeCt4Z2llZzgrbDR3dEtM?=
 =?utf-8?B?NFc5Q1p6a2JhZlYxcFNMMEswS096ZHBsb0Jvd3NNTjUzY2kwaFR2TWNCVldw?=
 =?utf-8?B?RW9Ba1l0V3g4cEpLRmVXQkNzbCt0MDF6aUhUc3VMSURSS1dldldLdmRheWZs?=
 =?utf-8?B?c21md3JFU3ZmTW1mY21vWE1DNDBJOE1EQUlvOVJoTmxCVkhHWUI4WlYrTGI3?=
 =?utf-8?B?ZDNXc1ZXVFFBMzM4aTFvaUtvSVhoaXRKNEh2ODVlWVJ4U3NHN1NpRzdMRzVa?=
 =?utf-8?B?R21zZ3oxYWNMS2k5Y0pXUnZFNTJTcUlHRVFFbGU3Qm96ajk4SjdPaUkydnZ1?=
 =?utf-8?B?R2dWQUd0TUk0ZDVBb0JKL0h0d2ZvWEx1aSsrMU5tdHUzWUZSZ3ZEM2FUQXlX?=
 =?utf-8?B?dCt2QTNpeGhUMkNIL2cwOHowUnBXV0k5Tk44UldHUk9DYnh4Qjh1UTdLTHF6?=
 =?utf-8?B?MEZsdUVsWW1jRGtTRUlzUHlHL0pQeVYxVjZOeHlOYm1qMGJxUFR2cWFaMDhk?=
 =?utf-8?B?NytKMTJMSlk0Z0FYSnhNV2JJZ0h6dFRqY0ZkOGdCZjl5T09CbDBhS2FaWnZ5?=
 =?utf-8?B?VUExRjR0dEd5eWhQUzVJZmtnbDJhSDVxYlVLN25uUzdkaDhIVWtkV1ZwYVRB?=
 =?utf-8?B?d1BCT29MdENlQVJJZHVnSkdrVUYyOWRZb25FSStUSGh2T2lzblk5QWlXcDl2?=
 =?utf-8?B?MUlLb2R6blFZRmhXc0Rtd1d1VlBwRUN1cUFSUkRGNUlPK2xranBTZ3NWRXcz?=
 =?utf-8?B?bHFjU3BIeEtNbENSQ3pPdTdjUnVOWGtUY0sxOUd6Rjc5TE5uUlQwZnJxQVFU?=
 =?utf-8?B?RE1pSU9rWnFURmtGbmRRc2VDNldBU0lqUWUrU1ZWU2hnYUJZS3NFZzhFc2tF?=
 =?utf-8?B?VjRZSzNXZzI3QUpTYkpYSmFBMjJXdEc4WEx2QWZiQktGVThTVTA2d1E5WTNX?=
 =?utf-8?B?RkFMaGVSd24wR2pkQmd0aXBHNE1YdUpGOVpPZG1IcFUzOFJrc0tVeVlyRWd6?=
 =?utf-8?B?WmIvbmF0ZmkwWUIyWXY0RHl3U2xHN0pjKzZxSXVZTFdBRFVwS0trWk0yQzBv?=
 =?utf-8?B?VVEzOTFRd0tybnlQQUszcm54ZnFqSExvZzRKV09IYnJRUU5EUjdjaVJBOGs3?=
 =?utf-8?B?UDNFL1FJdmg3c3llR1VKQkJ2Mlk5NTlCaVN3a0t0MURaUnhSYkFiU1I0NUVz?=
 =?utf-8?B?dkhPL2FWZUV2V1NqcTlKK3c0V3lYc2hXZUg4UXNrcDdxUU43T0dDeERDUEhP?=
 =?utf-8?B?cTl1V3ZydFQ3UUMvaFVNR1NtTkpOZXllOXBaVzFXNFB4cE9URUYwT3o2WEV1?=
 =?utf-8?B?aURMVFZHc28yb3NWSld0NUNnMFdBbEFWeTVPaWlEWFdZaW1Fbms5ZHo1b2p6?=
 =?utf-8?B?RHZRWkJFTHI5R2U3UFBOdFJoSjJuSG12VXUrZ0J1MVRwOWFLUEJ2WlFVQ0xQ?=
 =?utf-8?B?WDYxZStxRGFpTTJ2eFpmRldPSllhUEIxaVZPd2FjaGxNd05JZmFKTy9QQzJT?=
 =?utf-8?B?T1k4WmpXWDEyTDVTZHNtcHVxSjlweG00WnFtSGZ3RHRaQUNRM09VY3VEVzBZ?=
 =?utf-8?B?aUF3Wk1WekpMYWliNUxLK0Rrc01rVEk2TTRBbkVKNTFMR1F4Q2tUV3lpSlNX?=
 =?utf-8?B?d3FUNS8yTFA1dFhKYTFFTGNRL0pTU0JzQlBXUXBZZ1dmT3RGQmtHSSsxOFZR?=
 =?utf-8?B?d0xvOHppUVlrS1l3Z1huYU1XQzlMM1dBREFDYTdCN3NrS3RkbFkzU1NtQ01p?=
 =?utf-8?B?ZGhuUU5rclM0ekFteUNVQnppYi9LUzBjQk9VQlNjdGJ6MFRrbEtva2RmYzNS?=
 =?utf-8?B?RXViZUJTMm8yVVYxZ1hpejdLZ2hvczBXY3hVMExtdUZEdXBZUnlQODVSeU5X?=
 =?utf-8?B?eGRjMkNZTzdjN3N3MThyR1hHRFQwS3ZMZHAwZGxFMVhBdTZFM2kyWmx6T3Iz?=
 =?utf-8?B?MWY2NE9PbGdpMWlZTXo1Mmw3ZDlqUFoySTNiVGpCSUpKWWtXSmJKQ01Tb0JM?=
 =?utf-8?Q?8bSQm0V19Ma1cWYnNhlBt68=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3795a7e8-90aa-477e-6ba8-08dc5e4f3e47
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 19:56:02.2331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NIQIstuRAdFbDHMVil/VKcH7NujX6PsbPskKl4rUXyWffeT4q0K50jKBv2QYCEhDsIxbEBpWIyDnzkLH//3onzjRyVxcfj6FEPlYIIpZFb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5435
Received-SPF: pass client-ip=2a01:111:f400:fe1e::700;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
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

On 10/27/23 14:10, Jean-Louis Dupond wrote:
> [...]
> 
> I've checked all the code paths, and as far as I see it nowhere breaks
> the discard_no_unref option.
> It's important that we don't introduce new code paths that can make
> holes in the qcow2 image when this option is enabled :)
> 
> If you can confirm my conclusion, that would be great.
> 
> 
> Thanks
> Jean-Louis
> 

Hi Jean-Louis,

I've finally got to working on v2 for this series.  However I'm failing
to get a grasp on what this option is supposed to be doing and what are
we trying to avoid here.

Consider this simple example:

# cd build
# ./qemu-img create -f qcow2   unref.qcow2 192K
# ./qemu-img create -f qcow2 nounref.qcow2 192K
# ./qemu-io -c "write 0 192K"   unref.qcow2
# ./qemu-io -c "write 0 192K" nounref.qcow2
#
# strace -fv -e fallocate ./qemu-io -c "discard 64K 64K" unref.qcow2
[pid 887710] fallocate(9, FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE,
393216, 65536) = 0
discard 65536/65536 bytes at offset 65536
64 KiB, 1 ops; 00.00 sec (252.123 MiB/sec and 4033.9660 ops/sec)
#
# strace -fv -e fallocate ./qemu-io -c "reopen -o discard-no-unref=on"
-c "discard 64K 64K" nounref.qcow2
# [pid 887789] fallocate(9, FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE,
393216, 65536) = 0
discard 65536/65536 bytes at offset 65536
64 KiB, 1 ops; 00.00 sec (345.457 MiB/sec and 5527.3049 ops/sec)
#
# ./qemu-img check unref.qcow2

No errors were found on the image.
2/3 = 66.67% allocated, 50.00% fragmented, 0.00% compressed clusters
Image end offset: 524288
# ./qemu-img check nounref.qcow2
No errors were found on the image.
3/3 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
Image end offset: 524288
#
# ls -la *.qcow2

-rw-r--r-- 1 root root 524288 Apr 16 22:42 nounref.qcow2
-rw-r--r-- 1 root root 524288 Apr 16 22:41 unref.qcow2
# du --block-size=1 *.qcow2
397312  nounref.qcow2
397312  unref.qcow2

I understand that by keeping the L2 entry we achieve that cluster
remains formally allocated, but no matter whether "discard-no-unref"
option is enabled fallocate(FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE) is
being called leaving a hole in the file (e.g. file becomes sparse).
However you say in the comment above that we can't allow making new
holes in the file when this option is enabled.  How does that correlate
and what do we achieve?  And which logic do you think we need to follow
when discarding separate subclusters?

Andrey

