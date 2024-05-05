Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B77B6C4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 07:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3WNk-00054x-Jx; Sun, 05 May 2024 03:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s3WNe-00053a-MG
 for qemu-devel@nongnu.org; Sun, 05 May 2024 03:33:54 -0400
Received: from mail-dm6nam10on2084.outbound.protection.outlook.com
 ([40.107.93.84] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s3WNY-0002PD-M5
 for qemu-devel@nongnu.org; Sun, 05 May 2024 03:33:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFQFa73pafOW1cRFMCXb0yUMuRC3OgXEBL6alDz10ATlNW8R7Y3uArKC9PEPRG4NbOIZqibm9xsV2N2mV6CrmolMWq9TcOxVST4yh3++/T5F+Qez4s3t8be4zTE9bBuNXPeB+fmi7pSmVCoxhOue1v4vPFDsm9t/4mvWCcuWe0TYO3tyupEvHIEYtZUeqj9eXpsaiYgDqkMsnSXS46TNdB3293j9l+tQK6OsshXMgpGCmZwSZlx9uKWdM6uU6uxKnlq6nCIWx2XA+KiTqytUAhlWUff8C6Mjydaamu+0HtYnqIzAZKzFINP/4TIctXTgxjQutcY3Od4BWx4IOVqGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIL/S4E0nJsTb+pRORJWwShB63AjbcifJkNWtA2MW8c=;
 b=dvqm2NtgYqBXQUuvbNYCOHGjrOlrIzStNYD+nHTzeb1Y29dDwztph/yP6y6/ZpvmzJAP7CsaeYB5zrw5fPl2DWLO41GTOXIMUnOB78nmuXmbnnjuM29Rzgv05h+kjq/lwa/8jzyy3TzX3nmsyNzIM6Z1fi53JDbWzEApg7J6zmT8b2VeMdUxP5suUuLqdTWXzc+P78nBPNRrR/mjJV8FnSrOdQwaJpOY3i8YcW0EdljZT2Ty4X2RZ2Ljg+0N4f2U3riEFJKi3DgJhtBbqO5gdMwUah5NL+bKClRn8vwuhxVYcGAh1dCAMVawurELJJf6SWik9CwwVozlmRsGlrK0Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIL/S4E0nJsTb+pRORJWwShB63AjbcifJkNWtA2MW8c=;
 b=VFFGhL/h9vB8e0Ef08zRUPDhh9OiBes+IRXJ4UN/9AiqMvVN+lf5Xk0Fdj+NekB7Ap9UBTRojKrAUMB5vOARUcZG+JeAMMrVk/dggR9O0SV66WQH/p+OLrydtLm6HbYItwqs3JcOYaGSWpmD8Ziv7+qaAixjxz3REo/ZaK5mY1ViemPr/VFrH/cCjEini0mXEQLggeSi6Ioc7jnt/bpPgwCHasy8aewBOSG1cVs5CxSEj6JqrHB/SQ4qjkaad+lgFGBunWHyyVEbCPKvS7KHMj7TiRFLyIRs2jSCnDxsPh6RV3Vs6De3R4NnK6rLZ/VUBTqzgPFe2EPxVCl5xaEKmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by PH7PR12MB7817.namprd12.prod.outlook.com (2603:10b6:510:279::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Sun, 5 May
 2024 07:28:42 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80%5]) with mapi id 15.20.7544.039; Sun, 5 May 2024
 07:28:39 +0000
Message-ID: <600825d2-a314-4120-ad2a-0b1f3c5bb8d9@nvidia.com>
Date: Sun, 5 May 2024 10:28:33 +0300
User-Agent: Mozilla Thunderbird
From: Avihai Horon <avihaih@nvidia.com>
Subject: Re: [PATCH 2/3] vfio/migration: Emit VFIO device migration state
 change QAPI event
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Maor Gottlieb <maorg@nvidia.com>,
 qemu-devel@nongnu.org
References: <20240430051621.19597-1-avihaih@nvidia.com>
 <20240430051621.19597-3-avihaih@nvidia.com>
 <08936db7-46bf-42ba-ac14-49cb14f34646@oracle.com>
 <0d368ac4-fbba-4829-b25d-d49957b7c9da@nvidia.com>
 <5e9c1edd-4e99-4fb7-8b9a-159b1a6503c5@oracle.com>
Content-Language: en-US
In-Reply-To: <5e9c1edd-4e99-4fb7-8b9a-159b1a6503c5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0191.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::19) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|PH7PR12MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 5134e13f-b146-438b-1df7-08dc6cd4fb81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3FSWEhoZ0RyWFVzZUdlQXovTW5aSUk0cWZpeEFXMklhRHk4N0hpWEI3ZS82?=
 =?utf-8?B?Z3JaNTRvRzEvU1RPWnJlRFRTMkNaci8wY2h3RlBLYzM1eXFGOWthNE9yeHp2?=
 =?utf-8?B?Z3BoQmpPRU50ODNnOG1lSDREV24yR1U2RWdzRUdCeHlLNUNoNStyZ0V0MDBH?=
 =?utf-8?B?Zmc1Mys3bXkzUHFXbmQ2V0JTSm1ZdERGRjI1WGo1WE12TjNBNnBBUU5XQnhR?=
 =?utf-8?B?VUQ3NmpSRnN6U2QyN1RlbVFZQk9NR1ZjbTdicHk4NDhUNDZjenRNRmFUOC9m?=
 =?utf-8?B?UXZqWncwSGhjZ2VvaWU1cmFxa25idmhoQ1hCeUdTNFArU09mQ1pHWS95dk1y?=
 =?utf-8?B?LytUMWZTeEJNZHhMTXlQdnlZTUJycktaZHpLdTVaeWdURks5RHp6U2R0dmFz?=
 =?utf-8?B?eGFoOVZUK1ZmK2x3STZiZG9VUmMweVo0c3VxMFQ5VnJQL0FacHdsb3kwNUdK?=
 =?utf-8?B?eTRyNXNYUEF4WjJPbnBxNlRsSGJtZG5ERCtQTnQwNUhBa2RCb3c4L1p6elk1?=
 =?utf-8?B?d2tvYUIzU283Nk0veDJNWnNSRU5PUytET2dpa0V5L0ZUSWNIa20vczgvZ1VJ?=
 =?utf-8?B?bzQ2aExqTnI5cFRUQzFsVW90Q252OVBlWkFQREdqQ1NIay9JYU4xQU9SUmZS?=
 =?utf-8?B?MnZOZnB2WGdhV1hKbHVyS1BpaWpJVG1QcS85SEkrdGRxblRDanpxb3RzQlBQ?=
 =?utf-8?B?ZC9EUHhrOWxXRHE4bzVaSUE4M2lDblBSYkZYRUF0SUI5RUdTbWlTMmNYYkpP?=
 =?utf-8?B?bWhwYWg5U2V4b0RWUTBkZG96RmtrdkJndzJWaWxpMjdKbERpZ0MrcVZoeHo2?=
 =?utf-8?B?UUNLZXNPWG5FTEtlY0FmazdadVE0ZzJhRWsvTW1JUk9hSnRDR3pHN2VrdlUz?=
 =?utf-8?B?TXhLdU5IRHNWSXNKK2FRbGcwN2lYV0JDV2tCZ0hxY3J3RU9XODBGQ25SQ2lD?=
 =?utf-8?B?VjI5bGRIK3phQWNta0dadGlKV1VyNjF6ckpRV0c3SW9OL3lxQkRaSW5Xa2ww?=
 =?utf-8?B?VzRsajZ6OGZZSlBEYzFGcDJLWGNhdktHQ2ovT1JHcStoNHVxbTBrNHpCNFVO?=
 =?utf-8?B?ZmVuUFhyT244aytXbnZlVFZqZDhmM3p3cDB1cHZ0TURNSXQyTTVWditKV1k1?=
 =?utf-8?B?bkQ1Y3d4aWo2SDd3N2VQNkpZMGRTZWdnckxGVGZ3WlJYOVFZa2RFOTJnWkxC?=
 =?utf-8?B?R1ZTZ2U3cEM4MXViNDJxRmhJWEdmNFZ1YTNrL3IraHpkb01iWUtXVDY3dnJV?=
 =?utf-8?B?aWdWOFFSSTk2blZMTTNvbFFwTDlFZlRLUWdZc3R3WmNwbEE3cWZML1F5a04z?=
 =?utf-8?B?VTFOY2tDa1FoSVE2M2J0M1o4MVVoZC9iamhKbGs3TWhGdW5LbXVVUFlacitV?=
 =?utf-8?B?UXhFTWhHTldtSDdMN1hBT2cwaWRVczhmeVRXdWxaMjR6RjFQTjgxMlF6ZWYz?=
 =?utf-8?B?NHRDU1ExbTUwM3llOUdXY1ZPeSsxU0FFOEU0aXRzQW0wTy94Nkw5a2xYSEg0?=
 =?utf-8?B?cXluWTh4ZXpIcFR2QzhGN3BSRSs5bk9Ub2l5VzIrdnEvejAvZXpwYTI1UmJu?=
 =?utf-8?B?TDhQR2xiT1lHdWloVGx1ZlZJcFkyekxNL0p4eU5LMnV1MXkxL0JwbkZhaW1s?=
 =?utf-8?B?THVpYTllOEpRQm5xNEs4UzlFSzRKdVFJeUpkN1BGc2c0c1RxeDdUUUtkWHJj?=
 =?utf-8?B?NDgzMHk0c3dyZFNRUnREVmVIazBId3RJbkx2Z1lzUW1TeThlYWdwVmpBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUk5SXIyb0V4RnBQUzJGRlpwODBNbjd5dlV1NjRTN0xpVmpnUTBSS1hIUlQr?=
 =?utf-8?B?bVlaRW1tYXpLamFEc0NXVTlOeGhvWEk2NGNKM1V0K0RUL251akdwRHRWd0dW?=
 =?utf-8?B?NTZvbkx0MWJURTFjLzllaDEydnIxYjBoSjJzRU9EbE10RWhTc2tXTFo4QXFp?=
 =?utf-8?B?czhlWUNGZFZyM1pQeVJVWFlmRnduNnkycnUxTzlvOVJNbTAvWDZrZTdhMXk4?=
 =?utf-8?B?eUxnZFB6WDcrVENkdDZ2Snc0NGl1VUs1U1JMUU9ad0ZzTEVScXYwcHFDTGlW?=
 =?utf-8?B?YWo3d2pReWd3LzlsK3RTSEkwSzJLbDBQYzNtbnhwTTZOWHZ1SmpTalAvazk0?=
 =?utf-8?B?NlZwUlVmai9PTzl0N0ova1Y2VlFJZlJKZU9KU3VvdE1qcUx5dGtjNWpCUFBl?=
 =?utf-8?B?eEVCQ2FNd2FNdGtwRWJVenByQjU4bVY3L3hOZTBCRjU1c2J5RHJ5VEZmQVo5?=
 =?utf-8?B?Y3pLV2o1MVRNMjN4aXpKUWFWc2IrNGpra3ZjOSthMDBxM2ZnOGRCbURiUUF2?=
 =?utf-8?B?azQ0ZGJqdWF5S3pDU2RuNm5DOW52R3FiT3FDVHlJSU40TmQ5Um80eVdsS05F?=
 =?utf-8?B?S3RHV0tQNHlsK3VXQ0ZsOWtTWFlxWEhSZWFSeE1hbm10ZGF2MXhjRWx3bGNo?=
 =?utf-8?B?cWttd01ORE5ZaC8za1Z3eUF3UlJEMU1TQTJiM3pFNm0wZ3gzMkxxOEFoWmZ0?=
 =?utf-8?B?dHN5TnBUdlVKZlJrdWlyU1NoazRoMzlWSGxjak9tSFB0WUdoRDR5a3MvWEla?=
 =?utf-8?B?MzFyQ050N0FpWTN0eE42Z0ZaNnQva1Q3VGw4a0g0bC9LaTQrUkw5VWVWbElW?=
 =?utf-8?B?QmNLQzYxWDhVYTlKOUkraVErVlVoa3VGYTJpc2lQS0FRSUdScTlJc21Md0s4?=
 =?utf-8?B?WUozTXlRKzhmRnBGT0pIMlVrYldYb0NqV0IyR3JBTUNGTjk4WGtGSDl3cTBj?=
 =?utf-8?B?MllGUVRMVXlDNGRRTW9nWHpNeVFRV205TllyeUxxWmI1SEszdTlTWm5UL3Fk?=
 =?utf-8?B?WWMwUHg1ZTVVeHlqQVp0SXhlSGoxNnh5N3JHM3oyQXZxS3JsNTI2ckNEckJv?=
 =?utf-8?B?bkQ1LzBQcFNWWGRwRVdkaXUveXdtaFFDTDZkREkvaDNWSkQ0UHkwb1hMbXBl?=
 =?utf-8?B?VlNtNjExTVdCcDJveSt4TSthZEVvcHdidjRiRzZlV1Q3cUJVQVBRSnlpTUxH?=
 =?utf-8?B?R3d5dUFOQTk4SWVjTStIL1RlR01aNWJmS05wZU9mZG1aK2tFY3lJWU1ZOEhh?=
 =?utf-8?B?YmRtSFc0YXlib0FWQWtabTJtK2t2V0U0Wk1DKzlzM1JRUUowb25GT2hmeWRB?=
 =?utf-8?B?MjRTbjh6Z1hZYnBLZ2UyQUgralArWFFlRms4R2RqWWdFTWxsY3dSY2RTeDUx?=
 =?utf-8?B?eFN0c1ZleG1mckpWSUZobzBUNHZvaGhwTHgrc1ZoRzFqVi93WVh4eGc3L1BL?=
 =?utf-8?B?d0lsK3RjelFSTFF0cS8zdHRIdHV6Wkg2MVd1QklXQkxBb1hzclZINFdoL3ZS?=
 =?utf-8?B?WitQc0M3ZVYwSHJBRDFDZHB3RnVyQ0VOS01NN21jeXdLdWdUb1p2Uy93ZERU?=
 =?utf-8?B?RTdvZUFZalY3dkZEcG0yanAwTktqUjUwOHpHVi93eEp3TTF0ZGpCcVM5UTc3?=
 =?utf-8?B?bnBNRStTN1BnYndrUjZRWHJ1TWx5NXJ5YkF5TjB4SnpLeUZHZ1JWSXJLVGtQ?=
 =?utf-8?B?RERFaGVGUlFqRTNaY1NuMHJjb0NwVmRyNktMQ0tEUGhmem9CVWtHazlPb2Nh?=
 =?utf-8?B?ZkloMDhrV0E5NU1tMVU1Ulp3bHFxd1dnb3JVRlpmUVBWZnhYbGRWblgxZFNh?=
 =?utf-8?B?SXRxN1FUaGxjK24vdHB5b1lETG1IYXUwQ3BlZFROQVk3TmhHajEwL1VnclNy?=
 =?utf-8?B?Wk9lTUYrbUFITjY0dTNOazFHY3RjajdsZERheDhXd2xtcFdQb0M5Q3h5dC9I?=
 =?utf-8?B?dExyTno5QWpENlFOcDUwZThpZlJDTmFrb1dLcklHbEc3c0k0OUNLMGxXZHVX?=
 =?utf-8?B?eEREbHBpV0VnNG9mU1ZBelAzS1FjOXR0b1RRVC9qUmtpYUlmZHdFY3FJMExP?=
 =?utf-8?B?a3VkeW42VERRcmgxVXZaVnRkajRIN2pzR3NaVC91RTZiTUZEYmM3UHZLTllk?=
 =?utf-8?Q?Ra71WWfdZwwjDl1pQxIsRpM75?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5134e13f-b146-438b-1df7-08dc6cd4fb81
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 07:28:39.0851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCCW1MfRe4jlAP2+4FpunhbRcWc7imikY7yMEh+MLsSTEQ19aV+XwE0zPrGD78nwKn+4OeEBd/NAfF4bAH324w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7817
Received-SPF: softfail client-ip=40.107.93.84; envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.23,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


On 02/05/2024 13:22, Joao Martins wrote:
> External email: Use caution opening links or attachments
>
>
> On 01/05/2024 13:28, Avihai Horon wrote:
>> On 01/05/2024 14:50, Joao Martins wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 30/04/2024 06:16, Avihai Horon wrote:
>>>> Emit VFIO device migration state change QAPI event when a VFIO device
>>>> changes its migration state. This can be used by management applications
>>>> to get updates on the current state of the VFIO device for their own
>>>> purposes.
>>>>
>>>> A new per VFIO device capability, "migration-events", is added so events
>>>> can be enabled only for the required devices. It is disabled by default.
>>>>
>>>> Signed-off-by: Avihai Horon<avihaih@nvidia.com>
>>>> ---
>>>>    include/hw/vfio/vfio-common.h |  1 +
>>>>    hw/vfio/migration.c           | 44 +++++++++++++++++++++++++++++++++++
>>>>    hw/vfio/pci.c                 |  2 ++
>>>>    3 files changed, 47 insertions(+)
>>>>
>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>>> index b9da6c08ef..3ec5f2425e 100644
>>>> --- a/include/hw/vfio/vfio-common.h
>>>> +++ b/include/hw/vfio/vfio-common.h
>>>> @@ -115,6 +115,7 @@ typedef struct VFIODevice {
>>>>        bool no_mmap;
>>>>        bool ram_block_discard_allowed;
>>>>        OnOffAuto enable_migration;
>>>> +    bool migration_events;
>>>>        VFIODeviceOps *ops;
>>>>        unsigned int num_irqs;
>>>>        unsigned int num_regions;
>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>> index 06ae40969b..6bbccf6545 100644
>>>> --- a/hw/vfio/migration.c
>>>> +++ b/hw/vfio/migration.c
>>>> @@ -24,6 +24,7 @@
>>>>    #include "migration/register.h"
>>>>    #include "migration/blocker.h"
>>>>    #include "qapi/error.h"
>>>> +#include "qapi/qapi-events-vfio.h"
>>>>    #include "exec/ramlist.h"
>>>>    #include "exec/ram_addr.h"
>>>>    #include "pci.h"
>>>> @@ -80,6 +81,46 @@ static const char *mig_state_to_str(enum
>>>> vfio_device_mig_state state)
>>>>        }
>>>>    }
>>>>
>>>> +static VFIODeviceMigState
>>>> +mig_state_to_qapi_state(enum vfio_device_mig_state state)
>>>> +{
>>>> +    switch (state) {
>>>> +    case VFIO_DEVICE_STATE_STOP:
>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_STOP;
>>>> +    case VFIO_DEVICE_STATE_RUNNING:
>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_RUNNING;
>>>> +    case VFIO_DEVICE_STATE_STOP_COPY:
>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_STOP_COPY;
>>>> +    case VFIO_DEVICE_STATE_RESUMING:
>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_RESUMING;
>>>> +    case VFIO_DEVICE_STATE_RUNNING_P2P:
>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_RUNNING_P2P;
>>>> +    case VFIO_DEVICE_STATE_PRE_COPY:
>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_PRE_COPY;
>>>> +    case VFIO_DEVICE_STATE_PRE_COPY_P2P:
>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_PRE_COPY_P2P;
>>>> +    default:
>>>> +        g_assert_not_reached();
>>>> +    }
>>>> +}
>>>> +
>>>> +static void vfio_migration_send_state_change_event(VFIODevice *vbasedev)
>>>> +{
>>>> +    VFIOMigration *migration = vbasedev->migration;
>>>> +    const char *id;
>>>> +    Object *obj;
>>>> +
>>>> +    if (!vbasedev->migration_events) {
>>>> +        return;
>>>> +    }
>>>> +
>>> Shouldn't this leap frog migrate_events() capability instead of introducing its
>>> vfio equivalent i.e.
>>>
>>>           if (!migrate_events()) {
>>>               return;
>>>           }
>>>
>>> ?
>> I used a per VFIO device cap so the events can be fine tuned for each device
>> (maybe one device should send events while the other not).
>> This gives the most flexibility and I don't think it complicates the
>> configuration (one downside, though, is that it can't be enabled/disabled
>> dynamically during runtime).
>>
> Right.
>
>> I don't think events add much overhead, so if you prefer a global cap, I can
>> change it.
>> However, I'm not sure overloading the existing migrate_events() is valid?
>>
> migration 'events' capability just means we will have some migration events
> emited via QAPI monitor for: 1) general global status and 2) for each migration
> pass (both with different event names=.

Yes, it's already overloaded.

In migration QAPI it says: "@events: generate events for each migration 
state change (since 2.4)".
This only refers to the MIGRATION event AFAIU.

Later on (in QEMU 2.6), MIGRATION_PASS event was added and the events 
cap was overloaded for the first time (without changing @events 
description).

Now we want to add yet another use for events capability, the VFIO 
migration state change events.

I think what bothers me is the @events description, which is not accurate.
Maybe it should be changed to "@events: generate migration related 
events (since 2.4)"? However, I'm not sure if it's OK to do this.

>   So the suggestion was just what feels a
> natural extension of that (...)
>
>>> Applications that don't understand the event string (migration related or not)
>>> will just discard it (AIUI)
>>>
> (...) specially because of this as all these events have a different name.
>
> But overloading might not make sense for others IDK ... it was just a suggestion
> :) not a strong preference

Yes, I get your rationale.
I don't have a strong opinion either, so maybe let's see what other 
people think.

Thanks.

>>>> +    obj = vbasedev->ops->vfio_get_object(vbasedev);
>>>> +    id = object_get_canonical_path_component(obj);
>>>> +
>>>> +    qapi_event_send_vfio_device_mig_state_changed(
>>>> +        id, mig_state_to_qapi_state(migration->device_state));
>>>> +}
>>>> +
>>>>    static int vfio_migration_set_state(VFIODevice *vbasedev,
>>>>                                        enum vfio_device_mig_state new_state,
>>>>                                        enum vfio_device_mig_state recover_state)
>>>> @@ -126,11 +167,13 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>>>>            }
>>>>
>>>>            migration->device_state = recover_state;
>>>> +        vfio_migration_send_state_change_event(vbasedev);
>>>>
>>>>            return ret;
>>>>        }
>>>>
>>>>        migration->device_state = new_state;
>>>> +    vfio_migration_send_state_change_event(vbasedev);
>>>>        if (mig_state->data_fd != -1) {
>>>>            if (migration->data_fd != -1) {
>>>>                /*
>>>> @@ -157,6 +200,7 @@ reset_device:
>>>>        }
>>>>
>>>>        migration->device_state = VFIO_DEVICE_STATE_RUNNING;
>>>> +    vfio_migration_send_state_change_event(vbasedev);
>>>>
>>>>        return ret;
>>>>    }
>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>> index 64780d1b79..8840602c50 100644
>>>> --- a/hw/vfio/pci.c
>>>> +++ b/hw/vfio/pci.c
>>>> @@ -3362,6 +3362,8 @@ static Property vfio_pci_dev_properties[] = {
>>>>                        VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>>>>        DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>>>>                                vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
>>>> +    DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>>>> +                     vbasedev.migration_events, false),
>>>>        DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
>>>>        DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
>>>>                         vbasedev.ram_block_discard_allowed, false),

