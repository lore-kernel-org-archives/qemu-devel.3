Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37CECD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 14:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrJ3s-0002X5-UX; Mon, 01 Apr 2024 10:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rrJ3o-0002Wv-O8
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 10:54:56 -0400
Received: from mail-db8eur05on2133.outbound.protection.outlook.com
 ([40.107.20.133] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rrJ3m-0004rB-BZ
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 10:54:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOthV62cbz4ERX81UCGEmuCGZLSnpYfX1cS8nqkWK5YvBPL5TncPDTz1uV0o2A293ZEHv0nKZbpPkC1XGGxEkzSvVvDrsBl1GpdPYjSQfdV5M5xjDNC3clj+BJD6Z3zdnnr6QKCcTDr5n200LlO2XmvxvlTLACpBkGvnQFMMtlffpE0QwKdokCbJKRUmwjFlXslaJOvpSw50tb0AHjeoHlKcb0OAQk1vVqeew646G+H+vfiD5n4NSVqjhTdmtH1gk9y2ctV4O/PGhXU3qp6pfoRJ6cCGEAN1oDKTziazMWtge4Z2WB23awdK5kFTtlKvl8/gpcnWNjuFd98fFOnNyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PbFQPTl4fs1Mtu2jCemn5/yivypRwk7JJ1HqTPlvk4=;
 b=TwW+xIFaBmO3cb2ELDFX0d+F7AAVIGY/kbuWIScda4gHF4PNojgZY/gz3BDzH/a3qDv4lcIHG/g6thk1l5UeffFpTwxNbZl2lkA4iM8uGfrxb55dC38QGJq2pBl7JFM5ZUyCZCc1NFjIf4m4r+3jzpIFogF7//L9tf6i0wPuBlc7dm6u1xmAAb6n5gRRTH/sw3GwovNCfBq8X1Ug1IyunIHvcG6hGJNPI8C1VnMQAFNY1lv1QcLKpPGQhiE4r2xRfatL4KS3jdRufCvnZxqNnJuoz78NYl8aYyXOMIWQDUSDNqNjVwg4Y5Ov07qpRQ5Y/F6gWc5PrQu8KSW1v11nFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PbFQPTl4fs1Mtu2jCemn5/yivypRwk7JJ1HqTPlvk4=;
 b=b/6pLJI2UlCLAsNYQT6x0vC6E1aIMCbM4a5DpIhr7EsA35K3ZvV2nYtaLL3jwqKDcen8nCxSjmYGaVU0z4CdiVWB/MPrUMtKdyDG2kTGSqb4lA208gO9XSJJLE//9Tb5kbeeSCJA7J3fNx2mt0pzia+XnsPg//uJTJ7W9CXxxjuGEM/77bIIG0QPVEWPrfsRPMx0tDKASI6RoIBk5b118DQDih9WotGIqRjwTyrVy3hnQyb+wFfFyuwO/Zxs2qAHVU64oQg9vkODpOtWbAqnY69pHtaLoP12dKm9d8/ARFPY9kTY5+tpTLc4iO4ucn+v2oLQO7h9zJ5I7FfcqmuOQA==
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com (2603:10a6:10:52d::7)
 by AS8PR08MB8111.eurprd08.prod.outlook.com (2603:10a6:20b:54d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 14:49:47 +0000
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::50a8:5a05:2ebb:15ed]) by DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::50a8:5a05:2ebb:15ed%6]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 14:49:46 +0000
Message-ID: <280cd27c-d771-4c23-9612-c3fdcd556114@virtuozzo.com>
Date: Mon, 1 Apr 2024 17:50:08 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] qga: guest-get-fsinfo: add optional
 'total-bytes-privileged' field
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, marcandre.lureau@redhat.com, 
 philmd@linaro.org, den@virtuozzo.com, berrange@redhat.com
References: <20240320161648.158226-1-andrey.drobyshev@virtuozzo.com>
 <20240320161648.158226-2-andrey.drobyshev@virtuozzo.com>
 <Zf1f1yajMqqF6G6t@redhat.com>
 <d3c9b601-8363-420b-8a3b-13dc50f0469f@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <d3c9b601-8363-420b-8a3b-13dc50f0469f@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::21) To DBBPR08MB10650.eurprd08.prod.outlook.com
 (2603:10a6:10:52d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10650:EE_|AS8PR08MB8111:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ryGS/XN6XBygCmI24V1v9SRXZdh0BGVuD0M/EMPCDPoDGkorpz0bDn7/MbvkqQNlvAvPU+HAeJ+pzsVTa+aC3JtB0H1jtknFpKTSWCJT3j5vhm1WyUgk4BMzpD2h9tvPv5jWCeGcLlJiPXS9j/LLGStMuCTVSq8aE696O5wkJAL6+8uA0ViiL7qBH8iiIrEiKkPVCkn50F44qPkiWISzURhKR6G78yXOD+FoZWj73kP60+IRjSoCXmBJU+G56YI9JMnvmG1mVNodAZDe1wSyL3LRyFxcxH4HXdLuHo0JFXS1N6tWn6TsQcs+UNUCVwZmj4iR9anfm90wH/v9U243c0+34+HiTyudpCYzMUw5ULcQveU0Nwqop06XBkzopu0lJ+mZB/x3B7SciP6WmsBig1nL/lUgYF8vo+GO4exoepEUrKtxWQ0fotckRfoYlyqfCq1QyOnXset5pQc/+dOjaVQLdZ27/cwYymYW/R9I/JBUIyxMQadt7L2Q22FZyrmo/uzbZ0RUDjOo85xkPtYdUIeqBGDoU9vjXC3SSF0qEYiPFlFvzt4gE6JcOXGn2vGThBUQ6CrjoAR31TjruZP/OdW5hHukqpIkEMlWVaWaXe/at1IdnOL/vuVw/VW2JL1WkmcBQLHvA8dy1/wzQXYbbRlCbJhfCjQt1WiubTBePKc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10650.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0U3aENLaWExMGhBRnNKeU9rZGRFNWdnRnNsZ2N1clNpbEhSTXUzckpzMG1m?=
 =?utf-8?B?TVR5M3AxNEwyeE51ejFLd2JhM3oyaGN5T1gyQjF5NDJ0dEEwQ1lkSE56UG5C?=
 =?utf-8?B?Z3NDQVB6OEZ5eFdhZTAzTWFnS0hERWxJVHR0NjY4b2pFMkZldTdFc2lCWnFx?=
 =?utf-8?B?K0Mzd3l6MzZpVDNCVXNoY0dpWmRLOHFta2JSZk40VWhEbkNyc21PODNHMjZr?=
 =?utf-8?B?c09rUysyM1FBMFpuUnJ4MWpoV3lmZWpoVkdyK2o5Uy8ybzQ0VDlYdFQzcmRE?=
 =?utf-8?B?K2txeW80WWo4NDRnV0FlWkZreTg2ajRpei9kWGsyMUFGMC9ZTWd2aWNxc29Q?=
 =?utf-8?B?R0Ztbmgrdk5TWHpWL1d6M3N4RHAxSTV3L0t0SnBXM1YrVmZlL3dTQW9MaUQ1?=
 =?utf-8?B?RmFBVDZvQk9ZSzhyRmVidktscUxOZTVuSHIwS1JhTldDY2d1ZExtVWtjdFM4?=
 =?utf-8?B?ajNVOUVKZnNmM1prT1RkQmJGYVFoU3ZhVzVBcEc3UkxtZ2Jza2xTbHlBQWcz?=
 =?utf-8?B?RTI2YnZTaXV5eHZXT3UxSVBkMjhzMFNYRjRPMVJDdmhMblNzelM0MkxURTdq?=
 =?utf-8?B?VnVwOFhmUzRyWkIvVWpxdXpPZVFNNm5vcVVteEVMd056WnNrL2JOeE00TW1Z?=
 =?utf-8?B?WUhpNXJzcnVONmlJaEpCa0dheStqOVNVWmpCeVZQMlVjUVowakFqQy9hdlBH?=
 =?utf-8?B?aEQwdjFPTTBuUXd2Y28xdGFMK2ZlQXlza2E3TEZGVWNoVWZvd3B2ckw0V3Jz?=
 =?utf-8?B?bXE4TVRoWkpEVXVTQ0R5R3dYeGwzRlZmWUNNekRHUVJucFE1WG4rR3Y1NnN6?=
 =?utf-8?B?MzRzUnZzTEVvNHEyaGpadGExd3lWMGtucXRGWFdHMWtaVEJRZ3lMR21uOUZp?=
 =?utf-8?B?NWhtU1ZsZHF6bFp3ay95OW9SL0dzcGZURVphdEV4VGtIT01XYzdzL1VOVUhz?=
 =?utf-8?B?emhZdksyQzNtdG9BbWU0UUQ2aEJRdVdZZHBEUm55SzlYeVhna1RLMC9TZ1lp?=
 =?utf-8?B?SGg0dWZFajZhK1Vha3NjeHN6Umd2Z1hXM1RzWGJhMkh4RlBWTERJZFlqcnlB?=
 =?utf-8?B?QmRkcFVWaXlaLzlMRjFWa041cEp6YmdML1gwTnlzaGY1SllDVHZseHIrWjlC?=
 =?utf-8?B?bzFEL1RoYzJkM0hMMWl1OWpvRkgySUxZc2ZDbERiVDRiTExIS0FNRytPeVlw?=
 =?utf-8?B?Mngvd0hZcUZxUzkvUUExNmpRak02ZmpiZm8rWTRCVDZQZEdhQTNheDVGZGR3?=
 =?utf-8?B?L3djVzlEWVRDTGFYeWViUEk3Sm52YTZOeHVnekMwWlJYWm15ZTlieEw1Rlgx?=
 =?utf-8?B?UytHR0VvZUZwZXJBR29sS3NsdmhvTko0ZTdXb0huVlJ4WFNwN3Z4Ukp1ZUtP?=
 =?utf-8?B?YXFhR2NnZkoyNXlqQkNlVTVKb2FhV0tWbGpsTitYT3o4S1pnN2VoMjZ6aS9P?=
 =?utf-8?B?TDRYb1c3b3daWEEvZkxCM05UVW5id3IyeCtMZXN3Z3V2UWUvMUZuNFo2anND?=
 =?utf-8?B?L21hL3hwU2JXSEh6RGZDcDh3aWR1ODQwTnpaalhkM1VscWs2QkpSU1FQRWR4?=
 =?utf-8?B?SnhmQmMrd0VubHpEcEFKSVEzSDgrOHRDZFJTNE0wZUgxNU9USm1Kb3ZkRm9X?=
 =?utf-8?B?dE9hRjhWayszVUNGQ3lMTnlxTDZTeGRXbEdFdXR0dkN2Uk1TeFI0ZVZWa2tj?=
 =?utf-8?B?SW40ZWVIME10YWNWazlhcW8xSU8xbEFqNmlxOWw1eEZ3cVdLNDE0QVFWdWlh?=
 =?utf-8?B?SkdzM0kvWWNmUTVuc2tUZmQwMFo5K2VYY0RoK251dU43WEluWVJmREx6dzgr?=
 =?utf-8?B?clZsREQ1VGVLdVRoMmZQYTVDL0J3Q2xmYzZ3YVBGV1hFcWtMZXBNei8xVHZn?=
 =?utf-8?B?QlZuTU5Lc01HTHFGU1ltVUREdlVWRjRicHZKK3VpMGZ0OUs3RVJNd1lGOWJK?=
 =?utf-8?B?ZXJneFRXNkQwU0s4THhBdXRRU3h1MktGVU1uajZPYVdYNlpoL1RvaDRYQnV6?=
 =?utf-8?B?MXlFTWJJZDFMZURoS01HOGE0Q3VGeklpaFN2TUFBenZuMXAzSnNvZmdCWGJW?=
 =?utf-8?B?czF3WGkvVVFHMEVGRFVEdzBPUUJGTHpCeGVmNWNsdVJvUHpscit3WDhtSWVR?=
 =?utf-8?B?V3IyeElyNG9qSktwOC9heTU3RDlrVXkybFhkQU45RmZ4Sjd0Nlg1U3FSQ01u?=
 =?utf-8?B?aHc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3eb2cfc-ebb6-4bf0-aaa5-08dc525af998
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10650.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 14:49:46.9207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLtdW9Kn3mrb4cAvUxxEN8o/0FDm6epeq4NvZTJgoTpXgC2Cyw6WfU0UiYvYqJiz7OXbr6b8glAA3KFm+f8rbcxnsRYwPT/v1WSRzxyTjSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8111
Received-SPF: pass client-ip=40.107.20.133;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

On 3/22/24 15:17, Andrey Drobyshev wrote:
> On 3/22/24 12:39, Daniel P. Berrangé wrote:
>> On Wed, Mar 20, 2024 at 06:16:42PM +0200, Andrey Drobyshev wrote:
>>> Since the commit 25b5ff1a86 ("qga: add mountpoint usage info to
>>> GuestFilesystemInfo") we have 2 values reported in guest-get-fsinfo:
>>> used = (f_blocks - f_bfree), total = (f_blocks - f_bfree + f_bavail) as
>>> returned by statvfs(3).  While on Windows guests that's all we can get
>>> with GetDiskFreeSpaceExA(), on POSIX guests we might also be interested in
>>> total file system size, as it's visible for root user.  Let's add an
>>> optional field 'total-bytes-privileged' to GuestFilesystemInfo struct,
>>> which'd only be reported on POSIX and represent f_blocks value as returned
>>> by statvfs(3).
>>>
>>> While here, also tweak the docs to reflect better where those values
>>> come from.
>>>
>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> ---
>>>  qga/commands-posix.c | 2 ++
>>>  qga/commands-win32.c | 1 +
>>>  qga/qapi-schema.json | 7 +++++--
>>>  3 files changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>>> index 26008db497..7df2d72e9f 100644
>>> --- a/qga/commands-posix.c
>>> +++ b/qga/commands-posix.c
>>> @@ -1569,8 +1569,10 @@ static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
>>>          nonroot_total = used + buf.f_bavail;
>>>          fs->used_bytes = used * fr_size;
>>>          fs->total_bytes = nonroot_total * fr_size;
>>> +        fs->total_bytes_privileged = buf.f_blocks * fr_size;
>>>  
>>>          fs->has_total_bytes = true;
>>> +        fs->has_total_bytes_privileged = true;
>>>          fs->has_used_bytes = true;
>>>      }
>>>  
>>> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>>> index 6242737b00..6fee0e1e6f 100644
>>> --- a/qga/commands-win32.c
>>> +++ b/qga/commands-win32.c
>>> @@ -1143,6 +1143,7 @@ static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
>>>      fs = g_malloc(sizeof(*fs));
>>>      fs->name = g_strdup(guid);
>>>      fs->has_total_bytes = false;
>>> +    fs->has_total_bytes_privileged = false;
>>>      fs->has_used_bytes = false;
>>>      if (len == 0) {
>>>          fs->mountpoint = g_strdup("System Reserved");
>>> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
>>> index 9554b566a7..dcc469b268 100644
>>> --- a/qga/qapi-schema.json
>>> +++ b/qga/qapi-schema.json
>>> @@ -1026,7 +1026,10 @@
>>>  #
>>>  # @used-bytes: file system used bytes (since 3.0)
>>>  #
>>> -# @total-bytes: non-root file system total bytes (since 3.0)
>>> +# @total-bytes: filesystem capacity in bytes for unprivileged users (since 3.0)
>>> +#
>>> +# @total-bytes-privileged: filesystem capacity in bytes for privileged users
>>> +#     (since 9.0)
>>
>> Will need to be '9.1', not '9.0', since we don't accept new features
>> during freeze periods.
>>
>>>  #
>>>  # @disk: an array of disk hardware information that the volume lies
>>>  #     on, which may be empty if the disk type is not supported
>>> @@ -1036,7 +1039,7 @@
>>>  { 'struct': 'GuestFilesystemInfo',
>>>    'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
>>>             '*used-bytes': 'uint64', '*total-bytes': 'uint64',
>>> -           'disk': ['GuestDiskAddress']} }
>>> +           '*total-bytes-privileged': 'uint64', 'disk': ['GuestDiskAddress']} }
>>>  
>>>  ##
>>>  # @guest-get-fsinfo:
>>
>> Assuming the version is changed:
>>
>>   Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>
>> With regards,
>> Daniel
> 
> Thanks, Daniel.
> 
> @kkostiuk do I need to send one more iteration with the version change?
> Whatever is most convenient for you.
> 
> Andrey

Ping

