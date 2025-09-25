Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21BACAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kFL-0000CQ-5K; Thu, 25 Sep 2025 07:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDt-0006aW-JN; Thu, 25 Sep 2025 07:33:19 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDm-0008O8-S5; Thu, 25 Sep 2025 07:33:17 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58P2J7xa2034377; Thu, 25 Sep 2025 04:32:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=q54MZtLMQR80krtnG2BA/y4cgR4bMp2erfVibh7Bf
 +Y=; b=2h6smT+0j+pNGZYL/vgq3soPymbptURsW47rO2hvawzXg5nYcUWv4y3D+
 bH0OaHp41xazJ/lzRQZl3HxeneYO4s17Q9nYfW/rV6pQYJgXEZ0G/MjDH0UPWVwH
 Cte7gk2TkkCqs0/WFc+JhQoQarz+/w2sGSO9wuPGa6hdN9gH3qb2We5F75OHANq3
 rQxXRvHfbkBdhFoYZjl6Ta+1oHgX1i7KgB3w4b+v3r2S+jz57gJWWYlDhmeyp2E9
 HZ8zqSRQjSvXLOdiRu2hVMtga4OBvC7OYA/xS1+m25jWMGtSlIP/I0y82jESEGrH
 7SSZmBRUTc3nFCVS1XZFDhrYmKY4Q==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021117.outbound.protection.outlook.com [40.107.208.117])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49cj95tkns-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:32:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CF39BWvTVznNW2UmFI3IjMLhPxz7luUuCF7AMVZIwzZZG9p4YVJ6tbjwKQAXUIKSxKPC4Dv7Uw43BxcPhO3zNP3MubGUXWOhbmMewy9Cxg0qHfMFCg1VoGuHG62P5xxL1CkcWKr/7AmXR6491mVOIoVXtSIyouPCL2nBOYvIiHzFOW4sx1820k0URSLGDCO7xvIqXNB3SXtR2Jas7bHrVkG2/Z7L/PCiTtFHOn6g94UpLqBtAIYmDrP7TyiBuWDIDGyAHfGB2+KSETUU0EhPW3Mz2JI+G+QkCxn4LYFL+jYzq0uing33tGJNXWZaIAVD6LSrBebOdrF5y0rplWMcdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q54MZtLMQR80krtnG2BA/y4cgR4bMp2erfVibh7Bf+Y=;
 b=oFjx58SS4mrueQPyRrgPXUuBxrD40faHmK6vqecjMuS+CK4giV/kvyzouQfGmJeXihoAfpX2LR4SWwvdCZljuOhuDI6lCSDrfClPwuxqevvZSm81rFpBz+0TtKPYzuja457Dyz5yBT5tITLFFgTbJ4ktxXD+pjrwilP/eyOHbxrgI+98ZzWBPUDPrXVLiIEe5jKkhU699l85tZJmdRKGrmTbMrS9iMGRdhs1VdAT+ieoSlTw6tWU4NC/QSdI7rxLwDqM7UToDDuaGUscfG2G8O9w+thZB2NRnWnMEwrdYAO80wx6KHBOrnOqoj7AfYoq2fD7PxvZoHSwVqVGUmAJsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q54MZtLMQR80krtnG2BA/y4cgR4bMp2erfVibh7Bf+Y=;
 b=xWI9zMp87pk5aQtx9YzqV67mq8Fp2FwgtcnwOI1zpybLLmJnW3S/xWKQdM+IzhBRLVI8oxP+LOm6X3E3v9E1mlBNCi8/jDn60Ox7/jNQR/NbP/nfIL9hsgHLJWXo+EkKfcmu7v/Gu0XhgUcNUymOaWLZeqpSJcZRzsuEH3nLsB5gdf83OA5m6NFSfPswA5PfI4+lhboEpJ0Irdthw+IuaM/zgtfqESNtVfyWjbRPw1u2YiAR57Mb0spT99ze4fWxBhs6CU3p6yeHg2MXyhRuqKyCryvgNTX5cHDB2R2m/DcFuqLFFFv4SfuobkwfD2yjzY8G/oi4JBjDNwKuxVQMdw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9854.namprd02.prod.outlook.com (2603:10b6:208:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 11:32:55 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:32:55 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 15/28] vfio/pci.c: rename vfio_pci_dev_info to vfio_pci_info
Date: Thu, 25 Sep 2025 12:31:23 +0100
Message-ID: <20250925113159.1760317-16-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0409.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9854:EE_
X-MS-Office365-Filtering-Correlation-Id: 14856f8c-9acd-49e8-5d73-08ddfc274555
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWpWYkpnSUVWanhkV2NoMzNpSGttMHo4bGg0UytJOGFuK1FDNFdCRDYzUHAw?=
 =?utf-8?B?eEVQUkg4MGx3dzhWM2NlNVpYUWdJckszSVJXSzk3bFpXRWJxTDQ4NTN5dlZD?=
 =?utf-8?B?cWQyUVFMZERkK3dmRmUrUFc3MEYrdjA4b01YckQrUGlTYlpFOVExc0wxcTJR?=
 =?utf-8?B?eFlWdWJCby9lMFBpZHJVODNwVWNxSTRWYnNyYnk2M2FYeVRPaUVDVHhibC90?=
 =?utf-8?B?N0FFb3RudHFnbDhUM2VXU2UxWUU3Q0sxYnJGZXl1cWUvRVQ1bm5IOHVGcTZ4?=
 =?utf-8?B?NmlzU0VRVnU4ajNHSit5TW5yVHFUNTltRHlTS3FTZUlUQTBLVENBK0E4dUZu?=
 =?utf-8?B?QXgrVytkalBiVENtdXowbkVYMnNqbmpiWmo3SlhRcWh3SmRDcnVjS3hKOVdk?=
 =?utf-8?B?dXkyOEYyRTQ3SHl0ZDE5L0lYd0wvTmwzOUFBQXFDdTdWSVZ6WWhEL2V5eW1W?=
 =?utf-8?B?NEFjNHdhTWloaytHcXVoVkhldVRONWNVQ3l1c1ovT2xGa2ZISTI1aS8zcXFZ?=
 =?utf-8?B?aTRNajM3SE1QZ2ErUm5VOG1jVFZhTlpsMnVsT21SSW52RWxJTkNxT2p5ZnZT?=
 =?utf-8?B?S3JsZzN2VTByck5Eek5LaFl4MlZPRHRBTlpJQ3ZBQ2VqQmdudHNScE0zOXRI?=
 =?utf-8?B?QnpOL0luclVDaTdTM3RoalNKazhIL0lrQm5SeEQ1cnlMYkN4SmdBQ2NYWDcr?=
 =?utf-8?B?NXFsNmk5aFVLTm41RTB6K0ZrQzJnVVpkOEN4N1lCYisrdnV1RzBoY0FJN3pj?=
 =?utf-8?B?WUNNOXFid2dvcWxGNERMQW9mNVdMSTZNU1dtR0RyaGY0Wk9NeGwvT2xnamd1?=
 =?utf-8?B?UWx6ZGRxMUxYMld0OW50RnJMSW9PQmMwbENpdG9IYlIxSUlKQWFTbVF6Q1ZY?=
 =?utf-8?B?S0U0QzExRTIvMTFtZDVZaWFUUFBjdFRNZHBiTXB0bVZQeTFGMzlDRUxMbHpF?=
 =?utf-8?B?cVl2RlRFN0xhWUVwbFJocUM3RGNJUUZ0a1dmdHpBZDFxNkRYMi9xR0NqZkdh?=
 =?utf-8?B?M2xkQU51RWppQ0JLRzEvUEczNG1yZDU5S0xaRjFwd3ZyTEtwclNKeTVlRE5I?=
 =?utf-8?B?ZW9LZ1lMblFsYnE4bi9RSlpBWEgxY1dieDdsdkw4ci9KaFh3RWhBdTlZMkhp?=
 =?utf-8?B?QXVHZ2ZqMi9HL2NNemptTUJadHpkSkxsdEJFM0tIRWRYZFNFK0RpUWZNSFNW?=
 =?utf-8?B?QmNmYVRSZVY1MDVHZnV0NncrenNCZll4RFljYmlZdjNiS0crcGowRzhyYlZw?=
 =?utf-8?B?NDcxYWc1LzJRSHRrT3FhRUdnL29Wa1M5Ujdkd25scGR6REpjVXBJekQ5SDdm?=
 =?utf-8?B?TDJkWUtCZ0t4VkdWVG52YXVCdGZDTDdhclZoYmZsLzJ4VVNvTFczM29lVkE2?=
 =?utf-8?B?QU4wRDlMWGMwM295UFVybWV3R2JkbElZZDlIbzg2VEhmOHhDTlY4M2ZTSTl4?=
 =?utf-8?B?UmM5QUdYQjdUeW9tS21mb2dQbVpWc01TRFJHVUQ1VVNzWE9RaXZjNDNKdzRu?=
 =?utf-8?B?VDREMHlacFl0dVlldk40ZW41dkd4M3V4RkpTMjdLK09jUW51YzhqeHhTblNH?=
 =?utf-8?B?SFF2WlVtaDFETG9lMW1MTVhLOW4zRUwyUkxQcHVuQ0dhaE5ycWEzYnNRS3Nm?=
 =?utf-8?B?eC8yYy9lb0pTL0d3TUdhYlF5b3V2VlJrelpUemlIQ2JlNS9DUkVNazZ4NGZ6?=
 =?utf-8?B?UmFyRHJ5L1NSYjF2bTQzMk41am8xeCs4UTlRdlRwSllKNnZsZU9DZjhzaFY4?=
 =?utf-8?B?R25RRHFVM1lRSDk4Yjh6UTM3Z1hqTnc4RFRUSTRNYSt4S0QzWFJsNzJGRkIz?=
 =?utf-8?B?VXJUaWpiZCtPZ0pwQUYyWllRb0VqQ3NwV1RScjNIMTlVV3lRTitKaDVXcVRC?=
 =?utf-8?B?OUZ5N2dGZklRZDNNdVJEOGNQKy9jTHNJNTdJenRxRDZzYVU2V0R2bmJVODNi?=
 =?utf-8?B?TVkrcVJUYmRIR2d5TTQzQVFWMldPc0g5UHVlNGtoWHFRbXpKN1F6RmZOWUFl?=
 =?utf-8?Q?Wvv+cdgTXAPlffrNsZIx4U6P16+bII=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0dOaW1RbGw1ajVhTU1pWFgzZUtxNUNSSXd5eE5UU2l3MTdoK3JXSmxhbU9U?=
 =?utf-8?B?UHBNM3l1QjZJRkFxWlpMWXNjN2NqQ3FsRFlaNTNseVBVamQzRTBNVTArWjFH?=
 =?utf-8?B?LzdUd1FibEZMbnlXQTgxMFJ1NXc2ZWt3Nk42SjZhZHgzbENrWU9acHFhdVZx?=
 =?utf-8?B?U3loMEpPUENsdEtZQm5UcE9rOE4yeFh3VVJjaHgrbUFqVFErd2dEdWhVMzJm?=
 =?utf-8?B?UU9UWEFVcFhRQ0pZZ0lIZjJscDAwcm1OUktobHJCZjZMSWJCaUNYZzFnQ0ZX?=
 =?utf-8?B?NTgvOGthcHk4KzN3RDJHcXorbFZGc0FkZ2F0TWE0TXpUdGIwd09yYys4YUZw?=
 =?utf-8?B?dUVHbjVnMU5GL1hORUgvWkFSdFFLaEYwZjJNanp4TTZ4TTl2YkZZUjJDOGdZ?=
 =?utf-8?B?NDg4czZYdzhkNm5VdkoxaUZsYTNSRllqSzA5VUxjaDRERkJhSEcxOVJKTHpl?=
 =?utf-8?B?eUV2NEI1S0tTYy9JVFVnSlhNcU14dEx0UGhLWS8zcEVUYWU3aTc4SXJJa1cr?=
 =?utf-8?B?OXZvMzNSbDFwZm91OXNYczNxbnNreXE2K2Y5NXNyb1g3TWRmVEFZL2VwbDhM?=
 =?utf-8?B?U0tWZXU3aStOdCs5S2MwTjZIbnEwUWN3Y3lSa01MNXhQSmJQTDd2YklzK1NH?=
 =?utf-8?B?Z2wzb2VMd21Dd25qRjB0MGJsZTlndEppSzhoRVE0YWxSZTdRUFliekJuSkI3?=
 =?utf-8?B?MUR0TFFYNzFHdTZJdGFKYTQzQnpkS2xmRTF1ZWRRZ1NKQWFhMFcwRlR1NVdZ?=
 =?utf-8?B?U2Y2UVAvM0dmTjI3VzFNYkVXYldzcHQ1eGVUM29uRmFKR24zWGlrMGhQMmpw?=
 =?utf-8?B?eFpiMWxIMEZEN2g1OEU3MDBFN09WQm5QVnZhdnlhT3U0WExrb0VpdWRFK2Yr?=
 =?utf-8?B?WXNNbWErTDlKWlFWb0hFTnRvelJtYnREOHlEMGVvRFQ5emNSVDA1YXV1ajd1?=
 =?utf-8?B?Sjl4UU9YUld0T2EwTHBEQmhYbWZad2FkOUdzTTRlU05vZG9xMG94R09LQXd1?=
 =?utf-8?B?bHRadHpGelFtR2hnTy82ZUEyVmdjMHFDcC8xZkpLdXFIK25SZHQ5THVSaUti?=
 =?utf-8?B?ak55UW8yU1dmZUJFemtwOTlQbm0vVHJJeHpYYnlBUnpNcnBiVVV5SG9WdUtk?=
 =?utf-8?B?bHlZMml2N3VNKytqa1hBait5VXRQU3pjVHlxUmhsTW4wVXBxZzBTb0lQRDQ5?=
 =?utf-8?B?SFppSnc4aEY0bnJ3dmFacWZzUE9yYXRZUXpqOVRpQkNQU0czbDJXdzJEWUUv?=
 =?utf-8?B?bmdMNGhtelJJd1VvamdzZDhIMmVVUGExNG5SWS9zY3V3WGJTbEFTUmNOQXJ0?=
 =?utf-8?B?cUE0emlZTlV5bzBPS0h1QU9wYURWNVdRL2FRNFRWaU9EOE1paU9FaitkT0p1?=
 =?utf-8?B?SEJpak1TWEMvUU9OS0hycDMwNkwxVnJ0Um00Q2taMXlibjc2aFNxd3ZDUVZo?=
 =?utf-8?B?U3pWYlRHWlNCUTc5a3JsaXlSTjdhQ0QxeTYzUWNvT3cydmJ4WGd0eSt1L3RZ?=
 =?utf-8?B?L1V0TnZUdGFyUURRR0JoYmtDQVpiQWNIQzY4V0s3K0ZuQXNLRGN1S2w0YzJT?=
 =?utf-8?B?cyswV0hWVjNINk94WHlLSmswdXp3MjdhWS9NbHZUdm4vWFRGOW9WTjVQM3VJ?=
 =?utf-8?B?dEh3RjU1NEVGZFVCTWhXaHhKWG9tYVpOdlhzL0xVNGtRR2tQa2QxMXNVM0V3?=
 =?utf-8?B?ZnM3OWJXcmNCcXdNWk50QlBnWlBmZkVQREtDSXdSMktvRCt1WmRXZlowb04v?=
 =?utf-8?B?ZlM4RFA2N0E3clhRMkFVSVAyQk8xdnV5TUVkL3Q5RnhsREp0Slc1QXdtdGdC?=
 =?utf-8?B?dmN6dEc4blI3RGpXMG5oeDRNY1ZKVFJHRis4ZGlnamJDRWtYUWJ1dTFZQW1m?=
 =?utf-8?B?SjNLSS8vbzdJNEZjWjA5a2FJcjBMMENCdndGOS9EUUhNeDRybXNiSlRaTmk3?=
 =?utf-8?B?V3BnZzBIckJ4dktCSkVJVjdwa3Rkc3BFVHFhN0NVYks5WnpjUTRFRDR0V1l6?=
 =?utf-8?B?RTZDa2xrc3YvWlA5dUVtUThBYWZ4NzVEOWF1YjAwcmkrVGhJY2gyOEtYV3Ju?=
 =?utf-8?B?MzErZHp2RVdtU240eWtxejZtOHJSWUE2Q1ducmRPVGUwZnBDTlZJSm5KeUc3?=
 =?utf-8?B?RHNyaUNDRzZGaFdTUmd6M0wrSU1PZGlQcG82cC9ON3RYSDgwMmtMUFpZWHBV?=
 =?utf-8?B?aUdVS0NyNW94ZDlGUlVkQm53N2NGdGtXWGFxTmFBayszaWZZSlcxNWxRLzNx?=
 =?utf-8?B?ZVQrNWVzNVFjOGtKa0hSWVhsOUh3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14856f8c-9acd-49e8-5d73-08ddfc274555
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:32:55.4426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i72meAFeWQidytM2Gt3uEPDHrFI0hJUp8ek/Lg73nqyWgf449essbJWkvIv9hx00V2+LqwTkysw1c9izzGUv7w31EUGfbC//4gjNpWc6ewA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9854
X-Authority-Analysis: v=2.4 cv=fPk53Yae c=1 sm=1 tr=0 ts=68d52869 cx=c_pps
 a=fJIB0T+C2yAfE4P2TQxPqg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=-an67RP_g-7o1LT8KO4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mPzwcqePFPnk0e59NxvEJzxkUJ2rLuFj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfXy5JWRUzSngoe
 QA6TYU4N8EGYjMGv24tf0lniW/u1istOKa34v2eXJMiCh2O/u9ApWnCxE4kYegOHNnVTJ1Nh5Lm
 2RwArJ19QAvSdOs0GthpMQaYwgJxp03rgHH2G/5oKsJWRXJFlSxg7rtq1X+sZPPWRVYLFAVrPpT
 +l93YNXxbGwPtaGPDKVw9aHn21OIcoby89gOC1doh0SmVXmAyF+mVR1QI7sbMuv2hCfbdvns34m
 PfQCBFzzWHHLpEre9nLsWeLmtCRWOtHudLwZGpYCrQExHA277HohzVoKkDon0Sc4fLu6KcAhYyb
 Q+RtVlN0T26M1re06H5EuC+8CFpNz+d8CNPEkPRK9OhpXd4XYX1ngM0bJQSIc0=
X-Proofpoint-ORIG-GUID: mPzwcqePFPnk0e59NxvEJzxkUJ2rLuFj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

This changes the prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 1fd087de3c..479def72c5 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3912,7 +3912,7 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
                                           "multifd channels");
 }
 
-static const TypeInfo vfio_pci_dev_info = {
+static const TypeInfo vfio_pci_info = {
     .name = TYPE_VFIO_PCI,
     .parent = TYPE_VFIO_PCI_BASE,
     .class_init = vfio_pci_class_init,
@@ -3970,7 +3970,7 @@ static void register_vfio_pci_dev_type(void)
     vfio_pci_migration_multifd_transfer_prop.realized_set_allowed = true;
 
     type_register_static(&vfio_pci_base_dev_info);
-    type_register_static(&vfio_pci_dev_info);
+    type_register_static(&vfio_pci_info);
     type_register_static(&vfio_pci_nohotplug_dev_info);
 }
 
-- 
2.43.0


