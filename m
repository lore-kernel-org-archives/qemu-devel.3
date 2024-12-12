Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C9BE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfry-0004Qx-82; Thu, 12 Dec 2024 04:52:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLfrt-0004QR-2Z
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:52:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLfrp-0004qG-Pa
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733997140;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NeGVnfVvBktK8UrbrPxZ5tgFpTAgvCNUa2rE3x77BOE=;
 b=EigJ9yuv87pa6o6gdn54+McNE3fhcSgXowEvEyOb3OjTjOLxNkeUWL+svm3/ZxM/F+f1lz
 StfwjDoUiNGGBa4iKGZEfANDZ7gZLpEyIlm1RAcVKZoDSViPVPTwg4XfZXO2ldcqLjQ5Ac
 HVxRtu/R4sEvJ9vTVNxDSt9/L8zDzu4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-o3FHBmomNXmqrWval35ebg-1; Thu,
 12 Dec 2024 04:52:14 -0500
X-MC-Unique: o3FHBmomNXmqrWval35ebg-1
X-Mimecast-MFC-AGG-ID: o3FHBmomNXmqrWval35ebg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5666319560B3; Thu, 12 Dec 2024 09:52:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4669730044C1; Thu, 12 Dec 2024 09:52:11 +0000 (UTC)
Date: Thu, 12 Dec 2024 09:52:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
Subject: Re: [PATCH v2 11/31] tests/functional: switch over to using
 self.build_file(...)
Message-ID: <Z1qyRxVfFutj8Qv8@redhat.com>
References: <20241211172648.2893097-1-berrange@redhat.com>
 <20241211172648.2893097-12-berrange@redhat.com>
 <5b8795ee-910e-4b1d-b185-8f76fcdd9502@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b8795ee-910e-4b1d-b185-8f76fcdd9502@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Dec 12, 2024 at 10:42:49AM +0100, Thomas Huth wrote:
> On 11/12/2024 18.26, Daniel P. Berrangé wrote:
> > This removes direct access of the 'BUILD_DIR' variable.
> > 
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> ...
> > diff --git a/tests/functional/test_virtio_gpu.py b/tests/functional/test_virtio_gpu.py
> > index 7654421e6b..630569bff8 100755
> > --- a/tests/functional/test_virtio_gpu.py
> > +++ b/tests/functional/test_virtio_gpu.py
> > @@ -6,7 +6,6 @@
> >   # later.  See the COPYING file in the top-level directory.
> > -from qemu_test import BUILD_DIR
> >   from qemu_test import QemuSystemTest, Asset
> >   from qemu_test import wait_for_console_pattern
> >   from qemu_test import exec_command_and_wait_for_pattern
> > @@ -18,12 +17,8 @@
> >   import subprocess
> > -def pick_default_vug_bin():
> > -    relative_path = "./contrib/vhost-user-gpu/vhost-user-gpu"
> > -    if is_readable_executable_file(relative_path):
> > -        return relative_path
> > -
> > -    bld_dir_path = os.path.join(BUILD_DIR, relative_path)
> > +def pick_default_vug_bin(test):
> > +    bld_dir_path = test.build_file(relative_path)
> >       if is_readable_executable_file(bld_dir_path):
> >           return bld_dir_path
> 
> FYI, while testing, I noticed that this is failing now:
> 
> Traceback (most recent call last):
>   File ".../tests/functional/test_virtio_gpu.py", line 84, in test_vhost_user_vga_virgl
>     vug = pick_default_vug_bin(self)
>           ^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File ".../tests/functional/test_virtio_gpu.py", line 21, in pick_default_vug_bin
>     bld_dir_path = test.build_file(relative_path)
>                                    ^^^^^^^^^^^^^
> NameError: name 'relative_path' is not defined

I'll add the following

-    bld_dir_path = test.build_file(relative_path)
+    bld_dir_path = test.build_file("contrib", "vhost-user-gpu", "vhost-user-gpu")

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


