Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9EAC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 09:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM2PL-0001ZU-9k; Tue, 25 Jun 2024 05:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM2PJ-0001ZL-AZ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 05:24:09 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM2PH-0007L5-LB
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 05:24:09 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57d1d45ba34so5629337a12.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 02:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719307446; x=1719912246; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ruYUXHZ62lTWu6iSk/KN/vNmnmYzxVcuA4afnOxRtSM=;
 b=woONqvNTV8uYdIaKML4o20QzwwGdt5ViF6hUnDviObleN5fNsmst3uBuaJ9vbzXk2+
 4QrJGzLVHK0D+9EWYf2e+WEwYhU5MXTag/Pb0YWmG9OG4pXaKDRbFr0BQKtl5HN8H1nW
 LAACHCpQzxmFKt6ftBYxYHaB1xCjC8wnSCZd/VetwP7tAY2rRXVEfQWYMlVH7RBeRkub
 jPFUZy0RHpgfa01dAV2DuJctXERWyoo1+XwYfA6k+fJVKYeoHGQHR40EEHQmm7ApKzrY
 tlvsx27AbH5MvrV7GIBtoLEySGgKdx7oUbFn3YfLCvwPcBP3/H1KlGZJd6oHCdB2jYCT
 qX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719307446; x=1719912246;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ruYUXHZ62lTWu6iSk/KN/vNmnmYzxVcuA4afnOxRtSM=;
 b=A3QE6S05f3Tc8ReNS83i0wAIUACHYaRFCFVQKaEybchZTXyulXxgQP3rTONszh6iLx
 PLHSN7xm0fHIgRY2yw3oA7COycRyylTFrQL3sHEKtCyDHKJ46uDrM+/RKw6nmPzB2djm
 1HlofTaww0Z2kyBmK87a9UYO50WjTw7c8VKR6PWKtKoY1g/hRLcuZdQ16pcWF1BijFXQ
 nsgSL2NXqLBgozSkslu1G0YpR9H/+n2p8fK3mtWYG5zLMzhKZLo19C7JPUarYyr4Iljp
 yASKnnzNMdPchpw2PcciPvjtVoL/QZIjjPqRqOiUK//I9/TXPQGTqn7elhFYeHVvNrL8
 6mBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4KGa65K/M8FnPrOkKWzI5vbN5fjLhym0nlPbC6/2dCL64+M1fS413JA0+8v2tM18uwGfoZEOnmE2jx7QaoSj6OY9YAt8=
X-Gm-Message-State: AOJu0Yy9GjzKu5X1MAf9xVgTnolsgcmrfEBEpOJ7SkoYlxjOg19YkCMk
 IlGBY/RDgznkLL5HADmu7hi9QZMXbmz4gOUIP53xIAK7udJ2ULG/xr1PYgrIGbYTQ9fE7q1hC6L
 zT0oculnwiR248TT1+nOneQ14fVP1drKwbKBN8A==
X-Google-Smtp-Source: AGHT+IGUYYVYfwsc55jichi1AFTKV8o+ao3ZtkWJXfuRedLM3bHi14AWrPyNUqhxI4Ur3wB0yNWfcZsCBjum+b5H7mQ=
X-Received: by 2002:a05:6402:26c5:b0:582:5195:3a75 with SMTP id
 4fb4d7f45d1cf-58251957824mr674993a12.39.1719307445903; Tue, 25 Jun 2024
 02:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240624204400.103747-1-flwu@google.com>
 <d82916f9-3f5c-43f1-a545-0f5a30c8459e@linaro.org>
In-Reply-To: <d82916f9-3f5c-43f1-a545-0f5a30c8459e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jun 2024 10:23:54 +0100
Message-ID: <CAFEAcA-HdxjCau=6p7fY5=dGY++YS-GHkxufLJ6-n3rD-GQofQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] qom: Rename Object::class into Object::klass
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Felix Wu <flwu@google.com>, pbonzini@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, peterx@redhat.com, david@redhat.com, 
 qemu-devel@nongnu.org, Roman Kiryanov <rkir@google.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Tue, 25 Jun 2024 at 03:20, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
> Since you are posting different C++ enablement cleanups,
> I suggest you add a section in our docs/devel/style.rst
> requesting to keep headers C++ compatible, by not using
> C++ reserved keywords, etc...
>
> In particular because the mainstream project is not build-testing
> for C++, thus we will likely merge patches breaking C++ and
> make your life harder. That said, a C++ header smoke-build job
> in our CI could help.

Unless there's some easy mechanism for contributors to check
that they haven't broken whatever our C++ requirement is,
I don't think we should define it in the style guide.

More generally, we specifically removed the handling we
had for being able to include our headers from C++ source
files. (cf the stuff we added in commit 875df03b221 for
extern "C" blocks and then removed again later). If we're
not bringing that back (and I don't think we should) then
we're not actually trying to have our headers be C++
compatible, so what are we aiming for?

thanks
-- PMM

