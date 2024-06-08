Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF805C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrYZ-0003ht-AI; Sat, 08 Jun 2024 04:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrYN-0003En-6u
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrYL-0000KM-OP
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cfbnAz0X/hhB4+Gnmb2yzifvZfZx13Zr3Rf9dp8T810=;
 b=a/rXoGlSf0D2VeeNLTHzD63K+RsAXh/rUPFZYWBRPdzqLJz3gu0T1vssoenMn2OBDPrT1G
 BBchuKBWY7bgg7HL8d+35/pnloxdQYbO+42tsmosOxMUc2+c1/xLTdeqO65lxRXQxlbl5j
 wtd5jVQ085lG2pd/ZER+/mgVnNSfqWk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-M5gEhwUVO_GMUngtpYq8AA-1; Sat, 08 Jun 2024 04:35:54 -0400
X-MC-Unique: M5gEhwUVO_GMUngtpYq8AA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6ef9b8b0fbso33011066b.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835752; x=1718440552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cfbnAz0X/hhB4+Gnmb2yzifvZfZx13Zr3Rf9dp8T810=;
 b=EkdpCiUkXoGLyYwDFcjl4nfBqAdH7uEVgm0WJGvaz9mI67h8RJISaIhhD+aUy+57uJ
 yoKaMYLD3BGd8iKAu5324GuqzZhL08BodyYQcdg7ni5J6LDceHVnXkFrEOCnZkiZ/EG9
 2aJ+fY7mEMtTEQjQRLo5E/v/6fDnsMF1SmggiL+HEuU+lyG/Id2pb3c9nqZpv0/NwEVK
 h5MyPZG1mdzJXKPcFqMq0ydAhM8nPJHR61w8q9ADdeSbw7sf3EmHV/pmSFgl4tuVeoAK
 SYgPQDlqdS5+ztCeztEdadxDU+2J5hrqFesff4XwcBxqWJYKXnTYxSkTEjLf8+7tW5Vj
 uSVA==
X-Gm-Message-State: AOJu0YzXwmapgzUYTNXx8gVIAQvWAyw0UAPHlJT3GCrTpUSVxnWlSiuy
 /qAKApQo+EaKov5A5LK9nBPOCzqTaR5dLe3G0maM61aprLGBmkB0mU6RUCJS3+SWKx6y0UTcm1J
 gDtK+qAjVcET7FLiA9YE3DRLzwC80w0udY5K0lQSObo1QIeWGFNsIWq1T6YBbAf6eiTyTohXfzY
 5X7pUSg5yTxEGmeB31RvrFh34QBVsPG0V6Osj0
X-Received: by 2002:a17:906:32c7:b0:a63:4e5a:a240 with SMTP id
 a640c23a62f3a-a6cd561340bmr297753366b.6.1717835752696; 
 Sat, 08 Jun 2024 01:35:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3wwK9a9lS62ZqPCn6VNul2lDaWHK6LjDuwHH0YXbRKZajMp7kPS6x9WKI1mei/4nVRy9Jvw==
X-Received: by 2002:a17:906:32c7:b0:a63:4e5a:a240 with SMTP id
 a640c23a62f3a-a6cd561340bmr297752366b.6.1717835752264; 
 Sat, 08 Jun 2024 01:35:52 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6ef4192b56sm149601466b.167.2024.06.08.01.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:35:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 37/42] docs: i386: pc: Avoid mentioning limit of maximum vCPUs
Date: Sat,  8 Jun 2024 10:34:10 +0200
Message-ID: <20240608083415.2769160-38-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

From: Zhao Liu <zhao1.liu@intel.com>

Different versions of PC machine support different maximum vCPUs, and
even different features have limits on the maximum number of vCPUs (
For example, if x2apic is not enabled in the TCG case, the maximum of
255 vCPUs are supported).

It is difficult to list the maximum vCPUs under all restrictions. Thus,
to avoid confusion, avoid mentioning specific maximum vCPU number
limitations here.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240606085436.2028900-1-zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/system/target-i386-desc.rst.inc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/docs/system/target-i386-desc.rst.inc b/docs/system/target-i386-desc.rst.inc
index 319e540573d..ae312b1c1e6 100644
--- a/docs/system/target-i386-desc.rst.inc
+++ b/docs/system/target-i386-desc.rst.inc
@@ -36,7 +36,8 @@ The QEMU PC System emulator simulates the following peripherals:
 -  PCI UHCI, OHCI, EHCI or XHCI USB controller and a virtual USB-1.1
    hub.
 
-SMP is supported with up to 255 CPUs (and 4096 CPUs for PC Q35 machine).
+SMP is supported with a large number of virtual CPUs (upper limit is
+configuration dependent).
 
 QEMU uses the PC BIOS from the Seabios project and the Plex86/Bochs LGPL
 VGA BIOS.
-- 
2.45.1


