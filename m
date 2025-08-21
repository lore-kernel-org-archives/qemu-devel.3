Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C46CCA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up5c7-00014D-P7; Thu, 21 Aug 2025 09:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1up5c5-00013o-A7
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 09:45:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1up5c3-00017X-3s
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 09:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755783951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LNX8DFuQfc4fgSWU7U10ikxsemDb3m7zjOCAua2xYvY=;
 b=Oer1R9dK2Ol/Ff17cIjBAcNTHtfyxtOeCsv8tQWEKbr/iqNe+rcxrOVRgW22h7C0DqN2In
 CfU7H5KFFoiDi6i2Fbmy5n/mKOWY9iPqQZ4WqWFSvJKYxf5qBGXUUIvepcxbbm29kpoxLj
 idE0pQ3r5IeiJooEpX6QQqS7mUnnsM0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-Bqfy5v1vOmey2KzxeentBQ-1; Thu, 21 Aug 2025 09:45:50 -0400
X-MC-Unique: Bqfy5v1vOmey2KzxeentBQ-1
X-Mimecast-MFC-AGG-ID: Bqfy5v1vOmey2KzxeentBQ_1755783950
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7e8704e0264so271194685a.1
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 06:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755783950; x=1756388750;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LNX8DFuQfc4fgSWU7U10ikxsemDb3m7zjOCAua2xYvY=;
 b=PSudF4XVC4kUAnVH19sFIKj3n+SIGyIzLYxSOPYsVembONLmcBA8vT1dLelMPqyaaI
 X/pmf+7cwDzvD81JRLPO2lv2l5nOb6J1RSiOwYaCKXZdlA2tCRAQSLmjSZxG1SfblADe
 lJF5pjOI3pVxKyprCoawX3OYnb6+8XdXcngnYqfcBF5u9Ed5F5qGFnGV3zT0hvxgXnvw
 5wHiFdbNS/+JRErb8rjDfw3Z4ZWNtEElf7+g5EG8gcZBmFobeSIdnk7UrleYCXnwl73R
 ka3s/Y1JoApswtlO9sJpkAR/8wF+IIZ/c6fWwFJFDna+NUt5CL3DUEgfHVz5c4SRGMJB
 FQLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcQ2Iy0uOJRgw07GTxe/N8mhHrVqOWaMB4imfozM84TdZHhr5tQ0sAGpomqR+4jewTsXLUKrWBQf2l@nongnu.org
X-Gm-Message-State: AOJu0Yx9kZY3xDJ1ja7eMY/nrHVRsJZEmGkATy5/H5ieeiQkJmLMl/Lo
 oc+BU2uUyzzQ0c+oKLBwxggRxB3Obdp6eqkIGlT6ekYwVGPhlpoGZ/N4JdDfQ+KhPEi7HmX8qHO
 FO6HscZpZgnr5Fh4DyaAEk0mCZbsHTV1lfInwGsNyYP9TzB4clg0ywAmH
X-Gm-Gg: ASbGncuvAsrReEN2VbJb0I3xV8GvSKvYaDlV0ac9wKtjVVDtsnjtF/GK3uYaCkzLuhp
 YMij+wmeTnf0b/PQibL5Ky5ud9dxXTUr0PCV690X4ucx5acOd9OyaModXfBY3H778lkcj6haMJ4
 +cJTHqhFzHztwLmQfHX2CvMzf0GsScC0Uqcqk3av4QnJgDrTdKXjmx1couPhH8SHkh+2BPH9tu8
 tJCI4+DHUf/nOwcWlzGXl9xtmVRdjQ+5cRhite23JwwAZUvG1L2uopUSGzUgGe4KN+sYuaOhQlu
 0+M+xUnszKVdzxqw0tCynXdWZ5NkDbpx
X-Received: by 2002:a05:620a:44c4:b0:7e8:3f25:d8e2 with SMTP id
 af79cd13be357-7ea08e63506mr210602785a.62.1755783949637; 
 Thu, 21 Aug 2025 06:45:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk6UfWDBG/PLfa4I+xpxi/RUVyV6N0cvhDsZFGxT1LOnKT+MH1Yn9QS/7RILZjRjKWmteLPA==
X-Received: by 2002:a05:620a:44c4:b0:7e8:3f25:d8e2 with SMTP id
 af79cd13be357-7ea08e63506mr210597785a.62.1755783949095; 
 Thu, 21 Aug 2025 06:45:49 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e87e07381dsm1145605085a.29.2025.08.21.06.45.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 06:45:48 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:45:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 mst@redhat.com, farosas@suse.de, raphael@enfabrica.net,
 sgarzare@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru
Subject: Re: [PATCH 26/33] io/channel-socket: introduce
 qio_channel_socket_keep_nonblock()
Message-ID: <aKcjAIVheXDJpWgV@x1.local>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-27-vsementsov@yandex-team.ru>
 <aKXNLfKWzHKUhGaz@x1.local> <aKXRGiDQlyPyhNsh@redhat.com>
 <e3c67e47-8a5e-459f-8d76-a00032b7e013@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3c67e47-8a5e-459f-8d76-a00032b7e013@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Aug 21, 2025 at 03:07:57PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> What I dislike in the way, when we reset to blocking always, and set
> non-blocking again where needed:
> 
> 1. Extra fcntl calls for nothing (I think actually, in most cases, for
> fds passed through migration stream(s) we'll want to keep fd as is)
>
> 2. When we reset to blocking on target, it's visible on source and may
> break things.
>
> In these series it's probably doesn't really matter, as at the time when
> we get the descriptor on target, it should not be used anymore on source.
>
> But for example, in CPR-transfer, where descriptors are passed in the
> preliminary stage, and source is running and use the descriptors, we
> shouldn't change the non-blocking status of fd on target. Probably,
> CPR-transfer for now only works with fds which are blpcking, so we don't
> have a problem.
>
> So, I think, that better default is preserve state of the flag for fds
> passed through migration stream. And backends may modify it if needed (I
> think, in most cases - they will not need).

I agree having that as a default iochannel behavior is questionable.

If it was defined for any fd-passing protocols making sure nonblocking
status is predictable (in this case, fds will be always blocking), IMHO it
should be done in the protocol layer either constantly setting or clearing
NONBLOCK flag before sending the fds, rather than having it silently
processed in iochannel internals.

Do we know how many existing users are relying such behavior?  I wonder if
we could still push this operation to the protocols that will need it, then
we can avoid this slightly awkward iochannel feature flag, because the
iochannel user will simply always have full control.

-- 
Peter Xu


