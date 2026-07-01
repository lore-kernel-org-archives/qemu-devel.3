Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6D3C43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 14:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wevkD-0005il-O5; Wed, 01 Jul 2026 10:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wevjq-0005VL-Nl
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 10:16:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wevjo-0000AN-Gh
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 10:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782915385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DC7FX4yNG/LF/omxYor4QYAGV4Nd5tb0QmpA++dsmZw=;
 b=VBcw1h6RE0HE3WW811cOz0Y70RR9mUcVgxhJOeS531kOwDuYGVnVfPHK9dBIcmO5ZaaikK
 ja4S8SSQq78ydeO2tnv5b6WSGrNJjcRoIyk1KMg7JA5ep1j4VTDcFL7TMl4mNV4abxp3Tf
 883mUv/ThRqXN2jQHOn+tsRuljOk8d8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-H9bzD_jwMI-VrRkmXtntLg-1; Wed, 01 Jul 2026 10:16:23 -0400
X-MC-Unique: H9bzD_jwMI-VrRkmXtntLg-1
X-Mimecast-MFC-AGG-ID: H9bzD_jwMI-VrRkmXtntLg_1782915383
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490a767c7dcso6953225e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 07:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782915382; x=1783520182; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DC7FX4yNG/LF/omxYor4QYAGV4Nd5tb0QmpA++dsmZw=;
 b=mCtbsKZB3qqRaKtf93fpW+cpaCC2bTOypDQTNRax+KhZaBV6UNxFnHcrhL8fuz7oVa
 lsutFi1yprFlWRrITc0V1KD59jGLiPKPf0esjGkjHMEGrvha5IHjFuI200QPhVKSuCkK
 80RwDleBZ8lZiwczlwxw2aDSNLDOFx0snQerkLNaNJ8nP6iYxlwjG87G6Jq8wL92JKeY
 XZoK2ZPbsYP5IT47ZiM3T71Bs9OOPBhvUmG4l5RAKuJvCogA82PRwlb9IOH3Bw6lirkK
 3L31vfzg3hCjwE8/0x+6YTZo0R866pJZOJ0EyGSjWgyNbK6ZYXlvXBA7x7c4JBcpbLcK
 hbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782915383; x=1783520183;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DC7FX4yNG/LF/omxYor4QYAGV4Nd5tb0QmpA++dsmZw=;
 b=dgUQqiDEvkUJpr7OBjFYWnS10NJFCeaFCt2DME98FmFFFUmz7K2iFyse7ovV8Z7lTC
 S6tM511AnMvN9sKh8fNI9h4dCFxpAr2Eu/72TtcRNA495WWdVg0pULyyPLsCWoP3QfTg
 B1PhlIU7a4lTRV84aMnypKMSrjvwE/vE1F7cV+u86xcSgVtSAH9GWi7um60SZVXC1aF8
 1pCWmrdV1+JX6vExpya2yNImXSMh/pnQh2gxqO2Hlz05XvJTyqpzAR7DdTWGlfs6qo2i
 HvS1Yu3Ba6VGVXfbvasCXRUG/o3ACLP9Jib1BM49u+dpUmTB6XF3B/vIkFqQrIwOqAJ8
 CCDQ==
X-Gm-Message-State: AOJu0YxvDUl6LrNl4wR1ns8MNZ5MYBm+eNx/r1sKUNSNZVHvREUIWCan
 Mw8xoxUItPtMdEGcmhA9FtCdZZN5mwZZCBN1RWVaSxk9zjGwLGN5olFCM0cEvDlgGDRP9I4NlBF
 aF6i0CvbhPuHzSSKokZnb43iwNB3v4jASUl1jURzUVVcp7z/NuVLrRArG
X-Gm-Gg: AfdE7cn2pWtQkeDebEGHggemuRixhpTWyIZzpSJY+D2Wn56TYRMyJZXyj5CA5dKOjiQ
 JtsfhuyrozQw0fcwYix79Qb+gH6Uc2vpAH7dn8BLUtw+IDdnJthW9PfKePfhXvIQ5la1fv5swQx
 3Ou8zjXOWcP+5Xg6ivGV0fgX8I7EgEp56mtdhYb4nccOSp8o4uXcaHfEoRW9sDfi/9IgCdOPIab
 mA/pF4yvcaVGKVRtdg367NiF5PkO2rxkDeJ8eaHyUk0v9zMFvnxowNuRgoyF0zzEmf95QXpWUZ5
 zHRkww04f4lBpJow/4pLqpvs80nboc+c12o0/4kF3J/0ejBNhVgd4vKbVyAbzQoOv1qYI9vyGYP
 yyxL7MeMmZbTg36DvOHInAi1kih9ctasVa17HVl7bgtNpFQaFAmjXOtpVt8V7v+2IGh+W5glsVA
 zHvvZA
X-Received: by 2002:a05:600c:c046:b0:492:5e22:ef18 with SMTP id
 5b1f17b1804b1-493c2b490f3mr21453325e9.9.1782915382593; 
 Wed, 01 Jul 2026 07:16:22 -0700 (PDT)
X-Received: by 2002:a05:600c:c046:b0:492:5e22:ef18 with SMTP id
 5b1f17b1804b1-493c2b490f3mr21453015e9.9.1782915382136; 
 Wed, 01 Jul 2026 07:16:22 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be493c24sm53283795e9.0.2026.07.01.07.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 07:16:21 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH 0/3] hw/i386/microvm: add uefi-vars-sysbus support via
 platform bus
Date: Wed, 01 Jul 2026 16:16:16 +0200
Message-Id: <20260701-microvm_uefi_var-v1-0-0652cae6a152@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MWwqAIBAArxL7naAVva4SIWZb7YcaK0kQ3T3pc
 xhmHojIhBHG4gHGRJGCz6DKAuxh/I6C1sxQyaqVnVTCkeWQnL5wI50Mi940dWOx2/plgJydnM3
 9L6f5fT9863V3YgAAAA==
X-Change-ID: 20260701-microvm_uefi_var-8a434ce7f8b9
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This series adds support for the uefi-vars-sysbus device on the microvm
machine type, enabling persistent UEFI variable storage.

The uefi-vars-sysbus device is a sysbus device that is attached to the
platform bus, which microvm does not currently support. To address this,
the series adds a platform bus to microvm, following the same
pattern used by the ARM virt machine.

The platform bus is mapped at 0xfec20000 with a 1 MB window, placed
after the IOAPICs. It is created without IRQ lines since the
uefi-vars-sysbus device only requires MMIO.

Patch 1 fixes a crash in the platform bus core when num_irqs is zero,
        which is needed to support an MMIO-only platform bus.
Patch 2 adds the platform bus to microvm with MMIO mapping and FDT
        integration.
Patch 3 allows the uefi-vars-sysbus device to be instantiated on
        microvm.

Corresponding edk2 changes[1]

[1]https://github.com/tianocore/edk2/pull/12751

To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Sergio Lopez <slp@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>

Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Luigi Leonardi (3):
      hw/core/platform-bus: fix crash when num_irqs is zero
      hw/i386/microvm: add platform bus support
      hw/i386/microvm: add uefi-vars-sysbus support

 hw/core/platform-bus.c    |  4 ++++
 hw/i386/Kconfig           |  1 +
 hw/i386/microvm-dt.c      |  9 +++++++++
 hw/i386/microvm.c         | 38 ++++++++++++++++++++++++++++++++++++++
 include/hw/i386/microvm.h |  4 ++++
 5 files changed, 56 insertions(+)
---
base-commit: f38d6ae70f100fc8d3f095a842d2f1ca29262218
change-id: 20260701-microvm_uefi_var-8a434ce7f8b9

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


