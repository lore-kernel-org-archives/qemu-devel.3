Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8519DCD98E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE4o-0003CV-Hq; Mon, 15 Jun 2026 16:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE4m-0003BM-Aq
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE4k-0002HO-Tp
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781555910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CcXfLzNY8fSZYo9PLVA3EmHZ0GPkDr4koAHbu3BXWIg=;
 b=fhJvc4o23amNpDtlnYTudOGSliyFHcU3S/0vPxJohAnfnA/gRsqmiLU4Z7JAuKQADiv+W3
 KOISp+GlFJqyIp+Bmg+d4s9mmf1Stk9d/sM2i/zVTN4Te/2Gd+MQCyVDuUMr/w18XLfcEb
 UgMwv7UN9ykyTAvMKT+hQ2Vlklu6ZAQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-Jk1EO7zmODCYpvhLP684Ag-1; Mon,
 15 Jun 2026 16:38:26 -0400
X-MC-Unique: Jk1EO7zmODCYpvhLP684Ag-1
X-Mimecast-MFC-AGG-ID: Jk1EO7zmODCYpvhLP684Ag_1781555905
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C511619560B3; Mon, 15 Jun 2026 20:38:25 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D86F7180049F; Mon, 15 Jun 2026 20:38:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:37:34 +0400
Subject: [PATCH v2 08/53] qapi/qom: add qapi-type field to ObjectPropertyInfo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-8-cc9396b9c18c@redhat.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
In-Reply-To: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1867;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=l98NcHIYxcIgRoI9lT+AEGU4cey8Hr4xwKBBC+to5GQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKOyYTrKyfEqmrLB+Sb79rEj4qlPmzcKI4UQ
 1Nt7FhFMQ2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijgAKCRDa6OEJdZac
 5cq4EACWWySCz529dhE1qlmg69na1t7nQbHVSijr8LZagzISuMD6q9tfFop2yf5/gEddTXt0TBb
 P6xtekVDcFtFaf2V8SJgYowR8bsRRwx3cvvZ/WzQnNR4xFeTSzfI+pWUHSd1B1cwfIeSMB/OKeM
 x879AeCKBRg+TjpZ0ERExtFjLLB8IUYMR6kqa0QcJaV4pwGg9se7mK9tK49tAAg/KjQwHJRvXJi
 GTom+X2Qg1cHAUjfeylOi8we0I27QBWb3SWVEoAhPeFdepcxYzluOZHJ7/Si2c24h4ySnjyvRDA
 AHK448MbRO1FpV1zZSQqkfT24U7kxfBjUDGZrj5i2u4T9AjITDaBit6tykSp3MKLgaDSBpIXEG6
 p5Pg9qwwgxmK6WIUDgkzW8UsHdsahb8GMfb+JTxS4gtDgVCL1dRhq56odnD3NLnLnSOiAQT0SDB
 wwV6EqNRItQFtd0SZcokbL4fHQL1FD9ZHuy3QIkO5BHDdNNtg7IdKoKhWtp6UgeUAC5VbnS6v3m
 e9AtWj8Vhj3ARQasJ3TWGh25tBNHdW6A9EVUnD/n9+G0Oi8826Df4ggvPE+fnQy695tHVHWEPwg
 xlMpwGJhCLRhgFu/jB/XgsKtmyp8sXJ+DNALgeM91sfoUvP40AKJalAB5U1d269TE0+lz+tgMPq
 MZ9+OCmRuzU/2aw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add an optional 'qapi-type' field to ObjectPropertyInfo and
ObjectPropertyValue. When present, it contains the masked type name that
can be looked up in query-qmp-schema output. Absent for properties
without a QAPI type association.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qapi/qom.json | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/qapi/qom.json b/qapi/qom.json
index dd45ac1087c..a655be0beaa 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -35,6 +35,11 @@
 #        qdev device type name.  Link properties form the device model
 #        graph.
 #
+# @qapi-type: if the property was registered with a QAPI type
+#     association, the type name as it appears in the output of
+#     ``query-qmp-schema``.  Absent for properties without a QAPI
+#     type association.  (since 11.1)
+#
 # @description: if specified, the description of the property.
 #
 # @default-value: the default value, if any (since 5.0)
@@ -44,6 +49,7 @@
 { 'struct': 'ObjectPropertyInfo',
   'data': { 'name': 'str',
             'type': 'str',
+            '*qapi-type': 'str',
             '*description': 'str',
             '*default-value': 'any' } }
 
@@ -55,6 +61,11 @@
 # @type: the type of the property, as described in
 #     `ObjectPropertyInfo`.
 #
+# @qapi-type: if the property was registered with a QAPI type
+#     association, the type name as it appears in the output of
+#     ``query-qmp-schema``.  Absent for properties without a QAPI
+#     type association.  (since 11.1)
+#
 # @value: the value of the property.  Absent when the property cannot
 #     be read.
 #
@@ -63,6 +74,7 @@
 { 'struct': 'ObjectPropertyValue',
   'data': { 'name': 'str',
             'type': 'str',
+            '*qapi-type': 'str',
             '*value': 'any' } }
 
 ##

-- 
2.54.0


