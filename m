Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C62C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 08:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSC0V-0003W6-Cq; Fri, 12 Jul 2024 04:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSC0S-0003JG-3E
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSC0Q-0003gm-6V
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720774313;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LApJBlvn0rPCmpk8/Q8YINFGlr/LoqSPBKHF7y7oNj0=;
 b=Lehv5BahQIe6kusUXVlQs47hZEjav1q+VpyPisjWuS4KA3Iv+POnXj7bLMBna5cA8n07f8
 ibAh7qGMZZAWcFH1MBMvNbUQpuUJrV5UvpaXXbXnS8cOuz3gDQB8mv7eXVCpuNRRyStjVv
 ZO3XxHUkKGaNlcUMWQLV68xuHUSXrK8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-UP8UnPHSMuiBw6pLK2ZHOA-1; Fri,
 12 Jul 2024 04:51:49 -0400
X-MC-Unique: UP8UnPHSMuiBw6pLK2ZHOA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE4EA19560A3; Fri, 12 Jul 2024 08:51:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57F5B1955E85; Fri, 12 Jul 2024 08:51:45 +0000 (UTC)
Date: Fri, 12 Jul 2024 09:51:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [RFC PATCH 2/8] tests/pytest: Convert some simple avocado tests
 into pytests
Message-ID: <ZpDunfVt_QcmUXCu@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
 <20240711115546.40859-3-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240711115546.40859-3-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Thu, Jul 11, 2024 at 01:55:40PM +0200, Thomas Huth wrote:
> These test are rather simple and don't need any modifications apart
> from adjusting the "from avocado_qemu" line. These tests can now
> be run directly via "pytest" by setting the PYTHONPATH environment
> variable to the python folder of QEMU and by providing the QEMU
> binary via the PYTEST_QEMU_BINARY environment variable, and the source
> and build directories via the PYTEST_SOURCE_ROOTand PYTEST_BUILD_ROOT
> environment variables.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/{avocado/cpu_queries.py => pytest/test_cpu_queries.py}   | 2 +-
>  .../empty_cpu_model.py => pytest/test_empty_cpu_model.py}      | 2 +-
>  .../mem-addr-space-check.py => pytest/test_mem_addr_space.py}  | 3 +--
>  .../virtio_version.py => pytest/test_virtio_version.py}        | 2 +-
>  4 files changed, 4 insertions(+), 5 deletions(-)
>  rename tests/{avocado/cpu_queries.py => pytest/test_cpu_queries.py} (96%)
>  rename tests/{avocado/empty_cpu_model.py => pytest/test_empty_cpu_model.py} (94%)
>  rename tests/{avocado/mem-addr-space-check.py => pytest/test_mem_addr_space.py} (99%)
>  rename tests/{avocado/virtio_version.py => pytest/test_virtio_version.py} (99%)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

though if you take my suggestion in the previous patch, then this
patch should 'chmod +x' all the test files, and add the __main__
magic to call 'unittest.main().

> 
> diff --git a/tests/avocado/cpu_queries.py b/tests/pytest/test_cpu_queries.py
> similarity index 96%
> rename from tests/avocado/cpu_queries.py
> rename to tests/pytest/test_cpu_queries.py
> index d3faa14720..b300447121 100644
> --- a/tests/avocado/cpu_queries.py
> +++ b/tests/pytest/test_cpu_queries.py
> @@ -8,7 +8,7 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
>  
> -from avocado_qemu import QemuSystemTest
> +from qemu_pytest import QemuSystemTest
>  
>  class QueryCPUModelExpansion(QemuSystemTest):
>      """
> diff --git a/tests/avocado/empty_cpu_model.py b/tests/pytest/test_empty_cpu_model.py
> similarity index 94%
> rename from tests/avocado/empty_cpu_model.py
> rename to tests/pytest/test_empty_cpu_model.py
> index d906ef3d3c..113740bc82 100644
> --- a/tests/avocado/empty_cpu_model.py
> +++ b/tests/pytest/test_empty_cpu_model.py
> @@ -7,7 +7,7 @@
>  #
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
> -from avocado_qemu import QemuSystemTest
> +from qemu_pytest import QemuSystemTest
>  
>  class EmptyCPUModel(QemuSystemTest):
>      def test(self):
> diff --git a/tests/avocado/mem-addr-space-check.py b/tests/pytest/test_mem_addr_space.py
> similarity index 99%
> rename from tests/avocado/mem-addr-space-check.py
> rename to tests/pytest/test_mem_addr_space.py
> index 85541ea051..6ae7ba5e6b 100644
> --- a/tests/avocado/mem-addr-space-check.py
> +++ b/tests/pytest/test_mem_addr_space.py
> @@ -8,8 +8,7 @@
>  #
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  
> -from avocado_qemu import QemuSystemTest
> -import signal
> +from qemu_pytest import QemuSystemTest
>  import time
>  
>  class MemAddrCheck(QemuSystemTest):
> diff --git a/tests/avocado/virtio_version.py b/tests/pytest/test_virtio_version.py
> similarity index 99%
> rename from tests/avocado/virtio_version.py
> rename to tests/pytest/test_virtio_version.py
> index afe5e828b5..ca3aa806df 100644
> --- a/tests/avocado/virtio_version.py
> +++ b/tests/pytest/test_virtio_version.py
> @@ -12,7 +12,7 @@
>  import os
>  
>  from qemu.machine import QEMUMachine
> -from avocado_qemu import QemuSystemTest
> +from qemu_pytest import QemuSystemTest
>  
>  # Virtio Device IDs:
>  VIRTIO_NET = 1
> -- 
> 2.45.2
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


