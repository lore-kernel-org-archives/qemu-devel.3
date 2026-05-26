Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4225CCD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmf-0000f3-3o; Tue, 26 May 2026 10:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmX-000067-Qx
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:22 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmW-0001Kz-BV
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:21 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso66972675e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805759; x=1780410559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DQqsaZ8KXCDVjBXlqmHlbDtKPnb7URsI2I5IPm/qc/s=;
 b=LYw6RwKi7uO3wFJ2CFTkusmk0c4WSE+6cHV7m6KbBEPEZ46ok2PHw/pB0Y+sKRPFf8
 hbudTkQoIhxYuUNVj+uhB2uTTROIJQZQ/2Kvpkk+/hGArHWhvFzAKaOtHV97jmQNLRWk
 bosXw3IxJfFyGm5IWuPt0Zb6Kv4OwdePfhPYy51vZao/1uVlEOHGqg9DAMv5UJcUfjNC
 p2dJDwcsc612wpxJwWA5EQZvQJ/BP95fU5VQH8EZGnPy8JbRAlu0tJjy73twbPTPLd+I
 p6dpU1xjmzuh1O8StqePSsHhtgLu3JIJmQ5eiWS9ka8pUfDoCtxeZd9TyUv/oz1RKE3x
 B0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805759; x=1780410559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DQqsaZ8KXCDVjBXlqmHlbDtKPnb7URsI2I5IPm/qc/s=;
 b=W5RTIi1LvRbBv+YxJ9HFg2no4ui3Ed6wahaDfMZJpJiIpwb0bhLz4dlhJHayTeiJVv
 LUmAkjFRaW3VyHIq/ZQEmmE1AMvIDJYScIQEXbU9QaZBwvrneEYq0pckYRPYV55+wEW8
 G3d+4xE/tdrUxHcricEQUw5OZRuAgd6iTtsIV/feL4HV/bySv9btNO1wWNtEveCYw7E3
 kDb1qhljIozeIrRfAzh/4tVyrOf2zNFgq3bps3aC2Zth4zhMIPXr41ze0XExfWI++Cnz
 QSfCf5wx/1/zq+x9AM9KnIFiXFxoasFCVnbAclo2XY+uBAF38sRP6YEwqiCHdBNNvj1h
 kdcA==
X-Gm-Message-State: AOJu0YyiP6fBm41ceofKLcu3lywL1EyN6pIO6nIKWyCY5V6O2ucCXOmg
 uEhgEZIVGCNfvVh/fzFH0awTlj/6gj0ryRFKbdPRfF/89qv3Mn3ljESqLegdd9kkVU0P6It3TqX
 g2fjS
X-Gm-Gg: Acq92OFHWpvERMge0GQol6LoKIRQFiXffMB1q01Y6u8v5ceHqqlHMwzMTPuq39Seb3U
 93XcvVjsGSuCUACnowGdCJMVWDjagzhBYTpHjZhGfkEvWiN5uzk+N88uz2j6mYfsolpXwJx7Gt5
 Z8yoCl2X4lqvyVdrfMPvOkY86kJZJt30fWUZ1BgUc+e81ai4tbd2/HHJL19ClYyRrUS1iBvoV70
 9fzT3kJtvnc/60GoKZ6P6BtqHpqeav/udine91qyr7rSbEGpckv/J7ciZxDz1q1IIaTq+mpKKHO
 x2x906i/wRsUjzMR9uy9Qb9OgEuB/dyqGLVGKIMyVG11/oJ5daYvRO65k8RI2t4zwRgGGTQ6a97
 dXE4ixZ8g0F7HacVSyzNbjV8uLVeXY73zVvzpr8yxxHsoGeyQ+/O88fhXBHMeg5PDdmCdAD03n1
 VniGLKvevbRP/yZy5RbZj5IXcUJO5fmMESBHm0VkqUq37f8BDKc1ShcZkC7XbIonVoJvDEYvXJV
 SzO16w5smiNYAbttuM9G6MrQGXxwXs=
X-Received: by 2002:a05:600c:35d6:b0:490:4973:91a0 with SMTP id
 5b1f17b1804b1-4904973932amr285542975e9.10.1779805758651; 
 Tue, 26 May 2026 07:29:18 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/54] tests/functional/aarch64: Bump up timeout on vbsa
Date: Tue, 26 May 2026 15:28:24 +0100
Message-ID: <20260526142850.2326589-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

On a debug build, the virt_vbsa functional test takes about 2 minutes to
run on my machine, so it tends to time out. Bump the timeout to 4 mins.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20260518160440.1037245-1-peter.maydell@linaro.org
---
 tests/functional/aarch64/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
index 9803f66299..e81afd6c39 100644
--- a/tests/functional/aarch64/meson.build
+++ b/tests/functional/aarch64/meson.build
@@ -17,6 +17,7 @@ test_aarch64_timeouts = {
   'tuxrun' : 240,
   'virt' : 360,
   'virt_gpu' : 480,
+  'virt_vbsa' : 240,
 }
 
 tests_aarch64_system_quick = [
-- 
2.43.0


