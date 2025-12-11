Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BE5D3E792
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 12:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTfYT-0000cs-LA; Thu, 11 Dec 2025 07:13:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vTfYR-0000cc-9P
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 07:13:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vTfYP-0000QU-RY
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 07:13:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765455231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yI1OvrvfSngspZxo1DNPDpXA2hckf2JskikJ/uhiwUg=;
 b=YGdQTiNMAqF2azsd4QhNVw9KLqD9dOCXhC0gs58AM0a/s1wbfeFfdD8+5dmBPtctKHrn58
 CJKlKfR8WgnAxJxP1dI9GYBCMLWDgdDn6Pu+rf0yDFP+TQXYC97HRqMxYKh+V6hqT8vnrY
 0bAIVC8cruzXqMtKx663DNWPbgJYZeQ=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-LOBxuNsjOtWxmb2SnHM0VA-1; Thu, 11 Dec 2025 07:13:50 -0500
X-MC-Unique: LOBxuNsjOtWxmb2SnHM0VA-1
X-Mimecast-MFC-AGG-ID: LOBxuNsjOtWxmb2SnHM0VA_1765455230
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-63e0c5c5faeso4209d50.0
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 04:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765455230; x=1766060030; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yI1OvrvfSngspZxo1DNPDpXA2hckf2JskikJ/uhiwUg=;
 b=g/Ztj7rv3ANxQ9mBqlbuyYfhzDGIBn1UAAgGoOFxxfyyadNXr/COd6YU5Dnp8q3nBt
 2hxnN+q9N4H7DJbsC1OA86Vs8obNwEKZYvo8IjOiCMn/FR7p03FSqDLFOw/GNcnT0lK3
 t34fR3+aXmgEaCjnrx68kcbe3kZOIy2c6Ue+JXAIs1h5YjaLVhor2q1ggvMMeaCIUO2m
 XNq/U9DFSiNiPXp65xbdCbpG+nYfIe9w38yNrH7EfjFF+GjO39lcSQlEq8yaA6lHJjBf
 c83vyTLT/U9hFDY6Ogahii4YzfWLescTmzNUKDO69Rlf7kihTZuVenRctO1hQidyYtkI
 VPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765455230; x=1766060030;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yI1OvrvfSngspZxo1DNPDpXA2hckf2JskikJ/uhiwUg=;
 b=DPLJn5hpB/V1LyZVCg1XA9tc9qEHI8FEe5BcgeoayVyHCyX72BHjV3QMma2wgQ8P+3
 QvgH7kRjSqes+nON450vEdd1XG+Q6wgyn2V2ZlUN1Z4w/B856toDgQFcyKcJI7FVV6ny
 B+MTKEXb7ACSvpXlAhF9iG4Yr6Q9sdFTpv+hDcHfm2wAf852g5rzP3ErWOwI/Wt5gHEP
 h8voR0G5JXAeoUM1kgPukWTtBWgAwn2XXwDN4mZm/6Y1KUXhbVYmfu/P8ZhkcodFLv0T
 ybTb6YQKm1zenxhpIGHCve3naJdbg4OLz1Ez6hHUjIO0QxhcXLNNL5h1qqu96xsDMy7D
 6mDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm27jzNL5ol1hiehrZ7B4UCJ8eYK4V6R7tPL5lP7QIoI44oaQK1dODiu0a5zAKLqRIuCNp8VeC4GF6@nongnu.org
X-Gm-Message-State: AOJu0YxYDFvH3gH7H35JRpqHAyj+OTEM8WqyPFS4AxWnQRyWbeMmmsLi
 kS88+HCDey4anT3D/NUxISTY9pCbIiGkB1uZ4iao2xZ2q6MyTXkktOYgnSjBRMhsklrdvR59faj
 PuCmSANHuvfL4Cg8JdNf05Po3wpSaGAUCqStEUSRj7I4XnpWGcVHREWR1+vv/6QWvPQ82vfj/en
 kZQijTY/HofPFFLjEY/XOHxEhCPsliayY=
X-Gm-Gg: AY/fxX7qtTD/CP6+PPPfGh3kSXzXEO5qaoiLuUG6oFGYW4Cjvl+mZi2wXam8firiorG
 S8GkGMKMtvh1RbZC4s9giCmJk9xHeDd+NSnjUDICZaousy7gCzVwDqmEvn6Cae4CSXKkTxy5cZJ
 Obr0NzeIgromyIGfaiddSEPYsNQtq9rXmgQqUx+XVl7Su+GtX6AUIEWKpbm61m2hYWWmnaS16jw
 i+6BoquF+pQp/dPKnAwp7FA2w==
X-Received: by 2002:a53:accc:0:10b0:642:11db:f5f9 with SMTP id
 956f58d0204a3-6446eb00d22mr4040246d50.55.1765455230070; 
 Thu, 11 Dec 2025 04:13:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHROJjsbzOIVv+kYTD9ro8JG+iZdkU/42JNWuiGSczA/9oE2vX2Q9tF+kKEIbWEYXmMVuuS5GDxWugGb4B3XmQ=
X-Received: by 2002:a53:accc:0:10b0:642:11db:f5f9 with SMTP id
 956f58d0204a3-6446eb00d22mr4040218d50.55.1765455229744; Thu, 11 Dec 2025
 04:13:49 -0800 (PST)
MIME-Version: 1.0
References: <20251211103136.1578463-1-osteffen@redhat.com>
 <20251211103136.1578463-4-osteffen@redhat.com>
 <h4256m67shwdq4aouxpqadb2zozhq2f5dfeo74c5jnet5f26kz@a3av5xjfyfow>
 <wcqcwrshe6nmz3lb5bz2ucdydwgsfxlxbua5jfaly677zsgy4h@dy3nypkedwhi>
In-Reply-To: <wcqcwrshe6nmz3lb5bz2ucdydwgsfxlxbua5jfaly677zsgy4h@dy3nypkedwhi>
From: Oliver Steffen <osteffen@redhat.com>
Date: Thu, 11 Dec 2025 13:13:38 +0100
X-Gm-Features: AQt7F2qze9RyAeRjOZHPPw_9vU0S84kiY_7xf7UE5IW_lvYtbV8Jd7QVLXvgO0M
Message-ID: <CA+bRGFo=bxbKPCkG6cWY9RH501F8NF4yxZk_hu6Vqi6NkFLK_Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] igvm: Fill MADT IGVM parameter field
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Joerg Roedel <joerg.roedel@amd.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti <mtosatti@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=osteffen@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Dec 11, 2025 at 12:30=E2=80=AFPM Luigi Leonardi <leonardi@redhat.co=
m> wrote:
>
> Hi,
>
> On Thu, Dec 11, 2025 at 12:15:59PM +0100, Gerd Hoffmann wrote:
> >  Hi,
> >
> >> +static int qigvm_initialization_madt(QIgvm *ctx,
> >> +                                     const uint8_t *header_data, Erro=
r **errp)
> >> +{
> >> +    const IGVM_VHS_PARAMETER *param =3D (const IGVM_VHS_PARAMETER *)h=
eader_data;
> >> +    QIgvmParameterData *param_entry;
> >> +
> >> +    if (ctx->madt =3D=3D NULL) {
> >> +        return 0;
> >> +    }
> >> +
> >> +    /* Find the parameter area that should hold the device tree */
> >
> >cut+paste error in the comment.

Will do.

> >
> >> +    QTAILQ_FOREACH(param_entry, &ctx->parameter_data, next)
> >> +    {
> >> +        if (param_entry->index =3D=3D param->parameter_area_index) {
> >
> >Hmm, that is a pattern repeated a number of times already in the igvm
> >code.  Should we factor that out into a helper function?
>
> +1

Will do.

>
> >
> >>  static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **e=
rrp)
> >>  {
> >>      int32_t header_count;
> >> @@ -892,7 +925,7 @@ IgvmHandle qigvm_file_init(char *filename, Error *=
*errp)
> >>  }
> >>
> >>  int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
> >> -                       bool onlyVpContext, Error **errp)
> >> +                       bool onlyVpContext, GArray *madt, Error **errp=
)
> >
> >I'd like to see less parameters for this function, not more.
> >
> >I think sensible options here are:
> >
> >  (a) store the madt pointer in IgvmCfg, or
> >  (b) pass MachineState instead of ConfidentialGuestSupport, so
> >      we can use the MachineState here to generate the madt.
> >
> >Luigi, any opinion?  I think device tree support will need access to
> >MachineState too, and I think both madt and dt should take the same
> >approach here.
>
> I have a slight preference over MachineState as it's more generic and we
> don't need to add more fields in IgvmCfg for new features.
>
Passing in MachineState would be easy, but do we really want to add machine
related logic (building of ACPI tables, and later maybe device trees)
into the igvm backend?

> Luigi
>


