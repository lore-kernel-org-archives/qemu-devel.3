Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A74E9380E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 04:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC8wJ-000115-0O; Mon, 13 Apr 2026 00:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wC8wD-00010d-0W; Mon, 13 Apr 2026 00:30:17 -0400
Received: from mail-japanwestazolkn190120001.outbound.protection.outlook.com
 ([2a01:111:f403:d406::1] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wC8w9-00006E-TZ; Mon, 13 Apr 2026 00:30:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2z86tlyKB7/NvZsC7zfhLmEfWcwPg+8hS0HbJswzCRk37g9F0INyJ7nO5TmeHOWObKXZg0r7NhMd3h8EspS6w3cheiTnDF2yCkejgTmaQgtRpWlZKcdaLZWRvMva+HIm7sbcQN8cbnrxz3YHiHXNNKDzuQ7r1045q7B+hWLK+0bTjqQ+xWY2KhDMwfaJoVFxcdjqQvJHhidv8y1UZSeE1R1AnlULX1TvXWLKzhw8wmr0hTKz9JEOOjis4We+GtKzA7Rp3OUoveuIfuVNIahZEIPHX67dCq4GbAhJi0GBF18P+3g3wFrCjoovxC/NhbYl+gjS1ut1utpAEdAETKaAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igyJGKVx7a88FzH+UKKMmxdHHL1lTusyUJbbBgAMmpE=;
 b=TSJ28U98ZsdS6hy9HMiVfjMgVpRqJ3QOQaC3qcBGKo1vBpZc35+scTSKCEnhktvhfreKjaAjuI5ds8/qc+dDAFDnke0Dso4uOb4L+a8HhmebvLn1F+6AgpxbAt9BAS3/p+jpAgIExwjRR62pnWilQLre/z1dvFIRvW7+Sp7GnDqU/3rZDcpAmdXV5SDCMXK2cFjEn+GWChRByWTBE3GvTC374AvDtjEn8GUK2eOH7v4/B62vz+6K2d1UmteDDog7VRypzoqNLpACFsi5jX0fUUMUs2cCwaCsWr/gNRmCW4dexp/KSktdQ6u8af07yH8tcfYWXCH+YlXhtnAH7e6MlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igyJGKVx7a88FzH+UKKMmxdHHL1lTusyUJbbBgAMmpE=;
 b=E7LTmXdfYR1o6vNpesfn/qDRszcgp6jTCXXLBCgE8SZ9sp6S7Y7xVmEDRR+4J8ptVZGzqoXb+iEZhpco+HZ/WOZ2xPI+L+hKPTGWGqtUeltApcpKbe4O1JPyvrvgN4F4WyFjDwc5RPmmOc8o96u3QXIIOyMi9/Gdu/dLiHqrJhD10g3Tekeja9DKMckU0UCbOXrfZU5YhtDTxUK88+qFwqzDb4xm+kI17FCglVyF4OQvwdzzvTrUcVJ1ax5BiuvC5b7Ti4BCidgVtg6iCCf1uahkdBU9jvLNxN+7T29uQsk0E+wwFeN2ORDlV5OQhYi6cBgzDn+p82UlovvR7np/oQ==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by TY2PPF9075091F2.apcprd04.prod.outlook.com (2603:1096:408::ae1)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.42; Mon, 13 Apr
 2026 04:30:06 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 04:30:06 +0000
Message-ID: <SE3PR04MB89226D76EFAF7EB799A7F108F3242@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Mon, 13 Apr 2026 12:29:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] target/riscv: Add basic definitions and CSRs for
 SMMPT
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu.zevorn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com, daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com,
 Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
 <20260408140635.42546-2-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260408140635.42546-2-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0361.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::17) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <912317eb-6445-416b-98d4-41566ef17d76@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|TY2PPF9075091F2:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d1622c4-a429-4c21-5dea-08de9915562a
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|51005399006|8060799015|19110799012|23021999003|15080799012|461199028|6090799003|5072599009|40105399003|3412199025|440099028|26121999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0E1NTl2cXZCNWNBdVJOMEFOUTJKNHVNNGpDcWdwU3BUY1gyU1gwbEwrTWN0?=
 =?utf-8?B?dDJVQWZmY2x6MWtCZ1d1czMwcnlhbnNsNDNUY0U1Z3NreENnR3pkcEdlcHdp?=
 =?utf-8?B?aUREZHJLV0lxYlpJU0EraFE3dVA0dGFzeXI4amlNeFFOMHVDdXBqN2RvT1VW?=
 =?utf-8?B?NjBGRG0wTTlNVS84dk1EQWZ3YkNFZ0paSFhqanp1NXZRUVhjQTh5SG5kZFBk?=
 =?utf-8?B?R1ZQVnlMcloxTWdPOEpESU93WHhaVm9VRE5KNEY3QnJBQVRpcFdNWnpOWDY3?=
 =?utf-8?B?MEtuNXBWZVpNK2pOdTZlenpOSDBicHVWZ25hU3BhVnRIVUE2elRmV1JRdDE4?=
 =?utf-8?B?MGg2Rlo5MFlaTmtlbWFyZzhMbE82SisvVTRsajJndzdxRlJzUlpIMllEeG9K?=
 =?utf-8?B?d292OWlIbXdNcE1qTW9uNTN2MSt2V1hVeEV5Q0xRTjN0QXpqNnRRN0pLK0J6?=
 =?utf-8?B?OUxTd0NPYTM4Qmcydnc3MEQ3SFhDMnh0UlZkQ3JJTTZNTnpTZVFHRksvb3lX?=
 =?utf-8?B?U2dVd3BNZG9MRlFZbDIvVk1tb0k3eDNyVDN3Rmp6dTFrdmlTZ2tSV2JCVWo3?=
 =?utf-8?B?dG9ZRmRsL0IwWk5QMmg5Y2llNXgxSm85dW5waUdvZXNZc0tVVmk0RHQraHRn?=
 =?utf-8?B?dFdHUnBBSlJvTVFmc0ZLTTNsUEdvN2RraG9qNk5ITHVSZ2lFUmNZZEJDYnpz?=
 =?utf-8?B?cVhtakR3cTlNQzdxUndONUVtMDRDRnlxUUkrd3FCcHk3UXh5NWZ1cmdwY1Rz?=
 =?utf-8?B?b1NEUWhQdTlnaDZXMDU2d3BYbllCcUZFQlFPWk1mQy96cHZsMklOTjdLUmhY?=
 =?utf-8?B?cDlyNW82Y0ZTQmoxbVM0TERSMExqeDZpOExVcTRPYWg0M2NSVmhKT1RCT1NR?=
 =?utf-8?B?blo5cHp2MlBrRm5KNjM0TEZyS0lHZmJnM1FiN2RGWkF0b1ZvRng3MHVzM01O?=
 =?utf-8?B?R1ZWdDJnckhVWVF1ZkMxNk02ZUtRWC9JZi9NbHp1bTFzM25XaEtwQTN2ZDhT?=
 =?utf-8?B?U1VyTWJ4Sm12WWJnQjhkR0EyQWVBSCsyUCtrN3gySk11dmM0V1p0YWtPT1VS?=
 =?utf-8?B?L3kxYkNiYkpmaFk2RDhpS1d2SkRPLzJIQno1U0VjbXZROGpUNDQxejNjK3RI?=
 =?utf-8?B?Sld1NTJLTThmbmZBL3hhU1d1dkg0RWxaQ2FmcEVSYzk3Q0k2c3U0bXNoWFZN?=
 =?utf-8?B?T2Rxd0d1Nmk0Qm9VMFdUck45STd0a09WVm1YWjZwSVBZK3BoZXh2TVRQVTUz?=
 =?utf-8?B?RVFrTTJwaVYrTUhLUTBWU25HbDVhZWM3V2Y3bGZiY29BU1NIdz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nlh4UjhjblRyaHFsdTZqWTZQd2Q0MFdxMmJuUjdFTE1oYStQODM4eTc3Ullr?=
 =?utf-8?B?OFVXZ2E5ajBLQjBQdEtKbHlkY0hFZXZoc0Fhb0JJMGxMVVBNWStKUDVoQzlH?=
 =?utf-8?B?d0JkajhpK3RCQXF1M21oMElSN2dXYU80ZVVTSjVOY1Fxakx4L1liaHlFWjlY?=
 =?utf-8?B?TlQxOU1FZkFiamxmZHprM2wyUFl0WE80SEx0RmN5RzBLZ1BMOG9IeUZQUzlv?=
 =?utf-8?B?R1ZNY2tHM0FNbjlMRmFzWXB5VktrNFBwQUZDYkZsNGdCMkRCb0tvZlMwdGZC?=
 =?utf-8?B?NFZvTERxMDEyZTA3ZURuWTMrVDNobE5KcHphOVVBcUlKQUt6Uml1alRTSXJx?=
 =?utf-8?B?ZDM1SVBpSWJaVS96R3VWMWNSY2FDaDBNQnFMVm41Q2FRQVI0R2hyajRNNU04?=
 =?utf-8?B?K0I0TGJ2N0p1YXdCL1JieTFwcnpEcEc2SllSZlNyYUd0bWpzY1ljUSt3U0w5?=
 =?utf-8?B?eENNSkM0Z3loOHEwQTRJQ3g0NnE4T2JIV1l5UzhkajZvd3ZWckJVV1FUaVVi?=
 =?utf-8?B?QW9HN0x2VERNVXVudllGTUhySE5ubEhReURYemQybkdpOXhDcXdyUVZXUHdI?=
 =?utf-8?B?WGZmVVFYcmlETnlSN1NybGdqck5MS2UwMWxyU282ZTlMdm95MVFTSzJEbTNB?=
 =?utf-8?B?Rzh4ZnZWS2x1OHZINE05RWw2bno5cGliN2xrektBRHZtaU5mM0s0eUFKVVVL?=
 =?utf-8?B?L2lzYXFDNmJ3ZkcwWVhqTVJUNUxSOUwyV2FFTDVhRVVvMXdjWkZ4cms0YS91?=
 =?utf-8?B?OHRMVExOQWhOUXdKM0M0TlBjVUExZmZzVVl6bG43VU9xa3J3UzNiTWdQT1cy?=
 =?utf-8?B?TUtuZkxZakNPNUt1cnlMUjFVNm9FZ3BtN1FNTjhXLzhvOEx1bVE4T0ZIVGNh?=
 =?utf-8?B?NkZ2Q3ZLMDQ0MEVpQWlmek44VDB6Zm9xTnk4d2lwU3dzeUh6WWJVYVk1NXZm?=
 =?utf-8?B?MlFPNWVmaUhHc0VQYnI0SzVObWxwbTg1QW13ZzF6L0lNODZ0ZmJrNE5LZnpo?=
 =?utf-8?B?NkQrWCtwZjdSc2lCZnV3VnlVOERjK3VmMFNJd01TRDdDek9mUGFhTFlYdVEx?=
 =?utf-8?B?aVVIOWdyYVArN0FqdWRnUHNiTDRGWGRjVXFad0pxL0FZZElEWldzcEplTDZC?=
 =?utf-8?B?UkFZeXA5MVoyMzNRdU9sU2pocXRJVUk5ZDdiOEU0bjMvZVVqSkVjUnFPOTdj?=
 =?utf-8?B?dXZCeTFNRy90NFZ0SW53MW1aMmpFQVJiUG54WEpNNFM5WnhMU2M4Y3dSa0pG?=
 =?utf-8?B?RzhseWp2cXFOYmpnT2FKUjB6clIvSXBuN0ppc0UvU08yVUV4VVgzaUJ2SnZV?=
 =?utf-8?B?VzZCTmtUYXVHUFNPaDNEOU92MkR3RUxhdW1zN3NWK1JYb0w5eTRlV1FpTjE4?=
 =?utf-8?B?MzY1YkY0Nk50d1M3a0JZVVJPWHQ1T1U3NnBnZkthQ1B4MHg0cUY4M1VuT1Nk?=
 =?utf-8?B?K0J4SnVKMXk5YVRlbDBGQmJRQWpydTl1VytibDk0L2dndHlJYmlWaFhjZy8w?=
 =?utf-8?B?NjBENXVVdC96aDZrSDdTS04rcEFXU3FFb0c1ZE1YY0RpT24wTUFmMEdMWnd3?=
 =?utf-8?B?Z2hRaEpZaUNCTVNEVlB5TU5QWnc2MlBWQlRyaTMzN0FiTm13QlJKS1JtSThk?=
 =?utf-8?B?dm93ZnRxS1Y3TVR2aG9GVEtCMENFRTR3aFFQUENQZlBobDFSWE1jYzJINUhC?=
 =?utf-8?B?WXdvNEYrUDJvN1VkbW5UQW9ETjRkdnNldkpwd2tjTWRFY0tGMXovaW5yZU9W?=
 =?utf-8?B?VmhVTXVZSkVEZGloMktMcmV1VDhZblJrdy9mYUtWa0s0Y3RZUlFZdnB3dm42?=
 =?utf-8?B?NVpzeDVnWWZGMFZ1REVNdmZwMkd4UDJjeGRHbkxmL0RmbUZXSGdDNUpDczVY?=
 =?utf-8?Q?MHLHaJtg8Ce4q?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1622c4-a429-4c21-5dea-08de9915562a
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 04:30:05.8665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF9075091F2
Received-SPF: pass client-ip=2a01:111:f403:d406::1;
 envelope-from=nutty.liu@hotmail.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 4/8/2026 10:06 PM, LIU Zhiwei wrote:
> This patch lays the groundwork for the SMMPT (Supervisor Domains Access
> Protection) extension by introducing its fundamental components.
>
> It adds:
> - New CPU configuration flags, `ext_smmpt` and `ext_smsdid`, to enable
>    the extension.
> - Bit-field definitions for the `mmpt` CSR in `cpu_bits.h`.
> - The `mmpt` and `msdcfg` CSR numbers and their read/write handlers in
>    `csr.c`.
> - New fields in `CPUArchState` to store the state of these new CSRs.
> - A new translation failure reason `TRANSLATE_MPT_FAIL`.
>
> This provides the necessary infrastructure for the core MPT logic and
> MMU integration that will follow.
>
> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/cpu.h                |  9 ++-
>   target/riscv/cpu_bits.h           | 27 +++++++++
>   target/riscv/cpu_cfg_fields.h.inc |  2 +
>   target/riscv/csr.c                | 95 +++++++++++++++++++++++++++++++
>   target/riscv/riscv_smmpt.h        | 21 +++++++
>   5 files changed, 153 insertions(+), 1 deletion(-)
>   create mode 100644 target/riscv/riscv_smmpt.h
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty

