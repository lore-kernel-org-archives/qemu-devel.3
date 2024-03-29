Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DACCD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 19:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqI9i-0006fq-Rn; Fri, 29 Mar 2024 15:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rqI9f-0006fD-5b
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 15:44:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rqI9d-0004lL-9R
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 15:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711741483;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V11yvYk7eJymAL7pJOm/k1LWAhKluBtXgiPc5016mLE=;
 b=c++fu9KOipBvUEwuPGc/HdD/mEJlUT0wl3cp6z0+kh/kraWHVly6sRbb3wp3huoAMOXKyM
 rVQvJTWOTpkoFZRJTT1aocYfJE20kIHBm51yAuTQr7hdCnmciphAk2IeKGQXMiNQ2vcPbm
 CpcASU1MczSNvqvk1kIfhEWhnGF08tY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-tiHPQzpEPlKYd6LUZG7gvg-1; Fri,
 29 Mar 2024 15:44:39 -0400
X-MC-Unique: tiHPQzpEPlKYd6LUZG7gvg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2C041C07547;
 Fri, 29 Mar 2024 19:44:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A4D4111E3F3;
 Fri, 29 Mar 2024 19:44:28 +0000 (UTC)
Date: Fri, 29 Mar 2024 19:44:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>,
 "integration@gluster.org" <integration@gluster.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Yu Zhang <yu.zhang@ionos.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Message-ID: <ZgcaB4hYv6E70QqH@redhat.com>
References: <20240328130255.52257-1-philmd@linaro.org>
 <20240328130255.52257-3-philmd@linaro.org> <87frwatp7n.fsf@suse.de>
 <ZgWGMmUTq0jqSUvr@x1n>
 <7a510fbe-1c27-4f67-93b8-0d9cf01c1c74@fujitsu.com>
 <ef160e75-d4a4-4be0-81f3-77d8b0e76178@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef160e75-d4a4-4be0-81f3-77d8b0e76178@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Mar 29, 2024 at 11:28:54AM +0100, Philippe Mathieu-Daudé wrote:
> Hi Zhijian,
> 
> On 29/3/24 02:53, Zhijian Li (Fujitsu) wrote:
> > 
> > 
> > On 28/03/2024 23:01, Peter Xu wrote:
> > > On Thu, Mar 28, 2024 at 11:18:04AM -0300, Fabiano Rosas wrote:
> > > > Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> > > > 
> > > > > The whole RDMA subsystem was deprecated in commit e9a54265f5
> > > > > ("hw/rdma: Deprecate the pvrdma device and the rdma subsystem")
> > > > > released in v8.2.
> > > > > 
> > > > > Remove:
> > > > >    - RDMA handling from migration
> > > > >    - dependencies on libibumad, libibverbs and librdmacm
> > > > > 
> > > > > Keep the RAM_SAVE_FLAG_HOOK definition since it might appears
> > > > > in old migration streams.
> > > > > 
> > > > > Cc: Peter Xu <peterx@redhat.com>
> > > > > Cc: Li Zhijian <lizhijian@fujitsu.com>
> > > > > Acked-by: Fabiano Rosas <farosas@suse.de>
> > > > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > 
> > > > Just to be clear, because people raised the point in the last version,
> > > > the first link in the deprecation commit links to a thread comprising
> > > > entirely of rdma migration patches. I don't see any ambiguity on whether
> > > > the deprecation was intended to include migration. There's even an ack
> > > > from Juan.
> > > 
> > > Yes I remember that's the plan.
> > > 
> > > > 
> > > > So on the basis of not reverting the previous maintainer's decision, my
> > > > Ack stands here.
> > > > 
> > > > We also had pretty obvious bugs ([1], [2]) in the past that would have
> > > > been caught if we had any kind of testing for the feature, so I can't
> > > > even say this thing works currently.
> > > > 
> > > > @Peter Xu, @Li Zhijian, what are your thoughts on this?
> > > 
> > > Generally I definitely agree with such a removal sooner or later, as that's
> > > how deprecation works, and even after Juan's left I'm not aware of any
> > > other new RDMA users.  Personally, I'd slightly prefer postponing it one
> > > more release which might help a bit of our downstream maintenance, however
> > > I assume that's not a blocker either, as I think we can also manage it.
> > > 
> > > IMHO it's more important to know whether there are still users and whether
> > > they would still like to see it around. That's also one thing I notice that
> > > e9a54265f533f didn't yet get acks from RDMA users that we are aware, even
> > > if they're rare. According to [2] it could be that such user may only rely
> > > on the release versions of QEMU when it broke things.
> > > 
> > > So I'm copying Yu too (while Zhijian is already in the loop), just in case
> > > someone would like to stand up and speak.
> > 
> > 
> > I admit RDMA migration was lack of testing(unit/CI test), which led to the a few
> > obvious bugs being noticed too late.
> > However I was a bit surprised when I saw the removal of the RDMA migration. I wasn't
> > aware that this feature has not been marked as deprecated(at least there is no
> > prompt to end-user).
> > 
> > 
> > > IMHO it's more important to know whether there are still users and whether
> > > they would still like to see it around.
> > 
> > Agree.
> > I didn't immediately express my opinion in V1 because I'm also consulting our
> > customers for this feature in the future.
> > 
> > Personally, I agree with Perter's idea that "I'd slightly prefer postponing it one
> > more release which might help a bit of our downstream maintenance"
> 
> Do you mind posting a deprecation patch to clarify the situation?

The key thing the first deprecation patch missed was that it failed
to issue a warning message when RDMA migration was actually used.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


