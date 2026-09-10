Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C495EC79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 14:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4g1k-0001EH-Af; Thu, 10 Sep 2026 10:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x4g1e-0001Dg-Mk
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 10:45:20 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x4g1b-0004ZV-8T
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 10:45:16 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8565d77c277so99410347b3.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 07:45:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789051514; cv=none;
 d=google.com; s=arc-20260327;
 b=qU4YsWoBmj6g695i2dRWjKBEwXXJY6VD5QpSAtopibInc9vu6boTLTSHUdB33vUSrb
 7xnDuy0qUiTRKinie+bM9YE+goz35DaNJpv/WxfCyT5wZtCstAq4R7I3TTUrVQUnvPUX
 bZQWVgEIp/y9bCVjXITH+tzHDh2WVp/RrPY04Yxudpum2mJxC+gf+fW1twhoz9zVq4B+
 TO2RdSlZlEJIUCGDmds0GiFUNmj/9j8G0xSUds8vm6Na3HGLzv23jS/Dswe/VJi4E1Tg
 wsyhIvNcTiNVGNuPZcR/DA1VVLAL7EqnYVPrW4GMDoJuh8D5vmaubL+fhJws1HmIW614
 sm4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3wEWA+naB4Xk3UWBjGGWlFCL2JDAUCZN8RPErsVops4=;
 fh=anZl6Td6NaKjHGFM8y4oK3yu8UEI3L8plTd5OD+C2Mo=;
 b=cN6QtI/Ek5HqP7A16KvdqbJi1qrYClPrAgFvezh54SwRbXGxUbE4zBrVtFFY/t5rrD
 L80L8OKUsuOD2k/8xV+Ai68k3sSDOzT5lzhF13p1zsasJmY6pspN8zVBhRRjQWxUgAcT
 XFSO0hCZuN9L0vpqh8fWpsU6vBiKrLnjNMAMuBVr3gdJFyYYTT0YWIjrKx+SUvzHYRc6
 Eapj+Rp1I5PlYZNQhlhuYHfNLobVw+2xRCjH1wBjFKkhV1XS3wvnw44FC8auzBJjY/ow
 N1GcbHFYr6vv9Ac5NuMm2vzI9tiaJVFiGCPlmSqdkj62dSYdj9bFq22vDfnMxgxy+ha2
 tYhA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789051514; x=1789656314; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3wEWA+naB4Xk3UWBjGGWlFCL2JDAUCZN8RPErsVops4=;
 b=IyVEFbjm+9F+bYx4tPd9a6xRLrWuDQ7yTQ5IE/QBLo+S1gpVwseks9YTIDUjtO0bPF
 AsUs2UPY8p2eA7mkn1mZrlC3NsUaRbSV9hFSMkdboaoORUwUyVhg1RpMFZ2FFcsRXci4
 F5pjjVG2QIAQ8+RY1P0jL4l2OypC24wIEGNXtjM/M9gkAJ7P283qDKEg6C9Vin+dU+15
 KNM6rXm7WHR1ZkF99Nj5CuZVifqqQ40y3CLLvgDkwuHToBlGiYlEca84+X1rkm51LdRy
 TNZxZz1lHRLpO4Z4/u+iLX6PGmE2tqKFqzl2GTulQmlyAITt630QUocYVRgIAs7/C7xK
 u5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789051514; x=1789656314;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3wEWA+naB4Xk3UWBjGGWlFCL2JDAUCZN8RPErsVops4=;
 b=sxEhSi29lLvoCKywrkCMT5BK2+xhrrxhd/TGEr8d1pKdjD8J+FlwcyjfjDolx+IYe1
 U277tgcutzVbbh9aD6/SX7RzcWMAqEJaoVFSBoUDaOiYWElblXvPra/qGW+3OzETRHs5
 ixuY5t1AY7+ovQHbtHssO/lDcjxJbmgU+c2GdVqSmcKVLDq6tyMscrTcU98lpiJua8+3
 v4EeQcJbMYljI6Qd4uA72aF/3VNiIscl5W8Ak3yDFqgxXEqm0dKPXoaKBXLHiagqArn7
 gdQ7U+FVtTTCYtBzwbcNqf3XVzPBIcmbT/VT2PMl6O02ltsPaLQVZekOp2OP2SXkJRQ1
 5MGw==
X-Gm-Message-State: AFuF++kbkiLLEHDecfcKrQJrgw7i+ABAOma5GMHvEQYob8bcOnD59+7z
 sqisRZpnJXw208rJMLmtyEQZ48QmflEu2n/yGVsXdgfiEU3/Vv0M4fp7/auQPDGmVS8C5NLL0/l
 By72kdi95kKoJp4a0F8+M5ICjhYZpeMuKbTMtObhnR9iCpUbqWaC4LUA=
X-Gm-Gg: AYBFou3mpTzh5dCMUZX+3ksxKz6DQ7e5SSBCpkyuL083UrHDup7gDXq8zutv/HRTEPf
 lXVUvssr6I6Kw1XwR80fYRXXlnNK5xX24GOapj/zIij3osO17LPYI0VJeR0kXFig/uU+VDidWzR
 9KzVtXKFLVRAbM1HNSJqA6rnLir5342T/EBdVHZ7yjKNWwnLT5c9YDaanJFSbPrOzBPpTe+ghgz
 AAkZpXdMKs+wNSFNZ8Sr3FCoJkj8hLNJR13FnZZ0iL89e+lrwBLsBd3ocsqDgXedus6cXbSxLiS
 dyeJ2JYVXyWu/A5OsVy/Wj0vXgnQZTylN6gOpWK4Wcj2emryulT5Ub7UYZJXiSLiOhrEcsRABpt
 SX++8jnqvciN5Ay2whmIxPe4gLo/gH9x2cYaprGmY4kZU8O/AoA==
X-Received: by 2002:a05:690c:c:b0:873:5c6b:a2f8 with SMTP id
 00721157ae682-8735c6ba5e3mr136804347b3.38.1789051508667; Thu, 10 Sep 2026
 07:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Sep 2026 15:44:56 +0100
X-Gm-Features: AcwNN1VCO2GLJj9N0bpJb_wnNZjBakHIeRe8QHYMtSJ73CE4DHfh0sRNrGOexz0
Message-ID: <CAFEAcA8hD2+8uupWy5jZbKYLLUPwkvX9LdCEGrdVL20L1f7mpw@mail.gmail.com>
Subject: Re: [GIT PULL 00/24] Various virtio-gpu/dmabuf related fixes
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Thu, 10 Sept 2026 at 14:30, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The following changes since commit 257bf4f160c50ca8c4ebd603f519f5c786013f=
b7:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into stagin=
g (2026-09-10 11:08:04 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/virtio-gpu-pr-v1
>
> for you to fetch changes up to d26343c12d84227263b8d2fc89bac7632a98e00d:
>
>   contrib/vhost-user-gpu: disable scanouts on resource unref (2026-09-10 =
17:29:47 +0400)
>
> ----------------------------------------------------------------
> Various virtio-gpu/dmabuf related fixes
>
> Hi,
>
> While working on CVE-2026-66020 (which had a few revision on list), I
> kept finding several places where virtio-gpu scanout and dmabuf
> ownership was unclear.
>
> The CVE comes from using a blob after RESOURCE_DETACH_BACKING has
> unmapped its memory. Following that path also found stale dmabuf
> references, duplicated scanout bookkeeping, and inconsistent cleanup
> between display backends.
>
> Those changes touch a lot of area and I have done basic testing with the
> various backends. I would not recommend backporting them all to stable.
> The first 2 patches address CVE-2026-66020 in the general case and
> should be safe to backport.
>
> thanks
>
> To: qemu-devel@nongnu.org
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: C=C3=A9dric Le Goater <clg@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> ---
> Changes in v5:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v4: https://lore.kernel.org/qemu-devel/20260910-virtio-gpu-clea=
nup-v4-0-7d623714bd71@redhat.com

So is this different from the v4 on list? Please don't send pull
requests as if they were new revisions of individual patch series.
This is not the mechanism the project uses: pull requests should
be an accumulation of whatever patches the maintainer of a
subsystem has. Sometimes that will happen to be a single
patchset, but usually not.

thanks
-- PMM

