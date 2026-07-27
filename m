Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBDBC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 06:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woEPN-0002h5-EM; Mon, 27 Jul 2026 02:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woEPK-0002eU-MZ; Mon, 27 Jul 2026 02:01:46 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woEPI-0005mB-32; Mon, 27 Jul 2026 02:01:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHuiLwBeZL+UbnATypv8BV3hHS0GYBXioyQkennjFDLZuY/WZum/30lhu+EgBEwkoDTYuPyq9dpLfCc5+BE5d3rnw+hlKfBqJFj1t5bCWYO/SxqpdFMgc5ODQYSVMNE2yvMNbOkKYVRoWvwfV3GIZzEBRgi2R9uhy4CQ3Qa9sKD/tb5gE7ZqtskJC5dNTZcNh2QnvkjwYpodWKZ8U0hp6Yw9tt+6H1fOl2YWiHosMd8LmPb6ovAJdaGxcYPW6P3LBOsh4FSmf3Y/Wqz8n7bOKeFQRWY61hJJBfGNiYJlM5U3jmF4Yw6nKLXmDgsveGsisv9VqP+sF6Xec0ZztsUAGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1T2vuFyvPEd24++VZJM1pvRA70hLzReM4eRQup4XyFE=;
 b=nEgq1k3/CRxhBykp2X6+poanyC1zwff4VV/xGBOWOJWQfHM3mqLQxr/VYL+HN0rcRIJa8yWzCxKrtPNq/NilFLFSiXmi7YNbYKefOX42hp7L4pyMoDyK1kFC1/3R1HA3JhMZcsTgf+etjv5FvRpMyNFJt9qFg2xxw23dwwi7jVze91KS1Z494RlKtz+GeErBQOCWE3Wd2B8zGLy+jbFlRKgBD4tuP0DgT29wUNzoibXlQKFYozau6RSnDvFiCeCgCvMVNUQAXfsqyr8dq4lZkCWMR+Mrnk1FtvBi8Oa9WikEk2iZJcJGHohQIpnX4MOyh3/pZNu4/rEQkNb1aCSU9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1T2vuFyvPEd24++VZJM1pvRA70hLzReM4eRQup4XyFE=;
 b=N/s7dfhye8OXAApRbykWOBwhlu+89r+HeCpjoEGbcAqGHBFwydKS3TRE3GZzmNWnMjXqUUq6aijU3eDiGAR2vOk18Mh5w+thBOMH6QIeyKZPD7tgJSTgM5lR/riBxtexOe2Cye911sXlGqXK46XRp1aAvJDU5qrfB3NOEsxMDMLDVhYG9YmmF4CC5RLL8q83HrsD9kHHU4y3IDRgtT/IkXfOu+LSbAQOJ6laq8qFaP9Nkzb6tUB2a7tQNOwui67UhE7QFJ3oSuJZ1xGXDSYJAHFO1j/GJoIvRBtgk8yi70OVcEHFCq6IGlc1cCkv91GKZ0alzDpuYkyGvHmfZZDidg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SI2PR02MB5683.apcprd02.prod.outlook.com (2603:1096:4:1ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 06:01:36 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 06:01:35 +0000
Date: Mon, 27 Jul 2026 14:01:31 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Zephyr Li <fritchleybohrer@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH] target/riscv: preserve vl on element-zero fault
Message-ID: <ambzIcXtYqMpeLZj@ChaodeMacBook-Pro.local>
References: <20260724030145.14778-1-fritchleybohrer@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724030145.14778-1-fritchleybohrer@gmail.com>
X-ClientProxiedBy: BY3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:254::7) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SI2PR02MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0b98a8-e2a4-481b-b613-08deeba4840c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|34096008|366016|376014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0TFdxalxXmIu5dYbDxsa6FV1eDGQ6GM5S7AgttaQ8KdoYiBJIqgjoEwGK+0JQV0LIsn2KU6l4sStb434Pd6YIqcm6CjhFAbTRuRxQS0bYHmRbd9Mu33ZSzpUf2Uv5EPvC6vaJuX48heZhBG06Cw67zJlL8jNd0n59k9nDRdUL+7cQxykrXw81ELgC8lxX+sNCl7EPgTBhq/FUsYZ9GDPyDsHtxSwPtxkDXqyBlFZtRvSgNYYFKbXIVk4M4Ou0+Pm01FJg+B3upg5oXUHU+8Csn7U5+PYm6Kk/G49+tjrv3lLLB+rxt3Reb/wxLTDFAVGvBjXoXIrgUdhCluDEK8O7x9o6xBmNp24Rzfg1P7zUeyi3kvjrXMZ80k8F5+ycbxDsR17EP3zEe8X1kkHF4RnLHUCmzM7E2GKkF3Exhl011/W42Z0dcDemTp28tRj3pBTYAG/xBTY7dfMWPQyHGZs3+/LA/BhsPl0dep5obZRvzY+mIFoKACu8IVHLQSaBlwZyEuaAomi3yzfWKiI7CZPb9JVUllmvoyKYRERveLo4Tix10F4vkh4VtkSmAlPfECylNM8SJSkd0pwY+79L77L1p5l2QRwqJO5J/kGbozZNkg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(34096008)(366016)(376014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iEaS0QHSjehkEb7vG5K3O9RgZnlql5p4ziTt+cNoGvmv0Rr5n9dkDWfZUbeK?=
 =?us-ascii?Q?8Puj/BQCGv5x7u+Lj0/20FsJGry2MrJRRLTJGs9Ksw7/Uol7/1sYorOWG8wR?=
 =?us-ascii?Q?d7Ps6LK/o/8lOIExjDD0FwXghPE1mFzFEbH8Qt7PLw/7FssYa3dmM7b/M/mO?=
 =?us-ascii?Q?QNLhCvf6L40+jedWN85FQE7gPchxeZgirCRXVQK17oAPOuGKhF0w3/0aEOCF?=
 =?us-ascii?Q?ZJTCtRUu8VTr6Zrmjq00CRgv0IdzMP8tVTjIIkGHRXsstj0vGaIf+hOcOIY+?=
 =?us-ascii?Q?YMMvLxG6VGHRknttWUJ+BPg/c/3iqH9iKEh02HQ4GC4axjef5YH7BeKkxdwi?=
 =?us-ascii?Q?UMTg3Eks+EDf2f1q09YWAMkNlj1kK7X64fJvBOw8KCMsppS5xqcEXEcgnsyl?=
 =?us-ascii?Q?GHqOz8Oo/EauZfEOG9A+MfwbkWgalrZkEPO3ZProiZA8nGL5GOjSAPRVKf7K?=
 =?us-ascii?Q?nne/68d8ws+peK4NkPRxcR9QaIOaA6j+zjEvuZCi7HL0Lcgt1VSEzkaSAsNL?=
 =?us-ascii?Q?4lrlM/DAmyCKg88PMn2k2Re/QzYTXedIkooFAk7X3XKGU8KmfiEwTGPH76Ul?=
 =?us-ascii?Q?8DLLD4Q5QMls3+6mfxSkGo+ulRGjY+UjY7ErS5TYNanVHAeato0CpnqQNA4A?=
 =?us-ascii?Q?Rm8bXoY8Dr11p3zjRZEuhtYAlhvGh0c1ulkGrRmuZC+5U1CWk0lkrkJB56NG?=
 =?us-ascii?Q?IUuunMHhKCox/liXPzQUhbQ7K1GF2MstzYq1PdiS+Fu2ZD1WBbC84IH7NBHY?=
 =?us-ascii?Q?k9OOz8bCeVYsIO9/qgp1VDvUW82Amqc9NhLmtXnmoyO9CpvUsQJrKpUmBI6q?=
 =?us-ascii?Q?RkcuHpQAEruacxPzLRAeMtNQfvQ4areF8pP94O8MzThjrhblc+RxxmK9ujTw?=
 =?us-ascii?Q?hiR/FErVMWtFPnTTc87pK3iiYn79dPmPbMa8iPI2oMceRfVxjRzDA8z7nQEI?=
 =?us-ascii?Q?0iPu2/e7uIc4jPhsXMHhP0KUKWuRVEniyqby0hk3S9rpfObPFd9ruEdVBPOP?=
 =?us-ascii?Q?sSHc1sfgBsOR9ehu7z9oCBhX/rRfKvsIv11TSDuh1aB0VrHZfYDKXfQxm5lP?=
 =?us-ascii?Q?DRiShh/n3uN5pA7+wk8YxomEDI6In0HADQdWkBze2U1FXNrWO6cQDDGlvhj1?=
 =?us-ascii?Q?nqiM33bX9td+nmv+EKzImnpc7HqkaJCllCryXKpG51Nc4wiQ0P3SdofXEfRB?=
 =?us-ascii?Q?pxcjXXfnWsglJifJQh167uzrR1D4u7J9vJhK2pTutFt161rhspvsqCrZKs6D?=
 =?us-ascii?Q?q1ph5eURta7dS5moj1AJYTH7GXkvvxL/oeYHOfCSpWAhekaW7HDsO4EU060W?=
 =?us-ascii?Q?RIHOlFXWAUd2lH5+XCRB+wljp953CHTF+4uBasa6TnGHzFzgu5J4CEQVDjKd?=
 =?us-ascii?Q?W6kig8lbdfOLFEwjiaBsFTCmRadN3ddfhpXvljugmz0SrzqnA6c4w4B5Pqnj?=
 =?us-ascii?Q?luT+ABS/cknqqdRc0HALeVSzFpbamGnWS3mtXEplhyG9a7shN3/LygNnDsJg?=
 =?us-ascii?Q?QOOygOF/cUD6GNkqPobl7aITUbnS8x0CuLT9ZS1uHLaXKYm/dCQPMeg+adIV?=
 =?us-ascii?Q?9YR6sKcgiSL/+dFeKlo55bTHiT4u63R4tE2Kg8P7Qh8T8LQ0x2iIjnVL//7f?=
 =?us-ascii?Q?IO51BOND+FSUoVPVUrjeQblNFAARsibg/LCRwlGWSGjZz6Rnjs4nWwqoMW4O?=
 =?us-ascii?Q?T5PLVvnb8kURayClsjLgtSx+F9qKxGwK5dFKeBUbdh8Sd2Cogjt0NmjX7FEq?=
 =?us-ascii?Q?uk5y2YCDvyjMC7nYbbMIgWQ8HxZclHg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0b98a8-e2a4-481b-b613-08deeba4840c
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 06:01:35.7364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAwWO4uP6vv+wbXN4jzbWsYaASN+1wSFTm3EY76N5Qf4T4iWJCL+WnZLEItnPdifyyeY4bxaJDfsYKn4/xVCRmeF2FvmmxVyYFlyJxgKKAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5683
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

On Fri, Jul 24, 2026 at 11:01:45AM +0800, Zephyr Li wrote:
> A unit-stride fault-only-first load must leave vl unchanged when element zero raises a synchronous exception. Keep the shortened value in a local bound until all loads complete, and only then update the architectural vl.
> 
> Add a bare-metal RVV regression test which faults vle32ff.v on element zero and checks that vl remains unchanged in the trap handler.
Please wrap the commit message at 76 columns or fewer.

see:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#write-a-meaningful-commit-message


Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3544
> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> ---
>  target/riscv/tcg/vector_helper.c          | 23 ++++++----
>  tests/tcg/riscv64/Makefile.softmmu-target |  5 ++
>  tests/tcg/riscv64/test-vle32ff.S          | 56 +++++++++++++++++++++++
>  3 files changed, 75 insertions(+), 9 deletions(-)
>  create mode 100644 tests/tcg/riscv64/test-vle32ff.S
> 
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index e321ca2616..5a310822b7 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -686,7 +686,7 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
>            uint32_t desc, vext_ldst_elem_fn_tlb *ldst_tlb,
>            vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz, uintptr_t ra)
>  {
> -    uint32_t i, k, vl = 0;
> +    uint32_t i, k, vl = 0, load_vl;
>      uint32_t nf = vext_nf(desc);
>      uint32_t vm = vext_vm(desc);
>      uint32_t max_elems = vext_max_elems(desc, log2_esz);
> @@ -752,22 +752,24 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
>          }
>      }
>  ProbeSuccess:
> -    /* load bytes from guest memory */
> -    if (vl != 0) {
> -        env->vl = vl;
> -    }
> +    /*
> +     * Keep a shortened vl local until all loads complete. In particular,
> +     * an exception from element zero must leave the architectural vl alone.
> +     */
> +    load_vl = vl ? vl : env->vl;
>  
> -    if (env->vstart < env->vl) {
> +    if (env->vstart < load_vl) {
>          if (vm) {
>              /* Load/store elements in the first page */
>              if (likely(elems)) {
> +                elems = MIN(elems, load_vl - env->vstart);
>                  vext_page_ldst_us(env, vd, addr, elems, nf, max_elems,
>                                    log2_esz, true, mmu_index, ldst_tlb,
>                                    ldst_host, ra);
>              }
>  
>              /* Load/store elements in the second page */
> -            if (unlikely(env->vstart < env->vl)) {
> +            if (unlikely(env->vstart < load_vl)) {
>                  /* Cross page element */
>                  if (unlikely(page_split % msize)) {
>                      for (k = 0; k < nf; k++) {
> @@ -780,7 +782,7 @@ ProbeSuccess:
>  
>                  addr = base + ((env->vstart * nf) << log2_esz);
>                  /* Get number of elements of second page */
> -                elems = env->vl - env->vstart;
> +                elems = load_vl - env->vstart;
>  
>                  /* Load/store elements in the second page */
>                  vext_page_ldst_us(env, vd, addr, elems, nf, max_elems,
> @@ -788,7 +790,7 @@ ProbeSuccess:
>                                    ldst_host, ra);
>              }
>          } else {
> -            for (i = env->vstart; i < env->vl; i++) {
> +            for (i = env->vstart; i < load_vl; i++) {
>                  k = 0;
>                  while (k < nf) {
>                      if (!vext_elem_mask(v0, i)) {
> @@ -806,6 +808,9 @@ ProbeSuccess:
>              }
>          }
>      }
> +    if (vl != 0) {
> +        env->vl = vl;
> +    }
>      env->vstart = 0;
>  
>      vext_set_tail_elems_1s(env->vl, vd, desc, nf, esz, max_elems);
> diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
> index 82be8a2c91..7ae225bd73 100644
> --- a/tests/tcg/riscv64/Makefile.softmmu-target
> +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> @@ -41,5 +41,10 @@ comma:= ,
>  run-test-crc32: test-crc32
>  	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)xlrbr=true $(QEMU_OPTS)$<)
>  
> +EXTRA_RUNS += run-test-vle32ff
> +run-test-vle32ff: test-vle32ff
> +	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true $(QEMU_OPTS)$<)
> +test-vle32ff: CFLAGS += -march=rv64gcv
> +
>  # We don't currently support the multiarch system tests
>  undefine MULTIARCH_TESTS
> diff --git a/tests/tcg/riscv64/test-vle32ff.S b/tests/tcg/riscv64/test-vle32ff.S
> new file mode 100644
> index 0000000000..4c687bf1e4
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-vle32ff.S
> @@ -0,0 +1,56 @@
> +/*
> + * Verify that a fault-only-first load keeps vl unchanged when element zero
> + * raises a synchronous exception.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +	.option norvc
> +
> +	.text
> +	.globl _start
> +_start:
> +	lla	t0, trap
> +	csrw	mtvec, t0
> +
> +	li	t1, 4
> +	vsetvli	t2, t1, e32, m1, ta, ma
> +	li	t0, 1
> +	vle32ff.v	v1, (t0)
> +
> +	/* Element zero did not trap. */
> +	li	a0, 1
> +	j	_exit
> +
> +trap:
> +	csrr	t0, mcause
> +	li	t1, 5		/* Load access fault. */
> +	bne	t0, t1, trap_fail
> +
> +	csrr	t0, vl
> +	li	t1, 4
> +	bne	t0, t1, trap_fail
> +
> +	li	a0, 0
> +	j	_exit
> +
> +trap_fail:
> +	li	a0, 1
> +
> +_exit:
> +	lla	a1, semiargs
> +	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
> +	sd	t0, 0(a1)
> +	sd	a0, 8(a1)
> +	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
> +
> +	.balign	16
> +	slli	zero, zero, 0x1f
> +	ebreak
> +	srai	zero, zero, 0x7
> +	j	.
> +
> +	.data
> +	.balign	8
> +semiargs:
> +	.space	16

