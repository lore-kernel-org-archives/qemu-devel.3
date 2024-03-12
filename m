Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534D1C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1Ue-00034p-01; Tue, 12 Mar 2024 08:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1UK-0002OF-PP
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1UF-00008X-PX
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710247445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b1l6WbAUCt0bM585OCGgo0YKxZvXleO/qSAwsOqY+TA=;
 b=fee1+6VZqJgW69pnLAl85rkcgeErAaCIx/UHEwvmw1pjzqDMKSHDrX0JRB8MlO2APqfdYe
 I305+d7E3KoU1033a0Klbr+BGLEuZ/9kgasLOzVEQXJ3vVxxnjyXjwYK1xvUEhc9zdhQKo
 reOtua5MRLMxDedk2w1NOBeg+uw3Zro=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-MzZ7g4qLNuS9D3MUPaetLA-1; Tue, 12 Mar 2024 08:44:02 -0400
X-MC-Unique: MzZ7g4qLNuS9D3MUPaetLA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3B818007A2;
 Tue, 12 Mar 2024 12:43:44 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D5E20492BC4;
 Tue, 12 Mar 2024 12:43:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 02/55] hw/display/macfb: Fix missing ERRP_GUARD() in
 macfb_nubus_realize()
Date: Tue, 12 Mar 2024 13:42:46 +0100
Message-ID: <20240312124339.761630-3-thuth@redhat.com>
In-Reply-To: <20240312124339.761630-1-thuth@redhat.com>
References: <20240312124339.761630-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

As the comment in qapi/error, dereferencing @errp requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
* - It must not be dereferenced, because it may be null.
...
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.
*
* Using it when it's not needed is safe, but please avoid cluttering
* the source with useless code.

But in macfb_nubus_realize(), @errp is dereferenced without
ERRP_GUARD():

ndc->parent_realize(dev, errp);
if (*errp) {
    return;
}

Here we check *errp, because the ndc->parent_realize(), as a
DeviceClass.realize() callback, returns void. And since
macfb_nubus_realize(), also as a DeviceClass.realize(), doesn't get the
NULL @errp parameter, it hasn't triggered the bug that dereferencing the
NULL @errp.

To follow the requirement of @errp, add missing ERRP_GUARD() in
macfb_nubus_realize().

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240223085653.1255438-3-zhao1.liu@linux.intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/display/macfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index 418e99c8e1..1ace341a0f 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -714,6 +714,7 @@ static void macfb_nubus_set_irq(void *opaque, int n, int level)
 
 static void macfb_nubus_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_GUARD();
     NubusDevice *nd = NUBUS_DEVICE(dev);
     MacfbNubusState *s = NUBUS_MACFB(dev);
     MacfbNubusDeviceClass *ndc = NUBUS_MACFB_GET_CLASS(dev);
-- 
2.44.0


