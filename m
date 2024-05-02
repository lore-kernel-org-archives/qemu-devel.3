Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70454C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 10:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2TMy-0005zc-4X; Thu, 02 May 2024 06:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2TMv-0005zJ-GB
 for qemu-devel@nongnu.org; Thu, 02 May 2024 06:08:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2TMt-00036k-Dr
 for qemu-devel@nongnu.org; Thu, 02 May 2024 06:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714644526;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RSA+6DUDEl6ykdewhj9FZQbvIE5dx9B5Jv+dq97DvzA=;
 b=CpEe1wbvs0FwU6Ks39VYKwAn6rc072kHfm+Yn3gCzuEID43u3+TdiX6Oa/Tq8Wh+2d8WST
 3/kjm/axBoZiM19X4hex1AHfMbIYTovyqmwVde5WSqpWO71Peb6Ipw8+B3eBK6KIl3+MGz
 NLYgZI4K1sYL0WSTKilOxFtLQzk5RGc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-p7LeEoySPNSPD4OsYxl76g-1; Thu, 02 May 2024 06:08:42 -0400
X-MC-Unique: p7LeEoySPNSPD4OsYxl76g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3852280B704;
 Thu,  2 May 2024 10:08:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E657C271AA;
 Thu,  2 May 2024 10:08:40 +0000 (UTC)
Date: Thu, 2 May 2024 11:08:38 +0100
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
Message-ID: <ZjNmJqfFw4ncRrav@redhat.com>
References: <20240502090547.87824-1-philmd@linaro.org>
 <ZjNYhGQTFBQHZgga@redhat.com>
 <8c487804-a706-4149-abb3-c2495247f09f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c487804-a706-4149-abb3-c2495247f09f@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Thu, May 02, 2024 at 11:19:28AM +0200, Philippe Mathieu-Daudé wrote:
> On 2/5/24 11:10, Daniel P. Berrangé wrote:
> > On Thu, May 02, 2024 at 11:05:47AM +0200, Philippe Mathieu-Daudé wrote:
> > > On-demand paging support was added in libibverbs v1.2.0 in
> > > commit https://github.com/linux-rdma/rdma-core/commit/e500adc7b1
> > 
> > That is 9 years old, so I'm surprised any distro we target still
> > is so outdated. Can you say what distro you're seeing a problem
> > on and what version it has ?
> 
> This is Oracle Solaris 11.4 SRU, released 2 weeks ago:
> https://support.oracle.com/knowledge/Sun%20Microsystems/2433412_1.html

Solaris 11.4 was originally from 2018 IIUC, so that explains why
it is so ancient.

> I'm not sure how to detect the version, I'm seeing downstream
> patches applied on top.

When this was first introduced there was no pkg-config files
present, nor was it using cmake, or even library versioning
afaics.

The pkgconfig files were added 3 years later in

  commit df5fe3c2fa9d7dbb38fb7b4878955330620211ed
  Author: Luca Boccassi <bluca@debian.org>
  Date:   Tue Aug 28 19:46:07 2018 +0100

    Generate and install pkgconfig files for libs

which at that point had defined:

  CMakeLists.txt:set(PACKAGE_VERSION "20.0")
  librdmacm/CMakeLists.txt:  1 1.1.${PACKAGE_VERSION}
  libibverbs/CMakeLists.txt:  1 1.5.${PACKAGE_VERSION}

So I think we can try checking

  libibverbs >= 1.5
  rdmacm >= 1.1

in meson.build, and see if that solves the Solaris
problem....depends what the scope of their downstream
patches is.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


