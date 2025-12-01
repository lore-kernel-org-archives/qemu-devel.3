Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3D9D116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 19:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ9pZ-0000fa-3l; Mon, 01 Dec 2025 14:45:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vQ9pV-0000f6-L3
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 14:45:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vQ9pT-00054X-NY
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 14:45:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764618296;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=769chCCXjX1Rlh/91X7Jq6ZVZjPBGeAlHQo7YYerjxc=;
 b=cXNQXFbCdJYeAG6E2WIsWW1cK9kAA+eBuMgdGgw0WJnqXFkID1GtDGt0yWk/MDj7EEeexY
 L6y+RXL392B7qx4d5Js/YaBukdQvf/zf0gMyaZU7SFlM0aU0tI9H+KOLmLl0hd8Doki1H8
 iBzahHGMgzW9G8doKIUYjXajV2d7ZCU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-EyJfE-dONli8_e0q42qUFw-1; Mon,
 01 Dec 2025 14:44:53 -0500
X-MC-Unique: EyJfE-dONli8_e0q42qUFw-1
X-Mimecast-MFC-AGG-ID: EyJfE-dONli8_e0q42qUFw_1764618291
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15CBC180049F; Mon,  1 Dec 2025 19:44:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.139])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89F9F180047F; Mon,  1 Dec 2025 19:44:45 +0000 (UTC)
Date: Mon, 1 Dec 2025 19:44:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>,
 geoff@hostfission.com
Subject: Re: [RFC 00/24] audio: add GStreamer backend
Message-ID: <aS3wKkxxrekvIWuc@redhat.com>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
 <e6ada475-da8a-4643-4986-2ffc1d5b9c66@eik.bme.hu>
 <CAMxuvayr-qyjzsexWL1wt72mJA_-Dew9JAofjELhSVYC_w8SvA@mail.gmail.com>
 <fdd7e1c4-a2a5-4039-59a9-9afda763feea@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fdd7e1c4-a2a5-4039-59a9-9afda763feea@eik.bme.hu>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 01, 2025 at 08:30:26PM +0100, BALATON Zoltan wrote:
> On Mon, 1 Dec 2025, Marc-André Lureau wrote:
> > On Mon, Dec 1, 2025 at 5:03 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
> > > On Mon, 1 Dec 2025, marcandre.lureau@redhat.com wrote:
> > > > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > > 
> > > > Hi,
> > > > 
> > > > The following patch series provides a GStreamer-based audio backend,
> > > which could
> > > > ultimately allow QEMU to leverage the framework to support the various
> > > audio
> > > > subsystems and simplify the audio handling logic (timing, resampling,
> > > mixing
> > > > etc), as well as allow greater pipeline flexibility and customization.
> > > 
> > > While it's good to have a GStreamer backend to integrate well into systems
> > > already using that, this should not replace existing audio backends in
> > > QEMU. The reason is that GStreamer has extensive dependencies that I would
> > > 
> > 
> > GStreamer itself is not so big and doesn't have that many dependencies that
> > qemu doesn't already have.
> 
> Except that this proposal uses GStreamer from rust so would also pull in all
> the rust dependencies too which is still not needed for QEMU. Saying that
> it's optional but then you lose audio output is also not quite acceptable.

In terms of replacing the existing audio backends, it would simply have to
wait until we declare Rust to be a mandatory dependency of QEMU, before
proposing any removal of existing backends.

> > > as another audio backend but not as a replacement for QEMU's audio
> > > handling logic and backends.
> > 
> > It would be great if people with very specific or constrained requirements
> > on qemu audio could check if the GStreamer backend fits their need.
> 
> At least one of them already said it wouldn't. Also why somebody not running
> a desktop environment that uses GStreamer would want to add that dependency
> and use a GStreamer plugin to get the sound back to their native sound
> service when it is probably already supported by QEMU directly? QEMU also
> has to support Windows and macOS sound services so having a few more
> Linux/Unix ones does not make it much more complex.

GStreamer is not merely for desktop environments. It is a general purpose
audio system, and in terms of QEMU, it is already used by the Spice server
for video encoding purposes.  IMHO it is reasonable to consider whether
QEMU could use GStreamer for all audio output regardless of whether it is
running from a desktop session or not.

Personally my main concern with gstreamer is that when things go wrong
it can be very difficult to understand why and thus hard to figure out
how to fix it, unless you're pretty experienced with gstreamer.

If we do consider rationalizing how many backends we have, IMHO, it
would be desirable to retain at least one other QEMU audio backend
that is considered simple & reliable (fool proof) to use & debug.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


