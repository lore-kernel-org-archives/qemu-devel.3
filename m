Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB92ACD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 10:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWu70-00009D-VM; Tue, 09 Jun 2026 06:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWu6x-0008Tv-QD
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:55:12 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWu6w-0002pL-9j
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:55:11 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-660390acd71so5238736d50.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 03:55:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781002508; cv=none;
 d=google.com; s=arc-20240605;
 b=KQdu9U9UZs4L5QWSCiyPu4hZe/hNfHmDrnTcbrpeVVR5YCyCNTAFugYzkcD7522PXF
 QSRJWXmqy6f9ASCcH+ehZIiLyE9RR2N5LAtzZLqoevldmNGXpA24Lv0aYbG5FbQCNxdk
 Obe0/7hB+2FXY0cEBTbLm4E9gC2XzlMx02qZa9TwUUGrGJ9QMGpEo8r3ozxmD4cP8KKh
 RYtP5LUAOAkKDQE08XjtPrb+k9jArRK5HCqZyZ6bAG4fFP9sKgkFcx/Naclhdu3K8fyn
 a8tSF6GORBIBDsNnZwKEVTLtLHxZazzSMeNDvITXbklUBqQ8Jd8WOtLsw3gIUUSZg66E
 Ekcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bAtaAFGZwzjrH775iZLAsakth7XvKzHJ6AENtKI62AU=;
 fh=VdU0ZIHHM7Xuu0AoHAY9TnsLw+Rmx6THNQ8Qxyqt4ys=;
 b=Yomh2sW/pxE1J427+MVzlcjqoVvJgVynoqWuHu7RmOHP411YiSDRlubMksRJpy+GV4
 AtGOPSIuAFymmPLX7wtlV+HkwOeBqLpxrzn+zsmnMiy4rSdXk0w9WBmm7l9xkjAbkKiB
 CYTPmObL/e06emaCAAkW7HMGTkIK37scZyrtX5ZvzYvFs7o9oKjTd1ko7KlugRDbV5qO
 ikWqYh8YV+o9BwoDHIPRXphduOfilgQJsaWUqmzajofnQKNn+c2sD1njKnhvGPDNVLuo
 2L1/nu0yhQ+aapw98GqsYUehSs49fI7yDsFCvidFx+G+ro9X69x/gh2voLPAnEMFb7qd
 eGlQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781002508; x=1781607308; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bAtaAFGZwzjrH775iZLAsakth7XvKzHJ6AENtKI62AU=;
 b=pkW5ozBZzpFONWIZbA6ooPLcbfFWDg714/GOXPS4FJBBUz6omBYOhRv693T9/K4MyP
 6vcEyp2A+2nePzS6jcZKKR8qz6XhbndhyhFkEg8e7y5dFZ3rUu6QVGaS3fOtzol2lmjJ
 gq7Qg89SjAAL9VTgxuuOWIE5BTCqw94dWB+uzKWc+J5P33sYGqLD4RT8+hB6CY1YUFpP
 trbH6aPJV/wZyALmG+QdVTS9ZFOLvk47kPzSJTN26b2WPPM7eaLFh7W6Zm2fIilt2749
 zv+GdK65dN2tHZr+h/2Y0pkHHVnbRvgQiQ5m4LPY16BhHZPv7UIQmcOIoJjNBJH7x35q
 xhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781002508; x=1781607308;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bAtaAFGZwzjrH775iZLAsakth7XvKzHJ6AENtKI62AU=;
 b=NEmQlGhHpUhTcVTizC8z4jhp2lqHZCqIzWNufzWai8wR4VXgD6fv935a2VBZiMvjaD
 wy9ePtaP2V5ux4h3SSuVQGstTJxvicUiFZhuTeEsiPxJT5IOYAkPxf8qb9kil47ubDKG
 y2maI3GE7cZkFItkRi5bLajTMcGAJGNvBZwEIm6IjBNzkXo7KuqfNOQInt7OtpssellN
 Nj347shKizNNNIlxlBGezEqYoFLQ4WjxjHOIOdLIifWu4uigfDmr51QkNAj3diogz5Jn
 VLsTlV2fy6GgAizmQz4rQeWllyJVzJk9W1+Ch1HvJYuaLUCH8hrEdMDSVbPnif+8a77h
 8DnQ==
X-Gm-Message-State: AOJu0YycSnPv7FXp7IM6JwA+MGfSlcZUXSLgQe2tKGnPztXMHS0/6rfd
 ductvHXG62a/DavRCEBT6vW9nwr8TMdqkgZ5dsqZtSY3GCgP/pfoEqqjq83hrlj0p/LDjNhiotU
 z0T3gTIzgnat/HZI1oX813fjHCPsrzhKg0KbFXOM3/g==
X-Gm-Gg: Acq92OEQU5C77hIL+4jNzQoaQ5911DXDhDAXxbshI/J5cLxUJUMpmjI1CvjxYTt/AxE
 H6SD7OHI8lHzYJQrbmtqo0jdkVS+LdKHEMWKDsP3X9GVZuAvHjI0pvFUQ/aSYC4SmuvTJeaHgyG
 JqY+pjE4Aa5f+iZFiBru6A01IKYRM/rTtC+Yj2VnX+6NPeQ7finSn//mhM9KGf5a6A2jJAyVsq1
 LtIOQn1kdrxt5c3gmEKI0dqv+F+7S+W7a0UNigA4xx2IXT0iTX7MUWh8ONoqhf4ZOHNlaxFBxfB
 ngAvuMGv2zoufBLHxbGAQlkGbWgUj7b/rMKvNqG3FKPBqfqGxgYGnneDqRUa2B0cDX5euswilol
 mjaYCV/EtBo63
X-Received: by 2002:a05:690e:1689:b0:660:38c6:8160 with SMTP id
 956f58d0204a3-6610a626fffmr12296040d50.2.1781002507594; Tue, 09 Jun 2026
 03:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260521112806.504961-1-kraxel@redhat.com>
 <CAFEAcA8hbObntY8Tp+kOV7btb-io92O9GW99-6SPxigPJUjPrw@mail.gmail.com>
 <aiE5LrpfnJRbkx-A@sirius.home.kraxel.org>
 <CAFEAcA_ow2ro3h0nfhY3jA_XToAnjdVFNPrF25aWLd=X2cnmaw@mail.gmail.com>
 <aia8iXGozAclWQCb@sirius.home.kraxel.org>
 <CAFEAcA9oB_-ao5C8fGYonE7njUMWLHo5-iETeN_XtnFL4PzyvA@mail.gmail.com>
 <aibALjyPTXVUDpDv@sirius.home.kraxel.org>
 <CAFEAcA-VQWKzJ-aNnzYHZ7a+sVP1y6tkUnE3YCPydsqP0uVXvg@mail.gmail.com>
 <aiflCrf0iDwcpj27@sirius.home.kraxel.org>
In-Reply-To: <aiflCrf0iDwcpj27@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 11:54:56 +0100
X-Gm-Features: AVVi8CcrerybwJGdaDfs1LfeQ9Yqbhb9iHGmu50RaWYSsjt4SmMagGtGA9gERmc
Message-ID: <CAFEAcA_+fZnFG_2xH2gXF7ZtGo-WVwAhwkz9ucuS5kXZOYShnw@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/arm: add support for shim loading
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Tue, 9 Jun 2026 at 11:10, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > With firmware qemu exposes kernel + initrd (and with this patch shim
> > > too) via fw_cfg, and the firmware can pick it up from there and run
> > > it (instead of trying to boot via disk / cdrom / network).
> >
> > I don't really think of the latter as being direct-boot, and
> > nor does our documentation:
>
> > #  - specify a firmware and pass a hint to the kernel to boot
> > #  - direct kernel image boot
>
> That is a technical detail which doesn't make much of a difference
> from the end user perspective.  And often people talk about "direct
> kernel boot" without drawing a line between these two cases, because the
> user-visible behavior is pretty much identical:  You pass a kernel to
> qemu via '-kernel', and it gets booted ...

As an end user I find them majorly different -- I usually
don't want the firmware, because it takes forever to boot
if you do that.

This is probably partly an x86 vs Arm difference: for x86 there
is always some kind of BIOS booted, but for Arm there
by default is not, and direct kernel boot is much more
common.

thanks
-- PMM

