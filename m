Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD991099B53
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 23:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3jTX-0005Sn-Rv; Fri, 20 Mar 2026 19:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <landonclipp@gmail.com>)
 id 1w3jQe-0004d7-RH
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 19:38:56 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <landonclipp@gmail.com>)
 id 1w3jQd-0006av-Cy
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 19:38:56 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-509134ab2d2so21072071cf.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 16:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774049932; x=1774654732; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NPOeYfcd3a8RIxnu94gsrILewZg9g9bl+gIZgb4Msao=;
 b=Y8SBsRYsJXJKKYLKRpj349E1v2OrFW3I9fb770M+cHQsYbiBnQV8d+ueGFx3NBaSSv
 vMlogyF6Xo8PBc8E4KJS0NsnCpy7fwgDdr6DECkXrigm4SKIPZIlCEhvmo8qmPxS9QTB
 ewE+p31jlN9jicF7zLw1x7ozFumgFDByneE0tJiM0+UudoO8F4rMU+0VwcpHny+hUzY+
 akOSXLKeanKWIWu1SfJ1NNb85aJgP7IVk+ahqwCvaSH3Zc4WJx/n/GiNYgynVb/9Woio
 ZrxWKLC6RJkuWw/OZkghBeWz9b3t5VtJalOYF8/PN/XkARlQU3dAuqotN/si2Wugna7T
 +/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774049932; x=1774654732;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NPOeYfcd3a8RIxnu94gsrILewZg9g9bl+gIZgb4Msao=;
 b=TCYlxP1PlRKhpPdvew7sbtpFf6GmuDcLMVh/ah9IqTOMzostec0pcHthI54K9GbTrf
 ET3Cykc7Gabr3UEntR3Wc5/d+RxDQMbN/3fcXVFUrxR2p+XdMnftyfS3qYVCLgJ5+ANf
 HJw//EVR3CYMqPK9H4W06ZLblUmBnQCmRDFu7T9Z9RWEiZXEcP4HmhCDSKzreCZQXChn
 vBSDB/9hJEM+fCdSYQg1966qSe0rRTYpz/6vBzg7TotItSEC7n2j8RhfO4yR66aGtZu0
 zs1Bc7vr8q39hdl0R/IxXGcC32wAxX1jqz6wWKMP/O9pdt9kVDuqqg09fiwjFvf/qEAb
 SFCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDqqDbx3LHK7W/jl8i/UahkTsTPkiju3WmgjaIzDKjYrUEO4+dq68M9Kpv9zaZWdgjx26GL8szmt/o@nongnu.org
X-Gm-Message-State: AOJu0YwfGoGY9DaYIFg1jTWrdP1c6PJzk63gakxCMbQtFfvLerwlS0aW
 cu9gSirfFSXe4eKlPUapJ8iT8wcALBozdN3YAtE4zAo7imIaNoi/O5Y5
X-Gm-Gg: ATEYQzyxx5nivTqoG9pFvOpmIUMf0ZyV4swQ++5H+eEdM9tkm+/P2kc/adS7equl4Xa
 /lIoSaJjnnqE1kOPOMXAS6F7QRjW5Rwjauv0/pkXWl/T1wgcCyjlOFRX5T2H/F2jgtOuNcSbiwm
 JhODmjzMmUilzlTzcK4fvE0SB7v3Ixp0dQ36ujAy9ykPAd2kv8D22CGFouqkFiOPUuQbm1yNMa0
 E4sIGAU8lOuZ2WQPkeIm/QOI7SqoVf09q/BQp/zXnnL2tCAvk3G8tMWnRdMosn+Yt6ZaWZTgMK2
 ZlUoJ7w3qtolS2zglP0USe5Er2P76WOodtX2kzod4hP2QJZk2rmhUqgIdZxE9gzL6d2ZvTZcJ83
 vAQW0SLsapf9r8CG97IC8iiOoAGeE+vr7CD/NDrmwG8z1LTgzWCn2WYrfXd5kGk6wPyXxaUbC5p
 Ay1Skv2fgi47Xo1ZLgCShVRzM7jqQgCWiXvS0Mh43iLcXlJYDVeEGzo7qgg58pjDbbx9j58gCex
 AU=
X-Received: by 2002:a05:622a:848f:b0:509:61:b22 with SMTP id
 d75a77b69052e-50b37566620mr53148851cf.57.1774049932015; 
 Fri, 20 Mar 2026 16:38:52 -0700 (PDT)
Received: from localhost (c-71-194-28-115.hsd1.il.comcast.net. [71.194.28.115])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b36cb2e29sm35646841cf.1.2026.03.20.16.38.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 16:38:50 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Mar 2026 18:38:47 -0500
Message-Id: <DH807PW5SQCW.3AA422QQRGVAH@gmail.com>
Cc: "Peter Maydell" <peter.maydell@linaro.org>, "Auger Eric"
 <eric.auger@redhat.com>, "Xiao Feng Ren" <renxiaof@linux.vnet.ibm.com>,
 "Arnd Bergmann" <arnd@arndb.de>, "Alexander Graf" <agraf@suse.de>, "Magnus
 Damm" <magnus.damm@gmail.com>, "Laurent Pinchart"
 <laurent.pinchart@ideasonboard.com>, "Wolfram Sang"
 <wsa+renesas@sang-engineering.com>, "Landon Clipp" <landonclipp@gmail.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>,
 <linux-renesas-soc@vger.kernel.org>
Subject: Re: [Qemu-arm] [PATCH/RFC 4/5] vfio: No-IOMMU mode support
From: "Landon Clipp" <landonclipp@gmail.com>
To: "Alex Williamson" <alex.williamson@redhat.com>, "Geert Uytterhoeven"
 <geert+renesas@glider.be>
X-Mailer: aerc 0.21.0
References: <1518189456-2873-1-git-send-email-geert+renesas@glider.be>
 <1518189456-2873-5-git-send-email-geert+renesas@glider.be>
 <20180209085024.004b6f9e@w520.home>
In-Reply-To: <20180209085024.004b6f9e@w520.home>
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=landonclipp@gmail.com; helo=mail-qt1-x833.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 20 Mar 2026 19:41:54 -0400
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

On Fri Feb 9, 2018 at 9:50 AM CST, Alex Williamson wrote:
> On Fri,  9 Feb 2018 16:17:35 +0100
> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
>> From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
>>=20
>> Add qemu support for the newly introduced VFIO No-IOMMU driver.
>>=20
>> We need to add special handling for:
>> - Group character device is /dev/vfio/noiommu-$GROUP.
>> - No-IOMMU does not rely on a memory listener.
>> - No IOMMU will be set for its group, so no need to call
>>   vfio_kvm_device_add_group.
>>=20
>> Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
>> [geert: Rebase]
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  hw/vfio/common.c              | 61 ++++++++++++++++++++++++++++++++++--=
-------
>>  include/hw/vfio/vfio-common.h |  2 ++
>>  2 files changed, 50 insertions(+), 13 deletions(-)
>
> NAK.  I'm opposed to no-iommu support in QEMU in general, but accepting
> vfio devices with no-iommu (which provide no DMA translation!!!)
> transparently as if they might actually work like a regular vfio device
> is absolutely unacceptable.  Without DMA translation and isolation, you
> might want to think about another interface, I'm not keen on the idea
> of corrupting vfio support in order to blink some LEDs.  Thanks,
>
> Alex
>

8 years later, I was wondering if we could revisit this. I found myself in =
a
need to use enable_unsafe_noiommu_mode due to some systems I'm using not ha=
ving
a usable IOMMU. QEMU is being used as part of a single-tenant workload
sandboxing environment, and given the specific circumstances, both the user=
s and
the administrators understand that enabling the noiommu mode is unsafe and
cannot be used where security matters. Regardless, it's still something we =
want.

As the administrator of my system, it's under my control whether VFIO is pu=
t
into this mode, and if it is, I would expect the remaning software componen=
ts
to respect that decision. As is, the system is unusable because of a lack o=
f
support in QEMU.

I'm happy to elucidate more of my use-case if it is helpful, but I first wa=
nted to
gauge your willingness to reconsider this under a different context.

Regards,
Landon (CoreWeave)

