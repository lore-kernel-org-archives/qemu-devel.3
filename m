Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C03AC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTmkr-0005tL-Gh; Tue, 16 Jul 2024 14:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sTmkb-0005EU-0p
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:18:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sTmkY-0002fr-CF
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721153885;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Rp+Q/k4E8xVOVrrj97OL8nULCD643ypzWapLarWEofw=;
 b=SItdtyRxVL34ZQUADqeBLoa8leR062PSpuq98HnAaWJnAOnpKvVwyRMz1AzvT+URUk8MWO
 dgwbo1KBD0eu7VOxn6VWxWpnKqF+updAlP2MV19mzRLHL/dgUkW1MPKvniUJkDQvJZoCNh
 cXqUpZyEbh3GrKJRha1bfYxTjKWEm5c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-TuqeoaGONsCoSoWfEdWH6w-1; Tue,
 16 Jul 2024 14:18:03 -0400
X-MC-Unique: TuqeoaGONsCoSoWfEdWH6w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 494B11955BF6; Tue, 16 Jul 2024 18:18:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9537919560B2; Tue, 16 Jul 2024 18:17:58 +0000 (UTC)
Date: Tue, 16 Jul 2024 19:17:54 +0100
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
Subject: Re: [PATCH 05/11] tests/functional: Implement fetch_asset() method
 for downloading assets
Message-ID: <Zpa5Un6oAdVstI-r@redhat.com>
References: <20240716112614.1755692-1-thuth@redhat.com>
 <20240716112614.1755692-6-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240716112614.1755692-6-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Tue, Jul 16, 2024 at 01:26:08PM +0200, Thomas Huth wrote:
> In the new python test framework, we cannot use the fetch_asset()
> function from Avocado anymore, so we have to provide our own
> implementation now instead. Thus add such a function based on the
> urllib python module for this purpose.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/qemu_test/__init__.py | 36 ++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
> index e73705d40a..77c3b14d34 100644
> --- a/tests/functional/qemu_test/__init__.py
> +++ b/tests/functional/qemu_test/__init__.py
> @@ -11,6 +11,8 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
>  
> +import hashlib
> +import urllib.request
>  import logging
>  import os
>  import pycotap
> @@ -23,6 +25,7 @@
>  import unittest
>  
>  from pathlib import Path
> +from shutil import copyfileobj
>  from qemu.machine import QEMUMachine
>  from qemu.utils import (get_info_usernet_hostfwd_port, kvm_available,
>                          tcg_available)
> @@ -215,6 +218,39 @@ def setUp(self, bin_prefix):
>          if not os.path.exists(self.workdir):
>              os.makedirs(self.workdir)
>  
> +    def check_hash(self, file_name, expected_hash):
> +        if not expected_hash:
> +            return True
> +        if len(expected_hash) == 40:
> +            sum_prog = 'sha1sum'
> +        elif len(expected_hash) == 64:
> +            sum_prog = 'sha256sum'
> +        elif len(expected_hash) == 128:
> +            sum_prog = 'sha512sum'
> +        else:
> +            raise Exception("unknown hash type")
> +        checksum = subprocess.check_output([sum_prog, file_name]).split()[0]
> +        return expected_hash == checksum.decode("utf-8")
> +
> +    def fetch_asset(self, url, asset_hash):
> +        cache_dir = os.path.expanduser("~/.cache/qemu/download")
> +        if not os.path.exists(cache_dir):
> +            os.makedirs(cache_dir)
> +        fname = os.path.join(cache_dir,
> +                             hashlib.sha256(url.encode("utf-8")).hexdigest())
> +        if os.path.exists(fname) and self.check_hash(fname, asset_hash):
> +            return fname
> +        self.log.info("Downloading %s to %s...", url, fname)
> +        dl_fname = fname + ".download"
> +        with urllib.request.urlopen(url) as src:
> +            with open(dl_fname, "wb+") as dst:
> +                copyfileobj(src, dst)

For cleanliness we should probably wrap this and delete the file on
error, eg

   try:
     with open(dl_fname,....) as dst
        ....
   except:
     os.remove(dl_fname)
     raise

> +        if not self.check_hash(dl_fname, asset_hash):
> +            os.remove(dl_fname)
> +            raise Exception("Hash of " + url + " does not match")
> +        os.rename(dl_fname, fname)
> +        return fname
> +
>      def main():
>          tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
>                                     test_output_log = pycotap.LogMode.LogToError)
> -- 
> 2.45.2
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


