Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1A7CD98EC
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 18:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smGs2-0001Do-Oz; Thu, 05 Sep 2024 14:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1smGrz-0001D1-1n
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 14:06:11 -0400
Received: from mail-db8eur05on2109.outbound.protection.outlook.com
 ([40.107.20.109] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1smGrv-0000Qc-MR
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 14:06:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1a14EGqC6YGtHStzv6MtD0lkiYB3AeQYsx7RMINbqaM72aUQKfAaOTsYOZUlT4Ygnwc6uz+j8DvOj1HxDMUm3sowakKRRy1yh8LedQvErub6aYLPb9Q+42QZNCgUYkzmyHYrxdRug127kieCd2ew1AH8DncMmA+EpinAkqmywKfBsYlPI3SgY/wyBaY4zjL7awdjqW/ZcCRlA2roWJQePvYHRMd/jbldZi+0HQOsTepjWBRrTDOShCtH8Z/v7F2pFVg+eMkVXhvRleDn2Z1jubCSLtZtrBRTR59Dqg91unjeQE2F935HLmj5HgRHHY1wy337Ds8hPozM5nTAyF5SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVgcP/tmV52DtR++m30Wgnlp3jhv08g8Tn75SZGQkJ4=;
 b=tl/0KM3c3heLFz5OC5UKffgivtvm9zAVVENHu7XHzUYAHP4jfp0jfygITXRAt4P+cwl+Hl5b/b9ndUyhTf1ags+yoWytQRGGym+nO3Aboaqwi4iPyFz9YIM2zsMUSC0upre1HMrJylpHYdAzxrPGugWp4r+YxS8DxJvY47OP+fTPZbibMIGZCw4qR+qtSjaY9xtiToheR8lRtMLolcKHPIePwpafG0zNdx8svfsIdfFhUQQ69kP6pq4WhsOBfRaQpfNEN/YrJA8VjjwFkH75x8Xtq30ZNKZUbvttssuJn3tAZWMl4ersvvDviFD9AWuTKRVMZGhAIPwACC0q7dzMBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVgcP/tmV52DtR++m30Wgnlp3jhv08g8Tn75SZGQkJ4=;
 b=WA1iqXuDUU+cAPz2MpDPGVasPMrj6l/WDfj4yK2/LZuUBgjAp2pDEctHcyA8kX1zspU/1OjpwIR8idwtqmv6hq97IE/VIsg/hJvVWPraQ0hRNFRgyCV5FkifQaux6PxvrSsxAxWfswifsdLr217vzDn5CY1+UjEnnwqjdXptmDBsfVex8sJ1BMgESpoJ3ZAvdZZl3etQrfYO8pbyhJVaItRKNVjI3bos66lpYyiFMv1po4Np3QOKQj32RSg45CwCqqZvItgxByYK47mcFHHn2SXD0nJCZYUmMTbbRfYqMVUeTrYnO43Z2JAWzZ0LLI4ujBe4bo/7yUkV/30I6pnCjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.16; Thu, 5 Sep
 2024 18:00:57 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%4]) with mapi id 15.20.7939.010; Thu, 5 Sep 2024
 18:00:56 +0000
Message-ID: <fae6629b-523f-46be-8b45-d3fa9174ed4d@virtuozzo.com>
Date: Thu, 5 Sep 2024 20:00:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] migration: improve migration_throttle tracepoint
To: Peter Xu <peterx@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20240905165146.293586-1-den@openvz.org> <Ztnv9mouMVIbHnIx@x1n>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <Ztnv9mouMVIbHnIx@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0131.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::24) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AM7PR08MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ebec991-7abf-429a-fbf7-08dccdd4b11b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWFabUhhN3NEQUkwSUdlN2xtSktETkpVeTRaZkxtRTVhRmdoTExQaU96RXdU?=
 =?utf-8?B?eFlRK2hVa2I3ejVDQTJqZU5BSGdXZGQwT2xsbGY3cWxTY1hmUFB2WXBwL0dM?=
 =?utf-8?B?YlYxYjd3dXJLdGhSSVhTdXg1K0VuM3NSZG9KRGdJZDl4RjhHUUoxOGdTcjV3?=
 =?utf-8?B?ZytQUk1OVDNXNUV0enp4Nm1GQ2pxTHQ4YUgvaXplZEF1dnlzZllRZnowWUdx?=
 =?utf-8?B?RW1hZGIzaDVZYWpwNjR0cmE3ck5zWHVVM2ZFWE1xSWYwSHhHWEdqNWFadlJS?=
 =?utf-8?B?emJYNFNTZm93QlM1K1Fwc0JMN25lbjFPbkVUQk5hM2czK0hoeXZTdC9Tb3JZ?=
 =?utf-8?B?Mkt6UnF3aGJoZFJyaGJYZk1LRzg2OEUwd0NWSThTUmg0eW10MmVSOGhaeWtM?=
 =?utf-8?B?emNQenV6dFdNMkZHVll5cUExaDhQZ01QM3FEM1Nwaytha1JYdHJhMWE3Zzgz?=
 =?utf-8?B?cVV4WVN5djI3RmVQaG5OL1VyMWFtdWhMazZJRW1uN2JtS2JOVnozMWFiNnFo?=
 =?utf-8?B?dlBOL1FpSG1RZlFhWk5hRER6eHhod2JuQzJoU1ptRllBdmlaUS9qQTg0QjhE?=
 =?utf-8?B?eUZYRTd6eldxVmJ3NDRmS3I4b2lES1Nwcm5TVVZzVFNMS1hrRnVUWUVDYm1E?=
 =?utf-8?B?aG84L3o2MysxNDJHeGNvb2g1M3lUNmZ1ZzJEenoydS9BOWtNV1poeEM4RW5K?=
 =?utf-8?B?STJ2Z3VWbVBwQk0vaXlYSWZOMmNrVDd5QWlUMmVyNGJuWUl1SHQ4UmhQcmJK?=
 =?utf-8?B?bGxxSWRWZWlrR0ozY1pyc1UvOE9EdW1pT05OalJGTzFhRXdSV0dHdnF0TVh0?=
 =?utf-8?B?aVJONDM2QXkrYUcvNXlvY0JCQ3k2RXlTNTlOb21TMEZ1YnZJWVR0ajNaODRB?=
 =?utf-8?B?S3I5TzVsQ2g1cCtwQlE1QjhaZVZBZUVWVGJWc1djRjhJeG9xSXA4a29Vemtj?=
 =?utf-8?B?dlBLUmUxNUVRZVZqa2F0REtOVzVzb1lDdzI0cUQ0WnNPY09TdVE5b0pybWJY?=
 =?utf-8?B?aUFsSno3c0NkMGNkeXR0T1BGR0RNYzBEZUNqaTZGa0ppam8vSkhhZ042ODF6?=
 =?utf-8?B?UjFuWWRJMVk3Uk1RY3ozU3E1QW03bEtVV0k5eHplcFZBcFRDVHdSVXRiblFa?=
 =?utf-8?B?VExMVEFaeHJoN3oybzdIbjBQMmNQTk9FNDRvaFB4VE13VWpUZUJtMTJzSHJX?=
 =?utf-8?B?akJvQURFSmxNcnR3amtxQW10R1gxT2FKYm1zWTFEeDJmSUorYU5ndU03ejlL?=
 =?utf-8?B?WUJHQXRYVGdhNGw1QWdCWTJIOTljUFVFNDZRWkloUXNQWlBjTlNmWjl2MG9u?=
 =?utf-8?B?d1BtRTJ5Nmwvb2ZHZ3VEdVdSbFIyWE1EeVFzRUxDMGNQaVVGMGtHaFFqUjJQ?=
 =?utf-8?B?RGxZSzYxUW9LT0hEcENkTEo0bW5WZmUxN3huNmxhQzFoUHkwamM4aGFGSEtZ?=
 =?utf-8?B?M3hVMkpEMUpjdXp2cENiNnBwblhHYWNhdkJPaTI2UWozVU80ZWdZUVAzajAr?=
 =?utf-8?B?eUpQcDROOEUrQ1k1YVRRTXVoTEZYTFpTVGFzaklpbkViZW5DcDNENzVFbmRH?=
 =?utf-8?B?SXFzcWluOUdTYVlYVVJLR1lxbktqNnlicW1mR3o4bjNLVUN5SXR4YWo2M25y?=
 =?utf-8?B?UFRsOENqV3dNNDExQVUzV0RqcXlERVk5STRDZ2ROc0g2OFhXVHhDVDJKK2VB?=
 =?utf-8?B?QzQwbEpQVDFtZFYvMXI3bGhSdUl6NllpVENydzJBK01ueVM5eFduMEcwckZm?=
 =?utf-8?B?UzJHUTNNVTlTTHJJellzMmQ1a0t5K1FDc29WN2dhOWtNcURzbGhlTDZYdHRv?=
 =?utf-8?B?cW1yZFhKK1hVUkhBRXVHUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU80akpYMnBjSkxWb3RwRGVqbVVVS0FMcllzODBmSmdOSWtCT0ZYWXdETTJN?=
 =?utf-8?B?NVcvNnR3OUNGVnlMNDhmeGJ4NjRQVTFoZkt3SEhSV0dOMVJOSFJKQjlXU082?=
 =?utf-8?B?dmRXaWNWU3hWQzJsZFNBM0lyRVRwb2pONjJLZUppeVZnaVRZTDg2TW40U00v?=
 =?utf-8?B?ZGZydTROTmNRMHlraDFSSnRoY1FlSzRQZ0ZTQWJyaE5PUFcrTlh2c2ZFQjVt?=
 =?utf-8?B?TjZ0ZVVLOTBzUjdtZ1Bsa3hKUXBGVWlaTEt4eEtMd3Y4Z1ZacmNkdm96SDA3?=
 =?utf-8?B?ZEx6dHdpb0RLN3cvR0ZHWXRaMldtNzJJaGN1VTVjNnBQeXBLREpUOXpNODNK?=
 =?utf-8?B?aHZKdkVLcU0xNkxKV1JXeEtQVmYxRGV0SjU3USsyaU9FZWxZZ0pibzd5R3p5?=
 =?utf-8?B?RExKZ2NwU3RvZjJMY3NPZHNhZGhXTUMwVEVSZU5DL2liTFliNUQ1WTVGdkZq?=
 =?utf-8?B?MDZ5RHBOYjd1aDJKNXJJOUxPY0dQeXVBRE5taVprRVBIb2toWGtoMU1oY0kr?=
 =?utf-8?B?UmxLckNqQUdTYXZiYi9VM00zdWozUFVwL1ZkL25uWHJCTFNDQnJWNHdCcGRQ?=
 =?utf-8?B?UDRpYkxTSnc3Sk9lbFZPVTlDcWdRQ2pTTWVLckh4ZU1ySHNtSTZocFpsTmtG?=
 =?utf-8?B?TDlWamRhSjZOQjIyTVlPaEJBelRFYlVxRHdMZmdieHlSTG96c0lJdC9QNTcx?=
 =?utf-8?B?Skd5cHF1Q0FrSEdBaHVjbklkNUgwdU5HMU54c1lhb2RsbG9sRHErWkJrR1BR?=
 =?utf-8?B?Q1hqZzk3Mzg5UGNTQ1VrcmlqMDFibks0KzIvdVZ3V2xWQTR5SjQ0Uy9Gd012?=
 =?utf-8?B?aG9LeVZNd2J6N0VYUjFBbysvSGFQYyt2cUFWRHUyalE1QXd5eGYzYnl0RzVH?=
 =?utf-8?B?NW01MTZiME54ZU9FZU15NEFwV1ppVzAyNHl5clBoTUFpdUpCZGFRcDlpTEQ0?=
 =?utf-8?B?K1JoUEoxVzlGam5sb2RId1JjYzNjWlhqZEN1bWJ4Znp4NGNEZmR4TU5zOEk3?=
 =?utf-8?B?bmJ2dVl0ZThWWmlLcmpCbU55OFpkd2JtblAzSjU5bGg3WlcvYnhSY3NGblRK?=
 =?utf-8?B?WWs0WDR1SENOYjhaVEJiSExzd0tGYWJmYW85N3RmL2NESEV6WGNUUjd6TUxD?=
 =?utf-8?B?K25WQlJlL0ZBNnIyRWpMdmQ5Rjl4a2loQW9tUytzeTdrNEJ0OTcrVW13Mkdn?=
 =?utf-8?B?ZWJqYnFkaUhkc1paSkZ2ZXd3UVJ1cVhmdmdUbW43clRWMGM4Rk4xdGhjYVBD?=
 =?utf-8?B?cGE2NnVyTmJFeThaaEt4bEE0TjlnRisxcFZRMnZFbTd5SWpVT1kvYUliVjFX?=
 =?utf-8?B?UlpEbFBSU2Q0Z2VyOHlPM3E3MUdaNGQzRmdUa0xSUjZCZzdBaVhhU05FUVR2?=
 =?utf-8?B?TmFlSmI0dEN3ZEN6TlZXMlo3dDd1U3VnbERWN3RnUzdHOExrUzFiajdMR0dU?=
 =?utf-8?B?S3RiejdmZGRCb0QyWnBlY2o3VmFDdldDZlFBTFYxZk9qZlhzTkhSUmJTV2Fi?=
 =?utf-8?B?UFloVFdWZVN4Ly9RMTdkTVNHVHRpOUhhQnVPbVN5MFR1THlRbTBiS1ZEQTBJ?=
 =?utf-8?B?bWkxMUdTWHdvcTdWd0o4SkIwMlBXNWZueW1YN2NickduN1Z3b2Z3SFpDUCtj?=
 =?utf-8?B?MG8xbTk5Z1BYeERZVFlDSTJpSjlic01hUE5jS0ZHRDlQSHpWTnFqMCs5eWxm?=
 =?utf-8?B?VDUzVUFENHJtVEMxYlVuRVoyWUx3bElRazVoSXJndC9BUGlVWmRpTzc0RXlY?=
 =?utf-8?B?d0R0cjVPN1BuWXM4QWRlbHZxSTFJSG9yUkRHNHVWYldkbHdtRTFMNityMlNx?=
 =?utf-8?B?MldVTVU5OFRDaHhrTUxrQzBVN0x6Sm1wS1hIR2t0V3htYjB1MHRNT21wd2w0?=
 =?utf-8?B?QmtBQ0VvMEVySjI0YnE0THBSV1hMSWRxTE9CNHlyUWpQSDFuOWV2WW1aWmxM?=
 =?utf-8?B?emJTazd6Nkl4WDVIOVJIcndySi8zOGovRC90c0tFRDZTbm5xY0FlRk1nYVdD?=
 =?utf-8?B?TTE1WGd2U2NUaC9GbFdXdGplQ0xXbWJLMkJZNW40dFZkRFUyb3EwbFF5cDR6?=
 =?utf-8?B?OXczL01WbGh2YjBWNjZDdkU3YUxCQlptaHp1UFNleTBpQWlKZW9MRDlQWk5B?=
 =?utf-8?Q?1EufZwgjAl1a9YQmzRXaYh9oH?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebec991-7abf-429a-fbf7-08dccdd4b11b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 18:00:56.9097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxCzTqp36sicXHfsZL0YtcXxWLNHsOvpq9PqFqNHrkxlOOez6hgesd7KfqshPtnY3QB3wu/P36cXV3GuqAjakA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
Received-SPF: pass client-ip=40.107.20.109; envelope-from=den@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 9/5/24 19:52, Peter Xu wrote:
> On Thu, Sep 05, 2024 at 06:51:46PM +0200, Denis V. Lunev via wrote:
>> Right now this tracepoint is just saying that the guest has been
>> throttled, but this is not that good for debugging purposes. We should
>> also know how much the guest is throttled in order to understand
>> consequences for the guest behaviour.
>>
>> The patch moves the tracepoint from migration_trigger_throttle() to
>> mig_throttle_guest_down() where this information is really available.
>> This is not a problem as mig_throttle_guest_down() is called in the
>> only one place.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Peter Xu <peterx@redhat.com>
>> CC: Fabiano Rosas <farosas@suse.de>
> Makes sense to me, but maybe we can further move it to cpu_throttle_set()?
>
in that case we should rename the tracepoint as in that case the
module would be different :)

    4     90  system/cpu-throttle.c <<cpu_throttle_set>>
              void cpu_throttle_set(int new_throttle_pct)

Will it be OK for you?

Den


