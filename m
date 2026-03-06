Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB674FCB605
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWem-0003zi-Vv; Fri, 06 Mar 2026 10:00:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWel-0003wk-Q8
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:59 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWek-0002Mf-8Y
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:59 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4837f27cf2dso87213725e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 06:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809197; x=1773413997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E1dcGaWKyR+5TgJfH7tF4p5apo7JtSGgCwG/8xW/MXk=;
 b=Py5veFxLB9IbgDAPYO5LHHASQHu/GwR1FiTjrBFQsqzI1+v1zyay58IC3oRyWf6jtp
 3xNYIA7G7Pu9q+X/It0y4S+emnOE0gkdJV4pChRwwUm6+SLb88b6YuLGXQHCbtKvbeDP
 bjQdPTB+NIbTn/FgYPsowJbdRXMJHKrrAM/zadWORDS3Z8ZkT5uL224bbPzjpkKM/N9X
 5LS+b3GdnvW5Npata0XDkHfyL0J1ALtVHbZSN+8YFtFQq0PCp7MWH1CB+ikrnF8Lwss5
 wFlVqhVDD94hvfmuEn6G2VquNkNpN2pz4w3f0qhI7S5sdVxi+XOmcMNYhybcxMxuZnqb
 /atA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809197; x=1773413997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=E1dcGaWKyR+5TgJfH7tF4p5apo7JtSGgCwG/8xW/MXk=;
 b=s0ifsCZESUK9JEvH0yibNRiCyvJTf1anjDk0FPN+Bb4icWmbI33AiAlvY0U7gjNJkC
 BGT65u/fdWa1gvdTZeE2uqBLdLMlGjiXIfUKxVSWagjzZ3VWSzbpBk6n3QMZzB/uf54W
 s3ojRVywZhoouJNUYZouIAoS82h4HeAnt3r2T/qyhUObCkhOAa3GgXPh0odz0pIldYP/
 7pT6NsAZQJnOVWw3Kk/NiqX3yBP8T35qyK3nTwGOOZ4npZVniWrdR4QA5N7No9c10tPN
 8RuzhP9MzhwPJOzRZOHr1rNSmHss92oESoOpSxm8cp35m7X2/4m3+EDOxv4URhmFvo9j
 SOnw==
X-Gm-Message-State: AOJu0YzXzKKqWNyfLbAR9vE4Q9P/glU1JlZEXucykyjg6KYFVkXWsyuB
 sKAcqR+Vz9kBRX51FlpgvL70QOi4QV5Bxjawc4nkYGuLv/bDMdmfjXl67J2f48aclwkinQqK71y
 Dl4Xt
X-Gm-Gg: ATEYQzwMSNKkKRPoS0DmoMaqvaR2q6pp+PTSxbbFDVUHC+MoEdd2Tq5z7oSCpuutfms
 ugvG72Q85m8W0ct27pfHrhn8MZjfT4sM1wsytL9d4uR0b1FDPc24ux14Pi/j0VhysUU79QX4KqK
 3/qlt1H/ES5e3W7HDpAmzAjnnV2BmM8lZKx3QJJLdNkejB3J9UK7dtZ3Zi2d15cu0ylbZtEDg/U
 WXC+rS5zeH48WUS8ZGVrpL+Dm5DxpR5/WUOfgVtimK9191tZ920HMG8hi1KszWeIgAIFsu7LSRM
 3+tS+rzT2XDBqCOwyle8tsNkzoAEIyBYB8buP2gxHMSnWCMVsaud3FVHN7k3anVnAkY2+eNYg7h
 1iuE3lY61MsB06FxHgPryVRfbFlyQ5pFSOfJWH7Y7R+RxP8XLMya/ENBFpVo95kKA3x8pH0+2Nz
 hR6dGSjSi/I5h2cWiL9OgI/q5I8Ookwg5ORIh/3ca0k1iQguLZwBk7G1Ax8l7HuDCpUqNt9R8qQ
 OcWGirG+2X+nZ+xnv9xhAVh6rU89lo=
X-Received: by 2002:a05:600c:c16d:b0:480:39ad:3b7c with SMTP id
 5b1f17b1804b1-485269582fbmr44110205e9.16.1772809196701; 
 Fri, 06 Mar 2026 06:59:56 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.06.59.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 06:59:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/49] target/arm/kvm: Tweak print_register_name() for arm64
 system register
Date: Fri,  6 Mar 2026 14:59:07 +0000
Message-ID: <20260306145939.2162189-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Eric Auger <eric.auger@redhat.com>

As opposed to other register types, arm64 system register decoding
is not introduced by any 'register' mention which can lead to
unfriendly user-facing traces.  Let's add "system register"

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260304101625.1962633-5-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 11f6f2dff0..d4a68874b8 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -978,7 +978,7 @@ char *kvm_print_register_name(uint64_t regidx)
         case KVM_REG_ARM_DEMUX:
             return g_strdup_printf("demuxed reg %"PRIx64, regidx);
         case KVM_REG_ARM64_SYSREG:
-            return g_strdup_printf("op0:%d op1:%d crn:%d crm:%d op2:%d",
+            return g_strdup_printf("system register op0:%d op1:%d crn:%d crm:%d op2:%d",
                                    CP_REG_ARM64_SYSREG_OP(regidx, OP0),
                                    CP_REG_ARM64_SYSREG_OP(regidx, OP1),
                                    CP_REG_ARM64_SYSREG_OP(regidx, CRN),
-- 
2.43.0


