Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C49BD25B6E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 13:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl5tE-0003Ur-Cp; Wed, 28 Jan 2026 08:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vl5tC-0003TH-8O
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 08:47:22 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vl5tA-0001WO-Ij
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 08:47:22 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-78fba1a1b1eso14635677b3.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 05:47:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769608039; cv=none;
 d=google.com; s=arc-20240605;
 b=J77qeuEJ/UXDqkH3CXPbrOTZKxA61rQfN/rEzrPoHBXcsEHIWbl2EwCoqK5cYfgqxy
 5eODaWVtaaQKqXAH8L6L3rXB4e0sIinnR/d86PzoduZFQsr+yov38mYATi0JfRvpgU6N
 KvRLRVqaCNC10RhEFCYwhDbw3KnB5EidHZnPir+rcyN+n6ZoPKpG+z/yFuLmnGppTHj8
 1YcJLH2RN/TacHkw/YNmgdgkQNEFTqUI9A7gzgB5j0ONvy0EIIJkJ5/gzbpkfbeLZHWh
 aerlhLA8RssETYhzeZqBA91d1R/zYpEoACENAWmp4qi4oPgu9M7NHGDY0Q5Qefsf+Gaf
 S9Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XthBvk64XF7dOx5Ux0xttMlujNGM76qeuQlMDMyHws8=;
 fh=vLO9KFfxIIkA8uYnLhuQfjfWDZsQ+vEXGoKtckzy40s=;
 b=bT+wYE59qHzubIaW468bhYo4FLb0QmfQDYiwXOBVLQMF7mIv4BYQgBwoq3kOczUGMM
 tWwgtVuwef8zmmZTDxvOGzwk92NnpSHPgaeKcC7IOAIMyqXgD9nR8frrq/OJ0ukwx1oI
 pbCnvnfX7aHLTwlaipzvR/Bil4UIAWl9A7zImufhnWKAi7RQOpcW1xTe5/hlfmz3EVwH
 FWk4DB1nwuifx1wUYHUIii0jV3Yp+sTn1cWQrZFkfSlxkBlPTDEFsWpBZ4vC3faZEGEU
 7JuV6+2q+8iSDoApj+K99Lsk+8LtNF83HzB7aYvx1X19nmkNIbSNYBBC8impq7KL6FR7
 EwJA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769608039; x=1770212839; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XthBvk64XF7dOx5Ux0xttMlujNGM76qeuQlMDMyHws8=;
 b=oqpGsn1C4NQEgZYVXkxs6+TNQtPKtuIenOPTio3BiaLqKLhga1gmzmSHfygQrLbPk/
 /AMJTt+dyJK9JnAPkjCG4UcWWuRuf8J93FGeFHF6ut6jTP9JwJp0Zfo3bUt8WFuwoJrw
 9YIizH8GNafTqr7/LSJ318+tsHyXBMtV068XQajQn/JMYniedaLTEeO0lilnSWtROTos
 R5Ghq254IlAPy5u90fMh8b0rs1cp6IPGevmed5palPkCGjb8C+2HVMyyoPEOaQfKzAKR
 mM3y/3wpCiiZIyh4vGAOsvpIooQlSono66utcNT2+GyWLmCASpXVjXEaEpTlwjv1sgi8
 xB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769608039; x=1770212839;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XthBvk64XF7dOx5Ux0xttMlujNGM76qeuQlMDMyHws8=;
 b=QHkx+3Es7FULofhX2VsEVNPrVA67SNBvQeIiYjK5Ht6ZCQ+04gqmFQWEfnwkamFc8f
 Awi8VylahYiGySfxB+F2VRu06cDdlILOIf07LY3GFZLUTAn5WhfsxRUEoRccZdnQF17J
 I8KTUsyuVzc/5lffSYwtAWBv03YVNi7cwtUzw8BSPt/WsmJY+KHkV2ptCZv4QW3I46o1
 TbjF2SQW5yWlnFMFfq/I9mYzFSuMUyJd9HBltseS7/ahhHRi5dzirB4bA7qNU9epLTnR
 COSW5fBBJuviB2uv+ySpjEMsNRwra9FHjjUhx6gtBs8My/ncXbGafrtguCrWa4vq0Djq
 6QWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMOarY+5JQTNm+bPM6P7H1lxqnetVWQ4LXhnYVsBnVrnefxQT8u8rmAwpQTkopBpV9ElItKIAcYMCQ@nongnu.org
X-Gm-Message-State: AOJu0Yz+gUZCSa/pYD3xMCSzSx7P9hEhXyPAmbfWyK7SixbDbTmILMU9
 MkqWcWoTCm5vpn9dkWApYgTsy4Qd8dLIVK5ITFDDp9FeAuNZRpG/XBk3l1+TV+tfIqu8CuXYNff
 MmQMDxZbA3zgpp+s3ZzwmDTmlg1Xt/+PCu1qVbceanA==
X-Gm-Gg: AZuq6aLpqUaylMdKTfVF5jiuUc4Bc/s4R2yS+fegH3ElHbDgh/DJEab9/LFfbDpBbYn
 ExwHTW7mfT8JYxF9x6uVNZXfYQWEgYCKjRXTrAkXNyA4JWvuyTxBEo2qxjHj4m/dkKFTg8gxern
 G2aMwblmRxnJO9EpKohy9+1UkeMk6/IgjQz9AOYkV/mKQSOnYXDUqPfWZR8ZYHNPrUZZF/vvSta
 34axmKpp2nl9GOgsXHSOXHnqyuFjzypZq/s+TTy8AOtloxyfufD48CbPfhdZiTRW28JQ9JjeQQS
 0YVP
X-Received: by 2002:a05:690c:ec8:b0:794:87bf:76ef with SMTP id
 00721157ae682-79487bf788emr10858577b3.7.1769608038928; Wed, 28 Jan 2026
 05:47:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1769362313.git.balaton@eik.bme.hu>
 <CAFEAcA_jS3hef=dhxZ5s7MReSW4ir+jMUGwu+RjD_JP7ZRrRXQ@mail.gmail.com>
 <0118dc9b-d467-7f6b-92a8-4f42760ecb6c@eik.bme.hu> <aXkXWGho7lnJ-gwX@x1.local>
 <2fa59d39-5634-0b8c-27ee-9e9548a7f92a@eik.bme.hu>
 <562f0e5c-7ae8-4d95-9dd4-674447362ef7@rsg.ci.i.u-tokyo.ac.jp>
 <cfacf068-7663-6c7f-4908-928bb63e803c@eik.bme.hu>
In-Reply-To: <cfacf068-7663-6c7f-4908-928bb63e803c@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Jan 2026 13:47:07 +0000
X-Gm-Features: AZwV_QhgEfh2dfyL6etJTtG7hFZRjmy3Z8n49ecubf-OHs76bZMeN8V0MpRg78E
Message-ID: <CAFEAcA-8-jC-HJix5YFVbmg3sEuhcSMD8gKJxzAiz=GPy0sw9Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Implement memory_region_new_* functions
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Wed, 28 Jan 2026 at 11:40, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> OK I try to summarise the motivation again:
>
> 1. Documentation in docs/devel/memory.rst says that memory regions'
> lifecycle is managed by QOM and they are freed with their owner or when
> nothing else uses them. This is also already implemented for a long time
> as described but cannot be used because the only constructors available
> kill this feature when calling object_initialize that clears the free
> function added by object_new. (The life time management is implemented
> through adding memory regions as children to the owner and unparenting
> them on freeing the owner which decreases ref count of the memory region
> and will free it when nothing else references it as far as I can tell.)

If we have leaks because of our very common pattern of "embed
a MemoryRegion struct in the device state struct" then we must
fix those, because there's no way we're going to convert all
that existing code to a new set of APIs. But I was under the
impression we had already dealt with those, because MRs track
their owner's refcount, and don't have their own independent one ?

> These are my motivation for this change. What is the motivation for using
> embedded memory regions instead and against this change?

Simply that it's a consistent pattern we use in a lot of the codebase:
the device embeds a lot of the structs it uses, rather than allocating
memory for them and keeping pointers to that allocated memory. We
still have also various older device models that use the previous
pattern of "allocate memory and have pointers" too, but most new
code doesn't do that. I think we should for preference write code
in one pattern, not two, and "embed structs" seems to be what
we have mostly settled on for new code.

There is an argument to be made that the pointer model would
fit better with a possible future world of "the user can wire
configurably wire up their own board model from devices", and
that it works better in a part-Rust-part-C world where the two
different languages don't have convenient access to the exact
size of structs defined in the other language. But that future
model is not something anybody has yet really fleshed out in any
detail, so it's still a bit speculative.

I'm not actually opposed to the idea of making a design decision
that this struct-embedding is no longer what we want to do, and defining
that something else is our new best practice for how to write devices.
But I think we would need to start by reaching a consensus that that
*is* what we want to do, and documenting that "best practice" somewhere
in docs/devel/. Then we can examine proposed new APIs and all be
on the same page about the design patterns we want and it will
be clearer to reviewers whether the new APIs fit into those
patterns or not.

thanks
-- PMM

