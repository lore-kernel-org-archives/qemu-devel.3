Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90984C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 21:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQsB-0001cP-0E; Tue, 04 Feb 2025 16:54:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfQrx-0001Z2-08
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:54:09 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfQrv-0008US-F8
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:54:08 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2f9da2a7004so672638a91.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 13:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738706046; x=1739310846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j2FzoHSuAoX+1zQ7RA2/urh/hio8OfZSmlzrSvDG4W4=;
 b=PAOvao2ptAE7ZcNTocNLHNFC7AjDnGRq5GLUAzRyrUkeHvJ7hcebZj46Xnp3qzIcSp
 vA8+H9sLtw0M64qcV/n5VV80127kTtDILzCbSLr0NPJpvU4Bc1NrmCSjsUEPxjh3WD53
 ZwL2J/W4E5o52tdi/zuddcFQaI2jC8a9l5w8Ckw6edRBVm8QORH6SkAsgvQtiuDsuF4q
 U783ekSMITmXceNq7GajtPPpe+LfBfISx0xvhhnl0MraQTKrst4pKd6Zo4wvSmvXj0Dc
 QnsSSVwm5o6Xm/2GO6MYNR38DvQyes+qperaJyxXCDWAgi4OIGZLA7xa7x5QwKvB/csF
 UpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738706046; x=1739310846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j2FzoHSuAoX+1zQ7RA2/urh/hio8OfZSmlzrSvDG4W4=;
 b=fdQKxMTOplHfbIjktKmcF7MLywhgRrxGvYspo9ENt+G4pPKXvbt3k2F9MEmOVsob/+
 xJX9o0VVLKeTkhqOdQYjjc7GBUjjsC9yT1ItGVHrmwlEhyzg0ti+AJIvlpELrEJ6DnRO
 9y8UqQOlB6P1qmrFzDaG+42kxA9rje2fVAIOVj8+UbWyG5btR6t/0PCZry7SznSw3S4T
 iZ+hRMmHhMUavDdHKJDg/gcGxMYYbbg2DgyQ+3CattBlGWC+uVJiuMRLBnkyNvxBaqCb
 /SJvunpskU1RQka+LF9o9SPNKMNRlGdmCpI64VDHS6yTm1vrJoETfB65eRuupZwyBbC/
 OxRw==
X-Gm-Message-State: AOJu0YyN8mnNBJrpeansAsHG4gck2WET6LbL+YKrEgyECUiDETtZ9nLI
 9+hyBXi16N1+zzSv58fyIApPWTAhBDevM4z36lGTZV3mSB5q8RoehqamNeAGgsyYnR+MjT+01is
 t
X-Gm-Gg: ASbGncsOC2KRPZOgYnwLvZ+qJXATOOXmmJG8gXlRJLV1rM7eNfe5XRNpQLy6TNO7HCy
 8rWfVW+wJEk+coxtHngNcKeEm2cAg4HBBjPfKhuqt1NVU4B2EOMdDVE+wIyH1YfgX6AWxA5l0Jd
 lzjG1gUoJew2FIRlgxyA8cKinXN4/A5aBDef4yVruSfe/Pz8qc4T6izcb31NExg7JrszajOvjK8
 fxBtlSSD0WrfIXtxMwSK6KbpIO9uo4fh2zFLfYbe7GYHz8C3XRv4mbaDBy02p7NQsmLFk/iOTws
 fgUTUfpV1AOwWR5whVhrzdu11u+IL+uDM7B7WOrYf4cR79E=
X-Google-Smtp-Source: AGHT+IGK2nBlBlheukBIc5u1PmVI4QupaSBfiH3Jf65IQNX4JgwUkONtwKNYvGuU1k2oAXScGOy4Cg==
X-Received: by 2002:a17:90b:2247:b0:2ee:94d1:7a89 with SMTP id
 98e67ed59e1d1-2f9e074d1fdmr508250a91.1.1738706046038; 
 Tue, 04 Feb 2025 13:54:06 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9e1d60b57sm33888a91.9.2025.02.04.13.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 13:54:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 07/12] gitlab-ci: Replace aarch64 with arm in
 cross-i686-tci build
Date: Tue,  4 Feb 2025 13:53:54 -0800
Message-ID: <20250204215359.1238808-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204215359.1238808-1-richard.henderson@linaro.org>
References: <20250204215359.1238808-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Configuration of 64-bit host on 32-bit guest will shortly
be denied.  Use a 32-bit guest instead.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .gitlab-ci.d/crossbuilds.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 95dfc39224..7ae0f966f1 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -61,7 +61,7 @@ cross-i686-tci:
   variables:
     IMAGE: debian-i686-cross
     ACCEL: tcg-interpreter
-    EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,aarch64-softmmu,aarch64-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins --disable-kvm
+    EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,arm-softmmu,arm-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins --disable-kvm
     # Force tests to run with reduced parallelism, to see whether this
     # reduces the flakiness of this CI job. The CI
     # environment by default shows us 8 CPUs and so we
-- 
2.43.0


