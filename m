Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F11C5AC67
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 02:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtz5R-0001j8-DH; Tue, 11 Aug 2026 22:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wtz5K-0001iZ-48; Tue, 11 Aug 2026 22:52:54 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wtz5H-0004xs-91; Tue, 11 Aug 2026 22:52:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glwTLSfj7DSkNpCaITeOjZ3Xx9HsM3PlmF8s/Bv9gb1MF/P4Y9uiPIuQku7VzQ6R5LbG1bn1jaR7pBYbeatjFn3YNmCXQ7Xwb1N2taWOA/a87OH7c0HD0Ger5VYCS1Ma3hebiPNuMdXSeawIwqIEGbO1khFrxuZ+3ATFNuTdv7VZn9QNbL/66G+5RnDNJyNGCHUC3SpbAOREyYPNVPOPOK+RDPsjNQxdpPHpPe2S3JdpUMSikl40iO1m7dohHHxzS9Uu7g0CQDOGE9fT05v1mD3ru+3wgrZU8LiwQh57YQ2xooCw+nUf+pzmLiNDmAjqCNRaT7EadKFV4PtwOmasEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rv4SsRzPLkM0K2IbVQgluUQ8jpgTxp3oHukrIavbOM=;
 b=dqmVkhakbrRRr/5uTGs2njG0A68DiQHorpzC5QVAa0r9cnam4DRBx3seJuPf/ii4P4C5oYxddLCryLnoydZRhl08HDutayIMv9QFKgPGKwD6aPtHNjoStqJneWz+13W348pj8luSCK0hdmy55xQ+XDPu4YUr6ey8I6plw4Y3gbZv4DkffSmfoj1wnyQ6iy2Z4g5e24dXyNqT7UQN9TfH+rnuY65xOKn/3sJkbEW94918kBhd92L5xiwn5+0zSTINhu6UIdChxgyzUABNnpOaKuZnz7Ydysxy+bWohVWsFVQW17XGnfk/kg7bdaouwdOBjnvaU4jGVzkPuRBK5G25YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rv4SsRzPLkM0K2IbVQgluUQ8jpgTxp3oHukrIavbOM=;
 b=gIV7hlhD9KGLMsOzDsotXapTM+TD/lvhqnoYxVUBG6uvs9I70AU12z16iMkOQDnpaAr2/swDRZ2pgwvZe/auXVGa3W/rPc+FrnB1PfjojJ5LZhFWKKdO0yQqOxcLYd4H8T+K2wOQY0evUdvgBcq8NTJH87YRYDsYUo96hRwChAufCV8cKmxZIxu/cRdD7L3GCphieV7kxeN5/9tCWgbzWBMU1wkkBVI4mSSntjblQjk/9+KmEVo7M91kFmFnvznX2MxtOcmdMwiUlwgr7xciDXwcHzUuwAyLQypejgSEkmR6fEFbPp2D2zTAlZiboOp/+CBopFk2nBaW3yQrq9tIHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEZPR02MB5805.apcprd02.prod.outlook.com (2603:1096:101:49::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 02:52:41 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 02:52:41 +0000
Date: Wed, 12 Aug 2026 10:52:35 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Alistair <alistair@alistair23.me>
Cc: Zephyr Li <fritchleybohrer@gmail.com>, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH v2] target/riscv: preserve vl on element-zero fault
Message-ID: <anvbH7pv95iO5PaR@ChaodeMacBook-Pro.local>
References: <20260724030145.14778-1-fritchleybohrer@gmail.com>
 <20260727084203.881580-1-fritchleybohrer@gmail.com>
 <718ed7010d214630379023daabb2fb804f7be73f.camel@alistair23.me>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <718ed7010d214630379023daabb2fb804f7be73f.camel@alistair23.me>
X-ClientProxiedBy: JH0PR03CA0025.apcprd03.prod.outlook.com
 (2603:1096:990:74::8) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SEZPR02MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: 0def4cd6-8e2d-45de-f02c-08def81cc6a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: m7Pr//T9XAYJ41U0W3IN9sD2uxt2PXD7fHFOVPVhPIkhCiWqK3GVNs7JBYHQoUWooeiWnThfMpDyP5r416hv6vrRUwTiq8eT2MHWqI7n+sImjgSEbaPQ8C3bWURFfGz8u+tGjGRw2osLyKnTRWmYUqy+0YEIOm3LqKnuoHNpeQLxamO1jPkTxkaI5WgM6/49hL4hFGrng6BTlVckr/NLFSIrko4Gn79K6jPsC3DpMtrSqaWePWyxiccDy6yINA91E2LKim9yvvhvD3waGf3gEXE4QDnGAVk3M4eNrcPtCke0ezxx4lXZR09rkEugO7SsV5cbxZdDiUcIEFX/wRZrp3uzw8LBNeoahc6hK6tf81BSbDG/CSu8Ds4jw+heUVV1NB3/4c763r/C/wqKiMIfjgMYHHlav5XocFp06hnXov/wWwV7E41IAkCTlwgotY0e2jlSMPdsoCIIFQTFSi+atKX1mfxIvVj2mqy+ZnOGfkT30ThWl6f/V95majX391+SJzmga5PuxE3jlLKfEvyl8qkOp14N363cN3gI94PUlQE9rcX4UkjDG7DjQmlxNoZ8aKxTD5qnn+QiixZ3p4VBBFXD3Q/1t1tpVQG8+6zMJEJcBcYBmtL9lUX6Uiloi2O/gLV0N1bDb1a3AlA8mTeqyrkFA2ASfePWLdwxi49BhHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2V3VDdtQ2VUSDFQdmdsanF2SjRYRzk1dU1xZGsyUy9HMW1lTmgwRmdVZFh5?=
 =?utf-8?B?K0JDQ0Z3cm5vSVdUaWVXc0ZDYS9NN2pXYS9laW9JWlJHcy9EOFNBaUVXd0xT?=
 =?utf-8?B?QmRuOVpySFpNdVVMZGRXQ0hnaU05VGxHOU1Cby9NT3dDbjJ6Sk0xRmRKczRn?=
 =?utf-8?B?aHNIcHRiOHgvNi8wSWhDNWpJbmk2VXRlOWlYYW1WRWM1c2hDaG9YY2JKc0R5?=
 =?utf-8?B?d1pqN0h4NVFFak5oU1RqMjJicXFyM3BYSkVpQmVIbXo0UC9jT0ZWODJMUXBV?=
 =?utf-8?B?UG1wVWRaWHdjeHBuL2ZwZ1J0OHlMNlhsbVhVS2tsbjRHUTNMeUhicko3TlJ1?=
 =?utf-8?B?Um9oTWtGMlU2cVRjTTkza1VodGFOa0tlWUVBbEhPdnBqclZxcEpwcjZMTHgz?=
 =?utf-8?B?Sy80QkZZVFpuMUJkQ2FCQng3cDNEQ0hwYjIxVEJLOXlpNThOcUVZZDR1aGN4?=
 =?utf-8?B?elJETUMvcUpsYXErSmU5d2tEVEpEbkRzbnBSbFZGSnJhWkpLREhkUXgycDQ0?=
 =?utf-8?B?WWp2TkVHNytVeDM4d0xHcmJjNk00Uk5RcFNlWGxFZWRsWDZSeFVmbU42cThG?=
 =?utf-8?B?MjMyTU1ySE5qeFhNM1EyVmdmaVF4WU9PWm5mb3FsNHhPWmE2QXoxTkZmYVha?=
 =?utf-8?B?aFBMdWtudVpXYlc2RUI5cXZqdjNGZko3Vjg5RkYwVlV2SFFkYnpnalF1SzVB?=
 =?utf-8?B?aTRGN2gzaTJyWFBPSkJoT04wcEwvanViT0d0UTJTS2Yzc0JHWGRtSEE5eGNG?=
 =?utf-8?B?ZFNNTlU1b0E2S1J0T2FmVjdtVGtjMVZ2RCtzazZCU2FFN2hCV3dwS3Z2Y001?=
 =?utf-8?B?L1FjOHMwMGZBWGJNQ0NCRWdUTUVIUnF6Q3NYY1Y5OE1NeThoTlVNZVdMY0xn?=
 =?utf-8?B?Zmp3RENZcU1nc1cxUEdGYUs4MU1iWHppQ2pMU2thNkpNQ0dqVkJYUVJXdy9m?=
 =?utf-8?B?eUg5T2IyenJQdWpqSzZySTcxT0VkOVZnTlFxeVFvMWd5Um8vMWt0ODJhcGxQ?=
 =?utf-8?B?Vklid2drZVRqU0g0d1lPWnhGYjlvQkRkT3duNjdoSWY5bldEcFNvUVZhZ3Y1?=
 =?utf-8?B?YXYxVG5wTzFXaUJzaWpWRENOTUZkNURkcmhqTXh0SVluV1FvUkF0M1V4cytS?=
 =?utf-8?B?YmVEUTRwZGkwUjVwNm56RHhycTNTOUx5ekNveWhobS9CcHFidlg2cHovZXlh?=
 =?utf-8?B?UUFNVGFsNEpXOWdadWU2Rndzbk96N2tjTXdDd214OHI3cGp1NERJRnpMNmtv?=
 =?utf-8?B?Uno1U2xCenU3TkxWemhESk5LKytvb3VNMXZkRVRjZllBK2dpelFTRXNZcjVB?=
 =?utf-8?B?Nm9qelF1eHkwM2NnNTJ2OTVJcmhpSzRpbityNnpJTHBEayt1K3hnV1FWNjNY?=
 =?utf-8?B?QkgrTllYZ2RvenU4bldGcVFJU01uVk8vUGRjWUFOVVpkTjZHeUlTNUFmaTBz?=
 =?utf-8?B?NUlheVliRFVSVzZ2UFltNVBraTB6VVlwOFFMT240Sy80S09pek0wYm9YZkZ2?=
 =?utf-8?B?R2JIclZOWUNudFFvajRYQ290Ny9xNFVleEZZNzhCMU83c05ZT0JzRGZVODBC?=
 =?utf-8?B?S3o0Nll6aXdocFo3bGdldDRpMlBQSUFZMkoySjJHUzVEaFFIdVNmU3hOTlhn?=
 =?utf-8?B?K0txOFlvOHljakNNLzE2aDdjdjVSV1ZLNVZ4eCtvZFFaR1VOSUczeFRaclZl?=
 =?utf-8?B?L0lPSlRDNW9xYjg3UGdQakVJemtsTm5hSzQzL0pKODRqWUU4Q3NveHBDOEJR?=
 =?utf-8?B?QXQzYnNsRytvS212Mld2ZGREMkFEQWZ6RDc0VFA2ekgwS0dNanUwb3RSZDBL?=
 =?utf-8?B?WVRiS0JhdHlZek00Y1gvR2JvY1BBNUNJK2szcG1KREtWU2tpVFEwNU1Idjhx?=
 =?utf-8?B?L2lObmdIOG1wMkJzeVFOcmt1MmtPYkF4NDlXTm5EVzJLUTNpNmo1b0Vjd0g3?=
 =?utf-8?B?Q0RmYUtXRUh2TG5YM2dCblczNjI2Nko3MWh3OElHSTF5YzBVeWVVelJVazFx?=
 =?utf-8?B?Z2c5c3I1ekljTVFVL0o0a0VuL05XRkYySmtZOE92RnkvWU13aFJGajR5b096?=
 =?utf-8?B?N2pEbGhkVFlLT2E5QkxvbDNvMTlGZnlDQ0J5Yk11MzBIeWdZTVVmQlNMd3hY?=
 =?utf-8?B?MGZ5N0hib0ZMNHYybWl6eC9uaVByZVlsR0ZKYjFRSm5xSTh6OUcvZ204TEdp?=
 =?utf-8?B?MlVlR1dwL01QV3dLSFEyQUNaTG55ME5VS080Q09zNyt0VERaSWdtREhiNThH?=
 =?utf-8?B?cTJKazRpdngzdXBVS0ZSTkVkaSt6UDRVRnRuZXIvd0dybzBQL05kR0ZSUnZn?=
 =?utf-8?B?Z1hwcnQwZ1dXSVJNMDg5RUEwRXhQdlErbGEwQnNDc0owL3o2bEpWdHRkL3FJ?=
 =?utf-8?Q?bC8RYqC6O3yfxvzU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0def4cd6-8e2d-45de-f02c-08def81cc6a9
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 02:52:41.0324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eoDwO5A2FaX2YdRkuu/0KDr3qY/1BIy/22qseFo3x2MdU8iO4Pc5JvFU1wJHKlKF0HHtna7QWb83TEj6y/8K38IWPDZubN64ZH3kQqz9lLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5805
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=chao.liu@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

On Wed, Aug 12, 2026 at 05:41:00AM +0800, Alistair wrote:
> On Mon, 2026-07-27 at 16:42 +0800, Zephyr Li wrote:
> > A unit-stride fault-only-first load must leave vl unchanged when
> > element
> > zero raises a synchronous exception. Keep the shortened value in a
> > local
> > bound until all loads complete, and only then update the
> > architectural vl.
> > 
> > Add a bare-metal RVV regression test which faults vle32ff.v on
> > element zero
> > and checks that vl remains unchanged in the trap handler.
> > 
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3544
> > Reviewed-by: Chao Liu <chao.liu@processmission.com>
> 
> Was this Reviewed?
I’ve checked v2. The test improvements look good to me and the
fix is unchanged.

Thanks,
Chao
> 
> Alistair
> 
> > Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> > ---
> > Changes in v2:
> > - Fix commit message formatting.
> > - Enable vector state in the bare-metal test.
> > - Use an aligned unmapped address and compare against the vsetvli
> > result.
> > - Express the mstatus.VS setting as a field shift.
> > 
> >  target/riscv/tcg/vector_helper.c          | 23 +++++----
> >  tests/tcg/riscv64/Makefile.softmmu-target |  5 ++
> >  tests/tcg/riscv64/test-vle32ff.S          | 57
> > +++++++++++++++++++++++
> >  3 files changed, 76 insertions(+), 9 deletions(-)
> >  create mode 100644 tests/tcg/riscv64/test-vle32ff.S
> > 
> > diff --git a/target/riscv/tcg/vector_helper.c
> > b/target/riscv/tcg/vector_helper.c
> > index e321ca2616..5a310822b7 100644
> > --- a/target/riscv/tcg/vector_helper.c
> > +++ b/target/riscv/tcg/vector_helper.c
> > @@ -686,7 +686,7 @@ vext_ldff(void *vd, void *v0, target_ulong base,
> > CPURISCVState *env,
> >            uint32_t desc, vext_ldst_elem_fn_tlb *ldst_tlb,
> >            vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
> > uintptr_t ra)
> >  {
> > -    uint32_t i, k, vl = 0;
> > +    uint32_t i, k, vl = 0, load_vl;
> >      uint32_t nf = vext_nf(desc);
> >      uint32_t vm = vext_vm(desc);
> >      uint32_t max_elems = vext_max_elems(desc, log2_esz);
> > @@ -752,22 +752,24 @@ vext_ldff(void *vd, void *v0, target_ulong
> > base, CPURISCVState *env,
> >          }
> >      }
> >  ProbeSuccess:
> > -    /* load bytes from guest memory */
> > -    if (vl != 0) {
> > -        env->vl = vl;
> > -    }
> > +    /*
> > +     * Keep a shortened vl local until all loads complete. In
> > particular,
> > +     * an exception from element zero must leave the architectural
> > vl alone.
> > +     */
> > +    load_vl = vl ? vl : env->vl;
> >  
> > -    if (env->vstart < env->vl) {
> > +    if (env->vstart < load_vl) {
> >          if (vm) {
> >              /* Load/store elements in the first page */
> >              if (likely(elems)) {
> > +                elems = MIN(elems, load_vl - env->vstart);
> >                  vext_page_ldst_us(env, vd, addr, elems, nf,
> > max_elems,
> >                                    log2_esz, true, mmu_index,
> > ldst_tlb,
> >                                    ldst_host, ra);
> >              }
> >  
> >              /* Load/store elements in the second page */
> > -            if (unlikely(env->vstart < env->vl)) {
> > +            if (unlikely(env->vstart < load_vl)) {
> >                  /* Cross page element */
> >                  if (unlikely(page_split % msize)) {
> >                      for (k = 0; k < nf; k++) {
> > @@ -780,7 +782,7 @@ ProbeSuccess:
> >  
> >                  addr = base + ((env->vstart * nf) << log2_esz);
> >                  /* Get number of elements of second page */
> > -                elems = env->vl - env->vstart;
> > +                elems = load_vl - env->vstart;
> >  
> >                  /* Load/store elements in the second page */
> >                  vext_page_ldst_us(env, vd, addr, elems, nf,
> > max_elems,
> > @@ -788,7 +790,7 @@ ProbeSuccess:
> >                                    ldst_host, ra);
> >              }
> >          } else {
> > -            for (i = env->vstart; i < env->vl; i++) {
> > +            for (i = env->vstart; i < load_vl; i++) {
> >                  k = 0;
> >                  while (k < nf) {
> >                      if (!vext_elem_mask(v0, i)) {
> > @@ -806,6 +808,9 @@ ProbeSuccess:
> >              }
> >          }
> >      }
> > +    if (vl != 0) {
> > +        env->vl = vl;
> > +    }
> >      env->vstart = 0;
> >  
> >      vext_set_tail_elems_1s(env->vl, vd, desc, nf, esz, max_elems);
> > diff --git a/tests/tcg/riscv64/Makefile.softmmu-target
> > b/tests/tcg/riscv64/Makefile.softmmu-target
> > index 82be8a2c91..7ae225bd73 100644
> > --- a/tests/tcg/riscv64/Makefile.softmmu-target
> > +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> > @@ -41,5 +41,10 @@ comma:= ,
> >  run-test-crc32: test-crc32
> >  	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)xlrbr=true
> > $(QEMU_OPTS)$<)
> >  
> > +EXTRA_RUNS += run-test-vle32ff
> > +run-test-vle32ff: test-vle32ff
> > +	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true
> > $(QEMU_OPTS)$<)
> > +test-vle32ff: CFLAGS += -march=rv64gcv
> > +
> >  # We don't currently support the multiarch system tests
> >  undefine MULTIARCH_TESTS
> > diff --git a/tests/tcg/riscv64/test-vle32ff.S
> > b/tests/tcg/riscv64/test-vle32ff.S
> > new file mode 100644
> > index 0000000000..f510960c05
> > --- /dev/null
> > +++ b/tests/tcg/riscv64/test-vle32ff.S
> > @@ -0,0 +1,57 @@
> > +/*
> > + * Verify that a fault-only-first load keeps vl unchanged when
> > element zero
> > + * raises a synchronous exception.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +	.option norvc
> > +
> > +	.text
> > +	.globl _start
> > +_start:
> > +	lla	t0, trap
> > +	csrw	mtvec, t0
> > +
> > +	li	t0, (1 << 9)	/* Set mstatus.VS to Initial. */
> > +	csrs	mstatus, t0
> > +	li	t1, 4
> > +	vsetvli	t2, t1, e32, m1, ta, ma
> > +	li	t0, 0x18000000	/* Unmapped gap in the virt memory
> > map. */
> > +	vle32ff.v	v1, (t0)
> > +
> > +	/* Element zero did not trap. */
> > +	li	a0, 1
> > +	j	_exit
> > +
> > +trap:
> > +	csrr	t0, mcause
> > +	li	t1, 5		/* Load access fault. */
> > +	bne	t0, t1, trap_fail
> > +
> > +	csrr	t0, vl
> > +	bne	t0, t2, trap_fail
> > +
> > +	li	a0, 0
> > +	j	_exit
> > +
> > +trap_fail:
> > +	li	a0, 1
> > +
> > +_exit:
> > +	lla	a1, semiargs
> > +	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
> > +	sd	t0, 0(a1)
> > +	sd	a0, 8(a1)
> > +	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
> > +
> > +	.balign	16
> > +	slli	zero, zero, 0x1f
> > +	ebreak
> > +	srai	zero, zero, 0x7
> > +	j	.
> > +
> > +	.data
> > +	.balign	8
> > +semiargs:
> > +	.space	16

