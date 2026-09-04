Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF88C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Q1J-0004mq-Nt; Fri, 04 Sep 2026 05:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2Q1I-0004mg-VZ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 05:15:36 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2Q1H-0001aQ-7X
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 05:15:36 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-836ce6cbe1eso7416477b3.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 02:15:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788513333; cv=none;
 d=google.com; s=arc-20260327;
 b=RIS+VCYmnK5epMu6Ghuh7nofPs/J+1haDAmu6N1BKsKwYGcbCA2CiimUv88kt1BuVq
 fDOyVEsKqgEXkstWbDksKTvuR56kajV2LDCUxB38TkHOeUStk2zRnHqP2DWYvu6egGjz
 U0DOlkcoy0+HW0jiL9/RhEGnS8H1E9IkCMsTDZla9p+b7VSRFCgcjyx16tsselhuQWM7
 U8+xQc5d9TwNy0yp+tZe70bvKMxo50aRAsXVwEYnfCOMnRyoKEiuFboNzksvJFERlD29
 1CnHZiLtFts+a3CgA4Ykp6Nn7nuq/Ray4pS6gQfP3B3N8wtS55Rifqi8qy82K+W7e9Kb
 zygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2Pf6JzldFyCcEKI+aEXpQhEuXKSo1Uk1RaFlSh3dN+0=;
 fh=ILU5lqw7vqxBdELzbxjWl6muK1VB0VK4Qr9OFCEqlCg=;
 b=Hi2A2/okTBfqWqMgxzaqUBUUQRCbNyzKyomW3epFIjqFE872qu579Qj/tv4LouRguK
 AunFCEcdQD3vuehx7qgiZ90k2PyJYMD3khsM3aeUWOm6Xk+enjW8Z3mXH+k2gn3fI+JR
 mA17vuFS/NCnRz2Dg5xepRRj1znE79aulxsoluH5XHZl3UwnKZhQMuy2vYBR2tm9KfJB
 BbZdSf3AEFUBh+oCketWb6vgMFXXtLvmuQB2Jwow8lVvQ1BWyZDWI38z74JxI+yZ+h/c
 1M+MJ4YUMJkgmEcHOw0yTQl3BLnn7eKETzP/VxQyr4fsDLcaehQB6oEgPpHyv+Q7cjrN
 eK2g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788513333; x=1789118133; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2Pf6JzldFyCcEKI+aEXpQhEuXKSo1Uk1RaFlSh3dN+0=;
 b=Ks1YasoJFFq8iG5AVQEcUG2cHVQi5EHEyfXAXAzi/vdUVJCY5+Wr1BuJQRQ7OuK5k7
 H1tiXcuxYbcFFgUJez3Ic58Gw4WNN9b35wG1tlhG+urN5V3RCQGsi7uCCEUfioA2+wq2
 vzDwC7AwjbaeKtHw5dg9c2Px9OrEWTYKjjZPsbs7TprqCiYNhedRx9dihWBPq/wGF2B+
 zvj45Ll1ZJr69365wXQlTibu741yQkT3Pd+Oncy/hBFb+RuWe5Eu8Jl13hmTORDJb/Rq
 jxdjZpJInBnUZGMvUCsvNCqAsRdJGbUGQEdibrl9UTptqBOL+z02wqVgVT2ouTQ9oybn
 EPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788513333; x=1789118133;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2Pf6JzldFyCcEKI+aEXpQhEuXKSo1Uk1RaFlSh3dN+0=;
 b=FGVrvuiqN5KpO/0Q2E9/ycNATAMQfpA9ibKJOo2G6rpTlkpdOEryxe0E24ZEIiRhtK
 +imCY3oD/eenn/le3IzYaQPZe4DNAG0q2wJ4Eb0ARywsPTYKnq8K0ETSOHMQF72bl9lx
 FYecLfITRUGT+gBqjz4rAXjwtzZWPXRFZpe08pxFW2Uoyz90K6nq4pHY2xKvo9PhrRIS
 jhipXdrXEFt7uZtMxnVwDwpbtwiOj6UkMCKjUGGlfw5LcyGXrAGEQRl3AGcs/O1vyHP2
 CWK7hMIaCSt/WMNOPnUUazECsu+UEZEGFXVaDLJwqClZz3RMuQLmcjJsPybx8L1Vu/bx
 bgkw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrktud8YodrGAAI5Xd/+pw9asUHQiaCWvpTpzGLg/DVCGTJ53OVZsJpyGlibdYLAxyriGKKG0fknD6@nongnu.org
X-Gm-Message-State: AFuF++lQXtEtc3Q2RTkis6vBKB27gSZkaTQJu2ZZWkh60rYiWFIFSNe1
 Pe3GcIzxM0ntZrJpgZKn7GGoZW7/3+2NALZgygidceCzS1URQ9HaNdHDEPD5Hy9clxS57+z2t0S
 n2CR9n3gHv5lBuuQhc+h+FPHG5ZwpBlErUnxCwgFPxg==
X-Gm-Gg: AYBFou10S65jCmWpulhekWleRT+0lz8a3jI9NRF2u7iKPWc/znptFWWJu2IBcU8Xf99
 sNg2YVsremGMHzscXJzF9/MSLP1/9OKM7bjsY2p2EVgnWYmkMeGV6lSGW0f/SSR7qyCS65ZP8Wk
 skLxWNbrk01MJLJXoiLaUSoQNOkjsPi4hs4nCg6iXLZarVeiLpO49CFghpPSHPy9LXjCf/aHUSL
 MLxDjogcsdYvEu3IF35tnawB1hlENOaBocb5UhOCogwCQdtfo6H2M88nGXP82wDLILgD7OnYvOg
 3KoHKn061dFQg1byJ1OhbOJZ/sSalBSeMueNL/P5jcRlAnnNVv0l/6qnIEMtqMA50K8x2H6bAGV
 VaWq2Wew7CyWcaFIKFCtb3nCnCYyh
X-Received: by 2002:a05:690c:d8a:b0:854:27c3:5cd8 with SMTP id
 00721157ae682-8712a22ab0cmr27034477b3.27.1788513332915; Fri, 04 Sep 2026
 02:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-2-farosas@suse.de>
 <apmwZbSLZ46yvGmT@x1.local> <87bjae8bya.fsf@suse.de>
 <apm10EPO4vYlZLQZ@x1.local> <87fqzp9yzb.fsf@pond.sub.org>
In-Reply-To: <87fqzp9yzb.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Sep 2026 10:15:21 +0100
X-Gm-Features: AcwNN1XRJVbUyotbcb_XYSSxnIXIMLmY8VPdq6ntFqvlPEzK_P9rGvli5yqH3vU
Message-ID: <CAFEAcA_N0NciFyg88rfweD_uYeFbtgrP1y3NhmXwhChZGMmxSw@mail.gmail.com>
Subject: Re: [PATCH 01/18] checkpatch: Fix checking of newlines in error
 messages
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Fri, 4 Sept 2026 at 09:56, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Xu <peterx@redhat.com> writes:
>
> > On Thu, Sep 03, 2026 at 02:46:37PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >>
> >> > On Wed, Sep 02, 2026 at 07:15:29PM -0300, Fabiano Rosas wrote:
> >> >> Using newlines in the g_test_message is fine. It automatically adds
> >> >> the '#' required by the TAP protocol to the start of each line.
> >> >
> >> > IIUC we have such check not because TAP, but because all these functions
> >> > will append one newline at the end, hence it's not needed.  IOW, if it
> >> > applies to g_test_message(), I don't see why it doesn't apply to the rest.
> >> > But maybe there're other reasons?
> >> >
> >> > To make it simpler, maybe we just call a few times g_test_message()?
> >> >
> >>
> >> Not sure I understand your point, Peter. I want to be able to print nice
> >> messages in patch 9:
> >>
> >>  g_test_message("expected vs. found:\n\n%s\n---\n%s:%s", str, t2[match], t2[match + 1]);
> >>
> >>  # HMP output mismatch for entry at line 55:
> >>  # expected vs. found:
> >>  #
> >>  # max-bandwidth: 10356305952768 bytes/hour
> >>  # ---
> >>  # max-bandwidth: 10356305952768 bytes/second
> >>
> >> What would be the issue of having newlines here?
> >
> > No issue here that I can see.  My question was, why you moved
> > g_test_message() out only, but not all?
> >
> > My gut feeling is we check this because people forget that all these
> > functions includes a newline.
> >
> > So if your point stands here that "newlines can be in the middle", they
> > should apply to all, not one.
>
> I'm not sure I understand you correctly.  If you suggest to permit
> newlines in the middle of error_setg(), error_report() & friends, I
> disagree.  qapi/error.h:
>
>  * The resulting message should be a single phrase, with no newline or
>  * trailing punctuation.
>
> If you want to provide additional information, use error_append_hint() /
> error_printf().

Right. These functions have a genuinely different set of semantics
from g_test_message(), which is why Fabiano's patch only changes
how checkpatch handles that g_test_message(), not the various
QEMU error/warning functions.

-- PMM

