Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294A0C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 18:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riI3e-0000vv-Om; Thu, 07 Mar 2024 13:01:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1riI3d-0000vm-IS
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:01:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1riI3b-0000ww-OF
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709834486;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c39cvUgsYwuGqIPjfHGcg/RuIORHcXIMpVYsi6nWlcI=;
 b=We3vfySneabzE9pjgQZbygdVBF7osFxrcmA0cTuu+Cq8WQw6XlhDTWHrRTDKt2O9cVwZ/r
 qF6rjBk7wZL7ChYLYcZgSCvpBPTSB17DYyf/3eMirydpEMTu6v4KWqtSwkSx0GBz2afTDi
 Z+vbD8D3+TVMsu4l68Hm89bbrmYo/C4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-cZJRMJ_uM5WflnfXWjl3jw-1; Thu,
 07 Mar 2024 13:01:22 -0500
X-MC-Unique: cZJRMJ_uM5WflnfXWjl3jw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CED1285F98D;
 Thu,  7 Mar 2024 18:01:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93A7E40C6CB5;
 Thu,  7 Mar 2024 18:01:21 +0000 (UTC)
Date: Thu, 7 Mar 2024 18:01:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/3] ui/gtk: skip drawing guest scanout when associated
 VC is invisible
Message-ID: <ZeoA78gWLSuntQ1V@redhat.com>
References: <20240130234840.53122-1-dongwon.kim@intel.com>
 <20240130234840.53122-2-dongwon.kim@intel.com>
 <CAJ+F1CLzVDfCdy9XUGxAf1DN=ert+9JDs3Sq1HYve4Bdy7mFHw@mail.gmail.com>
 <PH8PR11MB6879524941306A7B3FB17EE2FA7C2@PH8PR11MB6879.namprd11.prod.outlook.com>
 <CAJ+F1C+4f7=GAa8gOhH+=Qv5WAQrypa=83R-+RVEAo4JjknLSw@mail.gmail.com>
 <PH8PR11MB6879AF46B1B0A31E68D146F9FA432@PH8PR11MB6879.namprd11.prod.outlook.com>
 <ZemM45aJdtzx9LH2@redhat.com>
 <PH8PR11MB6879A43FEDABBD1307861429FA202@PH8PR11MB6879.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH8PR11MB6879A43FEDABBD1307861429FA202@PH8PR11MB6879.namprd11.prod.outlook.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

On Thu, Mar 07, 2024 at 05:53:24PM +0000, Kim, Dongwon wrote:
> Hi Daniel,
> 
> > -----Original Message-----
> > From: Daniel P. Berrangé <berrange@redhat.com>
> > Sent: Thursday, March 7, 2024 1:46 AM
> > To: Kim, Dongwon <dongwon.kim@intel.com>
> > Cc: Marc-André Lureau <marcandre.lureau@gmail.com>; qemu-
> > devel@nongnu.org
> > Subject: Re: [PATCH 1/3] ui/gtk: skip drawing guest scanout when associated
> > VC is invisible
> > 
> > On Thu, Feb 01, 2024 at 06:48:58PM +0000, Kim, Dongwon wrote:
> > > Hi Marc-André,
> > >
> > > Thanks for your feedback. Yes, you are right, rendering doesn't stop
> > > on Ubuntu system as it has preview even after the window is minimized. But
> > this is not always the case.
> > > Some simple windows managers don't have this preview (thumbnail)
> > > feature and this visible flag is not toggled. And the rendering stops
> > > right away there when the window is minimized.
> > 
> > This makes me pretty uncomfortable. This is proposing changing QEMU
> > behaviour to workaround a problem whose behaviour varies based on what 3rd
> > party software QEMU is running on
> > 
> > What you say "window managers" are you referring to a traditional
> > X11 based host display only, or does the problem also exist on modern
> > Wayland host display ?
> 
> [Kim, Dongwon]  I didn't mean anything about the compositor/display
> server itself. And I am not sure about the general behavior of Wayland
> compositors but the point here is the rendering while the app is being
> iconized (minimized) is not always the case. For example, ICE-WM on
> Yocto Linux doesn't have any preview for the iconized or minimized
> applications, which means all drawing activities on the minimized
> app are paused. This is the problem in case blob scanout is used
> with virtio-gpu on the guest because the guest won't receive the
> response for the frame submission until the frame is fully rendered
> on the host. This is causing timeout and further issue on the display
> pipeline in virtio-gpu driver in the guest.

I guess I'm wondering why we should consider this a bug in QEMU
rather than a bug in either the toolkit or host rendering stack ?

Lets say there was no guest OS here, just a regular host app
issuing drawing requests that were equivalent to the workload
the guest is issuing.  If that applications' execution got
blocked because its drawing requests are not getting processed
when iconified, I'd be inclined to call it a bug.

Or are we perhaps handling drawing in the wrong way in QEMU ?

If the problem is with drawing to a iconified windows, is
there an intermediate target buffer we should be drawing
to, instead of directly to the window. There must be some
supported way to have drawing requests fully processed in
the background indepent of having a visible window, surely ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


