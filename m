Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC89C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 03:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyLCe-0006Ep-M5; Sun, 23 Aug 2026 23:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wyLCd-0006EQ-DW; Sun, 23 Aug 2026 23:18:27 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wyLCa-0007ds-MY; Sun, 23 Aug 2026 23:18:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDpsvTLQK2kaDsz9I9XNZfCyFyvyoWgK4iLhvn8f2jgrteRO+hOmEBb1dWg1GIY1jKF+VFpie45QN+wuDRV+RCfOh/sikh0ZbWSpGt8SV7T/t/1EsHFELLuVcMVMLb2Gh/9VUz9JOB+eBAxppk+eC7ajeogl3JPLPmDYNWtXXDlfSWF2X3E23bWRdahKgryPBw5nufUQSxa3GG2XvCJebaegqNFN7AuJsxFl3jrdBFhJgTelsBgQTPw02/lhhu65Lio/6pTEDPlVmdgsdAfVKlUUGiOgTyeJq764N5MwqC1ZHz/ufCjyDfqYfeqNTXMDNVDjrJur1TQwM1mHpd5nGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmPD7Ge1Nbi0Oqii1TiVr+WPqKjW0/kUmFvAuoDhWIU=;
 b=YEAM7nYTylsaN+O8LiCuWbkG1JW3Ji468JkM6zaLYiENIbTy9u+iz3M1CU558COPIRsTJDbDPxvR0QT+UTjabdMU/DiANCRXGuqgGfHCmQx1b3DMxTLcFp26/HSKZ6yNkcLUwxQBG9tiBDPlnZgRlO7Fw1O0gcdR7Cx9DSMInUVOnst6gOd4/P2VmjR/pCHD2r2OWRB4x7GgBRgeJNZjuviM4sxZr0FpksiSGxzB6aBT0YUFP5aVyHox1F7388/c9PeAv+xNrLak+ECoSq+Q0xoVQL8zogKgybgS6hlUrAcQy+/oYh0ro0IH6eEvuwLwvMdlykP9Cvxeq3BhNXmTiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmPD7Ge1Nbi0Oqii1TiVr+WPqKjW0/kUmFvAuoDhWIU=;
 b=O0yWkoxV+aBLBUfhQX/wWAb5NUf4wyAmLhM2PgDuCGbNThF4dT/li99Na7Xxl0dqnaxaEVWflbd4CWK9zPJ9ykgn6qv0D6xLPBPSmzSJOVd8sgBk9Z4jdAJRaGZjnVAmQhtfy887iFXGFRseTWNCS879hmhRD8AvyE5Bjelz/Jqayb4QduJtlM/cjHfpUslbel7y6ikgMxgKdBif2UfqZ39nNNzy0gVONr19V+FEw7YvoC2dJmY2FZ4FqnJIOQWbQkigXHipyiMh922AMYY54iLxzD7EHJhB9CRAMtoLMa+8MCAnbZXToL0jQiUrApfIFqScdV4SBdAmiJ6+fqG1qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SI4PR02MB9628.apcprd02.prod.outlook.com (2603:1096:4:2ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 03:18:15 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 03:18:15 +0000
Date: Mon, 24 Aug 2026 11:18:10 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH 0/5] target/riscv: support Debug 0.13 and 1.0
Message-ID: <aou3G0of6_RUCGrP@ChaodeMacBook-Pro.local>
References: <20260805182506.2943757-1-daniel.barboza@oss.qualcomm.com>
 <748104a9-5917-46f9-aa99-bf86ef66e9c2@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <748104a9-5917-46f9-aa99-bf86ef66e9c2@oss.qualcomm.com>
X-ClientProxiedBy: SJ2PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:a03:505::7) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SI4PR02MB9628:EE_
X-MS-Office365-Filtering-Correlation-Id: ce23b2dc-1114-4d47-e5f3-08df018e5635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jMFI0SoAzIXGr9qjyhc7cTDpZSWJvuVelHQ3U3pSAMaBZjHv5a4PmOMJdYgdfuMMLBH2VXDz0hbi4jJLJkbXrJB8QLCl0GyjMHkAfplF90L9sJZygfx/KJwxUUQbnVihnoPA+vbk8T8AxVCIFM3Bv8W1Rn78jqZneN12QIG//5GibITY8wliQ+557gyipzcR6z4eQI09TQ4kFCeCYLzzsF8LZaknSiDEaKjv2MroV/z5oS4atNY8H5ryPHFzUiA0xiicYgto1+PD+m6qA5JHDr+c8ntB/bkExM779jZpN/H/ZWQmCoT5h2gu6tsNv7Icqp0DnPq7AoqydXP/UXaZathOW6yrUdHoLU61bIz+QbbKdzBCiRUxBLJgsZ/cwmRcHjFwb2gFlr28eX0y3/hiyXlxbtWIqmfLFmnNReCN0UooRESKR7P+9J3WO24iX1YDphbBkGyclY8xgnxY86z9ujsJU5OIDkFTqkTVGtDoAy8KP7MCNlWpEB+1ZcfJ2NSzB5NuHd835sNogdobDr4sOBGfTF7JKpbNHcK3CRWeZ08a1Z1pn/yM+eEP3LzuagpHzPOkmRdkVr1ZBD1FrCX1Kevd+HM4keu6CheU6QIc8mI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzhZUCtNcDNRRk5uWjNnRUV0UEdrcVdPdWx5MWYrMnAxMjNVcjcvTjZ2WEJO?=
 =?utf-8?B?WURVSmpIOUpLQ0xWU1NuRU9CMklKYmVBc29CZEpCaE52VTVtQ1U4VVJLdnhr?=
 =?utf-8?B?a1NBemQzUWVSN3hRalQ4cldNRkV2eW5WTDB1NXNycHpLdlRZY2xycW9GS3hM?=
 =?utf-8?B?cThDeXpYMHhxVnhKMXAwVUhzdFY1RUd4d2tpUmRIUkFqYWYzTlM5WEZHM0Ru?=
 =?utf-8?B?RTY0UFBuNzZGMCtHTFlqaFAzS0xoRmVPeTRPRTVHMmtUTXRxV2k0Zk5KeEEv?=
 =?utf-8?B?YVM3YWEvVmRpVjlKcjF5SVh0U001TGptYmtpbGM3WU5OSk9xakVPYzF6V3JZ?=
 =?utf-8?B?VmhNSE9Bc2ZVenJUS2F3bml2VU1MVWRQRFBmZTVVcXZzbFZyeXBaaS9QVEI5?=
 =?utf-8?B?eFB5WWNhVWNoM01vQ2J3bTdFblpkenRjNlQrNFIzV09md1ZKQitFTGdzQVhX?=
 =?utf-8?B?aVN2SlNvbVpDbVdVRzhsa2JkMVJIWUIwZkJOSnQ3MnVod3NFamx4V2lBNEdC?=
 =?utf-8?B?akl1aTN0dlFkNzg2alFlbkdvMTFIN09Gc1Y2TVZHMENMajNudGJhLzJTWnFI?=
 =?utf-8?B?ZDJydWwvUjdZbXNvajZPTmFoVTVONXpMR2t0NTVxazNQbHZxcEhqMnQxeWVp?=
 =?utf-8?B?cWt0aW5CLzJXMjJJWDU1RW1LOVNlVms5ZUF5SFY0U2pReng2ZHlFY2NOdnRU?=
 =?utf-8?B?Q242MGpRcGtxVWRDWjVtcXc1YTlISUl4a09ydlNCUFNvOFR0MkpHUFpjOFhI?=
 =?utf-8?B?TkNRSlFpZWJZMXBxMnh0blpINzBFSElnWkpZZFdnalcvemlxQWZWRjAyWFRU?=
 =?utf-8?B?VCtkeU5qUGVKcDZEYnFVcXNkblc5Q1g3dWxJS2NLcTVEVkk4MHExcWlRaldD?=
 =?utf-8?B?Y2tET1duc2V3c0xOdjByLzgrSmcySE1BVURsYWllSmpvRWNEMkxXK1lwU0k1?=
 =?utf-8?B?bGFRMFBIdmoxWkhtYVM0UGFqOWdZaVUwTlVlS3ZPMzVUelQxcmtFeFpuTGRO?=
 =?utf-8?B?NjBsaUZtK2FvWTdEWFg1SnRJby9GNXRUZlV3M1dVbmFlcjF4akdOVGVTZ05l?=
 =?utf-8?B?V0I5RlZ0cEQreSt0NHllZ0lETGVQeVlLaEl4RW5VRWxmelhGUEVhTGQ2SEIv?=
 =?utf-8?B?TWRYVG50Q2pmWm5taEFEZnJuR29oeE11aDJ5VUNQSk5aM21rNkRDVDdIanNQ?=
 =?utf-8?B?Sk04MmJJSitvTFRNamVwdlVuKzBZdGhMYnlBS3dUbTlzUktDU0EwWFA4OFpu?=
 =?utf-8?B?anFCUy9Xc3VhNW52R1k4YkVheGd1QjN0a1NlcDgwUDUybVU2N1JuN3RiRDg1?=
 =?utf-8?B?VFAzMWsrYnVVSmNrczcwUko1RFJ5ZUtkbGlIdlkyME01Z2FvQWxKVGpxUjF2?=
 =?utf-8?B?SFBWb3pEZG9BUDlNU2I0RGZ6KzQzd3BHOVp5dGF0UHY4L2EvMTRXYjNjdXVP?=
 =?utf-8?B?VXRIOUVxcUMvMFI5T2RZVmNyVXFPaDJFNTk5eGhKaXJ5SmV4RzVaNkVONmZz?=
 =?utf-8?B?QWNQQkFFeVgydDdMeVRwS3p1QnI1ZWNrdzdkSXNxbll6d1lVdWd1cUw3ei9t?=
 =?utf-8?B?YUl6eW9iU2hhYU1zL2YybUpNK3F5Sk1HOHJtNmViSHo5VmM1RC82alBKUXJ2?=
 =?utf-8?B?cUxONG9EUFlvMjJ0OWhzUTN3U3dIZEF3ZFhHd3JSZmNmTXNoTWtsNDhnY1hW?=
 =?utf-8?B?L09UOExZZUhkTkR2dFVEYndsK3dyYUl5TXFoRFdvMTA1bkljMzZIR1NuVFhX?=
 =?utf-8?B?TWJYSVl2dG02bnEyKzFDajA4SzhabFhWaGlhSU1RcGVkbEtNSjllS0RPOWxC?=
 =?utf-8?B?Z1kvOTJteUdnbGtzV3cvVWxVeS9sWS9Jck5IZ0NKK2RkWW1ENGl0czliZkxV?=
 =?utf-8?B?RDBYRkZmWkEyNmZvNWoyOHYrZnYrN2IwdjFyaTMyRWIyNi9NZXVWVkxtcUI5?=
 =?utf-8?B?VUFndWxkekd6REw0VEpiajh2TURvamhld3FYTDNSWmN3a2N6YTBSY0U2Vlhw?=
 =?utf-8?B?bEtNREVIZGptY2tuVTA1bU1TbmxYQllEZ2t2eG5pTy94cWpUR3NyRWpOc0hE?=
 =?utf-8?B?VGNhVGJIb0JXbmppbUhPcDI0THUyWitjQnd5SkpnS0YvYXRiYXFWZlpqdnVs?=
 =?utf-8?B?clJnK013d1hTeUVBa0l0M0hiZHMxeXpPcDdEcXJvY1hCNDN2L01wQTNoTXFt?=
 =?utf-8?B?YkVUaU9MRDJjWjRzbllEVVNrYXo3MlNKMUFFdXhQcm1jWS9Hb3U2QUpPUW9Y?=
 =?utf-8?B?VzJEeUJTY3NmazI0ejNwRm9DLzZsZitSS2NVeXB0c0Q4UjdrbGo4MG1lMHE2?=
 =?utf-8?B?Tkk5TEdEancrY29lelZRWkxjL2EwQkwzQWZvVnRpZjhZSEdoZHlGaUpSV1B0?=
 =?utf-8?Q?eW6WjbOzRe4ZlUYY=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce23b2dc-1114-4d47-e5f3-08df018e5635
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 03:18:15.5380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ssurXswu5hJvxDJaAO8wgeF0o2iH7qScU+0Iwx23wEkbF6vcmLVxDPXSh8OPb5pqqGuP8z2oLKVL/R+bA5wTvSM6zNjOX8INF20V/o1YfqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR02MB9628
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=chao.liu@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Daniel,

On Thu, Aug 20, 2026 at 08:01:39AM +0800, Daniel Henrique Barboza wrote:
> Ping
> 
> 
> This is the series I talked about in our call last night/earlier today.
> 
> The v9 of the riscv-server-ref work was rebased on top of it, along with Chao's
> sdext patches.  As soon as we get this queued I think I'll re-send Chao's
> work next.
Thanks for continuing to drive the sdext work. I don’t have much time to dedicate
to it at the moment, but I’ll do my best to help with the review.

Cheers,
Chao
> 
> 
> Cheers,
> Daniel
> 
> On 8/5/2026 3:25 PM, Daniel Henrique Barboza wrote:
> > Hi,
> > 
> > This short series adds support for Debug 0.13 and Debug 1.0.  The
> > motivation is simple: we need Debug 1.0 to complete tue upstreaming of
> > sdext, which is already fully reviewed and acked for awhile [1], and
> > then proceed with the upstreaming of the RISC-V Server Ref board
> > (currently on v8: [2]).
> > 
> > The work is based in section 1.2.1.2 "Incompatible Changes from 0.13 to
> > 1.0" of the ratified 1.0 spec [3].  It ended being simpler than
> > anticipated because we don't implement most of the registers/bits that
> > are backwards incompatible.  I added doc changes to explain the
> > rationale used.
> > 
> > After this series:
> > 
> > - 'ext_sdtrig' refers to Debug 1.0.  The legacy 'debug' flag refers to
> >    Debug 0.13;
> > - setting both flags enables Debug 1.0, i.e. 'ext_sdtrig' takes
> >    precedence.
> > 
> > My hope is that this split will make it easier to to move away from
> > Debug 0.13 in the future once there's no more demand for it.
> > 
> > Patches based on master.
> > 
> > [1] https://lore.kernel.org/qemu-devel/cover.1775959096.git.chao.liu.zevorn@gmail.com/
> > [2] https://lore.kernel.org/qemu-devel/20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com/
> > [3] https://docs.riscv.org/reference/debug/v1.0/_attachments/riscv-debug-specification.pdf
> > 
> > Daniel Henrique Barboza (5):
> >    target/riscv: split 'debug' and 'sdtrig' flags
> >    target/riscv/tcg/debug.c: add Debug 1.0 'pending' bit
> >    target/riscv/tcg/debug: adjust 'timing' bit for Debug 1.0
> >    target/riscv/tcg/debug: set tinfo version if sdtrig enabled
> >    docs/specs: add RISC-V CPU Debug support info
> > 
> >   docs/specs/index.rst              |  1 +
> >   docs/specs/riscv-debug.rst        | 68 +++++++++++++++++++++++++++++++
> >   target/riscv/cpu.c                | 21 +++++++---
> >   target/riscv/cpu_cfg_fields.h.inc |  1 +
> >   target/riscv/machine.c            |  2 +-
> >   target/riscv/tcg/csr.c            |  2 +-
> >   target/riscv/tcg/debug.c          | 51 +++++++++++++++++++++--
> >   target/riscv/tcg/debug.h          |  6 ++-
> >   target/riscv/tcg/tcg-cpu.c        |  3 +-
> >   9 files changed, 142 insertions(+), 13 deletions(-)
> >   create mode 100644 docs/specs/riscv-debug.rst
> > 
> 

