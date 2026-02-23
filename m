Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4CDEC1116
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vua2x-000063-Sv; Mon, 23 Feb 2026 12:48:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vua2v-00005m-7L
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:48:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vua2s-0001cd-AV
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771868912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bpPxgojvGFzCV79Vc5qWekIiK5d1L9J7xZt9PnBLwZY=;
 b=BFx8N0pgUeMBxwbkD6L+Nt3E3PQ8G1S6iSTdppXLow2umFbPN4vaL75fDMrxVoO11M+VTI
 MgCZ3UVSyPQ7EY1X/9tyiAmPoOzwBu7elgjp/XDEpt6nYqql1DjXYkf8CZSdWSGHd1ltvu
 l8ftwp+B8o9on0AZOs+8el6jDla7Dr0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-B6scGfNGMXOEF4MhVcoDlQ-1; Mon, 23 Feb 2026 12:48:30 -0500
X-MC-Unique: B6scGfNGMXOEF4MhVcoDlQ-1
X-Mimecast-MFC-AGG-ID: B6scGfNGMXOEF4MhVcoDlQ_1771868910
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-506a936d7afso565466921cf.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771868910; x=1772473710; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bpPxgojvGFzCV79Vc5qWekIiK5d1L9J7xZt9PnBLwZY=;
 b=HlE2a4+zW8U+aUvWr+z8No2TG5DwAbA9QBh81lSaR0NBBvExmvJhhTd2GmY7Cx5wcl
 GyStsokFU+b44dRbBAktkSfvqOni4h3FIChw+Q6PQs1vhgzXoEsd3wxQJTbO4cV2hoMQ
 W6zJJoFop5Eg0hysFsB8LsBCm3PKkjW7ia3Xk6ffsndT21o7xypxh5qnn/EVD331y2lf
 fds3gUVWaYSgfuIkZzo+Y2DCF6quwAa1uHhb7PzcGxBzrNzI5O1gVIY2xabSMD4QK+UN
 TBwaB8QnZgcM8S5SwmB27iol+652UKPsrH6usRcwmgkmL/D9XUr8l42I2kgz7SPbJKF9
 Tg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771868910; x=1772473710;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bpPxgojvGFzCV79Vc5qWekIiK5d1L9J7xZt9PnBLwZY=;
 b=Yw9KtqmNUCfVr6EZ0vYTxC/Y9auNDIYaWf7UDIqfo4SrP0wtmJljWq3iJ8qJDXS8E1
 XjYQRKEeOa9TvJub5OLkEpEJBc6ekO66HwkHeqMUpMnJXo+iCUBuAkNxfuBLo8BmT2o+
 VrCaGJoTPkTQ3MJrpZ+oDcXjNWYhX/mRYHz3aOQVa6H6wXUxcVc3x+zaXI7ZYmh5erPQ
 bsWVIwRA9D+AvMxTnu0LXmJ875PWfHiIGjfaJt0ecrCfq93JWSymkB9iQMnHYALoUQBb
 ftjCQdco9gJ3z7cwLgE7cekUnu8mtcChlmS2VYHVq+bO7mpum6TEoxsF6bdXg+nB+VHG
 08wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUINM6WH6hTeX2qO6vMyJaM9RabhaiAUJ67k+Gs0rHaqsJplGddEzm4VpZoEKsPHsPJYSxPbUzfnpqf@nongnu.org
X-Gm-Message-State: AOJu0Yz9QXdr16wnzbUgfZS0FdSrVi4U1wTnq4IAqtxTMoNAMvaYkUOq
 L+DlAOExVa9W0Wd3F7DeV4V89IzwU2wjzbIK+gMi/0pmXsz9gPcUQZPsxFQUhuxG9MbLCY7+lEt
 ASJZWPe5crG3ijxbp3dUR+9hbqGyFYRJsnNaZ12Ye1hnm98l2vKSZGHzi
X-Gm-Gg: AZuq6aJsvq06Nf6Q5xd5DnUk8p/GwEcGEl0PPE/MobQO6VWdxrYi0MeMCRVemt2/hwa
 tbvF3VcNp3ZNP3INFfEbaEA1mF/OuVK7vir2DvrGZDYHlggIMowNnQ3WPpvl2tIk2wsF7AxAJbV
 QphxK/2UsnoD0/TAyhMMlX2k+SzSY8XGfJDino2/DXKlQGQMypzPkWocWEN/VeNCoJOlrTDdrQB
 2GGOv+WqS0NsEtzkL1UJldo1Vkyhcdeg/EKS8BEPjRyRlQmAU+DnTVlon1mkF3dBGNvxKyLf+Nx
 0Mzt2emxh83C9PQAtNzBwwQ8TwFh0WjhGnYawyJ/yP0arzh7fcdxB0T99clLKNQKWz4BhFvj4s7
 VE0QvVFIsOL4lDA==
X-Received: by 2002:a05:622a:130c:b0:506:a49a:2082 with SMTP id
 d75a77b69052e-5070bc9af90mr115619491cf.39.1771868909902; 
 Mon, 23 Feb 2026 09:48:29 -0800 (PST)
X-Received: by 2002:a05:622a:130c:b0:506:a49a:2082 with SMTP id
 d75a77b69052e-5070bc9af90mr115619141cf.39.1771868909398; 
 Mon, 23 Feb 2026 09:48:29 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5070d582c1esm73951521cf.15.2026.02.23.09.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:48:28 -0800 (PST)
Date: Mon, 23 Feb 2026 12:48:17 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, mst@redhat.com, thuth@redhat.com,
 armbru@redhat.com, eblake@redhat.com, farosas@suse.de,
 zhao1.liu@intel.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 davydov-max@yandex-team.ru, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, leiyang@redhat.com,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com
Subject: Re: [PATCH v11 3/8] qapi: add local migration parameter
Message-ID: <aZyS4UizvDq1Wnpq@x1.local>
References: <20260219115530.2019498-1-vsementsov@yandex-team.ru>
 <20260219115530.2019498-4-vsementsov@yandex-team.ru>
 <aZeEBqiocvOeutDn@x1.local>
 <b9957bbd-d673-4232-96e9-d13663033f62@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9957bbd-d673-4232-96e9-d13663033f62@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Feb 20, 2026 at 10:56:50AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 20.02.26 00:43, Peter Xu wrote:
> > On Thu, Feb 19, 2026 at 02:55:24PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > We are going to implement local-migration feature: some devices will be
> > > able to transfer open file descriptors through migration stream (which
> > > must UNIX domain socket for that purpose).  This allows to transfer the
> > > whole backend state without reconnecting and restarting the backend
> > > service. For example, virtio-net will migrate its attached TAP netdev,
> > > together with its connected file descriptors.
> > > 
> > > In this commit we introduce a migration parameter, which enables
> > > the feature for supporting devices (no one at the moment).
> > > 
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > 
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > 
> > PS: one nitpick is maybe we don't need to spell out the per-device option
> > in the doc of "local", it also doesn't need to be called "local-migration"
> > on every device if it will be presnet.. no strong feelings.
> > 
> 
> I thought about it.. But couldn't come up with a more generic phrase.
> And I think it's bad to omit the fact that the parameter doesn't
> automatically enable the feature without some flag on device side.
> 
> +#     channel.  Individual devices declare the support for local
> +#     migration by per-device local-migration option.  (Since 11.0)
> 
> Hmm. After merging at least virtio-net/TAP migration we can write:
> 
>     In general devices may have an option (like local-migration
>     for virtio-net) which in conjunction with "local" set to true
>     enables the local-migration feature for that device.
> 
> And to be prepared for it now:
> 
>     In general devices may have an option which in conjunction with
>     "local" set to true enables the local-migration feature for that
>     device.

Yep, this looks good.  The per-device option is not required IMHO, so "may
have" is accurate to me.

For example, when we introduce a completely new device, it can support
migrate_is_local() since the first day, then it doesn't need the per device
knob.

OTOH, the global "local" parameter is needed only because we want a promise
from the user that this is a local migration, instead of relying on URI
being unix sockets.  One example is in kubevirt AFAIU we use unix sockets
even for remote migrations (where the unix socket will only be used as a
proxy to route things outside of the container).  Hence "local" deduces
"unix sockets", not vice versa.

Thanks,

-- 
Peter Xu


