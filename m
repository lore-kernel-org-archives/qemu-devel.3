Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B01C79F80
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DEs-0001WQ-9E; Thu, 03 Sep 2026 15:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DEq-0001VI-Lo
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:44 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DEm-0004FU-I3
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:44 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so231632a91.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788464199; x=1789068999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QiMoKtfrtM+3TWwYQneleIhe2dU3Jpv/t9kAYcs0lKo=;
 b=eTHXSzqkCguI72XKr6AEdjoUF6IdI5WjK6d0cbDySCuXbqlf4vwgryPrdNgBpVF2+X
 qc4k5mTLBs9K51kF18XS01z5dAS6U7B3cgqHtO4O+hwGreEKpP2tZWGVmm6EOGI1q7Tw
 phOnaC9VD6/dGshxXiwpy8O72Vkm7SncANs3B9oBaAPrh9GKMc1iD+3tvA6JRdjtOjQE
 /bkW5z0L0tYdOluBqFmlvql0w3BwPbSVDjC0C29EiMs2EQjLH6s2lFWOaYsY6RhJvZ5E
 Cz2xDfMFFEiLCbFXPEMqZFxWXC+cxySoCjVKFSBg5eki7zY7WKU4ctnWpot7tDXP8Uzl
 E8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464199; x=1789068999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QiMoKtfrtM+3TWwYQneleIhe2dU3Jpv/t9kAYcs0lKo=;
 b=kFACHa6SCF9IvZqsFcg7QMuUyZiTpoTmb//C2XzRr2gg5vMwPEc78oxDjZiWiK6c8C
 IoJ0IEf8f2aqx67iZcOpgEPx+jC6s5tpKjDMZsg+59iAVglAblx2/EPW3eTf3kxQOvQw
 ZP+berLwIFoI6HiVLwbxFnNqkdomSWv6vVCbJjTugoHRA/uf5n4QgqsyzrKodevfiYfM
 EY5WznMhvHc4YWy9l1RKZM46h5+nXSblxYMU0+u4MwoNFUk8o6Tc2REQFVGzTmZk/AvF
 5Hwlb7IYo2KDciq18RoHihzhPVLFcV2uZTwEeg8YcCHbxxP/8P0HpLuG1ZC4+1SbKMZN
 dvzw==
X-Gm-Message-State: AFuF++l7V9eFRxw79ZNGsmdYGAhtlx0p8LVwYhQexioiG7dkDa+vals8
 38obODIm0hOpYW4495Rs6R76rwbDKKBfAz8+IoACKX0dGUwW28Jrvnd6ubXbpRl9+Pw=
X-Gm-Gg: AYBFou1QS9EpZ7dUYyKTaQyGiMZRG1XmPfvuJKKUS49FfxigdR3fzn03bb1ewhQhPdd
 LnYBIlZHKiV8PQR1vCTVs57EOgRFvzOH2Avntwh/+rh+zVk/HqbhmPJisETV51JIc6iq/hBJ7uE
 AsdTutWIkY52SUOywNXzVkFQq4WYlhjpkDaXQ+yDco9Cn9tuYWjI3r+o3DTYRydWSoDQGrBIv1y
 NRaZG7oi+XbZWZPCaiqxg/jODI9u+j4hNnb2gdl2DdWXMJFnULTaPw4bSMpPqNmj0e8lPjpetkq
 9GJLfEeq1/eNzzMhXFrBe9ydn6mAfqtoq4ZLX0vRGQvYTsIDka4ypEk7sxCjUpQALfKiw72gEGb
 xTNk8Szmi2Ydg+uBerbpJJdSsv2y+or8nq8EzUqeB6/q5VyXwm2ByxfSPFaPNBlSNzu2Wdg7UFn
 4BEo2sxJiQEpQTkTaX2Ivkp+7k3tksZO5a2L2E0A2A8ecFKvZSUTy9r4nbXCn6B1sX+1eDqqFz6
 Izp0NdkYYWcrj0=
X-Received: by 2002:a17:90b:28ce:b0:38d:fda6:4873 with SMTP id
 98e67ed59e1d1-39b26100cbfmr1254551a91.10.1788464198938; 
 Thu, 03 Sep 2026 12:36:38 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 12:36:38 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v4 14/24] target/arm/cpu: Don't read Realm registers
Date: Thu,  3 Sep 2026 13:36:01 -0600
Message-ID: <20260903193611.1058589-15-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x1036.google.com
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The host cannot access registers of a Realm. Instead of showing all
registers as zero in "info registers", display a message about this
restriction.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 77aa78f00e2f..51c2527d840d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -965,6 +965,11 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     const char *ns_status;
     bool sve;
 
+    if (cpu->kvm_rme) {
+        qemu_fprintf(f, "the CPU registers are confidential to the realm\n");
+        return;
+    }
+
     qemu_fprintf(f, " PC=%016" PRIx64 " ", env->pc);
     for (i = 0; i < 32; i++) {
         if (i == 31) {
-- 
2.43.0


