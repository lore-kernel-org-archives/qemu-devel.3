Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB43F46447
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w24zd-0002Qs-Vx; Mon, 16 Mar 2026 06:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w24zc-0002OS-03
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:16:12 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w24za-0004my-DS
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:16:11 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64ad9fabd08so4643734d50.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 03:16:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773656168; cv=none;
 d=google.com; s=arc-20240605;
 b=RaxfuGg5ydO8Jqu0mxw339T2pvv45CnKy2O0EieigIb0Q+SkkzGfuEy3D1EQdTtgdc
 VHO0M7NPS43b15+ie9kDLtU323wmJYlht8y6XHOz9DomXVWj/0xu4MVvbxIPw7WaD88S
 2Epdd8fmPr5J/fkOZPxzv6AN02vV2MbzSFr/EThoecLjqYTlag2O7QJVFbrkisdy1eFm
 zla1KpY3/VlDdwKb9wq3EgcBiee6zsMIX9BXbep2AVkqV05ggIwHe/BAiZF5dMVHfytD
 7emrWLYDmd4Bgyso/Ph9wIrZXLvWL5M12T3pdrETHwWuB3Aluubeyj9BBM4pdQ/YMmhc
 Ag9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KBtTHbchl8BVnt+wihrT4O66oryNkHN5cfbIdwz+1DI=;
 fh=o9NNXRRpR1snqmakVgbq3eXDVCQ4hGFs6Xd9sNLXLEI=;
 b=I3HjaYpDQ3tZ/uMDlCamMeOUAoYC5K2lMQXemrtutlSz5UKKeQtoJH9e79sr+HkMfO
 WDCsHzwngZMbgG/dcucmUH+H0dE1gnEFa5ygN2OhybeB1Nd4vEsuSVua68YMygej9Gee
 cxVVNUMdLuCBwSwmPFSWLUSRcksZ5gyAjBxNwEypwNrqr35nLhEaIt5aKONZLg+7b79K
 VH/Lb7P2fv4W9O5ZX36sDWtRh9Viel4nMHcYa86L27Qu/iIh54YwfyoDKgL/1s60lSWm
 RYoXE8XOmAvoGigYnwNLU/wR4WgaId0dJjYxni91KfsumBzb57iBhtEgoETvpvJnhCKo
 PAtA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773656168; x=1774260968; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KBtTHbchl8BVnt+wihrT4O66oryNkHN5cfbIdwz+1DI=;
 b=wSKufxc/7d+jJntx6cdGBRz/eVww6cAOELrF2Uy/oFowu8Pw7oBRdypAo7N1xhKKLJ
 /xed4VRpvN84gS/W8+qxuXH5w9b8RSj/et7bo+ICLRU8Wh0BIymmxu7cIhD6MMGBzE3l
 HD1nsdh7zuLW9aJ5/6jnViNCSKAx+PokRsEa9ChzAg8G0vNidfudK0bl5K7R3B/M6JfB
 mQg3KqSK1IMJ+EvIlpqUNcOpGonErgwZv5zh3hsEs+W+gjbFCj75vT30ITKIfJhhmZN9
 6UFYFft+zVbhO4Un2Z6mIIroLj+ePorNPkLNPKRW3LeizeOLAMCIkX5Hk7qOy0tpiGSr
 C2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773656168; x=1774260968;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KBtTHbchl8BVnt+wihrT4O66oryNkHN5cfbIdwz+1DI=;
 b=dzQ7McnpBnFtoBGNYVhcrTHItZVmAo1PdPVKXAgIcMjBFzYdVsNX48NFYp7bZdApWB
 noVbZpkHEacUx61LKU5XgZSiHQdbLHbeWHSmabW6/YSIdq/TCunR9Bz6laWb8IKAQjj8
 o+vuyni5Cu3sO5pEkkTGsEj5DvJ0Y1P+aYoDngDNrirf3TMpmI2kZp7rIQIEIMpGZZpQ
 MuuXmWNyIEIYoYObSU2oE7Lp0C7qyBMPQXSZkWWG9fEdGMCZJHyPJJZHRMyM2MALyrXB
 ISmv9wj8puZThSwrUlgVgcU7akMV1USGqfRS/NFPoW9WwizhPxutQMv6azlXnd1JELhh
 F4Fw==
X-Gm-Message-State: AOJu0YyaM+9xemH5IwNlpHeJW+u9xw88LZ6j4yBRDUh7ubLfqXCT21+X
 gU6bB4LemRHZ3yvOuqp11EF7aT6CtNZLksCWKcCzlaACXUIXl6aLhW2vIEIpbfbAGdab3u4gIwe
 HW2hza4VH34JLEBSLIKZeftSOAWraZHEUTEBLw/Ndpw==
X-Gm-Gg: ATEYQzyU07AV88WgEMWEKsfhqEY+YnFyj+eKelSltNK0RxaeHvWa0znfRzGkpvqW7EF
 dOqwP+wPnWpdAaaEpttQrp1y/AhcjkWPvXT4zqeduCP5qSuFHXtt7nDa0OuNSgRc0r3n9ipAbcj
 5Y++BeoTHgGeRNtqGH1X6zlfKFYlFn0aN/IFbHw1vzOD04ZuvJbK4McZVmeevuuEtfE2V+ce4Q8
 C7j1OUYsNk0RXvMDi7X8w6WPleP83tUH3dJSPLHmYM58KJK1dWM9yr9bRIJUEj6Gq0AbASen1gw
 qKWrhdXIN9wwff7K5hQLnzaWAWdcwRry9PeIj1/hOsdhmHvkUonfFIEWM7kywuvZ6ms=
X-Received: by 2002:a05:690e:4146:b0:64e:7240:ce24 with SMTP id
 956f58d0204a3-64e7240d1fcmr7377286d50.26.1773656168470; Mon, 16 Mar 2026
 03:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260316071005.91624-1-mjt@tls.msk.ru>
In-Reply-To: <20260316071005.91624-1-mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2026 10:15:57 +0000
X-Gm-Features: AaiRm51EYjcbh8Ypj0jkLdAARfWfwrxt6IftmH6jT_z2Yz0PLQusxdmfQXjyGog
Message-ID: <CAFEAcA8+9Cxs7k2TyzxEx31GzWoAP8TN90=DEtVLUpvdevYdtw@mail.gmail.com>
Subject: Re: [PULL 00/14] Trivial patches for 2026-03-16
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Mon, 16 Mar 2026 at 07:10, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> The following changes since commit fff352b9b6080e580aa1fadd29b4eccf4cb292=
2a:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into stagin=
g (2026-03-12 15:21:06 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches
>
> for you to fetch changes up to 4ba98cfd263ba3e657b9d18c90bc5a4f2dcb0c63:
>
>   rename CONFIG_EPOLL_CREATE1 to CONFIG_EPOLL, and stop checking for epol=
l in meson.build (2026-03-16 10:05:25 +0300)
>
> ----------------------------------------------------------------
> trivial patches for 2026-03-16
>
> a few patches accumulated in trivial-patches tree to date.
> A larger part of it is my linux-user cleanup series.
>
> ----------------------------------------------------------------

Hi; this fails to build on some configs, eg:

https://gitlab.com/qemu-project/qemu/-/jobs/13506360670

../net/slirp.c:72:12: error: =E2=80=98get_last_str_sep=E2=80=99 defined but=
 not used
[-Werror=3Dunused-function]
   72 | static int get_last_str_sep(char *buf, int buf_size, const
char **pp, int sep)
      |            ^~~~~~~~~~~~~~~~

Looks like one of the patches defines the function unconditionally
but puts the only callsite inside an ifdef, so if the config
means we don't compile the code that calls it then the compiler
complains about the unused function.

thanks
-- PMM

