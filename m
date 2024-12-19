Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E240CE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJIv-0002gU-9Y; Thu, 19 Dec 2024 11:23:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1tOG5Q-0006RI-2T
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:57:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1tOG5O-0008Oc-FW
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734613021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uXzJANXhwMdBRsCMeT0yHZ2KzMN5BtMBkrRQTHFIH+U=;
 b=iuj0HxFVsBLmV10k1xT+caQ0bjHEPmvCBDUtDpSCI2H6yb0eMrhIWb+jDXaZfeA1oWME5G
 FiIp8gCJRDCikEkNQq5v6zL4cbGLWlaTVN4GLvGH4ebFIZjFarT0yEOt1TPJZfbfFq5M/X
 bUfLOXMZsX4XW7fYNQxoP1gDkVDsCxk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-pLrMYwzuOyubKjyYp5kH9w-1; Thu, 19 Dec 2024 07:55:51 -0500
X-MC-Unique: pLrMYwzuOyubKjyYp5kH9w-1
X-Mimecast-MFC-AGG-ID: pLrMYwzuOyubKjyYp5kH9w
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d8f94518c9so15436236d6.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 04:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734612950; x=1735217750;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uXzJANXhwMdBRsCMeT0yHZ2KzMN5BtMBkrRQTHFIH+U=;
 b=OcMs0QNlUehB8rhKHuq+G/eOGjvWe69QoYlARHqVmYQEymUKU8KU5umlI1GZ5xvFzl
 JvbrBBP5+Ou5FHsqSdlBLOxH4Q1hzdBR3C/ThK/rVjhsJIPzNneyIDv5Ny6UWOewIifg
 rrc/BBPwAXKrLRwVoUvSR9BLXSACz2R/7B0uHpHevBb1nt/gNwB+CxA/f+b2Ke3rzxV4
 MB0tKVuSDOvYwYFjlQEzGSl9g9+yRTtQC5nqL9Oc+gS8uv0oMXdthn+QkNuvf5LltsWJ
 qgzZk3OywC21EX1wQWlBk8zCK3GIkCzf8VJ+aFvyYIk4Sp3ypd6Jmgx5Rhr6nS/4BixM
 X1aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUgmvTeR7JG1yF/S7ltzdovrnFTF35rkqvxtx6ZEl3s4DqGlHxdGQyv7wSEUsxf0b0uKWrvduuFQy9@nongnu.org
X-Gm-Message-State: AOJu0YyR/oodl/xVvbrf/QJB5Y4S2l0UjyT59IsogdnHZSbgAmWb/xyk
 xUXlpqCy4TsNgyi0jy4VPCs4E776Gc80wwWcY9zCKOagBQVJMWZK6ck/+bWE622dvh+ghHv29+4
 xBznySrjMts5UX6DmDplHXGN+2NwmHnBBxhwsbzpopH1ULS/heyOWDjaCDMmi8F0w9yg/1TNg3R
 +rbICoIOamEa5NFuqqaAHkdchpj8M=
X-Gm-Gg: ASbGnctEGdg/wKYYm8IxsYV1X0qERsiqFDGQMzhvxAWnLLtLTP9oCjOlQX3F3ITjB38
 Agz6/kivgNUauqp8Ct1fNZGV8QjwGebHybyTs9cHQlcKV2D8znTO8oUqTVjjLM0CTHy5UvgA=
X-Received: by 2002:a05:6214:caa:b0:6d4:238e:35b0 with SMTP id
 6a1803df08f44-6dd14b9e6aamr54895506d6.17.1734612950574; 
 Thu, 19 Dec 2024 04:55:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHc8CvBpnh+vnzUpe1Jec9gHlHrtZrl6f8KPOw7VEqnwHjtpvY54iSE+/u+CEbIqjWhA3ecd+vqUFcVVHwGQ0k=
X-Received: by 2002:a05:6214:caa:b0:6d4:238e:35b0 with SMTP id
 6a1803df08f44-6dd14b9e6aamr54895246d6.17.1734612950337; Thu, 19 Dec 2024
 04:55:50 -0800 (PST)
MIME-Version: 1.0
References: <20241216114841.1025070-1-anisinha@redhat.com>
 <61096f4d-7b5f-48fd-9840-caf058db2201@linaro.org>
 <2933CCF9-F9D6-46D1-9658-07B85104011D@redhat.com>
 <6eed1b13-f41a-4590-8254-dbfb1f9c7a5b@linaro.org>
In-Reply-To: <6eed1b13-f41a-4590-8254-dbfb1f9c7a5b@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 19 Dec 2024 16:55:39 +0400
Message-ID: <CAMxuvawa3G_G4DvSNdF_y2anTtte0ayVaANsvo9Gh_TKP3bEbA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>, Alexander Graf <graf@amazon.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Daniel Berrange <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi

On Thu, Dec 19, 2024 at 2:03=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
> >>> +static const TypeInfo vmfwupdate_device_info =3D {
> >>> +    .name          =3D TYPE_VMFWUPDATE,
> >>> +    .parent        =3D TYPE_DEVICE,
> >>
> >> What is the qdev API used here? Why not use a plain object?
> >
> > I wrote this taking vmcoreinfo device as starting point. I will leave t=
his as is for now unless anyone has strong opinions.
>
> We shouldn't blindly copy/paste & spread possible design mistakes.
>
> Marc-Andr=C3=A9, any particular reason to implement vmcoreinfo using qdev
> and not plain object?
>

I don't remember (damn 8y ago..). It seems the design changed over
time during review, qdev might have been necessary and stayed this
way.


