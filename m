Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A3ACD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsaz-0001on-Mr; Wed, 03 Jun 2026 16:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZt-0008Ck-HM
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZm-0004ID-5E
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:37 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653GtTO83552128
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=PVvrPaIoObY
 DYUC9DNIpLydqYY9Flw1wxl4B7t+Ck1w=; b=Fj3YEXXq5PaMVjuqS0WhBVrOleG
 nuxENkF3/xgAR3Ur8F46gPGpyWAgwYur0/QbQjLuO0paz6EUlJytKPZmR1+YBt6b
 86Ew2hN3mN9QTZuMTkW0TP2HUg1rzvLnd753OGz/DI53Q1VBKedp0xKtl71qd7CW
 dSk9Wxi+l26MGdjLPMBZbyFMNPegiaf1KkTAXDqvm2AnjhxlDDK93IISi1GAamof
 Kxrv9YUC85DA8Vt2rCsNnBAqNg0DW5MwnW8hAZJSfu6VRjsmHoaqnSXLR9d2627h
 //JNldkvjJFIiQzXGuA9kIddLBZamGJKlQBNdxmtDkq4jgpPcDjaIC3Eqwg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejj9mtp2g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:52:26 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30761ab3483so1305869eec.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780519946; x=1781124746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVvrPaIoObYDYUC9DNIpLydqYY9Flw1wxl4B7t+Ck1w=;
 b=BZ2EL7edidwxBxSAE5N9Gk+q7bfVIAE1xgx7+48vQyL4fmtqssc02BzdP2zBzOEf27
 Pg6VkKlmUpaAm4GjqRXtLqhuIFOr9JQT0CRX7YL3Rq5ip5zHGxh2+q6pMwbenTH37LXE
 v3o3/qdvI89u661AHEIdE7KsF2k3poTlep4X9kr3eeBvcBSNPcU3MdPLlT8jqliAWSYD
 bkWAap5IDHqU6gptuzRafU84Bx5+goEg3k+o8LWy0xIY6V89sT2RGFi8ahD8xaSJXdFE
 +BLV2x3kBUiKpNDhIVJzBzK7y7+hDi7ydJDNJ85w9J7NmtNIpx9Frk9yARuvl5gt8CiR
 SDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519946; x=1781124746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PVvrPaIoObYDYUC9DNIpLydqYY9Flw1wxl4B7t+Ck1w=;
 b=EEjBQ4W7zOt+UERA8Vr7+e4Gr3g6S3GNgQ/uImPEwQXyN7+JHygwMimEf5F2ojyFN1
 wTCpvZjQ7QeuxGzHY1TrbQwQmIuApFRRfEE2vm1cFPUDEH9dINCbtjcue0geuocf4RyV
 bxEwDX/Z7l5e51MCFDXOIeRgsv+l/BEQgPw2pXoA2tHlZpxbiD2XXXNQo+C9WECeBO68
 jeqwfHuVk6bt73DTaB+VfFO7+uNYzXTIY+zlELJxuhWVQ0VywMRcSSl6kzTmBmeuIfC3
 F7wn27ei+MFdMkYryl1JEdC5BKyP6t8lGQq9fSQ0oDA4kFOPzcPV3nq402W53AKmR+sW
 8eWg==
X-Gm-Message-State: AOJu0Yxt6zNPGwCQzRDLQDf3Cc/ZvWo+69CFpM7QKZS80uwcjtir9kgr
 Xxg8DoQC9JpD1VEFm4OO5UXwrt4d3aX9KJzA1amJ6I+inKAAY63PY/QjIuyg+ociLrop6JkHXQq
 mb2x/a7tgtrH5aXplN3YwRv/vPZhgL6zpf2GCH+bSYP6mGsjRewQakkeLxvRhZfPWPXvR
X-Gm-Gg: Acq92OHQtY0o06dYZDS98ga/8YcABu+O48h2xw+x66IQFdePHP8tazprnHHSAIwaPCQ
 xVJ95cO3uKGx6/ZnQXxFtqYZ0jDi4fR36KCxKWXHdOb59gRCUHbTcIFxgNZbq23SXNLhAx+YBZ5
 PvMoE632vo9DOUfqraR1b0ylvFhHFKwqf3ZgNfIyMkv2l0ejF4dNxLsQ8iyamVKFdgCXm9Cfqg4
 9vmnEdpclyvdaDg7Syb5roDSXLRVxmspRTRl7xC1rLccscYq8rEjYVnBOYSF69UYZObrjkKzs1U
 z9A2WJQUzBRRkoQppA4GGYFRSC1T4pgfTuyU/hU1bOBFh7tfN3Db1qaT79NIiLzaTcNnElSZe+q
 IoMDGxpiNVGkL8q2OKMPZPdGiE9DcpZ9yuZIdyvXrFfl4FhcQ7p6Dc37XQ+qBrFgZ6fp9bK5XYh
 Li+9yL83GAsPMVoECS
X-Received: by 2002:a05:7300:5726:b0:2d9:fa9c:87a9 with SMTP id
 5a478bee46e88-3074fa53068mr2902135eec.5.1780519945687; 
 Wed, 03 Jun 2026 13:52:25 -0700 (PDT)
X-Received: by 2002:a05:7300:5726:b0:2d9:fa9c:87a9 with SMTP id
 5a478bee46e88-3074fa53068mr2902120eec.5.1780519945240; 
 Wed, 03 Jun 2026 13:52:25 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm4586333eec.8.2026.06.03.13.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:52:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 19/25] plugins: remove qemu_plugin_id from
 qemu_plugin_vcpu_syscall_filter_cb_t
Date: Wed,  3 Jun 2026 13:51:46 -0700
Message-ID: <20260603205152.1440291-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: L90x6Axw7mb3Fn-4o--zvJgmZ1eCbpcs
X-Authority-Analysis: v=2.4 cv=XK0AjwhE c=1 sm=1 tr=0 ts=6a20940a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=ZpZNCfPiCzbVQKdpNmsA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfX6sNvuU/Ci2Nl
 o+pX9qaub05UddACNwtvVn1x0xuUN0kYXCJnwF87xwmwSUpZ9lGJslJY8BnrahnFEqxy+1Lznjv
 5uy5lBRSVaUAB0PWP73UDCu4ScExRLvTeXGtDNiViVZmsmmmEwiScvFyzm+F1pmrXSveXobNDRE
 OcJRSY2zeB6OF7T+kY26506RAWOE9mUHs9XKuxdc1CSsQ2Dp7p0q2neU/wt6Nrs7j6gyLFK3egD
 ohsiqCxEQiQS4AnrCdV1SL3k8yCTHS+dEtxicSvezMgv+1NxXyeZOmyTXImjPE0t3txW7IP8Fe9
 at15ep3zMpqMnksymRpy0mSr6gdRaK7J8PxA2odKgd9n95ZogAL93V6ON+7SXoC9LtfjS/D9rZR
 OiWK7+WzCbhvWtyWGeKXjsl7S1bUNT86HhxYDr0wo4+wmUyZYXEUuvIFX5z1ipJyXjz2WHLhF52
 +MhRn01PW4ynEKCCuGg==
X-Proofpoint-ORIG-GUID: L90x6Axw7mb3Fn-4o--zvJgmZ1eCbpcs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030203
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/plugins/qemu-plugin.h | 4 +---
 plugins/core.c                | 2 +-
 tests/tcg/plugins/setpc.c     | 2 +-
 tests/tcg/plugins/syscall.c   | 2 +-
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 909f19b7128..c38ae7db1b3 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -852,7 +852,6 @@ typedef void
 /**
  * typedef qemu_plugin_vcpu_syscall_filter_cb_t - vCPU syscall filter callback
  * function type
- * @id: plugin id
  * @vcpu_index: the executing vCPU
  * @num: the syscall number
  * @a1: the 1st syscall argument
@@ -869,8 +868,7 @@ typedef void
  * handled further), otherwise returns false.
  */
 typedef bool
-(*qemu_plugin_vcpu_syscall_filter_cb_t)(qemu_plugin_id_t id,
-                                        unsigned int vcpu_index,
+(*qemu_plugin_vcpu_syscall_filter_cb_t)(unsigned int vcpu_index,
                                         int64_t num, uint64_t a1, uint64_t a2,
                                         uint64_t a3, uint64_t a4, uint64_t a5,
                                         uint64_t a6, uint64_t a7, uint64_t a8,
diff --git a/plugins/core.c b/plugins/core.c
index 45136bf950a..987e49b89cd 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -589,7 +589,7 @@ qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_syscall_filter_cb_t func = cb->f.vcpu_syscall_filter;
 
-        if (func(cb->ctx->id, cpu->cpu_index, num, a1, a2, a3, a4,
+        if (func(cpu->cpu_index, num, a1, a2, a3, a4,
                  a5, a6, a7, a8, sysret)) {
             filtered = true;
             break;
diff --git a/tests/tcg/plugins/setpc.c b/tests/tcg/plugins/setpc.c
index 595571cdfd9..9bb5bf0f5f7 100644
--- a/tests/tcg/plugins/setpc.c
+++ b/tests/tcg/plugins/setpc.c
@@ -23,7 +23,7 @@ static uint64_t source_pc;
 static uint64_t target_pc;
 static uint64_t target_vaddr;
 
-static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcpu_index,
+static bool vcpu_syscall_filter(unsigned int vcpu_index,
                                 int64_t num, uint64_t a1, uint64_t a2,
                                 uint64_t a3, uint64_t a4, uint64_t a5,
                                 uint64_t a6, uint64_t a7, uint64_t a8,
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index 8a823acfca7..2afd71895e3 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -171,7 +171,7 @@ static void vcpu_syscall_ret(qemu_plugin_id_t id, unsigned int vcpu_idx,
     }
 }
 
-static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcpu_index,
+static bool vcpu_syscall_filter(unsigned int vcpu_index,
                                 int64_t num, uint64_t a1, uint64_t a2,
                                 uint64_t a3, uint64_t a4, uint64_t a5,
                                 uint64_t a6, uint64_t a7, uint64_t a8,
-- 
2.43.0


