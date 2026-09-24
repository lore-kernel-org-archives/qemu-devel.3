Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84DDC9830D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 02:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Z7y-0003So-F0; Wed, 23 Sep 2026 22:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x9Z7w-0003Sb-6s
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 22:24:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x9Z7u-0003aT-FE
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 22:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790216636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nmTfdejzArygVoWMwMs8tPnXa7qv1jv3YKb24Z3QYRI=;
 b=XNLSqhjQ+vK3xi/hCKN/KW7Kofuf/241SeSBHCZBPetyedz2VW3egrlOk3l1lfnTDOsmap
 RVtY/QlPMEcTekwwThtLjKvShHe+R6OL8x+v8iCung6tuoTbx5yt+FiotaIf0sOQ30ZMgv
 kvducXvMgzZguLyngZZ6fo0pNCQT+5w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-c3L6PDm9MJ-zSRkISwClSw-1; Wed, 23 Sep 2026 22:23:55 -0400
X-MC-Unique: c3L6PDm9MJ-zSRkISwClSw-1
X-Mimecast-MFC-AGG-ID: c3L6PDm9MJ-zSRkISwClSw_1790216634
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49e73659ac5so21750395e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 19:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790216634; x=1790821434; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nmTfdejzArygVoWMwMs8tPnXa7qv1jv3YKb24Z3QYRI=;
 b=dFgI96lwUCyILilEm1w44htjdhKpbhpLV9MNfBz2T3QdfI1V+9HuwyfcCEVas0Z7zW
 mrWQFgwGZ+w1PbA2VQ0ey8KGO8zSYKqXBdfO0wfoFl0VoUBOrFIU9n33bIHIjUhGGOgp
 NtQ79e2aztQuIh06huRedEkKImC9D+8vCckNuVQTi8N/G1egbSyuM7ZtN0EkTcKgRsvu
 u2wWnqr3EKt3tVI07QJ5NeQezOUdDp61AxjMrgwoD2PzYTrbBEzADkDhepD+q7M70iyB
 Zv/eSSY/3GOK6tXAKk2/Ips1mc1wia8vx8dGWZO57id8ZeHIG/Iu4Djwbh1xw1igc9zG
 tL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790216634; x=1790821434;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nmTfdejzArygVoWMwMs8tPnXa7qv1jv3YKb24Z3QYRI=;
 b=LCDbgxbMIQw0dq7WejmA/4Tr0THIbgnx3TXro7XohyhtSclKae2du6q/QQLaxJi0gT
 PhU8Y6o/+ZwzlTZ3lGcfhu68HqakaZFLHgr5GSQdp5uvTLipvU8Gfm3h3YcnoH5BjtZL
 hKx0ezZS8KXhHfCQun3r6dQ061lhO3sh3fNFu991udpodoKK7hgxZRagxnOpDBeoH3Tp
 ON7n92ekL/xL7IkU9jvJx1JImBG/2wlB0+qUHETmI921K7FfZt8/opAsVhE6rAVfk2lS
 /XZqWwLXyhPwK+43SS9GCJi6MES8/piuM3XNKQ5JFf23/sa06Akvvf9g28Vsw5nEEJEx
 2jMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzz/93oP2a+VEGBlAf3UZxSZP+P4NZhw1PexyRtlqXB6794QAa9RLcmUFh/6Ujorr+A4zyFAV1vSMRZ@nongnu.org
X-Gm-Message-State: AFuF++l9wx2u6Nch+wP5rnKYn+7D/hDNfvXAuJ6g3bEl0XaOZdibXhbb
 wDw4VYfXSdgam2e7L+wrkvCdU5dQdxDpqFx8jBkL4cRoQfhb6wztDIRh+Bc/1Nc/KPknQhMKCL2
 0v++qnTs18gKXp7AkyYZWlRgdwWLrr39SwMscFJBOl74Nr0pNJF420ZZH
X-Gm-Gg: AYBFou1oPPLOROk+gzse0pemd1IqjM9aors7QgijKp/U3ZkPC0HfPki/KS0P92DKcb9
 KIySOwo1QiAooVrrho2rRh8NIAHyN5lGW/sVc4erSKxWUWfOqwVJgkngQWWHXtWMk8lT6qD3H0m
 9tpivk6KAA9e8qQHa+2jimP5ZmUuTsQA5XXZyuYOE+ZYdrJY5npyFxzbI5eCeGs0s+q2PJkKG/b
 OE01sHuFZ3UO5zVqeMMV8KwbFfWO4bO5EFMQRdQQmI7M1DaXhh8N+f9Y1sKnMl2zZWNDuD0LyM/
 yGLdJ6JH2juotEBRZAsHIGaiD8PB2IF7r7CRh5QnaxPhiBl+wrC1BBXvo5WMApGhYRakREzTdV+
 pb55xuHbqqlEwnsjfg/4fTpIqr9rrTuElZ6y8TMke0TARJl8Q9765gFIDPHmHGg3UTw==
X-Received: by 2002:a05:600c:19d3:b0:49e:6777:da79 with SMTP id
 5b1f17b1804b1-49fe66fb4a7mr14460075e9.26.1790216633953; 
 Wed, 23 Sep 2026 19:23:53 -0700 (PDT)
X-Received: by 2002:a05:600c:19d3:b0:49e:6777:da79 with SMTP id
 5b1f17b1804b1-49fe66fb4a7mr14459855e9.26.1790216633491; 
 Wed, 23 Sep 2026 19:23:53 -0700 (PDT)
Received: from redhat.com
 (2a02-ab04-0158-f000-2548-f3bd-8b42-b18f.dynamic.v6.chello.sk.
 [2a02:ab04:158:f000:2548:f3bd:8b42:b18f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdf158147sm87272965e9.0.2026.09.23.19.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 19:23:52 -0700 (PDT)
Date: Wed, 23 Sep 2026 22:23:51 -0400
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
Message-ID: <20260923220502-mutt-send-email-mst@kernel.org>
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-2-pbonzini@redhat.com>
 <arEvLLYK9A5MKNdE@redhat.com> <arP7TDfz7lz699KJ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arP7TDfz7lz699KJ@redhat.com>
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

On Wed, Sep 23, 2026 at 06:16:12PM +0200, Kevin Wolf wrote:
> Am 21.09.2026 um 15:20 hat Daniel P. Berrangé geschrieben:
> > On Mon, Sep 21, 2026 at 09:52:48AM +0200, Paolo Bonzini wrote:
> > > +.. note:: **Use of AI does not remove the need for authors to comply
> > > +          with all other requirements for contribution.**  In particular,
> > > +          the ``Signed-off-by`` label in a patch submission is a statement
> > > +          that the author takes responsibility for the entire contents of
> > > +          the patch, certifying that their patch submission is made in
> > > +          accordance with the rules of the :ref:`Developer's Certificate of
> > > +          Origin (DCO) <dco>`.
> > > +
> > > +          Since a submitter cannot audit LLM output against its training
> > > +          data, the DCO is paired with :ref:`metadata in the commit message
> > > +          <ai-used-for>` about AI-generated parts.  The DCO still certifies
> > > +          that the contributor has the legal right to submit code in general.
> > 
> > I'm not a fan of this second paragraph, as that feels like it is undermining
> > the DCO. That first sentence in particular is somewhat saying that the
> > contributor does not have to think about plagarism and thed project is ok
> > with that, and also implying that the DCO doesn't apply to the LLM output.
> > This is both not OK in its implication of the project accepting some
> > liability, and then also contradicted by the next sentence.
> > 
> > IMHO this paragraph should just be removed.  The first paragraph clearly
> > states the DCO applies to the submission as a whole, and leaves all liability
> > for infringement on the contributor.
> 
> I don't think making this the individual contributor's problem is great.
> It's rather unfriendly towards contributors to expect them to certify
> something that we all know they can't honestly certify.
> 
> Our current AI policy was built on the assertion that it's impossible to
> sign the DCO for AI output, and I think that's still right. A developer
> can't certify the origin of something when they don't really know where
> it comes from.
> 
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
> 
> Kevin

Which risk precisely? That a judge will close all LLMs overnight
declaring their output a derivative of the internet and so illegal to
use? Please.

But just like "AI" does not mean "illegal" it does not mean "legal".

For example, if I give an LLM a chunk of code and say "adopt this to qemu" then
an argument can be made that it is a derivative of the code I supplied.

Whether to give an LLM web access so it can pull in random bits of code
and create derivatives of that is entirely under developer's control.

Whether AI output is a derivative of LLM weights is also an open
question, mitigated by the fact that many LLM vendors will assign
copyright to their users. Whether to use an LLM where that is the case
is also under developer's control.

I'm not sure why we need to get into so much detail, though.

-- 
MST


