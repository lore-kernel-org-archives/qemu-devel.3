Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B101D68B33
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcIj-0005L9-9a; Thu, 14 Nov 2024 11:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcI3-0004z5-Jz
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:51 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcI0-0002Db-GQ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:50 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-720aa3dbda5so600546b3a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600104; x=1732204904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CIfCBBS4NOF8aU4fkbSKUFc82IUgInZTkka8x32P+O8=;
 b=MxhnKw7Ycsd2Lz1o4fV3Te2gTmgA35JPkuYio81N7DSRFGZA8Nc6Xa9vzhqEg56Qw+
 AM29PKMX+SwzPEwpUmahkZJxkmj2vhikmn+iQWVMm1T5s800EmwyziOhe2dV91hLZakc
 TNNxpOBDFmIp7UOOnakYkp6VJ40zXnfmDnCa2gdE8iXi/qR2nL0a3hfHG1Udw6gTlj1c
 VcpPvhzhQ2/wb+1cqUOV/uLfV1vt0+fRO8SAA2Qxpbh3cIXY5RSglEF8z04C5jAczGrr
 z/lV9BPwRNnZiYIDySJm72u23eeUBGIr1zChtRc7FNQgVXnk/XIPaiK+Ydx+26+yc59p
 FbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600104; x=1732204904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CIfCBBS4NOF8aU4fkbSKUFc82IUgInZTkka8x32P+O8=;
 b=KK8kQ536REW9N1hJ/CLqPIPtJynknqaCk5b+yHEj/+uNO/Ucr2QWFmVWYaCgzH8WJv
 5m+kXJx/3tzLm9uLYc8uoVXgyAn5bEUeCIp/edVsxiYUaZenWmogvMp7lPZ1Mmgwv4qI
 kII2MowWvKbxXZrY/pylHV/JdwJyzqjbbN2SFuMxFx5jS+P27FE2aKdpM8XUhcM2tzLf
 7gYeewU2WC0JHDUBDXjyasJd/48QEFJpdkmwoCJscMzQNp0Ncuxb89h1aqV3xGErORHh
 f6dPf1aHaDlPMcgLIefzW7Ro0YhYcCrm0F0/Gi2Z+ntkEsGygE5740N9w0gRzPxEC7Og
 MWcw==
X-Gm-Message-State: AOJu0YycVlgtXQIhBZLOJWo4PBOXdMzKI2RHdvcIEV9vOIjMQH7auRVH
 2ZkOWwpysnmCgsqUznBgGlAa9ZWc8YSp1cu8z67TN5UJBG+mfyOnJtrIDhzxtaQ7yEIps/I40YQ
 +
X-Google-Smtp-Source: AGHT+IFXgtuzAj+FLsRJNB5OYDKwFBpVXFWVzv6tNsTZOkil1C20oQhAsdnc9rvUvjaNpibRI0+eIg==
X-Received: by 2002:a17:90b:2643:b0:2e9:20d8:4140 with SMTP id
 98e67ed59e1d1-2e9e4c73ae4mr12373356a91.26.1731600103692; 
 Thu, 14 Nov 2024 08:01:43 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/54] accel/tcg: Use tlb_hit_page in victim_tlb_hit
Date: Thu, 14 Nov 2024 08:00:51 -0800
Message-ID: <20241114160131.48616-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

This is clearer than directly comparing the
page address and the comparator.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index eb85e96ee2..7ecd327297 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1394,9 +1394,8 @@ static bool victim_tlb_hit(CPUState *cpu, size_t mmu_idx, size_t index,
     assert_cpu_is_self(cpu);
     for (vidx = 0; vidx < CPU_VTLB_SIZE; ++vidx) {
         CPUTLBEntry *vtlb = &cpu->neg.tlb.d[mmu_idx].vtable[vidx];
-        uint64_t cmp = tlb_read_idx(vtlb, access_type);
 
-        if (cmp == page) {
+        if (tlb_hit_page(tlb_read_idx(vtlb, access_type), page)) {
             /* Found entry in victim tlb, swap tlb and iotlb.  */
             CPUTLBEntry tmptlb, *tlb = &cpu->neg.tlb.f[mmu_idx].table[index];
 
-- 
2.43.0


