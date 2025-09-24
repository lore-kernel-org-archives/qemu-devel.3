Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E036CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 13:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Pnu-0002eA-J5; Wed, 24 Sep 2025 09:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1Pnr-0002cw-Af
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 09:45:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1Pna-0005hE-BO
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 09:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758721480;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nNQpqY7O7ToF/ZLOdnIWc8H8LK3UZC0ujKHBQpSOzYw=;
 b=O20FLoW4S9AW9BoKFweKOxHbapIsGIxXyIS3L67nnI76++qoZdOjrzblaPNYxe8oxEUbu7
 oOe5oWLSFVqgG7sBMtcLSI83XD6jxCFXdN1KTAEFB2cJfITypFhq+S5bzB3vM8JmtBV8I4
 M5g6IMxB7lLKhksCBC6ErVuC5xxd/bs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-6tv6i2F4NX6KPyjWRJ-V4A-1; Wed,
 24 Sep 2025 09:44:34 -0400
X-MC-Unique: 6tv6i2F4NX6KPyjWRJ-V4A-1
X-Mimecast-MFC-AGG-ID: 6tv6i2F4NX6KPyjWRJ-V4A_1758721472
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 750131800359; Wed, 24 Sep 2025 13:44:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.136])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9815300018D; Wed, 24 Sep 2025 13:44:26 +0000 (UTC)
Date: Wed, 24 Sep 2025 14:44:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Yonggang Luo <luoyonggang@gmail.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ed Maste <emaste@freebsd.org>, devel@lists.libvirt.org,
 qemu-rust@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: Re: [PATCH v2 12/27] lcitool: update, switch to f41
Message-ID: <aNP1tyH1YeRyhnNg@redhat.com>
References: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
 <20250924120426.2158655-13-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250924120426.2158655-13-marcandre.lureau@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 24, 2025 at 04:04:09PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Newer lcitool version has various fixes helping QEMU CI and this series.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml   |  3 ++-
>  scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml     |  3 ++-
>  tests/docker/dockerfiles/alpine.docker             |  2 +-
>  tests/docker/dockerfiles/debian-amd64-cross.docker |  5 ++++-
>  tests/docker/dockerfiles/debian-arm64-cross.docker |  5 ++++-
>  tests/docker/dockerfiles/debian-armhf-cross.docker |  5 ++++-
>  tests/docker/dockerfiles/debian-i686-cross.docker  |  5 ++++-
>  .../dockerfiles/debian-mips64el-cross.docker       |  5 ++++-
>  .../docker/dockerfiles/debian-mipsel-cross.docker  |  5 ++++-
>  .../docker/dockerfiles/debian-ppc64el-cross.docker |  5 ++++-
>  .../docker/dockerfiles/debian-riscv64-cross.docker |  8 ++++++--
>  tests/docker/dockerfiles/debian-s390x-cross.docker |  5 ++++-
>  tests/docker/dockerfiles/debian.docker             |  5 ++++-
>  .../docker/dockerfiles/fedora-rust-nightly.docker  | 14 ++++++++------
>  tests/docker/dockerfiles/fedora-win64-cross.docker | 11 +++++++----
>  tests/docker/dockerfiles/fedora.docker             | 14 ++++++++------
>  tests/docker/dockerfiles/opensuse-leap.docker      |  4 ++--
>  tests/docker/dockerfiles/ubuntu2204.docker         |  5 ++++-
>  tests/lcitool/libvirt-ci                           |  2 +-
>  tests/lcitool/projects/qemu.yml                    |  1 -
>  tests/lcitool/refresh                              |  6 +++---
>  21 files changed, 80 insertions(+), 38 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


