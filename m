Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38ACCC3ABDF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAH7-0001Oi-8x; Wed, 14 May 2025 07:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFAH5-0001OO-Lf
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:27:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFAH3-00027k-UC
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747222065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+3xhh4BPTg8h0AIB2bmQVUR9EAcp4F80bu2hgOqAGbE=;
 b=JMQhUDepiYReP6FmyiVfwII4ga0NKihAruiu3mCOkh1ybIvExtcvmN/8+91QsC/H1WLDxN
 /Pgs4hB7nDOgJpZAVSly4ee8ot1PeKm2VynF6m4GFJhjDQ0tXZGqUNbsiOgruClXOry1KS
 CaMD9DsEKaUoKnyWtVj5t43rXk7BnW8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-wTSum3TvOE2h-SGzO-tpQw-1; Wed,
 14 May 2025 07:27:42 -0400
X-MC-Unique: wTSum3TvOE2h-SGzO-tpQw-1
X-Mimecast-MFC-AGG-ID: wTSum3TvOE2h-SGzO-tpQw_1747222061
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E99AB1956087; Wed, 14 May 2025 11:27:40 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 90E3019560A3; Wed, 14 May 2025 11:27:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 03/13] hw/s390x/event-facility: Remove the obsolete
 "allow_all_mask_sizes" code
Date: Wed, 14 May 2025 13:27:23 +0200
Message-ID: <20250514112733.456644-4-thuth@redhat.com>
In-Reply-To: <20250514112733.456644-1-thuth@redhat.com>
References: <20250514112733.456644-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

Now that the machine types 2.11 and older have been removed, we
don't need the "allow_all_mask_sizes" compatibility handling code
anymore and can remove it now.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250506062148.306084-4-thuth@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/event-facility.c | 37 +------------------------------------
 1 file changed, 1 insertion(+), 36 deletions(-)

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 1afe3645730..7b7bf237fed 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -45,13 +45,6 @@ struct SCLPEventFacility {
         uint32_t receive_mask_pieces[2];
         sccb_mask_t receive_mask;
     };
-    /*
-     * when false, we keep the same broken, backwards compatible behaviour as
-     * before, allowing only masks of size exactly 4; when true, we implement
-     * the architecture correctly, allowing all valid mask sizes. Needed for
-     * migration toward older versions.
-     */
-    bool allow_all_mask_sizes;
     /* length of the receive mask */
     uint16_t mask_length;
 };
@@ -294,8 +287,7 @@ static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
     uint16_t mask_length = be16_to_cpu(we_mask->mask_length);
     sccb_mask_t tmp_mask;
 
-    if (!mask_length || (mask_length > SCLP_EVENT_MASK_LEN_MAX) ||
-        ((mask_length != 4) && !ef->allow_all_mask_sizes)) {
+    if (!mask_length || mask_length > SCLP_EVENT_MASK_LEN_MAX) {
         sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_MASK_LENGTH);
         return;
     }
@@ -355,13 +347,6 @@ static bool vmstate_event_facility_mask64_needed(void *opaque)
     return (ef->receive_mask & 0xFFFFFFFF) != 0;
 }
 
-static bool vmstate_event_facility_mask_length_needed(void *opaque)
-{
-    SCLPEventFacility *ef = opaque;
-
-    return ef->allow_all_mask_sizes;
-}
-
 static const VMStateDescription vmstate_event_facility_mask64 = {
     .name = "vmstate-event-facility/mask64",
     .version_id = 0,
@@ -377,7 +362,6 @@ static const VMStateDescription vmstate_event_facility_mask_length = {
     .name = "vmstate-event-facility/mask_length",
     .version_id = 0,
     .minimum_version_id = 0,
-    .needed = vmstate_event_facility_mask_length_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT16(mask_length, SCLPEventFacility),
         VMSTATE_END_OF_LIST()
@@ -399,31 +383,12 @@ static const VMStateDescription vmstate_event_facility = {
      }
 };
 
-static void sclp_event_set_allow_all_mask_sizes(Object *obj, bool value,
-                                                       Error **errp)
-{
-    SCLPEventFacility *ef = (SCLPEventFacility *)obj;
-
-    ef->allow_all_mask_sizes = value;
-}
-
-static bool sclp_event_get_allow_all_mask_sizes(Object *obj, Error **errp)
-{
-    SCLPEventFacility *ef = (SCLPEventFacility *)obj;
-
-    return ef->allow_all_mask_sizes;
-}
-
 static void init_event_facility(Object *obj)
 {
     SCLPEventFacility *event_facility = EVENT_FACILITY(obj);
     DeviceState *sdev = DEVICE(obj);
 
     event_facility->mask_length = 4;
-    event_facility->allow_all_mask_sizes = true;
-    object_property_add_bool(obj, "allow_all_mask_sizes",
-                             sclp_event_get_allow_all_mask_sizes,
-                             sclp_event_set_allow_all_mask_sizes);
 
     /* Spawn a new bus for SCLP events */
     qbus_init(&event_facility->sbus, sizeof(event_facility->sbus),
-- 
2.49.0


