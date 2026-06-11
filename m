Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6FCCD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 16:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXiB3-0001nf-2A; Thu, 11 Jun 2026 12:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXiB0-0001nT-F4
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 12:22:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXiAy-0006ak-BV
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 12:22:42 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BEs4SE923215
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 16:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=aWYEWQoXXsz
 q2CCnDXDZh6Lgo7kjM26o3yuxkKVq0FM=; b=GjoBGq2fIuNIeA6LO8QjwTQzqL0
 WP1qVlPgrfOOP4xIs1UCU+IyeLMmcW/fS7kxJW6P66e/G1uk4rTyBeu+LaaeBWpd
 KhUcTtObd7P7A20EFtX+40q9YGUZieBg9D6081om4RqyLUiHw9y/fz20qg+lmBIv
 JwORy53tGBZDZWAyL28hu/sWY7Oz1ndONT+iCf14Wzl2Zuqacyt0wdNGD1+F1k9b
 bFv/h5zLzHgBfX3WQspdXwH/IhOic/t1y6ZYQrccCHAFtiTPH7jm8o7TugSVWvBn
 PImVsFw5UTfb4dI3+WIbN3tSVSwbyGO/Dt27w/Omq3EMi8AKNYNFOWrWMjQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6uvdyx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 16:22:38 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5a77f8bdc24so6115997e0c.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 09:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781194958; x=1781799758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aWYEWQoXXszq2CCnDXDZh6Lgo7kjM26o3yuxkKVq0FM=;
 b=DJT5HfMsnXgnBeNGO5uidAPaLo5YyF5N3TnD7CsQ6fp3bl3qtbeWDmwWaQyiPn3SXh
 PghdO7OT4ALDWykdDeMybiBp+b0PR0T/UdNpDeT/0UCM3SVBRKJP59KxU9r5yLswzv+J
 oPwyR/V0E/RU+w1JPfZnNe+duXOTPTbPKkTNnKI6txARSQZ3U6vuICsxFhaaaizMhge4
 aRiIHIa78g6GQ4yXRoXOLbv6ywFWGm8OTrRrRs8q7b21wXJq6OD26nrcE2bVMZLCUyGn
 fChEMRygSKIMMAr2Kfz4otuHT/eORmxH2XNNzZkf6LPb0AJhpb5asGEgM6aRgC7Ghlhl
 wXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781194958; x=1781799758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aWYEWQoXXszq2CCnDXDZh6Lgo7kjM26o3yuxkKVq0FM=;
 b=Qqw3oldeoxcSoRBKQJU799j0t+dCNeKLxgr0GukD9IQlKHarmtNz95nsnkUOraY7pB
 ZP1SynC2Upv+UYaSLP30xzN5ekDsAtISlwXqD+imKEsLBr3M7oy8LTOhnVL4hJywPTRO
 rZvQ0uOo4+TWkBQaWFSdmygQ2OyV8YotlKLitcpvySf8PzHVCVEUMOcqEgqqoVWkQiK+
 07Y2MEQFpPrBUJPDurC4cX2ezpMPPdFSO0C08hnxPjdNbMp+EH+vs+EjtUy324E83Ms3
 vkWdJXu+Jlsk32MiB9+ZPsJMqGE+i51LbRZkIW5txWapcwA9vb4SwMk8HaaAsFJrZQid
 tnrw==
X-Gm-Message-State: AOJu0YyY6n4/kcTet0mXN8WuHf7xqnM70fjn5o8z7at6lfVwVPrwWd5N
 jiJN+0G/CWowZdCueEqC3/pEg5Q/r3sCipftH+Uy9eCz2X04DUIUFQI08+WeyIACpbq05C1x718
 qFZipdAyZxcmrBBmwGPdUZWpcgKEc4GQApnndCCclHNBib2c+tBCJgkm3GkzlZAu7Nw==
X-Gm-Gg: Acq92OHCcM5LG4gn1GPoKh7z0Y9ZfdiNp30cdpuxzCEHiABPmy87Sa5e03k1pu5/soZ
 ScQuefMetnb639cqaLjnvy5tOt7dVDyR2MJ0UX/3YdCq5iN7JaKj58yKeQnNDVE98OllpYTsXlA
 0AKHgMdLbJRLWz+viqLG8t6CgzHcwKsVhpJTQL+3iLfr54dL7UthUPOhVU/MeLRiK5/U/78SuAp
 +sWP4ewCheiaAS5I2hXvVVybaqjxcOG+p/cB6LspnYiRA1LFFZnPsClokTk6GDDxU9Llw3r0tIQ
 F1c8cIFsb0cA1QFrDx1NqWsmzaTZ5WCs9AKQZ8XLXUO09651w9GGp4zyF3rHOetYD/VcEIJIfyl
 0UnsBwvdv6dDvivsboITQE0ZZ9T/WVi47ammhYQyFItMeJA4uru5aYTpA9NE=
X-Received: by 2002:a05:6122:1c8e:b0:56d:451b:e4dd with SMTP id
 71dfb90a1353d-5bb0231e205mr2023262e0c.12.1781194957951; 
 Thu, 11 Jun 2026 09:22:37 -0700 (PDT)
X-Received: by 2002:a05:6122:1c8e:b0:56d:451b:e4dd with SMTP id
 71dfb90a1353d-5bb0231e205mr2023219e0c.12.1781194957559; 
 Thu, 11 Jun 2026 09:22:37 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d1eadaea6asm21879526d6.40.2026.06.11.09.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 09:22:36 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 2/2] target/riscv/cpu.c: do not default to svbare for bare CPUs
Date: Thu, 11 Jun 2026 13:22:23 -0300
Message-ID: <20260611162223.2361941-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611162223.2361941-1-daniel.barboza@oss.qualcomm.com>
References: <20260611162223.2361941-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FJ8rAeos c=1 sm=1 tr=0 ts=6a2ae0ce cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=rku2gE6GsbCemJvB6G0A:9 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE2NCBTYWx0ZWRfX7wymN2G3FF3E
 6aZELeQxTixwP11bTAB4HuRgCxBrjkaDb1rMoXcxzXYhfWnKiCLOlDN5sQWUFnnV+Tslnp/oiiM
 0atNU81PlrZ25RWR7jQmD9iwfD+DH9Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE2NCBTYWx0ZWRfXxGS3cweR0ytu
 OBN4Khfx15KU46xA9u1qgb4940ACUGXCwFoHXfCH1nzMhZRa4+0N5E7gRvrJpeVp5FXWhszWoVJ
 jRNfWHTOWYDZIz4k29MKFlTadukVD8RHWBK2msMnVO1mNpZJ8z7rtRPoHBXO5+eih5zzWvce2Gc
 uvItfhO0Rhl8Zz0g81CJgD/V8RLlU4/R0uETS4JEg6iO0olxcGyBOWL8J34W4Dei36zC7mk6P3K
 SgKnlDGQkzX4uGw8Jb/+nPf02y0eFf6C2HiCE4s92DanpEExRHB5o30yQbcQUQls9VzCcgZ9Ep9
 AlRGK3yjcRpCOmIcPK6ZNVkkiffhWJMw+Vcvsu8hBWbd9NAXv93XGzckVpSZBuX+AJztiQzW9eU
 HbiL34znN6INoiVpBNpcfdcRR3HXXb8tT6RUGJqsIfWID+VZvGmiyrNY/h+TVUcRUwugPYUFYsH
 bwDABXnTx9SwmbpcvYQ==
X-Proofpoint-GUID: bOQdE7l0piSR9SnhsQbd3y8RORNWNZh7
X-Proofpoint-ORIG-GUID: bOQdE7l0piSR9SnhsQbd3y8RORNWNZh7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110164
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Back when we added bare CPUs (rv64i and friends) we didn't had a way of
easily setting satp-mode to 'bare' in the command line, so we decided
that if the user didn't specify a satp-mode we would limit the CPU to
max_satp_mode = bare.

We don't need to do that anymore now that we can set 'svbare' in the
command line, thus users can confortably set 'svbare=on' if they want.

Besides, setting svbare if no satp-mode is provided in the command line
just for bare CPUs, while every other CPU will default to its
max_satp_mode value, is yet another random stuff users have to deal with
for no good reason.  And, on top of all that, this will make it weirder
to use CPUs that uses bare CPUs as their parent type.

Remove this special handling for bare CPUs.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d968daa404..c2f79a1ca0 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -510,21 +510,6 @@ static bool get_satp_mode_supported(RISCVCPU *cpu, uint16_t *supported)
     }
     return true;
 }
-
-/* Set the satp mode to the max supported */
-static void set_satp_mode_default_map(RISCVCPU *cpu)
-{
-    /*
-     * Bare CPUs do not default to the max available.
-     * Users must set a valid satp_mode in the command
-     * line.  Otherwise, leave the existing max_satp_mode
-     * in place.
-     */
-    if (object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_BARE_CPU) != NULL) {
-        warn_report("No satp mode set. Defaulting to 'bare'");
-        cpu->cfg.max_satp_mode = VM_1_10_MBARE;
-    }
-}
 #endif
 
 #ifndef CONFIG_USER_ONLY
@@ -896,10 +881,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
     }
 
     if (cpu->satp_modes.map == 0) {
-        if (cpu->satp_modes.init == 0) {
-            /* If unset by the user, we fallback to the default satp mode. */
-            set_satp_mode_default_map(cpu);
-        } else {
+        if (cpu->satp_modes.init != 0) {
             /*
              * Find the lowest level that was disabled and then enable the
              * first valid level below which can be found in
-- 
2.43.0


