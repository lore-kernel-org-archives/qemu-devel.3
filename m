Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E97C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 12:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKH0L-00011y-PJ; Thu, 20 Jun 2024 08:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKH0I-00011W-L6
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 08:35:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKH0F-0001IT-CX
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 08:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718886897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+J8ZKmc6WVqVjMfdbmwhqjqqw7K35ILoMMCb1fz3yBU=;
 b=fOAT2N98oOvVxU5SlLS4GibwXSiXi2ICxn5eR4vh/dUrRC3idvUQxXAt2SWIlHOPYsMvB0
 INZdCVHtG6f/upPxcp7wO4q6/xsEbXG7G/moTcsgV16TjJAdsrkV9qWfXy2woA+GBAeF/V
 Xms5yeZ/TOxBrP9mZBwHoBORDUyDZQY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-8teCBD1qOUuiVAmHW9PDdQ-1; Thu, 20 Jun 2024 08:34:54 -0400
X-MC-Unique: 8teCBD1qOUuiVAmHW9PDdQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3634a634f8aso394165f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 05:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718886893; x=1719491693;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+J8ZKmc6WVqVjMfdbmwhqjqqw7K35ILoMMCb1fz3yBU=;
 b=ALaiDHpeQzQqeReXCCCZ0VT83eTmKR937Nx33T1/DjUhqHS0Z35zwFlB98QvIwkCGW
 TyhxwSlf/27XRK2CJWO9xwo7B8Ps4LiFIQpE8e2w3VBnD3yNQSD6cfHeZgIeoAyhh6xa
 pjka7s7vvfTSCcxVMrqiz6BF7g4f6XNisdQ+M5WDWW/MI2KUE/9kzfnug6WvPkmVJK5u
 i5F0XdWm49LcHnOnCsl3bZJwI9w8cIRZcEo0Cmcw0SwbyY4sK2GiGh/qPmomcpPCxuAy
 +Dud6iaIm5aOGYb9iyAGQZd/oqr+/c9tFH6nFibGv9ZVbrzCj5tfvjqF/67cR1brnRob
 8bNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZqv3NqsEa5OxrSwL29wkp9DKPgXU5Z1aoArw2XNJ4PYS4N8UKfpQRB4VaVODujLpDQ7Rxo5jb3do6yVMjTjpPxhNc3Z4=
X-Gm-Message-State: AOJu0YxxIhR5zMXmHH0FtkWmWPCFoOc3ZEvNN4lqPbNt64keOIZeKQxo
 Fak+SeYhmCHsq1bx3yawzpA5mWGkF3dfVPPC40uf9jAX2ZGxRVTyMmQ/dnF6OcBnAZNUTLT7G+y
 dPbZUAp+GpZ2JCYVQ0lGdbYqrL05YAR5d4/lXv74jcw35Ffkg2CsZAPADR8+vIY5Idaq5AjusLO
 xUGinIE62RcxlwczgPBiiXUE8WkSw=
X-Received: by 2002:adf:e441:0:b0:362:c237:5569 with SMTP id
 ffacd0b85a97d-363170eccc5mr3922807f8f.2.1718886893021; 
 Thu, 20 Jun 2024 05:34:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl7i5yax5a8Js0A6dl35wv4BAY9QWjHKdqMvppukHvZoV+T5ef+VPOTi3MiZRLyM6jzcLq0ytFKKwXMJG/qxM=
X-Received: by 2002:adf:e441:0:b0:362:c237:5569 with SMTP id
 ffacd0b85a97d-363170eccc5mr3922787f8f.2.1718886892661; Thu, 20 Jun 2024
 05:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <6bf311a35e6d3bfa8b3bfd10d8f896a9e655fa30.1718827153.git.manos.pitsidianakis@linaro.org>
 <877cejdg4c.fsf@draig.linaro.org>
In-Reply-To: <877cejdg4c.fsf@draig.linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 20 Jun 2024 14:34:40 +0200
Message-ID: <CABgObfbQPMjAS4eMP9=p6vqv_6WYrKk-bGauFkhRtzwY7rA00w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/5] rust: add bindgen step as a meson dependency
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com, 
 Richard Henderson <richard.henderson@linaro.org>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
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

On Thu, Jun 20, 2024 at 1:10=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
> > +# FIXME: These are the latest stable versions, refine to actual minimu=
m ones.
> > +msrv =3D {
> > +  'rustc': '1.79.0',
> > +  'cargo': '1.79.0',
> > +  'bindgen': '0.69.4',
> > +}
>
> So for Debian Bookworm this comes out as:
>
>   msrv =3D {
>     'rustc': '1.79.0',
>     'cargo': '1.79.0',
>     'bindgen': '0.69.4',
>   }

I think it's 0.60.1 bindgen and 1.63.0 rustc/cargo? That means we
don't have generic associated types (1.65), which are nice to have but
not absolutely necessary.

The only other one with an old version is Ubuntu 22.04 (1.58.1), but
it has 1.75.0 in updates

Paolo


