Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F69BD44D4C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 11:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8dxF-0008Dw-SK; Wed, 06 Nov 2024 06:12:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8dxA-0008DJ-Ul
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 06:12:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8dx8-0007Ae-4g
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 06:11:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730891517;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=daFViwoyFcCR6g/6Wy04GzZgIaIkXkomKK0DqWH9IgI=;
 b=ehd8uSgcwa4qXeY05P0TtNPK4zpo1AY5XEOe095NYkuflGArNqZuxVkE0LSs2WL4hknq6Z
 n0A89rm82QJ7nom+URYBqwlXyZaswkp2Wq86yPebGwCxQGfvdmz6xAcpxDFZKTCT26Zkma
 ipvzxFTQqR0SHkfdEbmJWusJ3TY+ZOY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-kF9Sbp9bMbOnrLpM81i11g-1; Wed,
 06 Nov 2024 06:11:54 -0500
X-MC-Unique: kF9Sbp9bMbOnrLpM81i11g-1
X-Mimecast-MFC-AGG-ID: kF9Sbp9bMbOnrLpM81i11g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8E4C1956083; Wed,  6 Nov 2024 11:11:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.182])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D00619560AA; Wed,  6 Nov 2024 11:11:48 +0000 (UTC)
Date: Wed, 6 Nov 2024 11:11:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 21/22] tests/qtest: Add support for check-qtest-<subsystem>
Message-ID: <ZytO8SLDAT2VRjly@redhat.com>
References: <20241105180837.5990-1-farosas@suse.de>
 <20241105180837.5990-22-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105180837.5990-22-farosas@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On Tue, Nov 05, 2024 at 03:08:36PM -0300, Fabiano Rosas wrote:
> Allow qtests to be ran by subsystem. Some subsystems, such as
> migration, have a large number of tests and we could benefit from
> being able to access them from make check without having to run the
> full set of qtests.
> 
> This adds the following make check targets:
> 
> make check-qtest-migration
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> I did not include check-qtest-<arch>-<subsys> because meson generates a
> long line that affects readability.

Can you give an example of that ?  I'm wondering how much of a
problem it actually is ? Personally when I'm running a subset
of tests, I almost always want to limit to just one arch target.

> ---
>  tests/qtest/meson.build | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

Despite the above question, this does what it claims to do
at this time, so

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 806af512d0..e0ba858f5b 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -36,6 +36,13 @@ if enable_modules
>    qtests_generic += [ 'modules-test' ]
>  endif
>  
> +qtest_subsystems = {
> +  'migration-test-smoke': ['migration'],
> +  'migration-test': ['migration'],
> +  'cdrom-test': ['block'],
> +  'ahci-test': ['block'],
> +}
> +
>  qtests_pci = \
>    (config_all_devices.has_key('CONFIG_VGA') ? ['display-vga-test'] : []) +                  \
>    (config_all_devices.has_key('CONFIG_IVSHMEM_DEVICE') ? ['ivshmem-test'] : [])
> @@ -431,6 +438,12 @@ foreach dir : target_dirs
>          test: executable(test, src, dependencies: deps)
>        }
>      endif
> +
> +    suites = ['qtest', 'qtest-' + target_base]
> +    foreach subsys: qtest_subsystems.get(test, [])
> +      suites += ['qtest-' + subsys]
> +    endforeach
> +
>      test('qtest-@0@/@1@'.format(target_base, test),
>           qtest_executables[test],
>           depends: [test_deps, qtest_emulator, emulator_modules],
> @@ -439,6 +452,6 @@ foreach dir : target_dirs
>           protocol: 'tap',
>           timeout: slow_qtests.get(test, 60),
>           priority: slow_qtests.get(test, 60),
> -         suite: ['qtest', 'qtest-' + target_base])
> +         suite: suites)
>    endforeach
>  endforeach
> -- 
> 2.35.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


