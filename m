Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867D4C36007
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 12:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvbbz-0001tR-I1; Fri, 21 Mar 2025 08:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tvbbu-0001py-U4
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 08:36:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tvbbt-0008Nc-DH
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 08:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742560584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VRDSLwYwETArjgeOrFMmyM+30TOgKYOKUr0h0AFCGSM=;
 b=cTNwmm9it3R2yLQ6slRF1JtCMgfy0S/1XHJQ3O0w724Y/6YTihoz/RZIvYnV7iUxecKbTR
 wJyTHQ6NBaidZRALtKeb0B+X7c5N0Xl9QesMBmU1kOQ+vOhpuOY8HjpM80YsQp8S4Ct3Ng
 0xqFo/YAJxFeDtylQ98SHMJuDfnT+Eg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-nmyjx7c3PrmWmrFZ9oBHvQ-1; Fri,
 21 Mar 2025 08:36:20 -0400
X-MC-Unique: nmyjx7c3PrmWmrFZ9oBHvQ-1
X-Mimecast-MFC-AGG-ID: nmyjx7c3PrmWmrFZ9oBHvQ_1742560578
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7C3D196D2D8; Fri, 21 Mar 2025 12:36:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.38])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 386BF1801766; Fri, 21 Mar 2025 12:36:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 49E381800609; Fri, 21 Mar 2025 13:36:05 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 6/6] docs/firmware: add feature flag for host uefi variable
 store
Date: Fri, 21 Mar 2025 13:36:04 +0100
Message-ID: <20250321123604.2126923-7-kraxel@redhat.com>
In-Reply-To: <20250321123604.2126923-1-kraxel@redhat.com>
References: <20250321123604.2126923-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20250319141159.1461621-7-kraxel@redhat.com>
---
 docs/interop/firmware.json | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 57f55f6c5455..745d21d82232 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -214,13 +214,23 @@
 #                  PL011 UART. @verbose-static is mutually exclusive
 #                  with @verbose-dynamic.
 #
+# @host-uefi-vars: The firmware expects the host to provide an uefi
+#                  variable store.  qemu supports that via
+#                  "uefi-vars-sysbus" (aarch64, riscv64, loongarch64)
+#                  or "uefi-vars-x64" (x86_64) devices.  The firmware
+#                  will not use flash for nvram.  When loading the
+#                  firmware into flash the 'stateless' setup should be
+#                  used.  It is recommened to load the firmware into
+#                  memory though.
+#
 # Since: 3.0
 ##
 { 'enum' : 'FirmwareFeature',
   'data' : [ 'acpi-s3', 'acpi-s4',
              'amd-sev', 'amd-sev-es', 'amd-sev-snp',
              'intel-tdx',
-             'enrolled-keys', 'requires-smm', 'secure-boot',
+             'enrolled-keys', 'requires-smm',
+             'secure-boot', 'host-uefi-vars',
              'verbose-dynamic', 'verbose-static' ] }
 
 ##
-- 
2.49.0


