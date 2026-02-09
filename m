Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDF8E81BD3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 16:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpTqa-0003z3-8B; Mon, 09 Feb 2026 11:10:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpTq2-0003t4-Em
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 11:10:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpTpz-0007Gz-7t
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 11:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770653407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DCaiAlBvAUplbRFd6E4sqlHLaxO0QdoSD58SLhn3I/I=;
 b=aqaNCRI1Y7p7ErLNQLSB2UKK1l8TEtndRQIT5r/amFlcM5AzI3w84VPkUXQR/7c/oJPRyW
 8zuaCP9UWhh6PrY3mSsYbfMnCFNCpvL1Ja0fVtEPRXut8fWulUKZ4pY2X19WG5czk1xD3q
 1FG6DxRcVWPRj/AcOFUGdWv5Nv5/E5k=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-DF9pAwWnMxafYcABp8pTag-1; Mon, 09 Feb 2026 11:10:05 -0500
X-MC-Unique: DF9pAwWnMxafYcABp8pTag-1
X-Mimecast-MFC-AGG-ID: DF9pAwWnMxafYcABp8pTag_1770653405
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8946f51b8c8so129404326d6.3
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 08:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770653405; x=1771258205; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DCaiAlBvAUplbRFd6E4sqlHLaxO0QdoSD58SLhn3I/I=;
 b=elUV+iz5CbajPoQ0oz0+sl0K+V7cUQexwObUs3klFYOPkIurjdf/n48g5Bw2NBecdq
 abC/XqFsmhEV1Lc0DmYKRH/p+/0SZ6izMyvEoYrcjB6ChOaT++aSeHWSWcCGYLv3Mhj/
 G6sdXYSWY0uN4nWY9HJbrgmU2M8QWpnSpmEUpztfFMKMH3xLlOv7iqWaTjFOv2kqdFNb
 tH1w8XuyeWkeIFy1NFT9Zqb3ARxJm2bW2LmVjOgSUz43fNdDCHXy33As2BFsHhUkItO9
 D0FmhTMHRf5x4YowR9vDJYcFkjBqIOv7tCifFv4C7x+/XxH+cmXSlcC74J1AkUmG2Zvh
 siAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770653405; x=1771258205;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DCaiAlBvAUplbRFd6E4sqlHLaxO0QdoSD58SLhn3I/I=;
 b=lL8mIMN2Qkpr66BzpRHKO1LEFozJnWOKjWgoGRENhXOJw3lTnGMDLHl/qVmPOYGgr+
 f8/TZi63fxOuZdU3F5f0EniShHeQt9Bp18Wle3gpeT/9gm/FwbCMDBDNgppbH/gA+Vwr
 6+/vgTfjygtkqgZog5KlSN4ykez/DOUO9U0dGe8bVKJEEWiwEu0OzBnHFYJWhamrQee5
 EB2f+aVjAsGK6T6VAEO4fciSDUCMHQLNez8PftoNcTl2BP067K0GetzCFkmP/GuPwRYS
 kzF2Ia1RnWvExVafl8W5nLor3d0ANwbbrl9Nkz5FbAS7UgW+NgfoqhR21mOTYVw8Kc9Z
 B8xw==
X-Gm-Message-State: AOJu0YxIFCQ0TXjL7HxC3hUmbfrGb9kCEEMKHEb570wbfK5E5hJTAc8h
 yV05X+uGDjVyT3SOyzvU+OY/zdq1OIug3nxo2JIyAda05ZdFbwQotCwgVTGsSozOgZ454Y6PkLt
 UUnlVWKYlLelIdRg93eNl5BCBvN/A123o3vn/rUibs+vMyZQu7rz2Kpek
X-Gm-Gg: AZuq6aKKO118ssJNrwXYneCfc/jQMi1qxIMQXLv/+pkMyvPvF/w5M4W+rB1H2W+/Rd1
 Kd7RRakg2IOKJBxUPdMCiQfaVj8NpQ243a0QEIsbonMdnOXwMiKSIbwWCnBmzw+ggmonh9XrjNf
 AusxmrLf9x1cs5I2zgIae8IBPT72qxEMyaanm3Hg0t4Smkpvc5D8x2I+GmlXGlPSLbuvA8seYKC
 hqdKPhc5MnCgVBfOAYqORWAtKqj3zgveiCQvwoB2rZdeIy0n4yKuuIqJxMnBtFxokazFlRbK7aj
 j5nQkR/lY+pd94NodLN7TXULSG41Y+Y5gy1Yx4xGMIK5fPCRSTm6UeBhq1t6wTltts4+f3Lsu+b
 bmOk=
X-Received: by 2002:ad4:5b86:0:b0:897:1ff:a7c with SMTP id
 6a1803df08f44-89701ff0d32mr44888786d6.1.1770653404803; 
 Mon, 09 Feb 2026 08:10:04 -0800 (PST)
X-Received: by 2002:ad4:5b86:0:b0:897:1ff:a7c with SMTP id
 6a1803df08f44-89701ff0d32mr44887836d6.1.1770653404040; 
 Mon, 09 Feb 2026 08:10:04 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8caf7aef19asm839447785a.21.2026.02.09.08.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 08:10:03 -0800 (PST)
Date: Mon, 9 Feb 2026 11:10:02 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v5 03/16] colo: Setup ram cache in normal migration path
Message-ID: <aYoG2rzTkfk6SDiR@x1.local>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
 <20260203-colo_unit_test_multifd-v5-3-57508b7389f6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260203-colo_unit_test_multifd-v5-3-57508b7389f6@web.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 03, 2026 at 11:15:09AM +0100, Lukas Straub wrote:
> Since
> 121ccedc2b migration: block incoming colo when capability is disabled
> 
> x-colo capability needs to be always enabled on the incoming side.
> So migration_incoming_colo_enabled() and migrate_colo() are equivalent
> with migrate_colo() being easier to reason about since it is always true
> during the whole migration.
> 
> Use migrate_colo() to initialize the ram cache in the normal migration path.
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Since the goal of this patch is to drop the COLO migration command, this
looks an improvement indeed,

Reviewed-by: Peter Xu <peterx@redhat.com>

I'll still comment though for possible future updates..

> ---
>  migration/migration.c | 18 ++++++++++++++----
>  migration/savevm.c    | 14 +-------------
>  2 files changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index b103a82fc0b83009d01d238ff16c0a542d83509f..a73d842ad8b060dc84273ade36ef7dc8b87421f3 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -630,10 +630,6 @@ int migration_incoming_enable_colo(Error **errp)
>          return -EINVAL;
>      }
>  
> -    if (ram_block_discard_disable(true)) {
> -        error_setg(errp, "COLO: cannot disable RAM discard");
> -        return -EBUSY;
> -    }
>      migration_colo_enabled = true;
>      return 0;
>  }
> @@ -770,6 +766,20 @@ process_incoming_migration_co(void *opaque)
>  
>      assert(mis->from_src_file);
>  
> +    if (migrate_colo()) {
> +        if (ram_block_discard_disable(true)) {

IMHO this is something we could have done at migrate_incoming and fail the
QMP command directly, rather than waiting until this late.

> +            error_setg(&local_err, "COLO: cannot disable RAM discard");
> +            goto fail;
> +        }
> +
> +        ret = colo_init_ram_cache(&local_err);

This might be more suitable to be put in ram's load_setup() (which should
happen at the initial migration phase, before colo taking snapshots), then
I believe this function can be unexported too.

> +        if (ret) {
> +            error_prepend(&local_err, "failed to init colo RAM cache: %d: ",
> +                          ret);
> +            goto fail;
> +        }
> +    }
> +
>      mis->largest_page_size = qemu_ram_pagesize_largest();
>      postcopy_state_set(POSTCOPY_INCOMING_NONE);
>      migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 3dc812a7bbb4e8f5321114c9919d4619798fed5e..0353ac2d0de819b6547a1f771e6a4c3b8fb1e4ef 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2407,19 +2407,7 @@ static int loadvm_process_enable_colo(MigrationIncomingState *mis,
>                                        Error **errp)
>  {
>      ERRP_GUARD();
> -    int ret;
> -
> -    ret = migration_incoming_enable_colo(errp);
> -    if (ret < 0) {
> -        return ret;
> -    }
> -
> -    ret = colo_init_ram_cache(errp);
> -    if (ret) {
> -        error_prepend(errp, "failed to init colo RAM cache: %d: ", ret);
> -        migration_incoming_disable_colo();
> -    }
> -    return ret;
> +    return migration_incoming_enable_colo(errp);
>  }
>  
>  static int loadvm_postcopy_handle_switchover_start(Error **errp)
> 
> -- 
> 2.39.5
> 

-- 
Peter Xu


