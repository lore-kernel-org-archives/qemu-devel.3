Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5B1C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 16:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shX4Y-0004IF-QG; Fri, 23 Aug 2024 12:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1shX4X-0004HM-76; Fri, 23 Aug 2024 12:23:33 -0400
Received: from mail-bn7nam10on2062f.outbound.protection.outlook.com
 ([2a01:111:f403:2009::62f]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1shX4J-0005VQ-FO; Fri, 23 Aug 2024 12:23:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgW0RDX/wMjUGnxF43uE8cWCm5ehlv12Q1VChODdV1bKiRt9iuMASam5KgtB4e+JaGPNktXbM2RE2MWGQHXkP9/lMGbj95NmJ6pszhf6bVEOpqmn9cU3qViJOWWLUGrcIHcK9ZiL9cTabT4lQiJips1CW0d0fXduKO6W88xt+jpgEQtBGsHeWFXrZorJ84y9PWWwYKVjPdTpJTXJlqyTw9nfgmhDIFav56nyUXHmg+3W9ckjAxoHQbfZsGHjYZFWHjWUGhFdH3B3QBHM/yjElnL0kH5RuANf3fdbA9SSuFMX2HDjaEi5NmmyCPzqHPQvnBn+AKSBTHkdw6iy3fLYFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2HXWel7P5e4hGrPyUY/tK653/LBEDZCTNlo1CXgE+M=;
 b=Dck3uECDT+Z1GStUq+RimJRiDclkYa0kMd1LvU86FctsxVy5mZuJd0to6phkNkA6ZtzpRirIq4XtdDbBf0MOWXTFFmVl5lLsaCmQfgk0avXeUV4cW5NWOQ63rIk+ovq4DKd4zQfg9OKc0UPsgtGwEO4UqVsLsdeJdrAQ2UL+y9o8HfUw977nibYqNxpteGc7OfLTW4CCkXuB6U6eFIATmDuphIlQQCGhCzyXOCLLwUeNvJbOLJAUFoterQP1gnz71x+OI82m0MOP7R7Ox6uiNFEXvTrcmo8HIbls474a/mwI+2pVEifQ15HQp+0QtAXyOuJFm45cxFyUbpxvF26CIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2HXWel7P5e4hGrPyUY/tK653/LBEDZCTNlo1CXgE+M=;
 b=rAfShk/u8TCqm3jr7MiQkaN4hQVY4NIAiTxSiJsYp0tiJE6aYehDAvE9Jj/DrslzKdC9+03JkfY5MLRcZvu2D7WpM9b0PP2jDlgWAULhtwPd1VoBMIda2jWUhMiwKB3WM0oDRyzKJfGUJydHt5oX89sTuj5hv4V52d2eaKHHEkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 16:23:13 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 16:23:13 +0000
Date: Fri, 23 Aug 2024 18:23:06 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH for-9.2 3/6] hw/nvram/xlnx-bbram: Call
 register_finalize_block
Message-ID: <Zsi3aqGnq0SBbB4x@xse-figlesia-l2.amd.com>
References: <20240822162127.705879-1-peter.maydell@linaro.org>
 <20240822162127.705879-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240822162127.705879-4-peter.maydell@linaro.org>
X-ClientProxiedBy: FR3P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::7) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|IA1PR12MB9031:EE_
X-MS-Office365-Filtering-Correlation-Id: 40137c97-0368-482f-7b1e-08dcc38fe2a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0NocjZvZFo0OVFpVm5pYllQdmVTTlJqRy9GM1VaekNXWXFzakNPTkVpYnJK?=
 =?utf-8?B?QTAvSk5RQ2xLMG5rckZCbjFIUDMrN3d0b2paeG1GYUtOdEZmMVFtNTgyZFM3?=
 =?utf-8?B?ZzBhQk1xQ1ZOemhlU2p3Zy9udmhQVjJ1V25yNVpoZVdycTJTaXFvdkh0Ym9K?=
 =?utf-8?B?cno0YVZZY2xFMUNQcE1aNWFHWUZKd1g1QzcycldJY014VTUwMEMwRnZ3RTMx?=
 =?utf-8?B?V3MvMkpFV1V4RHlONnhyYnZEbDJDc0dUS0kraGlKMDFibkZ4ZUpRajlvRVJi?=
 =?utf-8?B?K2N2dlhSTUFoN0tqdWlnWitjTnhPVlhMSi84N2hyZXNSVnlVWXVDY1VWcTZW?=
 =?utf-8?B?NnlzSmpBRStHTjZ3dGUrSUk5SzArdGM4MTZwUkh2QzgvL2o3b1NycEk1WlZx?=
 =?utf-8?B?UFNEbkNtakdQRFZTcHFhMmdxZDZRVVB4RVJuZjArNUVxYlRqK1M2MGZQTmVl?=
 =?utf-8?B?OGFSTS82b3dWaXdNSDNYb3ZQbEp5S2tnSEQ3Z1BGUk9KUUovbTJub1g3cEtv?=
 =?utf-8?B?YStLbHE2UlpEeDdjVHJQbUt6cG9Gc2pEaHM2L1laSHg0cjlCZXd5Q1VzZjBK?=
 =?utf-8?B?TjZmYzcwaFptRWhQL3JyOUpObE95QVY1c0w0d2lDczh1dll6c3Qvei8yUEl2?=
 =?utf-8?B?amJaQy9hZWc5TkZYOWdqak1QNnNYQ1ZjOHZDZmd1bGN1RXhUTnF3b2lWZm9R?=
 =?utf-8?B?eGUzNUEvM2lXdlNlaVhRdEtnMnAzS3pxR1ZSMEgzQ2xuSktFV2NscFZCeENo?=
 =?utf-8?B?WTFUa21BSkJ0bXA0dUVSTko0VGlYT01GMVlSa1lDY3Nka0dZblhZUFE5eFBi?=
 =?utf-8?B?Y2w5d255TWpEcmEycG02KzYwSnJucVRPZnpJODBnSDhxbG52TFlqeThSdjUv?=
 =?utf-8?B?eVhTZHBvSGYxK2RKenVub0NVN1Q1TGZrSHo2THJqc3h5aXZ1RTNkZUhKT1JW?=
 =?utf-8?B?NlhKZi91bU1PWCt6L1dMNEMvcUFLeGp5YVhpdmtKTUFyTWFQcTB5MHR2UzBo?=
 =?utf-8?B?c004cVNsRHR1T3NPY2FlRWJKWUN4RU5NVXZwYWxOZnkybDE3b3dOL0tQSklE?=
 =?utf-8?B?ZkwvUHk2UVFsYWJ0NEV1ZlEwSUppdERIWjlOMDNDcHRDdFBqZlVsWExZN0RI?=
 =?utf-8?B?cGRkUXJlUnFtMVpqbkNJK1owN3VReGZXbHlBaDB2U29KSUpCbU5JbkI1Qlpk?=
 =?utf-8?B?ZlVZVnhjSzBWVnNUdFRHYjAvUlFtNTVEd3dGaDBzeWVWaElsRkJaQmNnVDlt?=
 =?utf-8?B?enpOVmFPZW9jQnEweHVGNXBMbkV2bkhqdE1XWjlQZVFtTG1UQm0ycHdMNUd0?=
 =?utf-8?B?TnJ6ZzZXTDB1N0tZd3F1VkFUSDBRL1VsOWZKdGNMclpHYkZVdEs0cmpZZjR3?=
 =?utf-8?B?SHpPWXk1MEtCUWdQaXJLaUM4VXY2NXNrZkVsbjJPTnJlaklsZVlZejlVbEhT?=
 =?utf-8?B?U0tSSnpYZjlZK01VekVBVWtNc2NlNWlhWHdUWW5SK3RrT0FRSjFWZnBLUFpI?=
 =?utf-8?B?RVRTRlNOYU5XWStmNS9zRm5aN3k4REFlNGtOUlV3blE2Z1NBbmRldzZNRUtN?=
 =?utf-8?B?eDJLd09hTFYrTGtnbm5hT0hpWldvODlpenRmUTdvZDJYQVVjOXU5SkRGTmND?=
 =?utf-8?B?Uy9UMHdOZkt4S1Y1cVlKRGlod3QwOEZTd0RDd0lRN0lKTVE3d2VKS0ZBWURa?=
 =?utf-8?B?dDZIQ2l1Yys2VWVBS0RDV09MTGw4aFdTNUVwaGo0S2c0MGo5SW5iYW14MjVh?=
 =?utf-8?B?bVpwTkhKYzNBcnkvYjd1R2FwQ29QU05sRkxoMzhpOURzZityRmdhOWY0dXlJ?=
 =?utf-8?B?dFl1ODZPc0ZpRERoS1owQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3BPdE9mRGttNTJ0dDZCdDEra2prUXN3U1pqMUx1dWJ0TXMxbFhCK0IvbVJN?=
 =?utf-8?B?VGFpT0cvZzI4LzhIV3RBazc5S0YrcWhGQUdEK096WkI2R29IVDZ0cGc3a3dM?=
 =?utf-8?B?Y0FHSzBUblJQZ2RCdDB5RmRZcXJ5alQ5aTJSalU0eTdFa1FtV3U0UEI2cEw5?=
 =?utf-8?B?SVc4bkVOR3EzbGNjbFdWb1NMOUwrNWEvbzR5VEU4Rzh3czNtN09SL0R1OUpw?=
 =?utf-8?B?Um5SVEVDUWNzZG9zRGJ5ZSsrYWNVK200TW5uTS80VUNwQ0Z6ZHZVVVUwZnJ5?=
 =?utf-8?B?d25IeFJreEZScW52Sm85aGdyM0JmaGV2Sjh5OTdMczd6T0QybUlxZGMyR1Vj?=
 =?utf-8?B?bDc5SGMxSzNGc0s2VkNVbytOdlhaT05xQXpLSDU3czczU1RBVE9XOXltZVMy?=
 =?utf-8?B?SmZjb1piMXJlZmRhaVZiYm5wN0V1VUVmMEkzQnFtOTVoKzErdmZFS0V6NHl0?=
 =?utf-8?B?KzRDWXhqNWM4QmhlTTdGNkhDa1ZzNlR2bmxPRmNuS1VJZ1AxSWU4cEpmSHZB?=
 =?utf-8?B?TFBhc0V4RlJFa29xTWhUOXNWYTAzQWFzVEt3enFWU2dLdk12UHBMSnJCbVRD?=
 =?utf-8?B?TTZZS1ZPVC9vcDRHa3BqY0V0bHhrTVlObHRHUkFxK0RNTW1tNW92Wkx0YWN4?=
 =?utf-8?B?QVpybC83N0ZjbEhSc1JIZFdCT2JkeUtLbXlqRCtpNWVoSi9Fa0JWQk96ODFU?=
 =?utf-8?B?cFFGNC9JQ0FwVGdBbUphV0x4bjI4K2x4b3FtakFBVkNUSmltZ3hZNlo0RXJm?=
 =?utf-8?B?UkNUM0FrRFh6Uzcza2ZjMnRJVVJGbWZiMnVkYUkyQkFrOXBlMGdRNzJEVHVE?=
 =?utf-8?B?NTJCSW54OGlLNkUrUXdNT1ZONC9Sd1hNY0tzalpCTWZVNnJaWTI2MVVwTHM0?=
 =?utf-8?B?K1Q3T2dqay9qTHptMFdraVVvM1l4cVoxVENJcGxWK3BYSTM1QzFCU0E4a3lk?=
 =?utf-8?B?MGh0YzkxVFM5MDI0MzBlUTlUOXpCaVUycDRvS2JaNDBQa0V0OW9PWko4dVYy?=
 =?utf-8?B?aDZjL2JRUnhEVWlmWE1NTFlMZDY0R0V6SU45OURFd0ZXSGtjc29jcTlncXpr?=
 =?utf-8?B?eWtBaDhPd2xtenlaRVJoZy83NlBKOUZncTh0bU11ZHBadzdPZFdydGNtb1Fr?=
 =?utf-8?B?dnJVOUhaVmtqSFpjZlVuK3dFcHIvRXQrZnRKb1NFT0VMbzhHcks0cVhJSEdQ?=
 =?utf-8?B?TkYycWRucVh0d1Z0ellnc0pIcTl0YlU3NHZjRUpoNVBTRXVJbFR2NlRQOVhL?=
 =?utf-8?B?aXFORUNZVlRSdHNhcGRZOTRzVDdtNEFyMkhaZ0tIZEx6SFVIcU41NTFFVUpi?=
 =?utf-8?B?Tk9ldXQxRDBnd2Zpd0E5VkhDSFVHOWp1UzNIQUFZQ2FSVTFoMGl4RlVnY3J2?=
 =?utf-8?B?S1NmekNhZ1VWQyt1ZFlFcWY1T3NKWVptbEMvQVN2ZzdMczd5bGlaT3IycCt5?=
 =?utf-8?B?cUgvSVUyZ010Ym1lNkF5ekNKR2swbWtJQ0JMVHNnM0FMS3prdWxQT3JrQi9x?=
 =?utf-8?B?Zm5jZEovbVoyMVpnZTVQVzBDeGozMllkVlJzWVZ1TVhPWEhUNjFxQnIwSkJj?=
 =?utf-8?B?NitRbnhIcUZBcW1pNUgrT0dWNmRBZTRCYjFQSXNKbFgxeVlFMFFyTmVHUTlt?=
 =?utf-8?B?WGtmOFRubGFacHp1OTFtTGUrNFF1cmRIWC9lVlY5dVdpUm1yYUJ3U2RtVm5i?=
 =?utf-8?B?U2Fybk5TTXN4MDFhUmpwS25uRGd3akxkcHMvazc3dDZSZENocWZiTFBzN1cw?=
 =?utf-8?B?N1dJZWYzd215aWFwNHRZM01tOGJoZ0VsckkrWFlRL28rVEJ4cWNWLzBidmlx?=
 =?utf-8?B?L3BYWHhXYjhGMVNNMUtFREIydHp4dVljK3FHTSt4TGpYTXVINm96blRnNE5Y?=
 =?utf-8?B?S0k3L24wWEJQUURSMGFtYkI4RWFkSEJqaG5PbGF6S1VLOWxaK3JXYTdoVmxF?=
 =?utf-8?B?bHJhZ1NpUDVPNU5KMFpVSGNuRHBhTVk5ZksrdkZxcVlLM01POTlSTUc0bVhP?=
 =?utf-8?B?RUxpZFpwT0g4OWRCT09hMjdZTlR3ai9jYmprZnJzMHYyaTQvYzQ1OHhDekl0?=
 =?utf-8?B?UlJJT3NuaWtNNExkanZlUzIrTmRTUk9SbG1pN3hJVnBWOWxoVnZ4c3lDUDcv?=
 =?utf-8?Q?T/TMuVk7iaNsKIWCTFjsJ4HEt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40137c97-0368-482f-7b1e-08dcc38fe2a8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 16:23:13.1866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BPf5ctuLdmANEiKrYcHu8Jd/kQcI5S8mi7Ou4eT9l/uP0GhsltX1IFNUsVfq0s+0apxK3GiIKnwYSl4D1JSFgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9031
Received-SPF: permerror client-ip=2a01:111:f403:2009::62f;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 22, 2024 at 05:21:24PM +0100, Peter Maydell wrote:
> The TYPE_XLNX_BBRAM device creates a register block with
> register_init_block32() in its instance_init method; we must
> therefore destroy it in our instance_finalize method to avoid a leak
> in the QOM introspection "init-inspect-finalize" lifecycle:
> 
> Direct leak of 304 byte(s) in 1 object(s) allocated from:
>     #0 0x5641518ca9d8 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-aarch64+0x294d9d8) (BuildId: 4a6
> 18cb63d57d5a19ed45cfc262b08da47eaafe5)
>     #1 0x7ff1aab31c50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
>     #2 0x564151cffc5d in register_init_block hw/core/register.c:248:34
>     #3 0x564151d006be in register_init_block32 hw/core/register.c:299:12
>     #4 0x56415293df75 in bbram_ctrl_init hw/nvram/xlnx-bbram.c:462:9
>     #5 0x564154891dc1 in object_init_with_type qom/object.c:420:9
>     #6 0x56415487909b in object_initialize_with_type qom/object.c:562:5
>     #7 0x56415487a93d in object_new_with_type qom/object.c:782:5
>     #8 0x56415487aa11 in object_new qom/object.c:797:12
>     #9 0x56415507883d in qmp_device_list_properties qom/qom-qmp-cmds.c:144:11
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>


> ---
>  include/hw/nvram/xlnx-bbram.h |  1 +
>  hw/nvram/xlnx-bbram.c         | 13 ++++++++++---
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/nvram/xlnx-bbram.h b/include/hw/nvram/xlnx-bbram.h
> index 6fc13f8cc17..bce8e89d905 100644
> --- a/include/hw/nvram/xlnx-bbram.h
> +++ b/include/hw/nvram/xlnx-bbram.h
> @@ -47,6 +47,7 @@ struct XlnxBBRam {
>      bool bbram8_wo;
>      bool blk_ro;
>  
> +    RegisterInfoArray *reg_array;
>      uint32_t regs[RMAX_XLNX_BBRAM];
>      RegisterInfo regs_info[RMAX_XLNX_BBRAM];
>  };
> diff --git a/hw/nvram/xlnx-bbram.c b/hw/nvram/xlnx-bbram.c
> index 09575a77d77..1bc58e90ad0 100644
> --- a/hw/nvram/xlnx-bbram.c
> +++ b/hw/nvram/xlnx-bbram.c
> @@ -456,9 +456,8 @@ static void bbram_ctrl_init(Object *obj)
>  {
>      XlnxBBRam *s = XLNX_BBRAM(obj);
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> -    RegisterInfoArray *reg_array;
>  
> -    reg_array =
> +    s->reg_array =
>          register_init_block32(DEVICE(obj), bbram_ctrl_regs_info,
>                                ARRAY_SIZE(bbram_ctrl_regs_info),
>                                s->regs_info, s->regs,
> @@ -466,10 +465,17 @@ static void bbram_ctrl_init(Object *obj)
>                                XLNX_BBRAM_ERR_DEBUG,
>                                R_MAX * 4);
>  
> -    sysbus_init_mmio(sbd, &reg_array->mem);
> +    sysbus_init_mmio(sbd, &s->reg_array->mem);
>      sysbus_init_irq(sbd, &s->irq_bbram);
>  }
>  
> +static void bbram_ctrl_finalize(Object *obj)
> +{
> +    XlnxBBRam *s = XLNX_BBRAM(obj);
> +
> +    register_finalize_block(s->reg_array);
> +}
> +
>  static void bbram_prop_set_drive(Object *obj, Visitor *v, const char *name,
>                                   void *opaque, Error **errp)
>  {
> @@ -537,6 +543,7 @@ static const TypeInfo bbram_ctrl_info = {
>      .instance_size = sizeof(XlnxBBRam),
>      .class_init    = bbram_ctrl_class_init,
>      .instance_init = bbram_ctrl_init,
> +    .instance_finalize = bbram_ctrl_finalize,
>  };
>  
>  static void bbram_ctrl_register_types(void)
> -- 
> 2.34.1
> 

