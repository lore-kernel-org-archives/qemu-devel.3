Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9007F43848
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 16:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD2sa-0007eu-1N; Wed, 15 Apr 2026 12:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wD2sY-0007eX-5N
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 12:14:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wD2sW-00021n-GJ
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 12:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776269651;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UUzXZ4ROjwVKYNuE9jrRqZorw/cY4qO7yPodx/nnrvU=;
 b=LTJGkXsqVJaEEbcMMj4ZwHGRDX3H0pywWF01hnmB8xfBqSfTTRxTzbG9FgFhSCnzwFMDef
 nhNCV8wUx5bwfGfi0+LSj3Tv/2JA35ocNR6YTzBrFPjoUukgEP81p4AgBlFwM+fbUGNFVu
 qP22NBFmTCj3XBaLFVzqYDbkfbPVhWg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-yO3xjjhfPF-frzDggIELtw-1; Wed,
 15 Apr 2026 12:14:08 -0400
X-MC-Unique: yO3xjjhfPF-frzDggIELtw-1
X-Mimecast-MFC-AGG-ID: yO3xjjhfPF-frzDggIELtw_1776269645
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E97DA1955DB2; Wed, 15 Apr 2026 16:14:04 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFB511800446; Wed, 15 Apr 2026 16:14:03 +0000 (UTC)
Date: Wed, 15 Apr 2026 17:14:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 48/67] ui/vnc: merge vnc_display_init() and
 vnc_display_open()
Message-ID: <ad-5SFF4anOYvA1P@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
 <20260410-qemu-vnc-v2-48-231416f76dc3@redhat.com>
 <4dabec5f-1700-41a4-a36c-526b9f096460@linaro.org>
 <CAMxuvaw9YOsJihsQDpLjhM3ohk+h_JoeHT-6S7KvPuwNCReHSg@mail.gmail.com>
 <fae0a954-fd89-49f7-848d-74f352036176@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fae0a954-fd89-49f7-848d-74f352036176@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sun, Apr 12, 2026 at 10:57:51PM +0200, Philippe Mathieu-Daudé wrote:
> On 12/4/26 16:17, Marc-André Lureau wrote:
> > Hi
> > 
> > On Sun, Apr 12, 2026 at 2:31 AM Philippe Mathieu-Daudé
> > <philmd@linaro.org> wrote:
> > > 
> > > On 10/4/26 21:19, Marc-André Lureau wrote:
> > > > Combine the two-step vnc_display_init()/vnc_display_open() sequence
> > > > into a single vnc_display_new() function that returns VncDisplay*.
> > > > This simplifies the API by making vnc_display_open() an
> > > > internal detail and will allow further code simplification.
> > > > 
> > > > vnc_display_new() is moved to vnc.h, since it returns VncDisplay* now.
> > > > Add vnc_display_free() for consistency, and it will be later used.
> > > > 
> > > > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > > ---
> > > >    include/ui/console.h |  2 --
> > > >    ui/vnc.h             |  3 +++
> > > >    ui/vnc.c             | 75 ++++++++++++++++++++++------------------------------
> > > >    3 files changed, 35 insertions(+), 45 deletions(-)
> > > 
> > > 
> > > > -bool vnc_display_init(const char *id, Error **errp)
> > > > +VncDisplay *vnc_display_new(const char *id, Error **errp)
> > > >    {
> > > >        VncDisplay *vd;
> > > > 
> > > >        if (vnc_display_find(id) != NULL) {
> > > > -        return true;
> > > > +        return NULL;
> > > 
> > > Can you explain why we don't return the VncDisplay found here?
> > 
> > `vnc_display_new()` is called from `vnc_init_func()`. If we have
> > duplicate IDs, the function returns NULL, which is treated as an
> > error.
> > 
> > Duplicate IDs are handled earlier by qemu_opts_create() though. So we
> > could assert() instead ?
> 
> That would make this code path clearer for sure.

Yeah, an assert(!vnc_display_find(id)) would make sense.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


