Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65ED6C9EC8B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHvC-0005TE-1j; Mon, 12 Jan 2026 08:25:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHud-0004Wp-1d
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHuZ-0003tl-5T
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZTC0TaeHDKR66aLqLlM3/y/CGbtg30ikDOryFdUyg4=;
 b=MI1buGdCJ8VRQCS/AImg8IYPv4UcC3cjoyZ8EBS5fnVpDO7WYvhQTYBqI60pJ+z22BYoW4
 OxB+WKVaOFPvkXB7I/Iwg19ybyquP7fRUfWMFSaLQ9nt+KAA4zqWNHCEJd8G2iByQdMys2
 YhghLU0h3Xx2SxqXdwv/4AMiHtQ4wCk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-A1ra-SokNomyYRJ-ABpeBQ-1; Mon, 12 Jan 2026 08:24:43 -0500
X-MC-Unique: A1ra-SokNomyYRJ-ABpeBQ-1
X-Mimecast-MFC-AGG-ID: A1ra-SokNomyYRJ-ABpeBQ_1768224282
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c5269fcecdeso2396518a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224282; x=1768829082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sZTC0TaeHDKR66aLqLlM3/y/CGbtg30ikDOryFdUyg4=;
 b=s3EBp5MmDhUwOvlP4rkIMMY7YjHLgQIKHtbfmWY0XDDoEyFz5i4UuDYJxz3ZBe01mq
 fwK3Sq+68mYJ+wZ+gQ5ExIWORxcKW6OuMKMZNPUEH4UfJByxwiAec2+iHkIHhH+nX7Ku
 4HqFlzK/Src4a9zM18IPS6ksAIGajohQPeFzJVnNectYpdgW9MjbLzSd2kJGK3dg75Iu
 KiyJI9S/txWh1U0uYI/skdhcEpiVf3n3Cq+C/PAmS0yM/FTpo+9nTNTY97GugzDLI+iV
 LDwZTEL5BiIpx5HQgyWYWbw7ytTa222mwBkfmv0GAxm40DhwyWLBLut4M54L+oOIoI7K
 6clA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224282; x=1768829082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sZTC0TaeHDKR66aLqLlM3/y/CGbtg30ikDOryFdUyg4=;
 b=InewjIL6/X53ylNPNjx7ZXK5yRl2mA3EyI2M1RsIEzHrxi6szVuE0wA+45Np8VrLTr
 vrcfNT9QTEtlDoonVij7QYddnjgT2chJ1OO6cd66ixfFThX73ygNyHFJtIxCN5uCp/ll
 lejFVdzAVgRraNx9IxLwq8TmbQ6GkFIQ0Xl8HPfzQOnDpGudNAzUsix7lpPBmuc/2GUQ
 6IZYhHDCAx3rfBoAuFLOG45rBhE+AmQ5dMwo4oy/0rabFtfmg4DSmVrEw5YtJbYnLPD+
 gK1GKJkWEni9s0/eOM4yRdnloDEXqD0Pw/dn98BiVoRcgtsvgPlGp2ZS9BFPGyJy3Am5
 UxOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGs7WzXWCHzQvfQuW73hnFjZP3K6yYFyAWN/v2o/56vydqgcpOZR/WbjqHZ0NeTohBrn5kq0T+JTIG@nongnu.org
X-Gm-Message-State: AOJu0YwAyA2wMVz86GcwaHiypKA00tZsR5mJhO6MMLGVFidAxoWK3Mjn
 ny8QrgPIt5bls/ounDfZrp+K3JI2zyNBGb0l+MpJsiCDb1ZKzRC5/jD19aXuck7FwctX5hpQEmy
 BQtnWE9s5qeNUpz6HqGzDa9V2oy9UkvUITFSGFJi+Pw2dpxBtzrz4X2Hx
X-Gm-Gg: AY/fxX6hEx1U4Dz86kKB90WD0nw3ne21y0YrKpKMQuZyIBA2kLdE4pIMdHjewMlXCXi
 /sKWrYkPRczh9i0CPEIsTStobr9r7XRv6UL00vvLxhdEKa566Rzoru0nWN5zJFDXxeCNlaaLBbF
 YlJcbZ+++zG3D6tY5N7r1erXTdmHaIlzVrPdD4rVYluzvdDIs2OmuXXRswIw5d3MFgjvliCvggl
 Mso+bzsCig9vcTEiW8K5MOdIrnSXAc+l2A1LvYFvx5w77vlSgwGGLWkyruguJg33FiBoM8F6OnB
 ddwTuwCL0bzu1Qo5TnsX1n2GlTrwDQuVCia5J6YWMaA/UYP3y7dbFjfBrJnvOVBejWB6SYhgCl/
 rtVHgIjO4C5H/ePUs32iqjXcCfrpWsayhX6LWQg9hjJE=
X-Received: by 2002:a05:6a20:9389:b0:364:13ca:3702 with SMTP id
 adf61e73a8af0-3898f987e4dmr15605302637.42.1768224282085; 
 Mon, 12 Jan 2026 05:24:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHk8QW2RliSHhtFMjkKxZmzmVzNrv6vCTx1ajL7q72+fmrMw65zwoht1sL/r/v90mZHzFABIw==
X-Received: by 2002:a05:6a20:9389:b0:364:13ca:3702 with SMTP id
 adf61e73a8af0-3898f987e4dmr15605280637.42.1768224281664; 
 Mon, 12 Jan 2026 05:24:41 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:24:41 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 29/32] kvm/i386/apic: set local apic after vcpu file
 descriptors changed
Date: Mon, 12 Jan 2026 18:52:42 +0530
Message-ID: <20260112132259.76855-30-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


