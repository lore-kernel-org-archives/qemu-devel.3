Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD46AD58D72
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 17:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFdCd-0007wT-RK; Mon, 25 Nov 2024 12:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFdCb-0007w1-Re
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:48:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFdCa-0001GW-BG
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732556926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1nOGoPVZzN353iDJZzkuNXnEmcEvYTkZNAZ4tk6pm+o=;
 b=X6IppYA9MyrMbJ4wQ8MmGFFtq84XeHMduumXtT/rW6eo2wlXnanZB9XiEbhaS0CbhBgl+I
 THc08ycbxJwEDtaC+h3QsixbopWdNdtwEcJiNNKlyoidnRz9Qnjj1t3NYrXak8SJnxQQI8
 0oLMdJRYI7KlU35vkPH1S+wzLJByHn4=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-e-9-hJnkNeW8bznqs-XRHQ-1; Mon, 25 Nov 2024 12:48:45 -0500
X-MC-Unique: e-9-hJnkNeW8bznqs-XRHQ-1
X-Mimecast-MFC-AGG-ID: e-9-hJnkNeW8bznqs-XRHQ
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-8418f68672eso132493239f.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 09:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732556925; x=1733161725;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1nOGoPVZzN353iDJZzkuNXnEmcEvYTkZNAZ4tk6pm+o=;
 b=crxC3uWWwA3+HZqrJLKcc9Q793857Zu+N5iMtf5ejiDRD1lp0Sx48fwPz1o5plRtWB
 M/CSn7fXWMGgcr2ZmWXPXvdkVj/ebvAZU/sZHbPIIbyLT2pPVj0C1ZlMTTgDCjviqyPD
 TZ6KTPRE5pVnqFbhfmtu812vA6NprOvItrn6/HTB5zotYyq4GBvTd4cSdQFj8104NS+i
 JTiqXTj2XCsq5bjEUOdZNUjb5ijWDiza5HqV5nas+ky8IF2JFvcY1SgQpnLfc0+JSkEb
 JCGI+xXwZyMIxOJQ4cmLCfCZKt1Ph8sXAB+5ZoSjxXEHjFd6WLXSB6NcA3lh8+XofYZL
 7Nyw==
X-Gm-Message-State: AOJu0YzVSny+LpBGp042v75pQpZ65QLZ5TCtWx0LpH8nF1/vFYQRL9BD
 wvJbyVqrargH1auRFP31sBI55nZJ/CXijAr+jaStptMAeKLG4HOgyGoVBeCDlqo0oaib/5kFLTs
 St354pneg8gOGCu9JSx7ZZqoHwS2aPNPG/hgZ2QgjwM+CKIy9PWLk
X-Gm-Gg: ASbGncuC6JWszqAxr+77iskq4VTeu/+/StF/uyrZUbi9qWzq2ME6tbhlQKlFzvvOWNv
 bO46RNitU/rTpQAUKJzBdZbEjYOE4maca64/aZ9+ZTqIQbFTuow0aOcC8cndqvd/UVNfBa/3BFv
 VrJd28CD5FhcyEpBWWByrKMx+H9PHu/CpDDXBa5taJcM+WrJ74L7a2+5I932g3baevkJgBgDw3A
 iI8+IF8qhtdYXEqUKM2yF4SDE1BaFYoay9jiAFGmLpAsUcVMuZuS7lw0jQ1DWSXroHpKA+ygbU0
 pR3/d0E2v6M=
X-Received: by 2002:a05:6602:2b85:b0:83a:b43b:da89 with SMTP id
 ca18e2360f4ac-83ecdd0bd18mr1458070539f.10.1732556924951; 
 Mon, 25 Nov 2024 09:48:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuRdcVG1/TkkxCFIOW6qYjgMU2oWEvgCNDXiGnSHFI8bTGqd5A7S9onRaGDoYNTeDvCI4yfg==
X-Received: by 2002:a05:6602:2b85:b0:83a:b43b:da89 with SMTP id
 ca18e2360f4ac-83ecdd0bd18mr1458068839f.10.1732556924662; 
 Mon, 25 Nov 2024 09:48:44 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-841a54abb68sm35753639f.25.2024.11.25.09.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 09:48:44 -0800 (PST)
Date: Mon, 25 Nov 2024 12:48:41 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 12/22] tests/qtest/migration: Split TLS tests from
 migration-test.c
Message-ID: <Z0S4eVeFIAgGHiyY@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-13-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113194630.3385-13-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Nov 13, 2024 at 04:46:20PM -0300, Fabiano Rosas wrote:
> The migration-test.c file has become unwieldy large. It's quite
> confusing to navigate with all the test definitions mixed with hook
> definitions. The TLS tests make this worse with ifdef'ery.
> 
> Since we're planning on having a smaller set of tests to run as smoke
> testing on all architectures, I'm taking the time to split some tests
> into their own file.
> 
> Move the TLS tests into a file of their own.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/meson.build                |   8 +-
>  tests/qtest/migration-test.c           | 788 +-----------------------
>  tests/qtest/migration/test-framework.h |   6 +
>  tests/qtest/migration/tls-tests.c      | 791 +++++++++++++++++++++++++
>  4 files changed, 804 insertions(+), 789 deletions(-)
>  create mode 100644 tests/qtest/migration/tls-tests.c
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index bdb9512510..9ad9f0dc65 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -337,11 +337,13 @@ migration_files = [files(
>    'migration/migration-util.c',
>  )]
>  
> +migration_tls_files = []
>  if gnutls.found()
> -  migration_files += [files('../unit/crypto-tls-psk-helpers.c'), gnutls]
> +  migration_tls_files = [files('migration/tls-tests.c'),
> +                         files('../unit/crypto-tls-psk-helpers.c'), gnutls]

Nit: not a meson expert, but I think we could simply use files(A, B)
instead of files(A), files(B)..

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


