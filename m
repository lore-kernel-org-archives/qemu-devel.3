Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75ED8C021A6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 11:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmWJq-0004SF-SA; Mon, 24 Feb 2025 06:08:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tmWJp-0004S6-QD
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:08:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tmWJn-000869-RM
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740395289;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IcsL2QcQszB6ySRaQFeNXCM8i7cwL568A4PUnedKVOQ=;
 b=UsvwfBOyUtR+k0jGT07UD1JmtmGHRVtvLialWEDSLaMQ8aRXX1fEfnqdAAzptXJHmk610H
 d1B4hjr7vGx9NPVvU4MDYmh6c8cMC+a1IHN6+nJxUPOswpKpmH+AERypwOYao9OBWD0rxS
 fvbSawhPds1CGZXdr8NZQlOTLDMFpVY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-HiVleyE-P22bZQunfQhBhA-1; Mon,
 24 Feb 2025 06:08:05 -0500
X-MC-Unique: HiVleyE-P22bZQunfQhBhA-1
X-Mimecast-MFC-AGG-ID: HiVleyE-P22bZQunfQhBhA_1740395284
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA45C18EB2C6; Mon, 24 Feb 2025 11:08:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.119])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2D471800359; Mon, 24 Feb 2025 11:08:00 +0000 (UTC)
Date: Mon, 24 Feb 2025 11:07:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH] hw/display: add blocklist for known bad drivers
Message-ID: <Z7xTDYS7SzYyNvGo@redhat.com>
References: <20250221160101.2318357-1-alex.bennee@linaro.org>
 <Z7xFQ4bHwBEo8aQw@redhat.com> <87eczn8vcj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eczn8vcj.fsf@draig.linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Feb 24, 2025 at 10:56:12AM +0000, Alex Bennée wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Fri, Feb 21, 2025 at 04:01:01PM +0000, Alex Bennée wrote:
> >> While running the new GPU tests it was noted that the proprietary
> >> nVidia driver barfed when run under the sanitiser:
> >> 
> >>   2025-02-20 11:13:08,226: [11:13:07.782] Output 'headless' attempts
> >>   EOTF mode SDR and colorimetry mode default.
> >>   2025-02-20 11:13:08,227: [11:13:07.784] Output 'headless' using color
> >>   profile: stock sRGB color profile
> >> 
> >>   and that's the last thing it outputs.
> >> 
> >>   The sanitizer reports that when the framework sends the SIGTERM
> >>   because of the timeout we get a write to a NULL pointer (but
> >>   interesting not this time in an atexit callback):
> >> 
> >>   UndefinedBehaviorSanitizer:DEADLYSIGNAL
> >>   ==471863==ERROR: UndefinedBehaviorSanitizer: SEGV on unknown address
> >>   0x000000000000 (pc 0x7a18ceaafe80 bp 0x000000000000 sp 0x7ffe8e3ff6d0
> >>   T471863)
> >>   ==471863==The signal is caused by a WRITE memory access.
> >>   ==471863==Hint: address points to the zero page.
> >>       #0 0x7a18ceaafe80
> >>   (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x16afe80)
> >>   (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
> >>       #1 0x7a18ce9e72c0
> >>   (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15e72c0)
> >>   (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
> >>       #2 0x7a18ce9f11bb
> >>   (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15f11bb)
> >>   (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
> >>       #3 0x7a18ce6dc9d1
> >>   (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x12dc9d1)
> >>   (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
> >>       #4 0x7a18e7d15326 in vrend_renderer_create_fence
> >>   /usr/src/virglrenderer-1.0.0-1ubuntu2/obj-x86_64-linux-gnu/../src/vrend_renderer.c:10883:26
> >>       #5 0x55bfb6621871 in virtio_gpu_virgl_process_cmd
> >> 
> >> The #dri-devel channel confirmed:
> >> 
> >>   <digetx> stsquad: nv driver is known to not work with venus, don't use
> >>       it for testing
> >> 
> >> So lets implement a blocklist to stop users starting a known bad
> >> setup.
> >
> > I don't much like the conceptual idea of blocking usage of QEMU itself
> > based on current point-in-time bugs in the host OS driver stack, because
> > it is making an assertion that all future versions of the driver will
> > also be broken and that's not generally valid.
> >
> > If the user chose to use a dodgy graphics driver, they can deal with
> > the consequences of their choice.
> >
> > Skipping only the functional test, without any qemu-system code changes
> > though is more palettable as that's not a hard block on usage.
> 
> Well how do you do one without the other? I don't want to always skip the
> vulkan testing because some developer setups have broken drivers. Unless
> you are suggesting something like:
> 
>   -device virtio-vga-gl,hostmem=4G,blob=on,venus=on,ignore-nvidia=on
> 
> or something like that?

I was thinking that test_aarch64_virt_gpu.py would dynamically check
the kernel driver and use that in its @skip annotation.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


