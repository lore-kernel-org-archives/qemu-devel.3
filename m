Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25FEC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 08:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsHEO-0006Ma-GU; Wed, 12 Mar 2025 04:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tsHE4-0006Gb-Fn
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 04:14:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tsHE2-0003Vi-Ll
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 04:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741767239;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=6Nari1HuJU+2sPS8UHcK4mg/fk4y9Yl9L19qUWlWm6E=;
 b=U0ZXRvxxISE8GTfzjQHt6pJWVlKuPFI9OrW/d5GBgjghBKjCnGObiWV/AT7zWdhwxeG6iV
 Rc/Av2plgv5k7pTFTbuff4ibk6Awc2dOoPLdKqkO4b+Ac9UA9HqSPD7l//+4udWAAIOEe5
 E5MNOkcmkmmv4neJBtrf+Ot14noRTs4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-kC6yqtRuOkiCkxbWick0yA-1; Wed,
 12 Mar 2025 04:13:54 -0400
X-MC-Unique: kC6yqtRuOkiCkxbWick0yA-1
X-Mimecast-MFC-AGG-ID: kC6yqtRuOkiCkxbWick0yA_1741767233
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74950180025B; Wed, 12 Mar 2025 08:13:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.57])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C84EB18001F6; Wed, 12 Mar 2025 08:13:51 +0000 (UTC)
Date: Wed, 12 Mar 2025 08:13:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/3] tests/functional/asset: Fail assert fetch when
 retries are exceeded
Message-ID: <Z9FCPL2iucV3KsyG@redhat.com>
References: <20250312051739.938441-1-npiggin@gmail.com>
 <20250312051739.938441-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250312051739.938441-2-npiggin@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Mar 12, 2025 at 03:17:36PM +1000, Nicholas Piggin wrote:
> Currently the fetch code does not fail gracefully when retry limit is
> exceeded, it just falls through the loop with no file, which ends up
> hitting other errors.
> 
> In preparation for adding more cases where a download gets retried,
> add an explicit check for retry limit exceeded.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  tests/functional/qemu_test/asset.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> index f0730695f09..6a1c92ffbef 100644
> --- a/tests/functional/qemu_test/asset.py
> +++ b/tests/functional/qemu_test/asset.py
> @@ -116,7 +116,10 @@ def fetch(self):
>          self.log.info("Downloading %s to %s...", self.url, self.cache_file)
>          tmp_cache_file = self.cache_file.with_suffix(".download")
>  
> -        for retries in range(3):
> +        for retries in range(4):
> +            if retries == 3:
> +                raise Exception("Retries exceeded downloading %s", self.url)

While it works, it feels a bit wierd to me. Given the error retry
scenario will unlink the file, I think it would be better todo

   if not os.path.exists(tmp_cache_file)
      raise Exception(...)

immediately after the for() loop

> +
>              try:
>                  with tmp_cache_file.open("xb") as dst:
>                      with urllib.request.urlopen(self.url) as resp:
> -- 
> 2.47.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


