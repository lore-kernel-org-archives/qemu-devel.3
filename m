Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6940C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg69P-0005st-1Q; Thu, 06 Feb 2025 12:58:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tg69M-0005sH-UL; Thu, 06 Feb 2025 12:58:52 -0500
Received: from mail-bn1nam02on20610.outbound.protection.outlook.com
 ([2a01:111:f403:2407::610]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tg69K-0001Ho-Pt; Thu, 06 Feb 2025 12:58:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7v3pnvIeBAf2M+xqStjwaKNrDmEdin1tVlbF7QRh/pSj2lVziQxBaku8wp+p7AihCp3MZMUoCKOBQTtPXpsSleTDdRKMzk2CIyt2eFtdwdZpY3vzcM81VH4y0etMxDYtUA6tQiADCjlIyg9o1y975hyzZgUArb7O9utfFYKd20t1rQ3nOBjHRNWOValFNPTMdzs1cwaoHXzvQZWzJvV+HKTdGOvf9P9a3yCcfD7D05x+41gaEKWbSniSDOKfZbmis0rskVNTpE2cWnCl9N3wIM6zH5s92W7fXKfs0toVg01pmYTfgodxLpWMfFMyJBFrGW28ExTSkvWiibeI/FJsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00/W8Y7nYANfAcTJkSq/PTVvLJ4eJC3qMxgm1lHB7UI=;
 b=v+vXsYJ1QHJaktm3LZZzQmPC/thwcu2kpR3fWi3SQIrZF/tQ8xFQddxaGqbvu5ZrbFrdb3SM87XbPre994v9Uq56notDGB4Tak7FuOjFawmhYUAvt0QCXXY524FTQ8Rw6HnVMutmhb99aDolkucUshE3oHio8cZXFi0pr7H82/ibodU/YLwrW6U70Txfar3NKxuQvM2M8loB4im5KDZc9Ory/pwNYJGbff36zJncxuLDIgH+jj2SsfIv/CGpLu6fcLlZj9NLfgcpsry1JqEo7VyNNgRlFzRBdLiVUwpBe6srYTTG1DBhSfuWg2IwLp7PiEQGFWvnjtHHnU7xMlXZPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00/W8Y7nYANfAcTJkSq/PTVvLJ4eJC3qMxgm1lHB7UI=;
 b=bUjggBpY3Pl8YzYrmKlByg1yRw3wOhanu1o7rjVp6QDwklnBXa3+jHpCcF1H2LQpv0mv8unGLnCclS3BQqZRwGDcRvfHiArk9yAOj+S/zk/9Eo6pviYvMZYBo1Tx7nBz6PJpp/DTyP5GT/LaYy/FFTqes+CtpS0ufRi5TILBomQUllA+869na9eG17SwSUkdZT/0vt6y/TcbS38GzDIBAeK1iaRCw4sMm1cPgQbOtVqYXb0T0aQ82+ZpoETkTRmOwCpzPYfZuS27aRvljCA6a/oY4I/JNM8kW0+JyIMuLa+1rgrH/usMqaB7+PuaPvM6Fre/bEAjHdUzKeRC+MOslQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB6360.namprd12.prod.outlook.com (2603:10b6:8:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 17:58:45 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 17:58:45 +0000
Date: Thu, 6 Feb 2025 13:58:43 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <20250206175843.GI2960738@nvidia.com>
References: <Z51DmtP83741RAsb@redhat.com>
 <47d2c2556d794d87abf440263b2f7cd8@huawei.com>
 <Z6SQ3_5bcqseyzVa@redhat.com>
 <f898b6de4a664fe8810b06b7741e3120@huawei.com>
 <Z6TLSdwgajmHVmGH@redhat.com>
 <71116749d1234ab48a205fd2588151ec@huawei.com>
 <20250206170238.GG2960738@nvidia.com> <Z6TtCLQ35UI12T77@redhat.com>
 <20250206174647.GA3480821@nvidia.com> <Z6T3cX_fM-aeYbMI@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6T3cX_fM-aeYbMI@redhat.com>
X-ClientProxiedBy: BLAPR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:208:32a::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f831909-b305-4053-efed-08dd46d7e607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzZKeUZiT043SUk2K0RJVGM2ZlYwNzg3QWorYlNFa0F0L0c2TXBONGNpaStE?=
 =?utf-8?B?bEpCeFE2Ly9mUW5DT0REd1VDbkZob2pqb0NWdU9RT0dHK1BaWDQ5Rzl3TkhX?=
 =?utf-8?B?dGwvL21OZ2o1TmI4dE9nNVdkZ3RHU25IT0ZlRnI3emNYZ05zWUE1OFZMRFNH?=
 =?utf-8?B?S0dWYkJ2bnFyay9qdUFhZ2dUZG0xbUxkTSsrbGJLMlpsakx6elBxc0phNTd1?=
 =?utf-8?B?UWlyZEZvbVI2dVBBekpPb1RKYmphbTZEeG5XaXV6dyt5R3ppaFlHNWRwK2hX?=
 =?utf-8?B?N2xocVkzbEhyZzVOcXpOc2hwQzdCdGJFaEVuV3JscDM2dW9nVS9oMkVGK1ll?=
 =?utf-8?B?ZnZZd1VXWU4xeTkxSkdUZ1BjUDVmQmx1TVRqU0RBMGhraG5yYjJNQmthZU1R?=
 =?utf-8?B?SjVrYVdLcmJ3MTVDakVHRzRuTWhOTWdHdWxDVkdXSGxQS29JOHJiUGdHTXpi?=
 =?utf-8?B?WnFiSGptQTNONUVzT2J0Ri96cGpEWlc3Q2hJa0pwRTFqdmhEc1RlMmZMQ1pD?=
 =?utf-8?B?YTVEZGZlZnRYcE1TekxLMloxeGQ2ZzRpMnhMQXpWRi8vY1l3bnFpL0EwVjls?=
 =?utf-8?B?cSs3K0Z0Wm1uSU91OWVLSVFNNll5eVZrQWQxWDRabTJub0t2VlZGbG9BUHBy?=
 =?utf-8?B?eW5rOWtlcDBkMHhIQktVLzl2QlZtZmRrN2d2c0VmaytJK1REN0RTR0t5cHBV?=
 =?utf-8?B?ZHFkTkYyUXd5V0ZYSVhlR3lMaURHUnlXTDBtKzJMQUl2K1lBVWh2V1pqTnZj?=
 =?utf-8?B?YmdRb0JrUGNOaitlS2x5dHlCWk9ocnRlUjhGNUdRNW1VOTI1RnRoVzRHSFkr?=
 =?utf-8?B?MVdXNnFjZEwwWGxyYnFBVE5ZcWtjdDdEeHlBZ3lrMm0zamcwSW9iYW1lZU8z?=
 =?utf-8?B?dUI3Qlp5WEJZVU5WTkx0WkliYk5seGZ2NzFFTzNhbm5xSk1rUVpoNStiZ2la?=
 =?utf-8?B?clJoeXIxNXhlUnh6dmx5czFlK29ValV2SzBQek5sb2hZelNWMmZ4d2tRbk4x?=
 =?utf-8?B?enF5RnpRSzFVTGJZcVhUYjBBTTN5aTB6YWt4WDdwb1NZRVp4SG5RalpCT2dq?=
 =?utf-8?B?UElYSERkUkJrejJjTFgwQ3REcTQ3cmJYZ1pIeG13aWVOODhxSVFmbU8rdkU3?=
 =?utf-8?B?dVptamt2TlRmbXZUaTlZMUZ3NnVOdzZ3cjFmdXdvZHd1UTIya3plR0N1ZlM2?=
 =?utf-8?B?Qmk4ZzlTejlZUUFpdWVQaDdrbktQK2VJc051MFd6UkZLa0pib2JoNmFHeERK?=
 =?utf-8?B?OXE0d2hEL09iZURCSDc0bGdUQmxRSG04NkllVmVjWHNnYjJjWE1tRm5Gd0FS?=
 =?utf-8?B?S0RrY0tjWkFzVUJ2c0JxMU9UUDRhSTZzVDNsRlZUWEtWVktJbUF3N3RCMlBV?=
 =?utf-8?B?ZVlvZGI0VUltdlZrT2hZY2laajRSRVFkbFN1UlQ3ZGVPSzlYbU5uSms4Tjhy?=
 =?utf-8?B?elVYZzh2LyttdWthR2tEV2JHYlRYMHFLVnpXY2pZcEJJM1ZaN2NDRGdUaWZr?=
 =?utf-8?B?d2s3V0UxNEtFSjRHUUplcXBqenZEOTAvTWwvNWZQR29QQlpieDlpTlBGWDdv?=
 =?utf-8?B?a01YWms2MExGRkVPWjdlWUhiV2ErMkRSTllxbmZ2WHRFNVVtN043WlpEWEdX?=
 =?utf-8?B?TFhlak9xOXFNOXNuRXJHT2svZWthczhGWW9tM2hvRzVkN1JiRE1pUWNESjVj?=
 =?utf-8?B?M1lVZUIvaHFtcG9PdjNDb3pkVnBEYUlySDVDUy8xMS9tMXNieS80OUZIMzVP?=
 =?utf-8?B?NjNUNytVa1o0SkxFNm9VSlV1RHJrSVVYd2dkRHRISkJCZFB2SUdtRTI1dVVo?=
 =?utf-8?B?SGJ6MmpKN1pOZGtLbGY0dkVObWk3NkZEVzd2NTJkWFV0UzhMNkNqbEZ2NzBD?=
 =?utf-8?Q?APDXKbTKh596C?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFQyTkdHSS9qNVY5ZkIyWkQ3UWh5WnNiY3VXaWgwWVBpZ2R6cndnK3J1N1Ji?=
 =?utf-8?B?ZlY5VWptSEV5ZHM2d21oakFMMU1sbG1EK2lWQnNnUHEzOTZ3S1FrTUIrYVli?=
 =?utf-8?B?Z2NadThiQWk0YmNsekdBRHo1OXBicU5McW9GdGF3UEdnWGVyeXpoRzZQcERE?=
 =?utf-8?B?SEhVR0lTaDRzSlNaQUZrTjlqV05waG8zaElYUE9aU2ZWdU9kVG1lZUxXanJq?=
 =?utf-8?B?VnlYUGRIVWhYMFdxZzFrMXpOL1hFbUI0azFiMFVyUURPcEhHUElOUWpZcFVx?=
 =?utf-8?B?TkwxWjBWeEdVMlR0Wjg5ZFlTcS8zZ0xsekwrYVo5TkVYUjAxMFk3ZGx5a0hV?=
 =?utf-8?B?Q3Q0U29pQmtFOFlnRXg3Rko1ZTJkeFpmYVlCV1BPU3k3S1F5RGtqSzUxOXI4?=
 =?utf-8?B?N3RsUlQyY2x0RkJWR0J2L0orQzB4MFZnbkNYZHoyU0ZlSFcwYXlCYzZqdERr?=
 =?utf-8?B?dlZlZXU1c2ZJV3ZFNmwyOXRQcXd0NTVFbGV4clpNdUlkb1hPeTJDRThiWndE?=
 =?utf-8?B?eVl3TlZ1cWJUZFFMZU1uYnprYTcrR3RPMWx4UnFoTVdLaWNKZFh6UjFIT3c5?=
 =?utf-8?B?alZZRFZ2VzFEVlNxdXdsZ1JiN3puOW1TNFVMOU1FKytpbTdzTjNkdzQ1alB2?=
 =?utf-8?B?S3U4T05NTWtybUowUzlzaW9QWXlXZW1VTXZ3ZVVSdVhJRStjZlhoelA3V0Nm?=
 =?utf-8?B?b2c2ZE9ZNEJYNjVlalJMeHVVYS9wbk9pQWJFTDR2TFY1THRYcUtlVVlORFZ1?=
 =?utf-8?B?VzJMWUJIZDlxeE5MdlQzQW1VV0RzaHFWWmhJQWdIZUFid2xLL2thckl4WERM?=
 =?utf-8?B?MW5wT0lXTTVWa2xRT0NHeTdVRnovU1BvUHpYUFd4cFJIN3A1U3lWZE9zREVk?=
 =?utf-8?B?ZzF2K1dIOTBsTWVHeFd5bnNVRi9CZkpXSTNSNDhsVVN2YUxndjBsUlhMR0lx?=
 =?utf-8?B?STMwRS9taVhpUDRZRWVUditPUzlEMTNIVkZTNWdKTlNaQWNUTTR1SnRPd1Vx?=
 =?utf-8?B?c2UrSEFkNTJjZG9CK1k1Rnl4SmNKQVIwbVVRcERERi9hUlBHZ3RRaUY4UnhE?=
 =?utf-8?B?THRCTmFmRWo2ZVFzL3RyTGJBMFNBdWFjVUo5TGlLTEpIbXoxWGg5LytaSk85?=
 =?utf-8?B?ak5ndEpiK2M2Z0xFQ21nSExoZWhXdCtVMWI3MXd5aWRncFkya3ZFemtqRWRa?=
 =?utf-8?B?ejZLVStXZCtsbjBXYU93YzZNN3VrUjlEUkpJTE9VcndhVTdNL2xySlFIZGpG?=
 =?utf-8?B?aUlwR0xWU0RYZHBQeEkvSlFYOFpxTWEwL2lNVDg4RmxmWDhiTDBONHVNVEN1?=
 =?utf-8?B?aGJsTXBqY2RLb2VscUNtemFnZEFKd2lKQkN4V0JQZVdSdzhpNm9DS0pibzJ3?=
 =?utf-8?B?b0taYytNQzcyYXc5bXFtVFJ5MG82MHZFU3ZRaEg2OXVtSmhZNmo1UzB4T0t4?=
 =?utf-8?B?QXRDTTBGYjFrUDJwZittaTdWZTRYM1FQUnp6WTVqZEhlWXJRdlUrMzVWcjJU?=
 =?utf-8?B?TzNLQW56OVViNjdmcGxVeXUvUHJJYmpmN0JvbVJTV3ZFZGRlR3FKcC9ocmtr?=
 =?utf-8?B?SXZMbWJuYXR2c0xzNExLVStWSVErTEF6bll0bWQ2NXZidEpueVN4WjR3VXBO?=
 =?utf-8?B?aFFqWHNCY3crUU54aVdZb0UrVUpFNkx3K24wUXV5Lyt2My9qbmxhNmZLRDdL?=
 =?utf-8?B?cVhOK2Jqa3hUTktScUhjeWdWNVIyR0xNUEVsQllJdFJ2TnRCSnloWVpGd1U1?=
 =?utf-8?B?YkhkRGhQSEFOTFo3aDRxZUFRajRhbEQybUZFSnVUd1g1alZEUTRWU0Fhbzc5?=
 =?utf-8?B?eWJXV21icVFGZnJXYzl0bEhqRUVDMFpuMlVYMkRWNGU4NHo5TVRBanZPK05u?=
 =?utf-8?B?NlNXeVhCUG9YZnUxV1dpNFY1a1BMSjU2b2hTb3N0eFo2UGc3dWc4eFY5M0Zm?=
 =?utf-8?B?S1p2ckw2ZHZKRzhXRkIzNkJkaExaWmpIOHFJVWlaOEZIc0szcFFnSUpOS1Rr?=
 =?utf-8?B?YXhOd05aSjhMM3QvTFowRUFHMkdick5USlZhYm9jbFpyNmtZemhqMWR2SkJO?=
 =?utf-8?B?UVI3blptaGlpOUpwSENmQVpjK3djM1h0SlAvb2lXb21td0ZaZFFneCtFK2dv?=
 =?utf-8?Q?LpEogakYeeADFjuJsom8vnQYK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f831909-b305-4053-efed-08dd46d7e607
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 17:58:44.9297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q62RgwuOu7RO9sqYkng7+avzTO8VnhscRGZ8tYzG0/VxnJv/U6PxQRuNIML8Wq5H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6360
Received-SPF: softfail client-ip=2a01:111:f403:2407::610;
 envelope-from=jgg@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Feb 06, 2025 at 05:54:57PM +0000, Daniel P. Berrangé wrote:
> > > We shouldn't assume any VFIO device exists in the QEMU cnofig at the time
> > > we realize the virtual ssmu. I expect the SMMU may be cold plugged, while
> > > the VFIO devices may be hot plugged arbitrarly later, and we should have
> > > the association initialized the SMMU is realized.
> > 
> > This is not supported kernel side, you can't instantiate a vIOMMU
> > without a VFIO device that uses it. For security.
> 
> What are the security concerns here ?

You should not be able to open iommufd and manipulate iommu HW that
you don't have a VFIO descriptor for, including creating physical
vIOMMU resources, allocating command queues and whatever else.

Some kind of hot plug smmu would have to create a vSMMU without any
kernel backing and then later bind it to a kernel implementation.

Jason

