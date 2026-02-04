Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9918CE95385
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 11:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnasK-0000RB-Cf; Wed, 04 Feb 2026 06:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnasJ-0000Qt-9J
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:16:47 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnasH-0006R3-EP
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:16:47 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6145m1LB2991334; Wed, 4 Feb 2026 03:16:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=G4o1jBp9aVjgFKrCac+O1udKfaA8SJan7FznMhbNH
 hM=; b=tjiDkErdAzzewxxKsyFqyfsQbh/D0szFxtttznEAbwhJW/8g1zfk2VSO3
 /JDYbCB8L0kkopkOMQpG3EeTL0qlQKxyY7BgOphhHrXdbQqVuqyTOBHRMf1sXbHr
 Y3J6Ay8mWRlFJXcF6qLILtjcjG4eZ82tfl5PeMeBUlxIb2d/8VCaRJVS1ilxUie3
 oSjpDpw/gwOA5sWOHgfahZZnlkoxjgMYwA598mtQltHZgDZW7y7YZ9EWsZ77Nuv8
 bjCKos0VHmIrpgvz6WinVGv6oLsOoJBnq9BB2RbImPkH8dED6j3uCb5ib1D6JwNR
 rtMurNwB4IukwWSdVweP0H2207s4A==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020126.outbound.protection.outlook.com [52.101.56.126])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c3ntja4k5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 03:16:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnqxcdmghD/48HPyX9q4QDKAQN/lLyuh+3xFCTfQVr5wS9s3aF4McwyJWGbwVRyrxLMPFsb8tyVNYAGBsIINPKddUyPkMAX+AQ1ddq8gCkFeVehPuGxoQ8F8BOG+Jd9NqpmHT+GB4KFEh1Cfl3eV5NAyhOJKJKE/lyU8qMqfX4tgCjxaF8fQWQqK37pXpyQKiZy0+UcPYd/+ykyG4QW1kVuU6VJ6imZkdmDF+JRj4gH5HAJMG9HO4AyR1d/vcgaQTx1LoIuhVj4Wid1cRZ3xfX1gX5mC2XpzZfN2JjWrmRNk/N99NZuM6sKVqUd2jHAnhOITzkkEb58s2N4BjjCkkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4o1jBp9aVjgFKrCac+O1udKfaA8SJan7FznMhbNHhM=;
 b=SIlcd8ZsDTtIV09mM0/1VHcmVCV6L6o3RjnKWVDivz5J00ljTl3wcrN6Kwj4oiHJI0RLqiYQZ9UdotwSH7pQwF4W4rTXzk/v3v1hgCVMRPa77txDE3A67ccQ1mrdk5BE71iLWQkfXs8hOkrbA89o/BvxyFlqpoW6Q+mwUCBnTZFhcGvOr/aVB+rP1F0MFJES/G/YR7pEftP1+Dy+UyyJmXUTMOblWjqIxVkpJ3dnvqZfua2YVn8lcuAFeedyCv9qOnXFnLF2kR5G5+h/bWDBXis5VN3s61zCKhKXBz4Ack3rzzI1/7IizmaoZoIk2od+zRxOvK5381Lc9MsLLv62Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4o1jBp9aVjgFKrCac+O1udKfaA8SJan7FznMhbNHhM=;
 b=toCRvrwr0z4s+AwRCaBZyZ+u3vQVEk4xTBbGmYwqwGUC7plKMIy+I2PLKoDy90cGG3vF3m4R+n/dYqfcIThXlcaqOR2WAZ0PIeqsdLLAL94y1As3pZC9T12Z+OiCsq+isHQkX0c2WPyqdNd5DyFyubrIKr8Q6r/7rz2T0SUCcBZg89uJ05vYsC09Ix/5SAk+4Ox+G663TVhWWQgRwQbbGiqJUDHElNkueyGGFAClVAzULXW+s08vK1AMQmeWKJulHlclEzwgEumfz7wD97PwM2s6k1qWkUAmYNrePL3uikSAvA9D2eCdy5p9FGthBlGLHiv5tj7WDfALA6BEgjdrpA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS7PR02MB10892.namprd02.prod.outlook.com (2603:10b6:8:266::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Wed, 4 Feb
 2026 11:16:41 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 11:16:41 +0000
Message-ID: <84cb5bfa-fe27-4415-bcd8-3ef0b0979f7f@nutanix.com>
Date: Wed, 4 Feb 2026 11:16:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/37] audio: remove set_dbus_server from audio_driver
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-23-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-23-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:806:23::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS7PR02MB10892:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d07593-3c64-42e7-7412-08de63dedf3e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzdxR3FrMjNGaFQ3OGZQZHJma09NZkw2UFpwM3U5YU5hZ1YrVGJuVmpMQVJS?=
 =?utf-8?B?bmZYamhoZk0yS3JYcEM1RS9PV0lKT0VHTU9rWFd2K3N5OE55WHdNc1QyUWZD?=
 =?utf-8?B?a1RXZGxWL2YwbmM2Skl2THkzWVFTMjlVUk40MWVGeGhHSkppbWJRR1ZISUtv?=
 =?utf-8?B?RWZtZXpMUjJGRzVmaFBZQmNBUHZVMC9KbWdpT2pEb0NJaHoyT0ZFZzN1Y3Fu?=
 =?utf-8?B?MFIvbEpYVU9ubGJRZFlnb3pwb2diNCt1Y0FuZkdOMkZPZC92eDZaUHM1NlVm?=
 =?utf-8?B?OWltaE5RbFR0UkdEMXlLUGN1Sy9PTDB0bUV2SVkzRWFwL1JTbzZKQk9WNGpI?=
 =?utf-8?B?eWRtRk1hMFQzRThNL2psWlRRQ0QvRVpQTVlXMlczMmtybllENFdVMGpPanF6?=
 =?utf-8?B?NVJJS0ZtZmhHVHJwNGVKMk40aFN0amNHSFJCSWNuZ0I0SGd0dmFIc1RMK210?=
 =?utf-8?B?K09ISjZLc1BHMjVYUkU0U1VVUWM4YVlrVGVYZVZ2cVlKbVVQT3dSOHp1Y1JO?=
 =?utf-8?B?Zk53dmc2b0ZKaEJOMlFFUzZrYmlicXdhd1RtenY2WkRBdmp1T3VmVEhPeTVV?=
 =?utf-8?B?T21oTk03N2VTZnQrR01qNXE3ZGE4ZGpCVWo1clZqQTBjMW1wWC9WOVVzMUdZ?=
 =?utf-8?B?anlZTkRFYTUwOUxOZ251amlQOFhkUjlOaGFoTUdkM2dPbnRzY2J5aUhOQnBl?=
 =?utf-8?B?Nm1zQS9LSDdUNzBoUWp0c1F6MjVPTG9hRnpxYTlzaE5CaGFtRGduck9yc25k?=
 =?utf-8?B?QW5OMytCSzZDd0xpdytIMGhCSkhkOXdORFJvYmZNY2tkOHZ4amErMFVDeE9u?=
 =?utf-8?B?OFFDUkpiZC9rVy91aGVOUVNPdmduMWJ4RHFJWUN1NHBzT0haZ3VYZkl5WFFD?=
 =?utf-8?B?VCtlNmFmV3ZTWjVqS0dpVm9jb0liNG5STFI0bUMwbGl4VU9QZ3d6T1BpaGl2?=
 =?utf-8?B?QWtKSzRQQnVnTFY1aDFtQ2lBQnpxajRvWlJPcGpwUnZqSElrTG56TDFwZWZF?=
 =?utf-8?B?eURTU21wdWdSL2hiT0VBT0ZmcklKb2h4QWdOeXNLSFRsVXNBaVExRCs3a1d2?=
 =?utf-8?B?S0QvSUZocWw3N0xBRGhTUFpCUW1YcFJCRWJvbWJkQzFVSEl3SVM5elZ3dDdv?=
 =?utf-8?B?QVpiUVorTDVWWi9YdmNQTXVKN2pVeXR1UW80LzJ4SDRCYTEwbGt5TERZbTdW?=
 =?utf-8?B?T2E0WDdGKzdXNVQvN1dxNmxDVFNvNnY4M2ZnMlBtZlJrYlNTUmlzRWEvOHo3?=
 =?utf-8?B?YklLVFBBVjFjQkkvaFFwTzFPMnhaSFdNY2lDYi9aRWNoSVZZZlRPdzc0d2kv?=
 =?utf-8?B?ZDZXM2czQ1BNeVhFWFdaakJ0aDJRbWRtM2QydTE5M0Y4OEo3eTFwcEtsdVVm?=
 =?utf-8?B?TGpqbncxVXdhYnJpL3hmMGZUL21GdGJwVEFENExudklEclFTeHp1MkJqNXB5?=
 =?utf-8?B?S2xnMThINUYzWXJwSnE4S1pLeWZIWkk0TjZ5L3V5SGF4R254NDVVM1dFcGtr?=
 =?utf-8?B?Z2doL0U3RmEyS0xBTUVIVXRuUEhra25CWHIzVWxSRGFZZXdZZkwzaDZZNmdN?=
 =?utf-8?B?ZlRwQzJsSERnbjNsUDFXK1ZpRC9pbUxLSnhqT21EdSsrcHBqK2RHbWQ4U3RZ?=
 =?utf-8?B?bkdreXNjVUM0NVpGaDJwUG83VkdUYkRqNmZjeHFKbVVPdGxYWTNjWUJJSzI2?=
 =?utf-8?B?a3dqdEpWTmtaWG5ROVl4a3hRNFFJR3BoSS8xcGZxUWJzTWh4NHQrbFZ5T1pS?=
 =?utf-8?B?MkMxS3YrQ1FuMlhsb0ZkUnl0YzlOMlpHZ0ZTdzhrbXkwVXdtTGRZOGpjUjlR?=
 =?utf-8?B?YWk0QVBFb3ZqWVBkTEdBRDlQTndMUEJzZnBod3lFRlliMTVEM0pPdEpGUnVw?=
 =?utf-8?B?REdzZDdSbnY5TGJ0Qnlvb3BnM1VoMUZPaURzRUFTN2JHNlRIcmF0enM2ZmZm?=
 =?utf-8?B?NHdSQUhQWlJyV1U3aDVMdDZBeCsxaWJPZTVVUmYyOE5kbjEybTNCa1REWWxC?=
 =?utf-8?B?cGlLdzhobEhHdmphalpvNUNCZUZoYjA3ZFFSdHRJQ1BJeHFjZHpwU3dNQkIr?=
 =?utf-8?B?OHRVU1ZYa0hEWkZ1Rk4xZnNNbUQxNDlsbHZIV3FpZ0NSajAzb2dYR3FYcFc2?=
 =?utf-8?Q?5VS4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmdlOEp3MExRM2JtNFlJSnhlYS9oVG1GL052alArMFAvdGo0NlNZUmtsN0JF?=
 =?utf-8?B?R2lWQzR1SEpicHM5SWY2UDFRMXF1cHcvZDFJUmo3dXo3OWpaRENoUnZpRVZk?=
 =?utf-8?B?Y0xBcUo4dzc0Y0RzR3hXSnhLb1l6YlpZdUFnc1Z1bXFCTnhOOHBWbGFDTUo2?=
 =?utf-8?B?WThyVFZKWWx3MUc5VHp3Y01DSW01b2xyeldSSm9WVnN0TUU5cHFPY1hsamEr?=
 =?utf-8?B?dC9vQk1WNitjdWhwN3VXcHB6dzd0NVRSVldSWUYrK3BVSkVBWThwYmVmK1Fk?=
 =?utf-8?B?a2F2cVF2cVl1dTJ5bFpjMWFyQ2htcm5yRTlVeTlFSXdvYTdjbURJUFpRMElm?=
 =?utf-8?B?MElsYmpBWjNaQ01nV29xTUZlb3YyRjlMNmJWdm5BQThDcW0zNjd0OFBBMlRK?=
 =?utf-8?B?MERLZElBQ2lwZ3dZSnFIamI0WDRjTzYvZ25Qa1dtTmJCc0czNGZvMGZERklP?=
 =?utf-8?B?cEpzb3dRNVNML01MMUxhOXhHWkZ6Ri9hOWlaRUxLbnZ6dElOMEVNUkJOWVIx?=
 =?utf-8?B?MU1PUW02MkY4R0ViYUs1REdoQlV5ZGFudjVIRW9oNFltaXhjcEg3bE5qQ3pO?=
 =?utf-8?B?eHVhNWtsREdzVitpQnpGZEMzaCt0Y2FYbnJFcGJzQ291NjhUQ0FoTzBySER5?=
 =?utf-8?B?MExPOWpaNHZkNVpYR1hPK2g2WHRwYWw3KzVlQTl3STJoNGE0a2lMdzBXSENl?=
 =?utf-8?B?Q2xPTmtRVVVJcWRCcTlSRVBwZGVjMFZNK21ZdUE4RzVPcnRFSzJsTm9LL0cr?=
 =?utf-8?B?cVVzS3JZUFM3MEFhektTUTB2RFJuZ2VDNkNWVG5qeGR5QUVkNURxK0JLTTYx?=
 =?utf-8?B?d2V5cXFJV3Z3eU5UWHZFOHkyU2ZBd3U5cVJqT3kxTTFyU29EREFsTUhWOTlJ?=
 =?utf-8?B?ZE9kQ2JYZzc4K0pqc3FURG9hREFJY2d3WnlRRVgvOHNlU2pTTndEWDJXc24x?=
 =?utf-8?B?MUV3Z1Y3ckExbC9QMzlwYXkvZ0lUeTNETUM5T0Q0K1JQZWJYdjBIc09oVGQ1?=
 =?utf-8?B?QVJtUnpkVmI0ZFA5aFRCbVR4amxRSWMyWDRxVkIvajNCbnRENXJVQ21oRDBJ?=
 =?utf-8?B?amNZUTAyZUNDRExVNjFuemlGS3BsWDFRa2RWQjRsMFYvOXhGNkVsOTRKL0xY?=
 =?utf-8?B?bndhK3RGN2FrZEVNK0ZRa2FsTlRvZUVFVU5peGZzSXJNM2J4NWV4bEVNK0xs?=
 =?utf-8?B?cmpBb0NETzNQU1N4MmR6QnVnZGFqcmk1NDkyY2hubmZnalNpcThyYnNWQktx?=
 =?utf-8?B?Mlk4YTVKRGNWd2ZYeFpSYjl1Q2NsNkVyZTlZdnlGaytidS9GdUY1K3BZRzcr?=
 =?utf-8?B?NC84MHZqR1J2dTBJZk5oSHVEUU16UFVJQjNFSW5YL1lJbmRudDFXM2xSTTRC?=
 =?utf-8?B?Rm5xY2QxMTFNMjZBMlIrS1FSM0JLcTBFYnFONTltbTA4Z1ByTElqYkZySzJF?=
 =?utf-8?B?c21ZMnIvMkc4VzVKQlJHWWFNYWIwbEI2TlU2WHZDcEJaYVhWSHVHRDlvR1Bk?=
 =?utf-8?B?cktWcENEZHNRbzY0MmVnc1JHcjFPcXdJdklCay82ZDV2MGxWajdicG5kb3dj?=
 =?utf-8?B?SWRRQzZZY0VWN1EyZzZxT2lLQTM5NTV2V2R0ZXhOMFZ4VzBHd0ZpNi82S1By?=
 =?utf-8?B?aVpVcUNGL00rQ3E4THRZMktpdk1wMmVXZDdvYnVBZmdCWUdaUzN1UUZtR3dM?=
 =?utf-8?B?S25ZQzBtc1JMMUsyY2JZNDFNV1BzKzFBd3Vtcy90VnA5ZkJaV3VRVHg3RS8y?=
 =?utf-8?B?ZGlsaXZENlJNR0RUNWdYVi9YMGlsdW9DK1IxS2dUcWFMSWN4UDVFMmJkV0tQ?=
 =?utf-8?B?bkorcTFtZ1FqZVlTQnJGYTdvY1psdDF0T2FYZVZKTmpDeWk3ZVNRRWxlNW9y?=
 =?utf-8?B?SVJJL3p1d2w0WWEwVzYyVGpRbjZ1SHUzSzNSSmRNSjh2aU1pSUdUVXE4aHBh?=
 =?utf-8?B?Ukt0UWR5QVdhZHdObnJMZjc2R1dMcVFvSTNURjcxMzRGamJrZFJpMld0MDIz?=
 =?utf-8?B?YnhlUkUxd0xjTnhiYTcwK1JZcnJUU1FkYWlDT0lLT09ZakxFSEVhMVplbzdo?=
 =?utf-8?B?YzlkdUVmYjNFb2V1MmdUN3paNm94RnRzdWtDcWYwTFN2dTl6eThDbTc0N2RF?=
 =?utf-8?B?Rk9VeVFDSFJIMUd5Nnc2MWF3OWIzZFVJcld6S2ZjeHhSZ2dYL2IxZlJFYmox?=
 =?utf-8?B?YkZobFZra1BqOVhqSjJxUG92REdlR0xWU0s5eXkyOHhKYmxIRGFxV2xiWCsv?=
 =?utf-8?B?VSs5OTNBWnZXRCtoQTFuNE14UTNuckZ0cjJ3Qy82cVNPYUZERjVycEtkcDZI?=
 =?utf-8?B?eDN4VUd5NzljSzJyRHFSV1Z5MDZlZmp4bW56cE5lL2p4dXdzYXBFVDVJUm10?=
 =?utf-8?Q?YW58nC6UmGr7TXgY=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d07593-3c64-42e7-7412-08de63dedf3e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 11:16:41.3292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLLo/R+YY1+fdkx3qH0QZif7qGtbuc/up+p/O7NxIGvBv101zOszLLVckfoONkO9hHT/BjO7rvh2HxCZQCtA1Sk4uEaw0XZqVwxLYROBUPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB10892
X-Proofpoint-ORIG-GUID: lA0uVEabKQam3V9BBAlPIdJW6RfbmOwW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA4NSBTYWx0ZWRfX3pNqep4Uz63+
 6O0vV/OQZ79mbqWICs5iveQAZCGo0j3KoEexr9iDS2DCB0rLtWpwk04L89khADtVRKAZblyc6mv
 0D0v2KjCRJWVTAftSisf8zF6NDgMSWY19GMu4euDEl8e1f1PzhNqYNZtvymRUehUgY0js8QCEcI
 W3OuItplRCgnd/S0HG7nSq5nCmgPBuwOqTBD6fKHAGdoVFul1B2o4N+iCfJmo0AlyiMFH2IOz8K
 YA6zWrhrSLNpnf/f8FflJ6N/RCJfIbT+nyhqT0P5Gp8PL+pY8f8HoJyhRY9e6EAnknzmjCaqpDk
 kleHEd6C8LVvPBwuINSOXJFKFpcQ2tOXTmb5LGJRxEdxquoaDbZSq1ivw582rHLNamg3qFPcQF/
 sVbW9Prjb4Xju2Xa53Id+x6dWZAps9oiWpY8Iv9xgrJFDGC5mZ8GasVTeUEMdH4ptkp2Ou/u8oI
 2VmCzbBInFOhFU//kKQ==
X-Authority-Analysis: v=2.4 cv=K6cv3iWI c=1 sm=1 tr=0 ts=69832a9b cx=c_pps
 a=y6InnzShCRkIpTYudTQ+bA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=21aiUDWVu8agm7edwxsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lA0uVEabKQam3V9BBAlPIdJW6RfbmOwW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Use the QOM class vtable only instead.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_int.h | 10 ----------
>   audio/audio.c     | 29 +++--------------------------
>   audio/dbusaudio.c | 17 +++++++++--------
>   3 files changed, 12 insertions(+), 44 deletions(-)
> 
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 29f5864be69..0b97c8edee3 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -33,10 +33,6 @@
>   #include "qemu/audio-capture.h"
>   #include "mixeng.h"
>   
> -#ifdef CONFIG_GIO
> -#include <gio/gio.h>
> -#endif
> -
>   void G_GNUC_PRINTF(2, 0)
>   AUD_vlog(const char *cap, const char *fmt, va_list ap);
>   
> @@ -145,12 +141,6 @@ struct audio_driver {
>       const char *name;
>       void *(*init) (Audiodev *, Error **);
>       void (*fini) (void *);
> -#ifdef CONFIG_GIO
> -    bool (*set_dbus_server)(AudioBackend *be,
> -                            GDBusObjectManagerServer *manager,
> -                            bool p2p,
> -                            Error **errp);
> -#endif
>       struct audio_pcm_ops *pcm_ops;
>       int max_voices_out;
>       int max_voices_in;
> diff --git a/audio/audio.c b/audio/audio.c
> index 323608ea0d5..7e23a63d401 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1639,31 +1639,11 @@ static const char *audio_mixeng_backend_get_id(AudioBackend *be)
>       return AUDIO_MIXENG_BACKEND(be)->dev->id;
>   }
>   
> -#ifdef CONFIG_GIO
> -static bool audio_mixeng_backend_set_dbus_server(AudioBackend *be,
> -                                                 GDBusObjectManagerServer *manager,
> -                                                 bool p2p,
> -                                                 Error **errp)
> -{
> -    AudioMixengBackend *d = AUDIO_MIXENG_BACKEND(be);
> -
> -    if (!d->drv->set_dbus_server) {
> -        return false;
> -    }
> -
> -    return d->drv->set_dbus_server(be, manager, p2p, errp);
> -}
> -
> -#endif
> -
>   static void audio_mixeng_backend_class_init(ObjectClass *klass, const void *data)
>   {
>       AudioBackendClass *be = AUDIO_BACKEND_CLASS(klass);
>   
>       be->get_id = audio_mixeng_backend_get_id;
> -#ifdef CONFIG_GIO
> -    be->set_dbus_server = audio_mixeng_backend_set_dbus_server;
> -#endif
>   }
>   
>   static void audio_mixeng_backend_init(Object *obj)
> @@ -2263,12 +2243,9 @@ AudioBackend *audio_be_by_name(const char *name, Error **errp)
>   #ifdef CONFIG_GIO
>   bool audio_be_can_set_dbus_server(AudioBackend *be)
>   {
> -    /*
> -     * TODO:
> -     * AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> -     * return klass->set_dbus_server != NULL;
> -     */
> -    return AUDIO_MIXENG_BACKEND(be)->drv->set_dbus_server != NULL;
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->set_dbus_server != NULL;
>   }
>   
>   bool audio_be_set_dbus_server(AudioBackend *be,
> diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> index 789d72f6903..9b25269a2d9 100644
> --- a/audio/dbusaudio.c
> +++ b/audio/dbusaudio.c
> @@ -54,13 +54,6 @@ struct AudioDbus {
>   
>   static struct audio_driver dbus_audio_driver;
>   
> -static void audio_dbus_class_init(ObjectClass *klass, const void *data)
> -{
> -    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> -
> -    k->driver = &dbus_audio_driver;
> -}
> -
>   typedef struct DBusAudio {
>       Audiodev *dev;
>       GDBusObjectManagerServer *server;
> @@ -720,7 +713,6 @@ static struct audio_driver dbus_audio_driver = {
>       .name            = "dbus",
>       .init            = dbus_audio_init,
>       .fini            = dbus_audio_fini,
> -    .set_dbus_server = dbus_audio_set_server,
>       .pcm_ops         = &dbus_pcm_ops,
>       .max_voices_out  = INT_MAX,
>       .max_voices_in   = INT_MAX,
> @@ -728,6 +720,15 @@ static struct audio_driver dbus_audio_driver = {
>       .voice_size_in   = sizeof(DBusVoiceIn)
>   };
>   
> +static void audio_dbus_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    b->set_dbus_server = dbus_audio_set_server;
> +    k->driver = &dbus_audio_driver;
> +}
> +
>   static const TypeInfo audio_dbus_info = {
>       .name = TYPE_AUDIO_DBUS,
>       .parent = TYPE_AUDIO_MIXENG_BACKEND,

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


