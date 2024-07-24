Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C9FC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 16:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWepZ-0001C2-IC; Wed, 24 Jul 2024 12:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWepY-0001BX-1z
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 12:27:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWepV-0002Wy-DG
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 12:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721838423;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=s4U6m+38PTY1pm9G8WHo3AGMZVn7OqUwMTywSICKYVw=;
 b=bNl7XbSiu146oGzqlXDQdrQSMikWvgfqd5oHGOGS440xfZYMv+dggUyfYi++a6xw4SP4HS
 UdHuPTDape39Uf70a1w4b72pzUUAMHnjIiJYIx0lpmaK9T8nWZc9fWeMcvjSrQFHjRuFYQ
 /f5jx2Xtg3ZrrW+Rr0nsbTrtlUi7enc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-OLXnul61MtKfJ9w60vwC5A-1; Wed,
 24 Jul 2024 12:27:01 -0400
X-MC-Unique: OLXnul61MtKfJ9w60vwC5A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5F891955D56; Wed, 24 Jul 2024 16:26:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.141])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BA9519560AE; Wed, 24 Jul 2024 16:26:49 +0000 (UTC)
Date: Wed, 24 Jul 2024 17:26:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v4 01/17] meson: Add optional dependency on IGVM library
Message-ID: <ZqErRoSUknD26cbI@redhat.com>
References: <cover.1720004383.git.roy.hopkins@suse.com>
 <0f377bfb248db9d33cf8ec1758b231137b0de437.1720004383.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f377bfb248db9d33cf8ec1758b231137b0de437.1720004383.git.roy.hopkins@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 03, 2024 at 12:05:39PM +0100, Roy Hopkins wrote:
> The IGVM library allows Independent Guest Virtual Machine files to be
> parsed and processed. IGVM files are used to configure guest memory
> layout, initial processor state and other configuration pertaining to
> secure virtual machines.
> 
> This adds the --enable-igvm configure option, enabled by default, which
> attempts to locate and link against the IGVM library via pkgconfig and
> sets CONFIG_IGVM if found.
> 
> The library is added to the system_ss target in backends/meson.build
> where the IGVM parsing will be performed by the ConfidentialGuestSupport
> object.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> ---
>  meson.build                   | 8 ++++++++
>  backends/meson.build          | 3 +++
>  meson_options.txt             | 2 ++
>  scripts/meson-buildoptions.sh | 3 +++
>  4 files changed, 16 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index 54e6b09f4f..e2f7752636 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1276,6 +1276,12 @@ if host_os == 'linux' and (have_system or have_tools)
>                         method: 'pkg-config',
>                         required: get_option('libudev'))
>  endif
> +igvm = not_found
> +if not get_option('igvm').auto() or have_system
> +  igvm = dependency('igvm',
> +                       method: 'pkg-config',
> +                       required: get_option('igvm'))

nit-picking, the indentation for these 2 lines is out of
alginment with the first line.

We probably ought to add a min version number to the
check too. IIUC, to get the namespace pollution fixes
you did, we'll want >= 0.3.0 ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


