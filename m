Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41084C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 05:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWT9C-00037g-Np; Tue, 01 Jul 2025 01:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1uWT96-000376-Uo
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 01:03:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1uWT94-0000Gj-CS
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 01:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751346179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HbLaptKb353ifewpOFrVwcsHZty7YG6WqtGJY037U04=;
 b=ELVOlLKcqnjeYYNMHe7BDI5ExKXyG0Vq8JMofzW23rbSUfpVaLLWU+VB+DvoKjoFJGMkLE
 GIYTaeA5nj+9vil68U1S1IvqGUaXdN79SWSaaGCFzE8hmufbP3TDuk9hQnFbpY3ovi4q1s
 sxXQhXYZbycJgJtEo1ULH0hjkNbSRC8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154--PAw6Y0gMFKcA_aaot2bEA-1; Tue, 01 Jul 2025 01:02:57 -0400
X-MC-Unique: -PAw6Y0gMFKcA_aaot2bEA-1
X-Mimecast-MFC-AGG-ID: -PAw6Y0gMFKcA_aaot2bEA_1751346177
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f6ba526eso1733368f8f.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 22:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751346176; x=1751950976;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HbLaptKb353ifewpOFrVwcsHZty7YG6WqtGJY037U04=;
 b=bNFnWe7KfMwap0DPmh+ci2zB8fKgvhbWOr/gHjw09OwfxPeSQQmCP4NagQyeSb3eQZ
 lYxb9DRRKdmEed4TmGDf6fvWCcp0u0Rb6a5MB0QvS2Y45hnSd3YKHo2C/kSAmubQ39IO
 FKmeL5wiC+mjOCI7m/9yR/rQQevhX1ljxsQTg6bVGVc1QwiSIHcqzASTSMDMx9u8t4kR
 ex82CqwdAmZm9qh9OA4goM+Zf1DjA92qhf29+gPbXnmRMJ9/peEUZkLs5NfJdXsJvpna
 GOW4PqtMQLZhXWclkb61HM6Dm8TkFlkirKqnH9h7SC227zqZQHJP7bc1tZfEWK94jfUn
 z1ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrJDRt3BMTsJAnQpH9erZndpX3s+XqEzNYGOJsC94dIXSyt5qnp9y0+vVHbAir4XOP0eGd5AG25zt7@nongnu.org
X-Gm-Message-State: AOJu0YxxCbLzNY9zJ7Yl9ea+0/+/0NzOAIqVk/mCYJ74tU6IYOQ0bzx8
 rXepcOpjrY+Lw89ad5gmrdI0sVjzgsACvE+GV1kqAS05BTZXiAYJBu5A5I4h2khtWEAB0XdSz7R
 ltbMtyGBtFeg3A/ZKAAf7M9bEkL4KCHllwZdOT6EpTYjB2TEJuAUmYC5v
X-Gm-Gg: ASbGnctqT939e5WOeNstlTlIfgTJ8rUOEdBBvcvcHSyWXmfBQ/C09DvgIb2yas3i7KI
 68/uQBLgB3qwRkOc4lqLNSHgyJ7ZrZYN6UiECW8sbqciZc9kRrcF7Mgt8FW/ItMeMlTqQ17tqft
 68inLbnhWMV6caPL0SmFi6Wg04Ds3+w30/gOIhHz1kqPBtBzujzGXP2AwV6ehu9Q7otzXFqQFRI
 vLXiB0W8HrU/KcdVM4uVU0Pxg/oH6BUqxDeWh2EMDHDrq1nuJ9bP48687+QfGi85wpexaGbPtdW
 v4TNq+wlw0EqqP3myX5oMwDtaolWm6BScjZGtf1sGeHomuSPW/90t93W6SvoS3o0
X-Received: by 2002:a5d:5050:0:b0:3a6:d2ae:830 with SMTP id
 ffacd0b85a97d-3a9001a14a8mr11435755f8f.56.1751346176449; 
 Mon, 30 Jun 2025 22:02:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1IqZE27dMmKj0anQJ9LstM5O6nUBcGnYFhDjmyQ17TMVLqL5YnxONg1iWEM5497wX+AI5UA==
X-Received: by 2002:a5d:5050:0:b0:3a6:d2ae:830 with SMTP id
 ffacd0b85a97d-3a9001a14a8mr11435736f8f.56.1751346175926; 
 Mon, 30 Jun 2025 22:02:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e599bdsm11819285f8f.84.2025.06.30.22.02.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 22:02:55 -0700 (PDT)
Message-ID: <971a5fd7-58d9-489f-9fb3-45fe19ce95bc@redhat.com>
Date: Tue, 1 Jul 2025 07:02:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] ramfb: Add property to control if load the romfile
Content-Language: en-US
To: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20250701030549.2153331-1-shahuang@redhat.com>
 <20250701030549.2153331-2-shahuang@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20250701030549.2153331-2-shahuang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Shaoqin,

On 7/1/25 5:05 AM, Shaoqin Huang wrote:
> Currently the ramfb device loads the vgabios-ramfb.bin unconditionally,
> but only the x86 need the vgabios-ramfb.bin, this can cause that when
> use the release package on arm64 it can't find the vgabios-ramfb.bin.
> 
> Because only seabios will use the vgabios-ramfb.bin, load the rom logic
> is x86-specific. For other !x86 platforms, the edk2 ships an EFI driver
> for ramfb, so they don't need to load the romfile.
> 
> So add a new property use-legacy-x86-rom in both ramfb and vfio_pci
> device, because the vfio display also use the ramfb_setup() to load
> the vgabios-ramfb.bin file.
> 
> After have this property, the machine type can set the compatibility to
> not load the vgabios-ramfb.bin if the arch doesn't need it.
> 
> For now the default value is true but it will be turned off by default
> in subsequent patch when compats get properly handled.
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/display/ramfb-standalone.c | 4 +++-
>  hw/display/ramfb-stubs.c      | 2 +-
>  hw/display/ramfb.c            | 6 ++++--
>  hw/vfio/display.c             | 4 ++--
>  hw/vfio/pci.c                 | 1 +
>  hw/vfio/pci.h                 | 1 +
>  include/hw/display/ramfb.h    | 2 +-
>  7 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
> index 1be106b57f..af1175bf96 100644
> --- a/hw/display/ramfb-standalone.c
> +++ b/hw/display/ramfb-standalone.c
> @@ -17,6 +17,7 @@ struct RAMFBStandaloneState {
>      QemuConsole *con;
>      RAMFBState *state;
>      bool migrate;
> +    bool use_legacy_x86_rom;
>  };
>  
>  static void display_update_wrapper(void *dev)
> @@ -39,7 +40,7 @@ static void ramfb_realizefn(DeviceState *dev, Error **errp)
>      RAMFBStandaloneState *ramfb = RAMFB(dev);
>  
>      ramfb->con = graphic_console_init(dev, 0, &wrapper_ops, dev);
> -    ramfb->state = ramfb_setup(errp);
> +    ramfb->state = ramfb_setup(ramfb->use_legacy_x86_rom, errp);
>  }
>  
>  static bool migrate_needed(void *opaque)
> @@ -62,6 +63,7 @@ static const VMStateDescription ramfb_dev_vmstate = {
>  
>  static const Property ramfb_properties[] = {
>      DEFINE_PROP_BOOL("x-migrate", RAMFBStandaloneState, migrate,  true),
> +    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState, use_legacy_x86_rom, true),
>  };
>  
>  static void ramfb_class_initfn(ObjectClass *klass, void *data)
> diff --git a/hw/display/ramfb-stubs.c b/hw/display/ramfb-stubs.c
> index cf64733b10..b83551357b 100644
> --- a/hw/display/ramfb-stubs.c
> +++ b/hw/display/ramfb-stubs.c
> @@ -8,7 +8,7 @@ void ramfb_display_update(QemuConsole *con, RAMFBState *s)
>  {
>  }
>  
> -RAMFBState *ramfb_setup(Error **errp)
> +RAMFBState *ramfb_setup(bool romfile, Error **errp)
>  {
>      error_setg(errp, "ramfb support not available");
>      return NULL;
> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
> index 8c0f907673..9a17d97d07 100644
> --- a/hw/display/ramfb.c
> +++ b/hw/display/ramfb.c
> @@ -135,7 +135,7 @@ const VMStateDescription ramfb_vmstate = {
>      }
>  };
>  
> -RAMFBState *ramfb_setup(Error **errp)
> +RAMFBState *ramfb_setup(bool romfile, Error **errp)
>  {
>      FWCfgState *fw_cfg = fw_cfg_find();
>      RAMFBState *s;
> @@ -147,7 +147,9 @@ RAMFBState *ramfb_setup(Error **errp)
>  
>      s = g_new0(RAMFBState, 1);
>  
> -    rom_add_vga("vgabios-ramfb.bin");
> +    if (romfile) {
> +        rom_add_vga("vgabios-ramfb.bin");
> +    }
>      fw_cfg_add_file_callback(fw_cfg, "etc/ramfb",
>                               NULL, ramfb_fw_cfg_write, s,
>                               &s->cfg, sizeof(s->cfg), false);
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index ea87830fe0..8bfd8eb1e3 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -365,7 +365,7 @@ static bool vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
>                                            &vfio_display_dmabuf_ops,
>                                            vdev);
>      if (vdev->enable_ramfb) {
> -        vdev->dpy->ramfb = ramfb_setup(errp);
> +        vdev->dpy->ramfb = ramfb_setup(vdev->use_legacy_x86_rom, errp);
>          if (!vdev->dpy->ramfb) {
>              return false;
>          }
> @@ -494,7 +494,7 @@ static bool vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
>                                            &vfio_display_region_ops,
>                                            vdev);
>      if (vdev->enable_ramfb) {
> -        vdev->dpy->ramfb = ramfb_setup(errp);
> +        vdev->dpy->ramfb = ramfb_setup(vdev->use_legacy_x86_rom, errp);
>          if (!vdev->dpy->ramfb) {
>              return false;
>          }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 7f1532fbed..ff0d93fae0 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3564,6 +3564,7 @@ static const TypeInfo vfio_pci_dev_info = {
>  
>  static const Property vfio_pci_dev_nohotplug_properties[] = {
>      DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
> +    DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice, use_legacy_x86_rom, true),
>      DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate,
>                              ON_OFF_AUTO_AUTO),
>  };
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index d94ecaba68..713956157e 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -177,6 +177,7 @@ struct VFIOPCIDevice {
>      bool no_kvm_ioeventfd;
>      bool no_vfio_ioeventfd;
>      bool enable_ramfb;
> +    bool use_legacy_x86_rom;
>      OnOffAuto ramfb_migrate;
>      bool defer_kvm_irq_routing;
>      bool clear_parent_atomics_on_exit;
> diff --git a/include/hw/display/ramfb.h b/include/hw/display/ramfb.h
> index a7e0019144..172aa6dc89 100644
> --- a/include/hw/display/ramfb.h
> +++ b/include/hw/display/ramfb.h
> @@ -6,7 +6,7 @@
>  /* ramfb.c */
>  typedef struct RAMFBState RAMFBState;
>  void ramfb_display_update(QemuConsole *con, RAMFBState *s);
> -RAMFBState *ramfb_setup(Error **errp);
> +RAMFBState *ramfb_setup(bool romfile, Error **errp);
>  
>  extern const VMStateDescription ramfb_vmstate;
>  


