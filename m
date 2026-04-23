Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E68CFC0342
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFvwL-0007rf-8u; Thu, 23 Apr 2026 11:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFvvv-0007pr-R3
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:25:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFvvs-0008IL-72
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776957934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gvefTJu7dGp8xIrMloC+CQc+wFQkZXv7PVTkOxSx0DQ=;
 b=ZvRh/V8LOP9pX0g0j3yj28NFf7EccD3IfOWQgBftaMX9eWk80R1YvpU+Qxqj214FpQ2uuA
 DJwrswzuZQMwZZ1sPUqRxokgeeE2uYr896rcmztAKD/Ye/JQbaIjnw4/79IDnj55lL6t5i
 Pdxpu8R5Vmk8iakmik3dmz+9+gqpMe0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-ZP09SJO3MGGGYMtNhC_7_g-1; Thu, 23 Apr 2026 11:25:32 -0400
X-MC-Unique: ZP09SJO3MGGGYMtNhC_7_g-1
X-Mimecast-MFC-AGG-ID: ZP09SJO3MGGGYMtNhC_7_g_1776957932
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8abd6e281c0so187196356d6.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 08:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776957932; x=1777562732; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gvefTJu7dGp8xIrMloC+CQc+wFQkZXv7PVTkOxSx0DQ=;
 b=AeXNT/O1HY76idFtCHNQ13meku/302bvQyE9YQJur6c4DIGrrSbS8qGfhyjV3WZ/jd
 QmNA2b7sqA0K/3YMXzXqbv9pgus4i92TXAOQHR6M7VPDN5OrS7aDsxbMIEwnScSRFdew
 g9tvwTZpQeu0AC+hApApxrxhtmw3Sfboq3zwPudnQkUKc4rKEFGZRTwgSFExixINrset
 rUmbFA0BK38qQI4yrcW7z4D7MAOlWvUmlzY9d+pg/anMsb2nuSYXVcEvLLGRmUmqoIOT
 zQcUKm2HrLnG5REAaopC1CbnMOsc8+KkdHWe5ARSnaCxh9EIX0Qt0FEuktk3kF6zilTU
 cm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776957932; x=1777562732;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gvefTJu7dGp8xIrMloC+CQc+wFQkZXv7PVTkOxSx0DQ=;
 b=LA2/A+uAmJbiqan7/2/d5i+OBb/SrELAiiIdUmDw/sF2bmKCI9L0YFkAeuhVsofTyf
 K7N809C6TgEHmxWwQDtygecbF2GetLD0wuw+GJZGlOHVXkkAIdBsZxgcg5iVE56Vn/TT
 jFxolin/8lOOblXFRGBsJc0F8Csv1gZ5rzS9oDSMrjbr2qnmz9nNOgypD4rFM220Am1I
 UTpx4Nbn45NC0lnf8+azb4gVP0XPcFV58PDnF8//AQ70al7hZNG1u8pdomryknz3Pu8h
 w5NhrNh/jv5Siii3qOSAwSsN8srXuQPhq5GhAoGL1JDEbAbKMa8aFv4M5nOTtCIF/ueZ
 3S9g==
X-Gm-Message-State: AOJu0Yx3FAe6vBNMBBc17xP1bdmrtUGcO6mgDFlK90UMbMdsKIGncWTD
 PXDK3W5iRNg2+eqNmciP5e7yTEe2S3jbDUkeTrFc5eHEyTxGraud+lrN8/Ql+NF7N4AQ0zfWTq3
 QIlWYUXICqMBdIJhrbaSPj2d+cS5bKxKDRIkpYNQyiDsNP3MsK6QNc6zs
X-Gm-Gg: AeBDiesQheRGqASELgr4pXsEPSmpXj9/ynFJ6LqrziZGZJSvjaKClx1c/GCgHjIVX7j
 sYnlC9tymAMCATVisPIMIulXAvNsy+CcjZ+k+qJpGCwxwCI5lZD9t4W3j503r3/wqrqi6RhTwu8
 iIKwTsATDAB7+aEbmwmlnIJRXSgSVvCHKYxmImgErdTC2Wg5xe983WhVNHhPd4o6Rv9u1IOmAhX
 j88hDXmk0eLSr/6JNsQXuSoyRmbOEMUY03fnRFuFdrqTOxWCHlpQ5x5DHNGdijWed6T+giVr4Ku
 exnEgF9nmXSfja6iMHAVx40En8CLmLjtrhPsWita3nNUKpY/WzpTXAe3l9yHg45sIWNcj1biLm5
 n7S4VGZ0k3BhxINA0q/lmMrv+PiOTZxO/AkSoqsazjBCYc1gT/z1khmg6OQ==
X-Received: by 2002:ac8:5fd1:0:b0:50d:6b06:a453 with SMTP id
 d75a77b69052e-50e36a3f60bmr421425951cf.18.1776957931753; 
 Thu, 23 Apr 2026 08:25:31 -0700 (PDT)
X-Received: by 2002:ac8:5fd1:0:b0:50d:6b06:a453 with SMTP id
 d75a77b69052e-50e36a3f60bmr421425131cf.18.1776957930984; 
 Thu, 23 Apr 2026 08:25:30 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50fc42c7fabsm41308371cf.9.2026.04.23.08.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 08:25:30 -0700 (PDT)
Date: Thu, 23 Apr 2026 11:25:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Prasad Pandit <ppandit@redhat.com>,
 Ben Chaney <bchaney@akamai.com>, Juraj Marcin <jmarcin@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, Pranav Tyagi <prtyagi@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH] migration: Fix crash on second migration when cancel early
Message-ID: <aeo56NITJuRd1FN5@x1.local>
References: <20260421175820.302795-1-peterx@redhat.com>
 <87wlxzdsv9.fsf@suse.de> <aejqGMhhrfQENE1X@x1.local>
 <87qzo6ek7d.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87qzo6ek7d.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 22, 2026 at 06:52:54PM -0300, Fabiano Rosas wrote:
> > We're on the same page at least on that the gsources are not yet managed.
> > But I am not sure they're leaked.
> >
> > exec_connect_incoming() does qio_channel_add_watch_full(), within itself it
> > will release the refcount of the IO watch gsource.  It means it'll be a
> > dangling gsource on the main context.  So after the spawn of the new
> > process, it will still be finalized properly?
> >
> 
> When the migration_with_exec functional test fails [0], the test issues
> qmp-quit to both src and dst. The dst will exit before ever having
> dispatched the gsource and exec_accept_incoming_migration() is not
> executed at all. In that case the gsource and the ioc are never freed
> and the spawned process is left behind.
> 
> This oneliner triggers it for me:
> 
> for i in $(seq 1 1000); do \
> echo "$i ============="; \
> make -j$(nproc) check-func-quick || break; done; ps aux | grep socat
> 
> [0] - due to the startup race as the AI overlords told us. Patch coming
> soon!

Ohhhh, so it's about some failure path, ok.

> 
> >> watches like this:
> >> 
> >>   static inline void migration_watch_data(void) {};
> >>   
> >>   qio_channel_add_watch_full(ioc, G_IO_IN, exec_accept_incoming_migration,
> >>                              migration_watch_data, NULL,
> >>                              g_main_context_get_thread_default());
> >> 
> >> and at migrate_cancel():
> >> 
> >>   while(g_source_remove_by_user_data(migration_watch_data));
> >> 
> >> It feels to me that a wrapper around this, or even a hashtable of "func
> >> ptr->GSource" or "str->GSource id" would allow us to call a (say)
> >> qio_channel_clear_watches() and avoid having to do the management in
> >> each of the clients.
> >
> > In general, this whole idea sounds reasonable.  I just want to check with
> > you on which side of QEMU we're talking about.
> >
> > To me, dest QEMU is less of a concern when it can easily be killed.  But
> > still it's good to be able to manage those.  Src QEMU is more important
> > from that perspective.
> >
> 
> It applies to both src and dst. Whenever we have to add a watch. The
> non-uniformity of having the source removed maybe after it dispatches if
> we return G_SOURCE_REMOVE or maybe it doesn't dispatch and then it needs
> to be explicitly removed is error prone I think.
> 
> Looking at callers of qio_channel_add_watch[_full], all of them just
> store the gsource "tag" and later remove it. Having the callers each
> implement their own way of keeping track of the GSource pointer/id just
> to be able to free them later on seems unnecessary to me.

Yes, and we also need to keep in mind that the ID can be reused by glib
context right after removal of the gsource from the context, afaik.

Example I randomly picked: qio_channel_websock_handshake_io(), it remembers
the ID into hs_io_tag but it also needs to be very careful in its callback
function so that whenever qio_channel_websock_handshake_send() would return
FALSE (which should really be G_SOURCE_REMOVE..) it must reset hs_io_tag.

> 
> The caller could still decide when to destroy the source, but it could
> have semantics more like: "I'm done with all the sources".
> 
> Or just make it part of the iochannel finalize routine. A small list of
> source ids per channel seems reasonable.

Sounds good in general.

But one thing to mention is, IIUC even with this it won't fix the problem
you hit above with leftover spawned process and IOC.. because IOC's
finalize() won't get called..

-- 
Peter Xu


