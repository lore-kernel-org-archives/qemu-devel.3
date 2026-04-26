Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD9EFF885D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzC0-0000do-Bc; Sun, 26 Apr 2026 09:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGzBy-0000dF-7i
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:06:34 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGzBw-0000bx-Rn
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:06:33 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-79ea87af213so144287147b3.0
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:06:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777208792; cv=none;
 d=google.com; s=arc-20240605;
 b=CMBdE7uxelXDBsGNQxJ4q+BHpub8n0ug6/32Rs1I5nr34cCUnHmdoRo0v2L2yHoz3g
 4PJid0YuR0Zas796+5aaBIcNH03X+JWWKKf3j9qf9M3WRmSVG9RQoVedDIuGOotzNf0+
 NcUFACJnz8qY4ggyyDKdigjvIjW6sqT+tsFeV0cUj6Q/PC4AdZHDUWUyW86ikVzyo1FA
 WN4Cl20Asmkp0GzlAm/CTYplwUl8FBzwP3KdG2ozCXBI76BzvBdBoVR33rthvAJOPiGi
 JvOYoQeSHnl3WXzJCwQwr3PKsE3f5+yj2pyCSMG72FqZyTWy7kOuLNw4gJEfPYm5HwIc
 /4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VGCKUxLRvSSYVrr9yEqhR0e7GV6fSSp0ahgBUsJ+SvA=;
 fh=k+JQU2w1b4ymBVJgrCNZLxW9T1CiH07slgA3uwiw0DE=;
 b=CvMxr9SPOQ+ANisr8gEOSQnYgzTxuO6rgvePPq2xCjV+wrv2ZjY5Ud/TnqJDn1zzpY
 QwAf801mMO5tikHH9p+hjfPDgOm5K9rFzKpd5sjOIheHFxl2mKK6pbPGXhe7f+tcd5la
 8q8XG5Amj+7VM6Ps+lgcGVuEi1P/OYa3Atj7IUqagnE+g9C1nSFLd9GQZrgUCHkkvOQy
 bz5BVW0BiBrm4O4Bnzv9qIHNm/JM4J4xMmSMtI4mLI9BRUv6pD4qLqicIfcua+0d3sqv
 kSGiPL4DZlcMqpME/clfqZcmvjBxi2eE8OqbdLmTS3c2JMM0vAmaFWNA2VP/11FzDQVL
 QKXQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777208792; x=1777813592; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VGCKUxLRvSSYVrr9yEqhR0e7GV6fSSp0ahgBUsJ+SvA=;
 b=XbQqWT3fBk03PJWoV5N50Rhsq77sdf0sSSiOpcuGOEprZsvH/Vcw5+ec/zuZxz0kri
 TyqJThnfYyXwzVRV2UVB5n7wukrGK9XOQtHC6Ias9l2s6Lxzk5Qdy6Ibe/eomughPwoV
 HD+23QZxoYHX7zoo/J5J18OEs9fJg2U8rwwrbfdA2Ti0BpZQ9QwEj6mdVZa3X449Ih51
 Q9oud18Gtlr+33O/s1Jt9weOZhpjDNoQHfIet+0a9TqU20UaJanDn6+wobYSXWHBVRHF
 OhxzkcM+Oz+CXWmrPdyCp+eEoFRiChLAuWLbFTMWU5lhaCq9Y1Bnj0ixKtSakshjhIYl
 9rMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777208792; x=1777813592;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VGCKUxLRvSSYVrr9yEqhR0e7GV6fSSp0ahgBUsJ+SvA=;
 b=HszQBmLdcrGidkeyz5RqwN5LAXSpQQDE3Srj6eYOk/RNYL1uQhvfGtMQXir2+pb7CZ
 D9b6Q/wMJ/hQ4qcxEDNYHy2jgP2c1Xme5wzJ3Kp/hToUC008My1SMZd11aNjxLUHI5k6
 R6il1RNtq9qBrna5YlDF5V2yn7i368byrMmHR5UXjah+VtgZmuRwwn88zUHOLqduS6jc
 lOBY3LU8IBbvEkj17y5qj0GtGtbhe87YDyfnrFGIe5Jq6poPCRSKSFPkf+UfJELmAPob
 D8rcvi3pLaalawaSfln7miPB8sj1GFsN/WnNv+VHXYSLzVeYRe8qOKqVqbzI9Y8WpUnw
 Z98g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+D84t1Zcx0kVXfehr3uJMMMrXB13FUYInBP8HGUBrsLlAG6dAzrwyNeLvH+4IA/ZLcini3O+R/aVzk@nongnu.org
X-Gm-Message-State: AOJu0YwFPQb6h1SEo7kSWBqEkYPdMtsMiltpokQ1eFhY26Bfx4NR4Mh3
 F5JZc/2jaigAVSoKGYfJQDmWIGtawQA1io+DjLL6nqKw4jAmKVTPN9A0+dbRcsn3Baf708U0e7K
 xd/CTUQWI4jkI5z1g5a1fpXqde0fXetCmCZfK6sWt4A==
X-Gm-Gg: AeBDietEicwUICr9LtfsS+Y3VjPcl5wAkeS1ifeSMGBHkGNkU4bsUNLtq7SN5XBKZy4
 7U1h7Q61gdOywFCbVDgpayZrnobVrCnVh7t/1oPuHjJl3di1rTT+tb8b6OKhJi/Rzpo8QS+Bmm2
 ihQJFsZFBiZOJnQuOBu6Psf4+Bqtier1oxaOoiWcuG+EKUiEqZaKDgnUKzaipR69XoiO0/KQ+xe
 DVEPYH17fcoCe9RrKvmsXWIwbcXcr8AgluAM+AVPfnVCoVslYg7hpdlP0qtQJfp3dIjA4IDDkFu
 E9gzbpGZxGmlfHm82xkCIkAORX8bCXwKzSQydj/AVKj6NWQ9Z4zHeaXqOguj0UM8FSs5IUT1AQ6
 j2w==
X-Received: by 2002:a05:690e:4009:b0:657:33b:9df0 with SMTP id
 956f58d0204a3-657033ba8bamr6181342d50.8.1777208791658; Sun, 26 Apr 2026
 06:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260425144852.46590-1-deller@kernel.org>
 <CANCZdfoOPvn0JJiF5Nar_UNEWMzmQCvEiTKV1vbuVFy2qiMpfQ@mail.gmail.com>
 <d54586b6-8213-48e7-9e7e-2c966948872d@gmx.de>
 <CANCZdfqa2XU9OHt3kJATkaU2D+g2=afRdjNvYE0o6Hx8YvFy0g@mail.gmail.com>
In-Reply-To: <CANCZdfqa2XU9OHt3kJATkaU2D+g2=afRdjNvYE0o6Hx8YvFy0g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 26 Apr 2026 14:06:19 +0100
X-Gm-Features: AVHnY4J3-BFOxCuZUe7hxUUKaJnHtN_CbI3Xk2Cumve9jbkCTf4fZ3HcKVxB8TE
Message-ID: <CAFEAcA-9A+sFfaJEF=AcCPkpDB-i+fbdG_uvn==utNFHjCtwkg@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Flush errors by using exit() instead of
 _exit() in error path
To: Warner Losh <imp@bsdimp.com>
Cc: Helge Deller <deller@gmx.de>, Helge Deller <deller@kernel.org>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Sat, 25 Apr 2026 at 16:51, Warner Losh <imp@bsdimp.com> wrote:
> I don't think this will break anything. The printf can't possibly work, either
> we must change it to a write or do the exit. exit is done everywhere else.
> This has been wrong since:
>
> commit 03cfd8faa7ffb7201e2949b99c2f35b1fef7078b
> Author: Laurent Vivier <laurent@vivier.eu>
> Date:   Fri Aug 30 01:46:44 2013 +0200
>
>     linux-user: add support of binfmt_misc 'O' flag
> ...
> +    if (execfd < 0) {
> +        printf("Error while loading %s: %s\n", filename, strerror(-execfd));
> +        _exit(1);
> +    }
> ...
> but the full commit log doesn't say why.

My guess is that the "print an error and exit" if() block was
simply copied from the bit further down that does:

    if (ret != 0) {
        printf("Error while loading %s: %s\n", exec_path, strerror(-ret));
        _exit(EXIT_FAILURE);
    }

for the loader_exec failure case. That one dates back to
commit 74cd30b811cc2f in 2003, which changes some exit() calls
to _exit(). I have no idea why, and the commit message is cryptic
and useless. But it seems unlikely that the reason is still
relevant today.

-- PMM

