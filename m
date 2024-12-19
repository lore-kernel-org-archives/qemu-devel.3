Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DC2E7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJJG-0003m0-8g; Thu, 19 Dec 2024 11:23:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tOHil-0003Aj-Ul
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:41:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tOHik-0002Os-6U
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:41:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734619305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=32Fg/9MsvAhaDZv2tz2CNpS6C7gzvxZjQEqSc8NsMDE=;
 b=aAjdlmI1wrmGgFVudnp1ZzoSZlTyhqSP8PiHkLff4qpj3PBOhG7OIne0+9hlD3rde7RfH0
 T/G40WaRO2pilbtW3RQiyQrDVV2w1WFhR7NEkELvTPVI0G+4hH9p913QsVQLSGGkXE3izN
 NdWMDmVjhynJu7ZhHNRf7Weoe+dO/n8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-wIqI_LQ1PR68T48-rSNmew-1; Thu, 19 Dec 2024 09:41:43 -0500
X-MC-Unique: wIqI_LQ1PR68T48-rSNmew-1
X-Mimecast-MFC-AGG-ID: wIqI_LQ1PR68T48-rSNmew
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385ed79291eso1054285f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 06:41:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734619302; x=1735224102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=32Fg/9MsvAhaDZv2tz2CNpS6C7gzvxZjQEqSc8NsMDE=;
 b=V4cn085xYzOc+ca3KdzCvHPHcWHslPRsUgxc0PO3+6SnyJzINBNtQ471RHZS52tURu
 gKj5HBlcYChF5VqCx1CjAaDbGl30NYi7x93BcbZJoeQY1AOKhN+OTEHx1jKjkCm8QgFp
 12bb8BBzKSqnza4wFMZ+fPnt3kt1RZE1LZOao82l+nkp185FbwzBsvE8khMGfXgQsSqV
 4xZzXZ7Aimn+VNHt6IZXdbipZsL2DYdVPrMUInSdF2bRyatcgz+tm5AgnQulzZUvSLZM
 dA777l0lPWMFVof6rmiBD0Nmx7Z4mq5qivoSyDCF1vzQPHXupKImUl98T+HVsMgbc7cC
 /Dgg==
X-Gm-Message-State: AOJu0YzL4cukNvNJvtt+pJrFa1rAclFsRN3n9LuuJJDpM1mZuBuCUSRY
 SXMLrC8bDzZXvzZx67jQngYw+3bdzG4774ogzlzdkAScGlVChlvTwP2R4SNjuT5BIE+UA96NyuH
 2q3AUpezHfQdYvsE49gWH+aCUAQmR2KzaztLw7Vku6ZJ+IUy62vy1x2+fJ9x8bJoPYC1B2lj4jM
 wPqJsBajUo4iMxOyHGLKkmPYL1Rv8MkP6a1Ds=
X-Gm-Gg: ASbGnctmOn5pX1XDt5dx3mLIHNseyPsyaAOybQiEaHgDxm59U3Wh75SbukyQygkLvkX
 Q/IKEiSPp+5a7P3WnEUptocNgZJ/6idlLv1rXYFJ4qU7RQO4YmiuSvYbvEF3wpmfY3rF2dtw2dp
 eQo8Sxp9DrlWOb5I20kT+qM2bteQ/EzWbm0mzudVTiJi4+enZZWbZeUPLvEjMiGDxnS3WOZ+gtI
 0bX85YIP53sma1if5S6wBPsp1fr0rUHQrsrZRuPXVgBsrq0FhjGRiVjP8QsKjp3aZ6iYg49O9OF
 AaJnM/Ay9li4qpRqEXroATZHtAvchAmgc9o4f5E6
X-Received: by 2002:a5d:5f4d:0:b0:386:34af:9bae with SMTP id
 ffacd0b85a97d-38a1a1f7219mr3532273f8f.4.1734619302127; 
 Thu, 19 Dec 2024 06:41:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7Rzj8wVSJzmZXEYgZk+H6CTeb0rLWMlJyMFUs4EsRfwWka9nmax80bCaoeqCswpdyOxH5EA==
X-Received: by 2002:a5d:5f4d:0:b0:386:34af:9bae with SMTP id
 ffacd0b85a97d-38a1a1f7219mr3532234f8f.4.1734619301704; 
 Thu, 19 Dec 2024 06:41:41 -0800 (PST)
Received: from localhost
 (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de.
 [2003:cb:c749:6600:b73a:466c:e610:686])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-43656b0145csm53826055e9.15.2024.12.19.06.41.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 06:41:41 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 10/14] s390x/s390-virtio-ccw: prepare for memory devices
Date: Thu, 19 Dec 2024 15:41:11 +0100
Message-ID: <20241219144115.2820241-11-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219144115.2820241-1-david@redhat.com>
References: <20241219144115.2820241-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Let's prepare our address space for memory devices if enabled via
"maxmem" and if we have CONFIG_MEM_DEVICE enabled at all. Note that
CONFIG_MEM_DEVICE will be selected automatically once we add support
for devices.

Just like on other architectures, the region container for memory devices
is placed directly above our initial memory. For now, we only align the
start address of the region up to 1 GiB, but we won't add any additional
space to the region for internal alignment purposes; this can be done in
the future if really required.

The RAM size returned via SCLP is not modified, as this only
covers initial RAM (and standby memory we don't implement) and not memory
devices; clarify that in the docs of read_SCP_info(). Existing OSes without
support for memory devices will keep working as is, even when memory
devices would be attached the VM.

Guest OSs which support memory devices, such as virtio-mem, will
consult diag500(), to find out the maximum possible pfn. Guest OSes that
don't support memory devices, don't have to be changed and will continue
relying on information provided by SCLP.

There are no remaining maxram_size users in s390x code, and the remaining
ram_size users only care about initial RAM:
* hw/s390x/ipl.c
* hw/s390x/s390-hypercall.c
* hw/s390x/sclp.c
* target/s390x/kvm/pv.c

Message-ID: <20241008105455.2302628-11-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 23 ++++++++++++++++++++++-
 hw/s390x/sclp.c            |  6 +++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 1c56b70dcd..2ba66be018 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -149,6 +149,7 @@ static void s390_memory_init(MachineState *machine)
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *ram = machine->ram;
     uint64_t ram_size = memory_region_size(ram);
+    uint64_t devmem_base, devmem_size;
 
     if (!QEMU_IS_ALIGNED(ram_size, 1 * MiB)) {
         /*
@@ -161,11 +162,31 @@ static void s390_memory_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
 
-    s390_set_memory_limit(s390ms, ram_size);
+    devmem_size = 0;
+    devmem_base = ram_size;
+#ifdef CONFIG_MEM_DEVICE
+    if (machine->ram_size < machine->maxram_size) {
+
+        /*
+         * Make sure memory devices have a sane default alignment, even
+         * when weird initial memory sizes are specified.
+         */
+        devmem_base = QEMU_ALIGN_UP(devmem_base, 1 * GiB);
+        devmem_size = machine->maxram_size - machine->ram_size;
+    }
+#endif
+    s390_set_memory_limit(s390ms, devmem_base + devmem_size);
 
     /* Map the initial memory. Must happen after setting the memory limit. */
     memory_region_add_subregion(sysmem, 0, ram);
 
+    /* Initialize address space for memory devices. */
+#ifdef CONFIG_MEM_DEVICE
+    if (devmem_size) {
+        machine_memory_devices_init(machine, devmem_base, devmem_size);
+    }
+#endif /* CONFIG_MEM_DEVICE */
+
     /*
      * Configure the maximum page size. As no memory devices were created
      * yet, this is the page size of initial memory only.
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 73e88ab4eb..5945c9b1d8 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -161,7 +161,11 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
         read_info->rnsize2 = cpu_to_be32(rnsize);
     }
 
-    /* we don't support standby memory, maxram_size is never exposed */
+    /*
+     * We don't support standby memory. maxram_size is used for sizing the
+     * memory device region, which is not exposed through SCLP but through
+     * diag500.
+     */
     rnmax = machine->ram_size >> sclp->increment_size;
     if (rnmax < 0x10000) {
         read_info->rnmax = cpu_to_be16(rnmax);
-- 
2.47.1


