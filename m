Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3FACE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 10:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKwO1-0003c1-3l; Mon, 17 Nov 2025 05:23:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vKwNo-0003Zr-Bu
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 05:22:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vKwNk-0004J7-IE
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 05:22:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763374954;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7hcHIffL+y0hVwYYu1dloFwXf/0pG0p6dbiGKxiiO3A=;
 b=Fujd7JbzFAg40E5bseSG0PBvPWzYnrFDJ0ru0C/iMFDlTv3EfQ54hTNHlkj6jO7vaWeM45
 m7lnQWZc/gJSw2k3Ce847EBoyhPInGajGnqLtLIrQurX92rfmoZHaMDEGPLhjgy4AOAtiO
 H/Ha6l6S+Vy3BnozAzOt+SsqOJhLrJM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-RvSlML4TO9myLKMXm1kl3g-1; Mon,
 17 Nov 2025 05:22:31 -0500
X-MC-Unique: RvSlML4TO9myLKMXm1kl3g-1
X-Mimecast-MFC-AGG-ID: RvSlML4TO9myLKMXm1kl3g_1763374949
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F2351956095; Mon, 17 Nov 2025 10:22:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EDE21955F65; Mon, 17 Nov 2025 10:22:20 +0000 (UTC)
Date: Mon, 17 Nov 2025 10:22:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paul Durrant <paul@xen.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Li-Wen Hsu <lwhsu@freebsd.org>,
 David Woodhouse <dwmw2@infradead.org>, Ed Maste <emaste@freebsd.org>
Subject: Re: [PATCH v2 16/18] gitlab: make custom runners need QEMU_CI to run
Message-ID: <aRr3WQfFnD1gpXdH@redhat.com>
References: <20251113102525.1255370-1-alex.bennee@linaro.org>
 <20251113102525.1255370-17-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251113102525.1255370-17-alex.bennee@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Nov 13, 2025 at 10:25:22AM +0000, Alex Bennée wrote:
> In addition to not being triggered by schedule we should follow the
> same rules about QEMU_CI. One day we may figure out how to fold the
> custom runner rules into the .base_job_template but today is not that
> day.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .gitlab-ci.d/custom-runners/debian-13-ppc64le.yml    | 2 +-
>  .gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml | 2 +-
>  .gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml b/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
> index 6492d013de8..be73c14b95e 100644
> --- a/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
> +++ b/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
> @@ -11,7 +11,7 @@
>      - ppc64le
>    rules:
>      - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
> -    - if: '$PPC64LE_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule"'
> +    - if: '$PPC64LE_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule" && $QEMU_CI'
>    before_script:
>      - source scripts/ci/gitlab-ci-section
>      - section_start setup "Pre-script setup"
> diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
> index c8adb8171c0..7a30a18d0bc 100644
> --- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
> +++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
> @@ -11,7 +11,7 @@
>      - aarch64
>    rules:
>      - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
> -    - if: '$AARCH64_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule"'
> +    - if: '$AARCH64_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule" && $QEMU_CI'
>    before_script:
>      - source scripts/ci/gitlab-ci-section
>      - section_start setup "Pre-script setup"
> diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
> index fcb49ae884d..c30816a806e 100644
> --- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
> +++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
> @@ -11,7 +11,7 @@
>      - s390x
>    rules:
>      - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'

As a separate commit this should be changed to

   - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH =~ /^staging/'

$QEMU_CI_UPSTREAM defaults to 'qemu-project' but devs can override it
to point to their own repo, in order to test operation as if it were
in upstream.

> -    - if: '$S390X_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule"'
> +    - if: '$S390X_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule" && $QEMU_CI'
>    before_script:
>      - source scripts/ci/gitlab-ci-section
>      - section_start setup "Pre-script setup"

This means the job will never get run by default in upstream context
unless QEMU_CI is set. This is different from base.yml where in upstream
context, jobs all run by default.

ie in upstream we implicitly have QEMU_CI==2 by default, while in
forks we implicitly have QEMU_CI==0 / unset.

To get this matching better requires:

 rules:
   - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH =~ /^staging/'
   - if: '$QEMU_CI != "1" && $QEMU_CI != "2" && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
     when: never
   - if: '$S390X_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule" && $QEMU_CI == "1"'
     when: manual
   - if: '$S390X_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule"'


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


