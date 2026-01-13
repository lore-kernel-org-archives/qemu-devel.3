Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B8ED29DEF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfaKs-0004VY-Aw; Tue, 13 Jan 2026 04:05:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vfaKq-0004Ui-Pc
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:05:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vfaKp-0005hJ-8C
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768295106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qajHnMGw3ZdtEuAKfx2zY/SzFAOO6RQwHn/ZFyWTsbc=;
 b=Co9tuq7YBA2iYVdwHAYQtokydiDlSV7ZW6yVXsxvYneJxLUMpx6LLodedULB5k0EN88RLH
 9FqR4qnOXjaKx+CiQWxveKL63esqm2jMxFiuIwRhMhQdDS0Gi1GQREfFDdTLK7nejtdu3o
 B4hR5p4fYRPY45rzv32ygAu2uqNmzeY=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-YWufnrKaNb6EG4rno1U0Xw-1; Tue, 13 Jan 2026 04:05:05 -0500
X-MC-Unique: YWufnrKaNb6EG4rno1U0Xw-1
X-Mimecast-MFC-AGG-ID: YWufnrKaNb6EG4rno1U0Xw_1768295104
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-648f70e3483so1237415d50.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 01:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768295104; x=1768899904; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qajHnMGw3ZdtEuAKfx2zY/SzFAOO6RQwHn/ZFyWTsbc=;
 b=Ru2hU5PBj36KgMwi7fwKSUoUWnZgS2nKtePtzYnkmWP/ADB9ThBrZv6nbkZ6yF39Sn
 0hEsuoPSsmoA+f44PLr7FoAUB5mGbuoA4HmkOf28B0ZW93eCyIlDGUGZdOJMa0VeC2wr
 diu/rOtv+eRoLQU7GTkb7KeXeWWhdVj04QJouerKLIYQSuIkmh0MZuUbJhaNJTXMCUhX
 V6y6ANXVOH1B/SvpBBzeoyNaiC/IlmAlR1134F0ChVRQmJFGOW2uEugh/Zf+nzGIIKvO
 8L/2syO4399j8ke6x5y5bnXGNV+0Il5PTaCGqjbsG77BU9/LfcqdlDLxlTmX36WTMCrn
 cIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768295104; x=1768899904;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qajHnMGw3ZdtEuAKfx2zY/SzFAOO6RQwHn/ZFyWTsbc=;
 b=oPq6+0p/Kvv8UMhNHDlS+beCLnh3i00Cgk3wlkE4bpTFTmnLTaZ/osl6nP+gC0seqV
 wH3bICRNyNqgweO62cOxrFh05galDlux2CwwF5yLaR98Vl3LTM5EqQ1x8Ljh6wNzvBaB
 bbY2WmIS5LXolEjpl7ZnPKTnOl0IhTeiq8X9aNd8Yij7qZNjwUqdEb7t843Ca+Pd9/uG
 /ejjRVBZLB55EkKrDPpJwUvLWqS24J65aZxZirzGt9L8ZmXjW86sL87vZT8KMjmuD+6M
 qJgVQhieJbHAO79oYYlHYNBlqGIo9whxZy82IWU8jQvCnGK2RikmzAcQG/Oge+L3MdvA
 t8Zg==
X-Gm-Message-State: AOJu0Yw01jgKvk9ldcV/JrHm2G8niGou1M8IiFGsL7RbUw0g22KYaKmh
 RmE1m06w8qAYO1lQkeRuWqybQPbb+PSdiqd469uDMUW4m3E9IUZedeMmXPyr4iZjUiSzDytBEhS
 6Y4xApaAz7+0ALFsdAB6O2jIRnGgji2sc8Vh8KMypPn7JYor8G5w7+sYJSqocNjJeFYE2MSQKZ8
 LKxGwQe1R+MKIbx6nJCgMFYyr9PJg9Mqo=
X-Gm-Gg: AY/fxX59VXHCI33eelhWjeZQMgdwJNUyMEqcENStNkQEChbOAbM4jCFA6t8teJpkAy+
 X0Ty/4R4G/ynkK/a6+ZXlGBHogHOVuDne1MHgnjn0d6yD9VDZAPyIqL5739ah0nwgQiVt83V7+d
 Zgga1S+rGwL45R4XgMYFl8HrxZ9N57djP8Rm5LUnMlL+DijfH6wx3BY5RdbrFfR5pmEpzgrPaae
 FjMAydK2bV/CI5MwdU9KjKcPA==
X-Received: by 2002:a05:690e:1407:b0:645:52ab:8101 with SMTP id
 956f58d0204a3-648f62b7babmr1967412d50.33.1768295104529; 
 Tue, 13 Jan 2026 01:05:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9hDVcta2sm1Dxk1EZJEMaNuPNZlLYI8i4dtYynMlPY7XTJuYxfeRoBdVnl9c5rGQjUSisOkYeC2cxY/vAvUI=
X-Received: by 2002:a05:690e:1407:b0:645:52ab:8101 with SMTP id
 956f58d0204a3-648f62b7babmr1967391d50.33.1768295104191; Tue, 13 Jan 2026
 01:05:04 -0800 (PST)
MIME-Version: 1.0
References: <20260109143413.293593-1-osteffen@redhat.com>
 <20260109143413.293593-4-osteffen@redhat.com>
 <F2E4DEF4-3E69-47E4-946F-8795FD6CF77B@redhat.com>
In-Reply-To: <F2E4DEF4-3E69-47E4-946F-8795FD6CF77B@redhat.com>
From: Oliver Steffen <osteffen@redhat.com>
Date: Tue, 13 Jan 2026 10:04:52 +0100
X-Gm-Features: AZwV_QgUwF8qACGwNJN7vmv95RmAWL6ETL_v2kwRNY9Rhxnmlv7uFfct8yEs6mA
Message-ID: <CA+bRGFrdeWpZFwRsLVOGDfw_Wb5622f6GafiJVE0dY1tU8yq1w@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] igvm: Add missing NULL check
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Joerg Roedel <joerg.roedel@amd.com>, Gerd Hoffmann <kraxel@redhat.com>,
 kvm@vger.kernel.org, 
 Eduardo Habkost <eduardo@habkost.net>, Michael Tsirkin <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=osteffen@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Jan 13, 2026 at 8:21=E2=80=AFAM Ani Sinha <anisinha@redhat.com> wro=
te:
>
>
>
> > On 9 Jan 2026, at 8:04=E2=80=AFPM, Oliver Steffen <osteffen@redhat.com>=
 wrote:
> >
> > Check for NULL pointer returned from igvm_get_buffer().
> > Documentation for that function calls for that unconditionally.
> >
> > Signed-off-by: Oliver Steffen <osteffen@redhat.com>
> > ---
> > backends/igvm.c | 13 ++++++++++---
> > 1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/backends/igvm.c b/backends/igvm.c
> > index a350c890cc..dc1fd026cb 100644
> > --- a/backends/igvm.c
> > +++ b/backends/igvm.c
> > @@ -170,9 +170,16 @@ static int qigvm_handler(QIgvm *ctx, uint32_t type=
, Error **errp)
> >                 (int)header_handle);
> >             return -1;
> >         }
> > -        header_data =3D igvm_get_buffer(ctx->file, header_handle) +
> > -                      sizeof(IGVM_VHS_VARIABLE_HEADER);
> > -        result =3D handlers[handler].handler(ctx, header_data, errp);
> > +        header_data =3D igvm_get_buffer(ctx->file, header_handle);
> > +        if (header_data =3D=3D NULL) {
> > +            error_setg(
> > +                errp,
> > +                "IGVM: Failed to get directive header data (code: %d)"=
,
> > +                (int)header_handle);
> > +            result =3D -1;
>
> I would just return -1 here and remove the else {} clause below. It makes=
 it slightly easier to follow the code.

Sure, can do.
But are we ok with publicating
      igvm_free_buffer(ctx->file, header_handle);
which we need before returning?

>
> > +        } else {
> > +            result =3D handlers[handler].handler(ctx, header_data + si=
zeof(IGVM_VHS_VARIABLE_HEADER), errp);
> > +        }
> >         igvm_free_buffer(ctx->file, header_handle);
> >         return result;
> >     }
> > --
> > 2.52.0
> >
>


