Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408E4C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 11:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s52F0-0006tv-An; Thu, 09 May 2024 07:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1s52Et-0006gq-NW
 for qemu-devel@nongnu.org; Thu, 09 May 2024 07:47:07 -0400
Received: from mail-psaapc01on2070e.outbound.protection.outlook.com
 ([2a01:111:f400:feae::70e]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1s52El-00007e-JI
 for qemu-devel@nongnu.org; Thu, 09 May 2024 07:47:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VV7GSk+Cdffec0tj/B5TsZZ3yXWkRp+T86FL8vWZn+IoISDnfjOqwgAfk/qjG02GAl9oH1xEbWrDjAIh41iU4KmZHRaIrP+V0iLc9t6itOMTpexRASoEGjnSC3/9mUm2DByyObBznT96d7z8TPwKPZ6i1O77X3beKCJEoBmvxJXYRdY6ujaOsioqkoeODHRUgY2aaANAl00fUDqqv6IGT7gQL3j5JCm706dDqBsOVWdb6KxuEaoiK3vQCedC7bmAxlBvlYMO16cgFxd6QBA0aBagCaCb/PH41CQSBD1QYGzMTinUJ1vLp1QOo947lrIZPZdPfJXIOGlXZyXvs7mayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2xE4pfdPjPOAxTkSHWMYb7NOTXwUEBRAu7ZG5NBDnk=;
 b=Vd2Hv4nUWghVzxbZuTgNf84CZ6fm6iGDQQ4zq/F6ZeKJF6/FsyiXP4BInRZI3kKdk0ZaBEUbZ4pH3t7mo8N+VaVjw/g5ZvSfESuBWKkh/Y3JntFsEBVF8vrbYTbuEAOpWMpgMlJc13wcB5cgwPkx2r1L0k1XXfogHq4vEu+rjZs+tskNTqZ7qe8ve7I04t34zKZ69TJBlz9xcyKBJHSndGfRrw9mA6BcDu6C9tF0k3u7qVsLlPuIRFesKlvjhPT7fiZQw345cFvBuGg57ZdpUFVKguxxv90QZ5b3WpmKan8qZT01xzBnGJWW29UN/3FFI0UxLfn/WvkEG+wbEGqMqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2xE4pfdPjPOAxTkSHWMYb7NOTXwUEBRAu7ZG5NBDnk=;
 b=FrU1irh/7Lq9CRTkb1h/nUizTTmDfizWJDoV9qQW7kkhLirQMsqxBS6v627yvZ+RuaB4CS7nJW+fAM3Im/sMeNEOO2Ml58OmorPKWjf2WT1ELUS4toWGIGGZFe8I2Ez8DhR4FUKXA6avKObem1h1rqxIjo8fMnOlCNWIYa3bQyZbGKwWVvYYtuzfeS0aggpW6sEeMIlk8M8EBr6Fm/54OCibq+8i3CVSv0LRGnh1D/6UuAc9RvDLcjvFSGOr+V2luou7cOJx1P/uFzggDrTahK+wyS8w6oRGWwzZJEz9O6B+u3PQdwengSq17t6rXypHiHWAAiIAA5Ek2y0joAYkSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by JH0PR06MB6511.apcprd06.prod.outlook.com (2603:1096:990:34::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 11:46:52 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::b6f8:321a:6742:9bde]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::b6f8:321a:6742:9bde%6]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 11:46:52 +0000
From: Wafer <wafer@jaguarmicro.com>
To: mst@redhat.com
Cc: eperezma@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org,
 angus.chen@jaguarmicro.com, Wafer <wafer@jaguarmicro.com>
Subject: [PATCH v2] hw/virtio: Fix obtain the buffer id from the last
 descriptor
Date: Thu,  9 May 2024 19:45:52 +0800
Message-Id: <20240509114552.11525-2-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.27.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|JH0PR06MB6511:EE_
X-MS-Office365-Filtering-Correlation-Id: 72240c3f-eaf1-4b02-f5e4-08dc701db7f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|52116005|376005|366007|38350700005; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUpKdlFIeUtSVUlqMWtZYkdrb1phSWthdmZ1YWRiYU5GRGQzVUtDYmRzaSta?=
 =?utf-8?B?TjVPZ094YkM0QVVrcUJBbndEanYrR1NjY1UwYWNEOXRpSTkrN0MrMENZUm5Y?=
 =?utf-8?B?RHBhYmg5NjBxeEJVcUlrZ05VVUROV09GbzVOYkVvVHd1TlBxK1BOekNxU0FI?=
 =?utf-8?B?OHhlOThVU0RCVFZnNWV1Vm9TVGZrZklFaGVQaVI1UTdQZHNFRjJtZW50clNI?=
 =?utf-8?B?UWY2Z0VIaVl2TkU5QS9ubDROVW5kdGtMb0hGUy9lM0tKaDVpb3doRi9BZGl6?=
 =?utf-8?B?SGdWU0NhVmZPTTIrNXlZdTVmZTRCM2k1ODlXV0NwVDhFSjY2eGx1TFZBSXh4?=
 =?utf-8?B?QnFJSTNaT2xZYzZtTmxRK3ZOQUFXQXJRUGhEQXE0a09XdWtkczZaNGp2cTQy?=
 =?utf-8?B?SWNJRlhrajh0YVZCQmhQRVRIanRWdEtGcXNVUjE1MUxRbVpGSTczbk52NWpS?=
 =?utf-8?B?OVltMU1GL0p0Yk5yUGw5c0t2cDFWTkZPcGhNUC9pam9JVzM0NGN3cEhsZFZ4?=
 =?utf-8?B?TThlRklWVlVPWVkyZ2ZLQU5MN0Y5T05VL0RJelhDNWZVckxxRzdyMnpGZkRu?=
 =?utf-8?B?L0Q2VlBlbjFlZE9LR2sxRHpPUUlmdmUwbElxWjY2RWxOZmI3TUQ2SjFuYSt5?=
 =?utf-8?B?R3BINThyNDhBZlBXV1BWdTlNdHJiQTAyRnJZYW1XU29Udk9BSVBsSTRObVNl?=
 =?utf-8?B?MHc5WW5GdEhrR2lYR3hVZk9ucXp1ZUR1bXE3dlVSZlliZm5GV1l2N1ZlZUlJ?=
 =?utf-8?B?QkdGQVJzaFJWVHNrU3phamV1UHhLSTZyNG1IUmdJUnlLanhHbWJJS2pOR3Zu?=
 =?utf-8?B?V1o2MHBSL2t2a2xEZkhmRkt0NnNSQ3RsOUhIbWpVVnFRYmMxZEdoSDE1aDht?=
 =?utf-8?B?am5rZWRIS1hrVHdoaHJPWEtCL01IenVPc09NSmowUS9HWE0wS1A5Znh4a2Q0?=
 =?utf-8?B?WFZBeHFWV0tJZ2RYVkUrazR5QVhZalVqWGY3VWNhay92UTZKMm5zZjgwMFZI?=
 =?utf-8?B?Q0dEZnl3cnJLVzFOZTRFb3M5eE5kLzZQSC9vMllpYnpmcHFpaXNaVlJXZVFv?=
 =?utf-8?B?VkhWbmtwSmRCWnE0TXQ1bXRESFhEOWJYcG10dkE1dEtwOXg3ay9ZdzNjdlFW?=
 =?utf-8?B?SEdob1FxdkJzZjJYTDA4YmVnQTJlVWt2MGRFMDQwd3JDeXJnUExWN1NxQ29m?=
 =?utf-8?B?SmdFYlErR1lkSFBOb1ZXNXcvYVJFcENiSUhuanZCY09yQUtESlh1cExGWnNj?=
 =?utf-8?B?YkdoaHd2TzNWdDNIMUZiTG5iMEp6ZHo5VUVORUxqc2t6L3dKaUV1RGNMVzJo?=
 =?utf-8?B?ZWlOR3VGWlJjMUc0T21sa0xMZmtoTjhqVmRLOXdaUjJlbUtZVWR0QzVla0pP?=
 =?utf-8?B?NjBRRHhrYlhEbnNVNXFqeitrYUd6TzNSbnhNdStFa3FlcWloSVpiaUdLczly?=
 =?utf-8?B?d2RhaU5IOUZLNlh2dG9UTWU1NDBkcTd2YTJUUlhma1c5eHR4NjZkRzZ6cW1z?=
 =?utf-8?B?OThPSHJyMjRuckZPU3JlaVdHT1U1U2hzY01wejlERjR5SEF1QWl1di9RU1Nu?=
 =?utf-8?B?RmFwKy9UNEFpS0RiakNFNVFlUlNCUU5oWlRlb3BwS0Y3ZFNES0tMb3JialhH?=
 =?utf-8?B?dkRHWjFlN2RZL1MrVXhSZmZpei9sU0lSK3crQ2FnNnY5U2ZyWXZ3SzZScGlU?=
 =?utf-8?B?SkVWZENGYnczdC9wc3dpT052YURnZTJMYzNjWnJpUVkzWC9sYU9neTJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVJ3Z0tmZ3VWNXQrTmwwOVVjMHFNdkNScThVR25haEJWN0pUcDNqUWNIZkww?=
 =?utf-8?B?bEV5WTZYTzYxNHQ1Vkx3ZWxla2poRFZPSUlzUVZLb2F1MnRVZDJOd2JGcXhh?=
 =?utf-8?B?VjB6Z0ZvUkp3V2tYS2RhSm9zbm1NZ2pyVHZjbUhSQXdkaGJIMjFpZVBTUlNS?=
 =?utf-8?B?MitDczdqM3BDdUZkR0duN3BGSU9BWENrK0hGNWs4anI1aXE2Tjk4TmU0eEZE?=
 =?utf-8?B?WisrdkUrNTNyVUpWcEtwZEI3KzVXMWlLQmNLR0JjM3NEZnZTRVFZamw2V290?=
 =?utf-8?B?Q0lEdFdreWhHSmovL1BnNDM3WnhhOWFJRkwrKzNYbDdWc29pb2NNcVFsUjFN?=
 =?utf-8?B?RThYSlZrRGczcU0zVEIwejI5bGZoRmlCUGRqUnFxOWRtWXVEUk9RN1RKL1RF?=
 =?utf-8?B?UVFBZ1VuWVlielp3M0UwcHVGVm1ROVlwT05pQlZ6SUNxYWRQYmRiWTh6T3ZT?=
 =?utf-8?B?M0l4WGROOUpCd0pDakNud3gyYjRpVzBsOTB6K3ZNQk9lOFlHRHNYN1B5MjU2?=
 =?utf-8?B?VnFBSWIzb1pXa2dHZzlnMi9xNzllUVNBbWNRMm5lQkdxMDVZSDU4cWY0TDJR?=
 =?utf-8?B?bVVqZ2hSMUJ1RXpEajFqN2lxSWEzTVZrV3hUSHJtQ1BJRUFoemFwUmRweUN4?=
 =?utf-8?B?d0ZPaEg4VDdMUys4UFVvYUtCbUNXL0JIOEVsY01rWmFYbFAzVWJFSGtWdVhM?=
 =?utf-8?B?WUFncEF3NHQ2bmtBV1pxVmdGRjhGait5dVJHdEpKYWlSVWVWS25pczR1UXFp?=
 =?utf-8?B?ZnlKWWNWVk1BSm40UTRyK1FvUndGdEtNZWNwWnFGUE03eFlmNEh2OHZxTndK?=
 =?utf-8?B?L1RhOXJDOEg2SmtDK2ZGazhXYlB4d1dNbHhwci9iK3Z2WEMwdUpVZVlYZDJz?=
 =?utf-8?B?ZjdkaG1vN3NwUkl0TjRhblUxbUJuN3p5bmhGUElZWlY2cGlOcmxGRFpjcms4?=
 =?utf-8?B?Sy90aUxWa25Ed1Q1d1FBby82R2JHcTh0c3g5WEFyaERubGJkQnloSC9ObXcv?=
 =?utf-8?B?NXd1akMrazkwcTZVa1ZXWlZXUk1qV0JWYUwxK0QwRTZneHIzMUQ5bnNxM2VS?=
 =?utf-8?B?UFMrMTVxYjRCOWxjbERnQXNIM01FdzJlT0p0cC9IMVpuMDREYklmTHE4dUM0?=
 =?utf-8?B?TDl0OW9zRXU4WW1Zem1FZmVnNE83RVBuaE1xV3U2dWJ0ditITGhxYUxKYXFq?=
 =?utf-8?B?MjlvWFlzWUlZYThDazZMb2UzZHdiNjR4bC9xUndUWGdOeWxIN0M1dExlSjdy?=
 =?utf-8?B?WDMrZy9jQTlTTkxEalF1VnBTbmpFT2FpSUR2bkhEVDAyb0djMjBtblNKRmQv?=
 =?utf-8?B?eGNQL1h5c3FrYkpESnIyZUhLMmNXcjl2Z2prZnhLMmFweXA1TWd1WnlickZk?=
 =?utf-8?B?SmZFZDd0WlkzalNxb2NvdzhNaXVlbnRtRjVPTW9HSVN2OThmM2hnZE9abTZD?=
 =?utf-8?B?R09UZWVWWWVJWGJ1Ky9ydEhKNDc2QXV2ODYxckd6R3FpWWVnSDRXanl2R1cv?=
 =?utf-8?B?WWdJa0ZTM1RWQnFrV2lQT0o5VWhpMURiWG0wY1VWaDJrY3JMQm0zMjRWcDlJ?=
 =?utf-8?B?cWVTZ0FOcHBCMVU5eTVSV3F1RGREUStIeHIyemc2eFVkMzB2SUlSWFU0dlNW?=
 =?utf-8?B?Ykg4ZzFLWkpnT0VwZVpJZGF3UWkyc0VNTnA4MlNBcmI2YVhDTXl3SDRmSUxB?=
 =?utf-8?B?dnJOU29zSXBVcWJ2eE1jYk5LYmRyT05sYi9qaDhyWUlWZFU1WDJtb1hkSFJ2?=
 =?utf-8?B?QUlOakZTZ2FRZG9Rdk51ZkxFUVVkd1d6TEFOL3QrS1VNdVpjODdxaUpscjZn?=
 =?utf-8?B?UXE3VVFjZWNqK05vSkNnUjRrOXRxWkJtYmEzVDNzZjVyRTV6TUdpSFZSN0E1?=
 =?utf-8?B?ZUZ2S0MvY2pQSWZENGlZZ2w2TFIra0FpeWhDaXdIeEdseXNYMG9uK2hQRFFT?=
 =?utf-8?B?VWE0cVQ0M0N5YXNCR3lzV29jbm5pLysxd28zV0NOQXNiR0tXcHJpd2dxZ0Q3?=
 =?utf-8?B?Y2pNeWcwUGxoVml3WEdDaERVbHIxV1N2NTMxSkxLZ1pLZWhOLzkvZDM3Szhk?=
 =?utf-8?B?eVpEeXkvSjR3Mzd4elEyY0Q3bEdMNHAvZTBsUlYyeWgyNUNFb2pSdFRVU1pH?=
 =?utf-8?Q?GtimJnvz6bDysfzKFv/9tlvZl?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72240c3f-eaf1-4b02-f5e4-08dc701db7f6
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 11:46:52.4253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RsJDrc8Rl+BThw+9SMsPn/+7qRpwrQj0ny9UkQy+j0pfDv2CYGk714PV+FRfqY3YsPeOSbQW+R7Dzkn5h7kFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6511
Received-SPF: pass client-ip=2a01:111:f400:feae::70e;
 envelope-from=wafer@jaguarmicro.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The virtio-1.3 specification
<https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html> writes:
2.8.6 Next Flag: Descriptor Chaining
      Buffer ID is included in the last descriptor in the list.

If the feature (_F_INDIRECT_DESC) has been negotiated, install only
one descriptor in the virtqueue.
Therefor the buffer id should be obtained from the first descriptor.

In descriptor chaining scenarios, the buffer id should be obtained
from the last descriptor.

Fixes: 86044b24e8 ("virtio: basic packed virtqueue support")

Signed-off-by: Wafer <wafer@jaguarmicro.com>
Reviewed-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>

--
Changes in v2:
 - Use Jason suggestion: Move the code out of the loop.
---
 hw/virtio/virtio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 871674f9be..e9e8447878 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1744,6 +1744,11 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
                                              &indirect_desc_cache);
     } while (rc == VIRTQUEUE_READ_DESC_MORE);
 
+    if (desc_cache != &indirect_desc_cache) {
+        /* Buffer ID is included in the last descriptor in the list. */
+        id = desc.id;
+    }
+
     /* Now copy what we have collected and mapped */
     elem = virtqueue_alloc_element(sz, out_num, in_num);
     for (i = 0; i < out_num; i++) {
-- 
2.27.0


