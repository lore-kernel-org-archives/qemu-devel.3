Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F984CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 11:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwIvI-0000Gs-8W; Wed, 10 Sep 2025 07:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uwIvG-0000GZ-NK
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 07:23:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uwIvC-0005T3-Qq
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 07:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757503406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mGFk30MGM5K/JJHqc+uoU4YlFU7uTNlGDhTBnBJSob4=;
 b=etasB0eXPIwtb3cDGzF/aOYIvNVz08iXu3sVkk5/mQh7Tvef2Uwt0Bp81RWUQg2qGWm+pK
 UmwqGFsgYkD49jbfEJBmSha8nkdZmS0A+OKC87g31iN9WHyTQM8r5rh3Ox3cfV5mS1LwQr
 xZ56VszLwSdLZC4iSv775wRs4IrmiFg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-aY3q-ilCNmSYkOJnZeKipw-1; Wed, 10 Sep 2025 07:23:23 -0400
X-MC-Unique: aY3q-ilCNmSYkOJnZeKipw-1
X-Mimecast-MFC-AGG-ID: aY3q-ilCNmSYkOJnZeKipw_1757503402
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3e1260394dcso3430238f8f.0
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 04:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757503402; x=1758108202;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mGFk30MGM5K/JJHqc+uoU4YlFU7uTNlGDhTBnBJSob4=;
 b=Qy4X5buIfTDwzbX025Y0D/5GVPRcvsCa6q6CMWaevreng1wbFeHKe+M0OFeiC1O7aS
 8d5NkK16+A0HyaESLSr/kUQxY9pq94dkzJuhYQwZNrTFmL+rqvlMlpUs6wBJDMC6yrw9
 JvhbWA/Jll0WU+8KIZ8ZGdupxI/Vz3jV4tjxSzvdrYVjnCRp4OWEHnXuIIUArEOI60YW
 JD3px6w+0pQDO+J+2O2U2IXwhhjheuKIrYbLSm1Luyz4o0FEaoOWHA8UgZ/Q1d6iMt3g
 f2WffH5MhtOZUEDQ42y4H0v2CPMWptMDqhUwd1VEyi9jbi+nUMQlDajhsCe6m/cFyHTt
 Lsgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6CF2ob2/8Ov/vT6t3J62CwXg+vfzVs25eeX7tvqF8HeAOwhVEWK91PMeiMYs0GsOIjaGmoWrTUrnL@nongnu.org
X-Gm-Message-State: AOJu0Yw8BWTu9D/OD8VDrPa9LYvHBwpa2tm4RWhGgMr8ejfYkG1xHb7I
 gayQRBGkFRhGDBjtmB+9LeoRg9CW0Tr4K55+Eo7lQHve0/XsUxz6VQiJnR5WijIOjHsxpranby0
 XqqCc8qYd2MCQ8moVXepiCG4Cfs6niA6C+QQCK5+XmadGo2rCA/sr5zUI07Ro9lzWsZSP/SdoWU
 gppjvu6icfAI3Jr2f2JDgml0caeYq0bOo=
X-Gm-Gg: ASbGncscxA+wfaXi/Phh53/ICsy6YayXmnB3h/pzaq09MAJ1+Si3fS0LNxRudthwRw5
 kXRBZV97bEgUpOS6lWRA4DajeM324rjWhQXv/5oZvULlf1qAXRaMmfk83yzs9EeJy7KnDu8+3Dw
 y16xV5zkc+1jlbSIUxTDpW8xc/lMQe/33qT00enljlk5W0ox0bxAy60nGZ9GcKRT5TKRkNOMrBG
 y8ZnK/Lfn0Vfp2Eq7GphzA+
X-Received: by 2002:a5d:5f50:0:b0:3e7:4fda:fe0c with SMTP id
 ffacd0b85a97d-3e74fdafe2bmr6679157f8f.15.1757503402161; 
 Wed, 10 Sep 2025 04:23:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0jLQ1dZ4GmWYrmzVNmseXH/Rq4V2AxJAQskPYaLYAAre5OLDq8O69gm/5flLil4UTKw1UDgpNTfvlXdtzNJs=
X-Received: by 2002:a5d:5f50:0:b0:3e7:4fda:fe0c with SMTP id
 ffacd0b85a97d-3e74fdafe2bmr6679131f8f.15.1757503401747; Wed, 10 Sep 2025
 04:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250829125935.1526984-1-pbonzini@redhat.com>
 <20250829125935.1526984-25-pbonzini@redhat.com>
 <aL7oe3sis3bKJhLW@redhat.com> <20250910131633.4b66856d@fedora>
In-Reply-To: <20250910131633.4b66856d@fedora>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 10 Sep 2025 13:23:10 +0200
X-Gm-Features: AS18NWB7MjUJ6h1sL9RXn4O3u85PYtFg-FZmfQk63dpq2JCWGcxj-Pji0HCLoyc
Message-ID: <CABgObfZz8pYRSDMw0Hq+wpcWPL1Oaq_TPtcbSAnLZW0Gr3XSng@mail.gmail.com>
Subject: Re: [PULL 24/28] hpet: switch to fine-grained device locking
To: Igor Mammedov <imammedo@redhat.com>, David Woodhouse <dwmw@amazon.co.uk>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Sep 10, 2025 at 1:16=E2=80=AFPM Igor Mammedov <imammedo@redhat.com>=
 wrote:
>
> On Mon, 8 Sep 2025 15:30:19 +0100
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>
> > Hi,
> >
> > This patches causes a regression making QEMU  abort in the KVM Xen
> > functional test.
> >
> > To reproduce please run 'make check-functional-x86_64', or more
> > specifically run this single test:
> >
> >  QEMU_TEST_QEMU_BINARY=3D./build/qemu-system-x86_64 PYTHONPATH=3D./pyth=
on:./tests/functional ./tests/functional/x86_64/test_kvm_xen.py
> >
> > though I recommend you first add this series:
> >
> >   https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg01540.htm=
l
> >
> > as that fixes an infinite loop in the functional test console
> > code on QEMU abnormal premature exit.
>
> I'll try to reproduce and see where it goes wrong

I've only looked at it briefly, but it fails on the bql_locked()
assertion of xen_evtchn_set_gsi().

I think the assertion can be moved inside "if (gsi && gsi =3D=3D s->callbac=
k_gsi)".

Paolo


