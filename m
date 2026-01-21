Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031ACC4451C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 12:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viWtb-0000jb-3K; Wed, 21 Jan 2026 07:01:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1viWt0-0000cl-VM
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:00:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1viWsx-0002yC-3I
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768996825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/aZ6HZ0+IWKxjbdg+AXguTC4M+4lt7VFJT8pqJWSUVM=;
 b=YkhlWvWdzEatHUhPDLjjHUV6w3FmDhm0iWVZpDPi87Y2CcvTE7K1itZCgpIQfWHf57qYx9
 WQSV5OT1HkzZwH/ksbrWYNcT7MBU498cat77pppATIu7k/ExsWMc7xZFtJ7OOF6XgZVQ3M
 8MlvrfkePen3CdqI4N8uWWMBjuGhcoY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-2IK_EALnPSqv3Dnc37yttw-1; Wed, 21 Jan 2026 07:00:23 -0500
X-MC-Unique: 2IK_EALnPSqv3Dnc37yttw-1
X-Mimecast-MFC-AGG-ID: 2IK_EALnPSqv3Dnc37yttw_1768996822
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-435a2de6ec0so172441f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 04:00:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768996822; cv=none;
 d=google.com; s=arc-20240605;
 b=Ybwj9Y17mGHtpw1D0F/CUUxOwJOQcF4S4OR8qAdGfeCAQX8S7JpG/Zb00+YRC1230T
 iOkWhpgnoTG4fAwB5DsYe7ipBKGMmui2xqReCW+/Oq6j5Ng2bA6qOM88MM2iqLv7fjFW
 SvP1kkodmA6uQ7o2RyC25k1Ruxu9+Tk0OV5eSlr7bkOufjQiaC6TISdtqUixdpsG3UEM
 fiTiMMi32nzhf6Zoym5l3+LVI2Cj42kUJ87GfBW7uhRDrLT+EtpKrfccacC6WDAJhxIg
 D/kaGjPVInXy+SuHs/ja5zCMUT6dGvWw1LT0+oOyUWVt1xXkBjFh6XU2x8rqOZoX/r3d
 iCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/aZ6HZ0+IWKxjbdg+AXguTC4M+4lt7VFJT8pqJWSUVM=;
 fh=0RzcIwFimfBkgnFHDXsRN51GKRJBbsoa2EXtpgq3n8k=;
 b=eevOQ4X/4H2swQxTJ2whxqJQXheEqvN2+Lf9elPUTg+xBlgCdpXxcO1q70DA8YgFxv
 jyeVtF0OH/5hnHlnkSw5CmgRQjHe0TIelxnP3g+qe3He8TuOn2mjupsjd05oqIrL7Gkz
 7sq9EIBCjgXFB4cIUOpwKPry+2NrXBFW3KBXjQBCdoQ8BQRtf+lLSdl1hi1U1FHtl4mY
 S1eqeRzWr/0KmVaWsq/ayIfSHwb0csR4k0Lg/i07wACtNPdgbTIrl8LK6xDnNAYQ9n9W
 PkKg2YQBzRaTa7d8LFfhj/F6kd46qCBtuigwVCjTGrl9cDrVZ64il5/WuNm83+c9bPff
 +7dw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768996822; x=1769601622; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/aZ6HZ0+IWKxjbdg+AXguTC4M+4lt7VFJT8pqJWSUVM=;
 b=eQS8OionW+3qwjlrIX03aDaCWfzbu0m1cshqFPWheRWJEAwryK7ihMx84STU1a7iLN
 0ZenNTfYys5GY5vwGKxd5Jxerv1DlftjwC1UnbgmjBNxcCXw40eQ8mu7QmPOSfiMF6L/
 xhF2RJJFDEQVwMmGhP8bDZ57PGK3BmUeWF4fqQJSztxEpPC7FTybo4XxOc6MpNlJGAwd
 cBU7tW6q22HZ2ACr6JJDt+nlvfg9P43I5ja5aosWpJi1sZ9XYJVvxnV3W7bDx62Ktu5x
 R73sF+upl/DLvlGrrBAZdG0yGTaNFRW0BRR91ioNQX8TysTjjBH0js69gDlBwIk/60E+
 iMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768996822; x=1769601622;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/aZ6HZ0+IWKxjbdg+AXguTC4M+4lt7VFJT8pqJWSUVM=;
 b=w2LG081hlUjkbh5l11UqGl4chqEMRbzF3F3EsRto1aSjNSnSPBLwAbbWl18zjpVSXM
 KcUabziMvSTO/2PB7LSHnz0q4U5ewQsr1TCnls/SQKl4DWTy4n/4e9AhtH20Xxa8+zhe
 8ymrioOzbabCThoj8gXYDzz/c+uLhAZAKP+bhEDD/FgFQZi6owxjxiVD3kmK5YHotIzX
 yQI+o/6ak/c4dCcqVsAEbHv9x4A0edNl8na18I1bew0zCfxvqGVxzDHxubx2SwoO14au
 /vzQCq66LvgC1y+8v8TaXQdsBze41WILXny8D2WOwhd35qq6fSdFpQr/nTgnrFK2HNea
 Z0Xg==
X-Gm-Message-State: AOJu0YzNGEXgETXE3Qt1Cwsja1sU2KpcA2cqtoKv6w7H4Avg/yORsd3b
 uPNDhMoC37TbsHA4nhC5JJuvAE8/JF87euY0gcRtbnVl7N50K2P7bI3dY8LLYzeitEfxQLpcj1k
 AsNehGXJrINRDjvHHvs1Zw0kaHapNCDx4Fg1rD4txAMsO46/XgN3Whz1F8XLMgAeOvgJyFSl0hX
 v+fQENEI4t6wJZDkyHweYxBxD7WJz5wpc=
X-Gm-Gg: AZuq6aIxqeBPgmQufBzjCMvsKuetHdOlpUXyyczYO539+uLnbBhO0keISxlmzv3kYNn
 gezYdF0DgXtyP1EE2Bx1QFiz7CMI8cErk9emlsN4gnTTx8NmGgO2VE4E1310OcVeBGiPsW0bar2
 5gqk92ESLyF+P+RvNpeNWAdBb3IFOO28ashHIz44cGOUFFnfxDtrxi4eY80FkBnIEG3Mz0MG/gE
 DtIaQbP7MNkRsInAlGALQQV6qWzvsGiVr48nguQ5QRl0Uyp+IvS2XBk
X-Received: by 2002:a05:600c:6091:b0:480:1a9a:e571 with SMTP id
 5b1f17b1804b1-4801eb04160mr233217155e9.22.1768996822408; 
 Wed, 21 Jan 2026 04:00:22 -0800 (PST)
X-Received: by 2002:a05:600c:6091:b0:480:1a9a:e571 with SMTP id
 5b1f17b1804b1-4801eb04160mr233216475e9.22.1768996821939; Wed, 21 Jan 2026
 04:00:21 -0800 (PST)
MIME-Version: 1.0
References: <20260114132309.5832-1-farosas@suse.de>
 <20260114132309.5832-3-farosas@suse.de>
In-Reply-To: <20260114132309.5832-3-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 21 Jan 2026 17:30:05 +0530
X-Gm-Features: AZwV_Qgg2_w9UXrJ9uYOu5i1SjUE6AmN_veJLGC2sAf7qE0Bpi5uRByHZ1ccXQs
Message-ID: <CAE8KmOx-HbzqDGt12mMxNHcTocq2rWSrksgrns-PdHWCPDJacg@mail.gmail.com>
Subject: Re: [PATCH 2/5] migration: Use QAPI_CLONE_MEMBERS in
 migrate_params_apply
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 14 Jan 2026 at 18:55, Fabiano Rosas <farosas@suse.de> wrote:
> Instead of setting parameters one by one, use the temporary object,
> which already contains the current migration parameters plus the new
> ones and was just validated by migration_params_check(). Use cloning
> to overwrite it.
>
> This avoids the need to alter this function every time a new parameter
> is added.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/options.c | 134 ++++----------------------------------------
>  1 file changed, 12 insertions(+), 122 deletions(-)
>
> diff --git a/migration/options.c b/migration/options.c
> index 994e1cc5ac..7a16119ff8 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -13,6 +13,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
> +#include "qemu/main-loop.h"
>  #include "exec/target_page.h"
>  #include "qapi/clone-visitor.h"
>  #include "qapi/error.h"
> @@ -1384,132 +1385,21 @@ static void migrate_params_test_apply(MigrationParameters *params,
>      }
>  }
>
> +/*
> + * Caller must ensure all has_* fields of @params are true to ensure
> + * all fields get copied and the pointer members don't dangle.
> + */

* Maybe skip initial -> Caller must ensure - to avoid double usage of  'ensure'
     "All has_* fields of @params must be true to ensure that they are
copied ..."

>  static void migrate_params_apply(MigrationParameters *params)
>  {
>      MigrationState *s = migrate_get_current();
> +    MigrationParameters *cur = &s->parameters;
>
> -    /* TODO use QAPI_CLONE() instead of duplicating it inline */
> +    assert(bql_locked());

* Why are we confirming that bql_lock is taken? Is it because we are
updating a global MigrationState field (s->parameters)? IIUC
'migrate_params_apply' is called via QMP_ call, which is handled by
the main thread, we don't generally update/write these parameters in
any other threads (multifd, postcopy etc.).  /* I'm thinking if it was
not checked before, why do we need it now? We are including the
main-loop.h header for this as well. */

>
> -    if (params->has_throttle_trigger_threshold) {
> -        s->parameters.throttle_trigger_threshold = params->throttle_trigger_threshold;
> -    }
> -
> -    if (params->has_cpu_throttle_initial) {
> -        s->parameters.cpu_throttle_initial = params->cpu_throttle_initial;
> -    }
> -
> -    if (params->has_cpu_throttle_increment) {
> -        s->parameters.cpu_throttle_increment = params->cpu_throttle_increment;
> -    }
> -
> -    if (params->has_cpu_throttle_tailslow) {
> -        s->parameters.cpu_throttle_tailslow = params->cpu_throttle_tailslow;
> -    }
> -
> -    if (params->tls_creds) {
> -        qapi_free_StrOrNull(s->parameters.tls_creds);
> -        s->parameters.tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
> -    }
> -
> -    if (params->tls_hostname) {
> -        qapi_free_StrOrNull(s->parameters.tls_hostname);
> -        s->parameters.tls_hostname = QAPI_CLONE(StrOrNull,
> -                                                params->tls_hostname);
> -    }
> -
> -    if (params->tls_authz) {
> -        qapi_free_StrOrNull(s->parameters.tls_authz);
> -        s->parameters.tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
> -    }
> -
> -    if (params->has_max_bandwidth) {
> -        s->parameters.max_bandwidth = params->max_bandwidth;
> -    }
> -
> -    if (params->has_avail_switchover_bandwidth) {
> -        s->parameters.avail_switchover_bandwidth = params->avail_switchover_bandwidth;
> -    }
> -
> -    if (params->has_downtime_limit) {
> -        s->parameters.downtime_limit = params->downtime_limit;
> -    }
> -
> -    if (params->has_x_checkpoint_delay) {
> -        s->parameters.x_checkpoint_delay = params->x_checkpoint_delay;
> -    }
> -
> -    if (params->has_multifd_channels) {
> -        s->parameters.multifd_channels = params->multifd_channels;
> -    }
> -    if (params->has_multifd_compression) {
> -        s->parameters.multifd_compression = params->multifd_compression;
> -    }
> -    if (params->has_multifd_qatzip_level) {
> -        s->parameters.multifd_qatzip_level = params->multifd_qatzip_level;
> -    }
> -    if (params->has_multifd_zlib_level) {
> -        s->parameters.multifd_zlib_level = params->multifd_zlib_level;
> -    }
> -    if (params->has_multifd_zstd_level) {
> -        s->parameters.multifd_zstd_level = params->multifd_zstd_level;
> -    }
> -    if (params->has_xbzrle_cache_size) {
> -        s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
> -    }
> -    if (params->has_max_postcopy_bandwidth) {
> -        s->parameters.max_postcopy_bandwidth = params->max_postcopy_bandwidth;
> -    }
> -    if (params->has_max_cpu_throttle) {
> -        s->parameters.max_cpu_throttle = params->max_cpu_throttle;
> -    }
> -    if (params->has_announce_initial) {
> -        s->parameters.announce_initial = params->announce_initial;
> -    }
> -    if (params->has_announce_max) {
> -        s->parameters.announce_max = params->announce_max;
> -    }
> -    if (params->has_announce_rounds) {
> -        s->parameters.announce_rounds = params->announce_rounds;
> -    }
> -    if (params->has_announce_step) {
> -        s->parameters.announce_step = params->announce_step;
> -    }
> -
> -    if (params->has_block_bitmap_mapping) {
> -        qapi_free_BitmapMigrationNodeAliasList(
> -            s->parameters.block_bitmap_mapping);
> -
> -        s->has_block_bitmap_mapping = true;
> -        s->parameters.block_bitmap_mapping =
> -            QAPI_CLONE(BitmapMigrationNodeAliasList,
> -                       params->block_bitmap_mapping);
> -    }
> -
> -    if (params->has_x_vcpu_dirty_limit_period) {
> -        s->parameters.x_vcpu_dirty_limit_period =
> -            params->x_vcpu_dirty_limit_period;
> -    }
> -    if (params->has_vcpu_dirty_limit) {
> -        s->parameters.vcpu_dirty_limit = params->vcpu_dirty_limit;
> -    }
> -
> -    if (params->has_mode) {
> -        s->parameters.mode = params->mode;
> -    }
> -
> -    if (params->has_zero_page_detection) {
> -        s->parameters.zero_page_detection = params->zero_page_detection;
> -    }
> -
> -    if (params->has_direct_io) {
> -        s->parameters.direct_io = params->direct_io;
> -    }
> -
> -    if (params->has_cpr_exec_command) {
> -        qapi_free_strList(s->parameters.cpr_exec_command);
> -        s->parameters.cpr_exec_command =
> -            QAPI_CLONE(strList, params->cpr_exec_command);
> -    }
> +    migrate_tls_opts_free(cur);
> +    qapi_free_BitmapMigrationNodeAliasList(cur->block_bitmap_mapping);
> +    qapi_free_strList(cur->cpr_exec_command);
> +    QAPI_CLONE_MEMBERS(MigrationParameters, cur, params);
>  }
>
>  void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
> @@ -1539,7 +1429,7 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>              migrate_get_current()->has_block_bitmap_mapping = true;
>          }
>
> -        migrate_params_apply(params);
> +        migrate_params_apply(&tmp);
>          migrate_post_update_params(params, errp);
>      }
>
> --

* Change looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


