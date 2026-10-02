Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFDDCA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 20:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCjki-0007aB-4p; Fri, 02 Oct 2026 16:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjkW-0007Mg-Qj
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:20:56 -0400
Received: from mail-pz2-x2b.google.com ([2607:f8b0:4864:3b::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjkT-0005nd-UB
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:20:56 -0400
Received: by mail-pz2-x2b.google.com with SMTP id
 41be03b00d2f7-cc78d59bb02so3265266a12.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 13:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790972451; x=1791577251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wM7DDMRNXZ6kOtLnUpES13DSbro3EyKRePerUlcAXQ4=;
 b=RVLeIhhwxZB+o/ksYI0StVrbTFXJHW4ARwOrKKMWPozJ8CoE031KEx0tAEx/xw9dWx
 T1u6HNUqvSi2nL1QIE1IDqXAXKRwdJW0ZGTOf6Zf+vuuUOpuBB5PpNDuhYcksCumS6P8
 3tLJ2/2vR3t295+yXBXnw10ydZ1UaVAPWOkILl4LDRLF8vtuklpubljiW1hkU+u6nF/7
 Ed/+vt6LR91l8xacPOPm4HpSY4ajbvobmTH7tVTOoypls2GeFLoaMv8dmzRWMEHAaD0v
 u+X1CKg7PKeLcXVCm1zYnn7k1nqSRmtFMh5e1FQcCDNzCXMYDRIeBeV9FndEOss3cIUe
 qOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790972451; x=1791577251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wM7DDMRNXZ6kOtLnUpES13DSbro3EyKRePerUlcAXQ4=;
 b=lDD/xFTt2hkgKAa8AoGn8DkDctMdB64KsLsP6wHpQbLUmGPYxxWxIQbWrDeYMZIjA+
 F8Fprf7g0BcF6rK81Q8SKRE3U4OuBO+rU1VcBHnglN0DDzrbxIpx677cwaQu+iVVgmfc
 Hv64G+bOBRU9izCq9DLXPVjo9Z7Eynn2moLZvAmR+HPN6ODL2iUDBpS9Chur6S7WpHAD
 5hE9iKXgpkdLvKSREl2T1KYQd3UyFz10WUrdgcgOWnEvWeQdUyL99UwnnRuwkuLlQeua
 zxfQ+fZMGerA3mAVFtoePTbe+azaBOqRURJVDYa7krTOJIsotQsmnZuVg6EMBrRP7V8j
 KeNw==
X-Gm-Message-State: AFq9FYIcp5PIECDzXV8CIzfzXQ400WrJiYIr1E7c9/oXPPCVEqIMmsyp
 g+rOiQfF/KCCHX3UHUTVeEtXyUvPH/prxGa3+bb9E0mOau9qdf+QbvmJnYuQGXCn4DQ=
X-Gm-Gg: AYBFou31mj5H1mlB7WkNAdt3Np2P+uvfPENzt7pDc4SCft0anA3rR81cv878T1R2wq6
 c7aHkG5gLZVpc8wRJe+NVUbpzhvVPfms5xvc8mTLagDdcwNrRC1dzwRP9uWNL3zK+GCZgznw0fG
 pL/QmUqSf/pKex2X8OvFDlLqRS0ZIa2OmGAE/IftpObJnvwPrasTZOc3R3XlWFvk1cZNJOrdYeT
 qMmkCgdVx+hcnzEbf/1a8sWjEmFXbu2sFm70VQR+a2v9k4uGlVofhOwZ+D+ZJZ5gug88yOw0G0R
 ppoAPJ/WE6gakLrcB8sZkPh4WEivcGUzg4XQbuM93tPUqBc+Wf+qEM3STdjA5/6zJip9EsruvTC
 urMtbgLGg14X8Nhzvjd2TyuyWNzRGMSkZ/ys9fnW1159FDp0vPYwHjiT5++C+6WfvZSCMawd+oS
 nlK8YKS2fSXydLXs4pHjPQ8DZ5APgZBRQ/62sM5Hc4anGwsZ+MbVVtUAKo5Ym8jXaWoG12Ow9/x
 T11xQ0t/rMBEEzAMeio4yoK
X-Received: by 2002:a17:902:d2ce:b0:2dd:c100:4b77 with SMTP id
 d9443c01a7336-2e49b6adb4cmr32416315ad.46.1790972450919; 
 Fri, 02 Oct 2026 13:20:50 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:61ac:e744:6559:a357])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 13:20:50 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 12/22] target/arm/cpu: Don't read Realm registers
Date: Fri,  2 Oct 2026 14:20:16 -0600
Message-ID: <20261002202026.1204110-13-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2b;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pz2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
index 10ac6c983189..73bbebddcdb0 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -967,6 +967,11 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
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


