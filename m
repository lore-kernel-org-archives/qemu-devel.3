Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F1EC71136
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 18:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPQ9n-0001X2-3c; Wed, 11 Jun 2025 14:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uPQ9f-0001Qg-FJ
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:26:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uPQ9I-0001Fz-BC
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749666363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UQNXH4s6oZwiIt3/fk9WMce4UX8+i3+RrT8bw0pK+dY=;
 b=aJPfENxZNKAaHq5beoh9bxiw7rOLZAtJlwFmww9lvRbYymGQTL7qd5wR5yatuBr+lZfyBc
 DobUYtI56mCuxnSlxsAt0vvGHyGf0joqkj9tnm53T3p8zZWdfdjeB46kLIbQBdN2EqYhWk
 2mWs9PR1VkaaWLmjpRsjSSSLI5Pm148=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-FQt9AiT3P5azAo_his_eOA-1; Wed,
 11 Jun 2025 14:25:59 -0400
X-MC-Unique: FQt9AiT3P5azAo_his_eOA-1
X-Mimecast-MFC-AGG-ID: FQt9AiT3P5azAo_his_eOA_1749666356
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AE341800283; Wed, 11 Jun 2025 18:25:54 +0000 (UTC)
Received: from localhost (unknown [10.2.16.122])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 389FA18003FC; Wed, 11 Jun 2025 18:25:50 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-block@nongnu.org, Jesper Devantier <foss@defmacro.it>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Troy Lee <leetroy@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Fam Zheng <fam@euphon.net>, Sven Schnelle <svens@stackframe.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Hannes Reinecke <hare@suse.com>, Klaus Jensen <its@irrelevant.dk>,
 Jeuk Kim <jeuk20.kim@samsung.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Rob Herring <robh@kernel.org>, Steven Lee <steven_lee@aspeedtech.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 01/31] include/qemu/compiler: add QEMU_UNINITIALIZED attribute
 macro
Date: Wed, 11 Jun 2025 14:25:03 -0400
Message-ID: <20250611182533.200590-2-stefanha@redhat.com>
In-Reply-To: <20250611182533.200590-1-stefanha@redhat.com>
References: <20250611182533.200590-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The QEMU_UNINITIALIZED macro is to be used to skip the default compiler
variable initialization done by -ftrivial-auto-var-init=zero.

Use this in cases where there a method in the device I/O path (or other
important hot paths), that has large variables on the stack. A rule of
thumb is that "large" means a method with 4kb data in the local stack
frame. Any variables which are KB in size, should be annotated with this
attribute, to pre-emptively eliminate any potential overhead from the
compiler zero'ing memory.

Given that this turns off a security hardening feature, when using this
to flag variables, it is important that the code is double-checked to
ensure there is no possible use of uninitialized data in the method.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20250610123709.835102-2-berrange@redhat.com
[DB: split off patch & rewrite guidance on when to use the annotation]
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/compiler.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 496dac5ac1..65b89958d3 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -207,6 +207,26 @@
 # define QEMU_USED
 #endif
 
+/*
+ * Disable -ftrivial-auto-var-init on a local variable.
+ *
+ * Use this in cases where there a method in the device I/O path (or other
+ * important hot paths), that has large variables on the stack. A rule of
+ * thumb is that "large" means a method with 4kb data in the local stack
+ * frame. Any variables which are KB in size, should be annotated with this
+ * attribute, to pre-emptively eliminate any potential overhead from the
+ * compiler's implicit zero'ing of memory.
+ *
+ * Given that this turns off a security hardening feature, when using this
+ * to flag variables, it is important that the code is double-checked to
+ * ensure there is no possible use of uninitialized data in the method.
+ */
+#if __has_attribute(uninitialized)
+# define QEMU_UNINITIALIZED __attribute__((uninitialized))
+#else
+# define QEMU_UNINITIALIZED
+#endif
+
 /*
  * http://clang.llvm.org/docs/ThreadSafetyAnalysis.html
  *
-- 
2.49.0


