Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77512E7718C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOffy-00064B-0d; Fri, 20 Dec 2024 11:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOffw-00063M-3R
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:16:28 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOffu-0006zp-IP
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:16:27 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385d7f19f20so1106871f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711385; x=1735316185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MpUTAuW1kXEuNRtJRYL3FXGH/kmNDhNOdnBKMvX74f4=;
 b=r6T9QqeInxiheU1b+nJczlGqbFm201FFl4mYpY4aNFHe6uerNlpc0SpZUJTI1pz66z
 EwL07NVPN4JVq23gtnodLWWjHL8A3gEajiduJRPpIrEPRJLjcWtpiX/uVbcvRYIjSMb8
 iY2QxdemXqgsJRPgMiwJXf7n8U/iPDeN/aONa2CTtLeU67ttEDtX+JxiH8ofRnIzcloJ
 fK+8Smh9c0BvGS2EzF8DlM9Rp8Kx3fc+PaIfu7DQE/93nglg18ELpx9tClWgQ9uqArir
 cdeTfr+q/LrjBnRVxVjxEoLH9qc6aUnT5aPjWNiURDIl4/T//dJOdEjZvtKZh+AVGUsq
 LyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711385; x=1735316185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MpUTAuW1kXEuNRtJRYL3FXGH/kmNDhNOdnBKMvX74f4=;
 b=ECp5Ic4IrVmltDw43IXbIwjqqob5bPzGzmPM3GxnC6hsMtk3DhKR6WplK5nBE1ICNG
 x9VXnEVNRupbcOs3/4DMBBca2HmNiRTUsri005xfCnFOENDBuqW8oPs0uuonQ83dxFzq
 koLSo8RR0OHLduIW5MnUhockqISsKDf3lGxRmwGU1ThzpwvLhVR+YkP1ciig21jkAPm+
 okaLeb7XV6ieuTonhxyutdIzxX1EBfuEszTWi9mmxqnLI0JB1ljbEmwqmOo4ljOC8wfk
 Y58AeXIfGo1Rpy9GL/PcYeiwZ+Rezyrgjq1UoiG1eKXnjDDFPB6S97SzGBMOacaQihXF
 PzZw==
X-Gm-Message-State: AOJu0YwCGhgrVGJqEayVOCY0c+NIKq2B6XISBJY4583+f9T1xGNjtzcj
 Fqmregiwih9xMwYjl48PYV2LrVk0+Xbu6QPhCTdbBas8UhZBsrfiZdBBRY4PTDSiTpZHALIZkUq
 B
X-Gm-Gg: ASbGnctwIF+2Ekh2z8EDEvuGMsdzDtmxAynueaA4+g0qjphNaSFqlJoEl09VnveAuW+
 JwTeY0tsVt8vWTmp0CEaB/CxmWtL8uRu5ZUuX/ndrq2ztc8DzVUqH+HhoFTME9I2DTjFc3TIvNn
 yyECpbjCdlAo0bThBEOHjTZnSUp0EGKJlDFFLyb45EJ8scZU5B+T8Fsd+LMA0HWcrBI0WQMwYti
 VuiDJg5O1U9j+4SpjC9MfrM7Yug2i7Yitq48uNCyPbP656Mz67VSAFqrN4uFzCWHXft+k6vrSk=
X-Google-Smtp-Source: AGHT+IEVN3dsqae3OutgvLvncpOu4Z8dxQ2IFhmn6E/JjqS13Yv1/fwQnw/LjuVJFsQOkw2IsqUxzA==
X-Received: by 2002:a05:6000:184e:b0:385:dd10:215d with SMTP id
 ffacd0b85a97d-38a223fd770mr3095502f8f.44.1734711384809; 
 Fri, 20 Dec 2024 08:16:24 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828989sm4425707f8f.18.2024.12.20.08.16.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:16:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Bharat Bhushan <r65777@freescale.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/59] ppc/e500: Avoid abuse of container_get()
Date: Fri, 20 Dec 2024 17:14:58 +0100
Message-ID: <20241220161551.89317-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Peter Xu <peterx@redhat.com>

container_get() is going to become strict on not allowing to return a
non-container.

Switch the e500 user to use object_resolve_path_component() explicitly.

Cc: Bharat Bhushan <r65777@freescale.com>
Cc: qemu-ppc@nongnu.org
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-ID: <20241121192202.4155849-6-peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/ppce500.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 54071fc125a..67b22537c59 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -418,8 +418,8 @@ static const VMStateDescription vmstate_ppce500_pci = {
 static void e500_pcihost_bridge_realize(PCIDevice *d, Error **errp)
 {
     PPCE500PCIBridgeState *b = PPC_E500_PCI_BRIDGE(d);
-    PPCE500CCSRState *ccsr = CCSR(container_get(qdev_get_machine(),
-                                  "/e500-ccsr"));
+    PPCE500CCSRState *ccsr = CCSR(
+        object_resolve_path_component(qdev_get_machine(), "e500-ccsr"));
 
     memory_region_init_alias(&b->bar0, OBJECT(ccsr), "e500-pci-bar0", &ccsr->ccsr_space,
                              0, int128_get64(ccsr->ccsr_space.size));
-- 
2.47.1


