Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FB8CD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 11:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sloFq-0004gq-JW; Wed, 04 Sep 2024 07:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sloFn-0004Wb-OK
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 07:32:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sloFm-0008Pb-0k
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 07:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725449566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HikrecDzuQZ+HW3KJp4Ub7/bQnHaCS7c5CHmC+pqSGQ=;
 b=e/fHyAWdHJlQDRw+qXVe1VmxnR+SNBcv/2d93bZZrffw5bq/fp5bgHDQDA/Hx5ha7Sr+TD
 Iy4GCASCKVokYUMimNaNARPrNjbxbSeA0vTqV1BJf1AfRZbcT9yOr6BtpOrhnh0+AdT2GJ
 7QeAO6nNYrFomb4bfw9hM+vZhuJ5ueM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-fjsbBxRwMPGEguvDpIcYEA-1; Wed, 04 Sep 2024 07:32:44 -0400
X-MC-Unique: fjsbBxRwMPGEguvDpIcYEA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42c80412dc1so32166745e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 04:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725449564; x=1726054364;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HikrecDzuQZ+HW3KJp4Ub7/bQnHaCS7c5CHmC+pqSGQ=;
 b=qX2M0G4aWAT2ATh48qX/1pUcC1ahdJja9FYsQ9wH2D5DDqjJRvqCf5lp/aPGWWmVKU
 SAuldgJliZF6yIzWgv1h0E8aoLL6zrBEpFbCdBdZ0DGMMvbTF+QB+x5HG3SEdlg3mANs
 fDKE+DlU3RiElkje1+WpWGv1FUbnb00YltmB4x/ARsjK4Bf0X0qp+xHroWItUSXmpqTA
 Akgi6lupRV+WmhBUyk9MkJLntGePQ2mWcy5huXQWGH8TyiNVLLIQ5/m6WsyijxTe4Ot6
 IKlIjahfEl1fy0Ev6dgt/dIDaYch4m+FbxmK+brMoScDUTlAwcOIoV6UG6WbAv0lELiP
 k07w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe2pXjEA2g9NURKwvX3K2EcTcYuMKs+uefBy8X2NjWHkZFyePfOk4vcHUk3+tJvq0IonNaBuTsKHp3@nongnu.org
X-Gm-Message-State: AOJu0YxPOyJ0GoSY82qPajqpTBj8buPrNbjiMddDGOfqNiEnmKJFlkJM
 L4vhVgTJ92h5vdtY+rItjfdzaR98CI6eF2fltMe7f7BdJYRAC1fcb1BdPq8VyEdj2RzbEatntGJ
 TJpVAw4qjP9dQzFu1C7RGh/kFa1PE6Opj+p7SxV2AHSQFndcand59cIJhjrEPZIL/GdhbdfjB4l
 akeZcwJGM2FuRq7214XA4h0okf1Os=
X-Received: by 2002:a05:600c:1c89:b0:426:66a2:b200 with SMTP id
 5b1f17b1804b1-42bd052b0f6mr102136235e9.0.1725449563664; 
 Wed, 04 Sep 2024 04:32:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRQXQvnJCUbRm/i4tPz9ykUbel9ixB1kEuUQHL6UCT9IKLQzmGoSzan5rcO0UG8e1HY2UscTVZQDoqELd7xOI=
X-Received: by 2002:a05:600c:1c89:b0:426:66a2:b200 with SMTP id
 5b1f17b1804b1-42bd052b0f6mr102135945e9.0.1725449563222; Wed, 04 Sep 2024
 04:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
 <20240828-rust-pl011-v9-3-35579191f17c@linaro.org>
 <Zs8X7dV4XczEM5YU@redhat.com>
 <CABgObfYL6ACRK4GF80vjY42sWire4H0SyN+oz+99q5oPjA_3oQ@mail.gmail.com>
In-Reply-To: <CABgObfYL6ACRK4GF80vjY42sWire4H0SyN+oz+99q5oPjA_3oQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 4 Sep 2024 13:32:31 +0200
Message-ID: <CABgObfYRNxhD8FAsTSwdvdQJpEyY+hE=jS2nKoozZVkx1Fp2rg@mail.gmail.com>
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 4, 2024 at 1:03=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
> On Wed, Aug 28, 2024 at 2:28=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange=
@redhat.com> wrote:
> > Defaulting to the $rust_host_triple is incorrect when QEMU has been
> > told to build for a non-host target.

BTW, this is why as of this patch rust is set to "disabled" by default.

> > Either we need todo the right thing and auto-set rust target based
> > on QEMU target (preferred), or we need to make it a fatal error
> > when rust target is omitted & QEMU is building a non-host target.
>
> I already have a patch to autodetect the right triple, but I didn't
> have time to finish it (and send it to Manos) before disappearing on
> vacation. I think it's okay to initially require --rust-target-triple=3D
> for cross compilation.

Done: https://paste.debian.net/1328408/

Paolo


