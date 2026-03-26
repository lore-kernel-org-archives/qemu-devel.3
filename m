Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC5F10A88D4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 15:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5maG-0001w0-6N; Thu, 26 Mar 2026 11:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5maD-0001vf-Mz
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 11:25:17 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5maC-0005QR-5X
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 11:25:17 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64f48a5c3d8so1387513d50.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 08:25:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774538714; cv=none;
 d=google.com; s=arc-20240605;
 b=TbRQacmDpbAKEKmxrZ5wW/AcFOX6hVD21cdONvBubMBl0zu8X3enMyqQjQzYwwyKzu
 x634FOsKxJ6JeZGI0B4OTvHEBDHKn533ygH7m2hvptSrTIIH928L5QTArNPfmCDPeM9I
 AL/3QJ9WtBK/dW6ovIg/O6/wEki/t/cejLti7AxBvBSfvzpFZrmLU5gI2vU3QH5ngQSx
 0ifLzc5W23DZ8CprePh8C7BeJ1kdur+U5w/4R83xcuqWAP1M5hs2W9GiOC2BJTig7r5C
 0uzktbZixSo0WKpZUQmfVqruqoGGYjtorVlGnO0nc4zX9a1yoZm7W4vAecqjzivuwIfa
 4jEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=USXXcSwLW1EXRSE4f7p51QuIuMKDb4fP8WlWne/h+3s=;
 fh=wenmdvXzFm2UTuSjK3Hs2ebVaHDwTR9Lx3OWz30VTOA=;
 b=kDpksERYB2QAf4gy7yK95fzTyX+sY/1LoGcwGdAkzy6FFL9W71T8TrNsuadkzmnDZK
 4fejgbh/hIdsLWtSzHBcqAyID6/nMyY3kVUqWR4VohtpuPIP3mdEQ4LIhbnAC3Lh6o9g
 qLSTJnENUGIVH4dCkgKo/rRwfXCbnfPtAFbNfSFV5W6DorvZuctGw+lTKwH6juNk8T/T
 rDeYBl3hctu/Vc1xeNEzYUO0bbinP5Z1rUPtmEw5MgFXG42xO+S+3k5lcbWKMw5fQ2nT
 +sNwri+aPJOL1wU+HRPyNSA93Egm22AJbezp/h+qhpZ0NjCoV1YJPcCW1zFX8cpGDCpN
 A7sA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774538714; x=1775143514; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=USXXcSwLW1EXRSE4f7p51QuIuMKDb4fP8WlWne/h+3s=;
 b=z49g5Hc75mrPnv3n+l+E7WEgNugbfnuN1KztjI2865qRr5U8s1SNH2ZHGLEEQGbXre
 JiST88qXc8iUmSD0UGxxHDnXxSIqy+4RARcdkl1I454awCedaUgUmZYjDNl6dyWuDci8
 boYXG2kddgzfN3rcKD16XMQLX4qHmpCBeFWmXvw9cuX3UEQmSijBKyc+l51gK5vyXGcj
 PWxXbAsoVlRUvbfW591pM5NKfq5ea91AGU1ZOeP6WYvZzJ9/fmnb74h4H2u/LP+l1DyP
 NQxTfVglgmHVeV+HOw7d/km63hKXcXHgFD78/380gNZGLZy+nU/fdOZ/TA7w/VYLv84H
 nosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774538714; x=1775143514;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=USXXcSwLW1EXRSE4f7p51QuIuMKDb4fP8WlWne/h+3s=;
 b=KBO8B9dcF+0hL5lhAv5aZxB/K0QxiaOxD9vOwvI5W/0QVVFhkwL54MdG3h8vyOh2u4
 Ha0vcpa9qb56+rEanSSvhPf0SL7s2mXkT0K8AJRPCCLfYUDgd4pBgqOnlQT/ktFkKMQx
 7jOvUqeOlsi1kJXqPXJBUFUmh9NCfGfsZ8B1Y5hD+SxEp/VDNFxkWu6BCuMNo3PthTIt
 X/4xc2jiZ8vc3KRi4kpATg/s5RNRYx8v78nxo2ZKohjbmbv56K35jIhR6r1oob5bL12u
 gyR0vhH+0kBW5Y3tLQSoaW1mad3/GjnNFOODkH03qxvR1lNbPRjUMkhJQOaTTAlBvPyZ
 SkAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxvG+zcSwaJNxasz4djKWBRSYlbA+J+70hyLYtoK5FA32ryYqE0yz8hDt+Dv8q5bKHrh4fLWdeoQUo@nongnu.org
X-Gm-Message-State: AOJu0YxRoYeRNKj3kdK7Yh1bkrlmwqRXmY1gT2vqPne8d+jm5pjjp1XS
 tG252Z62kSi4rm5yhDq2VCKecj0GK4JmBmc3OLpjXlsw+aenjs5LukQMLWszK4oJKTRHbCSBtEX
 LR+PYJHPRPm2zz+tV18vsozLt0il+j4jHgAnuI7bMLcjcNVn6oz7xnTQ=
X-Gm-Gg: ATEYQzwvBYZY3ltxNDUCrqRPFfZT5X75/HVB9Mrzizb2/HdLCyM51papUkDeawORlIF
 eZ/o9l5tOBvuCTaXvalG+kctMOMy7c+p0yunEf+c7H5HyPoS92cQKWTos7Cy5sXBoaJA1VFzTPq
 5TIE7aVKCLPsu0v2G/AQ8EYvbbWr4tpM908m/dt8gYwh6e9bbdSTcl1ChQUI14dOuWPbffqhrOy
 r33dqYYJ+Zugmtt/9ZqmrB25Gq5ONLbwrPg34/j1Uy70USLpcAokKKlOlWdoXFxYCzZ315aHQ/k
 YuvhVBdg+/v7jjO89T9Nr6Lqp3qmX8K6SsqfpDj8Ep8D2abKgnPH7h96n67HFZ3cjWI=
X-Received: by 2002:a05:690e:1603:b0:64c:a708:2b92 with SMTP id
 956f58d0204a3-64ee618987amr5998282d50.81.1774538714516; Thu, 26 Mar 2026
 08:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260326113457.159065-1-thuth@redhat.com>
 <CAFEAcA-xWtr=Xgst=MOVcm+TxegSvNVXmDP_RDVDOvJJW76Qeg@mail.gmail.com>
 <f6045fed-60fb-47b8-8241-a6fcb0af7292@redhat.com>
 <CAFEAcA_VoSX2JK-HRpAN0P0LT2dj_WvSRyP2dom3ZQK76mtyfA@mail.gmail.com>
 <67ae08fb-adc1-755b-a73b-789cd3e43049@eik.bme.hu>
In-Reply-To: <67ae08fb-adc1-755b-a73b-789cd3e43049@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2026 15:25:03 +0000
X-Gm-Features: AQROBzCEzJfKV_lU3uoh5unYRiw5OlDwXcpPzXqEGsNH1snuSDy2odl9u1BKxgk
Message-ID: <CAFEAcA8D_NEkhRS4ppCrTzMjj_5BjRtSevD6OGRWX=4f2cWyYw@mail.gmail.com>
Subject: Re: [PATCH] hw/display/vga-isa: Fix migration of the isa-vga device
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Thu, 26 Mar 2026 at 15:17, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Thu, 26 Mar 2026, Peter Maydell wrote:
> > I do notice that the Cirrus devices have their own vmstate handle
> > saving and restoring all the common VGA state, instead of using
> > vmstate_vga_common, and they miss out all the vbe entries at
> > the bottom...
>
> That might be OK as cirrus-vga does not seem to support Bochs DISPI VBE
> ports so there should be nothing there to save/restore.

Mmm, I did wonder about that, but I couldn't see anything where
we disabled exposing those ports to the guest. But looking closer
the cirrus code never calls vga_init(), so it does indeed not
expose any of the VBE state to the guest and doesn't need to
migrate it.

-- PMM

