Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AD3E8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 14:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHp8-0004yA-56; Tue, 03 Feb 2026 09:56:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vnHou-0004oW-4H
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:56:02 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vnHoo-0007Uf-31
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:55:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vj+UyLmfnnly9q+fQ5jPlNr9dACDXUpDz5zoxNg1CefGr+UShLyN73qTj1qD1jPEEm0xxSFJ898ahQCfiJIKc8K57MR0gN4dqOfLrlCh93sSvEe3WWkh8nFrQNOn5NXwqBqp1rHo1s3uw/3ByTJxouOuU7/7cTq0Hg8a1770Rhs/IiZ3RrYHb9WYWH/cXesKCv1UHU2+tK1LLmHTIF1rwXtiCmMcGBrVhvl0CGnOb/Ckka6+PzS+diD6DVvWtP3vVcHXv87fSjRAkpPAVJvVAMZQ9ccakDnqveeMiuq9HSNqWIQ/+ZIX96wTHppyq4Iy+O54T/R6vP94uo4uGrV6CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAJKnoI8E3IwYPs7LpDE+lPA9W+oNjil1rzhsfP2l7Y=;
 b=SWBBmpLlC4fMdRQgMinYvKR9kVQdyNc6OllvjMrHzVCHfONblXaKxispQ4cJ5nTYTEyMgsuzY7t9+jqhKkoD8rlnvsye52thdLBICbOTuqnGFNiORVkmlnCJQQAk/hNgAlFNZm31q7QCTFTuQAtUX4zI9cWxGZMLW4haupgKC2KjP6DfeIPjrGNKrQyvQgyVZ/mLQuDKtaejSIt2nXiTmJgBUsol+iiVjOukW60z4Bd1m0FNMJTFASbPo8oueygjP5KAvICHMk2AgWA3W4QT/KtIdxZK4SaFaAchHke0fGLa+0Xzvmz0F1/yOpjge2bnvW/SS2REVytbNxWG2Bet0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAJKnoI8E3IwYPs7LpDE+lPA9W+oNjil1rzhsfP2l7Y=;
 b=eHJE4MTKAyomxvwncp5MQoVNDIoJcbJDiNp0LaLtjSOfYT3ZlkKAiI3n+OGN+FOsJx5/3+TmYoaKl6zsiUo3lp78T09W4Z9q1vYWAliuDLLV4sL0hgbT+R9ASerGRf7SGt9giCEbN+l33rjbOlKuJBKgxvQWI7Yc6U1BA3Kk+Vk=
Received: from CH0PR12MB5283.namprd12.prod.outlook.com (2603:10b6:610:d6::12)
 by PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 14:55:40 +0000
Received: from CH0PR12MB5283.namprd12.prod.outlook.com
 ([fe80::23f7:7362:bc2f:507d]) by CH0PR12MB5283.namprd12.prod.outlook.com
 ([fe80::23f7:7362:bc2f:507d%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 14:55:39 +0000
From: "Pekovic, Manojlo" <Manojlo.Pekovic@amd.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "Prica, Nikola" <Nikola.Prica@amd.com>,
 "Andjelkovic, Dejan" <Dejan.Andjelkovic@amd.com>, Manojlo Pekovic
 <mpekovic@example.com>
Subject: RE: [PATCH 1/2] vfio/pci: Refactor atomic capability checking
Thread-Topic: [PATCH 1/2] vfio/pci: Refactor atomic capability checking
Thread-Index: AQHclRy8atB9LEfWSUelOQbLXLiagLVxD1tw
Date: Tue, 3 Feb 2026 14:55:39 +0000
Message-ID: <CH0PR12MB52838F23E3431D5C21EF5240FA9BA@CH0PR12MB5283.namprd12.prod.outlook.com>
References: <20260203144939.49-1-manojlo.pekovic@amd.com>
 <20260203144939.49-2-manojlo.pekovic@amd.com>
 <2af33652-d467-42be-86c3-e1995f2c1b89@linaro.org>
In-Reply-To: <2af33652-d467-42be-86c3-e1995f2c1b89@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-03T14:53:00.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5283:EE_|PH8PR12MB6723:EE_
x-ms-office365-filtering-correlation-id: 505defbd-2c8e-4115-d6fb-08de63344bdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ck1qUldST1pwY3NHTTVYQWNkc0V4dUhCSzEzRHhnSnRDaEI5aXhkUXRtTDZ2?=
 =?utf-8?B?Vm9sRHJDbkFVb0FZZE1EM2t4Z2UyWm1oQ04vZTYyZ25BSzQyV2xOOC84ZVlX?=
 =?utf-8?B?Um1UZkxFNlRsalYzekhJSEFjd0JJYk45ZXN3MFVaMG9lT2x5b2owODlLdWpX?=
 =?utf-8?B?a1l6Tjl6L2lGYWlDNmxNbE51TjZha3lCRllyQlkvRnRxbTNjcHNvRlRFN2JE?=
 =?utf-8?B?TGlEa3YzS1hicUszZEt6Q0JCVjJCdC9ETEt0VjhlUXo1UjlUcWxlNFBVQzFr?=
 =?utf-8?B?SDlMZytMNjN6K1FhVld1dHg2ejExOE5maGc5VXoyZmpyVEc5UVBvOEpvZTBo?=
 =?utf-8?B?enJ6MG90RzE1Z3dRWGR0MWh2VklXcWdlaWlqeld5VVo1REJvNFpSaFZIZkxv?=
 =?utf-8?B?QXZNTlQ4WktxZ3kwZUJFS09laUdNTjkyaExtc094eURMUEQ4UDRYR0dMODdl?=
 =?utf-8?B?SFJ5OVoyaFVhSHRTSkk4Y2RQTmNEREIrM3ZlWXpOaXRqZG5iKytzSnpZL085?=
 =?utf-8?B?eDYvU0dMSkFpR0h1bTV4V2oxTVBqellHaVZKZ2Zma29DT1VjMXkzUG43OUdz?=
 =?utf-8?B?Wm0zY093ZFRjZHcxTTBkTFN2eUJRak1vWndqRXJYYVdjSlY5QU5lTzNXVm9K?=
 =?utf-8?B?SlB5VTVSTEVlM1BBK2gwVFIxbnlScHVTMU5TbWNqOUFEb1RaRHRickUxbjNm?=
 =?utf-8?B?SUVkWGxnRERFOFZJUDlGTWZZTUdPWTdRWjdOdjBxM2JPVjNCeDh2OVNwdFVF?=
 =?utf-8?B?QWxVeUZmK0VsdlBBQ1pERFJXZEVOQjB3SEpVWVR2TEFXQ29IcDlZQVFOK01i?=
 =?utf-8?B?RE1RSTkyUmxVM0N6Y0FJUFhGK1VpODFoTlFQaUZtdFIveCtQSUpOY043a2tL?=
 =?utf-8?B?b0o5YUhWZFlDTzhmcnpQUkI4SVBJbU1CUW5CdENic1BxWTg1SmpMNkxGZ01H?=
 =?utf-8?B?ZW5lOFhsdEpMQm5YM2F1NVNOMWE5SExJcnBTQitRM2Vua0xLME5IdVhUTkhx?=
 =?utf-8?B?U2RZKzhwdnI0UGkya0tEVWFZR2JKOUhKM0g1WGt5SGh4RUgwdXNCeWdyUUFL?=
 =?utf-8?B?WHZ1Si83VGpQM0ZyUHA4WDF6UlFQaWY3M1o5Ry90eHJWVysyMXBaY0VuZTZM?=
 =?utf-8?B?S3Vhc3pXN1p6Qmw1TGJ0aHkrd0V6c2xHVk5KZUh2RTg0MGtndEM3c1VaenNQ?=
 =?utf-8?B?VVk0Skdzd0RSYko0NWJDSzZLbE55UnVsaURWYlQvTVBKWkI3OWpCWDZVMXZn?=
 =?utf-8?B?N3hRMUhycWJWckZOM1Fvc3hkNFgzQi9YV3VzOTd4dTd5NnVNK2FXYXdzek9m?=
 =?utf-8?B?MjlQZ1RhZ2tkNXhwMXpCb01mM0NjVzBjandRVENNMVRkVEdvZHZUUTdSUVRG?=
 =?utf-8?B?OFVkREtkWEUxU0hHS3NFSGQzaDRoZmVNaEtkcDNPbWd2bEJRdHNBUVR3WDEw?=
 =?utf-8?B?MmkwTm9uWjByOEtBYjVmcTVEcEZyRXh2SXZYMlE0eHNJZGxHdit1dG5pS2Zu?=
 =?utf-8?B?aUd6VklmY1I4djk1ZUJ6aUNzQlZYNERSOEtwOVRHVE9JRmdnd0FSTTJkVEJo?=
 =?utf-8?B?Q0MvcjR2QlNRTnhUSkJhc2FvNVhEMU9jYTV5T3JlWTE0VUxZYzR1MWluQy9N?=
 =?utf-8?B?MnhjQWhJT1ZlNjM1OXlDeFBmbStzTnFlMUphVG53WDd1cTFBanc4RFdsV25Z?=
 =?utf-8?B?N2xOMy9tZEx3elZrM1N6OTQwb3pVZEVjV3Z6ZXkwc3N6OXZ3K3NmNjN4eVJw?=
 =?utf-8?B?UkFRQ2NldG9NbUZESjJOaEJGUGU3VUJTNmM0azhYaGo4SEpPUHBZd1k0UjBm?=
 =?utf-8?B?clBBUHltRnlsTHdNdlBQR0YxTnR4WVVKd3lTVnQ5SDRObXBHaXRzV1B1RmFx?=
 =?utf-8?B?STNYMU9RYkpDSnowOHo1akcwNFlqT1hKeGdtWTYxSHFsNTdJWnpwb0hEbWdY?=
 =?utf-8?B?b29ZWDQ1NGYvdkJyNnU1TnFONmkwclB2ZkJwbm94T0NFMGdFSVhjL1pDOGo5?=
 =?utf-8?B?Q3cxRUw0ZVA0ek9qMi8yZHU4K2ZHYnVpblNsejBTQWJvQVhoMFFLTkdzTTZy?=
 =?utf-8?B?TW01ODRVd1c1eXpibmlEb2tVT3JKQXlTbWZwMXVtdjhSWURPSmxVSGxpK2R1?=
 =?utf-8?B?eHRveTh0L2t2WEhiS1g4WlJPS0FrWlB2cHZYWmNiL2hOVEk5WlJuekRRYXNM?=
 =?utf-8?Q?n5UhupY+wqPgAGSIDhxnBy0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5283.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUFwejViS3N1QkRzVEttZE5uMjVhZTBORU9PUGJMeWM3RDVlUndGY1Y3YTNW?=
 =?utf-8?B?c1pCT0t2NndtcGo1MUM0ZHJ4SGQ3bVdWREVIZGJRNFRTTnVvQzR0clNjRGVN?=
 =?utf-8?B?ZkdkZUZzTGZqVFpJeDljWnBpV0NNbEc5MkVmd1pPT2NUck9nald3V2JONTVt?=
 =?utf-8?B?bUNyZC9CZ2Z6Y3BJVkR2VmF6Rm1UUTQ3bXY5Yno3Wi85SVozYk5aVm52YzdI?=
 =?utf-8?B?TmtpOVZJVmt0LzNjUDdqNUZRd3g0K1BhREliaWhRa2ZzMDNHNDUzS1hHTFJJ?=
 =?utf-8?B?K2RaUXA2YWUxbnRld1doTDVmelh5dWNESm9Fb3U4L244bS9YMGlpdFZKN0Zt?=
 =?utf-8?B?dEZVREpKdlMrcm8wa2ZDaHlCMXBSdktsZmhSMVpTRlBicEJmRFhTTFVReVdQ?=
 =?utf-8?B?ellJWlZDNU4zZWxXREwvWnNzTzNwTk12V3VvRjJqQUdiYm10bFhZY1dNeXgy?=
 =?utf-8?B?ZkxEYWg3Nzh3OGdMaXRMQlB3N0J3T2UydXJPM3ZFTUp0N2ZLcUl5WDN2RC9V?=
 =?utf-8?B?U1ZDZjhVQmoxMDhBU3cxYUsxKzcyMXVySUtpajZ3VlNMNmt5aUN2ZzJSMytq?=
 =?utf-8?B?VmhoMXNmUUd0c3JhckMwTkdTM0RKTm9XV0xiZ0I0QmVDeGxnbUZUS2NyZ240?=
 =?utf-8?B?ckp3bzZydDhEUU1iUmFPQzNXRXBFZk80Z3ZsT2NqSHFGQTh0bldNQ05xV3FK?=
 =?utf-8?B?Tjl3QmdWMElxOHNBMGNqald5cktadzhVRi8wRVB2MWFBNnpXenovTThhZjhE?=
 =?utf-8?B?c2owa3pJOE84Q3JpcXFCT1VMSXp2b3J0OXNiUXpsOEY0ZzRPb2FzOHQ4NXVD?=
 =?utf-8?B?dG9aaThqUm5tQkcrNlBiejRZaFJXSWwzSWVNNHF5SGlVRW1jVnZjY0x4RE1D?=
 =?utf-8?B?SFEzSEV1ZWl5M29iK1ZHaEJPWE8yUGlZRk16bUMyczEyRG11RWxZS1BsOGxZ?=
 =?utf-8?B?N1d0MDFpOENVZG1icFViL1hhdWNWRHozRXVvYVZnaDAyakg0S0VBanY5NDBx?=
 =?utf-8?B?TFRPZUdXMWRFcDM0TGwrM2ZURUlva0FwWFNMSVhuYWorMkRrNVVtMjRUejhp?=
 =?utf-8?B?WDBjVEVka1FyRWNaWFZaZ1hPVW92RjBVRzBRL1dLbjdQaEZBUFJwY1ltamIr?=
 =?utf-8?B?aGN2eW5DQWVqV0pSWTh3WXpUbUVLTWJaMjRkdElUaHdPelM3VkIzLzJmWmRJ?=
 =?utf-8?B?V3NxamRxclRwWUNmVDdrYW1HTndOVDRLTUtoei91dndZWTAxNTZoV2pUOHBv?=
 =?utf-8?B?eXM0cXRlNmxJVTkxR0NYT1ZWVHhjbEdma1hBNzlud0lNU0tyYnJMUmY1Y1hk?=
 =?utf-8?B?Z3VvQjk4TDh5WktIb2hVQzNWUE5za0dxUFZRd2RCWjhQUGlmUENwZXE4SmM3?=
 =?utf-8?B?VVppQjYwWEdDdU9CdDJ4cGJLTTlLNUpKM0xwOTArT1YxNElrNFJWWFNZWlRw?=
 =?utf-8?B?bkNTbVVVdVdJdGpjU1hnWm1jMkYrUU94Uzk3UFJ4d2hGWGg3NWZ1VTlFY0Y4?=
 =?utf-8?B?UVgyMXMvS25SQTRwYWZ2UkZhQm9uY1VIRzA1NHpxcWxPTit6cXBNMndjSmYr?=
 =?utf-8?B?VTBkUlFWU2txNCtqU0R0VTgxNWg0RmtJM3E5WE03T1ZKcElmd1BpVURIMlVy?=
 =?utf-8?B?NnF3UWZsRzdsYlZYbTFUYzNqRWhlNk5CUE1jcU9MYkVRSHZpODE0OXpId2Ir?=
 =?utf-8?B?ajAwZTdQcEZWdVBEQ1hnNCtCOERQSjB3VllicThDVTRJMnBIZmVhenVqZzkv?=
 =?utf-8?B?M3VHRnNTQmJ1dEhjZ05YU1JpY1dGV01pM1NMa1FhV1VQZENIUjQ0YUlRY01p?=
 =?utf-8?B?cUhDdjQxRDE1V1hqYnoyV0t0cGFoSEVqeE4xV01yUW5pcWc3VVNkdmFLL2xN?=
 =?utf-8?B?dlhkSjl5aVRHTmNCdTFSQWR0Q2tDcktxeWIzWVdlMmFLbjVIa3pQUEQ0eHBp?=
 =?utf-8?B?RnhVZzZWR2VyREpIdlNKNmI4M3hlTW81OFVJdFlEc0lMemRQL1ZQaTdBTVpl?=
 =?utf-8?B?RDAxN3VTZzZnaFBwSEFFclVBellHeWMzb2d2OUVuTzk1U05yWmpabE1jbk1B?=
 =?utf-8?B?aEJYcGltVDRyc2VqTFd5T3d1bWZiSE5WLzVBRDhGTXFaOWsybkJwbjROZERH?=
 =?utf-8?B?YTdtdjNKam1DdGl0WEhnNnBNNmJqVGFDcCtyQWF4Z2xKRWEvOG5IT2ZEdjc4?=
 =?utf-8?B?OU96V25nSzVqUGxLblBBUGJRNitUbEd6QkxrcDVJclM2ZElPRVMwZFQ0TnFQ?=
 =?utf-8?B?QjhxRG9zWEFhMzUrZzQrY2orTkNWcFpkeThRR3FKa0haNFZoOXNOZEhTS3Fa?=
 =?utf-8?Q?vt2P9YS5Guzb8maPKz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 505defbd-2c8e-4115-d6fb-08de63344bdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 14:55:39.5161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LHv6UbHA9Hydai89npcfMjcU/VgeWoi0S/81l9wLBUl7E9XehzcJDXlCUvob1F6BZd4BTPCsOqWdJaoge9zm4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=Manojlo.Pekovic@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgUGhpbGlwcGUsDQoNClllYWgsIGp1c3QgY2F1Z2h0IGl0IGluIHRoZSBvdXRwdXQgb2Yg
Z2l0IHNlbmQtZW1haWwuLiBTb3JyeSBmb3IgdGhhdC4NCldoYXQgaXMgdGhlIGFwcHJvcHJpYXRl
IGZpeCwgc2hvdWxkIEkgc2VuZCB0aGUgY29tcGxldGVseSBuZXcgcGF0Y2gsIGFzIHRoaXMgb25l
IHdlbnQgb3V0Pw0KDQpUaGFua3MgYW5kIHNvcnJ5IGZvciBpbmNvbnZlbmllbmNlLA0KTWFub2ps
byBQZWtvdmljDQpTb2Z0d2FyZSBEZXZlbG9wbWVudCBFbmdpbmVlciAyDQpDbG91ZCBTb2Z0d2Fy
ZSBUZWFtDQoNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogUGhpbGlwcGUg
TWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KU2VudDogVHVlc2RheSwgRmVicnVh
cnkgMywgMjAyNiAzOjUzIFBNDQpUbzogUGVrb3ZpYywgTWFub2psbyA8TWFub2psby5QZWtvdmlj
QGFtZC5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCkNjOiBhbGV4LndpbGxpYW1zb25AcmVk
aGF0LmNvbTsgY2xnQHJlZGhhdC5jb207IFByaWNhLCBOaWtvbGEgPE5pa29sYS5QcmljYUBhbWQu
Y29tPjsgQW5kamVsa292aWMsIERlamFuIDxEZWphbi5BbmRqZWxrb3ZpY0BhbWQuY29tPjsgTWFu
b2psbyBQZWtvdmljIDxtcGVrb3ZpY0BleGFtcGxlLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0gg
MS8yXSB2ZmlvL3BjaTogUmVmYWN0b3IgYXRvbWljIGNhcGFiaWxpdHkgY2hlY2tpbmcNCg0KSGkg
TWFub2psbywNCg0KT24gMy8yLzI2IDE1OjQ5LCBNYW5vamxvIFBla292aWMgd3JvdGU6DQo+IEZy
b206IE1hbm9qbG8gUGVrb3ZpYyA8bXBla292aWNAZXhhbXBsZS5jb20+DQo+DQo+IEV4dHJhY3Qg
YXRvbWljIGNhcGFiaWxpdHkgY2hlY2tpbmcgbG9naWMgaW50byBhIHNlcGFyYXRlIGZ1bmN0aW9u
DQo+IHZmaW9fZ2V0X2F0b21pY19jYXAoKSBmb3IgYmV0dGVyIGNvZGUgb3JnYW5pemF0aW9uIGFu
ZCByZXVzYWJpbGl0eS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogTWFub2psbyBQZWtvdmljIDxtcGVr
b3ZpY0BleGFtcGxlLmNvbT4NCg0KRG9uJ3QgeW91IG1lYW4gIk1hbm9qbG8gUGVrb3ZpYyA8bWFu
b2psby5wZWtvdmljQGFtZC5jb20+Ij8NCg0KPiAtLS0NCj4gICBody92ZmlvL3BjaS5jIHwgNTMg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQ0KDQo=

