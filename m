Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9501125847
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LK1-0000Tb-T4; Wed, 11 Mar 2026 11:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w0LJ0-00006w-Us; Wed, 11 Mar 2026 11:17:08 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w0LIx-0000Wx-8m; Wed, 11 Mar 2026 11:17:02 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1773242183; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=G1hagRa4xojlEj9k9aUjM5hZnaxAlpbf5aPag3qOp4sJfvDKre8+jw3xXQIhvbW7WQkIjdCrfRvMeYH5iNGwcjNq4lTdz6/wRmeDfzyncMCU5hAUKa/CN+7QJEUjiJe7Nsgwl6V4sLrQkQIwED0m8GHFwZ3/Fy7HT2aMJ2f5+eg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773242183;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Xiwc6ZTsoVE3sApNhrgrxie2j913R3HBh0AQxHunnbc=; 
 b=QIN7WirFHOLQw71nqs2JYJLBvb7+gV77MLArw/rFPWVopAAbZcDT4w3cuvvy4fMN3YvKQI7DFCs0nXJ+gZJO4VQHHkVwq9Yo9ASFV1Y+n83hGJYIcfBWd9PZyD5kdgMltJ6YtpEC81VUoLWdsxTggPNQdKUHgYal8EPoaRh1YEM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773242183; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Xiwc6ZTsoVE3sApNhrgrxie2j913R3HBh0AQxHunnbc=;
 b=v7nhr3pycgbbJZUYSfbkc0/cOtQTLzLolsHYkCEQ0s7qBE3It80+/P5Vs/lFCSGt
 UAIdnT2u3O00gzNtysCmoaZNuK8Iu19jomFXEA6KvXKfRIdn88t+9DbLu1X+SeFiAMe
 U4lcEiSG7OVAssd2dJ/vPc2ZnpPH+nKXey0UPesM=
Received: by mx.zohomail.com with SMTPS id 1773242181330266.4815230829188;
 Wed, 11 Mar 2026 08:16:21 -0700 (PDT)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
Date: Wed, 11 Mar 2026 15:15:29 +0000
Subject: [PATCH 02/14] accel/mshv: move msr.c to target/i386
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-mshv_accel_arm64_supp-v1-2-c31699b7bc1f@anirudhrb.com>
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
In-Reply-To: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org
X-Mailer: b4 0.14.3
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.54;
 envelope-from=anirudh@anirudhrb.com; helo=sender4-of-o54.zoho.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Aastha Rawat <aastharawat@linux.microsoft.com>

This file has x86 specific implementations. Move this file to i386
folder in preparation for ARM64 MSHV support.

Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
---
 accel/mshv/meson.build            | 1 -
 target/i386/mshv/meson.build      | 1 +
 {accel => target/i386}/mshv/msr.c | 0
 3 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/mshv/meson.build b/accel/mshv/meson.build
index c1b1787c5e..e433187cde 100644
--- a/accel/mshv/meson.build
+++ b/accel/mshv/meson.build
@@ -1,6 +1,5 @@
 system_ss.add(when: 'CONFIG_MSHV', if_true: files(
   'irq.c',
   'mem.c',
-  'msr.c',
   'mshv-all.c'
 ))
diff --git a/target/i386/mshv/meson.build b/target/i386/mshv/meson.build
index 49f28d4a5b..6091c21887 100644
--- a/target/i386/mshv/meson.build
+++ b/target/i386/mshv/meson.build
@@ -2,6 +2,7 @@ i386_mshv_ss = ss.source_set()
 
 i386_mshv_ss.add(files(
   'mshv-cpu.c',
+  'msr.c',
 ))
 
 i386_system_ss.add_all(when: 'CONFIG_MSHV', if_true: i386_mshv_ss)
diff --git a/accel/mshv/msr.c b/target/i386/mshv/msr.c
similarity index 100%
rename from accel/mshv/msr.c
rename to target/i386/mshv/msr.c

-- 
2.43.0


