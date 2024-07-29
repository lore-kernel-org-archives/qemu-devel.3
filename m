Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3122DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 10:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYNi8-0006Zk-E7; Mon, 29 Jul 2024 06:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYNi7-0006VG-GU
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 06:34:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYNi5-00043K-Cy
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 06:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722249272;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=jrsIQdxPsAZhxdWinFuSjToBMhcCX2rBPI5tFjYosOQ=;
 b=h9szyC935bBybkh26yxW48gxglK0KktjP5QAIJKOuiVY7+msPvL8OV5LJ4bYYBiwZTkXZm
 4CDMdSmuaKaLwLAiAEi9Su2RjJwJBFTlZiDu8oGvpd+qKMYV0uuY41LncLSd4qr4O7zJ69
 lgZdWOHDaUavNbVKxvliZHEJHSwCuas=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-kSaR1ZIRMG6tWIK5qN8daA-1; Mon,
 29 Jul 2024 06:34:26 -0400
X-MC-Unique: kSaR1ZIRMG6tWIK5qN8daA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9D4F1955D4D; Mon, 29 Jul 2024 10:34:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.58])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5160A300018D; Mon, 29 Jul 2024 10:34:17 +0000 (UTC)
Date: Mon, 29 Jul 2024 11:34:13 +0100
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
Subject: Re: [PATCH 05/13] tests/avocado: machine aarch64: standardize
 location and RO access
Message-ID: <ZqdwJRRBjj5DsWh8@redhat.com>
References: <20240726134438.14720-1-crosa@redhat.com>
 <20240726134438.14720-6-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240726134438.14720-6-crosa@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Jul 26, 2024 at 09:44:30AM -0400, Cleber Rosa wrote:
> The tests under machine_aarch64_virt.py and machine_aarch64_sbsaref.py
> should not be writing to the ISO files.  By adding "media=cdrom" the
> "ro" is autmatically set.
> 
> While at it, let's use a single code style and hash for the ISO url.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/avocado/machine_aarch64_sbsaref.py |  6 +++++-
>  tests/avocado/machine_aarch64_virt.py    | 14 +++++++-------
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
> index e920bbf08c..1275f24532 100644
> --- a/tests/avocado/machine_aarch64_sbsaref.py
> +++ b/tests/avocado/machine_aarch64_sbsaref.py
> @@ -129,7 +129,11 @@ def boot_alpine_linux(self, cpu):
>              "-cpu",
>              cpu,
>              "-drive",
> -            f"file={iso_path},format=raw",
> +            f"file={iso_path},media=cdrom,format=raw",
> +            "-device",
> +            "virtio-rng-pci,rng=rng0",
> +            "-object",
> +            "rng-random,id=rng0,filename=/dev/urandom",
>          )

The commit message doesn't say anything about adding virtio-rng.
If that's needed for some reason, do it as a separate commit
with an explanation of the bug its fixing.


> diff --git a/tests/avocado/machine_aarch64_virt.py b/tests/avocado/machine_aarch64_virt.py
> index a90dc6ff4b..6831d2c0ed 100644
> --- a/tests/avocado/machine_aarch64_virt.py
> +++ b/tests/avocado/machine_aarch64_virt.py
> @@ -37,13 +37,13 @@ def test_alpine_virt_tcg_gic_max(self):
>          :avocado: tags=machine:virt
>          :avocado: tags=accel:tcg
>          """
> -        iso_url = ('https://dl-cdn.alpinelinux.org/'
> -                   'alpine/v3.17/releases/aarch64/'
> -                   'alpine-standard-3.17.2-aarch64.iso')
> +        iso_url = (
> +            "https://dl-cdn.alpinelinux.org/"
> +            "alpine/v3.17/releases/aarch64/alpine-standard-3.17.2-aarch64.iso"
> +        )
>  
> -        # Alpine use sha256 so I recalculated this myself
> -        iso_sha1 = '76284fcd7b41fe899b0c2375ceb8470803eea839'
> -        iso_path = self.fetch_asset(iso_url, asset_hash=iso_sha1)
> +        iso_hash = "5a36304ecf039292082d92b48152a9ec21009d3a62f459de623e19c4bd9dc027"
> +        iso_path = self.fetch_asset(iso_url, algorithm="sha256", asset_hash=iso_hash)
>  
>          self.vm.set_console()
>          kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
> @@ -60,7 +60,7 @@ def test_alpine_virt_tcg_gic_max(self):
>          self.vm.add_args("-smp", "2", "-m", "1024")
>          self.vm.add_args('-bios', os.path.join(BUILD_DIR, 'pc-bios',
>                                                 'edk2-aarch64-code.fd'))
> -        self.vm.add_args("-drive", f"file={iso_path},format=raw")
> +        self.vm.add_args("-drive", f"file={iso_path},media=cdrom,format=raw")
>          self.vm.add_args('-device', 'virtio-rng-pci,rng=rng0')
>          self.vm.add_args('-object', 'rng-random,id=rng0,filename=/dev/urandom')
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


