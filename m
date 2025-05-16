Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA78C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 05:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFnbR-0006HX-EL; Fri, 16 May 2025 01:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFnbO-0006GF-Qs
 for qemu-devel@nongnu.org; Fri, 16 May 2025 01:27:22 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFnbN-0001Mn-E5
 for qemu-devel@nongnu.org; Fri, 16 May 2025 01:27:22 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-23198fcdeb0so16710435ad.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 22:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747373239; x=1747978039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dU3iAcSQrpRQtiTX04EuYFPrLnsx+BhMT5SxU3B5tJI=;
 b=P3DH1mixMNf1IpGmQEV6E5ztBn3TKr61GoD3e4IEVmKeQLnyGpc0vpPPiOR8TX5JIB
 uErv0FiANSpvBJpk/wLq6+uIvGtR/XaimM8yussrzNWpouxrVNtlKazBes0i0jDoIfTj
 G78DI7DGaR1Jf3ao1Xfq0ZWc/udOz7etZ2K3fKssGk1INVt8HO5mh2ie0i/7KPQQfPR6
 rxiOXzLEBIftsCTQdCsp2HC5QkXJMUPHZKV2JPm2+hKVpRzwHn5TT1roi0IJ24urkdg0
 lORYwOKDTc56eYp0u3TByyE0EAD6scesrGYG9KxeNGeJhHgomyq9+Ymddkd1lschowW2
 Wzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747373240; x=1747978040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dU3iAcSQrpRQtiTX04EuYFPrLnsx+BhMT5SxU3B5tJI=;
 b=sVmPqR5lFy6eQ2ux0/xpqcWSO30Wex96p066h30BlTI6SO3iE3YttyC7smwFUJFzOG
 Yk8ihJhpaK+lPuRG8GuIrsAUvpUsVmtxZRlX6++RrDYBmADdF/CYE32m8neq72UK5VP5
 gZ3rx6+0p03Z4yeTiG1o5RTLXYCwEsTPeM5IYbsX1Hf/Rdt9VQn8peg6g7H1wOULJlL/
 XF838SrsQ0k3I3JCzIBHw2lGsykoIx2/gogeO9fOG2e0P2UIAlky+8lYZIxQCwFQ3SsZ
 taLMfvuHE2Bys1YlImLATG1AY3V82B5oYv/VrM1h2ddFenRBY6aSnUSnn/KfPVAb+RHF
 hlgQ==
X-Gm-Message-State: AOJu0YwbY1M1kfJWop887Gotn3QxOUNNKuo7237OJy8ohFwaCNbIZpP2
 Sw9QUQoqE444D4QU4/pTAxYcYzPFd0KoiMxI8fik5MPNYh+PUKuLgWO6xTQ4g0JcUhzTJyXq+0a
 +uVi0
X-Gm-Gg: ASbGncspRrE40+SRdeZUjsFFm4n164PQdRZ9GqEE7JR1mISZB9C3f3CFDSCUOOC+Mx9
 txL2n808YULV2HhGXkUmflNPClRxvWExrG3gdp5XvcQrXIIwikJN5D7gvyuKPbKJqldK1jaBmb4
 iYLodFeYx7onh9wq+2ka8/pEp0Bi4gtZJFnyITD3N1/ou/o3OKlTw6n3NDyZ5GP1uLdXKmC1TeA
 99ntpG2rO0e002lGKte377R8B04v831GCNuGONL9Nu5+x+mLeL/hpfwI0SazvCPPoiD5IBnrFtb
 FE3O/yonQkNcfThZt7yUB/s0j0/Up3tS3zqrLUyPGxV+RfVMjBa8aT/usbL63Q==
X-Google-Smtp-Source: AGHT+IHlsntQRTzA6tNyetMsEEPrx3HoRDbc/aJ2UJGnQ6Br4wobIo8ayTB1XmOqMa5qL8Ouear3PQ==
X-Received: by 2002:a17:902:e80c:b0:224:78e:4eb4 with SMTP id
 d9443c01a7336-231d45a9c3cmr24389565ad.39.1747373239691; 
 Thu, 15 May 2025 22:27:19 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ebabfesm6539135ad.174.2025.05.15.22.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 22:27:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 thuth@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 3/6] target/arm: remove explicit dependencies listed
Date: Thu, 15 May 2025 22:27:05 -0700
Message-ID: <20250516052708.930928-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250516052708.930928-1-pierrick.bouvier@linaro.org>
References: <20250516052708.930928-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index b404fa54863..2ff7ed6e98f 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -28,7 +28,7 @@ arm_user_ss.add(files(
   'vfp_fpscr.c',
 ))
 
-arm_common_system_ss.add(files('cpu.c'), capstone)
+arm_common_system_ss.add(files('cpu.c'))
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
-- 
2.47.2


