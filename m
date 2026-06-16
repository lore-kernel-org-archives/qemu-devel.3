Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60DFCD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 16:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZWtB-0001hd-0c; Tue, 16 Jun 2026 12:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZWt8-0001gp-Rg
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 12:43:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZWt7-0002Bv-7P
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 12:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781628223;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ePpdY+5KphUB9g0JAZw709yvKIEar2RAnrbS2KtJajM=;
 b=dgFKLegNBb+Am3V4kuH4co3nbivTf9aPnPAWDJneJr1fJnvHor3fPtKW0bJSZXsoNBUrM8
 6aMXJDcRXQJ4GuCbxEc1JS74DPupfhtNreVDqi/iqMF6KLcW/Mel61QYAPTF6LptG9YnUn
 Ts6AEap27suNXwvv4+3En2iyee89hEU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-Q76XmsxkNbW9Y3VO5jp9iA-1; Tue,
 16 Jun 2026 12:43:40 -0400
X-MC-Unique: Q76XmsxkNbW9Y3VO5jp9iA-1
X-Mimecast-MFC-AGG-ID: Q76XmsxkNbW9Y3VO5jp9iA_1781628218
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68E6E1805C06; Tue, 16 Jun 2026 16:43:38 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.111])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93918180034F; Tue, 16 Jun 2026 16:43:32 +0000 (UTC)
Date: Tue, 16 Jun 2026 17:43:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [RFC 2/7] qom: deprecated embedding object structs within other
 objects
Message-ID: <ajF9MZzIyil8_OVY@redhat.com>
References: <20260616155554.264412-1-berrange@redhat.com>
 <20260616155554.264412-3-berrange@redhat.com>
 <CAFEAcA8twCjEdr6R=JPEuWzf2+Gvuznro290ZZW8Eb0zubLpew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8twCjEdr6R=JPEuWzf2+Gvuznro290ZZW8Eb0zubLpew@mail.gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Tue, Jun 16, 2026 at 05:15:22PM +0100, Peter Maydell wrote:
> On Tue, 16 Jun 2026 at 16:56, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > The QOM APIs currently allow objects to be either allocated directly
> > on the heap, or statically embedded inside the struct of another object.
> >
> > For the latter QOM has logic to avoid calling 'free' on the object when
> > finalizers complete, however, this is not sufficient to make the
> > practice safe.
> >
> > Users of QOM expect that if they call "object_ref" to acquire their own
> > reference, then object will never be freed as long as they hold it.
> >
> > This expectation is broken when an instance is embedded, as the "owner"
> > object's may be finalized, which frees the memory that is storing the
> > embedded QOM instance, even if its ref-count is still live.
> >
> > Worse still is that a user of a QOM object cannot easily tell if the
> > instance they're using is embedded or directly heap allocated.
> >
> > Mark the APIs for embedding objects as deprecated as the first step
> > towards removal of this flawed design concept. All objects must now
> > be directly heap allocated going forward, and existing usage must be
> > incrementally converted.
> 
> I think if you mark an API that we call in 800+ places and 150+ files
> as deprecated, mostly what will happen is nobody ever turns on the
> --enable-deprecated option because the output will be full of noise...

That is a challenge. The baseline is that developers have no visibility
of use of deprecated APIs at all, and we barely even document them.

My thought is that even if --enable-deprecated is rarely enabled, at
least having QEMU_DEPRECATED visible in the header files is a red flag
for developers to look elsewhere for their solution.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


