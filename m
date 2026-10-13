Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930D0CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGYmZ-0002od-CJ; Tue, 13 Oct 2026 05:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGYmX-0002oH-75
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 05:26:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGYmT-0004Uu-7W
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 05:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791883603;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Q0OZL1995Bz696SPHYwnvGMDPJ13sGzioecQYMEGYjk=;
 b=DdfFQg/YqEpA58cpwKC7Tyq1f4TfTYk0iw3JuSttSBj7qoRJHIBhaU5RHxbnDJEwusNBzM
 HPSOYFwIw4BJHOp/OG2pDq+PeZDYqDShoDAQZluTkiB81Qu1oHb85RaFxu16xHQOPVHXOR
 2QQbc+iG25/rp3YST8B+FYn5UAhVtcY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-d1s6RyTgMQaJ8obtjPUvHg-1; Tue,
 13 Oct 2026 09:26:39 +0000
X-MC-Unique: d1s6RyTgMQaJ8obtjPUvHg-1
X-Mimecast-MFC-AGG-ID: d1s6RyTgMQaJ8obtjPUvHg_1791883597
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECE3A180AD43; Tue, 13 Oct 2026 09:26:35 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8D80195608B; Tue, 13 Oct 2026 09:26:28 +0000 (UTC)
Date: Tue, 13 Oct 2026 10:26:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: luoyonggang@gmail.com, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Stafford Horne <shorne@gmail.com>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Alexander Bulekov <alxndr@bu.edu>,
 Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH 4/8] target-info: replace QOM registration with a
 constructor list
Message-ID: <as35QRodxSk16e-F@redhat.com>
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <20261007115253.328-5-luoyonggang@gmail.com>
 <37275f1f-aee9-444b-aaed-3e0bf34b63cd@oss.qualcomm.com>
 <CAE2XoE_GmDbA5SSUb3k_9HwE+bxnBjK+kBj-RE5BonEBC=GpMw@mail.gmail.com>
 <919a1a75-78b9-42a9-93ed-9edf6757f707@oss.qualcomm.com>
 <CAE2XoE8G7Pyu-UaoW0BRxHqEX2aef_ak29mAkwwssSS5Rf_y5A@mail.gmail.com>
 <578afeb7-d302-402e-bedf-43b29ef00d5b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <578afeb7-d302-402e-bedf-43b29ef00d5b@oss.qualcomm.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 07, 2026 at 04:24:07PM -0700, Pierrick Bouvier wrote:
> On 10/7/2026 3:54 PM, Yonggang Luo wrote:
> > My work is here.
> > https://gitlab.com/lygstate-qemu/qemu/-/tree/combined-binary-multi-targets?ref_type=heads
> > I am afraid of posting 300 pathces into threads to flood it(and
> > disturbing yours). So I'll wait for your work first. and resolving
> > conflicts later, that's really time-consuming.
> >
> 
> It's indeed not possible to send 300 patches and expect this to work,
> whether it's on this mailing list, or any software forge also.
> It's also not possible to send a link, and expect anyone to take a look
> at the 373 commits sitting it on top of master. My name is not Claude.
> Instead, humans have to progress step by step, based on feedback. Yes it
> takes time and it can be frustrating. And yes, I've been there (and
> frustrated) also, I feel sorry for you.
> 
> At the moment, if we want to make it move on, we need to focus on one
> single thing:
> "How to document/specify which targets a machine support".
> 
> > I did many explanations before. seems my explanation is too bad and
> > not to give a clean picture for you, let's delay these first.
> >
> 
> If I can suggest something politely here, IMHO, alternating between
> genuinely human written messages, and AI content sent as it is on email
> or commit messages is not helping on the receiver side.
> 
> I would prefer anytime to deal with imperfect english (mine is imperfect
> too, I'm not a native speaker neither), compared to read what
> Claude/GPT/Deepseek generated that was pasted as it is.
> I understand it's a good tool for helping on the language side, and
> that's ok to fix grammar and sentence structure.
> But asking "Please generate a summary from those email threads and
> explain what the current series is doing", and paste this is doomed to fail.
> 
> It also has a very detrimental side effect: it makes me start to wonder
> where the code is coming from also. Especially when seeing boilerplates
> with lengthy comments written in perfect english. My 2 cents is, use AI
> if you want/need, but make sure the result has this *human* touch.

Although these are not yet final/commited, please bear in mind the
proposed updated AI guidelines which broadly intend to forbid use
of AI for authoring commit messages & cover letters:

  https://lists.gnu.org/archive/html/qemu-devel/2026-09/msg00260.html


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


