Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EA7E7BDB4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 13:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vryh4-0001KB-PU; Mon, 16 Feb 2026 08:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vrygr-0001Cl-9L
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 08:31:06 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vrygp-0008VU-KC
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 08:31:05 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64ae1729637so2786653d50.2
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 05:31:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771248662; cv=none;
 d=google.com; s=arc-20240605;
 b=QRFuo9ekIfO+dA5MdK5QZSF5n4PcfPoz9+WlDUoX4oBQV+xJ9mL8qjeWixzpvfLQPj
 nKakgu42xu9gLRkEym3G9xb67cXTgqon7NLpz/6iOj4r5IQ2/F9/wF+dgrnBJVf89aY7
 uTeAjC8xycCU+RUXP7+zPk26/90QDj79TP674k8JenFa7OE2pO935VwnINljWJvFUQ64
 kSOxS+bu1UXID/++joASl7f+PKrNaSHHb/9BnzYwlD14PGrOJTvYdNp/tTR6GiMpZucL
 bZ+2uq6Vsu5/ZFXWjsBpdOxKxHiDsJPdFJo/MJnjEJMzEkgNuFoKX2ox5G9Wn6momoOx
 U7Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=o3wOtoDZJ0p0jz0Xtoq03ZP4KLyE4lMLqKI4YU+J1SA=;
 fh=NN+C68PdtpgkjlihUrfyK6mn4CiHnNSLiIN4Wol2LfE=;
 b=fxfENSWgX3rR6fEf6BGZP4n1mXhqiG182RDaMzq6s1AcAUrYszWeeaJ36HAX/qAiLM
 lzV598UQHWAHQFq5ckV1JLE10uHJxdkoQ7SYkNwyfAksKz3xWpnvSj/+h1Dr+RWGJC6O
 j+KAxA0ME5d907kZRmr2Ann8REvHb8ymbcB9g6m1udkKBacOGQO6brlVp256iiBhW5DE
 rKo8Mmq+DZY5ibsciZz0OXptj2a7tNlRSJWt0+51KIzbslPXxaFHzK5PnIS4GciNNEr3
 5JupaHLmntOHVupZfNSdWRKsN9qcnZDB3BthYjYWKZRYEcYedbFQGaRYrZwyGYpVuh9v
 j0bA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771248662; x=1771853462; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o3wOtoDZJ0p0jz0Xtoq03ZP4KLyE4lMLqKI4YU+J1SA=;
 b=HUOqqobpt9a8p4C1VaPwaeZY9T6T+cyyMbQfPLypQ2ui/IWe9UpUblcZAAacPEkiFW
 ebHIL/TkuxK7IxoE+/HPwvQEDP674GOP3urxFuRPb2Sr0u+2B7k5hyWRRQ+KstQwlMho
 c6FWWhEOJdIxL3uMlCzn4eYTx9uQlxJbs5MsiAk5MjBpw5OAS/12XHz8DH2hk+GJumDM
 APcRJ6DOjwNOqzNffNujuyAqqDz3XsY9YKBqa9JXXJjNZ6bWXaoGeUrSSlRJcPPSidu7
 vghQXrPHXj0FykpA7PEpniJW0F6erDUPwiofqx65xiGuWc1/ViTAuLCxxHmVRCesc20v
 zMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771248662; x=1771853462;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o3wOtoDZJ0p0jz0Xtoq03ZP4KLyE4lMLqKI4YU+J1SA=;
 b=RFX8I7IWb1MgPNUNTeK/SNTQfRiOw59wJE+I3YLxLeGUfZBnooM5zPXvjkI8BM+fqn
 Rl/MoYBAGBtwf1w70ZymRwJDlBXia8MnbXjmQkznMZLPsPrgjZ34kYlWJOyMW2JzJ9U2
 c+Z7qUthqeaWet/BAnE7AubUIMdgzgfjD5J5PH44hrtkpVOXHdaPEMk8+zDPYQVpZ9IO
 83GnoBrBqtndqyEThclCtuEiLbhR80eSqeVKEwlhXStps7wIE4szg57JTGzZrMpdSwLv
 Jz0W6a5KXkF9NO61nIwI4uFWWe4MrGIDzMKiic2QNo5A4QcJj+MDeWlpPlzYdPsyYTJo
 0Xrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyy+Ck1xcdNz7ZSUUq1ciuLFcfXHrBhZq6gdWAuUjiCmaHa7ncbaadE9UmF34ICjfK6JhPSFA18dvZ@nongnu.org
X-Gm-Message-State: AOJu0Ywak/d0v6Y1V201Dj90npN5jf7OKK+wEFOKKJwQ96AtBd384pFy
 fpHPrttzhugwXpr2jC+frHcSOIBj1i9JNzV4ivBeURcvQHY/0hpBwMQy9gGa0oHdAflzlMFD1OB
 w7JTsn/zTl9guC34aIlH6LMaf6ldvbiLVW+ErCAnUJw==
X-Gm-Gg: AZuq6aIRXChwCKY0tDHg7tXm9jVXsmvNEAqj7oK9vxOPEuUnW2pRdSCxZ9y4vM2LIJe
 uHmmS/I7xzZHfQdy5fSQOgyjb3KrHK8JwpBaagUk+YHA1SEG9rwjso5Itpez+bh2BBtg8oPj1zh
 Q0oZ6JrE/fSxtK/gQSyNXqnR80BmImsXusA/1nQuypdrjiDxPH9eP2L4npdkvthdd1YNFZKURpf
 zKTahkRJM8ldLBvBd3tXElD7dSAZYAWpRZyS35yqaEaq9Q9LImjIU0tunZHScIGdeJJVto0CBcE
 K4E9BsO6Jvyi3WnB12A7WDIM5TO7gPrGozE8rw5LsglVZqhE4uYDJQ7vwCYbHXPVJTOiWAoSgVh
 Wgw==
X-Received: by 2002:a53:b20c:0:b0:64a:d720:f259 with SMTP id
 956f58d0204a3-64c21b80db0mr4529065d50.85.1771248662214; Mon, 16 Feb 2026
 05:31:02 -0800 (PST)
MIME-Version: 1.0
References: <20251202160853.22560-1-sebott@redhat.com>
 <20251202160853.22560-3-sebott@redhat.com>
 <CAFEAcA8oi1Xs2kv66dFV9NZore+Q2vHUsgMikveVdN1c+3SBJQ@mail.gmail.com>
 <9b04a20f-b708-208d-1e4e-466ec30b7bb9@redhat.com>
 <CAFEAcA-A+zW=QFdCY7z==+Z=xXfhJvPeyHhbG_MpEmpkQfrmaw@mail.gmail.com>
 <4e9470d5-ef3e-cf5c-4117-fb589d56323c@redhat.com>
In-Reply-To: <4e9470d5-ef3e-cf5c-4117-fb589d56323c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Feb 2026 13:30:51 +0000
X-Gm-Features: AZwV_QhGoaC3Vnb64FdYsO_8xJx-bd5rBrEQJ8-6M3I7JiVPCm-6tAEOuq08bHQ
Message-ID: <CAFEAcA8V9bjQUzUYAW7qj5fEn_f9xaPJAYpTRgvdaFq0cY3pRA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] target/arm/kvm: add kvm-psci-version vcpu property
To: Sebastian Ott <sebott@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Wed, 11 Feb 2026 at 16:04, Sebastian Ott <sebott@redhat.com> wrote:
>
> On Wed, 11 Feb 2026, Peter Maydell wrote:
> > On Wed, 11 Feb 2026 at 15:37, Sebastian Ott <sebott@redhat.com> wrote:
> >>
> >> Hi Peter,
> >>
> >> On Fri, 6 Feb 2026, Peter Maydell wrote:
> >>> On Tue, 2 Dec 2025 at 16:09, Sebastian Ott <sebott@redhat.com> wrote:
> >
> >>>> +static char *kvm_get_psci_version(Object *obj, Error **errp)
> >>>> +{
> >>>> +    ARMCPU *cpu = ARM_CPU(obj);
> >>>> +    const struct psci_version *ver;
> >>>> +
> >>>> +    for (ver = psci_versions; ver->number != -1; ver++) {
> >> [...]
> >>>> +        if (ver->number == cpu->psci_version)
> >>>> +            return g_strdup(ver->str);
> >>>> +    }
> >>>> +
> >>>> +    return g_strdup_printf("Unknown PSCI-version: %x", cpu->psci_version);
> >>>
> >>> Is this ever possible?
> >>
> >> Hm, not sure actually - what if there's a new kernel/qemu implementing
> >> psci version 1.4 and then you migrate to a qemu that doesn't know about
> >> 1.4?
> >
> > Oh, I see -- we're reporting back cpu->psci_version here, which
> > indeed could be the value set by KVM. I misread and assumed
> > this was just reading back the field that the setter sets,
> > which is kvm_prop_psci_version (and which I think will only
> > be set via the setter and so isn't ever a value the setter
> > doesn't know about).
> >
> > That does flag up a bug in this patch, though: if I set
> > a QOM property via the setter function and then read its
> > value via the getter function I ought to get back what
> > I just wrote.
> >
>
> Meaning this should be something like below?
>
> static char *kvm_get_psci_version(Object *obj, Error **errp)
> {
>      ARMCPU *cpu = ARM_CPU(obj);
>
>      return g_strdup_printf("%d.%d",
>         (int) PSCI_VERSION_MAJOR(cpu->kvm_prop_psci_version),
>         (int) PSCI_VERSION_MINOR(cpu->kvm_prop_psci_version));

I guess we need to define what we want. Things we need:

 - user/QMP/etc setting a value and reading it back should
   get back what they set
 - QEMU needs to keep working on a new kernel that defines a
   new PSCI version in the future
 - user reading the default value and then writing it back
   should succeed

Things we might like:
 - ideally the setter would fail if the user picks a version
   KVM can't support, but I don't think we can conveniently
   determine this, so "fail vcpu init" may be as good as we
   can get without unnecessarily large amounts of effort

I think this probably adds up to:
 - setter should accept any a.b value (for a,b fitting in [0,65535])
 - getter can handle any value and turn it into a.b
 - make sure that setting it to an invalid value gives a helpful
   error on vcpu start

Doing it this way, do we need a separate cpu->kvm_prop_psci_version,
or could we directly read and write cpu_>psci_version ?

thanks
-- PMM

