Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54B1C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzaKg-0007zS-KR; Thu, 27 Aug 2026 09:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzaKf-0007z1-Nr
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:39:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzaKc-0003se-Nz
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787837989;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qH3mShZB+XOmnEkPOPaAr/PtkuZBNwHw182S/VQMPXc=;
 b=IS8iZnSwAip8PAhzZSWr5CrDrF52zQjH8+zj4iSKhK7h9ravMvVkBseEFoBVx5Rsz6ljBd
 rHkWo81TFg9xjNTXWeugzn4oE0gCQayWq3pgjHA3dsWsz/XQDiGoUTkTO2qNx99zFMbN/x
 jQ7L9bVt7iiUOsG0NQiATvv1r17Bv9M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-EVneE2scN0KFRW4rq_rn7A-1; Thu,
 27 Aug 2026 09:39:44 -0400
X-MC-Unique: EVneE2scN0KFRW4rq_rn7A-1
X-Mimecast-MFC-AGG-ID: EVneE2scN0KFRW4rq_rn7A_1787837977
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BE93195DE19; Thu, 27 Aug 2026 13:39:36 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67DC418005AD; Thu, 27 Aug 2026 13:39:26 +0000 (UTC)
Date: Thu, 27 Aug 2026 14:39:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex@shazbot.org>, linux-cxl@vger.kernel.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, qemu-trivial@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiri Pirko <jiri@resnulli.us>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, linux-edac@vger.kernel.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Lukas Straub <lukasstraub2@web.de>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v3 01/43] qapi: convert trivial intro sections for
 error.json
Message-ID: <apA-CzGqrlFNfjp5@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
 <20260826193840.2152000-2-jsnow@redhat.com>
 <ao_-_38raHK0rWkX@redhat.com> <87jypb90c0.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jypb90c0.fsf@pond.sub.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

On Thu, Aug 27, 2026 at 03:09:35PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Wed, Aug 26, 2026 at 03:37:58PM -0400, John Snow wrote:
> >> Signed-off-by: John Snow <jsnow@redhat.com>
> >> ---
> >>  qapi/error.json | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >> 
> >> diff --git a/qapi/error.json b/qapi/error.json
> >> index 54cb02fb880..a53b13e55c9 100644
> >> --- a/qapi/error.json
> >> +++ b/qapi/error.json
> >> @@ -9,8 +9,7 @@
> >>  
> >>  ##
> >>  # @QapiErrorClass:
> >> -#
> >> -# QEMU error classes
> >> +#     QEMU error classes
> >
> > Where is this need for indent coming from ?  From the POV of someone
> > writing comments, the need to indent the introductory text like this
> > feels very counter-intuitive, an exception from any other inline
> > docs syntax I've typically used. Is there any way we can avoid this ?
> 
> The cover letter explains the need:

Yes, I just didn't see the connection from that, to the use
of indent.

> 
>     This is being done primarily for the benefit of the forthcoming
>     "inliner", a feature for the rendered HTML QMP documentation that
>     seeks to "inline" QMP command argument documentation into the argument
>     list for each command.
> 
>     There are two main motives here:
> 
>     (1) We want the split between the "introduction" and "details"
>         sections to be mechanically obvious, so that auto-generated or
>         inlined documentation has a well-defined, obvious spot to go.
> 
>     (2) We do not want to inline irrelevant, introductory text describing
>         structures to be copied into command documentation.

So IIUC, you're saying that we are going to rely on indentation
to distinguish introduction from details ?


> Note that the inliner elided Netdev's Intro "Captures the configuration
> of a network device."
> 
> However, when Intro and Details bleed together, the inliner elides more
> than it should.  I consider that a fairly serious issue.
> 
> I'm afraid forgetting to mark the end of Intro with "Details:" would be
> a common mistake, easy to miss in review.  So I explored possible
> alternatives:
> 
>     Subject: Re: [PATCH v2 00/10] qapi: enforce section ordering
>     Date: Wed, 15 Apr 2026 11:43:45 +0200
>     Message-ID: <87zf341ru6.fsf@pond.sub.org>
>     https://lore.kernel.org/qemu-devel/87zf341ru6.fsf@pond.sub.org/
> 
> John is working towards "3. Make the end of intro syntactically obvious"
> always, specifically "3c. Indent intro like descriptions and tagged
> sections" with the ultimate goal to reject unindented Intro.  That way,
> we cannot write an Intro with an unclear end.  John, correct me if I'm
> accidentally misrepresenting your work.
> 
> Questions?  Better ideas?

As an author, how substantive is "Intro" expected to be? I guess on
QAPI docs I've written I've not ever been aware of there even being
a distinct concept of Intro vs Details to think about. It is all just
some lines of prose to me.

My only alternative idea to indentation would be to declare that the
"Intro" is always the 1st paragraph of text and anything beyond that
is the "Details". That might match up with the way that contributors
naturally write text where the 1st paragraph conveys the key idea,
such that they dno't need to think about Intro vs Details as a
concept.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


