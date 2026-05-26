Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA49CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRo5u-0001QA-Ub; Tue, 26 May 2026 05:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRo5p-0001PU-Er
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:28:57 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRo5n-0000gU-BO
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:28:57 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49041e84237so32008045e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779787733; x=1780392533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1WS2NP0lf76aoO/hmlJ5RcBOqL1i539DvL8Db6YndYI=;
 b=qYsLcyk4LYjX1/3zn5aQI5xdS1w3ohFQI9RW6h9FiEtUCpllJzgDChf/10W9gO4mwF
 +GCmFebA5INHsU0+hp7XM+QFXLYpKx5QkXDRAmREwL0Xw7Elt4lfQCLPQqmcVrvuw9kQ
 Yewu5DHZ0sipb4ViNy5yISY5cMiyNHT2NbVEE4OpAtSRZAbeFTEt84l9pcazhXOz8SuN
 uYP3vLRNLijYWc/Uhkw7cVNwpUdH8VMlbJ4aLcqjMImLZI9fPjYymUkjwjoYkme1ciRL
 aEhz+cV5fq0QN4BmS2qnhFrwnO0wUf0SDOYR0PP5zEjoJsAaKU+7na7km2UbqgTw0Wt1
 97rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779787733; x=1780392533;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1WS2NP0lf76aoO/hmlJ5RcBOqL1i539DvL8Db6YndYI=;
 b=UxoNjyt728Sq9G9XLaSAb9enpLO7Ib9mFBN3cU6ahB0l2sTz/c51yPh8hzG5H19V5i
 uoR84vSU+By3+oQNl0cKU4pJSnxtQca+Lkv6d/w0kUGm9pTh8s3z6ecpyM+qelVjC1Ls
 tpdilq7aDpvoo5737TB79PATFCAqoSTfDu8L0xsUIQRPdQLRNQv5USMCdbrzbGskRPqv
 eceD7kUGqK+isdYUUu6mnseZgPWUHLeKzus5otX94nzSXel025OQuvwUWYbt50PhtDbe
 iwUiJSJ4BQYTwrYR3qS6eatsWUzYCw3yR6iS9VQjkDLEkVPbKmtLU81lRsg7xudrTzWY
 jTrA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9BZ2bPm05Fo3OhpXqGqDwXxJcKKVjhRnh7IvCZ5r8JhuswGh1n5m61JNmIeOSC83AqWCi4M1KTOxfp@nongnu.org
X-Gm-Message-State: AOJu0YwdXNJf6xWAan5055ZaDs/qPnYXTWwGl8ha4IXVsSoXgHigi44r
 v08g5S5iIj4+ghiUltm7m51N8szYtC7VG9LAldaCKSZOfBdSZ9c9waSyEv4OfkC8f4I=
X-Gm-Gg: Acq92OGFpvQUWz7ZyV/dLzJk+ibgIwcV3KKRZPwzxbkBTBBaz4lXFSHj5R++3m7A8nd
 zwYfpiMkAtLkNp+Bqba5YX79rppK9cuwUPLAKHf/hacgzkuUN5/1NgSsjJyYE9CJBOi41A0qPiA
 a1gd8ilRbnLtmgLIzuWRAoyZBZr/RCJ34VPvHb7CzQA5ihQgyh3/amm+E50RNVDm5v/lR4g2pas
 BzM7ZGpsbfS5hHGBDsDwEY6Ewf1fX8E8iyOSDJ2G5PeZWxhtTlLcP76lWpPmhpt3I3VzVzLDn3t
 n9Yoe/XDxnT0lZzBboMvG4DkB1JnstADNiotVMvBSk7nrteTl1fTfYpNyvlvosuMw7m6KfHdekZ
 mpuu28T3GDAMv3a2j9ZzStzLNbF2LQUM8ErcvI1jLtCPqs79d61YpfSKIqAgo5pusOx2D7xqe+m
 iBKwax9aelEGjJ15k1m3wzL20=
X-Received: by 2002:a7b:c7ca:0:b0:490:4b89:5372 with SMTP id
 5b1f17b1804b1-4904b8956c5mr149868895e9.11.1779787733522; 
 Tue, 26 May 2026 02:28:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49042aeafa8sm102170925e9.27.2026.05.26.02.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 02:28:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AA35860373;
 Tue, 26 May 2026 10:28:51 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  qemu-devel@nongnu.org,  stefanha@redhat.com
Subject: Re: on ai generated and code provenance
In-Reply-To: <CAFEAcA9wMRFJWrjGHcd2nfhgXovyuS=dDJvCXWZkgmD_eez27A@mail.gmail.com>
 (Peter Maydell's message of "Tue, 26 May 2026 09:23:35 +0100")
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <f0bc9023-28c4-4685-b0cc-fc7ad4e6d371@redhat.com>
 <CAFEAcA9wMRFJWrjGHcd2nfhgXovyuS=dDJvCXWZkgmD_eez27A@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Tue, 26 May 2026 10:28:51 +0100
Message-ID: <87eciy1pv0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 25 May 2026 at 17:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 5/24/26 14:42, Michael S. Tsirkin wrote:
>> > I propose adopting linux's rules instead:
>> > https://docs.kernel.org/process/coding-assistants.html
>>
>> Replacing QEMU's policy with Linux's would be orthogonal to the topic of
>> the DCO.  Maintainers would still have the option of rejecting
>> AI-assisted patches if they don't believe they can apply their own sign-=
off.
>>
>> Other projects have taken similar "no AI" policies for different
>> reasons.  Zig has one because they believe AI code would make it harder
>> to retain contributors[3][4]; Rust is working on one that is fairly
>> restrictive[5] (discussion at [6]) and requires previous communications
>> with reviewers about *any* generated PRs[7].  Personally I think QEMU's
>> policy is fine but we should start introducing exceptions, possibly
>> including large contributions with pre-authorization (but not
>> pre-approval) from the maintainer.
>
> If we revisit our AI policy (which we should, I think, in the sense
> that it's been a while and the situation has changed), I want to
> note that although our current policy essentially says "no, because
> we don't want the legal risks", that doesn't imply that "if we
> judge now that the legal risks are acceptable, that was the only
> blocker and so we are now open to AI contributions of all sorts".

I think there are still potential legal risks but in the normal use case
they are pretty small. Prompts to re-factor QEMU code will likely be
fine because the LLM is acting as a fungible editor - if anyone prompted
"implement Rosetta's target code optimisation pass" we should be very
wary of accidental infringement.

> While we were essentially in the "blanket ban" state anyway, there was
> no particular need to have the discussion about other reasons we might
> also want to be restrictive or cautious about AI contributions, but
> those other reasons and viewpoints don't go away automatically with
> the legal one.
>
> I have quite a lot of sympathy with the rationale behind the
> Zig policy, for instance:
>  https://kristoff.it/blog/contributor-poker-and-ai/
> I spend quite a lot of time reviewing patches for things which
> are features I don't necessarily personally care about. I'm
> happy with doing that for other people who are hopefully
> learning and gaining something from the process; I'm much
> less interested in reviewing a mountain of LLM-generated patches.

I agree - I think we need to address the quality expectations expected
of series authored with the help of AI before we open the doors to even
a limited subset of exceptions. Otherwise I think we could see a similar
deluge of patches overloading reviewers the same way the issue tracker
has been recently.=20

>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

