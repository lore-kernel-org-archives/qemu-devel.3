Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF955E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 11:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV8DA-0006gc-PV; Tue, 07 Jan 2025 06:57:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tV8D8-0006dg-NK
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 06:57:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tV8D7-0005hG-11
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 06:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736251040;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=j5H3kJTayO47ok9QWH372kMOdaKmrHvOCpkhXrl4cI0=;
 b=a3PGNgyKmnsFUCmWA2t87xRIj762OYheTW4dg7aczWlxaX6rY9f+rWymr3v9XTDJxGwFKk
 7pzEwbHBsl9AA1LNGVlj/2xpfadHLf13GaqHKwcvt+BBqFiir/yHmGqN1i450DKC8P4LNA
 5h8iRnhyZbTj7AYwjDTD/W1kFiQDYRk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-Pp5EsXy3Nrqi1NqYQfns0A-1; Tue,
 07 Jan 2025 06:57:18 -0500
X-MC-Unique: Pp5EsXy3Nrqi1NqYQfns0A-1
X-Mimecast-MFC-AGG-ID: Pp5EsXy3Nrqi1NqYQfns0A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08910195608C; Tue,  7 Jan 2025 11:57:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.64])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 289601956053; Tue,  7 Jan 2025 11:57:14 +0000 (UTC)
Date: Tue, 7 Jan 2025 11:57:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] tests/functional/test_x86_64_hotplug_cpu: Fix race
 condition during unplug
Message-ID: <Z30WlysSx4-L-YSs@redhat.com>
References: <20250107115245.52755-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250107115245.52755-1-thuth@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 07, 2025 at 12:52:45PM +0100, Thomas Huth wrote:
> When unplugging the CPU, the test tries to check for a successful
> unplug by changing to the /sys/devices/system/cpu/cpu1 directory
> to see whether that fails. However, the "cd" could be faster than
> the unplug operation in the kernel, so there is a race condition
> and the test sometimes fails here.
> Fix it by trying to change the directory in a loop until the the
> CPU has really been unplugged.
> 
> Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/test_x86_64_hotplug_cpu.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/test_x86_64_hotplug_cpu.py b/tests/functional/test_x86_64_hotplug_cpu.py
> index b1d5156c72..7b9200ac2e 100755
> --- a/tests/functional/test_x86_64_hotplug_cpu.py
> +++ b/tests/functional/test_x86_64_hotplug_cpu.py
> @@ -59,11 +59,13 @@ def test_hotplug(self):
>                                            'cd /sys/devices/system/cpu/cpu1',
>                                            'cpu1#')
>  
> +        exec_command_and_wait_for_pattern(self, 'cd ..', prompt)

Is this actually needed ? Are we keeping the CPU from being unplugged by
being in that dir ? If so, why isn't it also needed in the while loop
below ?

>          self.vm.cmd('device_del', id='c1')
>  
>          exec_command_and_wait_for_pattern(self,
> -                                          'cd /sys/devices/system/cpu/cpu1',
> -                                          'No such file or directory')
> +                                    'while cd /sys/devices/system/cpu/cpu1 ;'
> +                                    ' do sleep 0.2 ; done',
> +                                    'No such file or directory')
>  
>  if __name__ == '__main__':
>      LinuxKernelTest.main()
> -- 
> 2.47.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


