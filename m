Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AE3C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 09:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7WyH-0002Yq-LJ; Thu, 16 May 2024 05:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7WyF-0002YW-KC
 for qemu-devel@nongnu.org; Thu, 16 May 2024 05:00:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7WyC-0002lH-Ki
 for qemu-devel@nongnu.org; Thu, 16 May 2024 05:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715850011;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n/KJU03z5HddHSd+HwHUC1KTd2PvcA3611FDHHgBwKU=;
 b=NjTEo73vWc9eopXCte4lK13oL3N8oSPrdCLBqIKZEqGt0uZ2urWiE1JG9R+4RqfXb7hNn/
 ut8ijlW+F2wbR/NuG+2zPswEcuXdNG4NzZaZzLtODLjK9MehdUv4ffSXh/A57tUv0EMWhB
 pFQbhU4cQA0GiDexNpKsTqY4GnuZ+A0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-d0-u1FRCP9mrbtO8vyfqIw-1; Thu, 16 May 2024 05:00:02 -0400
X-MC-Unique: d0-u1FRCP9mrbtO8vyfqIw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 033F5101A554;
 Thu, 16 May 2024 09:00:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AD76200B4D0;
 Thu, 16 May 2024 09:00:01 +0000 (UTC)
Date: Thu, 16 May 2024 09:59:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 5/5] tests/docker/dockerfiles: Update container files
 with "lcitool-refresh"
Message-ID: <ZkXLDnd02C9jgiYH@redhat.com>
References: <20240516084059.511463-1-thuth@redhat.com>
 <20240516084059.511463-6-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240516084059.511463-6-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
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

On Thu, May 16, 2024 at 10:40:59AM +0200, Thomas Huth wrote:
> Run "make lcitool-refresh" after the previous changes to the
> lcitool files. This removes the g++ and xfslibs-dev packages
> from the dockerfiles (except for the fedora-win64-cross dockerfile
> where we keep the C++ compiler).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/docker/dockerfiles/alpine.docker                | 4 ----
>  tests/docker/dockerfiles/centos9.docker               | 4 ----
>  tests/docker/dockerfiles/debian-amd64-cross.docker    | 4 ----
>  tests/docker/dockerfiles/debian-arm64-cross.docker    | 4 ----
>  tests/docker/dockerfiles/debian-armel-cross.docker    | 4 ----
>  tests/docker/dockerfiles/debian-armhf-cross.docker    | 4 ----
>  tests/docker/dockerfiles/debian-i686-cross.docker     | 4 ----
>  tests/docker/dockerfiles/debian-mips64el-cross.docker | 4 ----
>  tests/docker/dockerfiles/debian-mipsel-cross.docker   | 4 ----
>  tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 4 ----
>  tests/docker/dockerfiles/debian-riscv64-cross.docker  | 3 ---
>  tests/docker/dockerfiles/debian-s390x-cross.docker    | 4 ----
>  tests/docker/dockerfiles/debian.docker                | 4 ----
>  tests/docker/dockerfiles/fedora-win64-cross.docker    | 2 +-
>  tests/docker/dockerfiles/fedora.docker                | 4 ----
>  tests/docker/dockerfiles/opensuse-leap.docker         | 4 ----
>  tests/docker/dockerfiles/ubuntu2204.docker            | 4 ----
>  17 files changed, 1 insertion(+), 64 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


