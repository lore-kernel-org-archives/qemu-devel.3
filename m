Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D802C44529
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 18:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlsfB-0005eR-36; Mon, 20 Jul 2026 14:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wlsf9-0005bF-QB
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 14:24:23 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wlsf8-0001mR-5Q
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 14:24:23 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-80cebd41372so96341337b3.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:24:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784571861; cv=none;
 d=google.com; s=arc-20260327;
 b=alzFGlEfEVhszDYlMJiz6/wLtBJ2TMRDjFahcykeMpwq20asHZQm8hkZWglONnaTxQ
 0xqNE/0HlywPg83OE9wyyKXle4KxJSILAKSrPb8cPixSDZDwMUXGHjeYmUY7L0g2obkC
 FNp4RweOSBTWi7qYwHIx7W5YjpbC8KqqLNHVKS+jFOKXghzJ7QNQK0J5MhvOVaRY+QLt
 0r4Md1F5cMoEJuBMo9TQdioYj7yxHAijI7AlmhPGsYbO4oKsuJb+rWe02zoVKgh5Ux7L
 QXAFcwnTG4EU3ZLWY8wnU/0bF0Vxx+rMnP8i1S2ZoU5GXkbEFxRBxvnPfMGZ03txLQft
 F75Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WHQXP4Ha+1KWS0Nc7WTVc4BzIYjC2uZ98tXAR3hZGBQ=;
 fh=HLhN7+M99QIQ7fqK8HLN1zNNRRBMAygbiENshqMpnWY=;
 b=p2g8xUpI4lV0En9ZVvzMa82eXjMpTLO/235no4aDrtLE0PmOvQHEcHCkKich7qiJgt
 cNf3A2W53gFfCfpAaRMX7+G+0XcjdpX8x8H3VZSr12VoG2TE5LowmYR4SKUi+KUfF1Vb
 xKEeo1I4s29FbdQK/kUj1XoZap+glMOf5QrU6auv0fcetQoXRVq29EASNMP2gDBgmeky
 4KqtNdbsEaoN3cr9rnSlUEstsq885Kt3KIAYnwqfWTg6qm1n45FbUAczZWgkXZjbDVf9
 bjs6HVTsiIx+H0Pc3RtvVJfErZKJGn09fBJGQp1Wqzg7hCQKqfRPBlek5I4EZXkivzLz
 fA8Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784571861; x=1785176661; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WHQXP4Ha+1KWS0Nc7WTVc4BzIYjC2uZ98tXAR3hZGBQ=;
 b=zCZvDMdhsyuP0z6xDFnbVe6uO1qzUTPjnsfmnPbMx4D5UaBJEanEsWZL3Ae5ktoNjv
 P5WRkI6PMRwM5Ncm/7lYagNuVVg9BVKMzMYU8DpWcHIn2UKNk4hLUY/x4dQ/aivHGFmJ
 y4naZ7TTpgEgqFaulqRyZcvVKJ33zeLS+bn8g4dLoSC1XvB8an20xMideoPRC4Jr6/St
 hS4OO8Qi684Z5RL8+4CZHLRNBSSaKkwSMr4hM+Tw2GQQcb3Hy+aC55dstTdjRQOmG+cU
 vAcoAIgt9Ew1eLQPkfFfUitsRlo8DUffmcjfi5So/vZfQvafcm+WAhB6EpK/8yGxlAxy
 UeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784571861; x=1785176661;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WHQXP4Ha+1KWS0Nc7WTVc4BzIYjC2uZ98tXAR3hZGBQ=;
 b=bb7Au9N+lD3Y1gPsTBlYNtfpdb3tfpdIhCqJwEJ/eItvf+MEMZ79pK4LYmEvETeNYA
 YEAj03GbSzvbb3JdB+R4XKwaxdwZ9mrGvWVOrW+IedJIOz3IO6Edk0fMdNL5TDBkRX4K
 4lf+BEXzRkM/FBQhn8L5hPvVV1KuCeO6CKSGCC2PgRmWPJtWrrRcpQbLH9m+yXPnTdUq
 OO7slFnAQXecTrzBhWb8ii5qnkwFGD7sUvirpQ4yVubu6A+8t03d6/v8QBlcWJeo9IBW
 ZFwtQIcfmB7O047nU9xBC2/h3PDqjUEq2ULnrYjBZEzs31TLAMUJsa9/0LrfMyJ92Vi1
 amHQ==
X-Gm-Message-State: AOJu0YyJ1iIXyRBTC4xqv60mOuG2y+lJJ0oi4sFDck+UYim/6QjShExv
 OdHjJR6PtGxJNv3qKd4avxvblnhe1qhNCFQfrVR9BU7fEIsiye1XdRq+f/7B+CNrMLF9+v4KQS+
 HXkZsbsaeWh/7Sh560Yc3abjkiIMny591MY5heGRETvuzw+GZS9NT
X-Gm-Gg: AR+sD11TxFDQYQxXpTFXKslnv7XCa4RBgeP0UL4a530Fw8Fl8KgWK+sh6E3zBuqjb6R
 SOqryq5tCG1P7GlwP6cp+zFSDlNraUBWZpwRsgHltewBj+X3NtZMt0wTBNoEZXxswbqqWZpgcpr
 9ZsLsBUxJZiMGTb2Ud8/Qo1GubSRpCiFeJOKTCD0HKAViEcTnMaHdRarKI16DH+0B+zbpr/QVv7
 PxkVos7UMzOZk3lXGN87OysTac5g28SwBMgihrA+3zppyJ8kofjd4ERS3yMxAcLlKcRqA+fDFd+
 0vENGEr9VJVkFQyyeLWkMyxclKLYy5TnKVodrtazxT5W7g==
X-Received: by 2002:a05:690c:64c6:b0:81f:2401:8017 with SMTP id
 00721157ae682-81f24018066mr2760047b3.51.1784571860759; Mon, 20 Jul 2026
 11:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260719152318.69501-1-matthew@pq.io>
 <20260719152318.69501-3-matthew@pq.io>
 <CAFEAcA9Mqtk65y9jJCWZgmRUMwgV+Sz7Y=R=Pp5R5huNj8cLjw@mail.gmail.com>
 <20260720095147.maydell-reply@pq.io>
In-Reply-To: <20260720095147.maydell-reply@pq.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2026 19:24:08 +0100
X-Gm-Features: AUfX_mxTEkH93o-MQmHolSk3OHZAYABZvcopaITa-5KbgYRSNeZJ1LK8Bd4o9hc
Message-ID: <CAFEAcA91D4mALhmaNMpVWCM7XLb0Qr7oso3nTbd-ONH-bWtQXQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/usb/dev-hid: add apple-mighty-mouse
To: Matthew Jackson <matthew@pq.io>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, 
 Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Mon, 20 Jul 2026 at 17:51, Matthew Jackson <matthew@pq.io> wrote:
>
> On Mon, 20 Jul 2026 at 08:22, Peter Maydell <peter.maydell@linaro.org> wrote:
> > Reading this comment prompts me to check with you whether you have
> > read our AI contribution policy, which at present is essentially
> > a "no AI generated code or text in contributions" policy:
> > https://www.qemu.org/docs/master/devel/code-provenance.html#use-of-ai-generated-content
>
> Thanks Peter, and fair question -- the answer is yes, AI tooling was
> used in producing this series, so under the current policy I should not
> have sent it in this form. I apologise for that, and I appreciate you
> flagging it directly rather than just dropping the patches.
>
> To be transparent about what that means for these patches: this work
> comes out of a project that runs macOS guests on QEMU/KVM, and I use an
> AI coding assistant in that project. The comment you quoted is a good
> example -- it's essentially the assistant's working notes shipped
> verbatim, which is exactly the kind of thing that shouldn't be in an
> upstream submission (and, as you say, the development-history narrative
> doesn't belong there regardless of how it was written).
>
> What is *not* AI-derived is the hardware ground truth: the USB
> descriptors, HID report descriptors and endpoint topology are captured
> byte-for-byte from real Apple peripherals, and the design decisions
> (which device to emulate, why Mighty Mouse rather than Magic Trackpad,
> how it binds in macOS) were mine. But I recognise that doesn't resolve
> the DCO clause (b) concern about the generated code and text itself, and
> I don't want to hand-wave that.
>
> So I'll withdraw this series for now rather than ask you to review it
> under a cloud. If I reimplement the device code and comments myself,
> from the captured hardware descriptors as the spec, would a resubmission
> be welcome -- or would you rather this category of contribution wait
> until the AI policy itself is revisited?

I think that if you reimplement the code and comments that would
be OK with our AI policy -- as you say the descriptor stuff is
basically just data.

What I don't know is whether there's anybody interested in reviewing
this particular device model: the whole QEMU USB subsystem is currently
in the "Orphan" state, and I'm not sure how many people upstream are
interested in macos guests. So it's possible that if you do the
work to reimplement and submit a human-written version of this
functionality that the patches will still struggle to get review.

I suspect your applesmc patches are in a similar limbo, so maybe the
path forward is if you can find somebody who's interested in reviewing
those, see if they'd also be interested in reviewing a reworked
equivalent of these apple mouse/kbd devices, and don't do the rework
until you're reasonably confident you have a reviewer lined up ?

I have cc'd Mohamed Mediouni, who said on IRC that they might be
interested in reviewing some of these series.

thanks
-- PMM

