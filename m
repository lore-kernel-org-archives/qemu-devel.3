Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362DFCA0FF9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uraXN-00084c-GX; Thu, 28 Aug 2025 07:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXK-00081B-LC
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:22 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXI-00052W-Tk
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:22 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57S7hYMs2893263; Thu, 28 Aug 2025 04:11:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Vm0v1DVf9N4uvuZ8H0+MDFCY7nHayO+0F+irSwbHI
 t8=; b=MwE+XjsNTqQVZPQzEaiZCciBLwZoXKBBKgzYuuG8T+DmoU/CIpJ9pKMRN
 jIBCRbF0bqlLmZgu8ncJoM3c5xMHAA1d73jM1pafIpSSR3H69q4d4TwxFaK3bU5+
 kh5xIHa87urgWeZI62GmkfWYlksmMn7ALCQpDoCgDPavjXaLWQso7aRJ7KvsaGdc
 dYNVl+zSin3XWmLkiiwdj2BYqA+wy2ZGzu6AD1FThop+g+sc+avh+aCbHluqutTk
 ef5EQWCW0vbqX3PYJr8hpCPUs2fcvpKZnLg6W/U39/D28b2swHanvUFPBVF+fB1b
 yFoDSNgjwQ8P9G34UMnpiRkCH7ekg==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022090.outbound.protection.outlook.com [52.101.43.90])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48t7sy1pfw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 04:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yh1RZ4COJTMer9wdDP6MzhcipBAi4h2Iiuw5GZA/Y3G79aLwbHet4IIRYXALIgpMRL4Zr9kTxPmtUv2TbbN9Dwu7jNPpnhUtDa56YLffgPTKZbwZ26th0nFoNjtCLdSQD8Sp+TFuJ6SWOpAjkdB5el/l+AtQDkplMSTtuIlib8o31Dv4+OcEl9g6x+XJ7zxdYikeaUbzqP+r0pk/4syJMU7H46/CzZhcFaGjLAMl/CrVMTqKQm0xNMw2VOxeiuHS+O1wPBDGOGUbc3wJWzrvAMXzUNeyGPaYhH/XzUrsWrEF2hQ7zY3eJQS3ka/1vAi8dTMYlnjiX+hyIz25UO2Oug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vm0v1DVf9N4uvuZ8H0+MDFCY7nHayO+0F+irSwbHIt8=;
 b=T85th0eyr38uhXKAM84jlhnQaTxhDX4SVhf197+ICQT7YgIGc/29pHk1EZPW++KkGMp/TOOH7cnxPR1GBSTcavsRJsS6+o1Dx40drofbu4W7wQI3JfREMPBFcmEVPu74tzGhm6X+x9xEFgArRSq2QweEqjs2NzNvvMeuzqpsyQmx3XtSyhfsdyEqJp/pIB3SJtlDA7LWGvVM4p34JSG7IdQ968+nKNBIxuYeR5dQ0RftWnDDyDFJYDFQ5jJOz515pulMckrkWZwYTD2DmiSTJ0UHDbC8EoOBRbIMQ3hyJoDMfnCoAm4Dd3YIqHYu+gtUpW6/QkBdAU6ah3DGyW89Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vm0v1DVf9N4uvuZ8H0+MDFCY7nHayO+0F+irSwbHIt8=;
 b=yQXyWt6Dq2+8SAQMna5KzcbeNQFAeUqqrAlaGpKEXWe4OGsTum/03/ay7v68D9lsUG5mBhibpezNBhl578T1VHs2ojXYgkqlHpH8IsYjhD3t5HRPCcndDYOJXp26BUHnNsfad52dl4GjBET2eDqn65g7m/3HQ/7p//GozzlMrj4R+XTv16TJZs1sBdCtipe3IL6wsipM22jAtKaoKgD6HkXDy0q7Gt/eAOrOiEJ82PNx/8NlLOuqq7WCZxIiof2MKmq4MpEdk84YU8Y0BDsP1UcZeJU8fRXK0FWl+Jl1Sd5adEQV/jY/0X4m9lL1v9YuqN9oP5DXAXPYCy6+Kr3+mQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8077.namprd02.prod.outlook.com (2603:10b6:408:149::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.23; Thu, 28 Aug
 2025 11:11:11 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 11:11:10 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v7 03/19] hw/i386/pc_piix.c: remove include for loader.h
Date: Thu, 28 Aug 2025 12:09:46 +0100
Message-ID: <20250828111057.468712-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828111057.468712-1-mark.caveayland@nutanix.com>
References: <20250828111057.468712-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR05CA0081.eurprd05.prod.outlook.com
 (2603:10a6:208:136::21) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 45237ff7-b6b6-4359-d49a-08dde6239830
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2Fhay8vNFdDcVE1eWVUbGx0WjVlRDYrcVVKZU1YclBrd1Y3MXdGcTlUaTFY?=
 =?utf-8?B?RFVvWitKN2JvMnBrYWJZT0F6eXdBSWpIV1EvZ3hlK0NNQTJqMkVKYXdYYk1L?=
 =?utf-8?B?UFVDTWh6V0V4RmRzN0lkaW9aMHNtWEFJVjlSOUNhK2cvOUdVREZOVEkwbnIr?=
 =?utf-8?B?VDRLN3FxY1dXcXlod1ZWNmFCV2pOc3RNeU01cm9tbUtCSms2ZnU4T21pbDdw?=
 =?utf-8?B?Z0h6VGpFc1A2ZVJnOWFvNk1CK3dQbWdrbW8yNnFOakdZTzNRMDJiYWNSNzMr?=
 =?utf-8?B?UWNNYktyVlVocU55TWtEL0pOZVhiVmthUmJvbzJTWDNYN1l2QkE4SU02WmtW?=
 =?utf-8?B?NGgvb3R3ZWU3Y010OFQ2Z0lISlY1bGxwUjdZd0V3Y1IrWWtkT3NMWEpKQ3ZH?=
 =?utf-8?B?aTBnQmVNbXVhUTBIMlUvWVNKT1NwTXpDdFlzY2lEa3N2MmJqYjhsTkVHZ1dI?=
 =?utf-8?B?RFBHTG1XN3pnUDdhaXp1YVRHdnlZblBJRkF6aU9yNjB1OTJMRVlEY0UxN3c4?=
 =?utf-8?B?M2ZiaytBQmszRzJKSVhYc2g1NkN4UkJJMHdibGdFNGJqa2pWRVhITWtTS1Zr?=
 =?utf-8?B?elIrZ1NIZTdqMTZoRlNaVDhXeUt2OVpNdlNYdFNMbGU3RTZlSUVJUFlFRUhD?=
 =?utf-8?B?ZEVNWlloZlVmei9MMS9pZGJXTW92NWlLN0lEZ1pDdmxUUmJ4NVY5SmRoRnlP?=
 =?utf-8?B?YlNUTWFwcUhxTld3SmpjWDhWWmJtM2ZTdjFkalpMeWxpTmZzMUZOTmhZNVBH?=
 =?utf-8?B?QnNyUUhhb3Fid3VIcUZudDBXOGVmdzBudFpodFQwVVkwL1VvNWxWS3ViOXdC?=
 =?utf-8?B?ZXQxV1NzelFqWGozejdYdlljYWZBbmhJZFdWWXVLSktSREIvRVJFdUd1YlFy?=
 =?utf-8?B?Y0tmNFR5QU5ZWXY3c1l3MEdJYjVtei9UYVlITWhRa3UyT2tGckE0VEswdUhp?=
 =?utf-8?B?OWN1Zk53QURhbEFYTWxBV2tyVk9MeVNEaDhONzY0VWgwOW0yV2RhOE1nNmd0?=
 =?utf-8?B?ckpzckVNWm9CT1hnZlBNTGtzTUhQamFMeTRGVXVqakN1VGNhUVlONHhCaUVU?=
 =?utf-8?B?aFFnNjBYRzBQS3FGVjNlajhxYlM0dmlQNkpjdUpOY2tzQWZsVmtNMy9LVFNM?=
 =?utf-8?B?OUY2dzdFUlN4TzU0cnVCTjM5TTRSekNLbTZUbGRNd0JoUjZyVHEzSlNwQk1W?=
 =?utf-8?B?Q3NPeTNFVWJPZC9YS01YVWhtN1BxZUsxSnhBUU0xMnV6dHF4MVJSVVFsUkRD?=
 =?utf-8?B?OW5jdDIwZllNbVVySjd3T1N1aEs5ME0yZjBOaG53aXdnRmZLVFlKK1JDQnZn?=
 =?utf-8?B?L2c1ODN2QVdnellpWnJXZWZzeTRONVVUK1NJeUdnL252WkV4NGdXUnE5bitt?=
 =?utf-8?B?WVRHcTBtWEg1R09UOTNYTmNoYnowKzA3QmpxRVBrU2RFaXFlZ25YVXdVbkZJ?=
 =?utf-8?B?eGNHT0hlZG1LaXQ0OUZCdzhwZzZ1VEwxNCtnQTdxdkxPbjd4aEVtd242ZWh4?=
 =?utf-8?B?aWliSC9GckpPbG1RaXJkN0tjcEhWTlV2TlhEaXMraGJ5WlB4bC9iNkFOeEJE?=
 =?utf-8?B?WEU3Y1Z0enl6bFNHWGRMemY1bzdaVkpBbTk3dVpsZ211MlVmYy93MGQwQ3Jt?=
 =?utf-8?B?enUwMUR5QlNBSjNJeHRoczR6UUpUKzNzaG05NUhZL1JCSU9yaG9NRExhWmVX?=
 =?utf-8?B?YXBUWHRtYXhyNEYzclhpQTVEaWp0d3NUMW1hUVhDR003R0V1OE9qZ1AybzIr?=
 =?utf-8?B?eHAxU1VuUlRXZWJNWnZGL1BWbkI0Nk9GRWRsenorVFM2dm5kM0hCaDlvN2VH?=
 =?utf-8?B?Y0JSenN6RlM1Zmlac1djQlBzaHhHdWFMNm9nczRTWitnMVFyTDVna1h1WDdl?=
 =?utf-8?B?U0dlYis1djJxRmIvaUhkZFFPMVJ4aTdMd0h5R1VQakFZcnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RldTWjJzLzFGS2V6c2JLOGVzNXJYRjdqeWNIZlhoL3B0MWpYWVJsVm4vSzZF?=
 =?utf-8?B?ZS85dHZ0SUlQZzR4Zk9kWTVKcTZzYkRTdmNKbjJ6Z01DZ29xZU1ueWdEc2dn?=
 =?utf-8?B?T3N5ckpaQS95MGU0TFlOUHdUNkVabW9WV0FqTmFrT1FzdkJVWExXK1Y1SHRT?=
 =?utf-8?B?cGZLVnAyMWMyRkQxV3ZrbnFrMGhOeDlLNnZsSXZrZTRkZnZXbWNWU1p2emxw?=
 =?utf-8?B?OExmNmo5Sk1XNE5wTXYyK2NOUElnUnM5di8xRC9NQkFrL1h5Q1NiVUl2aHk1?=
 =?utf-8?B?TG9OWWk5KzEvaWt4REVYMjVjbXNLOWkycTRqSGN6V3R6ZmVQMzA4UFBubjZV?=
 =?utf-8?B?TFlEUHlZVncrTDhIMHE4Z3JNc0lIRGhrUGNIMU9BOEZIMkZ2a2N5OHFwb0xK?=
 =?utf-8?B?TUpHOVB2cjdEcjFwVFdUc2JpTW9LV3paNWJZL1BveVJCaDZQQUZtMHV5Q25r?=
 =?utf-8?B?Q0Z2QXlndjA1N3Fpd0xpVmxidUxsbG5ld3NETmNLcHgvUFV0ZDRtYWtHYlNP?=
 =?utf-8?B?aFFaSC9CZm5YbGJaTUFGTklIcm1tZ0dNcThtWEJMd0FMOHd2dzhaeGxuSGwy?=
 =?utf-8?B?SytYbzk0bUNwNGxMdi9sbXpPZFA4em42YjBwa29BM0swZ3NiTDY3MUU2U0hh?=
 =?utf-8?B?SXJrU0Npeks5WWZlcFBLb1dBbzRKN3U2cE4wZjR4eDZuQmJJWTQzd1R5RnNr?=
 =?utf-8?B?dmt3ZHhsSVh4RVFZMmN2cWdEdlVLWlVkcS9YanQ2Rklwd2VIa2dFL2ZObG5j?=
 =?utf-8?B?ZmlMeEFDM2tDekVUMHc5VVZXS3JxK1IwMUxCcit5UXN0eUVNbmJpWjNFbEFn?=
 =?utf-8?B?NGZYTCtGSkJwSjNhNEVWSUlqemt6Mmh2c2x3RmdDYXEyZnA2VzZNdHF0aXVn?=
 =?utf-8?B?b1pkSXNqbmkxbVM2K2EySHRDRmFMSmdseEllYXhtWnVlMGZ2VGhJNmRrdjdS?=
 =?utf-8?B?YlNhcWNIVk9PN1orTjMvelQxMkhlcUE3RXlmclpud1N4ZE1yZDRHS1hVZ2Rn?=
 =?utf-8?B?c1VCNWpFUjFJdytNU2Z1MmJ2K3k2RXR5OUNUT2c1SXZ5bmJ2QXA3TTcvWGYr?=
 =?utf-8?B?a0hzUHhhMDZybEtzelhPV2ZzbmF5ekJlL3J2RExHeGJhdGVTV1VBNWMrUG1h?=
 =?utf-8?B?Mm40alByUGJsL2Y2Zi9RQkRUdVBERUVHZDNJbUZNV3orTkdWclhlc0xQYlJz?=
 =?utf-8?B?Y3F2TnBydzBXUVBrdkFzVWF3OC9iOHRnNEVXeHdXMDNFM2xRL0NZbnI3ekRG?=
 =?utf-8?B?RzAxTFNGdERwS3hScjUySnFjck5PNkxCbDJudGxLbTVLVGRnVG5zWWlWUWZP?=
 =?utf-8?B?aE5oL0pIQTFTcVcwcFd0REczTnEwYmpYK0UwZm5hY3NWSnpLaXo2Nm9ocE92?=
 =?utf-8?B?UXlOSDdjUW9QSmlQZnZRTnl5NVFGem1MbFFPOGR6S0VYUGRFRWs1MDdQTThZ?=
 =?utf-8?B?SWw1bHNtVnhGb3R6QVAzc2VzSUpSY2ZDQmo3ZzNwcW1ZVFd6SkFMdFhwbS9n?=
 =?utf-8?B?Q2MwbDZaNGRQdVptZ3k4VWV4ZWpibkFGNVF0UWxmTmo5azJmek45YlVZNmxM?=
 =?utf-8?B?Vkw1OUgxbGtYL2tzRWU0ZEpUYThPd0VtMHdMN282b0pDNTJBVHVBZFkxYzFk?=
 =?utf-8?B?TTdhZHVadkFqOEw2bWRyTmdVVUoyREgyRGdQVTkzeUN6OFpMMm5Ta3p6YTV3?=
 =?utf-8?B?VHlXalRmRUJjZUhJUGVVWkh1SGdsZEp1NUpEVEhjYU9kNVRQUjAvSkpZeE1m?=
 =?utf-8?B?a1ZsZUpqNHdoOGhMQzAvMHVXN0xxaUJrR3B6WGY1dkxUQldXZ2dNaUovOE5I?=
 =?utf-8?B?d3lxT2ptL08yT09CMk5nTDNIWitsMG8wOFJVUjQ3SlhLZjBLeHJQbkJuMzR4?=
 =?utf-8?B?MVFqbVI4WGUyTjZTZUNPeFpVQ0hiQnFjbkVYaXRjbWFYbUQ1Yzd3VEI1alBr?=
 =?utf-8?B?dTVGWlg1ejA4VUdWbWsyVmVHQVBiQmtwN1lTUHhHeG52cndZM3ZteGRCclVr?=
 =?utf-8?B?VjBkUmtMSG95aUVnK0pyVEgxOW9VWk1SNit0UDRlOEtGcnZpR2hMZ1phUCta?=
 =?utf-8?B?R0pzSmVJNWFSMTMrMFZrektsUU5xZzFQV292N2tiWW9yRkhCMHJpZUpjUThY?=
 =?utf-8?B?Z1Y2SnVLT0lpNXVBb29mLy8rRGhJQWJCTm9ialRtZGxrazBDT2NlU2JTa005?=
 =?utf-8?B?WS9nWlQ0UGtMU0R3aWs3ZUVOemRQTVVtdC9ma1VjSnA1U2laeUh1NXFmNGd3?=
 =?utf-8?B?TmdDYitBZU1aU3pzbG9vVXpRY05nPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45237ff7-b6b6-4359-d49a-08dde6239830
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:11:10.8794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKDq3azlITJPz5+9Ph7bEysLsNxGHHqK8lLxJa+hXwHYc+lrn+tVh/NyH4mqh+QcUMqz48DP9DxmsswGAdWyPjQm4isZPGnYeDO7jlk9gyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5MyBTYWx0ZWRfX7Og2+M8sA/T+
 +p4hv/a54flxVyAXmXXPMlnlTB8yBUSvuuw61Vevqtoa1nU7Onjkx+ST2O/YvExY0MfE+DDL25U
 E8GN6waxilhgrhQUu95Iffk9P9N5LwyOXd1VFH3ho58J9MnE2pfeB/Cf7XkJRb9SOcN65IMVuJ9
 HmbQjqFSUFk3YgZ4oj7deVOpV8YC8AtK/2IVtvcD+I9m2bWvtEAa/whQo0CNPja7bprJ+i12WD2
 hu/ytNK/2rnmRrThgbtohfQbJQuWtZ6+OFcaDbBqfY4430kYfMNd+CnAKeqbr+FzYNai42K3MP/
 ak9smXigkl8npzEXD/asgWEJjEwND+O9xbryxHuNK9PNf2in6i9fTu4gqz8DxY=
X-Proofpoint-GUID: j6lCV2A3pcjFSAU2--k-NuFNFMpkvFMn
X-Authority-Analysis: v=2.4 cv=M/VNKzws c=1 sm=1 tr=0 ts=68b03955 cx=c_pps
 a=ybF/z1spmW4Yh6p7z4QQKQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=Q1hRsLocYsZLQuAplzoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: j6lCV2A3pcjFSAU2--k-NuFNFMpkvFMn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This header is not required since the loader functionality is handled separately
by pc_memory_init() in pc.c.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/i386/pc_piix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9a3b5d88f0..351986232d 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -28,7 +28,6 @@
 #include "qemu/units.h"
 #include "hw/char/parallel-isa.h"
 #include "hw/dma/i8257.h"
-#include "hw/loader.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/apic.h"
-- 
2.43.0


