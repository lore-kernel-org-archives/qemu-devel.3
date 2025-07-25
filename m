Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B7EC87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 13:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufIMr-0002EA-2i; Fri, 25 Jul 2025 09:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ufIMC-0001Mx-Lg
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:21:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ufIMA-00063u-9Q
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753449660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c4TSneD7qD5pmbXg+RcZ6s7fULfl1lz3F2q7tTJd/iw=;
 b=TWJS1h51s6wStDa8zXEo1RM6u3aDZThKYFDixj3yoroSdwRX1mnP/KEtvFxflVSN07I8Xp
 3jyRHSfFzdWaPV8wWZFg0O5EdyG1De492wGEMiljHklZh0bWP7lPIyuw24gk3wbAcKRPuu
 eDbLyidxYu69LTcvlVp5gFCdXDbE5zA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317--_8QFQu1O2GG1W-XuCFXcg-1; Fri, 25 Jul 2025 09:20:59 -0400
X-MC-Unique: -_8QFQu1O2GG1W-XuCFXcg-1
X-Mimecast-MFC-AGG-ID: -_8QFQu1O2GG1W-XuCFXcg_1753449657
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a50049f8eeso933292f8f.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 06:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753449657; x=1754054457;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c4TSneD7qD5pmbXg+RcZ6s7fULfl1lz3F2q7tTJd/iw=;
 b=vUIU2sUognAinCF2OKomaDMt9ZP8tuxuItB1Kw5qgf5W6LqzwdgGUrv+/BQFJLO9qB
 4Uc9mbTG+6EDGYG4YM+GORWAf4eK6enNSGEtGKrZquvti4oEA7/UCa5ZQt9IHOM9gn6v
 QpxBXYtGpAlvS6Z1nio78wck5Cqn1DnHU0rDifiok5xWYwJORv5jc3YmV7/PhwySFBqq
 rpdgIZwao5uJHyx5MA44jAhHv6tZQSeJKXKx65TrMbHCrwbr8uyE8SEvK1NWoCQ/Ckvf
 BIuV92v+072XKtAQDXJn4y8hNM5H6n7i53uMEXu6F+7qBGsbsYmsNT40u70NcYQXnStj
 mIHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsHntE8TNAS22RcKIM0yMyBdVTYorrzNC9QD6i0Sig5LCv5UCBUx9r2JmQapXQzhw8vzSe1Tvapj43@nongnu.org
X-Gm-Message-State: AOJu0YwzHBrHOlpRFfes7nnc3V8bMVleMZuzVgSQ+5ll926xuv54kzx5
 3l+z4n7fnyGSWoG9TpwP6YclMiwSRtybxYIdJkht2JGQCcQy1Uae9XdGX7c9tanMhqoS0PsWxuf
 xZkIHvwqCt21Ymbs6wNQGQ4R/2suqBTEMMk4bH6OC8LKWer8we+mDyH6G
X-Gm-Gg: ASbGncszitAbrfRA53k3n38tNMfVnjWGz/01eU+CHwWPnEHvWEmJC8NT6NS1ebnmwqQ
 bZpNb9/9IhR735ialPY2GVuRSyLYjYM1yBzYBIbheSZ0lgQE/+jifRn+h3W7k7Mw/rLAkt1euXY
 ZVEhEw3v1PdVSBvze62B4LX1Hhy7Fe4pzAlbKOYFQwOf+jfcDx46PLVKnilayLPOnRDRFlYGR+M
 KSZk7v30JkWcQ2x3OuFZjQh8+BRkt2cULgGeRHYiES4avUBOtvTQ9Poq40OB88lIsRc59T3epQb
 +0DHOFGJCOg4t0UEmMBPtlISRrxK63TM0A==
X-Received: by 2002:a05:6000:1886:b0:3a4:dc2a:924e with SMTP id
 ffacd0b85a97d-3b7765e5b1fmr1643689f8f.6.1753449657389; 
 Fri, 25 Jul 2025 06:20:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcCJ+NRZCKJb5Cm+Ip5KqqZEkEO8Av5wVcqHU8dQaWfMBKW24n0I2p9uev9P9PngAf9Rz8mQ==
X-Received: by 2002:a05:6000:1886:b0:3a4:dc2a:924e with SMTP id
 ffacd0b85a97d-3b7765e5b1fmr1643669f8f.6.1753449656935; 
 Fri, 25 Jul 2025 06:20:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:153d:b500:b346:7481:16b2:6b23])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fc60525sm5092411f8f.10.2025.07.25.06.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 06:20:56 -0700 (PDT)
Date: Fri, 25 Jul 2025 09:20:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: Re: [PATCH v2] hw/smbios: allow clearing the VM bit in SMBIOS table 0
Message-ID: <20250725091651-mutt-send-email-mst@kernel.org>
References: <20250724195409.43499-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724195409.43499-1-d-tatianin@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 24, 2025 at 10:54:09PM +0300, Daniil Tatianin wrote:
> This is useful to be able to freeze a specific version of SeaBIOS to
> prevent guest visible changes between BIOS updates. This is currently
> not possible since the extension byte 2 provided by SeaBIOS does not
> set the VM bit, whereas QEMU sets it unconditionally.
> 
> Allowing to clear it also seems useful if we want to hide the fact that
> the guest system is running inside a virtual machine.
> 
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
> 
> After talking to Michael:
> Supersedes: <20250723090128.977364-1-d-tatianin@yandex-team.ru>
> 
> v2:
> - Add the new option to qemu-options.hx
> 
> ---
>  hw/smbios/smbios.c           | 11 ++++++++++-
>  include/hw/firmware/smbios.h |  2 +-
>  qemu-options.hx              |  2 +-
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 1ac063cfb4..13e21a9c43 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -179,6 +179,10 @@ static const QemuOptDesc qemu_smbios_type0_opts[] = {
>          .name = "uefi",
>          .type = QEMU_OPT_BOOL,
>          .help = "uefi support",
> +    },{
> +        .name = "vm",
> +        .type = QEMU_OPT_BOOL,
> +        .help = "virtual machine",
>      },
>      { /* end of list */ }
>  };


Can/should we just poke at "hypervisor" CPU property?

Cc Paolo for comments.

> @@ -574,10 +578,14 @@ static void smbios_build_type_0_table(void)
>  
>      t->bios_characteristics = cpu_to_le64(0x08); /* Not supported */
>      t->bios_characteristics_extension_bytes[0] = 0;
> -    t->bios_characteristics_extension_bytes[1] = 0x14; /* TCD/SVVP | VM */
> +
> +    t->bios_characteristics_extension_bytes[1] = 0x04; /* TCD/SVVP */
>      if (smbios_type0.uefi) {
>          t->bios_characteristics_extension_bytes[1] |= 0x08; /* |= UEFI */
>      }
> +    if (smbios_type0.vm) {
> +        t->bios_characteristics_extension_bytes[1] |= 0x10; /* |= VM */
> +    }
>  
>      if (smbios_type0.have_major_minor) {
>          t->system_bios_major_release = smbios_type0.major;
> @@ -1405,6 +1413,7 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>              save_opt(&smbios_type0.version, opts, "version");
>              save_opt(&smbios_type0.date, opts, "date");
>              smbios_type0.uefi = qemu_opt_get_bool(opts, "uefi", false);
> +            smbios_type0.vm = qemu_opt_get_bool(opts, "vm", true);
>  
>              val = qemu_opt_get(opts, "release");
>              if (val) {
> diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
> index f066ab7262..3ea732f4e6 100644
> --- a/include/hw/firmware/smbios.h
> +++ b/include/hw/firmware/smbios.h
> @@ -22,7 +22,7 @@ extern GArray *usr_blobs_sizes;
>  
>  typedef struct {
>      const char *vendor, *version, *date;
> -    bool have_major_minor, uefi;
> +    bool have_major_minor, uefi, vm;
>      uint8_t major, minor;
>  } smbios_type0_t;
>  extern smbios_type0_t smbios_type0;
> diff --git a/qemu-options.hx b/qemu-options.hx
> index ab23f14d21..11204c47eb 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2693,7 +2693,7 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
>      "-smbios file=binary\n"
>      "                load SMBIOS entry from binary file\n"
>      "-smbios type=0[,vendor=str][,version=str][,date=str][,release=%d.%d]\n"
> -    "              [,uefi=on|off]\n"
> +    "              [,uefi=on|off][,vm=on|off]\n"
>      "                specify SMBIOS type 0 fields\n"
>      "-smbios type=1[,manufacturer=str][,product=str][,version=str][,serial=str]\n"
>      "              [,uuid=uuid][,sku=str][,family=str]\n"
> -- 
> 2.34.1


