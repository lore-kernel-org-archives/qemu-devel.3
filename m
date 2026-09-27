Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2747EC98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAl3p-0004ds-Q9; Sun, 27 Sep 2026 05:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xAl3h-0004cS-UA
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:20:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xAl3f-0000vd-C7
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790500828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lh2giaqRBqZBsoy7Af/ETUxO56YXSXTEu0q4O2bVmHE=;
 b=fmZ9CgptkqFejTc5b75fEVSdg6u3Jt4zrXTdE1dSjMad2um6SrQtaVK4rQHx796pS1bkRa
 TthwoGhccNtbXqaA6DZ1pTQtN1IrmMD9sZpVkM3919ENpwZAllTsmzLMX70s17IYPwaGty
 J1kG1Gn4scaK5nBbAe9pEQdbyqJHin8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-4zsNpK9pNbe7bnWhcv93aA-1; Sun, 27 Sep 2026 05:20:27 -0400
X-MC-Unique: 4zsNpK9pNbe7bnWhcv93aA-1
X-Mimecast-MFC-AGG-ID: 4zsNpK9pNbe7bnWhcv93aA_1790500826
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49febef74e3so15438825e9.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790500826; x=1791105626; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lh2giaqRBqZBsoy7Af/ETUxO56YXSXTEu0q4O2bVmHE=;
 b=SvPM7QjNq5RCvHhQWrl2eZTMiE/dtgyNHBGZtiuT4iXfvvzSttinhXpTA0zkMlzw4K
 +NRhmaaP35pE4PSgvBNwcUVaPYECsCkBXIv2VVGT1uvaN/Zc1MK23cn4M72EDjaGYiWV
 84f08DA8G8vFzHMMX0haG4BOiMu5fyIEPsXgKgMdVmqUxiFBImZo3SgOSQ0d+8x86yPK
 nPGgRIKoQvZfZG+V64Df30hh5olcUNjijKzAMOkH37mZvzMCOUxSeNqM7D6a/YZFPurJ
 lK0nCA3XYnA2PnnIVIBt6OstUbX9GtkgmP7aaG8dWBC3MIjc6KVRl93/zk/6Y1enZTcz
 kQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790500826; x=1791105626;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lh2giaqRBqZBsoy7Af/ETUxO56YXSXTEu0q4O2bVmHE=;
 b=NyUV7p24yZc/dPLc6IiLbubzy++I3jJmbBOqDEJLNrh9uSn52+QYx9lzen1Vg4cUY0
 LKTujJ/HYECt1noirp8EMhiH94v39lQtrrad+2thvzjGmvjDswD4AmH+tWz02x6KWX3O
 +vUaok4Jc9z0bgSG6A2drgcB1BiXU6VkOWKcIXhiaepLmyb/7Jwv+sz9B3rgWqqbuFaf
 CV+NnnhP80wqWlQY4O0ErVcHoIKMKfCHVZHg8osbWOGX/GX2GoDjMSDHxHOlRKcDL3x3
 VXX5n8NFuAekwaNKt7tYad87N1Yw5M1TcOPh6aFQaEYGJV/3yCyNC6v+I5EmoOzDDg80
 WlZA==
X-Forwarded-Encrypted: i=1;
 AKwUvByYXvkJ326Dtm9zxPJwEQvh08lrGBroyocJ6byzNgs2r303RVhO0FId5/8q14Pf4xMC9GbFGGQGpuP7@nongnu.org
X-Gm-Message-State: AFuF++mJaPzO/jiz3zJWm1i2a2iwDRm8jFtvED1TmKZSdW631kYB+wI2
 38n6r5ZYziozNXh8rR70N05IVHPOwMlUZMYCphRAkfMulAde8TKaMRPtSRNAtOpSbcASiy+6Ko9
 l8tg6ECA46CnYi68X8+C5905FPvp6DqjBQI6NmTUVJHJMXYKS2EevRhxX
X-Gm-Gg: AYBFou3vxQHv9ykuTGABcBcGUx5x1LMcJkWwx4aBFzp3fTVD6J5WwOPYqrM11QNu5AX
 5P7OObGxpuQUFxTWql5UuZpC6VkTTU5SAhMtxmmw/FiEP04lSZ9p7Feu9BokERGLAjzp8b/KaCk
 o9FpANNhMdJDgjQBRYl18OyNqsWVxVa9qmZBg3tFwENIc+uaiIt3YtHtBVsHuZ1kXlEfkkaHkqZ
 Zcz/t2nAd1TBhHahFMGHR63XuFYnxo7O3vCrpqmO1lYCvrvBG0UXWI4SxydU6AAkbkWRYG1CC3M
 wugMfXP9xBi7MG4ZHtl5yT3UpN2jWqzEz/DL9Q6E+H248aMT7XrGF2i2pPObtd+lcbwv6/H5Fnw
 WdVPvbjG+SxkJVLkJ3F7VOPged7tHfZABO1aZYbrUTK2e2WzlGqd9AF2CGHNwMFjf/Q==
X-Received: by 2002:a7b:c314:0:b0:49f:bb49:9cca with SMTP id
 5b1f17b1804b1-49fe66cf67amr144186185e9.5.1790500825771; 
 Sun, 27 Sep 2026 02:20:25 -0700 (PDT)
X-Received: by 2002:a7b:c314:0:b0:49f:bb49:9cca with SMTP id
 5b1f17b1804b1-49fe66cf67amr144185995e9.5.1790500825265; 
 Sun, 27 Sep 2026 02:20:25 -0700 (PDT)
Received: from redhat.com
 (2a02-ab04-0158-f000-2548-f3bd-8b42-b18f.dynamic.v6.chello.sk.
 [2a02:ab04:158:f000:2548:f3bd:8b42:b18f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a354d57sm18590430f8f.14.2026.09.27.02.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:20:24 -0700 (PDT)
Date: Sun, 27 Sep 2026 05:20:22 -0400
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
Message-ID: <20260927050956-mutt-send-email-mst@kernel.org>
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-2-pbonzini@redhat.com>
 <arEvLLYK9A5MKNdE@redhat.com> <arP7TDfz7lz699KJ@redhat.com>
 <87ik3vyp3i.fsf@draig.linaro.org> <arT_kefzEhqg8-FB@redhat.com>
 <20260924120617-mutt-send-email-mst@kernel.org>
 <arVmjZTsLVLH0bm0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arVmjZTsLVLH0bm0@redhat.com>
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

On Thu, Sep 24, 2026 at 08:06:05PM +0200, Kevin Wolf wrote:
> Am 24.09.2026 um 18:06 hat Michael S. Tsirkin geschrieben:
> > On Thu, Sep 24, 2026 at 12:46:41PM +0200, Kevin Wolf wrote:
> > > Am 24.09.2026 um 11:29 hat Alex Bennée geschrieben:
> > > > Kevin Wolf <kwolf@redhat.com> writes:
> > > > 
> > > > > Am 21.09.2026 um 15:20 hat Daniel P. Berrangé geschrieben:
> > > > >> On Mon, Sep 21, 2026 at 09:52:48AM +0200, Paolo Bonzini wrote:
> > > > >> > +.. note:: **Use of AI does not remove the need for authors to comply
> > > > >> > +          with all other requirements for contribution.**  In particular,
> > > > >> > +          the ``Signed-off-by`` label in a patch submission is a statement
> > > > >> > +          that the author takes responsibility for the entire contents of
> > > > >> > +          the patch, certifying that their patch submission is made in
> > > > >> > +          accordance with the rules of the :ref:`Developer's Certificate of
> > > > >> > +          Origin (DCO) <dco>`.
> > > > >> > +
> > > > >> > +          Since a submitter cannot audit LLM output against its training
> > > > >> > +          data, the DCO is paired with :ref:`metadata in the commit message
> > > > >> > +          <ai-used-for>` about AI-generated parts.  The DCO still certifies
> > > > >> > +          that the contributor has the legal right to submit code in general.
> > > > >> 
> > > > >> I'm not a fan of this second paragraph, as that feels like it is undermining
> > > > >> the DCO. That first sentence in particular is somewhat saying that the
> > > > >> contributor does not have to think about plagarism and thed project is ok
> > > > >> with that, and also implying that the DCO doesn't apply to the LLM output.
> > > > >> This is both not OK in its implication of the project accepting some
> > > > >> liability, and then also contradicted by the next sentence.
> > > > >> 
> > > > >> IMHO this paragraph should just be removed.  The first paragraph clearly
> > > > >> states the DCO applies to the submission as a whole, and leaves all liability
> > > > >> for infringement on the contributor.
> > > > >
> > > > > I don't think making this the individual contributor's problem is great.
> > > > > It's rather unfriendly towards contributors to expect them to certify
> > > > > something that we all know they can't honestly certify.
> > > > 
> > > > This is the current position with the DCO anyway. If the contributor has
> > > > copy and pasted (and maybe adapted) from Stack Overflow they are still
> > > > realistically the only person that can make that judgement.
> > > 
> > > Yes, that's the current position with the DCO and the reasoning why we
> > > said LLM output is unacceptable in submissions.
> > > 
> > > The big difference is if I copy and pasted from Stack Overflow, I _know_
> > > that I did that. If the LLM effectively does it for me, I don't know
> > > that. The best I can do is check if I can find similar code elsewhere.
> > 
> > You can block your LLM from accessing stack overflow.
> 
> Given that training my own model from scratch isn't a realistic option,
> I can't block the LLM from being trained on data from Stack Overflow.
> 
> Kevin

But again, that is beside the point, unless you believe that a judge
will (or should?) close all LLMs overnight declaring their output a
derivative of the internet and so illegal to use. If not, training is
transformative, and LLM output is not a derivative of the internet
*unless it is input with Stack Overflow*.

-- 
MST


