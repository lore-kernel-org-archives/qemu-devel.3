Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CD1C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOWf-0003GJ-Sq; Tue, 20 May 2025 11:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWe-0003Fi-Gl
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:04 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWb-0002TA-ST
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:04 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K9twWJ009877;
 Tue, 20 May 2025 08:04:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=32+Qwyy4PKCdAlU1XbkR2tPxH1dX91rBCeR80BoBB
 kI=; b=c3Ky8YZE8toL/MV65d/c5dBNf9d6UiMwFCbc/cmXlLWrD7ZJ0TWV0/smZ
 Io3WV0C6VYUvpAtz1u5hxbp5okxEW/V+uLg6NGaU4LWgTakWrqHWzAQQIBqMVLpU
 8npGtRuM4H/5NDpR0pyEuNnPXS+r2QbcsRB98C46pJsNnIFYqU/TiYTqnaFUcmav
 rNUGYZVtYAoZtf/mVWMGT/Yhx3+8OTgj3Td6+EsOWzaWaE4eAsI40XtRQC7kEL7P
 GELI+LCyRaGQ/OcOtFWrGnBz9Tiy6PxIC4alx62yeE6ZaI/uXSUDqddEqqI4nm2A
 37iRGwtPIYAnLQl0x/f2ekXH22hLw==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46rcm2hydv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:04:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AE1toe9joHa0PQWMCEwATSK5kyBWzzcXD7tMXxoj+oTiyIfqiCeoK3wL8bvL5CVz1twuh36/xmiZsulMHXkGJ+AjwGxmVJvzKjlQtyTIxDiRVjlMGj7wImrb8xAb/FU6gAnE2kl77UCaKQZJY5tz0/p9sasHgBGl+mohdF4f/ysSZq85leLC7c/wA42U/8l/69qPDU9cTX6aVy2iLq0zdEbJiwFYSp0M4lNSlx/OP2ljUCJlclMB3iatykUBVXqD47kTI07P2qeuCnHQyOrzKR+PaZ659JenHiaU/1Lq8iicG74gNNRvFg3Y5tv99iBV3LjXXrFDHwWuA/GDVCv3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32+Qwyy4PKCdAlU1XbkR2tPxH1dX91rBCeR80BoBBkI=;
 b=KI9sLIlH4DNQg5Ll9ZUdJWt/HXdDmHrSpe5bZfdNeLYBltnbh8CPCD3EmkP0CoyN6Z+svKJHmjEU8VstBMSJDoHqZKJ5yKLH2CYNwFIJWUcKgqAuSto1q5X1bB3zvaKuYM7YDSSKwEcsJyRb6FuvaG2Ui6WvuiPOqk/0QMHnmkCJPBQBpx6Jnzo1W/NzKyvd6TPNiwjb8dGZNXs0ZtxrcxsWYG24vAwMsk+WhXB6PPXHe7CIvRxNmkAxl8e2sJprUF7IJG+VgFy/P5BnoRI8b1ZvQljZkZ9E/GEzT+FB7a0f/Jf7qsqg2q6S6UIX75Y2ytSl1kVifFEP6n972rpPMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32+Qwyy4PKCdAlU1XbkR2tPxH1dX91rBCeR80BoBBkI=;
 b=U6GLXb219zhgPk4zW4H+GYe0VBKyfbRT56ABGVsZ2Vh4u+kEY4jtxU6ALOmTig3ZZm3HXIWOMJW+P0yAGyrtZpcw2eOt3UQGG0fL0Du9PCTXLMvCbX6wKvlopexoky1kF7VxxTI8BjLhpPTwb5xs00OV9r7orhsjBYTIjAPkUX/n45GTbTB3nq39Ood1KvCctCu6vT2iEV3u63Y7ueAESdhZfrxLfMujhAAE1DZI64JJijh6hzy07hlmpVnnkHYMFo4C9XM917tSmUexX/ktAbIPd5hIvUmzlI7uA2+VHJHmVfKiMyeoqCutrF6wWrq66oQr1ibaOMMo5Sdt1zwL4A==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:04:56 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:04:56 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v2 13/29] vfio-user: connect vfio proxy to remote server
Date: Tue, 20 May 2025 16:04:02 +0100
Message-ID: <20250520150419.2172078-14-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520150419.2172078-1-john.levon@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ae6d28-0ba7-416c-5a28-08dd97afaef1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1RuM0xJTDhPdDBjUVBubGJ1SUNnUnd4UmhwOHpTd3NlUVlmV1Foa1ROZHRX?=
 =?utf-8?B?NlJZckpZRGw4S2lGT3lJSHg0eUpRNFN0ZlExZ3ZDRE1mOC82dk1tbXBRS1R0?=
 =?utf-8?B?WDUvVzBFeW50MGZUd1BWR1ptVksvQUExWUFjT2wzL1BNbFdPSW9iMEdjSlg5?=
 =?utf-8?B?eWFzUHlPcVA0Zi9WLzkxOEloRXloSWJFZmYyc09CN0k3dXd4NlFJZTEvT25p?=
 =?utf-8?B?bWdQMVY2Njg5alNLZGNaVGVldWxqZGhxalJBdnRKL29wVW5YWk10WFUwQnJJ?=
 =?utf-8?B?Mk51YTBjMUxEK2Q2NmliTC9IK0E2Wko4aWNLTERyU3NtWGh0YUdwZmRoT2Zl?=
 =?utf-8?B?OU1EalNoTC9BK3ROb1ZGd0svNE5uc3V5ekZPQmdGTm0vanJHb0xjTE5Ycnhk?=
 =?utf-8?B?Tk9Va2tGclp6T0tGbnU3cGwxdVd3ZFIrOHRwNm8ybkM1Rmg5SzhYa3BQNmFY?=
 =?utf-8?B?K0FWS1Q5UFNxbkxZalZMMm04YXVpUURzUTFSanpqTWQzWXl2eU1pSmdxejgw?=
 =?utf-8?B?MVdOS09wOXhMbm1lWDlYbndLYWExTEVWcUtjUVAxTHlvaW4zT3o3YzZIYkth?=
 =?utf-8?B?TDhHcU9oYjAyWnppTXJXdFRXZk9DSkg3TkNwKzdLZjk0ZHVVTk5TWkhpdFdR?=
 =?utf-8?B?M3B6bFoyc29OR2RoQmhHUWwycm45UEF4Smhid09ISldFUWhNUmNlYlNqL0My?=
 =?utf-8?B?U2llTHhaMVU0UGhEYkN6bFdIaVBKOVBLdTdyNTE1MkVHNEhpRGFOZHd0c2hm?=
 =?utf-8?B?b29QVzh4WDFEQmp6TzJFTUVnYVpCbGhJeDB3RGlHN0g2WW04Ky9zZUo4eGFQ?=
 =?utf-8?B?QTllcitENzhuOHBTbHpQNTBjL2NOU1BjRy9xQVMxNVlzSkgwUjNRMkRNWUhU?=
 =?utf-8?B?ZW9HMGhudE1iR09tckRvUERoc0FYQk92T0w4ZmpOdW9wS3p2QzlDNmZZRjla?=
 =?utf-8?B?MHA3VlpaRzdQeU0xc3ZtNytrVkxCR3N2SkdCQ2ovOUZVN1Z3UGtWWGJyMlhP?=
 =?utf-8?B?TWFTb3QwM09QTVhlcjFWK2VjNTJaMUdaNmR5UEkwckVZQUxSVklTdGpRMW52?=
 =?utf-8?B?NDZWcXMrTWhNUmZ2Q0NwUksrUVB3Zm9mOW5mMmV0bVkwQllxMlRuOHVwM244?=
 =?utf-8?B?YjY5dURldi9PVnpYMzB5eHhvcTg1YlM3aGdGcndvOWlYZzA5WFFlL2pGVWty?=
 =?utf-8?B?Sk03eURRMkhtUGFNcXhVUU1PZGJRMmhaMWNoVWYzQ2lMSVdEeXlGbkx3aTlB?=
 =?utf-8?B?NGdybTJxZm1zRjlSM2F1YXNLRU41VUZjazQ5TWx4Nnd0MnRqZjhjWjRObWlO?=
 =?utf-8?B?UzZwSTcweGc2aUxqMjNTRmgrcWRyaXQ5RnJ0eEd5OEpJNlZQQkxmVmVoTnMy?=
 =?utf-8?B?Y0FtNFJDOHRyWWhKcytrVVVMOG85U1QwazI2KzhQdjNqNUdkSUxUTE11T1la?=
 =?utf-8?B?VjdXVm1sWDA1QkNyejlaMS9yTm1Mbkg5bUJndTZQcUZpM294TncvUE81Vi96?=
 =?utf-8?B?dFJmOEtRNndoUFZOQndLK2ZUVXdnbzNjQ0V3ekc2YjRRQk9YTHVndnM4eXBx?=
 =?utf-8?B?cTBLaGtzM2Q4TFhjTkxSRU1xZ3IrQ1FmN2E3UUttSGpOa3IwOC96OHdvajdL?=
 =?utf-8?B?dCtkWGhHdFdMU2d1RkZweGZ4K0J6R0cwSzVOcGFTQVpWR0ZVTkpHb09sdmdK?=
 =?utf-8?B?SGdHUjRtL3BkeGJtM00zOUk0SXZlWTN3ZE5jbnN4dHF3Y2pFNEpFY1RIdnFC?=
 =?utf-8?B?ZlAyWHdnelVVL3ozbmlPWE1TQlJxWmlsaFRpRmF3N2lIaTBYcmZGaWx0Y2Zv?=
 =?utf-8?B?YkkzWThDNWVTSUdnY3VxUitOcE1oRWcybEwyVEFjc2dGd09QT2F3Z2F5WGxm?=
 =?utf-8?B?TEhhQ1d4V3J3VmdQbmx6SS9PNmwyYVloUjdvbUduSWlFQlp5dVpBWGlkcEVD?=
 =?utf-8?Q?19tZebXJSh4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejk4K1JLbDR2T1VBM2RGNExBOU1JNkxHT1hlVFV6SmJyVERuVUdVRWU2OTRK?=
 =?utf-8?B?ZEdRT1pQQUFPQmtHckcvcWd0MVMyMDQyVmJQZllvVXcwd0h5Mlh0ZVlmdjZh?=
 =?utf-8?B?L29GQk1WekxhdTlGb3J6NXJFZEY0SzFiVnNpaTJ5cWlOODVKT3lCbFl6Q25U?=
 =?utf-8?B?Q0UxdUxBbkp4Sk1XVm14ZU54U3dTSmRIQVoxVHpyZEpJSnZ1QjM2eFdESmJl?=
 =?utf-8?B?dWIwUDV6MFY5NGw4R3pLSFVZNzRERU1FYUkwaFA5R21BUFVsREtvRDhQeFFB?=
 =?utf-8?B?UVMvdkR1b2RlaG0xRUdQMzdyZW5LVXZMNko4RzZjb0FNRXM3UEVPam04RFoy?=
 =?utf-8?B?djlodWtKOXhvVGh0NzJ4eGJqL2FXbHk3TURMblhIaDQ1R040ZGlCdkU3Zkxx?=
 =?utf-8?B?M0U1aENxS2VjSnNyWENxUzd0NTZBaWZOOWltcHJQaG51NUcxemQzV0lIU3Zq?=
 =?utf-8?B?bnpRZ1dnV3QxWEthQ2dSRWNWU2lNeXc1QUViVGhmK1Y3RVdZY0JkVHNCVEYw?=
 =?utf-8?B?dE9XSXZjMEE1N2tvaExXWldUV2d6a2hjci82aGdUdXJDcjYycWJtV1RYMG03?=
 =?utf-8?B?UVNXbDFxczRlVFV5VThhUDBUK1c3NG5wbFIxdUhUSXZCSFJyOWFXRVdIVlJU?=
 =?utf-8?B?eTdURlU1RmRpc1FaOEk1bGtrNmJrKzV5YW5CbE83aER0U2EyYTJueGZxaitZ?=
 =?utf-8?B?ZnErT25UK0h1Z20zWHZ2dkp5REswRUVuekVwOXozZEt2b3U2TTgzeWhZdTBC?=
 =?utf-8?B?YTlnS2JzZ0ZNV3d6V05WT1JMK2ZHT0NMVXovZGs1R1JWZzBMUFNxWnNZbGox?=
 =?utf-8?B?UnpTOGo3UE1BQ1o5ZHl0eGY1V2JHVStuaUJ5akR6V3Zxaml2UXZEVEs1bDRi?=
 =?utf-8?B?bE1FSEZFbHVTczdsM29DUTJFZmN2bUoyRkdvRjY1RUFrNjRidnhDbnJwRUpi?=
 =?utf-8?B?NGVobnJOQkQ0NUFQYk0wTnRtTTlWeVBldTI4bUZDQmFrL2VhNmZuYnBFVEZS?=
 =?utf-8?B?YllTL2J4M1N1dzR4YzVKeWd1OUE5MzVQTlEyb1NrVXJ6bjFYcWwycTc5Y1NV?=
 =?utf-8?B?c09VQ2s2Nk4wMDBrcXZaVnlkWVlSdnFYUXFkQzR5YnU1aTlnano3VEtMaWRW?=
 =?utf-8?B?TTBWc2RNOEhqMlc1eFV5VHJZV3psS3c5aVFGb0tFTFRZWFJGcFhDTTNKQXVa?=
 =?utf-8?B?ZEdwWFEzaFhIUTJZRW90TDFOelVkZUVYR2JxWm1TRDRrcjdvbnpSMXBQZjRt?=
 =?utf-8?B?WXFKMGVUK3ROY1Z3ajgyemkzZm9VNDVpQVhjb0Y0Y1JmcGQwb0pBMjJmWHVa?=
 =?utf-8?B?TmMwTTJHUnp5SXlCcGZXNGxiaFhxdWN5akI5REk5UzNUSHdXemtlc2Mzbmtz?=
 =?utf-8?B?K0hNeXREM3hLSW02VHMwbHEzOEt6bjV3R1hBc2tnOVZ6Zzh2Nnh4Z1dFQkQx?=
 =?utf-8?B?ZGVUUFBjKzl2ZGVpT0RqRFROUE9nNVVINXdweEhsZkEvT0xpY2N2bkNLU0FY?=
 =?utf-8?B?em52RjcyUjBsUDJlbFF4cGhrdE42SGtFKzBEV3RiQmxpcEY4K0xYTWp0enh0?=
 =?utf-8?B?d2Jzb3ZjRnZQNnVrZ1ppVkRxdWxWTk04UURDVS9FTnhoa0JLRkVoTDd1NEtT?=
 =?utf-8?B?d0xUTCtMU08zV0dZc1dXZVlDZHcyVUFuVXVVUlBzME5Fb3BYVlpqZTlUejFu?=
 =?utf-8?B?QmtKbHRoZHZMbW1qY1dySy9wMzlSVGxFbWJMdVBJaDJLbXBpTmUraDBySDdX?=
 =?utf-8?B?anVKU0NEMGtHWHI1V2VVSXZKb2JiRFhmdTFZK0tNVTdUQlBRQXZyZXVVRHdX?=
 =?utf-8?B?Ynljdm5LcWUrTkdkY2tRYWtRYjJGQWVranVjWG9PNmhEKzV3N21rdm5acXVW?=
 =?utf-8?B?RWcvUk4xRXBidnBEbzFKYi91ZEpHQndiZHRpc015TGhRYjJSMklQUTJMYnl4?=
 =?utf-8?B?RUJoVmNleUpvMnVRa2VDWGZmbDQxUkpibnNORVN6S2UxOVlzVW0yTHFITEh1?=
 =?utf-8?B?Ri92R2hzK29jNjNqeGdvRTZaQ1JPZnh3blIxWjJXeUtlUHlXNHZCNUtUclVF?=
 =?utf-8?B?Vk5qdWZ2c1RDNUp1SWRXRE5pOHRWQ090SDhzUXFQNVV2QWp6c1JZVEVpSE5E?=
 =?utf-8?Q?ozSqGgcQtoqNQddCn3LRm8RHz?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ae6d28-0ba7-416c-5a28-08dd97afaef1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:04:56.8222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vi2COFyQv5gwpTv448kbl/ysJZv1j+CYqF6qyfZOrf1MK2cjs8LCwkmFOR25ytY9Wg4Q8pi4XjNaI7ZptRrs5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462
X-Authority-Analysis: v=2.4 cv=HZoUTjE8 c=1 sm=1 tr=0 ts=682c9a1b cx=c_pps
 a=UtaLnOzkojfj4BVWksq/2g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8
 a=vhHEnE-nI2wpHcbFAcgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfX2hLcMUho6yAW
 LvlbI1b8WL806UnrbyIN09tZQtzwB7DrJBRxBLOc8gOWgIgAk86fN3chAollfIgTMK7uIdHP351
 6lD5Jrj3UsIsJNGIxPNr4fPxoHkRAbxzymGjmf3T2ww1WvHs/gMnlWGD1bzX+WOtSIlzkkyBun/
 oOmAIpv2Fj2EAmCKkp3BbwnyAgEDOFJTVj58eDymR0GreFzOFGYFhHk+9iGjrt4uyjJg6A5pxHM
 ICk1rE78suG+eSXPc4VWmtdSBSslAIJfTXtghnlYLrJzP1ku1Oo8TMQ/zzdxIMWl/vDE74Tw6+e
 0lvd+e6oVQvurn/AUMWj0XzQel/P4ZSpViNpc/etW7lsaK1Fj3FbYn4sGoZCC8Nnk8ocjsASZo2
 HJNEq4khpNlon0W5QUBlGXSkhc+hkEzSO8X/lmeQVxDfSVmOOFmrsxAhZpJC6BsPwZk6SQYC
X-Proofpoint-GUID: Gj_DUGR89tg30x0TW2qG8e7aPYaEfxgB
X-Proofpoint-ORIG-GUID: Gj_DUGR89tg30x0TW2qG8e7aPYaEfxgB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Introduce the vfio-user "proxy": this is the client code responsible for
sending and receiving vfio-user messages across the control socket.

The new files hw/vfio-user/proxy.[ch] contain some basic plumbing for
managing the proxy; initialize the proxy during realization of the
VFIOUserPCIDevice instance.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.h          |  82 +++++++++++++++++
 include/hw/vfio/vfio-device.h |   2 +
 hw/vfio-user/pci.c            |  17 ++++
 hw/vfio-user/proxy.c          | 165 ++++++++++++++++++++++++++++++++++
 hw/vfio-user/meson.build      |   1 +
 5 files changed, 267 insertions(+)
 create mode 100644 hw/vfio-user/proxy.h
 create mode 100644 hw/vfio-user/proxy.c

diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
new file mode 100644
index 0000000000..60fe3e0b6d
--- /dev/null
+++ b/hw/vfio-user/proxy.h
@@ -0,0 +1,82 @@
+#ifndef VFIO_USER_PROXY_H
+#define VFIO_USER_PROXY_H
+
+/*
+ * vfio protocol over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "io/channel.h"
+#include "io/channel-socket.h"
+
+typedef struct {
+    int send_fds;
+    int recv_fds;
+    int *fds;
+} VFIOUserFDs;
+
+enum msg_type {
+    VFIO_MSG_NONE,
+    VFIO_MSG_ASYNC,
+    VFIO_MSG_WAIT,
+    VFIO_MSG_NOWAIT,
+    VFIO_MSG_REQ,
+};
+
+typedef struct VFIOUserMsg {
+    QTAILQ_ENTRY(VFIOUserMsg) next;
+    VFIOUserFDs *fds;
+    uint32_t rsize;
+    uint32_t id;
+    QemuCond cv;
+    bool complete;
+    enum msg_type type;
+} VFIOUserMsg;
+
+
+enum proxy_state {
+    VFIO_PROXY_CONNECTED = 1,
+    VFIO_PROXY_ERROR = 2,
+    VFIO_PROXY_CLOSING = 3,
+    VFIO_PROXY_CLOSED = 4,
+};
+
+typedef QTAILQ_HEAD(VFIOUserMsgQ, VFIOUserMsg) VFIOUserMsgQ;
+
+typedef struct VFIOUserProxy {
+    QLIST_ENTRY(VFIOUserProxy) next;
+    char *sockname;
+    struct QIOChannel *ioc;
+    void (*request)(void *opaque, VFIOUserMsg *msg);
+    void *req_arg;
+    int flags;
+    QemuCond close_cv;
+    AioContext *ctx;
+    QEMUBH *req_bh;
+
+    /*
+     * above only changed when BQL is held
+     * below are protected by per-proxy lock
+     */
+    QemuMutex lock;
+    VFIOUserMsgQ free;
+    VFIOUserMsgQ pending;
+    VFIOUserMsgQ incoming;
+    VFIOUserMsgQ outgoing;
+    VFIOUserMsg *last_nowait;
+    enum proxy_state state;
+} VFIOUserProxy;
+
+/* VFIOProxy flags */
+#define VFIO_PROXY_CLIENT        0x1
+
+VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp);
+void vfio_user_disconnect(VFIOUserProxy *proxy);
+
+#endif /* VFIO_USER_PROXY_H */
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index a23ef4ea13..09f1a21bf8 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -46,6 +46,7 @@ typedef struct VFIOMigration VFIOMigration;
 
 typedef struct IOMMUFDBackend IOMMUFDBackend;
 typedef struct VFIOIOASHwpt VFIOIOASHwpt;
+typedef struct VFIOUserProxy VFIOUserProxy;
 
 typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) next;
@@ -86,6 +87,7 @@ typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) hwpt_next;
     struct vfio_region_info **reginfo;
     int *region_fds;
+    VFIOUserProxy *proxy;
 } VFIODevice;
 
 struct VFIODeviceOps {
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 181fe0f02e..f77d0e497d 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -14,6 +14,7 @@
 
 #include "hw/qdev-properties.h"
 #include "hw/vfio/pci.h"
+#include "hw/vfio-user/proxy.h"
 
 #define TYPE_VFIO_USER_PCI "vfio-user-pci"
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
@@ -46,6 +47,8 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     AddressSpace *as;
+    SocketAddress addr;
+    VFIOUserProxy *proxy;
 
     /*
      * TODO: make option parser understand SocketAddress
@@ -58,6 +61,15 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         return;
     }
 
+    memset(&addr, 0, sizeof(addr));
+    addr.type = SOCKET_ADDRESS_TYPE_UNIX;
+    addr.u.q_unix.path = udev->sock_name;
+    proxy = vfio_user_connect_dev(&addr, errp);
+    if (!proxy) {
+        return;
+    }
+    vbasedev->proxy = proxy;
+
     vbasedev->name = g_strdup_printf("VFIO user <%s>", udev->sock_name);
 
     /*
@@ -103,8 +115,13 @@ static void vfio_user_instance_init(Object *obj)
 static void vfio_user_instance_finalize(Object *obj)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_pci_put_device(vdev);
+
+    if (vbasedev->proxy != NULL) {
+        vfio_user_disconnect(vbasedev->proxy);
+    }
 }
 
 static const Property vfio_user_pci_dev_properties[] = {
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
new file mode 100644
index 0000000000..ac481553ba
--- /dev/null
+++ b/hw/vfio-user/proxy.c
@@ -0,0 +1,165 @@
+/*
+ * vfio protocol over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include <sys/ioctl.h>
+
+#include "hw/vfio/vfio-device.h"
+#include "hw/vfio-user/proxy.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/lockable.h"
+#include "system/iothread.h"
+
+static IOThread *vfio_user_iothread;
+
+static void vfio_user_shutdown(VFIOUserProxy *proxy);
+
+
+/*
+ * Functions called by main, CPU, or iothread threads
+ */
+
+static void vfio_user_shutdown(VFIOUserProxy *proxy)
+{
+    qio_channel_shutdown(proxy->ioc, QIO_CHANNEL_SHUTDOWN_READ, NULL);
+    qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx, NULL,
+                                   proxy->ctx, NULL, NULL);
+}
+
+/*
+ * Functions only called by iothread
+ */
+
+static void vfio_user_cb(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    proxy->state = VFIO_PROXY_CLOSED;
+    qemu_cond_signal(&proxy->close_cv);
+}
+
+
+/*
+ * Functions called by main or CPU threads
+ */
+
+static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
+    QLIST_HEAD_INITIALIZER(vfio_user_sockets);
+
+VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
+{
+    VFIOUserProxy *proxy;
+    QIOChannelSocket *sioc;
+    QIOChannel *ioc;
+    char *sockname;
+
+    if (addr->type != SOCKET_ADDRESS_TYPE_UNIX) {
+        error_setg(errp, "vfio_user_connect - bad address family");
+        return NULL;
+    }
+    sockname = addr->u.q_unix.path;
+
+    sioc = qio_channel_socket_new();
+    ioc = QIO_CHANNEL(sioc);
+    if (qio_channel_socket_connect_sync(sioc, addr, errp)) {
+        object_unref(OBJECT(ioc));
+        return NULL;
+    }
+    qio_channel_set_blocking(ioc, false, NULL);
+
+    proxy = g_malloc0(sizeof(VFIOUserProxy));
+    proxy->sockname = g_strdup_printf("unix:%s", sockname);
+    proxy->ioc = ioc;
+    proxy->flags = VFIO_PROXY_CLIENT;
+    proxy->state = VFIO_PROXY_CONNECTED;
+
+    qemu_mutex_init(&proxy->lock);
+    qemu_cond_init(&proxy->close_cv);
+
+    if (vfio_user_iothread == NULL) {
+        vfio_user_iothread = iothread_create("VFIO user", errp);
+    }
+
+    proxy->ctx = iothread_get_aio_context(vfio_user_iothread);
+
+    QTAILQ_INIT(&proxy->outgoing);
+    QTAILQ_INIT(&proxy->incoming);
+    QTAILQ_INIT(&proxy->free);
+    QTAILQ_INIT(&proxy->pending);
+    QLIST_INSERT_HEAD(&vfio_user_sockets, proxy, next);
+
+    return proxy;
+}
+
+void vfio_user_disconnect(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *r1, *r2;
+
+    qemu_mutex_lock(&proxy->lock);
+
+    /* our side is quitting */
+    if (proxy->state == VFIO_PROXY_CONNECTED) {
+        vfio_user_shutdown(proxy);
+        if (!QTAILQ_EMPTY(&proxy->pending)) {
+            error_printf("vfio_user_disconnect: outstanding requests\n");
+        }
+    }
+    object_unref(OBJECT(proxy->ioc));
+    proxy->ioc = NULL;
+
+    proxy->state = VFIO_PROXY_CLOSING;
+    QTAILQ_FOREACH_SAFE(r1, &proxy->outgoing, next, r2) {
+        qemu_cond_destroy(&r1->cv);
+        QTAILQ_REMOVE(&proxy->outgoing, r1, next);
+        g_free(r1);
+    }
+    QTAILQ_FOREACH_SAFE(r1, &proxy->incoming, next, r2) {
+        qemu_cond_destroy(&r1->cv);
+        QTAILQ_REMOVE(&proxy->incoming, r1, next);
+        g_free(r1);
+    }
+    QTAILQ_FOREACH_SAFE(r1, &proxy->pending, next, r2) {
+        qemu_cond_destroy(&r1->cv);
+        QTAILQ_REMOVE(&proxy->pending, r1, next);
+        g_free(r1);
+    }
+    QTAILQ_FOREACH_SAFE(r1, &proxy->free, next, r2) {
+        qemu_cond_destroy(&r1->cv);
+        QTAILQ_REMOVE(&proxy->free, r1, next);
+        g_free(r1);
+    }
+
+    /*
+     * Make sure the iothread isn't blocking anywhere
+     * with a ref to this proxy by waiting for a BH
+     * handler to run after the proxy fd handlers were
+     * deleted above.
+     */
+    aio_bh_schedule_oneshot(proxy->ctx, vfio_user_cb, proxy);
+    qemu_cond_wait(&proxy->close_cv, &proxy->lock);
+
+    /* we now hold the only ref to proxy */
+    qemu_mutex_unlock(&proxy->lock);
+    qemu_cond_destroy(&proxy->close_cv);
+    qemu_mutex_destroy(&proxy->lock);
+
+    QLIST_REMOVE(proxy, next);
+    if (QLIST_EMPTY(&vfio_user_sockets)) {
+        iothread_destroy(vfio_user_iothread);
+        vfio_user_iothread = NULL;
+    }
+
+    g_free(proxy->sockname);
+    g_free(proxy);
+}
diff --git a/hw/vfio-user/meson.build b/hw/vfio-user/meson.build
index f1fee70c85..695b341547 100644
--- a/hw/vfio-user/meson.build
+++ b/hw/vfio-user/meson.build
@@ -2,6 +2,7 @@ vfio_user_ss = ss.source_set()
 vfio_user_ss.add(files(
   'container.c',
   'pci.c',
+  'proxy.c',
 ))
 
 if get_option('vfio_user_client').enabled()
-- 
2.43.0


