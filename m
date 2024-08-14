Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C1DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 08:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se9XM-0008Kj-TG; Wed, 14 Aug 2024 04:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5956f96c7e=ian.brockbank@cirrus.com>)
 id 1se9XE-0008Gb-B3; Wed, 14 Aug 2024 04:39:12 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]
 helo=mx0b-001ae601.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5956f96c7e=ian.brockbank@cirrus.com>)
 id 1se9XB-0005SM-34; Wed, 14 Aug 2024 04:39:11 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47E5pcFY028298;
 Wed, 14 Aug 2024 03:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 PODMain02222019; bh=jGxS2QDYR7dRjDufJBqbg+fegf704lBzccFIu6GKoZo=; b=
 o8XXAN1uO2LuSthkRC8Ai/oC5WHDR859pays++IvwJ7O1v7UfrIgwnmQvXFUOI9U
 IfjO/aAs2NqKJGOnxtNHNwW1CPaV50rb2SCr5zfpS2rCkbLR5gH4DuTvWbDp7/1u
 lTH5Pb9AiEYoxFBRZbhmK2iUfdzJ/BgZ8QHwWDD2N0jhrxPjCDddYrJiYw+FKeW7
 BFY8OTqhYyF5cYGieIU6s6TNM9lIJVomWtM87JTcCquUAkpA/152uy+aWPZ2r5l/
 6Q9xucttT8UHUIufTlmh3PlHZWo2TqUNfC1vUHM4jjjWGismccOtHPt5kF5Gj7dK
 uT0VenkQ1ISMRI4ZWT5o3A==
Received: from ausex01.ad.cirrus.com ([141.131.3.19])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 40x5kwma9q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Aug 2024 03:38:51 -0500 (CDT)
Received: from ausex01.ad.cirrus.com (141.131.37.95) by ausex01.ad.cirrus.com
 (141.131.37.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 14 Aug
 2024 03:38:50 -0500
Received: from EDIN7BQBTG3.ad.cirrus.com (141.131.38.212) by
 anon-ausex01.ad.cirrus.com (141.131.37.95) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 14 Aug 2024 03:38:48 -0500
From: Ian Brockbank <Ian.Brockbank@cirrus.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
CC: Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ian Brockbank
 <ian.brockbank@cirrus.com>
Subject: [PATCH 00/11] RISC-V: support CLIC v0.9 specification
Date: Wed, 14 Aug 2024 09:27:24 +0100
Message-ID: <20240814083836.12256-1-Ian.Brockbank@cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <https://lists.gnu.org/archive/html/qemu-riscv/2024-08/msg00234.html>
References: <https://lists.gnu.org/archive/html/qemu-riscv/2024-08/msg00234.html>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _FS76DKaGybX0TlWv4mg4IRSDTNSBypW
X-Proofpoint-GUID: _FS76DKaGybX0TlWv4mg4IRSDTNSBypW
X-Proofpoint-Spam-Reason: orgsafe
Received-SPF: pass client-ip=67.231.149.25;
 envelope-from=prvs=5956f96c7e=ian.brockbank@cirrus.com;
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

[Resending to include qemu-devel and add numbers to the patches]

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

