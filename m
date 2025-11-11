Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70312CCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 17:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIsQe-0006kz-Gs; Tue, 11 Nov 2025 12:45:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vIsQA-0006YS-0F
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:44:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vIsQ8-0000DN-Bs
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762883083;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fzn3RzXMfdT+5ldv/NPqY6jr0RcXoLXW5jbnLfVdeYI=;
 b=M9e/PSvEfvHVKcxIivzMAvUHnrEm6bIdvpxIbqyJrDzpUF9RXKIG4pzsg4or6zWVFguTHK
 SNuJZ9bLXOjHyj+isrF88sPLiLisCLACXwkR8ClDcXmGbh/MR3T/GIBc1I6depuDdplJ4u
 GqCUHnlpNZXBF9EkTdMwJNwnx+t5Cs8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-u99Db5y3P0KP8vXCQYcUwA-1; Tue,
 11 Nov 2025 12:44:39 -0500
X-MC-Unique: u99Db5y3P0KP8vXCQYcUwA-1
X-Mimecast-MFC-AGG-ID: u99Db5y3P0KP8vXCQYcUwA_1762883076
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2970180057A; Tue, 11 Nov 2025 17:44:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.84])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1046018002B6; Tue, 11 Nov 2025 17:44:29 +0000 (UTC)
Date: Tue, 11 Nov 2025 17:44:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Ed Maste <emaste@freebsd.org>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-arm@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH 13/16] gitlab: use template for ubuntu-24.04-s390x jobs
Message-ID: <aRN1-tuthanSX4pD@redhat.com>
References: <20251111171724.78201-1-alex.bennee@linaro.org>
 <20251111171724.78201-14-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251111171724.78201-14-alex.bennee@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Nov 11, 2025 at 05:17:20PM +0000, Alex Bennée wrote:
> Most of the test is pure boilerplate so to save ourselves from
> repetition move all the main bits into a minimal copy of
> native_build_job_template but without the caching.
> 
> We keep all the current allow_fail and configure setups but do take
> the opportunity to replace the inline nproc calls to using a common
> JOBS variable.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .../custom-runners/ubuntu-24.04-s390x.yml     | 181 +++++++-----------
>  1 file changed, 66 insertions(+), 115 deletions(-)
> 
> diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
> index 45dbee17880..ef8db2750ac 100644
> --- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
> +++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
> @@ -2,129 +2,80 @@
>  # setup by the scripts/ci/setup/ubuntu/build-environment.yml task
>  # "Install basic packages to build QEMU on Ubuntu 24.04"
>  
> +.ubuntu_s390x_template:
> +  extends: .custom_runner_template
> +  needs: []
> +  stage: build
> +  tags:
> +    - ubuntu_24.04
> +    - s390x
> +  rules:
> +    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
> +    - if: "$S390X_RUNNER_AVAILABLE"

These rules mean the jobs always run if those three envs
are satisified, however....


>  ubuntu-24.04-s390x-alldbg:
> - extends: .custom_runner_template
> - needs: []
> - stage: build
> - tags:
> - - ubuntu_24.04
> - - s390x
> - rules:
> - - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
> -   when: manual
> -   allow_failure: true
> - - if: "$S390X_RUNNER_AVAILABLE"
> -   when: manual
> -   allow_failure: true

...this job...

>  ubuntu-24.04-s390x-clang:
> - extends: .custom_runner_template
> - needs: []
> - stage: build
> - tags:
> - - ubuntu_24.04
> - - s390x
> - rules:
> - - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
> -   when: manual
> -   allow_failure: true
> - - if: "$S390X_RUNNER_AVAILABLE"
> -   when: manual
> -   allow_failure: true

...this job..


>  ubuntu-24.04-s390x-tci:
> - needs: []
> - stage: build
> - tags:
> - - ubuntu_24.04
> - - s390x
> - rules:
> - - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
> -   when: manual
> -   allow_failure: true
> - - if: "$S390X_RUNNER_AVAILABLE"
> -   when: manual
> -   allow_failure: true

...this job...

>  ubuntu-24.04-s390x-notcg:
> - extends: .custom_runner_template
> - needs: []
> - stage: build
> - tags:
> - - ubuntu_24.04
> - - s390x
> - rules:
> - - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
> -   when: manual
> -   allow_failure: true
> - - if: "$S390X_RUNNER_AVAILABLE"
> -   when: manual
> -   allow_failure: true

...and this job, would never get run by default even if the env vars
were satisfied. It would require someone to hit the 'run' button in
the CI web pages. Now with this commit, these 4 manual jobs are run
unconditionally every time. IOW, pipelines now trigger 6 s390x
jobs instead of 2 jobs, and 4 opt-in jobs.

If that is intentional, IMHO, there should have been a prior commit
that removed the 'when: manual' stanza from all these jobs, so that
this commit was pure re-factoring with no functional change in job
behaviour.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


