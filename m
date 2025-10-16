Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9644CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 14:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Oa1-00059d-21; Thu, 16 Oct 2025 10:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.drab@virtuozzo.com>)
 id 1v9Nj9-0001RX-2Q
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 09:09:07 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.drab@virtuozzo.com>)
 id 1v9Nj1-0006hk-HN
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 09:09:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDS6WnVsMMnvaSZLfcu80AyV05fPLh6MRJ/4P7iQIWNk6vw9qc2A9QFKpfwa7IpjdHEytU//cHv+Gc59vuylDrmLYSpOpEoBz4YMwkiHTs80/OTWA8DiA1L5p9MFK5ZNlHuXpeEuaEzPAK4tNpUYmg4UfOyhQit1/GQRLf1MOIlmIg1aNa9DUR1GJ0MS/YEJuuoKr5lF8rfrwsF+JzMrPjonx2lUcZZ6c2+AHMXUgyCww43wfyGJi/NrIzR9SKCmu3sNDB0ki6DZ5dCx/aXzKqtA4lzcFj24akdcepQcUBbGDNPO5RFaTfVLAvif6n0swOxxx35HMOzNz+2TAnejuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tdx+LoyDpEGFiBvnDoCSmQsD5VExiCVz2ewFEyMANlQ=;
 b=EsIIuKgIYIl0S9Ovm7t2bm9d8g8yktxCA7M69fOJRR3tpM+TZCSfWuVy4XnD0EXPNsKSeKoCa3l9WUe6TVZoHTaIJFeq7s2aLGcG3Iezpv630rWj022Uhk4B8V0UYXFIMQ4R+OakeuuuA/36k5uQGM8R7zkmZQ0RZ300teXCRGNgjGLkY2+YryhWXZ7HMb1+rA8WTogD+1OgLmRNgB1AT9mak3+nGcr9vrewpfCZLA+ihhvRNtGj+5aeIJioFeHD9Qo0vCyYhjXP+spWbvh6a8D/NY1SmsqQ77PASf4NTc/zBgJjYBf0LveGh/Yt17hBcV5o906Qd9RXZ82pFv47pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tdx+LoyDpEGFiBvnDoCSmQsD5VExiCVz2ewFEyMANlQ=;
 b=DhuDjIu9BnFxUhyrbc+NWN77cCqhOEX03RXjN3S3nXp/hcAVdG2MQ36yaniGyGecitkL08z8vvbsLlker+aVq3nNN3cViYSsXOtpPMb0uhB0wx9thFKpbIhDsLYIbccwB6uwTGTsr5TSD+GBsIjKYHKyM9pIxxiKdJfQ8B0lZai2KrpXWoeuhflqKm3gxIBRbl6O2SE3K0jkaOuJ8uyM6AMRsSEhbJeXAf5l4HRUXoNghlKJ8TDkMW1HtHPKy7EivzUwF/4339LEU3zdOxWjjgFc9t9ZDW1yET2+OABW2Y4FHf27qomon1zoneUSBQ6nBIHck8/Xh3KQM1/nTzQ+Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB4PR08MB9863.eurprd08.prod.outlook.com (2603:10a6:10:3f0::16)
 by AM9PR08MB6001.eurprd08.prod.outlook.com (2603:10a6:20b:2d5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Thu, 16 Oct
 2025 13:08:52 +0000
Received: from DB4PR08MB9863.eurprd08.prod.outlook.com
 ([fe80::d9c7:6a37:13f7:701d]) by DB4PR08MB9863.eurprd08.prod.outlook.com
 ([fe80::d9c7:6a37:13f7:701d%5]) with mapi id 15.20.9228.009; Thu, 16 Oct 2025
 13:08:52 +0000
Message-ID: <561f5abd-c699-48e5-a396-fd4714b11fa0@virtuozzo.com>
Date: Thu, 16 Oct 2025 15:08:51 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: martin.drab@email.cz
From: Martin Drab <martin.drab@virtuozzo.com>
Subject: [PATCH] [qga]: Close handle to the serial device when destroying a,
 channel
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0129.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::13) To DB4PR08MB9863.eurprd08.prod.outlook.com
 (2603:10a6:10:3f0::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR08MB9863:EE_|AM9PR08MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d962e6-2692-4c32-ceb7-08de0cb5273b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TG5HWSsxMHZJSjJQYnZXR2RPZHFjczQvRWUwQXZvc0I5QXlCZm5id1BwbFB6?=
 =?utf-8?B?Rm1SS1NzUG5xSis5VGw0dEQxc0c2QnVJc1pkQjMwTjdwY2lQOWdSSmtSZGkr?=
 =?utf-8?B?Y0tyTjJBd2NHZGlXZGM5L0FWM2MxMG9jLy9UWUtEQTJvSWRwUXBwaUtFbWdG?=
 =?utf-8?B?ZUhJeld4ZVNhU3dwYzRrNzBrNzVRdTNvT0QreWpKU2NNZDFMRXdWKyt0WEJD?=
 =?utf-8?B?YTFNUTVYc3FLenVSa2FROUVhYzBiT0pDME1RVTRmUk56RHcwdHVQTlRHaTlY?=
 =?utf-8?B?cmhkTlBwY29YeStIVmNLUlEvT2kzTjlsQ0Y0S0RVRml2QVBkZDU3b1Y1R3FV?=
 =?utf-8?B?ZGJvMVhzWGRWSFJzOE9nOXNFOHppUXRQQ1NJUi9nemxWRkphOXU4dEl4VFBI?=
 =?utf-8?B?K05hanBNbkZQdmljMU9NbCtBY3VTcW9ESzdycFdMQ0Z5VDRqVmJpYlI5bFY1?=
 =?utf-8?B?WG1wTS9NSWFocDJiUm5Mc2NvMnYydkJHUGhhQVVackpEcHlwR0drL0JmcTlO?=
 =?utf-8?B?VzhVb05pbTBMTWE2Lzl0VDhpcDAwWWN3ZmxSZVJjN3NwQWZlVG0xcWZyaERi?=
 =?utf-8?B?QlVVM1IwdGV5ZTc1ZkRPM2pWK012QXozNWd6ZVFWaXVRdEFxSldxK0M3RUNw?=
 =?utf-8?B?UjdNZXJYam9qRWwzdy9vbjZYME5hQ1pMSW5ybGM3YkFHSUFYKzRhK2xYNmZs?=
 =?utf-8?B?Wi8rWEdTQW93dWllN3hkTVc4Vm1pbHdGRXdmSFM0L01HZm8yVVRQWmQ2NVR3?=
 =?utf-8?B?ZlowK1orcWI0MGpaR1pYdDlNb0ZicDQzeGdXU2FnZllhdys2SkNIQUFhN2dL?=
 =?utf-8?B?YmRiN1NjbEtlRWJ3dTIvb2haTnZMUWkrTmJ4eFNHQi9peHNnZ2dnaUFGSjRK?=
 =?utf-8?B?RW5zZS9IOG5PUXUrMER4eWtCYStIdWdqaUhZczlKVFdxZWFMTmZ0QTQ3YS91?=
 =?utf-8?B?Tk1sU2UyaHNlZlN5bUFSRXFlNFF4NFplV042THdBQS9ha3FYdHNuMlhqcHRq?=
 =?utf-8?B?VVg3STdoWU1UN2JQZkxVVEd2eUxXdEJFOXFRUW5LRUJ2emZvY1NGcGs1TjdK?=
 =?utf-8?B?dVZlMWtNY2JDdmlVd28vYytUWWJoUTVMRXQ5TjZWa1lmQkorSnJNVGZsYi93?=
 =?utf-8?B?aGNQZUg5cmFneUdsRmhrZW1ndDZiM0xHMFRHb242NDVsd2V5L3ZaTkJyNE9C?=
 =?utf-8?B?Q3BGRFJXT0FKRFpna3BiT21xQ2ZTMXd1bHUvemJOQlIzMzBtb1I2OVlQTEJo?=
 =?utf-8?B?UXJxMlRIMkRsNnF4TjRqS1BHRStYcHMwdmIzczFoaHVjVDRxWS9pM0t1bTZw?=
 =?utf-8?B?b0t3R1J2TjFLbTVrMktmMWJ5Zk9lM1QxSVBrSmNJMW5rakVSQzMzbytPTlEv?=
 =?utf-8?B?RFFrMkpQNFhabjlRWVNkaWhldFdJcG1zZXJ6MS9WTGlnd2VYeityRVMvVHZZ?=
 =?utf-8?B?eENjcEl2Ymh5eWtKNENZdGVjVkhNamYzUjF4aERGUzUrS3VtNDZuSjY1VWdv?=
 =?utf-8?B?QWd6MllPU05jVU9VbmN1R1pzTjJYNjRjVFU5ZjlVelZSNmU4U3J0dmwvRUJR?=
 =?utf-8?B?SDdkS1MzbE5nVmhMOFJoRXhPSGpLL0s4TEJYSVMyUkE2WWpMRzZOU05UNUpZ?=
 =?utf-8?B?dUdCMlJVYXRiV3grRVF6TkE3a0tTM2ovektXdmkxNFp0TWtwcFVoVU93dTd1?=
 =?utf-8?B?QTI5bVNPMWlJZE54blBLWlNRUzc1WnpRMGFXWEQ4OHZpb2dPT3NaSk5FRDR1?=
 =?utf-8?B?cm52Mk5vWTFOMTRMSDhCUEFmdDAyZzZmZEgyV3NwNy9uOFZrUThKS2ZBT28y?=
 =?utf-8?B?citUak5ybzVDTDhvS0VnVU9vRkpWN2txOEN1MENMcUZ6cVBwV1o1WVBhNkZv?=
 =?utf-8?B?TEtVeFRrMGZJTEVVaUZ3cU9OOGg3V0JJY0hid0R1dlBSSmZ2YlVrV2Y2dDZr?=
 =?utf-8?Q?HSc1J5IfgT/PgH5oa71Z5NLi+i3A8Zkf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB4PR08MB9863.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0tWb2R0NXZDVGdRVFo2WGdJRUVzWkxqeGZLVmNoTkhEeU1FNU1pdDdndVJK?=
 =?utf-8?B?OXI2WnhidjdkaHgxdnhiMlRyaU1xcldxblhyQUpKOEdJRmV4YlhvaFVDODRn?=
 =?utf-8?B?UzdKcSs0OWNUUC80MEhtY1Yzdk15c3VxU29wdnhQZ2FJOFd1a08xRnViMlBH?=
 =?utf-8?B?MXJheTMzRUJuNGFJY3lhTUh0eDV6RnFubHpHU0N4dGgxcTYxRlduVG5GZkZ0?=
 =?utf-8?B?b2pMS2tGQ1AwcnNsMy9RN3lhRXRVZHdncWxyb0xPRVhSZ1VxRGd5VDRkSkZ6?=
 =?utf-8?B?STNMVXpyNFA5d3RJOEJOSkJUR1pjY3hvanVEME50WXBSV3BxcXpEVVgxRS9n?=
 =?utf-8?B?UDg4VTFDMlVKeWNhM3NsczBNN0VYMkVFN1lVdHRUc2hwUFhkRVZPK0xxNUJ5?=
 =?utf-8?B?VlYxSXAyUmJlQ25kVEw2bE5LZ3lSNHRFUkowWG9zRHNkYm1Tb0VoZ0djUjdX?=
 =?utf-8?B?dnNhL0JkSk1kMFE4aWV3Vm5FdFdWYlBhTWxaTTJRb0xrL1pBUDBjamNCWS9Q?=
 =?utf-8?B?MmhzOEdFVFJ0VXh6MUs1RGpaclVseEFOczVLSTdNTll2cGJiZWplNGZPcEYz?=
 =?utf-8?B?MXZ2dmpZM3diNCtiTHd6cy9BclV0c2ZMUmVWc0hJSk93eE5HVGxlSDVxdlpz?=
 =?utf-8?B?TjVaM3M4d1Jpeko2TFJ1UGRhWHF0U2k5UkR1Um92S2F0WW9JREVTSjNzVE1I?=
 =?utf-8?B?MHdTUDc3bDgyeDAzR082aTNYZ1RaTkxLTVJLRE1hSWdvL0NNc0xBYXZuZWtE?=
 =?utf-8?B?ckNYQmJ3ZnhwcFV4N2Jyd2N0SGJ1eUZSV0ZKWXdaWllHbFg0SVpLdVM2RFYy?=
 =?utf-8?B?ZHYxaU9Nekh1UnY2WXlwd0pHbTBIQzNyVHdPRVlEbHFHK2hpV2IvdGsrU2g0?=
 =?utf-8?B?UmFvcGR0WnJkK0N2V0FwMEluMklQNUc0UmRxVE5nYW9ibm1SYktIbWRWYS9w?=
 =?utf-8?B?bnJTS2JJeHZqd0hSMDVLZWR1Zm41K3k0MzVLL2ZYYmVqR3JLdjl5alJNdUNQ?=
 =?utf-8?B?dWxtaXpJbmhaOVdKb3dsYmNHWVB6YUJ1WU9nbFVPbTVBTDUzT0xOZGJkZ0la?=
 =?utf-8?B?L1Z3OThhdlFMYm1oQlN0WlhWV2FnTzV2ai9ndzJBTStFNFFqZVFqbnlKQ3kr?=
 =?utf-8?B?WkFtY2tMMWpEWG9TMS8zaHU0MHRDYVVZZkp5QnVtNFE5ZFQweFYzWE8vZmJU?=
 =?utf-8?B?KyszTnhTRFgvMXY0OUZ4eXNpVWRpOXkxU1kvekIvU3JvdlpQa3JpM2hZT2Vu?=
 =?utf-8?B?RTJ1clhYTlpDajZ1REtkTW5kSGk5NjBqU0d2Q0JWSUY0MkxBdm0wUklYQmNo?=
 =?utf-8?B?MEFrYnRJSFBIc01sUUdKVmZhQXgyYmIyMnhNbWZBa090S3QrdXhtT3RlT01K?=
 =?utf-8?B?aEFTQmNwcWd6SjFsUFZhblNFTy9HVStrRkZYcnNPUlR2UGhaZFB1Z3Nycjc5?=
 =?utf-8?B?Q2pjdW02MThVK3FCVi96OEI2WHUvN21mNFhaQkRpMFBsV3BjMXdiTU9qaXc4?=
 =?utf-8?B?TjBPbWRSdXlHUDNEd0w3TjV6bVFoQm0ycTFnRjB4Q054QWovN0M5S0FTNzVN?=
 =?utf-8?B?ZE96NXF3bnkyNEEzV2o3YnBBN2FtWGtmWTdYNDFma09WT0xyczFuQW9DWHZN?=
 =?utf-8?B?RGdEei81MjkwNE5scDBja000eXhPaENrT29SREVUMnBJaFkxRVRmR0RTYXVP?=
 =?utf-8?B?RXJhdit0TnRFOXc0MzdsMEhPVFJJM0R2OE8vdDdVZ3gvbElDcDkxQWswWGVE?=
 =?utf-8?B?aWVneWNjb1pyZmVYcEVRZzVQSC9zdkdJSktNWWV3akpPbWhxUU5oNExESi9C?=
 =?utf-8?B?bytMN2JnMCt2aHdSQUZmNmxDNTZsbHloZEN2K1ZiZ1MwL1NlY1RSUFQzQldu?=
 =?utf-8?B?dC9XYVIwaUFLYndpMGUyczUxaUIvd0tNelVaOE5OcDlHdlBZVjVjNlNiY0o4?=
 =?utf-8?B?U0FWd0lkVENOby93amNOamVzcmJ2cExaa1QreEx6Sm1hQ0RDL2xjdWIyaldF?=
 =?utf-8?B?R3lOeUd5SzFMWmhrUzh4MnNDN1hETFJzdFk1bVNCZHVQcEZ1Sk9LbWd2UDZw?=
 =?utf-8?B?bFdqWFJaY3FYaEF2L2EwQ1N4SHpibjI3ejRSMURoNXdHOWg3T0dxZVFYSXk1?=
 =?utf-8?B?WXhrL29wMEhqTy9zNlVKRGw0ZllaUmdRWXpER1p6OURjclovV3RWdWtzcEhP?=
 =?utf-8?B?ZUE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d962e6-2692-4c32-ceb7-08de0cb5273b
X-MS-Exchange-CrossTenant-AuthSource: DB4PR08MB9863.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 13:08:52.2080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwDzT3z7PBQKkIjZyr81LbOQJSosVYMKwWLG3YUPQiXJcw7FKR6dNyvzNU0raQ3dJjz/6sREw4Lstch1QUCEkxXVI3lZRo23+XgtJoyTDjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6001
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=martin.drab@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 16 Oct 2025 10:03:41 -0400
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

 From 4010649ca861e78bb45688258db7f37edfe81342 Mon Sep 17 00:00:00 2001
From: Martin Drab <martin.drab@virtuozzo.com>
Date: Wed, 15 Oct 2025 23:37:24 +0200
Subject: [PATCH] [qga]: Close handle to the serial device when destroying a
  channel

It seems the handle is not being closed when QGA is freeing its 
communication channel. The open handle prevents the serial device from 
being removed. That may happen, for example, when the Virtio serial 
driver fails to restart its devices after HW resource reassignment due 
to a CPU/memory hotplug.

This fix adds the handle closing code into the ga_channel_free function. 
Only QGA for Windows is being fixed.

Signed-Off-By: Martin Drab <martin.drab@virtuozzo.com>
---
  qga/channel-win32.c | 6 ++++++
  1 file changed, 6 insertions(+)

diff --git a/qga/channel-win32.c b/qga/channel-win32.c
index 779007e39b..520cd6ae50 100644
--- a/qga/channel-win32.c
+++ b/qga/channel-win32.c
@@ -354,6 +354,12 @@ void ga_channel_free(GAChannel *c)
      if (c->rstate.ov.hEvent) {
          CloseHandle(c->rstate.ov.hEvent);
      }
+
+    if (c->handle) {
+        CancelIo(c->handle);
+        CloseHandle(c->handle);
+    }
+
      g_free(c->rstate.buf);
      g_free(c);
  }
-- 
2.39.1.windows.1


