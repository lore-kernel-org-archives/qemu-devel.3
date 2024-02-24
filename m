Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82563C48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 22:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1re0f4-0001du-Bc; Sat, 24 Feb 2024 17:38:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1re0f3-0001dd-9T
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 17:38:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1re0f1-00017r-PP
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 17:38:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708814302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=40TtFxg1pEVEJWYlwDy7fIgI5EIVX3ypk2Eo4eCmLhg=;
 b=OYjo/xj4PJcSea73ezfCijcjv+ruB8vXhLj4wn2ZvHLFvyBTTMI9dRC8Yq618pNstPi0qg
 1GPAckycWzG0psaVDrPRhuofIEmzc3BjY4ht4FzPgvTOPllS8Cn00cTZJlicNXNg8sQ6RC
 l0LRf3gzIvsI77/t6XDyXRw+li7IrOI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-hwuymFXqMUGaA5xcDeGPag-1; Sat, 24 Feb 2024 17:38:20 -0500
X-MC-Unique: hwuymFXqMUGaA5xcDeGPag-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33da4d779c9so629922f8f.1
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 14:38:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708814299; x=1709419099;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=40TtFxg1pEVEJWYlwDy7fIgI5EIVX3ypk2Eo4eCmLhg=;
 b=KKeSEtj6bLEDsaDw2/hMYTjpG0C6j93RoNnln5fjVEyVg/ZoL19+d0mrySYxrrCAcI
 9t2PWnb54Gp3xrf2d2vZ6ZlQZWoJW1eVGfOrh5y1gucjtsHRvVeYN84y/EdqlWImnon0
 7ZfhOWwmH25gzWFR3mpYL/hi6i7ybfOkfFVWm4xpSCyR05fugJI/chcO8qutKM3zef8O
 YOAYBPwNkNOdIXugdl9kRRnoJiSdcVTyx32s+4/58jvoCtaihLLwNwQbgAV8vb/C7GsF
 PDU+N/QdDhDeymWhYvf1qWMZ3TppoSMwNSu97a5l4wrWTTByPiUlS+GwhRBp04Udzv5h
 a3iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKazmIk5Ar4Zr/uFqskQxH8GE1feZd5KqS56eg8DB3efylcuFDcVgXYw2HhDI/10i+M4wJSGnUbCwWwEPRGHLs4gkRCao=
X-Gm-Message-State: AOJu0YwVw5c4FKKru8z0gCiPfA4cIIa2mwLpPPwrWsbXt3L0Up1kuXmw
 GD7cmN3Ff1l4HrYIdtW+VDwlpNUvd13tPsrr0kLB6vLOOQXAVHGu14vdtu0JevVe+FdpUj6oi5W
 /9NK2jmLH+pOSkY/gq+hOSO0i3waRI04naOukNY5KiHhVWF14JYokPSjVgrbL0nmMrsikBNM/kV
 w0ZAbTUa6Xu7b4d7TMo47650WwRfo=
X-Received: by 2002:a5d:64ab:0:b0:33d:c131:26e3 with SMTP id
 m11-20020a5d64ab000000b0033dc13126e3mr1788526wrp.14.1708814298957; 
 Sat, 24 Feb 2024 14:38:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/ndiwZR6iK7wtaKADS9cUrrxln8kancT1RdRvmCHFyVA1VNK5dGmOyekoSxEnQuuIHX57wH9ZdPQhvfOLy5M=
X-Received: by 2002:a5d:64ab:0:b0:33d:c131:26e3 with SMTP id
 m11-20020a5d64ab000000b0033dc13126e3mr1788520wrp.14.1708814298632; Sat, 24
 Feb 2024 14:38:18 -0800 (PST)
MIME-Version: 1.0
References: <20240223124406.234509-1-pbonzini@redhat.com>
 <20240223124406.234509-6-pbonzini@redhat.com>
 <50972788-77b0-4494-b956-367e227575b6@redhat.com>
 <ab8ce4b2-d0c4-867e-44cf-44137e91a610@eik.bme.hu>
In-Reply-To: <ab8ce4b2-d0c4-867e-44cf-44137e91a610@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 24 Feb 2024 23:38:06 +0100
Message-ID: <CABgObfaTc47kf7L5Jyh75KA__Jfzb-0cmOEwCRbPHOT8f=7qUQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] hppa: do not require CONFIG_USB
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 23, 2024 at 8:56=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
> >> -    if (!lasi_dev && machine->enable_graphics) {
> >> +    if (!lasi_dev && machine->enable_graphics && defaults_enabled()) =
{
> >
> > Do we need the defaults_enabled() here? Isn't enable_graphics already
> > disabled if defaults_enabled() is not set?
>
> Isn't enable_graphics controlled by -nographic and defaults_enabled
> controlled by -nodefaults? I think they are independent but maybe that
> does not answer the question if it's needed or not.

Indeed they are different. The idea is that if graphics are disabled
you interact with a serial console so you don't need keyboard or
mouse; and if default devices are disabled of course you create as
little as possible and leave everything to the user.

Paolo


