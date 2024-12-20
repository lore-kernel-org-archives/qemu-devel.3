Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CE1E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaPc-0007cX-57; Fri, 20 Dec 2024 05:39:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tOaPZ-0007c4-RF
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 05:39:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tOaPW-0003sS-5g
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 05:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734691148;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=mWZSyVjU07Lxs1TFL5AklqoyPv0NF+9AT9YKbahr3H4=;
 b=KsTyk2CGwRJE843zYPDnTr4pacMdtLK+529FX9MlKJedFH8AOCzbhv+6xcaaSoXrsW08nH
 QTZjhxhak83Mo240BzadPOhQjMLX3CcQc5/ILfMwDeNbQ/LKf7TxJi7qBxr+HyUxEmJ01R
 DdHKktA0zSu8AUYtdVVkRejGgrXB6jA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-4Hyf9YU2NiyGPTASQNeKjQ-1; Fri,
 20 Dec 2024 05:39:04 -0500
X-MC-Unique: 4Hyf9YU2NiyGPTASQNeKjQ-1
X-Mimecast-MFC-AGG-ID: 4Hyf9YU2NiyGPTASQNeKjQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4231719560B8; Fri, 20 Dec 2024 10:39:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.4])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D40D1956096; Fri, 20 Dec 2024 10:39:00 +0000 (UTC)
Date: Fri, 20 Dec 2024 10:38:56 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-ppc@nongnu.org
Subject: Re: [PATCH 1/4] tests/functional: Don't fail the whole test if a
 pre-cache fetch fails
Message-ID: <Z2VJQJTjmzlgT2uU@redhat.com>
References: <20241220024617.1968556-1-npiggin@gmail.com>
 <20241220024617.1968556-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241220024617.1968556-2-npiggin@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On Fri, Dec 20, 2024 at 12:46:14PM +1000, Nicholas Piggin wrote:
> If any pre-cache downloads fail, the entire functional test run
> is failed.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  tests/functional/qemu_test/asset.py | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> index f126cd5863a..f82b07e7027 100644
> --- a/tests/functional/qemu_test/asset.py
> +++ b/tests/functional/qemu_test/asset.py
> @@ -102,7 +102,8 @@ def fetch(self):
>              return str(self.cache_file)
>  
>          if os.environ.get("QEMU_TEST_NO_DOWNLOAD", False):
> -            raise Exception("Asset cache is invalid and downloads disabled")
> +            raise Exception("Failed to fetch asset %s, not found in cache "
> +                            "and downloads are disabled", self.url)
>  
>          self.log.info("Downloading %s to %s...", self.url, self.cache_file)
>          tmp_cache_file = self.cache_file.with_suffix(".download")
> @@ -162,7 +163,13 @@ def precache_test(test):
>          for name, asset in vars(test.__class__).items():
>              if name.startswith("ASSET_") and type(asset) == Asset:
>                  log.info("Attempting to cache '%s'" % asset)
> -                asset.fetch()
> +                try:
> +                    asset.fetch()
> +                except:
> +                    # Asset pre-cache should not be fatal. An error is printed
> +                    # and the test itself will fail if it is unable to get the
> +                    # assert.
> +                    pass
>          log.removeHandler(handler)
>  
>      def precache_suite(suite):

Asset fetching errors & skipping tests is being handled by a pending
pull request:

  https://lists.nongnu.org/archive/html/qemu-devel/2024-12/msg04334.html
  https://lists.nongnu.org/archive/html/qemu-devel/2024-12/msg04333.html

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


