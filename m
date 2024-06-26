Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEF3C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 12:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMRW1-0001TH-EA; Wed, 26 Jun 2024 08:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sMRVy-0001T7-P8
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 08:12:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sMRVw-0003Vc-L7
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 08:12:42 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q9sIDU002156;
 Wed, 26 Jun 2024 12:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=UOM4RIuvCOqJqHaaQ2jPs+bwXhScnC7/lS4Vxdd4hDY=; b=
 ZiRi2SFzP77dpZ3v6c9qANsAgBYyvvkFYQ6CbMybKKqLvO8/w5xx4geAcdfCKY5O
 IkDSeIBH6G9xb1752obP/x9jKNHClSnx77dFro/NvEeOf7N0KnJdAfbr3TuXwFfk
 9B7x3eP2TxbfhCV43BXWqYfx6KLPSN2qdYgun7js66I3Zfzpdd/9FBHwg4tTUFW4
 31NF4p//SPXahmtihq44eP9AiV482Fhh2A4aBNel8Y0FNezj7Y151L6zDnZudLml
 BJSMsGp1TpbUHrgTb2kkiNp5XPAWRo4Qof3VCh7TgApTbz6GcAWC+RiEd3BKWjOy
 9EG7mGWdZzGbGtOp8icz+w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywq5t368d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2024 12:12:31 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45QC4J6i037056; Wed, 26 Jun 2024 12:12:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3ywn29extq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2024 12:12:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tnu/zSJ7RpYe4zeD139RXLmkIOTnfHT1cGHmC7uTUp1AqpM7AFj7Q4K5TmNr+Af1iyyy2UGQo79DLSX0PBhmFRXltN4Fq+iSGsWZcoa15zo/MO7RmeuRzVn4outj5VUTpeioWRDZexauLVxsWd72xxCEGU9maUzDULmI36dHZYorpoazRG/jYVhrrZEKiTljAj56HKHOajM41pybqtt3P1LKP4ntDw+4P+8zYx8bmfGsvovOCdIJR1/mMguCmjz+9JnmxMVLb2VGD0fdniyg+EMQWYO9H6fCg3n9YVT6ePOjHR0DhCkb0ZwvSS6d+6qwDyKW5OH7xCBCwbRrZFBL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOM4RIuvCOqJqHaaQ2jPs+bwXhScnC7/lS4Vxdd4hDY=;
 b=SahBSP0shCQMLLjhjqeTgnyJcnkrNuiHMYNVItTY5Qn189/NJpaoYDXqvaQn2xK46TEs4tJ1B053TvdhjhG/O1DEfHiYVcem1bjsKk6s1+LQ20I2i7Ny1F3i/k2q7Pflc4ZLNp6bZ0oiTIntZmcWqVyL4QYgWkdbO/bJywJ9FsHCxMMPOFhS+f7JFr1HCXJ/CgFjWq2Nb2VY0S9kY35Cr+ZZVTO5U69EaiEyhDBLwdZhPPUhvXsHfwcBF++Xer3ijihFrWTeBvg5LrscruJUVUMxDbXa3Ic2sSvKm2MnlbU/Pdu2JB1hk/GisY8Zkdq7YC9WfUbeNHcLtmedsd32Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOM4RIuvCOqJqHaaQ2jPs+bwXhScnC7/lS4Vxdd4hDY=;
 b=vUdmIW0JmhEYK1jBiwQrilORvl5J95QTnKjrJ0lXfzNHoTkkI5n+eo1sbrckRxtJzPNUv6UAooZspmxMRKFWX4NNiupmc+Jr8nP1qT7kU1bv6o5KpDPRiHUCZap7s51LIzWZ7FjKuQznK4vhaozOdYB9U5G73xGJ7cK+65oC5Rg=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CYXPR10MB7950.namprd10.prod.outlook.com (2603:10b6:930:db::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 12:12:28 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 12:12:28 +0000
Message-ID: <32366d3f-453e-4f34-98e6-70cbf83f0490@oracle.com>
Date: Wed, 26 Jun 2024 13:12:15 +0100
Subject: Re: [PATCH RFC 2/2] migration: abort on destination if switchover
 limit exceeded
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Elena Ufimtseva
 <elena.ufimtseva@oracle.com>, qemu-devel@nongnu.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com
References: <20240621143221.198784-1-elena.ufimtseva@oracle.com>
 <20240621143221.198784-3-elena.ufimtseva@oracle.com> <ZnnL42_iDip3hfUh@x1n>
 <9eeea2a9-b3ef-4791-94de-fb06ad2bd9b4@oracle.com> <ZnrZ9W6WpvmDBpgv@x1n>
 <ZnsOdiHACtL90f3J@redhat.com>
 <9b6c50d2-5c42-48b2-8e0b-b6304f225679@oracle.com>
 <Znv81nAGJRb85wBs@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <Znv81nAGJRb85wBs@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CYXPR10MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 9700c264-f9f6-4704-36cc-08dc95d93eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHI5TDMrSlpqdG05bjBpVDNKL0ljRm9ITWh5Ulh6czh2bjA1NmJvOVBDb01Z?=
 =?utf-8?B?RmVnUldjT2NtcUZaNlJjRUFxcXM3NEVwSEdGY251WkhjZ0Z3YlZQd1p4RFUz?=
 =?utf-8?B?Q2t5VW5ScEk2akhKdUFYOHFyRkFBRWdvbzh5QUw0WW16V1BMYjM5M29iNUl6?=
 =?utf-8?B?WklmUDJRTU9BTVpuV0FwdEZGZGNqeTlKS1JkNXVPalVpVW53YVBrMDRhU0s1?=
 =?utf-8?B?R2NzSDUzWkliOW9VaHVMV0h5dStTTmtIS3RpQTlwSlI1ckZEWVk0VjFoRkk3?=
 =?utf-8?B?MnpBTms3b1lBSUtmVmtRcEVqaGh6dDdTbnA3bWRnd3VSR0ljQ3VHSXEyL00z?=
 =?utf-8?B?UFhyZ1o2dnQxZUsvRytaME1SOEgyRithbDQ0N1ZNR2VsS2k0NVNsdVRSQzJH?=
 =?utf-8?B?Unl1Um9Wa1pwbzVhQU90WjdNbXN0MVhmcDJQWkJWWEtXc2JqM0duY0gwY3du?=
 =?utf-8?B?cFFudlg4NzJOSUdyaHJJRllqWUxSdjZkOTdvT3ovSWtKeUJvaFBheHNiQnhW?=
 =?utf-8?B?Nk5qWGNXNUpFaUp6YnRPcnFSWE4rbXgxMUJZVVpidmN1NjBtKzBYc3ZBTWdR?=
 =?utf-8?B?dFNJZEtzWXo4OW9UQWlNakpDZzRJRUxIRG94dUpsb3E5YzQzeU15bW1kV1Zs?=
 =?utf-8?B?TnlCTmdBc0tPRXZYazBtT1puY3dod3dpa2o5dkovQVFxZ1VYdUNtNENYSUVa?=
 =?utf-8?B?eTJOWWtwZlZmT090THE5ckhEZXpZS0hxKzRuQTQwWjBQd0tXb3dOVlJOcVpE?=
 =?utf-8?B?TlFQTlpwMnZHbTdBNENsOFdYbHN4MGxYNVhNNUhOb3Q5MzYyRmxEdDd3UGpJ?=
 =?utf-8?B?QW1pbTFUNHdHU0ZIVUl0MFRGdkovSk9TVkwrbExweEY4RUdXeFhleStSTVdD?=
 =?utf-8?B?a1lESW4vdjlWT1Z0d1UrQjE5NXNKOG55TS9VZ0c4b0xrWnZFMmVGZUZublhC?=
 =?utf-8?B?MER6Zlg4bUd0ZEFnc3hmbmlPWEFVSzBmUmRObEtKbWZmNFNMN0VJQXJTaHBS?=
 =?utf-8?B?amtlaHMrWkUvYVN6QzBWNDMzSnQwTHJPQUp4SnhxRVJDWTRxZUhJWlpSSUYz?=
 =?utf-8?B?dk9paXpQR2ttQ05kSUZFaGFmWGVQcjNucjVyV2k2S0t1R2FFN1hFMm9iQU9B?=
 =?utf-8?B?amNUQ1gwVitvNWFWUWVvaWNQUnpoa0pRbnlJK0IzQnlMaXdoeHpiVnh5Uk0x?=
 =?utf-8?B?R1FnNnhaelN3RGFpUHpjWnNtajE0WVVrMWRiRVl4bzhmTU9kNkVsQ0hJWUFt?=
 =?utf-8?B?RzMxMG1pUUM0YnV5SHJSVTlQK0xKMVdkZ2NSOVV2TUJxbGJxQVJnQk9EUlFt?=
 =?utf-8?B?dVZIRnVrMjd6V2tBWkc2L3kvY3Uxakcwc3NSSGd1aHg4azI2YVVhN0lCWlpS?=
 =?utf-8?B?YXAwMy9rRlp5RVVmV0JuTk5zTjB5eFg3azdYdzR4dmtLUFhES0piTVV0TkFp?=
 =?utf-8?B?YXRlcTNTL0FtTGt2Uk1PWXJYSnFIeHkzU04wSHRpZ1hnd0RsMERKMUVLTFFB?=
 =?utf-8?B?a3pHb1NOK0FmUHR6OUZaVmJPc09TS09VWWFBZDNZZkJYcnM5eE90QUZYVU5B?=
 =?utf-8?B?VkxjOFlRREpqK0VIZkxnNjZMQUhqR2o3cTBpVGpiOExTVWJQMkFURTNkKzI3?=
 =?utf-8?B?T3hqbTVDN0l4Y3d2WENpUFRhZTNXbW1ESGVXakJkZXAvMXp1ZUlEZ1Y1Qm1P?=
 =?utf-8?B?NGhGSlAxNDRKOW5aU2dLQU9waXljSk55aXpmRFh6MVpGUnFuYzBEZ2l6Z0pT?=
 =?utf-8?Q?67OTxutYx3YPhMeuf4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230038)(366014)(376012)(7416012)(1800799022); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3FQUko3aEE3ZHl0MXFwN3hjSDBQQ1RQeWFQV0J0bmlFMWtPK3Q0Znh5THRN?=
 =?utf-8?B?ckhybjd0d01PbU4zTDVnNkVCZ3NlaGlsRXBoSzJPNFR2NDdNMDY5Und6OWFW?=
 =?utf-8?B?TDZDUG5sbWNjazlVSm9ZeFZmSVd2bElHaDJTVEM5aTVVTkh2dUdpbVFVQ0ZH?=
 =?utf-8?B?Y3greFRMTWxiZkhhZUhUR1AvZGtDZnhYeno3NVlGcjcraFJOUXdKa1MrRUNa?=
 =?utf-8?B?VFBkdkxtQUJtNmdtN2k4aHhJTlhsNmJGYkFtUzhpdXhmamZrUnNqbDhVWE5R?=
 =?utf-8?B?YWMzUjVnT0oyb0Q2ZWZlVFFod3Q1MVF0cXNLVkQ3MnpRS2VlZVJhT1g0V3Fq?=
 =?utf-8?B?ZWFoRnk3NjJRWVdWNDV4K3dJanlPWnZpbzEwK2l1U2NJTk5EU3gvV2FSeC9k?=
 =?utf-8?B?Yis1cldvQk95MWdYMjJ1ZEJNenV0SG9OcVdKblZRS2xYdGZldm1kVWcrTnhu?=
 =?utf-8?B?QkRVN2JzK29PcDNGMllyWXBwWnFnWm5SU1VJMlgyUjRGVjVEQ0wrblNKMjly?=
 =?utf-8?B?YkMzajMxQm8wS1ByL0NGVERBYXg1dm1jaVpmTU1kTlQzcWxZbHI2M1pZaW9L?=
 =?utf-8?B?SCtOU3RRbEg3ZU05emtrL2NjcTdyK2k4cHE2RWZUOUczZWhFaUhsaXFESmF3?=
 =?utf-8?B?Mk1tUXdjeVEvL25aMUo4MURJKzRxWS9NOHRIUFQrUCtYTW0yd0pzeElwNjJB?=
 =?utf-8?B?Q1BOdHMweDFXVzdqMCtOU3JjRHVtcGlhUTZYeE9paUZYeC96aFhZNjkwZzhE?=
 =?utf-8?B?QlBrZUt2dWliTG5DUnZvc3N6cUxIZGRHKzB1RWNxdWxGL0VpT25VQlhqdnNX?=
 =?utf-8?B?U1oySW0zUCtWNGlJellvVmRSTGVicGdRUmNRTDNEeHBkWEt5a2pyWG1VT0hI?=
 =?utf-8?B?Uk4yUUo2d2FxTDk4SGo5c2oyZXZqc0ppRitJK0hIMXJ0WDBTTlVrM1NTNzdm?=
 =?utf-8?B?TklEb3ZnakRaQkZHQURyTXdYWWUzSXl2a3dlNHNpTzZVV3JraFpsWkR1dEpS?=
 =?utf-8?B?eUxTNDNPdUpVUDh1dkRuckRkdFAraFdTQ2lsZ0Ywak9DYWJ3ZlRnVlRqRy9t?=
 =?utf-8?B?OW5DZEJjZmhNZHh0TEE5MUszc3doUWp3eWJNTmJ1SnFnY0pMdkJMdDllbjUy?=
 =?utf-8?B?Lzk5cnN0RHNRRWxLUC9KSnNXSnB0RFpQUkdmVG9rUHUvQXFiVEFsR3ZhclVp?=
 =?utf-8?B?YVd0OVJ5WGJOUXgxNGtvVXkzNllMdzBsUkhyM3BKTmVEV25KZzNuQmhOcHZw?=
 =?utf-8?B?TnkxV21CRi9ER1FVMnQyaWZxbjRMdUNlL2xDb05KYzNXVFFxRzdOV2VUc0FS?=
 =?utf-8?B?VittZnJkRURYYnFuck5oN2QwUktmYUt4V3ZLSDJqU2hhMEpOaHBGQ3lTSDd6?=
 =?utf-8?B?c1ltT0ptSHU5TkVTeThIcE5CYko0bjF4Y2VtT0dyK2JNVjRyZ3F4dlFQL1R1?=
 =?utf-8?B?bWMyVXl3M3FqLzNIN1FhMGpvbng1bnlod053TkJ5c3lZakg2cVZWcFFSZGRZ?=
 =?utf-8?B?S3BMY25odnlpOEM4Z3k5Z0UzUTFoa2J6TWh0dGVqUkUxTEJQN00xYk9IOHBJ?=
 =?utf-8?B?bFQ2Sy9wSERBT2RqU3NWTzZzdnJDL3VEelBUN0YyMWFoUFk1ak1pcm8rVFBs?=
 =?utf-8?B?N3pYTXpyTFVzQUtyT2pvem1yTHdFWEhzajBZVmFVTnRMRWJtME5VaUs2NmZs?=
 =?utf-8?B?KzZyRnI3b3Z5UEp5TkFTamxaVVVQUzN6d29aa3llTnpPUllydlQzcU1Ia29W?=
 =?utf-8?B?SXY2OGpNU0wzZVc0Z1Q3UHZmc1RjTmErdDZoTEJxOS9tcHptRkU4ajUrc0kr?=
 =?utf-8?B?cTV1cTlvV0ZReVlUbnlBUU9pSFdpM0dudXVOeU1rTjg4U2ZiS2tKclMreFd6?=
 =?utf-8?B?R1I5OVk1dWRWK3Zic0N0TDNXcjRVS2Rud2pqSXc0WG92bjlzazlKYmg1VzJV?=
 =?utf-8?B?WXZKRTFBQUxjcmVvM2VnbzN0cXVLQm45d05SMUdOdWU4a1FDZlRzZDJZZENm?=
 =?utf-8?B?N2kvSkRkdklwWC9iTnk3WDhKeXZuU3FtN3RjUVZQdFMreDdpaUNDa1lCMDJM?=
 =?utf-8?B?RllPQ3gzaTVScU41UzV5MFVOUElrSE8rcFdzRmVWT0NJRDV4cy9nVVlicEo4?=
 =?utf-8?B?SnlnRWx0R2hpRHY3ZWZYbHhPblE5TlRFRVVPdFpZZ2ZudWJnd0UvZkd1ekJh?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2Ma7dzAuZfxmO816ErK2o7jAbOP335zWOrJQz2rTQfFmOZCL2sffB3QLuUHOQJkWXbcvK2/tJ3mkQcOXts/mMHKsv6e+wzZ9vET3PtvFkHa9kra4zS50aLgGGPRo8PYRdAKXwfjPZsE5+iTpDnbzyHabxErY3Ma5u296GoT1XDjkHTNAONnDOsQEDfyVK9gUatKjHS/N12cAjU7W+UQ2g1KdVB1z5MsM1fvuWpOc8P36FJfjjOrzlbSooNfXvQOUXTZI+aL3bJUZduS+RNnOvmD9tHVpxkFvilhbdq13dssgCCRfgQTwIDsKexICg4CMKRewi1jUgNLTmOAW1RUUqO6Wd3XohEwQ3x4mMeDqmLls3ID2QSABNiHBHiCFGnQ8YaQhISxAJX/GSeEt63KR4us0nQJE/3lEMdxW1h3zRi/bL9cLj1a436fxV9cD1aVl6qGcC07hd0W6xnqVcBafgxA5j7dHeITwag2134/+6aMItS7ViNgQC7t8ntcL83ARz1/EDCVUI5V7H6sRMUpoW8s7T2+5hf5faVvsDLx1MLmHE8v6OxN/phD2s6IQoqvJk8QV+qunvz3FbclumzwUlLrnalO9ECj0AcNIrnovCLU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9700c264-f9f6-4704-36cc-08dc95d93eff
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 12:12:27.9769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxsxXUNn6SsXdoJ2bZmVCLvtxf1nVfa1pgbdk147Q/O+a+JG0/1f9GdXFq+ccRyQYdJedXhYDNhMTp+gp8/i/jPTxUXmYvtZ3jCBh7tlff0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7950
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_06,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406260091
X-Proofpoint-GUID: jtQF29Gq4N6cLrldsMwPPc9-mFyzrOms
X-Proofpoint-ORIG-GUID: jtQF29Gq4N6cLrldsMwPPc9-mFyzrOms
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 26/06/2024 12:34, Daniel P. Berrangé wrote:
> On Wed, Jun 26, 2024 at 12:29:41PM +0100, Joao Martins wrote:
>> On 25/06/2024 19:37, Daniel P. Berrangé wrote:
>>> On Tue, Jun 25, 2024 at 10:53:41AM -0400, Peter Xu wrote:
>>>> Then the question is how should we suggest the user to specify these two
>>>> parameters.
>>>>
>>>> The cover letter used:
>>>>
>>>>   migrate_set_parameter downtime-limit 300
>>>>   migrate_set_parameter switchover-limit 10
>>>
>>> What this means is that in practice the total downtime limit
>>> is 310 ms, however, expressing this as two parameters is
>>> incredibly inflexible.
>>>
>>> If the actual RAM transfer downtime only took 50 ms, then why
>>> should the switchover downtime still be limited to 10ms, when
>>> we've still got a budget of 250 ms that was unused.
>>>
>>
>> The downtime limit is 300, it's more than you are giving something *extra* 10ms
>> when you switchover regardless of where that's spent.
>>
>> If it makes it easier to understand you could see this parameter as:
>>
>> 'downtime-limit-max-error' = 10 ms
>>
>> The name as proposed by the RFC was meant to honor what the error margin was
>> meant for: to account for extra time during switchover. Adding this inside
>> downtime-limit wouldn't work as it otherwise would be used solely for RAM
>> transfer during precopy.
>>
>>> IOW, if my VM tolerates a downtime of 310ms, then I want that
>>> 310ms spread across the RAM transfer downtime and switchover
>>> downtime in *any* ratio. ALl that matters is the overall
>>> completion time.
>>>
>> That still happens with this patches, no specific budget is given to each.
> 
> If no specific budget is given to each, then IMHO adding the second
> parameter is pointless & misleading. 

That is contradictory with your earlier statement.

You redacted the part where I describe how this works in *the worst case* if the
entire downtime-limit is used for RAM transfer then the switchover-limit might
*implicitly* act as an budget:

| Though implicitly if downtime-limit captures only RAM transfer, then in theory
| if you're migrating a busy guest that happens to meet the SLA say
| expected-downtime=290, then you have a total of 20 for switchover (thanks to
| the extra 10 used in switchover-limit/downtime-limit-max-error 10).

I am confused with what to make here. If budget is bad because any ratio should
be used if available, but then the added parameter doesn't care about ratios
specifically but *can* act as switchover ratio when RAM dominates
downtime-limit. But now no budget is associated is also bad ... then what's your
middle ground from your point of view to tackle switchover downtime being
somehow accounted?

