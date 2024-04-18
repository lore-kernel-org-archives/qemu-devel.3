Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD269C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 12:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxQke-00028d-LT; Thu, 18 Apr 2024 08:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxQkV-000287-5l
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 08:20:22 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxQkB-0002co-Tx
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 08:20:18 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d8a24f8a3cso9529871fa.1
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 05:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713442794; x=1714047594; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V6dbRVO5l22jaDMVZgf+JMaBxDRGqVTS+Kl5b1IVopo=;
 b=Dd0XuUY6jpefvkW/rMw4xKcjM90nhwbWCb+fsQQjtQ4loIvEUQ/0+INVCLhnWJiOLD
 kURJ+wAE7+l0L6sOwWVXOLBCum1GKyh/IfQTmOk/Yg0C/h6tzYzFzx5lUkrFaAt9Uqz8
 nqLSwNn0Ac9EIVRTTMjZ4DbwvmA/C9Pr9BK8ALW095F15HFerx29A2e1wLqnj9FdnVKd
 0IRcDGrmgw4zGh6M1L5JnxrDoYTHv/6gRFTlNTUiUf4H1rHkFR2f2cwxDNKGxdetRfCl
 /N1mI57ZV9curJhREsIPVtNqCJlAgOn9QSOMinF+7M+8GF+16BQnaksf93k7JT1LqbVn
 kAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713442794; x=1714047594;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V6dbRVO5l22jaDMVZgf+JMaBxDRGqVTS+Kl5b1IVopo=;
 b=WptOy6VVCLDR2RQn1uadfGQPlX0vUOTeuu7tjFxt6r0yPTo2wEsiCQ9FVvY2++yQA8
 ZgHpASHZ7xXgN9IBA8qXjVkNFhyXJOyO+wC/ZjXfaZgM84m9S8ifJcKdkuBAsCC52N5S
 khP34fvUaTUNWMH0gK8rsQQwTjtmgVyccJwUDPCdpLKf23j9XabXnGp25vTqJ0AwjUbr
 ONE+y3FL64t6ePu9L3WS9H209terU7IxpnEnoxHiaxi3U5PhmJJa6F1MbIFm5AHX46AW
 v5IFYtIT6Y67YApMTBlBR01I20sbWuD1nhrezILvNO59C1GLPiW5/XmVVV0lj0IHylUK
 87dA==
X-Gm-Message-State: AOJu0Yx8BURAc2ZjbxkrMWxLH+Ezg3YUDaUnT5BEbF1Q7C2CPWszdsg1
 otXObzMKOoWbYTOtN84KmNFVaohgtptKMVgRDYDG6J0a97SFYip8oDt8sN9sb3KbUKXZqtgnSho
 bREk8NK9q+n9fcHJ61XQb9z58aF5k26psVp4En0SxNyPIrZLZ
X-Google-Smtp-Source: AGHT+IGTndAxqN6nCIzImYsU5YViT+/a4CuomsO2OtnyCB3P03m6ANO4Bj/3WFXEXZuqkCsS1w2c5kj6ajWznilo4Sc=
X-Received: by 2002:a2e:b0f5:0:b0:2d8:10d3:1a0b with SMTP id
 h21-20020a2eb0f5000000b002d810d31a0bmr1518119ljl.39.1713442793618; Thu, 18
 Apr 2024 05:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240113012741.54664-1-masscry@gmail.com>
 <CABH+J_76pW0-XQVUsJ+7faK-gCVaoa7DScDcdHmcZxdc25GC5g@mail.gmail.com>
In-Reply-To: <CABH+J_76pW0-XQVUsJ+7faK-gCVaoa7DScDcdHmcZxdc25GC5g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Apr 2024 13:19:42 +0100
Message-ID: <CAFEAcA_68NR-SV+4anovL3nx+VFJYKeT3XXFq0k2oSFAuHH1SQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix pointer arithmetic in indirect read for
 libvhost-user and libvduse
To: qemu-devel@nongnu.org
Cc: =?UTF-8?B?0KLQuNC80YPRgA==?= <masscry@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Raphael Norwitz <raphael@enfabrica.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Temir: yeah, this was our fault, apologies for not responding.

Michael, David, Raphael -- looks like we unfortunately lost
track of this patchset -- could one of you have a look and
review it, please?

thanks
-- PMM

On Sun, 4 Feb 2024 at 09:42, =D0=A2=D0=B8=D0=BC=D1=83=D1=80 <masscry@gmail.=
com> wrote:
>
> Hello, I am very sorry for bothering community on a such minor problem ag=
ain, but I got no response for a few weeks, so maybe I have started thread =
on a wrong mailing list, so I made an issue in gitlab issue tracker: https:=
//gitlab.com/qemu-project/qemu/-/issues/2149 referencing this thread.
>
> Maybe, it would help attract proper eyes to such a simple problem, so no =
one bothers in trying to fix it, albeit it lives in the codebase for some t=
ime already and is being copied around.
>
> Sincerely,
> Temir.
>
> =D1=81=D0=B1, 13 =D1=8F=D0=BD=D0=B2. 2024=E2=80=AF=D0=B3. =D0=B2 04:28, T=
emir Zharaspayev <masscry@gmail.com>:
>>
>> Hello! I have found a problem with virtqueue_read_indirect_desc function=
, which
>> was advancing pointer to struct as it was a byte pointer, so every eleme=
nt
>> comming after first chunk would be copied somewhere out of buffer.
>>
>> As I understand this is cold path, but nevertheless worth fixing.
>>
>> Also, exacly same problem in vduse_queue_read_indirect_desc function, be=
cause
>> as I understand it is a copy of virtqueue_read_indirect_desc with vduse
>> backend.
>>
>> I was not sure if element of scattered buffer may end in the middle of
>> vring_desc struct data, so instead of writing
>> desc +=3D read_len/sizeof(struct vring_desc)
>> have implemented fix with proper byte pointer arithmetic.
>>
>> Sincerely,
>> Temir.
>>
>> Temir Zharaspayev (2):
>>   libvhost-user: Fix pointer arithmetic in indirect read
>>   libvduse: Fix pointer arithmetic in indirect read
>>
>>  subprojects/libvduse/libvduse.c           | 11 ++++++-----
>>  subprojects/libvhost-user/libvhost-user.c | 11 ++++++-----
>>  2 files changed, 12 insertions(+), 10 deletions(-)
>>
>> --
>> 2.34.

