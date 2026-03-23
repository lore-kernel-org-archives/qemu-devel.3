Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E66EC01C9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4cvj-0001te-8P; Mon, 23 Mar 2026 06:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4cvg-0001rn-OJ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:54:40 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4cvf-00065e-8Z
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:54:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso46798105e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 03:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774263278; x=1774868078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=93M7NOlE4KuSJmzP57okoBM7XVBUJORTOt+EAqM7cIs=;
 b=wrcBewbiEanazeytWifPtdNbK8bKV8A2k8m9N2rktPXfWKy3L4wqcD5ZjXitgJGe8c
 WZ71r1LKi3qKsR29CMxaJ9eG/g2fE4TVmYkUkPdi0ukZfy4w2s6iVwXsh3c6ogAfdDc9
 eOo7wxJDuf1IZVQowHfV77LmAhL6gfjYTQGsxoa/jGvKmfGDE8Rw1oxgxsMg9euejxAY
 wZj6b8Oosh5mk6pg0KvQRcKHxoWaLTCA45kreLKBXXzsKnTn98XqXwipcRh+dnezLybm
 QVBxjE0Xl26l5OA/EFczHEJ8CCaSJZiJQzMLriR9vIpAR8J+CNb7PXQceM460YtwX2mR
 s5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774263278; x=1774868078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=93M7NOlE4KuSJmzP57okoBM7XVBUJORTOt+EAqM7cIs=;
 b=Z7M7rxQNbVnb/E0SZuGHEicFKDEEXYWvZy8HQedYqhe2bjADbMI4lcXckekWHf/Xjl
 NJZLcfXYxXKSmlc6s+ciWcd0FNuuoAHIKV41Ms3cIYn6Y/Klah8CmCGz09LvOQKMgSvx
 PV30kn/ewM92bU6lMmUS2gIbXz+IVEFqh1dYODFVS0H8qQ5aH4rb77UC1TwiJH7QBHeK
 orSWpFIxX8dcogSc19EmHthZLmo0GCRlXXCWy1k+McuQ5ege8gg7NeukFuf4ZzmB5HN9
 mrsCE/DIPuUFOkDXAjb0ndjs5IuojtDPQ+5i9+cCHF5Rkv0hYjNrZnMXk+Auw18wJmZg
 v/lg==
X-Gm-Message-State: AOJu0YzhjyHSIC4z5XgyvRHU7xud22yWKOSI3l/j1Am+ehn7Q1zOoqGx
 MU89lPONnfqm4w6DCA/iw3HErII94I5Bn+OmA4KPp7w40OVxz83gg591ZBCBE1MuVjI2R47e62s
 WjqmafTM=
X-Gm-Gg: ATEYQzxu/59AzG7iDurBZHWtxqACRmBY0VjbEfnVorUNw3KfwH5a5s2Q/TgU1mxI57J
 Bi2cVuOf+CLnGnUh0GLQk2FR/zxfEYtgMT34iTNKn9xXKx9cyCQU2U1yEERPJ+P92WG/m4SJtr3
 d49nvaafkJREAZhtL42kSUfGrrWJwkNVj31tEMZQ80qDTDZ0p2JcF26QRi/BtVvkvrxJlJByjGy
 Oe6AR9OHnJLV2tqlA/3ludb+MBgiugvbbpCxY7AKvBkZ0gEOI4MFwyumFZbCSsv87hKhnQYGZCy
 IpkPWAfqVUFKmWBg5Mtr4sriwLWFe4G/Q8moe4gjcExzj14I8O7AsBokWcfGhIhXCfFtpa+sfZF
 oTT+I5yQAcCO15uZwK30ttDb0zVSfGBlUZAsUv0uP91esKBPU1aVCms7eFMvEkqgGHzLDG8BFFN
 u4a8TnNHfum/G9GF3cwBRf4ELbu30Nl6TTkdpU9yU7EOnbJEgoH3AipwW5DOC7FGQsSDeUXJY+q
 aQXOSKyTK45A9gcNnyFFp+UagY+5xg=
X-Received: by 2002:a05:600c:3e10:b0:485:3428:774c with SMTP id
 5b1f17b1804b1-486fe8b0073mr176137685e9.4.1774263277831; 
 Mon, 23 Mar 2026 03:54:37 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff1dd9f1sm115483185e9.8.2026.03.23.03.54.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 03:54:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/10] target/arm: cpu: alter error message for host CPU type
Date: Mon, 23 Mar 2026 10:54:26 +0000
Message-ID: <20260323105429.4059580-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323105429.4059580-1-peter.maydell@linaro.org>
References: <20260323105429.4059580-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Make the error message for attempting to use 'host' on an
unsupported accelerator match the check we're doing.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260314221529.47841-6-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 98d09ac065..ccc47c8a9a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1629,8 +1629,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
      * this is the first point where we can report it.
      */
     if (cpu->host_cpu_probe_failed) {
-        if (!kvm_enabled() && !hvf_enabled()) {
-            error_setg(errp, "The 'host' CPU type can only be used with KVM or HVF");
+        if (!kvm_enabled() && !hvf_enabled() && !whpx_enabled()) {
+            error_setg(errp, "The 'host' CPU type can only be used with KVM, HVF or WHPX");
         } else {
             error_setg(errp, "Failed to retrieve host CPU features");
         }
-- 
2.43.0


