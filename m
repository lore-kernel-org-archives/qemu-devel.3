Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D12BC44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLJl-0002iT-2B; Thu, 16 Jul 2026 08:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLJj-0002hZ-6y
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:35:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLJh-000747-HW
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:35:54 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GBibhs3747325
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=dqyPARbkh64
 mZ2RIOOLnv5zdbrEo4chMNue1KyyBAxw=; b=LVYQNupj2926xBgCnYjGOjHuZ86
 WM+GhzooHKSSU2AUJ+g0aNQbrLhQ8OoKnZG6c9zEvVSklZ4gKtP1E8M9Mbyy8PaI
 RNt0B60qrBIGr+hCC1IoEv74fb2wg/K6nG1zM1Is0aXz+LIwaVj4PqYqhQbOZ9Pt
 zLrX3Cw62zIl0mmoWfCjY4nls3tofGABmTcbiFmiZs6qPScU+8Jh8sBOk7kTpVoq
 /UdOzP74cP6dq4xqgVMSmkvpurIyRTtw/MLjl6yvoxff/43fXFm5FXILMdtGoQ8Y
 58dcCvwXRwEFZy/JaBWWOrD+tXRS82V/U+JpiZvLf2tT0t4N9jg8vVV6wGw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feq3pj550-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:35:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e623b0e95so819828885a.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 05:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784205351; x=1784810151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dqyPARbkh64mZ2RIOOLnv5zdbrEo4chMNue1KyyBAxw=;
 b=knVK1JnfvGnoKcZidkEV1WUYBwTYBRTb4JXrUWsSCgu5uO42CIyblE6tn8tHh/HmdF
 MEFpR2FMUJaz5JuihuUCBa6YrkIkshk8tKyTgwyZrKZdVzZ8g4hH8a4UA194W2GAnQS7
 e5SpUdMX/zkg4X6M7igeYRd7aK6ckBIw5OWeCRFjW1QHoAkb8YZRD7HGOnb08eq4G7iN
 2jP2c8Kd+qG5f/4thUJ8gmmpk1Gkg9RbtOdxxxp7Z0Wgk/X5PJiZc5+3sCz67WRU6GZ7
 QeWi8hUPLu97WqaIq/WOOK4DvTIF9P33sIV0/K4R3uJT0PtbZCLQOVP/BA3VdXht+jQr
 5K2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205351; x=1784810151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dqyPARbkh64mZ2RIOOLnv5zdbrEo4chMNue1KyyBAxw=;
 b=Vde0avcIduW+Nk/6fhDWwMSEezq3B644i0AX+gOS/qIgWeioLaePzolqNkB/lgwvGg
 +MDcwlAwXqsr9BnhbmB92AP6kga8Jc2p1hGEpdcDf5H1I+GjpbVu8clFLjP7hl6yphP3
 avCWeYHWnfn1yc2Yx/W43Zb0zSubPVTSgm4Q/Kgfs33MGd2j3qg/u8Cx4pEoPhl2VGwS
 76JlV4LALGDJAsj230BIoCxwP1Jb0rM3tcVZZrITz9wcESVMk4pa9fWnGPL/MvBC8yoO
 CdT6wsvVZY9vEUwZzzxTROFhyvSRezNSE1JoYnRf1mwBEN78pHF+/I6MNZdAqIxe//q5
 eu2w==
X-Gm-Message-State: AOJu0YxVV9sYa0dVJtZORIkkl7zc/bcirejIDCdqdLJYufwg5r6EOAmO
 /Sc2B7nzfMMbMcsNQ8ZUh1zPStE9CyxkVU0+7aMnS4tGmvjFq677nJq53LD//9C3+ZahphkgF98
 VsbMk0LIU9sNumpxYzrVX6piVHqGR+gWoYS+JnAdxbo4LvcBXqOG3p6Zq5+q7hTZ66A==
X-Gm-Gg: AfdE7cnXXHBvf70olnlSANpKP8h/HBbNrhBQvaV57GC2MfL3Q8FjFDWQ1yXC6L1oE8P
 W3aqpe3dqHia6RiQ8XjiRE6FqIKX1RUskRJN/7FasZX3dP0jMkfBcxkwvv0QL8BBQqPZyFMABfn
 AA8gg2s3XFVPJSWJladzDyO7oUDgtNGNEqeRQgHthn8aK1fR7RWG2SCDHI3IZ/1VclQJwSg99hl
 6PTj8iFzlb39hecibtke8gJqfN8U9lNyj8p8MYDzPHynFqzyMQJSl2c6Zu+m6TAyx5fS4z5ufGV
 dE9FCYjrmLzWLnq8n2udaTGLXXvhE/Km+y5f3JzjaTLiAkXYWJc0Wic5iD8PZYZH8wYBdbXHZhM
 WtJPB1V7rBZZYNfIKVI8o75zrIsKNgX+8jPI=
X-Received: by 2002:a05:622a:4a8b:b0:51c:1408:6c13 with SMTP id
 d75a77b69052e-51e4f0baafdmr73387581cf.44.1784205350954; 
 Thu, 16 Jul 2026 05:35:50 -0700 (PDT)
X-Received: by 2002:a05:622a:4a8b:b0:51c:1408:6c13 with SMTP id
 d75a77b69052e-51e4f0baafdmr73387121cf.44.1784205350314; 
 Thu, 16 Jul 2026 05:35:50 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-902de1fdb3bsm191609316d6.23.2026.07.16.05.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:35:49 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 npiggin@gmail.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH for-11.1 03/17] target/riscv/debug: Implement permissive type
 unavailable trigger
Date: Thu, 16 Jul 2026 09:35:20 -0300
Message-ID: <20260716123535.3709148-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
References: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 45DSxktg6oTph3Vxc8TvQuLj2MGPFw1L
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfXyYLAkI+CnIFl
 zTfAW9GMD1EsPGGv6017ptbapCGtdtiLvFVio8BiwN2WtiU5M11Z2vXk7AJ5i2Lt8yBF4T9YPJC
 C4rgV+giZZWqFiIPIOmJLrWAs73Qrlc=
X-Proofpoint-GUID: 45DSxktg6oTph3Vxc8TvQuLj2MGPFw1L
X-Authority-Analysis: v=2.4 cv=PN8/P/qC c=1 sm=1 tr=0 ts=6a58d028 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=8_OeMpcRU3GNJPBcLSAA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX/5HT/hy+Vduq
 N/V3UX+iIX/ji+t1KyC7nQRkankbyeVSGwqJu4FMkMkxw5GIh25zKjW6AZJS3mibYnfN7AYkuXE
 4h4vbOCfNHK9CL6DZeg0RDG94Sw1TG0yxLK54c3jHnZVssIwoYSweSdZpcjb/ZTRdycI4/6ISH7
 pHuTQRcQF8qG3Ht29fa5B0WoTDaeO/EKNAkELFnPat63UyC5G1cxeudeqH2rRceQS8+swGmu5T8
 7ZOh/SSwuz2Y9s3VDfKUanTcMLyVN8spqs7VfsGlwBN+8JnsQS6E68tiUBX+0dJTQisQ4oBm5/4
 oredl7Y5FDX8xTlaoLSr3YaSKe3k0aK6TEkTc3kobUQmMgjKH0EQq07O2wlNL0X/PwUXb1GlBFL
 53xnp9caVfDIQjEgBH50TQELBli3R0wB0Yh6lIjZDHzJA1RO1lqF58uKJkM70i2kCmPvZDY2ZTm
 p+mVedoorsoYLBLJgWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160129
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Nicholas Piggin <npiggin@gmail.com>

When a trigger type is "disabled", tdata2 and tdata3 must accept values
that are valid for some supported trigger type. Additionally, writing 0
to tdata1 must result in the type becoming "disabled". This is important
for the prescribed sequences for updating triggers.

Implement write tdata=0 -> disabled behaviour and permissive accepting
of tdata2/3 values in disabled state. This implementation could be
improved by checking tdata2/3 values against supported trigger types,
but it is good enough to be usable by software.

From the RISC-V Debug Specification for tdata1:

  Writing 0 to this register must result in a trigger that is disabled.
  If this trigger supports multiple types, then the hardware should
  disable it by changing type to 15.

and, when type=15:

  This trigger is disabled. In this state, tdata2 and tdata3 can be
  written with any value that is supported for any of the types this
  trigger implements.

Fixes: a42bd00166 ("target/riscv: debug: Determine the trigger type from tdata1.type")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/tcg/debug.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 9e6c907742..c7cc67e244 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -829,6 +829,28 @@ static void itrigger_reg_write(CPURISCVState *env, target_ulong index,
     }
 }
 
+static void anytype_reg_write(CPURISCVState *env, target_ulong index,
+                              int tdata_index, target_ulong val)
+{
+    /*
+     * This should check the value is valid for at least one of the supported
+     * trigger types.
+     */
+    switch (tdata_index) {
+    case TDATA1:
+        env->tdata1[env->trigger_cur] = val;
+        break;
+    case TDATA2:
+        env->tdata2[env->trigger_cur] = val;
+        break;
+    case TDATA3:
+        env->tdata3[env->trigger_cur] = val;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static int itrigger_get_adjust_count(CPURISCVState *env)
 {
     int count = itrigger_get_count(env, env->trigger_cur), executed;
@@ -885,6 +907,10 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
     }
 
     if (tdata_index == TDATA1) {
+        if (val == 0) {
+            /* special case, writing 0 results in disabled trigger */
+            val = build_tdata1(env, TRIGGER_TYPE_UNAVAIL, 0, 0);
+        }
         trigger_type = extract_trigger_type(env, val);
     }
 
@@ -899,6 +925,9 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
         itrigger_reg_write(env, env->trigger_cur, tdata_index, val);
         check_itrigger = true;
         break;
+    case TRIGGER_TYPE_UNAVAIL:
+        anytype_reg_write(env, env->trigger_cur, tdata_index, val);
+        break;
     case TRIGGER_TYPE_INT:
     case TRIGGER_TYPE_EXCP:
     case TRIGGER_TYPE_EXT_SRC:
@@ -906,7 +935,6 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
                       trigger_type);
         break;
     case TRIGGER_TYPE_NO_EXIST:
-    case TRIGGER_TYPE_UNAVAIL:
         qemu_log_mask(LOG_GUEST_ERROR, "trigger type: %d does not exit\n",
                       trigger_type);
         break;
-- 
2.43.0


