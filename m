Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98C8C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh9kX-00026K-Iv; Tue, 07 Jul 2026 13:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wh9kU-000263-Rc
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wh9kS-00072P-4v
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783445898;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QmICZgRb/IM2RZgGI+ma5vN8bglcW8OkJgsdhwy1O5M=;
 b=GXNqX0ugjSzeBft9g5vM6moO7F5lEwg9oqupWe8tCpbbNkDVhL3+xKYh7fBqmq55OBTeNa
 RaHRM2zdVp7gMBEvAy0uAiKh4m9O2FcZyKsgQR0KnF2qfpsITKL1szM5Rc2EPdur/RkaIT
 h62m3+qMSKMfQzPR90cw1VYqkxlrplo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-CIp4C3xuMcOZ4c_n6cUwCQ-1; Tue,
 07 Jul 2026 13:38:17 -0400
X-MC-Unique: CIp4C3xuMcOZ4c_n6cUwCQ-1
X-Mimecast-MFC-AGG-ID: CIp4C3xuMcOZ4c_n6cUwCQ_1783445895
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7DAF1955D48; Tue,  7 Jul 2026 17:38:14 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.142])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42E051800756; Tue,  7 Jul 2026 17:38:12 +0000 (UTC)
Date: Tue, 7 Jul 2026 18:38:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] iotests: add --quiet arg to hide env variable dump
Message-ID: <ak05gbutFsE8HeCq@redhat.com>
References: <20260623160611.2347282-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260623160611.2347282-1-berrange@redhat.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

Ping: anyone have any thoughts on this proposal

On Tue, Jun 23, 2026 at 05:06:11PM +0100, Daniel P. Berrangé wrote:
> Every test run dumps a long list of environment variable settings.
> While this is often useful, if you are trying to reproduce a bug
> while repeatedly running a single test it can be quiet noisy. Add
> a --quiet flag to 'check' which allows the env variable dump to
> be hidden.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  tests/qemu-iotests/check         | 4 +++-
>  tests/qemu-iotests/testrunner.py | 7 ++++---
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index 3941eac8e2..c8ba536970 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -46,6 +46,8 @@ def make_argparser() -> argparse.ArgumentParser:
>          description="Test run options",
>          formatter_class=argparse.ArgumentDefaultsHelpFormatter)
>  
> +    p.add_argument('-q', '--quiet', action='store_true',
> +                   help='reduce output verbosity to only test results')
>      p.add_argument('-n', '--dry-run', action='store_true',
>                     help='show me, do not run tests')
>      p.add_argument('-j', dest='jobs', type=int, default=1,
> @@ -230,6 +232,6 @@ if __name__ == '__main__':
>          with TestRunner(env, tap=args.tap,
>                          color=args.color) as tr:
>              paths = [os.path.join(env.source_iotests, t) for t in tests]
> -            ok = tr.run_tests(paths, args.jobs)
> +            ok = tr.run_tests(paths, args.jobs, args.quiet)
>              if not ok:
>                  sys.exit(1)
> diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
> index dbe2dddc32..0eb7f144df 100644
> --- a/tests/qemu-iotests/testrunner.py
> +++ b/tests/qemu-iotests/testrunner.py
> @@ -376,7 +376,7 @@ def run_test(self, test: str,
>          sys.stdout.flush()
>          return res
>  
> -    def run_tests(self, tests: List[str], jobs: int = 1) -> bool:
> +    def run_tests(self, tests: List[str], jobs: int = 1, quiet: bool = False) -> bool:
>          n_run = 0
>          failed = []
>          notrun = []
> @@ -384,9 +384,10 @@ def run_tests(self, tests: List[str], jobs: int = 1) -> bool:
>  
>          if self.tap:
>              print('TAP version 13')
> -            self.env.print_env('# ')
> +            if not quiet:
> +                self.env.print_env('# ')
>              print('1..%d' % len(tests))
> -        else:
> +        elif not quiet:
>              self.env.print_env()
>  
>          test_field_width = max(len(os.path.basename(t)) for t in tests) + 2
> -- 
> 2.54.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


