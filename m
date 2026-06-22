Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38865CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 16:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbhBZ-00066g-Au; Mon, 22 Jun 2026 12:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbhBV-000661-Hv
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:07:41 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbhBU-0006In-2u
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:07:41 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-66310a69f65so2456570d50.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 09:07:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782144459; cv=none;
 d=google.com; s=arc-20240605;
 b=JVJEK62rmscJios/iXdpVtsDDue4PfFzXBRiOcUp7mRrTFjpmK7sbQAMoiTFkYJoYd
 MlJDducoB1Xo5bDUl6G8t4YjYHJM+g56uqTW/2KllkdMVKfVtOUKUzi3esJCbPnfuSMs
 HDREx8J8tmdrm0lRXVyUySlktFlB7Z+nOJZv4v1kMkpPg1VUEuxlEJgwKZBvHBEFXjRF
 b+97tyP4pMS8FfEBxo78xxEUV/AQVlgsvfb/+8Dm+pyrFvQ9ypscYGN9wzmdMTBizLA8
 30T2UKYz6j7U9QXjYJEQQNc29TFA8AUIDiD2ohNqhu/Y8j8IAY5P8V5cWArpmO9MyaKq
 lHPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XFXBYQvR1B9AsvIycYAgg9wXLkRe3WQ47h1nYEBLwjM=;
 fh=Q3krpAQIA0wAxp6tS0EmfBAbNCwv1IVxVd0z2YXKEao=;
 b=IqPreFHuy6q0CeOph3u+Hzi4VnL+lr4nT6+e36UMrkgiqDzI8bWjNnaclmofTpbbUM
 zT6hgp0BEstAeCsavMhmNEB+F0NNhgoy22HvI//PplHXhQx0MX+9LN/fajmT0sO3SvNO
 fM2qpQc/sKmYNAmM/G+QXPXvEH0kv4G1N2/BEJf9CzT8U96TTCN0XHGInxaHHJjKwiAu
 0aUZ0Ast9FHb/OLH7K07gjb53bjXuLh2SjmDh3lvtHJYZYODPB1FSoNO1u0GWYxW72ef
 SeeGpXyONJminCeDIdQsApvsVYw7pMhbl+KhcehdP58/U+clxwhlxiaMz9bRoM3y95RC
 IIRQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782144459; x=1782749259; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XFXBYQvR1B9AsvIycYAgg9wXLkRe3WQ47h1nYEBLwjM=;
 b=QUcAq8FKhWKW85D3x/l7KQAymnl4BKaCLEVBlREBXyJpou3q7D7NN6p5ejhPirijtD
 2Tfd0FJwDcF0Ao+ALDlbnd7Bl9Kn0iAoMZy/3WLMf7WnIwReqLiVu6XpM0Rye2WALDJS
 Lq9G/QWyisAjRI4/4J/iLwkBwStP7yHvzFiWKiZRxMsxCasNPiJQ0U7QsO/II07zUF/z
 4/xUCi1RnFVafvRqDXhLIaH74ZbrDTjWljmWuqAFDTNHRO5rkqUhfTX+3wdBrZj4bTqX
 wq4zRv9LpnQ/lsit7N2l+3NfI0Ktr/nSxhS9MzYq/DNfBfDxrXB1uf2klu7bfb7QlAZe
 TYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782144459; x=1782749259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XFXBYQvR1B9AsvIycYAgg9wXLkRe3WQ47h1nYEBLwjM=;
 b=ekiemAOX4vc1aLwr8pqrmbEphD+BQSzJUXZ6uXgUMonzauphd7iUdQqMpBnrM6ea1a
 XnUZ5lViWlEkQVvJp6Rs98qpTnCGrzbtCSBau1fYJnRU3qY2xEEqIFCHAI7WpHTPr42K
 EQynNuyqgxZsyPgHFVxgYWXMvKO6/eXoC+J+gm514XECp+6sGlNThUfe2yiqpz8ujoRC
 ptLcbIronblBn9aFZnbEDK57yExOum5XoapkkzKzQQ8G/A5nYX4sRf1Bb0zBivvWXmpU
 MS26IcG6YesoNWLiKBrRGcy1IpLj0jv0mAhx1Crgoxts3qM8KuWgXrMl/ShbViNIVeNc
 VNFg==
X-Gm-Message-State: AOJu0YyRT4U6c+x0AuXWMQy77j0kswRvh+Awt+nEFibhNTpaZJ+U+IeK
 Em+edsF3JoqQpnQjJ7VQgouFiXU7ipwxycdfl+QKTFAQF5+YW9WB6VeO00lNrOP7hhWIa1byhOp
 jY838cickF44+C59rkHHJBGbp5+YCCbjpEUhKezBAFQ==
X-Gm-Gg: AfdE7ckAWaeH0LY9XNaZ04v+wMgms8xMXNdVPcst6v+uj3p2hu7Y6zAVUPtXcLnLgEA
 9UqInKx9/uS7EHjESpxuZ/bqh68F1YQ5/ejRxG/BWbF8dwu6NTETReGu+XhfQeDUKW68+lmRQQ/
 uuZ9bi86mGNgMKrqqat/XBtvYmXAe52sXJiR2zlApsiTkUvc2PDEVo4MkCaNEDkruP1Sx54zJCz
 jbGFOkX3IvgrUGrKGQ3GV27rdCc2h8kL50r0L3Nx74qAjdJ5yux40i6fPDAQOsqKk8bAq5h0eNV
 2WoF7Z3TVke26SZsT3PAbuml2fYC1ymMK02AIt/2QVtB16oeBpudgIR0
X-Received: by 2002:a05:690e:e81:b0:662:dcac:7a52 with SMTP id
 956f58d0204a3-663032f5ee5mr12483256d50.39.1782144458590; Mon, 22 Jun 2026
 09:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
In-Reply-To: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jun 2026 17:07:26 +0100
X-Gm-Features: AVVi8CdQFZcZe9qHP4nGo_qucpQD1VPolgeNGwX947UE4Cv122fXpI5UTm5dl_4
Message-ID: <CAFEAcA8R1RXrGo2xov-4gKLQXX=FTVKoK1rGuxuYmBo9e8SN_g@mail.gmail.com>
Subject: Re: [PATCH v7 00/15] target/arm: add support for MTE4
To: Gabriel Brookman <brookmangabriel@gmail.com>
Cc: qemu-devel@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Fri, 29 May 2026 at 20:52, Gabriel Brookman
<brookmangabriel@gmail.com> wrote:
>
> This series implements ARM's Enhanced Memory Tagging Extension
> (MTE4). MTE4 implies the presence of several subfeatures:
> FEAT_MTE_CANONICAL_TAGS, FEAT_MTE_TAGGED_FAR, FEAT_MTE_STORE_ONLY,
> FEAT_MTE_NO_ADDRESS_TAGS, and FEAT_MTE_PERM, none of which are
> currently implemented in QEMU. This patch implements all five.

I just noticed that this patchset didn't add FEAT_MTE4 to the
list of implemented features in docs/system/arm/emulation.rst.
Are we missing anything to be able to call MTE4 complete
and close https://gitlab.com/qemu-project/qemu/-/work_items/3116 ?

thanks
-- PMM

