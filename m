Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782EFC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSo-0005rJ-6o; Tue, 01 Jul 2025 13:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSl-0005oo-1k
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:08:07 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSd-0003h2-7K
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:08:06 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a588da60dfso2268261f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389677; x=1751994477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r7p0sPnBcRmvM4bd4jbXz1OCAH6iKswXTMPYh8eLjyw=;
 b=NrJohOVudVAh3HLIFxAtdU/FW1Dw5Kl/MpJMsMh6Njw74xD5itH2brjV0aoaKjIHis
 /cRAO3YmoFl27cdUXSoZspdDZ1WXmPinf45R677XY8tFGT+NtSUgCMA5j+zBVMuZX1SO
 VOxXWKnOeigQb9tp6aFISx8Gu6z+pTSFQHLa9FQ0soGh7eQ19/TKMwHss4j3ENMCsHDM
 To24BGqSmXibRycvABfJ0UJcvyE/OSL1Dn1StZa+jAPe5KTV/Htj6HSTng7aRL8NjD+u
 u74lPjAamnI1UCheb5BTyko44Lm7ru6pUpGGjtA6aOYz8wRgfsAQWC0Ksx9yxaub/4++
 T9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389677; x=1751994477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r7p0sPnBcRmvM4bd4jbXz1OCAH6iKswXTMPYh8eLjyw=;
 b=XjzltG7Ci81UtFDyn3NpgMLc9QzPJFByc6xLHP679Lrc47XKTXaGL6l4qxBdjCNC82
 kC/r22pZx3pbL4Rwij/9AoCUco16eQMB6M2Eq03SI8Pnh+5EAVdclgT2inUpEbrbexxV
 HzNr5dbkavSmFZqAqo/W9O+Y03tOVD80BV6uZwlVWEheE7tpphbJaoAWHhvDuX3Hzwvn
 LjM0TCIs+GRVoHyrgz1CW8YszOQZOk58Dpl4qfPXNXjeUi21scBP4MpJJQ9Gl+n6pp/U
 J63eAGZU8uns5lk5rvZy/u2sfjiSV5Mex3QKrd0ILD5btDSlrLttGz/Hy7m3Fli1cFa2
 T8LA==
X-Gm-Message-State: AOJu0Yyqie8hH5rznyn8GotVUfGOx87s/m8+LpraJMkGEHwIttNCfpdH
 mvJAS3fmGXi+KZN57nkVssUCd14g29CHCF6poEXc32maPa1v/av2td07VAF+HI48ncJrt1TZdpw
 50oCQ
X-Gm-Gg: ASbGnctEsgqUSEwx+pEF6U0aLxAXZA++v5KrjFBXPn0wGvQSHKA9r08ALfVZD1h0seS
 ZkRu+z1kES8j2PBMs8m7HleH3gD0S+JxW5XQrqzSZnNIJbiwIfZRHyzUPYS5fYKfvU0R3XPPohA
 twscStsM6mKLVF4bI3SiCwwmPqnm1wBCi7KuiI71HhAtr+PvccJOSoXo4Q84vWHFiQKVJQZ/p+G
 Wit33m/ZeA22o0maHqfDzW0ONrIgSlYv1rr0CoYkTLSowjVgSxiTrz2pajbZCTW51y2P6HorZ5u
 kMmxcUFQX7gbTgHLjI3EW6tuaPvdHc/O+YWdu/l4oO782eM8xdEbzgjuUvw34ehBfcDj
X-Google-Smtp-Source: AGHT+IHqhlsfKbTnlHveeKhO0MPD0gHoL/1LO51nUOXa1O1/JQyFtn2+bh8ziX348ThoGlqhZ6FC4w==
X-Received: by 2002:a5d:4a12:0:b0:3a4:eb92:b5eb with SMTP id
 ffacd0b85a97d-3a8ff8f4ddamr12380547f8f.50.1751389677023; 
 Tue, 01 Jul 2025 10:07:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/43] hw/arm/virt: Make EL2 accelerator check an accept-list
Date: Tue,  1 Jul 2025 18:07:11 +0100
Message-ID: <20250701170720.4072660-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Currently only the TCG and qtest accelerators can handle an EL2
guest.  Instead of making the condition check be "fail if KVM or HVF"
(an exclude-list), make it a be "allow if TCG or qtest" (an
accept-list).

This is better for if/when we add new accelerators, as it makes the
default be that we forbid an EL2 guest.  This is the most likely to
be correct and also "fails safe"; if the new accelerator really can
support EL2 guests then the implementor will see that they need to
add it to the accept-list.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20250623121845.7214-20-philmd@linaro.org
[PMM: rewrote commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b3b1c6df7fa..30f91bcfb3c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2207,7 +2207,7 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->virt && (kvm_enabled() || hvf_enabled())) {
+    if (vms->virt && !tcg_enabled() && !qtest_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "Virtualization extensions to the guest CPU",
                      current_accel_name());
-- 
2.43.0


