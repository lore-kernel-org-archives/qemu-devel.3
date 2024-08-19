Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84710C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 16:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg4vb-0005ym-EQ; Mon, 19 Aug 2024 12:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5961d01319=ian.brockbank@cirrus.com>)
 id 1sg4vX-0005sx-Sg; Mon, 19 Aug 2024 12:08:15 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]
 helo=mx0b-001ae601.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5961d01319=ian.brockbank@cirrus.com>)
 id 1sg4vV-0006x1-QQ; Mon, 19 Aug 2024 12:08:15 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JF6kfa004018;
 Mon, 19 Aug 2024 11:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 PODMain02222019; bh=CTBn2WQgxjV9HstSP0zkV4cvwhWuzTA6WEBVfacCLU8=; b=
 AXB7KgE2t3pNjS8SWBsUN0r2VMkSmRu0sTU2NDtOLeW4SYcDrl58efiakn0Lkp8Q
 V3ukLux7+4F7G/Rl/PyhWf6jgZX1Nr/E4ohPROV8FK3XD69x379YiutpyMc/cvXp
 jf6LR8YR/o2+RqCTAwI+M01va8/NPAxcFEWlQTETmmrxyAK6eYZ4wABVyrj+Gx60
 aaiFY7vvg11l53dU5ar1r/2eyddK4r+XxQo5GdYWsUI2xpukdaXrmKj2vqyFuB6B
 y4jDxc2Hrq+esNNTPqWgC2ap43dTOxLgi3AU46KKBOLhX0WiTdN0Z8dmfIA2Yj2s
 I8f2yKQgsZ3tjyLZKa95/A==
Received: from ausex02.ad.cirrus.com ([141.131.3.21])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 412s8x1x57-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Aug 2024 11:07:56 -0500 (CDT)
Received: from ausex01.ad.cirrus.com (141.131.37.95) by ausex02.ad.cirrus.com
 (141.131.37.96) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 19 Aug
 2024 11:07:55 -0500
Received: from EDIN7BQBTG3.ad.cirrus.com (141.131.38.212) by
 anon-ausex01.ad.cirrus.com (141.131.37.95) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 19 Aug 2024 11:07:53 -0500
From: Ian Brockbank <Ian.Brockbank@cirrus.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
CC: Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ian Brockbank
 <ian.brockbank@cirrus.com>
Subject: [PATCH 00/11 v2] RISC-V: support CLIC v0.9 specification
Date: Mon, 19 Aug 2024 17:02:08 +0100
Message-ID: <20240819160742.27586-1-Ian.Brockbank@cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <https://lists.gnu.org/archive/html/qemu-riscv/2024-08/msg00234.html>
References: <https://lists.gnu.org/archive/html/qemu-riscv/2024-08/msg00234.html>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1hR6MrH6FeYr0AP99NSuhHpCrCRY_fji
X-Proofpoint-GUID: 1hR6MrH6FeYr0AP99NSuhHpCrCRY_fji
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=67.231.149.25;
 envelope-from=prvs=5961d01319=ian.brockbank@cirrus.com;
 helo=mx0b-001ae601.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

[Resubmission now the merge is correct]

This patch set gives an implementation of "RISC-V Core-Local Interrupt
Controller(CLIC) Version 0.9-draft-20210217". It comes from [1], where
you can find the pdf format or the source code.

This is based on the implementation from 2021 by Liu Zhiwei [3], who took
over the job from Michael Clark, who gave the first implementation of
clic-v0.7 specification [2]. I believe this implementation addresses all
the comments in Liu Zhiwei's RFC patch thread.

This implementation follows the CLIC 0.9-stable draft at 14 March 2024,
with the following exceptions and implementation details:
 - the CLIC control registers are memory-mapped as per earlier drafts (in
   particular version 0.9-draft, 20 June 2023)
 - the indirect CSR control in 0.9-stable is not implemented
 - the vector table can be either handler addresses (as per the spec)
   or a jump table where each entry is processed as an instruction,
   selectable with version number v0.9-jmp
 - each hart is assigned its own CLIC block
 - if PRV_S and/or PRV_M are supported, they are currently assumed to follo=
w
   the PRV_M registers; a subsequent update will address this
 - support for PRV_S and PRV_M is selectable at CLIC instantiation
 - PRV_S and PRV_U registers are currently separate from PRV_M; a subsequen=
t
   update will turn them into filtered views onto the PRV_M registers
 - each hart is assigned its own CLIC block
 - support for PRV_S and PRV_M is selectable at CLIC instantiation by
   passing in a base address for the given modes; a base address of 0 is
   treated as not supported
 - PRV_S and PRV_U registers are mapped  onto the PRV_M controls with
   appropriate filtering for the access mode
 - the RISCV virt machine has been updated to allow CLIC emulation by
   passing "machine=3Dvirt,clic=3Don" on the command line; various other
   parameters have been added to allow finer control of the CLIC behavior

The implementation (in jump-table mode) has been verified to match the
Cirrus Logic silicon (PRV_M only), which is based upon the Pulp
implementation [4] as of June 2023.

The implementation also includes a selection of qtests designed to verify
operation in all possible combinations of PRV_M, PRV_S and PRV_U.

[1] specification website: https://github.com/riscv/riscv-fast-interrupt.
[2] Michael Clark origin work:
https://github.com/sifive/riscv-qemu/tree/sifive-clic.
[3] RFC Patch submission by Liu Zhiwei:
https://lists.gnu.org/archive/html/qemu-devel/2021-04/msg01417.html
[4] Pulp implementation of CLIC: https://github.com/pulp-platform/clic

Ian Brockbank (11):
    target/riscv: Add CLIC CSR mintstatus
    target/riscv: Update CSR xintthresh in CLIC mode
    hw/intc: Add CLIC device
    target/riscv: Update CSR xie in CLIC mode
    target/riscv: Update CSR xip in CLIC mode
    target/riscv: Update CSR xtvec in CLIC mode
    target/riscv: Update CSR xnxti in CLIC mode
    target/riscv: Update interrupt handling in CLIC mode
    target/riscv: Update interrupt return in CLIC mode
    hw/riscv: add CLIC into virt machine
    tests: add riscv clic qtest case and a function in qtest

This message and any attachments may contain privileged and confidential in=
formation that is intended solely for the person(s) to whom it is addressed=
. If you are not an intended recipient you must not: read; copy; distribute=
; discuss; take any action in or make any reliance upon the contents of thi=
s message; nor open or read any attachment. If you have received this messa=
ge in error, please notify us as soon as possible on the following telephon=
e number and destroy this message including any attachments. Thank you. Cir=
rus Logic International (UK) Ltd and Cirrus Logic International Semiconduct=
or Ltd are companies registered in Scotland, with registered numbers SC0898=
39 and SC495735 respectively. Our registered office is at 7B Nightingale Wa=
y, Quartermile, Edinburgh, EH3 9EG, UK. Tel: +44 (0)131 272 7000. www.cirru=
s.com

