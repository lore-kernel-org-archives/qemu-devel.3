Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA54C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 09:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSCHv-0001FP-2m; Fri, 12 Jul 2024 05:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSCHm-0000ne-8r
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:09:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSCHj-0000dt-Sp
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720775384;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=I50DrznIePTUVYH+PHGL7ToEEJBraFOSccEufIAd9cY=;
 b=Leyvoxvoy+ufkd4i0Oue+yI0bSggI7aRGDSLVT0p0LYYZVh7AK8hpjtVADRQBvArRf/OKN
 fUG1Jv9PXoXRLGLW/1E/w3ZO4eON7BKNdpURJgNw5iZ1u1HWGHFsRRY0oKhzvfyuTQfv8b
 VvHoSU91TmU/Igsn/Fj7g/+cPFmSR2o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-mjR8V0Z-NVu4ZSG6eUPBhQ-1; Fri,
 12 Jul 2024 05:09:39 -0400
X-MC-Unique: mjR8V0Z-NVu4ZSG6eUPBhQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E24A719560A3; Fri, 12 Jul 2024 09:09:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDC5F1955F40; Fri, 12 Jul 2024 09:09:35 +0000 (UTC)
Date: Fri, 12 Jul 2024 10:09:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [RFC PATCH 5/8] tests_pytest: Implement fetch_asset() method for
 downloading assets
Message-ID: <ZpDyy6JAqhvPgx5M@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
 <20240711115546.40859-6-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240711115546.40859-6-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Thu, Jul 11, 2024 at 01:55:43PM +0200, Thomas Huth wrote:
> In the pytests, we cannot use the fetch_asset() function from Avocado
> anymore, so we have to provide our own implementation now instead.
> Thus add such a function based on the _download_with_cache() function
> from tests/vm/basevm.py for this purpose.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/pytest/qemu_pytest/__init__.py | 40 ++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/pytest/qemu_pytest/__init__.py b/tests/pytest/qemu_pytest/__init__.py
> index e3ed32e3de..73d80b3828 100644
> --- a/tests/pytest/qemu_pytest/__init__.py
> +++ b/tests/pytest/qemu_pytest/__init__.py
> @@ -11,6 +11,7 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
>  
> +import hashlib
>  import logging
>  import os
>  import shutil
> @@ -201,17 +202,34 @@ def setUp(self, bin_prefix):
>          self.assertIsNotNone(SOURCE_DIR,'PYTEST_SOURCE_ROOT must be set')
>          self.assertIsNotNone(self.qemu_bin, 'PYTEST_QEMU_BINARY must be set')
>  
> -    def fetch_asset(self, name,
> -                    asset_hash, algorithm=None,
> -                    locations=None, expire=None,
> -                    find_only=False, cancel_on_missing=True):
> -        return super().fetch_asset(name,
> -                        asset_hash=asset_hash,
> -                        algorithm=algorithm,
> -                        locations=locations,
> -                        expire=expire,
> -                        find_only=find_only,
> -                        cancel_on_missing=cancel_on_missing)
> +    def check_hash(self, file_name, expected_hash):
> +        if not expected_hash:
> +            return True
> +        if len(expected_hash) == 32:
> +            sum_prog = 'md5sum'
> +        elif len(expected_hash) == 40:
> +            sum_prog = 'sha1sum'
> +        elif len(expected_hash) == 64:
> +            sum_prog = 'sha256sum'
> +        elif len(expected_hash) == 128:
> +            sum_prog = 'sha512sum'
> +        else:
> +            raise Exception("unknown hash type")

Why shouldn't we just standardize on sha256 as we convert each test
to pytest ? sha512 is overkill, and md5/sha1 shouldn't really be used
anymore.

> +        checksum = subprocess.check_output([sum_prog, file_name]).split()[0]
> +        return expected_hash == checksum.decode("utf-8")
> +
> +    def fetch_asset(self, url, asset_hash):
> +        cache_dir = os.path.expanduser("~/.cache/qemu/download")
> +        if not os.path.exists(cache_dir):
> +            os.makedirs(cache_dir)
> +        fname = os.path.join(cache_dir,
> +                             hashlib.sha1(url.encode("utf-8")).hexdigest())
> +        if os.path.exists(fname) and self.check_hash(fname, asset_hash):
> +            return fname
> +        logging.debug("Downloading %s to %s...", url, fname)
> +        subprocess.check_call(["wget", "-c", url, "-O", fname + ".download"])
> +        os.rename(fname + ".download", fname)
> +        return fname

To avoid a dep on an external command that may not be installed,
I think we could replace wget with native python code:

 import urllib
 from shutil import copyfileobj
 
 with urllib.request.urlopen(url) as src:
    with open(fname + ".download", "w+") as dst
       copyfileobj(src, dst)


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


