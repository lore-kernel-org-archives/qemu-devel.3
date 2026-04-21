Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D050F327CD
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 09:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF7Y1-00006f-ST; Tue, 21 Apr 2026 05:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF7Xs-0008W0-32
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 05:37:28 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF7Xq-0007qY-Kx
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 05:37:27 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-824c9da9928so1939526b3a.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 02:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776764245; x=1777369045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YE9BDIqY+24bLK0kZ7UcvW9+EgeTMrYBvGuCfwOpwsw=;
 b=GaiJafvFGp5bpXeoKQEqQMWneo45MD5WEQbVcn2lsOmtTOWv2huKaF/BWqwg7eDzTt
 W7gFqDasPgpPNfgh9EvE/oCoBe3pFVhpLRkpfEbdM9+KfBrVemPAaeLto9wPyhu9il0q
 6LfWk73Z090A4vSYU55kv8Dpy18Uxza3ETGIPidKauRdnVdEn/TUbs+sJpCtj4lrpigB
 5t/O0Vo/coZG2w+GV4Ja6/Es5chUbi77eAZd6FSZFO0iSd81KDBt6ZEbKWC7f8e8+GSP
 wIYd3LUFZsO/wWK+2sL8LjCzG+QH3H7moW+2t+G6tUaAtl78MiAf8Jb7/qEEIQkGBsDd
 XFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776764245; x=1777369045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YE9BDIqY+24bLK0kZ7UcvW9+EgeTMrYBvGuCfwOpwsw=;
 b=Xb5isFzgcC9iclT+cFJCC9fCchLW2kojL5apUf2ByalYbptlWofmRshn/OsvlwgHLm
 AnGQhqdaOau28J+AVYS5ssqONwFL+Bye7+KzRq3ZI+4T7x+UI44041GpSXhkCBzDXJWB
 SGT9WcoVBre9WDDn7vTa/B6SctFmwMj67dGkINSQZoIxrJ4aoqJ+zXmXmsnkij2Qo/av
 mTNnoupcahyzvjNsmT046rCzluQpVV/4A/DTwyoej4dvUttA7NfzQzdh4PDRq+n3YTYR
 3o4MZkehnVWkdgfuM9h32ePptO3z06faPEhWWxaPDsEUSDd++PoEB/2peEnVL6ou4LNV
 Lhig==
X-Gm-Message-State: AOJu0YwzvKr0Dk0hUoe/t3+SE/X1HnDWmqmo91/HBKwr8ohbv4aOgh6d
 zxSKSmQt9ycv06p8U4trqhMDsSRn+ILAmtH+lJyV5ztJ9xcQBivfputI1gtqkK5xdd3865lqqz/
 DvcaMfapvTFqMmgHi0oI1bKw7ZpxETN6hq/HiBPzfvJnJZ/xuo+nIY8itO07B0vOSbgZgyfPDJa
 s7weBPxH1dPCSqs95fcOxIqOzzdkto+ZlcmU9KngnLc9rd258B
X-Gm-Gg: AeBDietFGLlBvpYLrDZ3wSCMJtnaX0gOAJ0pP6k2SsELR53w082J6ZGboIGSM8DqGhT
 wahB14UagjcLnFiqPnusi2IcE5UFc/1kO/v2f4UOqVRj2iQaAHaRAk2R7YqFJeQVBhhGZqwBHVN
 rn6F7/dk+JlLmgzpXEHt14wTwxj9Wx/lFYn+PBy/2Lccrq2QQJIgks4ONzQ+WO01CZI0yWPQ7VE
 q0cH1PLoSc4mp6KFQMhoUyt7LsKiEEaZPoFP3dVMfNdmEDtngSbSFeoyofgtK9GQ8zw2KYnnaQN
 /XCf1+oEopZvgvUheA3s6+GJKGT6QAAQTMFPxhlhavGszTIpGKF+hPmyM6ce3DWEjul69Mn8fDP
 cH1jYLQtmYrNjI5UiRkQdjukuHo+nJcToUcPIDqyFRvNpkN0um1FNwJNyZ8YV0zSjYHNmliwuyj
 nCq/mG24+RxlEjdupdhS4H9IPxXEoAX+uEjwjptgs3KsCb9J8Z4yWxsiKEfv4I
X-Received: by 2002:a05:6a00:2288:b0:82c:e76b:c68c with SMTP id
 d2e1a72fcca58-82f8c3f2b00mr17734196b3a.0.1776764244656; 
 Tue, 21 Apr 2026 02:37:24 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e981be6sm15904589b3a.9.2026.04.21.02.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 02:37:24 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 1/6] target/riscv: fix address masking
Date: Tue, 21 Apr 2026 17:37:10 +0800
Message-ID: <20260421093715.2995067-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421093715.2995067-1-frank.chang@sifive.com>
References: <20260421093715.2995067-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Yong-Xuan Wang <yongxuan.wang@sifive.com>

The pmlen should get the corresponding value before shifting address.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/internals.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index b001cbc080a..43b77d30f27 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -216,8 +216,8 @@ static inline target_ulong adjust_addr_body(CPURISCVState *env,
     if (!is_virt_addr) {
         signext = riscv_cpu_virt_mem_enabled(env);
     }
-    addr = addr << pmlen;
     pmlen = riscv_pm_get_pmlen(pmm);
+    addr = addr << pmlen;
 
     /* sign/zero extend masked address by N-1 bit */
     if (signext) {
-- 
2.43.0


