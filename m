Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C553C35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 08:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqTiO-00082s-GW; Tue, 17 Sep 2024 04:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sqTiN-0007xX-68
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:37:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sqTiL-0006Dw-IH
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726562256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cQV4dLPvgzGlPMhKSmvh+b3FRZfVIgNpQ8FZLUAJEsI=;
 b=XBOcJAjghkb8jnXWpnEDjVbu6Nqov+TcbVxLW16weNtFcORFJRFv/66foA8VcEMzjvk0uI
 KbzGUq8wVS9cZayYqYoomN1PbfeT4gQmc0PHhl2+WhiuoFOPL7ydK5bbztJiyYQGLZ6akh
 vsOVKbknZb41PcmF8DN3qq1GPDg5XeE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-bbMEuRxVPUSx_nZE0TnA4w-1; Tue,
 17 Sep 2024 04:37:33 -0400
X-MC-Unique: bbMEuRxVPUSx_nZE0TnA4w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4646B195604F; Tue, 17 Sep 2024 08:37:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.72])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F36AB19560AD; Tue, 17 Sep 2024 08:37:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0F0C618009B8; Tue, 17 Sep 2024 10:37:18 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Song Gao <gaosong@loongson.cn>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 6/7] tests/acpi: update aarch64/virt/SSDT.memhp
Date: Tue, 17 Sep 2024 10:37:00 +0200
Message-ID: <20240917083709.571436-7-kraxel@redhat.com>
In-Reply-To: <20240917083709.571436-1-kraxel@redhat.com>
References: <20240917083709.571436-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Address (and checksum) change due to firmware image size change.

 DefinitionBlock ("", "SSDT", 1, "BOCHS ", "NVDIMM", 0x00000001)
 [ ... ]
-    Name (MEMA, 0x43C80000)
+    Name (MEMA, 0x43DA0000)

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 tests/data/acpi/aarch64/virt/SSDT.memhp | Bin 1817 -> 1817 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/data/acpi/aarch64/virt/SSDT.memhp b/tests/data/acpi/aarch64/virt/SSDT.memhp
index fb3dcde5a10936667ad75a759b8bd444a7b19fc2..1deb1d2832201a5da7501821f1ea20d3eecb08b2 100644
GIT binary patch
delta 22
dcmbQqH<OPmIM^jblAVEpan43AUUsHi&Hz111wsG-

delta 22
dcmbQqH<OPmIM^jblAVEpaot8PUUsGv&Hz2O1wsG-

-- 
2.46.0


