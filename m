Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946C7D65C66
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 15:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVtUs-0008E4-K0; Wed, 17 Dec 2025 10:31:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVtUS-00086M-LY
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 10:31:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVtUM-0004tw-Fa
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 10:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765985437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EtAYrSEVmR245Oj85NpGqSKszzA3+PPTTlMuly7njmQ=;
 b=MQwcgTGrYv+GVhEhYe7oLix2TUEIWcLWZW4liRJxop902f4CqkThQ7QfKu0wURpx71Kdk3
 RtWNz8Auuqc6fPzsSeYI7px56GrWzXJy3iBFdzuflGHDU70fDHG7uZG8oRU8/kBsmR347+
 rASdY7tKfnekPc5al4urZaA1xttED9s=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-NuzGypmfMqCpz2lq8H--6A-1; Wed, 17 Dec 2025 10:30:36 -0500
X-MC-Unique: NuzGypmfMqCpz2lq8H--6A-1
X-Mimecast-MFC-AGG-ID: NuzGypmfMqCpz2lq8H--6A_1765985435
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7bf5cdef41dso10006326b3a.0
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 07:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765985435; x=1766590235; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EtAYrSEVmR245Oj85NpGqSKszzA3+PPTTlMuly7njmQ=;
 b=HQhSd3skgd0z3Xgbz8n8iEuet0e1wdew3YNIsXAUZGnLyrQOmmO1BbfqOjnaElg3te
 mTkH4RkZRTLZrwtN/ez4eoEGCxknuV3p0mb5FePorOkETpRnDFtGwD3olUa/A1GWCuIV
 tzghMV9mZ8D1qf2Fx361B0M5YTtg7CbgqUdYem5Oc4AuKNb4RcrdSuADPv4KGXIjnVAU
 xvJvqW80HccT7efHwt13TfBiQ7ZjVTwqoaj2tEWWPAgkBFnUfna4srUiYOc48FYTRhex
 KnyzVbvC3Do8dNrro+wOsdWf1/XRE2HCE+DwfZ9qHQ1jZxVNDgjaf18qk8Zsj9CWZ/YL
 xLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765985435; x=1766590235;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EtAYrSEVmR245Oj85NpGqSKszzA3+PPTTlMuly7njmQ=;
 b=sYT0BOrPdPWSCjpzB7GmWSprQFep7C3nFBOR2L2/5ES4Or7J2H6fI9Tl2selw4bKWJ
 xYGwtx8NeQhGKYpVTAhtsLx4mU02rPU5yxfMNJGWtuyhIAIoDLZabFZt3/TrKjPiDLD9
 NBjVg79dE8nMcjjcnR71BPIgGfvLmZ0Nl4PAng/oXOOv6BRBfhRu+5DjwqdQHJUyhzdI
 Y1quLnvUGUFEU6jlF4oXz4pN1QhBHmT7b884NSc+ZPQ1NeVY84pQRfCm9w0Yp+v5VPhN
 FeA4MewmXEq8Cfo7kcjp6+/8gJoJU9eCtMFkUQbKI7tjajJ7GNWkaFTXl958fhC1lZxL
 naAw==
X-Gm-Message-State: AOJu0Yw1IU6plpfVoqcm7zLMpOSP6c69T1CSOM7HjMLQkED4YvR/95+A
 54C/cHqHANWOPlNX5i9BNub3gqaod8PSOSc2OD5yC6zMkNJkaxF1JGyoIsQVS2KD7Ba+ixKMZXK
 UdOfyJdsHDLIEenURZkY9FIjFOw0awjtZeS8BuYuSu7+Jqt20nhEaLfoU
X-Gm-Gg: AY/fxX6NcKe1t93upPNH5mR6vX52YIAFKIUgbOoXwgXyRM+Me/6KMNDVSKVG9U+UVRi
 e0Ln3hpuZewYAQzXPZUafppGwvw9mulHE6fi4CP+OFlR5eRPFQ9oEh0DfK4LzOdSSNJtQfWXWgF
 n7Xq/zR1xiaJ6KsehpWUd6WaO+64Ac6ExP5uiNp77U0SjDbjxmGc7tMdvnJEBKVREYKELWYwvZe
 iX3yecKepXzRwlNjm7cvpw7Xaq3xzNCp47MD9x4124ItssCkDJtPyk7K1tzHKIgP2CKqYeg36gg
 MLwi9r+c8F5m97YMtuHrmS3sBB5FhFjN7S31ACczHA+nN3MxQALe4ClgqqT4YbhRkohHSBIAZVH
 FDoI=
X-Received: by 2002:a05:6a00:3311:b0:7f0:8031:70b8 with SMTP id
 d2e1a72fcca58-7f669a8e789mr16800741b3a.51.1765985434734; 
 Wed, 17 Dec 2025 07:30:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3xwiyrWGTr2BUbULYm8AUys4yVn8bpImlI83wdnLG8oN8hX5YQX8VgNCX5IqrBqiKaoi22w==
X-Received: by 2002:a05:6a00:3311:b0:7f0:8031:70b8 with SMTP id
 d2e1a72fcca58-7f669a8e789mr16800702b3a.51.1765985434090; 
 Wed, 17 Dec 2025 07:30:34 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7fcbc5a6d92sm3069644b3a.68.2025.12.17.07.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 07:30:33 -0800 (PST)
Date: Wed, 17 Dec 2025 10:30:28 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 27/51] tests/qtest/migration: Fix misuse of listen_uri
Message-ID: <aULMlFMCcGXWVEjd@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-28-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-28-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Mon, Dec 15, 2025 at 07:00:13PM -0300, Fabiano Rosas wrote:
> The listen_uri parameter is supposed to be used for the incoming
> migration while connect_uri for the outgoing migration. This is well
> documented in the header file.
> 
> However, due to -incoming "defer", some tests set listen-uri =
> "defer", which is fine. But then, being without another parameter to
> define the uri to be use in migrate_incoming, some tests have been
> misusing connect_uri.
> 
> Add a separate flag to denote "defer" and spare the tests from passing
> the string. Change the usage of listen_uri to it's original purpose.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration/compression-tests.c | 12 +++----
>  tests/qtest/migration/cpr-tests.c         | 17 +++++++---
>  tests/qtest/migration/file-tests.c        | 38 ++++++++++++++++-------
>  tests/qtest/migration/framework.c         | 12 +++----
>  tests/qtest/migration/framework.h         |  7 +++++
>  tests/qtest/migration/misc-tests.c        |  4 +--
>  tests/qtest/migration/precopy-tests.c     | 26 ++++++++++------
>  tests/qtest/migration/tls-tests.c         | 16 +++++-----
>  8 files changed, 85 insertions(+), 47 deletions(-)

Makes sense.

But there's one missing?  I'm staring at a tree where wholeset applied, I
can still see:

static void test_mode_exec(char *name, MigrateCommon *args)
{
    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                           FILE_TEST_FILENAME);
    g_autofree char *listen_uri = g_strdup_printf("defer"); <-------------

    args->connect_uri = uri;
    args->listen_uri = listen_uri;
    ...
}

The other question is, after this patch, can we assume connect_uri and
listen_uri should always be the same?  Can we merge the two already into
"uri"?

For the latter - not a request to do it in this series, I suggest we land
this series without keep growing, or you'll have endless pain rebasing..
However no hurt to discuss the next step so you can send them afterwards if
you see fit.

-- 
Peter Xu


