Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11F6C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHLUl-0001MX-Bv; Tue, 20 May 2025 07:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uHLUi-0001MF-4K
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:50:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uHLUd-0004iJ-Pa
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747741844;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=bXimasAoO6sn49a3F1IPBhaMX/eHAox+FQE8ROsPQ+w=;
 b=Mg2ML2hqz8EnZHSkQ6zeAxG73UV9UGUi9gf78Yu+iClCggnjV6wWij7nrKsU6HQm/YsCMJ
 Qo8XqYtXMTJZE9vwKgZ2ioSCiZjOkSdDLYrAspEoeQtvuawMcjbbATOTE2ATCTF5VTnDl3
 jIgPp2mJR+p3uV0I0ROacdkOm2Ipkq4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-xScUKK74PHSU8Y9Fg_ltag-1; Tue,
 20 May 2025 07:50:41 -0400
X-MC-Unique: xScUKK74PHSU8Y9Fg_ltag-1
X-Mimecast-MFC-AGG-ID: xScUKK74PHSU8Y9Fg_ltag_1747741840
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93B0B180035C; Tue, 20 May 2025 11:50:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.49])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F97A30001AA; Tue, 20 May 2025 11:50:33 +0000 (UTC)
Date: Tue, 20 May 2025 12:50:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [RFC PATCH 01/25] accel: Add Meson and config support for MSHV
 accelerator
Message-ID: <aCxsgBJZYeeXJVec@redhat.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-2-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250520113018.49569-2-magnuskulke@linux.microsoft.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, May 20, 2025 at 01:29:54PM +0200, Magnus Kulke wrote:
> Introduce a Meson feature option and default-config entry to allow
> building QEMU with MSHV (Microsoft Hypervisor) acceleration support.
> 
> This is the first step toward implementing an MSHV backend in QEMU.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  accel/Kconfig                 |  3 +++
>  meson.build                   | 16 ++++++++++++++++
>  meson_options.txt             |  2 ++
>  scripts/meson-buildoptions.sh |  3 +++
>  4 files changed, 24 insertions(+)
> 
> diff --git a/accel/Kconfig b/accel/Kconfig
> index 4263cab722..a60f114923 100644
> --- a/accel/Kconfig
> +++ b/accel/Kconfig
> @@ -13,6 +13,9 @@ config TCG
>  config KVM
>      bool
>  
> +config MSHV
> +    bool
> +
>  config XEN
>      bool
>      select FSDEV_9P if VIRTFS
> diff --git a/meson.build b/meson.build
> index e819a7084c..a4269b816b 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -322,6 +322,13 @@ else
>  endif
>  accelerator_targets += { 'CONFIG_XEN': xen_targets }
>  
> +if cpu == 'x86_64'
> +  mshv_targets = ['x86_64-softmmu']
> +else
> +  mshv_targets = []
> +endif
> +accelerator_targets += { 'CONFIG_MSHV': mshv_targets }
> +
>  if cpu == 'aarch64'
>    accelerator_targets += {
>      'CONFIG_HVF': ['aarch64-softmmu']
> @@ -877,6 +884,14 @@ accelerators = []
>  if get_option('kvm').allowed() and host_os == 'linux'
>    accelerators += 'CONFIG_KVM'
>  endif
> +
> +if get_option('mshv').allowed() and host_os == 'linux'
> +  if get_option('mshv').enabled() and host_machine.cpu() != 'x86_64'
> +    error('mshv accelerator requires x64_64 host')
> +  endif
> +  accelerators += 'CONFIG_MSHV'

This enables MSHV for non-x86 when the option is left on 'auto'.

You would need something more like this:

  if host_machine.cpu() != 'x86_64'
    if get_option('mshv').enabled()
      error('mshv accelerator requires x64_64 host')
    endif
  else
    accelerators += 'CONFIG_MSHV'
  endif

> +endif
> +
>  if get_option('whpx').allowed() and host_os == 'windows'
>    if get_option('whpx').enabled() and host_machine.cpu() != 'x86_64'
>      error('WHPX requires 64-bit host')

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


