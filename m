Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE68BC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 21:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAFMS-0005lr-DL; Wed, 30 Apr 2025 17:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAFMQ-0005lT-Th
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 17:52:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAFMN-00016r-PM
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 17:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746049974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9qseGLC6OOs6xH9QIQgmXmXLWBwNv81/YkrZl8hkUec=;
 b=KO73SkG98ayTlRStuiW+ooLCa3mNFEPC9RPVZGEIS4+WH/N1HKJDYEaUBW8pKK7gDrX/m1
 8plONYVbGjW6pvDaTwCtoMN1h4USu2xEHo6KFCjG+6hyTz/p9zbLHsm76LnEynDfoaFx9N
 OY7AERURWc0AkFXopkC3djKHA1K2xxU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-yuQeOKlzOC2za-ih5ioCrA-1; Wed, 30 Apr 2025 17:52:51 -0400
X-MC-Unique: yuQeOKlzOC2za-ih5ioCrA-1
X-Mimecast-MFC-AGG-ID: yuQeOKlzOC2za-ih5ioCrA_1746049971
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-47699e92ab0so7469621cf.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 14:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746049971; x=1746654771;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9qseGLC6OOs6xH9QIQgmXmXLWBwNv81/YkrZl8hkUec=;
 b=H0g0RUXKes/QshjiBfYmhQpqAvY+lpG+pU7cujZ7FgXrBeWJroELQbBJEkbuxmomaY
 bm+1qFh/lYWyH8NGD52uEwMHVpw/Q6BVv4Vn0iPzNUFzvsZlaukqK0K9rhRkjICnecAp
 hq8C2ubJy0hlTurbQ/daOiVmSQP3fBdW5CqZjxV1hZUXe/6StqqGzPizJowK7E7awaJ3
 yo4w4Zh9RgRss2oC+zZqQyVf9+3588k3bGoMDGGpm84OksOE0kNQgtr+Rel5bsquOZz7
 oU2fZfOlMJ+dF7U9w9Tkh3iUYA8nbJZ5hWSymYuGchY6hfaOjuOXzLSZx22j7bpdAejA
 6bdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViRpnhV3RNcgaAQNSbNV9tIb3W+sU2R9eNv/yLh3P70DmKvk/34yEUKfLF9Xqb5+2vu5m6hTcSPUlu@nongnu.org
X-Gm-Message-State: AOJu0Yx1y8Wi/O6g3UsSMmDD0+9QdEjpN6BNnfB1/fcGsjR/SUD0kaUG
 NFzKC6wa0y+QaWaS6JtrvYQOJt9DtQ+lEP2KAygWqrhMLAhjYFGoytNQMkyYdKrhfpBwBOuPxL9
 jIIMCIVeZEU0qiFH3umdBoyRjIrOAMQIs9yZATHdUXnlojRXhZWJY
X-Gm-Gg: ASbGncuHpVfkrDLrLjJN1gfbZXfFti7a/apbhAoe2b70OyKRMqRVejIUVIHh2VblM7m
 W6IzIc3IrrVN/5Npk79UEzcBhYFTpY9UXfZqp8cl4x70FNB2DPEWtNTjE+M1fO4zoU8MUICl6dE
 Mbk2pKVWRVDhbPJ6ENPgpqOvk7K1WqOQHADXhyqA8Sch+hAqpachgXllgdPw4Q3AHwuEIj3vipq
 K35ts8Ag7UYMNwD1kPs3rZgkYm9mc69b0V2yppOVCqd5fgDmkiyH963W/+VUZWdshaEb2lue8/c
 mzs=
X-Received: by 2002:a05:622a:4cc6:b0:476:8960:d1a3 with SMTP id
 d75a77b69052e-48b208945aemr721951cf.14.1746049970897; 
 Wed, 30 Apr 2025 14:52:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhAAfQjI2GPMBFrUF/XIuYP7ZUWuftzR+01qlKmxjCF6GrxpvtciGAfgIXql5HCuJFYy4Lwg==
X-Received: by 2002:a05:622a:4cc6:b0:476:8960:d1a3 with SMTP id
 d75a77b69052e-48b208945aemr721651cf.14.1746049970588; 
 Wed, 30 Apr 2025 14:52:50 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-48b0671e2casm1128241cf.24.2025.04.30.14.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 14:52:50 -0700 (PDT)
Date: Wed, 30 Apr 2025 17:52:47 -0400
From: Peter Xu <peterx@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jack Wang <jinpu.wang@ionos.com>,
 "Michael R . Galaxy" <mrgalaxy@nvidia.com>, Yu Zhang <yu.zhang@ionos.com>
Subject: Re: [PATCH] qtest/migration/rdma: Add test for rdma migration with
 ipv6
Message-ID: <aBKbr3aVAxAwt2rD@x1.local>
References: <20250327021234.264161-1-lizhijian@fujitsu.com>
 <aBFAIflmJns_nVIm@x1.local>
 <78c811ed-d6a2-4811-9ac8-48c5c93a2fed@fujitsu.com>
 <6aaafc7c-9876-45da-8cca-5b670b8ccc50@fujitsu.com>
 <396fcfe6-7ddb-41e7-ae28-e5210dea7dd7@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <396fcfe6-7ddb-41e7-ae28-e5210dea7dd7@fujitsu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

On Wed, Apr 30, 2025 at 09:49:40AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 30/04/2025 16:48, Zhijian Li (Fujitsu) via wrote:
> >>> stderr:
> >>> qemu-system-x86_64: cannot get rkey
> >>> qemu-system-x86_64: error while loading state section id 2(ram)
> >>> qemu-system-x86_64: load of migration failed: Operation not permitted
> >>> qemu-system-x86_64: rdma migration: recv polling control error!
> >>> qemu-system-x86_64: RDMA is in an error state waiting migration to abort!
> >>> qemu-system-x86_64: failed to save SaveStateEntry with id(name): 2(ram): -1
> >>> qemu-system-x86_64: Channel error: Operation not permitted
> >>> **
> >>> ERROR:../tests/qtest/migration/migration-qmp.c:200:check_migration_status: assertion failed (current_status != "failed"): ("failed" != "failed")
> >>> qemu-system-x86_64: warning: Early error. Sending error.
> >>> qemu-system-x86_64: warning: rdma migration: send polling control error
> >>> ../tests/qtest/libqtest.c:199: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
> >>>
> >>> So running the test also needs root?  Is it possible we fix the test so it
> >>> can also be smart enough to skip if it knows it'll hit the "cannot get
> >>> rkey" error (even if it sees the rdma link setup)?  Not something urgent
> >>> but definitely good to have.
> > It seems it's a security problem, I have no a good idea yet.
> > 
> > Let me see see...
> 
> Another workaround is update the 'ulimit -l' to >=128M for a non-root user(in practice
> this value works well on fedora40)

OK so it's about the locked mem.. thanks for looking.

> 
> So we would have something like this:
> 
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index 9f7236dc59f..1f24753c5a5 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -101,6 +101,26 @@ static void test_precopy_unix_dirty_ring(void)
>   
>   #ifdef CONFIG_RDMA
>   
> +#include <sys/resource.h>
> +#define REQUIRED_MEMLOCK (128 * 1024 * 1024) // 128MB

How does the 128M come from?  Is it correlated to the VM size somehow?
Btw, migrate_start() says for x86 we use 150MB VM.

When you feel confident, feel free to send a formal patch, it can also
include the reposted version of the current patch so that can be a series.

It'll also be great if you could make sure they apply on top of:

https://gitlab.com/peterx/qemu/-/tree/migration-staging

Thanks,

> +
> +static bool mlock_check(void)
> +{
> +    uid_t uid;
> +    struct rlimit rlim;
> +
> +    uid = getuid();
> +    if (uid == 0) {
> +        return true;
> +    }
> +
> +    if (getrlimit(RLIMIT_MEMLOCK, &rlim) != 0) {
> +        return false;
> +    }
> +
> +    return rlim.rlim_cur >= REQUIRED_MEMLOCK;
> +}
> +
>   #define RDMA_MIGRATION_HELPER "scripts/rdma-migration-helper.sh"
>   static int new_rdma_link(char *buffer, bool ipv6)
>   {
> @@ -137,6 +157,11 @@ static void test_precopy_rdma_plain_ip(bool ipv6)
>   {
>       char buffer[128] = {};
>   
> +    if (!mlock_check()) {
> +        g_test_skip("'ulimit -l' is too small, require 128M");
> +        return;
> +    }
> +
>       if (new_rdma_link(buffer, ipv6)) {
>           g_test_skip("No rdma link available\n"
>                       "# To enable the test:\n"

-- 
Peter Xu


