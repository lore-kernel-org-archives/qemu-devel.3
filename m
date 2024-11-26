Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CACD6554A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 18:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG0Mw-00008V-4p; Tue, 26 Nov 2024 13:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tG0MV-0008Sj-Qw
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 13:32:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tG0MT-0004QW-HL
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 13:32:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732645951;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4nTIIQ4QgtVSmsqfe8mjdg8vSR6mYJGAtfAp0+KD9wI=;
 b=UFNA8ki1J9btwjhQvxynTZVkS782kURj4Si4ebigZjSO7qQxWoX+bP+ASmpk52g03ZzDgm
 p3ilrtFie+wihD1HWVnelgxGrwXkpUEd4unttFoDJ4gF2gIF7qc++oUUAflNmZx0GxiNPz
 DSYsrzY4OZWv0H03rZPU0lqhHJ0Eu0Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-VU2xrrN3NUa2QvMH5KHkvg-1; Tue,
 26 Nov 2024 13:32:27 -0500
X-MC-Unique: VU2xrrN3NUa2QvMH5KHkvg-1
X-Mimecast-MFC-AGG-ID: VU2xrrN3NUa2QvMH5KHkvg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D5A11956064; Tue, 26 Nov 2024 18:32:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.147])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DB071955F43; Tue, 26 Nov 2024 18:32:21 +0000 (UTC)
Date: Tue, 26 Nov 2024 18:32:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dmitry Frolov <frolov@swemel.ru>
Cc: farosas@suse.de, lvivier@redhat.com, sdl.qemu@linuxtesting.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/qtest: add TIMEOUT_MULTIPLIER
Message-ID: <Z0YUMoPr0oyQhqqK@redhat.com>
References: <20241113094342.282676-2-frolov@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113094342.282676-2-frolov@swemel.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
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

On Wed, Nov 13, 2024 at 12:43:40PM +0300, Dmitry Frolov wrote:
> Some tests need more time when qemu is built with
> "--enable-asan --enable-ubsan"
> 
> As was discussed here:
> https://patchew.org/QEMU/20241112120100.176492-2-frolov@swemel.r/u
> 
> TIMEOUT_MULTIPLIER enviroment variable will be
> a useful option, allowing non-invasive timeouts
> increasing for a specific build.
> 
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> ---
>  scripts/mtest2make.py | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
> index eb01a05ddb..ff60b62724 100644
> --- a/scripts/mtest2make.py
> +++ b/scripts/mtest2make.py
> @@ -27,7 +27,9 @@ def names(self, base):
>  .speed.slow = $(foreach s,$(sort $(filter-out %-thorough, $1)), --suite $s)
>  .speed.thorough = $(foreach s,$(sort $1), --suite $s)
>  
> +ifndef TIMEOUT_MULTIPLIER
>  TIMEOUT_MULTIPLIER = 1
> +endif

Can you explain what scenario this is needed for, as unless I'm
missing something this change has no purpose. This assignment is
merely defining the defalt value, which can already be overridden
at runtime without this 'ifndef'

eg

$ make check-unit TIMEOUT_MULTIPLIER=7

In another shell:

$ ps -axuwwf | grep 'meson test'
berrange 1931657  3.9  0.1 330904 99344 pts/1    S+   18:29   0:00                  \_ /var/home/berrange/src/virt/qemu/build/pyvenv/bin/python3 /var/home/berrange/src/virt/qemu/build/pyvenv/bin/meson test --no-rebuild -t 7 --num-processes 1 --print-errorlogs --suite unit

shows TIMEOUT_MULTIPLIER being honoured



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


