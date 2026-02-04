Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB00EA7941
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vni9q-0006Cp-5g; Wed, 04 Feb 2026 14:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vni9e-00060d-S8
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vni9d-0007iz-74
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s8o9e/d8lMOSdZF43VdPPly6c5Scmgonl/LFvLQlohY=;
 b=EtBqCaRH7yY+6FB4rzHTSOFXr42tpI3Tc+s9T+8KXW0r4E3XvGm40qk0qf0pfRq/84uZM4
 ClSOxwreNG/D6M449i0BYppgsc0+vLW0oCI05ENtmobCDTXKu8Gn2Y816DSizylwPvhtZc
 0zjx/7LwRcm5dsHWqsHofpCLo0WUmD0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-wLjfd27pMXmOZH8bSFbaFA-1; Wed, 04 Feb 2026 14:03:04 -0500
X-MC-Unique: wLjfd27pMXmOZH8bSFbaFA-1
X-Mimecast-MFC-AGG-ID: wLjfd27pMXmOZH8bSFbaFA_1770231783
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430f5dcd4cdso136354f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231783; x=1770836583; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=s8o9e/d8lMOSdZF43VdPPly6c5Scmgonl/LFvLQlohY=;
 b=g50qVF8F1zzsCyewCNkVCsh42Qg+mFo7w1v1Wc3zHGk8Po2psN/0thu0C5YDhi7Io+
 KhNefZ1P5HNFRrWynrf5SlckgQMLRNiGoT7rgcDF5Qjbzu5tVbUJJg3AeXuGDsG3qziF
 JMAW95AEQ82+OhPyeMNopmg1CdtzzshtRiDOfEYsa9OzUoBqRF4wkOD29bAKgVOVtmJ4
 5MSMQSnllnRu1s4ZDa5kc7Gs/TRyvwJNhLy6KPk0Iv3+bO56Q8kDvCFZ7C+lHiuF1L61
 1EHb7Z0xK0fH11JNav2yGb5BN6yuqkVu70mjZepZQngpHMylXgl1leQotPRtIwWxRmjG
 yiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231783; x=1770836583;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s8o9e/d8lMOSdZF43VdPPly6c5Scmgonl/LFvLQlohY=;
 b=fn4A/r2z8nOK106z1cPIrNowquavaN2J9WUaQPQBFYofpm3suW9hGGRPTslkAsH3bJ
 O8a995o4qoDT3iKjmkiA2xpbNkKQrKXg2FfnClyUMNYeoo8BXVU2p8QdMGbnj/ODLMtT
 ryerZ/PLlwuHBkUinFKmckAG18kn47bDIOwPavoReh8GhBqYjVem4fQG5Cn0PXBp3fLw
 NXv/XTFUwpF1HfUiBi+7jmxSRGfUoBPujY1AkmC8HZcbBqOxUMBCYHSowr1H/wUD1zgD
 PfsMtaKKGmGWqfv8r81HCmCtu5wcM9J9fssIlXh32s1Y9OuTQlvpdwTogQkxCaMtRaiJ
 XTdQ==
X-Gm-Message-State: AOJu0YwdBBNuQKbu2RMbidmWAW+uXtFpxOvN8H0Foy5SS5vPyVf5AtcK
 R0YTaheens6lbFc1zpmXZtz5emXJHVNHH3cMF1+cKlLJ9J9m8EiZlk8wIUMEk7PtNwoFuAk2H+J
 olpPFl9z4diyX2LZr9cKQ6Fkd8duQ62oCRJMFNTn+GQNIzqZ9G+dpQ0BphlQUSk/AKi6pVGvPtk
 7MVukL5U0kzYh/dql7l+izPz67S4NZVEuY3Q==
X-Gm-Gg: AZuq6aKLs7DpJPz0OkKAvRkwP/jiohFqoXhYtVCAi3NAflgfB/oSijVO2MxpDo/zP9e
 t+Mc+RlxA18ogW6ujZJjREL3NWh3Cg4lwlPx44B3nYlc/7hvyOTT76stJvu2Ss7dWIaMewQd2id
 m52OdEbXt/wcG0hcstxFraupBdK4PEbbYJfuopl/8ft0bUiscDZtse1UKp/z4GyfjMcOUEp3taC
 J/Fswhl6TbAuxgXvWY9Hl1CQzqONnPrkGvbDg86N6WP0f5POFUz5SmMqnzQh+knrG7DgYok9T+I
 OF+fR26XOF5XaILTwVXMXYBHov/YVKWj2FnokEwv9gGVlq+asyRNwyLKYeDMyUnxAMCZw/afEfW
 PDfmy165igObCag4IlhPGbf+cX4YX8CoLtA==
X-Received: by 2002:a05:6000:24c6:b0:435:ab90:6f34 with SMTP id
 ffacd0b85a97d-43617e3fcf9mr5438935f8f.16.1770231782811; 
 Wed, 04 Feb 2026 11:03:02 -0800 (PST)
X-Received: by 2002:a05:6000:24c6:b0:435:ab90:6f34 with SMTP id
 ffacd0b85a97d-43617e3fcf9mr5438886f8f.16.1770231782333; 
 Wed, 04 Feb 2026 11:03:02 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43618057f93sm8039320f8f.24.2026.02.04.11.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:03:01 -0800 (PST)
Date: Wed, 4 Feb 2026 14:03:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shiju Jose <shiju.jose@huawei.com>, Markus Armbruster <armbru@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Eric Blake <eblake@redhat.com>
Subject: [PULL 05/51] qapi: cxl: Refactor CXL event injection for common
 commands arguments
Message-ID: <785b458d94343c629d353628f9cf6e5774dbc2f6.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Shiju Jose <shiju.jose@huawei.com>

Refactor CXL event injection to use struct for common command
arguments.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260114142713.617806-2-Jonathan.Cameron@huawei.com>
---
 qapi/cxl.json | 89 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 31 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index eeddb58d1d..55a088586e 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -31,11 +31,10 @@
  }
 
 ##
-# @cxl-inject-general-media-event:
+# @CXLCommonEventBase:
 #
-# Inject an event record for a General Media Event (CXL r3.0
-# 8.2.9.2.1.1).  This event type is reported via one of the event logs
-# specified via the log parameter.
+# Common event base for a CXL Event (CXL r3.0 8.2.9.2.1
+# Table 8-42 Common Event Record Format).
 #
 # @path: CXL type 3 device canonical QOM path
 #
@@ -44,6 +43,16 @@
 # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
 #     Record Format, Event Record Flags for subfield definitions.
 #
+# Since: 8.1
+##
+{ 'struct': 'CXLCommonEventBase',
+  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8' } }
+
+##
+# @CXLGeneralMediaEvent:
+#
+# Event record for a General Media Event (CXL r3.0 8.2.9.2.1.1).
+#
 # @dpa: Device Physical Address (relative to @path device).  Note
 #     lower bits include some flags.  See CXL r3.0 Table 8-43 General
 #     Media Event Record, Physical Address.
@@ -74,26 +83,29 @@
 #
 # Since: 8.1
 ##
-{ 'command': 'cxl-inject-general-media-event',
-  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
-            'dpa': 'uint64', 'descriptor': 'uint8',
+{ 'struct': 'CXLGeneralMediaEvent',
+  'base': 'CXLCommonEventBase',
+  'data': { 'dpa': 'uint64', 'descriptor': 'uint8',
             'type': 'uint8', 'transaction-type': 'uint8',
             '*channel': 'uint8', '*rank': 'uint8',
             '*device': 'uint32', '*component-id': 'str' } }
 
 ##
-# @cxl-inject-dram-event:
+# @cxl-inject-general-media-event:
 #
-# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
-# This event type is reported via one of the event logs specified via
-# the log parameter.
+# Inject an event record for a General Media Event (CXL r3.0
+# 8.2.9.2.1.1).  This event type is reported via one of the event
+# logs specified via the log parameter.
 #
-# @path: CXL type 3 device canonical QOM path
+# Since: 8.1
+##
+{ 'command': 'cxl-inject-general-media-event',
+  'data': 'CXLGeneralMediaEvent' }
+
+##
+# @CXLDRAMEvent:
 #
-# @log: Event log to add the event to
-#
-# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
-#     Record Format, Event Record Flags for subfield definitions.
+# Event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
 #
 # @dpa: Device Physical Address (relative to @path device).  Note
 #     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
@@ -133,9 +145,9 @@
 #
 # Since: 8.1
 ##
-{ 'command': 'cxl-inject-dram-event',
-  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
-            'dpa': 'uint64', 'descriptor': 'uint8',
+{ 'struct': 'CXLDRAMEvent',
+  'base': 'CXLCommonEventBase',
+  'data': { 'dpa': 'uint64', 'descriptor': 'uint8',
             'type': 'uint8', 'transaction-type': 'uint8',
             '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
             '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
@@ -143,18 +155,21 @@
            }}
 
 ##
-# @cxl-inject-memory-module-event:
+# @cxl-inject-dram-event:
 #
-# Inject an event record for a Memory Module Event (CXL r3.0
-# 8.2.9.2.1.3).  This event includes a copy of the Device Health info
-# at the time of the event.
+# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
+# This event type is reported via one of the event logs
+# specified via the log parameter.
 #
-# @path: CXL type 3 device canonical QOM path
+# Since: 8.1
+##
+{ 'command': 'cxl-inject-dram-event',
+  'data': 'CXLDRAMEvent' }
+
+##
+# @CXLMemModuleEvent:
 #
-# @log: Event Log to add the event to
-#
-# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
-#     Record Format, Event Record Flags for subfield definitions.
+# Event record for a Memory Module Event (CXL r3.0 8.2.9.2.1.3).
 #
 # @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
 #     Event Record for bit definitions for bit definiions.
@@ -185,9 +200,9 @@
 #
 # Since: 8.1
 ##
-{ 'command': 'cxl-inject-memory-module-event',
-  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint8',
-            'type': 'uint8', 'health-status': 'uint8',
+{ 'struct': 'CXLMemModuleEvent',
+  'base': 'CXLCommonEventBase',
+  'data': { 'type': 'uint8', 'health-status': 'uint8',
             'media-status': 'uint8', 'additional-status': 'uint8',
             'life-used': 'uint8', 'temperature' : 'int16',
             'dirty-shutdown-count': 'uint32',
@@ -195,6 +210,18 @@
             'corrected-persistent-error-count': 'uint32'
             }}
 
+##
+# @cxl-inject-memory-module-event:
+#
+# Inject an event record for a Memory Module Event (CXL r3.0
+# 8.2.9.2.1.3).  This event includes a copy of the Device Health info
+# at the time of the event.
+#
+# Since: 8.1
+##
+{ 'command': 'cxl-inject-memory-module-event',
+  'data': 'CXLMemModuleEvent' }
+
 ##
 # @cxl-inject-poison:
 #
-- 
MST


