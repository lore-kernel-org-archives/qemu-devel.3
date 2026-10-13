Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2763DCC6B0E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGXZE-0005ub-Ho; Tue, 13 Oct 2026 04:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGXZD-0005uL-Ce
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:08:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGXZB-0003u3-Cs
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791878936;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+PBWGP1ZRY+pTeN/ilLcZLrA5sthLU1Ia3ftkeO7vik=;
 b=cFRMArxAZNMr6EpxM+yj5BOWfvnUj4jv1MQL7zW1s4VO/mGgZoYgN+lyuCURxjBDlJjkO/
 e/p5ZHHQ0T/hxbLbYXBkT7Y43LXQsk5T6zhF257WO/EDeyBwn306bgWpYIFDWT/W+aW5vb
 MMQ387W4QP55xuqKwJuZZWeLlPA5yMI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-fvkNCuiiPnCwpLgi27OTbw-1; Tue,
 13 Oct 2026 08:08:52 +0000
X-MC-Unique: fvkNCuiiPnCwpLgi27OTbw-1
X-Mimecast-MFC-AGG-ID: fvkNCuiiPnCwpLgi27OTbw_1791878929
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DF73184AE51; Tue, 13 Oct 2026 08:08:49 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A04A130001B9; Tue, 13 Oct 2026 08:08:41 +0000 (UTC)
Date: Tue, 13 Oct 2026 09:08:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Kyle Evans <kevans@freebsd.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, Ani Sinha <anisinha@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Warner Losh <imp@bsdimp.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Peter Xu <peterx@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Song Gao <gaosong@loongson.cn>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v2 15/16] tests/functional: update s390x tuxrun images
Message-ID: <as3nBrTshSmDcKvM@redhat.com>
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
 <20261012170330.1144446-16-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261012170330.1144446-16-alex.bennee@linaro.org>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Mon, Oct 12, 2026 at 06:03:29PM +0100, Alex Bennée wrote:
> We now split the fetching of the buildroot image from the kernel
> itself. This is because we will want to access additional metadata in
> future tests.

This commit message appears unrelated 

> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/functional/s390x/test_tuxrun.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/functional/s390x/test_tuxrun.py b/tests/functional/s390x/test_tuxrun.py
> index 086466af81f..8e0261e2b7f 100755
> --- a/tests/functional/s390x/test_tuxrun.py
> +++ b/tests/functional/s390x/test_tuxrun.py
> @@ -17,11 +17,11 @@
>  class TuxRunS390xTest(TuxRunBaselineTest):
>  
>      ASSET_S390X_KERNEL = Asset(
> -        'https://storage.tuxboot.com/buildroot/20241119/s390/bzImage',
> -        'ee67e91db52a2aed104a7c72b2a08987c678f8179c029626789c35d6dd0fedf1')
> +        'https://storage.tuxboot.com/kernels/6.18.54/s390/bzImage',
> +        '5efeb31754b211440e1595ab11355bb006fe78a2c0604ed0a8c55c4598b71aec')
>      ASSET_S390X_ROOTFS = Asset(
> -        'https://storage.tuxboot.com/buildroot/20241119/s390/rootfs.ext4.zst',
> -        'bff7971fc2fef56372d98afe4557b82fd0a785a241e44c29b058e577ad1bbb44')
> +        'https://storage.tuxboot.com/buildroot/20260924/s390/rootfs.ext4.zst',
> +        '5ba18c4d18831c50a0c743990f7bdee1d3b520629d423c55b668d8fbbac9c6f5')
>  
>      def test_s390(self):
>          self.set_machine('s390-ccw-virtio')
> -- 
> 2.47.3
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


