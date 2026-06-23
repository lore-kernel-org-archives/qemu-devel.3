Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F11DCDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 11:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbzIJ-0005j0-EC; Tue, 23 Jun 2026 07:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wbzIG-0005ih-Hp
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:27:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wbzIE-0003pd-Oc
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782214069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1B55lBwuXfx3+Y5RwrRALsHBWOQX92axApRUVhiSmm4=;
 b=PWg4NYjzpmtIWTCS3m1xDfehgtZtjBML3u90pmkP/8lVJW9S0WIuirvih2fBdBVThUihGZ
 vFx4HkpBqjDg/f5QGfLAXze6Eey7ref5vmEwrf4LLNON/oaqUhSKi/shLgexsfaeE/J4xK
 AC69b1l+IrYD1TjmDJTYZrybaWbr3gQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-vVEWxBj0M2G3kE38lvicpg-1; Tue, 23 Jun 2026 07:27:47 -0400
X-MC-Unique: vVEWxBj0M2G3kE38lvicpg-1
X-Mimecast-MFC-AGG-ID: vVEWxBj0M2G3kE38lvicpg_1782214067
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49221de4ed4so36970735e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 04:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782214066; x=1782818866; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=1B55lBwuXfx3+Y5RwrRALsHBWOQX92axApRUVhiSmm4=;
 b=P+n90CzseiL5x7q2rkWb69prYCzjz7iGTskXeNSHgwSwl/ekBx2ilVnZWyD7m+kev0
 OSXuVZTNOlpH04iyMQ31jSmqg9t+Pr1fAU9OE4nMQ+SdSTVQ2+ib1Y6gFJ6CSH3BTwdn
 BjAdInhwgLr4PXiJQEx1VrhVX//3xfMGpyNDNPivnpC/XTgejXiv2FuSaQvde02fkn8g
 vR0e5MOOt9jogra8TnEU5JGHIEhtKiEotYjkjzVMBBDENKmPPTpJzU447fWwiGx4Vnyx
 EmaAhx9gMyW7jkIzpBdEHmGXfb/aIP9ky5HL1Zj01GZChclQCJEddmr/PG3501fw2gwY
 iukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782214066; x=1782818866;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1B55lBwuXfx3+Y5RwrRALsHBWOQX92axApRUVhiSmm4=;
 b=IgNm2GDZViiuw6dOrCCIiCHxZSVIGQ+01Pj/NQdpy2ggNodFTKAnfCN/k2Zkuhl3fa
 C6DXPuiuHgXT0p16cF0TvcurOrX9tNgF15HXROh+TAk/KxrZsX72QktCjVaNOMNtIM14
 fKEwugEGiXtzvTrY/hFrUtvwhiUJliPQQbCVFHr/dqQTOYs0e0DUeU40Su3pmqL/ICqx
 IMTqzmicqAJYbZ3jfRdY+DxKZW+mLXJ7xUZBRDgkBQvTXiQY1EwXKN0+0zhinu1OUiG4
 uDoUBDDLGs8vqPl7NlfdxAinXKjhimOB9jDuuS2mtI2alz0C4nvJgBpt1tOri7Xxmup8
 ZTUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+JfOg//Tf5ohndsx0AXS0Sgltlv2v4OCg7igNxZDLn9O8HBFYWpAisH5yJ3Nar3NJg+D59u1Xg7cf@nongnu.org
X-Gm-Message-State: AOJu0YxmFCSgg8/uiE7+5rHLM9r0KrnD/+K88sPinAVsejUlCeqeDD8q
 2uqaMCcYTaGhUSLWK2xe5PIRDpF/TqPR5yaQWjaCCk+7AIyam+M/wxmQ2qc2CTOSa3BodEZAIZb
 do2mJiGjRdlOkg6sEhTQFd7gcWDL/Xen4guVL0X4fxq+tDbNiSrKWJ2Yb
X-Gm-Gg: AfdE7cm+Bv0soesTTmQb8Jxpb7VSzSYUGka1KEusfJ5FGnTb3AeCvp7fXpSClnG1NMO
 Hv8XWNKAb310wNaJJzmIEFugAu7Tf3xuwVaWzEiWIhJfJmMvrosfQXyiuxOGP8xQ1jJT9rwz9Y5
 dm5UW1voU2aHJIyk1yAitl10EYTcDDDz8qPahjIttLqN4dq06eJd+GeoPcpKbWlSRkr0+rUV/bJ
 CDgC3Ak2TtQ1Z/dXxJjIUPI1TS8jgUXBba4EvHlLAt75+g+2txx4kTIbjNtbTIZld1YeLyt+Eo7
 GuLPeVERSY7kVP5n1H3uuDPnkhrU9H6Bwl4sQFp55n2DPK6pBaQ88FM+kvOOpO63We5qYUAIKzb
 V1L52w0wNz24H1DhbhkCYhRnG4Do+JGC7/KAo9AwmZ6rLqISCfivgOmA=
X-Received: by 2002:a05:600c:c058:b0:492:37e2:43f6 with SMTP id
 5b1f17b1804b1-49240e81bbfmr229338605e9.19.1782214066578; 
 Tue, 23 Jun 2026 04:27:46 -0700 (PDT)
X-Received: by 2002:a05:600c:c058:b0:492:37e2:43f6 with SMTP id
 5b1f17b1804b1-49240e81bbfmr229338065e9.19.1782214066101; 
 Tue, 23 Jun 2026 04:27:46 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8426:ae00:2b21:b1ac:81f4:97b6?
 ([2a01:cb19:8426:ae00:2b21:b1ac:81f4:97b6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666c579d4sm36173630f8f.28.2026.06.23.04.27.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 04:27:45 -0700 (PDT)
Message-ID: <a0964032-3dd3-4e80-8f87-d9bd1ef537df@redhat.com>
Date: Tue, 23 Jun 2026 13:27:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/34] docs: add mdpy mdev vfio display testing guide
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Peter Maydell
 <peter.maydell@linaro.org>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
 <20260623-b4-ui-v4-6-4656aec3398d@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260623-b4-ui-v4-6-4656aec3398d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 6/23/26 09:44, Marc-André Lureau wrote:
> Document how to test VFIO display hotplug using the kernel mdpy mdev
> sample.



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   docs/devel/index-internals.rst |  1 +
>   docs/devel/vfio-mdpy.rst       | 90 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 91 insertions(+)
> 
> diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
> index 7a0678cbdd3..198f155247a 100644
> --- a/docs/devel/index-internals.rst
> +++ b/docs/devel/index-internals.rst
> @@ -22,6 +22,7 @@ Details about QEMU's various subsystems including how to add features to them.
>      tracing
>      uefi-vars
>      vfio-iommufd
> +   vfio-mdpy
>      writing-monitor-commands
>      virtio-backends
>      crypto
> diff --git a/docs/devel/vfio-mdpy.rst b/docs/devel/vfio-mdpy.rst
> new file mode 100644
> index 00000000000..7875d00d1e0
> --- /dev/null
> +++ b/docs/devel/vfio-mdpy.rst
> @@ -0,0 +1,90 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +===================================
> +Testing VFIO display with mdev mdpy
> +===================================
> +
> +.. contents:: Table of Contents
> +
> +The kernel provides a sample mediated device driver, ``mdpy``
> +(``samples/vfio-mdev/mdpy.c``), that exposes a fake framebuffer through the VFIO
> +display region interface. It can be used to test VFIO display support, including
> +hotplug, without any real GPU hardware.
> +
> +The kernel modules
> +==================
> +
> +The ``mdpy`` driver depends on the ``mdev`` subsystem. Enable, build and load
> +the modules.
> +
> +The minimal set is::
> +
> +    CONFIG_SAMPLE_VFIO_MDEV_MDPY=m
> +    CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB=m   # guest framebuffer driver
> +
> +CONFIG_VFIO_MDEV is selected automatically.
> +
> +Verify that the driver registered successfully:
> +
> +.. code-block:: bash
> +
> +    ls /sys/devices/virtual/mdpy/mdpy/mdev_supported_types/
> +
> +Creating an mdev instance
> +=========================
> +
> +Available types correspond to different resolutions (e.g. ``mdpy-vga``
> +for 640x480, ``mdpy-xga`` for 1024x768, ``mdpy-hd`` for 1920x1080).
> +
> +Each mdev instance is identified by a UUID:
> +
> +.. code-block:: bash
> +
> +    uuid=$(uuidgen)
> +    echo "$uuid" > /sys/devices/virtual/mdpy/mdpy/mdev_supported_types/mdpy-xga/create
> +
> +To remove the instance later:
> +
> +.. code-block:: bash
> +
> +    echo 1 > /sys/bus/mdev/devices/$uuid/remove
> +
> +Make sure your user has the necessary permissions to access the vfio group.
> +(ex: chmod 666 /dev/vfio/16)
> +
> +Starting QEMU
> +=============
> +
> +Boot-time attachment
> +--------------------
> +
> +.. code-block:: bash
> +
> +    qemu-system-x86_64 -machine q35 -m 1G \
> +        -device vfio-pci,sysfsdev=/sys/bus/mdev/devices/$uuid,display=on \
> +        -display gtk,gl=on
> +
> +Hotplug via HMP
> +---------------
> +
> +Start QEMU with a PCIe root port (required for PCIe hotplug) and a
> +monitor:
> +
> +.. code-block:: bash
> +
> +    qemu-system-x86_64 -machine q35 -m 1G \
> +        -device pcie-root-port,id=rp0,slot=1 \
> +        -display gtk,gl=on \
> +        -monitor stdio
> +
> +Then at the ``(qemu)`` prompt:
> +
> +.. code-block:: none
> +
> +    device_add vfio-pci,sysfsdev=/sys/bus/mdev/devices/<uuid>,display=on,bus=rp0,id=mdpy0
> +
> +To hot-unplug:
> +
> +.. code-block:: none
> +
> +    device_del mdpy0
> 


