Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666ABD6DDF3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 12:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBvP8-0002PM-TE; Fri, 15 Nov 2024 07:26:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tBvP3-0002Ou-68
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 07:26:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tBvOz-00034c-M1
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 07:26:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731673576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sEck+2qGQJh6DiitwbwDowEFZc8NEqB99HceTW/FzsA=;
 b=LFCBGH+b7QKdt+LYJWgBTbLz2QXzq/45vQ7SUNQnoBE2J5VtYYL+KO6xFg6+L9bMqgXGyw
 M16RJ7o4Sq19+tB6BCoFVDB+55eokWQFCIYVy/g1SMOejdMQzBMdaPgvZTgpF9CQYm1MNZ
 dj4Zz+s23u0e2+s8KimCE6w9I6kZ/4Y=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-e0gseu3-NG69zEQ5sdpG_A-1; Fri, 15 Nov 2024 07:26:14 -0500
X-MC-Unique: e0gseu3-NG69zEQ5sdpG_A-1
X-Mimecast-MFC-AGG-ID: e0gseu3-NG69zEQ5sdpG_A
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5c947d9afc9so532553a12.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 04:26:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731673573; x=1732278373;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sEck+2qGQJh6DiitwbwDowEFZc8NEqB99HceTW/FzsA=;
 b=tXOIlLLkZHSW46bUJVKfJCpghi32kyejUDletPqIAerafPWnTES0DUhFNgAIIMoZ3H
 WEwTV4xn5ZUbcOgNGjRxDNCOkGWPTz178sNrAwaDuM+aiWHHXkm4b0vWXG7VfByYXebi
 jYMQS3ry4S1JyoS0dCSdRYKQ55+nSAnqLLhc2v1sOIuCiGpAsWfqhL+EZb6ZuTiRH/58
 uqbzGjE/KJOiYdSPimK6FgPefE66KTeFgTLRhro6ateyv1695X8No9UH4sIOFt/YIsV4
 yI0Oab+6OkJul/WSab+yOdxswc1Yz8foOp/zkpQH/4S1/wiv1joIbOpsu4RjYd9ofPTI
 EYdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpPbJyBXm6+OdW8dYfwE5Ob7l9ccsMzOGCe1X5liI7x8vUXSqhCwe8s7Evg6JXk/2kVx0oXmSZil+6@nongnu.org
X-Gm-Message-State: AOJu0YzMj2gljVJWww+5v4SC5kZvO71T/Xl8gm/fU3fDEsl9UAmfrWr8
 r/ZhvzPma4EWwS3IYhP7/MzuNrZpqg9PZNd5OPhdnxHbZgmv5W7uYGnUghL6l1hQmwUkrVv2F2y
 ij9SXsUP9YLXsZRWMnftbpMEoo3CPmh3RcURxkJeqrBBIBLTBZnV9
X-Received: by 2002:a17:907:2da6:b0:aa4:8af:48fc with SMTP id
 a640c23a62f3a-aa483413667mr269197566b.17.1731673572848; 
 Fri, 15 Nov 2024 04:26:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKk2X+gqsBZ6hW5Df7Dwj0WsFQ29eUY+sekmoDXUAeJ+a42uKCEpTYStFRuMrumMHjUITalA==
X-Received: by 2002:a17:907:2da6:b0:aa4:8af:48fc with SMTP id
 a640c23a62f3a-aa483413667mr269192966b.17.1731673572437; 
 Fri, 15 Nov 2024 04:26:12 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-115.web.vodafone.de.
 [109.42.49.115]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20df263bcsm175082966b.11.2024.11.15.04.26.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 04:26:12 -0800 (PST)
Message-ID: <59fa56b8-46f6-4590-9e2e-07b4a935e0bf@redhat.com>
Date: Fri, 15 Nov 2024 13:26:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw: Add "loadparm" property to scsi disk devices for
 booting on s390x
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jared Rossi <jrossi@linux.ibm.com>, qemu-devel@nongnu.org,
 Boris Fiuczynski <fiuczy@linux.ibm.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eric Farman <farman@linux.ibm.com>
References: <20241114122919.973930-1-thuth@redhat.com>
 <9e7cb217-a33e-48aa-b030-efb991ca33f3@linux.ibm.com>
 <f0315077-eb61-4134-b81a-7d33906c6d31@redhat.com>
 <31889800-47fc-4ee0-8016-58a9d82b2719@linux.ibm.com>
 <0e9b5272-2aa9-41a4-b0bb-43f0c89751e7@redhat.com>
 <CABgObfZ5VqJUd9+HvoRkBqeg=pMo_WaZDop_jiRnrCz=gfTRfw@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CABgObfZ5VqJUd9+HvoRkBqeg=pMo_WaZDop_jiRnrCz=gfTRfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.658,
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

On 15/11/2024 12.49, Paolo Bonzini wrote:
> On Fri, Nov 15, 2024 at 7:30 AM Thomas Huth <thuth@redhat.com> wrote:
>> Ok, great! Sounds like we have a passable solution for QEMU 9.2. We still
>> can refine the loadparm handling of the scsi devices in future QEMU
>> releases, but this will now at least solve the present problem that Boris
>> reported from the libvirt side.
> 
> Please put in the release notes that in the future loadparm might be
> limited to s390 emulators... Not sure how, but we'll come up with
> something.

Sure, will do!

Alternatively, would you rather prefer something like this for the common
scsi code:

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index c1fa02883d..5c9362fa83 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -32,6 +32,7 @@
  #include "migration/vmstate.h"
  #include "hw/scsi/emulation.h"
  #include "scsi/constants.h"
+#include "sysemu/arch_init.h"
  #include "sysemu/block-backend.h"
  #include "sysemu/blockdev.h"
  #include "hw/block/block.h"
@@ -3136,6 +3137,31 @@ BlockAIOCB *scsi_dma_writev(int64_t offset, QEMUIOVector *iov,
      return blk_aio_pwritev(s->qdev.conf.blk, offset, iov, 0, cb, cb_opaque);
  }
  
+static char *scsi_property_get_loadparm(Object *obj, Error **errp)
+{
+    return g_strdup(SCSI_DISK_BASE(obj)->loadparm);
+}
+
+static void scsi_property_set_loadparm(Object *obj, const char *value,
+                                       Error **errp)
+{
+    SCSI_DISK_BASE(obj)->loadparm = g_strdup(value);
+}
+
+static void scsi_property_add_specifics(DeviceClass *dc)
+{
+    ObjectClass *oc = OBJECT_CLASS(dc);
+
+    /* The loadparm property is only supported on s390x */
+    if (arch_type & QEMU_ARCH_S390X) {
+        object_class_property_add_str(oc, "loadparm",
+                                      scsi_property_get_loadparm,
+                                      scsi_property_set_loadparm);
+        object_class_property_set_description(oc, "loadparm",
+                                              "load parameter (s390x only)");
+    }
+}
+
  static void scsi_disk_base_class_initfn(ObjectClass *klass, void *data)
  {
      DeviceClass *dc = DEVICE_CLASS(klass);
@@ -3166,7 +3192,6 @@ static const TypeInfo scsi_disk_base_info = {
      DEFINE_PROP_STRING("vendor", SCSIDiskState, vendor),                \
      DEFINE_PROP_STRING("product", SCSIDiskState, product),              \
      DEFINE_PROP_STRING("device_id", SCSIDiskState, device_id),          \
-    DEFINE_PROP_STRING("loadparm", SCSIDiskState, loadparm),            \
      DEFINE_PROP_BOOL("migrate-emulated-scsi-request", SCSIDiskState, migrate_emulated_scsi_request, true)
  
  
@@ -3220,6 +3245,8 @@ static void scsi_hd_class_initfn(ObjectClass *klass, void *data)
      dc->desc = "virtual SCSI disk";
      device_class_set_props(dc, scsi_hd_properties);
      dc->vmsd  = &vmstate_scsi_disk_state;
+
+    scsi_property_add_specifics(dc);
  }
  
  static const TypeInfo scsi_hd_info = {
@@ -3260,6 +3287,8 @@ static void scsi_cd_class_initfn(ObjectClass *klass, void *data)
      dc->desc = "virtual SCSI CD-ROM";
      device_class_set_props(dc, scsi_cd_properties);
      dc->vmsd  = &vmstate_scsi_disk_state;
+
+    scsi_property_add_specifics(dc);
  }
  
  static const TypeInfo scsi_cd_info = {

?

Using the global arch_type variable is likely also not the
nicest solution, but it at least limits the property to the
s390x target for now...

  Thomas


