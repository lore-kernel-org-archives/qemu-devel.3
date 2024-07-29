Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53E9C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 11:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYO8D-0007uK-Jn; Mon, 29 Jul 2024 07:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYO8C-0007q9-GM
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 07:01:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYO8A-00017M-Rw
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 07:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722250889;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/136KuYSZeuOyvyvNzrmEgzKDOkJpPOyPtAP+U1yY4E=;
 b=YUOhygUxFqhBxD5ZdpMzGbtAqyouM/spqENeYHexwC9+DOASs+CyzC+ac/5qYWClXB3x+O
 RXytPtrG1cESs+S3VbvUCf/qidRWRtjljWLuO1m2N1hM/RTh3e2bW/meYoqB6ux1c0gYDQ
 0+4tqDfQdoX4IPGj+chwPWzyr6UEMQE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-30K7-chHMJ-6wY0KsOPVSg-1; Mon,
 29 Jul 2024 07:01:25 -0400
X-MC-Unique: 30K7-chHMJ-6wY0KsOPVSg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 685781955D4A; Mon, 29 Jul 2024 11:01:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.58])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 020C81955F23; Mon, 29 Jul 2024 11:01:16 +0000 (UTC)
Date: Mon, 29 Jul 2024 12:01:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, kvm@vger.kernel.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 qemu-arm@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH 09/13] tests/avocado/boot_xen.py: fetch kernel during
 test setUp()
Message-ID: <Zqd2edn1-aNiVriv@redhat.com>
References: <20240726134438.14720-1-crosa@redhat.com>
 <20240726134438.14720-10-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240726134438.14720-10-crosa@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Jul 26, 2024 at 09:44:34AM -0400, Cleber Rosa wrote:
> The kernel is a common blob used in all tests.  By moving it to the
> setUp() method, the "fetch asset" plugin will recognize the kernel and
> attempt to fetch it and cache it before the tests are started.

The other tests don't call  fetch_asset() from their setUp
method - what's different about this test that prevents the
asset caching working ?

> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/avocado/boot_xen.py | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/avocado/boot_xen.py b/tests/avocado/boot_xen.py
> index f29bc58b9e..490a127a3e 100644
> --- a/tests/avocado/boot_xen.py
> +++ b/tests/avocado/boot_xen.py
> @@ -30,23 +30,22 @@ class BootXen(LinuxKernelTest):
>      timeout = 90
>      XEN_COMMON_COMMAND_LINE = 'dom0_mem=128M loglvl=all guest_loglvl=all'
>  
> -    def fetch_guest_kernel(self):
> +    def setUp(self):
> +        super(BootXen, self).setUp()
> +
>          # Using my own built kernel - which works
>          kernel_url = ('https://fileserver.linaro.org/'
>                        's/JSsewXGZ6mqxPr5/download?path=%2F&files='
>                        'linux-5.9.9-arm64-ajb')
>          kernel_sha1 = '4f92bc4b9f88d5ab792fa7a43a68555d344e1b83'
> -        kernel_path = self.fetch_asset(kernel_url,
> -                                       asset_hash=kernel_sha1)
> -
> -        return kernel_path
> +        self.kernel_path = self.fetch_asset(kernel_url,
> +                                            asset_hash=kernel_sha1)
>  
>      def launch_xen(self, xen_path):
>          """
>          Launch Xen with a dom0 guest kernel
>          """
>          self.log.info("launch with xen_path: %s", xen_path)
> -        kernel_path = self.fetch_guest_kernel()
>  
>          self.vm.set_console()
>  
> @@ -56,7 +55,7 @@ def launch_xen(self, xen_path):
>                           '-append', self.XEN_COMMON_COMMAND_LINE,
>                           '-device',
>                           'guest-loader,addr=0x47000000,kernel=%s,bootargs=console=hvc0'
> -                         % (kernel_path))
> +                         % (self.kernel_path))
>  
>          self.vm.launch()
>  
> -- 
> 2.45.2
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


