Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3268EE77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 10:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN8h6-0004Mu-9c; Mon, 16 Dec 2024 05:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tN8h2-0004Kd-DB
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 05:51:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tN8h0-0005QE-9A
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 05:51:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734346272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8lJRS/uMo3zV7XiUqogGKGMtiS1CO54wNJfbudnlOtg=;
 b=Rd2v4DDDgbbt3mTXeNcZcMwiGkUwpvdUMKp+bzTN3wcbO3XPOBVWl4iLyyglV6+yxSpQl0
 IFqSjsfV0o+YxvU8fvGSjh2iqMKmp0oFN3nzNR3yfpWmsHXrKNSSZB0Y6IxkP8IzXTkBEP
 YqTuj2gwKphSDNeTgRFb11BjrSPSMUo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-rWyZwKU_P5KJL4J-XzVHgw-1; Mon,
 16 Dec 2024 05:51:09 -0500
X-MC-Unique: rWyZwKU_P5KJL4J-XzVHgw-1
X-Mimecast-MFC-AGG-ID: rWyZwKU_P5KJL4J-XzVHgw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E48E1956046; Mon, 16 Dec 2024 10:51:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.88])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A226195394B; Mon, 16 Dec 2024 10:51:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2C5F51800602; Mon, 16 Dec 2024 11:50:54 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Jaloo <liu.jaloo@gmail.com>
Subject: [PULL 7/7] roms: re-add edk2-basetools target
Date: Mon, 16 Dec 2024 11:50:53 +0100
Message-ID: <20241216105053.246204-8-kraxel@redhat.com>
In-Reply-To: <20241216105053.246204-1-kraxel@redhat.com>
References: <20241216105053.246204-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.168,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Needed to build ipxe nic roms.

Reported-by: Liu Jaloo <liu.jaloo@gmail.com>
Fixes: 22e11539e167 ("edk2: replace build scripts")
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20241212084408.1390728-1-kraxel@redhat.com>
---
 roms/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/roms/Makefile b/roms/Makefile
index dfed2b216a1e..31e4b97c983b 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -157,6 +157,11 @@ edk2-version: edk2
 		touch $@; \
 	fi
 
+edk2-basetools: edk2-version
+	$(PYTHON) edk2-build.py --config edk2-build.config \
+		--silent --no-logs \
+		--match none # build only basetools
+
 efi: edk2-version
 	$(PYTHON) edk2-build.py --config edk2-build.config \
 		--version-override "$(EDK2_STABLE)$(FIRMWARE_EXTRAVERSION)" \
-- 
2.47.1


