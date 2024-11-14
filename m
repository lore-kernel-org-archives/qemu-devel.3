Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D841D68B0A
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 13:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBZdc-0005wi-C3; Thu, 14 Nov 2024 08:11:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBZda-0005wW-BR
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 08:11:54 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBZdY-0004qk-7V
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 08:11:54 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2fb3c3d5513so5469141fa.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 05:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731589910; x=1732194710; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hfjq+nL7BtAaZqLIbSQqn/Jrhwp9S2vnthD48cz0pmM=;
 b=TEDKUVUiNwL2Gv5Kh0FDACfsDdhDf+3javp+fOtV2/BFMrmRTbzfFcsrYwvHkUn8yX
 Q8meO3sa9z46YeZKOt7njECsBlbg2SOnliHiJP0/zvGVtpsZaErNS3zHRWEZgR7gDeWh
 KFN7CXDY+mIH/PtHzbFyPe+m1B2UvLaxGvafBzGOLammIkqzv1l0TA/xT4KFp7vAbsjc
 Dp+kHYUC5Bvh5r5/VYcZZ3g89+m8nwNeJV9VFKjtEZsQFusqeBIbz2r97LzBA/C0+RHN
 4WVojo1XsR+X1gTMPVSf1GwLRgqVBYaGCHdjLP4PO1NW8tNG2rLK3DxfBHWY06epz4mp
 MrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731589910; x=1732194710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hfjq+nL7BtAaZqLIbSQqn/Jrhwp9S2vnthD48cz0pmM=;
 b=e1VstUSPwfIcKFgnAvv8apY6loYXe8rpgJypbPWjP2R1tAtyxdl9Q583Iqs2PLmzfW
 s8JBTR+A7e/Uuu9uiYQNLmvaY8amCRuRjsbPL4WA4vcputsSMrgcA7jpQ7fktjAdqyHg
 vLBk7UUvWLEUHJn4e2S3ssae2oP25vU8bH17n9jOq+D/mmqAF/QYZN1wLNLxjE65Hhah
 yQmHb8ziWLmQ3VKeFO/rwZtfriSpMjndIgdaFZYk13yjmj0BzLIlAO5bLcR266gyeW+H
 8rr3ep+TajsXefZe3W4AMqxf0k3FB4Jw4j9b+ph5w9un9lVG4+KVcqapbNwTxOww6WnI
 97Lw==
X-Gm-Message-State: AOJu0YwZN0iJBuig/mQkHJts2f3DGdGkiNXzwp/51g1h+f9WxTG9bxyV
 LITq62W4vtIjzEYvXbtwj4PcxqmSAaE9zvvVGCTlaSOyzw7myaMOm9BVaj2aQ1+PU6m4mwFsL4z
 m0bTVRzcmeEeVLI3InaKac3xPQwRi6JCocVGaMyeDTLVYuZ8N
X-Google-Smtp-Source: AGHT+IFuC/di/tAeX/rNiyQUX8bzxlWLrCBavyY83EmU/7Ot8bFqlGeSz5BCv4dmvGQmsNljQpEzqCbKcRdHkbr5kSg=
X-Received: by 2002:a2e:a582:0:b0:2fb:8c9a:fe37 with SMTP id
 38308e7fff4ca-2ff4c5c1d7dmr36796171fa.16.1731589910064; Thu, 14 Nov 2024
 05:11:50 -0800 (PST)
MIME-Version: 1.0
References: <20241105083203.2230983-1-marcandre.lureau@redhat.com>
 <CAJ+F1C+JTfhgOFw_4oOsOPA-JbYPQh7P7adp2EkOFY_JVpXBvw@mail.gmail.com>
In-Reply-To: <CAJ+F1C+JTfhgOFw_4oOsOPA-JbYPQh7P7adp2EkOFY_JVpXBvw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Nov 2024 13:11:38 +0000
Message-ID: <CAFEAcA84euon8uDXOkF3F9BDJC5M7WZhY=QnT0zQ+J_AB=VR5w@mail.gmail.com>
Subject: Re: [PATCH] hw/audio/hda: avoid unnecessary re-open stream on
 reconfiguration
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, mjt@tls.msk.ru,
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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

On Thu, 14 Nov 2024 at 12:57, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi Paolo
>
> Did you see that patch? What do you say about it?

I think Paolo's patch seems like a cleaner fix for
the leak than this one.

Incidentally, to recap something I said on IRC: it seems
to me like part of the problem here is that our AUD_*
API doesn't match up well with what the Spice audio
backend in QEMU needs. Specifically, the Spice channel
(if I read the code correctly) always uses a fixed
sample format and frequency. So even if the guest
reconfigures the audio device with a different frequency
there's no need to tear down the Spice audio channel.

Awkwardly, our AUD_ layer APIs provide no way for the hda
device model to say "this is just a change of the config
parameters" -- all it can do is AUD_close-then-AUD_open.
And at the Spice backend layer there's no way to tell
"this is an AUD_close because we're really finished with
audio" from "this is an AUD_close that's about to be
followed by an AUD_open because it's just a config change".

Even if the spice client end ought to cope better
with the server end closing the audio connection, it's
definitely not ideal to have a close-and-reconnect
happening multiple times in less than a second
(which is what you see in one of the logs provided
in the bug report).

thanks
-- PMM

