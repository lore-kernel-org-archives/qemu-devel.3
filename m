Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411A6C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 16:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7HOL-0004CL-5q; Wed, 15 May 2024 12:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7HOJ-0004Bv-O1
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:22:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7HOG-0007jd-De
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715790123;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nmkTWaisy4R2Mu7NUhC46zzhrGGene3P5HaV6fxWV04=;
 b=Iow/CFwiw26ZwFYGM7AUYv+EzfTmDHtu2sRU3CUNZ7PppQ+U6BufPu/hGh8ZsyQDz7OBDG
 RNdVfV02eYmG8p80vv32ZjiCUuwg38RPTOa/d8f3UG8/C/ExRWMiLPAbxAL8BhALilQ9cu
 WdZ6ZLl4SqSjCVUWv5HwvjimX5WQDYY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-2Khz-HrLOcK4JNNGKh6JCg-1; Wed,
 15 May 2024 12:22:00 -0400
X-MC-Unique: 2Khz-HrLOcK4JNNGKh6JCg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 574FD3803908;
 Wed, 15 May 2024 16:21:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A0D3491032;
 Wed, 15 May 2024 16:21:55 +0000 (UTC)
Date: Wed, 15 May 2024 17:21:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 0/5] Fix "virtio-gpu: fix scanout migration post-load"
Message-ID: <ZkThIRggOlig2tv0@redhat.com>
References: <20240515141557.1277999-1-marcandre.lureau@redhat.com>
 <ZkTdwyxWcTTMwtAp@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkTdwyxWcTTMwtAp@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
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

On Wed, May 15, 2024 at 10:07:31AM -0600, Peter Xu wrote:
> On Wed, May 15, 2024 at 06:15:51PM +0400, marcandre.lureau@redhat.com wrote:
> > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> > 
> > Hi,
> > 
> > The aforementioned patch breaks virtio-gpu device migrations for versions
> > pre-9.0/9.0, both forwards and backwards. Versioning of `VMS_STRUCT` is more
> > complex than it may initially appear, as evidenced in the problematic commit
> > dfcf74fa68c ("virtio-gpu: fix scanout migration post-load").
> > 
> > v2:
> >  - use a manual version field test (instead of the more complex struct variant)
> > 
> > v3:
> >  - introduce machine_check_version()
> >  - drop the VMSD version, and use machine version field test
> 
> Thanks for trying this out already.
> 
> Last time I mentioned this may for the long term because I remember Dan and
> Thomas were trying to work on some machine deprecation work, and maybe such
> things may collapse with that work (and perhaps easier with that work
> landed, too?).  Just to copy them both here so we know where we are now, as
> I didn't follow that discussion.  IOW, patch 3/4 may need separate review
> from outside migration..

You'll be refering to my series here:

  https://lists.nongnu.org/archive/html/qemu-devel/2024-05/msg00084.html

Note that series very delibrately did *not* expose the version numbers
as accessible fields to code. The version number info is only accessible
within the machine type macros, and once the macros are expanded, the
version digits remains hidden within the opaque machine type name strings,
and/or method names.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


