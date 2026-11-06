Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C50606A33B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NHIOiltE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPNag-0001Wa-Cs; Fri, 06 Nov 2026 12:19:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xPNaV-0001Vc-B8
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:18:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xPNaR-0003At-NZ
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:18:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793985526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2d86+FwB1uQEHKFdrMKLs2YhvwfDcuQjAOKn41giyL4=;
 b=NHIOiltELrgm2y0Vb6EZzGidQ8JglFVEepfZWJMJW1GIy+r4l5gPih6kOlkhSJ50jzQvBw
 BC8MervZ3zT6eeBOwdejzVquGGKsm+HS2DumZXh+/dh3qbYP16JtcfIsd5EmK9yYM6KnSE
 WcRBcdpyA1PTtIkfd3RtXjMm7yRkEpA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-MrpppYFgOdmJFxiZ5e2B8w-1; Fri,
 06 Nov 2026 12:18:43 -0500
X-MC-Unique: MrpppYFgOdmJFxiZ5e2B8w-1
X-Mimecast-MFC-AGG-ID: MrpppYFgOdmJFxiZ5e2B8w_1793985521
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BE85180064B; Fri,  6 Nov 2026 17:18:41 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B6151848D41; Fri,  6 Nov 2026 17:18:39 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/4] hw/misc: move vmlaunchupdate.c from specific_ss to
 system_ss
Date: Fri,  6 Nov 2026 17:18:33 +0000
Message-ID: <20261106171836.2020151-2-berrange@redhat.com>
In-Reply-To: <20261106171836.2020151-1-berrange@redhat.com>
References: <20261106171836.2020151-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

test-multi-target fails when igvm is enabled if both arm and
aarch64 targets are enabled:

  $ tests/unit/test-multi-target
  TAP version 14
  # random seed: R02S0c27cf3526927aa4a7f822f0a8315b3e
  1..2
  # Start of multi-targets tests
  # Start of qom-types-are-unique tests
  Registering `vm-launch-update' which already exists
  # child process (/multi-targets/qom-types-are-unique/aarch64 [1982534]) killed by signal 6 (Aborted)
  # child process (/multi-targets/qom-types-are-unique/aarch64 [1982534]) stdout: ""
  # child process (/multi-targets/qom-types-are-unique/aarch64 [1982534]) stderr: "Registering `vm-launch-update' which already exists\n"
  **
  ERROR:../tests/unit/test-multi-target.c:41:test_qom_types_are_unique: child process (/multi-targets/qom-types-are-unique/aarch64 [1982534]) failed unexpectedly
  not ok /multi-targets/qom-types-are-unique/aarch64 - ERROR:../tests/unit/test-multi-target.c:41:test_qom_types_are_unique: child process (/multi-targets/qom-types-are-unique/aarch64 [1982534]) failed unexpectedly
  Bail out!
  Aborted                    (core dumped) tests/unit/test-multi-target

This is because it is linked twice into test-multi-target
and thus the same device class object code is duplicated and
thus the class name gets registered twice.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/misc/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index fc3800baec0..7a071af82b0 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -170,7 +170,7 @@ specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
 specific_ss.add(when: 'CONFIG_RISCV_MIPS_CMGCR', if_true: files('riscv_cmgcr.c'))
 specific_ss.add(when: 'CONFIG_RISCV_MIPS_CPC', if_true: files('riscv_cpc.c'))
 if igvm.found()
-   specific_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmlaunchupdate.c'))
+   system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmlaunchupdate.c'))
 endif
 
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
-- 
2.56.0


