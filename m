Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C52C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 16:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNDUc-0005ba-NU; Thu, 05 Jun 2025 12:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uNDU3-0005F5-JO
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:30:32 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uNDU1-0000oP-71
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:30:26 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-708d90aa8f9so12228277b3.3
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 09:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749141023; x=1749745823; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8VLeZXtiyN8c5iZoJYezNM+Ro1ne6h44DZkTHRNf6DE=;
 b=PL48mwwtKMn8umaiOH4g+Yb25PuDHcf7nFfBT/KL/DZE5fDcCFc1pWnwJ3GXVoC+TV
 mPaqn6sqAPQndA1nuExDNxvuN22wq2kkMRgx1IHoKaOp9icw2CZBx392TAvUaxdypqzM
 WBSnQPbFoo+QNbhjhTT07kzjcmo1txZ4h4uGD4SlJvDZ4Cm5d6bxc9WN2FRwPIWMdxyU
 iUTMUnT7OVT0mJ0vgNGmGtf9EqEeK5SOC8HbF9QY0ZwXNDTwlSe8zvzvoSB0V59U2LVP
 qnXGjggv2F1ikKuZSjGIAvF11UxivJCFxBbkIBhxvSmGHBsNaCZYdEyV7RHSlbTA+Djj
 /0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749141023; x=1749745823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8VLeZXtiyN8c5iZoJYezNM+Ro1ne6h44DZkTHRNf6DE=;
 b=LZBuEtRMKROlF5qDBSZTkHrRiuzgvCyjRZGXnGfW/Q5BTL7Wnczh7en/1cerSFc9MC
 yDhjaiY2dujlVkFpKFIZNs720zCqZrbxf5LP2gIZ6f5UkeyTRySQIGP+ko4OZgXy7VVs
 Bp0ucDjbk9LIyAfvKp+5ztXOBPTtZtHuxTmCbm3Njj2bmGdVJzDnC9C0BdTRn4Gh80P2
 XM84a64GUsjLWTnxN3gtDdCP/uLkG4XEZi/uh9qt1YniYM0ssquxsanv6xLA4dJLF69Q
 cl1aETDfRB2hespztyKecnyT09vIEhZclCMZRfCeh6+RmXCWCeceDZYH3zYsFDirDW2i
 bK6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBwYO+LQK+VxdByi3M+PJHCP/hpnRoNZQN5kbEW7LW+C1QLhiiX5TJIeNfl1Irm6GJ4tA7FFYpKVGg@nongnu.org
X-Gm-Message-State: AOJu0YzWQsHRCcMkEGRawoMtG1tJbGvQDcBNvjd8tIVNJJr4cGQh1mjh
 EyRrJjTJ6eLZPMYlOU3F+4mEL1ZcF5NPsxNzM/mLrHRx09mduC7gPg/adHLDY0Bv1uMcdauWJD2
 s0i0l1L2Tkf/32PC9ByWss9a368XQpco0FXijG2B0ng==
X-Gm-Gg: ASbGncuhvuo8Q57zNyLndNJ5Lr0k872+LCpBNJg+vi1/ilOJAt84jDB4wpHpGGTqX1R
 VlfkQWL1gNpTRzNWk/vGIRdqUkJClcIqZ8cHylgLgr/9RNP4Q+9lqe3EYBcJt8xcj/zqwhnp35J
 l0XvN44iqfY0wVp5LZir3f2sqMJCNtdTqKAw/Ox/jTS06r
X-Google-Smtp-Source: AGHT+IGG0TO0LGFS0twEe0XL3TuRhRSFvGHfBKQmcOYDNyoXzTaghSXOoutOd2xO0PHcj7maX7v+YF+p+hHy5P/fzVc=
X-Received: by 2002:a05:690c:45ca:b0:710:f74b:61ab with SMTP id
 00721157ae682-710f7692132mr662957b3.9.1749141022732; Thu, 05 Jun 2025
 09:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250604191843.399309-1-stefanha@redhat.com>
 <aEFWeZUlqqRvHsJT@redhat.com>
 <42276df1-4267-4038-8685-c7a193259e67@linaro.org>
 <20250605125015.GB417071@fedora>
 <ff2a5d50-0908-4736-b664-523b2ed09f30@linaro.org>
In-Reply-To: <ff2a5d50-0908-4736-b664-523b2ed09f30@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jun 2025 17:30:11 +0100
X-Gm-Features: AX0GCFt1DT-f-LR644GIw7ENXtfGWaZhU-EaC86nHdQra3NKU90bOa83dkQEN6w
Message-ID: <CAFEAcA8LMZ6xqW_SvPFjDMiQXYUthB3cjKUVThUfaieYfPxvNw@mail.gmail.com>
Subject: Re: [PATCH] virtio: avoid cost of -ftrivial-auto-var-init in hot path
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Thu, 5 Jun 2025 at 17:18, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> On 5/6/25 14:50, Stefan Hajnoczi wrote:
> > On Thu, Jun 05, 2025 at 01:28:49PM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
> >> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >> index 85110bce374..b96c6ec603c 100644
> >> --- a/hw/virtio/virtio.c
> >> +++ b/hw/virtio/virtio.c
> >> @@ -153,6 +153,12 @@ struct VirtQueue
> >>       EventNotifier host_notifier;
> >>       bool host_notifier_enabled;
> >>       QLIST_ENTRY(VirtQueue) node;
> >> +
> >> +    /* Only used by virtqueue_pop() */
> >> +    struct {
> >> +        hwaddr addr[VIRTQUEUE_MAX_SIZE];
> >> +        struct iovec iov[VIRTQUEUE_MAX_SIZE];
> >> +    } pop;
> >
> > This is an alternative. Using g_alloca() is another alternative.
>
> Not a lot of these:
>
> $ git grep -w g_alloca
> backends/tpm/tpm_emulator.c:136:        buf =3D g_alloca(n);
> tests/unit/test-char.c:1012:        be =3D g_alloca(sizeof(CharBackend));

There are also some alloca() uses, mostly ancient code in
linux-user that should really not be using it.

Like variable-length-arrays (which we managed to eradicate)
use of alloca is tricky because if the allocation size is
large then it just runs us out of stack in an uncontrolled
way. I'm not sure it's worth trying to remove existing alloca
use, but it would probably be preferable not to add more.

(GCC has a -Walloca option, so if we ever did get rid of all
of them we could avoid new ones creeping back in.)

thanks
-- PMM

