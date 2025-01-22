Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB680C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 10:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taXjX-0005YZ-3o; Wed, 22 Jan 2025 05:13:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1taXjV-0005Y2-HW
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 05:13:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1taXjQ-0006ym-3p
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 05:13:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737540786;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CvBz052lKFryl9VhwOkYQzU88m8A44mTqzKI5WsUFbU=;
 b=dQVoY9BA7Srd4jM4XliR+L/izPIthB73YjVWKrHNzo280OnPnObUxVwEx5KBHKa3JINOOY
 SamC2KvL6fp1eFTkeoyIP4Bdiz9HzJ2nSfCTTPb3N5jn9mdLzR2g0D8tRJgbH+l/imDIxF
 pfgtD7iDvZgYRE5F5o2nBoXuDiVUFKM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-Xg9qVpKZNhKRfM9vZSdwAQ-1; Wed,
 22 Jan 2025 05:13:02 -0500
X-MC-Unique: Xg9qVpKZNhKRfM9vZSdwAQ-1
X-Mimecast-MFC-AGG-ID: Xg9qVpKZNhKRfM9vZSdwAQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83EF61956054; Wed, 22 Jan 2025 10:13:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.43])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A703195608E; Wed, 22 Jan 2025 10:12:58 +0000 (UTC)
Date: Wed, 22 Jan 2025 10:12:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] tests/functional: Fix broken decorators with lamda
 functions
Message-ID: <Z5DEp_Yq0LlrocnP@redhat.com>
References: <20250121065814.1092720-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250121065814.1092720-1-thuth@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Jan 21, 2025 at 07:58:14AM +0100, Thomas Huth wrote:
> The decorators that use a lambda function are currently broken
> and do not properly skip the test if the condition is not met.
> Using "return skipUnless(lambda: ...)" does not work as expected.
> To fix it, rewrite the decorators without lambda, it's simpler
> that way anyway.

Urgh, I clearly failed to re-test this properly. Originally
I wasn't using skipUnless as a helper, but had implemented
something that looked pretty much like skipUnless and then
refactored it :-(

> 
> skipIfMissingImports also needs to exec() the import statement,
> otherwise we always try to import a module called "impname" which
> does not exist.

Worth doing this as a separate commit.

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  I've noticed the problem while trying to get the migration test
>  through the CI:
>  https://gitlab.com/thuth/qemu/-/jobs/8901960783#L100
>  ... the OpenSUSE containers apparently lack the "nc" binary ...
> 
>  tests/functional/qemu_test/decorators.py | 44 +++++++++++-------------
>  1 file changed, 21 insertions(+), 23 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
> index df088bc090..7750af7b7d 100644
> --- a/tests/functional/qemu_test/decorators.py
> +++ b/tests/functional/qemu_test/decorators.py
> @@ -16,15 +16,14 @@
>    @skipIfMissingCommands("mkisofs", "losetup")
>  '''
>  def skipIfMissingCommands(*args):
> -    def has_cmds(cmdlist):
> -        for cmd in cmdlist:
> -            if not which(cmd):
> -                return False
> -        return True
> -
> -    return skipUnless(lambda: has_cmds(args),
> -                      'required command(s) "%s" not installed' %
> -                      ", ".join(args))
> +    has_cmds = True
> +    for cmd in args:
> +         if not which(cmd):
> +             has_cmds = False
> +             break
> +
> +    return skipUnless(has_cmds, 'required command(s) "%s" not installed' %
> +                                ", ".join(args))
>  
>  '''
>  Decorator to skip execution of a test if the current
> @@ -35,9 +34,9 @@ def has_cmds(cmdlist):
>    @skipIfNotMachine("x86_64", "aarch64")
>  '''
>  def skipIfNotMachine(*args):
> -    return skipUnless(lambda: platform.machine() in args,
> -                        'not running on one of the required machine(s) "%s"' %
> -                        ", ".join(args))
> +    return skipUnless(platform.machine() in args,
> +                      'not running on one of the required machine(s) "%s"' %
> +                      ", ".join(args))
>  
>  '''
>  Decorator to skip execution of flaky tests, unless
> @@ -94,14 +93,13 @@ def skipBigDataTest():
>    @skipIfMissingImports("numpy", "cv2")
>  '''
>  def skipIfMissingImports(*args):
> -    def has_imports(importlist):
> -        for impname in importlist:
> -            try:
> -                import impname
> -            except ImportError:
> -                return False
> -        return True
> -
> -    return skipUnless(lambda: has_imports(args),
> -                      'required import(s) "%s" not installed' %
> -                      ", ".join(args))
> +    has_imports = True
> +    for impname in args:
> +        try:
> +            exec('import %s' % impname)

I feel like the recommended approach would probably be to use

  importlib.import_module(impname)

> +        except ImportError:
> +            has_imports = False
> +            break
> +
> +    return skipUnless(has_imports, 'required import(s) "%s" not installed' %
> +                                   ", ".join(args))

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


