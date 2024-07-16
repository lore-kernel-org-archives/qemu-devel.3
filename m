Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34338C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTmhF-0005YC-B5; Tue, 16 Jul 2024 14:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sTmhC-0005OX-Q3
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:14:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sTmhA-0001oC-TR
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721153675;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1pxPUUVlyO/F2kA7QwaBt+rhc796HdyQ2Ti9YUwoThg=;
 b=JSWRcEKbze+zFqDn5cpyG/DRNAwvIAg0kt0idTqOekyVopns+ryyQVDYtN5hsvFz4WyNVO
 cGcEByoMLAhXaui+whL2y7fry4PEEBXQRSMdchY6KjWzsSnZXTEPWlpVZ0L4ZRMA7C0ziN
 0TiqOBPr0PIhdadkAf6mASf9tcmw9k0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-ZHvK4rIcO6-nzxHXCLRgnA-1; Tue,
 16 Jul 2024 14:14:30 -0400
X-MC-Unique: ZHvK4rIcO6-nzxHXCLRgnA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A0301955D4E; Tue, 16 Jul 2024 18:14:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C0B93000183; Tue, 16 Jul 2024 18:14:23 +0000 (UTC)
Date: Tue, 16 Jul 2024 19:14:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 02/11] tests/functional: Convert simple avocado tests
 into standalone python tests
Message-ID: <Zpa4fEpq3lsjoSqa@redhat.com>
References: <20240716112614.1755692-1-thuth@redhat.com>
 <20240716112614.1755692-3-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716112614.1755692-3-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jul 16, 2024 at 01:26:05PM +0200, Thomas Huth wrote:
> These test are rather simple and don't need any modifications apart
> from adjusting the "from avocado_qemu" line. To ease debugging, make
> the files executable and add a shebang line and Python '__main__'
> handling, too, so that these tests can now be run by executing them
> directly.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .../test_cpu_queries.py}                      |  7 ++-
>  .../test_empty_cpu_model.py}                  |  7 ++-
>  .../test_mem_addr_space.py}                   | 53 +++----------------
>  .../test_pc_cpu_hotplug_props.py}             | 11 ++--
>  .../test_virtio_version.py}                   |  8 +--
>  5 files changed, 29 insertions(+), 57 deletions(-)
>  rename tests/{avocado/cpu_queries.py => functional/test_cpu_queries.py} (89%)
>  mode change 100644 => 100755
>  rename tests/{avocado/empty_cpu_model.py => functional/test_empty_cpu_model.py} (84%)
>  mode change 100644 => 100755
>  rename tests/{avocado/mem-addr-space-check.py => functional/test_mem_addr_space.py} (92%)
>  mode change 100644 => 100755
>  rename tests/{avocado/pc_cpu_hotplug_props.py => functional/test_pc_cpu_hotplug_props.py} (90%)
>  mode change 100644 => 100755
>  rename tests/{avocado/virtio_version.py => functional/test_virtio_version.py} (98%)
>  mode change 100644 => 100755
> 

> diff --git a/tests/avocado/mem-addr-space-check.py b/tests/functional/test_mem_addr_space.py
> old mode 100644
> new mode 100755
> similarity index 92%
> rename from tests/avocado/mem-addr-space-check.py
> rename to tests/functional/test_mem_addr_space.py
> index 85541ea051..bb0cf062ca
> --- a/tests/avocado/mem-addr-space-check.py
> +++ b/tests/functional/test_mem_addr_space.py
> @@ -1,3 +1,5 @@
> +#!/usr/bin/env python3
> +#
>  # Check for crash when using memory beyond the available guest processor
>  # address space.
>  #
> @@ -8,8 +10,7 @@
>  #
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  
> -from avocado_qemu import QemuSystemTest
> -import signal

Nit-pick - cleanup of an unrelated existing bug - 'signal' wasn't
used. Suggest doing it in a separate patch

Aside from that:

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


