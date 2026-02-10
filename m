Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D8EEA811B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpoAJ-0002Cx-1H; Tue, 10 Feb 2026 08:52:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoAG-0002B1-JR
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:28 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoAF-0006Mq-39
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:28 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-480142406b3so43928435e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770731546; x=1771336346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7wzAaDjiOhrmRRcJpDVFtm7pFxU4gAMetH8yOhIS7bo=;
 b=k1Es7PRZubPlIBsfZ9Pkw7uSvS8Gn/JfWZClXPCGI3tQqjK3WRjYMKf22vjfSovGqG
 inO8H2JstdiN97c7Vb5D2ih28zvaDA7tqMOdA6bzevxmg2IKPhlG7Q+Mpm6H8gvmdrFu
 QGjdzA2BLOLz7rU+Q7UXDNu8YTg7k4ne/b5nfZmpd/ECs9AcGbSPxkdp+iV6g8O1M8ja
 thnHlrRdEtTYcQ+rAUmu33WOwgcuHOuSil0EzgVCxjkudJWpT0W1XonEUNXBeGZWIkQb
 41nmWyWEm5FEpTZUtHW9TPulitLeXZsWnAmyzAh6WD1u1oF+u1crZ+8tcOsaGHXXt6Aj
 MjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770731546; x=1771336346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7wzAaDjiOhrmRRcJpDVFtm7pFxU4gAMetH8yOhIS7bo=;
 b=wBaJmc/TmNB/3sp/pBy+7AMynwYWW+N8z8BiVh880iVUbGSrdpblw8Hy/Z1gEZ2GM8
 uxPzN2FMefukkgpJap/OzMfIYkODRw/BwiGtbSvthwg/vT/IxjfR6P6VO77Ym6zRMOci
 PM8dXdVlMkrPPkB5SjHD60I2oWlhLzhJX5LmqQyC8Cg1A+tUvshuD6qGHfvA71vEyopG
 WT+Vjo9bc8Ui/F5gbgca/u0OfOyLvbN2g9/lFrD51sYZcV3IqjqXOZPPXadZ4yNYlwAr
 E4a0FOvCliYaeF6f1btjJSaqxoc72xQbMvT0MaWYdbE7zrp8pLgKUIkG3sSsXLxYRW6u
 dNNA==
X-Gm-Message-State: AOJu0YyWc3+YDkhfaYhWpyDe9KTKvzCN0m/vPsNkabRl8Z1bB1o/2pDv
 rxQ3cEE9fXFkxkfkHL4zvR4M6TNNW7NbTOJZiSHfcMvAy5JroE53lEvw5NXMomPdx1PfYmVorcY
 yHyGJ
X-Gm-Gg: AZuq6aLfus8bxThWjTMWaEdyn4m+uCQ+a7uliom6h4z5HtC7FhVgKOOWVDln11Cxl3O
 tVbZOlCKqGnDAPulZbMZgS51ZS3+uRxq33q0MgqIyGcfD8xPFagX19tUJAJyR9ap6sCrBb0DQj/
 t/cQc4Whg8TgfEcxkFA2aTdkXGSB2u7zIyYyAtZ7UCVJcVDQrsvc7rtsXP9hIWB9M49DfNXzD9J
 VuPLTyBJhunH8vQ3+vjLqCl0lcDgjyZALLe+TAI1tWHPKJrGtiLtV405ewLq8qmIqiOYTTWc0PR
 jYHgwUZMpOTB8nucKy0wfQITHl4/rehtpvb8UPm4uFxHDcUONcNKvxbxQ8tFfOmgYIBXAAZxqpe
 o+xFcKodPubPrTdicRzZrQR707P988ONt3Dvb4u5p0bdMouldK+sL6DXaoj6Px6Tgvrr45kaW73
 zoQWhuHwosdYa1ODaJpfVtYHKYjfLDb8xT64f4fRFkaRDVOvkDsdDFOKgI+UgXbYZUfzlx8cUi2
 +ci25zzq9QnqHZctbbxzqZUM0t/qZs=
X-Received: by 2002:a05:600c:450f:b0:477:7af8:c88b with SMTP id
 5b1f17b1804b1-483507e16a6mr31159365e9.11.1770731545579; 
 Tue, 10 Feb 2026 05:52:25 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77f9sm64344875e9.3.2026.02.10.05.52.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 05:52:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/26] target/arm: whpx: instantiate GIC early
Date: Tue, 10 Feb 2026 13:52:00 +0000
Message-ID: <20260210135206.229528-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135206.229528-1-peter.maydell@linaro.org>
References: <20260210135206.229528-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

While figuring out a better spot for it, put it in whpx_accel_init.

Needs to be done before WHvSetupPartition.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/whpx/whpx-all.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index c88c67a9e2..44ef42307b 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -939,6 +939,38 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
 
     memset(&prop, 0, sizeof(prop));
 
+    /*
+     * The only currently supported configuration for the interrupt
+     * controller is kernel-irqchip=on,gic-version=3, with the `virt`
+     * machine.
+     *
+     * Initialising the vGIC here because it needs to be done prior to
+     * WHvSetupPartition.
+     */
+
+    WHV_ARM64_IC_PARAMETERS ic_params = {
+        .EmulationMode = WHvArm64IcEmulationModeGicV3,
+        .GicV3Parameters = {
+            .GicdBaseAddress = 0x08000000,
+            .GitsTranslaterBaseAddress = 0x08080000,
+            .GicLpiIntIdBits = 0,
+            .GicPpiPerformanceMonitorsInterrupt = VIRTUAL_PMU_IRQ,
+            .GicPpiOverflowInterruptFromCntv = ARCH_TIMER_VIRT_IRQ
+        }
+    };
+    prop.Arm64IcParameters = ic_params;
+
+    hr = whp_dispatch.WHvSetPartitionProperty(
+            whpx->partition,
+            WHvPartitionPropertyCodeArm64IcParameters,
+            &prop,
+            sizeof(prop));
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to enable GICv3 interrupt controller, hr=%08lx", hr);
+        ret = -EINVAL;
+        goto error;
+    }
+
     hr = whp_dispatch.WHvSetupPartition(whpx->partition);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to setup partition, hr=%08lx", hr);
-- 
2.43.0


