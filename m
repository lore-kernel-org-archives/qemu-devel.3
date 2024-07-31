Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41767C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 10:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ6ez-0003Vu-OG; Wed, 31 Jul 2024 06:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZ6ey-0003Uk-40
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 06:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZ6ev-0007Cx-T0
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 06:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722422055;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YQWIjwmJFrmFXp+UfOHsAmW4kJLnhJOkHqAGTjt1Sn4=;
 b=TfVauknEdmsV4EByHpdB8Hr+SbEyFevBAF14XxUDux/3wPhbVcTVSJWFTe3qSrZPOBCrwv
 97F51DTn1zxD4KhgVXX/HUdZwfudUqqxpMzgQeQzL/BxhTA4cNtpnoN0XImoCz/vMCURGN
 A38H4vb63ifxebAoV7Eb9aJtsPsxH/g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-YMV5Pxg9NqGJsEDJReNTqQ-1; Wed,
 31 Jul 2024 06:34:11 -0400
X-MC-Unique: YMV5Pxg9NqGJsEDJReNTqQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F03DC1955D42; Wed, 31 Jul 2024 10:34:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.33])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 710BB19560B2; Wed, 31 Jul 2024 10:34:07 +0000 (UTC)
Date: Wed, 31 Jul 2024 11:34:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Itaru Kitayama <itaru.kitayama@linux.dev>, qemu-devel@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: QEMU unexpectedly closed the monitor
Message-ID: <ZqoTG0eYwNLAJu3D@redhat.com>
References: <8AFDCC22-C476-45EF-9119-2E3C9A2A91C3@linux.dev>
 <87le1jc8qi.fsf@draig.linaro.org>
 <7F67EEEA-D222-4348-83EF-5C81C94C79D0@linux.dev>
 <87h6c5dh31.fsf@draig.linaro.org>
 <CAFEAcA_y1y+5aqDXDUmAzRJo2Kf9o+JwbH-6MB62UEZD=LQZ-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_y1y+5aqDXDUmAzRJo2Kf9o+JwbH-6MB62UEZD=LQZ-w@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Wed, Jul 31, 2024 at 11:29:01AM +0100, Peter Maydell wrote:
> On Wed, 31 Jul 2024 at 10:52, Alex Bennée <alex.bennee@linaro.org> wrote:
> > You then need to manually strip out all the various chardevs for libvirt
> > control sockets and you can an equivalent command line you can run from
> > the console. One thing that did jump out as a bit weird to me was:
> >
> >  -rtc base=utc -no-shutdown -no-acpi -boot strict=on \
> >  -kernel /home/realm/Image-v6.10 \
> >  -initrd /home/realm/rootfs.cpio \
> >  -append 'earlycon console=ttyAMA0 rdinit=/sbin/init rw root=/dev/vda acpi=on'
> 
> Also worth checking here I guess is whether virt-install
> is running QEMU as a user which doesn't have access to
> the /home/realm/Image-v6.10 etc files -- are they world
> readable?

Most likely it is the directory permissions which are the problem since
$HOME is typically set to deny access from other users, which would include
the user QEMU runs as.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


