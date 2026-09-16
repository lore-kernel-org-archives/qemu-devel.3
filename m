Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471C4C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6mV7-0003hN-PG; Wed, 16 Sep 2026 06:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x6mUY-0003Zx-Du
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:03:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x6mUU-0005SR-Jo
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789553025;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p7kWp+CvyuO/TBfQQdi+hBwvA9y8gBjhYBHZleFIzVw=;
 b=bByqvVfHBS9iv1tJBE0UWN+xUTl9AZktaM8LZ1SC88oqBW3FBzeA22O331zdQEU2NNIjmz
 0HQ0ao7BZSbEt2+EkJ89nCf2hGtki3JkX2PINDhSmMxvpk/PmkM8OMoTMqY4BkZTNnIAsi
 P/sAh1OuzWeuL2idyhqUKibC8XHcjz8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-yr6wLpL9ObCHlBhNnzY4DA-1; Wed,
 16 Sep 2026 06:03:43 -0400
X-MC-Unique: yr6wLpL9ObCHlBhNnzY4DA-1
X-Mimecast-MFC-AGG-ID: yr6wLpL9ObCHlBhNnzY4DA_1789553021
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2487C184B3AE; Wed, 16 Sep 2026 10:03:40 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B14551956054; Wed, 16 Sep 2026 10:03:33 +0000 (UTC)
Date: Wed, 16 Sep 2026 11:03:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Warner Losh <imp@bsdimp.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Song Gao <gaosong@loongson.cn>, Kyle Evans <kevans@freebsd.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Eric Farman <farman@linux.ibm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v3 16/17] scripts/make2mtest: add docker dependencies for
 check-tcg-% targets
Message-ID: <aqppcizE7rzIfwCL@redhat.com>
References: <20260916085341.1692742-1-alex.bennee@linaro.org>
 <20260916085341.1692742-17-alex.bennee@linaro.org>
 <b58e25cd-0b41-4060-9946-cc5675aea67c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b58e25cd-0b41-4060-9946-cc5675aea67c@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Wed, Sep 16, 2026 at 02:56:09AM -0700, Pierrick Bouvier wrote:
> On 9/16/2026 1:53 AM, Alex Bennée wrote:
> > This should trigger the building of the docker image when the user
> > calls "make check-tcg" or one of the arch specific targets such as
> > "make check-tcg-m68k-linux-user".
> >
> 
> Maybe there is some confusion, patch 2 only reverts option
> enable/disable-containers + --container-command for meson. It does not
> disable container support for meson tcg tests, which is there and
> enabled by default. Thus, container image dependencies are already
> there, with ninja or make.
> 
> $ ./configure && make check-tcg-m68k-linux-user --dry-run |& grep debian
> [246/1052] Generating tests/tcg/image-debian-all-test-cross with a
> custom command
> 
> Given that dependencies are already there, what is the goal of current
> patch?
> 
> > We still keep the internal meson dependency so individual tests can
> > launched and the docker build verified.
> >
> 
> As a side note, since patch 3 removes existing meson options, there will
> be no way to disable container build and run. It might be a (new)
> problem if some people were relying on this to avoid using
> docker/podman, which is the current workaround for John Snow's issue for
> instance.
> 
> At minimum, current series should at least keep meson implementation of
> --disable-containers, which implies to keep this entry in
> meson_options.txt. The rest is less important, as risk is only to skip
> tests, which is not blocking for users.

Yes, if we're keeping meson.build rules that rely on containers,
then meson stll needs to honour the --disable-containers arg that
configure is processing now.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


