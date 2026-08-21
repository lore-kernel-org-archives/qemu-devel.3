Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939D2C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 10:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxMq5-00051t-0G; Fri, 21 Aug 2026 06:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxMq2-0004vA-V9
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:51:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxMq0-0003Uz-00
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:51:06 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9M3iG789985
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 10:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VWq345a0G0XUYPJ8u6+lPJrThsdxHTF0ZV2AIgn58Tc=; b=Ho+SvkvhekCxRhmg
 K4iembLFfevuzGs5WIJgWTAyY4VAKnD9SC1zCbHR7+iuaMFpnBVr3Q6A0BpsaPPB
 V9slCB9KgLUHvHia6RzJnLW0LB4cN7/hQACmoHTGHT4HNlZLsfkPpL/xH/fiKabJ
 NgkgDWe6zQYaf4OP/KHHzzmPZui+1Wp2ctuf5zIZGasoRe6KLsgzm1VwzbcKTbb2
 w526eOtEVUOpaPhAO8s6ucDeVmh9jPZThXypmVszSVyPKIhi6XxTHVatCVWCsen4
 pzvMXkvV5PSzIXXlojAoFe+4bHSNK8/2n6hSPndRRPYkJRG3xceCqTNZj7THBMfs
 WonaUg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6ebusjj6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 10:50:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-930edb4362dso84766485a.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 03:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787309452; x=1787914252; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VWq345a0G0XUYPJ8u6+lPJrThsdxHTF0ZV2AIgn58Tc=;
 b=EA9TwTkSdRLU9K6C3eAQ1H1hit2K9i3a2iCFKpBppy+hksmrmhYEh8TZ8RTxk7PRd6
 Cdd4q96I4BoaxgocPwcmrFXZbRnLHFuOb84ig26r3g0X8iwwWMeZNNEs7LGTRLG9Pebq
 VhFy1zRb8GSr35FvSk7Lor63NECFEvn1apthSKYbqU1WNeeHGMuVbUcpXyeSNB1EWMZV
 xjQVuEOdU2Dc/qizIIOjAmiu1u+hoc/QzSpAJ7uegSABLN/S8KNrC4/WhNE3InY7lZ4o
 DVIStfm+rHXauA9HcZRWm+cwe0eS2Ja2RlZbNuXu8NiO3IVFv21dp9gKUOAGangumRUv
 wvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787309452; x=1787914252;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VWq345a0G0XUYPJ8u6+lPJrThsdxHTF0ZV2AIgn58Tc=;
 b=r6ZHdE8Ss+hRiYsjr/hs+IZ04ICtNzCRJN8RvNpIB6cwHEo/laHavvkWYjQpENTTsF
 xJpyoa2T0U5bCZLrG3hgy3rvMGVDUDa34BISSEb+W5jbdp/6enq+Zr+xaujnKYPqRhj4
 v1vrVCKzpqLenVp8afMvtaTfHNjuOeLwyyxYJ0Ivq/Ee55HcbrFsq+p8eAQC0pkZVsLs
 2afEYVFZExg6z5pNXpYLVOOmRcsT3eZpjYP9xY2ZOYZHubzWH5+K2Nb3P2oNKCjkhLjQ
 Bl6uZLHkucINenoL3yRhztu71wAApR9JH+NLQeIibUoT2++xzcliyeDTB4Nj6AWsYM9Z
 L1SA==
X-Gm-Message-State: AOJu0YxlUjOSnmUzP4qvmW231EU1yizAKUT+du2dY2ravmX22kQkZJQZ
 VGKxUwO2xJixm7pLv1cjqtj9Wkc8gWQL3hAUmot9fBK4gYembDr9y0niGw/M+qKbXLm3MGZsKIc
 oN2roYA62HbKek9wyCOfwVJlpwqF504mDH5LY9KqIxbVhW4aQ9bcNKOnntcdIw7kCdvZP
X-Gm-Gg: AR+sD11JrVoL7a98Ht4opPRdEHWc8ilSRYU4i9ZRIxoE7+c9ClOoYHkVvDZ9RqVwYOU
 FAcEvAYRc+3za2HD6tiBL4fkMKq8o0sQtZincduh1awpJRLK+M3T2cyHXVgRP1Rk2FAE/rx2WDJ
 oxvbTEpLbobQ4AKrARqjL5MjVF3cKEVfRIxq1EsqiSU/1zxPBaB4tZ3P8kBVnWYJk60Fzeoyww9
 nhkt0DNs9TxaeAvK8Q5wlEvtoDlcx6e+CyIxfcunBtGVNvoAYfSLVRjaToF/cRjrkBBqYZCtHKG
 Z3BMYK181d9zVnckrDh2SvoPBpk3QeCmRZhFOSXR6lhOWXDt6Vk/y4WfNAj9qmbiT/N7en6AVeP
 FImvlMqmJYiCGR4SNlYaCjmdrjXNh4o8QUF01Fe2Iqw==
X-Received: by 2002:ac8:6546:0:b0:51b:f857:cf82 with SMTP id
 d75a77b69052e-52df5694797mr50222971cf.8.1787309452195; 
 Fri, 21 Aug 2026 03:50:52 -0700 (PDT)
X-Received: by 2002:ac8:6546:0:b0:51b:f857:cf82 with SMTP id
 d75a77b69052e-52df5694797mr50222521cf.8.1787309451781; 
 Fri, 21 Aug 2026 03:50:51 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7fdbsm23197365e9.6.2026.08.21.03.50.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Aug 2026 03:50:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v3 08/15] target/loongarch: Constify CPULoongArchState for
 various cpu_*() getters
Date: Fri, 21 Aug 2026 12:49:42 +0200
Message-ID: <20260821104950.32108-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821104950.32108-1-philmd@oss.qualcomm.com>
References: <20260821104950.32108-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3JYAnUJ5miGBtC6yXKg8VuBXrh8r7ptK
X-Proofpoint-ORIG-GUID: 3JYAnUJ5miGBtC6yXKg8VuBXrh8r7ptK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfX8co1B52EArrS
 f9L1QrttT8/yWm5zngfch2r1Coebczz2r3wm0/6qsKRTScbYlfAuEI9yMYC9RNgIXpDUTBXc1Xl
 2xn6osieSpVCtO1qW0Jh1aFw/og4Vn8=
X-Authority-Analysis: v=2.4 cv=QJlYgALL c=1 sm=1 tr=0 ts=6a882d8c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=WMCVsHtyMyZApbVNAjAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfXyvrVL6VxvFp3
 1D/USQJYdTqHI5WyyARtW2IGAbZFRSNL9GReMsgllE1sENHj+Xshr+9fyjPL0A46iMjpksMeSkq
 5+2cJ3YpmZAt9n6oBUB2BDkqsvEGhyHi3lljTqUdD8WYdv5rLH1YnNWN7k755N1jD9iwgcA+5Qz
 f59eY2s8k857ac/dUvo21ZRHs2PC7izPQEYB8pvrM6rOfmA8QzHMuPQIMJVr1mhWTiQhU2/Djlv
 7Ta0q0CF82JbSsRIdCKjmob07y5CkftSTFZDUF8CgTQCSLPsdm01Anu/9WUEdxM7NerXb29Y0ik
 fgbCnkXG6ahVXLqrLXQIbed81msGmI8dWFYH4yqLm5KXtMWit0qUuPqrE1X4Ebq8oVVnu/CjG3D
 hF8d4QJXQ0h0/gR+RsW7+APsFl5a0kECAdQo34YWd6lR3d+CIaw0brPHFaQIa8Vh51sIlJeil6t
 Z6TR0XXZhUaO6XnWp+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210081
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Add the const qualifier to CPULoongArchStatCPUMIPSStatee when
the argument is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/loongarch/cpu.h       | 6 +++---
 target/loongarch/internals.h | 2 +-
 target/loongarch/cpu.c       | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 97db3b453fe..ad8e7497279 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -486,7 +486,7 @@ struct LoongArchCPUClass {
 #define MMU_USER_IDX     MMU_PLV_USER
 #define MMU_DA_IDX       4
 
-static inline CPUSysState *env_sys(CPULoongArchState *env)
+static inline CPUSysState *env_sys(const CPULoongArchState *env)
 {
     return env->sys_state;
 }
@@ -496,12 +496,12 @@ static inline void set_sys_state(CPULoongArchState *env, CPUSysState *sys)
     env->sys_state = sys;
 }
 
-static inline bool is_la64(CPULoongArchState *env)
+static inline bool is_la64(const CPULoongArchState *env)
 {
     return FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == CPUCFG1_ARCH_LA64;
 }
 
-static inline bool is_va32(CPULoongArchState *env)
+static inline bool is_va32(const CPULoongArchState *env)
 {
     /* VA32 if !LA64 or VA32L[1-3] */
     bool va32 = !is_la64(env);
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 50f0fe2e9be..d6f31161e85 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -38,7 +38,7 @@ uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu);
 uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu);
 void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
                                                uint64_t value);
-bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env);
+bool cpu_loongarch_hw_interrupts_pending(const CPULoongArchState *env);
 #endif /* !CONFIG_USER_ONLY */
 
 uint64_t read_fcc(CPULoongArchState *env);
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index d9c1e871027..2dbe2203b20 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -82,7 +82,7 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
 }
 
 /* Check if there is pending and not masked out interrupt */
-bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
+bool cpu_loongarch_hw_interrupts_pending(const CPULoongArchState *env)
 {
     uint32_t pending;
     uint32_t status;
-- 
2.53.0


