Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703DAC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7ow-0006N6-5H; Wed, 15 Jan 2025 13:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7ot-0006MR-AJ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:08:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7or-0006VR-Ia
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8wJJjJt30l1/qgQLW37za6mc4YGsCzqM5YuQJ0KkPbo=;
 b=PGLbMjth2o07lnsHYu7uXzVs4fkgL/7J+XYtJ02gFnAG6YHg5Rb4iHk5InPgVKrc67Sl14
 hZrQhHstsWNVlkHdFdKgvThkm0Td0Tx91cV8iIcjFf7onZMEoQODbPnssbJtcxTUAq8SEY
 8n0hkUvar2wk+thhZv2/Fh8XAGZ0k4A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-P4ShFd6vOrWzQrDQlRPoPw-1; Wed, 15 Jan 2025 13:08:42 -0500
X-MC-Unique: P4ShFd6vOrWzQrDQlRPoPw-1
X-Mimecast-MFC-AGG-ID: P4ShFd6vOrWzQrDQlRPoPw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38a9118c486so62005f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:08:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964521; x=1737569321;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8wJJjJt30l1/qgQLW37za6mc4YGsCzqM5YuQJ0KkPbo=;
 b=oMMjhpqE7+bm7Z8v575qD54r7xBO6UrJuuaQ3uGLeAWuWabWGcA1J8PIiTXYfLDUsG
 zZc+nSZ4ikZHUyvT2ycfDjQb7SkjNHyhjwvZU2hEmGL1yUHhOqLOQz3rgUKKqmsX+XTf
 zfMYHCBepfisFA7P85s/Codtxm5O30a89MxOy8ss/ugkeXGq/rneHvYTVYXebOoShQAs
 y2vRtQqoMLvhLqblwnPr/10hOKZ9EZ4SLnjOgs8V9RR+oVlbW/DLR5W+jN1n7H7osLYa
 V7j5euhGmf0Np0aliaivk/uZs2MOQHjTun2OlEDB6ANQUEMR2bmrKB5Gajy/Ln17+SJ1
 0L+Q==
X-Gm-Message-State: AOJu0Yx9hBAQU2pgGsqanMIDmkxajg976njv8k4xaEeu6n2VOq6zpJ+s
 9hlTHzDsqpEwmFrQ5/PH1Ugi1G4wBjARAFOCNG6MHb1GO4elWw7bFS9IjtuHSqkDyJz9hxYw1H3
 OGgqrxaKQegXQ7u4bgNr3Acoa1cYWFi5XNZsXhyzvh9w5U+5CqgAjadowBzAi2PGaZJBunOpQD+
 n1zLAPXofpTTHx+nt8C6ipR0JOB6qTpQ==
X-Gm-Gg: ASbGncumq6ShsDbCMXfgowAHAsZDJ4iJ4nPgKSbKuZELRDv4Frl2UpbUctTHEFx76s0
 QU0RrSSzqWjsctgjyYWQEVS0/4B84TlPj7T2pYKWU79/D51c1TJ2LH0Kch7E++jZtZy6RQpEY6z
 3HCdfNUF7vmS2bNGCSVjXShnto3q6pLE/5X2/w7eZmpm5BEOfEhVmrpDLm/j4mdx5J9oApmRGD8
 x3us/tDkWTMN9d11t8WnHJ0exJ0SSn/ZMmR7AbbPbdP0PPficq9
X-Received: by 2002:adf:9b9a:0:b0:38a:4575:5ffd with SMTP id
 ffacd0b85a97d-38a8730fbedmr21782191f8f.45.1736964521034; 
 Wed, 15 Jan 2025 10:08:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeWMus/iA2fkkBLWPOgRikLyUIsc5gxU7c78rB3JNReuG5lO00yzPsGht3zBzat+Y0/SKtjQ==
X-Received: by 2002:adf:9b9a:0:b0:38a:4575:5ffd with SMTP id
 ffacd0b85a97d-38a8730fbedmr21782166f8f.45.1736964520569; 
 Wed, 15 Jan 2025 10:08:40 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1b05sm18070503f8f.88.2025.01.15.10.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:08:39 -0800 (PST)
Date: Wed, 15 Jan 2025 13:08:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Eric Mackay <eric.mackay@oracle.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 04/48] cpuhp: make sure that remove events are handled within
 the same SCI
Message-ID: <8aa35bebeeaed19ae57afbc3e110b8e7fe8587d0.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

CPU_SCAN_METHOD was processing insert events first and only if insert event was
not present then it would check remove event.

Normally it's not an issue as it doesn't make much sense tho hotplug and
immediately unplug it. In this corner case, which can be reproduced with:

   qemu -smp 1,maxcpus=2 -cpu host -monitor stdio \
        -drive if=pflash,format=raw,readonly,file=edk2-x86_64-code.fd

   * boot till GRUB prompt and pause guest (either via monitor or stop GRUB
     from automatic boot)
   * at monitor prompt add CPU:
         device_add host-x86_64-cpu,socket-id=0,core-id=1,thread-id=0,id=foo
   * let guest OS boot completely, and unplug CPU from monitor prompt:
         device_del foo
     which triggers GPE event that leads to CPU_SCAN_METHOD on guest side

as result of above cpu 'foo' will not be hotunplugged, since QEMU sees
insert event and ignores remove event (leaving it in pending state) for
the GPE event.

Any follow up CPU hotplug/unplug action from QEMU side will handle
previously ignored event, so as workaround user can repeat device_del.

Fix this corner-case by queuing remove events independently from insert
events, aka the same way as we do with insert events. And then go over remove
queue to send eject notify events to OSPM within the same GPE event.

PS:
Process remove queue after the cpu add queue has been processed 1st
to ensure that OSPM gets hotadd evets after hotremove ones.

PS2:
Case where it's still borken happens when guest OS is Linux and
device_del happens before guest OS initializes ACPI subsystem.
Culprit in this case though is the guest kernel, which mangles GPE.sts
(by clearing them up) and thus pending SCI turns to NOP leaving
insert/remove events in pending state.
That is the guest bug and should be fixed there.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reported-by: Eric Mackay <eric.mackay@oracle.com>
Message-Id: <20241210163945.3422623-3-imammedo@redhat.com>
Tested-by: Eric Mackay <eric.mackay@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/cpu.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 9d530a24da..f70a2c045e 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -327,6 +327,7 @@ const VMStateDescription vmstate_cpu_hotplug = {
 #define CPU_EJECT_METHOD  "CEJ0"
 #define CPU_OST_METHOD    "COST"
 #define CPU_ADDED_LIST    "CNEW"
+#define CPU_EJ_LIST       "CEJL"
 
 #define CPU_ENABLED       "CPEN"
 #define CPU_SELECTOR      "CSEL"
@@ -488,7 +489,6 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
         method = aml_method(CPU_SCAN_METHOD, 0, AML_SERIALIZED);
         {
             const uint8_t max_cpus_per_pass = 255;
-            Aml *else_ctx;
             Aml *while_ctx, *while_ctx2;
             Aml *has_event = aml_local(0);
             Aml *dev_chk = aml_int(1);
@@ -499,6 +499,8 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
             Aml *uid = aml_local(3);
             Aml *has_job = aml_local(4);
             Aml *new_cpus = aml_name(CPU_ADDED_LIST);
+            Aml *ej_cpus = aml_name(CPU_EJ_LIST);
+            Aml *num_ej_cpus = aml_local(5);
 
             aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
 
@@ -513,6 +515,8 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
              */
             aml_append(method, aml_name_decl(CPU_ADDED_LIST,
                                              aml_package(max_cpus_per_pass)));
+            aml_append(method, aml_name_decl(CPU_EJ_LIST,
+                                             aml_package(max_cpus_per_pass)));
 
             aml_append(method, aml_store(zero, uid));
             aml_append(method, aml_store(one, has_job));
@@ -527,6 +531,7 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
 
                 aml_append(while_ctx2, aml_store(one, has_event));
                 aml_append(while_ctx2, aml_store(zero, num_added_cpus));
+                aml_append(while_ctx2, aml_store(zero, num_ej_cpus));
 
                 /*
                  * Scan CPUs, till there are CPUs with events or
@@ -559,8 +564,10 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
                       * if CPU_ADDED_LIST is full, exit inner loop and process
                       * collected CPUs
                       */
-                     ifctx = aml_if(
-                         aml_equal(num_added_cpus, aml_int(max_cpus_per_pass)));
+                     ifctx = aml_if(aml_lor(
+                         aml_equal(num_added_cpus, aml_int(max_cpus_per_pass)),
+                         aml_equal(num_ej_cpus, aml_int(max_cpus_per_pass))
+                         ));
                      {
                          aml_append(ifctx, aml_store(one, has_job));
                          aml_append(ifctx, aml_break());
@@ -577,16 +584,16 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
                          aml_append(ifctx, aml_store(one, has_event));
                      }
                      aml_append(while_ctx, ifctx);
-                     else_ctx = aml_else();
+
                      ifctx = aml_if(aml_equal(rm_evt, one));
                      {
-                         aml_append(ifctx,
-                             aml_call2(CPU_NOTIFY_METHOD, uid, eject_req));
-                         aml_append(ifctx, aml_store(one, rm_evt));
+                         /* cache to be removed CPUs to Notify later */
+                         aml_append(ifctx, aml_store(uid,
+                             aml_index(ej_cpus, num_ej_cpus)));
+                         aml_append(ifctx, aml_increment(num_ej_cpus));
                          aml_append(ifctx, aml_store(one, has_event));
                      }
-                     aml_append(else_ctx, ifctx);
-                     aml_append(while_ctx, else_ctx);
+                     aml_append(while_ctx, ifctx);
                      aml_append(while_ctx, aml_increment(uid));
                 }
                 aml_append(while_ctx2, while_ctx);
@@ -620,6 +627,24 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
                     aml_append(while_ctx, aml_increment(cpu_idx));
                 }
                 aml_append(while_ctx2, while_ctx);
+
+                /*
+                 * Notify OSPM about to be removed CPUs and clear remove flag
+                 */
+                aml_append(while_ctx2, aml_store(zero, cpu_idx));
+                while_ctx = aml_while(aml_lless(cpu_idx, num_ej_cpus));
+                {
+                    aml_append(while_ctx,
+                        aml_store(aml_derefof(aml_index(ej_cpus, cpu_idx)),
+                                  uid));
+                    aml_append(while_ctx,
+                        aml_call2(CPU_NOTIFY_METHOD, uid, eject_req));
+                    aml_append(while_ctx, aml_store(uid, cpu_selector));
+                    aml_append(while_ctx, aml_store(one, rm_evt));
+                    aml_append(while_ctx, aml_increment(cpu_idx));
+                }
+                aml_append(while_ctx2, while_ctx);
+
                 /*
                  * If another batch is needed, then it will resume scanning
                  * exactly at -- and not after -- the last CPU that's currently
-- 
MST


