Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BD7CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcLzW-0007am-DJ; Wed, 24 Jun 2026 07:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcLzU-0007aH-Lo
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:42:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcLzT-0007aW-5h
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vczqbItL4HK30XxRE+DcjNlBuXut/LSRWV0zFWitP9w=;
 b=SQcrR31QVlGZN9eKGKLaBTiU17bUwA8sYUIr6WN5wps6FTmcul7AP5Y9/WvQPQ9R6Ei25C
 zmvC+qVHRxoR4CiCarDjElKOECGwCdjRT27PEonjFmztMZWtj/hzwZxfsTzHiBRWc8mxK/
 Cc70uppNlBORCJidrcYoThnqAuCvCeQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639--HBPgmWXPx62XmgzD177gw-1; Wed,
 24 Jun 2026 07:41:56 -0400
X-MC-Unique: -HBPgmWXPx62XmgzD177gw-1
X-Mimecast-MFC-AGG-ID: -HBPgmWXPx62XmgzD177gw_1782301316
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0ABCE1955F07
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:41:56 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9ECBA1955F7A; Wed, 24 Jun 2026 11:41:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:26 +0400
Subject: [GIT PULL 04/35] scripts/lsan_suppressions: suppress fontconfig leaks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-4-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1016;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=zt/pQu2Inuys4dVDvXDp2sUcT8roo/0x8IoywLFrTpE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8Jm7ADrHuTxxZ4ttFFSt+QhGYP6qVvxET6hM
 ZEiODqjO/iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCZgAKCRDa6OEJdZac
 5aGwD/9rjrTUdpP1zNPilGd0uBAhNAeF7a4vJ6Dq0x/Vz1gb8fgX/QGpZ1R6oJdjRrBQ4HmWNZI
 BqR8FscSOkjy+qirmBOgvyeAi+b6/hmM0xw+YvgSmSfRaQbewGbt/qiciZNvcb8Yi+Dl8MITDYL
 EDtQhk/89ADHxqT2ChsBGvwH/affha0eHXCgu+7GZNC+uFT8fqRFHFvNZYmnd4GH0hkuBS2xiuC
 zEQ8QwDhmuPIe0TYuVoiUmsJ/7M/p6f21N96cokuyUNWUySZ9whYDaNyW2WaCd+e1hKsZg8ceDl
 lMMCyZt7VE9OvZXzhhAmlYiLp6Y6aWdILgHoxiHcDFO7O7ph/9qwhRL7iKSrNhZaV0lXsZ9hn34
 uqWJXuC9Mgjkj8wPm1JQfpIiLCaU4qDxswoNsxQUGIyy0B6lDxYetxX2NqY5aSmdLqiHeLk6PyX
 OEXH5rCgL/8vQBGT6xAbARFOiGofXZngdXxZ38nLhb0A3msiSZL95xAA3BC/MHI3zQWDoZxIC/d
 lghNuThIQCU4Wt+hkc2OsDU5QrShRnBEcUspg3r96xYwAj9SlZdJRreGL9yNa0jbn1B0WbXWzJ/
 Fy1/c/okEzWi0UhZWl33hHq3OMrONcyoeNxY47JkkPjzV/pz8ApnrdJitTAAcAUWH4thmSWw0gh
 4WT2WArf+LSe+Ng==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Those are annoying reports for gtk/sdl etc.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-4-4656aec3398d@redhat.com>
---
 scripts/lsan_suppressions.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/lsan_suppressions.txt b/scripts/lsan_suppressions.txt
index 30256bc6d01..f3b827facff 100644
--- a/scripts/lsan_suppressions.txt
+++ b/scripts/lsan_suppressions.txt
@@ -10,6 +10,10 @@ leak:/lib64/libtcmalloc_minimal.so.4
 # libxkbcommon also leaks in qemu-keymap
 leak:/lib64/libxkbcommon.so.0
 
+# libfontconfig leaks are notorious, for ex
+# https://gitlab.freedesktop.org/fontconfig/fontconfig/-/work_items/519
+leak:libfontconfig.so
+
 # g_set_user_dirs() deliberately leaks the previous cached g_get_user_*
 # values. This is documented in upstream glib's valgrind-format
 # suppression file:

-- 
2.54.0


