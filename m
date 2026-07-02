Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE71C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHqO-0003CN-E1; Thu, 02 Jul 2026 09:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHqJ-0002yE-Hu
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHqH-0008GD-Nb
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:39 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662Dcpje565177
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i5CvciT5tad7yGydRdWyMF8oIxQptsq2RqDK/Jr9Fwk=; b=cF7jyUsrbSlXG8Az
 /tqZF1IsanqBQwl2YF7MLyrmkb3Xfs5HZI/oKtnRM1H4bgJguEVbUUmQyYDTC+g3
 L8qZ43hwmnw+RjI9qNKoiz2b1vD6R2FKyIdrkg4TlPqnCsIVmtXGKIWQnaP99J2u
 z17QS2yf0NMv8NnYhjDNqeEuIA56ew02WOHOd05nSypI4rTeSWa3tUFjf7PaXaUd
 tiHGQLNf21xM/0X1ZOyEr7JdbigTyb9X94CQ9CTTmxlO9z90KFNTFLarwFTHENJ3
 d5BtGEjn5v4esCTljmPDrA59kGygcTlvBsoDgjE2kF4n5tJl2BlTZcZ/0zbsA56C
 t5Wj8A==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5s2501wy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:52:26 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7395c3d6923so546415137.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783000346; x=1783605146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i5CvciT5tad7yGydRdWyMF8oIxQptsq2RqDK/Jr9Fwk=;
 b=Qpn4c7zCyd2M6JUtcC00CUJeCdmR2PBQvGFd9PngokCAp0hmOBxXm5E97Ntac4Kcvf
 DFfQmPwspbIZioA/1XNI4oFvJ8HEl96TdB+N8OQIzirztBuLiYF96X/sSvKYzxcgy+5y
 /2v31jWq8ZOJDU4/NXrtignpUmvviZ0nfb931fiJoFiaIE0ihq/J4ato9/0d++mR8lZe
 CvPA+if+VenyRfr9+yWHgArb2gPkxMC6SXrAdxdyTxtNCEeuRwq0nSr9i2pO/LzUCDPv
 eMO+IejFNQYREfl1nLtnYcWKuxgbJ0AxB0PtWrDOSEWhaaeeJUKYFB3o1PMJc4EVO2nJ
 O30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783000346; x=1783605146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i5CvciT5tad7yGydRdWyMF8oIxQptsq2RqDK/Jr9Fwk=;
 b=AM723OpqoQeKNA0t1DbPP3v9likY6hM/dwMa2ZShVlujE4S4NhcavFlNtHwQKUuzSS
 XkMOTZ7DQyOV3xP0yDtjIslnMRmhlDzI1GLSw1dNEiBYQ3KE7FASCvvwl/cagsrb9AHe
 EWbLAEEdbPq6Px5YU6KwSWNP+8jGiJZzwbjdadETO7S3dRmL/84t2biD2Gvu7kSaUxz5
 pR/0aM0te6DevwRnZOLqRVlEEZy07sU2WGpoM+m44chdLEUPKH4J7hwFZvwlcxEuadvc
 7G8uRRu79yDWvheqvri30Ax2vjL0ZhAuSykRv72ZeplKRCpy2ya72ISFSFXuENFelYtu
 Ckmw==
X-Gm-Message-State: AOJu0Yyuz434nU79CsPyNTKqBMDDI1Rt3+zuLX3pljlE2lmT+WYgoyf/
 JSAw/ET/WiDkQHxE2/VvbKqVDus11lgbFJLLYDRDLQpuaIu2qgP9VnNUjTU+Of69nKoM3SV1usc
 C6nVbs/XBDC1tK4WgLu1nMV+ARNa7sitLFI7FWIDFAoeILI5jne1xXxemUP76DBTK7w==
X-Gm-Gg: AfdE7clEVyi9hlSqCeJOXbdxYuLuPgE3sOtpCDZfnxjLs4oOxa/7n3SQd1Vh59kIWRx
 PvsDINm18TRaqhQXecf0JMScxm/zich2WPcCpixbnKbji8A2byMgDqse0eOrKq12hH75tuz0Z2N
 iJ29VsgOMF6Z0NFkOMmS3IrZ/+gvkHdPEeb6UiEd6izXqXXvIqhg578nEUVUmo+6cI8MIfixLHb
 6fZLaiLpu/xdoJNk5aFBsCCHNTYxEz+oROYRwLkdWpgmbtoIEkH7YH9jFSepXpm4VerSb/J+Mm0
 Zb9HepO7WRdnqo7hdBdYNiQHaoGXcZUxtx+nzNAA9AysNgKbGNFmJTXnVYsRybU8dVtkbPIRZTn
 bDqavjOXVSwBC2NSWSFFqHon88w4wBI8LAyf7N4ty+Q8D5w==
X-Received: by 2002:a05:6102:5127:b0:738:ecd7:1984 with SMTP id
 ada2fe7eead31-73dbd608843mr2196470137.3.1783000346034; 
 Thu, 02 Jul 2026 06:52:26 -0700 (PDT)
X-Received: by 2002:a05:6102:5127:b0:738:ecd7:1984 with SMTP id
 ada2fe7eead31-73dbd608843mr2196449137.3.1783000345537; 
 Thu, 02 Jul 2026 06:52:25 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1c4e64a3sm1276462137.9.2026.07.02.06.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:52:25 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 20/24] target/riscv: move riscv_cpu_set_rdtime_fn to
 riscv_aclint
Date: Thu,  2 Jul 2026 10:51:22 -0300
Message-ID: <20260702135128.1188021-21-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=U7uiy+ru c=1 sm=1 tr=0 ts=6a466d1a cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=u0cZ2EjT8PS4VQJ4ig0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: xO0kjbrHNfs4k5T9T2LUtZSmsylNJByp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfXwsIEbokRQktK
 XNfps6V0bvxXdCrCagx7YUiASEn9VLZtf/W4vSkZ9nbAMRnjpw70DmGEYnij/myNOYMToVBg0os
 6LaVWd8Jp0Mq8Zk0my8tV0Fk8K1Dajd92CyBV2JrnG4CPbdPtRTtsU/7UY5lgTiNR0VMBOcQHlt
 HzR0RGV0RqXgcJ6R5eLRbhr3nrTX2lAP2ucQn19v1jwj1KHDdOIoLW911ZYF/222CN0X2vIpfrq
 87Q+bIqvAi74ibfcfpgBmOdxDyEJX/q7bDz0u6IiWhdz5QbhpRsqCF2PL3wFcVN3HV6niTjHtry
 uSHmXrIp/ajAD2zikrdf6JLx5jOZX/a5U9xRZO7PUDYQ5+r/IUiFTiTgQOCVhmrZIht8v0Ffqba
 BH4L1wipYACx0GH6SlTmRMqQfXI+D12QJde2p4PYLxN20HANCFh3GwgN/LKwibhZ9YDZ31LNyah
 Dmz+w7062gpzG2i+a3w==
X-Proofpoint-GUID: xO0kjbrHNfs4k5T9T2LUtZSmsylNJByp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX+Kr1zn04xQry
 9l+ZYpkJ2ekJdwk3kl58HWaiE9pF71mx17kV9+97CX4LYvF3OlMj6oucdj746yACuz15/LDzY3t
 2nVXtPT5c5eZcIfs1ZAA9GPQDNxvvQ4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

There's no need for it to be in cpu_helper since riscv_aclint is the
only caller.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aclint.c        | 8 ++++++++
 target/riscv/cpu.h            | 2 --
 target/riscv/tcg/cpu_helper.c | 7 -------
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index e27e5fb394..361a8d1bcb 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -40,6 +40,14 @@ typedef struct riscv_aclint_mtimer_callback {
     int num;
 } riscv_aclint_mtimer_callback;
 
+static void riscv_cpu_set_rdtime_fn(CPURISCVState *env,
+                                    uint64_t (*fn)(void *),
+                                    void *arg)
+{
+    env->rdtime_fn = fn;
+    env->rdtime_fn_arg = arg;
+}
+
 static uint64_t cpu_riscv_read_rtc_raw(uint32_t timebase_freq)
 {
     return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 396d9253e6..d6c5d6c1db 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -682,8 +682,6 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
 void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
 void riscv_cpu_interrupt(CPURISCVState *env);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
-void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
-                             void *arg);
 void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, privilege_mode_t priv,
                                    aia_ireg_rmw_fn rmw_fn,
                                    void *rmw_fn_arg);
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index aded995a7f..7a1ea53ae7 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -612,13 +612,6 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask, uint64_t value)
     return old;
 }
 
-void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
-                             void *arg)
-{
-    env->rdtime_fn = fn;
-    env->rdtime_fn_arg = arg;
-}
-
 void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, privilege_mode_t priv,
                                    aia_ireg_rmw_fn rmw_fn,
                                    void *rmw_fn_arg)
-- 
2.43.0


