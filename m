Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5ADC52D6F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 16:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg50m-0001Iq-Rz; Mon, 19 Aug 2024 12:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5961d01319=ian.brockbank@cirrus.com>)
 id 1sg50e-0000N1-Ns; Mon, 19 Aug 2024 12:13:33 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5961d01319=ian.brockbank@cirrus.com>)
 id 1sg50c-0007dY-St; Mon, 19 Aug 2024 12:13:32 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JF6kmj012798;
 Mon, 19 Aug 2024 11:11:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 PODMain02222019; bh=6kxBEvL1XX5A4t5MqUPj/4BY/7wipVF5zbUzogEKAoI=; b=
 RV2zk1nFyLD5A4AbvDKpeC0IO2n+PScMrYK3LzxwIIlDD95khmp7NXVIlwozB966
 nWZhnJcXItKZckcAZ8c5f+PyTs8rMXAqOrzi+xVhKrFE7+nPN/AS2I5PKMzhJDdK
 V1aRaoGhWFFUfmCSQ+kFmwtvOltvlWCwJ7EUbPB4PKW00eRgRTh3xR2WtBztSS8w
 YufyyNABosbCgXExarD0YB8u9wkPItetWlaq8zFA/UfvnZE6A5AaX9gP0t1EiQz/
 jYd3LuxECvIdcpRspIU4sW7Tv1j5nwW4AjLoZkH54EA+u1hRU1i65xwCMc3cUem4
 RNntNht9LcVDoIsIoz5VgQ==
Received: from ausex01.ad.cirrus.com ([141.131.3.19])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 412r9hsxb0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Aug 2024 11:11:23 -0500 (CDT)
Received: from ausex01.ad.cirrus.com (141.131.37.95) by ausex01.ad.cirrus.com
 (141.131.37.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 19 Aug
 2024 11:11:22 -0500
Received: from EDIN7BQBTG3.ad.cirrus.com (141.131.38.212) by
 anon-ausex01.ad.cirrus.com (141.131.37.95) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 19 Aug 2024 11:11:20 -0500
From: Ian Brockbank <Ian.Brockbank@cirrus.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
CC: Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ian Brockbank
 <ian.brockbank@cirrus.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Subject: [PATCH 05/11 v2] target/riscv: Update CSR xip in CLIC mode
Date: Mon, 19 Aug 2024 17:02:16 +0100
Message-ID: <20240819160742.27586-9-Ian.Brockbank@cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240819160742.27586-1-Ian.Brockbank@cirrus.com>
References: <https://lists.gnu.org/archive/html/qemu-riscv/2024-08/msg00234.html>
 <20240819160742.27586-1-Ian.Brockbank@cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-GUID: XvH52XeQnxR3M22WX1R8YTnj7J3ofbaC
X-Proofpoint-ORIG-GUID: XvH52XeQnxR3M22WX1R8YTnj7J3ofbaC
X-Proofpoint-Spam-Reason: orgsafe
Received-SPF: pass client-ip=67.231.152.168;
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

From: Ian Brockbank <ian.brockbank@cirrus.com>

The xip CSR appears hardwired to zero in CLIC mode, replaced by separate
memory-mapped interrupt pendings (clicintip[i]). Writes to xip will be
ignored and will not trap (i.e., no access faults).

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Signed-off-by: Ian Brockbank <ian.brockbank@cirrus.com>
---
 target/riscv/csr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index a5978e0929..276ef7856e 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2743,6 +2743,12 @@ static RISCVException rmw_mip(CPURISCVState *env, in=
t csrno,
     uint64_t rval;
     RISCVException ret;

+    /* The xip CSR appears hardwired to zero in CLIC mode. */
+    if (riscv_clic_is_clic_mode(env)) {
+        *ret_val =3D 0;
+        return RISCV_EXCP_NONE;
+    }
+
     ret =3D rmw_mip64(env, csrno, &rval, new_val, wr_mask);
     if (ret_val) {
         *ret_val =3D rval;
@@ -3294,6 +3300,12 @@ static RISCVException rmw_sip64(CPURISCVState *env, =
int csrno,
         }
         ret =3D rmw_vsip64(env, CSR_VSIP, ret_val, new_val, wr_mask);
     } else {
+        /* The xip CSR appears hardwired to zero in CLIC mode. */
+        if (riscv_clic_is_clic_mode(env)) {
+            *ret_val =3D 0;
+            return RISCV_EXCP_NONE;
+        }
+
         ret =3D rmw_mvip64(env, csrno, ret_val, new_val, wr_mask & mask);
     }

--
2.46.0.windows.1
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

