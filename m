Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F16C71135
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 10:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjbxF-0003Fm-3Y; Thu, 29 Aug 2024 06:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjbxB-000355-OL
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 06:00:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjbx7-0000YP-Mh
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 06:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724925628;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uWTxyJhkZz/CLmC7vpG/JENXwbmrm/SYov1F8ko9X38=;
 b=VNWC2BKPT0sPgWws32b7ylsGM90gPJ2mY6hCEvUmxYVFlSScI8jBiPeLm4rw4V5UdFFmia
 j9Xiop6NCe8FSzJ4nkx8sfrwV2IzMhkTIF9Sai/+ZSFiTrPEdS2LEJnd6VpNXjgMseiqC0
 7RWNG5weSJXQv0l68NZ0ZoIJB0Y7YhM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-IOyR5jCqPSCbMKSkuiG3Yw-1; Thu,
 29 Aug 2024 06:00:25 -0400
X-MC-Unique: IOyR5jCqPSCbMKSkuiG3Yw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAFEE1955F40; Thu, 29 Aug 2024 10:00:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.64])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D7BF19560A3; Thu, 29 Aug 2024 10:00:21 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:00:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v4 14/35] tests/functional: add a module for handling
 asset download & caching
Message-ID: <ZtBGslpB8gqYFpzT@redhat.com>
References: <20240821082748.65853-1-thuth@redhat.com>
 <20240821082748.65853-15-thuth@redhat.com>
 <776a3b71-2495-40dd-a813-55000f997c2f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <776a3b71-2495-40dd-a813-55000f997c2f@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 23, 2024 at 08:24:45AM +0200, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 21/8/24 10:27, Thomas Huth wrote:
> > From: Daniel P. Berrangé <berrange@redhat.com>
> > 
> > The 'Asset' class is a simple module that declares a downloadable
> > asset that can be cached locally. Downloads are stored in the user's
> > home dir at ~/.cache/qemu/download, using a sha256 sum of the URL.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > [thuth: Drop sha1 support, use hash on file content for naming instead of URL,
> >          add the possibility to specify the cache dir via environment variable]
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   tests/functional/qemu_test/__init__.py |  1 +
> >   tests/functional/qemu_test/asset.py    | 97 ++++++++++++++++++++++++++
> >   2 files changed, 98 insertions(+)
> >   create mode 100644 tests/functional/qemu_test/asset.py
> 
> 
> > +    def fetch(self):
> > +        if not self.cache_dir.exists():
> > +            self.cache_dir.mkdir(parents=True, exist_ok=True)
> > +
> > +        if self.valid():
> > +            self.log.debug("Using cached asset %s for %s",
> > +                           self.cache_file, self.url)
> > +            return str(self.cache_file)
> > +
> > +        self.log.info("Downloading %s to %s...", self.url, self.cache_file)
> > +        tmp_cache_file = self.cache_file.with_suffix(".download")
> > +
> > +        try:
> > +            resp = urllib.request.urlopen(self.url)
> > +        except Exception as e:
> > +            self.log.error("Unable to download %s: %s", self.url, e)
> > +            raise
> > +
> > +        try:
> > +            with tmp_cache_file.open("wb+") as dst:
> > +                copyfileobj(resp, dst)
> > +        except:
> > +            tmp_cache_file.unlink()
> > +            raise
> > +        try:
> > +            # Set these just for informational purposes
> > +            os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
> > +                        self.url.encode('utf8'))
> > +            os.setxattr(str(tmp_cache_file), "user.qemu-asset-hash",
> > +                        self.hash.encode('utf8'))
> > +        except Exception as e:
> > +            self.log.info("Unable to set xattr on %s: %s", tmp_cache_file, e)
> 
> This line is annoying on macOS as it is logged for each file downloaded.
> Is it really useful? Can we demote to DEBUG level or log it just once,
> given all tmp_cache_files will always be on the same cache_dir thus
> filesystem?

Yeah, DEBUG would be fine.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


