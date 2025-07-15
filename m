Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C090C83F21
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 12:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubeKr-0004qI-OA; Tue, 15 Jul 2025 08:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubeKZ-0004jL-5c
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:00:33 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubeKQ-0005wy-Un
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:00:17 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F7w5cd015997;
 Tue, 15 Jul 2025 05:00:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=PoY9EdfKhirhuYHZw2stFjXb4nLKVrVGWqsxiC+wt
 nw=; b=fZX5M6ERRQtdH6nlOmPkjVvYIF1Sja3GKgh04y1UP4LL/VKorFi/zCxWV
 gOzH0A51CJUIeE+CfQqgv45MaNy60QtdZoM1g5LNUQMNvvHrtmSWzeC0K3pp/86G
 WcKNydjKo8UjHbDoDSbbk7d55QtS+YV6UeLGBmLIcfJpgrfk8RXp/3acRFzmKGtq
 mM6oWZyCLWFnU0Y6K7Px7n9Sjb10J8n2CvsurowyWKqoyvyjOasCHeafZ728D8MQ
 RxXqkVVor3mex31nHalYl2IypoAHIfUVr94YhPpNvvzeseSLk5yH65t6QfPxlVtx
 j1CfLcvH70g7Y9OU7Dhw0SAYbzqwQ==
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2117.outbound.protection.outlook.com [40.107.96.117])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47upsh6168-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 05:00:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsWfJ9mY/nU4wxQCpgQXFLep5eGbWBPMOUCebl3Oi8EpItlxEZMea+9WOwPdyqVdb2Veb5WDbDYyZJ7gvda0jlrATsacNjXxk+JcvUXsHiGb48Ign80jLM0y1IrBI/sZB7+0PBKwRE7Fj9lmyft0ekpTiCQsg57vp+EKTGOruuFMqpt7tOlrx763EPKZ7jKjeTIQZxMkZ/eEjE5bjQ5Pwo82hcyJkV34bzJXzAz7GmoahS6krkMkneFDLsDw8p5gLuLxgimmH77ky64uVAcUnFlqAtIcBkdPQY9uJWj26WrP7jMgNkxdtZTVsCf/SzIhYlycm1p3140v9vv2/qprLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoY9EdfKhirhuYHZw2stFjXb4nLKVrVGWqsxiC+wtnw=;
 b=m9svXKBLicV6VyC7hryPMErQ6Mp8fynTh+5bNVfX087QRTPDx3bApaWYX0HCjXZgwRuLbUuDWW4IpqPnka5wc2dS0vFaVfbWS3RfQyjnxTLvMdspjUShHizBaTdb67T/qFTpsNAdlv+Ut18GBkYw+Cjc5sf6xExfV5azeKo6wzKCjQ4romAfewjFN6HFQ+oRkwFMLhbpNXTipAchuxPg7Of+t6Hbh1qi/omNDfMRSAxS2FpENzhKx8RfRQUgn+WX7OFvGmGTTrZbhE7syZXiDXRYyX9BS90XDMi7PJf53qkarhd3TIhyxjYl83yKT8OKhJ6ttirm2S+l38sNFetRAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoY9EdfKhirhuYHZw2stFjXb4nLKVrVGWqsxiC+wtnw=;
 b=uNBXONZ2pu4RU2RasDjvt7164B/+B+Cwy9IW/ip24Lg71BriULrAfYy+Ml7Y944ryIphzM78hm66VFPM507sSdKuupDkZmewcf+uLns8XkvaBlld1YCT9n/nkkjjE2KkCFZSgvZJPkWt0ZFRGIOEQqRKHAiTXPiW81cy/aGdPFnU1DtkPKfF5+oKzXMnX9xxkxZqCfmk3b0h5kRsEDN23/l8mHGgjrTKELblIxoCDJqkaH/cwIRjZIsl4eFdBKhm5HigCuiZdg+GBjSyg6yQS2J5I50O+Wqg+W3X7Of1yUezmumHUvKypoVTyiH37dgHkh2scAWLvk6Xb4mU8PObow==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DS0PR02MB10710.namprd02.prod.outlook.com (2603:10b6:8:1fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Tue, 15 Jul
 2025 12:00:04 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 12:00:04 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH v3 4/4] hw/vfio-user: fix use of uninitialized variable
Date: Tue, 15 Jul 2025 13:59:54 +0200
Message-ID: <20250715115954.515819-5-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715115954.515819-1-john.levon@nutanix.com>
References: <20250715115954.515819-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::29) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DS0PR02MB10710:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a1f9727-d53f-4f95-9175-08ddc39722b1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGhOUHFXYkI1MURNSFRrdTVndVFrVGRWOTN3dHNhME5KSmdaQnJBUlhJT3JJ?=
 =?utf-8?B?SXlXZVpCR1A0aW0wQVM0bElZV0s2OUgrcEtNUnBYbmVEL1ZBTjcvRHNCVWZ6?=
 =?utf-8?B?ZGo5ZEJpT0RlQXVZMitDWEFyU3JTWXBnZGZYNmZEQkZuVGp2ekpqOHhZUmdq?=
 =?utf-8?B?MTdrUmkxODR1dVVuQUcremZJSFdzaTZ3SnN6Z3ZXbzFqRyswaHI2VUFsTkNh?=
 =?utf-8?B?NWNCNW5EL3VRTVcydEk2SHBzVm9WZzE1eUtYbmg1L1UzMUlCMUh6cFozdWI4?=
 =?utf-8?B?bFpkamtGMTZpaVdNeGkvMDZvT3hCVGk3TnJDOXBGSFZEQzVoelQyb3FvQ25I?=
 =?utf-8?B?ZktlZHFzV3pKcTdBTXE2WklOeXZYWmFwTmx6YlVLK0xNbU9DeDNhYzZNNk80?=
 =?utf-8?B?VDZhV1ZZcXVENml1QlZPaGM1SW9ZSFM3Yml3ZjhSY0ZoUFBqMVMrRUhISWZJ?=
 =?utf-8?B?WFFhMURuZnFlb0NFeGV6aFVFSVdadjh3UDZGNFNZS2FaNjJuQ2FVdGtUR2Fi?=
 =?utf-8?B?d0ErNVJIS0d3cjdCSnVibDBtaHU1eGNXdWgyYlltSFVBMVduRHhzbmEzR01B?=
 =?utf-8?B?VXl2RmlVK2FrRGNUK3lwd29WWUdKR3dsalJGcFF4NGpNZ3pEZHZDcERmdzkw?=
 =?utf-8?B?czNaUHRHNzVuM2ZBVmRtVXVXRlE3L2w2ei9pYkxDWHB5NDN4aWRGaXpROGpa?=
 =?utf-8?B?TllMNmFsNlVFdlBuV1VoZ0RhOUxoY1g2M1NkTnRFTVFSellFQWFUQUNtdGZp?=
 =?utf-8?B?SVNDRUJvN1RUQlZpSU1qbWtBRVd2OExKWWlZSWJ3MHFHZ2FmeXlKYUhOc2h0?=
 =?utf-8?B?d0ZuUHZJT1U2RytIWUgvaWEvcW0xbkgxV0g2WG5tRXFtV1Rpbk5BWVlFSFJt?=
 =?utf-8?B?OU5oSXNxV3Z5N0lBc0RwSmlwYkxFREE4ZTlDZVlMSEN2dnJsRjczYUtzK0lF?=
 =?utf-8?B?aHRDSzBKZ1ovSjBMaXFlTFhpUkRJSnpYRWRTc0YrWEEyNERIaWhzckZnYlZ3?=
 =?utf-8?B?N0M2U0EzUDZpRmQ1aEY1aStjM3hjWFcraW1VdGYxbDFEUXNucEZDVDZVcGlB?=
 =?utf-8?B?eFp5aldGYkNhamFVZW40YUVMdFNVMkpja1RZb0xRdlNNZUJSYStxTTN4dWZL?=
 =?utf-8?B?dDRyeHZjZnluQzJ3V3ptaFE0UFZsWnVUbStRSnNjell1a0p5MnAzT0ExSjc3?=
 =?utf-8?B?SDJSM0hJTHdmUFpBSEdacjg1aitWZnlsK0kwUWthektiT2l1cWQzNklZdzN2?=
 =?utf-8?B?bk81cENGRDBNM0E2ZEZmMm9CRTQ2a1IrZVlvb0pDUXNscGh5TXdEVytFbUIy?=
 =?utf-8?B?d1dNRXRUMkZTdmplVDVFUk9FUjIrMGZPclE5MVNDZUdMRzkxZHFtMlBIUUg4?=
 =?utf-8?B?VnV5cHArNWJJRU8wZEQ4L0Zza3djVHhvckZXYVdFTjNrNEpycEh0QXRoSmxS?=
 =?utf-8?B?cWh4UmJLT1g2K1pDN25yMEMrWkVkeHhxYlZIaWY3VjFHUkFNaHVSRzFTb0dJ?=
 =?utf-8?B?YjVWbm1qd2VsbjBkUjlaWm9sY2JLa0g3TkhMMDRlM0FLdll6ditEY0p6dEpP?=
 =?utf-8?B?MGxjc2swdHoyMDBNVU5sUEFCS2VQdGRPNkRTWlNyUjhaSEZSdWNYcGxHYXg5?=
 =?utf-8?B?cnVPc2F2czNQZWJiYXVsUE9EaHpOSmhWMDlKZzlHZEpTbTU0Smx4d2xQbFpo?=
 =?utf-8?B?eUtVZjhkWWVVQ0QrY3daS2RuenUvdlVKOEIyUjJ3eXorSUFZazBpVkVYQStP?=
 =?utf-8?B?dkliL0RJaEdPcHRUWk8zZlhNQ21VS1h3TFRMMVcxODdDYkkwVUpsQkU5R1B0?=
 =?utf-8?B?dDYyZkFKNzI2OWFkb0JaNHJTL2ZmWk5tb3JBT1BZc3MrVm5vZ0hhV2dlTmxE?=
 =?utf-8?B?QXFRZkxYY04xWDM0ckFJbDczUjhBUTBuMGl3aWREUXRGbHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ci9aZ0RsTW1GUkdFVktPMmJOV1VaQ1A3VmxSdWRBbkJXbUwyd1pXVlRLcm1B?=
 =?utf-8?B?N0tCNVBnLzNxSnNWSzRjTlI3dFZRY1gwODV6MVRUalZ5a25rRnluL3JYaURu?=
 =?utf-8?B?dlpTTFVaaFJYV25Fa0dDRVgweDZ0NkEzdGtpZ2RqSG9YOUNkOFhxMkpRQXdW?=
 =?utf-8?B?c0lWYUUzVkJGK084Smh4YnRFZXFWQll2ODB5eEh4d2VnRW9SWm0vcUxRUU5O?=
 =?utf-8?B?ZFM5L1VKK0YrVGxySTFMWjlDYnNFeGJ0cEFsS2pjMFJIZHAxdDRmSC9XVGwz?=
 =?utf-8?B?dGJYeTdwclFHUS9lb2NZcW04RmJMZ3RkYlh0TTlubmJFeU8zQ0RmOHNpWU1w?=
 =?utf-8?B?R3g5WEc4ZjNLK3djclBzSDJZaFB1VXJuQVcxMEpXN2U0SVhEcEJOVG1xdGhi?=
 =?utf-8?B?MlFCL3kxTDJJN2tUaEVraHZ1dElaczRzSzlhMHNoRld5Q3pBVVloczlFWFFL?=
 =?utf-8?B?YnN3WmZBZkE2MUNvZHVXRmZSRXFLVG9PN0xMbVBFR1JHRk1DdW53cEhFdEVR?=
 =?utf-8?B?ZnBPQnRiV3hsMTFzemxwRG0rTHlLdU42UnJabUlhSHNoc3RQVlEzSnJoZldD?=
 =?utf-8?B?NG90VlpiS3BnOTVnYWgzelBZWE1pYyt5NWovSElBLzRlTzhTNHlHNGZxVmxW?=
 =?utf-8?B?ditmM1FKRHlZSGpWblV6MFU2elYxQjlQUkdrbS9iTzZXaVM0MVFUU0t5eDJO?=
 =?utf-8?B?T05BM3NVNWZDeU15Y0ZnbHE2dHcyRjlDdEkwT25uc2Q5NjJsOEZaUDhha3hr?=
 =?utf-8?B?Q1JyUXhydDNnYlF1YUZ2WkRCY0tPRXdKSGNzN2hWNDQ2akxBaDl3V2JIWGxR?=
 =?utf-8?B?VFBuV2lnaFZlYkZnd28wMEpBVEhKMWhlNDJVdnozT2NSdnpseW9iZGhKYjRt?=
 =?utf-8?B?SVlhaU01eGJ0U1F2R1VHL2N1SGRLY3NsQnVXbU80TnBOb01iWHgwdlVJbWUr?=
 =?utf-8?B?aVlpaTVlSUkyUWd1c0pvWjUyNUpMRGJxS25nVjFzcFBxa1VmWGFtYzg4aUN6?=
 =?utf-8?B?WkxJWFFieXBzUXF5QTFqSjVxMkVtWlBuNnIxR083dWlvREZ3dU9ycU9LTkcy?=
 =?utf-8?B?NE1aTUYxZFBzM3hOWlB6SWN3TFRRbFVrUTd4SWNYRTFVRFdMazNJQ2ZSNjBa?=
 =?utf-8?B?eE10MTVDaEFvZUJwNTZOSVgrQmRlL01HaVltSzFjNzg4SVRyVXdDUkJKN25I?=
 =?utf-8?B?ZnNCT0hvS2N1OEEyUm5hWjRtYVdLRXZ3cDVZalZYdkJJamptTHdWOUU0MVhs?=
 =?utf-8?B?a1pZR2RTZFdXUDkybUxpdFJtVEV5ajdaK0NSem9iRjdiNDlxK0ZSaS95dTkx?=
 =?utf-8?B?cUI5VFFxeTRZWnByYnJkUVM0clVzaE9MRkF6bmdmakhLVnZxSEdrbW9QVk1B?=
 =?utf-8?B?eEVOc0c4SEJ3aG9LRjdyQ3A3ZngrbVV0MUc2NkM2US9BTHhqSjRSSk45clh5?=
 =?utf-8?B?YzV3ZEhEdzk1dGZlbVVpZ1lkcHJESnU1YXNsd0JHY3NuakJKekxOendNc0Vp?=
 =?utf-8?B?M21Lekw1YytFV2hlWXA2WU5hWDVIaUVIdkd2TVdqWFBZT3hNRFN0Y0hLdWQy?=
 =?utf-8?B?R1VZMkVNeURaaWxYM05Zb2VJRGJ3NFdITjVmWFZqU2plZnd0UnByNVNFSE1q?=
 =?utf-8?B?M3RTSnVkbHFMdFF1Rk9UdDJ2Q2MrTjM1MGI1eXZtaStLSlZVOVZDT05hTGVW?=
 =?utf-8?B?UXFVUzQzUGI5TDZyMGlUQkRiMHdZdDlGUm9NVnM1NFZGTGtDNnVScGpHUjRx?=
 =?utf-8?B?eVArZERKZmFyOGF1ZmxPdUlpL092NWRkTDJuTDhKSS9rdmVSMFdwNmx6Smtl?=
 =?utf-8?B?S3BQeDBCTGhQVnpkYzJMbzAxMDkvd0RaeWF5SytBMkluWEFqTUNvR0RqMWVy?=
 =?utf-8?B?NysvcndWMnBKN0JOWXlxblp0d2M1bzM0WXVxOTR1bUtFcUV4UVE1M2k0aE9w?=
 =?utf-8?B?UVdtRGk3dEQveXZOZWtCOTAxbGRoWWhFRmVEcFZxbzdOcFpjeHhGcFJGaHVx?=
 =?utf-8?B?eEtTamFJSStPK3ptVU5XUDJ5a1ZjUThodUdTdzBvamVoUy9lM0FlMXUyU1I1?=
 =?utf-8?B?YTk5TGNIS2g3elVFRlJwc0tFMmhDSmRSdWNSdjFDR3pDMHpmcTRLdVZiK281?=
 =?utf-8?B?SmRqamNxTzdBalpqT0RBVXVRZVQvczBmcEtseFdzMzEyMTZUOHZoOWRWRHR0?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1f9727-d53f-4f95-9175-08ddc39722b1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:00:04.8100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxVM6Ix1PJFWucbUtqCtUYNWKAISisje6TZTUh6DtTgII0qPUFXj4yWVyuLOky3a7H+2GdYLrUKqGxOXGVCKtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10710
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEwOSBTYWx0ZWRfX5TgQ2UOo2xQt
 Ip0bHu2idfbI4N0sxIFKFeAzwttKu0+3uYhOIWznukLnKiaVIJsJERPWB4tNay7kUnCv7Hc9uMJ
 12aXRGHXJBeEl6hxVQPXrZKfYUYkf0NsHpvhTOynasQ8XmfnGy3rTHU2OJF73LczpHmYQC8guVm
 quEJZMyxuxX46EUvM0DvFlkioIl4hNOKPi9xt4dNglAofE8paP5MvG5SuTelf/pkV+aJwh4iwhL
 F3YIwpqVnkxCHITbvhLaf3hzmYUFqo4AddujX1bnWZgzrPwMjGLNFp2n2gxIeFQa76W+6YGRvJ4
 4SzijgxT2M6S9onT+7TY2YapmtfYCxgx8P0YbwEvyJCAJ7xRNEmMwaiKRNjtRShNmyplsxZPhlL
 Wr9gMnhVmphaaP7mzGpV8h8VN76+IQGBnz6CR+gLSFMbM7r/ix/GKkm1aYfDPvKForaOmFQz
X-Proofpoint-ORIG-GUID: DAT0kQQD96sHSgZmDtA7KOAjCS3fDQ5L
X-Proofpoint-GUID: DAT0kQQD96sHSgZmDtA7KOAjCS3fDQ5L
X-Authority-Analysis: v=2.4 cv=AoTu3P9P c=1 sm=1 tr=0 ts=687642c6 cx=c_pps
 a=7BW3xbkRIOScQKbXweZh0w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=ElJsUu_2Y0o_wqdk4xsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Coverity reported:

CID 1611805:         Uninitialized variables

in vfio_user_dma_map(). This can occur in the happy path when
->async_ops was not set; as this doesn't typically happen, it wasn't
caught during testing.

Align both map and unmap implementations to initialize ret the same way
to resolve this.

Resolves: Coverity CID 1611805
Fixes: 18e899e6 ("vfio-user: implement VFIO_USER_DMA_MAP/UNMAP")
Reported-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/container.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index d318e6a339..d589dd90f5 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -64,8 +64,6 @@ static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
                               0, &local_err)) {
             error_report_err(local_err);
             ret = -EFAULT;
-        } else {
-            ret = 0;
         }
     } else {
         if (!vfio_user_send_wait(container->proxy, &msgp->hdr, NULL,
@@ -92,7 +90,7 @@ static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                                                 bcontainer);
     int fd = memory_region_get_fd(mrp);
     Error *local_err = NULL;
-    int ret;
+    int ret = 0;
 
     VFIOUserFDs *fds = NULL;
     VFIOUserDMAMap *msgp = g_malloc0(sizeof(*msgp));
@@ -135,8 +133,6 @@ static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                               0, &local_err)) {
             error_report_err(local_err);
             ret = -EFAULT;
-        } else {
-            ret = 0;
         }
     } else {
         VFIOUserFDs local_fds = { 1, 0, &fd };
-- 
2.43.0


