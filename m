Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D16CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc7Ks-0005xv-1n; Tue, 23 Jun 2026 16:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wc7Kp-0005xG-Vg
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 16:03:04 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wc7Ko-0004eW-I1
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 16:03:03 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-662fa4a4470so268973d50.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 13:03:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782244981; cv=none;
 d=google.com; s=arc-20240605;
 b=N4Ok2cREcStEf+NxKwhshPDsE3VrR0Xk7iqNsi8KfN8Zpd44uYOzb52ErWocpNp/Bi
 t0QMe2Nz3R0G5eUSvuLD2enL07nDGd6xu3pxU/7UW+v1CyAhZ36MXZXQ486WLdfzjMxm
 MlIWm8fmhH/7M0saJ2ETm0ot7QBxrEfFTqorbeqb93Mq091cfgm8ySOpdOHepIP0wsaJ
 e+jGE+6Hm2uRuPq8yk2qWr/u2U1gdg/pHZcXcpHoPn6JnpP8xj5SuZ8gaU6FxLub0Lni
 K6u6oXPokfPKGLRydmh8g5jpRPIP3KbR3lOlaar5ESEEsfTnbbW9jpoBO4D+iMeHhXPg
 2pNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TrLvQubzU+/Lpc8tJLp7Tkl2EusD11p+O2+kpsWbbJU=;
 fh=ntnFdXsRCZbLHVr/o1nS8k5XTrfppuza30kytlDn5nc=;
 b=cFjwMvpiEAaJ7KpffIy4ubH1oaIJGsIfzNs5XjZyuDP49jW9zU+rDh+omECLxRnavz
 3teFjQdoURggR/NUBhLNnkWRE1frxxLAMbmqWwoRTDeACpmwc9p6WDPPLNUF0cK4Z/CB
 Z+PQsz3P7Yivhybl6i3/lsqUlcxFHuJdzsOf3eiIHQ719JgZnmquTZBVB4NV6TfDZf/W
 OWW4uT2yAOIH9P2BLDUNAJ/blXdzAwUBkq4Gh7Bm1vd9dvlmjfsURJ2EcAIDL0ml8RQS
 UbzVbBNoV1kOs6xRJ9tKlGWkAwGLAMBIjOye7H0t3giF/Pz2aVXhJSYQFglWWYltlmnY
 nz+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782244981; x=1782849781; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TrLvQubzU+/Lpc8tJLp7Tkl2EusD11p+O2+kpsWbbJU=;
 b=uRTcADkgb7jxGim9t8gvUxcguhGud0dVciEzgUaS9Mk0MOV8NpcBpqAwHuNxiX4EUy
 rVvwx/z9QWWKzYSPmR7PjmiJTzhNhIg92JBz89+Q7jn01mYLi4N3h60smnwjMIAb6mYq
 +lavmI+gxHoU3EAu5yQWsnguY+uHaOyksQDH2LxS2IdbSWfkj2pKx3aff2qZMC8gaEoQ
 QNSwoTdE+laADPYp3r5WEuUWl7IKOST/ZlMNkbC2JDvZVivWfdaGCAYFjPidhXblbzsq
 qMI/l6Jy3cN938hfV5fzDApHq72H5XWrj852BzFce0oOMpYLfU1Y5cyJdld7KmWVmqy4
 xYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782244981; x=1782849781;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TrLvQubzU+/Lpc8tJLp7Tkl2EusD11p+O2+kpsWbbJU=;
 b=BdMe4aC8TrfMqeHAclg8EUdmbx0kckNv+7Pzc/WPUMSPC+JBqFTaREc5jbEksw2KUs
 zlGc/yV0Y74/aNw8Me+55EAm8Tw4ng4oQcX5w4n9ZWGXBtmWnWrhZT6DvoiPENDBEHf8
 T7+3vVD07z5lGWFWti4gGmv0fjYkptV8BvvqDqwmOWAhFgnzJe1aKO9l9sObGBSO2qEn
 8i2RFrOLfKx21P6ut5ShK18+RXWplLPFh5ehYw4sCkxBotOOrqScgya7kfxuktpBiERr
 T1i2GHaoGS0UyNtsvOgK6bwmGUUuQCeCew+97RDzRhyue0YYFR98GiIr6XXuNOfVHXVz
 WbDg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCsTPwYHs3t+J8+qLPQrXmI5L8BUOFgU6edP7uP+5eHqAsH5BbiMDhJgRY3TILxlUyO4AOXn5puKjN@nongnu.org
X-Gm-Message-State: AOJu0YzwT47rNUyJMbO56hazE88TiajNqqB5+P8I9ywGFCqkdX3gQGXW
 DMKS4g35zJ3/znSsncdJ3Wzlr9gPtwx7CcXYnUE+aRjhy629aNkPeklde2arWM20nOng32FfCJX
 j23G/1t7o47H4cFEuM0iKMB6MhUtPYCV7zDRMExn4WA==
X-Gm-Gg: AfdE7clvaxBOc2bYkAieDKkN8lEoUxVgh3y2xPeD5ZahSxIzX2/3vxUWvM5dz8ZIaHz
 c/XM6vbav62SkhSu1Wstl4iNj1HzqNsUOr55FzSU/Ymnc9XH42EG1dWQ4BibskPakU51RKWs1SU
 1HhIScrZQpJ0n/9dNOegnehiUisoge8dLcb9PbrdR/4OTSKS8b8LaVqfIfA60tieQ54p80njyjS
 XfnokbBqCEa0rKXOXNHHcX4gU3GQ9k3r9a5l6tqUeAGy1dtguWhCtR8YJGuE9GNRJPG3T4CLzQk
 IQKkNK6UOWUB0J23Bn3DqmRvqp6cgYt4Cf47ig4qeSFqFMcr/AMmCZqn
X-Received: by 2002:a05:690e:1c09:b0:65e:37bc:c759 with SMTP id
 956f58d0204a3-6636e61cec8mr323686d50.62.1782244980904; Tue, 23 Jun 2026
 13:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260623131946.46879-1-utsingh@redhat.com>
 <CAFEAcA-nrh63fWvnVSSJExspOw28WkZyn69=YMdb5=ZA8m95uA@mail.gmail.com>
 <ajqdIS-BZeyV3lnA@kbusch-mbp>
 <ajq7-Y3oZcUu3BJK@utsingh-thinkpadx1carbongen12.bengluru.csb>
In-Reply-To: <ajq7-Y3oZcUu3BJK@utsingh-thinkpadx1carbongen12.bengluru.csb>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jun 2026 21:02:48 +0100
X-Gm-Features: AVVi8CdkKtH6NBGsm-uGOaoXnxIfO7IKtqqNfyIrvZI7IUvuM1qJxPvu5JhXuZU
Message-ID: <CAFEAcA8OeYH9qCvYER9PUShXg+hyfyZEOOSfcKvxrSXff-KxEg@mail.gmail.com>
Subject: Re: [PATCH] hw/nvme: add user controlled 'vid' property
To: Utkarsh Singh <utsingh@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Maurizio Lombardi <mlombard@redhat.com>, John Meneghini <jmeneghi@redhat.com>
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

On Tue, 23 Jun 2026 at 18:01, Utkarsh Singh <utsingh@redhat.com> wrote:
>
> On Tue, Jun 23, 2026 at 08:50:09AM -0600, Keith Busch wrote:
> >On Tue, Jun 23, 2026 at 03:01:12PM +0100, Peter Maydell wrote:
> >> Should we also have a "device-id" property here? Being able
> >> to set the vendor-ID only seems unnecessarily limited, since
> >> PCI IDs are a (vendor,device) tuple.
> >
> >Yes, the quirks are usually based off the same tuple, so there should be
> >a way to set both when that's the justification for the patch.
> Will add device-id and rename "vid" to "pci-vendor-id" in v2.

I don't have a strong opinion whether to have the pci- prefix
or not, but please be consistent about whether you have it or
not for vendor-id and device-id.

-- PMM

