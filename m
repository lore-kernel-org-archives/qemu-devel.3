Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4C3C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 19:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCk7K-0007k1-HK; Wed, 07 May 2025 15:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uCk7H-0007di-20
 for qemu-devel@nongnu.org; Wed, 07 May 2025 15:07:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uCk7F-0007Po-5R
 for qemu-devel@nongnu.org; Wed, 07 May 2025 15:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746644854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TvmoLXdYV7DVvfU0s6CWieMJJ+Y1fBuORvqJSWTGhP4=;
 b=jWqmm5xx6LE0p+PoNMXtuSXR2113eo9GNsVoT+YSolhDsn6UkAzg/g78DmbVX1fRIrOUk1
 0Rmox+FP3Izvxsss1IAiiuR1YdoFempuLrV/oYlJO6G92NQKXq9UHpNDfePhMQomLetH47
 K5QZPsdQi7Vli215rHRyLSvOoTPHODs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-IRsRCANaMrix6NTQaiMoBA-1; Wed, 07 May 2025 15:07:33 -0400
X-MC-Unique: IRsRCANaMrix6NTQaiMoBA-1
X-Mimecast-MFC-AGG-ID: IRsRCANaMrix6NTQaiMoBA_1746644853
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6eeb5e86c5fso2785416d6.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 12:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746644852; x=1747249652;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TvmoLXdYV7DVvfU0s6CWieMJJ+Y1fBuORvqJSWTGhP4=;
 b=eFqcFadrmpYCei+517cX2ydPJUwOOPpe8QhZRZyNps2qqmH9t8luXmbx8SXTlL5pC6
 ipfU5PrUbIWRVAoG9+gK25PZVYxIA1DAK3otqWHl3Hn7thlMOm6U5Jp+qbywu/l3P9er
 VZe3Pjw5/m0FttRqJGl24YSYSJhVbbxnlVTdSB+DhvoQVRncPn9FH5w2Xs++efFEUW+M
 XeiMfVxmrhZkUcJmE9NhJius+wljHeEodAurV3ULnkWolb0/RYUtbTHft2es6L8FXyW9
 Gik3GNkuYRh5/qFqrVbhlS924CKoeBsap989lWso0Hi/TyVelQpo+v7IMmJ5XqibwU82
 2eGA==
X-Gm-Message-State: AOJu0YycygLykPSrYIRl5lCHLlkwpzC0veWqLgFP1EPTDR6SRZB350uD
 0x4ko0uuO6Zofx+3FWYT5jTXH7DDnMBnaHffUyW5EEqsOBAwN6Q1SlN+WyxI5w2ttdSDcd+ulXx
 liiRHBEuB6teL1la4C7ffUERJrHS47ffldDhryTOB2exxesLUhMUX
X-Gm-Gg: ASbGnctm0DDAq71ZR9/SQ6qNaX06X6FiAH1SxiqD0cRSXiYVKP0W4edmrmgGW4pvLvV
 A55MopV/m6BelkD12H9dvsDk70TBCTEF2zigUu7FXgwxvQ+31gYrqEyLV/tB07EjW2Am4HrZlCa
 KYA0sdeSHVhj8OJI96Lvd017CyAAmGOazDb+uKtf85P8ecDQoc9oXhl03VnDw7pCD07YqR83V7u
 JFhit8buAsP3Me8OTPOSD4HxvMVhTnxHo3EOmZU7N2FPyxmDsXPcFlvUzozNA6v/LWkBhh6EfgC
 ub8=
X-Received: by 2002:a05:6214:e8c:b0:6f5:3f55:343c with SMTP id
 6a1803df08f44-6f54c485691mr8142366d6.32.1746644852262; 
 Wed, 07 May 2025 12:07:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFddC6LvPemOzVaOI1rmGvtmgqlUNJERmf6TfXWMPVBOvZQ+oe3+Tt6lyYKyvPrTg++r4bFYQ==
X-Received: by 2002:a05:6214:e8c:b0:6f5:3f55:343c with SMTP id
 6a1803df08f44-6f54c485691mr8139626d6.32.1746644850051; 
 Wed, 07 May 2025 12:07:30 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f54268da00sm17930576d6.56.2025.05.07.12.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 12:07:29 -0700 (PDT)
Date: Wed, 7 May 2025 15:07:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 2/3] ci: Fix build-previous-qemu when the version tag is
 absent
Message-ID: <aBuvb1adcWnw3Jim@x1.local>
References: <20250507155835.31074-1-farosas@suse.de>
 <20250507155835.31074-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250507155835.31074-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, May 07, 2025 at 12:58:34PM -0300, Fabiano Rosas wrote:
> Stefan reports that during QEMU release, pushing a series with the
> VERSION bump commit, but not pushing the new git tag in the same
> command will cause a failure of the build-previous-qemu job at the git
> fetch step.
> 
> Since the job is intended to produce a build of the previous QEMU
> version for consumption by the migration-compat-* jobs, there's no
> reason to produce a build of the release commit because the migration
> job would end up testing the release against itself.
> 
> Skip the job when VERSION contains the newly release version number.
> 
> I'm opting for 'exit 0' for both the build and the test jobs because
> allow_failure would mask any real error in the jobs. It also avoids
> having an orange ! on every release pipeline.
> 
> Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

This is better than before for sure:

Reviewed-by: Peter Xu <peterx@redhat.com>

Though nitpicks below.

> ---
>  .gitlab-ci.d/buildtest.yml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index ccf69fb8dd..159bdde2e8 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -203,6 +203,11 @@ build-previous-qemu:
>      GIT_FETCH_EXTRA_FLAGS: --prune --quiet
>    before_script:
>      - source scripts/ci/gitlab-ci-section
> +    # Skip if this series contains the release bump commit. During the
> +    # release process there might be a window of commits when the
> +    # version tag is not yet present in the remote and git fetch would
> +    # fail.
> +    - if grep -q "\.0$" VERSION; then exit 0; fi
>      - export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v\1.0/' VERSION)"
>      - git remote add upstream https://gitlab.com/qemu-project/qemu
>      - git fetch upstream refs/tags/$QEMU_PREV_VERSION:refs/tags/$QEMU_PREV_VERSION
> @@ -226,7 +231,8 @@ build-previous-qemu:
>      # Use the migration-tests from the older QEMU tree. This avoids
>      # testing an old QEMU against new features/tests that it is not
>      # compatible with.
> -    - cd build-previous
> +    # Skip if build-previous-qemu has failed.

This is inaccurate?  As this job could only run if the dependent job
succeeded IIUC (aka, exit 0 means success).  Meanwhile..

> +    - cd build-previous || exit 0

.. It'll be nice if we could still fail this job if something wrong
happened in build-previous..

Maybe it's clearer we check .0 here too?  It's oneliner so we could dup it
I guess.  I wished the CI jobs can have nested "rules:"..

>      # old to new
>      - QTEST_QEMU_BINARY_SRC=./qemu-system-${TARGET}
>            QTEST_QEMU_BINARY=../build/qemu-system-${TARGET} ./tests/qtest/migration-test
> -- 
> 2.35.3
> 

-- 
Peter Xu


