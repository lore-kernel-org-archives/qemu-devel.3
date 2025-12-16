Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C18D637B3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 21:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVd2k-0003ow-Ez; Tue, 16 Dec 2025 16:57:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVd2f-0003oh-Pb
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 16:57:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVd2e-00056I-8L
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 16:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765922231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CLnbf5pAyTL5Dylp0Rt+OhZbutRpz7ZCVLWVEnF4kRI=;
 b=EsXmAZGyYTtZn/tVTIAQShQZJzgXPtzXgCEj0+V7CgfM07viXm9KSAQm/2xcQKTA1/rMQU
 DqNf4Q6OasbSI192JtVBMz98VlhTjxvsOIQ9mDbU3y8ibr1lNwHOF4n7S4waWFXElpXmvV
 c4VrV8pqixPG/S6jz5H9FV/WNgNp8bE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-mbsAWuIJNiOLmAN615HfxA-1; Tue, 16 Dec 2025 16:57:09 -0500
X-MC-Unique: mbsAWuIJNiOLmAN615HfxA-1
X-Mimecast-MFC-AGG-ID: mbsAWuIJNiOLmAN615HfxA_1765922228
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-bc09a8454b9so11869880a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 13:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765922228; x=1766527028; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CLnbf5pAyTL5Dylp0Rt+OhZbutRpz7ZCVLWVEnF4kRI=;
 b=nXLdsqsdlcc67L/umygOL4W/+YKN2Yj8zPvoaHcjsrX3W0rTd/+JswQCQikz8xROiA
 Yqek43pR2foQ3T5DqzIqDU+gUX/vJ20+wBBaA+2+ExmmZVCYWOW4FFhBv+kL/gWrD06i
 P27lvuFxlB6utzY16KFvPP1KtJrw0UeG1y2+qJBt5ZZAnNRq6R7Y/qvtN7IzzgDeMH4D
 iReKwpPMMYVDKhKAxsomIbvJLxytUsWBEE7aa97XKVDruT+AvjjvANerhI67OM6nid9w
 jKBRhvU9lXD3h6A6UinxlSj27ytdZ2ysdmUu2OnMLp979uuc9NYrVMuiAMkjBaNckXxJ
 Um+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765922228; x=1766527028;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CLnbf5pAyTL5Dylp0Rt+OhZbutRpz7ZCVLWVEnF4kRI=;
 b=SkF2t75BgniiHQDXcsXh80M3cBzsIW8Tm+vLd+Epwo4OMlYqZcDLAdYdNW7L2eN9Oa
 761nUjO1k3q6udB/um0wrwhNZ8fnBO2SrzKJ+kmM+IkJkCmi0Xy7P/QQhS6jRsXAwjPY
 66Yes1MKyMxuDGbX5hJOIfAiT+fpNMSb/8yn5aU9Lhha4m6KYBUNW+/REM5deof0gZQM
 89HcE8BWJdUSmXhVWis577aiPbDzjg3PDMCSLvgqlwELOqxQiNQ5MtZJQSR0zmGg//Fi
 ZpuKZdl8c/6IDUbgyIWl2k/2chNU+nccziRMvZCe1EbUcWJDc85PqzeAMj3z4aWa0ZvE
 1eKw==
X-Gm-Message-State: AOJu0Yzsnl3yfoumA2KwTD1ZsmoBQ1QQbXBaoNzxy56J17c2phNuuBHE
 kQvmiNTFi7/FPyse0TTUlYV3U+AyNdPJWm9Jf7lYO4mfmrVU/QvtKUrlhiUpdoalksGpyk3vbjN
 ZiTom6J3ABCn8vZnxlqxr/sKwIohNFlirWfATIjFjK1HCyOfvb/63Hl9R
X-Gm-Gg: AY/fxX4RY3lTxQNxSITK8NadN6Wexvewwu0pXkXe5mevy2W4b5MvmIkjctSwwXCSSoz
 /Iym84PeLdJxue0WTBxGMyxf5pPxxbZPiDu9NIN+56yJKyUnrjTuo6GD4Uyb1eXpmWY4UTyEN3v
 xFcL080KY+dmR7mhRNM1zf7lAQ/7RyvEc/fu3961NvbJxPsCsCbPg76xBPmS7EHF6zpjNpcBTB8
 BpqHIFy0RTifa8AH+1WCJ20bR8P5WZSFlihm9h25VRIlSHzj30ShtWlTJ1CyaecPxRurmZwhToG
 BwIo8FERrBlZ5oyFkE1v7aSpteH4Zezx6Po9LKocBrFAbZDu2v/TXjeJbJnpWJkZWR7tzwAB4+X
 WTAc=
X-Received: by 2002:a05:7300:f78f:b0:2ae:5ba4:a8a6 with SMTP id
 5a478bee46e88-2ae5ba4add2mr454370eec.35.1765922228354; 
 Tue, 16 Dec 2025 13:57:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG60jpOiej97uvWClnm+5ZZ0MMX5HafjrgtADIB+guhOVFjOroVTbwdrhyAQ6e0BHLCn3XQVA==
X-Received: by 2002:a05:7300:f78f:b0:2ae:5ba4:a8a6 with SMTP id
 5a478bee46e88-2ae5ba4add2mr454356eec.35.1765922227858; 
 Tue, 16 Dec 2025 13:57:07 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11f2e2b46f5sm55521211c88.5.2025.12.16.13.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 13:57:07 -0800 (PST)
Date: Tue, 16 Dec 2025 16:57:02 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 25/51] tests/qtest/migration: Pass MigrateCommon into
 test functions
Message-ID: <aUHVru0XJOSPTZAh@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-26-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-26-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Dec 15, 2025 at 07:00:11PM -0300, Fabiano Rosas wrote:
> With the upcoming addition of the config QDict, the tests will need a
> better way of managing the memory of the test data than putting the
> test arguments on the stack of the test functions. The config QDict
> will need to be merged into the arguments of migrate_qmp* functions,
> which causes a refcount increment, so the test functions would need to
> allocate and deref the config QDict themselves.
> 
> A better approach is to already pass the arguments into the test
> functions and do the memory management in the existing wrapper. There
> is already migration_test_destroy(), which is called for every test.
> 
> Do the following:
> 
> - merge the two existing wrappers, migration_test_wrapper() and
>   migration_test_wrapper_full(). The latter was pioneer in passing
>   data into the tests, but now all tests will receive data, so we
>   don't need it anymore.
> 
>   The usage of migration_test_wrapper_full() was in passing a slightly
>   different test name string into the cancel tests, so still keep the
>   migration_test_add_suffix() function.
> 
> - add (char *name, MigrateCommon *args) to the signature of all test
>   functions.
> 
> - alter any code to stop allocating args on the stack and instead use
>   the object that came as parameter.
> 
> - pass args around as needed.
> 
> - while here, order args (MigrateCommon) before args->start
>   (MigrateStart) and put a blank like in between.
> 
> No functional change.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

This looks fine,

Reviewed-by: Peter Xu <peterx@redhat.com>

I'm just curious, is it required to touch all these lines?  E.g.,

> ---
>  tests/qtest/migration/compression-tests.c | 127 +++---
>  tests/qtest/migration/cpr-tests.c         |  71 ++--
>  tests/qtest/migration/file-tests.c        | 184 ++++----
>  tests/qtest/migration/migration-util.c    |  26 +-
>  tests/qtest/migration/migration-util.h    |   8 +-
>  tests/qtest/migration/misc-tests.c        | 108 ++---
>  tests/qtest/migration/postcopy-tests.c    |  80 ++--
>  tests/qtest/migration/precopy-tests.c     | 354 +++++++---------
>  tests/qtest/migration/tls-tests.c         | 485 ++++++++++------------
>  9 files changed, 642 insertions(+), 801 deletions(-)
> 
> diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
> index b827665b8e..845e622cd5 100644
> --- a/tests/qtest/migration/compression-tests.c
> +++ b/tests/qtest/migration/compression-tests.c
> @@ -31,30 +31,25 @@ migrate_hook_start_precopy_tcp_multifd_zstd(QTestState *from,
>      return migrate_hook_start_precopy_tcp_multifd_common(from, to, "zstd");
>  }
>  
> -static void test_multifd_tcp_zstd(void)
> +static void test_multifd_tcp_zstd(char *name, MigrateCommon *args)
>  {
> -    MigrateCommon args = {

Can this be changed to:

       *args = (struct MigrateCommon) {

So as to avoid touching most of below across whole tree?

> -        .listen_uri = "defer",
> -        .start = {
> -            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> -        },
> -        .start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
> -    };
> -    test_precopy_common(&args);
> +    args->listen_uri = "defer";
> +    args->start_hook = migrate_hook_start_precopy_tcp_multifd_zstd;
> +
> +    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
> +
> +    test_precopy_common(args);
>  }

-- 
Peter Xu


