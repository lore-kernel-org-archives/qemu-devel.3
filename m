Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784BFCCA462
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHT5K-0005Vi-3p; Thu, 15 Oct 2026 17:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4a-0005D4-TI
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4Z-0002Sc-1j
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:12 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FFE2LO2678271
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6HLvaAlUVPB
 yVR+Y40fMkyXdIzksCs4/HkcBtIZ5IU4=; b=iaarwkuttSyI3O4OMVjbkdmLCQ0
 IuW/z6/GMMshV2AyyOxl3DatZu4myfS5n9UwwKITsmBUje1QF4Ivy0l8eVAjx+s9
 k4Z3qE6G2e402zXqx/H42/X/+tNfZqnqxC7yp2tTieYFgvsC8qVC2Qt8uSlghsup
 cRCneuOLJlCnUDhJsQWr3syXaBBnjOTH7mXlXlkfgvutRe7SNG+TJY5Ss00VvXvx
 Hy8S2JJ2WKPbt1EQO/CMJaRw2QHbCrpu9BZP8B1iRC6+zwMG2zFzUcjkmj4QKJv5
 MVnBJnDklnquH0yDAaEBdJVgpEm6GnJSQFHqrxxlqb4ymSFFm32PNwjg0Gw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb19t9ee6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:59 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3a46f0f158dso541623a91.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 14:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792099979; x=1792704779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6HLvaAlUVPByVR+Y40fMkyXdIzksCs4/HkcBtIZ5IU4=;
 b=C58QWk62FuyKPHqRCkzBVsHWdnVEF4FvDPrsWFR9Ep0raw6xI6rZ7lDFcphR42NFRc
 rDsPFDGVKUk0V94PRXAO5POlvYPjutzlIv+LtaWjGVmgFgxEmvQ5j5TFzxK+Qy7LZEkJ
 LT5WONtnq3Y7uKQBlR9Dxda1b2bW4ykTFm1zmEq0g9/HEq3cQ1b+72LGjBMMY7AA5FMD
 CYCZZiMMm271FJNrnK6yxvmijNd74vCmSJzYLTK+rfFGEUYvdRMvCVzExYrZ7TlVgR3m
 h9XtEepIHESPokUm22gwMq/ekasSwt25ALjbM4cSTJD6tx2FaTEIMEqs/BVZMQP9v+Fx
 e5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792099979; x=1792704779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6HLvaAlUVPByVR+Y40fMkyXdIzksCs4/HkcBtIZ5IU4=;
 b=y0tYnURDAa1NZ2ypSgHkholR7CyeK7+AtutEQ49njKgETjbAgNVtKiMTnV9IBv+PXi
 z0L6FSkA2HrhqdENixIVxSvjhGgJRd7NgScBxIlywVYysIH3v65wgiOk8C1AOq46pB6D
 rtbpIp0xeQ7uIiD3N1/y0tlTR2ukqjGAQTFD9iuKIJHCq/BZVbk0YDnbrSxkC8Jhjr5V
 cRevisOCVL5GwKxojw1N9puuh5BFg1HS3Ev3YHFFxdsALUNShOdr6z4kLXayPqQxIkpf
 0s1ZESl8PYCPN7hViWtAfg+0i28OAQf0pCmNzOHn/ot276y77gw/iOd+eCpBd6fEXQRB
 eJcw==
X-Gm-Message-State: AFq9FYJHJDZ7d3mJjtETr1YAgs8+Ru7z2NGhzBdoVKo+ypMYP4H053ju
 bO76YbrMgSp7rDmPvUWO8MLddQvlGvv0WZbx3AfljqBl6UiiTx44+IjS1mAXz0v0CH9jZNigT9j
 FO7LYTvB3YfDBB2AYjMBKsEvic7QXHFr4P0hmsEKzghL7LGVjaNKlspw+29XdPJ4Rig==
X-Gm-Gg: AYBFou16iLxZhMf5IXW39Doe+Iz6Alige8RIAyP7Ei3wLkGQgjjJskU9CrfCnqA0OEi
 iPgahXo4oGBVhM+eXaXaVdbdKjCT9T66RgB2KVo1B/N/YpckkGluhai2ZqWnBNzQFAj0Jo3Js5+
 zGkEhvSgZ+PFydVLe2nIS7kYbZSPtvX36iPIxQph9X6OKQywdT5iQTIqozBm92xXACqcxl/q+NC
 NmAlJtgxEAP1rybcx8E6Wd2ylkzR1Egmc3vfoauFho2Dvw6ocWfhfunThzXc990gcMuwkTihCvt
 z1J6nMAKjH8tis3wN6+cH4AcDskFj+i3bAmXSKi3Qii6GcYOZUi9C6b66t/uK8mZRw42NePmB58
 aBoS/cjq29aRBdksuQtxqiq8UEPplImupE9a0SNu2MH3v5XnbrNG1dwcqAaCRNzg=
X-Received: by 2002:a17:90b:4f41:b0:3a6:f6b0:30ce with SMTP id
 98e67ed59e1d1-3acbb8a8b96mr820093a91.36.1792099978762; 
 Thu, 15 Oct 2026 14:32:58 -0700 (PDT)
X-Received: by 2002:a17:90b:4f41:b0:3a6:f6b0:30ce with SMTP id
 98e67ed59e1d1-3acbb8a8b96mr820076a91.36.1792099978293; 
 Thu, 15 Oct 2026 14:32:58 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac940055f5sm5989362a91.0.2026.10.15.14.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 14:32:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, anjo@rev.ng
Subject: [PATCH v2 15/19] target/riscv: implement get_note_size sysemu op
Date: Thu, 15 Oct 2026 21:32:32 +0000
Message-ID: <20261015213236.157767-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: V9SNhilfTCYnu9xjzUxTI0NtC5VwEq3d
X-Proofpoint-ORIG-GUID: V9SNhilfTCYnu9xjzUxTI0NtC5VwEq3d
X-Authority-Analysis: v=2.4 cv=NqZE4MdJ c=1 sm=1 tr=0 ts=6ad1468b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=WHTxxU84TY79vzyxHH8A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfX3Mtf/Hvdqy+i
 3ETSGmk+2z1cgFByHgaNC9xQarJARhqlhUo0R52lWlNxoHYaT5NYbq4HZxWB2vNWFpOzNqtlALK
 bso5yxZINNV9QrasKAdznSAuPwt2pXX3sBwLya2JfBPM1jEoVj731CAubWRqaUzpEjLji8CXVyC
 hrWWkCNJocb/BMGjHv0qC4Diiw3AhnwzUsQXsFvwX8K6SQKlCsnpGaf1S3mn7Q2QU4E2P/taDhh
 I9Ks5YlNFKiYre9K/oaYQJKJiHt6q1/vaHXMttT+FTJ73yrnvC7wLjzqiZtLCpCAgf7MEYDzlbj
 HnbMJnXAKfZxLnY3Xh+Gsqrf5sDlN9sQ6F1zu6lYlADf45mmY2YfoMiq13jEU/MU4pLDjqK6FCE
 vjsfhXNgta4YVDyIBif5QRhH6OSQp3Dbhwy8iLeE6/gNUd1N3GSe29ZE583UCRnCh/P1BYgi1Ks
 gzQaSR1sfr3keDSPjDQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfXxbUdskOrDCiq
 SItuPGDmi2/awBmkiM0YJoPxU4huimErWZBr/6La7vdDKED1+w0J4FD+KEickdREmSubwQANG64
 q+E5o4m8Qz7PqvvpS/f+UQ+93pDwhQM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150085
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/riscv/arch_dump.c | 8 +++++++-
 target/riscv/cpu.c       | 1 +
 target/riscv/internals.h | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
index b2138ada1ec..e6c18518314 100644
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
index bfaaea94824..93a3f4ad8dd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3016,6 +3016,7 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
     .write_elf64_note = riscv_cpu_write_elf64_note,
     .write_elf32_note = riscv_cpu_write_elf32_note,
     .get_dump_info = riscv_get_dump_info,
+    .get_note_size = riscv_get_note_size,
     .legacy_vmsd = &vmstate_riscv_cpu,
 #ifdef CONFIG_TCG
     .translate_for_debug = riscv_cpu_translate_for_debug,
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 8a94aa0900f..03be7e32405 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -210,6 +210,8 @@ bool riscv_cpu_has_work(CPUState *cs);
 extern const struct SemihostingCPUOps riscv_semihosting_ops;
 int riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                         const struct GuestPhysBlockList *guest_phys_blocks);
+ssize_t riscv_get_note_size(const CPUState *cs, int class, int machine,
+                            int nr_cpus);
 
 /* Zjpm addr masking routine */
 static inline target_ulong adjust_addr_body(CPURISCVState *env,
-- 
2.43.0


