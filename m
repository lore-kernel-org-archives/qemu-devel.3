Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EFFC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgwt-0004n3-Gu; Fri, 03 Jul 2026 12:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgws-0004lr-Fn
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:41:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgwp-0001Dw-Q2
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:41:06 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIsCd498335
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QV+aX9nOik2ueUL6+e2EZz4Xhxb9JObx3udYKE6I3oM=; b=Bygy/DMCnWK3TGVv
 UISvUMpl+UmEvj9CrcNQlXM1Xpg/bmVCWsis7gLJ8F/Q2a3O76/ejGp0ypmoqUbi
 9ZfO3fCSKw6CUuSucQaUB1VH4D4z1g50YfvuDBdwXhfI3XWKMAu/5IBq1d60JKuJ
 1jj+UmFSv/6gqOILtbl1eUGxafQPLEnwxntHWL36huwK4KOllDefeXzqn33x1lO1
 d6SjcAJAOTAyGhz8zywMtCoQsTsG0KGH8QOqNffPKaWGhgxgEmRaVdlU6sRZiDi5
 lwoRbuKHj9U982OzDQfvrG+PS7Cpb3r2ZXUY+Fqgb/kPpYleI0wmM5LIrIkhD8O2
 IxQzvw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qcjx1h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:40:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e61b38eddso131617085a.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096852; x=1783701652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QV+aX9nOik2ueUL6+e2EZz4Xhxb9JObx3udYKE6I3oM=;
 b=GxNDRuCMJBqylJBZ6T/eXyPreWhS8YYQYwvEVtX8a1AG8EIxMsx2emOeJ+QZBzM45x
 y+rBB+OBzlxNiaAl+ic6beTOrClWQg4SqPhlWfUq9KJIDBBHM70ub9tc75Jpv+9rGmwO
 0tMD3weWKXFjy3PHyanrViXLdxIJjKNCEVIx+7AQdSWpW3M6aeb13WcSzXVV2wLDXI4Z
 21chOblfkAf3nHkSWv55dbYHhjwkFPx+ZE3kQ3GhGreNhxLnrEi5vIod29gAY774SuMN
 xv/vWrTwhB70pj23yWAStdyDkwbiaMy1E5yKUBFuKtLnQOIwSUmamNL+AWsZn13aWF/c
 F1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096852; x=1783701652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QV+aX9nOik2ueUL6+e2EZz4Xhxb9JObx3udYKE6I3oM=;
 b=epl8k/Rdhz7VGNzkGDCkvKoGYXJs6UjD6oLy7es7h8E8WxXhE2f3NRh7E3B9LZRg8d
 3uGFtVL/EW7/LgDAxxxXoQJnbd5Bs6iZ8mkRJK+su0QPATvMPm/43QAUY7iA9yBDEev5
 exIcwzkqSJ6PcwaSHeUCkMytqqTm77irzQcQdZNCIjmCXbBM7RmUbt0hWRYmD2Ze7TDs
 C+d/Doo2xxsTDJeib46pc1QyOWs9i07FnE+UopRWCjPiOzcumQocNN6O5/BcNm20F0mt
 CZ1qk5p/aRqSmgsuPiGPwRFQNJU4Y+BUsp+WnNszNuz4PDIjeYLNhYlHStE0uRJioHaZ
 4Ysg==
X-Gm-Message-State: AOJu0YzjKxGlwNs3w9OyfSq2772pwMkYyGwrrM1bBfKDZ6+9yDtsdier
 MojZtTJxJILezTO6hmEZBa4Jk7wrbf/u1mEn7xGN8khzUVeTOkWV8BmHaoJkrmR/xbPxz4oa8Qf
 y4/EVDh76w9/jUM6WLqnnBE5SpIGQS05GtOOx+uopGQodrdGm+ODNUZ09sTN8LFz0pQ==
X-Gm-Gg: AfdE7cmF7g3hhB6aNZPOVELYA90Yy2g3faaZDU9gvxSGOaRZWeUYUDDJDKLIEgLU1L3
 Lu2fjRjCmUCZQnzowhvNS/TPYllqpTgAPDxpMdCVAZyP7TEFNUgv7nYw0TO/V3tRqndO5xVBZc+
 vY5fwEQSEMyQoFPcTsVapMaXn+c5UvcVN6mlY9CAH0bff8NE4MxSkKl5sfB1Hzv8OcPvXS4QcbZ
 BFyCYtSkoGEW4S0ZiktWTOyRMNZyhCG2RZ6EWK3cMa+8bQe81nvSjiD0fLaqYi2xCsysc/Pmzhj
 sFpDuabY38iMo1Klj1kvBm9GNOSk/Ow410uLXese8LP1I6jEzW5v/xLVP26XMB2QHnI9M99/4SF
 HBcbjarK/0mkIY3rad0t+63dOrFu8PPO/pZciA8BBcUGdp18MPSuCWAh81hIvYYmvdtuX
X-Received: by 2002:a05:620a:1a18:b0:921:1572:ea9d with SMTP id
 af79cd13be357-92e9a3e0dbcmr27342985a.32.1783096852071; 
 Fri, 03 Jul 2026 09:40:52 -0700 (PDT)
X-Received: by 2002:a05:620a:1a18:b0:921:1572:ea9d with SMTP id
 af79cd13be357-92e9a3e0dbcmr27337985a.32.1783096851671; 
 Fri, 03 Jul 2026 09:40:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccb4cafesm60809585e9.0.2026.07.03.09.40.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:40:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, alex.bennee@linaro.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 23/33] gdbstub: Reduce @type variable scope
Date: Fri,  3 Jul 2026 18:37:46 +0200
Message-ID: <20260703163757.55500-24-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QRBUKMvA2BvMmAN_axruDx3RQnIGLKnY
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a47e614 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=3yY2QiCzES6IJYuWj7AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: QRBUKMvA2BvMmAN_axruDx3RQnIGLKnY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX9VMppu1kpTQU
 J3Z8lqrjNH+3QMeDaEUNCpPaGvZTaiHZxnkOM+rN/griOB4WUqG2NvGnggmEr9BEWN7kBOXJRrB
 rhnuiWN7/Va+bQ1m85bqxsp66v20TFrcQwfeQHnZVNACYtlI8YKqao8D/239hsNv09OSnJ0ntUW
 ECQ3AO64sh4fkJhBD1MIxGP9kEqRUxvNVfi2+tV8kvnorXDQ7lqpik7V/Jm80yF34MK/2VYEzBX
 HrZnm0lVzzT3qt6AWomN+tfTzglbAuepJ/3rZxQrclFVqrJiABDKnEFPwb9YWQn/LjcyDXbgDSM
 RLBwwKtWGXSWg1Xlc3jJ8jRtnhja5WI1Ajap9dKW7Bu/eoOCmG/vSaxGskS6eoC8AqpEh0FwbB3
 q2lC3xuY3DxJ5TXNIvJsfGIiNVQKVcG5cWVRbw2Tf88F5wAZftiZ7/uQin/YOkQ4Tu82fA5Mq6O
 w7dP2iiTQLSfUS9wbDQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX8c6/kgw8vM9G
 RgYaTkN3gdZ/uGCr0oNwkf5w61Hp5NlAPyGqwsH5eBOgby3egb/mbAIuCqely7ZIZe2y1Muwo0z
 dOpRIl3Tk0i/ZfJj26IedQ5aUihydoI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030164
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 gdbstub/system.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gdbstub/system.c b/gdbstub/system.c
index bf7aa1ac234..9c4bd8ebcba 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -125,7 +125,6 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
     CPUState *cpu = gdbserver_state.c_cpu;
     g_autoptr(GString) buf = g_string_new(NULL);
     g_autoptr(GString) tid = g_string_new(NULL);
-    const char *type;
     int ret;
 
     if (running || gdbserver_state.state == RS_INACTIVE) {
@@ -151,6 +150,8 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
     switch (state) {
     case RUN_STATE_DEBUG:
         if (cpu->watchpoint_hit) {
+            const char *type;
+
             switch (cpu->watchpoint_hit->flags & BP_MEM_ACCESS) {
             case BP_MEM_READ:
                 type = "r";
-- 
2.53.0


