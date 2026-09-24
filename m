Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02242C98311
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 09:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9flk-0006bo-Rc; Thu, 24 Sep 2026 05:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x9flg-0006be-FR
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 05:29:28 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x9fle-0002lW-F2
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 05:29:28 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6350f91so1151982f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 02:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790242164; x=1790846964; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3zKw6U8uqu30EP0WgeA1iiXi6lkOdizIoK74JjKzmCg=;
 b=xC7fyyRd5upHry/VQ2+g6K+uwTiuSK9rZnGOz4lBxnt7D+eqC0BPaHqf9FL459qp3R
 Pu0pYJfaNfRlvS/lkPFbvynU2TfH6Av9OSitLXPMLrAojEz3yPplVnV21CHUNTARveO6
 jkkussb1Z+j6w1mrMME7AYDeJkrxOowCF2r59Z50gAYxEczNjDqDKs1C3c75Du+/nvU/
 tXleq+GPgEnGo7wBGY1B70FhfmEv0SppVUFjufeJyGY2o094PVLvf0VMjbRwG5b5vLm6
 RdaCEl4IhQQeyF6HNPe5xZ5VbdZwzSIRCF+VjY5Mev7mBbI/1KdVUiErbmyCVts7t6dX
 eUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790242164; x=1790846964;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3zKw6U8uqu30EP0WgeA1iiXi6lkOdizIoK74JjKzmCg=;
 b=GCPgWDHjxFdnpAmgeCFt4ja54h7ngvvMRnVt5+66JpvZFdNN0U3F+VLoYNeRrOWLv/
 nje4wCOyRvOO3p3Ps5MUgXATMIu/CGSZxMcHwdgRD+OiLfGfZcD5VkXsOkLGYzjovV5S
 lFx5lxg/J8cec2WJyjxiArsfwWIMcRugpD/475YcPHbJsTmvIQE9llvZyUeN7E+QFd+E
 pXjWYJ+mpUMbujqAIeDcNuKi/ZjDGfLjw1PBl736p0A7MnX6AtaO7Z9QiYv4yK+YHNim
 NgTqaeTBEdocvhHSzlxkX5UvYA3rtJXN6Vt2D70cKuPSWacVCSgktIENxNbybSH3UEl/
 WKcA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzG6QzC3suzxC0HbzA0UHSRqaI1phXb6RJbhiY1iLVKGh05JvXj3eDvjyQnILAcJm9ZWtZNOAdkblhN@nongnu.org
X-Gm-Message-State: AFuF++lyY4Kb6gtTc6DTHPS5TTz/+bEeVDQ0aIjohzpl2YZbeIk6XGBR
 +9Aj+/WV6dXWKPMYpKq68xHnOrqJWxxxZpjSMnmvWfcVyJIxUWpaMddLpsr7/3hLxQs=
X-Gm-Gg: AYBFou07CihGfGXONlsKmQwd5UNTfPaREeaPcnioSE1YnvEQTp0ct9mE1bSnstfUE76
 J2iRxwPNJEBcdfqKI7dIJtci5c5pxIr5BVLnbg60zk+k7zaTso3EkWddAOcuGPPg4X71G9O/7bP
 mIyffOnL1ZBG2K9n/WrFdCznMdfyEPrVk/tvmERWzl1UKiPop6OEhTUn+pnVR473oJtBsJWbvk0
 9yJqOckcDvukKkcYi2L2h4INyfXfWojyUXcvts3/iZsfhFOAezQHHB9vdaVMxG6fqYNOvA7T0Nq
 vnG5zkNRqXvHVs8lvtP/Elk6MDFRxEw4vInWEg+Nj3Nz7IvqtvlRfxMN7zAfEMxD/WWCTvlDA7l
 YwpeQ+7wICiYbNrSCGgyOcLyf5+DPuLNpUnsssYhipDr3BamOuUNaFk2sVIkMFMLchfE0nWqSPy
 B9aLiyQCrYTapTlcbipEXePflfE6O1oNRHDqvMpcOmeoWPyeIXij/v1BpoqHoMRAIdtA3pAA==
X-Received: by 2002:a05:6000:238a:b0:487:84:96d7 with SMTP id
 ffacd0b85a97d-48871974f03mr2861357f8f.53.1790242164143; 
 Thu, 24 Sep 2026 02:29:24 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886876c500sm13770442f8f.19.2026.09.24.02.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 02:29:22 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B41F05F8E1;
 Thu, 24 Sep 2026 10:29:21 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  qemu-devel@nongnu.org,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Alistair Francis <alistair.francis@wdc.com>,  BALATON
 Zoltan <balaton@eik.bme.hu>,  Fabiano Rosas <farosas@suse.de>,  Peter
 Maydell <peter.maydell@linaro.org>,  Warner Losh <imp@bsdimp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
In-Reply-To: <arP7TDfz7lz699KJ@redhat.com> (Kevin Wolf's message of "Wed, 23
 Sep 2026 18:16:12 +0200")
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-2-pbonzini@redhat.com>
 <arEvLLYK9A5MKNdE@redhat.com> <arP7TDfz7lz699KJ@redhat.com>
User-Agent: mu4e 1.14.4-pre4; emacs 30.1
Date: Thu, 24 Sep 2026 10:29:21 +0100
Message-ID: <87ik3vyp3i.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x10.google.com
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 21.09.2026 um 15:20 hat Daniel P. Berrang=C3=A9 geschrieben:
>> On Mon, Sep 21, 2026 at 09:52:48AM +0200, Paolo Bonzini wrote:
>> > +.. note:: **Use of AI does not remove the need for authors to comply
>> > +          with all other requirements for contribution.**  In particu=
lar,
>> > +          the ``Signed-off-by`` label in a patch submission is a stat=
ement
>> > +          that the author takes responsibility for the entire content=
s of
>> > +          the patch, certifying that their patch submission is made in
>> > +          accordance with the rules of the :ref:`Developer's Certific=
ate of
>> > +          Origin (DCO) <dco>`.
>> > +
>> > +          Since a submitter cannot audit LLM output against its train=
ing
>> > +          data, the DCO is paired with :ref:`metadata in the commit m=
essage
>> > +          <ai-used-for>` about AI-generated parts.  The DCO still cer=
tifies
>> > +          that the contributor has the legal right to submit code in =
general.
>>=20
>> I'm not a fan of this second paragraph, as that feels like it is undermi=
ning
>> the DCO. That first sentence in particular is somewhat saying that the
>> contributor does not have to think about plagarism and thed project is ok
>> with that, and also implying that the DCO doesn't apply to the LLM outpu=
t.
>> This is both not OK in its implication of the project accepting some
>> liability, and then also contradicted by the next sentence.
>>=20
>> IMHO this paragraph should just be removed.  The first paragraph clearly
>> states the DCO applies to the submission as a whole, and leaves all liab=
ility
>> for infringement on the contributor.
>
> I don't think making this the individual contributor's problem is great.
> It's rather unfriendly towards contributors to expect them to certify
> something that we all know they can't honestly certify.

This is the current position with the DCO anyway. If the contributor has
copy and pasted (and maybe adapted) from Stack Overflow they are still
realistically the only person that can make that judgement.

> Our current AI policy was built on the assertion that it's impossible to
> sign the DCO for AI output, and I think that's still right. A developer
> can't certify the origin of something when they don't really know where
> it comes from.

It's certainly possible for LLMs to replicate copyright material but by
far the biggest influence is the code *in the project* that shapes the
output. It is basically pattern matching and predicting after all.

What level of reassurance the submitter needs to be able to certify with
their DCO is up to them. We can't police it, like every other submission
we rely in the submitters good faith representation of what they have
done.

> If we decide that we don't care as much about the legal risks any more
> and that we're willing to accept them to some extent, that should be
> explicitly reflected in the policy.
>
> It seems to me that the cleanest way to do it is to exempt correctly
> advertised (with 'AI-used-for:') AI output from the DCO requirement and
> instead add to the 'AI-used-for:' definition some relaxed version of it,
> e.g. "I have reviewed the contribution for potential licensing issues
> and haven't found a reason to doubt that I have the rights to submit
> this AI generated content under the open source license indicated in the
> file". This is something that could realistically be certified by
> contributors in good faith and also isn't just "anything goes", but of
> course it still is weaker than the DCO.
>
> If we're not willing to take the legal risk from this, we should
> probably leave the current AI policy unchanged instead of telling
> contributors that they have to work in a legal grey area.

I don't think we are asking them to work in a legally grey area, we are
insisting they are confident there is no legal risk in what they submit.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

