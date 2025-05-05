Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7B0C3ABC0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC56x-0006DA-LS; Mon, 05 May 2025 19:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC56s-00069L-R1
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:30 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC56p-0003VM-Kn
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:30 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3035858c687so3756666a91.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487226; x=1747092026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hckfD0sziqBh1sSWGP9c0OUCVTgvBeVKgVHtB7xMeJ4=;
 b=dgF7GdgCLgTsuNByqY/afSmBk61DtB/ipRVeBr4zomJLUy+cpv6jjedWzyheB79a6X
 HROBkppkcIpD4e0i4vijApU9F7pO943sj0Qp6fhr7DveAVCNxt6VHe323gaO9GdTIoJM
 v0zKoS+MZzKHMrdG51caoXIC8af5uGbWV4BoSX3wh1dcwUd5mrk6wR+/Mwkst3NqoPsI
 SSalcwBefFbzCAz8xBaEzegfPD1RsCal7qDpB/I7eRPnxj/sPRDzPp/3MDqs1gc+r9PR
 HKgkOayEj/DXgBgeI7ijJB/JSKyiiFfGAkjmvS+ou99CokyEEDlK1rsjjC8oNrVYoogd
 tEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487226; x=1747092026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hckfD0sziqBh1sSWGP9c0OUCVTgvBeVKgVHtB7xMeJ4=;
 b=B7xTyiO/aPVOS/9V5CFCIsdoiecw4YguPDshoU7rRMalWtBUtrmSmy6wGLRaWVm3t9
 2lS3I3RmNlklvbB2jGLDcANbcJ0oaWNP1Y3sWC5Hi+r2dFlaFj6ZlpMTB+0TTPcH49Qg
 VX4dkAjobcBNYNhPkQTkp4Zk8P1p5v1ykErPwrIq0Cd7Rk58CjZ1/Rbms2m1uClvoixb
 r8LE7chu7h5dl1i+9zDKQWN23OYxG+hnLTu8oIckwhU2G3qg3EXL1BNFMSBJHpVlQ45/
 12+Wx0+ao61h/kMVuoopf1r8VTzjzXHAJu7txN715xLiuVf0M6imNUl9zHJAmgfDOpu/
 LBPA==
X-Gm-Message-State: AOJu0YzXFxzb1ymDdIG+lhkuMQJszISWSUPRVBLaAzoj0sbeXHlIYJCY
 1lelG77L8DY/qAhg0x4mMV12S7lsoGLnep9IZe5VIGwme+3Lcmnf8Y/iJxOXyT6qFqKQiUPltxm
 Gh8k=
X-Gm-Gg: ASbGncv1efWUeU31wnTY3IjAmbl9xQx2fogWJXUe+6wwCs9aJZihvJUPhU2SaAQa7Hj
 6TPaj/HRp0P5RwZYDyvy7xkif8J8g6jr9AA1ZkQGmkJL3fsi+RlqIk6e3VwcLpdMXcVVz8E5QQI
 +0BtAc9MGXJ+D70rMH6MCNZDeY0TG/Tmo4TwyFb2Bw8VpH7juaeFq567yfwEQZHzqhfpUlaHPyp
 bMrXM5i1x2ZWdjRAq0s5U28kBbUJ/FCa+1FVmf51uU3PXxfZMPLvufXVTQO6mx5T1cYMVTuhyCN
 48nBVfh8MfSyDXkG8pcFVt5/CE/Vv/RdL+faYbRu
X-Google-Smtp-Source: AGHT+IEKId2hWCnJS/+NSIvZmGDfi3jgk5Oq8x6EKCRZTAN5kZeEu43KoC+oMuNp2EoM3sdXTPMLDw==
X-Received: by 2002:a17:90b:1cd0:b0:301:1bce:c255 with SMTP id
 98e67ed59e1d1-30a61a50832mr12860527a91.27.1746487225925; 
 Mon, 05 May 2025 16:20:25 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 06/50] target/arm/kvm-stub: add kvm_arm_reset_vcpu stub
Date: Mon,  5 May 2025 16:19:31 -0700
Message-ID: <20250505232015.130990-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

Needed in target/arm/cpu.c once kvm is possible.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm-stub.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 2b73d0598c1..e34d3f5e6b4 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -99,3 +99,8 @@ void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
 {
     g_assert_not_reached();
 }
+
+void kvm_arm_reset_vcpu(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
-- 
2.47.2


