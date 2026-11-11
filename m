Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB53606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 20:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=E8oZ0Lvl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xREdl-0007Y8-P2; Wed, 11 Nov 2026 15:09:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <domestos48@mail.ru>)
 id 1xREdh-0007SZ-Hi; Wed, 11 Nov 2026 15:09:49 -0500
Received: from send59.i.mail.ru ([89.221.237.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <domestos48@mail.ru>)
 id 1xREde-0004BW-Pg; Wed, 11 Nov 2026 15:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
 X-Cloud-Ids:Disposition-Notification-To;
 bh=bAhaok2IvcaI6qMiqPLbckA7SWnmOc5Jdp4FI9ev6Eg=; t=1794427783; x=1794517783; 
 b=E8oZ0Lvl7CVkHPXDWxiMSeUBOumT/B3RQgxk56qqOlweO9K9hKe8kYhuIX0TJsYDU7xuLXJ6iKw
 OBoLNCwiQcGWsMTkQF9SAVMJmPJCx3+5JInlPYqNe5L7DgTvYQpDhWYkQfC61sEjzyKrMN+rSjtM+
 L5xE915koQFht+UK+oe4RlhrzRt81xXfkL+s6YR6giu7Ue9C+/AJC8z/At4aazpYoJxym7dS9QI7a
 HG6m4Q9kceB4Uzr52K9G6YnMG7Ao2dKTrU9rPdaI7YK7HEuQMJxcEFTjFT3P1aOrpRlUnk4y4uohK
 23rBzRYC2aLJK6i4noZhfKympN6AhMi6LliA==;
Received: by exim-smtp-bccb94844-l2l5r with esmtpa (envelope-from
 <domestos48@mail.ru>)
 id 1xREdY-00000000PnG-0Qgs; Wed, 11 Nov 2026 23:09:40 +0300
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, chao.liu@processmission.com,
 daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com, palmer@dabbelt.com,
 qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 Dmitry Kokorev <domestos48@mail.ru>
Subject: [PATCH v2] target/riscv: fix WPRI handling in mhpmevent CSRs
Date: Wed, 11 Nov 2026 23:09:24 +0300
Message-ID: <20261111200924.49157-1-domestos48@mail.ru>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: exim-smtp-bccb94844-l2l5r;
 auth=pass smtp.auth=domestos48@mail.ru
 smtp.mailfrom=domestos48@mail.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD911FEDD3DADD298F8D9016E3DF913DB54E7039521800A2FC7182A05F5380850404C228DA9ACA6FE27DAF213F382F0D4FE3DE06ABAFEAF6705C7212CC5DEE6306786DF833C7CA5CCB6CF9BE0995F4686B4
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE70A10A23A3B64B805EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375661F398E59D6539FAA69592133060DEFFB1C20630F9F825D10A871A72FA2F6FBE58EEF46B7454FC60B9742502CCDD46D0D062BEEFFB5F8EA3EF6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C0ECC8AC47CD0EDEFF8941B15DA834481F9449624AB7ADAF37BA3038C0950A5D36D5E8D9A59859A8B6928DFCED7E1CF6F776E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7CDA0371536F40842743847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A57FA3F1CF9DDCA9F05002B1117B3ED69609E7D6ECAC89C5BAB91D2EB2DEE3878C3610D81D389A125CDE35189EBF2DEA281E618B5D5F965AFDA0C8A6D533FBB40DB2D1C9E48B6DC60AE2A7E19323554B122E763F503762DF50E7D66AA7A502BB9D4EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659955332C0FDAEC8FE75F3879A0D25AF3CD0E41112BD7D5A425F2741F103C4AB42075B499E40714703B8341EE9D5BE9A0A40094872DB924F0ED331799F98ACD31585E08CE8BF386A83546A885F7A58241B4C41F94D744909CEF1DAEBD50C2D18C54FDD1B49881939BFC3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4ZrlAo0bq3TDyw5v+G6YiroYwwGdQdJ4Nqu0=
X-Mailru-Sender: EFA0F3A8419EF216CD76C1B74664C258659133B4062BC0723DE06ABAFEAF6705C7212CC5DEE63067DDAC019A3742A8B624B5DB0AABE7183291296853BA92DB575DE55D1386FB234BE5A15ED4F09F547D75E7F0E51054F537BA1E8BD3BAFE721543BE086337E13D9AEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
Received-SPF: pass client-ip=89.221.237.154; envelope-from=domestos48@mail.ru;
 helo=send59.i.mail.ru
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
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_REPLYTO_END_DIGIT,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Writes to the mhpmevent CSRs can currently modify the
reserved WPRI bits 57:56. Fix this by ignoring writes to
these bits when writing to the mhpmevent CSRs through both
direct and indirect CSR access paths.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4722
Suggested-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Dmitry Kokorev <domestos48@mail.ru>

---
v2:
- Drop explicit preservation of mhpmevent WPRI bits.

 target/riscv/cpu_bits.h | 2 ++
 target/riscv/tcg/csr.c  | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 3579789a1f..3df9ea4ec3 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -1161,6 +1161,8 @@ typedef enum CTRType {
 #define MHPMEVENTH_BIT_VSINH               BIT(27)
 #define MHPMEVENT_BIT_VUINH                BIT_ULL(58)
 #define MHPMEVENTH_BIT_VUINH               BIT(26)
+#define MHPMEVENT_WPRI                     (BIT_ULL(57) | BIT_ULL(56))
+#define MHPMEVENTH_WPRI                    (BIT(25) | BIT(24))
 
 #define MHPMEVENT_FILTER_MASK              (MHPMEVENT_BIT_MINH  | \
                                             MHPMEVENT_BIT_SINH  | \
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index af444e3e6f..94a57a4553 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -1230,13 +1230,15 @@ static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
     if (riscv_cpu_mxl(env) == MXL_RV32) {
         mhpmevt_val = deposit64(env->mhpmevent_val[evt_index], 0, 32, val);
     } else {
-        inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MHPMEVENT_BIT_MINH;
+        inh_avail_mask = (~MHPMEVENT_FILTER_MASK | MHPMEVENT_BIT_MINH) &
+                         ~MHPMEVENT_WPRI;
         inh_avail_mask |= riscv_has_ext(env, RVU) ? MHPMEVENT_BIT_UINH : 0;
         inh_avail_mask |= riscv_has_ext(env, RVS) ? MHPMEVENT_BIT_SINH : 0;
         inh_avail_mask |= (riscv_has_ext(env, RVH) &&
                            riscv_has_ext(env, RVU)) ? MHPMEVENT_BIT_VUINH : 0;
         inh_avail_mask |= (riscv_has_ext(env, RVH) &&
                            riscv_has_ext(env, RVS)) ? MHPMEVENT_BIT_VSINH : 0;
+
         mhpmevt_val = val & inh_avail_mask;
     }
 
@@ -1263,6 +1265,7 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
     target_ulong inh_avail_mask = (target_ulong)(~MHPMEVENTH_FILTER_MASK |
                                                   MHPMEVENTH_BIT_MINH);
 
+    inh_avail_mask &= ~MHPMEVENTH_WPRI;
     inh_avail_mask |= riscv_has_ext(env, RVU) ? MHPMEVENTH_BIT_UINH : 0;
     inh_avail_mask |= riscv_has_ext(env, RVS) ? MHPMEVENTH_BIT_SINH : 0;
     inh_avail_mask |= (riscv_has_ext(env, RVH) &&
@@ -1531,7 +1534,7 @@ static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
             *val &= ~MHPMEVENT_BIT_MINH;
         }
     } else if (wr_mask) {
-        wr_mask &= ~MHPMEVENT_BIT_MINH;
+        wr_mask &= ~(MHPMEVENT_BIT_MINH | MHPMEVENT_WPRI);
         /* wr_mask is 64-bit so upper 32 bits of mhpmevt_val are retained */
         mhpmevt_val = (new_val & wr_mask) | (mhpmevt_val & ~wr_mask);
         env->mhpmevent_val[evt_index] = mhpmevt_val;
@@ -1560,7 +1563,7 @@ static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
             *val &= ~MHPMEVENTH_BIT_MINH;
         }
     } else if (wr_mask) {
-        wr_mask &= ~MHPMEVENTH_BIT_MINH;
+        wr_mask &= ~(MHPMEVENTH_BIT_MINH | MHPMEVENTH_WPRI);
         mhpmevth_val = (new_val & wr_mask) | (mhpmevth_val & ~wr_mask);
         mhpmevt_val = deposit64(mhpmevt_val, 32, 32, mhpmevth_val);
         env->mhpmevent_val[evt_index] = mhpmevt_val;
-- 
2.56.0


