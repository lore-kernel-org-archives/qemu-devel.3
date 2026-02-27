Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834EEFD530C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 08:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvsun-0000W1-4X; Fri, 27 Feb 2026 03:09:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvsul-0000Vd-Kx
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 03:09:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvsuj-0002tp-Sy
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 03:09:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772179772;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z4dRO3J9ZEREHEz67IYOdhP3RwpWBYBXb6puJsUpGX8=;
 b=Yg2Bl5vnY+0qAnp1BMuppRDJcNSeV1jPYc7DpD/32cKiB1GbLMfgvn/op74ZFP5hCqNtw0
 /Ac6BbbMvvjLCmSuJq8WcCQyR0hyi/pBGPmS/pkeNkXjJ2iJtoiNwQ7tTug76iNnvwBnt9
 2VUsj1OQatGukLKG102zsmEfYO2kOxw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-iRcIr9IpM9GaW_BQsi496w-1; Fri,
 27 Feb 2026 03:09:28 -0500
X-MC-Unique: iRcIr9IpM9GaW_BQsi496w-1
X-Mimecast-MFC-AGG-ID: iRcIr9IpM9GaW_BQsi496w_1772179767
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54A7D180034A; Fri, 27 Feb 2026 08:09:27 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.85])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 222571800348; Fri, 27 Feb 2026 08:09:24 +0000 (UTC)
Date: Fri, 27 Feb 2026 08:09:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 2/4] python: replace avocado tests with pytest
Message-ID: <aaFQCknP5DRUXS0Z@redhat.com>
References: <20260226213400.1254014-1-jsnow@redhat.com>
 <20260226213400.1254014-3-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226213400.1254014-3-jsnow@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Feb 26, 2026 at 04:33:58PM -0500, John Snow wrote:
> Following suit with the rest of this repository, drop avocado and
> replace it with the Python standard "pytest" package.
> 
> Our ultimate goal is to merge these python tests with the meson test
> suite, so the use of 'pytest' here is only a stop-gap solution to get
> the GitLab CI 'check-python-tox' passing again following recent Python
> packaging ecosystem changes.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/Makefile          |  4 +-
>  python/setup.cfg         |  1 +
>  python/tests/linters.py  | 79 ++++++++++++++++++++++++++++++++++++++++
>  python/tests/minreqs.txt |  1 +
>  4 files changed, 83 insertions(+), 2 deletions(-)
>  create mode 100644 python/tests/linters.py

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> +class TestLinters:
> +
> +    def test_flake8_pkg(self):
> +        check_call([sys.executable, "-m", "flake8", "qemu/"])
> +
> +    def test_flake8_scripts(self):
> +        check_call([sys.executable, "-m", "flake8", "scripts/"])
> +
> +    def test_flake8_qapi(self):
> +        check_call([sys.executable, "-m", "flake8",
> +              "../scripts/qapi/",
> +              "../docs/sphinx/qapidoc.py",
> +              "../docs/sphinx/qapi_domain.py"])

Underindented.

> +
> +    def test_isort_pkg(self):
> +        check_call([sys.executable, "-m", "isort", "-c", "qemu/"])
> +
> +    def test_isort_scripts(self):
> +        check_call([sys.executable, "-m", "isort", "-c", "scripts/"])
> +
> +    def test_isort_qapi(self):
> +        check_call([sys.executable, "-m", "isort",
> +                    "--sp", ".", "-c", "../scripts/qapi/"])
> +
> +    def test_isort_qapi_sphinx(self):
> +        # Force isort to recognize 'compat' as a local module and not
> +        # third-party
> +        check_call([sys.executable, "-m", "isort",
> +                    "--sp", ".", "-c", "-p", "compat",
> +                    "../docs/sphinx/qapi_domain.py",
> +                    "../docs/sphinx/qapidoc.py"])
> +

...

> +
> +    def test_pylint_qapi(self):
> +        os.environ['SETUPTOOLS_USE_DISTUTILS'] = 'stdlib'
> +        check_call([sys.executable, "-m", "pylint",
> +              "--rcfile=../scripts/qapi/pylintrc",
> +              "../scripts/qapi/",
> +              "../docs/sphinx/qapidoc.py",
> +              "../docs/sphinx/qapi_domain.py"])

Underindented.

> +
> +    def test_pylint_iotests(self):
> +        os.environ['SETUPTOOLS_USE_DISTUTILS'] = 'stdlib'
> +        check_call([sys.executable, "-m", "linters", "--pylint"],
> +                   cwd="../tests/qemu-iotests/")

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


