Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEF1C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 07:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgftK-0005dE-2q; Wed, 21 Aug 2024 03:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1sgftI-0005cg-Hu
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 03:36:24 -0400
Received: from mail-mw2nam10on2078.outbound.protection.outlook.com
 ([40.107.94.78] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1sgftD-00052t-1Y
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 03:36:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWS6xKas8SsYGzjCteRBCJNP0E330IR0fJUs+GWUTRTspzNqyEOh4WGOnvzEEEcaoT97j4YeC9Ds7WJliZLrqwf89BOE4nugb39wVbsvDJuW51gfBi3gtJRonropicHiSuVU2ffnogrSq+M8og9z8j5kVpwtSsjMw5JMHcdNhW1tXWnBY54bA2DFGq2XN1n7qcTaHylwb4Cl+fpQ0qiWTIhHLYYtZnGC68F7UymqURVQj5zspJxHXRi4ThMvPjP4O6ZfYBgGjwpp+JG1/w4EMET/Cl8al9f5jSr722MtPzdAqwdjanrTMVCTlkxvUsiqvutK5hLs5YuWyo1p+2ogng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySCGxuJFBGpZNZQH7+wUnKQ48JPw1I0ldxWHd9UHGfg=;
 b=Jk9/1hudZWCBHRtXKMnZUJJzvs1yUElWhtjD88uN2Ue15SOm/yo5xcRlOMcPrvGM9OK6qALG9/onJBnjpIiO3/wLNtsU+ns41gQW0LnptdCMD/j3j9oJI2LCFILlBX+vuf/vpZoS97UVLWT63qgtZqLCigYaTI+fWr+4r2M/3+JNPGB7FriHqKX1QZervsPMZ3SHIT7RlAzY+lEg/X4ARX3kO6BR+8Dw1S+z1CrduKD8qfHVqwvmCKtYv/0NLcmc/BlENlOdg2fPU6jCKpD0pOXhyO43ks1/EErjIwZW81IW6A8vUEi0q4U3eepKTpnUXNTdA5Sai0FAjU0S5NwBTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySCGxuJFBGpZNZQH7+wUnKQ48JPw1I0ldxWHd9UHGfg=;
 b=44B31Ty9Fx/71CiR0hoaUPY7XO0xLv435odz+qfRNu6KX6LQu3utypO+Qv5CR5eCUMDodB97YOb+YUIfX6tyLEj5F42bKdYdL4M3Yi5MGWy0nQE03Mj3somi+CVlzf1BXzXClDIwj3T0jn7DEPFH+dVH0a+4+cnEF4XANNx5LnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by PH7PR12MB7987.namprd12.prod.outlook.com (2603:10b6:510:27c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Wed, 21 Aug
 2024 07:31:10 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%6]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 07:31:10 +0000
Date: Wed, 21 Aug 2024 09:30:57 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Doug Brown <doug@schmorgal.com>
Cc: Vikram Garhwal <vikram.garhwal@amd.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/5] hw/net/can/xlnx-versal-canfd: Fix interrupt level
Message-ID: <ZsWXsQomR9mELllB@xse-figlesia-l2.amd.com>
References: <20240816163504.789393-1-doug@schmorgal.com>
 <20240816163504.789393-2-doug@schmorgal.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240816163504.789393-2-doug@schmorgal.com>
X-ClientProxiedBy: FR3P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::18) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|PH7PR12MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: a0de96be-f4b1-434d-7445-08dcc1b33a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFVZc2xTMnJQaFdCazk3eXkxeFJCcElqYXpoYzJmR2dXSFBibGhJMGIyanQ4?=
 =?utf-8?B?T2lya0xCSk1GQmx2WWVKUmNiT01FRjdBZXJFR2tGM1dsYXg1cGlFNFhJRnFw?=
 =?utf-8?B?bTcxSndzNVYwT1VzM055NktpSWZzaUo4QWlOVmZZOW5yUDRpcGRkZzZUaVhD?=
 =?utf-8?B?RFZ5ZHdXeVlFYWZvYW85ck4wUGw0a2hyQVIwbXg2cVptRUxkRzhkSjZHYlkx?=
 =?utf-8?B?WTQyT0RiSVUvUENveUpjbHhCR3B1cy8yakVGdlMzYzBWVmxZRjBVYWlSQUdD?=
 =?utf-8?B?Z2QzcUp1YjF2YkkvZVdOKzNKSUFBSDBZMVZmdmJDVGxYL3pQZ2hON3RBVFNI?=
 =?utf-8?B?M0ozUEJNbldtUFNweUVBZW9oamNnVWV5TDhkMzJWdGt1M1B1RWJ1ZEdFc1Rm?=
 =?utf-8?B?ZFRGUDVvbm9keGV4SjhvL1pTdTEwanBVVlZvdC90b014cEFybWJ1YzdZZGV1?=
 =?utf-8?B?SlFuS3lZTWdkQVIzWDl1YzNkN2UyOXpGY3R0eDJXekpXd2xiVHNJLzZoUk1W?=
 =?utf-8?B?TjkrQXEvdWJ1MGpscmVOUFE1Tk1DeS96Vm9IazNjcXo2Y1U3Y2VqVzJMbkh3?=
 =?utf-8?B?Z3FXVDQzK3ovbGozdktMK3QxeDhWa3hwRlhvRGFleW5kV0R1OFhBS0tXZElM?=
 =?utf-8?B?dnEwWS9kWThWaDMvVUtlVTBxUHlYT1VuOWs5UVQvZy9MNk9Mb2RqQmpJU21L?=
 =?utf-8?B?YnVFc1ppQWhOZ01NL3o3U1lVci9HcEFXdVZvUlgzOXI3M3FUK0NQRGtkUkMw?=
 =?utf-8?B?OThKQzRWRWxIQ0xQNjlZcHloVHBkaHYxZHlDNm9pdVc1NWZ3eURUUDdJaXhs?=
 =?utf-8?B?SXNQNkdwNFEzVVVCSXFFay81NlJXdGFzZ3FDQXpVckZoRHFLQnlEdi9rMEVi?=
 =?utf-8?B?TTFGTUp0TDd1aU1OVDhPckVVS2x6bmkwVjE0Nm5rVGVaSUs0TFh3bXdUcmdn?=
 =?utf-8?B?SDVoMXA1ODRVMXVaVmdmdGVjVEhxSG9rc0NEalVUc2poL3dJVmdYbDhUVDZD?=
 =?utf-8?B?dnhwQ01LSEx3dkp2MmN3clRpL1ZoWkVPa1NLdHBtUWpzcUlWcjRvTFcvcEhK?=
 =?utf-8?B?cXhEZmVOUDJWTGpMWFdJOUwvcGYrYkN2Tm5UcHNtLzFYbU1zRmg2cUpsVFFU?=
 =?utf-8?B?czAyVXhaRHN4bGNiRGFXbVNEeFBwOCtoeXAwc0F6cVB1V3lCYksyTVNQSWZB?=
 =?utf-8?B?MnRQbXNscEEyWmRGRitFeURMdGUwa2JXdHAwRmdrOWFxMU1QNjNpL3ZqRzhi?=
 =?utf-8?B?MlZSV3ZIZDQxMGRXdmZtc0lFQlgrUzBiaDRvSTVaMzV0N2NWcW9VTVlzdUJq?=
 =?utf-8?B?RDdwa3FVTG5zTnpFVm02SzZjdzY0b1BVejRRWC9MeHEvUTU0THVVdk01NEJ0?=
 =?utf-8?B?YzJGZjZZQ0ZaQm9kTkVld2E2M0dBY3RZdmdaT3BEd1AvbUQ4cExtanhPanlw?=
 =?utf-8?B?WENNc09NRWt3UStkZEZPeGttZkF4YWM5Zk55b3p2bDhRZnBjWTNSYVFiaWlL?=
 =?utf-8?B?SVZBTGdDTWxRM29EVVVpWFlNSnVTMlBQRG9LY3h2MXFuTFFpdy8wMXpZNklr?=
 =?utf-8?B?TUZsYTlLQ2V2TjlSQlBHWFREMHRuT3lTazhrN1JVdEVqNkZiVzVMS0hrQnA0?=
 =?utf-8?B?Z2ZQRTFLVmtObTVmQ205SklOL1dFQlNBQ3BIVm9vOVdhRWpjcDZrbnh1bkpV?=
 =?utf-8?B?Yk9UQjFyUm5ERFRVeDNiSWg0TXl5dUZYVGQ5MTlDUFhLY3VCMTV0Q09tdG1G?=
 =?utf-8?B?b1NYV0F2MStuMDRqbHlnRExtRmZuaFZiSjU0YnFLb0syV1IxRS9qdEE5T3ZM?=
 =?utf-8?B?WWxWVU5vN203Rm83Y0k0dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVZuczlaTy9IeERlL3VZTDlnUXN4RG5ZTGdoMDJkdVBXQnJ6Z3JXbTBZQ2ln?=
 =?utf-8?B?MXNrck1jRGxtbHI3QkZ3Y25NTVJ0a3dUaEF5WnJXZjl5Q2F4RnQ3Q1VhWERL?=
 =?utf-8?B?elowdXBweGgxN1IvQjFDSnhPUEpENmhLaTRTUmpQVnVaYlBTRVRuajNLOEh0?=
 =?utf-8?B?VUNuY2d4TEQvd2oyOFdmTjJCaDRhSXR3a1U2MGZzMnFvM042U2JFWnBOaEVP?=
 =?utf-8?B?Snd1V1dEdzd6SDMyNm1PT0dUcXVyOHdNTm5vRjZkd3EvTUJIYkZseUNlNEE5?=
 =?utf-8?B?Z2d4bFlBcnA1UWJkZy9wM2JJek5jeGdOaTJHdlMyOCtNS1FhNStDMGVwMVBP?=
 =?utf-8?B?V2hFa0F3MndpcWRiRG53aFNVNVlZczhpcXB5N3dIMXl2dFJIMWRxTVZlMkpC?=
 =?utf-8?B?WmxwOWl3U1YxYTJEMlkwS0I4N3VyUmx1OGVMWlk1NFYwM2dOcDh0OGFueW5P?=
 =?utf-8?B?dThxMTNZTWNvRHJzalRmWlpQTWo5WkdoeTY5TVA5SFhWZDZ0YVhWQjNxQ2Y0?=
 =?utf-8?B?SE9KR2lkVXBTVks0MmRIeXgxM2ViMVlBOU9lZWVhdFY1azRFMVRVckpmRmhY?=
 =?utf-8?B?NkRsUzByYlpVMmtWZkZLWEJ6RS9jYWt2OUhjVS85ZklmMFBOZU1sVmx6Tnhk?=
 =?utf-8?B?ZGJkbG9hZml4THFXR2dNc0I1ZWN2WjcxdCtBUlA4QWNyNi9hUUZQVFo3TXRB?=
 =?utf-8?B?NnB6ZnA0NTdPWHdZVVNZeGlxa2NEQzFpa0xRTDBYQlhOSmRkbGs1dnpJOGhl?=
 =?utf-8?B?K3c4YWlEenJPOWUrVlUxOWt0Si8rVmdtS1l0MmhXZkdvUzNTelcvd3VXUkVO?=
 =?utf-8?B?aStESmZGYm9POTMyeHZlM3VLSmpVZ1NBVW5mS2UwbDRlRzdENjlsR1FoeGZv?=
 =?utf-8?B?VUlnMXdxVW1FVVZOYnRaOXlVanZmOG9HVGcyR09ZK3JGWTNxSmgwRGtnZEJy?=
 =?utf-8?B?RGl6ODgvK0l1K29YYndBUFFvUUR5NVk3WlZxa1lFWU9Ld3ViOEYxZVJ5K3A0?=
 =?utf-8?B?K1ZPazQvdC9FYVd4TEI5NEVjZ3p5ejd2cE51ZlRNcEo2aFVZTmFvUmsxdDZC?=
 =?utf-8?B?eU1SMUU4R1FLZ29ibkZkcjRJamxxY2kyd0tIbVc1cncreUxCV3NHcTJBMU9y?=
 =?utf-8?B?YU1WSzRVTGdEbEZBK1BNaUxkalBmTmVRR2FibXNNY3cxRlNFMkU0Q0M0YVAw?=
 =?utf-8?B?SDJTOVFZYnZRNEs0OU9ETnNIQVM2V2xsTGg5K0RlZ1JsYmVNNUlLdkpLVU8r?=
 =?utf-8?B?TVNRcGwra0owdjFFZEJnbU5iOTBDTEdIcXgvcE9FcitGN2hBS2R6YTd5NHlO?=
 =?utf-8?B?Sk1CYkFsaStib0luV3REZENZRkpsbWJPQ3NKUmJVTnNEMU9TMElFMmtzdzdl?=
 =?utf-8?B?L0NvZ3pDWlRhUmZ0WnBkdkpUenRKbERHenRUTm52Uy8wd3cxTnRIT2pINVc4?=
 =?utf-8?B?Zm5JY2V4b09mWktRSk1Sckx1U3Z1RnZBZHd2d3hhZFlmLzV3VVlhRk5Wa0RU?=
 =?utf-8?B?R3J2eWs4eUhnQVBhbDhHVXZIKzkybjZabkRHOGJnMldlZjF4cHE5ZmsvSGlj?=
 =?utf-8?B?emFXL21tbldkZEs5dWplQ3JWOEtLYVpBQm5ZMW9mMHhBbkRkMGp4cVBTSVhv?=
 =?utf-8?B?c2IyeHdyUUcrWEk4STRsWmxqSkdyYnFONU43S0FWTW1EeGdTNjAzVUttSStW?=
 =?utf-8?B?aEFOdlJYL3N1Nnh4UWpBZHIwVmVXWDdKKzNOazVBNHRobEVjSkxFaW5OS1RN?=
 =?utf-8?B?MTZvV1UrTFI0RjBmL3dOb0hDMHJlaEpyL2ZxQVl3TG94TnNtSTlSekI4VElp?=
 =?utf-8?B?RThGeUVwSnlDM2ZHVWxiQ09zRHZWQkJtWVBUNldkNWZBU2ZQMVRwb0dkUEN0?=
 =?utf-8?B?MmJwUUFkQjNjdjJ3S3pMQzVXc2tBUW1FS1p0NWlhcDFoejVacG9penowdnlK?=
 =?utf-8?B?MjFjdHI0c1RCcUZhS3h5aWJMc0syaW5xcXduczdRZGh6Njd1bnc4YW80dDkx?=
 =?utf-8?B?M0JlRmRvOUxBVENXQjBGclpvTzExRVJ0M1phdWw3eng3WVNrRHlRd2ZOQ1lT?=
 =?utf-8?B?STVjZ2pBaEdzeCtBQVFURlZGLzZwUkZjYnF4Rlp2WkdUTHVhKzlrVjFvQnA3?=
 =?utf-8?Q?QLeRlfbdSX54oSU5XrrhKYkFX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0de96be-f4b1-434d-7445-08dcc1b33a44
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 07:31:10.3335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hizky0lKNP0sj5VY3l63GYq0g6nvxPo3KDZSEmwTLCkx69gArQxRSdXvwoqd6ZXiF71t4E+qpzajpRiNJdDcog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7987
Received-SPF: permerror client-ip=40.107.94.78;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Fri, Aug 16, 2024 at 09:35:01AM -0700, Doug Brown wrote:
> The interrupt level should be 0 or 1. The existing code was using the
> interrupt flags to determine the level. In the only machine currently
> supported (xlnx-versal-virt), the GICv3 was masking off all bits except
> bit 0 when applying it, resulting in the IRQ never being delivered.
> 
> Signed-off-by: Doug Brown <doug@schmorgal.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  hw/net/can/xlnx-versal-canfd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
> index 5f083c21e9..ad0c4da3c8 100644
> --- a/hw/net/can/xlnx-versal-canfd.c
> +++ b/hw/net/can/xlnx-versal-canfd.c
> @@ -682,8 +682,8 @@ static uint8_t canfd_dlc_array[8] = {8, 12, 16, 20, 24, 32, 48, 64};
>  
>  static void canfd_update_irq(XlnxVersalCANFDState *s)
>  {
> -    unsigned int irq = s->regs[R_INTERRUPT_STATUS_REGISTER] &
> -                        s->regs[R_INTERRUPT_ENABLE_REGISTER];
> +    const bool irq = (s->regs[R_INTERRUPT_STATUS_REGISTER] &
> +                      s->regs[R_INTERRUPT_ENABLE_REGISTER]) != 0;
>      g_autofree char *path = object_get_canonical_path(OBJECT(s));
>  
>      /* RX watermark interrupts. */
> -- 
> 2.34.1
> 

