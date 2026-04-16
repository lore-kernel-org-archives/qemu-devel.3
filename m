Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B7FF8A14B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIrr-0006d8-60; Thu, 16 Apr 2026 05:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqk-0005JY-UN
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:45 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqj-0007r2-0G
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:26 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso3946185e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331043; x=1776935843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zZTpw0jzH7BSXa/UG35FR0r0SKlHGvKk4XQ90fru598=;
 b=hiQwzcpwjp8NMJNIb2nFwSiiLia/V24mE4wQwxnwM0UNXmxcUnfzGOaiUtF15Vw/aL
 eAomXZOSM7x4sHITGqohHr7Of7SDhOKD0nbXhyvt77XU5KUeBJshSKLEre/fwAr0H3w4
 rH9WXRUW5vU1//Tup2SvcMYNfcmi9AutiyV9G6dDCO+1GvyseK4Pe9PvYNLmLepLNAGS
 fABDH264M9EEfU8cofeQkJ8MTcc5P8fuvdIelfVaY84bJqqKQC4nHFaTErGbVKZBR3it
 q6z+6YkSsVmRuhDPFNW+lwSes4RtwasZO/iNs2q9dSSze77N2PGj9td2WH1dHsNINJ8r
 K/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331043; x=1776935843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zZTpw0jzH7BSXa/UG35FR0r0SKlHGvKk4XQ90fru598=;
 b=bVnHKkJoKfEddwhybe+cxadmSdly/XAVdIrC53pn4zemXgqnvk0PK2s4QS3YI8TAyp
 gp8adzPVN5YOigOwm2z7Uu7kkE2y4qS/7MAAkJM2UYrj2IZ04fZK3gy46g3ZSHpWL1et
 /U7MhJI57KkwOw+g95EJUP6QbPlVyKNIdYjw5gZ+2sj1GHiPwEZqg0hLgnY2Q40O/vVg
 cChs277OaA8TezsPMQsvU19Hk0N6jZWGm6L+6C93kf+BRR0MbhNrzpsSrfFXMIEj+PRi
 tN42eEYtWbnf4x0J7BokLmaJdSfQrbF7lqS9CTgabTjQs71HA7MqMc1NMnWY4V3yhoub
 9dKw==
X-Gm-Message-State: AOJu0YxEMZGqvoR2Ux2sluPkRvMY+JC945j4SMw+zuhKEtvIgj41ZZc2
 6Y4kbXIbwKfFKjK0TAQpwCPqeDXrXfc9bnMsy8+eqVoyX32YMoDQQ4HoDSSBajsyBkx5CpOy7OQ
 OzQjuBy8=
X-Gm-Gg: AeBDietfcrPGuHGmTsGAz36EQdDAsJt9PExhBm7A617jv/IbdGiE6ORWNHHjB4pjPXe
 9+4AMitLFiKNMxLnGp1k5MEWw8AJtbWGCIk9T9PtQ6YKBwRKmFVA7MzHLxpAepMmM2nbMax1FiE
 Btq2PN4ikSLzP9avGXIsu7FrY8MSrBBqt2SgdiwY9cRO5kH9N5TkHvZtY01CKizLnwDK4fqX6YD
 nqc/q0QOlbO2HcTuB8Hfr9dYWaEPHgYeHQgu2GnQj5VdDNQ04LAi7qe/LAKGNFQM5cc6loyjjSw
 18wk4kP/HRnhZaddvq/3+49XoQxkfBodAx5mL+tqvyjkco/sNiS02h6XYLeYDjdHy+dMoV0+e/D
 yIYZVzpqqvL7te9X2tyg6SKZacs8MlcqPCu+SkE4kzKl0Am6bKqX7letsjsovpJduGFFXbpI3RX
 xs2FFvf8Ajdl8/sN40tx761cWSHaEwMdThbd7ywxAzlNg9GiVwXjeAb1vSbYUVnWq/5Jkz/Ajv/
 ohh7hz9fv7TBdoMTSv3BHOfr2sjBlJSMZQ7xVfKHw==
X-Received: by 2002:a05:600c:c090:b0:485:fbd2:f72 with SMTP id
 5b1f17b1804b1-488f45cc70amr26708555e9.1.1776331042738; 
 Thu, 16 Apr 2026 02:17:22 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.17.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:17:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 26/28] MAINTAINERS: Remove Wen Congyang
Date: Thu, 16 Apr 2026 10:16:52 +0100
Message-ID: <20260416091654.316158-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Wen Congyang has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ca64361b24..81ffb56c31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4383,7 +4383,6 @@ F: block/export/vduse-blk.c
 F: block/export/vduse-blk.h
 
 Replication
-M: Wen Congyang <wencongyang2@huawei.com>
 M: Xie Changlong <xiechanglong.d@gmail.com>
 S: Supported
 F: replication*
-- 
2.43.0


