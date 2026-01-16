Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B671DD4A619
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 10:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vggco-000306-UY; Fri, 16 Jan 2026 05:00:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vggcn-0002vU-5x
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:00:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vggci-0001s7-2h
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768557605;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qKFDFkyprOV4Vw/MUnmlT/ocG3ThLVvpfdkkSGm06kk=;
 b=SzRXYVSsm80px/pPR3VYekoU/9wHUyapU65Gj9HhE/T3hRVqo0hile1sm8i5H5cL4i/N6O
 Yg743a/MyjCAuytF1po2YJj6iSPjSF3k6v74SFmmDKhrv4iUGDTwxC5IEFj3hUATusUdoe
 ofasmsoQpo20Xdj2xfwrWX5x2B6cwpI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-HeQQHIOGMg6jFhE-tV2TQw-1; Fri,
 16 Jan 2026 05:00:03 -0500
X-MC-Unique: HeQQHIOGMg6jFhE-tV2TQw-1
X-Mimecast-MFC-AGG-ID: HeQQHIOGMg6jFhE-tV2TQw_1768557601
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8815C19560B2; Fri, 16 Jan 2026 10:00:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.135])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C4551955F22; Fri, 16 Jan 2026 09:59:58 +0000 (UTC)
Date: Fri, 16 Jan 2026 09:59:56 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] tests/functional: Check for nested virtualization to run
 KVM tests
Message-ID: <aWoMHGNxzHVdh2CT@redhat.com>
References: <20260116070438.31869-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260116070438.31869-1-philmd@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 16, 2026 at 08:04:38AM +0100, Philippe Mathieu-Daudé wrote:
> On Apple Silicon, nested virtualization starts to be usable
> with M3 models and later. Check for the CPU model to avoid
> failure on pre-M3:
> 
>   qemu-system-aarch64: unable to find CPU model 'cortex-a72'
> 
> Now tests are correctly skipped, i.e. on M1:
> 
>   ok 1 test_kvm.Aarch64VirtKVMTests.test_aarch64_nvhe_selftest # SKIP Nested Virtualization not available on Apple M1 Pro
>   ok 2 test_kvm.Aarch64VirtKVMTests.test_aarch64_vhe_selftest # SKIP Nested Virtualization not available on Apple M1 Pro
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  tests/functional/aarch64/test_kvm.py | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/tests/functional/aarch64/test_kvm.py b/tests/functional/aarch64/test_kvm.py
> index 7545f5ed554..b26c849ec67 100755
> --- a/tests/functional/aarch64/test_kvm.py
> +++ b/tests/functional/aarch64/test_kvm.py
> @@ -29,8 +29,31 @@ class Aarch64VirtKVMTests(LinuxKernelTest):
>      # base of tests
>      KUT_BASE = "/usr/share/kvm-unit-tests/"
>  
> +    def require_nested_virtualization(self):
> +        """
> +        Requires the accelerator to support nested virtualization for the test
> +        to continue
> +
> +        If the check fails, the test is canceled.
> +        """
> +        import platform, re, subprocess
> +
> +        if platform.system() != 'Darwin':
> +            return
> +        r = subprocess.run(['sysctl', '-n', 'machdep.cpu.brand_string'],
> +                           text=True, capture_output=True)
> +        if r.returncode != 0:
> +            return
> +        m = re.match(r"Apple M(\d+)( .*)?", r.stdout)

I tend to prefer check_call/check_output over the plain 'run',
in this case check_output is suitble

    try
       data = subprocess.check_output([..args..], encoding='utf8')
    except CalledProcessError
       return
    m = re.match(r"Apple M(\d+)( .*)?", data)


> +        if m:
> +            if int(m.group(1)) < 3:
> +                self.skipTest("Nested Virtualization not available"
> +                              " on %s" % r.stdout.strip())

Please add this as a decorator in tests/functional/qemu_tests/decorators.py
called something like  "skipUnlessNestedVirtSupported".

> +
>      def _launch_guest(self, kvm_mode="nvhe"):
>  
> +        self.require_nested_virtualization()
> +
>          self.set_machine('virt')
>          kernel_path = self.ASSET_KVM_TEST_KERNEL.fetch()
>  
> -- 
> 2.52.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


