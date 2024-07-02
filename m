Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8310DC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeCL-0007NH-2i; Tue, 02 Jul 2024 10:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeBu-0005Tf-5T
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeBi-0008F3-1Z
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YhLUD4bgFXykNLby5YqUbG3vAr/0cDl4XOSKHnOq4eQ=;
 b=SWNkcraKwU+33j8Fgk90fQ1vdE7xjwVKNwuqn4TIaDBeLLLFrIjw4folk3SDHnnGcgRzTQ
 /R3eiFUab5jhuoqIFbKl4Jhvdu97mt14LZO3v52qES2IEwH3iP5cF5TWEJnkAlVMYP82Ba
 Vt0Pp0Wj91PrSBM+YjKtQACh6SdIDJc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-xFZh1DHaNxec_NAuDZacHQ-1; Tue, 02 Jul 2024 10:08:47 -0400
X-MC-Unique: xFZh1DHaNxec_NAuDZacHQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-36248c176c4so2741921f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929326; x=1720534126;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YhLUD4bgFXykNLby5YqUbG3vAr/0cDl4XOSKHnOq4eQ=;
 b=F5GsLF8QGVgqUX/z/FTAdu7BR/km9MPJo00M4wNB2CSNwJoCc9da9oBcy1sgJIumDd
 okBESnRZsoTSPAeJtsxECoNwtG/pdYKc3cIobRJ6TaLZfNYWTBzw/3AlKKQFiGt7EENy
 sku/ex0mD5YELGrQnyx3r4W1DVSSoVEEINWQlrtvbLTZtycECcN8j1Z4ICZ/5n4jl3pF
 iRDyhyqckNsyripYYQFWDSKd/AArjb2xvzarLdOcEaiSvDTrw+lZMPIo/mX4hjIcFWTI
 kT3cET/x4eiFsc7yfgLLqt/v4hulkf93BUsa6VSNA16vezcvtz1uIJSywGkXhispic2s
 dWag==
X-Gm-Message-State: AOJu0YwHlH7W/NjBqpALgGGQ84PpCE6rvja5DPciPsqLZ4wbzXHO0rG7
 lDIWO9rCOrGSasvCQGVWkiMROiSdDUuNWVa6LVdmIWt6BRV0hCIBTMVeZ/GjhL0r2lv20QFvGFd
 2TVtPPzfVnpgMEolAi0Fhabm1OEBFY51BrNwjAcpjizjEofPJ2pHIJ1Fv6fwTaDfFTzQ3LAhtgx
 FU+y3Sbu/cSfk/n84443elaU2QoLFNYA==
X-Received: by 2002:a05:6000:400d:b0:366:e685:d0cb with SMTP id
 ffacd0b85a97d-3677569762bmr5969476f8f.6.1719929325921; 
 Tue, 02 Jul 2024 07:08:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlI1QbSiDmh8c9mM8CHdiAhR8Qlw9actoZSffLipZLpZ5KSZcQDn3VxWE9L5My8VJlIfJPFw==
X-Received: by 2002:a05:6000:400d:b0:366:e685:d0cb with SMTP id
 ffacd0b85a97d-3677569762bmr5969447f8f.6.1719929325317; 
 Tue, 02 Jul 2024 07:08:45 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36789fd7a0esm1532692f8f.104.2024.07.02.07.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:08:44 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:08:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 34/91] pvpanic: Emit GUEST_PVSHUTDOWN QMP event on pvpanic
 shutdown signal
Message-ID: <8db1f7be788b23f8eca189fe4546298ed387e9cb.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Emit a QMP event on receiving a PVPANIC_SHUTDOWN event. Even though a typical
SHUTDOWN event will be sent, it will be indistinguishable from a shutdown
originating from other cases (e.g. KVM exit due to KVM_SYSTEM_EVENT_SHUTDOWN)
that also issue the guest-shutdown cause.
A management layer application can detect the new GUEST_PVSHUTDOWN event to
determine if the guest is using the pvpanic interface to request shutdowns.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Message-Id: <20240527-pvpanic-shutdown-v8-6-5a28ec02558b@t-8ch.de>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/run-state.json | 14 ++++++++++++++
 system/runstate.c   |  1 +
 2 files changed, 15 insertions(+)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index f8773f23b2..5ac0fec852 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -462,6 +462,20 @@
 { 'event': 'GUEST_CRASHLOADED',
   'data': { 'action': 'GuestPanicAction', '*info': 'GuestPanicInformation' } }
 
+##
+# @GUEST_PVSHUTDOWN:
+#
+# Emitted when guest submits a shutdown request via pvpanic interface
+#
+# Since: 9.1
+#
+# Example:
+#
+#     <- { "event": "GUEST_PVSHUTDOWN",
+#          "timestamp": { "seconds": 1648245259, "microseconds": 893771 } }
+##
+{ 'event': 'GUEST_PVSHUTDOWN' }
+
 ##
 # @GuestPanicAction:
 #
diff --git a/system/runstate.c b/system/runstate.c
index fc49fd3e61..c833316f6d 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -586,6 +586,7 @@ void qemu_system_guest_crashloaded(GuestPanicInformation *info)
 
 void qemu_system_guest_pvshutdown(void)
 {
+    qapi_event_send_guest_pvshutdown();
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
 }
 
-- 
MST


