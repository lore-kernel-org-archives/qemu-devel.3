Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B688CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 13:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRrkQ-00040M-DH; Tue, 26 May 2026 09:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wRrkO-00040A-UP
 for qemu-devel@nongnu.org; Tue, 26 May 2026 09:23:05 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wRrkN-0000dW-4t
 for qemu-devel@nongnu.org; Tue, 26 May 2026 09:23:04 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bd6460b0d11so1857296766b.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 06:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779801781; cv=none;
 d=google.com; s=arc-20240605;
 b=OJmHjfHztoEvdRB7XHbFs0fXwrFzDVdFcRREf12yHevmyixtJBFS4wp0hFgMQK5YY6
 MjOOlhyt4em7E7mC7/rA+USeuW3cVnkx423hcK2eJRm2rS1bX9HzNeK07LiTZehSvn4V
 T+akRHgH3Gk2AEoaamF5eLh2ePEg2Gxb5d8wy2Ii1SYHvmigJmelfUdW96GBw8qpbKpJ
 LRFc3E0lGh4FDX2jDiiSQ00CzMykkCfU0pxm+JJwGY3rsRUrJsjfGW/pLBa7vowL3eOW
 qp9Cw7w/vHCOn145k0ssWL9hk0qsAI5Z2+4022PC309W2bJCRLTN+qR/NZ5AKBsJh6C+
 +4bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wM8+HqMP83uwX03OBjf8Pjbtv7j0XEsdhHWbb4v6MYw=;
 fh=qsdNDVjRFhetbPwfelUksp9m6Y//Y7oZPgd+roJVTtQ=;
 b=OHBhGrMRMeXKPVfE5jE8YOU0VfyxDNLljJpWAJfaAVPI3kODa/eIsKS4lhMYuI0+Td
 vPvY1U6/z6EsHQgpRSRXG8ivvf4cDE5xTe8u7DoPebqsMGuxsLB37hHI9Ljkn7am9mw0
 PwiC7Q6K5iY7yhsR5BIBpkIiF8CPrygvY1pmldQTHOF1VvR81TJOUoxoWJvlQB2ayfbB
 aEGsZPxGQvVI/0JYucVuXWY4outsAbLwvI1MpuzmbLBfTGG1pW+R8Bm0p3QUaCUIj09x
 DWUS4h6hLa5sxHcGDWo0YudPdIMh2yZMMP7Rf81w1vXlAE+xnJ/dmM1PNb7gfu2wPnBj
 0Cqw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779801781; x=1780406581; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wM8+HqMP83uwX03OBjf8Pjbtv7j0XEsdhHWbb4v6MYw=;
 b=UJTghpkIqnRHBoaHdIz24K2hKY7VaVqsV8T7CbSpb1vNMdeqqB6Pik5VSdBLZl8dTS
 zR1FjYLoXVfCITJg/o7VK4y9xPUpeJp1NUwrJoBPSXjOec8dsXUp995X8PQpQzrYoymD
 QQKBzip/05dtSGtnqc5MOO6YIytb48tyr56NEwPJacmagNGN49g1YgvyyOMO67amZpnq
 vzd//vzlXEW8MhCBZcEvjFg2x6XRtyZfBzMiD4jL+xb8kyMJlFKU89ioBRx2fcHtCiYs
 1JTwbzycbpbskbBPXrJ5fuw4ZnQ1x+9P7GledOqLSoXTEbbO20/EvBnhIvyJNztyKIHX
 AFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779801781; x=1780406581;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wM8+HqMP83uwX03OBjf8Pjbtv7j0XEsdhHWbb4v6MYw=;
 b=nRAm4EEPANfA45JvXWMIvyCO5yOrVBHq5XZJs2D1jIJujpmv3eXCfRA9A8aku9+V1/
 xpawraK92/KUYZMu+TcR+CkqWcgatHRa/W6Jn0FoZK6lxjIYrrilMIEfnBTFhzSfC6zj
 ScsZ3oTSF1J9p6MEz5NWIdSF1oZp0AuR9xPJc5kY/fI/TfThj08TAUCj4qKTDXRLlntS
 bclQeH7qOSqYJ08c1mgL98yE/NOeJh2duWsqPiAcPNFPr4nIcBhy09RIHpPsZ2BQ6i7s
 GVCTV2ByMirRbLlKgOKmTxRp4HTD1MFYqiAZjxqkcctGKpSuZ7h3OFsBdhnbXx/0x6Sn
 09ug==
X-Forwarded-Encrypted: i=1;
 AFNElJ/z8D5BBqqFXdqwTyxYPC6BIeJ36PeilPjUNOAj7bft2NwYR3BGgP3AN+6HgZbSM8gmZ5ogCJrUPqc+@nongnu.org
X-Gm-Message-State: AOJu0YyumBt6USf+bDdHyHYKAIUUECHkrLDSTl54ThrvlcHrnL3DN5pd
 /mAufKyRkfXGiAGBcMI6kYEX+/vb+617XbCls6jusslssURCdpgFdsTIo/VoMRN5hgdjypPcung
 g1GmT+U7m2aISjVOVPc4uvcbmPUs+ySI=
X-Gm-Gg: Acq92OFK6JKePNLCwCqC4quAPEwUnEwov3nehnneTHuGjNiW2GpOMnUVKK68K/k/qTK
 6Sv4u9fp3B6xGp/DzNVslvYau3c/H0EArbP6k3oUkbYawDuS+7sRmdB0X3d2hd53ZVpVtD4wTgE
 S7bdH48NEzOzcYi0yI0Ag3LexFIBS9/A+aERttKOJnl79vavxDzUN3A/07yl6bziA9HEZ0sTXTc
 IHRFLE1SnvfSzBrRfXugvxqzxqB83Jdz7jj/N1OLK8NbZ5394UyvV5oejUMV0xxPxEzn98kjat+
 K0R2pJPFFtuM+vQUIMRQhEy6nExv0trrIm5EJV9Jfw==
X-Received: by 2002:a17:907:3e0c:b0:bd4:d0f2:67b4 with SMTP id
 a640c23a62f3a-bdd25fdcb0cmr1188135666b.34.1779801781250; Tue, 26 May 2026
 06:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <f0bc9023-28c4-4685-b0cc-fc7ad4e6d371@redhat.com>
 <CAFEAcA9wMRFJWrjGHcd2nfhgXovyuS=dDJvCXWZkgmD_eez27A@mail.gmail.com>
 <CABgObfYSy-sctHcUW3hPxQZ8ZGOYHLi3HaW+FrEQ9kKitMAVZg@mail.gmail.com>
 <e875fb45-9697-a6d0-fbe0-d0531eb2c911@eik.bme.hu>
In-Reply-To: <e875fb45-9697-a6d0-fbe0-d0531eb2c911@eik.bme.hu>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 26 May 2026 09:22:49 -0400
X-Gm-Features: AVHnY4IZwmRV6l4ve8ieJokpfFCGB8bc0SIRZDGC1sMvRVoxAWWYOnvEOL6nC_A
Message-ID: <CAJSP0QWt_xB9a7UG3nved=m_5-Qmxy8qeAofh4c1M3a6qJanMQ@mail.gmail.com>
Subject: Re: on ai generated and code provenance
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 "Hajnoczi, Stefan" <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x634.google.com
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

On Tue, May 26, 2026 at 7:28=E2=80=AFAM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
> On Tue, 26 May 2026, Paolo Bonzini wrote:
> > Il mar 26 mag 2026, 10:23 Peter Maydell <peter.maydell@linaro.org> ha
> > scritto:
> >
> >>> Personally I think QEMU's
> >>> policy is fine but we should start introducing exceptions, possibly
> >>> including large contributions with pre-authorization (but not
> >>> pre-approval) from the maintainer.
> >>
> >> I want to note that [...] while we were essentially in the "blanket ba=
n"
> >> state anyway, there was no particular need to have the discussion abou=
t
> >> other reasons we might also want to be restrictive or cautious about A=
I
> >> contributions, but those other reasons and viewpoints don't go away
> >> automatically with the legal one.
> >>
> >> I have quite a lot of sympathy with the rationale behind the Zig polic=
y,
> >> for instance: https://kristoff.it/blog/contributor-poker-and-ai/ I spe=
nd
> >> quite a lot of time reviewing patches for things which are features I =
don't
> >> necessarily personally care about. I'm happy with doing that for other
> >> people who are hopefully learning and gaining something from the proce=
ss;
> >> I'm much less interested in reviewing a mountain of LLM-generated patc=
hes.
> >>
> >
> > I agree and that's a good argument for pre-discussion with the maintain=
ers.
> > It would anyway be the right thing to do for large contributions, but i=
t's
> > even more important with AI given the different balance between contrib=
utor
> > and reviewer.
>
> I think the real problem is people who don't know what they are doing yet
> use an AI to generate a patch and submit it anyway. Reviewers are then
> flooded with nonsense that they have to look at to find out if there's
> anything useful in it which takes their time from doing more useful
> things. So the policy should make clear that we don't accept patches
> generated by AI that no human has read and understood before submission
> and adding a S-o-b should also mean (besides that the submitter made sure
> there's no copyright infringement) that that person has knowledge about
> the patch and is willing to correct it. Then reviewers can just bounce AI
> nonsense back to the conrtibutor or ignore it if they don't reply (or
> reply with more AI nonsense suggesting they don't know what the patch doe=
s
> so can't correct it). I think that's the real fear that has led to the AI
> ban and the copyright issues were just a convenient excuse. Maybe
> clarifying this in the policy could be done although there will always be
> people who ignore documents. So maybe what we want is no direct submissio=
n
> of AI generated patches without at least a human inbetween who has alread=
y
> reviewed tha patch before sending it to the list.

That sounds reasonable.

Stefan

