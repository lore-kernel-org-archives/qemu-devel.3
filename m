Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AD7CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWyk8-0003xh-VR; Tue, 09 Jun 2026 11:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <titusr@google.com>) id 1wWyk8-0003wl-3m
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:51:56 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <titusr@google.com>) id 1wWyk5-00070x-0U
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:51:55 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5aa62bd04fbso30762e87.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 08:51:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781020311; cv=none;
 d=google.com; s=arc-20240605;
 b=RsH/WLFvw1Pk0s99gNF3EnkCyc5dIz7OBa1474Uwwfmrchqm0DcfT7aG6qC1Hka+Is
 qaW2nrQ3jIBxUUgDfV5iTAloQqB/XjjsZL4FFJldEe8V1rzngiph5ZE8FzC65JiFxYlY
 lnRCsV2Vh81O4EloU6Q5MzVdVu1Opk82YzhJZ8XVCD+I2Wq7a2Mp1Apr0N7f2H820HU2
 sADG3RgI7O/Gg92Vj0kQciL3cGZM/iAU8NNMnKfX+kx0mnGfi54zLVN2DqsJM3zcw/Ka
 Uyo0ZGU5kODApE89XaMaJK1LADzvRHwwbZuCHC/W75M0A6rd9HuxdVizCSqFXlSHwktK
 fEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wNVM8/XIQ+GMp2Km6P124CqDPpvEiW+D0aQeKgN3Az8=;
 fh=GZ4mKLDmqDtqJtf7iD6uEuKA1Lm/eILkcjqcU9S6Qvo=;
 b=W6AP7allulnWAlhVBoMeOemlvnt+HIXixjiVrOilauZV6rtSebUJMSOZFEP7qZRbPC
 ar72FiP5TrJoFAeYjFdmBg8VltgbQSMP0ADsYCo0Zss8g3Mr8MCxNPNPyHHL6XOQDtFs
 KuOlMBwF7zJnWGjNNZFHWjEHjEmjuBSeRxOq2J3OwU3xdYHYNOHmC8WufRpqYvsEM+Wy
 bmDreaYF3hTbt1H82/zOJrd+IF5IuPutfFPFGTkS6epB8RnIY1lGVO0gKqgmvGCnt8ZU
 NQYsfWszWrv/vu4iLAjN1c8krjWmmA5kkqdBqTFKsM7nsze88Rdf+E2CQsT07SI3UVDW
 uZcQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781020311; x=1781625111; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wNVM8/XIQ+GMp2Km6P124CqDPpvEiW+D0aQeKgN3Az8=;
 b=OteLEIbV8juVlw/RPBoJOAsAF+aLOIsDIlV9cDniJbmZFze1L+6Xsk1tdib0Sp2yHq
 mwQPFQgPTPAHT87Uc09sTy5Jblmm0B9wy9qTzAbwCxqG06B+RPfsiEgvHsvKbMFv6IRb
 VdTehG7ed44u163Tu75pm7sK+7QJ3EhBiZ+bqQlaOs814XJVmQ5zlRFRk2ivRx8gB9W5
 0OAqN96UdzGWDV50I6HmKgF/3HE7YqH0RrwcIW2/YNMdGqRozZilBj0dTQYAtWJsE2uB
 S8pjMas5enBEnZi0N5JMG0JAuB6Rb9lhMtFn52t1CRcfDttNfe+SyMswAMMtXCGEOeEM
 JXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781020311; x=1781625111;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wNVM8/XIQ+GMp2Km6P124CqDPpvEiW+D0aQeKgN3Az8=;
 b=eRZ4WKflM8ag+dkHUlVkdcxyrd1ihxuqdOPJyDj6IidODjuAK2/YqVlL9GqOakS3qR
 3AJ5nwSuc3iJuMRTTBeFX1o7M0/Ydo9KSLfpZ7Cwb1qrXx84nSyGIXPrNHWMbfHnOlSb
 qwb9nH6vEonaIWlT5roknpNZJYSwaBiR1peGc7vrB7Z42bhutWJBAuIkA50cSA9wua07
 rHpjMa/1EGvVtkBDaZ6DZDc8/LWHpK5SwOwdLn9zziGXf0BQFBc5MX7fBoRje7PurrOO
 rFf5MYkgmttCXJzNOLGgjL6SJKGl80m4sC0mPsI0yuIM464+6VpPSSv+0V83irBnivB/
 H3Vg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YlOJZO0Ce114y0AXX6M0dAb01bLHYK3csOKhgdbvX6alqhmcMwACIm4CBEODXXKPZ8ltFny0gXGm3@nongnu.org
X-Gm-Message-State: AOJu0Yz6t6ASxwyowOm2NbV/dHud5IZyZ7Gs+f/XK21mAlFfHnTgPqF3
 DN0S1qyHspYh7lV+hbg8l6StyFZRt1Y8Npi7fHjMgnie0UcsM1qPQtJlbXtp1QB9tz58XA2lTm6
 7mPexvWXionokB1q2isiBhYGr+f3JJJ0IYsA41i3s
X-Gm-Gg: Acq92OF/ddR9niaNdLm4k370dcxt8acVD/JuKBdpAgEkDM9UytIM/IMykjB4oAH8nR5
 1Am053iFfXMP2YhEiMstnGjBrGz9ZLnfkgHtZwWnh5OVD2i1LlmlFcvosYLNXElv0mMiRG1MEd8
 FvqQkljSOZzuloX2wLG9KWhXYVk2k4O6lEcmorrIYvRH8O6JAoxAAwUHyqpsx2LHh89aVPWedLj
 ZI9FqyZu7OxAu1vikAaxl8HNtC6yrf43HtYFSMN++Y97gVCpKR6cbi4aTcxRqSe+XKbXWgck70a
 w9ZM+ymGmjtqq0A3/GINQIT4G/c38sY6V750sAi9F0nhiTj+kQ==
X-Received: by 2002:a05:6512:23a8:b0:5a8:73f1:4099 with SMTP id
 2adb3069b0e04-5aa8856cd45mr731268e87.0.1781020310309; Tue, 09 Jun 2026
 08:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260609105626.1038690-1-thuth@redhat.com>
 <CAFEAcA9O6b02VMuto8VzaEsVi3zTqNtQKG_RcMaPnNdPXGUBhw@mail.gmail.com>
 <CAMvPwGpvpHD+Sx-HZR4FFMJB+W8Rk8LoU0256Q=vwKAdC96HSQ@mail.gmail.com>
 <CAFEAcA9N_O7RZRU+SPTfB_ePasjVZvUsFPhndfQDuHgQ+4Q-5A@mail.gmail.com>
In-Reply-To: <CAFEAcA9N_O7RZRU+SPTfB_ePasjVZvUsFPhndfQDuHgQ+4Q-5A@mail.gmail.com>
From: Titus Rwantare <titusr@google.com>
Date: Tue, 9 Jun 2026 08:51:13 -0700
X-Gm-Features: AVVi8Cdai3kcd1rD-r_4IKxs0gsOerSlPqiCRzTaBqR3URolkh9sVOzU02dxeO4
Message-ID: <CAMvPwGpzAcDxeqSvQmOjzkQn6T91CAmTO31bNs0wmSMqQKG=Qg@mail.gmail.com>
Subject: Re: [PATCH] hw/i2c/pmbus_device: Fix a possible crash when requesting
 too many bytes
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=titusr@google.com; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

   On Tue, 9 Jun 2026 at 08:25, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Tue, 9 Jun 2026 at 15:52, Titus Rwantare <titusr@google.com> wrote:
> >
> > On Tue, 9 Jun 2026 at 04:01, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> > > I had a look at this bug earlier, but was not sure that this is the
> > > right thing. What happens is that the guest does something that
> > > causes the device to queue up data X ready for the guest to
> > > read, but then instead of reading it, the guest does another
> > > "I would like data X please" action. My guess is that the way
> > > the hardware handles this is probably not "add the second
> > > copy of data X after the first one". Perhaps it is "drop the
> > > data the guest didn't read, so the next guest read gets the
> > > second lot of data, not the first". But maybe the spec really
> > > does say "you can do things in the order 'ask for A, ask for
> > > B, read data for A, read data for B".
> > >
> > > I couldn't conveniently find the pmbus spec to find out what
> > > the hardware is supposed to do here. We need some input from
> > > somebody who knows about pmbus.
>
> > Queueing reads are an implementation detail I decided on, not part of
> > the spec. How the data gets discarded is up to the device
> > manufacturer.
>
> So what *does* the spec say? Does it just say that if you don't
> read all the data before doing something else then it's all
> unpredictable? Is there a way for the guest to get the device
> back into a sane state after it's broken it like that?
>
> -- PMM

I'm not sure this can happen on hardware. The device puts all the
bytes on the bus, and the controller can interrupt it with a Repeated
START

SMBus v3.3 6.5:
```
The data formats implemented by SMBus are:
=E2=80=A2 Controller-transmitter transmits to target-receiver: The transfer
direction in this case is not changed.
=E2=80=A2 Controller reads target immediately after the first byte: At the
moment of the first acknowledgment (provided by the target-receiver)
the controller-transmitter becomes a controller-receiver and the
target-receiver becomes a target-transmitter.
=E2=80=A2 Combined format: During a change of direction within a transfer, =
the
controller generates a REPEATED START condition and the target address
but with the R/W#
set to 1. In this case the controller receiver terminates the transfer
by generating a NACK on the last byte of the transfer and a STOP
condition.
```
Hmm, seems to me the data gets cleared with a change in direction.
-Titus

