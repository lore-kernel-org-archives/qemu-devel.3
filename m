Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5BAC5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 16:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siysV-0003vf-Lm; Tue, 27 Aug 2024 12:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1siysP-0003t6-Uo
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 12:17:03 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1siysN-00081j-Th
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 12:17:01 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5becd359800so6348073a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 09:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724775418; x=1725380218; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gjiBlenLIcwCaCBQ4MnwJn6nAsA7Xvz8vcK+2BMgZ4E=;
 b=I2LNkJ6oSAGJQkr+MEiRI/3YuP3NRLtC4EMsOO4vLyqSAVeA7Ok5COKXslOowfISFm
 bbd/1fYZrwQHNfdJFARzONIE7rG0KbZ4+PP3Si7EAF7a0qRaZkrCXl3fjPfZw7kuUpby
 l0BdRN39SBUI0MJxi0vsiDUaPb8hy4c4I79wwsr7tOU94bCKgYR8j6INfaAcOUpBtTju
 p+y5X3PMDGAoyy5cyEIz+st3XdUIOGIP8hhBCZJd+SVGXam1cBlRLtbVkVSveOEomC//
 slG9Xim1rLP1EEBvdVOjUVZhAtW9peXyo9F1wDhdZc9a/HuA6q9LTWF0Do2Eg86WGq4V
 3MCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724775418; x=1725380218;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gjiBlenLIcwCaCBQ4MnwJn6nAsA7Xvz8vcK+2BMgZ4E=;
 b=dxK7uOLFAWCwVYDSexGu+h0L7WsSCAAp/JqYTA2+bQ4OBsrL+4/Ic/vBPaHaiZTN2o
 SGHGHDU47+XeLH9jxxj7OOxDZBIKnRDASnYYCfZI6bky3BhU8Ilwpq/m5JB58yNZ/fAb
 dfpJjxgNUwbosWjLMgRzhKRANWueyTHPV9ZV9P+RawmEGThVx+L/+9na9BBdakMC3HFG
 gHd50g7mL+vqSx8TNVbte75hONaFljZ1kG2qAHt05Cyu6A5AAcq6fkUVNkfHE9zPbMMj
 ZbxBsIjqSU0r2/hO8Om8BVjWuD8Z16TGudH7K1QZ4vsHH+TdN6J944Y/G8KwBo/JtWUi
 VFWw==
X-Gm-Message-State: AOJu0YxvhxfHZELYbmKxAAMidjzxhbJ20kCURtat4ZN0TmTCwvSutOpG
 E08wiaR5PX0rnmT+tHOiKzxMfwjE/TnXZHAa/4xW6gPYT33PPXEjVI/jHtvUohga4Mgd0TfZNjs
 +rGfpjDyh0ZzXfXGytDAMNFxSflkyAcDlL3V+cg==
X-Google-Smtp-Source: AGHT+IF7O7vEdqw9V481FvZDf9Elgr+LxpQZznoDNDnWDaaX5SdQp7vdlTE1W9mJxSRuT/0y+C6zMr5LmT5scQBy5rE=
X-Received: by 2002:a05:6402:2692:b0:5be:f101:9296 with SMTP id
 4fb4d7f45d1cf-5c0ba2a47d0mr2652995a12.8.1724775417529; Tue, 27 Aug 2024
 09:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240827083715.257768-1-david@redhat.com>
In-Reply-To: <20240827083715.257768-1-david@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2024 17:16:46 +0100
Message-ID: <CAFEAcA-Xm+ye1q2OzXO2Jsc0mXeRV_BGczown_yV264VHhnMLQ@mail.gmail.com>
Subject: Re: [PATCH v1] softmmu/physmem: fix memory leak in
 dirty_memory_extend()
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 27 Aug 2024 at 09:37, David Hildenbrand <david@redhat.com> wrote:
>
> As reported by Peter, we might be leaking memory when removing the
> highest RAMBlock (in the weird ram_addr_t space), and adding a new one.
>
> We will fail to realize that we already allocated bitmaps for more
> dirty memory blocks, and effectively discard the pointers to them.
>
> Fix it by getting rid of last_ram_page() and simply storing the number
> of dirty memory blocks that have been allocated. We'll store the number
> of blocks along with the actual pointer to keep it simple.
>
> Looks like this leak was introduced as we switched from using a single
> bitmap_zero_extend() to allocating multiple bitmaps:
> bitmap_zero_extend() relies on g_renew() which should have taken care of
> this.
>
> Resolves: https://lkml.kernel.org/r/CAFEAcA-k7a+VObGAfCFNygQNfCKL=3DAfX6A=
4kScq=3DVSSK0peqPg@mail.gmail.com
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: 5b82b703b69a ("memory: RCU ram_list.dirty_memory[] for safe RAM ho=
tplug")
> Cc: qemu-stable@nongnu.org
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

I checked, and with this fix (plus various others I've sent
out last week) we can run "make check" for the x86_64-softmmu
target under asan/lsan without getting any leak reports. So
(at least to that extent)

Tested-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM

