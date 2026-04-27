Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C463DFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRtm-0008UR-Al; Mon, 27 Apr 2026 15:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRtk-0008IE-8M
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:45:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRti-0008Pp-KE
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TrJVVZU6/Vb8qTLcl1rdJM/fVCkqBrqY+cxIoO1k+u8=;
 b=WXitdktzg5/WFxeTY3l73tOfaHPObzCi3EeKw4OjBPtmp7pHXKn1CEkKOm0vUror+HnmtD
 OQAaj5BhlvcPjfh47HqNa2iL3qhcTHHHeAJfalfVZWIP96A6cc4kkXa2LRMPL4ygSXpAqk
 8IXfI7Q6jwyC13DJpH8yiwvjWoNS4ik=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-jdhpb1OVPYiS51WHP1gnmQ-1; Mon,
 27 Apr 2026 15:45:34 -0400
X-MC-Unique: jdhpb1OVPYiS51WHP1gnmQ-1
X-Mimecast-MFC-AGG-ID: jdhpb1OVPYiS51WHP1gnmQ_1777319133
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA0E01800EC6; Mon, 27 Apr 2026 19:45:32 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 137BB19560AB; Mon, 27 Apr 2026 19:45:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:30 +0400
Subject: [PATCH 31/41] hw/arm/aspeed: free fmc_model and spi_model on
 finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-31-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1317;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=QmEwAllDpvGZxHEBIiH8j7FQV0Uib/7g87F76P7ZxvM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wV9VjLQBf/gHgH1FKdJL2Xn8D2iHAdgciYJ
 l6K3wXMshKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FQAKCRDa6OEJdZac
 5c4sEACZaigFcm1E8MQN8NsoAQIovauBv5iv6cFaus+D6+fU767G9Zs7kc0nr2iWWVRFTuwGzZk
 YqNLBe6id+Pf4E7m+zyPMXbYLe42uqgSKXkSQEkSvayCrp/+W+33mHJLzeJlw2ZS65DsAuKwn5e
 W8xXmODioL8/X1lYcCLmXWWFLaf5R5KbkVyFFjJX7PzdLlnXf+cxdmuqYlBqztrDf0StboLKIgf
 7osIkojRoMkWIegtouNvidYKxLPfc2qKy+Df4Xp6VdC1mM3sXDJ8TqL8iTLr0i/6/gBejWCiTwj
 jJ2h1imxulmhxr4Dl9eNyeT2VprRCzb+xPlCTE7K75KpeBSm0QZURjISalPzLkybi80WuEu+tGC
 U3fGZvwrY6F1zmDeMJNQjIOu5HDy/oH/uMmlGBSxcMKfeceUWkc1wA2J96Eb0PBVU6tFcLdfNId
 7PZzcZkUOmrBQvKVZ/IKgOKIL3YtBnYehLHTqPwQL4OeGuclVFCNXzuW5bTLjMiETtFOm6vxizg
 5MUe3Y1qjbknjVb9FBNk05dws6rIYS0NpHGWXWu+7cwNCUZTnpBquPk4Glpt/ENe7G0BJXmB+1N
 phiEMzPZnmLd2q8xtF7tG95fYvHZwFAKcNsZQ2N0GmLDOLjp6P+MQ6F7XrnKmJXFt1rmGl7Qw+i
 wFsKC+lZ7QfVI3A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The fmc_model and spi_model strings are allocated via g_strdup in
property setters but never freed when the machine object is destroyed.

Fixes: 9820e52fbef7 ("hw/arm/aspeed: Add machine properties to define the flash models")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/arm/aspeed.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index a3db3406c5f..a48c4420583 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -419,12 +419,21 @@ static void aspeed_machine_class_init(ObjectClass *oc, const void *data)
     aspeed_machine_class_props_init(oc);
 }
 
+static void aspeed_machine_instance_finalize(Object *obj)
+{
+    AspeedMachineState *bmc = ASPEED_MACHINE(obj);
+
+    g_free(bmc->fmc_model);
+    g_free(bmc->spi_model);
+}
+
 static const TypeInfo aspeed_machine_types[] = {
     {
         .name          = TYPE_ASPEED_MACHINE,
         .parent        = TYPE_MACHINE,
         .instance_size = sizeof(AspeedMachineState),
         .instance_init = aspeed_machine_instance_init,
+        .instance_finalize = aspeed_machine_instance_finalize,
         .class_size    = sizeof(AspeedMachineClass),
         .class_init    = aspeed_machine_class_init,
         .abstract      = true,

-- 
2.53.0


