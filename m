Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4099C18E7C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 16:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmxqC-0001FV-7M; Tue, 25 Feb 2025 11:31:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tmxpu-00012O-4T
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 11:31:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tmxpr-0006Zd-Vy
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 11:31:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740501067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t/vP1Y+kMo8kS2TrEex+VX8EYhsx5K4oxWryHizZVQE=;
 b=KrJdjZbC6vdQiXx1rUpfM8NLWO4MxSybBcyWTqiVEDW3pBeW8DRe/gPUSO5FQ7LyiKgHBC
 XYv54yAtypaoyrKZMLn+6jjFXlZjFxPYpLTKy0UFDdBhnVjk4LIBHQ92UYBnqLe3hA2S1d
 m9T5dmJ0IXFTdMH05agv9QgG5/r8qyE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-aYEHmfkGMKC9eO_gsJEXdw-1; Tue,
 25 Feb 2025 11:31:05 -0500
X-MC-Unique: aYEHmfkGMKC9eO_gsJEXdw-1
X-Mimecast-MFC-AGG-ID: aYEHmfkGMKC9eO_gsJEXdw_1740501064
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71B7B1801A1A; Tue, 25 Feb 2025 16:31:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.219])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6243A19560A3; Tue, 25 Feb 2025 16:31:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 86147180078A; Tue, 25 Feb 2025 17:30:32 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Ard Biesheuvel <ardb@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, graf@amazon.com,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 15/24] hw/uefi: add trace-events
Date: Tue, 25 Feb 2025 17:30:19 +0100
Message-ID: <20250225163031.1409078-16-kraxel@redhat.com>
In-Reply-To: <20250225163031.1409078-1-kraxel@redhat.com>
References: <20250225163031.1409078-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add trace events for debugging and trouble shooting.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/trace-events | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 hw/uefi/trace-events

diff --git a/hw/uefi/trace-events b/hw/uefi/trace-events
new file mode 100644
index 000000000000..3694712a946d
--- /dev/null
+++ b/hw/uefi/trace-events
@@ -0,0 +1,17 @@
+# device
+uefi_reg_read(uint64_t addr, unsigned size) "addr 0x%" PRIx64 ", size %u"
+uefi_reg_write(uint64_t addr, uint64_t val, unsigned size) "addr 0x%" PRIx64 ", val 0x%" PRIx64 ", size %d"
+uefi_hard_reset(void) ""
+
+# generic uefi
+uefi_variable(const char *context, const char *name, uint64_t size, const char *uuid) "context %s, name %s, size %" PRIu64 ", uuid %s"
+uefi_status(const char *context, const char *name) "context %s, status %s"
+uefi_event(const char *name) "event %s"
+
+# variable protocol
+uefi_vars_proto_cmd(const char *cmd) "cmd %s"
+uefi_vars_security_violation(const char *reason) "reason %s"
+
+# variable policy protocol
+uefi_vars_policy_cmd(const char *cmd) "cmd %s"
+uefi_vars_policy_deny(const char *reason) "reason %s"
-- 
2.48.1


