Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C03ED4335D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 13:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t92dp-00062T-EP; Thu, 07 Nov 2024 08:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t92dn-00062I-W7
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 08:33:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t92dm-0004j8-8L
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 08:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730986416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=54MT5qQtoBUiV5LPScA31jOb1d/rjVxMcCNfKrHwVQw=;
 b=ZvYN5P2AisrfhagihiAYJICdxByyvCsfx28lJq5kZ/uvkyX9gwcG7CO5txAThyv/Ftaqk/
 o0udHHgyE35su3t7Ov1lDgYegCmHWj3zLb+4fgvvKp5jRZpGMMmRj7qiHSUITfePT273aM
 W3msw0/a9bK4LhSpSan4kbbXvggPCfw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-WIfyQMHPN4WYOwj9z17H_g-1; Thu, 07 Nov 2024 08:33:34 -0500
X-MC-Unique: WIfyQMHPN4WYOwj9z17H_g-1
X-Mimecast-MFC-AGG-ID: WIfyQMHPN4WYOwj9z17H_g
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315a0f25afso6667865e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 05:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730986414; x=1731591214;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=54MT5qQtoBUiV5LPScA31jOb1d/rjVxMcCNfKrHwVQw=;
 b=POVmPJuOrZi18UM6tIxmnep8Lw9KmfEKl3P1LhpwLMExBW8JMzV17qTrZAlQJDUE+Y
 SdgjwrXkuGip1Qd2nf1FPd/MwZ+S42+/KTA6i6wxzZxXjHuNCuKaZnkLtiTqEezYXC2B
 0PetxBxq6wqdB9CMg6cH4obXb3o3t35FsYvRhAvnNoZ5fXswI+N5S39khV6QCbH1hToh
 +UDEr7IRNyWIGsNgOPPQvOb7nULAs6Dgj8AU3b3qBI7HH/6etn5tGwikkt/BBytUeJ0J
 TVDBEjSZHCpp/9fHhVqfKNluiXC1jdTKSxt/Z36XoPr2TRfwq3QB43JwyMiWu+DyaE8V
 N/wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpE4a5XQFZW+09g9T3lAIHh8fBjKsdUJKRRuVyLQ/CWoE10z0S74tp8oG8jgRKUo0dCKwvm2YMqz0a@nongnu.org
X-Gm-Message-State: AOJu0YyOo0lonD/e9ZujBi2NiPDj9EDIoUgsFHbdAADMruijF3hx5zJW
 I/4opRzzd06K/ZjVXw051AGGPzFVy6hJ2YgQn1eo1j8BZlnGd5VnNHgzf+VpiS0mCS1sH3/pRgy
 GwAyhRy2JaQ8VtOJiE+bbrZq2dPfMR9+lv1eNH3Kgd0R4wYN5K+xt2muKYRM4fVEeQ3+d1BCRIz
 94+mybrfqekWrdViUTrxFLauEpyB8=
X-Received: by 2002:a5d:5224:0:b0:37d:53dd:4dec with SMTP id
 ffacd0b85a97d-38061137a3emr29226611f8f.15.1730986413710; 
 Thu, 07 Nov 2024 05:33:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT5fn4q0EHF2q9paLWvZvgYtyA9yiMA7tf79qL/MyttDv0QTucxQCj2AmT3wfAKP8aNpHXOcX2cTuXvnN6P1s=
X-Received: by 2002:a5d:5224:0:b0:37d:53dd:4dec with SMTP id
 ffacd0b85a97d-38061137a3emr29226597f8f.15.1730986413374; Thu, 07 Nov 2024
 05:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20241106185136.582198-1-pbonzini@redhat.com>
 <2ee0bab1-1baa-4b52-9856-4c1fa4c9ef0e@linaro.org>
 <ml0lj.kelxgd4xtqc7@linaro.org>
In-Reply-To: <ml0lj.kelxgd4xtqc7@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 7 Nov 2024 14:33:21 +0100
Message-ID: <CABgObfbFGJgExMvVsR6TUrv1Q1VULk6-K1rjgp_w1qH3PWjtQQ@mail.gmail.com>
Subject: Re: [PATCH] rust: pl011: fix device id matching
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Nov 7, 2024 at 2:10=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> On Wed, 06 Nov 2024 22:56, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
> >On 6/11/24 18:51, Paolo Bonzini wrote:
> >> The offset that is compared against 0x3f8..0x400 is not shifted right.
> >> Adjust the pattern matching.
> >>
> >> Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >> Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> >>   rust/hw/char/pl011/src/device.rs | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> The device id reporting is still buggy even with this patch. I will send
> a proper fix within the day.

Sure, but can you expand on what's the breakage?

Paolo


