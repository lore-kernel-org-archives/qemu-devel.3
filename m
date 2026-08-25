Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00EDC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyzE4-0005cv-QO; Tue, 25 Aug 2026 18:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzD8-0003jO-9Z
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:38 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzD6-0001lt-Jb
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:37 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cbedbaba5fdso204829a12.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 15:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787695295; x=1788300095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s460w70rQILNZkGK5JrrHAiBRDkOoOpVurtRqc/D0Ik=;
 b=K7kbs5mKYi1rxxfsY4FBkRrdbyCtbWIzcOm2+oHdvTogpwnZrn5DXf8xhKuZwn+7Zz
 SCmxyNE8J+v3JN+s7oAgFFVHdC1SIPf3xJcsBPITKVHy514Uwpe815X7IZdZ0/JP473E
 t+z/wWj1Ummy46THZ6Y9RlsgpNKtfjjDUmfGBL65/uokNIg72sCSLDEojEjq2wk/K5TH
 ppV7+HworjRKDTJd4AOnOWVE8KTiQlX49W1f8LYtdTOnn1XR1swaR7rQ1PHjAl4O+kAc
 xv76LkwnELaG45cTnwJYK/yroE0OlHcvdX1aFERDVVIKDnKfEWfZPyyNLVdOoE4pzK71
 Pksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787695295; x=1788300095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=s460w70rQILNZkGK5JrrHAiBRDkOoOpVurtRqc/D0Ik=;
 b=KrSfOi2DUAdTaJDTYMaHfFLVBLbHXV1pMQ+Kr9oP972jjDUUqri9b4Jo39djrPwiC0
 DGrh+0zMFuq/PNo/aVcCdfMhgXjlESRW/5DHW5VWMqoEKH3I/DrN/K9Icd7dARVtWGjI
 oBLwvDnv4Fizo4vbvHBbTCLqGY01VTGBL/5gfa++kv4F0yljCARHnVSvzFLEVbekdC+I
 ViQHPPLSI63vJu7U8tv3NRRoCEAu52ILycmwmcednEfgjcLL+LpkjKSUtZSODoKDITTa
 eYTlV04uzyhPyvL20eNPWsyglBeho5DbXhmcGPQKgWi1oLbFfkK23AAVXGtr4qJycp3R
 DeQw==
X-Gm-Message-State: AFuF++l3xwdgwDNhzgLvo02YaQI3N5HdNsSejqcakF2skt32Q8H50OcZ
 8o4BYeZgOLC0Bpmziua6J426QqZfCrFFZeiF16Ms+cgLO2ce2VxFspqTeKjyiV+kTRA=
X-Gm-Gg: AR+sD10QPbLhfab0iTxddNswM+0G03AZTsIr4iLVl8SgpGh380OVuW0sp67+GWU+Evd
 IcDf48+P9ghORyu1bm6VP9pXK7jYhUCIDuqzmvcqoJlSd0F15prolk0RYhMMOk5c0zOF6ZOl94A
 Nr9eURx2k7/aU/ru/SFjpqduY0vlM/tSBYciU02gyOV4KisoQnvvF2M6OUaA6+nCG2nEI35RTlB
 dY2zbpv4M3lzrdR8Mmt9rAfY0Q2KhBeeS4q8IIBfKK0Qwpv3hp+V7g2pNLnMNTXMWaASOGpB1Yv
 aSx57Aa6DWSuSHpwblCfpZ8bTfHO0ZiTalN9MFE1RTmhZ9gQGzPr1mjMOptrARmE4r0iiWoTqUW
 8jhJqj65iXT4y8gqndLOE4EZPy9ZLGzr8YhsGqJSe+3WkCbwyMV1JlzHckfofcd0pFdGgJwejN/
 PRjFHQ7L28KVXoR3V6aOoR9SNtNhF6CbK6C4HIFLN9Pw3UXxMTttwlE0IR4OK59cNWFaoz4ZOxe
 ijBfeOXZxRJPqw=
X-Received: by 2002:a17:90a:d2c6:b0:392:c80b:8eff with SMTP id
 98e67ed59e1d1-3966d866cc8mr4364517a91.11.1787695294977; 
 Tue, 25 Aug 2026 15:01:34 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 15:01:34 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v3 14/24] target/arm/cpu: Don't read Realm registers
Date: Tue, 25 Aug 2026 16:00:51 -0600
Message-ID: <20260825220101.3443954-15-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The host cannot access registers of a Realm. Instead of showing all
registers as zero in "info registers", display a message about this
restriction.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a13e6dae2a2b..866ed02cf2d2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -926,6 +926,11 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     const char *ns_status;
     bool sve;
 
+    if (cpu->kvm_rme) {
+        qemu_fprintf(f, "the CPU registers are confidential to the realm\n");
+        return;
+    }
+
     qemu_fprintf(f, " PC=%016" PRIx64 " ", env->pc);
     for (i = 0; i < 32; i++) {
         if (i == 31) {
-- 
2.43.0


