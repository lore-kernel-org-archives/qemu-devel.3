Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5CBC83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 09:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueVhZ-0003b1-Ml; Wed, 23 Jul 2025 05:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ueVhT-0003XZ-Ut
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 05:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ueVhR-0003xo-Gf
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 05:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753262622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1jD3lA8l4ZzeU/+GzByC0GCyz024sM7uPwL6AOqX658=;
 b=UsHfFWOb56XMGUPXTItdXuYrgUVkkRcNlFw2ZbrWSHw8OX8cbKzP4bI7PYsSOjIdtSeoAs
 KmYvhR/reFyaXh1TZYs2jSmZ0VZi83N5pHn1Y+rF7D1UxODy9LkXctScH3k3lJ+RxoUZmo
 /yN43Zrx5RxHvlLJAx9L2WsDGY5Jfy0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182--V_uCZV5O82jegEyB9giXA-1; Wed, 23 Jul 2025 05:23:38 -0400
X-MC-Unique: -V_uCZV5O82jegEyB9giXA-1
X-Mimecast-MFC-AGG-ID: -V_uCZV5O82jegEyB9giXA_1753262617
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b604541741so4706386f8f.3
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 02:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753262617; x=1753867417;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1jD3lA8l4ZzeU/+GzByC0GCyz024sM7uPwL6AOqX658=;
 b=AuH0fkeonIPJB8lCZcnsn3I9aDIMX7aQk7U9B2Fe58ZHw5ytSZogzMPmdK2xBFPNVY
 0LaglnfYlsUND+J7FPaa8/adqp4RjGCu2vhMQ58ZDAo24CRLU86aFgCpWiebbgLsebrL
 5Wi3MXGwlD6HAJNfIRLiwwC9Hh2CWcTlTs4j9/kjzxULrBvPSRUWDj4/g+2T7ul4yGeT
 d2VlrQQ3nMiXjmPK04ny8/di9JfY8K8xXxNbAnK8L9vwodfF04+pYrmPywg829IB9tJq
 HvjKku2PSXZ62/uP46BOyTblXmeOkMnl3mDGvfRo+lA7gdE9P/FFDB2xJrmoD314lEjm
 Si/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0Wlytf2kTemnLb6nIKgNbBkIVnYNFaAsXj3liaWYbI0k/ELCiYXncnY6u+TKOQVB0iGCcrwRG5J6N@nongnu.org
X-Gm-Message-State: AOJu0YyIYqyndb6wqaML5/aplgCiB941uF5bYYL6f9yZd8vz5hbI5p8R
 I81Mp+TAPMGPey2g2kHVDANYWBS3Id09FOwk2BeuQ8gKMdAAclZQhDhklVrizZf1zZ01X1Cbwyx
 3tuTdKI3bqF/xqmqOSOM+8h/21cPAJhW8AqLMxMbb0XL8AuzraYo324+D
X-Gm-Gg: ASbGncs0OVJ34hg5R1ty6Mz8teukhCYc28wyh0sa8sdlXmq86AoZDUmOEebQBcdd2Lb
 4tgmx5if8kQEON0aTVYVhtn1LxmVkhd/gCOhPs8WtJNHMTMKtFUkMA6R21tm+XAds4BhdvOPYl3
 FGQWo4wg++5o9DZWydhDwipXAdMZU+1epe2Tw4LRr4p1Sz0dgrQtX7FEtFEooOynzzTPqHFE15C
 qOO2dRRyAVh2/VScAUBIvCNq/s1dhcInZ/xHgLr/ewstVPrdYXP4q+hQrPpKnHDngV/7B3QevTa
 3ASxIZLm6Q+ZOPvLFxj5w118OkVMq29Fy/g=
X-Received: by 2002:a05:6000:2883:b0:3b5:e6c0:1678 with SMTP id
 ffacd0b85a97d-3b768f26834mr2033221f8f.45.1753262617021; 
 Wed, 23 Jul 2025 02:23:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLzpQO5yEvGeaPK3GKJV1qStTTsvnNugfSy642YZZX+6aCepoX9O09WJEJWLgvL4JKJKlINQ==
X-Received: by 2002:a05:6000:2883:b0:3b5:e6c0:1678 with SMTP id
 ffacd0b85a97d-3b768f26834mr2033198f8f.45.1753262616540; 
 Wed, 23 Jul 2025 02:23:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:153d:b500:b346:7481:16b2:6b23])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca25678sm15568316f8f.12.2025.07.23.02.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 02:23:36 -0700 (PDT)
Date: Wed, 23 Jul 2025 05:23:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/smbios: add an ability to set extension bytes in the
 type0 table
Message-ID: <20250723052216-mutt-send-email-mst@kernel.org>
References: <20250723090128.977364-1-d-tatianin@yandex-team.ru>
 <20250723051334-mutt-send-email-mst@kernel.org>
 <d5f272b4-de89-4748-9b48-1322a36671e4@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5f272b4-de89-4748-9b48-1322a36671e4@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Jul 23, 2025 at 12:16:08PM +0300, Daniil Tatianin wrote:
> 
> On 7/23/25 12:14 PM, Michael S. Tsirkin wrote:
> > On Wed, Jul 23, 2025 at 12:01:28PM +0300, Daniil Tatianin wrote:
> > > This is useful to be able to indicate various supported features to the
> > > guest, or freeze a specific version of SeaBIOS to prevent guest visible
> > > changes between BIOS updates. This is currently not possible since the
> > > extension bytes indicated by SeaBIOS are slightly different than those
> > > QEMU sets by default.
> > > 
> > > Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> > > ---
> > >   hw/smbios/smbios.c           | 66 +++++++++++++++++++++++++++++++++---
> > >   include/hw/firmware/smbios.h |  3 ++
> > >   2 files changed, 64 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> > > index ad4cd6721e..73699e8a62 100644
> > > --- a/hw/smbios/smbios.c
> > > +++ b/hw/smbios/smbios.c
> > > @@ -178,6 +178,14 @@ static const QemuOptDesc qemu_smbios_type0_opts[] = {
> > >           .name = "uefi",
> > >           .type = QEMU_OPT_BOOL,
> > >           .help = "uefi support",
> > > +    },{
> > > +        .name = "extension_byte_1",
> > > +        .type = QEMU_OPT_NUMBER,
> > > +        .help = "BIOS characteristics extension byte 1"
> > > +    },{
> > > +        .name = "extension_byte_2",
> > > +        .type = QEMU_OPT_NUMBER,
> > > +        .help = "BIOS characteristics extension byte 2"
> > >       },
> > >       { /* end of list */ }
> > >   };
> > > @@ -572,10 +580,23 @@ static void smbios_build_type_0_table(void)
> > >       t->bios_rom_size = 0; /* hardcoded in SeaBIOS with FIXME comment */
> > >       t->bios_characteristics = cpu_to_le64(0x08); /* Not supported */
> > > -    t->bios_characteristics_extension_bytes[0] = 0;
> > > -    t->bios_characteristics_extension_bytes[1] = 0x14; /* TCD/SVVP | VM */
> > > -    if (smbios_type0.uefi) {
> > > -        t->bios_characteristics_extension_bytes[1] |= 0x08; /* |= UEFI */
> > > +
> > > +    if (smbios_type0.have_extension_bytes[0]) {
> > > +        t->bios_characteristics_extension_bytes[0] =
> > > +            smbios_type0.extension_bytes[0];
> > > +    } else {
> > > +        t->bios_characteristics_extension_bytes[0] = 0;
> > > +    }
> > > +
> > > +    if (smbios_type0.have_extension_bytes[1]) {
> > > +        t->bios_characteristics_extension_bytes[1] =
> > > +            smbios_type0.extension_bytes[1];
> > > +    } else {
> > > +        t->bios_characteristics_extension_bytes[1] = 0x14; /* TCD/SVVP | VM */
> > > +
> > > +        if (smbios_type0.uefi) {
> > > +            t->bios_characteristics_extension_bytes[1] |= 0x08; /* |= UEFI */
> > > +        }
> > should we not or these in, anyway?
> 
> That's fair enough, but I thought since you're specifying the entire byte
> anyway you don't
> want a different option modifying your value, that would most likely be a
> bug IMO.


But specifying uefi on command line is also user's choice.

Maybe we just want flags for all the options. Which ones do
you actually have a practicall need to tweak, and why?


> > 
> > >       }
> > >       if (smbios_type0.have_major_minor) {
> > > @@ -1403,7 +1424,42 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
> > >               save_opt(&smbios_type0.vendor, opts, "vendor");
> > >               save_opt(&smbios_type0.version, opts, "version");
> > >               save_opt(&smbios_type0.date, opts, "date");
> > > -            smbios_type0.uefi = qemu_opt_get_bool(opts, "uefi", false);
> > > +
> > > +            if (qemu_opt_get(opts, "extension_byte_1")) {
> > > +                uint64_t ex_val;
> > > +
> > > +                ex_val = qemu_opt_get_number(opts, "extension_byte_1", 0);
> > > +                if (ex_val > 0xFF) {
> > > +                    error_setg(errp, "Invalid extension_byte_1");
> > > +                    return;
> > > +                }
> > > +
> > > +                smbios_type0.extension_bytes[0] = ex_val;
> > > +                smbios_type0.have_extension_bytes[0] = true;
> > > +            }
> > > +
> > > +            if (qemu_opt_get(opts, "extension_byte_2")) {
> > > +                uint64_t ex_val;
> > > +
> > > +                ex_val = qemu_opt_get_number(opts, "extension_byte_2", 0);
> > > +                if (ex_val > 0xFF) {
> > > +                    error_setg(errp, "Invalid extension_byte_2");
> > > +                    return;
> > > +                }
> > > +
> > > +                smbios_type0.extension_bytes[1] = ex_val;
> > > +                smbios_type0.have_extension_bytes[1] = true;
> > > +            }
> > > +
> > > +            if (qemu_opt_get(opts, "uefi")) {
> > > +                if (smbios_type0.have_extension_bytes[1]) {
> > > +                    error_setg(errp, "'uefi' and 'extension_byte_2' are "
> > > +                                     "mutually exclusive");
> > > +                    return;
> > > +                }
> > > +
> > > +                smbios_type0.uefi = qemu_opt_get_bool(opts, "uefi", false);
> > > +            }
> > >               val = qemu_opt_get(opts, "release");
> > >               if (val) {
> > > diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
> > > index f066ab7262..67b3b28471 100644
> > > --- a/include/hw/firmware/smbios.h
> > > +++ b/include/hw/firmware/smbios.h
> > > @@ -24,6 +24,9 @@ typedef struct {
> > >       const char *vendor, *version, *date;
> > >       bool have_major_minor, uefi;
> > >       uint8_t major, minor;
> > > +
> > > +    bool have_extension_bytes[2];
> > > +    uint8_t extension_bytes[2];
> > >   } smbios_type0_t;
> > >   extern smbios_type0_t smbios_type0;
> > > -- 
> > > 2.34.1


