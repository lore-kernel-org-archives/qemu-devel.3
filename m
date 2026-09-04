Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703A2C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2RFG-0006w7-Lt; Fri, 04 Sep 2026 06:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2RFF-0006te-0V
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2RFD-0003cD-4B
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788518041;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=akj6hNnIfQfnrcuBvr4BeqhD0K7ZzBBWbnTgWybPfBU=;
 b=dAG9VQFpWvFXLPh5yf3987jKNi0nBMhYaZ1Iw/DDgVzY+zQujG0bgU5F6kNGefo+j0mFbY
 0udFb5d9BVyNxEJSUPmcaSgFG0h5qtEcpI/7A49ksVK0DzLOR6LxmsRhAtIR2jyBNWIdOJ
 KLTisOtVGesG1810YWccdk5l+4aeaI4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-t3wqYgcZOWOpI582kvMVKg-1; Fri,
 04 Sep 2026 06:33:47 -0400
X-MC-Unique: t3wqYgcZOWOpI582kvMVKg-1
X-Mimecast-MFC-AGG-ID: t3wqYgcZOWOpI582kvMVKg_1788518026
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB36C1955DBE; Fri,  4 Sep 2026 10:33:45 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6345618005BD; Fri,  4 Sep 2026 10:33:43 +0000 (UTC)
Date: Fri, 4 Sep 2026 11:33:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: luoyonggang@gmail.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, anjo@rev.ng,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 00/47] single-binary: implement dynamic filtering for QOM
 types
Message-ID: <apqehMpGW63jQPIi@redhat.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <4b4f77ee-21e9-405e-a1da-21506afa1c5b@oss.qualcomm.com>
 <app_CnHimOrOymMH@redhat.com>
 <CAE2XoE9A1WzOe43-qd1v9i6K9kSru4R2kEE1-2TrztoM=8NZJw@mail.gmail.com>
 <CAFEAcA_4TZxYhFbHfJZCas7bvh_KZjNp2aKzx3LPaXTQFuoQYQ@mail.gmail.com>
 <apqVhJrtMDECUb7I@redhat.com>
 <CAFEAcA8f15tCXn2Ut4ke2Q1PX6qWyAdMnxK5iK9pNXebw4Vncg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8f15tCXn2Ut4ke2Q1PX6qWyAdMnxK5iK9pNXebw4Vncg@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 04, 2026 at 11:23:12AM +0100, Peter Maydell wrote:
> On Fri, 4 Sept 2026 at 10:55, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Fri, Sep 04, 2026 at 10:13:04AM +0100, Peter Maydell wrote:
> > >       That extends nicely to truly heterogenous machine names:
> > > "-machine my-mixed-machine" wouldn't need the user to explicitly
> > > give it a -target option or otherwise say that it includes aarch64
> > > and microblaze CPUs. (We'd probably need to put something in to
> > > prevent future machine name clashes across targets, so that the
> > > only clashes are our existing legacy ones.)
> >
> > We don't have many examples of clashing machine names. Is there
> > any beyond just the 'virt' boards ? Now that we know we want
> > globally unique names, this feels easy enough to spot during
> > review.
> 
> Yeah; but if it's easy to have it automatically detected during
> "make check" then that's more reliable than catching it by
> eye in code review, especially as most target-architecture
> reviewers are probably not very familiar with machine names used
> by other architectures.
> 
> > > This rests on the assumption that the only thing we need to
> > > disambiguate is machine names, i.e. there aren't multiple
> > > targets with user-facing (i.e. not easily renameable) device
> > > names that are shared.
> >
> > IMHO it is best if our goal is to ensure type names are unique
> > throughout the codebase, so hopefully we don't have clashing
> > device names.
> 
> Yes, that's certainly what I'd hope we have; but if you told
> me "actually it turns out that architectures foo and bar
> both have a simple interrupt controller they named 'intc'"
> I wouldn't be super surprised :-)

With a bit of grepping for TypeInfo declarations and TYPE_ constants
I found on possible clash in "openprom" which is defined separately
for sparc sun4m and sparc64 sun4u machines. Possibly those ought to
be using some common parent, but since they're built-in devices we
can likely just rename them to be unique.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


