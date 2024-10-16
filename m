Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811D6D2A521
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 14:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t14uJ-0001vF-U0; Wed, 16 Oct 2024 10:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t14uG-0001ud-LG
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 10:21:44 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t14uF-0001qF-6H
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 10:21:44 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2fb470a8b27so9111841fa.1
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 07:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729088501; x=1729693301; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wW9lUFzKP2hx4lqmNR1ouK/qv/+WFIaZ2VkUqsUiAHY=;
 b=HmhmKJUgyFYIu65jLJqubZVj9F31Qk8xM8/7WzDYs/Exzomg+4KEmMHZN/Qxqt87a6
 gH2Rxyin+3DLyKMi3yyVAk13t/lcGBAvrQUMjybYbEQhieneUdzbgAiuUyPO1yKAY6Vh
 +EHNaMN34bvVY/YvgH/AoL92WUSE70raxGBsvjbrl4/Gx6kgFdjO8dqTqEVmiKmxpMHY
 wxnE0d6ld8dcCXdkdi9ShY7e/HPHyGZHOSO9E1qObkP/+An0m8WzVavGzmC0BpEpBUBe
 WrCkZRNuKmtP+AeJX6fYceNnH7QlLc3ZxxxI3jmhUl/nZ0IPF/TheXyC0399zRdlrEGW
 9EZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729088501; x=1729693301;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wW9lUFzKP2hx4lqmNR1ouK/qv/+WFIaZ2VkUqsUiAHY=;
 b=bAfCTFLsn8lq/xWHFsoiSY6nhLl8aQnZX8n7U4prsWde2IM2oN1OfIF1ePa/7n+3co
 ec/PqPe0+yLujBD2TkDm9Bg7xhHoFAbSbBXS1ar2HKYT5ZbmPQ3hme7/LNC043XEJQnA
 dCxzjn9vb2GHD3lh/7VqmakADuv7sdZRokpuBERqLTo8oSHKl4w9vZk6QFyaEiuBqGc0
 JsdVROixsO7+T9olInR82BD11/gm0GXWOQS4x4LC3AwaL9669/atAAYJGDrdqhZ4ZYUH
 mqgxUQYTPdEOmT7KCrQ5bXxi7REoP8MpkFG8Di0v5ZeiKCB0lQFFtLDuGTEPhYf7gFO/
 TJIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvSq7sP+h9MKZZiNIAp2Cta709TCJW0u2MsCU7RIycII1zPWDrL3eEQ4YPSIhpkjdoPvC1itgDEIKJ@nongnu.org
X-Gm-Message-State: AOJu0YwQx+uE9vuAlCrqE6UdtaQI2t+RX3wCxjQbDluN3CXha+7Tqcnj
 vTvHZaf7mX5Exb4bvXxheldudAdRuBk0mTfqarO81A9DXFaZaxrAaglW6V37VK7776T4hSZQ8ij
 8sWLoMFZz/8++FNsm4bwzwzrGSYQ=
X-Google-Smtp-Source: AGHT+IE7mfJ+HmRFFIfO86K+tjMR5pTMv89qSx4an8GXaZGrp+mVdPzzjc2sTTMfs1UdIbMr1zootjhkxUyGvJeg0Qg=
X-Received: by 2002:a2e:b8c7:0:b0:2fb:4a15:6112 with SMTP id
 38308e7fff4ca-2fb4a15633emr44044891fa.4.1729088500045; Wed, 16 Oct 2024
 07:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20241016102605.459395-1-r.peniaev@gmail.com>
 <20241016102605.459395-7-r.peniaev@gmail.com>
 <CAJ+F1CLkn2WcmJEmNpJwNcc5VPriDTdSFWcv44QWaYtvHycKcQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CLkn2WcmJEmNpJwNcc5VPriDTdSFWcv44QWaYtvHycKcQ@mail.gmail.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Wed, 16 Oct 2024 16:19:32 +0200
Message-ID: <CACZ9PQXdcEx55U_7xK2gtWiYS_7U7o2eHkkfy5XsFhB7uYEZ+w@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] chardev/char-mux: implement backend chardev
 multiplexing
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=r.peniaev@gmail.com; helo=mail-lj1-x230.google.com
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

Hi,

On Wed, Oct 16, 2024 at 1:14=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Wed, Oct 16, 2024 at 2:29=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.co=
m> wrote:
>>
>> This patch implements multiplexing capability of several backend
>> devices, which opens up an opportunity to use a single frontend
>> device on the guest, which can be manipulated from several
>> backend devices.
>>
>> The idea of the change is trivial: keep list of backend devices
>> (up to 4), init them on demand and forward data buffer back and
>> forth.
>>
>> Patch implements another multiplexer type `mux-be`. The following
>> is QEMU command line example:
>>
>>    -chardev mux-be,id=3Dmux0 \
>>    -chardev socket,path=3D/tmp/sock,server=3Don,wait=3Doff,id=3Dsock0,mu=
x-be-id=3Dmux0 \
>>    -chardev vc,id=3Dvc0,mux-be-id=3Dmux0 \
>
>
> I am not sure about adding "mux-be-id" to all chardev. It avoids the issu=
e of expressing a list of ids in mux-be though (while it may have potential=
 loop!)

Loop is a good point, but actually can be easily fixed by forbidding
the use of stacked muxes and a reference on itself. Do you think that
would be enough?

--
Roman

