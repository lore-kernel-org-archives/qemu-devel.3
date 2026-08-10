Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D294C5AD4E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 10:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtN65-00069P-5x; Mon, 10 Aug 2026 06:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtN5z-000688-9Y
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 06:19:03 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtN5t-0006B5-Sc
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 06:18:59 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8234e9ea616so29272597b3.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 03:18:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786357136; cv=none;
 d=google.com; s=arc-20260327;
 b=PLlPBQt/SMUytr30510+mHlRX+xGisyNO9gSgymdEAhgfMa0FWC1vIBZz9MPwgoUVJ
 fXJVZf1W34ORpI9AK258AGpzda7WesN+D1BJbBdJeyLBtttzSLbOOIh0QxyPvjDrOmhl
 Pno8PU3HM1paliZl4UTszEcPfAvLh0WXZLJyHzlj53iEDXzmth99nTuNI3rgRXIvyugv
 BwXoIp43kB1vK9o47W5wqR4eSgG5YwvxCiUYViKHhaddwIxqUPEyEJdE8HeUmBhAP/z3
 ckjatbo2lU7LynMBbDyCycy6xYVaubSgl668MOcoSSLu+01BdHCWa5V5v7RXWUrJi8hS
 8sjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KjGGOlmt6rWRwRWp56TNU1pTez3dB6dxr0NAMgvxaAw=;
 fh=SNx52JZ4VmtgYx6k93mkLhKNLmqa6YuqOJGrexHj6QI=;
 b=T3jemzNk+LOdLZwAmjHkeuz5nuB4mrEAbeCJcdSsFpOqmNoGev/DjOB4SE8RnfSHWT
 4xbQYUIM5L9M9VkGwq0W4SEQbr0R9rd8ghW0yIx+6k2DWYQnEN2MrAAnct2bNWcEQ5J1
 JGVYagT8GKe3TKX7UmQhsuip78+gh/ItX28EcrEmnCNhEEdXsJD/Vg6Czx+pNy0vj2bz
 Ee+hTQlKddQjO+P5znLbCa81fgrjCZGXzWGyD+hKROPz3WQEEeFeNLcvYco11KnAxs+D
 U3cRjcPqImDDvlz8u6z4hpBTJfma/r9qrUir1jVUBoETFimWiiLAHoU09PvmURQ0sJbN
 3dCw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786357136; x=1786961936; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KjGGOlmt6rWRwRWp56TNU1pTez3dB6dxr0NAMgvxaAw=;
 b=XYR6CLWjFImioOK+H4bzHcLoOcQ1UNGE04hMyZTZJVXhlB9jVcZC7+TFnihWlmjMYX
 f34EfTkGoJScdo9XjkUarosU4TwqmP9Vs4/9JPsfLQybiqPq29++Na8n00Qz6wrbpqCx
 rcJj+l6JE8BqhRheslccURJ3dU/dpqx/BwTlKGYubvjOFJwy+cXjiRUmTiUXeJE38w7s
 MH/UiqKOevUiQ4VygZb/cnQe6+DLnQn0UNNTj/3DyFGQQQ11jgqfGyfUsbRcONeIVUnu
 //RZ1hoV1RzWA02M9Ywa5fx6UXrDTn2BwpibkgsRbNo7+vpc/x66ttcSxpU5CijS/BsS
 yiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786357136; x=1786961936;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KjGGOlmt6rWRwRWp56TNU1pTez3dB6dxr0NAMgvxaAw=;
 b=k8R3mw4VDNgGERfv6Y9lLa7IKAUS+yLw+qjY91Wr6xLvia6yqf7KYiy3CpmwWn9Int
 98yKUWxrWeLh52U4pCde4fjYHUExRr0FQKimeUz8S8iVA0Sg4dBDxU1W7yU+QrVI1WXN
 ReH9fj6UveFtVEOgk4fZ9+/1KRnfhuBht0a70TmhEh+ZuQUJ9vdANGZpCXOzeQnYhwu9
 RDMRMgoNaSU1+i1Bvmm+wJb5I1Tg4yUPMrW7XMxIRA+qwKe8o4oZs8mNMFD++15wGIxz
 PQyxpz1LCymRzqKf5DBLbJa/KFH4Ii+JT3YFVxtP9B/Z3kaHW/x1Xb4p/JNfhD9wM0wP
 CzaA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6IMQ1Q8HsApNCaqWFwFfeYa4ixl2CsCLQPh13u9V9MfIL0ChofVAtmkiliUuGgSNIEzIn4jI/3bly@nongnu.org
X-Gm-Message-State: AOJu0YwRpfOqUsWCKiqu9eQR/1i8Qofu4gctfq1GUz9DT23n/VOCyh3v
 f78lSotfhdTtk2tdQ6vNOrRqJSFEjg/YtOqXqQkNmkqdLiQQDaivYxKiHBdVwN0eXpA6IGm3B9p
 lcsJn4jEpqbC6wd/qd4teMfvF2rJawm6b4QpTxTd8Tw==
X-Gm-Gg: AR+sD12XIO7SyDAe0kdi+MtELGbuevUwiuoSD+wqbKZbC8eZ7eiIuZB4n/rR24CaAWa
 SL9jga3kWKELzqaPsbjSPAwJ+P6aIGoMP6CMeRvr2LkoryJl7O07fuVH72Zz6srOiMzEnKqjrry
 vthP4hgkFpzzZSCo00osc5hdv9/n7sJAb0ehhzWKkvziCmbhaxz9ArFxucJzKcrF9bd4iy5NNbt
 5HxV9aZEH75WJPCPkCgeu0xmi3KoNVxwiYACkmxLmGCT2k6rRWSxaS8u0f7lCJRJpDSyPO4s7fL
 Rzof9JtpAxqFzjcOUSlLfpqjkudIBH4Ir8CW9iKZC2SAZeOtv70LqqI8zQ9iFkK9sgjtn9SQ9M9
 yBbm0kHDmWtTXYtoKYoNWxmCYFfXuXp4vH0meFnc=
X-Received: by 2002:a05:690c:4b09:b0:80f:469:3ca4 with SMTP id
 00721157ae682-825ee6701d1mr99703847b3.13.1786357136087; Mon, 10 Aug 2026
 03:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <20260802154350-mutt-send-email-mst@kernel.org>
 <CAFEAcA-VB7kNn6MM4cF7Pz356KgkyKRaK0xMC2PTXYYCVVfLyg@mail.gmail.com>
 <anXuqbBXERqn4lPu@redhat.com>
 <be6325a1-8a4f-4ecf-8045-a56ec66dcd42@redhat.com>
In-Reply-To: <be6325a1-8a4f-4ecf-8045-a56ec66dcd42@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Aug 2026 11:18:44 +0100
X-Gm-Features: AUfX_mxeBmK5-5yizutsp7ABgFHgKVTtXu7qp6zjcJLnwnxVreVzRo3MzTKQ9MU
Message-ID: <CAFEAcA860fF_+ffk=cXiYyFoQo0wCSUJ6b=7nVLLCwKhP6Nwxw@mail.gmail.com>
Subject: Re: GCC, Conservancy and Rust AI documents (was Re: [PATCH v2]
 docs/devel: relax policy on AI-generated contributions)
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <bonzini@gnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Fri, 7 Aug 2026 at 19:43, Paolo Bonzini <pbonzini@redhat.com> wrote:
> No one is going to agree 100% with everyone else; the only possible
> equilibrium is going to be the current "no AI for code generation"
> policy.

Also, I'm not sure we even have consensus on what the goals
of an AI policy should be. At least, in my own mind I am
not sure about that. We might care about, to different degrees:

 - the possibility that AI contributions might later be found
   to be copyright-infringing or otherwise legally encumbered,
   and need to be removed again
 - poor quality of resulting generated code
 - that a large number of individually OK-looking changes might
   pile up to result in design messes and degeneration of the
   codebase into "big ball of mud" architecture (you can argue
   we already have this difficulty without AI :-))
 - that our already very limited code-review ability gets
   overwhelmed if we allow AI-generated patchsets (there are
   already human-generated patchsets which go unreviewed and
   ignored as it is)
 - that we don't think one-shot AI-generated changes are likely
   to be a pathway by which new contributors join the community
   in the longer term
 - various non-technical aspects like those the Rust policy drafters
   labelled as "out of scope for discussion" under the "ethics"
   label

(and probably others that I have forgotten).

The current policy being "no AI" on a fairly narrow legal ground
had the advantage for me that I didn't need to consider my views
on all the rest of this. If we relax that strong position then
what kinds of relaxation we're OK with depends on what goals
we are trying to achieve and what problems we're trying to
defend against.

> Second, the Rust project came up with a different way to approach the
> issue: require disclosure of LLM-assisted changes and hold them to a
> higher bar.

That's not really the way the Rust policy came over to me. I
read it more as "no AI for codegen, but with an 'experimental'
back door for limited use". But that comes down to how much
"experimental" really means that to them and how much it's
"not actually experimental but the label made it easier to get
the policy agreed"...

I do think the "pre-agreement and pre-finding-a-reviewer" parts
are worth thinking about; to the extent that we've allowed some
AI-assisted work already, it's had that kind of "pre-agreement
and done by somebody we already trust as a contributor" aspect.

Also, I would be more in favour of uses of AI in the project
that made my life / job easier. "More and larger and more
frequent patch submissions that I have to review" isn't that,
so I am not super enthusiastic about permitting LLM assisted
contributions. ("Deluge of not very interesting autogenerated
bug reports" isn't great either, for that matter.)

-- PMM

