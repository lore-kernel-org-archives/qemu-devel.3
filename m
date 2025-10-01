Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142D1CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 12:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3vpd-0005J3-Db; Wed, 01 Oct 2025 08:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3vpY-0005IZ-Cd
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 08:21:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3vpM-0007wa-QP
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 08:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759321249;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=nYK99/HlrQMwoxwLKWb6I0EC0jIrNa4BMxAFVyzqfEk=;
 b=IAAcjnXoKTG7x7Tcd6uYJ5NthwiqJo10g1qYo8cgg6aMxKkcyh/VDmajAv/BwQGjg8yet+
 bd/k3L7BXTFS+Gx3u2WVDlY28lBeJN7erGVf+k6cRAIjTZ+6eg2jW/sWrGSFWt+zAhsgSE
 bHNr9nVpFgcZ98giIT5gzAwNHUXtb1k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-8svkYpnJMOKpXZWPZzKK8Q-1; Wed,
 01 Oct 2025 08:20:46 -0400
X-MC-Unique: 8svkYpnJMOKpXZWPZzKK8Q-1
X-Mimecast-MFC-AGG-ID: 8svkYpnJMOKpXZWPZzKK8Q_1759321244
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE2D21800366; Wed,  1 Oct 2025 12:20:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.187])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47B9830002C5; Wed,  1 Oct 2025 12:20:37 +0000 (UTC)
Date: Wed, 1 Oct 2025 13:20:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Eric Blake <eblake@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 26/27] docs: Add mshv to documentation
Message-ID: <aN0ckoE9WIFepW3d@redhat.com>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
 <20250916164847.77883-27-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250916164847.77883-27-magnuskulke@linux.microsoft.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Sep 16, 2025 at 06:48:46PM +0200, Magnus Kulke wrote:
> Added mshv to the list of accelerators in doc text.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  docs/about/build-platforms.rst |  2 +-
>  docs/devel/codebase.rst        |  2 +-
>  docs/glossary.rst              |  6 +++---
>  docs/system/introduction.rst   |  3 +++
>  qemu-options.hx                | 16 ++++++++--------
>  5 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
> index 8671c3be9c..06ba0ddc9a 100644
> --- a/docs/about/build-platforms.rst
> +++ b/docs/about/build-platforms.rst
> @@ -55,7 +55,7 @@ Those hosts are officially supported, with various accelerators:
>     * - SPARC
>       - tcg
>     * - x86
> -     - hvf (64 bit only), kvm, nvmm, tcg, whpx (64 bit only), xen
> +     - hvf (64 bit only), mshv (64 bit only), kvm, nvmm, tcg, whpx (64 bit only), xen
>  
>  Other host architectures are not supported. It is possible to build QEMU system
>  emulation on an unsupported host architecture using the configure
> diff --git a/docs/devel/codebase.rst b/docs/devel/codebase.rst
> index 2a3143787a..69d8827117 100644
> --- a/docs/devel/codebase.rst
> +++ b/docs/devel/codebase.rst
> @@ -48,7 +48,7 @@ yet, so sometimes the source code is all you have.
>  * `accel <https://gitlab.com/qemu-project/qemu/-/tree/master/accel>`_:
>    Infrastructure and architecture agnostic code related to the various
>    `accelerators <Accelerators>` supported by QEMU
> -  (TCG, KVM, hvf, whpx, xen, nvmm).
> +  (TCG, KVM, hvf, whpx, xen, nvmm, mshv).
>    Contains interfaces for operations that will be implemented per
>    `target <https://gitlab.com/qemu-project/qemu/-/tree/master/target>`_.
>  * `audio <https://gitlab.com/qemu-project/qemu/-/tree/master/audio>`_:
> diff --git a/docs/glossary.rst b/docs/glossary.rst
> index 4fa044bfb6..0fa75c9d1e 100644
> --- a/docs/glossary.rst
> +++ b/docs/glossary.rst

> @@ -102,8 +102,8 @@ hypervisors.
>  
>  In the context of QEMU, an hypervisor is an API, provided by the Host OS,
>  allowing to execute virtual machines. Linux implementation is KVM (and supports
> -Xen as well). For MacOS, it's HVF. Windows defines WHPX. And NetBSD provides
> -NVMM.
> +Xen and MSHV as well). For MacOS, it's HVF. Windows defines WHPX. And NetBSD
> +provides NVMM.

This is a bit of a bike-shed colouring comment, but how about saying

  "Linux provides a choice of KVM, Xen or MSHV; MacOS provides HVF;
   Windows provides WPHX; NetBSD provides NVMM."


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


