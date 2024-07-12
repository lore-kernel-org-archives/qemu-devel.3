Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706E3C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 09:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSCMF-00029i-6H; Fri, 12 Jul 2024 05:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSCMC-00022M-2g
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:14:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSCMA-00020v-9L
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720775661;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=3U+YTOgMU5fTtkjBOA4OawcRFDc53MN5eIKwMi+KAA0=;
 b=MPJKMmSfmyGmlJQg6tk6cvclzcmQjmAI/oUvKLamNvn0iXyRgIyx07UayCkZ5RfLMUzzVk
 xDVvuQn2BunLzf0Dzpw+kj9H9730cSJ8b+Ge6jHUy5qDm5q8+bpxSzPO7EqfzAfafzaSvj
 ia9ZQ/dV75jz4wv1WuzP3+YsZmM+iLY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-ZB_hlUuCPbSI8tl7UV4TIw-1; Fri,
 12 Jul 2024 05:14:12 -0400
X-MC-Unique: ZB_hlUuCPbSI8tl7UV4TIw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 172001954B33; Fri, 12 Jul 2024 09:14:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC0E51955F40; Fri, 12 Jul 2024 09:14:07 +0000 (UTC)
Date: Fri, 12 Jul 2024 10:14:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [RFC PATCH 7/8] tests/pytest: Add a function for extracting
 files from an archive
Message-ID: <ZpDz20mo-OWVOjI3@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
 <20240711115546.40859-8-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240711115546.40859-8-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

On Thu, Jul 11, 2024 at 01:55:45PM +0200, Thomas Huth wrote:
> Some Avocado-based tests use the "archive" module from avocado.utils
> to extract files from an archive. To be able to use these tests
> without Avocado, we have to provide our own function for extracting
> files. Fortunately, there is already the tarfile module that will
> provide us with this functionality, so let's just add a nice wrapper
> function around that.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/pytest/qemu_pytest/utils.py | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 tests/pytest/qemu_pytest/utils.py
> 
> diff --git a/tests/pytest/qemu_pytest/utils.py b/tests/pytest/qemu_pytest/utils.py
> new file mode 100644
> index 0000000000..4eb5e5d5e5
> --- /dev/null
> +++ b/tests/pytest/qemu_pytest/utils.py
> @@ -0,0 +1,21 @@
> +# Utilities for python-based QEMU tests
> +#
> +# Copyright 2024 Red Hat, Inc.
> +#
> +# Authors:
> +#  Thomas Huth <thuth@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import tarfile
> +
> +def archive_extract(archive, dest_dir, member=None):
> +    with tarfile.open(archive) as tf:
> +        if hasattr(tarfile, 'data_filter'):

Not convinced this is still needed. The python docs don't say anything
about 'data_filter' being introduced after 3.0, so can likely
assume it always exists.

> +            tf.extraction_filter = getattr(tarfile, 'data_filter',
> +                                           (lambda member, path: member))
> +        if member:
> +            tf.extract(member=member, path=dest_dir)
> +        else:
> +            tf.extractall(path=dest_dir)
> -- 
> 2.45.2
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


