Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE2AC61DC4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyzEV-0006rX-74; Tue, 25 Aug 2026 18:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzDQ-0004Jk-HD
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:57 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzDP-00021y-3T
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:56 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-39266382df6so381178a91.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 15:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787695314; x=1788300114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pjUwK0GJ0a5oiNGFlwfIXujzN/1nEJAAx2xEhAB3eLA=;
 b=J00HzOkDI41Qtnolo+TgHpsxwXrsU7wm2ZzM7uhew/MdlsIWKreG2US3YZH4uLG19x
 Yc67QsWzugvZgf+BweLbcpQxZpH09C4Ktd45yMvBmb4Q9OE0U7co7XXRddMNw5GHx2+q
 m69P1SsgTE63T8vT8Bo4CpQgVvjgkJbQhUdwAA7g9tRpLy61X34kxVLAKNsaJzgMLJph
 PLrl2AYqWu5LMX3rC07jpIXQDWcxjivFzlItMXor0yLA6uEvivWtxW7RKxXVnaQqOzj3
 bjqT51qI3B8/VCbbre/WbJGdR/S+NOWTYjBc9mbTwzFc3ii7S99d45F4xz0Um7gObbIV
 BB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787695314; x=1788300114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pjUwK0GJ0a5oiNGFlwfIXujzN/1nEJAAx2xEhAB3eLA=;
 b=KVC5mr3yDet23ZS37KzPOvOGfscJDnvkXKa8g8xYLjcoDihKc79rHn0FSgGjKgej+G
 /rWwi3wknB3Pmc5LlXQ6/74X/82s16cUowTqgSBvogCI7YeUFhV0gcC8627dBgQ682On
 LQXYW4mNQT2XyPYyq173Obsp95tISsDzGiixDDcvieB6MWrLBve5V3VN4xCq9M92XVqi
 YQTEL8Iy5z0ZCdsPVyaXqtG2ZZliTKaVrVZu6pjmZgzh67killvmeQRK6sO1C6F3OPvl
 sZfvVf37GGPIwShw4UYlrdRjqClMOUi6IwYx+MTj0okG88PxunXz0lcLAh7K/WHKcsp0
 +bMQ==
X-Gm-Message-State: AFuF++m7nMeUEKDkwRpxEhnfTZGpqYQMLybq6+mXd+b5xNcHUeeIXZ9e
 1E0agofgP28Y5zLK20GB+y6PQ2a80jRWSL5vSY8mRt6+q9LoxJFyNcaprZJANHmF7dI=
X-Gm-Gg: AR+sD12gpo+kgpW2NQcbSUbdM716JAzhB8DqXl0AWGPMUeCF9vMr6VadGCLY1X3Z3pM
 SX1g7nEhOkNFaL20RqedkaZqYnWO8JBSL5HMKXrV32QHEX6VSMjeFhAcSUTHMOdQ5d3NL0kHFPt
 uVv10aJwMjM4n+D4GJDv9Cbbm0QNd1pR7Iw+1edI9yGMWu/K0p7rjKABtX/aHebKHrYgHi/cAFE
 wh20AFcWxat968WTarrDBZ97pxjexRirWiyxkO0C0rjjP8LbQ1lJ7S+od6w8IsfEw6igBcCQB/t
 aPpOBEtowfujZZfML15jK5PTsJgow8k1v8Z5sSbC60LJSpQmHeCAm3pXVWD1pt/Y4qFTgTwnoU4
 IBP5daIRezD1ZziSmDGsL1qzQhep+3kJpMokfy3KrI6H0vInCLCeGlNBsQRc4fJupkAH1aZPcoR
 9C7EFH0eLADetQN0WnE8YrQGMepBZKhvGtyAtyHrbBLMTzZWuHMoRn/WTjjmbbil8ndJ7Y8JgYt
 F6CjsUjM6stmrs=
X-Received: by 2002:a17:90b:380b:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-3966d002fffmr4328291a91.0.1787695313671; 
 Tue, 25 Aug 2026 15:01:53 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 15:01:53 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v3 23/24] hw/arm/boot: Load DTB as is for confidential VMs
Date: Tue, 25 Aug 2026 16:01:00 -0600
Message-ID: <20260825220101.3443954-24-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x102c.google.com
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

Load DTB without modifications when provided.  That way it is possible
for a verification entity to reconstruct the Realm's initial measurement.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/boot.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 5e85be2bb462..ad588121452a 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -477,7 +477,14 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     g_autoptr(MemoryDeviceInfoList) md_list = NULL;
     Error *err = NULL;
 
-    if (binfo->dtb_filename) {
+    if (binfo->dtb_filename && binfo->confidential) {
+        /*
+         * If the user is providing a DTB for a confidential VM, it is already
+         * tailored to this configuration and measured. Load it as is, without
+         * any modification.
+         */
+        return rom_add_file_fixed_as(binfo->dtb_filename, addr, -1, as);
+    } else if (binfo->dtb_filename) {
         char *filename;
         filename = qemu_find_file(QEMU_FILE_TYPE_DTB, binfo->dtb_filename);
         if (!filename) {
-- 
2.43.0


