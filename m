Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C1B10F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYVu-0005Hb-AQ; Wed, 08 Apr 2026 15:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAY5v-0006vz-CP
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:57:43 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAQAX-00038V-L2
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 06:29:58 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6501547d7edso6363200d50.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 03:29:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775644196; cv=none;
 d=google.com; s=arc-20240605;
 b=Nqz5MJuP8wla+Nnke4WlC5JOu900Gr62eS196cJroH0WbhJXd8vbHuyUAi1F8N30gn
 XEze1/ORxAQWz7cd210XEzS8fgpWGLb/xCOFfenZA5pgxx7h8aaoLKg0J4S9x68i0EhL
 Nu1aHVNHJPI3WoOMqU4io0PR7vplCEqqet8ZtgA/R9ol6+NAXwHTiEjmvIiC4+MP5Krp
 1OkEMioPaS+8MHrFezZeblNtKYtxnMvLsfVtSetuKCRBTtRVfPGFEO5c2KaqmClC3/Ii
 XJA4dlOENegq4x6B6/1Jb73XdwovGD6AVT9vB+al2m8cG86MlOtYJxTuHJPDDoAAsE0s
 zvSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=JxJoYPmvtUxu3fCAqKpfdPmYYJ064fi1PCbqL1soQfM=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=l0u0Doqcg80BbGhQCE6IbDs6nuW5EyZe8ttM5Y8y1WRqlsY8/rm+UshPwPq4WjO/HE
 ggynYFvUdIYcPPUTB4olqyqmf1bHnQde0vW+vd+6zOLqFGWA46T/6GNVLEadLJKIHgq6
 lUjXGuZxWRgyONRBMOVqftPtB9GOsPV0xDAHSK3ZacrqS8R/FiozGN3tyszkeN3zuH6N
 KI4mRM8TKSq0vt5erMthioBSQ/tAmfBog0lKqLSah82ERA2wby3d2KltjxNji8AUR3LH
 tnIPN+6bS43IdeK/UU1ZBX9Sn0HZ+riDPI7m6oAeHRh2HZbA0itFHEVNtdyOTVI8eDE0
 I+4A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775644196; x=1776248996; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JxJoYPmvtUxu3fCAqKpfdPmYYJ064fi1PCbqL1soQfM=;
 b=ehl1xKnZE6uBQP+3aBtxftR76I0X8K6SbrsR2gqqLk+BiWxDl74CfMeBJ4mSX8GMVm
 82yd5fwSV2QUW/CKtG/d8wmbbc3Ldrott4ROa72xzbsx3yadGVjCE8pQDk+OFVst5vJq
 BlA+UD5R1ZPhZDNJx8XaLrKMEDtQpr7jZJEHla0/bP+3fbDj85BvhS35lbzT4y61LuiK
 tikLMxUDaHtMzECHk+DurYJgPOq/8WpxwfS8R7WFPKOxklxGEQJ8Ih9XD69EKWPEPUZj
 +axlptMT1WSqhFSonRZS08xwrcKWQ/lddKZLdmNZCA5rDxsq6o66cXwnvZIKxFgCaTgo
 QZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775644196; x=1776248996;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JxJoYPmvtUxu3fCAqKpfdPmYYJ064fi1PCbqL1soQfM=;
 b=MdlI6xqQ9qGKpmkS5Y0nvrM3Tz+TiRYN8g1wEVjKWBiNgYKWEXY4obg5DjEba1uHGD
 lLb/BkMXX9OgIHMMv7XanLWctS+YtutagKfxrkD6v6YahX2JibQ9BMNQb3AIadqTEFZ5
 y4uCxwRXWs4ODzlZxx6R/97kv2lbg1atBbYABcZcYwvk5lHFVGkaobMH1+zixVrdnHEn
 YAlhXkBDU16MZtkFc+R23OYyik3TWB3Dts1vhT6G+NvhMze/czq7QYgNhALmnd7/yp3I
 PsBThK0C1De0qDyjF//+D+Y4p1E6vQ+gYbdOQrI7+c1fjtmYtgxmfyF9R0iXxlDUjfts
 zuYw==
X-Gm-Message-State: AOJu0YwzJfxeBc5Frq86aS1MxYT9SOLcwL/+bmj8t0vwWevnbDY/uTlH
 MvHuenMEezHVvqZrh7Ajq3D4VaCdfjssfiRpHDApuekm+xvzhSwn+IHZzu4X6fj1yrT0CsLP41i
 oyY6swQgSU8LRdfu1K2WYnkH9tBi7Az1WoPGTCuI6o3x8gLpfyVPrdtM=
X-Gm-Gg: AeBDietTAThcWXwn1VB5uKwSRUAzR4TBB+jWIgzmSc3R8DFssxBwse6b20j6fSlrrqc
 orPBn8vExHtZpSTD98ihKLGlQ/KSkERgGPx/PZGDzXc1AIADm3OwHlzSA/Ib1ufOcGSgqloIzJL
 ueWbPmcW8kAaoIwyILz0B7BNcwJ3JiB5/1wjEl4gFl/HEbcGVlQj+Jh3MMYFMRPUqo1gYro+rN8
 QyfdkbbiGaF+/LKx/BOFrsM8ZMstbOjGKy1B6DVP0IyiK+LzUyxLxn3cOGLEyvnpwiwHRnYteMT
 1YZbsMfqyuoUtn2i7JN+nr+K6FX2VDIZDco+9oxAviVPgU8F6oM+d9UxLp2gXFMGHKY=
X-Received: by 2002:a05:690e:1488:b0:650:497f:7167 with SMTP id
 956f58d0204a3-650497f78e8mr19974089d50.48.1775644195948; Wed, 08 Apr 2026
 03:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260407175448.3329196-1-peter.maydell@linaro.org>
In-Reply-To: <20260407175448.3329196-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Apr 2026 11:29:44 +0100
X-Gm-Features: AQROBzBz76KriMj2pqWf7IxTjKLgHsop1ioGK4ZHTc-HM3zODc80w5KLIy--4Vk
Message-ID: <CAFEAcA8_Z4WtL4v=nK3AV9GrXkk8i8pbzh0aS0ErQ0n3bi+Y2g@mail.gmail.com>
Subject: Re: [PULL 0/3] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Tue, 7 Apr 2026 at 18:54, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Some arm patches: two small bug fixes for page table walking,
> plus one docs tweak.
>
> -- PMM
>
> The following changes since commit b6a7d06213e5d2f7d124d16418bc289c4a8a4b82:
>
>   Update version for v11.0.0-rc2 release (2026-04-01 20:48:02 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260407
>
> for you to fetch changes up to 8a9fa9ec99be2437a0741b6c74930e6d65dbcb0d:
>
>   docs/system: remove extraneous sentence (2026-04-07 16:03:54 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * docs/system: remove extraneous sentence
>  * target/arm: fix fault_s1ns for stage 2 faults
>  * target/arm: do_ats_write(): avoid assertion when ptw failed
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

