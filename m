Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26F4EE3693
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvP-0005vf-I6; Thu, 12 Feb 2026 09:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvA-0005VX-MB
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXv8-0006D1-W5
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wId+UDYcV0D4KMt0YhRwB30s7Fni+NsfRnUa5cYhF0Y=;
 b=L/CkcMaiudFBXbMKlRNdmXOsLMuZEIuQWb9w3622DPPOHXmi//aK32Am958+qqltAHFdng
 ZpfIupRAGYQyrd8lauNJbBrW5JSkzgVABQGAKXPkMfE2TP/FHpsSyYPMdJ+nYSKBDokcVQ
 Dc7I6fHx1SAGEM4xzQ6eRWoVfV6T818=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-nXN_KXaCMuGbz_aU9G6ApA-1; Thu, 12 Feb 2026 09:43:52 -0500
X-MC-Unique: nXN_KXaCMuGbz_aU9G6ApA-1
X-Mimecast-MFC-AGG-ID: nXN_KXaCMuGbz_aU9G6ApA_1770907432
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4806b12ad3fso78384675e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907431; x=1771512231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wId+UDYcV0D4KMt0YhRwB30s7Fni+NsfRnUa5cYhF0Y=;
 b=pvwstBm41znt1iFQacCrsmyecCX3B2Eac8Tmr+MCG0xdNH7VDZMPbFZQVH/rHHpiFE
 6ib2SU14mUhsU2HotJo+BhQqCERJHnkPgRp4vwBP+fwCcQlkzff9NX7RTmGG0sf0qriF
 PuH5ixD4HoPl4HB5USmRbBeyqYsU+4RhPPPq2kJOFoJbkUS4GfE5hfZA/unsfF7gB8kk
 E0YmuVP7REazScRDj4XC/P+0lBnyBhksWbuSeEZJkIYGFZGzrLE3BFAa0j8GpM6tSS4C
 vUSx96/0o4AhiykJBzYxEtR1S/0O6b5TlLntyDr0r+1CvejbKgNyH7PgCjWjRi0oNAgQ
 6Ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907431; x=1771512231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wId+UDYcV0D4KMt0YhRwB30s7Fni+NsfRnUa5cYhF0Y=;
 b=NHvH6tkCtF9kZMzqLR8jjXqEdvE45ArIESv6K4eV2aU727HfFDw8NXNsftclT7wTxr
 QH+W0/o1TIN71wbiW+hVn855qXCHRJadSmvcdNDDZpVy3dMVY1KqjNr+qxG7pQrfyaRp
 PQTuxBMMpT/S5oSRlr7Yuk9KrSx4ExA9ZmSSY9UDOVEmseCG9Q7r5JWc5H3Jsq3/8B/K
 1IrvMe5xFbJkhU4cX/ruOthdIf9UeUvFJfxyhO2xhpCEUq4xKABPAbOiyqCQ3gTMj71b
 jkdOZp3cbKTviTCVFA3MZNk85MkKpTsuiAEuLUiLOdmBr96jagRyVhY6QwxJgkMedEFp
 eCzQ==
X-Gm-Message-State: AOJu0YxUuyg5WFC5IZr7DryrLvEcsJ1le0VtemVubFiJN+vsnOY9Jf9p
 FOch6a/M8I7mbgGa/hNh6IUaSLEkfvYDrjTRLLsDAo5kekGuiQXl4lOGxN70p+2OGZ5r924AByy
 EAlEcyuYRKAzh3Lx+5XtpyP40GIvaCGQSgam3wewCMS1uNpY0tgKLdC+6RPM2URPRaxChEdrq7E
 26warjwMZVRxy9fZN9T61ilV6rOvxE1bboE27Uowg6
X-Gm-Gg: AZuq6aLV+W9haeYV0++U695wWcwiX2b16pnqBMZtrSZSEg5rfPDP8lj/V+hsR6Pjigw
 5GtFgzYS8GoxaAbMyAic3O72S1WKcfJbY6arlB6wVPTkHWeoS8x7SrfYfPqxCfKnDiTwzJg5Crl
 TbQPnPDpT2XxGyA/qC7jl6VZlpLJ6mDgSJrChmsrKm8/EdPJsnIivY4Eb12HCQdovb0za7dVP6t
 vwE2nTixlUXUTobpbqKVaYk8R2t+JPCYyw4n3K8J4dxWge74/SZWpO6XAAFABKbwMymWouhBIsd
 cQGUuVGlFwMkiccddDp7mJX/ax7c9Uj4Efuru3qvvjsFEzzBImopMlAv78BwqAcXb6IZn4ytfhr
 c7kxpXQpeXfrBUOJJ3BnsaXW/ZcZXWcc3kObSgSf69BpQmht7YEfeFmD7Z1cO/GyXba/cX4OLg6
 ZUZ4/d3/XdqTKkd8p6HAwERwqx1NR5e0AbNXlVlcJc0Mtc0bj/Odg=
X-Received: by 2002:a05:600c:c0c3:20b0:482:eec4:772 with SMTP id
 5b1f17b1804b1-48365716447mr32737855e9.32.1770907430668; 
 Thu, 12 Feb 2026 06:43:50 -0800 (PST)
X-Received: by 2002:a05:600c:c0c3:20b0:482:eec4:772 with SMTP id
 5b1f17b1804b1-48365716447mr32737335e9.32.1770907430103; 
 Thu, 12 Feb 2026 06:43:50 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835bc8736esm44919385e9.19.2026.02.12.06.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:43:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 28/41] hw/char/virtio-serial: Do not expose the
 'emergency-write' property
Date: Thu, 12 Feb 2026 15:42:30 +0100
Message-ID: <20260212144244.22579-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The VIRTIO_CONSOLE_F_EMERG_WRITE feature bit was only set
in the hw_compat_2_7[] array, via the 'emergency-write=off'
property. We removed all machines using that array, lets remove
that property. All instances have this feature bit set and
it can not be disabled. VirtIOSerial::host_features mask is
now unused, remove it.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260108033051.777361-28-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/virtio/virtio-serial.h | 2 --
 hw/char/virtio-serial-bus.c       | 9 +++------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio-serial.h
index 60641860bf8..da0c91e1a40 100644
--- a/include/hw/virtio/virtio-serial.h
+++ b/include/hw/virtio/virtio-serial.h
@@ -186,8 +186,6 @@ struct VirtIOSerial {
     struct VirtIOSerialPostLoad *post_load;
 
     virtio_serial_conf serial;
-
-    uint64_t host_features;
 };
 
 /* Interface to the virtio-serial bus */
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 5ec5f5313b2..b7c57ea9678 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -557,7 +557,7 @@ static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
 
     vser = VIRTIO_SERIAL(vdev);
 
-    features |= vser->host_features;
+    features |= BIT_ULL(VIRTIO_CONSOLE_F_EMERG_WRITE);
     if (vser->bus.max_nr_ports > 1) {
         virtio_add_feature(&features, VIRTIO_CONSOLE_F_MULTIPORT);
     }
@@ -587,8 +587,7 @@ static void set_config(VirtIODevice *vdev, const uint8_t *config_data)
     VirtIOSerialPortClass *vsc;
     uint8_t emerg_wr_lo;
 
-    if (!virtio_has_feature(vser->host_features,
-        VIRTIO_CONSOLE_F_EMERG_WRITE) || !config->emerg_wr) {
+    if (!config->emerg_wr) {
         return;
     }
 
@@ -1040,7 +1039,7 @@ static void virtio_serial_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (!virtio_has_feature(vser->host_features,
+    if (!virtio_has_feature(vdev->host_features,
                             VIRTIO_CONSOLE_F_EMERG_WRITE)) {
         config_size = offsetof(struct virtio_console_config, emerg_wr);
     }
@@ -1156,8 +1155,6 @@ static const VMStateDescription vmstate_virtio_console = {
 static const Property virtio_serial_properties[] = {
     DEFINE_PROP_UINT32("max_ports", VirtIOSerial, serial.max_virtserial_ports,
                                                   31),
-    DEFINE_PROP_BIT64("emergency-write", VirtIOSerial, host_features,
-                      VIRTIO_CONSOLE_F_EMERG_WRITE, true),
 };
 
 static void virtio_serial_class_init(ObjectClass *klass, const void *data)
-- 
2.52.0


