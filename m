Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C23C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 05:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua6c9-0006S0-CP; Fri, 11 Jul 2025 01:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1ua6c6-0006G3-RB
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:48:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1ua6c4-0001Tk-F8
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752212879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5EhnlcjnlQNs6yKbHR/5lcLMJJISSABdIQmZf/Y1KPI=;
 b=CUmO/c+D3SlEfccbODSupzIbEMtSJrB7WzB4dJwpwq7z6A5kLIPCW8Ub0QYp38D4fpoGn6
 58UTP9wgWzvbCXo3/AwdzSLpEBLKUcv391NiHBWF6yi8/k4vwVgsAEJOBeZwNwC3vPt104
 VpU1Ty3QNWXnRNcMvbvIvUUXGgbdg50=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-SSiEo8O1Nhunor3jmLjkRg-1; Fri, 11 Jul 2025 01:47:57 -0400
X-MC-Unique: SSiEo8O1Nhunor3jmLjkRg-1
X-Mimecast-MFC-AGG-ID: SSiEo8O1Nhunor3jmLjkRg_1752212876
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ad56a52edc5so165782566b.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 22:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752212876; x=1752817676;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5EhnlcjnlQNs6yKbHR/5lcLMJJISSABdIQmZf/Y1KPI=;
 b=UhB/Hxt1FTPCAk7aFDrHkn6VzR2ZDanUn8YJgDEJUcSgMYqRANKcLwmPS/DVuaNboQ
 mlaVIy5Ev2IEDgo3WIfisBgH10h6QTpER/Wb723546AAbsVxn9Jk0UMdbcKmxM3kLgcL
 utAmUC1BWicU4biG8pMdYAUscb2cJ4zS+pAgPDLAdbwgc/iFhGlzB3m6T9HQi4wqBO0J
 ipukCd0rTanKY96Yqf5Vab0WRtRLuWp1vlsE9d06Li61IcLGm5qRKu/3x7tijQ7kp40d
 bMvtzIHJB589Aj5i8CYeC1ZvxBaZY8WMqv6EXGGhxBH9xAiyPt7tfIrIiTjxJnS2GaDn
 5iJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX477P0hipI4WL7y9n856B694p8PqN2/PHw1RNtOcQRYP12LfoADcsuzNFzOXSV5FlM5BdKl2ouf9bB@nongnu.org
X-Gm-Message-State: AOJu0YwDi0rPwJF5mXulRLjsQF4n81l7woEIJXqjyoHsHl5NT+NyMmjp
 WJ84FReXrf+BNwGZLdLteOOUVhGqpVAcGnZzr77yugwinY5I6zcz8z35s+AVzmPlNkaWqb6K90J
 0q8VrC6SrxNe7C2YyKzDTMCA0Td2JENGkC+IweRKbP7pVMEcjjSwo4c0GL1joSDIObm1IKsnOyp
 5yeCHqb0xi2qb5rbZ1TjiSVo6XDRtLaoI=
X-Gm-Gg: ASbGnctqjLoh2ct25eRtJNyk2NqCHvbE3UQVqJt9cPMqh/pT1ovSStrArTw5dubdspR
 Aoo6SXi3qoeAiOkGQO9CLUizyxfoqWXTxYy9hEUWfSSbe3KsePvBAA4qbWZ/oMfohKmSOTwLqEu
 o2ULzprf205DDcWUZaAmhQiYY=
X-Received: by 2002:a17:907:7e89:b0:ae6:fa42:69ab with SMTP id
 a640c23a62f3a-ae6fbf9b01cmr176329066b.45.1752212876327; 
 Thu, 10 Jul 2025 22:47:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpq/8esfxY8lOOhoiClj6cT4+Kxg+Okxb8n7aHyw+7uTHCkrZHo//86p5Q64Mx6lRMnGnpDe2AS+FRyTBY2BQ=
X-Received: by 2002:a17:907:7e89:b0:ae6:fa42:69ab with SMTP id
 a640c23a62f3a-ae6fbf9b01cmr176326366b.45.1752212875779; Thu, 10 Jul 2025
 22:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1751554099.git.roy.hopkins@randomman.co.uk>
 <23e34a106da87427899f93178102e4a6ef50c966.1751554099.git.roy.hopkins@randomman.co.uk>
 <aG00MgIsZdXq9bRy@redhat.com>
In-Reply-To: <aG00MgIsZdXq9bRy@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Fri, 11 Jul 2025 11:17:44 +0530
X-Gm-Features: Ac12FXyZ175FE3suxBeCL9iUT64GTre1OcgbKygp5r4Ho4kHFcyM59v_cUgup6o
Message-ID: <CAK3XEhN3qDHJAykaYbOBXqRf6-qwX+ZPGHVuUuBLWN0o8J+Zpw@mail.gmail.com>
Subject: Re: [PATCH v9 02/16] backends/confidential-guest-support: Add
 functions to support IGVM
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Michael Roth <michael.roth@amd.com>, Gerd Hoffman <kraxel@redhat.com>, 
 Pankaj Gupta <pankaj.gupta@amd.com>, Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Jul 8, 2025 at 8:37=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Thu, Jul 03, 2025 at 04:03:10PM +0100, Roy Hopkins wrote:
> > In preparation for supporting the processing of IGVM files to configure
> > guests, this adds a set of functions to ConfidentialGuestSupport
> > allowing configuration of secure virtual machines that can be
> > implemented for each supported isolation platform type such as Intel TD=
X
> > or AMD SEV-SNP. These functions will be called by IGVM processing code
> > in subsequent patches.
> >
> > This commit provides a default implementation of the functions that
> > either perform no action or generate an error when they are called.
> > Targets that support ConfidentalGuestSupport should override these
> > implementations.
> >
> > Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > Acked-by: Gerd Hoffman <kraxel@redhat.com>
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > Reviewed-by: Ani Sinha <anisinha@redhat.com>
> > ---
> >  backends/confidential-guest-support.c       | 31 ++++++++++
> >  include/system/confidential-guest-support.h | 67 +++++++++++++++++++++
> >  2 files changed, 98 insertions(+)
> >
> > diff --git a/backends/confidential-guest-support.c b/backends/confident=
ial-guest-support.c
> > index 8ff7bfa857..c5bef1fbfa 100644
> > --- a/backends/confidential-guest-support.c
> > +++ b/backends/confidential-guest-support.c
> > @@ -14,15 +14,46 @@
> >  #include "qemu/osdep.h"
> >
> >  #include "system/confidential-guest-support.h"
> > +#include "qapi/error.h"
> >
> >  OBJECT_DEFINE_ABSTRACT_TYPE(ConfidentialGuestSupport,
> >                              confidential_guest_support,
> >                              CONFIDENTIAL_GUEST_SUPPORT,
> >                              OBJECT)
> >
> > +static bool check_support(ConfidentialGuestPlatformType platform,
> > +                         uint16_t platform_version, uint8_t highest_vt=
l,
> > +                         uint64_t shared_gpa_boundary)
>
> Nit-pick - underindented by 1 space.

Speaking of which, running checkpatch on this series reminded me that
MAINTAINERS needs updating for this area.

>
>
> > diff --git a/include/system/confidential-guest-support.h b/include/syst=
em/confidential-guest-support.h
> > index ea46b50c56..79ecd21f42 100644
> > --- a/include/system/confidential-guest-support.h
> > +++ b/include/system/confidential-guest-support.h
>
>
> > @@ -64,6 +95,42 @@ typedef struct ConfidentialGuestSupportClass {
> >
> >      int (*kvm_init)(ConfidentialGuestSupport *cgs, Error **errp);
> >      int (*kvm_reset)(ConfidentialGuestSupport *cgs, Error **errp);
> > +
> > +    /*
> > +     * Check to see if this confidential guest supports a particular
> > +     * platform or configuration.
> > +     *
> > +     * Return true if supported or false if not supported.
> > +     */
> > +    bool (*check_support)(ConfidentialGuestPlatformType platform,
> > +                         uint16_t platform_version, uint8_t highest_vt=
l,
> > +                         uint64_t shared_gpa_boundary);
>
> Nit-pick: underindented 1 space.
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


