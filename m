Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514B9E7E0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 11:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpmDi-0002mf-VM; Tue, 10 Feb 2026 06:47:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpmDg-0002m6-Mq
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 06:47:52 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpmDe-0003sj-9c
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 06:47:52 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-79430ef54c3so37042137b3.2
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 03:47:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770724069; cv=none;
 d=google.com; s=arc-20240605;
 b=QBn9GUVIhj8ZAormZH5yn6r0Xqf5OaRybvr/cJlALJd2Qp2JDlrl3hAvl4CjHbexRa
 16YYqJLKMTYBurbAWzsA6Ns7A+gEFApYulI1EcpReH/10x2Ble/AFE+6tAcHQaSO1aYg
 4PyHxeRJm5334fLmX1WisiQiJ6kLkdJq1X3O9ZtQpkkX3aCOkSp2fbnKb6YxM1MwUp84
 W4i1K2AkWgT+o9jx2S8C9mgWKJa9PLNGSJOTOQHZv2XEUwwzp5okOavZXVeMaHGGMVcy
 QwmRp2YU+Lz69t1js/jmlWNUmU5yKOL1wpqrjikkbVRZb/T6je4XNsEhxh5rjvOXz1vD
 4psw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NbYdlMKOlPbPQEzXWmVw5X1Vspmiq+h9MkdYLhOibzQ=;
 fh=/H3IPXbHkfJ7U92CFkuy7ATs0nyti9jVtYEI7Xvu9DI=;
 b=QiUjUKvzCJEIYEgeWhL16GMFEXPAPJRFshXIUcsdjHNPx2KJSsAcuCfJnQxgjVVZ4V
 MXjzUIK0ZaLkbx/NPidKkPSoSZieyc9ueXUaV1tON/dQkYTBnhpYvnVMd61Bnk3t95eL
 2zAxDqKxDk18CM5ZfIgGzABt0zIwP/kFhZqMZ9eCVGldZF9Gl6gXLshViPb4fSE1xYW1
 HXqk123nMjDLya6lPs0WEX6V+9wiJuZlKJ0Ncgmms9T7qWXpO86Db5hoFgs6MnygTScy
 7WO7PYy0bpjQ0I70nm3Hr5PPY0/w2SrP5llOv/EtTMFoDlC0MHgENHcCra1ZBkj24iAH
 yXrA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770724069; x=1771328869; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NbYdlMKOlPbPQEzXWmVw5X1Vspmiq+h9MkdYLhOibzQ=;
 b=ePPlwP8o0ro64+MkEK4Rs1BKvebbB4ioLdVtOdeD/6o3kngMhCkDHuTw0tUXcgl9eB
 NBHV70Mpcuz6URLibtngCEWMeraXMQ0I4HZN/QYLa04L35dwcGS7fF586uQZ08+0r31l
 Vs8+vUqeOjObOTGlOzLFbmgPeK8rM0b1qlewoUcO6GVeELKno9szjWJ0XN8ymtrKzSzz
 l3MGGVToTSqxS2xFIfodZgi74S6WY1T/7Kb1sOVAIUQf7JOy8m9srGZuxS5m0uW/Igl0
 tEOWaLGcNzYRY44ObF2p0YDP+zGhxy/pws8cSWo2yhx7aTpoBVZLjId0cGFgKk2RTPDi
 N0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770724069; x=1771328869;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NbYdlMKOlPbPQEzXWmVw5X1Vspmiq+h9MkdYLhOibzQ=;
 b=JTh0jyQBgGrt63AV1FtWeqPO3Cs9AtV3kgoDgsdZvtC339XnuRUETkCguv4uUZgBU8
 85ZL9bCSX49TBrqTKyLk/JJwpKvTvJ5hiOcIx8BChNUbwM74OgI+BI3kyGZiGr5ioNQ+
 6lKSE0p77n/FWa1DJMxy+F8C3gArGKs7KrajbZykN6boxlCICNSwzsFjjEa309jKzJJO
 izE6pZ3jICT9mt1zQF/jnr7pDWhQdKI8++0lXsYuvKzyDgYJfPrawMAOd5ZPndV5bPtZ
 H3BU69MdC/K4qS2ckRWwhsmJj/lFqmF6mPCRDIG0VTzTKBBmDA3kTjrbX8yWlHOnefFD
 PIGw==
X-Gm-Message-State: AOJu0YwTmdwJLAxdj9KwJiWv0So0GZi0ftUQswBFLwb70Iov98pzEib6
 /vyQw4jg3rLbRECYqeSA5l4pd2AEOFD+FlfT/YEjJ5nEhtzP214FfR97LXU2iAKysv8d9yBWq8L
 xY3tyliY9xAtLHy6GM+CLxXK5N8jwsgYIPz71doINzg==
X-Gm-Gg: AZuq6aLueR10Rn89uT2ogENIcMvzD4uFAN8XKN93oc/cEcm2/Q4/+N8mdJvdx6jizx5
 pumy6+66bGfNEiGsovQAzj39bphCXcIP73LgVQFENBV/IKwimL+lgqljQD7FkaB6tD/Jek4MTrz
 139oyJAW2mjq3hHsDm6codPcV0UyoMQh2emxH9Op/Ge0OOiMWD1WqRqrMlJP4WgqvsJUIlCALT4
 G2tAF6VvZFgF8WPE0KoSV3xW46ZbM5ql++25nfgfU/NeAPIFaMCmxjt8lqshRqcmPjp08edHOKe
 X7bORiWo/4PXt3mvCae+oeF4C/FC6Yw8JKbuFFedsOABTOiOuoeE7UMeKWYnM5FfbIQ=
X-Received: by 2002:a05:690c:9b0a:b0:795:616:434e with SMTP id
 00721157ae682-7952aa91578mr149545207b3.16.1770724068943; Tue, 10 Feb 2026
 03:47:48 -0800 (PST)
MIME-Version: 1.0
References: <CGME20260209052236epcas5p4039ffceb22c042b5d12a01f4694ccee3@epcas5p4.samsung.com>
 <20260209051931.122531-1-ashish.a6@samsung.com>
In-Reply-To: <20260209051931.122531-1-ashish.a6@samsung.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Feb 2026 11:47:37 +0000
X-Gm-Features: AZwV_QgBgcew-j9MZ53q6g33TB82NIP2KESM-C4bGUELvk4NE1LyCMIEcII17qo
Message-ID: <CAFEAcA-v3WMkmUu1dhOpL7g-x+Mzy54fBsj+rwBHKvEW_BNejA@mail.gmail.com>
Subject: Re: [PATCH v4] target/arm: Implement WFE,
 SEV and SEVONPEND for Cortex-M
To: Ashish Anand <ashish.a6@samsung.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, saurabh@samsung.com, 
 vishwa.mg@samsung.com, y.kaushal@samsung.com, ashish.anand202@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 9 Feb 2026 at 05:22, Ashish Anand <ashish.a6@samsung.com> wrote:
>
> Currently, QEMU implements the 'Wait For Event' (WFE) instruction as a
> simple yield. This causes high host CPU usage because guest
> RTOS idle loops effectively become busy-wait loops.
>
> To improve efficiency, this patch transitions WFE to use the architectural
> 'Halt' state (EXCP_HLT) for M-profile CPUs. This allows the host thread
> to sleep when the guest is idle.
>
> To support this transition, we implement the full architectural behavior
> required for WFE, specifically the 'Event Register', 'SEVONPEND' logic,
> and 'R_BPBR' exception handling requirements defined in the ARM
> Architecture Reference Manual.
>
> This patch enables resource-efficient idle emulation for Cortex-M.
>
> Signed-off-by: Ashish Anand <ashish.a6@samsung.com>
> ---


Applied to target-arm.next, thanks.

-- PMM

