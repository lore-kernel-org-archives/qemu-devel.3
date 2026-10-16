Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F85FCCF2C3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmTH-0008Lk-O0; Fri, 16 Oct 2026 14:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmSE-0007Ft-Ln
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmS7-0000Zi-A0
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:49 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GI5LeQ4097579
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=S8JB07cW+tB
 UfIxocCM7Je7xlYVhqb1eleN8UPzAYAA=; b=NMoA3tTu7XQmYa4uwh/Jk8UsBhl
 WK1mgbJfDhoLuY9qxZlySjHnrjU4fInoGH8DvBt3kUp48rOaXAQfnsDeQOhLij0y
 xVCweSPk7ulMNyJQm97FgG8+r+WAbpEuD7pSjq6VSie1Z9ZkiEoohWutmM+kMkv2
 zFXvR2cxFor9rJxIstU9u1dyFN+l7EHPnh/FDEWqR9HnVA8eOg1X+uFnboPCW6qW
 loM0+ilKhl/Jhe+vWMDVsfRfqpq6CJPrFtn89er4eLIU8HdnGscSBPyDmsGKAf1I
 gyXdI4AzSE0Iw/SEzJ0wpCzqtVLZQEDONp/LebJHgF7+AOxWmWEU9fKpepQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbrw70152-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:44 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb11535e6a1so192870a12.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792174484; x=1792779284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S8JB07cW+tBUfIxocCM7Je7xlYVhqb1eleN8UPzAYAA=;
 b=UhPieDLGm5fQ2XwUgalB9MUumwZU673SJVTFI6iJatNhK/hq5HKIfUDj/ElcCR15lA
 z/5VwRHer4EbtT1Q40+7qfJhb8tHuda1DiigperN8Wv4L97ZOaJHL+IA7ah7qf+77HiO
 MMkbUhz0NJKTdmg8cdV4mNFtaGwxrmfhry2v+UGTONWBobl/xJ+VlzsPvIAv6ECiEi9Z
 SOuhH1CJtdD8Xsot/LGt29G+0paAE5g7i3OnM1dnVCl+RulXw96J6kIqoS2nkOsRltmp
 ESIgbuv+5Wii7tppnYNR3yXTE3zhjvyveg/8CgipyogFn7sBNZf/aRnWqIRay936ID7v
 NAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174484; x=1792779284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=S8JB07cW+tBUfIxocCM7Je7xlYVhqb1eleN8UPzAYAA=;
 b=cN5wpgj/jki3knA3+dbJW25txJttXtc5vAtcvs8h/bzmu3562djA6fqxtQ/COF035O
 hiVsWB73YWMP0i1+EtK6OkynsRZtCzTsfUfhgCAa6mAGZZMIQC9eWoTbRkoRLqD4IqYG
 NF5qhNxcoiXCkEafxZXAL9TBloSW/ETt3VX5M01smWZa7vHrH0u1hEfg2D9JfFfOur/J
 wMqShc8kLX50b9t/bESJ7FGPdAmaaPhAB8CdnMR6bIJd0/gLAb9W8fqZFndlR+nNNn1p
 lGD4pIYGPYIFqKUDWL4W1T90HxCUZ/U90cWzAFi2yybtD74GzPFeZUg1D7MtJcaEauAk
 4Vxg==
X-Gm-Message-State: AFq9FYIdMkYm1cz28HieRQK21NdudH7beZWuKWcrr591kaSLuo78PC2S
 OLtogLyQg+++XcGPhFYiyeneki+HGI1PSTAuNt09CPw+RFniZ1yFzlLvmc86DTsjXnQpBojCL1B
 98l218dRKYh43rB3GScppqtrgQAgESYoTw7saX4uOwJt8i9SzIGnd+J8wptFz/IHrPA==
X-Gm-Gg: AYBFou2Nbvauy/kifXoSBLNwK3Z/5TPXxrTy4SqDocWcgjBMVLhHmMBmwpMdJzX+xwV
 401XzPdGW1Ibuti3XPUV4CCYFDvCnc2zJdCH9VzA2fxxg7vv0QsU31sWRlp4ep02pIoprFanE7S
 rENUxB0DT5hJlIKhgLUHsdAi+9WG6Kp2JZfaX+1B0laVe59LQovBUIvKFe9n+gQ8Xhr4zhhw6eL
 r/WKZk/kNZqkJ6CGzPXvkQBxJVk+QjnYz1/XRYUquRb8nsvhV/01k428wctWfYLvAw0rTY0efBx
 /oMfPlKEyoxeb1BZRLtf1hEtzijUac+DViUs03umdwLWYvSwqwMeJfujuTEEccdooxzBnPessiF
 pKsRgdbHc65iY/20K/luHB3/pjZjzX0Kv3dpY62mRNybBe9WAaEgTFgMOgCgQsd8=
X-Received: by 2002:a17:90b:570d:b0:3a8:9db2:a4f with SMTP id
 98e67ed59e1d1-3acef527908mr554028a91.51.1792174483760; 
 Fri, 16 Oct 2026 11:14:43 -0700 (PDT)
X-Received: by 2002:a17:90b:570d:b0:3a8:9db2:a4f with SMTP id
 98e67ed59e1d1-3acef527908mr554005a91.51.1792174483218; 
 Fri, 16 Oct 2026 11:14:43 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48e8646sm4895282a91.10.2026.10.16.11.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:14:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 19/23] target/riscv: implement get_note_size sysemu op
Date: Fri, 16 Oct 2026 11:14:06 -0700
Message-ID: <20261016181410.191743-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfXxA8UUmpXllF5
 OYfMfyLaTsDiltabLYrWz+9JJOtl86dL4LmZmu82LI3L4RPb/I5xEFG/e9gs7/xM7oacJRKsLTw
 HF0QHkcrAZZCTdfXPGpXIoQl8jf/kvU=
X-Proofpoint-ORIG-GUID: bHxTxRQpiWXbrnEsjDntetC_yLRIth7z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX2oNRcs+3l5Az
 UHxe0NwC9OkaJsXoEjO0vNtZbRAUi1V+VdfF2iXC6m/ORhl7w59goDruxjwzJow7cHHOgJvbvyz
 oW8+EZzjScdLVt/DVc8jM6DyAzwYtbOPivYVsxa7UdDS/k+zrlxoxNuNXqjRiZft7BJpyI19HIM
 Lf6aexlmZBtFG8eXHw+DzimOgvM9E2Lnv4kbwvpn6rR8PXtLYQLwFqm8O7svqt2e4LYvojwloas
 gxERI4ZT+YWUZU/Z8nIZitbXREAeXgztMVB2Sk5ZqS5AWojIQQ0pqkrhsq/W3lO79WrifEITycf
 6yGQGDxYkg6v1VDnAvUFw245y+Joco/n3ijh8Nv0jHA9vNji2Xq/ODCDi9g3coj8LWH+BblfXmT
 B513v8byL1ZOTNnyDUSfKz+b6txfNCjqKfAGkBuGYSWk0zCERjkRdqEhFqtQ9be3rWcxsszRMkK
 b0J0s/CI/it8AnyvEuA==
X-Proofpoint-GUID: bHxTxRQpiWXbrnEsjDntetC_yLRIth7z
X-Authority-Analysis: v=2.4 cv=XKKl2ghE c=1 sm=1 tr=0 ts=6ad26994 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=WHTxxU84TY79vzyxHH8A:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160072
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

For now, we keep the global cpu_get_note_size symbol defined.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/riscv/arch_dump.c | 8 +++++++-
 target/riscv/cpu.c       | 1 +
 target/riscv/internals.h | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
index 13aaa87202b..74b1489ddcb 100644
--- a/target/riscv/arch_dump.c
+++ b/target/riscv/arch_dump.c
@@ -182,7 +182,8 @@ int riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+ssize_t riscv_get_note_size(const CPUState *cs, int class, int machine,
+                            int nr_cpus)
 {
     size_t note_size;
 
@@ -194,3 +195,8 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     return note_size * nr_cpus;
 }
+
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    return riscv_get_note_size(first_cpu, class, machine, nr_cpus);
+}
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 059aee855df..b202a4eb6ea 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3105,6 +3105,7 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
     .write_elf64_note = riscv_cpu_write_elf64_note,
     .write_elf32_note = riscv_cpu_write_elf32_note,
     .get_dump_info = riscv_get_dump_info,
+    .get_note_size = riscv_get_note_size,
     .legacy_vmsd = &vmstate_riscv_cpu,
 #ifdef CONFIG_TCG
     .translate_for_debug = riscv_cpu_translate_for_debug,
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index ea4b4140c09..a0b040f70c9 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -209,6 +209,8 @@ bool riscv_cpu_has_work(CPUState *cs);
 extern const struct SemihostingCPUOps riscv_semihosting_ops;
 int riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                         const GuestPhysBlockList *guest_phys_blocks);
+ssize_t riscv_get_note_size(const CPUState *cs, int class, int machine,
+                            int nr_cpus);
 
 /* Zjpm addr masking routine */
 static inline target_ulong adjust_addr_body(CPURISCVState *env,
-- 
2.47.3


