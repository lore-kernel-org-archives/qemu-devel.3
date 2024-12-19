Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DEDE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 06:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO9qi-0007Ni-GQ; Thu, 19 Dec 2024 01:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.yuan@jaguarmicro.com>)
 id 1tO9qg-0007NR-N9; Thu, 19 Dec 2024 01:17:27 -0500
Received: from mail-tyzapc01on20727.outbound.protection.outlook.com
 ([2a01:111:f403:2011::727]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.yuan@jaguarmicro.com>)
 id 1tO9qe-0004e4-Ac; Thu, 19 Dec 2024 01:17:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDwB142H/4kMMPhRLrJbRRVCbsILTM+QAtGpHERH02bqxxBOzcdCeVnGqW19wdwtD9xIUwUhoFJgVYgsBtERc84Jta4Wqmgyq1zSbhaBROpLd1zY5DF0drVA0wTp7MMc2l0IsGiHSS62RcbIaYEgxSMPeehVX6upMZYgRDvoZN1Lgr8+FD3occcFRyrqMMVSha7XaZYitx9qiX4t9ngGn6FKR4f2ZbBuMOfNikJUTuXdodEX6ecsX/uoZ4yLfXuvRWGj2HUHyPBR4SIO22JKmA8F0S0YQp9MtKezNbKSEgEgIEOydnlOoc0mjJudmvMDJG0sl2qxsg+ROrkCMDN3kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKBXAcv7Y/JDvKnZe9LtSBDuGqQSzB8OKvrJg7SJO4g=;
 b=KxOXfA+aq7RXa+Cxw5l0EmhTof8iObZOSf0lZehu8yxWoftzRBwRT/+AnN9VtWa4+yPFcbi7z/Md9rxIeQKnh823+M1je621en2KplKzAV05Urnn5xp+MXxE6Memcftw1mTvBZ+NI74jrA2O3C3qrfxAxI19xSDJQ8smrSjX2SObqrTYoGyWCe+0y8eoeQjodbnEaXYixsVzRvPeLoHiEH8R/U845WVDlXGk9uXLIvT+VlIXrXBa3L1XQw9aubZxfGLgUeFrLSYqrinDGmyUfQuAWy59yPCiJMzrpTjxubniVeHpKWiUOYQfJ335IEuNhFHKvBMtMBdtMu8f8Zl92A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKBXAcv7Y/JDvKnZe9LtSBDuGqQSzB8OKvrJg7SJO4g=;
 b=i9kQjeUqcmUsPNdNoc1NQKQIJysNJmL/OGjmZn4BKET7IFhgRAHu7IKzmrEwiHhOSbnlH+Hh6FHeo/8mP6C6sP0RXGCNAUDbpzKojlB5GatxXXJZH8VoHtGTnNxJdgPJHOGHjVqq/lWWQgMGenJZ5SuAICEVgot8fVacTSgY306TReW0IRlKwPYf3w3XhkCOIEsPjPmP+SsKEIS3n0A0o+WHl+7TsZI0VdBqI4ifZLbUm1FMbKwhW1HQoph3r6QUf31wG4HV1HE8XW+Za0AtrUGT4KG/lGOheI/XKjagK8AQCPyt3UGamaCNnX8tplQxDbJ6yfgMJJ2qzKevcJuvng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB4891.apcprd06.prod.outlook.com (2603:1096:820:ae::7)
 by SEZPR06MB5391.apcprd06.prod.outlook.com (2603:1096:101:66::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 06:17:13 +0000
Received: from KL1PR0601MB4891.apcprd06.prod.outlook.com
 ([fe80::8950:42de:2354:91b2]) by KL1PR0601MB4891.apcprd06.prod.outlook.com
 ([fe80::8950:42de:2354:91b2%6]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 06:17:13 +0000
From: "Andrew.Yuan" <andrew.yuan@jaguarmicro.com>
To: philmd@linaro.org, edgar.iglesias@gmail.com, alistair@alistair23.me,
 jasowang@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Andrew Yuan <andrew.yuan@jaguarmicro.com>
Subject: [PATCH v3] hw/net: cadence_gem: feat: add logic for the DISABLE_MASK
 bit in type2_compare_x_word_1
Date: Thu, 19 Dec 2024 14:16:58 +0800
Message-Id: <20241219061658.805-1-andrew.yuan@jaguarmicro.com>
X-Mailer: git-send-email 2.37.0.windows.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::12) To KL1PR0601MB4891.apcprd06.prod.outlook.com
 (2603:1096:820:ae::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4891:EE_|SEZPR06MB5391:EE_
X-MS-Office365-Filtering-Correlation-Id: c27e885c-831a-4f77-e0da-08dd1ff4c707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0UrVTMvMUg5dkRJS2NDT2daUDAvU2tQdmdmSkRJVDV4cWtUY0piM3JISFo2?=
 =?utf-8?B?M2dBVGZ1eWZ4WnI2cEpLcUozYkpQQ3ZvbFMrUEp3d24rbFVKVzVyR0hNZDVY?=
 =?utf-8?B?MjJRZWV5YU8wVzNYUTdLRisrdkNFWWh2eVZ4YmhyM1hjakNtZnhQQTdTOFNY?=
 =?utf-8?B?SDdhYUpMbDVrelptWnBDTDc0M3NFTzdNbVlCRXZud2xlL1lFVkI2U1k5ZzlQ?=
 =?utf-8?B?V3ZwSkFobk5WYWZmZEdhMzZvd2ZOcFF4UFBnNVJBa1QwOE16eW8waHBPemdP?=
 =?utf-8?B?bElPUkh6aUZuZXpSUkdmQ29jL2lYVEZnRmV5YmZZTmpGYnpHNkpPTVpNYi91?=
 =?utf-8?B?N3RiNlNqMGJ3emN5aGFJdEhJb2UyTFlndGpSTkl1Y0ozMDc1WVhBWU1uQTZX?=
 =?utf-8?B?blRSTUJicXBqQ29CdGtkMHJYRGVEc2RrTy9XcmcvbUNDZjlmdHBjZVE4Uy9F?=
 =?utf-8?B?c21aS2lBSElqRlI1bzVtblp4bDRHVUhCOVRTdUU4c1RQR0RuaW9qdWFiT2w0?=
 =?utf-8?B?TE9hRDVsVGlqUVVyRWFVOURsNC9Kb1E0TVBneHBPNENraGwyTldtMEVFZjMz?=
 =?utf-8?B?bDJrNXFvcXd3NSt1cWswTkJ4WURzOFBmVGMzOFJRaGU4cDFjK2RWa09SWHJN?=
 =?utf-8?B?dDA0SzZqWkc2cXF0a1JVcmxlSVFZWlA4RFh6cDZZcVVLUzY5ZDdJOGZ3VG5S?=
 =?utf-8?B?VDNDYy9nVGpiM3cxdHdrWGdXTE84UTR3em95eEF6SmxrOEdRbmZJai9nWkVI?=
 =?utf-8?B?UWRxWnZVSCtJOWwzTGhYTkxVdlVxQm9GWThKcE52dkloaGhCSGVycjYzWE9h?=
 =?utf-8?B?T2FBdmVHRmNzbE1rQ1FXcmJrUXlHU1JZbHhVOUQwR2dxcUIwNStpOTJ3ZjRv?=
 =?utf-8?B?Q3B3SWlLZ3o4TEZwYUxqalY5WFo3UVUxaDJaS2Z2YlNYTk5URXJ1ZlVncmxY?=
 =?utf-8?B?a29FeHY5MzRmSG5ST1pCUkNTcFBFRmRnQldWM2p6Mzdoc2ZDeS9XQndEZmti?=
 =?utf-8?B?MzVpbS9qeXYvS3V2a25CdFB5NFBFRFIzbVhEdFV2Q0h3ZWhSem5FbU5WcUIx?=
 =?utf-8?B?U0ZLUkIrZXUyem1VWC9wblRrRzlTeXZYaEtBZUdmbXZFc0FidzQ4ZzhOSmg2?=
 =?utf-8?B?TDc2dWhuVmMwWmpya2xIMXFOa0JlZ1lleTI1ZlRpbngwT1VqVWV0QzNhSEZW?=
 =?utf-8?B?U3pydjZmenZpaC9ZMDB6bEhmbmVvalgwNTVYdEJqdWJUbVhiZTY0QTBYODNU?=
 =?utf-8?B?MVNjSmFwNm13SThYYVR5c2RGWm1hOXNwa0kydkRzWUVqZnZwUDhGQVpkekI2?=
 =?utf-8?B?c2FnRHUvd2J6cjFDMDU1cWVibEhXUkVLaU05eUxreGRtcVFpL2ZSNSs2ci93?=
 =?utf-8?B?eUx5cmRIa0czdEF4T0U3SmhQaWg4TkVBcFVPU2g4cnBWRFpMTEsxMzdpcDVW?=
 =?utf-8?B?b1VaUlRPVjlnSFd4OFFQenN0ajd5cmJUM2pmT1pDL1RPVWREb242TncyaS80?=
 =?utf-8?B?WkxqbkYwMHNabk5EeXB6S3k0VEl1Z0lucEhIbW92Znh5M1h5dUdWMjBDWGls?=
 =?utf-8?B?T2p2NUZLMzgyYVFNSUpqa2x4Zk5rOTF0azQ1dWNLZytvSmFLSVhsUGZHUVNp?=
 =?utf-8?B?eVNoekZFVnZNYm5RNXBBQktQU1QwcUcxdWJheHhIOFN1UEpONHQ3SklDVEdD?=
 =?utf-8?B?RktVL3kwZkdRbW9CaFFQOE1kMlBXNXJtaGVlYitSSmVaNnN1a3gzaFFhR3NU?=
 =?utf-8?B?a0dxTjNRQzdRM2p5T2dSK2VRZzNwR2FncDhMSGRTdHJMd0w5M3hxb1JTdUtH?=
 =?utf-8?B?RmlzNG5BcWJoZ21lN2NHbUJxMFhRelJmZnUrTUtRMVNBZ2VCcnZpRVRuMDNK?=
 =?utf-8?B?RWsrSDgzY2puNFdzeE5MZWZOeGFwcUhGQytacktISmhoeUdXcG9UeVQxNzAw?=
 =?utf-8?Q?5xNgqFEQkzJdnz+x+iq9zwqcAS260YQT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0601MB4891.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmUrQTF0dFFXb0hDSnYxdVlWem0rVzFjdTM5RnpGd0syU21jWXhDQ29GRVFz?=
 =?utf-8?B?dWZTYjZuZ2N4alpneThBMnN2NkNtU0hJbGUvOHNSUk5zZVNCN0hvK3ZpeU02?=
 =?utf-8?B?MWQySzh4YU5Pc1o3dnlldnJuSnUzZU03cys4WnNQMGJLdEZTSnFxNytmSXJ2?=
 =?utf-8?B?ajdyeGZrNlEvUUtYVFRhRUdLRmJrY1FFRURvazFLQUs2WFdVVVgxTjBHOWd6?=
 =?utf-8?B?RHJ5TlRMQ2ZES0JGdVhPZXgwdTRyVW40OEtNVjFoRk1RV3pFaE9sTDhxc25Q?=
 =?utf-8?B?aXhjaWRkME5TVWk4VDFUTTU4amJUWHZlODhZUGJHUWk3UjZwTVpiVFpWZ0ps?=
 =?utf-8?B?VWVGRjl0QWwwRkh2WEZrUGlsQzFXTStYcGVOVEZzZkx5b3BEN3QwZTF5Zlp6?=
 =?utf-8?B?K1Vjc3hubEkrc3htWDBUb2tVOGpGMWV3ZldmY21aZGQ5YmxCelcvWXJ4eXFK?=
 =?utf-8?B?dm1IRWNjSUJISURiTzRRci9FbUhzZHBhcHBHR3hQZlR2VzREeG5rSUlRYXhM?=
 =?utf-8?B?VnNRYjFpTVQvWFhBTWU0eFptSnNBUWUwTVN5TjcxVWJCNlBPQUZzNEorQ2xH?=
 =?utf-8?B?WE5yUDQ1TWQ2VC9FWEs2eEhwbWpCWThiNVZJS0czdXJlejk4Yys0YlhtcHpo?=
 =?utf-8?B?UzNrR2xMTWVIS0xUNC9YeXFUYUdZdGM2TlE3YUd5WlFBTWJuVklPTGt6b29Z?=
 =?utf-8?B?TXZHSjJwNUNZRmE1emVMbHppSml0amZuejI2NGZqc3RaWWhqT2VYMGdKdU5T?=
 =?utf-8?B?bUFad1I5eXI1UW1mUnViUDlKNlRhVUY1aVFGYitqczZ4ZWRiaWV5aTRkd2Nx?=
 =?utf-8?B?VnBxeEViMzhDNDFJNE5zeFFGVEtkQ0lWZmIxNU95dEpQblE0N1FjaDBoSUxD?=
 =?utf-8?B?NHQwOTFoUTdYMkhSWENtYVY4RTFCcGFZTStUeHRIOGVRNnVNOXJxZUdQMUpx?=
 =?utf-8?B?TktmeDVCVUVaNmRtTW1FUENmTDcvc0NrRW1XZHgxMGQyRDZORzE2NGZkYnZv?=
 =?utf-8?B?cThkR3ptUEtxaTVlQWpkbTl4N21WWWJTeldFOFJITFJjL216UDRJQ3EzN2la?=
 =?utf-8?B?YnJ3M1dLUTNnWnJKZExLL0V5WGFQb0hEaU1CV0NwbEVYdFUzTm0xaFhmU2hy?=
 =?utf-8?B?L1ZoaWlvMjBDcEFUY2QwbTNNT0FLbDY4RkJoNDdjakVPVm85eTNSTzJWdzdV?=
 =?utf-8?B?RS8vcGozcVpWblZHZ0V6V0ZUVEtzTUZGa0RzVlVrQmtEWm1GdC9aRmNESzR4?=
 =?utf-8?B?MDZsQVhxMFEzMURYRktQY1RzejZYdDl0NGNTRU1lYTFmUlFrVDlrTzNRZTVS?=
 =?utf-8?B?QUwvWnVxY3pPcVdVZ3NleHYvbnNtL3JLMWFULzh4VVB1WEM0VVQzZFlzYWFy?=
 =?utf-8?B?OGpISUkyTkpBMFVxcWR5cnp5di9jelhocm15Umo2ZHcyOExXb0xFd09JU3U1?=
 =?utf-8?B?bm05U1NHZjA1ZUJIbnI2ZDczaldFTjEza29UTEFGQ3l5Q2xaZlNmKzJEOTBV?=
 =?utf-8?B?dDQ0UWkrdGZVRnc1VkpYZEQ2SFE1MXpPUHJjNFRGSW5mNm9jRDdla1k4OEc1?=
 =?utf-8?B?RldxWWcrT1JoWXhHNXJjd3cxOUtOUGtzaEt2R0QxcGtuTG8rVTV6SndMcngy?=
 =?utf-8?B?d1pwdjN2VWxEbXJsZ1N1dXl0M0xSaSswVElrRTh3czMvTXdpMVR1aE40OGty?=
 =?utf-8?B?d1cxSUYvMWk4cUhEeUs4c3JRcWkxWmpDN3Vvdit5RFNSeG9IMk5ZcVRRella?=
 =?utf-8?B?ZGxHMklBY3RXKzExY2l1SGs4SFZ0YjlzdFlsRzJQZnFSeGpsTUNaOVdsWExO?=
 =?utf-8?B?VTRiRDJ2dEF0Vm9tNUMvUUlEb2sxSG96Wit4YXAvQ2R4MDdlZ0piUytDWXhj?=
 =?utf-8?B?L3NCa1NIU2puZkc5ZFQwSXk2a3BVRE4xK0FoS2tPNzVSWE4rNzNRT0tsY2Yr?=
 =?utf-8?B?bFZ6aFpTSDdtbUhoWWd3bHRqK1RibmpWVFFKMDhPNDdFNEdHUUhVMnZ2blVu?=
 =?utf-8?B?TEJkbHBjdG5VSU5nUjZWZDdSTEdXRlFPdXVwTHF2NVp6dHU4RHhObk1ma0dU?=
 =?utf-8?B?U0pqeFhST0VVMnp0V0pSSUduQTNhYnZ0NGgvbmMxbTcxMHBaVU9sMjNXMjJx?=
 =?utf-8?B?ZFhRbEx2blVCTlRwYzlVK2FkK2p5aWpmTHFlZWszWTQ2VVMxdUdmSCs5dEFS?=
 =?utf-8?B?OVE9PQ==?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c27e885c-831a-4f77-e0da-08dd1ff4c707
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4891.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 06:17:13.4819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0U7Q5wZ+3YeCLvkTOP0PigltFZp55SCH/anjU9qyEo7f/XmwiyWGTtbaxvo/cxN5yRU/QtCIy9rQU9ZJzjaonPPA/gmrufgnUXOzSdHL2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5391
Received-SPF: pass client-ip=2a01:111:f403:2011::727;
 envelope-from=andrew.yuan@jaguarmicro.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

From: Andrew Yuan <andrew.yuan@jaguarmicro.com>

As in the Cadence IP for Gigabit Ethernet MAC Part Number: IP7014 IP Rev: R1p12 - Doc Rev: 1.3 User Guide,
if the DISABLE_MASK bit in type2_compare_x_word_1 is set,
mask_value in type2_compare_x_word_0 is used as an additional 2 byte Compare Value

Signed-off-by: Andrew Yuan <andrew.yuan@jaguarmicro.com>
Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/cadence_gem.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 3fce01315f..7bd176951e 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -909,8 +909,8 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
 
         /* Compare A, B, C */
         for (j = 0; j < 3; j++) {
-            uint32_t cr0, cr1, mask, compare;
-            uint16_t rx_cmp;
+            uint32_t cr0, cr1, mask, compare, disable_mask;
+            uint32_t rx_cmp;
             int offset;
             int cr_idx = extract32(reg, R_SCREENING_TYPE2_REG0_COMPARE_A_SHIFT + j * 6,
                                    R_SCREENING_TYPE2_REG0_COMPARE_A_LENGTH);
@@ -946,9 +946,23 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
                 break;
             }
 
-            rx_cmp = rxbuf_ptr[offset] << 8 | rxbuf_ptr[offset];
-            mask = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, MASK_VALUE);
-            compare = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, COMPARE_VALUE);
+            disable_mask =
+                FIELD_EX32(cr1, TYPE2_COMPARE_0_WORD_1, DISABLE_MASK);
+            if (disable_mask) {
+                /*
+                 * If disable_mask is set,
+                 * mask_value is used as an additional 2 byte Compare Value.
+                 * To simple, set mask = 0xFFFFFFFF, if disable_mask is set.
+                 */
+                rx_cmp = ldl_le_p(rxbuf_ptr + offset);
+                mask = 0xFFFFFFFF;
+                compare = cr0;
+            } else {
+                rx_cmp = lduw_le_p(rxbuf_ptr + offset);
+                mask = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, MASK_VALUE);
+                compare =
+                    FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, COMPARE_VALUE);
+            }
 
             if ((rx_cmp & mask) == (compare & mask)) {
                 matched = true;
-- 
2.25.1


