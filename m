Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C232AD49232
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4j1-0004zO-8c; Fri, 12 Dec 2025 10:06:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4iX-0004Ug-G7
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:06:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4iT-0006QX-HM
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZTC0TaeHDKR66aLqLlM3/y/CGbtg30ikDOryFdUyg4=;
 b=DqLPhok86gywP164p3IXCtFjH5rY0Dk5K6Y/Q+/8uqEnXbhdGIkX8+wrn9TU+atO6F676O
 pp1Zj/uFJr5RSsd+MBuqyhBFb06EsTK4rr2nMl9a+sxBTFXyTqNWZLIqo9rq1CcBF2inat
 6h0j52nzPynznS/plaW8a8hMYxvO5w8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-N0_O-kKQOCWZa8uawYoXsg-1; Fri, 12 Dec 2025 10:05:55 -0500
X-MC-Unique: N0_O-kKQOCWZa8uawYoXsg-1
X-Mimecast-MFC-AGG-ID: N0_O-kKQOCWZa8uawYoXsg_1765551955
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7f66686710fso2122359b3a.3
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551954; x=1766156754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sZTC0TaeHDKR66aLqLlM3/y/CGbtg30ikDOryFdUyg4=;
 b=Ldhe92w82q6jLQsz0VOMjfyzSMvtcTLCBkERkUYL1I7k/ubeGE6U0wMXpN0qnc9jnf
 hRNinM6GZX1bifn8mJ9ARNF5oDKfgfKIqG0QaCiCskwctyRRu8DbZVVLel1NBt2NU/mb
 6fSQm7jy6nHMrwzz8fBIcYyaBVvks1i605urR+uoUznskvPQ0hsUwsQ0PLDBnX7A9LjC
 qfnjvf3lW8h4k8y3Fznqezgs7HemPdVE/W0XDNudvdT4hq84d1J+oF+rtPPqabT2sFSJ
 HXHsyZVMscjWQ+acJY5FFnZb6uI139q+cPGw2Jvv3ndeRYCGfZGaGKHCKQCNcSmL/nWd
 +7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551954; x=1766156754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sZTC0TaeHDKR66aLqLlM3/y/CGbtg30ikDOryFdUyg4=;
 b=p0xpQn6vINzQfyAWW5BbKip1kRX6xU6hBWpi2yniEonv4j+7rwyRv59l0wwaDS4awR
 kBuGMgZ0fubkVdtfwxrb8J85Zy+kV8eKRAlg4bNfo4GZkbsdInBfEQyMuzn3FagZzmek
 n0Ss/S/4/IGxsOEsRcy7xkm35fkxdKlYQ7kMRbMY/ns//DJtq7yUvMFLM69tcFMgt5HQ
 nX/tqy7eaTvxe4VemfbMWtVoVrfkDuQC1CpN5LLuAv4jKDi3WDVGlbgnDI2wceBZxOLU
 rtmdOPuzJl0mL7oERX4fQp9PfTl4CIq02tFLpcIszIJUhUonWOcnf0a+9ToQ54eoeV3n
 PIxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkJJdzVzxMYXdxRDBdUHDb7yKfF4U6AffdGEC5gSFkkm8ZSJ0RuchJIZCscgzHLCXKkYi13KTo8sIF@nongnu.org
X-Gm-Message-State: AOJu0YwmzI9PqyC4vlzJ1bEETpFbDEh7x0oXYSXCvgGh6RxcBT2FX35t
 4FaE9mdg2oDxf0GWfaNd5KlOHR41reT8oYvrM6P4E3QMYGd6Fak2P+q/MliZV49pfnvOIHsAxGr
 sqgDrhDBYQMn0aFW0bfz5SO9Ijv6JhgvR9k9DEW2EKUe7vvVaVLKoZq4tZBbasJXs8BE=
X-Gm-Gg: AY/fxX47bT0wqqkankdmC/n6PJcUP/FHOPXJsvF99R6KgPYoE2vBLcDYUd5a70emohu
 3Gm7o9H03HXcI3boRJRNsm0CrYDJjVMiANmLhvbry4Idb9zuRRzGLuoZVtzpMMIwdNRJWVs6lCG
 e2C8b/cBlSYmq0/SSkn3LWXMYBGq6dBXUn02jj9vHeUEYIi+W34bAYqPhTrwMhMPKTbn484vii9
 Sfj2rqqdu4UVNOuW24CW8facpWNKclww1APoS7p4EkKx3Fw/LNRgiwuucfpavbNUrS+Ct3sBsMv
 YsmAXheioqTVUknJmu/Hcvzag5nfATzDDdeM2pduJ4NNkquakKHfio/ixM8D8EBWdy1xxzn26Zp
 NFIufmtiTSrmlBOlcZxGuIP+5KorCGPVwLjOIBiUn2ys=
X-Received: by 2002:a05:6a20:a120:b0:2b1:c9dc:6da0 with SMTP id
 adf61e73a8af0-369af8134aemr2332833637.46.1765551953962; 
 Fri, 12 Dec 2025 07:05:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2PTtPcc3NYxZK0sT8luDMiL41s5In2g2ebIkjZn5jtCNym8KLEOHcSdYDAvY7Kqir+RLKRg==
X-Received: by 2002:a05:6a20:a120:b0:2b1:c9dc:6da0 with SMTP id
 adf61e73a8af0-369af8134aemr2332793637.46.1765551953479; 
 Fri, 12 Dec 2025 07:05:53 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:05:53 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: vkuznets@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v1 27/28] kvm/i386/apic: set local apic after vcpu file
 descriptors changed
Date: Fri, 12 Dec 2025 20:33:55 +0530
Message-ID: <20251212150359.548787-28-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251212150359.548787-1-anisinha@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Once the vcpu file descriptors changed after confidential guest reset, the
local apic needs to be reinitialized. This change adds a callback from the
vcpu fd change notifiers to reinitialize local apic for kvm x86.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/kvm/apic.c              | 13 +++++++++++++
 include/hw/i386/apic_internal.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 82355f0463..f6f8ac2764 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -229,6 +229,16 @@ static void kvm_apic_reset(APICCommonState *s)
     run_on_cpu(CPU(s->cpu), kvm_apic_put, RUN_ON_CPU_HOST_PTR(s));
 }
 
+static int apic_vcpufd_change_handler(NotifierWithReturn *n,
+                                      void *data, Error** errp) {
+    APICCommonState *s = container_of(n, APICCommonState,
+                                      vcpufd_change_notifier);
+
+    run_on_cpu(CPU(s->cpu), kvm_apic_put, RUN_ON_CPU_HOST_PTR(s));
+
+    return 0;
+}
+
 static void kvm_apic_realize(DeviceState *dev, Error **errp)
 {
     APICCommonState *s = APIC_COMMON(dev);
@@ -238,6 +248,9 @@ static void kvm_apic_realize(DeviceState *dev, Error **errp)
 
     assert(kvm_has_gsi_routing());
     msi_nonbroken = true;
+
+    s->vcpufd_change_notifier.notify = apic_vcpufd_change_handler;
+    kvm_vcpufd_add_change_notifier(&s->vcpufd_change_notifier);
 }
 
 static void kvm_apic_unrealize(DeviceState *dev)
diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index 4a62fdceb4..ffe5815e7f 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -189,6 +189,7 @@ struct APICCommonState {
     hwaddr vapic_paddr; /* note: persistence via kvmvapic */
     bool legacy_instance_id;
     uint32_t extended_log_dest;
+    NotifierWithReturn vcpufd_change_notifier;
 };
 
 typedef struct VAPICState {
-- 
2.42.0


