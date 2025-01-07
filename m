Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98711E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCST-0002Df-I3; Tue, 07 Jan 2025 11:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tVCSS-0002DK-1X
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:29:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tVCSQ-0003Ab-FB
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736267369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jiM1LIzVm64gZNl2wcaUn5sDKQykU/RHxCllnJa+msk=;
 b=Xl4a4SQXW2+ut1JrGC31KkOS+XQPLKItWnNNuxz9K2xCaAUsXKe6qTeAQSZDp0SYtqt3ZI
 n4VLJXtW6tJLRUpDb/macX2hLT3wBa14yyU+j7IG/g9IZ7jFPJl5WHx9Xf4xs8pEosJkXj
 SVqT/IQ1BrDn+RWHQaOEbo6boUun9rk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-2PHXXkjmPpeEqfMkuTd0Ug-1; Tue, 07 Jan 2025 11:29:27 -0500
X-MC-Unique: 2PHXXkjmPpeEqfMkuTd0Ug-1
X-Mimecast-MFC-AGG-ID: 2PHXXkjmPpeEqfMkuTd0Ug
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43626224274so48678025e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 08:29:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736267366; x=1736872166;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jiM1LIzVm64gZNl2wcaUn5sDKQykU/RHxCllnJa+msk=;
 b=dHJ3eZ6iD5jIvI7RhpJFuWb09yp0qrFiK11TR9wrY3eftr4bZOwS3CPbvm4A+uUJpd
 AvubDavT5O3YWAf+iprjuR6EbTpKGg5ruLhUV2XV+AE6m/ZhEFA6UiAIBP2ylypiQEVu
 plyBde8JXMp6HL+PoNZNGv081K25AiyPq6s0wjXaG/OzcmAk3sgbUal3FRA0QbvKCUm6
 HTCnUpUIAYWz4UmNuRO5EFEfy7XNdm23amKq1IjJ+7gLOfjkas+G3J0nXaRqPYDR8fQJ
 z4ahopqG9LqqJrQWUxwRF/JOc0CygO1XAK7MGGB/awtn+nreaP9OOaRpSHYehzDh6MVD
 ygWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWskA7vIX+GlysJjxp05snuMPGO5wKZxVGTBT4RRIwm/Z0uU63JCcTb4vGSvJjyYWtSHqPKT6f7w5c0@nongnu.org
X-Gm-Message-State: AOJu0YzJCwBnz1DGcMCw4URvKzZaTvdVtpTmQarrNsO0mGj28TfPnEN7
 lgp9Ui3PW8YwDwnVLafhn3y1c4AJBHd1ihGOmGt+bKOp9c5zjQymebAdAhwA7zx6nQlXJbeK9Te
 fe8n+RKxxS1Yevaa5zRnF54GWuDFDxXGPafwqMpBbCPMDN+EivZ9Kj/8r19+FtIyQHHhQI0ZcHg
 oUwQCskSGn2FJTuus4jh1k+6xVrVs=
X-Gm-Gg: ASbGnctvMJeGIl70Rd0P+3RvMTdLka5dXgi30x51A28LdocAhB5IiC2kzMNVUsf5q4H
 FJzDt3GR0oT+TYOc62VPKWAEXv3fpXBxkdfsa+g==
X-Received: by 2002:a05:600c:468f:b0:434:f335:855 with SMTP id
 5b1f17b1804b1-43668b78324mr419547655e9.28.1736267366547; 
 Tue, 07 Jan 2025 08:29:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1Gm88GTwU+d69vau7yMVlbGi8WnUchWKhvfIJhqzmRufi4K50T9P/SzUeM0X8LPa6QAObtFdXkFXzHhpwZAk=
X-Received: by 2002:a05:600c:468f:b0:434:f335:855 with SMTP id
 5b1f17b1804b1-43668b78324mr419547495e9.28.1736267366255; Tue, 07 Jan 2025
 08:29:26 -0800 (PST)
MIME-Version: 1.0
References: <20241219083228.363430-1-pbonzini@redhat.com>
 <20241219083228.363430-26-pbonzini@redhat.com>
 <daea6757-a67b-45d5-bf2a-807fd9569a70@linaro.org>
 <CABgObfYMP5-9uN9cLofPT6DzBS_o1CVfbHbY8pwn9xjdOXOqgw@mail.gmail.com>
 <CAFEAcA-PE1paXOJNUo-cihu__htZQUYogZphVhRAjFNFzgi7JA@mail.gmail.com>
 <CABgObfZ7FFW5yhA2u6Rt5=MndrLsF=BnNhgE73LAyUWUGF=yXQ@mail.gmail.com>
 <Z31OiMcYT/66AGDt@intel.com>
 <CABgObfZETbD03-H6=qOt6V8GY4ex3WP82i5axzdf_U0GCwsMbw@mail.gmail.com>
 <7cc2a444-c699-4e56-80ff-8f9d6890b71a@linaro.org>
In-Reply-To: <7cc2a444-c699-4e56-80ff-8f9d6890b71a@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 7 Jan 2025 17:29:14 +0100
Message-ID: <CABgObfaMja+D5NcCBp-AKUGgOgTR=uju93dyj57ZFAO+mUGUDA@mail.gmail.com>
Subject: Re: [PULL 25/41] rust: qom: put class_init together from multiple
 ClassInitImpl<>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, Jan 7, 2025 at 5:24=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
> > but I don't really like the two parameters and also I don't like that
> > class_init is called differently for classes and interfaces. It's
> > probably possible to design a better API, but I didn't spend too much
> > time on it because it may require rethinking how classes are declared
> > (not a huge deal, as we have only four of them).
>
> Are you saying this is not a problem related to QDev Reset, but
> a limitation with any QOM interface, and we can not instantiate
> any type implementing TYPE_INTERFACE? As in:
>
>    .interfaces =3D (InterfaceInfo[]) {
>      ...
>    },

So far there was no need for that, so it is not implemented. There are
three parts:

1) adding interfaces to the TypeInfo

2) filling in vtables for the interfaces

3) filling in the ResettableClass vtable based on a trait

None of these is supported by Rust code right now, but only (2) and
(3) are needed for qdev reset. That's because the Resettable interface
is declared in DeviceState rather than in the individual devices.

(2) boils down to wrapping object_class_dynamic_cast into a
nice-enough API. The commit that I added to rust-next covers that and
it should work, but the API is a bit unorthogonal.

Paolo


