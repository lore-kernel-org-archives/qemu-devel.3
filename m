Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7BAC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 10:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxl9c-000147-50; Fri, 19 Apr 2024 06:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rxl9Z-00013o-6G
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 06:07:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rxl9X-0004f4-EP
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 06:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713521249;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=rCf4BZSIXFViVkiBvlfN9rXUp3fBOPUvia8SVVo7jHs=;
 b=i/uCWGlKsTprS3JJAcVJwjBpVbgh+lpShzAmcO98mLI5gZm506ICbizV2iuN/uOoTa6S9d
 S/wHYFhlzwAFXjNJh5lqp75imT4sqX4gXijRgEuIrLujIwNVXeQua9+hUYk/gZlOh2LWa5
 guZmztEJG6fnmTQU22FOJrwdprVX2GY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-7H1kFN7oPFm_oZykcWcu7Q-1; Fri, 19 Apr 2024 06:07:26 -0400
X-MC-Unique: 7H1kFN7oPFm_oZykcWcu7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C65FF8ABE02;
 Fri, 19 Apr 2024 10:07:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DEC2F43FAC;
 Fri, 19 Apr 2024 10:07:23 +0000 (UTC)
Date: Fri, 19 Apr 2024 11:07:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 00/26] =?utf-8?Q?Multifd_?= =?utf-8?B?8J+UgA==?=
 device state transfer support with VFIO consumer
Message-ID: <ZiJCSZvsekaO8dzO@redhat.com>
References: <cover.1713269378.git.maciej.szmigiero@oracle.com>
 <Zh-KF72Fe9oV6tfT@redhat.com>
 <c0b1dbb1-d353-4832-af90-96895b2129fc@maciej.szmigiero.name>
 <Zh_6W8u3H4FmGS49@redhat.com>
 <71ede5c8-857c-418b-9e37-b8d343ddfa06@maciej.szmigiero.name>
 <ZiD4aLSre6qubuHr@redhat.com>
 <aebcd78e-b8b6-44db-b2be-0bbd5acccf3f@maciej.szmigiero.name>
 <ZiF8aWVfW7kPuOtn@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZiF8aWVfW7kPuOtn@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 18, 2024 at 04:02:49PM -0400, Peter Xu wrote:
> On Thu, Apr 18, 2024 at 08:14:15PM +0200, Maciej S. Szmigiero wrote:
> > I think one of the reasons for these results is that mixed (RAM + device
> > state) multifd channels participate in the RAM sync process
> > (MULTIFD_FLAG_SYNC) whereas device state dedicated channels don't.
> 
> Firstly, I'm wondering whether we can have better names for these new
> hooks.  Currently (only comment on the async* stuff):
> 
>   - complete_precopy_async
>   - complete_precopy
>   - complete_precopy_async_wait
> 
> But perhaps better:
> 
>   - complete_precopy_begin
>   - complete_precopy
>   - complete_precopy_end
> 
> ?
> 
> As I don't see why the device must do something with async in such hook.
> To me it's more like you're splitting one process into multiple, then
> begin/end sounds more generic.
> 
> Then, if with that in mind, IIUC we can already split ram_save_complete()
> into >1 phases too. For example, I would be curious whether the performance
> will go back to normal if we offloading multifd_send_sync_main() into the
> complete_precopy_end(), because we really only need one shot of that, and I
> am quite surprised it already greatly affects VFIO dumping its own things.
> 
> I would even ask one step further as what Dan was asking: have you thought
> about dumping VFIO states via multifd even during iterations?  Would that
> help even more than this series (which IIUC only helps during the blackout
> phase)?

To dump during RAM iteration, the VFIO device will need to have
dirty tracking and iterate on its state, because the guest CPUs
will still be running potentially changing VFIO state. That seems
impractical in the general case.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


