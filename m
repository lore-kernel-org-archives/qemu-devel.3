Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E98DC27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 08:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEmEj-0004Rc-Ht; Wed, 05 Jun 2024 04:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEmEh-0004RJ-NQ
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:43:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEmEe-0000S8-Qu
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717576987;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/HZFKNRGbKG0p9FEFkS4a+JiB2YEwyqcJFbnAjUaAgc=;
 b=Xgi3B+pX4U0bGPbkUok62x93hdUoYWAnIjGCkdSJmchqI5W7mB6iFazTkmyMpzhY6MGTLL
 cXMoGIpeLuKGOtNmzWaYoo9cKUfZiSZbBZVbh7O1lZ4KC4Jf7OWsvOZnJRh3OeIoItHRXc
 tPlYRyoaUqxg6TBY7ZbRTPo5QXzyZVI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-WRBNBKO_N5eDX-3rK6aHZQ-1; Wed, 05 Jun 2024 04:42:58 -0400
X-MC-Unique: WRBNBKO_N5eDX-3rK6aHZQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C24D7800074;
 Wed,  5 Jun 2024 08:42:57 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FB77111DD16;
 Wed,  5 Jun 2024 08:42:55 +0000 (UTC)
Date: Wed, 5 Jun 2024 09:42:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, imammedo@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] tests/qtest/x86: check for availability of older cpu
 models before running tests
Message-ID: <ZmAlDXIyoRrNfDeB@redhat.com>
References: <20240605072512.67692-1-anisinha@redhat.com>
 <20240605072512.67692-4-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240605072512.67692-4-anisinha@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jun 05, 2024 at 12:55:11PM +0530, Ani Sinha wrote:
> Some older cpu models like 486, athlon, pentium, penryn, phenom, core2duo etc
> may not be available in all builds. Check for their availability in qemu before
> running the corresponding tests.

From an upstream POV this is very much not the case - all CPUs models
are unconditionally built in to QEMU.

This change is being driven RHEL's desire to only ship a small subset
of CPU models, dropping the legacy stuff that's only interesting for
emulation use cases with ancient OS.

> 
> The order of the tests has been altered so that all tests for similar checks
> under a specific cpu is placed together.
> 
> One minor correction. Replaced 'phenom' with '486' in the test
> 'x86/cpuid/auto-level/phenom/arat' matching the cpu used.
> 
> CC: thuth@redhat.com
> CC: imammedo@redhat.com
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  tests/qtest/test-x86-cpuid-compat.c | 214 +++++++++++++++++-----------
>  1 file changed, 127 insertions(+), 87 deletions(-)
> 
> diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
> index 6a39454fce..054f9eae47 100644
> --- a/tests/qtest/test-x86-cpuid-compat.c
> +++ b/tests/qtest/test-x86-cpuid-compat.c
> @@ -209,99 +209,135 @@ static void test_plus_minus(void)
>  
>  int main(int argc, char **argv)
>  {
> +    bool has_486, has_athlon, has_conroe;
> +    bool has_core2duo, has_penryn, has_pentium, has_phenom;
> +
>      g_test_init(&argc, &argv, NULL);
>  
> -    g_test_add_func("/x86/cpuid/parsing-plus-minus/subprocess",
> -                    test_plus_minus_subprocess);
> -    g_test_add_func("/x86/cpuid/parsing-plus-minus", test_plus_minus);
> +    has_486 = qtest_has_cpu("486");
> +    has_athlon = qtest_has_cpu("athlon");
> +    has_conroe = qtest_has_cpu("Conroe");
> +    has_core2duo = qtest_has_cpu("core2duo");
> +    has_penryn = qtest_has_cpu("Penryn");
> +    has_pentium = qtest_has_cpu("pentium");
> +    has_phenom = qtest_has_cpu("phenom");
> +
> +    if (has_pentium) {
> +        g_test_add_func("/x86/cpuid/parsing-plus-minus/subprocess",
> +                        test_plus_minus_subprocess);
> +        g_test_add_func("/x86/cpuid/parsing-plus-minus", test_plus_minus);
> +    }
>  
>      /* Original level values for CPU models: */
> -    add_cpuid_test("x86/cpuid/phenom/level",
> -                   "-cpu phenom", "level", 5);
> -    add_cpuid_test("x86/cpuid/Conroe/level",
> -                   "-cpu Conroe", "level", 10);
> +    if (has_486) {
> +        add_cpuid_test("x86/cpuid/486/xlevel",
> +                       "-cpu 486", "xlevel", 0);
> +    }

I think that modifying every test like this is a  very cumbersome
way of doing it, as you're needing to hardcode a particular list
of CPUs to check for, and this list is not neccessarily complete.

Instead, IMHO the add_cpuid_test() method should be changed such
that instead of taking an ARGV string as its 2nd parameter, it
has a "cpu" and a "machine" parameter, with 'machine' being passed
NULL for most of the tests.

IOW, we should be calling

    add_cpuid_test("x86/cpuid/486/xlevel", NULL, "486", "xlevel", 0);

Now the 'add_cpuid_test' method itself, can check the CPU name
that it receives, and turn itself into a no-op if the CPU is
missing. This avoids adding any conditionals here, and will
work correctly no matter what CPUs are present.

> +    if (has_phenom) {
> +        add_cpuid_test("x86/cpuid/phenom/level",
> +                       "-cpu phenom", "level", 5);
> +        add_cpuid_test("x86/cpuid/phenom/xlevel",
> +                       "-cpu phenom", "xlevel", 0x8000001A);
> +    }
> +    if (has_athlon) {
> +        add_cpuid_test("x86/cpuid/athlon/xlevel",
> +                       "-cpu athlon", "xlevel", 0x80000008);
> +    }
> +    if (has_core2duo) {
> +        add_cpuid_test("x86/cpuid/core2duo/xlevel",
> +                       "-cpu core2duo", "xlevel", 0x80000008);
> +    }
> +    if (has_conroe) {
> +        add_cpuid_test("x86/cpuid/Conroe/level",
> +                       "-cpu Conroe", "level", 10);
> +    }
>      add_cpuid_test("x86/cpuid/SandyBridge/level",
>                     "-cpu SandyBridge", "level", 0xd);
> -    add_cpuid_test("x86/cpuid/486/xlevel",
> -                   "-cpu 486", "xlevel", 0);
> -    add_cpuid_test("x86/cpuid/core2duo/xlevel",
> -                   "-cpu core2duo", "xlevel", 0x80000008);
> -    add_cpuid_test("x86/cpuid/phenom/xlevel",
> -                   "-cpu phenom", "xlevel", 0x8000001A);
> -    add_cpuid_test("x86/cpuid/athlon/xlevel",
> -                   "-cpu athlon", "xlevel", 0x80000008);
>  
>      /* If level is not large enough, it should increase automatically: */
> -    /* CPUID[6].EAX: */
> -    add_cpuid_test("x86/cpuid/auto-level/phenom/arat",
> -                   "-cpu 486,arat=on", "level", 6);
> -    /* CPUID[EAX=7,ECX=0].EBX: */
> -    add_cpuid_test("x86/cpuid/auto-level/phenom/fsgsbase",
> -                   "-cpu phenom,fsgsbase=on", "level", 7);
> -    /* CPUID[EAX=7,ECX=0].ECX: */
> -    add_cpuid_test("x86/cpuid/auto-level/phenom/avx512vbmi",
> -                   "-cpu phenom,avx512vbmi=on", "level", 7);
> -    /* CPUID[EAX=0xd,ECX=1].EAX: */
> -    add_cpuid_test("x86/cpuid/auto-level/phenom/xsaveopt",
> -                   "-cpu phenom,xsaveopt=on", "level", 0xd);
> -    /* CPUID[8000_0001].EDX: */
> -    add_cpuid_test("x86/cpuid/auto-xlevel/486/3dnow",
> -                   "-cpu 486,3dnow=on", "xlevel", 0x80000001);
> -    /* CPUID[8000_0001].ECX: */
> -    add_cpuid_test("x86/cpuid/auto-xlevel/486/sse4a",
> -                   "-cpu 486,sse4a=on", "xlevel", 0x80000001);
> -    /* CPUID[8000_0007].EDX: */
> -    add_cpuid_test("x86/cpuid/auto-xlevel/486/invtsc",
> -                   "-cpu 486,invtsc=on", "xlevel", 0x80000007);
> -    /* CPUID[8000_000A].EDX: */
> -    add_cpuid_test("x86/cpuid/auto-xlevel/486/npt",
> -                   "-cpu 486,svm=on,npt=on", "xlevel", 0x8000000A);
> -    /* CPUID[C000_0001].EDX: */
> -    add_cpuid_test("x86/cpuid/auto-xlevel2/phenom/xstore",
> -                   "-cpu phenom,xstore=on", "xlevel2", 0xC0000001);
> -    /* SVM needs CPUID[0x8000000A] */
> -    add_cpuid_test("x86/cpuid/auto-xlevel/athlon/svm",
> -                   "-cpu athlon,svm=on", "xlevel", 0x8000000A);
> -
> +    if (has_486) {
> +        /* CPUID[6].EAX: */
> +        add_cpuid_test("x86/cpuid/auto-level/486/arat",
> +                       "-cpu 486,arat=on", "level", 6);
> +        /* CPUID[8000_0001].EDX: */
> +        add_cpuid_test("x86/cpuid/auto-xlevel/486/3dnow",
> +                       "-cpu 486,3dnow=on", "xlevel", 0x80000001);
> +        /* CPUID[8000_0001].ECX: */
> +        add_cpuid_test("x86/cpuid/auto-xlevel/486/sse4a",
> +                       "-cpu 486,sse4a=on", "xlevel", 0x80000001);
> +        /* CPUID[8000_0007].EDX: */
> +        add_cpuid_test("x86/cpuid/auto-xlevel/486/invtsc",
> +                       "-cpu 486,invtsc=on", "xlevel", 0x80000007);
> +        /* CPUID[8000_000A].EDX: */
> +        add_cpuid_test("x86/cpuid/auto-xlevel/486/npt",
> +                       "-cpu 486,svm=on,npt=on", "xlevel", 0x8000000A);
> +    }
> +    if (has_phenom) {
> +        /* CPUID[EAX=7,ECX=0].EBX: */
> +        add_cpuid_test("x86/cpuid/auto-level/phenom/fsgsbase",
> +                       "-cpu phenom,fsgsbase=on", "level", 7);
> +        /* CPUID[EAX=7,ECX=0].ECX: */
> +        add_cpuid_test("x86/cpuid/auto-level/phenom/avx512vbmi",
> +                       "-cpu phenom,avx512vbmi=on", "level", 7);
> +        /* CPUID[EAX=0xd,ECX=1].EAX: */
> +        add_cpuid_test("x86/cpuid/auto-level/phenom/xsaveopt",
> +                       "-cpu phenom,xsaveopt=on", "level", 0xd);
> +        /* CPUID[C000_0001].EDX: */
> +        add_cpuid_test("x86/cpuid/auto-xlevel2/phenom/xstore",
> +                       "-cpu phenom,xstore=on", "xlevel2", 0xC0000001);
> +    }
> +    if (has_athlon) {
> +        /* SVM needs CPUID[0x8000000A] */
> +        add_cpuid_test("x86/cpuid/auto-xlevel/athlon/svm",
> +                       "-cpu athlon,svm=on", "xlevel", 0x8000000A);
> +    }
>  
>      /* If level is already large enough, it shouldn't change: */
>      add_cpuid_test("x86/cpuid/auto-level/SandyBridge/multiple",
>                     "-cpu SandyBridge,arat=on,fsgsbase=on,avx512vbmi=on",
>                     "level", 0xd);
>      /* If level is explicitly set, it shouldn't change: */
> -    add_cpuid_test("x86/cpuid/auto-level/486/fixed/0xF",
> -                   "-cpu 486,level=0xF,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
> -                   "level", 0xF);
> -    add_cpuid_test("x86/cpuid/auto-level/486/fixed/2",
> -                   "-cpu 486,level=2,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
> -                   "level", 2);
> -    add_cpuid_test("x86/cpuid/auto-level/486/fixed/0",
> -                   "-cpu 486,level=0,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
> -                   "level", 0);
> +    if (has_486) {
> +        add_cpuid_test("x86/cpuid/auto-level/486/fixed/0xF",
> +                       "-cpu 486,level=0xF,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
> +                       "level", 0xF);
> +        add_cpuid_test("x86/cpuid/auto-level/486/fixed/2",
> +                       "-cpu 486,level=2,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
> +                       "level", 2);
> +        add_cpuid_test("x86/cpuid/auto-level/486/fixed/0",
> +                       "-cpu 486,level=0,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
> +                       "level", 0);
> +    }
>  
>      /* if xlevel is already large enough, it shouldn't change: */
> -    add_cpuid_test("x86/cpuid/auto-xlevel/phenom/3dnow",
> -                   "-cpu phenom,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
> -                   "xlevel", 0x8000001A);
> +    if (has_phenom) {
> +        add_cpuid_test("x86/cpuid/auto-xlevel/phenom/3dnow",
> +                       "-cpu phenom,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
> +                       "xlevel", 0x8000001A);
> +    }
> +
>      /* If xlevel is explicitly set, it shouldn't change: */
> -    add_cpuid_test("x86/cpuid/auto-xlevel/486/fixed/80000002",
> -                   "-cpu 486,xlevel=0x80000002,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
> -                   "xlevel", 0x80000002);
> -    add_cpuid_test("x86/cpuid/auto-xlevel/486/fixed/8000001A",
> -                   "-cpu 486,xlevel=0x8000001A,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
> -                   "xlevel", 0x8000001A);
> -    add_cpuid_test("x86/cpuid/auto-xlevel/phenom/fixed/0",
> -                   "-cpu 486,xlevel=0,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
> -                   "xlevel", 0);
> -
> -    /* if xlevel2 is already large enough, it shouldn't change: */
> -    add_cpuid_test("x86/cpuid/auto-xlevel2/486/fixed",
> -                   "-cpu 486,xlevel2=0xC0000002,xstore=on",
> -                   "xlevel2", 0xC0000002);
> +    if (has_486) {
> +        add_cpuid_test("x86/cpuid/auto-xlevel/486/fixed/80000002",
> +                       "-cpu 486,xlevel=0x80000002,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
> +                       "xlevel", 0x80000002);
> +        add_cpuid_test("x86/cpuid/auto-xlevel/486/fixed/8000001A",
> +                       "-cpu 486,xlevel=0x8000001A,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
> +                       "xlevel", 0x8000001A);
> +        add_cpuid_test("x86/cpuid/auto-xlevel/phenom/fixed/0",
> +                       "-cpu 486,xlevel=0,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
> +                       "xlevel", 0);
> +
> +        /* if xlevel2 is already large enough, it shouldn't change: */
> +        add_cpuid_test("x86/cpuid/auto-xlevel2/486/fixed",
> +                       "-cpu 486,xlevel2=0xC0000002,xstore=on",
> +                       "xlevel2", 0xC0000002);
> +    }
> +
>  
>      /* Check compatibility of old machine-types that didn't
>       * auto-increase level/xlevel/xlevel2: */
> -    if (qtest_has_machine("pc-i440fx-2.7")) {
> +    if (qtest_has_machine("pc-i440fx-2.7") && has_486) {
>          add_cpuid_test("x86/cpuid/auto-level/pc-2.7",
>                         "-machine pc-i440fx-2.7 -cpu 486,arat=on,avx512vbmi=on,xsaveopt=on",
>                         "level", 1);
> @@ -317,7 +353,7 @@ int main(int argc, char **argv)
>       * and the compat code that sets default level shouldn't
>       * disable the auto-level=7 code:
>       */
> -    if (qtest_has_machine("pc-i440fx-2.3")) {
> +    if (qtest_has_machine("pc-i440fx-2.3") && has_penryn) {
>          add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.3/off",
>                         "-machine pc-i440fx-2.3 -cpu Penryn",
>                         "level", 4);
> @@ -325,7 +361,7 @@ int main(int argc, char **argv)
>                         "-machine pc-i440fx-2.3 -cpu Penryn,erms=on",
>                         "level", 7);
>      }
> -    if (qtest_has_machine("pc-i440fx-2.9")) {
> +    if (qtest_has_machine("pc-i440fx-2.9") && has_conroe) {
>          add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.9/off",
>                         "-machine pc-i440fx-2.9 -cpu Conroe",
>                         "level", 10);
> @@ -354,18 +390,22 @@ int main(int argc, char **argv)
>      }
>  
>      /* Test feature parsing */
> -    add_feature_test("x86/cpuid/features/plus",
> -                     "-cpu 486,+arat",
> -                     6, 0, "EAX", 2, true);
> -    add_feature_test("x86/cpuid/features/minus",
> -                     "-cpu pentium,-mmx",
> -                     1, 0, "EDX", 23, false);
> -    add_feature_test("x86/cpuid/features/on",
> -                     "-cpu 486,arat=on",
> -                     6, 0, "EAX", 2, true);
> -    add_feature_test("x86/cpuid/features/off",
> -                     "-cpu pentium,mmx=off",
> -                     1, 0, "EDX", 23, false);
> +    if (has_486) {
> +        add_feature_test("x86/cpuid/features/plus",
> +                         "-cpu 486,+arat",
> +                         6, 0, "EAX", 2, true);
> +        add_feature_test("x86/cpuid/features/on",
> +                         "-cpu 486,arat=on",
> +                         6, 0, "EAX", 2, true);
> +    }
> +    if (has_pentium) {
> +        add_feature_test("x86/cpuid/features/minus",
> +                         "-cpu pentium,-mmx",
> +                         1, 0, "EDX", 23, false);
> +        add_feature_test("x86/cpuid/features/off",
> +                         "-cpu pentium,mmx=off",
> +                         1, 0, "EDX", 23, false);
> +    }
>      add_feature_test("x86/cpuid/features/max-plus-invtsc",
>                       "-cpu max,+invtsc",
>                       0x80000007, 0, "EDX", 8, true);
> -- 
> 2.42.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


