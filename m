Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A423D6E2DD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 19:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWJJz-0001FZ-8P; Thu, 18 Dec 2025 14:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWJJq-0001Di-2e
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 14:05:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWJJo-0003Fy-CN
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 14:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766084742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vcUrmDDl+qtL0kR0Yte+8l25DTAryA7/gu21iKp2lVc=;
 b=b738I/bEh/bv3t1JAJBR71cj6dFGRHgw9suv0VYh6unADryknxoK8dBrMpNjr3wZbH5BTs
 JJoSZJN3RWhm2oUu29/WMUtAiL0ntan0B9c/V7uj3mLIp5mF8O3+7EwOUrnzXmSDI9FhCF
 75+oyEqdJHNzCh+zWXgRsBkCdWTGvLU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-L-9ox3iiMfKUfGNKqFnLEQ-1; Thu, 18 Dec 2025 14:05:41 -0500
X-MC-Unique: L-9ox3iiMfKUfGNKqFnLEQ-1
X-Mimecast-MFC-AGG-ID: L-9ox3iiMfKUfGNKqFnLEQ_1766084740
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4ed7591799eso20389021cf.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 11:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766084740; x=1766689540; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vcUrmDDl+qtL0kR0Yte+8l25DTAryA7/gu21iKp2lVc=;
 b=Elvu3j0d75eyxbuQzi2uvU5Y16cihEvLedxZ6OxayUQhK3rl1SIe8ZDknCtHHuuQ5b
 H0GrMgv1cT4GMZiQfe0f1yHOjA8/v32dmJ7ksNgbfytGxhTWqyWEMkf2uuqxs30MKsxW
 3vsXxt8RP0W64i3XSpEulYpykaf5/0fIw35XvLmqOs6ivyY55p+X06igdXly3kwgHTtK
 dOrtCDDsm9K3Kg1litwjumDOErUGXO38dQamx8JdICV3DXpDFFPm3Zhj/b9kgD8cVg0a
 RpjQZdP2DK8rgbYvHojS4spDx923a7BjU4vS9AeKVDWIn4lVxyPJR3TSazKtAWfLn38Z
 tQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766084740; x=1766689540;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vcUrmDDl+qtL0kR0Yte+8l25DTAryA7/gu21iKp2lVc=;
 b=QZfQlVAWoUCMc9a37UtHY6ipcYmFzNQDSPa1MGvwvCxCSBobCdTja3EJ9+h96HOoK/
 m9vsQn+S0hq1aHnMQO59jQwfEIndtCA6L1vadwomxucCW9Gz8782/XqQlJetJaNd46Io
 AIVV6pQ8Wu7ZQ6N7y7+WAT8GkwKUfxp04fPjJhSih/iot74uBUKPF98X+bTssxWD3vyc
 fwJp5ah1ljx9CG6C6XZIsnT2Wj92bHd+ByZbVt3o8hS1ttnNJkJGtnoodG87hshqq2Vw
 cFUja9lKkNEz9rIjvISnVy5thnSvaDtr2IfgHflWmvBqW3olvPRh5UqvRLgyW1gBsAWr
 7twQ==
X-Gm-Message-State: AOJu0Yxnz81i1Si+WofYeylrXTy/CXgdx5hPLdNpNEtm6156hUiPvM9P
 a+w6LhbSpa1BnD6IBqITx3Y2GNJEebEe8Sf8qxgYrJei06pisWY8p1b3lX7YsjeJ/l7ziwm+j18
 eI43XE5b59xOr7q9DT06jrAHMAH0SpR+7EuAox/ZFzTIgvvKImYr5xHwn
X-Gm-Gg: AY/fxX6WpEfFxOaTWJeetLMcmWuCYpdFvKiscsAsE96Anj8TvYA2H5nFMMHIZNENf2q
 KNhVyvcpP2FjgzwKxmNR4W0+2Y7is4j+Uf6yDYuXKRGiPgoaqy5pchzGMYkWWDzyRJQPPvLW2WU
 gJSnVyaAERmUQGC3fwpkedkMu+2XjfGqgVm/SKWb0g1v9v2cPDHd62QgHPRY6b9ey4AmBb0TsZ7
 Nq7PKFgVVNykQhyulZCXmhbC3T8XXtGNmf3rG4na01xRYjgurtKXSUJYBMeUGpPGrxqxaqnu3Kk
 8UdJhNXY/W5XJDZnHH0Z/GMKJFTezXHR2NHsz4mqgmaSjTRn69UEAgZ+0V8VSc8lZNZwUwT1ltG
 ETGs=
X-Received: by 2002:ac8:7d85:0:b0:4ee:5aa:9c2c with SMTP id
 d75a77b69052e-4f4abcf6cb6mr3737431cf.8.1766084740436; 
 Thu, 18 Dec 2025 11:05:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwqktfdHYbWQ0S4+dHD/ctVJwoVaFepxR6pI+aFixUHhmGOH43qEgylfwhdREeIl7ndade4Q==
X-Received: by 2002:ac8:7d85:0:b0:4ee:5aa:9c2c with SMTP id
 d75a77b69052e-4f4abcf6cb6mr3736871cf.8.1766084739854; 
 Thu, 18 Dec 2025 11:05:39 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f4ac66a1aasm74841cf.33.2025.12.18.11.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 11:05:39 -0800 (PST)
Date: Thu, 18 Dec 2025 14:05:38 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 37/51] tests/qtest/migration: Add new hook with data
Message-ID: <aURQgjrsVhlfu8kr@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-38-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-38-farosas@suse.de>
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

On Mon, Dec 15, 2025 at 07:00:23PM -0300, Fabiano Rosas wrote:
> Add a new start hook that takes an opaque pointer so the tests can
> stop having to nest hook calls.

I saw that this hook is also removed after the whole series applied.. maybe
it should be mentioned here.

> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  tests/qtest/migration/framework.c |  8 ++++++++
>  tests/qtest/migration/framework.h | 16 ++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index f740228cf2..b9bbdca6a9 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -591,6 +591,9 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
>  
>      if (args->start_hook) {
>          args->postcopy_data = args->start_hook(from, to);
> +    } else if (args->start_hook_full) {
> +        args->postcopy_data = args->start_hook_full(from, to,
> +                                                    args->start_hook_data);
>      }
>  
>      migrate_ensure_non_converge(from, args->start.config);
> @@ -868,6 +871,9 @@ int test_precopy_common(MigrateCommon *args)
>  
>      if (args->start_hook) {
>          data_hook = args->start_hook(from, to);
> +    } else if (args->start_hook_full) {
> +        data_hook = args->start_hook_full(from, to,
> +                                          args->start_hook_data);
>      }
>  
>      if (args->start.incoming_defer && !args->start.defer_target_connect) {
> @@ -1062,6 +1068,8 @@ void test_file_common(MigrateCommon *args, bool stop_src)
>  
>      if (args->start_hook) {
>          data_hook = args->start_hook(from, to);
> +    } else if (args->start_hook_full) {
> +        data_hook = args->start_hook_full(from, to, args->start_hook_data);
>      }
>  
>      migrate_ensure_converge(from, args->start.config);
> diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
> index 65c656e0d3..2584599f14 100644
> --- a/tests/qtest/migration/framework.h
> +++ b/tests/qtest/migration/framework.h
> @@ -65,6 +65,19 @@ int migration_env_clean(MigrationTestEnv *env);
>  typedef void * (*TestMigrateStartHook)(QTestState *from,
>                                         QTestState *to);
>  
> +
> +/*
> + * A hook that runs after the src and dst QEMUs have been created, but
> + * before the migration is started. This can be used to run routines
> + * that require the QTestState object.
> + *
> + * Returns: NULL, or a pointer to opaque state to be
> + *          later passed to the TestMigrateEndHook
> + */
> +typedef void * (*TestMigrateStartHookFull)(QTestState *from,
> +                                           QTestState *to,
> +                                           void *opaque);
> +
>  /*
>   * A hook that runs after the migration has finished,
>   * regardless of whether it succeeded or failed, but
> @@ -196,6 +209,9 @@ typedef struct {
>      /* Optional: callback to run at finish to cleanup */
>      TestMigrateEndHook end_hook;
>  
> +    TestMigrateStartHookFull start_hook_full;
> +    void *start_hook_data;
> +
>      /*
>       * Optional: normally we expect the migration process to complete.
>       *
> -- 
> 2.51.0
> 

-- 
Peter Xu


