Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85673C9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB6ec-0002gC-7j; Mon, 28 Sep 2026 04:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xB6ea-0002fz-9J
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 04:24:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xB6eX-00005Q-W4
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 04:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790583840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mJsf641erLZCGkPMx5mFlPFGzVHiMUTS62rMDcD/Ses=;
 b=VL8tE83ePk+CyV9jt3Z+bnf9SSPELtrAlwXUssgXtqwCoUjVnRRA2dljhbl/3HcZH0GFsK
 jqbnkueoAsr0BcrXm6XxASgZ3Ffo8etgs7D0bT4q529QbOusTJdZ9IXi4Ktc0QGD30JTts
 P0Ib/ca0l3yPKXx/7aQV4V/DtoPTlTw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-LP-jkB8TP52C4q9uI53MhA-1; Mon, 28 Sep 2026 04:23:59 -0400
X-MC-Unique: LP-jkB8TP52C4q9uI53MhA-1
X-Mimecast-MFC-AGG-ID: LP-jkB8TP52C4q9uI53MhA_1790583838
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4888945a74fso1821811f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 01:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790583838; x=1791188638; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mJsf641erLZCGkPMx5mFlPFGzVHiMUTS62rMDcD/Ses=;
 b=R6oxEpsk1eg3nQ5AlbLgjNokCZnKFB62MkiI7cQAP+8wGWj4UwdEdDsRdjUmd9gyW3
 bl6MQjyn4eXCNiiSAALtLXsM4EzApoZuoJn5MwAChRJ61RZmDLv+GZEkICi8za8yVPSu
 jSYsSrZlx4j8CKmv1cvWqzZdI4/vPC8hj1z6NSM+efBg0j1ArZ73Mt3JNmC/atnsMbU5
 yDOZN/4HjonKm7Z1V/hDNbFCmhoTBYvCaBmhst0NEA2WjP047mBfA4++4DmzC94GnnP/
 B74Ex3YCznvfHlNAVdzVXrKrRN8gOHhmg1fYz0JSWSOy91D0/lWS/ms3jiQsrN61jAYF
 LBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790583838; x=1791188638;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mJsf641erLZCGkPMx5mFlPFGzVHiMUTS62rMDcD/Ses=;
 b=urB/sPMOUlpBFsUywNb3oW02hrRMJCsIhyiS12OyhbQjIKEty7vEJrtw/dLfbnjqGq
 bcSW0JYEQqFFwfrGkhuDxGyVciVxkQ4M/NIi/bWeh+EqcmTuT6YWRHHIALtkn1RQpkP+
 FWdeG7XFg4uprqb2LAbpMVLkpzjfE9kZ3M8NbXwQy9l5YokvNiB1kOTfcjDA+x3vmYzW
 k4rvdetYQa7ioLH53Yk6dkYid2igPcXalAC/ilL5fDJwkrZNSgVfwCGrWeMZITFn8tng
 J4eeEEa/Vni/VuHNge1R7Dyav+/utXClDWlu2IJ7UiXGc1c4IRsA74wHl5fKlwGh/KOO
 v/LA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzTIVijD2RIuLhtksKxgZ63XN34hsQ2HiQ+8gRBFxf2q2kNSLjtKH490kbVFEtkNjkkBuGiB86aybca@nongnu.org
X-Gm-Message-State: AFuF++nPHfYzcmEr9EXHIMAd7AhMenIBWKIdzoC2VCJpA4fWyyFvSjuL
 ihX/On1VCeRMkchR20HlXLltAFboP9YKLNGeECQb8RdoD08LpoedbXoe5VyFbhyngRG5iOraWI9
 hwZXorNZek5fHi3ZbWGRzQTFCNQPthJZhwfWYiclBn4xoUTJZrq5GI6kV
X-Gm-Gg: AYBFou1FLCqy/xmKCPnlXIQ8yKaYYSlzDzUe4bTBkJrsJvdfLnBCPNxd7evhurvOcnE
 d30gI0gGE8WyV3pouHUKHdRDNzh25gNxfealsISAeLPzyS+SCEQZCSZZfFLZ/ZbZ54uB59pnxTv
 VCF08glotfqO2aUqn4mN2D8xSz5xWn4yCAnWt5lfwdkSR94AEjej6UrvLtudhJpxVTnHGIMDPvf
 Px222XN+pYrl2Lwl8ohliPmgHFW/X/vDkp+Z+NmyZV1a7Q37etaLTdnwzlI35FH+pL5XvU5KOUR
 w5GV9zvkGlSvPRCOeZOoisL6V/VG+vS0R3NCYxsDCoRs54XkdrUofx3gT0k+h5tjLvDMpJsvIyQ
 7p854h/JX9085y6fWiOhpr2Hc/UbDPOAtHQaLKOyZonUbBtqj/EvZPYQvvgSngWZQiQ==
X-Received: by 2002:a05:600c:3b05:b0:4a0:321:6ddd with SMTP id
 5b1f17b1804b1-4a003217170mr45153785e9.34.1790583837512; 
 Mon, 28 Sep 2026 01:23:57 -0700 (PDT)
X-Received: by 2002:a05:600c:3b05:b0:4a0:321:6ddd with SMTP id
 5b1f17b1804b1-4a003217170mr45153455e9.34.1790583837029; 
 Mon, 28 Sep 2026 01:23:57 -0700 (PDT)
Received: from redhat.com
 (2a02-ab04-0158-f000-2548-f3bd-8b42-b18f.dynamic.v6.chello.sk.
 [2a02:ab04:158:f000:2548:f3bd:8b42:b18f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fef4fc959sm232969785e9.2.2026.09.28.01.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 01:23:56 -0700 (PDT)
Date: Mon, 28 Sep 2026 04:23:54 -0400
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
Message-ID: <20260928041617-mutt-send-email-mst@kernel.org>
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-2-pbonzini@redhat.com>
 <arEvLLYK9A5MKNdE@redhat.com> <arP7TDfz7lz699KJ@redhat.com>
 <87ik3vyp3i.fsf@draig.linaro.org> <arT_kefzEhqg8-FB@redhat.com>
 <20260924120617-mutt-send-email-mst@kernel.org>
 <arVmjZTsLVLH0bm0@redhat.com>
 <20260927050956-mutt-send-email-mst@kernel.org>
 <aroeF0CsjLoOszRJ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aroeF0CsjLoOszRJ@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Sep 28, 2026 at 09:58:15AM +0200, Kevin Wolf wrote:
> Am 27.09.2026 um 11:20 hat Michael S. Tsirkin geschrieben:
> > On Thu, Sep 24, 2026 at 08:06:05PM +0200, Kevin Wolf wrote:
> > > Am 24.09.2026 um 18:06 hat Michael S. Tsirkin geschrieben:
> > > > On Thu, Sep 24, 2026 at 12:46:41PM +0200, Kevin Wolf wrote:
> > > > > Am 24.09.2026 um 11:29 hat Alex Bennée geschrieben:
> > > > > > Kevin Wolf <kwolf@redhat.com> writes:
> > > > > > 
> > > > > > > Am 21.09.2026 um 15:20 hat Daniel P. Berrangé geschrieben:
> > > > > > >> On Mon, Sep 21, 2026 at 09:52:48AM +0200, Paolo Bonzini wrote:
> > > > > > >> > +.. note:: **Use of AI does not remove the need for authors to comply
> > > > > > >> > +          with all other requirements for contribution.**  In particular,
> > > > > > >> > +          the ``Signed-off-by`` label in a patch submission is a statement
> > > > > > >> > +          that the author takes responsibility for the entire contents of
> > > > > > >> > +          the patch, certifying that their patch submission is made in
> > > > > > >> > +          accordance with the rules of the :ref:`Developer's Certificate of
> > > > > > >> > +          Origin (DCO) <dco>`.
> > > > > > >> > +
> > > > > > >> > +          Since a submitter cannot audit LLM output against its training
> > > > > > >> > +          data, the DCO is paired with :ref:`metadata in the commit message
> > > > > > >> > +          <ai-used-for>` about AI-generated parts.  The DCO still certifies
> > > > > > >> > +          that the contributor has the legal right to submit code in general.
> > > > > > >> 
> > > > > > >> I'm not a fan of this second paragraph, as that feels like it is undermining
> > > > > > >> the DCO. That first sentence in particular is somewhat saying that the
> > > > > > >> contributor does not have to think about plagarism and thed project is ok
> > > > > > >> with that, and also implying that the DCO doesn't apply to the LLM output.
> > > > > > >> This is both not OK in its implication of the project accepting some
> > > > > > >> liability, and then also contradicted by the next sentence.
> > > > > > >> 
> > > > > > >> IMHO this paragraph should just be removed.  The first paragraph clearly
> > > > > > >> states the DCO applies to the submission as a whole, and leaves all liability
> > > > > > >> for infringement on the contributor.
> > > > > > >
> > > > > > > I don't think making this the individual contributor's problem is great.
> > > > > > > It's rather unfriendly towards contributors to expect them to certify
> > > > > > > something that we all know they can't honestly certify.
> > > > > > 
> > > > > > This is the current position with the DCO anyway. If the contributor has
> > > > > > copy and pasted (and maybe adapted) from Stack Overflow they are still
> > > > > > realistically the only person that can make that judgement.
> > > > > 
> > > > > Yes, that's the current position with the DCO and the reasoning why we
> > > > > said LLM output is unacceptable in submissions.
> > > > > 
> > > > > The big difference is if I copy and pasted from Stack Overflow, I _know_
> > > > > that I did that. If the LLM effectively does it for me, I don't know
> > > > > that. The best I can do is check if I can find similar code elsewhere.
> > > > 
> > > > You can block your LLM from accessing stack overflow.
> > > 
> > > Given that training my own model from scratch isn't a realistic option,
> > > I can't block the LLM from being trained on data from Stack Overflow.
> > > 
> > > Kevin
> > 
> > But again, that is beside the point, unless you believe that a judge
> > will (or should?) close all LLMs overnight declaring their output a
> > derivative of the internet and so illegal to use. If not, training is
> > transformative, and LLM output is not a derivative of the internet
> > *unless it is input with Stack Overflow*.
> 
> You're treating things as black and white here, which is maybe how
> things should be, but not how they are in practice today. At least my
> understanding is that the common interpretation is that LLM output is
> generally okay, but if it reproduces an existing work too closely, then
> you're still infringing on its copyright and that's your own problem.

As far as I understand, it's not true that you are "still infringing" -
rather, the courts did not yet decide this question.
Correct me if I am wrong.

They might in theory decide that yes.  We can decide to wait until some
court decides that no, and decline AI contributions until then.  Though
I note that there's no limit here - there's always a chance some court
decides differently. Traditionally, the free software community used
e.g. the GPL without waiting for it to be "tested in courts".





> Just because in >99% of cases the model doesn't reproduce things from
> the training data too closely, that doesn't automatically make
> everything it produces from training data clean. And this is the part
> that courts in different jurisdictions have even decided on, so it's not
> just speculation. I'm not aware of any court declaring that LLMs are
> purely transformative and everything that comes from training data is
> automatically good (though I'm also not aware of a court deciding the
> opposite; it seems to be always just about the result in the individual
> case and how much it resembles existing works).
> 
> Kevin


Really, QEMU internal APIs and coding style being as unique as they are,
I have a lot of trouble even imagining any code that is substantially
similar to anything on the internet and still being accepted into QEMU.

At least as long as humans and not AIs read it)


-- 
MST


