Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA71606A33B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GZ21ORad
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUxx-0003xv-SR; Thu, 12 Nov 2026 08:35:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRUvS-0007VC-9e
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:33:15 -0500
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRUvQ-0008QY-0b
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:33:13 -0500
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-67c05273c38so5255098d50.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 05:33:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794490391; cv=none;
 d=google.com; s=arc-20260327;
 b=Tzj9np40J8fehNjob2xJuHoMjQBaCBJr4jmJmRI+lzbmBazZ2iATI7rYcL4TH1IBds
 s47S5/T37QjRjk47xjesAX7EZgPxxBvKnYHGpzWjs3KDkwhWBCHdCNJnw+T3sNRFBq7l
 wm6ff3dmwggnCFZYLy8PJsTevRqapLhLWgVm8WxzakifNrPUj4A+xY8crVH0hLvh22SX
 O5TRgkrjyQaMMosAQ9J7EUWtOzyYotU5QrNaVR/VuYhOapRKaagT4Ihi+37gFpugQufC
 nMrAp8kq7/eDY/OoGYB21gfFgy4r9rPjBu0aLjzd/Utq4orV9UQEqc7iVbaw/IFq2fV9
 I7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=j/CJtSaA6jqYS1uoFysMs10vIbcRN7XMYuQjghIZkPo=;
 fh=moE9uCgZWSmwMCLxmwPjCTiAckUxNe2NQFItMzw3Zxc=;
 b=Puhi/PiInNE6zNuVQMAfAHP9DhGG6OKLhy+s9VUql+atIWC0gbbrKTbQTsfsiJo3bG
 xx1HNWh6tSLJ/sWhQgBLIqhxnSD0TDQBv1Hd6T8tuI1s6Dk7qAvYAQrMyXxgznf7Mywf
 an0HWqzCvsoUto7sxt+FeIip7iYsHzZvh5cBzxq4IQmqWnz+fFXroh8r9zE3l+bAOmsD
 JbEpiaQlOgDrC+uERZhXbvBqqnASowBJ6CViEspBkuPWh3/SzQH6WHTJ0mhrt8PS2hGG
 dUrHzogGpv3UUTAsHSw5TLxgD4tDe9GWLgDPRH1hNs3iaPuLLHWCks/ThdiyH/ZUrv6M
 o3JA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794490391; x=1795095191; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=j/CJtSaA6jqYS1uoFysMs10vIbcRN7XMYuQjghIZkPo=;
 b=GZ21ORade2B4FQWkwkqmpHqvAsLqJnzfs4rxd4+aKd0vC9BjHec/M44ulHvnTInOJT
 g6lYejlxL8prR0YAM+ZSsqCrtGLSmOJ57c+FVFMRcftj1+jkDB0CIcjP79zJIxwHFBEL
 pJNTnlz3PuN1dVRh4NqUudGES5dw+T2w5NvoZ41iQkqfCKZZHVQQGxtLnxNAZy5rDhTz
 XdKoIaUCx5uvY9yNbqDZ0/X8ZRXpG9vnYzqDRU4orM2BOIKYuGRlFyiSxXqzTEAgezOT
 rlYDZmqduxIVXUxW8GJl5BJ3oyE0x9py0ddtLS+LiJ5riFzBR5IcUfNJF+UoBYb54Qzn
 OFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794490391; x=1795095191;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=j/CJtSaA6jqYS1uoFysMs10vIbcRN7XMYuQjghIZkPo=;
 b=myseMiv5HHPo8unMH/6mVgj3AT+DuAKzQlDDGBK1IxzmHQZV3JkU1GWWflGDbbpP5y
 ykvjBayfRxicxafM0o5MPS3OgHH1bxmqKkdFxvnrG589rxuuK1lK9MqvO2hqEp0iZIvB
 lPICTaDCZ0wm9PustkHV3AmJQCf8cfmNrHVO/RjwPljYLWnyFEK5VV0yswmo86jCj3MJ
 vuWN3kmQcnWV84Tq6KLCEf8gVX7HRQABVec4tF8PGnICbmrQLKG43F/8ErzIsBwmSgl4
 C8XWweB0CykyyXCNerulIapIoOmIWN3tm0XeBQe4FabjNIV/JFwNdngTSfuzh9uT6Tc+
 u67g==
X-Gm-Message-State: APuU4Z8VKAFcUbG5fQSXkB3ZKmG0aBQCOjHSZXR4lWq49cFfN3L4Qqt6
 24XJBiRkqwHAq80tN8t7fspxht929QYoCIfy6qgqaffrAyYKFOxrFuLTvFyhmp+nNC4tFRGXr7T
 CkxifX8DfT2z7fPL14KciWtO9c1UQoGhtZPAVHlbxtbHZ7pD8g2TbK2M=
X-Gm-Gg: AYBFou3jHf3wqu195AKj4ozA3V9UMY7Yp3/zQUtWCuMZ+5LfxJv3la70RinuokAi6X3
 5YIASiALRvpbNAXkBXjl3otfYqFh4KnCi2g08gRDV+FMlbazarRZOs/xqCIYYe4Zvt9ZTIk+0cF
 AbCft/4MOtsSW+u27wf1Pvxes3b9/rcqMduDq+V0+jiGIj+pGJqpoO1SmxjzC1tIfZv7ZGpyrGG
 rZ3I/Dxzw+4DhF3N/tR6Tc6MbmXFz7FjntC1DNVU0xLgPViZZ6wBEwlvfwnlbpDxjx5kTU1OoHI
 5AfZSemm5wOSLu6MqahOEtxMaxFbjSOqcfFPq4wjFKC9AXio4hA5C6krdOuJ0vSeoehmMx/swS+
 dSfMKn6UEaSpU/Wwtg9nc/mbflS+LVYM8+IKX8s5llVnqis9ILz/jdnCF+NQfnhZ8S/XoQa55Jx
 y3f81SnCNbMwcRYD6dOZiAzw==
X-Received: by 2002:a05:690e:12c5:b0:67c:7317:de93 with SMTP id
 956f58d0204a3-67c7317e7famr2538372d50.91.1794490390522; Thu, 12 Nov 2026
 05:33:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110180645.2072237-1-peter.maydell@linaro.org>
In-Reply-To: <20261110180645.2072237-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Nov 2026 13:32:56 +0000
X-Gm-Features: AclHuK-WSQfPG9hwsoXuANu8c2tVwM1edaklHgFkYgt_ZPKQ0k4EKLW2GEc5lAw
Message-ID: <CAFEAcA-z+p2Qf9SuEcivLUWXcXuK97E1rE5_0rOjNiBM-W23Yw@mail.gmail.com>
Subject: Re: [PATCH v2 for-11.2 0/3] net: Consistently pad short packets for
 all backends
To: qemu-devel@nongnu.org
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, qemu-stable@nongnu.org, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang <jasowangio@gmail.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 10 Nov 2026 at 18:06, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Changes v1->v2:
>  * squashed old patches 2 and 3 together -- this fixes the
>    problem Akihiko noted where patch 2 makes us stop padding
>    packets going backend -> hub -> device before patch 3
>    puts the padding back again, and also means that you can't
>    accidentally cherry-pick the CVE-tagged commit without the
>    required changes that used to be in patch 2
>  * added reviewed-by tags and CVE tag
>
> Patches 1 and 2 are reviewed and ready to go in (they are the
> actual fix); patch 3 still needs review but it's just the
> tidy up of now-unnecessary code.

In fact patch 3 was reviewed and I just missed that it had
been (the patch in this series has the r-by tag because
my tooling spotted it even if I didn't :-)). So I'm going
to queue these via target-arm.next for a pullreq I plan
to send out by Monday, as they are a CVE fix and I think we
should get them in sooner rather than later.

Shout if you'd rather have more time or would prefer them
to go via a different route.

thanks
-- PMM

