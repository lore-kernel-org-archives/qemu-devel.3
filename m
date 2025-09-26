Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886E2CAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v29bX-0007fd-Ht; Fri, 26 Sep 2025 10:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v29bU-0007XW-8W
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:39:21 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v29bG-0003nR-RL
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:39:18 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-63605f6f64eso1559140d50.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758897542; x=1759502342; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uE3GP+0qSLdR1vLo7GlM0tuAuxbvcHaBIui5genWCUU=;
 b=h4JFuoOfZhWdzdHvSYtdYK8JrQNozDfP2ZATStRt+w8CGIuueSFQhdRJpiDT68AQQ8
 Mgb7oU8obP6ZPjBAzCNPfKnpJPMzGd6FkVujYyU18authliUrL/C7xof0NHlJoJu7n7n
 QO69P/GcNgDorMvSZBiDs/Mg+w79tuoU5OB0woU6ni9RRPGfuBh3ldTe8bfq6Svaimee
 yQ/w3OsBGxTMSlIELihkSqxHLdGcZaJaRtvnun8o6MQiEmFPdmERhPYtn14T1fXnLKl+
 Q79929wmvyqVxzmVTG5CvlM+K/toOqiBKBHtJMAr/OqagbEfz+tIBa9RR3tyD05lR2ek
 Mwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758897542; x=1759502342;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uE3GP+0qSLdR1vLo7GlM0tuAuxbvcHaBIui5genWCUU=;
 b=KuwJtyBcvT40Mz0tPCkq3qt06XZO5ENbFVV/9MlmubmJuDctlldxkBLnma4ISMe/7k
 /Dtb+35lIw53PDR+BtT3P3QQTutpJok2Sp+xad60BRo7v0IRn3LM4TkxsoPPfQxdu+et
 kikJZSrhnJ3uCoiUoyAnko+iF9JTJG2NEQm68JRtCMJw+hlfzqy/90Yx78kjwhaKqKwz
 obKl7CVI5FOmsO+9uU9Wm6oC/xxt7XUPHk2nGNuumSa6qNMWNJN9DBysV0Uv62l/yfrv
 aWLDDTMPOiFWWy8vnoHIwAfOBoM0UuEbsu7Sb87um4L5cJXcUCxfWtdU9iymfutEONhy
 P5Vw==
X-Gm-Message-State: AOJu0YzgQ4u5AQmHvBC5tTZFxPV8pZCvlfuIX5kX6g+xOncz38XfS7B6
 locjr2eeVhq4214SBLunjnIbBGYlangrBuCF0G2CRfj6EqU45na5sRPw+eGbDhgKY6PgZ6SWZPW
 zq/nHuTrNE0Ja3isGHoDHK8LRjyDXLM7t8m2OFQyBxQ==
X-Gm-Gg: ASbGncvFaxHpVFs1yhLXsLyC9Ig8LOl7bH1zUYwZVTnLICnPdSdizbOUsbLdv1W4GwK
 4QP1lACkJXwo2YdY3Ll9JRUW5nr/WoE7iSVZG5htVP66YtMMRDCtTgve4XzdMB9CnB5xAmrgPo7
 4zPTJwv6QtHrFwdNTdSM45L52Qdtc4KbsVe2g1x3IAUXGHwbce7zJEPVzLZUvhZxkgu1D1JiHSZ
 W7IgKWY6pr7wQ/V5Nk=
X-Google-Smtp-Source: AGHT+IGPc+Wb7pwOu6UrPV31vCwJ+v5ldpxLlIF2nOytN8XgiyNyAFj/8rxybnS71gh0/d8Gu5GlbWst9eUGzRG4TRU=
X-Received: by 2002:a53:b106:0:b0:636:149a:f54e with SMTP id
 956f58d0204a3-6361a87fa19mr6034005d50.37.1758897541888; Fri, 26 Sep 2025
 07:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250925075630.352720-1-pbonzini@redhat.com>
In-Reply-To: <20250925075630.352720-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Sep 2025 15:38:49 +0100
X-Gm-Features: AS18NWCUdF3oscrMcOApCaUfpjE0xJEQh1QfqTdz1VVXVfyU2QkO0nvqCYXi1KU
Message-ID: <CAFEAcA_6nf6zAK9=VZE9kCXUvYcZhxAgPUN=0gxtun7ip6b7ig@mail.gmail.com>
Subject: Re: [PATCH] docs/code-provenance: add an exception for non-creative
 AI changes
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, berrange@redhat.com, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Thu, 25 Sept 2025 at 08:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> AI tools can be used as a natural language refactoring engine for simple
> tasks such as modifying all callers of a given function or all accesses
> to a variable.  These tasks are interesting for an exception because:
>
> * it is credible for a contributor to claim DCO compliance.  If the
> contributor can reasonably make the same change with different tools or
> with just an editor, which tool is used (including an LLM) should have
> no bearing on compliance.  This also applies to less simple tasks such
> as adding Python type annotations.
>
> * they are relatively easy to test and review, and can provide noticeable
> time savings;
>
> * this kind of change is easily separated from more complex non-AI-generated
> ones, which we encourage people to do anyway.  It is therefore natural
> to highlight them as AI-generated.
>
> Make an exception for patches that have "limited creative content" - that
> is, mechanical transformations where the creativity lies in deciding what
> to change rather than in how to implement the change.

I figure I'll state my personal opinion on this one. This isn't
intended to be any kind of 'veto' on the question: I don't
feel that strongly about it (and I don't think I ought to
have a personal veto in any case).

I'm not enthusiastic. The current policy is essentially
"the legal risks are unclear and the project isn't willing
to accept them". That's a straightforward rule to follow
that doesn't require either the contributor or the reviewer
or the project to make a possibly difficult judgement call on
what counts as not in fact risky. As soon as we start adding
exceptions then either we the project are making those
judgement calls, or else we're pushing them on contributors
or reviewers. I prefer the simple "'no' until the legal
picture becomes less murky" rule we have currently.

-- PMM

