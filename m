Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4868AEDF176
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 15:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqvEZ-0006wf-82; Fri, 13 Feb 2026 10:37:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqvEX-0006wW-Gf
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:37:29 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqvEV-0005FK-1Y
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:37:29 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61DAwsxT2354787; Fri, 13 Feb 2026 07:37:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=1cDC06olnJ3RiNDr9Jc1S5kFrx3JNrQuGa0Z0ZPW1
 Co=; b=TjXWoU8FRMUW2wv3XdT9CRusY/BHD6Xi9iTuawYCVbxLt4Y1WZnfe5ni7
 3FVDUFKSobQZ/USdtxJCHqIH7LGM9pXS51jSF8yBvoFl5Gu4YenJGp2LPA07PN59
 620xPWaSmZY1mYOW1NvCbJk6z1LwNeaQk83x+NX2cItYBLfRHrn0n2WF8Tn9o/7U
 gIfcwsLyJ4UKK+RXAMa8LTj1Q/gmbf4s8bg7UVGKkNXD6RwtiMHGZH0Fq78wBwdV
 789TI/OJ8N1RRn7Dcl14L9hJSei/dp4f/WdLm0QerlotqrJ9C6w03gG5Oa8boJ1v
 nR7LBYTtnEdUlNJ6tG54aMVfj2KlQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021094.outbound.protection.outlook.com
 [40.93.194.94])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c9fukbg7f-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 07:37:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3fSPnekBL6iIrUFzXGWiQOZyomUskxy5HkRx+tjYF2bOnO3Bhi+NtUEi9cQg17QchMRNdgAAKbdP6FGsb9Px9krafdmYuCodHKYNt4ga4aJMiCCv2qltWvkorEI5GQL+n88jLLLnA6aj4ultiV8bNYZYzXxUg4hoSjETEUFGYySc0/WogCpEvMQKtHZcAcJKNDleVkXJRp6Og4XxEczvqock9p1B/zK83//tw6UPe+c6dI00mWnhQwRbO/Gi9kZEqXDCzKo2NNHGZc53+x4D9V5N2dk2L6cjgmhQyc3ZPOpbbVvLXsMj0RCaSK8xcpPiP6jkEFQGeSCaHqkieN38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cDC06olnJ3RiNDr9Jc1S5kFrx3JNrQuGa0Z0ZPW1Co=;
 b=kVS4yFvX0hKH7c8agKYDswwzwfpAbWcWuU0yRv7DifFWUSyqCOVlOPovGcqVVHuhzUU/60hr+dM43eVWT1E8aogS07mU36CNzSo7ej5DaQ5zbabq8GLOyFlPUcBzFJ9eYFC600Yg28QsEMpakb9dP2ffJGejQzO3ztGqWNUOVP0M+4mSYo/oQZ6AK/rBwVPsf9lAHrs1+ljOGgFeMhl73XqScQpIhVKE0lWVq5T1IjuhL8FYCopcVL/NMT91dJEdiGB36DH8lxXnwi4MZK7vqLiaYBuTQimy8rHlD4twjKwO+XT+27E27qXAZagKKRgbqLWpfZ7sjmW7FhDFM4SsCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cDC06olnJ3RiNDr9Jc1S5kFrx3JNrQuGa0Z0ZPW1Co=;
 b=fdsOdXD63ESc62uGZtRAFmmtZQl7P9+JkRX3ow6HxmnXItVArHArG+usaA4T8WC68daL75/IO+wxaHktvy6dFWF4TG7J6+MdXvh3mi7a1oYIEjJ3EH9gPbDtmLCCNLpCmqDk9UW7XKIbDyyhJCAHbVzv2rpsU5CEwMci+r0RGwjvQ78tN0P5ErSa9VI86fB/pY+v7DAjzysqeas9WQ0zycJ6lm0KnFHPUZwWBOCvd512r+8yQ0zqJzUpPAUo/svQ5j2Ozn+q6mPV2C0QQzvXD47lYJDTKsaLM0PmqcnPSmCP/Bet85TVXvpOrZVGQsLj1dOka2woPGme1aDQeHb7Sw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB10757.namprd02.prod.outlook.com (2603:10b6:8:1ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Fri, 13 Feb
 2026 15:37:20 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 15:37:20 +0000
Message-ID: <def0e361-78dd-470c-84e8-cb20bffd3134@nutanix.com>
Date: Fri, 13 Feb 2026 15:37:17 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/43] audio: replace ldebug with trace events
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-34-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-34-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR20CA0026.namprd20.prod.outlook.com
 (2603:10b6:610:58::36) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB10757:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e512f95-c36c-46fd-a9c4-08de6b15c6bf
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlMvWEtDV0ZPUEZ0RFVBYW9DVHN3RlQzdk5DNjV3ZjFDSUJzOWJONlZQbmRp?=
 =?utf-8?B?RXZLNnNmYkZPWWYzc0V1a1pDNDM2cE84eWtmYisvMzY3SU1UQVpPTGQxb2Rl?=
 =?utf-8?B?WUYxSE9pbjBiRG5rZTROWEt2Rklkb295UVpteFJKZVZkRkd4eTFCV1psc3Nv?=
 =?utf-8?B?KzVXbXJjVGNHeVdVLzVYUGk4bUd4WHEvazdCMW9SQWRBalF4YVR0OEFYSVVl?=
 =?utf-8?B?K1hBYVIyak92T3JNcFd6QUhjdGZUdVFPZ0JUTks5L0plcEFBNHZ2L1BGazl0?=
 =?utf-8?B?a0dobzA3MTZUVXVHaHRqOHhVVDNWOEl1SHBWTkdMNTBaeWs4Tm5peHYzMlNS?=
 =?utf-8?B?UHNSM3RCckROVW8zQml4YjVFN2xrNmRlZko5VERaNW02Zkg2OGpLeXMvakhW?=
 =?utf-8?B?T0NIN3hhT0hEcjdoTW52VG1XaGdTZDlvRVlIVm5nNExCUjF3bEJVZEhOQVZ5?=
 =?utf-8?B?V1B4aWZLaktQblU5aHdvQ0ZOSWliNUFoZDZoYlo4enNQdzZJb0hyYkl1dFQy?=
 =?utf-8?B?eFRzWExibmpPZ2FGYkxKaUJvU0ZUMEhPTEIwMGdoeWFNRGtKVEs0ZWtGOVhl?=
 =?utf-8?B?bnQ2ZzNGVU8vTnJXRVdxSFdBWnJ5TGpSM3p0Q3VMYzJKY1gwZlJ1QXRLUGNQ?=
 =?utf-8?B?QTczV0xTVXpjVk5UYUlyMFNySzh3VHBFSm5TUXQwOHBYMGcyeC96WnIyK3FF?=
 =?utf-8?B?aUlrTERPTGlML2haaXgxT2NNdVhGWmhYQ3EwVThrSXlTY3lEYUw5MmRURFhP?=
 =?utf-8?B?U1V4Ync3MlZ5YittYm1oc25wVi9yRWhVa0ZlYm54dXg4WXVzbWZBUWdjS2VB?=
 =?utf-8?B?aDdQK2dVVFVEUHQvOXJpR3FGQzkzMXVGUUlieHBYOFBJTjlocDF3aitpYmZo?=
 =?utf-8?B?SWdDVHNmcmNjUUhUQUd5VG1Ja0ljSkdHYytBbTYyNm8xNGVoREwrQWFFUENI?=
 =?utf-8?B?UTFVQ2RLa2Q4alpSQ2Q5TzNFbUdnQU5RVlVGcjVjOVZFN1g5OWxvYVl3MGlZ?=
 =?utf-8?B?OFUwZ2RGZHp3SlcrenA3d09rYnZtRm14MFhSUk9GVk5QM1d1cjJCV1B1eEZr?=
 =?utf-8?B?YzBvaWpOdGJreFM5NEVVVXdVbnZJQ2h5UGZ2U2dTZFFobDhSdU5aUURFWE1I?=
 =?utf-8?B?MGwzeFpHckRhWm4xWi9rSkJCNGpoL2o4ODRiaFVwUnVUQ21PeDdWMTF2Mkg5?=
 =?utf-8?B?a3IvWTR0MktFMDRwZ1VBTHBFRFRidWtjNk5lUUlLOVR6eS9JTWpjQ2tyVGdw?=
 =?utf-8?B?TXNkV3dEbnJFZGtrNzI5S1NabzRxZ0pQelcvY2ZGMnpYRURzRFhJZkx1akRB?=
 =?utf-8?B?VkhkMCt0MEJQb2lKRHRzVzIyYkVvZ2hFd1J2aXFWd0lESUZLSzJMYTJjVW9G?=
 =?utf-8?B?RUhEZ0pxbmdDbjMvaktVTnJWb2xxWGw1QmEwb0ozbGxoeGZLOUdLZTV1WE92?=
 =?utf-8?B?dTArRWJKZ28rQmVWMnpScVlTaC9YYnV6b1hiMEcwRVpoejErY3c5emx6VG8w?=
 =?utf-8?B?YXZBcUxvbHV1cGpIYi90NGhXMWxBRHJOTlUzMHlIQTJFNVRuS25HMlRjTEdS?=
 =?utf-8?B?by9QQUdKUVA5ME1SejZCeC90ZGdEMG1kZWlKYlVWYjVYWVpCYnp5empxYlNN?=
 =?utf-8?B?TFJYUyt0QXFaVXNRRHdoTmlhOEZRTWNZTkVMVlNyTmFKdUh2c29MYzVobHhh?=
 =?utf-8?B?a1kwSE1BNFhSL0UxVE1MT2NHd0lkQndVTzFXc2NITlRDZ2JpTXRGRUJ2MWZo?=
 =?utf-8?B?NlcxZ0lXWGZEd1NtcjJ4MFNoQVd0a0ZSaCtmOEpJTlNsSUtpbUdhdXBMTVE2?=
 =?utf-8?B?MVV0cWxHRklFeWF6Z3lOenAwS0RwUGNiRjcxbWJoTWYrZHB0N29CZnFZUS9h?=
 =?utf-8?B?NFVOenN2L285U1NZWFFjNDZlTUxzODFhcndzaTVadGdHVTgrb2wrRXo0aXU2?=
 =?utf-8?B?WjFzcjRDNC9MTERSaXFjdkN3STZTZUx2eDYvZHFrMEFWNXVFbmdsL2FhNHFL?=
 =?utf-8?B?YnUzUTk2QTU0RGN6VXA3S0JUbzZtMEpxOGhmQndCSi8rbUtLdmFYRjlremFQ?=
 =?utf-8?B?YWVhd01xM3RRSzZjOExiU2tJMWp6WGNLWk1FNFdjWDY1L3JET0N5NEtiVS9K?=
 =?utf-8?Q?YjDA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU5Kc0RRUFc1ZndacHppT21qb1VrMldHWERVUTk0amR3ZktibW1jZ1VVWVpk?=
 =?utf-8?B?NitBeHlZd2RSN3I0Uy95cktDa2Y0dTFJeGliRjZLSU9ibTB3VnoyK1pFVFZ2?=
 =?utf-8?B?K2pxcFFQUUFNejZCc1ZiMGcwRFlOQTlNSkc5eVBGL0VLT2VPUXVwTjUvVlEz?=
 =?utf-8?B?czg2OEN0aEluaGt1emwvQ3hyaThiZ09pZlcxbmkweE5Mamg3Ym1aandKK2M4?=
 =?utf-8?B?WlJBcHFkMTB2cVRVSFNEQ3JGbzFDMkgrWUp1NGMyOE9TdlRrK2tkdCsvcUxF?=
 =?utf-8?B?YmdUeVh1dU52Q0FEcWRONHlaV1NNKzJNZGRHUzJZdUpNUDJ3dnRxVmdQM0RD?=
 =?utf-8?B?RXZ6OElESjhCQThrQVcyYWhTbzh6R3BXMHVjaldpZS9CcjdDdHJLMjE5K2V3?=
 =?utf-8?B?a25Lb3ZjTmM1TkZFcEN6R3c3NDFQMTRabnQ5a2ZmSi8xcW9HR09tTWg1QkJP?=
 =?utf-8?B?SGxBMGs5UXMyM3RLLzZMbGtsQTU3QjlTMElwZFZteUoxMmJwL2tYbFFtS1J2?=
 =?utf-8?B?dEROZS9uaGcxMWlJT1RxQjEyWFBwRWJKSXJEVWFiWGx4dlh5akV2UVVaKzRx?=
 =?utf-8?B?d3B0Mll4cHl6ZUdhTEhxb2V4UnMwWG5HVzNCOS9MVlEvYTQveGpGQ3NLbTA5?=
 =?utf-8?B?b1F4VEh2MTRjWFFLNDRZU28wdXB1TVVxZnd5NXFqNEVHSFR0K1VXTkdUWmRj?=
 =?utf-8?B?MGZOKzN4djJDVnNHeUZ4bUkvRXdqZ1JlQ0hWRGplWjAxWHV4RDBmemRIUXdN?=
 =?utf-8?B?cXNXd0Z6c0crS2JHVFN2SnovNFRRTWVlYWJCYm0xYkNKQ3YyZzF6WUtLbEZW?=
 =?utf-8?B?NXpteW9LdVBJK0lFSHhCTDd6R0ovNVNrb1FadUljQld3VjVwVmV1S3FMM0NS?=
 =?utf-8?B?ZGFNeFNxQ010K005YzN1ZWJDNG9qQUJQQ2NWODM0NTVZK2tCZHUzMUNLVnVk?=
 =?utf-8?B?SzBQYUJXUWhUeWNTN29JQXh6cS9yN090bi9BVVNHL3grSXRNRjNsVFVhcVVy?=
 =?utf-8?B?UXJ4Y1k0NW9IRktIZTVkTVJza2tPaEpqK08ydGhPYVdlc1htd0s1Z2NjZytQ?=
 =?utf-8?B?WkVFc24rMjZiQVFZaUs1TTQwL0s1SHgxY3pMbGZURjRiYzltL1BBemRnREFl?=
 =?utf-8?B?eFNuN3kyaHFnVW00NU5LNXZhOWJPbHhkS2hoY1FMbzhtRnJsZ25TbEJhS2RS?=
 =?utf-8?B?ajBvUHBKUTNzTDdSYnFKMUdKR3lsaXF2U0M5MzlQQ1h0S0doQjNLM1FTV3lV?=
 =?utf-8?B?N25HcS9qS3lFNSsyUWpqTFBqOVZnOS8rWDNJNXAwZnBhNUZwMldKazVJL2My?=
 =?utf-8?B?QjZFVGpsZTErSDVIbTE0YWpTSEZGTjRLZWRXb0hjZXhvMExpNGRBUUN5Vjk1?=
 =?utf-8?B?L1prQVVTUFJ5cUFWRmlmWUdKL3U0QWp0Y2c0dWltczA4amRxTW16L0Y4eW9P?=
 =?utf-8?B?RmJkdEVYSTBpalBnY1FQbmdXWlBEaUd6dTRRc0QzdXZlTDBjSENEU2p5bTFH?=
 =?utf-8?B?UC8zVFF0elI0Zm1DMlc5dnM5ejAzSFZRMVJCRXZrSWhKcDdUYmxZVVFRd2Z5?=
 =?utf-8?B?OGlBTXhMSUtWUkYzZ3ZrZmp5aFJzWEE5UkcxdTQ5Mmo1eENtRHZjR1BaRHlx?=
 =?utf-8?B?aUEwRXJUTXBodUU4UW5FMXNNMmVvZlRCc1N0M0tQV2FYUzg2NlA2QnBKekxR?=
 =?utf-8?B?emlTdnhOb2tDWENnMXNCaTRvUkdaRlVUN1NUUEpINDduOUhWOSs0NHlNdVd4?=
 =?utf-8?B?TTRwUnhGYmFNR2FtRUFKOER2N21pdlFCa2UvUGkvY2tHQlVTMVlObThYRTkz?=
 =?utf-8?B?UTA1Mmc5ZUN4c2tSdGwvcjhQTWJ0UTBuSEVjVkxkbEtPMVhUUG1tVUFLSUt2?=
 =?utf-8?B?MlJ3c2J4cVJUOTdIZ0FMb21oTmh0MVExRFRrenYxWW8wZG1oZGZjTW9zbk84?=
 =?utf-8?B?WklkcnFHcmZScDVpYXF2anJBWWQzckRSYUt2TFhJaHZ4K0lHMi82dllyS0Mw?=
 =?utf-8?B?WnVCUHRPTC9LdUNCWDZwWEpDU1htVU01T3VVMG5jeUNzeDJMUVkrTzBSNFRL?=
 =?utf-8?B?b1NBYUdHdjJnV2QzM3dLMGViWWxlcm9rREJDSS9WU1N5dHFaNEdSZGlwNVF6?=
 =?utf-8?B?OUc4OGpvd2t1NTBRdlMrNUM1bUFqSGxQcVVNbkd6L1NZcmpvd2orR2EzeHB4?=
 =?utf-8?B?QkFyajdXOE04MkpmWnpERVYydlhlK0d5aFl4VHNFdXBBOUI0VDJGNUd6YW52?=
 =?utf-8?B?MGpIaFNYWlN6TFdhZVJsQmFOV2lpMG9JS1VXM3lFM296NC80QUNVdVp5djFL?=
 =?utf-8?B?eVhWUEtNTWVjOWRDSG13TVRRWUNNOEZRbkgxZExUQ1kxampjYXJwUnlEc2NL?=
 =?utf-8?Q?bBaE3AVC0dm+is6Y=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e512f95-c36c-46fd-a9c4-08de6b15c6bf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 15:37:20.7265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+gMFVT4F3FNWbAFXWevg4k7Y+F0pjkNa2xilcJfMQHkvz0ZPjo8KcEZ3L1uPzuRVD2mkPnRXt10CC5jHIU0Q1myPgflorGcNb8gYEvmrMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10757
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDEyMSBTYWx0ZWRfX/JbVHsfNlgY2
 /J/McHscdf1vPDf7fkoakVyNT9NnTMJHwzPYfcv0Topqrd1+6BWLpmH09RSz5E+6oKsveVZg+tB
 5s12CLY9vR978sou80JWAZJ+4jcpIoRJqmMllP4mWbCDIZsdjN98Vt8uKnT1qZuDnz2WxhPnN6x
 FGKAKchkGus9nL66GYuNFk+jte6TVEVMKllbSb+02ogP1Gy16bu18Bb1RcJ4rxj4rjP0QBmiQ3m
 sL8HhTjavKP9r4VB7D9OffsF4Rieu5arIQUbYpN4VSnYMYv4S3v840mu5mzlHnHgOUayLCOun4K
 Rg3ku86dC0mkriUFHezCRNU355RLaPbuCZ9+jXm8hAnyVzvWTRVVHtAYhWcnPggTWzpXNBLgCEq
 Wrp/Ng4ZtIshcc0HTwbhr2l2ewhnzVWOpTKbkRi/fF/5CnR9yvuPAkJj4LRry9obY5KMPgg8s+B
 Rs/eIPwCgJ0yq/QlhNg==
X-Proofpoint-GUID: fY5G1m6WnHFry1g7RqLb7kqj2W7oLxYo
X-Authority-Analysis: v=2.4 cv=NoHcssdJ c=1 sm=1 tr=0 ts=698f4533 cx=c_pps
 a=IKYxX5W+XLRgvfagleVcPw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=4U7CtG7POjkJ5uidImUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fY5G1m6WnHFry1g7RqLb7kqj2W7oLxYo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/01/2026 18:25, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Replace the ldebug macro calls with proper trace events:
> - audio_get_avail: traces available samples in capture stream
> - audio_open_out/audio_open_in: traces stream open parameters
> 
> This provides structured tracing that can be enabled at runtime
> without requiring debug builds.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_template.h  | 7 +++++--
>   audio/audio-mixeng-be.c | 6 +-----
>   audio/trace-events      | 7 +++++++
>   3 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index 3da91a4782c..c47a2f202f0 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -507,8 +507,11 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
>       k = AUDIO_MIXENG_BACKEND_GET_CLASS(s);
>       pdo = glue(audio_get_pdo_, TYPE)(s->dev);
>   
> -    ldebug ("open %s, freq %d, nchannels %d, fmt %d\n",
> -            name, as->freq, as->nchannels, as->fmt);
> +#ifdef DAC
> +    trace_audio_open_out(name, as->freq, as->nchannels, as->fmt);
> +#else
> +    trace_audio_open_in(name, as->freq, as->nchannels, as->fmt);
> +#endif
>   
>       if (audio_bug(__func__, audio_validate_settings(as))) {
>           audio_print_settings (as);
> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
> index e11c586c827..343f6ec181e 100644
> --- a/audio/audio-mixeng-be.c
> +++ b/audio/audio-mixeng-be.c
> @@ -881,11 +881,7 @@ static size_t audio_get_avail(SWVoiceIn *sw)
>           return 0;
>       }
>   
> -    ldebug (
> -        "%s: get_avail live %zu frontend frames %u\n",
> -        SW_NAME (sw),
> -        live, st_rate_frames_out(sw->rate, live)
> -        );
> +    trace_audio_get_avail(SW_NAME(sw), live, st_rate_frames_out(sw->rate, live));
>   
>       return live;
>   }
> diff --git a/audio/trace-events b/audio/trace-events
> index f33be2dd8e3..4749c54fc04 100644
> --- a/audio/trace-events
> +++ b/audio/trace-events
> @@ -58,3 +58,10 @@ audio_be_set_active_out(void *sw, bool on) "sw=%p, on=%d"
>   audio_timer_start(int interval) "interval %d ms"
>   audio_timer_stop(void) ""
>   audio_timer_delayed(int interval) "interval %d ms"
> +
> +# audio-mixeng-be.c
> +audio_get_avail(const char *name, size_t live, uint32_t frontend_frames) "%s: get_avail live %zu frontend frames %u"
> +
> +# audio_template.h
> +audio_open_out(const char *name, int freq, int nchannels, int fmt) "open %s, freq %d, nchannels %d, fmt %d"
> +audio_open_in(const char *name, int freq, int nchannels, int fmt) "open %s, freq %d, nchannels %d, fmt %d"

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


