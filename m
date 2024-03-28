Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E8FC54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 13:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rppOW-00089n-ON; Thu, 28 Mar 2024 09:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rppOS-00088w-8Y
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 09:02:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rppOM-0007zB-Lp
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 09:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711630919;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+BW2Ksf83GE8S7t1V52i4hvNKP0NhMKruDLFdUUHyY4=;
 b=WYiV8nGSJfZHzlNTRRBxDUeldgOjjW8m+kjxGFD3V13KH8UVrMwGUxclohvkBbjtbMz08g
 Juh3u0ttEFZ8p2ZwU8wEIOcScVEl+sS41rBGWdN63KSDAC4dCJk1+EOS39Xt39IXZub2RP
 qFZOthoNX5l/lcelXII66CmJXpKmFLc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-oY766mbCMDquMX5iwE9AwA-1; Thu, 28 Mar 2024 09:01:56 -0400
X-MC-Unique: oY766mbCMDquMX5iwE9AwA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E42618172C2;
 Thu, 28 Mar 2024 13:01:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.135])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F07FEC51651;
 Thu, 28 Mar 2024 13:01:47 +0000 (UTC)
Date: Thu, 28 Mar 2024 13:01:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 integration@gluster.org, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, devel@lists.libvirt.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH-for-9.1] rdma: Remove RDMA subsystem and pvrdma device
Message-ID: <ZgVqNbl8H_h4aJc5@redhat.com>
References: <20240327105549.1824-1-philmd@linaro.org>
 <ZgUy5rFScwNkmZQK@redhat.com>
 <07348327-a61c-4cfb-bb5c-658448e3fb42@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07348327-a61c-4cfb-bb5c-658448e3fb42@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
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

On Thu, Mar 28, 2024 at 01:57:27PM +0100, Philippe Mathieu-Daudé wrote:
> On 28/3/24 10:06, Daniel P. Berrangé wrote:
> > On Wed, Mar 27, 2024 at 11:55:48AM +0100, Philippe Mathieu-Daudé wrote:
> > > The whole RDMA subsystem was deprecated in commit e9a54265f5
> > > ("hw/rdma: Deprecate the pvrdma device and the rdma subsystem")
> > > released in v8.2. Time to remove it.
> > > 
> > > Keep the RAM_SAVE_FLAG_HOOK definition since it might appears
> > > in old migration streams.
> > > 
> > > Remove the dependencies on libibumad and libibverbs.
> > 
> > > 
> > > Remove the generated vmw_pvrdma/ directory from linux-headers.
> > > 
> > > Remove RDMA handling from migration.
> > > 
> > > Remove RDMA handling in GlusterFS block driver.
> > 
> > The RDMA support in GlusterFS is completely opaque to QEMU.
> > All we have there is the CLI syntax to enable use of the
> > RDMA support inside libglusterfs. I'm not convinced that
> > the justification for deprecation (lack of maintanier)
> > applies to this scenario.
> 
> I'll quote commit 0552ff2465 from 2016 then:
> 
>     block/gluster: deprecate rdma support
> 
>     gluster volfile server fetch happens through unix and/or tcp,
>     it doesn't support volfile fetch over rdma. The rdma code may
>     actually mislead, so to make sure things do not break, for now
>     we fallback to tcp when requested for rdma, with a warning.
> 
>     If you are wondering how this worked all these days, its the gluster
>     libgfapi code which handles anything other than unix transport as
>     socket/tcp, sad but true.

Ok, that should have been mentioned in the commit message
then, and is another reason for removing each functional
area in a separate commit, with the relevant notes for each.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


