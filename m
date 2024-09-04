Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A94CD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 11:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slnu1-0004YK-66; Wed, 04 Sep 2024 07:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slntu-0004LE-84
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 07:10:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slnto-0004ss-7B
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 07:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725448203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x10BpO19X4U6u9lb6ySW1fwldQquzzGsSGwyu79XcJs=;
 b=FTNVinuEnfGiTr+Ya0VpTx84itz9QMchkfa6+zrSItdoGUqlIuloDuAbetEgkd7xdis5Fc
 z1lnCMsAtU0pDuT3n/kFM5IiwqEWRttaXUwmAlpdbnD/nec8ZtbjMc87t2Ap6QI2cu1TD4
 vkr07GGwdSj8/gVTcE98PC5+aBqh3tM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-8aVV3AZBM0iN9e87LPVJmw-1; Wed, 04 Sep 2024 07:03:51 -0400
X-MC-Unique: 8aVV3AZBM0iN9e87LPVJmw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-374c54e188dso336806f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 04:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725447830; x=1726052630;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x10BpO19X4U6u9lb6ySW1fwldQquzzGsSGwyu79XcJs=;
 b=L9i2kFwt/KDbDtPiSnKYng+20AVnLPgKy3jdBRQTndYpukfJ0wU0uDe3r+nGnYIIU2
 T8ph2qWOD/T+fjYvGeC/oleRlk7jRtY7GamDmWwFjfzAIG/Zf8QXm89Phz6LX3YmUErT
 li3zdV3wpr5cGFp1jKHpXkNZGnsOJqauM7ZPzZLz4pdWHwhFnUW9K23TCtMXuNNWc41y
 DFst4c5wbgCDkkE4roppNvulvBAXv1k8IvOiuvdOTAIeNwMxDo/iRLOLItcL/e3w0n2G
 qdh7nrcfQNNnlxHzIFRzonUHGJJQcWzCle1Oh6K/I1lsmCT9ixWeeFjFyQ8ZyteI7Xdj
 X9Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCViZffhMlgLYNrSQ7Jit1cGxIS8VSf3uO+jmrCqaVgBOmA2XRXAZVSDxPtBU89KjID4YRSZw+WxWPqs@nongnu.org
X-Gm-Message-State: AOJu0YzjF0LSkUX5W1jJK1CKXP8llV9uVrMOcQKvUrYG4NoYeIDYz6rU
 6QbwpQjhoGSZ5/shSpUqxMXAuIma+SWDEKgiCRxKoh/MaIxclVvvp3Y98IinoXs2TrPSaWl2bj3
 OkLRF+emzb5w9LiBtAOwcYutPXPTE3mZOgN94EgWJkAcNfGxdnVlFXScbgyBuWIDW180RrDHJfu
 25hzSUzzJFYj/rdm+yJRAHnLqjf3o=
X-Received: by 2002:a05:6000:1189:b0:374:d2a3:d213 with SMTP id
 ffacd0b85a97d-3779a70796fmr815248f8f.18.1725447829926; 
 Wed, 04 Sep 2024 04:03:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNXVueRRfWvkoIvr2jbaK8nQi3fnfILmo9GcPsP5dhiaaQS/kC5/0gm/1XOGlvC59ir/YPOV6pARFGD3rQrgg=
X-Received: by 2002:a05:6000:1189:b0:374:d2a3:d213 with SMTP id
 ffacd0b85a97d-3779a70796fmr815224f8f.18.1725447829450; Wed, 04 Sep 2024
 04:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
 <20240828-rust-pl011-v9-3-35579191f17c@linaro.org>
 <Zs8X7dV4XczEM5YU@redhat.com>
In-Reply-To: <Zs8X7dV4XczEM5YU@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 4 Sep 2024 13:03:38 +0200
Message-ID: <CABgObfYL6ACRK4GF80vjY42sWire4H0SyN+oz+99q5oPjA_3oQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 3/9] configure, meson: detect Rust toolchain
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Junjie Mao <junjie.mao@intel.com>, 
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Wed, Aug 28, 2024 at 2:28=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> > +if test "$rust" !=3D disabled && test -z "$rust_target_triple"; then
> > +  rust_target_triple=3D$rust_host_triple
> > +fi
>
> Defaulting to the $rust_host_triple is incorrect when QEMU has been
> told to build for a non-host target.
>
> Either we need todo the right thing and auto-set rust target based
> on QEMU target (preferred), or we need to make it a fatal error
> when rust target is omitted & QEMU is building a non-host target.

I already have a patch to autodetect the right triple, but I didn't
have time to finish it (and send it to Manos) before disappearing on
vacation. I think it's okay to initially require --rust-target-triple=3D
for cross compilation.

Paolo


