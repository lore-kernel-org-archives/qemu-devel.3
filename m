Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD13CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 15:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1RSr-0005hK-Mg; Wed, 24 Sep 2025 11:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1RSq-0005eG-0W; Wed, 24 Sep 2025 11:31:28 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1RSb-0006jf-J5; Wed, 24 Sep 2025 11:31:26 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58OCbllh1809698; Wed, 24 Sep 2025 08:30:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=dQZoDUK6zfdsQODoM0F0MS5fbznbshrVEfX9T5F18
 Xs=; b=NYXiAqO7vWA5u+4MMQKHR8yHh8xB34z8ilBUJOw6cdm1vPWJJCp7oFH5/
 Ms49swVlpdFIRqOsYHMR44jFeC1BUKnJDrOHOBnwoJxBuDRcDNL9WsYiUlSJZeuj
 n5tCXLppCOAENTDHgNMSgWGl0O2+6GQG8n/j+y/0CDvbJ6Rts1HEtZ2hjLGCzbLq
 hi6oicmdPt0Pcp3aA3IFRX6MEjIBFe/drb0jRikpNeMU9GXN37mXgfgyPaA3AWBK
 oYCkc7sJLDUhnOStbftDOVaq8te9jiKz363D5btt295dIgUZOMCsWL2xKPrsrpo0
 lMb9mpIrGPCNPzUzB1iFTn9EyWfiQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022119.outbound.protection.outlook.com
 [40.93.195.119])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49cgtj8e3e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Sep 2025 08:30:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqoYayWqS6ajEaRF4gZLElt18IPJAPUmH8mjGOGr+WyBIJy95MrXI/ZYy+2tzBnmU7kiiM6aVgnievmx4ONCb8xTab4G/pBzBS2RMRiKMEC39vyDW05SjyM78AzphUF3dqBMotlPYo3wpijnPTgTTza6oMGpb3gHEd6+v2ygfXnq1NpvoTozuhK09QBO7dp8pgrwnq77lqSzk5/00gv+JwhBsjnNCJvgLaRbpqkq5dvtos1MNHjixQZ+uf98ndeYYi/nLD4QnSK11tiDZcs0yUlrjJgHHW7xy8rfgApNfRT1Rrn8FDEcTDE4z8+FwMhP1xkmGTD/UzP8i+RM/S1Xtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQZoDUK6zfdsQODoM0F0MS5fbznbshrVEfX9T5F18Xs=;
 b=ZiIDp1sugpQxOVCu2nIF5cgHZm5l5VbAgygWqURe287F4to9w0N3XVnscGGhyjoeq4Krhy9E3Eit7I9TiKa66PQuFLwODoj3vB+SxTRWPG+YjPE7eloHx2bbBiRptzNLG+ItpSOQHThZT/FC8kTsvYoW53bhYUM2iWtoSpH6vhkjjKwfeguYGVCGF5R5/cpnQU3FfIsdkAuv2iHZzyiNNTBxVhT+XKO6T4JhXMTe4/G5RKFXPkmNXuplBUmJmdev2IgfEiJ/g69fS30rc6mK2qgxv8OnUPpBIc80VK9NSx9ULpu0dkHxrkAmJ+hRpQeYKnbiOjzKQPoMubeOjLK25A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQZoDUK6zfdsQODoM0F0MS5fbznbshrVEfX9T5F18Xs=;
 b=c8o8TVaZqGV8/OY9SX0gCS4AgOkTiFViFhlXBfWPWDpWMh/zGhNJ1PfAbJR0gy2ItN9og2y24coKm4SvT0JcHdYz+TRlvUmn6aiIfA1QdzENlHKFqJUQ8OWsHwEh8+UPY3kSyST9quLY8zSc/Reek4TzqYZqZOAxOKo/p27Np7hR5j9/WOpiw/NNoPGihzq4fruvvGDQXrIoe/cB6EM3DIBroO1oC0N/2e7WhY8bB0H7eieoAaO+UKF34BO3WxQqkBzcTz5/EGOVSUAChtT30MXn+1KdHkRR7NvjZjXCo1cGmc4FO+7EYzI/cDQAgdr12rh4q+4/rlYjUo06QR+0mw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BY5PR02MB6625.namprd02.prod.outlook.com (2603:10b6:a03:209::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 24 Sep
 2025 15:30:35 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 15:30:35 +0000
Message-ID: <908641fe-1c42-4cbe-bb28-8beb236616ac@nutanix.com>
Date: Wed, 24 Sep 2025 16:30:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/27] include/hw/vfio/vfio-container.h: rename file to
 vfio-container-legacy.h
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, npiggin@gmail.com,
 harshpb@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
 <20250923135352.1157250-4-mark.caveayland@nutanix.com>
 <b4d724c3-321e-480a-a17a-3755c383e8af@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <b4d724c3-321e-480a-a17a-3755c383e8af@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0128.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BY5PR02MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e0f9720-45cc-46f4-42da-08ddfb7f4e4d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|10070799003|1800799024|376014|366016|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STNGZU1YRkFCMDRUREM3NDBQc3M5N0J0OHZXL1Y5bUJCeXhtT1ZwbDF3VGUv?=
 =?utf-8?B?bmhxS3pHSVdqL3hUd1ZlazllZTgzYkNjRnNIQjNNZGx5Vzc2QVdpd0NXQytY?=
 =?utf-8?B?d20vS1c1ZDNpUXdxYlF6aEFsVGpHYWVJNURReDFuckl4TEQvcHNISEcyUFdy?=
 =?utf-8?B?b1FMVmtYd1YxYlQzZGFFcUkyVzJSTVB2b3h6eitVenk0QWNlSC9HOFE2SlFX?=
 =?utf-8?B?bEhxcWUyMFpyNHFXR2pQLy9lbFh1bkw2Ukl0ZSttUlRHZVUyMnp5L1JPVnlY?=
 =?utf-8?B?czZlbEJCaHc1MCtZT2hpcndqT21iSXdMdGhDa1lqZkl2UkhMM3BSZk94OE9Y?=
 =?utf-8?B?T1JRWGUwY1F4TEFvenBBdlB4eHdNbzIwMDNxeGdGYXBtM3hxa1lOazJnd09s?=
 =?utf-8?B?UnpyVm8vU1pxS0JiU2tOdldFWjZxeHQ2eU5sV2lWLzUvcDc2ekROSDc0elpx?=
 =?utf-8?B?c2UwVTFlRU0rZjh2ZUtTZkVsVEFBM2p5T1J6SGRNT1hrSXQ3MENWSllaTXFx?=
 =?utf-8?B?UW9vbC94c0xFTnM5dHZweXZDY0IwRzFNRDkycTc5REtuY3c5NVZOV0liNWRP?=
 =?utf-8?B?ZFFCbDdxUlAwelBGR2VlZ0dudDZiRUxMV2d2a2pIbnpzSXk3bnF2cEdiclVF?=
 =?utf-8?B?U3pHWXA2cC9VMlhEaFRBbzd3akcxWmhpQjQvTHppdEFDQWZ3M2tjNWxTOXp2?=
 =?utf-8?B?SGJ6NjY3YURGdnJGWDJCMVg3WENEaVVGemxlREYzSmd0M3VwL043VkdSTTc2?=
 =?utf-8?B?a3F2ZEVUWnc3akg0cXB2OHBNalUzRFFEUWNvRGNoTDYrY2lLQi9JRGN3aDRN?=
 =?utf-8?B?WUc2MXprWjBzRDIvNy9vNzVHdFpJaUZ6QzcwbjBPZ2tvQ3l0TVJXN3NYT05T?=
 =?utf-8?B?YnRSTVlCS2tvaEdnN1Q2SUVud2xSbzhyYzVDRW84Q3cxemRsWGdaMEU4RUJY?=
 =?utf-8?B?a2VZYmZId3RSUncrUjhpS1NnNjJhOStZNUNWK01yeXlxV0FXNm1rUjlLVWdK?=
 =?utf-8?B?ZTdOdTlhVTZkZ2l4c1FyR2dUWkx5b05SSmp5RTZrQkVnbS9nbWVwbjh5OHJo?=
 =?utf-8?B?QTZVdDZHdzJGczNnNUJ3dnFRMW5PRFdjY1lUV0JCazdBdVZaa3htUElwdEh6?=
 =?utf-8?B?Yzh4NlhKTktwOE00bDMxWEd1MFpqWXQ0UXBNemwrT1ZHTlhuVit5UDdJVTNB?=
 =?utf-8?B?cXN6Vkhyb1dMbDBFREtXd1lwSnhvcVRzMU5xV0RKUUFXZDI1QVJMRG1EOXBZ?=
 =?utf-8?B?OXhGbG1zYnBYNit4TktsdCt5WDRhaWhqRTJ5Kys4ZkFJOHJkQmFOS2ZuWGNC?=
 =?utf-8?B?S0FzeVEzbm1mN1h3T3VDQklmd0UrMDJYdmxZdGo4QUNLYjdrd04wUXF6VkRG?=
 =?utf-8?B?Z2NHSUFadVNpQ0pJT2kySVNLd0p5Wmx4dGVTNXp2M1oxdlNDMGtudWhEeTlx?=
 =?utf-8?B?eTZSWWsycjAvMU5Ga2xrc21pSS9CT3VvaklpcjcvN2FvbU9FTTlIL0JPZ0pO?=
 =?utf-8?B?VHh2RTdWaGZ4ajBSQ1l6bG9qc2Q0UWFqblU5TjYyT3diQ0dJWk9jRm8wS3o2?=
 =?utf-8?B?TWVKRmNwTllWSUYwQ1VRY0t2SzYwVGpYbUxoMjJIRVo4RGQ0Zkk2US9zdFl4?=
 =?utf-8?B?NHYyaEdnL3dyMC9YeGdMaHdkaFRCeWNtUC9HcWtwaWJpTWZvcWNSaUlWNVBy?=
 =?utf-8?B?NGdoZEZMUlhMcjJoMFRnY3hkUU8xc3drc3k1SHVoRFFxSGlCM05KamplcDJm?=
 =?utf-8?B?N254NmE4L1BmWEhSQjBzNmlRVEd3a0trMG9wRzJqWmkxeEZkd01kMmhNTTY0?=
 =?utf-8?B?K0lSMC84MWlxVTVndE15TXU4dDQ3K2tSd05ONmZ1amZ1K3VaZ1BoQjNhOG1C?=
 =?utf-8?B?YmEwZkMyWjh6WWNUMTdNbXBvZGhGcWl1dnBHenpWUnpURVovSFI5dHNLa2NE?=
 =?utf-8?B?RE9obWxsL0FIb3ZHRjhibUdZenhvZkJQd3o4WXNRaGcwVXpHZ2svMSswRkU0?=
 =?utf-8?B?UXNXbW9aWUVBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(10070799003)(1800799024)(376014)(366016)(921020)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmVjdXFXUUErR1pocGZkS05odWlzL1N3bEk2WWd3cTlRbEtQZ3Z4TVc5RTlu?=
 =?utf-8?B?eTBKS203VTBPWlJpblR5N25uTXlBaGVmVnVKSHdmWmZQTWpmVElvTWhzZWVN?=
 =?utf-8?B?OTFIWTdYMEFpVnF2VDdhdVE4clBzZmNJZUhEN29jc0lWYWgrZjlUTzlTY2lN?=
 =?utf-8?B?VnA4TjlUbk5YQWozdUg4Z21XZnJsQTYzYzZNRGRYME5adHZJQXVBMjNHdERz?=
 =?utf-8?B?VFNobHluWDRQWmNjdHZDdU1vWnNTenhzYmkyOCsyMWJNckJZOURRWW43ME1I?=
 =?utf-8?B?SjI0WTlWVTFOL3VoQmtUODFqZHRXT2ZWY2xDZzVCVnhFY2pTS3dOcTVNRUhX?=
 =?utf-8?B?Y3BoZHlLYU1iKzREbVZCQWdiZVI1YXRwaTdjM2NIMSs1c1Vsb0QySFl6RTN5?=
 =?utf-8?B?QTMyRjMwd2F2eHRicWtENTR4SkhaWStWTFJLbTNxdThQT25qN2hMckpOYU5x?=
 =?utf-8?B?ZVM1U1dIcjJJWC9pRCtremxZQlVQVnQxM2tRZ0x3MmZjY3UzOWwyTVZaN1lI?=
 =?utf-8?B?aFJrdmttQnZ4dkMrK3kzditPS29RazlQc1g4THBKeHBaWm1Xd2Vwd2lKVHoy?=
 =?utf-8?B?UVl3dFl6T0pDM2U4cnJtM1Uxek16T3NQbnhNb25PUXJQdDJpUDdEZ1JWYmF4?=
 =?utf-8?B?KzBNSFVQbWtVVVUzZ1NQMmVsd083dUM0bWE5SXFWdDU1YmlraFNSdkQvd3ZR?=
 =?utf-8?B?VUZheEFWN0FaNHBRb2hvOWg5NUNzd1pCaDR0Rld5RDM3TnoxK0c2dmhMNzcr?=
 =?utf-8?B?ZmZwZVBlZG1OWTNjY2hRemxZTU9HVjQxSDh6dnhFWlBNbXpYaXpBS3BBclZt?=
 =?utf-8?B?SUo0TUtYeGVSZzBVSlcrOEFqY1BaSitkQ3pVWHBkcmVnNnNPRWdOdlJoQnNO?=
 =?utf-8?B?c0xQQ1hMSUJYWnJFZ3pFVC9Jd1BhMDNTSTdDU1BTNWpzSGpXYTlyV1JpTVB0?=
 =?utf-8?B?b1liZ3NhaWJNS2JXZE42R0lGUURpU1FYc3VkMTZiTUUvdUN2WTUxYk5RR01Q?=
 =?utf-8?B?RnJYd3g2V0xqV2c5OW5kVUNSSjUzd0ttS1p1bkU1bTRBMnNHektFWkc4VGoz?=
 =?utf-8?B?SUpIRXpQREhuSkdHL0VnRHNJZU1zUWxjbEwxcnQwdGIwUFU4QzJwaWVUakRN?=
 =?utf-8?B?RU1Gblp3VGRFUVJMMmxVTzF3TzJGTFZOQUprTDN3b2NQRlNLQnFRTldpR2pu?=
 =?utf-8?B?OEZZSXR2c2QwaWI5dENTZS9UeUIyckIrUXlDR3RCME0zc3VQR3pyU2t4T1JY?=
 =?utf-8?B?MmhTanBLZ1hFWGppWnRZdmJnNnBxYlZIZTlTcnpTeExZMEw5ZEVHWVkxM2lQ?=
 =?utf-8?B?ZXU0MlNmNXB3UVBDazNZaUpWcjJxVUVyT0laZVdENWk0ejZMMG5xQjRPYlZp?=
 =?utf-8?B?VU1Jd01EZXhoR2pwQ29xTWhVeGVVa2xlYnMzUjZvTTZ5S1pWeS9GM1UvVnIy?=
 =?utf-8?B?OEJpQUV6MHNWejRXeDlUb3haMUNRZm5ETVZVVjZDbnBWYTdnRTBJWmpzb0I4?=
 =?utf-8?B?cXpWOCt0UUN6WERlWGlCOXpyUE14cHJCK2hUcUp2dWlzYVIwNEpUWmlYbi9V?=
 =?utf-8?B?eWNQajJCbWF6K0JnUmE0aEI4NlhQa1pMWlVEN3ZDRy9WTUJ4cW43VmFMK0xu?=
 =?utf-8?B?UjBNZHFMZDJDVFc3QytLQkphTjhJMHBydHZKS21STUxhaUxTS3B2di8wNEp3?=
 =?utf-8?B?bHpiZFdVbGlFWGY0dk1BVXdNaGJmUXlNNk9US0loYlYxOGJBOXlSbXpXS2Rm?=
 =?utf-8?B?ZzRXS1RuZjF2Sk9ubDJkdUpIQzN0QnpSZStsaG1mZWFJN1FVZDdUMWx2blhN?=
 =?utf-8?B?TXZkeEJqMmt4ejA2Nk9rQ0l5a3ZmMm1uWm1mWWhzcEcxUjA3bk41NVQrODVr?=
 =?utf-8?B?QXpid0J2S3htcU9SbDlMZGVVRm40NCtUd2YvTnhxVWZ0SkowbS9ISGh4RTFC?=
 =?utf-8?B?MGNxK2l6SUhMcnJrd1JzZURvWU5pTStSNVA3em1NSkFZQllRQktocWxyTFdp?=
 =?utf-8?B?NXBvN3pwVk11ZDB1S0xXYkdNaXc4UUd1b1JlbXNnS1hFZzJGRmorcEx5RlY2?=
 =?utf-8?B?SHBTZ2MySk00alBmcmJHNlgyNE9HVnRnUENHcERGYkVqSkpMY3U1VGE2ZHQx?=
 =?utf-8?B?QmtVK1YrNUNJMFJtaTI4aHhUeU5pUUxXVlIwVFBsVDVWZGJrbnJJcGVnT2VW?=
 =?utf-8?B?Yk9GY0UrcHFwNk0rQmN6TXRQLzhtREhGY3BGTDNDSmhoZ0V5UmZWNmgveEs2?=
 =?utf-8?B?WFc2VGZMMVZRdVkwTXlMZEZWNmNRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0f9720-45cc-46f4-42da-08ddfb7f4e4d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 15:30:35.2157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tsfs5uOkEN8MDrZGpGX6/htGvemXTer73Gn6x1BZO61pN2SdmN1K2Ewgk1XEBAVCS1IZhcwHqr1LfQcNPic8XRhcj1VQ+cdZaw26Ulgp7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6625
X-Proofpoint-GUID: ZYn5SxcazgJWqbkg9FGuPc_M7Z7V8FHc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI0MDEzMiBTYWx0ZWRfX7wUm7sxEUF4O
 C3is5i8Y89ZyyHiRYMw5APPk0St/eHfz+CVWsGJGt/ioVxDUg7zZDHzNyiXAU2C73Z+HEEbZX1a
 dssRwCXcN6a0ivh1aq3piFQ9htxHikIAQIl7uRk4lwXN8bcEW08Endb0/m0XA1t9EyjwIIMqGxT
 3Mkr1qdTPJp35BvQunV4HM4tqeEiKQXQ463rbUWFToLqYdipp8C32VMscJupz8vfvLEKGrSMJDk
 kvDZpms9400doDvpU4EHN0w95ll7GF9QfQuAJHITV0iS61pBZUCjtvNBazhie5FqJGSDynhDaly
 bnimCW8a8GIi+rHn8Cy04eGzQC3p6zoKnWf4hkYuL8g5zN/RE7x3YtHxRpfqKc=
X-Proofpoint-ORIG-GUID: ZYn5SxcazgJWqbkg9FGuPc_M7Z7V8FHc
X-Authority-Analysis: v=2.4 cv=MoVS63ae c=1 sm=1 tr=0 ts=68d40e9d cx=c_pps
 a=c7K7qtXczKOKsP5Tyt1v3A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=egsZ_N3XKpCWBgXuByUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 24/09/2025 14:54, Cédric Le Goater wrote:

> On 9/23/25 15:53, Mark Cave-Ayland wrote:
>> With the rename of VFIOContainer to VFIOLegacyContainer, the vfio- 
>> container.h
>> header file containing the struct definition is misleading. Rename it 
>> from
>> vfio-container.h to vfio-container-legacy.h accordingly.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> 
> 
> Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks for the series reviews! Whilst looking at some other vfio bits 
and pieces today, I noticed that for this patch and the following one, 
the #ifdef ... #endif guard names now no longer match the name of the 
header file.

Would you like me to submit updates to these patches with the guard 
names also updated?


ATB,

Mark.


