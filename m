Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FDCC98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 16:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lyf-0001GO-2Y; Thu, 24 Sep 2026 12:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x9lyV-0001G0-8O
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 12:07:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x9lyS-0004H5-H7
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 12:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790266021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iqNAMj2NMtgXHXuOQfm8L/ME5UAEf0s+MlewdUDj4UI=;
 b=GfhhHZtxqMek8zEfOcckDEA/zk5xR139OQTPxwzs33yqZf3EYFk1E1x1vxMdnYSQYAJ1gp
 IFXhF5GFt7imWH7KI9yq/XaBZXbG2ng7KH0Llcrejm6ni+zCAtfKJkK2m0qVZvpCSqDjm3
 VWoLI+z7NB0jQZVaw8X6IkT4zMNdU/s=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-rHkqjp95NFCvV_cHCUIIXg-1; Thu, 24 Sep 2026 12:06:59 -0400
X-MC-Unique: rHkqjp95NFCvV_cHCUIIXg-1
X-Mimecast-MFC-AGG-ID: rHkqjp95NFCvV_cHCUIIXg_1790266019
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c294ae16922so275332566b.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 09:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790266019; x=1790870819; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iqNAMj2NMtgXHXuOQfm8L/ME5UAEf0s+MlewdUDj4UI=;
 b=QY14Jy5dQk8O/E6wQ2qwTlxqbBNWILWhmBDpHrQ17OEu/SfoTyUmm0VIgGHUSWPI9s
 W/JGp0ZMqoDs3OPzxtkocpn8DnvELIgiQm93hYImURG/c0FJCo97cMsDMMoXgs2waWYf
 OyUHW1r/uQhK+fJff9b0MlVttcRSmDbx8+sVoQYGh75WlFowTQL16xGt3fwoZsM6PJYt
 pHtgIMxdoEXo2j3BipQFjbln0cjt+U2ekgrmoHHUeDYpCf+kSJHr3gwTkqVu1CALG1iz
 lwe6LFm+ZoaMNOlzRnkM4wdBhV0hF2Es9pkBhLcg8yYuowca4JTVUtm5vsq4FLMuM2QJ
 4nZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790266019; x=1790870819;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iqNAMj2NMtgXHXuOQfm8L/ME5UAEf0s+MlewdUDj4UI=;
 b=PIcs9q/QE7ANiRVG0bwRkOITSdTYRVACxyRxhTcbGw0RQ40zIZYpIP6GxsqTr9FaS3
 JHvkQ9LgCdgpEQZDRxv5Sl/xSHQ2fq4ND6W784RD0lC9B8xvEbLDjpd/MckvkH5TkiEl
 isLboa+nQzoZHhQPj02D56+qZ9KRCmPKpNmkybBIEY9Tc3l07+XzxHmlgGFAbR7qD2LF
 VT94zBe9k4wvoME/jzoe80MkRWjmcKKahukG9QyzfcXa/vwtOT0EMsJXADgYQUGTj82F
 ymyShPhnPC2qrSrHe00Oe0kOOO2yU04voSSFLOQ99AxPaQetjrfcFeSn1ffEXT7ELlRC
 yZ/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8trMLA2rHB1bNxGBF5mp0VwNEk+iLHcGw4bblSZPf1uoPURKMdidEHjt4+YQDSl/BqChaHsGRO0Vt@nongnu.org
X-Gm-Message-State: AFuF++ksHZJYzpvFYAkn8zl4/jJfkuCLnpvgC7Gvn/MuyW6shsevkf8f
 RbS1AZb8jeejTH4URnIGudwgP21w/2apAiWvrlHIY+PmTKYbKoBiNTOA/J7nIRpH61018amUMlB
 XoRbBSxalXJSJGzJ7WkMJeJuDFwS+rrtUewvmhnvibcCOi/ZBrKn5ZVGP
X-Gm-Gg: AYBFou3gIfx19Myx93EqbajvOhOmiiXgMxZJQiu8CElO00IjkXjFzapIKVx3lgjvcAg
 wR2Izpt9h07oi419Tf78IiSuDv6Kj5oV4HtFTDdPGiasFLePccgZQVZoZeaO3dvpbafcTQvE6ru
 pQG32gqQPaM896cIy6yBJV29dtKC3rOakGSiOHIOiMd+gAKBmWoaNVvwQ1LvElNVuGHWY8aDi8j
 hj6tbd1e8vInYkcf6lsY/nrCihCxCRlnkz0uY56BmbO7+apE8E0ZIO8477I15ivoOm8j19ryeNI
 l81sGnQvhcIoDzzqzSe6Y/xUSDpkE2JBjZYooq4Uu2g9mFDEAb+U0LBVOrVk7pcb8dwOEnMkBug
 /PguczBSYKSrLrF45p6yjG2RTzvPbTz4BEqK/vyMQRDFOPyuF6ga8l3eez+aPm22Q3A==
X-Received: by 2002:a17:907:7211:b0:c26:1648:a062 with SMTP id
 a640c23a62f3a-c2ac2499a50mr286037266b.29.1790266018576; 
 Thu, 24 Sep 2026 09:06:58 -0700 (PDT)
X-Received: by 2002:a17:907:7211:b0:c26:1648:a062 with SMTP id
 a640c23a62f3a-c2ac2499a50mr286032966b.29.1790266018054; 
 Thu, 24 Sep 2026 09:06:58 -0700 (PDT)
Received: from redhat.com
 (2a02-ab04-0158-f000-2548-f3bd-8b42-b18f.dynamic.v6.chello.sk.
 [2a02:ab04:158:f000:2548:f3bd:8b42:b18f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2aae60f7desm318635666b.27.2026.09.24.09.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 09:06:57 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:06:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
Message-ID: <20260924120617-mutt-send-email-mst@kernel.org>
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-2-pbonzini@redhat.com>
 <arEvLLYK9A5MKNdE@redhat.com> <arP7TDfz7lz699KJ@redhat.com>
 <87ik3vyp3i.fsf@draig.linaro.org> <arT_kefzEhqg8-FB@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arT_kefzEhqg8-FB@redhat.com>
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

On Thu, Sep 24, 2026 at 12:46:41PM +0200, Kevin Wolf wrote:
> Am 24.09.2026 um 11:29 hat Alex Bennée geschrieben:
> > Kevin Wolf <kwolf@redhat.com> writes:
> > 
> > > Am 21.09.2026 um 15:20 hat Daniel P. Berrangé geschrieben:
> > >> On Mon, Sep 21, 2026 at 09:52:48AM +0200, Paolo Bonzini wrote:
> > >> > +.. note:: **Use of AI does not remove the need for authors to comply
> > >> > +          with all other requirements for contribution.**  In particular,
> > >> > +          the ``Signed-off-by`` label in a patch submission is a statement
> > >> > +          that the author takes responsibility for the entire contents of
> > >> > +          the patch, certifying that their patch submission is made in
> > >> > +          accordance with the rules of the :ref:`Developer's Certificate of
> > >> > +          Origin (DCO) <dco>`.
> > >> > +
> > >> > +          Since a submitter cannot audit LLM output against its training
> > >> > +          data, the DCO is paired with :ref:`metadata in the commit message
> > >> > +          <ai-used-for>` about AI-generated parts.  The DCO still certifies
> > >> > +          that the contributor has the legal right to submit code in general.
> > >> 
> > >> I'm not a fan of this second paragraph, as that feels like it is undermining
> > >> the DCO. That first sentence in particular is somewhat saying that the
> > >> contributor does not have to think about plagarism and thed project is ok
> > >> with that, and also implying that the DCO doesn't apply to the LLM output.
> > >> This is both not OK in its implication of the project accepting some
> > >> liability, and then also contradicted by the next sentence.
> > >> 
> > >> IMHO this paragraph should just be removed.  The first paragraph clearly
> > >> states the DCO applies to the submission as a whole, and leaves all liability
> > >> for infringement on the contributor.
> > >
> > > I don't think making this the individual contributor's problem is great.
> > > It's rather unfriendly towards contributors to expect them to certify
> > > something that we all know they can't honestly certify.
> > 
> > This is the current position with the DCO anyway. If the contributor has
> > copy and pasted (and maybe adapted) from Stack Overflow they are still
> > realistically the only person that can make that judgement.
> 
> Yes, that's the current position with the DCO and the reasoning why we
> said LLM output is unacceptable in submissions.
> 
> The big difference is if I copy and pasted from Stack Overflow, I _know_
> that I did that. If the LLM effectively does it for me, I don't know
> that. The best I can do is check if I can find similar code elsewhere.

You can block your LLM from accessing stack overflow.


> 
> So while I can certify with 100% confidence that I didn't manually copy
> things for code that I wrote myself, I can't certify that code from
> other sources, including LLMs, isn't copied from elsewhere. I can only
> say that I didn't find any reason to suspect it's copied.
> 
> > > Our current AI policy was built on the assertion that it's impossible to
> > > sign the DCO for AI output, and I think that's still right. A developer
> > > can't certify the origin of something when they don't really know where
> > > it comes from.
> > 
> > It's certainly possible for LLMs to replicate copyright material but by
> > far the biggest influence is the code *in the project* that shapes the
> > output. It is basically pattern matching and predicting after all.
> 
> If there is one chunk of code that violates the copyright of someone,
> you can't heal that just by having 1000 more chunks that are clean.
> 
> > What level of reassurance the submitter needs to be able to certify with
> > their DCO is up to them. We can't police it, like every other submission
> > we rely in the submitters good faith representation of what they have
> > done.
> 
> The DCO doesn't talk about levels of reassurance. It talks about hard
> facts, 100% confidence.
> 
> And that I can't give you with LLM generated content. I can maybe give
> you 99%, but never 100%.
> 
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
> > 
> > I don't think we are asking them to work in a legally grey area, we are
> > insisting they are confident there is no legal risk in what they submit.
> 
> If anyone is 100% "confident there is no legal risk", then I think
> they're simply wrong (unless the contribution is obviously not
> copyrightable anyway). The real question is if the risk is low enough.
> 
> But I suspect in most cases it's actually more like they're only 99%
> confident and think "ah well, I'll sign it anyway, I probably won't get
> into trouble". That gives people who are willing to bend the rules a
> little an advantage over more conscientious contributors, which I don't
> think is justified, because in the end it's the same 99% certainty for
> both.
> 
> Kevin


