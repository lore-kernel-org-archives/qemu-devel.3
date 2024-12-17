Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58F3E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 09:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNU6l-00062W-Cz; Tue, 17 Dec 2024 04:43:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNU6g-0005yT-RQ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:43:11 -0500
Received: from mail-bn8nam11on20602.outbound.protection.outlook.com
 ([2a01:111:f403:2414::602]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNU6a-0006sM-8v
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:43:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWNPL9lmWSGZCP86Py/Cr7CODsFepFPjjk4Syr0DbQ1YWVwmV7iGRt+Wwri3yQnbwPPZhJNOSKwgKiuCS0ccF9+GerHS4ZDX/qLGse767l/+Uo+QSIc7d9yISYkOwDKqHF/Bp0WuJ1JsJJU9yoqNJrH5I3U6zALXyVVKyp62hcj+qHKuFMKHznFuNkOz+bMnxfARFxPQb2z2uhZTe8Vn7OfaAZpxcm2hJACmcb4Fbx43Z2IKi1Con+Bm/tRcnKT//aYkDuOxTTQypCTGp1xS2BDoMmuwSwy6se24FzM+ZR94ZnVBZWw9X06VwAFxvQOBsS8bbIUWqtPz+wiK4Dm/ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXOJfatAiEFc71QvAhkMMT5+rFmMQMxC4G/1Tzd+GuI=;
 b=yzPMWxgHakpoOOsC70bebyufutk55AUaYmXn908rm8NuVdXQCqnHH6Ay7Wk/L4ueLx6HX8T57vXbsljzMfVb4OQI1/eKoWWa1inG4ff/lXPutIWFhWGd+snDQ4PDKMLJBxf0r38wzbq+r7gHHQHiA4eetcdf/jnm+c6w2w74brENTWgLkWM5kozDSGAxHk6wziuutjl/aQ0xWmY8mBSQbgPjrVZLxD5KfKVCmGqewXrIR5WsD+rsX/WEgtyp6jf5YIPd1AgmJ39KAKhT3ei2bAd7GHW+zOg+TBBaFCQ+olBWSP5hxs+QUMiJ7ld/ITM7EeXdvrstNH2klPlFBYxHmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXOJfatAiEFc71QvAhkMMT5+rFmMQMxC4G/1Tzd+GuI=;
 b=UAeMVPxnWxDE48cIwRXKMURZVAVNUnJYr13x15lvfzbWx8o7hQk4SHkN4r5ViwrK3ZQd6NBz9DznTi8kPN9bVhmRoJi9zrjiqiGGijkEhBY4DLYsP06l2EsnEdVpC/fSQ/JHDZoAxsxGOeHHzMq2jvO94Yt/MxgiRdWQi3rPLf/x0y2dalfS8YwUf8RqjwI98rb5aQJXitnMbctx8G0x1y5tbtcR+o8HIpVkUPhFKsW4nACzIPRlu+II2OF1J4nRUTL28CEtQ7ekNoj0aGITCB3JQ2ahoUYTqEonfWjJhaTekY7OOSboQS9N1uU9pYvSjdSFkhaxtJl39ZtCktrV1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 by DS7PR12MB6360.namprd12.prod.outlook.com (2603:10b6:8:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 09:42:59 +0000
Received: from BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d]) by BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 09:42:59 +0000
Message-ID: <40aed741-9e1a-46cb-a1e6-6a579d3288e2@nvidia.com>
Date: Tue, 17 Dec 2024 11:42:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] migration: Drop/unexport migration_is_device() and
 migration_is_active()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <91039070-7a87-43ae-9bc6-adcd9a05e2f4@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <91039070-7a87-43ae-9bc6-adcd9a05e2f4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::9) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:EE_|DS7PR12MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: a08a3627-05a3-461e-1697-08dd1e7f282e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVE5VFdTSzYwMzByZ0NKVkpKbTdtcUltenNRS2NQVXkyNE5kQmc2ZWhKdXA1?=
 =?utf-8?B?c3VQcHdDK3UrSFFwb2hud1gvcE1reGppWnBpZ2ZnYU1Tc0xjM0hBTjFROWpY?=
 =?utf-8?B?bEtPcGNOaTg1YSszWmUzU2Z1a1E0R3lOd1NJM2RWRVA5dHFJRFowajFNS3N6?=
 =?utf-8?B?VGxTL2luanF0VWtYcVh6d3M1cytBclVuTlhUSWFRb0hCSkpHejlFYWN0UXlH?=
 =?utf-8?B?aC9zTzZCVllhcmRCLzd2Nmc2OTgrN3ovUlJTelFGbXdlL2RzRjB4MXA0TldH?=
 =?utf-8?B?VEliV2FiRUd4dXJzQTkyQndhSUtGYVFuSmdkRFlrSGdmQzBlc1gxN3FhYlhq?=
 =?utf-8?B?TjRWT1dlaGhwZnA3MXRSU3ROTEFSZ3ZRUktLUWxaUXFiVGN0NFFhSnV1TTRF?=
 =?utf-8?B?KzlYOXpPWDRLMWlrUVJ2aDdHZ3RuREVOcFJYNUNzampyRjd3QXphajJjSjY3?=
 =?utf-8?B?NWxLdHlqN2IrVzcvd1ZDdkxpSnQ1ZXhBMTFVc2ZJN245a0lpbnVMSTdCclox?=
 =?utf-8?B?L0tOMVlJMDlEMXJSWHZRUjdoVFpoTHFmZ3BXV01qR1N4bVF3Y0pIbU1DUWYv?=
 =?utf-8?B?QllFalNFZ0RrV01aekd3V2lhM2lVcmpsQzNtZTB5U0xoTG5EWWdSSmpLTVZy?=
 =?utf-8?B?UktocnY4YkFWL1dkc1JQZ3FBNW5FSjBjSlBOMU1QSXZKZ1VZWDR6cGRzMWpE?=
 =?utf-8?B?aGYwanVJUkplY2JxdTFSUzVUN0hIU1BZdUN0ejlucUdkQzFwc3NudjJHdTdF?=
 =?utf-8?B?ZVBaYUxKaTNJWEVUcVV3QXFKYkVtS3Z1TmJnaWRsWGZveWtDYXR6ZUs2bDN1?=
 =?utf-8?B?ZUJLUmJ2a2FONUpVT21ldkJxSUdNVGxiNnV5MDhlcm44QnFFRmQ1UnQydGJZ?=
 =?utf-8?B?T3hFTzNnQWttYWo2T2w4dGxDNEp4THJrbkxyeGErd3BPcEhwbUl2V0JDbUNK?=
 =?utf-8?B?K0x6d2I5a0twSlNVc2ZSVkF1TER6T3RSQ1E4THI2bGVjMzhvOWYvMXJVRWNk?=
 =?utf-8?B?b0lLSXBTN2x3VklUWmRWRVFIMFhVUWY1Q09aK3NSWks3Z2dHUXZVTEJ0T3NE?=
 =?utf-8?B?M2JSUzN3OU5pdDNsUHVmR01PQTBvOUdtbTFoYkl4SDNNZ1BETktGclllclJh?=
 =?utf-8?B?V2tGbWE2SEp6UjJuakJuRjd1elJTaWdBWDkzZkJnTElzeG1zVUgwNmd0Qm9G?=
 =?utf-8?B?YUl3RUs0YUI5S1JVRmNHSmR4cFR0ZjdJVDlqZVBUS2xmbkp5VG11OGxmZXZt?=
 =?utf-8?B?aVI2K3JHQnAvcVJKYXNUdDg5Yk1Xc2IzamNPZUpoUE5hVmltaUtkS0Riak44?=
 =?utf-8?B?TmtmQ3pLUlpIeEhXNE9rV1pBV0ZMVFQvckFpZjlFSXNERGVGblVPaGxSMDFn?=
 =?utf-8?B?UUgydTRoVTVUOGxRNGM0RFJQMFd3YjZTMjRiZHNGUFR3ZVE4L3ZTSEhCY1hy?=
 =?utf-8?B?UDMxd2h5bk5qVDFDbU1ndHlnVTNaNzJHcTR5TW5yN25XRy9VY2tKeGJsUWpH?=
 =?utf-8?B?bnh1ZSt0VUM4S3R3bWFBV2UzamRrVkpsU0poRDBBK0tvWVp1ZmM3MWtWL2xS?=
 =?utf-8?B?SEtiejQrZkxpMDVvekh2TDU2RXBRTmt1U3V1b2p4a3hoTjh3Vjc3aXlOSXor?=
 =?utf-8?B?V2x4TU4vOVNuV3lIbGYvaXRvaTRSQUh3aC90M3E0cVZPd3I3K3RESzhIdGNY?=
 =?utf-8?B?MEdYbFVKN2NnQzBmQm5tWTJZTHhJU3VFMXd5SVEyNE8rRUNWOVJoOUhUZUVI?=
 =?utf-8?B?bXNDdTlXSU9QNGIzWjRDS2tCOVJrMDExbm5waytTYTUvcVRvTUJUekttanRM?=
 =?utf-8?B?ZHk3eXAwNEZUeDJaZkUvOEZYN0R4bENIdjlvREtZUDMxem9Jb3NLeHgzbnN5?=
 =?utf-8?Q?cdaUYvbs5zJe0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5544.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTl6NHIweG8wdUJRdVIvWUYvSEdQYWZqaFFqY1FzVm04dnkxQUtRRmlkclVS?=
 =?utf-8?B?WlRrR2VxVTZzZm1OWU9OVUxDdnBKUXhoS08va0RORnRRMmtJbVMxR2dZdDQ4?=
 =?utf-8?B?UXh4aGtzRU94dDNGZ0ZnUmU5eUx2Nk41clA1SjZCdmZuZDA4QWRKdFFxN2Zz?=
 =?utf-8?B?ZHZXbjdsVXpmZWZQRWpWUzZDSy9GMjlTb2JmVkdnNG9kRWkwTTErblJ3aFN6?=
 =?utf-8?B?citURzFEOUdZcE1XSlpXUE1Vc2hqdnluWFZ6RnVrYThFT3JHVi90VXMwd0FR?=
 =?utf-8?B?ekFmSEFUcnhDSVBLYTljbFIwZHZxQUxzZURkSjczbEYycmx4YklFTitCdlZm?=
 =?utf-8?B?Y1pPdkc2a1krU3p6NzNBM09WMUJOdWNCWmZ6bWV4SXV2ZWtnTWlibkR5V2Nw?=
 =?utf-8?B?RXFFb1hORHduMWc0WHlkZjRaTEUyUGwxWUs0RWtxVThGMHhmdTQra2FYTVBD?=
 =?utf-8?B?cTY4V2pPVWRoWDR4YTJqczJDbnJnVkJCbFk4dE1SZDNNSFBQY253NUNkZ0kr?=
 =?utf-8?B?d3JSekEzZ0Z0bHBRMWJNYnNxZU80clgzZnE2alkwT2dkTm0wOUxzQjk0ekpV?=
 =?utf-8?B?YW8wMTljUXE3QnlmZDBQYmo2ZlRXTldVWkJpd1pHY09BWktGSEhkbVFZOEl4?=
 =?utf-8?B?a1ZKQ24zcTVqT2NDUkhtcW55OVhZeTlpTnAzbDVRWEx5Tm5oZjJZMTkrSTNi?=
 =?utf-8?B?OWVMcjluRTY0U2tqNzUzaEZMRHVkeVBYdTZFRWN3QllYNmdzVmo4a2JqbDRm?=
 =?utf-8?B?dGVON2ZFaERwcWdaUjZ5dzlXMFpjRUR1bEw3QXFneGdYbWpCWE1hMTZOUjNn?=
 =?utf-8?B?Si9zWkhuZlkyeWpQMUIyVkFOcmE3Q252WXh1VkxpTEdiZFVNcEdZLzNYNDhG?=
 =?utf-8?B?eDJtYVI4UXV5WFpGM1J3VWJ5cldnOElWakJoVnl5OTJJWCs1anFKSGZTUG81?=
 =?utf-8?B?Wnl4bEZuSFlJQWdOU1l3clEzZXRYc2ZlZ3NEcnFZby9XeDVwdGxkZXNXaE1S?=
 =?utf-8?B?cTMrTDhxT1JWM21PbUZMa3pDM2p4cnA1TWtXVFNkczJiajkvRGI4dTdZZzg5?=
 =?utf-8?B?ZjBHY1VlTENCMGRSZVZQNEgyc1NlMWJBbkRMWnM5bUhGTkd4YWhub0FQNVBi?=
 =?utf-8?B?MDEvR1pEcUZmYTNBZjVzdm1QSE1LZElsL3FHVnI4VVZKNTlTTEpSbUJGZDVa?=
 =?utf-8?B?MjI0dzNSR1hMbHh6TTJzUTJtZzVod2lzbmdTVXZGV3BGS2U4RGZjQUJjbHN0?=
 =?utf-8?B?SGhQT1RjY2VBN1ZQUGFqbE00SmJrT2dVRmtpWFBwY2gvekVRUkRkU0Z2Vnlx?=
 =?utf-8?B?dkc4UHRHUVc4T1YzM1hWcE0vVnN2RUpoS2ROb2RONytPOTFtZVZtRnBmaklZ?=
 =?utf-8?B?MTBzYUNQRDZ5YkJiNE1qbE1PNEYvWU5vLzZlQnlPWkVIQ0dXcno2cmFwWDE4?=
 =?utf-8?B?WWVzaUxTOEc0dEJGTlNDTVJUNlJOdkNubG9mNlBjVmxEeGQrZzlsZ011WHB1?=
 =?utf-8?B?RDlzS2F5b3JSMDI5Mnl4VjB3SXR4TlRnUUFaUEV1c3ltc0JWUXpNanNKVEVh?=
 =?utf-8?B?MTQvWW5HdC9na28xUHVCKytBYzJncDByL3FnMWpueXFQR1lCY2tqMHRldGlX?=
 =?utf-8?B?OE9RRkFVYTM1OGErUURlQWV1N3Yvb0trZHNQaXZPNklvamV4TXU1a3BHMWg1?=
 =?utf-8?B?UG9BN3VnY1RDNlhObUpjdVlLS0VZVjNyLzg2QkZlQk1PNEhYQlR5Q0VzaTIv?=
 =?utf-8?B?SzB0YlR4a3M3WGNub0c1QmlqeGVta2ZDQ1REQ3FWMEJ3N3lnUDNWcWtkUzV6?=
 =?utf-8?B?WkZ2aSsvUnBuV1FJUW45YzJST2R5QjlablhwRDRWQ2paUDN3NjRHU0EvREFZ?=
 =?utf-8?B?eEkvdUxMQVltUW9TTFRSVGhibHhuNG1xNDFnQWpUMzJMTG5oeFZTbldBMDY5?=
 =?utf-8?B?VkpBbjBjdCtuUUJTbHJjUlFIVmpKc2ViVGpLUVNUTTBCbUh2N2F0djRzUTVs?=
 =?utf-8?B?Z0ZwSktWSk5VOUIxL2Z1UHAxaXJ6SWVHWDlYWXljZzZQR0h0eDdTYmExMk1U?=
 =?utf-8?B?WExOOENpZmN1cC93eDY4NFRTRWkxSTZLaTNHbFd4bVl6ZU5YRDFBbEZETXNS?=
 =?utf-8?Q?Zzpot8z+gwVF8PnlOwBYcXs8n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a08a3627-05a3-461e-1697-08dd1e7f282e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 09:42:59.6841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntf1kphH5/d6hNujNX4Z2Vsrj5xcpcyQuoQYDHhj5qygRQkURxKrS4j4T4JvDof4V+f1PlfbmfQwACWz+sSLPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6360
Received-SPF: softfail client-ip=2a01:111:f403:2414::602;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


On 16/12/2024 23:43, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 12/16/24 10:46, Avihai Horon wrote:
>> Hello,
>>
>> This follows up on Peter's series [1] to simplify migration status API
>> to a single migration_is_running() function.
>>
>> Peter's series tried to drop migration_is_device() and
>> migration_is_active(), however VFIO used them to check if dirty page
>> tracking has been started in order to avoid errors in log sync, so they
>> couldn't simply be dropped without some preliminary cleanups.
>>
>> This series handles these preliminary cleanups and eventually drops
>> migration_is_device() and unexports migration_is_active().
>>
>> The series has been migration tested with the following:
>> - VFIO device dirty tracking.
>> - Legacy VFIO iommu dirty tracking.
>> - vIOMMU + Legacy VFIO iommu dirty tracking (migration with vIOMMU is
>>    currently blocked, so I used a patched QEMU to allow it).
>>
>> I didn't test it with iommu DPT as I don't have access to such HW.
>> Cedric, I remember you said that you have such HW, it would be very
>> helpful if you could test it.
>
> Yes. I can.

Thanks.

>
> I am bit busy now and I only looked quickly at the comments. I understand
> from Joao that it shouldn't be too complex to change the VFIO dirty
> tracking engines to use calc-dirty-rate, which I agree would useful.

Sure, will do.

>
> How far are we from that ? 

Not far, I hope I can send v2 later this week.

> We are early in the QEMU cycle and this series
> looks ok, may be needs one respin. Should we merge it first ? I feel this
> would be good to have before the migration cleanups and the next version
> of Maciej's multifd series.
>
Agreed.

Thanks.


