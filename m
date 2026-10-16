Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8D0CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmT4-0007ry-6J; Fri, 16 Oct 2026 14:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmSE-0007Fv-NS
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmS8-0000aP-2E
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:49 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5noW2914762
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kDTXeloSGvr
 zispEwn3HNGPzJKJRiMhfHDcWspUmryo=; b=IFnuXobbf9t8r6F0xog8ztiB8ol
 5Q4ZNE26kz/PNPSZZ7Kiz7ByAWU7Qtx43bemyfU2D9iqzk0mBtvm/eNu+2cKiyYD
 acr/33q1dwtySFrYOOTKOrVblxwWUhDjRNn7u8FUtXtYeg/Uo7xe30VrT6K4S0ZE
 mNosgL9QxbKNv5MCNGak+B06Ef06tA5ZKXQ75jGvA4Cq5SD5W9rJFcM07u+5NDl1
 PJHkMKf5Ki4J/wOP1JVpkmz5vCN0DDu+4Fhy6s7ZH3QLYhcikq//CVcVTl2x/8NS
 rTLJoR4ko2ukvQsgkBK1FsQ/XQ9JyYer/G8833tkCqIQgk48RHoBKWvZmDA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbmmq15e2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:46 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3aaee1fc104so265052a91.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792174486; x=1792779286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kDTXeloSGvrzispEwn3HNGPzJKJRiMhfHDcWspUmryo=;
 b=fmqEVtLcG7ropQ0QNGKLSU1DEdR8pQmRnxEGhZv6NcuZQY/Oe2eiGMcLEBdKXPDxry
 A1H7v3MPncDEZj1I6ZFa1OzOAoSV+cqXzt+tINbIdXYq6HAh9RRY5hQZxHIIsA98yF8y
 wd8kc17IQu94Pi225sxBrbX+zQ0Tu4jt8wqcdr58WbHOp81Cju3sEM9pNHpTJuEwGKgP
 wNIocFs8iJrWeWoeaw+SgJJVybLZ+hr5+3ajrE/VF1IAhFL7MVO5e3MivaxICGzF0U9M
 G6WU3aln1tJCD25mgFFV4m7yhHYLh4iRkqN/RJPOcjLKVamQjykNC/g1dOsUqqLLWyfW
 wsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174486; x=1792779286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kDTXeloSGvrzispEwn3HNGPzJKJRiMhfHDcWspUmryo=;
 b=KVC+bNgQa489IToR8BKUc2Ehsg8Rl8SH/6YinWhP/cby8jK6TmgbLZ+xg/CpfgdeGZ
 WDrl0jrVhcOuJeImnfm/USNdSe/A+dJEWO5NxMKxgVKLtSpQsAt7QjmNsuurYPtSFrQi
 f3d2+nqBo8TQ2tuw05rKNdDxVKdwNJoT2JZ125xx4j8JZP+O1aswklQNddbaJI8iPWnp
 rAM2XX0uhd0VlPoCnpeSuUpEhuHDLOioV1uArXvUR/vUmMZIguYzpsizbHPpOECZmCvG
 RQ3GLrxZGvgUixhwWYFhh6an91xM+KQ6faPyG8W7BzoWqm42XhA0P1zE9+IghqXutH74
 Yj1g==
X-Gm-Message-State: AFq9FYIJ7iG1bEjQC+urBnK5GDAUnb7daTqkwLOJndYTXlSckwYr699B
 rSjxzF59liNoXFneQ3/3rhcEbQXQdnSkcmG1wCP4QJjlUydaKWQ9P3D3dvc3UTZ83NrEZv9k8bF
 UDyAn1VZ71jJ9qr3V2imQgbRdBJ1p0DcsDi/I0LnaQ5ntm4Bn8umOvasiD9BcgPzc/A==
X-Gm-Gg: AYBFou1FpsmxXkA31vXBsj+UJS0isevjwUYzRjN1ABTmUaXV5M5AWl8WYd7e4GGKuQo
 PbxqYpnYrSbhWMInQO6JmHPQNyEnUvL1OUWRZbiXQFMdgoSbi31yC8dkGrihhYSwDNVbF0S6ncv
 P0s85HrAMMPqfiKGbLxUqLBT7uOBxAYQ4VnuXYcvlzfsubJ2+lTi4dHuJhCUYPb74vhInxIU5uL
 dfDnlwjh/WI0ZGTp9xJ4K3TZhri4tSuS4BTrkVReRLuMGRxyCpQ3V66qV0RgQfnFtZMkkBRBbFq
 yTVX+wC0Yi92/8JHTlPxfjW/Wtmr9pzLzPGDefqsPXo8taU4Fue4BLhfIIRa7rpxu+o3cF4FnQD
 umQbaKGxbYkofvG6Ddw9wn+B4bLQ6AbNK6RggqAXmEk6sFYtSwj/lwB0S3l85cpQ=
X-Received: by 2002:a17:90b:53c3:b0:3a0:bbd8:5ba7 with SMTP id
 98e67ed59e1d1-3acef63e059mr519335a91.62.1792174485875; 
 Fri, 16 Oct 2026 11:14:45 -0700 (PDT)
X-Received: by 2002:a17:90b:53c3:b0:3a0:bbd8:5ba7 with SMTP id
 98e67ed59e1d1-3acef63e059mr519320a91.62.1792174485382; 
 Fri, 16 Oct 2026 11:14:45 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48e8646sm4895282a91.10.2026.10.16.11.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:14:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 21/23] target/loongarch: implement get_note_size sysemu op
Date: Fri, 16 Oct 2026 11:14:08 -0700
Message-ID: <20261016181410.191743-22-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfXy31UmXqKPueO
 bbMWt0ET1A14Tvt4ZXj99qCYygW//s54/GfOHJ6x3RUPUI5JqHkQzr1/B0sx/b2ii8oKJGGPGZX
 fw9BGr8ovdbq+VnFsfBxOsy0kBulVHY=
X-Authority-Analysis: v=2.4 cv=P9uvFSAu c=1 sm=1 tr=0 ts=6ad26996 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=VoVa20T_UCIUsInyF4AA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX2U3SiWmO1PmT
 c0SS/oYm5GFcFxWipzzsGxVVJ4lSstaCG5v4Mnsv2CC9T8C3/NQgjTmmhBfkiZVXlQEFvYJJSBN
 wqDeQnkXMLdamKK5nzXXVFqKeHWb0MJDPQYX0+VyEF7xpphqVfMZvRLnm1KZz+hjjIuWQhAh8rD
 RElumkwb453/JroZeL0k/4UsYNAlXIVvkjZ4AeOdutPsmMx45ZkAoZ1DT/KDJHA/1Lb1ZrFBYaT
 W1CJ+GO47vbT+khsZHgLo7EbC3cvjw8pfHNi9sULL7LsjNgPkyAMDVjurjYxCWt/PgqIXPpc+B9
 84r2fMwb6vtnkrsXdmaRxBtKkXpVdQHuODboMzevM0eedV1ITa8MgC6y+fK8PTNAZdgPa84+83q
 ABLjSsOW/e2Iff4doodnxov7fYFpN9mISRe6QmTbxiCU95OB27PffAgXzNjpxrX6Hr0iaUDYiGG
 CQRteNIChKC42Py3LDg==
X-Proofpoint-GUID: nD4c6_m0SDwAu8X1CUPQYAPuhlDAqU7K
X-Proofpoint-ORIG-GUID: nD4c6_m0SDwAu8X1CUPQYAPuhlDAqU7K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160072
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

For now, we keep the global cpu_get_note_size symbol defined.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/loongarch/arch_dump.c | 8 +++++++-
 target/loongarch/cpu.c       | 1 +
 target/loongarch/internals.h | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
index 5a0e1742242..e27bd0f6497 100644
--- a/target/loongarch/arch_dump.c
+++ b/target/loongarch/arch_dump.c
@@ -152,7 +152,8 @@ int loongarch_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+ssize_t loongarch_get_note_size(const CPUState *cs, int class,
+                                int machine, int nr_cpus)
 {
     size_t note_size = 0;
 
@@ -162,3 +163,8 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     return note_size * nr_cpus;
 }
+
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    return loongarch_get_note_size(first_cpu, class, machine, nr_cpus);
+}
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 65772f30947..5e182922b7d 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -842,6 +842,7 @@ static const struct SysemuCPUOps loongarch_sysemu_ops = {
     .has_work = loongarch_cpu_has_work,
     .write_elf64_note = loongarch_cpu_write_elf64_note,
     .get_dump_info = loongarch_get_dump_info,
+    .get_note_size = loongarch_get_note_size,
     .get_phys_addr_debug = loongarch_cpu_get_phys_addr_debug,
 };
 
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 83220f32aaf..4b37e88070c 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -53,5 +53,7 @@ int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
 
 int loongarch_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                             const GuestPhysBlockList *guest_phys_blocks);
+ssize_t loongarch_get_note_size(const CPUState *cs, int class,
+                                int machine, int nr_cpus);
 
 #endif
-- 
2.47.3


