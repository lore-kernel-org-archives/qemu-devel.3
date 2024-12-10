Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFA0E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 19:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL5Zm-0002MO-Mi; Tue, 10 Dec 2024 14:07:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tL5Zk-0002Lc-Ip
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 14:07:16 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tL5Zj-0000Np-0f
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 14:07:16 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso6377085e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 11:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733857633; x=1734462433; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5V565qyQf+kulFcpFLhJbvlPOxJD1fK7OBawhGdtI+8=;
 b=w8MqFqVIdO7pfAdqlz+5yPo8WvjrYCubUGKv5cfgy+fTgubyn1vcFRA7l6aMItW1mk
 vaUmvG6v/q/fiGrPHAyj442LvNJKeg6WHcG2Ng3kTjDKr6t0rP1eHnFRVvE5U+C9+oXW
 douhTYto+wACGahbLrBBBpFTfApGFjOLDSfPWRNCCEMIMoJD4v7Xl/XDMr5BP1Ru8on6
 dGKedTrb2nD274qeQ/TD2jqoL5jJlV2Q2piByXb+Pv0bJS8h/KOQRTmSJ8baFs+9JuJM
 Vo0vCIaf78ca2fFM+ZoWSeJzlnzmT8qyEVquuKzJPaintd/dPxkRFSVhkJPoTNF6ueZD
 BOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733857633; x=1734462433;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5V565qyQf+kulFcpFLhJbvlPOxJD1fK7OBawhGdtI+8=;
 b=KyZRzdaTl6yJV1ZlSVnEO9kYicNksCybyv/T9E8T4tGz6x8YtTg0KxTSWyBIoe9XZP
 jYO5sDiKx4bQblUrnn+aYzpEsKBD8XXwskxZb2SoWs5ZyvR2wM0eVgP9Yi0sSwdfX0vS
 u3QTw0ps+PDOJVk0MlBaMAuMeenIbPatDUd43C1CpA1EVHQlg1oS9Oq4E92aFRGgZYJ5
 AVkQytbKrmIvWUGUYgbfYUIQ7SKk3mQxPz8UgkYP9ZBHqTrNTtNr+osPJ/RFdWBlwSr/
 7CskSBdjXn9NgsZKGWHq9kiaVVZWR0w38QIud/y4svbAFaDoJq1CT44axBEBE+magSOH
 6JDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0oxlS6erhW/+ollxMGNlJ9Y5VbX3TOvhPkHIWsOXIs0dwOJIJLnusOY5uNhiC8xOIcfrBlleCLClF@nongnu.org
X-Gm-Message-State: AOJu0YwQH8IZaMSak0SpL/DG/NujRNjsksAT8p1rzCeQLfikETtC0YY0
 ZIJhBRAwifbTMjEM/JIdccEbJBMaGkV3o50TTgqFeCMVlcUc51Wgaq6XGZX9Q8s=
X-Gm-Gg: ASbGncv8FnHRb13iriUnzPT3K9jfZxIJ4uI8QL7mwxQA8sEaau58ln9PW3nrbuSl3So
 zgtTWO+VG+ap6nxta8jZJ5wFycrz1T0MbTxwy7tEdI+B6/A/o3f+FrFPWBjw5MIff/UtfDnCgvt
 P6Fyc+U4vGAXMaq7hWn5fkGRY/u5FAFSYVyEplzSdX006YxKKUsqMwMrAHENE+BMkXBk5il31W0
 096eo4Kf8CBTTEBaxwn/E5ip5G5nYCNQJ1jdCIlfh9PetOEXAxC
X-Google-Smtp-Source: AGHT+IFSCT5yXT0kkOTlqm/Y97/5nqu2pDrpQjmT/FBslfCiuIz79p51FLYlFmyS/Z2eMnRbb6ReWA==
X-Received: by 2002:a05:600c:3ca1:b0:434:9499:9e87 with SMTP id
 5b1f17b1804b1-434dded743dmr128768915e9.25.1733857633398; 
 Tue, 10 Dec 2024 11:07:13 -0800 (PST)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43502fef1eesm33604645e9.0.2024.12.10.11.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 11:07:13 -0800 (PST)
Date: Tue, 10 Dec 2024 19:07:38 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, alex.bennee@linaro.org
Subject: Re: [PATCH v3 08/26] hw/core/loader: Add ROM loader notifier
Message-ID: <20241210190738.GD1212502@myrica>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-10-jean-philippe@linaro.org>
 <564df018-6d47-4cb6-b781-5a2e58669da6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <564df018-6d47-4cb6-b781-5a2e58669da6@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Dec 05, 2024 at 10:59:52PM +0100, Philippe Mathieu-Daudé wrote:
> On 25/11/24 20:56, Jean-Philippe Brucker wrote:
> > Add a function to register a notifier, that is invoked after a ROM gets
> > loaded into guest memory.
> > 
> > It will be used by Arm confidential guest support, in order to register
> > all blobs loaded into memory with KVM, so that their content is moved
> > into Realm state and measured into the initial VM state.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >   include/hw/loader.h | 15 +++++++++++++++
> >   hw/core/loader.c    | 15 +++++++++++++++
> >   2 files changed, 30 insertions(+)
> > 
> > diff --git a/include/hw/loader.h b/include/hw/loader.h
> > index 7f6d06b956..0cd9905f97 100644
> > --- a/include/hw/loader.h
> > +++ b/include/hw/loader.h
> > @@ -353,6 +353,21 @@ void *rom_ptr_for_as(AddressSpace *as, hwaddr addr, size_t size);
> >   ssize_t rom_add_vga(const char *file);
> >   ssize_t rom_add_option(const char *file, int32_t bootindex);
> > +typedef struct RomLoaderNotify {
> > +    /* Parameters passed to rom_add_blob() */
> > +    hwaddr addr;
> 
> This is the buffer (blob) address in guest physical memory.
> 
> > +    size_t len;
> 
> This is the buffer length.
> 
> > +    size_t max_len;
> 
> This is the size of the MemoryRegion ROM containing the buffer.
> 
> Do we need to notify it? You don't use it in your next patch.
> If so, I'd rather have this API returns a MemoryRegion (Rom->mr),
> max_len can be retrieved using memory_region_size(mr); but I
> don't think we need this at all (at least for now).

No I don't think we need it either, what matters is the size of the data
copied into guest memory. I'll remove this

Thanks,
Jean

> 
> > +} RomLoaderNotify;
> > +
> > +/**
> > + * rom_add_load_notifier - Add a notifier for loaded images
> > + *
> > + * Add a notifier that will be invoked with a RomLoaderNotify structure for each
> > + * blob loaded into guest memory, after the blob is loaded.
> > + */
> > +void rom_add_load_notifier(Notifier *notifier);
> > +
> >   /* This is the usual maximum in uboot, so if a uImage overflows this, it would
> >    * overflow on real hardware too. */
> >   #define UBOOT_MAX_GUNZIP_BYTES (64 << 20)
> > diff --git a/hw/core/loader.c b/hw/core/loader.c
> > index 31593a1171..759a62cf58 100644
> > --- a/hw/core/loader.c
> > +++ b/hw/core/loader.c
> > @@ -67,6 +67,8 @@
> >   #include <zlib.h>
> >   static int roms_loaded;
> > +static NotifierList rom_loader_notifier =
> > +    NOTIFIER_LIST_INITIALIZER(rom_loader_notifier);
> >   /* return the size or -1 if error */
> >   int64_t get_image_size(const char *filename)
> > @@ -1179,6 +1181,11 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
> >       return mr;
> >   }
> > +void rom_add_load_notifier(Notifier *notifier)
> > +{
> > +    notifier_list_add(&rom_loader_notifier, notifier);
> > +}
> > +
> >   /* This function is specific for elf program because we don't need to allocate
> >    * all the rom. We just allocate the first part and the rest is just zeros. This
> >    * is why romsize and datasize are different. Also, this function takes its own
> > @@ -1220,6 +1227,7 @@ ssize_t rom_add_option(const char *file, int32_t bootindex)
> >   static void rom_reset(void *unused)
> >   {
> >       Rom *rom;
> > +    RomLoaderNotify notify;
> >       QTAILQ_FOREACH(rom, &roms, next) {
> >           if (rom->fw_file) {
> > @@ -1268,6 +1276,13 @@ static void rom_reset(void *unused)
> >           cpu_flush_icache_range(rom->addr, rom->datasize);
> >           trace_loader_write_rom(rom->name, rom->addr, rom->datasize, rom->isrom);
> > +
> > +        notify = (RomLoaderNotify) {
> > +            .addr = rom->addr,
> > +            .len = rom->datasize,
> > +            .max_len = rom->romsize,
> > +        };
> > +        notifier_list_notify(&rom_loader_notifier, &notify);
> >       }
> >   }
> 

