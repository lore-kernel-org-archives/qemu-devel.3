Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF72ED2FED4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkne0-0006yi-MC; Tue, 27 Jan 2026 13:18:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkndy-0006yA-W3
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:18:27 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkndx-0000ss-2O
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:18:26 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b8860d6251bso641646566b.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:18:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769537903; cv=none;
 d=google.com; s=arc-20240605;
 b=MqQpaik4pHgTsA7OZXfvwy4sxzq/gAdOclk7vWwR2gEIAHd/JureCBD3tVpEoNQTqt
 baKYtgYunpenQ6xRWR/iIQBJ6jSXVHS3cT+qat3zsE4HspXpUq9lSvLGfTESb2PiTeYU
 PYu2AxUX556b9/o45PmcTnJNpUY/K8f+zr4y7cLqHLNxKpTIxitcWHyYQTDJ8vkCbVRH
 gzLTucSWs+/e2zULBG7Nmdow4w5Zv6E49YfmnggtfxtlU2WxyvGsUqOJGzGdUgkHAlxh
 esb60b/ScKfvt1phk4jCafH8Kf0uWALpyrWogCe71D+pMI7y/ayBwzGvGHmUPTj74Le3
 LHbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Y4TAlzdd7rvwsch6CulBm7lpt7hAKOxigoaihNeKqsI=;
 fh=TqaWCibbDOf8M7FTsU5N1aPLjuWfvrMpXV9es2Ps8JI=;
 b=L1RoJ/8tq2TR6nIbKMSlrOpvJYU9lHz4HbpvJ9bJQUaXVedVYp/Os3ARvE9VyCnc8w
 vo1k1j/I8/ovSUHGNk0JBq9lawa75hkGj/vIuI40pgeP5K0RzSzurB+GW/JK+bSNGkyP
 Iz9oS0vadBeR0GI3eJ6C9haMNg+v91qBigc/IKVO6BYDLuxi+QqASXuQD9ZSaXqyN9qZ
 8rW2VMkuYdzj5Se47aFNCdgf2WINc8OEhezrd2onQWpRVEVow+2Y08HAvq+W2jy4JqgC
 N5Jnp5JMsa32JZomuhD11fTGc1cDYA0kCN4GVrOq4amL4G/wYUTaRhAj5PqjUzL3GToQ
 19hA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769537903; x=1770142703; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y4TAlzdd7rvwsch6CulBm7lpt7hAKOxigoaihNeKqsI=;
 b=E+EHQBcyciUHxS37TXV4zz/YGzuwB0NbLhcw1LcDtmSPGgxYFPsHOpbBpXO/iAruK1
 D2ekKicQJcq69GcIE8SreEvF3EH0QcTbLgcGPYkbu4F7qxPKZdqDAcbL/LejhOQEt92I
 iRl/FLJGshAa6iZ3TkJLYQprnnWVKGp+eY0Phop/Btj6CxXL4MvITi3MJX8NddMop1hk
 IRVXcuaz6O8ycb9LQ9AmNvK+y4zxhlO1PIP9tOGXb3hnrw6q5SNj92wopFrGFsvwEwjf
 Dp6mBThHBgNdFDLzkysjzXg+RFZGTonVFgIPD1ZKuc862h7IHbKoZZQXAJ3Rm+GdHFmd
 JtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769537903; x=1770142703;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y4TAlzdd7rvwsch6CulBm7lpt7hAKOxigoaihNeKqsI=;
 b=Ff0xxn0G1Ndljkycf6pWk3gIFvwfz1IS5F7we75uv7VBTHAqwlZHl92n0BJSqFHkhM
 hK+01nyDjgLetddj43YC7lqHeLiNkPmlzA6Qp1cwJQnIf9iE21LXVIrlaUNzDhKFrt+9
 n+VuoLBu7GQd+JNslZuSjZyjwVI4mHjbCFsdDKRDVQ4ByY6uqBQYi35JjpshwZ+bdXLI
 CGP2Jz567tOjxltaQIIiZYBsle346Fz4MSLIaa1jS/EmRWey2gtBbHcah62wJIbz7+VF
 ReKD9Q6bDYhs7rNVZeofn3wZRwgLK7hkl5XKQGQnYnDHwnU9ILTKPNF2Jg9d5L77ODQF
 DNlA==
X-Gm-Message-State: AOJu0YxbGF1zx30lX5Jv97zzGVMCREvodiKMuJxGYleh3akfqrLxtsmG
 z9tUDV8GghBaWbubu72Cs3mPvy7iJ3ALvOH6lPSdqG34YJuifoW6uA12kKtXY0t+WWpwWdNmIzu
 QXx4+1xXjAP2zh3I5rVbRLA5okwYH/+8=
X-Gm-Gg: AZuq6aKd5skBIStJJy1chsJiOcmCJ+edvrv4oBfzVE39hTco03kvOUba6wk7JBB1LIg
 fKtj0YfQ9NnEQzyAOf8n+KzLboSIK498EXgv62K9o7wpWYSV0eEgEPKel7tjrnCuv0G1uvvpuSq
 PiOo0NNDECh6vcGkdD3WyQ3crY4m9AoH2w2eExxCzGLdOYD7xoRp0ImNE2LUuaddtwJ0LFRa704
 +W6GaZqT2BY8O/tz9raWSijKNuhQDXmWGjQNrShC1UNmxzN/D5tpAVd6FGoTRNLoILUCjkD
X-Received: by 2002:a17:906:c116:b0:b88:73ea:a1d5 with SMTP id
 a640c23a62f3a-b8dab45dfcamr202671166b.51.1769537902937; Tue, 27 Jan 2026
 10:18:22 -0800 (PST)
MIME-Version: 1.0
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
 <CAFEAcA9NEjaUBX19sdw9TRCKcKn8CQfvoVNZ+VaXOcNZ8kf24g@mail.gmail.com>
In-Reply-To: <CAFEAcA9NEjaUBX19sdw9TRCKcKn8CQfvoVNZ+VaXOcNZ8kf24g@mail.gmail.com>
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Date: Tue, 27 Jan 2026 19:18:10 +0100
X-Gm-Features: AZwV_QhgsPS3k1UViGYc904zjHHQN9WcH2oc_E4-HDEBnl8NLgfggLHy5DbiCMI
Message-ID: <CAN-aV1EjYwSRfV87YQdtfqU5CH8Bsssr3EvStPWL2_VFOs4N4w@mail.gmail.com>
Subject: Re: [PATCH 00/27] hw/arm: Add generic FDT-based machine and
 infrastructure
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, artem_mygaiev@epam.com, 
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Ruslan_Ruslichenko@epam.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jan 27, 2026 at 11:03=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Mon, 26 Jan 2026 at 17:43, Ruslan Ruslichenko
> <ruslichenko.r@gmail.com> wrote:
> >
> > From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> >
> > This patch series introduces new ARM machine model, arm-generic-fdt, an=
d the underlying infrastructure required to instantiate a QEMU machine from=
 a Device Tree.
>
> I'm afraid this has been a feature that has been suggested from
> time to time, but which I don't think is workable in general.
>
> Device tree files are designed to provide enough information to
> the guest kernel to allow it to find non-probeable hardware. They
> are not designed to provide enough information to QEMU to allow
> it to create and wire up all the hardware present on the system.
>
> There are specific niches where it can be made to work -- I think
> Xilinx have or had a setup where they were generating an FPGA
> model and a device tree and a guest kernel all from the same
> single data source, so they could put everything necessary into
> the dtb, for example -- but I don't think it works in the
> general case. As one simple example, the DTB doesn't generally
> have any information about how the Secure world works in an Arm
> system, because Linux doesn't care about the Secure world. It
> also doesn't usually have information that the guest OS can
> probe for itself at runtime.
>
> There has been periodic discussion of more flexible user-driven
> board creation, but that has generally been with the idea of using
> the QMP monitor to orchestrate creation and connection of device
> models.
>
I agree that a guest Device Tree is insufficient for describing a
complete QEMU machine model.
However, we separate the guest configuration from the machine
definition. The -hw-dtb option allows the user to provide a
QEMU-specific system description.
Those hw-dtb would not be passed to Linux Guest VM.

The fact that this workflow has been successfully used in production
by AMD/Xilinx demonstrates that FDT is a feasible format.

In contrast, QMP usage may end up even more complex and less
maintainable for the task of full system modeling.
To my understanding, this would need to generate too long configs,
which may eventually require some intermediate format by itself.

I am proposing to use FDT as a serialization format to describe a
machine configuration. Theoretically we can use other formats, like
XML, but in my opinion FDT perfectly matches the requirements.

BR,
Ruslan Ruslichenko


> thanks
> -- PMM

