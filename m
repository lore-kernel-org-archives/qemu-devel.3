Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBE8C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 17:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbkRA-0001eq-KI; Wed, 07 Aug 2024 13:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sbkR9-0001dU-L5
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 13:26:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sbkR8-0005Ls-5A
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 13:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723051616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fHdSG8iEg4uS+0Sz/s3n8vWpM9yi4XCN7sVewjdqnp8=;
 b=HjGKWLXa9zU/siDfOrtyouFqHPPtiBMn95yLCca1A6MP2vf7/1mTCcgqyp7+aDw7OLx0c7
 xJJzse6cbcOf/RyK453pOJSo1ggb+YryVfDVpfQ8ZLGNqXz8+UY/n4r1XM7GzyBUw2+w4q
 q8KDPkxIDX2yuBgevFbf0sb3vulUwo4=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-UQS7voyDPYC27wF_zrWzjA-1; Wed, 07 Aug 2024 13:26:55 -0400
X-MC-Unique: UQS7voyDPYC27wF_zrWzjA-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-e0be2fa8f68so69849276.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 10:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723051615; x=1723656415;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fHdSG8iEg4uS+0Sz/s3n8vWpM9yi4XCN7sVewjdqnp8=;
 b=Y17ON0Vhd8E5wqHrxGmJxOhig9vH22tESMDihHRWQP8LmmePJS7524eJSqBFBh+qji
 1wlsNwTJ/3Q/JMcvuuYgLOhN3p7NpgVrbSf+NMlUuWrG/EHyv3H4qXKPyJIR5pRyckQ7
 5aP5TH6WcjWaoGI8s7E/FAF/Df38JrLtz7SZeKAtkRZY5xB3ZjkSNL5JEDzSLBuo3xr1
 Syj7JRotD3PmmGFZS9nFPZAhtzoJgISIi8ecs8CNqC2Y1DntpnVn4HAJ9npN3niAtr30
 8TRRWTFw6kPHMURaOEAJouXiDXttOMEhEWF+uXTrl55+JnHniWC7PwmrDNmUeeIYrPby
 WmMQ==
X-Gm-Message-State: AOJu0Yxbj/YxzEvL/GkcytfMBO+QS+IbxdQk/0CdpVT0bupRSwYlOXV0
 SDZLMa8+D6xFWAzBNUzUtG0cJzCilwEqBv/anQ7eQ2pKtPk4u6oAFcErOsOCw8S2PUo1Yy41azO
 fJUCWcHuFP0f2JOv2DV/k/tWQWG/X62RkvZT2xQ5tZ/lsSIFafK8wi4O/mTL6ECDmVXO+n6IgQR
 qDzp+CQn2y+PVkqbqT0WXOy7kWYCc=
X-Received: by 2002:a05:6902:1404:b0:e0b:6583:7900 with SMTP id
 3f1490d57ef6-e0bde4caae9mr21061835276.44.1723051614781; 
 Wed, 07 Aug 2024 10:26:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgVrS/gCmLskzoiySIAmIZmLty/hsAj4tce1KtsahwCZ1aWkzssq3u3XvD457tbYYRwRRDNR0kf8SbckRKCwE=
X-Received: by 2002:a05:6902:1404:b0:e0b:6583:7900 with SMTP id
 3f1490d57ef6-e0bde4caae9mr21061793276.44.1723051614380; Wed, 07 Aug 2024
 10:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240806173119.582857-1-crosa@redhat.com>
 <20240806173119.582857-8-crosa@redhat.com>
 <540fafc7-9044-4e9a-b2c8-2f2f04412b88@linaro.org>
In-Reply-To: <540fafc7-9044-4e9a-b2c8-2f2f04412b88@linaro.org>
From: Cleber Rosa <crosa@redhat.com>
Date: Wed, 7 Aug 2024 13:26:41 -0400
Message-ID: <CA+bd_6Ls00k4Wb9cfHZ87oNxb=y2AaRv+ibpR-bY9XPVg3SBiw@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] tests/avocado/tuxrun_baselines.py: use Avocado's
 zstd support
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, 
 Radoslaw Biernacki <rad@semihalf.com>, Troy Lee <leetroy@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, Beraldo Leal <bleal@redhat.com>,
 kvm@vger.kernel.org, 
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Paul Durrant <paul@xen.org>, 
 Eric Auger <eric.auger@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 qemu-arm@nongnu.org, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Leif Lindholm <quic_llindhol@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 6, 2024 at 2:20=E2=80=AFPM Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> On 6.08.2024 19:31, Cleber Rosa wrote:
> > +    @skipUnless(archive._probe_zstd_cmd(),
> > +                'Could not find "zstd", or it is not able to properly =
'
> > +                'decompress decompress the rootfs')
>
> One "decompress" would be enough.
>

True! Thanks for spotting that.

Regards,
- Cleber.


