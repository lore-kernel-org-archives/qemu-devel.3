Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859BDC54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 19:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpClM-0006nC-Ht; Tue, 26 Mar 2024 15:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rpClI-0006iY-Bm
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 15:47:08 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rpClG-0000ie-23
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 15:47:08 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42QHR2Ll027995; Tue, 26 Mar 2024 12:47:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=D/vSMdE6FnVcVyMG0XvlAqz3kSsuCtBhQ1pfDAa4h
 PM=; b=usuMxRL4LWxJbItqLT5TObxL1TBNXplb5kpVna+FZx1peDXqA9N3zsSWp
 8Qd5er3YkTQnEbLwx78kLVbpexvbS52ITSH85x0E0EvyivPTXmDaeDKB82dDpsF2
 4Fevu2KYFCK9kW8NyrRqkZhQDhFed3tfz4M9V7lNVRGvl4IMcPIzwL1D+PXz/mQc
 rmLt+3Ntfe3TcQs1lV1Tj3jCMxaEkrE+S+8M1N7BbgBVF5N1r6TZX2a3Yr743HB8
 nM4AgNWC1Hbl16XQtJ6q8nfNKzYA8W5bMmV/GNBTVXj3qr+rg8BAxfZqo6BfyFTZ
 kzl7aN4E1mODvPPspAe8BjM3dk96w==
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3x1xddxped-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Mar 2024 12:47:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URD++9NRhlQbkTcPREQ8Z7d3O2AMllok9WZztTUBMYBmcAoablpmX6JPOsV7KkpPfCHRW4iDnWbeBdLS/9jBkrr7GocIeoCy8qiSk+nqwOx8jasSdCa/5ZVlNrsBtWeU7uLh9rOkCPvfHLevtRnrqQk5TVb7sBpj1o3pI4ajTJFFi3heGwMzdsh1v6WlF6zecLAZqIKjnFNQ2nuTeSiqphGaBo1SpupoY/Twze7h5erOk4+Cr1FQynzi9jbtbAqOOe9nYGc+TnZJKnLfEMk9Iu91bFbyzA6/TKkbDTU4WhEyLX4nucuATOKJioKqb88alAGdYsT7TtwX9UpV/+5XzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/vSMdE6FnVcVyMG0XvlAqz3kSsuCtBhQ1pfDAa4hPM=;
 b=VwEjHCxXCE/6wFsBU9/+moUmm3WxMonw3qGJDQkC8RPfLxSuKJBg2r5j5Thz2qKuxEkpteT/9Gkmn5QyptvFjVvBsCp8WCpWfdzgZDdOgynlGCzrDX4Jom8gmN1tpb+RyKKTVAGmfR1AzstRdjQACPxlN9BqGXTsK0Phwi8uZs4xDQYiM3CkCH/VRgTOhhRPaBpkdVNS8zuPlOBU7Qm7+AHqwpR7zDWKKfgzTKn8snx1oektsbtTg71pR/TKKgNTEjHE9Zfb/WzngVMBo6Qh2F2+mMVkucuZRe9s5gstHv/S7X3KVji/f/6MqLvePzMkKq96ljnfBQVNHTjjvDa8fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/vSMdE6FnVcVyMG0XvlAqz3kSsuCtBhQ1pfDAa4hPM=;
 b=htpfC7+0HnLgqUGsND/X+Fi0X85SFxc1jPJcyh2zgL1fzk6PIj1w/wiJ79/rW1cD2xVS2cNAX+kmPSkYrQk8+cBPyzMR+Cjhg5/PoXLR9M7vJT1L3LguU6k+GevtRTOIFCFVz7bLzmB1TDJa/lMQslovLtRE12/SRFeDHHaEvYXIV7Y2O/hGA0+Lq4uIJC8OfEGVHhB8ZoxfzVRJSgKAuJgFxRtZITTTLjULdfg3UXSUnJ0adTnAyZdy69EdDt6l0G8diorosTh0dMcH13nAl9pon0VUDOfUexFx7wzr5X5aOzjhotln1II3cm4t4NHV1HUv7/VIp3BbZWa7UcWFiQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CY5PR02MB8870.namprd02.prod.outlook.com (2603:10b6:930:42::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 19:47:01 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 19:47:01 +0000
Message-ID: <7c99432e-8c06-4283-9ee7-34a421983756@nutanix.com>
Date: Wed, 27 Mar 2024 01:16:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: Standardize qtest function caller strings.
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, farosas@suse.de
References: <20240326193843.8444-1-het.gala@nutanix.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <20240326193843.8444-1-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::13) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CY5PR02MB8870:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qW/LKiXp0Uqi4rJpPT9zXTvVs810Hy2aoYnwI8dLRWo3+ZAXxSPqNYtcWOnAIkt9etHNrdpvbdJW3wv3kHxvjm3T2UopZlAeCKCWtJV8guud6a9p0aErdvguUCKVSjnI1Ikv7otlUGWY+AtAtJJNSH5YrbGVcitM0NjgZPZ90InNVjRpKWqKTPmMtD7DAqPnt6GG4jUgS4Lb4XgSAMQwWSRyHR+Vl/9O/FDg4YZKQ5aDIRkmHp3n7DCVlniypJT0sXmE1BhiRS64Yf76jkO2+9KoxdEvSwsCmz3ImN1HJv/zXQlivav/vTBTnzhkS3tBNAqzRLYSwiLqZ/20XIpZMsacG29Q4GNCPQUE+Q+SR69vBHhEkpMPKp7+jtUNC/hN6wQH+6JRtzZbE1hjegKanRC71Sn1+JRgp9OQobH6zsJRZaebYYTOY800UCFoporxAWtkkSfGHt+fqb+zrITi1V4TwbgfCY/sb4M+BwJQ+qv9ZFBh2aU6CxF9MbzVgM0QMwutx+MsmSrQqI4LOhYNe5NrcWZGiri1yT04t5Kr+TYgQtbKhYfPOyIDcg3BLCcD9J9VpBwlzkF8cm8WAD1t61HMA7xXH5tdXS+Knusbm2AMsR7nD20Pr27/JTO45yb8xK6iSP+ryRc12iphwVOVNt2Pq/z+x4u4hMw7e4i7J6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0x6QUVIcDJJbkFZZjJsbDdtcG40cW1rQ2QyeDVnUGMvRXdnc0txSUFaMU1Y?=
 =?utf-8?B?VlMrVUJ5Z0Z2MWtlVXhQOFVNRmp1R1E0anpUMVJ0L1RmeUdyMDF2MWdWVXVx?=
 =?utf-8?B?Tnp4WXdMSFg1OGlFMkZDNlFLZmgrZThYVWVCRDhoVVBxME8yOFNjclRLRnky?=
 =?utf-8?B?T0lRVmFDMHpQYjdMS2lTc3ZRWGhrdDhmcVlpV2NpclozcDlUZEwrbUkzeC90?=
 =?utf-8?B?cm9xSndlQ0pRZ2tXU3VIL2crMzdkeXF0dDR1R2tQR2pNbC9SU21HZm0zMkd4?=
 =?utf-8?B?TWhzTVB4NE5kWVFSbnlCOUtpY2FOOUtPZ01WaGNVUVJPOFRzNXNNZWJyMlZ2?=
 =?utf-8?B?R1d4Q0Y0Rjdvd0dOUDNncEJ1MlZYYzE2MWg3Y09UelM0ai9kUG04QTc2SEpI?=
 =?utf-8?B?QzNWakl3ekNZOVc5eHFnS05uQ0FkSjlhbWkyNkhTcmhnL0svNDlPMEE3NFFM?=
 =?utf-8?B?S05jTnFjWCtuUTNSR1VmTHlSWG10ZExaZEhBOFlyTzB2K3hNOWtTZFUvRzJp?=
 =?utf-8?B?eVVXc3JQTm41VGNFQXZjWG5VQzBhUEduVmdybURrckFXUmxxRkhxTWtqTWJz?=
 =?utf-8?B?MUgxR3dqUXI1ZUZRYmZIdFlVZXdjcS9mcVR6ZlRtd2tTWUVHVEpsRTh2b2c3?=
 =?utf-8?B?WTRtMXFyQ2JOQ2xmdWtWRFEybTluakFqOHR2MUdQSHFIamxNWVhRazVEOUtx?=
 =?utf-8?B?dndJTzA5VGRWcHlXUDQ5TFc4UXBIVTgwemtDcGJlUlA0TFA0cUhOc3FqVlF0?=
 =?utf-8?B?M3MvZi81SS92UUgyaWd1UjYraE1EaE1ZZThYbG9oL1NWNzFaU0JseHU0OVpK?=
 =?utf-8?B?cTgxMms3RTNZb3FqS3cvVUhUdnlrOEI0SGExTTRpTkVheUJuNjBmK056RjFZ?=
 =?utf-8?B?WHZBeTdLeTNMbFkxaUFTYXo4WEhLa1l4ckdqRFdTWTZQNHZoeWVja0hJNDNC?=
 =?utf-8?B?NmVWeGdYVzFkbENac2tSMjk2cmVVN2RHc2N2cGRyLzVGME9DRDZGMzF5TEVH?=
 =?utf-8?B?WWJEQ00xS2g4SXE0WWJ1eHlZNTRYdjVyeWVoS2luSERIUjRBWjlOblJYYS85?=
 =?utf-8?B?NHRnWjBZSG1vMk9qSVZXblZ5MFdQbEdtSGowNXpPTEJMbFR2SXVtNGhOcGpE?=
 =?utf-8?B?cXEyaHZJN1VnblZtYzlvNmp2ZWxhdlRWWXkvK2lkWnRVa0lEalpEd3M3cjlh?=
 =?utf-8?B?dVI2WTR3WjBrQ0dzUVVtY21ac1hNYTI2YTBwNjBJRU01aldRcmR3ZE1mMCsv?=
 =?utf-8?B?Tm05clFKdFFHbXV5a0VvdjFYUVY0TnBzbm1sSmFjREJDOVh3SHE0MnZzcC9R?=
 =?utf-8?B?Y3ZxZ2xVS3VRYk1lZllxQ3ptQ0dEcnhVaFZsUXlEZG52MENnMHZrV2NTL3VK?=
 =?utf-8?B?dmk0RE9yaE5NNFJWK2FpdFJYWFozTXJ3MHU3WUpNOG5ab2NTOXVxNnpQcjho?=
 =?utf-8?B?NFdDVzJRSTNuNm5OSGVvdFlFM2ZPazdhOEVtQmxpNVlia3Z0aTZiUERrVE5W?=
 =?utf-8?B?MXJidzQyRGZrbkVTUkF6RlZlL2ZUUzhPS0hqYTdZSUxic1haTUZjejJ4ZUlk?=
 =?utf-8?B?dlNBNmE3Vi9NUjd4blN1YjBPa05XdlNPVklnS3FZZkpUM0lLMzJKYWxXcHlL?=
 =?utf-8?B?RTNjZ09tSDcwTWkvakRYZG5ZZ2lsY0RMZW9Ka2xtdmZJeGs4enBVSXJ0UVo5?=
 =?utf-8?B?VGZlSjFBY2l4Nk5mUGsySXdEcytwT1lHd1NIaElMNUZoWWkzRDdhY3lnUTJz?=
 =?utf-8?B?cXZrUk9HNFMrb1luTU95NlA4dnUxVUY1dDVlakpiNldlRWhpLytldzNuOGt3?=
 =?utf-8?B?ZVBCb1NBclRpOE94ZkRTUGY2Vk40Tk11SWx0VUpaVDRUK3liSHFGUkY5MGQ2?=
 =?utf-8?B?NGZtS25mNjI4dUxFL0x6a3dEWHZHSktSQVdtTFJUaEtkd1hjUkh4cEY1b1ZF?=
 =?utf-8?B?dmVKbVJFaFFLUFVlN1VTdnNKU1BKeUNCTmJDQUpKbEcrb3hUZy9McDYxeGs5?=
 =?utf-8?B?WUNRb3JGMDV4eWNhRXZOdUNDZTZxWWVGVms0UzlJTjNxczJWa0hEYnViTFZm?=
 =?utf-8?B?RG5COEl2SXhYU0M4cWxTc0R0cGdnOW14cUthOFE4N2E0NDVpYkhlekVOY1Mw?=
 =?utf-8?Q?GT76idra5vPrqaRsMijtdcN3Z?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfdd6d3-8dd4-44be-92b1-08dc4dcd8101
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 19:47:01.0626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsIqAnmwxphKrhpZPIY0DennzR/jKILNHjbyIYIgXqXd6OnPP2FbuL2lULxPg5NTAzZ2nHXgLASLL8CvgTmA/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8870
X-Proofpoint-GUID: mZy8m4FjfH8CTkuLWk9WBhiWQKVM4q4L
X-Proofpoint-ORIG-GUID: mZy8m4FjfH8CTkuLWk9WBhiWQKVM4q4L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Maintainers, this is my first attempt trying to standardise the
grammar around migration qtests. I am not sure at multiple places on
whether a particular string is placed at the right place with the
right grammar. Please comment on the patch, if anything you feel can
be improvised in the existing design. Suggestions are most welcomed :)

Thank you Fabiano for initiating the idea on having a strict convention
to call migration qtests. Hope that this would help further down
the lane for anyone to call qtests in particular manner.

(For now, have not focused on the character width limit, will comply
  with that once, we are on a consensus with the design)

On 27/03/24 1:08 am, Het Gala wrote:
> For <test-type> --> migrate
> /<test-type>/<migration-mode>/<method>/<transport>/<invocation>/
> <compression>/<encryption>/O:<others>/...
>
> For <test-type> --> validate
> /<test-type>/<validate-variable>/O:<transport>/O:<invocation>/
> <validate-test-result>/O:<test-reason>/O:<others>/...
>
> test-type            :: migrate | validate
> migration-mode
>    a. migrate -->     :: precopy | postcopy | multifd
>    b. validate -->    :: (what to validate)
> methods              :: preempt | recovery | reboot | suspend | simple
> transport            :: tcp | fd | unix | file
> invocation           :: uri | channels | both
> CompressionType      :: zlib | zstd | none
> encryptionType       :: tls | plain
> validate-test-result :: success | failure
> others               :: other comments/capability that needs to be
>                          addressed. Can be multiple
>
> (more than one applicable, separated by using '-' in between)
> O: optional
>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> ---
>   tests/qtest/migration-test.c | 143 ++++++++++++++++++-----------------
>   1 file changed, 72 insertions(+), 71 deletions(-)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index bd9f4b9dbb..bf4d000b76 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -3620,62 +3620,63 @@ int main(int argc, char **argv)
Regards,
Het Gala

