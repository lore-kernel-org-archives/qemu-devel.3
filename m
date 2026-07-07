Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25B9C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 22:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whEW0-0001Qc-Tr; Tue, 07 Jul 2026 18:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEW0-0001Q0-2t
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:44 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEVy-0004CO-JH
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:43 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2cc8e87f29bso663195ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 15:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783464221; x=1784069021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2LOuBVMlOe80id4VIdSsW07pBBJsvlGWj514CqDOCv8=;
 b=fmbzBKKGITT425ms5pGGV0WXpFdXZFk/viZNFc2Pc8ms53apYidwrwMrMBpfa+S89n
 v1m2NLzxCM0o4GigvC7q8sGnaU3Z0VTshWNHxgDvH05QE82qKIHnv5aqLQIqQI9u2p9W
 V0dhM6CjzotRE2HrfjrXybbnaM5qDcQbTBrg+TpPxiQhCbl/5h0MTQZZNGIbeVWOERlq
 NY8heDnr/GZdL/t1T37vkJFdsHDWDJb2pNuWT9FeSN0UcHIaN/TH7g4u+rbFP4Ui5hfl
 M3c4M1/1+zfdIIXUxX/WGJ3Tb63IPtp0Cd2N04i41xXT7oMBzl5igfg7815lRCx1mRT0
 9gLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783464221; x=1784069021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2LOuBVMlOe80id4VIdSsW07pBBJsvlGWj514CqDOCv8=;
 b=R1c0C+Q1ALgV1MOyRjhwRR/iDBDqC1XU6gGhEOC0BCD9hfvZey3JE8GG9nBNNIOfb9
 sIA95At11ytVyoBAc6zMDW8sOkpY2Z8+psKHWZR0ccL0qImNumQ9uUHNYYA0CkT3lKW6
 3RdFrchlbx0nBRw2VcWbYh+Gv5kcsnXeMVjyD9aq2jw3PLwJQ4TnnnFOabqTiYLvh1oC
 3+OzZrWzJmVAqEJwh2cWxhlhJpaV5lRP7im5N2j/l/izi8hPguA/ME+po4jn4fboboMN
 aXP16gP2DQlUld0iunuWT6vHqJ6DUfMf4/9wk5MPQ/uEysoC6KvqPSGKylAWMJmohJCw
 n5IQ==
X-Gm-Message-State: AOJu0YwLJeEUiBrcjBIs8R9otUYaRBP3Vh8UAR/UmFoc5kcFSr5rUn6b
 52Wf2sOb4besy7MAxFmknnSe76Oi6QINEDDk4XjRNxfNkfz/E/Sh66JFLebztmfKcKY=
X-Gm-Gg: AfdE7clGq/CmFoI2VqvqPv244dhXGan+dxZUppl//fpvpiTnc6MrR5BIQwzmMAiLNyP
 9LeGhohVVydxpcfj7WdTkSfU6S0w4wH4QGRRtaZ28C4mVZRwL4OFCq0kACZGbfoi9oRmRbJED0V
 cCAT2u0uRG3XMP4N+B2AqMACwTVeOaH4s9DS/yvZfbeYzGshSXjrYQTc3eQ4d/DLJL17Hu5+uUE
 TsCLckwus2Y1LriPh5PrOrrNMaZbxY0ky0EYakFRRnYNYarVpJ2H0QHv7dYsw/AHafiHr+7kFAX
 w7UBl+OOBML8F+NWfA+BzXwluZtP9qRsaKprSTg3zx4LTUwNm84QGJODjMegsY7t4i2xTASw+I+
 OG5+Vryd03WjhIN1YnNumLdjNqZtjNl7W+aCh7pmikz43eEhahgB6Mf/y5Q8TfpezFgTHpv/9WU
 jRdnsF32WejDRQ+o5/2duO4xebu8OkbaqitD4AyCOAx4qd6GyWZQ==
X-Received: by 2002:a17:902:d486:b0:2cc:7759:ffac with SMTP id
 d9443c01a7336-2ccbee248d5mr67274915ad.30.1783464221115; 
 Tue, 07 Jul 2026 15:43:41 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 15:43:40 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, jpb@kernel.org, lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 15/25] target/arm/cpu: Don't read Realm registers
Date: Tue,  7 Jul 2026 16:42:56 -0600
Message-ID: <20260707224306.1202330-16-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x62d.google.com
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
index 787e4dc7ab23..7679b8758262 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -965,6 +965,11 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
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


