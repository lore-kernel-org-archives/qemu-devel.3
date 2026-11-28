Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B65606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Nov 2026 03:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nongnu.org header.i=@nongnu.org header.a=rsa-sha256 header.s=lists1p-gnu-org header.b=sbWH3bXT;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=GJzjvb6j
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nongnu.org;
	 s=lists1p-gnu-org; h=From:MIME-Version:Date:Subject:To:in-reply-to:
	references; bh=snVkRC7FGBUTuEY5Mui1J4ST/UNJSaw7xlfAgqYsX40=; b=sbWH3bXTdeVN1L
	LpoUqdQ8oBgLLU/4iFodAtiNRbxpV5KsFgIxfqKRfF8ti/QT8iEHQN+Fg73LGKEf5VuqXRxL+yHKA
	q9uo5aSB6WUxY1kKaBOif6x/m0qjnHhfK8wtOYe2F+BNOn5lqNaPJIWRZIYO4P4ClGsVjUfEbbOU0
	CuuthFAznvVMMWaen8dE/hsyRihJk3ipBhmebp0XaucC4QDaYv70m9eGAgrreNYnYJfmUKFVn2Ey0
	XHujHNhxAvbmBz91J+qBCOIwgPJjcJyosAtSbLMnBqxMWLbyuEp8Fk5rVV+tDtN3Bcjab6861pjKQ
	0FFMcrPN/5h1kV/yBgGA==;
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX9Dg-0000Ua-PL; Fri, 27 Nov 2026 22:35:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <domestos48@mail.ru>)
 id 1xX9DY-0000Tl-Nf; Fri, 27 Nov 2026 22:35:16 -0500
Received: from send105.i.mail.ru ([89.221.237.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <domestos48@mail.ru>)
 id 1xX9DU-0006oJ-Pu; Fri, 27 Nov 2026 22:35:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
 X-Cloud-Ids:Disposition-Notification-To;
 bh=snVkRC7FGBUTuEY5Mui1J4ST/UNJSaw7xlfAgqYsX40=; t=1795836901; x=1795926901; 
 b=GJzjvb6jfgsKE4Aw2VcEzs3aQsHSV/sYevuI0rdM2McZe4hYqlCQEeYXPCXr829jfb22CLGkj3C
 9zN4ur6dTjey2GGldi0qRyaz6FXSwqSYIaBkKkBaAWYcXZlpBo0LkeMNaCds7mExWXUWXFjGlq5kc
 RsCuWbHxmFzlsy3Y1XlSjq+KQ2IBqT+Wn2lFyf3y0wXBDjnhWlBY1lzDbOvyiVDnAZOkVfHcm49Wx
 1XVo5IH5r7tlNQgQOZodSoANTVMyGKFS8dI/NqyERQ9App/+c0QCCJvThP8ejeQwU0EndgnTkJ9+O
 8mh1lc/sDk+sq8HI7wDvwLdIBK6XKAL5rbIA==;
Received: by exim-smtp-558c69478d-gsxhs with esmtpa (envelope-from
 <domestos48@mail.ru>)
 id 1xX9DE-00000000AiT-3MFF; Sat, 28 Nov 2026 06:34:57 +0300
To: qemu-devel@nongnu.org
Cc: Dmitry Kokorev <domestos48@mail.ru>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH] target/riscv: fix exception handling for SIREG2-SIREG6
 accesses
Date: Sat, 28 Nov 2026 06:34:49 +0300
Message-ID: <20261128033449.122558-1-domestos48@mail.ru>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: exim-smtp-558c69478d-gsxhs;
 auth=pass smtp.auth=domestos48@mail.ru
 smtp.mailfrom=domestos48@mail.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9D70A5F1A44F40AC4984B02CC9DA0F8A0E2091737D616347F182A05F5380850408813C615274586453DE06ABAFEAF67059B41569FDD7B9B2AF23C9E2EA10BA734CF784B0C616BB7A4
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7AB524098FB2F2222EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375669F88000598BFA233F3106732FE27E3C8CD7AA220AB29594285D434980775D20F8EEF46B7454FC60B9742502CCDD46D0DBC0ADEB1C81BB362F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C068077CCD40B79AC98941B15DA834481F9449624AB7ADAF37BA3038C0950A5D36D5E8D9A59859A8B6470100DFE4501EF176E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7CBB2DCFE07A54726643847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A51DBE43BF87D51A1D5002B1117B3ED6964AF51DA3DD1D2E29ED71F038FC046993823CB91A9FED034534781492E4B8EEAD6804EF05EF4ADF2AF36E2E0160E5C55395B8A2A0B6518DF68C46860778A80D548E8926FB43031F38
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D65947646164FA1D80966B7662C0921B38C8FC40FF592C81304702711AC6647B96EC237095AB72748AEFB8341EE9D5BE9A0A2AAB519CF3ED7183BFD2B1E50FD673B6DF55745A629EFB84546A885F7A58241B4C41F94D744909CEF1DAEBD50C2D18C54FDD1B49881939BFC3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4ZrlAo0bq3TDyw5v+G6YiroYwFKm+EqDLIKE=
X-Mailru-Sender: 6C3E74F07C41AE94D7CD221249107760BE279CFC5F046260249E1E589EC000561B70824BD67EA12241981BF91713E4B73BC2F568E0EB198D43A928ADF1FB8230B15D5A005FF75DDCF5AEC393025268E4D4F5E195AEB7941D607123C7294C0AD7D392818AC9EB1D6DC77752E0C033A69E3453F38A29522196
X-Mras: Ok
Received-SPF: pass client-ip=89.221.237.200; envelope-from=domestos48@mail.ru;
 helo=send105.i.mail.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Dmitry Kokorev <domestos48@mail.ru>
From:  Dmitry Kokorev via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_REPLYTO_END_DIGIT,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix the `virt` flag in rmw_xireg_csrind() to use a range
check covering VSIREG2 through VSIREG6. Avoid the early
return for AIA isel ranges so that they are handled by the
virtual instruction exception check.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/5008
Signed-off-by: Dmitry Kokorev <domestos48@mail.ru>
---
 target/riscv/tcg/csr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index af444e3e6f..a7a914627e 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -2918,14 +2918,15 @@ static int rmw_xireg_csrind(CPURISCVState *env, int csrno,
                               uint16_t isel, target_ulong *val,
                               target_ulong new_val, target_ulong wr_mask)
 {
-    bool virt = csrno == CSR_VSIREG ? true : false;
+    bool virt = CSR_VSIREG <= csrno && csrno <= CSR_VSIREG6 &&
+                csrno != CSR_VSIREG4 - 1;
     int ret = -EINVAL;
 
     if (xiselect_cd_range(isel)) {
         ret = rmw_xireg_cd(env, csrno, isel, val, new_val, wr_mask);
     } else if (xiselect_ctr_range(csrno, isel)) {
         ret = rmw_xireg_ctr(env, csrno, isel, val, new_val, wr_mask);
-    } else {
+    } else if (!xiselect_aia_range(isel)) {
         /*
          * As per the specification, access to unimplented region is undefined
          * but recommendation is to raise illegal instruction exception.
-- 
2.56.1


