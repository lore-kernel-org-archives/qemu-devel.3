Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C56FCAC599
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 13:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uysc6-0002mG-UB; Wed, 17 Sep 2025 09:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uysbv-0002iT-Ng
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 09:54:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uysbt-0005gI-K4
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 09:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758117252;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=l35+6X0jYU0AhCSpL3cOHinYsiJ/cHpJo85JeoBiKr4=;
 b=Kvvanhlslx8VeGn439XZ7nFgIYLm6ayg9cfvhPZ8OHT4OyOwQxBtNWTVr0sCJSmMqtFxbl
 aMi+/SiJTUg8kXvYm9VqvLvoAN0l3mEficTHeh3EPY+HhFi9bsxf6IagcCRNi0HuhKNOSv
 9Pzc7TtDYrGEbgidHsxxuJMR0ZYI/6s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-DDKVbFUWM5W6iltcaVjQ6w-1; Wed,
 17 Sep 2025 09:54:05 -0400
X-MC-Unique: DDKVbFUWM5W6iltcaVjQ6w-1
X-Mimecast-MFC-AGG-ID: DDKVbFUWM5W6iltcaVjQ6w_1758117239
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4F5D1800378; Wed, 17 Sep 2025 13:53:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.195])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 262BC300018D; Wed, 17 Sep 2025 13:53:51 +0000 (UTC)
Date: Wed, 17 Sep 2025 14:53:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Joel Stanley <joel@jms.id.au>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 Chao Liu <chao.liu@zevorn.cn>, Nicholas Joaquin <njoaquin@tenstorrent.com>,
 Ganesh Valliappan <gvalliappan@tenstorrent.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 2/3] target/risvc: Fix vector whole ldst vstart check
Message-ID: <aMq9axr_wINfBpxP@redhat.com>
References: <20250903030114.274535-1-npiggin@gmail.com>
 <20250903030114.274535-3-npiggin@gmail.com>
 <6bff4c9d-1da4-40b3-901a-789923d8ef7e@ventanamicro.com>
 <qyikdqxxiewb7tqykt74gpx5oereckbepyptd3vr4flptmrvoc@midnt5c7agnc>
 <3dd9888f-be16-48f8-a858-f58a5b57825d@ventanamicro.com>
 <188f0525-154e-4d08-a155-68e8800e302d@linaro.org>
 <CACPK8Xd183vLgSyNfjzN5caUeJGRrjM1J8ugTVRd2k0Ea5LpfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACPK8Xd183vLgSyNfjzN5caUeJGRrjM1J8ugTVRd2k0Ea5LpfQ@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 17, 2025 at 11:14:41PM +0930, Joel Stanley wrote:
> On Fri, 5 Sept 2025 at 16:50, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 9/4/25 13:06, Daniel Henrique Barboza wrote:
> > > How hard it is to update the GCC version we're running in the docker images for
> > > "check-tcg"? We would like to use a RISC-V vector header that isn't supported
> > > ATM.
> > If debian packages the gcc version, then it's easy: change
> >
> >    gcc-riscv-linux-gnu
> >
> > to
> >
> >    gcc-NN-riscv-linux-gnu
> 
> The test that was failing uses debian-all-test-cross. This is based on
> Debian 12 which maxes out at GCC 12.
> 
> If we move to Debian 13, we get GCC 14. Something like this would do it:

Debian 12 is a supported platform for QEMU, so we should generally
expect our tests to work on that. That said IIUC riscv didn't become
officially supported in Debian until 13, so we can use that as a
justification for an exception to the normal platform rule.

> --- a/tests/docker/dockerfiles/debian-all-test-cross.docker
> +++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
> @@ -6,7 +6,7 @@
>  # basic compilers for as many targets as possible. We shall use this
>  # to build and run linux-user tests on GitLab
>  #
> -FROM docker.io/library/debian:12-slim
> +FROM docker.io/library/debian:13-slim
> 
> Is updating the distro something we would consider for this development cycle?
> 
> Cheers,
> 
> Joel
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


