Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88046C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 14:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufJlk-0006C1-Er; Fri, 25 Jul 2025 10:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ufJjr-0005PZ-EG
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 10:49:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ufJjp-0005AC-3N
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 10:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753454972;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C6lKaIDxG1Uem2y84g4lhKBCxcjzjO4dC1JpG6JBAo4=;
 b=AqxCTrbD4GXSebQ7SMQF9MBu6FkUt/B/09q9LHT7YFGqXNK5cnE+xKq0r8lenX88UlsNBU
 L/u1DlfwUu6KEUYZAtDMlAXNOrcltRfCyyu50gz9roT9ghfaUSfNGXNs20udhFLBCSRVOi
 sgAVHk1oSk1sX3E3Xox1x8Q1dGzv68U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-GNzWV1VkMSOttVxGcUIzfg-1; Fri,
 25 Jul 2025 10:49:28 -0400
X-MC-Unique: GNzWV1VkMSOttVxGcUIzfg-1
X-Mimecast-MFC-AGG-ID: GNzWV1VkMSOttVxGcUIzfg_1753454967
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FE7E19560B6; Fri, 25 Jul 2025 14:49:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.162])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E667D195608D; Fri, 25 Jul 2025 14:49:25 +0000 (UTC)
Date: Fri, 25 Jul 2025 15:49:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH] tests/functional: expose sys.argv to unittest.main
Message-ID: <aIOZcgH_NfGOtHnO@redhat.com>
References: <20250725144142.3041931-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250725144142.3041931-1-alex.bennee@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 25, 2025 at 03:41:42PM +0100, Alex Bennée wrote:
> With this we can call the supported we can take advantage of the
> argument the module supports:
> 
>   env PYTHONPATH=/home/alex/lsrc/qemu.git/python:/home/alex/lsrc/qemu.git/tests/functional ./pyvenv/bin/python /home/alex/lsrc/qemu.git/tests/functional/test_aarch64_kvm.py --help
>   usage: test_aarch64_kvm.py [-h] [-v] [-q] [--locals] [--durations N] [-f] [-c] [-b] [-k TESTNAMEPATTERNS] [tests ...]
> 
>   positional arguments:
>     tests                a list of any number of test modules, classes and test methods.
> 
>   options:
>     -h, --help           show this help message and exit
>     -v, --verbose        Verbose output
>     -q, --quiet          Quiet output
>     --locals             Show local variables in tracebacks
>     --durations N        Show the N slowest test cases (N=0 for all)
>     -f, --failfast       Stop on first fail or error
>     -c, --catch          Catch Ctrl-C and display results so far
>     -b, --buffer         Buffer stdout and stderr during tests
>     -k TESTNAMEPATTERNS  Only run tests which match the given substring
> 
>   Examples:
>     test_aarch64_kvm.py test_module               - run tests from test_module
>     test_aarch64_kvm.py module.TestClass          - run tests from module.TestClass
>     test_aarch64_kvm.py module.Class.test_method  - run specified test method
>     test_aarch64_kvm.py path/to/test_file.py      - run tests from test_file.py
> 
>   usage: test_aarch64_kvm.py discover [-h] [-v] [-q] [--locals] [--durations N] [-f] [-c] [-b] [-k TESTNAMEPATTERNS] [-s START] [-p PATTERN] [-t TOP]
> 
>   options:
>     -h, --help            show this help message and exit
>     -v, --verbose         Verbose output
>     -q, --quiet           Quiet output
>     --locals              Show local variables in tracebacks
>     --durations N         Show the N slowest test cases (N=0 for all)
>     -f, --failfast        Stop on first fail or error
>     -c, --catch           Catch Ctrl-C and display results so far
>     -b, --buffer          Buffer stdout and stderr during tests
>     -k TESTNAMEPATTERNS   Only run tests which match the given substring
>     -s, --start-directory START
>                           Directory to start discovery ('.' default)
>     -p, --pattern PATTERN
>                           Pattern to match tests ('test*.py' default)
>     -t, --top-level-directory TOP
>                           Top level directory of project (defaults to start directory)
> 
>   For test discovery all test modules must be importable from the top level directory of the project.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/functional/qemu_test/testcase.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


