Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A86106ACC9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 16:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0ije-00027G-80; Thu, 12 Mar 2026 12:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0ijZ-0001ve-Sb
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 12:18:04 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0ijW-000341-RS
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 12:18:01 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64ad79dfb6eso1540295d50.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 09:17:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773332275; cv=none;
 d=google.com; s=arc-20240605;
 b=VWFunI2HwLmfwj6XfU292SRdBwmdBTLpIWlMubJWaZ8Qk6J5PA7cCwcz6vM/kgrYLD
 mNogKNak5PR6m9duz41D7BUNOP04lA+eeg6HwAhH5IK9eyfXazdHkXbOT0RBbzz7bede
 L1QzNd+CGankuDOgv+6OK8zoL1XrgCxZOmJ8MauD3ya4Pc6imM+yX1GBJcyRMpkk8wfs
 esDxZgcRxWVtdQX+rb0fxMy0cm1fsuehIRGHrIjnTDrWQootVGhHNoLbEpd5DuRrRSPi
 JqbLvue3o+0yt2iUgIPyZsCo+973amQu4qUAi8CBjrLc1fiTB0tfUEI4EnKXLaOL7EFf
 W3EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FJoQa3mWUsa1R81FAOSHVzllk3JXyfmK7isVZcruZZQ=;
 fh=OqXzHiH5rq/Zgz6qqsJeDLgWQQ9tCzihPkg4J/a3698=;
 b=Sd3BtPKTluMCzOsm707PlObzFzME03kk1Z4mbtAFxwQm7rTWh06iusrED02UtR0IwT
 WdcOJC5FNhHKmDgJF0AUnOjxLLtbQlZUQNBs31OJQ6ULd7I1Q1ctYCIW3tOKYBpILAyx
 XzqVyk9qD5eB/xLvyi9HHSu8jCsD7AmRYAZSaCfAVAvwkZAdojTPk1t5ON1HaPQ5GvFd
 FB3qdkvYrZ3JhXwgFFc1Qqd0xpqYxltugzQMYDVT7eDSthnh+JhY0FgZbR9PeDKhRvk/
 x98GiPb2POTPcjD61uxLgPAfRaNuBDiJgxarfMRsGX/sFCoC3uOga1gIe4FgXkjF3KCR
 KvAw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773332275; x=1773937075; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FJoQa3mWUsa1R81FAOSHVzllk3JXyfmK7isVZcruZZQ=;
 b=erS56gu6NJEdjLykF3ywA+f0G4S7mjq+f4HDV8di1eeSfjMDFRUWRlEDPDM/hVzzPu
 Asr78Pg51vtjYh6QVni/EOTKSsIWXp5V4AKVTbVxPDKYwAm3tJDt2g9GOLoqhBf2kgMh
 jVYunLMwV9YvWrbn+M9raelNwsOJoo6zm3J+fpakt9CJb8Bwp594A6PMjxCvHu3MKj7X
 dBf6DczXMRc6Xh0g7yewfmdlFggr1GgaM2yC6NJRaP15XMbJS3sicqzUHLmDnZl3pqe5
 YrLsBWHXBwxGL1jDcy/1Vop+BXfWRdRDP2H16Sf89KH2iNVzfqkzdoc2NTbEwVWBYflq
 g07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773332275; x=1773937075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FJoQa3mWUsa1R81FAOSHVzllk3JXyfmK7isVZcruZZQ=;
 b=vO75aSZWeac16IU1TMGrTqIvJdRmXp+kGsgFeFa9xo07bfJ1w3znvrexPmVcvCiEGn
 aKjf4BFOhBSoCAFsDNa7OnKm3ddl4Nms4noQ65U3ehO1evTFarcTld9jH5NGhqGNG/RO
 a8SLL5ABOXWw/xmxa5ZrEqXUKmqd+4Ub4zgh++E98t9DkWBJySU5RbL+4Xt2XyEeJfe5
 /MYPNs3dTt2JwNwPx+GlttCY47TVEsKp2u2PPTcXzOzCKLp/YDM75R+S3NhVdBoKO4x+
 SvBYd2BfO6cm5UTUzldGJ/Bxx0W/8IFlEM/FeMLnbH+2Zs+aDd6F9ImyevIjZgEaIYUc
 J2Jw==
X-Gm-Message-State: AOJu0Yyu6+CEusxBFa71T28Yf6cbsJ26ipCJe2vijNuRDtpoVfMiVN67
 uW8jCcV0Ib6TLSgJGGABfivjudO2bjLPqeVlnr17cOrV67k0t12vCSi60SHKZZXwOCz2qXx/5iU
 tiU0pi4senUykKTGOoy6RrnOOEVtV5n9refoAJvT8Yg==
X-Gm-Gg: ATEYQzy+WcdMsU2bAXl4FsDL2vZ6wljn/cglueGXbW/o2TUcG6by+C9zGJkH6f+chcX
 c+cdoKy+JQwwzrSZAYMF5D97ypR03nMg9UNJO00q9wSzvAMgpDRMBmeJ6UvRzP4xoz78kLOiGtL
 hoAmkm5oF/mmLXrTTB8SkG21ubiNgl1NqY//6zLKF7yb16LH7hTnmR67co57uNOaG9wMyga/KVH
 Yn0s+lsOy0SGGHFsdU36u3v/F/6Q7AxNC9ej8N7NyYnswWe+OU1+FttA+SttQVNs3yDxza4FHXg
 S6IRWzsD+ZG1pQ5T5h06/DGowgZYauovtrH0pyl9re4fmjxERqsNt1LYc10piCt6ANo=
X-Received: by 2002:a05:690e:434b:b0:64c:a909:70cf with SMTP id
 956f58d0204a3-64e6309c6ffmr90847d50.70.1773332274737; Thu, 12 Mar 2026
 09:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260311213418.16951-1-farosas@suse.de>
In-Reply-To: <20260311213418.16951-1-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2026 16:17:43 +0000
X-Gm-Features: AaiRm51BeYHOGeaQKicaLUWHryaiqu-MO9gt-hYPfa8PcaQSexF9v14xKR0uPv0
Message-ID: <CAFEAcA_Q3n1fJjNWLVa3pf3Me-7zJzuG9zir34TZHT4YFny-3g@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] migration-test: Plumbing
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Prasad Pandit <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Wed, 11 Mar 2026 at 21:34, Fabiano Rosas <farosas@suse.de> wrote:
>
> Fix leaks. A couple of normal ones and a few that happen due to a test
> expecting failure in the destination side, but 'exit-on-error' is set
> so the coroutine just exits the entire process while a few resources
> are still allocated, but outside of the scope of the migration code.
>
> For v2 I set exit-on-error unconditionally in migration-test. The QEMU
> process should never return 1 anymore.
>
> I also removed the cleanup patches because they are no longer strictly
> necessary, I'll add them for the next release cyle to keep the changes
> during the freeze restricted to what is necessary to fix the bugs.
>
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/2379240537
> --enable-asan --enable-ubsan build is clean for x86_64 migration-test --full

Thanks for sending these out -- I can confirm that all the
migration-test fails I was seeing are now gone. I do still see
the func-sparc64-migration test fail, but that looks like it's
probably not the fault of migration itself: we hit a SPARC specific
assertion in QEMU rather than tripping an ASAN error.

thanks
-- PMM

