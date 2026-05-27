Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1A3CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 15:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSGQ3-0002gU-I9; Wed, 27 May 2026 11:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wSGQ1-0002gJ-S1
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:43:41 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wSGQ0-0004e1-FK
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:43:41 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6896c80480cso5710217a12.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 08:43:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779896618; cv=none;
 d=google.com; s=arc-20240605;
 b=TYYaSE70XLgOe6ALm2F5+HuY9vjeJgk3W3S2FjRsMcbOBfUDZuH6FTf9pFO7FEqqoZ
 i3/pcd5R58PcZb1CYbRNfvqNcPfeSMxmjgh/LtoJIUfE3zyL7gjtoAzy/hwC5BHxO0YM
 Uztetfyow0aLsBNf/+sDhqKRgKMVoTVYJTg1BZ5eDoW+Gex4PoYZv0ki/RHC2KqED7ai
 rY1VgtPRCVUPonKyzPBXlDfMHPHvakXeXNPH20BQn4JJ63J8f0DZVxz8Ij/ZHqMkv/19
 y7dGKFNjow0XxEXZVG29QEkKW27F/19cdpucAgYF6ZaG2Y4vFbejzculys/Oo7oqVDg8
 WcWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dG8YWXjS14eiD8h3cTh2p6N4ejHlEgB+79d4FU9Zg4s=;
 fh=gcc2YlLBZz1AnjBLUuqMEYVPvFIGBueb78Fme0j6+r4=;
 b=UQ5QUrMKmENntu9rdtNeVO5FIKAFGXPwpCRszs27ih/YF0e5FwaTr5xeQh2DzBclTj
 OZ8OebN/xU05p37wAzYGwyrICTIMlXAYtOXAmIO0817xgFT7aEabuV5i+uyxoS8Y6pAP
 MJ0SfsJF2/MUSgwlXrsbC9yMwwQMnBub6Lvunn60wNgeomlCynqm3uGRQRLIqdHb5fBU
 XyUvQyiNTgiqDWHZK7jECnBxa85ITU4om6NTM+Iuk3NWyrKfxts9y55yCFyYVspibWBb
 N5q6TZ/SbA36g9pSpY480TmCljVuG1IdFleyR+ybpoL3iSiH8sZNxtgUiy6YHcPTisn6
 l0Mw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779896618; x=1780501418; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dG8YWXjS14eiD8h3cTh2p6N4ejHlEgB+79d4FU9Zg4s=;
 b=oi6c6cNqlbKVDgr2ycc6ZDqxZ1XmSbGKOithVH/iTwubTXAzqiLxsVVf0igYlmBDlY
 KdWra0j1sJiaZcmIg5JpJzn5EkgwiaWYBUTE6VLcEjQmGAf98jVfeIB3ygEhR8Fc303V
 l6n4rhp9un0ktk+Sd6DLkuXDjVVO5nWLx8ixRy5GTXm3X0eom+SA1rdqaFUuReg2Aw+e
 zDomYWzC+aPfkJ2ecDLlrqo9dvF4hYXAmDODA7TcS/8R/YMfyo/YItO3sBJ/DQNZRdhg
 srDPvEMNXmNZTRnHNQIOQSjOv8zfLEDCHqWFxiHscJopBYDQrNwwCsbrKILwhUUvEvOD
 Kn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779896618; x=1780501418;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dG8YWXjS14eiD8h3cTh2p6N4ejHlEgB+79d4FU9Zg4s=;
 b=acLMyNUMk6EZm9cRo6nFkewyEoqA/O85mN9+K3FvataBDuPP0FKCp11YIOMq9ICReR
 HlrDjKNMbQ7gM8yrkw+HVW3+LcC8YjiRS3IlNi+mWDTqqBFp+eD5nWSw1dZcSaqq5Cr/
 FS84D8auqkHVRk8LcPElWmp3mD4Pjd2tndaek493hIAPWZidKepO4aHLUlIlUClxDJA6
 hPoGCT1+7sTXZYs2l/l4BPxqj7YUlvCD+vmabeV6pi2huCWImCP68FcLqU3AFPpR2RYh
 t435tu4rY/yqbjXn9XhqqluOzhRaJpA4yw//R6LggHCyxUO7cH686LzecZLSWh5CLKcN
 eQKQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+vqgk/tulI2omRIgZa8IJxE91HAiyxRgOi0D0GoqcKHRmgZ0aybtTZZY73D/YQkyF5jX0l7rayk43H@nongnu.org
X-Gm-Message-State: AOJu0YxgRCra8kOWgns8v5yEJw90cnisJVfzBxxkW77yrjBz8F2XPgGn
 uTKCcexrA/+DbaO0YhuTg4vqyUh8UZWVMd2ZUt2dSKwSNFcqVXiAwsNfKuKwJEWie47AsCjqV2w
 17DjxBX3L6hrAR/xh9h7grRH3oC6qwT4=
X-Gm-Gg: Acq92OEAFVmEovSZ3xauG+DsyxOGQ6ZD8uB7cZj/4SfIrKcsEl/UA17TMUl5KtPZsTd
 yGx8uNQr2Ifjj0QK+drp3HiUN+e55492ffiqpeTbroCvvzNHGtq3FRIjTRstLWGnvKYrp5NigVc
 VE2OVCuxXP24xbCthaZEHNJajweV9uEHoQ64mXVGEbqJH2ofdN/9Kvi04h1LSGyayXxgB3qxfus
 2cecX+rWwUUNNef9Qe09lSO6S0piGrDg0N1z+L2TlczZ/j5CaK2qdgEEwy70AZx7XAj3AN78ex9
 6LdQUiunLNRj4FVjxxZPClDhu8YNIt4LlI+NHuCvLdXwAVWOV/hF
X-Received: by 2002:a05:6402:5110:b0:687:74de:985b with SMTP id
 4fb4d7f45d1cf-6889c476ecbmr12976081a12.14.1779896618222; Wed, 27 May 2026
 08:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <875x4fmzcv.fsf@draig.linaro.org>
 <96181e0d-4c75-430a-9b80-9d8d0eabcce7@gmail.com>
 <CAAjaMXbFhtiHgiUwmJFXti25+vXRebjtaD6fFD+GkOHsDny=Bg@mail.gmail.com>
 <878q961nkz.fsf@draig.linaro.org> <87mrxlgt6u.fsf@alyssa.is>
 <87y0h5xl7h.fsf@draig.linaro.org> <877bopgoxe.fsf@alyssa.is>
In-Reply-To: <877bopgoxe.fsf@alyssa.is>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 27 May 2026 11:43:25 -0400
X-Gm-Features: AVHnY4Lm3VINJ7rD6J-nAN79YA3XeypUosbmn9oKm0X2lwODfYdExJDbGYO1ZO4
Message-ID: <CAJSP0QXXzMTav3wXgdsrY_K7kj9-P6C0E2LoCqQS=BpNJgT-Mw@mail.gmail.com>
Subject: Re: vhost-user implementations
To: Alyssa Ross <hi@alyssa.is>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Demi Marie Obenour <demiobenour@gmail.com>, 
 Albert Esteve <aesteve@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Eric Blake <eblake@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Auger Eric <eric.auger@redhat.com>, felipe@nutanix.com,
 Jan Kiszka <jan.kiszka@web.de>, Joao Martins <joao.m.martins@oracle.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, May 27, 2026 at 5:52=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
> Backends
> --------
>
> =E2=80=A2 vhost-device
> =E2=80=A2 virtiofsd
> =E2=80=A2 crosvm
> =E2=80=A2 Cloud Hypervisor
> =E2=80=A2 Spectrum's router
> =E2=80=A2 DPDK
> =E2=80=A2 SPDK

- QEMU's libvhost-user

