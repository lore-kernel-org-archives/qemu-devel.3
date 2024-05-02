Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7DCC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 09:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2TA8-00085j-St; Thu, 02 May 2024 05:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2TA4-000846-PC
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:55:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2TA2-0000oh-D9
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714643729;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NLGGbor5em6733RlyGNHzkI/Ilv2SIaeX+6RySBONw8=;
 b=d/AH5A465l/A1fdfql0Q8VlvSJUV9U4Ii2jonQF/P6HhHTtyt0BM7qWE3x19Ci1NGzafOC
 Tn+HLjkGbY8Hz2DeyzOIMUIjdvDrlEcm9RIRKXQAtAWV8tfvpvJjrOEumYd0YPUkUN54a5
 skj4JHrqrVkiSuBmIImETqNqdZTFMNU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-VMqvnEmOMmeaaAvESZpxFQ-1; Thu, 02 May 2024 05:55:26 -0400
X-MC-Unique: VMqvnEmOMmeaaAvESZpxFQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F050018065AA;
 Thu,  2 May 2024 09:55:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14ED6201F35C;
 Thu,  2 May 2024 09:55:23 +0000 (UTC)
Date: Thu, 2 May 2024 10:55:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Yu Zhang <yu.zhang@ionos.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Jack Wang <jack.wang@ionos.com>,
 Li Zhijian <lizhijian@fujitsu.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Michael Galaxy <mgalaxy@akamai.com>
Subject: Re: [PATCH] migration/rdma: Allow building without on-demand paging
 support
Message-ID: <ZjNjCpY-nDjOyrjq@redhat.com>
References: <20240502090547.87824-1-philmd@linaro.org>
 <ZjNYhGQTFBQHZgga@redhat.com>
 <8c487804-a706-4149-abb3-c2495247f09f@linaro.org>
 <fc6ef6ae-f380-4096-bdfd-094d1a7a3aaf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc6ef6ae-f380-4096-bdfd-094d1a7a3aaf@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
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

On Thu, May 02, 2024 at 11:21:31AM +0200, Philippe Mathieu-Daudé wrote:
> On 2/5/24 11:19, Philippe Mathieu-Daudé wrote:
> > On 2/5/24 11:10, Daniel P. Berrangé wrote:
> > > On Thu, May 02, 2024 at 11:05:47AM +0200, Philippe Mathieu-Daudé wrote:
> > > > On-demand paging support was added in libibverbs v1.2.0 in
> > > > commit https://github.com/linux-rdma/rdma-core/commit/e500adc7b1
> > > 
> > > That is 9 years old, so I'm surprised any distro we target still
> > > is so outdated. Can you say what distro you're seeing a problem
> > > on and what version it has ?
> > 
> > This is Oracle Solaris 11.4 SRU, released 2 weeks ago:
> > https://support.oracle.com/knowledge/Sun%20Microsystems/2433412_1.html
> > 
> > I'm not sure how to detect the version, I'm seeing downstream
> > patches applied on top.
> 
> Regardless, we can't expect any rdma library version to work,
> either we ask for some version, or we check that symbol is there
> and reject if not as "your rdma is too old", so the user can
> choose to build with --disable-rdma.

The RDMA libs appear to have pkg-config files, so I agree that we
should be requesting a min version in meson that matches what our
code actually requires.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


