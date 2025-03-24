Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD7FC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 10:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twecC-0004YE-2K; Mon, 24 Mar 2025 06:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tweby-0004XG-FN
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:00:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1twebv-0004YB-4d
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742810444;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Yu9kQL91sS/LlM4fNR7SaK6yBBOO7tEJ1QKcsxorvI=;
 b=BfPv7zwky0Dw6SGVzTgZIDZYvkwcqpc7C5WxdOwU09xrtVqBp5kX1b1hC090aj4QTbAHTj
 imwtdnvkwNFKY0yOKdhn1uZZQS8bHTZWUYNk2K7Aw4KumNKPm5hQUGaLweuNdDO32ORX9E
 UGDfK8q4Q3SP3I9Mnl1VGui2TZoxtD4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-xInaF-VRMSCEoOxSGyARdQ-1; Mon,
 24 Mar 2025 06:00:34 -0400
X-MC-Unique: xInaF-VRMSCEoOxSGyARdQ-1
X-Mimecast-MFC-AGG-ID: xInaF-VRMSCEoOxSGyARdQ_1742810433
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CDB31801A00; Mon, 24 Mar 2025 10:00:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AD2D1800268; Mon, 24 Mar 2025 10:00:26 +0000 (UTC)
Date: Mon, 24 Mar 2025 10:00:23 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: yuq825@gmail.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 6/6] ui/spice: support multi plane dmabuf scanout
Message-ID: <Z-EtNy3gXCr3kMcF@redhat.com>
References: <20250324081922.359369-1-yuq825@gmail.com>
 <20250324081922.359369-7-yuq825@gmail.com>
 <CAJ+F1C+NCda4V_1n-zL3GA_e+HabO6sbKBxWQb_S_zzPPjLNQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1C+NCda4V_1n-zL3GA_e+HabO6sbKBxWQb_S_zzPPjLNQQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Mar 24, 2025 at 01:30:16PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Mar 24, 2025 at 12:20 PM <yuq825@gmail.com> wrote:
> >
> > From: Qiang Yu <yuq825@gmail.com>

Please provide non-empty commit messages.

> >
> > Signed-off-by: Qiang Yu <yuq825@gmail.com>
> > ---
> >  meson.build        |  2 +-
> >  ui/spice-display.c | 65 +++++++++++++++++++++++-----------------------
> >  2 files changed, 34 insertions(+), 33 deletions(-)
> >
> > diff --git a/meson.build b/meson.build
> > index 9d9c11731f..b87704a83b 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -1329,7 +1329,7 @@ if get_option('spice') \
> >               .require(pixman.found(),
> >                        error_message: 'cannot enable SPICE if pixman is not available') \
> >               .allowed()
> > -  spice = dependency('spice-server', version: '>=0.14.0',
> > +  spice = dependency('spice-server', version: '>=0.14.3',
> 
> I am okay with bumping dependency requirements, but the nicer
> alternative would be to allow the current version and check the
> existence of the new API/function instead.

Bumping the min version must be a separate commit that lists
the current versions in our supported build platforms[1], in order
to demonstrate the that the chosen min version doesn't exclude
any supported platform.

See commit 34d55725e664445ccd5621165b1ef805197a530e for how
this should be done.

0.14.3 looks like it would probably be fine as a choice though,
as Ubuntu 20.04 has aged out of our support matrix.

With regards,
Daniel

[1] https://www.qemu.org/docs/master/about/build-platforms.html
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


