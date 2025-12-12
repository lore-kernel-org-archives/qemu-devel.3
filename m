Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582E9D4922D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4iy-0004v4-JG; Fri, 12 Dec 2025 10:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4ia-0004Xa-Mg
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:06:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4iZ-0006ZM-6X
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:06:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7qbW4sSJ0f//e1skZ7ujhw6w1Gd0GquqUMfT6GcW53o=;
 b=FGeJSlyeSI3A/RgkWCtd083/biOu5U0mQzbgCehVdqD5l9Rf63YqfUiR0lPb+GulcQh5S8
 YEE/pRjPwbNnDhJXZTAcaG9N3BWrb8ySOg26XZCjZzETNPL6TmjyYmswm+/RTOIv3LAWgm
 RyMHo7lLqHM6omstAN8kJr3yWMmURHE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-cjx-CgGwMrGOvAFP53Uygw-1; Fri, 12 Dec 2025 10:06:01 -0500
X-MC-Unique: cjx-CgGwMrGOvAFP53Uygw-1
X-Mimecast-MFC-AGG-ID: cjx-CgGwMrGOvAFP53Uygw_1765551960
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7b6b194cf71so2146408b3a.3
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551960; x=1766156760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7qbW4sSJ0f//e1skZ7ujhw6w1Gd0GquqUMfT6GcW53o=;
 b=r+Z2yFc/1dAJBQAc83O3K8bJHpO+lsJaXT9wVKXatt6fa+5WSXqrvNTAdpyD0PHJMy
 RMQV5NwR3Zobf90i+QS+gUetQl0W/OTJBbzl6HIwgRpVjtp/n9/yUZA29k9iRBGA1NMr
 2G/D1u9eZgp3wP7/cQ1mk1dbCQid5bfzd6RpHKd338u410KwsfoAnNs1wyeOBxQYWAwJ
 LhP9N1fVjGjeTWSkHTRR5O1xjdMTtRlKCJ42cxVgbd+SKn5scBp6Y3Xqe22O+OvdZ4rS
 IWKPMB7Z0vE0OsbwWniLlqRmOvlU2uWU7TLHBmFSfHtysGqeFPBISOrrs9+UmRVeXLMc
 ePmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551960; x=1766156760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7qbW4sSJ0f//e1skZ7ujhw6w1Gd0GquqUMfT6GcW53o=;
 b=m7zwQDIUi4oS6skWtqq8QK6liJqKMHAScMAyB7bSjMfUloyDUMqA6X7wcx7oui4JlX
 qg7/zRMNBL6uviCZMy0Eszf5Px0stOUrIYzCdtS0kosYdITvW0XymlkigMf7qSXq+BtZ
 5KaztpFtbzE81YMUZ6c5a8LJoIFqm36Ebiyp23umQANikN61/B+P61pvAhHmLCdtOMeC
 auwpovovfbH+EOb8WqeviWo0ywiEXAVb3loUqqRpoBfsztZP0i1eW/AvvR7aQ8siBicP
 zzmjtimb2t6cawqjDU+6H+TYcplVi9EdMgv2K6t/mcdiAOAPnA22DoUwoP08taH4IAPh
 Xcpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoionv4B0/xuxVNPWkm5wtk2ZDOubg7YHlsUySuVj1XdatpuSnE0q9vXG90wRWwD4lF/OG1BU6GdFP@nongnu.org
X-Gm-Message-State: AOJu0YzldWuRDrYYwQPlyP65RvyP6gWPr8nHzpPXTTqaWRXqlLsP1w87
 yNnHo5wvm38tUkogyelHfLWnlkqJTdmapVw/6TFNtob+9w0wgcW77B1O7pGgzSRBAvr7+lc4nhL
 U/3BEsS4sED5BZKcjqIkcDPgHDZyrn+9sWKt5HrL+E4NRWCCVnEIxmD5E
X-Gm-Gg: AY/fxX45zMwVsiZENLHs3KB4hh1rHgvR6U0aQHMlA22AlcAZT0XGGyRQ32RUMWik/+h
 EA6wZyV3hXniec6GhJzmtmSG/Rd3Ix1s2eYc6eT/pj1H1ZO26wAkM0IDdKw8u8V7c/p+/Fk00q6
 rfc44DFwtzJT6eHDMnGWI0OUTPJwuubtq7dBBeSDLP8u9JnffQnLq74HaomI2udQiufMZXpVlvK
 1QQP6Lag21yJ8lCnxuvKPgEVcuD7s4zmLo1A8PVBHM3YT3w9QhRLRaVMR7oJu5HCr0OqU75mXdo
 eKjeSjbse+JAymMJZAMRBsJh6GgeaSYyXJ26XWj7wcTcZCHfMS07NCSph5HkmigFneNUcCLKZqB
 W4mYIPdGWUK09Gb6D3dab9QiOAZRnDi5Aib5BP/2QGK0=
X-Received: by 2002:a05:6a20:72a5:b0:342:378e:44af with SMTP id
 adf61e73a8af0-369afa01e6emr2328102637.41.1765551959681; 
 Fri, 12 Dec 2025 07:05:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWsNzyOmhbI8ozEemOrWUsjBMSfwDTixVU/Mg4HYy0dEV3BRd5UWFrhNoGQ5KVYFJW7LkTYQ==
X-Received: by 2002:a05:6a20:72a5:b0:342:378e:44af with SMTP id
 adf61e73a8af0-369afa01e6emr2327917637.41.1765551956702; 
 Fri, 12 Dec 2025 07:05:56 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:05:56 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: vkuznets@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v1 28/28] kvm/clock: add support for confidential guest reset
Date: Fri, 12 Dec 2025 20:33:56 +0530
Message-ID: <20251212150359.548787-29-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251212150359.548787-1-anisinha@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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

Confidential guests change the KVM VM file descriptor upon reset and also create
new VCPU file descriptors against the new KVM VM file descriptor. We need to
save the clock state from kvm before KVM VM file descriptor changes and restore
it after. Also after VCPU file descriptors changed, we must call
KVM_KVMCLOCK_CTRL on the VCPU file descriptor to inform KVM that the VCPU is
in paused state.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/kvm/clock.c | 56 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index f56382717f..91a5a08f05 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -49,6 +49,9 @@ struct KVMClockState {
     /* whether the 'clock' value was obtained in a host with
      * reliable KVM_GET_CLOCK */
     bool clock_is_reliable;
+
+    NotifierWithReturn kvmclock_vcpufd_change_notifier;
+    NotifierWithReturn kvmclock_vmfd_pre_change_notifier;
 };
 
 struct pvclock_vcpu_time_info {
@@ -62,6 +65,9 @@ struct pvclock_vcpu_time_info {
     uint8_t    pad[2];
 } __attribute__((__packed__)); /* 32 bytes */
 
+static int kvmclock_set_clock(NotifierWithReturn *notifier,
+                              void *data, Error** errp);
+
 static uint64_t kvmclock_current_nsec(KVMClockState *s)
 {
     CPUState *cpu = first_cpu;
@@ -218,6 +224,51 @@ static void kvmclock_vm_state_change(void *opaque, bool running,
     }
 }
 
+static int kvmclock_save_clock(NotifierWithReturn *notifier,
+                               void *data, Error** errp)
+{
+    KVMClockState *s = container_of(notifier, KVMClockState,
+                                    kvmclock_vmfd_pre_change_notifier);
+    kvm_update_clock(s);
+    return 0;
+}
+
+static int kvmclock_set_clock(NotifierWithReturn *notifier,
+                              void *data, Error** errp)
+{
+    struct kvm_clock_data clock_data = {};
+    CPUState *cpu;
+    int ret;
+    KVMClockState *s = container_of(notifier, KVMClockState,
+                                    kvmclock_vcpufd_change_notifier);
+    int cap_clock_ctrl = kvm_check_extension(kvm_state, KVM_CAP_KVMCLOCK_CTRL);
+
+    if (!s->clock_is_reliable) {
+        uint64_t pvclock_via_mem = kvmclock_current_nsec(s);
+        /* saved clock value before vmfd change is not reliable */
+        if (pvclock_via_mem) {
+            s->clock = pvclock_via_mem;
+        }
+    }
+
+    clock_data.clock = s->clock;
+    ret = kvm_vm_ioctl(kvm_state, KVM_SET_CLOCK, &clock_data);
+    if (ret < 0) {
+        fprintf(stderr, "KVM_SET_CLOCK failed: %s\n", strerror(-ret));
+        abort();
+    }
+
+    if (!cap_clock_ctrl) {
+        return 0;
+    }
+    CPU_FOREACH(cpu) {
+        run_on_cpu(cpu, do_kvmclock_ctrl, RUN_ON_CPU_NULL);
+    }
+
+    return 0;
+}
+
+
 static void kvmclock_realize(DeviceState *dev, Error **errp)
 {
     KVMClockState *s = KVM_CLOCK(dev);
@@ -229,7 +280,12 @@ static void kvmclock_realize(DeviceState *dev, Error **errp)
 
     kvm_update_clock(s);
 
+    s->kvmclock_vcpufd_change_notifier.notify = kvmclock_set_clock;
+    s->kvmclock_vmfd_pre_change_notifier.notify = kvmclock_save_clock;
+
     qemu_add_vm_change_state_handler(kvmclock_vm_state_change, s);
+    kvm_vcpufd_add_change_notifier(&s->kvmclock_vcpufd_change_notifier);
+    kvm_vmfd_add_pre_change_notifier(&s->kvmclock_vmfd_pre_change_notifier);
 }
 
 static bool kvmclock_clock_is_reliable_needed(void *opaque)
-- 
2.42.0


