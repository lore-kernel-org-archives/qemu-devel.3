Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17B4CFD37C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 16:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNvhx-0005qL-GJ; Tue, 25 Nov 2025 11:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNvhp-0005kL-MK
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 11:15:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNvhl-0004ve-N1
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 11:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764087345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HI0Sh1nKmJf13ofGcya0llsGVhH3+la/wu8QoAnNlY0=;
 b=YXM3C6DcUMu3z77H+A8LsM86zaaiFKQ5wqwhmVhoDUAMs+1GX8T0L4VsxOWKbl/Rf8JS6q
 NMDVG4GlHEfOhI+yRpw9tPhiMXgEhrZXiGcO+mQwXEdnjTZOEcaFt2zn2z8oA5YSyWoulY
 wui0RyY0Pri2PmyCh+4p0KXAEkcNkuA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-baLkPeQwMAutUFlS_Os29Q-1; Tue, 25 Nov 2025 11:15:42 -0500
X-MC-Unique: baLkPeQwMAutUFlS_Os29Q-1
X-Mimecast-MFC-AGG-ID: baLkPeQwMAutUFlS_Os29Q_1764087342
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4ed7591799eso137466201cf.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 08:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764087342; x=1764692142; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HI0Sh1nKmJf13ofGcya0llsGVhH3+la/wu8QoAnNlY0=;
 b=LkvsjMB9HD8NpihEMX7iY8AQPvHqZid5GZZG+iLQQNiPIe9THIIhqPSJ/VE7j9ga9V
 Jslrtupz9TiGkVLMpHmkoqBWu9QU5PKk86/9vhs44K41sMw9bCQEnUbcPSM8k8MD6xnu
 9yShL8u9qIhyfqOggDgoqm0ZDGqKb/+EjAi8/fllSzVzF/1HBwWVwSEtskrwWs1fl58T
 g2w3KU+YvZj+h3mrK2KMx1l0+CRU4WuHxTVAbR/CMpChN/cwoHGX4KORaRzc/U3LfsGO
 GKaXCrKgjx1F9XAhwdJdiSRF1+Bm68AwTjOvbGh4oyG5vQyWzmX+uKQjXX4Lvat1A9wN
 XUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764087342; x=1764692142;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HI0Sh1nKmJf13ofGcya0llsGVhH3+la/wu8QoAnNlY0=;
 b=pu2IUbmtAK4wwuJ61EHjFyk9Viq7NanfGMoWFBfFYIOweq7w3GpdxzYHcWGWXYWGt0
 SXdwxnoiHlzd4gf8iY8ArGmuktKCG6z0rP7W94ILURgKsy5NQYLLhIkIHBG8/JpKSEgi
 hNV90IcMYDJjgPYsDyXqCQdxAR+2U19z351EvGMp2PPQ6l3k2T6vVn4MaJ39iY38idAY
 9Wk+4E4saZOiz94huMAq4HZfghkIIsAIk+2ET8hLrdGiS6pzl4ZfYKA/9guFYFxhXYbW
 mZOoVnEkLihmAY1mg43dKZM5T0oFaO1wTHRvy1dnnXRxcAM5HOR5Qb+cfymzVArxhr0/
 ZW8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZjunvot8e8FwOuF1lNjorkZtSDjkXUJfUSwvk5Wwv0U2NcWvAy3mFWIUgDfa2ZXymvP5GQlgP63IG@nongnu.org
X-Gm-Message-State: AOJu0YwPKcIgma7lzXaC7maGSpmeA4cKfZk/CH1Q2Q5Zl9EAirWhcqXt
 HfulZnRMNWSJO1WOCkPcnHL2i3PUtAzMS9Thp70WlSMNoiLe/Hil075x6SS6W/HhI0v9ISc8H/J
 qDB5BORB39iUoXmX3oPeOKHbpKYBesCZI4/4X6l7rW6RjHgmioa/Ru2nX
X-Gm-Gg: ASbGncs1NE/x7QWsQ2nKxF9zz5rqpQwqdsowo3kf3mBo7y5JZOFFDcs6MHkRrRkQqys
 rmTvKbrqPycrUzGTHkFGjoNJkB1IRpicLlRqigQ11TJbmwg1iysaJL4cv4bFLF7kYFJYlpkSDek
 W4lpy6cgnyktCTCBspD0kbR+YDZxHiblukUtKsyq2aevcbzkeBUU8mHKExSp15INFGesH4kg+e0
 AE4qFAMjT4IFHDDMR4xqEF+tk1bI7Gx7GdFfWMR+dflde9Gy4sSMGdSsfKC2YWbRT7CCBPQhf1C
 RpvBh11xfqWA5VYvUWoqDYINBikpaLFH8Ik9ryuge5OVPU61z8wshFGrjHvBV1j0
X-Received: by 2002:a05:622a:50:b0:4ee:2a31:6795 with SMTP id
 d75a77b69052e-4ee5883f9a9mr236313271cf.12.1764087341410; 
 Tue, 25 Nov 2025 08:15:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF15aZGlvoT+7lmnZg1qcS30NcleLngXiJvk3/yDQGfgc6SOZAAVCROZnhckj4DsCNerhcW+g==
X-Received: by 2002:a05:622a:50:b0:4ee:2a31:6795 with SMTP id
 d75a77b69052e-4ee5883f9a9mr236309801cf.12.1764087339437; 
 Tue, 25 Nov 2025 08:15:39 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee48d3a465sm110227231cf.4.2025.11.25.08.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 08:15:39 -0800 (PST)
Date: Tue, 25 Nov 2025 11:15:37 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, farosas@suse.de, peter.maydell@linaro.org
Subject: Re: g_autoptr(Error)
Message-ID: <aSXWKcjoIBK4LW59@x1.local>
References: <20251125070554.2256181-1-armbru@redhat.com>
 <871plmk1bc.fsf@pond.sub.org> <aSWSLMi6ZhTCS_p2@redhat.com>
 <87jyzexrly.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jyzexrly.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Nov 25, 2025 at 12:46:01PM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Nov 25, 2025 at 08:40:07AM +0100, Markus Armbruster wrote:
> >> g_autoptr(T) is quite useful when the object's extent matches the
> >> function's.
> >> 
> >> This isn't the case for an Error object the function propagates to its
> >> caller.  It is the case for an Error object the function reports or
> >> handles itself.  However, the functions to report Error also free it.

I'd confess I didn't pay enough attention on how the error API was designed
deliberately to always free the Error objects before almost whenever
possible.  But I see now, thanks for the write up.

> >> 
> >> Thus, g_autoptr(Error) is rarely applicable.  We have just three
> >> instances out of >1100 local Error variables, all in migration code.
> >> 
> >> Two want to move the error to the MigrationState for later handling /
> >> reporting.  Since migrate_set_error() doesn't move, but stores a copy,
> >> the original needs to be freed, and g_autoptr() is correct there.  We
> >> have 17 more that instead manually free with error_free() or
> >> error_report_err() right after migrate_set_error().
> >> 
> >> We recently discussed storing a copy vs. move the original:
> >> 
> >>     From: Peter Xu <peterx@redhat.com>
> >>     Subject: Re: [PATCH 0/3] migration: Error fixes and improvements
> >>     Date: Mon, 17 Nov 2025 11:03:37 -0500
> >>     Message-ID: <aRtHWbWcTh3OF2wY@x1.local>
> >> 
> >> The two g_autoptr() gave me pause when I investigated this topic, simply
> >> because they deviate from the common pattern migrate_set_error(s, err)
> >> followed by error_free() or error_report_err().
> >> 
> >> The third one became wrong when I cleaned up the reporting (missed in
> >> the cleanup patch, fixed in the patch I'm replying to).  I suspect my
> >> mistake escaped review for the same reason I made it: g_autoptr(Error)
> >> is unusual and not visible in the patch hunk.
> >> 
> >> Would you like me to replace the two correct uses of g_autoptr(Error) by
> >> more common usage?

Works for me.

Now I also think it should be good migrate_set_error() follow QEMU's Error
API design if we decide to stick with it freeing errors in such APIs.

Said that, I wonder if you think we could still consider passing Error**
into migrate_set_error(), though, which will be a merged solution of
current Error API and what Marc-Andre proposed on resetting pointers to
avoid any possible UAF, which I would still slightly prefer personally.

If we rework migrate_set_error() to take ownership first, then we can
naturally drop the two use cases, and remove the cleanup function.

Markus, please also let me know if you want me to do it.

> >
> > I had previously proposed g_autoptr(Error) a year or two back and you
> > rejected it then, so I'm surprised to see that it got into the code,
> > because it requires explicit opt-in via a G_DEFINE_AUTOPTR_CLEANUP_FUNC.
> >
> > Unfortunately it appears exactly that was added earlier this year in
> >
> >   commit 18eb55546a54e443d94a4c49286348176ad4b00a
> >   Author: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> >   Date:   Tue Mar 4 23:03:35 2025 +0100
> >
> >     error: define g_autoptr() cleanup function for the Error type
> >     
> >     Automatic memory management helps avoid memory safety issues.
> >     
> >     Reviewed-by: Peter Xu <peterx@redhat.com>
> >     Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> >     Link: https://lore.kernel.org/qemu-devel/a5843c5fa64d7e5239a4316092ec0ef0d10c2320.1741124640.git.maciej.szmigiero@oracle.com
> >     Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
> I missed it.  Not he submitter's fault; it was cc'ed to me.

If someone to blame, it's the reviewer.

Thanks!

-- 
Peter Xu


