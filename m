Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11604C98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 16:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9m81-0003Cl-Ay; Thu, 24 Sep 2026 12:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x9m7z-0003Cb-No
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 12:16:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x9m7x-00055h-I2
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 12:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790266610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ZdaqttdbNXPtEkMSIXzsiFaaXSlIcXrCM+6YaX1/OI=;
 b=ExPPHJtSGc2uuZBopIKYZi/oUOMBNWXUsIOSPc3HkfkoWRy0k8a3GH6DRO8fXkSP88ExyN
 P9OzITKf455jECld4f9FoN58B1WLhMZhv7j02gDc2Zm1tcl2of/qyDMKyF8tTQPVl+5NTU
 nWGHp/1x09lLy6LIbWePPJi4qGeVH/o=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-UxPeLIxaMWWSjYcvYrj5JA-1; Thu, 24 Sep 2026 12:16:48 -0400
X-MC-Unique: UxPeLIxaMWWSjYcvYrj5JA-1
X-Mimecast-MFC-AGG-ID: UxPeLIxaMWWSjYcvYrj5JA_1790266608
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6a9bb406f0cso19257a12.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 09:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790266608; x=1790871408; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/ZdaqttdbNXPtEkMSIXzsiFaaXSlIcXrCM+6YaX1/OI=;
 b=Qg5B+/FHQ60Mg09dU9H9yGjnMOGwGDgfCu0gA+lR4DfjhRC9YNkK9IhopwtTl3fsgj
 2Eml9Va8Iw2lri3DEhpMkKuWz2bGvTFoHa/mkNg1vITGrQnKLrbaVSrVfnc31kfMQoX9
 t597iroTOAXoJX7z0MBdhT1U4kg6eFb+Ogc+3H8qjG9EzNIgZTtICqX/nrK5L1U0wmVy
 QJwHOCzj+wHME+Wlm3a18LGsERZib1YAYlxrjn1ijcGt6pFYsipxxvbpZwGr6xW4gg2q
 dmPalCca2rBz7MsK4myjSetLHu9V6tLt+m8QlfIT3R9CkDcUfAQm1BYe73VBXWsUbZnk
 zrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790266608; x=1790871408;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/ZdaqttdbNXPtEkMSIXzsiFaaXSlIcXrCM+6YaX1/OI=;
 b=HG/gIzBu0BCLg5IY9P+S7bCClMuHIIoUh+JqQW8pjpRO6vB/7TlOO6MQgUU+ESLAHQ
 1u7G/9JTNLYdeilpirWfVQTLU7WSi6L4rRGnzmWhs63Fc+yClXc0hzmbexBmxwwDQqD8
 XenbfGLu2oef/p/1xaP8Ud3rWglUjLlyMMt3SODKGHXkNdAlX+m9kBw3IHQqAM+VBHa2
 XQnW6hot1N6yp/8y90p6Uo7RTC6fTFG+DPUWTzUg/CqbwC7oVRhlzp4ysxXmRWf7ZWvp
 rL3bvQorK8LKMVoGkRV/qczqL3bRwQVRh2mgFPesTmdXZVnx9rxOBHFdn9PKBZ52Wvla
 TcxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQNLumcnP1Q6vNQOk2M6V5ayjItCZCT6cWhPG3JtWHHQdHjU0plxyRrDUMdm4S3/ODZ1byuHL6HOoN@nongnu.org
X-Gm-Message-State: AFuF++mL3MWIAB6VCvD3g+i7bpPnTAnPF7dPFRdId8DV64Zzj2OyrgKj
 oG5HE+lXiK3MPRQG8wGkYEUR8Eat60iNVJhVEf3PCWqmztM+otjssK4JezZog+IJeyjSkf6+rto
 V3j6nbs/otpQgZN8fVJQ6I9P8gsGA0McHZ8G4C4+ozofSHeyGHTPHZT0F
X-Gm-Gg: AYBFou0oqPbU6olZulXg81KwO8gGeZImTgYnaskIy/QSjc2HH8W7pB388/K4DDb+4z3
 EPxcXaWe2sIL58qNegkdQcwUXYntagEwgMZabRlzC0JztaW5KrevIw4m0ZsN5aAEIapfQlpyDLf
 Y6uOW6C/Ir23VNpugkcTfY5ZkXNhgoqVN9q4t0SPLc1u1O0JhgebLnhgRZtiqXyoVrcuUCFfcrH
 09+bxgvIHFyC6NyP7DEBr4NifuPMqgR2H+2CFHGPAFy9TwM4t5D9aNJ5Ovjq8xXHUONdj4VaQkn
 evxxMnPrjOd+PmvejHC8UwLNnKxaES03oo4C3e+mznagr5/N1nFSStQX/AdzxEUX9hA3RBZdqh4
 MEerl2vM5ONmdwmb+oiwqCKzaD1N5O9T9d4qHykNuYFnZYxPjmhCq2Ek4cyLwZcdH+g==
X-Received: by 2002:a05:6402:3245:b0:6a9:850d:bb38 with SMTP id
 4fb4d7f45d1cf-6aac8eec505mr2007114a12.10.1790266607617; 
 Thu, 24 Sep 2026 09:16:47 -0700 (PDT)
X-Received: by 2002:a05:6402:3245:b0:6a9:850d:bb38 with SMTP id
 4fb4d7f45d1cf-6aac8eec505mr2007080a12.10.1790266606983; 
 Thu, 24 Sep 2026 09:16:46 -0700 (PDT)
Received: from redhat.com
 (2a02-ab04-0158-f000-2548-f3bd-8b42-b18f.dynamic.v6.chello.sk.
 [2a02:ab04:158:f000:2548:f3bd:8b42:b18f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aab386e596sm3917674a12.7.2026.09.24.09.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 09:16:46 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:16:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
Message-ID: <20260924120752-mutt-send-email-mst@kernel.org>
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-2-pbonzini@redhat.com>
 <arEvLLYK9A5MKNdE@redhat.com> <arP7TDfz7lz699KJ@redhat.com>
 <20260923220502-mutt-send-email-mst@kernel.org>
 <arTwYindIekU9URW@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arTwYindIekU9URW@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 24, 2026 at 11:41:54AM +0200, Kevin Wolf wrote:
> Am 24.09.2026 um 04:23 hat Michael S. Tsirkin geschrieben:
> > On Wed, Sep 23, 2026 at 06:16:12PM +0200, Kevin Wolf wrote:
> > > Am 21.09.2026 um 15:20 hat Daniel P. Berrangé geschrieben:
> > > > On Mon, Sep 21, 2026 at 09:52:48AM +0200, Paolo Bonzini wrote:
> > > > > +.. note:: **Use of AI does not remove the need for authors to comply
> > > > > +          with all other requirements for contribution.**  In particular,
> > > > > +          the ``Signed-off-by`` label in a patch submission is a statement
> > > > > +          that the author takes responsibility for the entire contents of
> > > > > +          the patch, certifying that their patch submission is made in
> > > > > +          accordance with the rules of the :ref:`Developer's Certificate of
> > > > > +          Origin (DCO) <dco>`.
> > > > > +
> > > > > +          Since a submitter cannot audit LLM output against its training
> > > > > +          data, the DCO is paired with :ref:`metadata in the commit message
> > > > > +          <ai-used-for>` about AI-generated parts.  The DCO still certifies
> > > > > +          that the contributor has the legal right to submit code in general.
> > > > 
> > > > I'm not a fan of this second paragraph, as that feels like it is undermining
> > > > the DCO. That first sentence in particular is somewhat saying that the
> > > > contributor does not have to think about plagarism and thed project is ok
> > > > with that, and also implying that the DCO doesn't apply to the LLM output.
> > > > This is both not OK in its implication of the project accepting some
> > > > liability, and then also contradicted by the next sentence.
> > > > 
> > > > IMHO this paragraph should just be removed.  The first paragraph clearly
> > > > states the DCO applies to the submission as a whole, and leaves all liability
> > > > for infringement on the contributor.
> > > 
> > > I don't think making this the individual contributor's problem is great.
> > > It's rather unfriendly towards contributors to expect them to certify
> > > something that we all know they can't honestly certify.
> > > 
> > > Our current AI policy was built on the assertion that it's impossible to
> > > sign the DCO for AI output, and I think that's still right. A developer
> > > can't certify the origin of something when they don't really know where
> > > it comes from.
> > > 
> > > If we decide that we don't care as much about the legal risks any more
> > > and that we're willing to accept them to some extent, that should be
> > > explicitly reflected in the policy.
> > > 
> > > It seems to me that the cleanest way to do it is to exempt correctly
> > > advertised (with 'AI-used-for:') AI output from the DCO requirement and
> > > instead add to the 'AI-used-for:' definition some relaxed version of it,
> > > e.g. "I have reviewed the contribution for potential licensing issues
> > > and haven't found a reason to doubt that I have the rights to submit
> > > this AI generated content under the open source license indicated in the
> > > file". This is something that could realistically be certified by
> > > contributors in good faith and also isn't just "anything goes", but of
> > > course it still is weaker than the DCO.
> > > 
> > > If we're not willing to take the legal risk from this, we should
> > > probably leave the current AI policy unchanged instead of telling
> > > contributors that they have to work in a legal grey area.
> > > 
> > > Kevin
> > 
> > Which risk precisely? That a judge will close all LLMs overnight
> > declaring their output a derivative of the internet and so illegal to
> > use? Please.
> 
> I mean, at least morally that would be the right thing to do. If what
> they did isn't illegal, that's a bug in the law.

I'm not prepared to argue morality, and I don't even know who "they"
would be. But if an LLM is transformative then it's not a derivative,
that's a feature of the law, not a bug.


> But no, I don't expect this to happen, but am referring to the more
> commonly talked about case of LLMs occasionally reproducing a single
> source more or less verbatim, which is what could give you legal trouble
> even practically speaking.

They don't really seem to do that unless you try to ask them to.

> You can't know for sure if this happens, so I don't think you could sign
> the DCO (you really can't know for sure if you have "right to submit it
> under the open source license indicated in the file"), but you can check
> for suspicious things and if you don't find any, say it's probably okay.
> 
> You seem to be saying that it's not only probably okay, but definitely
> okay, but then that's even less of a problem.
> 
> > But just like "AI" does not mean "illegal" it does not mean "legal".
> > 
> > For example, if I give an LLM a chunk of code and say "adopt this to qemu" then
> > an argument can be made that it is a derivative of the code I supplied.
> > 
> > Whether to give an LLM web access so it can pull in random bits of code
> > and create derivatives of that is entirely under developer's control.
> > 
> > Whether AI output is a derivative of LLM weights is also an open
> > question, mitigated by the fact that many LLM vendors will assign
> > copyright to their users. Whether to use an LLM where that is the case
> > is also under developer's control.
> > 
> > I'm not sure why we need to get into so much detail, though.
> 
> See, you bring up uncertainties yourself that nobody can answer today.

Oh people can easily make sure their LLM is not poking at the web, today.

> This is exactly why I wouldn't want to make people lie and say "I know
> this is definitely okay", but accept "I tried to be careful and to the
> best of my knowledge there is no problem" instead for the licensing of
> LLM output.
> 
> This seems reasonable enough to me. I'm just saying that if others
> disagree and we're not willing to accept the weaker assertion that
> people actually can make in good faith, then we should stay out of LLM
> generated content entirely instead of making people lie.
> 
> Kevin


