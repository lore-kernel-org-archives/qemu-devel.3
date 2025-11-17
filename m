Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A94CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 11:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxf5-0000Bh-Uh; Mon, 17 Nov 2025 06:44:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vKxf4-0000Ay-MT
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:44:46 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vKxf3-000313-4v
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:44:46 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-71d71bcab69so34862337b3.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 03:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763379883; x=1763984683; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mh42pQFJ66OqpZVu6hLshqlNoH1FayhCS+/Kp0WBPcI=;
 b=iCpiZVlwAeBUHKptAe6nTlDhurIgyKH3Xya5wTlBGIVJPAKbdZxo426HblCgM5IeBK
 jsVAWl3/t6GarQWxnmah/wlq7YfTDQsza+B9JBRTX9l4X0qYOvm/dQxhfSo4KOdbQgYf
 1+/6EwZatCzNXsCKj2GpM96cCDrzFw99WV8zcREi3tR14LIQUwSx7mqbYTCwONRXihpn
 RNFIGiLexuIiZSwUKWgircF2z9m0UqUqHFRunyBSp1D8QkxSNFJEy9vYbewluNzbQk9c
 g5p3uByENKJDdOER35xTFA+85jCuaTLAlHsV/ZaQE1pfg3rlfeZgdU/6hW8WMb3Jln/Q
 +i/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763379883; x=1763984683;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mh42pQFJ66OqpZVu6hLshqlNoH1FayhCS+/Kp0WBPcI=;
 b=HE4BqectEB/nm5yhVXvFnnyhpLKOo2EGNrlNbjt/FFFUZyJ8l7Kq46XLOMSkkW5oCS
 Twgs/aaV1A8gkievcAGnvnlV3XgPdA20MjaN+tCPuiFRCrQCN064Vfu/Uikr4pOSJiUJ
 SygftHNca0HztBVGZ8WkvJdxwZmJHmWePaDmPZl1B+WPcRu32yYo94SevNy1R30UUCrE
 Cb10qZ4jJGUs2FqhI2lpR97iiPkqyjeZ4b6IMJpBTC1FYVSUyFMsGRBPUUkjYhXHMsOh
 RIuUNh08D5ec5SInL4Zy3ppevDJZYl6QsAgZ4FlgXQQ0ZrBlOabtAQ/9qvrvcQuO7V6O
 /THw==
X-Gm-Message-State: AOJu0YyzDnCfPcyBZj2N/UC9T3FOjtkjAjRpSkFNeAZCkO1l3knox3Xr
 JugRahJZNlWqxPs3QjG61xUdpkCskOBAohpcpXgsLUdgsGyYCIfHLMYPj9cKUp/YX0n7rSfhzgo
 iMnx0+o27k3aQXTMFcWhKMZm458vz26dW8aFzpIPzXw==
X-Gm-Gg: ASbGnctTtj1ZOkTUjTb9Uiz6UVf2RVzkWtATrOa6PH1NZD3py6uWaFsIDG7iLkpWqCi
 xg0xXtqkq19VTDMF7sryuzcaxhNZyeMuyFs8+uzRwhjXuK8uMjruvvnS+TNVWcaZVGq0cmtm20X
 6sOKcuc7MFiTukCvWKXR6/ukuSgNncFJnO2rD5vwRWuwRkcFsntvyk7ToTJOSVTwAJ7jT7bPbz8
 3lDXPWMLnDEDF38ehTUMJuo2xMiKiEMWrTkIeHVZV2mtveMPE/jttDkD6mfgHIWlbwIHxps
X-Google-Smtp-Source: AGHT+IH2HpKa7rJc8SgXWbNjYHEDlmj0k1nTAZ8nfHZSIqbx13YEXuZQaj5LhmXBC300W39Zg3mWWJFJKlpEVljAFz0=
X-Received: by 2002:a53:d008:0:b0:63f:bdfa:640 with SMTP id
 956f58d0204a3-641e755eaddmr10036584d50.25.1763379883008; Mon, 17 Nov 2025
 03:44:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1762698873.git.mst@redhat.com>
 <20251117052608-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251117052608-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Nov 2025 11:44:30 +0000
X-Gm-Features: AWmQ_bkQY0srTWKPLdcX_1hwQVo4SYQEzuFuHPjHFjTePu6mOVWW6OaDTwz2atE
Message-ID: <CAFEAcA8KY=Cro0XHQe6ZoPPTVYgyOUMxzqnyiz0CD5_RRnZhWQ@mail.gmail.com>
Subject: Re: [PULL 00/14] virtio,pci,pc: fixes for 10.2
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Mon, 17 Nov 2025 at 10:28, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sun, Nov 09, 2025 at 09:35:09AM -0500, Michael S. Tsirkin wrote:
> > The following changes since commit 917ac07f9aef579b9538a81d45f45850aba42906:
> >
> >   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-11-05 16:07:18 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 97f24a0496be9e0a7216fea1fa0d54c1db9066e2:
> >
> >   vhost-user.rst: clarify when FDs can be sent (2025-11-09 08:25:53 -0500)
> >
> > ----------------------------------------------------------------
> > virtio,pci,pc: fixes for 10.2
> >
> > small fixes all over the place.
> > UDP tunnel and TSEG tweaks are kind of borderline,
> > but I feel not making the change now will just add
> > to compatibility headaches down the road.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ----------------------------------------------------------------
>
>
> Is there any issue with this pull request?
> Just making sure these fixes have not been lost.

They were merged last week (merge commit 593aee5df98b4a862).

-- PMM

