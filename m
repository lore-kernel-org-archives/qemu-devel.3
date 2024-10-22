Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21B2D2C55D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 14:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Flp-0006Y0-0C; Tue, 22 Oct 2024 10:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t3Fln-0006Xh-I6
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:21:59 -0400
Received: from mail-dm6nam10on2061b.outbound.protection.outlook.com
 ([2a01:111:f403:2413::61b]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t3Flk-0005uW-Gj
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:21:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7vIJXnwzDjZXgzDgfsufMbTC00rwvYPStRkTe4YstxdwcTJhQDsQmjEWBLPSWMffFqFKWta65I4vEORs/E10peylbR8Nlx5eS7xTSN4iztWchLnlvUHmaw2NDWPtpXWDl8aNvRSxEk6nBsde3J9hjfLmaP3317u/LIZ1xNbpGOBTRh0yXMCPtqOAhOYNEyo5HkSKNfcYL1VWWs2hX6CJe5OyxQlyHv4gRq/Ye2T98iUtsg8V8SbF7QGN7sypaJ7y8o3bClbLBUy1v4Qa4FXZrp7cz+SWmUClRgdkxObZtPJmAnQalSUbqw8MkT7JNcBySJVWvjGaEjjSkg6M3AjQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOy2X2O51GxHGpkyLBXtz77qN6Hfm19Azt+A5qq175w=;
 b=it09hsddVaU7/tEnnWSlfFSoC0EZvrou11jkIT1jixvVHBcW5XZ9GEC7XXKfKmJw716atH5Bn9khzMpAKKBUcTorduuAl9WZ9/q7S9Uv8YFnLsdI00DVcogjlfWO3HkXMFFLuaauro+ZPIULRO8WfcgAYPnPe6J6VciTYXxt2Abfx+IIuVLzPifzefhoxJT5ucyN0RTGRav92I+GCD6xUn8Q3OhYyZqxYtduMBv3Xs6gujUn9zN95tZ6loVk+Rn2Wy+a1yEUNm+9NoNK4YHB1dcxl1/86zZP2BN9QNcGWCFL3UuZw+q52d9sDlDivQw2FhGuST0dkXoZ/ptHG2TlCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOy2X2O51GxHGpkyLBXtz77qN6Hfm19Azt+A5qq175w=;
 b=Zt1TfRYc5HxpsEX6H+9XB3y+toOqYsWTpsaIQ/DdkQyxQDnvYPGMfWMdgYXc3U50WMpRxzfLujNzL1sChsHMB/6nWzQQlIyuOkRP/2e+RY6mNMItU5/1DWjSlj8GgOBLFuyHu29q0BrvP6mtoExCFCmYL140lEENHudeh/8XCKgpvbHtFeMAqU1B0VxiC6AsHALtozNrg8dL1oXCoqkJDscnln1TwWSW28CD4uRj1X5A8nvKy+UDfx4quiT9jYRl70qti3vRjxXw46m9QDBCyw9RzWfZ6y0i1FtxkjT7EchZjqJDXjHjBl++UeyeBjW2Qy9mg4hhJ5cVv2i1RN1rOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Tue, 22 Oct
 2024 14:21:50 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 14:21:49 +0000
Message-ID: <2581b405-4670-4a3b-8e39-a653d338778e@nvidia.com>
Date: Tue, 22 Oct 2024 17:21:44 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] vfio/migration: Refactor
 vfio_vmstate_change/_prepare() error reporting
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20241020130108.27148-1-avihaih@nvidia.com>
 <20241020130108.27148-3-avihaih@nvidia.com>
 <cfca06dd-cfd3-4a36-a80f-b8e2ddecbf88@redhat.com> <ZxZ4Y5KSNPcuN8-X@x1n>
 <68d60abe-32b6-49b3-bc60-6c92909252f0@redhat.com> <ZxaHPo7GRPuby5ky@x1n>
 <3e0d59e7-699e-47b2-a6dc-204d64e07895@nvidia.com>
 <d172a1b8-9e6f-42ef-a78c-decb5c9a2944@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <d172a1b8-9e6f-42ef-a78c-decb5c9a2944@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::13) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e966015-cc88-4868-3fbe-08dcf2a4de08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTFycXB5U1p3V2ZwbE5UQ1RNd0pnTTZWKzh6R09lek1oZ1E5MGI5b2NDd2pp?=
 =?utf-8?B?YkE0d3V1eFRKdVFqY0lKK0lCbHkzcWw5eElpS0pFVEVMSE9JMm01UXh6YkFE?=
 =?utf-8?B?anUrYkpxNXZDeE5MTjRxdnJmdFFFS08xL2ZBZDhMbDVxaHlOK2dSc3E4cW5r?=
 =?utf-8?B?UldzYXhIWFl5cUtJRnNPMVltTGhuaEsweVhZWEx1V2ZxZGxtVWFMQzd0bXQx?=
 =?utf-8?B?dTcyQ0lGaUZKT0svR0pZMHhZOE5pYkJoMGxUZ3pIZFZuSTZTNk1HNWhxS1Br?=
 =?utf-8?B?ZHJnc0xITm1aZ1k0R1NTdDE0VHpYSzZZdXRTajR0Rzk2azBlSlNvZE5VY2Nh?=
 =?utf-8?B?UTc3b3oyakVNc2tYbzlMSXFIR0l6SHRPWS92QXBKK0tPTEtGaXFsMk9waXRE?=
 =?utf-8?B?UzY4UGM5a3M0V25nN3orbDVoU3VUSXpwLzFwV1p3MnJEejZlT2EwYTdzUlNr?=
 =?utf-8?B?dkxteTZxQnVNZ1d5c3lTd3FhYkNyTHJkdXphM2hNU1pSekpsOElQVWNGUnZv?=
 =?utf-8?B?OVN4Y2o1UU12ZlpFMTJ1Njk2M29sNHlxWnBtUXEwOHVLWnhYOHRSaUdHZE0r?=
 =?utf-8?B?bTdaU2crbVN0aG5DckUvVGhmcWJyblJaRXRnRGkxWmRmOTBTZGlidTJCdHd5?=
 =?utf-8?B?aFJNajJMdFF5Tks1NjNGWnU5R29iODJ0OGVYVytIVFB5R2dXTlArV29qQ2tN?=
 =?utf-8?B?MHdJeFZMVGY4UjMrNnhTdWdQUTZoTEpHT3gzdmpIaTNlZWpId0Q5N1BobFRE?=
 =?utf-8?B?UlJrSXI0d2pJZHA5UUhYUmdkT21UbU1naFJpNG96cGhwTzVEYWtuMXZTTEdp?=
 =?utf-8?B?RTRVMHI2VkxsTThtUEtRUnZMYzE1RWZSL09vZUJEWDh3Q1V5cWlHMlNxMnRL?=
 =?utf-8?B?MEJFcmIzYUg0dzdYVkRWdVFybExSNi94UENPVUpaWkJhVGo4UVB2bHRkbms5?=
 =?utf-8?B?SkVSdlZXczM1bHdVUUJuNlJrTlNkQXFrNU5CZFZHS3BObU5KSVhNckY2WHBX?=
 =?utf-8?B?a0pPZVZqRi9haHdrNW1DQ0tCNFZ0QytiYmYvUE1jenk3ZEpidmF2YnE5Y2FY?=
 =?utf-8?B?Q0NZN1U1Rm1zc0wyQW0yRmJ3aVVYMEU5Y09qdEsyWXpMZlpDMFA0VFVwbUtW?=
 =?utf-8?B?WWhuNUxJSit1UHhNMXZUV1psSFpmOWV5S1drOWlGekZ0L01LTy9IOVllMDY5?=
 =?utf-8?B?Y2NPbXp0T0V2MTdid1Y5Y3V5UU1CTzVzWlJZYVl1TU9rSjN0TjdVZXF3RThp?=
 =?utf-8?B?RGdkcTBUanRaRFpHNzZ6N3ZYL2YwcjdIWUhLQmMxb1ZtYVpsRk5qakJFRk9m?=
 =?utf-8?B?K3V1UlNueWZ0MG9iem5Id01FOXpqcllMZWkycVpIUngxa1RvbU9Qb1lrVi9G?=
 =?utf-8?B?TndqZzJ5Rm93VUtXSXI5ckE1RGVKUldxRnNTUXBkMTdqN2pmeHI2QStnS2Qx?=
 =?utf-8?B?eTMyV3loa0M1SW1Pc0kwcEluZTRnSnhxazhvejRlKzEwektYcTBXQlIwMkhq?=
 =?utf-8?B?VnF6QlFpcUFwUkpyVXBzM3loZ2YxL2l6aVRaN1AzVkVORXdrbC8wWGg3MmZr?=
 =?utf-8?B?RlFIZG5hcFlYR0Q2bmZ3Nmtia0V6aG5najZoRld4amNpRzRReHkySXkwTHZ2?=
 =?utf-8?B?NHpZa0pKd01DUHpsVUdEem1GQ05iZHJ1R0t3Uys4alcxK2NJTVh4SXZ4S2Rv?=
 =?utf-8?B?Z25BYjYwR05hWFpiKzZGQWI0eDdTazJ4eHpkMWhuVjN4M0NrNXNEWWl2dUVG?=
 =?utf-8?Q?jc/igalLcyZFo3i9VNpCSwXmPmiumajJ/wnK9CS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGhvNXdubENkUURKckZPRDZoUDZuZUx3cGtUM1lsUG5JbEt2ZzRkL0ZyNnRs?=
 =?utf-8?B?akh0dzNtZmFuMVN1MG9yZmp0WlVlY0RYTmtORytqNEwwY1l1V1A1ZHNBT1ZT?=
 =?utf-8?B?TVQ1WmFoclQ0eUZnbjJlWlBIQ0xSamFIZllVNzVaWmdpSmxuQVVzajFmWDBZ?=
 =?utf-8?B?NGV2STI5MGRoOWNDNExtUDN4cEJFRjdZNWxXSy8veEJWaHdzVmJQcVc5cmIv?=
 =?utf-8?B?dGVjZnV3UlFxT1pxYXJ0eG9PT09lSnZCcjYycUh1YXdOeUNVdktDRGFhbDVq?=
 =?utf-8?B?S2hLalRzS0xmMzRvTU9TbUg1b1lRNUxIQjZGM2p2MFlpS0xWUTBpWjB4MUV5?=
 =?utf-8?B?RW5qRmJZK1FSR2E3aXpWMFQrU3Q0amtYejg3UXRXc1p0ajdMZ2sySEZJOVk3?=
 =?utf-8?B?Qi93QWo1YzV3a3BEY2Rpc1dQVk4vQks5ZkxucVE5RlFNQkdKUC9SRWpvV1N0?=
 =?utf-8?B?TDJHc3VHUWJiZlhzK3pid3RJSWU1a3FMWms1Wi8rSnZSdFk1dEpIczFWTWhO?=
 =?utf-8?B?eUIvL25ldnVJK1JTbjlkdWVVZUZqaXZXWkx5dGpOZDNxL0ZGYk01bHl5ZW9R?=
 =?utf-8?B?ZDhkSVZlTkFGbzFiZUZTaG5wQXdmWGhkMFlrZGFzYi9NLzN5dm92WjJKZE9k?=
 =?utf-8?B?anVUc05XZG41clFGakg2T0xCWDVsSWhlcDJCVEkxVWd3bTF4RGFPY2VpTFg3?=
 =?utf-8?B?QTF4MEVVMktXRytOMXZhM0hNN2tNWGJHSDZLejd1YWk4Mzd3NnFkYUVRZW4w?=
 =?utf-8?B?TWtSblc0T1FKYmZyRFBjY2tXQUs2U1EvbXlxTUN0NEdnbFNvM1o3UnVyUkF2?=
 =?utf-8?B?VVdlUG1TV1hqR2YwN3Jra1hCOEMycWxjY2puaXR6anZEME1mZFRtR1VuTENp?=
 =?utf-8?B?cDloZllmbGhBbG9lb2RtK1dBc3lOV0lYTnl4NDRhMW42VDRDNXk4Vm1Gek41?=
 =?utf-8?B?UkkxamFrRm9EclFKL2U0ZFM3bzlJMlU4bjg5YnBQc2dEbnJwOFZGZlRrUmgw?=
 =?utf-8?B?NUVLOFdER0xjaFBrRWN5ajNLekZCRmg4OGRya1NJZjd4Y0xBRmw3YjMvQkhk?=
 =?utf-8?B?VUNhSGVtNVB4cmZwMGcyYUJRWTZ5Z0tMdW9uUklOOGgrRTZmQUdMRUJkaE1R?=
 =?utf-8?B?N2hhd0U4c0cvZDBOM1AyV2hZak5UVnpibElMYWxuM1U3QTdZczdpNlRwUDVS?=
 =?utf-8?B?V3hHQ0tINkVCLzBCTkRNQUpYazlOamd4NVFETDVOOVA3anZKRFc3V3ExS3R1?=
 =?utf-8?B?NUpGNTRuREE0NkNlNGRGVkZYUTFwcjhDcjZNenZ6Z2pXQzRNN2hsVWRwV0E0?=
 =?utf-8?B?ZDRINEw2WVVkcHpadWF2OGpPaGQ2VzA4bU0rV2s5di8vUVFXbDM1WXBESWt1?=
 =?utf-8?B?Mjl4ZnFjTTQwYVpWQTUveitEQTN5T0I2dk42Wk14ZHBBQ1N0UG15WmM3MjNo?=
 =?utf-8?B?SmJhaVd0SEwxS25aUXBhNmN1ZW55Uy9ya0thRnA5RW9lZ01hd2NrbkMwQnYz?=
 =?utf-8?B?VjdhL1R1NGNsM1B6VUNNTzZxbHk3QTBTQTFRdlhhbSthekFlQzRmV3N2MkRt?=
 =?utf-8?B?UjV0TnpHWVF6VXR5STFzbGVYWW9EbGNHOFdWMGFFRUpLMU5xdnpvVGFBeFFS?=
 =?utf-8?B?NGFndHR5RnR3bHd4MEU4OGVBVk5qQklvdXR5Q0RMemJmdFpLQnZURVlJQjNW?=
 =?utf-8?B?MCtzREhlaTdYbVJVL1F2QWtsZlNyR2doc3lWb2RaTHIvU3hmbGI5Mms2Z1VM?=
 =?utf-8?B?c1oxME0xckVQaXpyR3kyajF5VTJyQ1BjdHR6Ymh2ajk0TVlqZzNBMHN0Mzc3?=
 =?utf-8?B?S1hOL09SS3d0alBaUlJXKzlqeVcveVBnYmVTWFpIcXQyMHpVWExNbGMzeVNa?=
 =?utf-8?B?Tk56UW1FMmdONkNZcDBUdEY0TzcreTBCMTJJOWMxSFNrQkZsekRSbUpzOXBL?=
 =?utf-8?B?NHNFTloxSFMyQnBLak9FVWdsRFo0MXMyMTZ6ZGd3YU10ZTVLVitlVmVDdi9X?=
 =?utf-8?B?MVcrN0RNU2k4aysyTVNNWGhGbGx0am5GM3hrKzBwMFFvamJ2ekxFM0NwZ001?=
 =?utf-8?B?ZnErKzNESnFBQ2s0OWlSRG1CSTVwQXdiOVRNR0p6UFlrWjVPM0dwN3B2TXRO?=
 =?utf-8?Q?qT04/6Jd1GCayqH/7RsGdrv5G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e966015-cc88-4868-3fbe-08dcf2a4de08
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 14:21:49.6140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzrVfVGdZYmkWGVoJN72ABSl8WWCeSGw8t1dzCdRgw6lKuXLH13nK+Z9yEWa6V56xegcsNK+B2NEATnVXHT0WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
Received-SPF: softfail client-ip=2a01:111:f403:2413::61b;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 22/10/2024 16:24, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 10/22/24 11:38, Avihai Horon wrote:
>>
>> On 21/10/2024 19:54, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Mon, Oct 21, 2024 at 06:43:13PM +0200, Cédric Le Goater wrote:
>>>> Hello,
>>>>
>>>>> IIUC the migration thread should always see valid migration 
>>>>> object, as it
>>>>> takes one refcount at the entrance of migration_thread():
>>>>>
>>>>>       object_ref(OBJECT(s));
>>>> Could the migration have failed before ? in migrate_fd_connect()
>>> I just noticed it's a vm state change notifier..
>>
>> Yep.
>> I stumbled upon this bug by accident when running on a buggy machine.
>> Migration wasn't involved, I just started the VM, shut it down and 
>> got the assert (as my VFIO device was faulty and errored on 
>> RUNNING->STOP state change).
>>
>> You can repro it by forcefully triggering an error on *->STOP 
>> transition:
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 17199b73ae..d41cb7c634 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -831,7 +831,9 @@ static void vfio_vmstate_change(void *opaque, 
>> bool running, RunState state)
>>       }
>>
>>       ret = vfio_migration_set_state_or_reset(vbasedev, new_state, 
>> &local_err);
>> -    if (ret) {
>> +    if (ret || new_state == VFIO_DEVICE_STATE_STOP) {
>> +        ret = -1;
>> +        error_setg(&local_err, "%s: forced error", vbasedev->name);
>>           /*
>>            * Migration should be aborted in this case, but 
>> vm_state_notify()
>>            * currently does not support reporting failures.
>>
>>>
>>> If so, maybe VFIO could refer to its internal states showing that it's
>>> during a migration first (so as to guarantee the migration object is 
>>> valid;
>>> e.g., only after save_setup() but before save_cleanup() hooks are 
>>> invoked).
>>
>> It's an option, but I think it's a bit awkward as we'd need to check 
>> that VFIOMigration->data_buffer is set
>
> That's what I was looking at too. It works. It feels a bit awkward
> indeed. We could hide the details in an helper routine though.
>
>> or add a new flag.
>
> yes that's another solution.
>
> Peter,
>
> I wonder if we could grab a ref on current_migration in save_setup(),
> store it under VFIOMigration and drop it save_cleanup() ?
>
>
>> Besides that, as Cedric pointed out, VFIO code calls 
>> migration_is_setup_or_active() which can also be unsafe, as it might 
>> be invoked after migration object has been freed.
>>
>> Maybe a simpler solution would be to extend the the migration object 
>> lifetime?
>> Looking at commit history, you can see that commit 1f8956041ad3 
>> ("migration: finalize current_migration object") added migration 
>> object finalization at the very end of qemu cleanup.
>> Then came commit 892ae715b6bc ("migration: Cleanup during exit") and 
>> moved the migration object finalization to the beginning of qemu 
>> cleanup (before stopping the VM etc.).
>>
>> If so, the fix could be something like the below?
>>
>> -------------8<-------------
>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>> index bfadc5613b..5eb099349a 100644
>> --- a/include/migration/misc.h
>> +++ b/include/migration/misc.h
>> @@ -52,6 +52,7 @@ void dump_vmstate_json_to_file(FILE *out_fp);
>>
>>   /* migration/migration.c */
>>   void migration_object_init(void);
>> +void migration_object_finalize(void);
>>   void migration_shutdown(void);
>>   bool migration_is_idle(void);
>>   bool migration_is_active(void);
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 021faee2f3..9eaa7947bc 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -265,6 +265,11 @@ void migration_object_init(void)
>>       dirty_bitmap_mig_init();
>>   }
>>
>> +void migration_object_finalize(void)
>> +{
>> +    object_unref(OBJECT(current_migration));
>> +}
>> +
>>   typedef struct {
>>       QEMUBH *bh;
>>       QEMUBHFunc *cb;
>> @@ -330,7 +335,6 @@ void migration_shutdown(void)
>>        * stop the migration using this structure
>>        */
>>       migration_cancel(NULL);
>> -    object_unref(OBJECT(current_migration));
>>
>>       /*
>>        * Cancel outgoing migration of dirty bitmaps. It should
>> diff --git a/system/runstate.c b/system/runstate.c
>> index c2c9afa905..fa823f5e72 100644
>> --- a/system/runstate.c
>> +++ b/system/runstate.c
>> @@ -930,5 +930,6 @@ void qemu_cleanup(int status)
>>       monitor_cleanup();
>>       qemu_chr_cleanup();
>>       user_creatable_cleanup();
>> +    migration_object_finalize();
>>       /* TODO: unref root container, check all devices are ok */
>>   }
>> -------------8<-------------
>
> 892ae715b6bc was trying to fix potential use-after-free issues.

Yes, and it did, by ref/unref current_migration in migration_thread().
In addition, it added a migrate_fd_cancel() in the beginning of qemu 
cleanup to encourage migration_thread to quit.
IIUC, these are the core changes of the commit, and the only reason to 
move "object_unref(OBJECT(current_migration))" from the end of qemu 
cleanup to the beginning of it was to put migration cleanup code in one 
place.

That's why I think moving "object_unref(OBJECT(current_migration))" back 
to the end of qemu cleanup is safe and shouldn't make much difference.
It will delay freeing of MigrationState right to the end and will allow 
us to use the already existing helper (migration_is_setup_or_active()) 
to check migration status.

IMHO this seems like the cleanest solution, unless I am missing something.

Thanks.

>
> I think it is safer to introduce an helper routine checking
> (in some ways) if a migration is in progress than partially
> revert 892ae715b6bc.
>
> Thanks,
>
> C.
>

