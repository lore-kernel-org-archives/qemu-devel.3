Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDF4E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1O5-0000ph-UI; Thu, 19 Feb 2026 05:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Np-0008KR-A8
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:35:47 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Nn-0006Ru-TD
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:35:45 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-794f701a3e6so7431057b3.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:35:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771497343; cv=none;
 d=google.com; s=arc-20240605;
 b=lrX30L0wdw/xtTu1wKHzhNBL7vC6tP7XdhqFUOfnNHWgS8a84Me7Hj0Nj8tsSpENmG
 rOp75uEBMMr42C97GcbWFQhWZr9ypDyjaZHiv5RM8n08jEo2Bc7I4KRvH7tmOzqBCpKF
 Zr8+p/xPQ+lqPBowDJFTct4OYH6Xe5MDCFsweIngEdHkLXIwSL6BGvcO6Bhg65WjOZHi
 0GiNUBv8VLsXQ/ivF4ltCPK5A6UlrmdgDYr2rAHfXPvQPKqxlb0T6qHcOTNWMj3b+2zp
 cthPeMKwRp1mDDyASVRDZPSJfJeCJ0PClJbphfNu3UolmUQbsd2jBRIZOYc9kZ96rxP8
 gyrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=n0tj6/+COLOKLzf9l3ZAhPDolvdhEu1WxIA0VMmVh9g=;
 fh=k/wqoA8f3JORtLZptWlQSxuSbBUUnci8tzFNmYX5rtg=;
 b=MDluQvqOUdr03eL5kM2lkBLD9geay5iuIUVMb+exmtvHMMfZTqwQDkWed/VnLX46Mj
 4nHbqU0iGVjnYXx3/l0eI11BrnbqY2F08GSURkY+IUjl6TOepn12Q9rPv5iefR51Mx9w
 8JYoY2GLHY7VJWwlWMWRMbM0xYjx4lR3XqTg1/fsRjTiL3Mj0PWu4pBTEcbfpNAbHy4Q
 e3QRtkT0cpX7OqZt9QedrFTHxYbdNJqhfmTDcsSsJNAYBqOq+swA0ZpcZasnHq/GScsT
 e+qu7Gm0dTaViQP9J7YzjEZBX54AgSju77tH1OGfoR8kBzvgZuEF14R9QPZ0LwPOotBI
 90/w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497343; x=1772102143; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n0tj6/+COLOKLzf9l3ZAhPDolvdhEu1WxIA0VMmVh9g=;
 b=MtEr2y0oD5ETrIgDbGSt2PoXUUI2PDMhOr7L0moLqmKmuUovYYblXtMouNZ2N5nrGF
 OteUdum1T84etwUzg3mYMLPVZtPuXVmguHOVZsNWst4k6FcWx+8bJC9DpeupbiBJp0kb
 fLSVxkdWi/KNMb7qyzVw1eID7jP/NTFqdkkS6SceZs6x3GNydNui0bObMIgvDTjZgFv7
 S/Bv9htqJLpqsMWe6IK0LzPrF8W1N2H/74uDImjMjj9BMzgR4yimrZVguf5sZTXTAq65
 jKJspfd6q/lSklaDRAjejKL+OHwT9BMVE0W8iJrPcOkH0/Wxkm3xHZcfVoGDq6q5yj31
 EsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497343; x=1772102143;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n0tj6/+COLOKLzf9l3ZAhPDolvdhEu1WxIA0VMmVh9g=;
 b=eZ02gPSR/t0PvdBCzEaUnNIQ7rhBk3hOGBIXAJmXAhEWaykj8TpM1oRXZsOodfvarQ
 W3BGDSNYmmDYOspvhSY72ktcjY6yyQcu7PpiD+rPFG7iIvByDzxcVd/fW460CsK0phCM
 6YH1zy0twRfe2CriurWg1W0KelA73FzwSiGR4R5TD8FE2yTtSGw7/Ydf1UBrdKbvVZ4K
 wOlmOXUPGoW4RTk2mqgX6HdQqfTe/gEt56Mo3OxzsqzZz83ODVyKdIc/NyMpMpoXA7xC
 AfKEjOakidzFmdP2WjouytOqZxwvY3rALwFlmZSyslqZ8jsJpLAOqHjuXYDRkiqU02d6
 ibyQ==
X-Gm-Message-State: AOJu0YxUDwbMqLEufdsBubguTeCGD4xwI/vuBnUoP9X8XB6JhIG9FMvv
 nSnB2pI4240GlfeeT15Ap9itUW7DxdAvfPK3DHR3gSSNvcIaDnsHGasAFIVTtjiI4WIZZF+pEH9
 5ebI9kqTtyLF/3bs9Chqn3SV3lc+xTXVUnB/dwq8E6Z2rkqAsHwc4
X-Gm-Gg: AZuq6aIHYkZBe+TvWWk7HF7q4k9RQPb13h/R6oeZEf3THqUfThdGhXWBJAnmHjg8z5Q
 eg0/fV6oEecnj6HhG9sG2KncyAbCGRemzTQicXi92xxraEvOJL20ZIp4a3eX8Cg66o2DIIfPAfi
 Su0kgn7n+23QSgLlwqCgpsNO3uGyOl0BB+aGITKClDqtzzYHRCsl/qKj4i4e6x+q4+0a7gAKFCd
 OKbge0t5Iaq/c6gh63eFuIqr+Bk43yDK/W+gzB8RR4G8J/84pCGHQGRPobHdKZXsoALCgPjLlap
 uXTod/31OQaM1CQIVJnFG0Bc+2Xo98JcsNAJwj6n1oqXLsQKMJig03/h25Vjq2u956A=
X-Received: by 2002:a05:690e:4091:b0:64a:dafe:fa6 with SMTP id
 956f58d0204a3-64c6137e245mr1818414d50.28.1771497342675; Thu, 19 Feb 2026
 02:35:42 -0800 (PST)
MIME-Version: 1.0
References: <20260218101729.92630-1-kkostiuk@redhat.com>
In-Reply-To: <20260218101729.92630-1-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Feb 2026 10:35:31 +0000
X-Gm-Features: AZwV_QjzSxo_Uky-J4xD0yOcOypPzewVv5zp52jxIajT-vkfgnUOGOLHk0wIeWs
Message-ID: <CAFEAcA89LyqznETULwNZ8ThBRzVuwv_1ieCC2QE=YpGTDFf-Hw@mail.gmail.com>
Subject: Re: [PULL v2 0/3] QGA misc fixes and improvements (2026-02-16)
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Wed, 18 Feb 2026 at 10:17, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> The following changes since commit ece408818d27f745ef1b05fb3cc99a1e7a5bf580:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-02-13 10:30:08 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/kostyanf14/qemu.git tags/qga-pull-2026-02-16-2
>
> for you to fetch changes up to 374f4676788ca1f1c5a33670efeafff4ce936f79:
>
>   qga: Fix VSS provider GetSnapshotProperties return value (2026-02-18 11:27:57 +0200)
>
> ----------------------------------------------------------------
> qga-pull-2026-02-16-2
>
> v2: Rebased
>
> ----------------------------------------------------------------
> Elizabeth Ashurov (3):
>       qga: implement guest-network-get-route for Windows
>       qga: Move CoInitialize/CoInitializeSecurity to main process thread
>       qga: Fix VSS provider GetSnapshotProperties return value



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

