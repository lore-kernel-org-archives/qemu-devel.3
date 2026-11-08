Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B802606A320
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 22:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=r/82RYxl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQAyY-0004Q9-S0; Sun, 08 Nov 2026 17:02:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <domestos48@mail.ru>)
 id 1xQAyW-0004PS-6t; Sun, 08 Nov 2026 17:02:56 -0500
Received: from send80.i.mail.ru ([89.221.237.175])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <domestos48@mail.ru>)
 id 1xQAyT-0000Wk-RQ; Sun, 08 Nov 2026 17:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
 X-Cloud-Ids:Disposition-Notification-To;
 bh=YtqfMQ4xXlT0ssdGa6lMwiMjefdmK5ZhNmt4aTovu40=; t=1794175370; x=1794265370; 
 b=r/82RYxli05tUqWf1/L5SJ4nVbgtpo5QzIR10nRVE+tZw3j9m9rz9gJIFoHdPAgvXrqiDYl/HLf
 aiHq211oTDXBmAeWWWNnAa5WNh5Q4yCuDlEeQMKI9kld0U36KRItIWQf/FMo0PD3zhxGumoyTVrOd
 vbbWnWEt1t4TSmbH8plC5s1x8P7zWJ68msU5ynrdaqH5bWPVOP4JV3CDUSGB/TerI3rmPaY5uXy0v
 EEzTbq8Wgd0jD2of/juEPeg9Bkx/16iyYkyjx8qYTDqXNwvzbzigBQuiqBtFis0ksessE8/HENyeA
 weaysEB+aIyKskWvGrJeooS221nrjOWxJl0Q==;
Received: by exim-smtp-canary-30-75cf684ff8-c6nln with esmtpa (envelope-from
 <domestos48@mail.ru>)
 id 1xQAyM-00000000DGT-0NGS; Mon, 09 Nov 2026 01:02:46 +0300
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Dmitry Kokorev <domestos48@mail.ru>
Subject: [PATCH] target/riscv: fix WPRI handling in mhpmevent CSRs
Date: Mon,  9 Nov 2026 01:02:32 +0300
Message-ID: <20261108220232.385393-1-domestos48@mail.ru>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: exim-smtp-canary-30-75cf684ff8-c6nln;
 auth=pass smtp.auth=domestos48@mail.ru
 smtp.mailfrom=domestos48@mail.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD96F2D5E088614A2372B8D188DC4D6F5CA3B42AFF3D8AD6CEA182A05F538085040437C97CF8D67A9D13DE06ABAFEAF67050767ED2490B9B8C2144EB2C858EDA7616EF1D6B1658FE618
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7F1942E6D70B4A2F0EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375669BFFA6ABF9D5DBB9E5818E3A3EE3E29BA75488E6AFFB844FC2924EEFEFADD3928EEF46B7454FC60B9742502CCDD46D0DEDCF5861DED71B2F389733CBF5DBD5E9D5E8D9A59859A8B65FF0BFC5AEE34BE6CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8090A508E0FED6299176DF2183F8FC7C0D62E3522C432C21CCD04E86FAF290E2DB606B96278B59C421DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6714D3C157B7FF6D575ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A58CD48C85B2EC895D5002B1117B3ED6961362BA0DE0B754191E49B01306B5E3AD823CB91A9FED034534781492E4B8EEAD87AC71952E7BCFF3F36E2E0160E5C55395B8A2A0B6518DF68C46860778A80D548E8926FB43031F38
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659C6C05B8361B7F355C3C46D585AE6B4D64199B9454E62A0522AC21F8AD3170CE321CC070B99DBCCA0B8341EE9D5BE9A0ADD1BC67E1A71A7E9D9D1B8B9A1ED52DBF4CEEB9844102CC9546A885F7A58241B4C41F94D744909CEF1DAEBD50C2D18C54FDD1B49881939BFC3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4ZrlAo0bq3TDyw5v+G6YiroYwPBqSlV6nYp0=
X-Mailru-Sender: EFA0F3A8419EF216CD76C1B74664C25897F5688144A3F8793DE06ABAFEAF67050767ED2490B9B8C2DDAC019A3742A8B624B5DB0AABE7183291296853BA92DB575DE55D1386FB234BE5A15ED4F09F547D75E7F0E51054F537BA1E8BD3BAFE721543BE086337E13D9AEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
Received-SPF: pass client-ip=89.221.237.175; envelope-from=domestos48@mail.ru;
 helo=send80.i.mail.ru
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_REPLYTO_END_DIGIT,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Writes to the mhpmevent CSRs can currently modify the
reserved WPRI bits 57:56. Fix this by retaining the
previous values of these bits when writing to the mhpmevent
CSRs through both direct and indirect CSR access paths.

Signed-off-by: Dmitry Kokorev <domestos48@mail.ru>
---
 target/riscv/cpu_bits.h |  2 ++
 target/riscv/tcg/csr.c  | 21 ++++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

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
index af444e3e6f..bc422c0014 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -1230,14 +1230,17 @@ static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
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
-        mhpmevt_val = val & inh_avail_mask;
+
+        mhpmevt_val = (val & inh_avail_mask) |
+                      (env->mhpmevent_val[evt_index] & MHPMEVENT_WPRI);
     }
 
     env->mhpmevent_val[evt_index] = mhpmevt_val;
@@ -1262,7 +1265,10 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
     int evt_index = csrno - CSR_MHPMEVENT3H + 3;
     target_ulong inh_avail_mask = (target_ulong)(~MHPMEVENTH_FILTER_MASK |
                                                   MHPMEVENTH_BIT_MINH);
+    target_ulong old_wpri_bits;
+    target_ulong new_high;
 
+    inh_avail_mask &= ~MHPMEVENTH_WPRI;
     inh_avail_mask |= riscv_has_ext(env, RVU) ? MHPMEVENTH_BIT_UINH : 0;
     inh_avail_mask |= riscv_has_ext(env, RVS) ? MHPMEVENTH_BIT_SINH : 0;
     inh_avail_mask |= (riscv_has_ext(env, RVH) &&
@@ -1270,8 +1276,13 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
     inh_avail_mask |= (riscv_has_ext(env, RVH) &&
                        riscv_has_ext(env, RVS)) ? MHPMEVENTH_BIT_VSINH : 0;
 
+    old_wpri_bits = extract64(env->mhpmevent_val[evt_index], 32, 32) &
+                    MHPMEVENTH_WPRI;
+
+    new_high = (val & inh_avail_mask) | old_wpri_bits;
+
     env->mhpmevent_val[evt_index] = deposit64(env->mhpmevent_val[evt_index],
-                                              32, 32, val & inh_avail_mask);
+                                              32, 32, new_high);
 
     riscv_pmu_update_event_map(env, env->mhpmevent_val[evt_index], evt_index);
 
@@ -1531,7 +1542,7 @@ static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
             *val &= ~MHPMEVENT_BIT_MINH;
         }
     } else if (wr_mask) {
-        wr_mask &= ~MHPMEVENT_BIT_MINH;
+        wr_mask &= ~(MHPMEVENT_BIT_MINH | MHPMEVENT_WPRI);
         /* wr_mask is 64-bit so upper 32 bits of mhpmevt_val are retained */
         mhpmevt_val = (new_val & wr_mask) | (mhpmevt_val & ~wr_mask);
         env->mhpmevent_val[evt_index] = mhpmevt_val;
@@ -1560,7 +1571,7 @@ static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
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


