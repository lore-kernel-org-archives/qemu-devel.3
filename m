Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F697C79F85
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a6e-0000yO-Ph; Fri, 04 Sep 2026 16:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a6W-0000ss-39
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:01:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a6T-0008Sx-V3
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tz/am8znVea0EH/I3yKmAvS/zTKGWDHDy5Io0oDOs84=;
 b=aJr/WBZYqmnvvrN1bq2dA2edmPM2rKFnQFksmyY9w85gNpyLCelf0rAPi7vSARPL628n2A
 JqqaUVPtqwELyqK3paGB+lW48tzkj0Ob6m7grbT4L51CQYceVUbuqPkd0fBbzMeaEOgdAA
 8Ficc4VTmufBkaEq3gCVmBczrqC8dwc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-xPEl46pCON6dOfEsoOvyGQ-1; Fri,
 04 Sep 2026 16:01:31 -0400
X-MC-Unique: xPEl46pCON6dOfEsoOvyGQ-1
X-Mimecast-MFC-AGG-ID: xPEl46pCON6dOfEsoOvyGQ_1788552090
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E7E11893EDE; Fri,  4 Sep 2026 20:01:30 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 990A07DC; Fri,  4 Sep 2026 20:01:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:37 +0400
Subject: [PATCH v4 54/75] hw/ppc/spapr_drc: convert fdt property to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-54-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=p8JanILoeFCoElHoPfG5YjLfU2MyrEO5wI6M3UiSSaA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLLZYtliGOoNv149VyVVY7BeDlQV1sAdI+xg
 BB7aVQzG0iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiywAKCRDa6OEJdZac
 5VdnD/9tZ0d70Ujucst6iT3VRYyt1b6f7KwLqU+mqUs1NDCmbfzFNPpmi43FG0AAwRVAGGLHjuy
 ahF9nBbquF3/VJJgd1FRlnFJcLzwlq0iFbrvB7gvD72d+vuMtmO7QmZDtOIJoRFwH/C7n+7wLyj
 kFinoewEM9mi3L7vr5pJ/NBf3NOv7Nf/29545HUem2YFrf5Ercoa4wLJxRWOcjvugfhoAZeDKTT
 sHFJXEJwoM94gcIRrY0V/h0TbVGsrpKPSWcaYnuXUZOTgMQkpfhDuz1btuXZH9rRiNaSjfiQtTD
 7f73rKwEpCj+6Hk3UWdNLCNPjVVR96EGdI3b4eBSgsj6fzI9ORT3Dk3vf3BOeWoFaTW8VqaXnWR
 oZVQfx8vkxA7JC47DhijDqGRxP+6qoANPKKTzptlVINR249quUOiVoZ9oc74VhXLWob0i+g+IQt
 5b6JQgZ+BO39/H+/QGXhYNGD5Lm2qm1GtPveOZ7FJeNgr3LguqKJT/DJGn+vF0w0ip4mwUR9AS6
 9KjKLikCq2GVA/WAVSMPPWTrHEx681kRnWbWVlUg4nqAfz8TNF2KKs2Fai/YT3dS2nervCljGWL
 ZzYQDP2xeRIpF1Zw9D3LaX2n9bL5BBswNu5V/+sHfj9sFqSMRkdG90cgS7/Ctv901rcToXYy8GY
 sFeSkQSLgRwLvPg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use object_property_add_qapi() with any_type_info for the "fdt"
property, since the FDT structure is dynamically shaped at runtime and
cannot be represented as a static QAPI type.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/ppc/spapr_drc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 64f9ca29b02e..740149ffdf3e 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -587,7 +587,7 @@ static void spapr_dr_connector_instance_init(Object *obj)
     object_property_add_uint32_ptr(obj, "id", &drc->id, OBJ_PROP_FLAG_READ);
     object_property_add_qapi(obj, "index", &uint32_type_info, prop_get_index,
                         NULL, NULL, NULL);
-    object_property_add(obj, "fdt", "struct", prop_get_fdt,
+    object_property_add_qapi(obj, "fdt", &any_type_info, prop_get_fdt,
                         NULL, NULL, NULL);
     drc->state = drck->empty_state;
 }

-- 
2.55.0.543.g5ebe2ebe4ea8


