Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165A9CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 13:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZq90-0006G2-70; Wed, 17 Jun 2026 09:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZq8y-0006FL-OK
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 09:17:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZq8u-0002yV-3a
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 09:17:23 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8V60v2291351
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 13:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8GztL1Elr1qdIuEyXh8KObvYDmXHW9cI0PCqtZBYkx8=; b=TWkQyaRHzN+Jn+Qp
 1IuPF+AYkdywPZfEi36qCi3wEY6zcVIf9OhLuy7JCx2wigcxD9hPopNJpe0G0bJv
 L//sj7rRwUfosxjnVD+CDYpi0rC0zn2DjtUbfICO71GX/9xLRzreWLPtOlbOaIzD
 KDOil+LJO46fkKiJ14GH1R2GNgm+XyZAt5h7ChBW9GJcB6UxAIUOdrKs2yAPVA/e
 U5zlj5R1YMhxNaS2cQdB1nErl1c0/P1deR235tyEWe8Pz1ugfhDbRp6yRNef10EF
 nMA1y84oN2Ijtkm1NaQo+z1U7gIq9Otubrezq6pWKsEwOXz89MhZfPXwgxLkuZce
 LHPOGA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueevkb1a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 13:17:18 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-7ff705a4289so710377b3.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 06:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781702238; x=1782307038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8GztL1Elr1qdIuEyXh8KObvYDmXHW9cI0PCqtZBYkx8=;
 b=hN9IWE4uaPLHuC4geIsZEQdwwb94ML++Pa53/y/ryHMrdSmSAhF2Xnm6UzCKk4GGd7
 dmWL26q1N3vjMi6nBV37ay6az100iqymGdr7oqWHjJEhVDu6L4DOlHygzOWErXE0FZT3
 fBiJ2zqvIbRFKl4GH48pyInHJ3p4r2nOMGOQSV1DLLqXfl7ZV9XNPmVfCDWjBfiUl7mK
 KnGcaltRm1xa0IN++c3gmZZ1LlGRrDQbOUznFCi6DLjFl4b4Ukp+Vih2euOw9ZSGZnPm
 jalKBd4ducOKIfeGI4W+9KDDHpACuuOEU4aUGpjOxy0zTkaFRQd7LgmJ/Svqb2kB+Ed7
 zdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781702238; x=1782307038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8GztL1Elr1qdIuEyXh8KObvYDmXHW9cI0PCqtZBYkx8=;
 b=fnQ4i0HnsCYEkxTL4NzZls5a8nEqc/fzjWaWGjKGxO9KMYiI8Med7boj+tAd1Cwnwr
 HMl3limqR8ch5YOy/UfeKtL74+NDS5UeKBTsTJ3C4GLcjAQPIjqfnzZKUCYMfatf1Pq9
 88EQNYkKuXfqfoYQsFG9BwGd6fZNDyisvmLeMya0bB3wRJjCQShjYYrdbFWjBzwZh3j3
 MZYyXGkTKpgYDGl3NPqZKPFQ6M1rIDfPxRfSbWP1++5yWNXwdMZuIKEP25AWuhWT+IKV
 V4tx6uH4jC0AvwBXMwyThFjxzOPwvWQjThKNqMJce4RcaCLohq0LGAysFGLEgf22qCds
 FDhQ==
X-Gm-Message-State: AOJu0Ywq74JNwnB1Ndr+AtQWBCaTpvU+qIvFa6O4Igfsq4WX/SE7EDoa
 8xwUYBYT57usNX68IRxr65kGbsVnXkiutfDzOIXjUnpINrS3+aBjJ4mTJHFvPaVcYnF8qTimcYU
 Z973KFmCqmfnALsQtfOHhDxOx6rwwWk8aUkP/V4Jp+vcz+P8rRuuvFGl+o2GjySD90w==
X-Gm-Gg: AfdE7cnJzJmnGMpyeBE1MclYXyn7yPVOyXfJDvfQDpQnSvlUFzoGTXZuH10z7GvVQQp
 FAZ3rP7yaqOQyiqJK0ldbSQFBMiCV+8v+AUN8LgmVqnS+LOtJUs9cBSr3ZdvK6xNlX+JVJyMCnA
 asXqIlOS/MAvtnwDplENbfLuP8/33+H/UkfKkyNHDqoKk4h0RfmBQKt11D2hIazfMiMzPY4Z6Sn
 p2PbiBjriy5HEmuYBEugMjhlLs5DoG/HFRjRr8i0X+w1iD5ugp1PKVYMtHkuyNCyzcL1kZi6u0V
 zBqytjHgS7iIMwJaEi74o8HYbEnVbT6fqIrIddw37tUzvm6CJwdd4OZq+8Jh7tCb1EgeoBmjs0Y
 n4Tp0Ozoxj6yMJpNKaoX0mgoGrB8IA0LXPlOEPUz5F/PJLwEk
X-Received: by 2002:a05:690c:7403:b0:7dd:3f36:59e3 with SMTP id
 00721157ae682-7fe5de9ccfemr36529477b3.36.1781702238292; 
 Wed, 17 Jun 2026 06:17:18 -0700 (PDT)
X-Received: by 2002:a05:690c:7403:b0:7dd:3f36:59e3 with SMTP id
 00721157ae682-7fe5de9ccfemr36528877b3.36.1781702237809; 
 Wed, 17 Jun 2026 06:17:17 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7fcd345a5fesm44861707b3.36.2026.06.17.06.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 06:17:17 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 1/3] target/riscv/cpu: add CPU unrealize callback
Date: Wed, 17 Jun 2026 10:17:08 -0300
Message-ID: <20260617131710.1855353-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617131710.1855353-1-daniel.barboza@oss.qualcomm.com>
References: <20260617131710.1855353-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEyNiBTYWx0ZWRfX6x3hHLtRYsdI
 BOi4V1ppUb+TYh9AnKDYDbSG/NqcFYvgFVUch0gDeyyDJPLYWZZHWGjPDhoUl6DzbG/EVixXRhy
 Mlw6A2gmuE9GwD+TDg1aqeq3K/Ck5avjlPbKbk9CIWsRWglM12OO7XUPV59ZbIUp+BOxYSffp11
 mZ3/tWGXuPHmYdsEYf3CyhG9j6ukFD1fyZor8nAbEwNDvxSOUHG9p1JZmmwI+tunyvzQb/JLNuF
 3dc9blB8bKbnbC4RUe9VUkrzekCdoDqSHbZ87TwHi/GYtdHPRNr2243IOxXqDuFr3uTzAuSn0Fo
 R0IUnOwDM1UVtBfHTf4kjlD6LHDl7vmSUZjKKWvgWNptFoCk/zIS0r+rV7460idNkPocSlyj5dr
 K8h8YoowM8cCoGF36oMYvuKaaH+oORxe1vBdeVJC9nBfZXWR5Hlsf6N9HY2/N8PBVi+F/aDEHpA
 bFxPtzoDkRe0TCI/uXw==
X-Authority-Analysis: v=2.4 cv=LM1WhpW9 c=1 sm=1 tr=0 ts=6a329e5e cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=-V4TLcwJ7WInddZtJMgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: cDKIRaDAexzNkM5i5-TqwPTxwHQ3oHqN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEyNiBTYWx0ZWRfXyYK5uRMFJKVB
 uZYTbp2MukXRcuGR+0bo00JYoWBCpLU14xTmwhb36cPk/vcX/y7/uVWjgvvlY3Hv6e5nTDAePZQ
 YxtPJ+mCOSNIvwOC5wBb/H7r/rhgfa0=
X-Proofpoint-ORIG-GUID: cDKIRaDAexzNkM5i5-TqwPTxwHQ3oHqN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170126
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

Next patch is going to dynamically allocate debug trigger arrays during
realize() time.  We need a way of freeing them during unrealize(), which
doesn't exist at this moment.

There's a lot going on in that patch already so we're adding the
callback infrastructure beforehand.

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 9 +++++++++
 target/riscv/cpu.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fa497e5e8a..b47e2b41c8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1009,6 +1009,13 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     mcc->parent_realize(dev, errp);
 }
 
+static void riscv_cpu_unrealize(DeviceState *dev)
+{
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
+
+    mcc->parent_unrealize(dev);
+}
+
 bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu)
 {
     if (tcg_enabled()) {
@@ -2664,6 +2671,8 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
 
     device_class_set_parent_realize(dc, riscv_cpu_realize,
                                     &mcc->parent_realize);
+    device_class_set_parent_unrealize(dc, riscv_cpu_unrealize,
+                                      &mcc->parent_unrealize);
 
     resettable_class_set_parent_phases(rc, NULL, riscv_cpu_reset_hold, NULL,
                                        &mcc->parent_phases);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7582874c35..16e9f87b83 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -576,6 +576,7 @@ typedef struct RISCVCPUDef {
 /**
  * RISCVCPUClass:
  * @parent_realize: The parent class' realize handler.
+ * @parent_unrealize: The parent class' unrealize handler.
  * @parent_phases: The parent class' reset phase handlers.
  *
  * A RISCV CPU model.
@@ -584,6 +585,7 @@ struct RISCVCPUClass {
     CPUClass parent_class;
 
     DeviceRealize parent_realize;
+    DeviceUnrealize parent_unrealize;
     ResettablePhases parent_phases;
     RISCVCPUDef *def;
 };
-- 
2.43.0


