Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9FDC27C53
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZWZ-0000ys-0Q; Tue, 04 Jun 2024 15:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZWX-0000tO-Do
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:08:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZWU-00013H-TM
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717528121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kgYXT9TqVXX9/BRZFmbWBgRNk9wpbHrKyLXkpZBaJss=;
 b=EnJkXZZPclbYdRsqvaeCeVLP48/YcMbeV5loyYOyLoV0zN7byl1hBUYmUlna2tFFmiH6CA
 w0vaBIfFrfAaPOu4knsQGnRr4VznkOnTTgVrX/XJfQyR9rJJ5U9VHmllTOIrgBCYYsa9A/
 G11+Rq8fWNZuC+3+sBIBXIHIjtAsEx4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-ZtwBgnGhN6GU57Z4FZky6w-1; Tue, 04 Jun 2024 15:08:39 -0400
X-MC-Unique: ZtwBgnGhN6GU57Z4FZky6w-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2eaaae3e600so26692211fa.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717528116; x=1718132916;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kgYXT9TqVXX9/BRZFmbWBgRNk9wpbHrKyLXkpZBaJss=;
 b=YAexYWbnQklFubyFmHZjXLiIxM0m8qQ7IwSixQm2Vw2/ZTrbj6v5+cxiR2wxFyccJJ
 7WBXxEkUx8L5tjwHbrUyldi5GXIRAWGuynA3mnHtIZfvxnDyaoa1gIHfT8mgacybBbBF
 INeL+RozeMLsvw4RSH8z9WxQtCDh5eAEP7ocVVhunR4tyytLUdxgRfDeOH82q2mPIwHF
 K9kaKYrb/8LLRuKAcZZ+b79G5iFSAvuGU+Aou9uRLnSU3ZuZJ0QGDgVvEA4WadOjsf3V
 K8PIQeHwpm/qGRBLA8hiXz4uA+ZHfnrkQryoiBHvdM0wcyeKtoUW/gsAf8A3McUkvRQl
 040w==
X-Gm-Message-State: AOJu0YyPZo4geEp8oylucwDQNRdgO6gDK/CVr+vIbYmVDRiUSIb+2nj+
 3uc9AuuQFiJiHAHHpf0PnKgwYdllITnwlcq6GKCdWPCr1/tORlGUfyNEGbJB7fQ+nwsUIO8/S+x
 YIXBShfFHyDCTe1zSD9ctoW2p+zp/dj+AX307FHchMI1OM/wVHD7hx5BPoyVLMBMqj3z/6kV8fk
 BbZ+7TwFywBj0jqTVE5ljnS8xMeHIgBQ==
X-Received: by 2002:a05:651c:551:b0:2ea:89f6:258f with SMTP id
 38308e7fff4ca-2eac77a26a9mr1667241fa.0.1717528116148; 
 Tue, 04 Jun 2024 12:08:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM7rQ/o1HEVzNpueFxB0aE3Ec2r1CJndkFhkB0tYUJe3mvY4lCzbPz7MSZytDrzy+H1EVuCw==
X-Received: by 2002:a05:651c:551:b0:2ea:89f6:258f with SMTP id
 38308e7fff4ca-2eac77a26a9mr1666951fa.0.1717528115620; 
 Tue, 04 Jun 2024 12:08:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b838a41sm165672925e9.1.2024.06.04.12.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:08:35 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:08:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 42/46] pvpanic: Emit GUEST_PVSHUTDOWN QMP event on pvpanic
 shutdown signal
Message-ID: <ed36d88dc9b5428df88cf4e3c1b7371d796902f9.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
index 83055f3278..c149b1ab4b 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -587,6 +587,7 @@ void qemu_system_guest_crashloaded(GuestPanicInformation *info)
 
 void qemu_system_guest_pvshutdown(void)
 {
+    qapi_event_send_guest_pvshutdown();
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
 }
 
-- 
MST


