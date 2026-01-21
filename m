Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185A6C44526
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 12:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viXly-0000zY-GX; Wed, 21 Jan 2026 07:57:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1viXlp-0000yh-9c
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:57:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1viXll-0003iy-OC
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769000228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9rjhaNwa1En2oh0xs70xQr0LlqOwr838fLa7z8CCasA=;
 b=PpRwZ55dhMphWVu67irm52YgHn5kH0ER3XUpxV8NdlI4J4CiAt3b7xs+Ah4Dzdk8MdJn1Z
 Lqw8O6d8ad76F+ASs6zfudYyNVhU4+vyDhtHU0Q1uU1gqzGze2+311yb7R4h37TMfH8P4Y
 fkjDqkhgFvibGNOh905Rk2iSOaIOSJw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-kWRAPsDDPlWutVZ6Rmgw9A-1; Wed, 21 Jan 2026 07:57:07 -0500
X-MC-Unique: kWRAPsDDPlWutVZ6Rmgw9A-1
X-Mimecast-MFC-AGG-ID: kWRAPsDDPlWutVZ6Rmgw9A_1769000226
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47ee868f5adso50897495e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 04:57:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769000226; cv=none;
 d=google.com; s=arc-20240605;
 b=Akbd02ieeVO2VPejSkSy5eyAdQYztbkr2FS/aM97dwMu7kl3pkZa9s1oG2TsHskjf1
 ada5c83tL6BYSoLAG/lbCE5RPzd13caU6raU1+iWBhW14UHFE9zIabLKX/Sc5xEhaZBn
 Dp/mIIUmlbzXeGYIrtdoInrVp3rfXbK4qpO7CKczsPAaGdxR6vUHmB2ytqjbbXxcUEbS
 VClFR/TrXF4ub9bGJSa4YkxNwSroKP3jI7pjon4olCm7vkk5VY9E17J0TMj2r9lzdken
 TnzuwLixm1eltFHa3nbrZVNyrswxM7XGntUGVHDjQs6UUhOIOoUMKb5Rl+zpXHbYiGM8
 vjCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9rjhaNwa1En2oh0xs70xQr0LlqOwr838fLa7z8CCasA=;
 fh=0RzcIwFimfBkgnFHDXsRN51GKRJBbsoa2EXtpgq3n8k=;
 b=hr9kMAwf0GI/dfL5KpTApHOdhXRKFS7dCLQSq1Qv2SNLJJMIHxhxqfil5uLpR4j4VA
 QRUrXlYu8qfmtV2z2SapvtjkCMjYn9y9/wQfHFCpbRAAlpNwqeltfC4XLAJkh7Z9r/0G
 zdMPF3KPtJyGNbX2E9S3Jyv+j4l5KcsClifsEdiP/eWmsXarvMzW0xUw9EE3THOZsxyR
 fNb5jUz6XYw9rn9JywsVho6TYjbQMBA7Fxrkyqro25RvnYe1iWV8DDEqhwUBP1a3fmg5
 lF8UrmMPIfEoCnjH9AWccNZkkNVr8ehegBMiH9qgUw9xtJ5rCHG4oQWdNvId7uTR9YRa
 /zUA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769000226; x=1769605026; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9rjhaNwa1En2oh0xs70xQr0LlqOwr838fLa7z8CCasA=;
 b=V5wBOkfcUpqzd8Wj9ccWfXI5bilz0uKADum5D4sAhua8P5yjWzNvGVxAlHYS13Ah1z
 jr1aLpHd3d7B2obfJhVGOrEi+DU511say3wTkmT7nPl6xgBlsLOMourQDcu7ILOfCry7
 TfdkBEJ0pnva2+3JrXiTsQHa7EF+QShIvPdT7wHQLUkCgBxGwiin+VHS18GdLNOM4X4/
 s2XHfkYFHnDAwr0DG3FAngq0f35HqnFttBNgrhLpJWf8gnQypjbJqPz5OwGPY/ZH+LFc
 YqPmI8oy8jn9IbVy7IUmxaIPagQ+jSPg/9mSaQnoaqZaQ3l8t8QWXVlrmSB+1eqveqxC
 eV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769000226; x=1769605026;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9rjhaNwa1En2oh0xs70xQr0LlqOwr838fLa7z8CCasA=;
 b=owzToTf3CpnxP+5lDczwdjPOfMVheg3BY48aGHIscWCAoanroltBhpljA56xGTlWrv
 Q4Kv70pQuDAbtHhh3Jk9jtYAhPsgdob+NVljWB+XEDq3dGgW3TS2eZLbsAth+VzF0aVS
 dol8clU85+XGnA3FpEW57/Zv4FQiP+vQ6zXDwT13DxJvy21XSh0DlAuFDCdbQBpsA4UP
 bKw0shMz0uI9vP9ZJ764mqJFJui+pp+GZla4KtXBSniW1PmGUQeCBcz/6xDWgk0RLxdK
 bH0wDgMt/W99xBQMFejJZiSbsPzV1ghu4kdSTlzbxz1AmS1T1U9XR+w9GbvQqoT7EKI+
 YjDQ==
X-Gm-Message-State: AOJu0YxDWGQbU4mnv99fIVJuv7M1J2CQaIWpT1YdVQW51GuURTyS4wOO
 KukXYAL7BinX5uBBgxh5cW1fp/WhAgOH0onM7VIQjLJRpAqL4lyHgVMZEmqrD8iknZjt0kByZJl
 Ds3hXICD6GhAfCOR9/KlTrFprqSbIfl+5fj7REIGQm2Kr4LaDMOip+6O8JSL0my5jE2jwTmJwaq
 3If7pnH2lOSNw0+57kNKDUGw74bheGucw=
X-Gm-Gg: AZuq6aLgfcAPm8Su58zX7gZ7tC3b3JR8nwghoPuoyp0YHHo+GpL/mAE6jF9jPcWpIwa
 O1fbCneFJwBCByHXY/Z4FLtiWpHvGC0I6pcHsASOp+DiDM6cIhapjC8JY2dZw9jNCdgpdHec+6J
 aXEfHmvdR/3By2dC3Fd5izbuPof0QCvGQOxY1f16y93EuqoFAS6VP/9IjkQqAQtMyyhYe+13caX
 KQ2SUP1EXS/X9f8L4gU0Ft6wmHOnckF6UgcBerBZGjBMgWzXAyOtEup
X-Received: by 2002:a05:600c:8b78:b0:47e:e8c2:905f with SMTP id
 5b1f17b1804b1-4801e30a790mr261513275e9.8.1769000226113; 
 Wed, 21 Jan 2026 04:57:06 -0800 (PST)
X-Received: by 2002:a05:600c:8b78:b0:47e:e8c2:905f with SMTP id
 5b1f17b1804b1-4801e30a790mr261512965e9.8.1769000225668; Wed, 21 Jan 2026
 04:57:05 -0800 (PST)
MIME-Version: 1.0
References: <20260114132309.5832-1-farosas@suse.de>
 <20260114132309.5832-6-farosas@suse.de>
In-Reply-To: <20260114132309.5832-6-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 21 Jan 2026 18:26:49 +0530
X-Gm-Features: AZwV_Qhqmm4_n2J9GM2yH76y06tRVC7IO9CMYGDZpIy5iGDu9ovAVZet_3lvsKs
Message-ID: <CAE8KmOxNPToj2r__BNGMxm=ckGLwbMD2t6_3h=-KVCQxV8RVxw@mail.gmail.com>
Subject: Re: [PATCH 5/5] migration/options: Use QAPI_MERGE in
 migrate_params_test_apply
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
> Convert the code in migrate_params_test_apply() from an open-coded
> copy of every migration parameter to a copy using visitors. The
> current code has conditionals for each parameter's has_* field, which
> is exactly what the visitors do.
>
> This hides the details of QAPI from the migration code and avoids the
> need to update migrate_params_test_apply() every time a new migration
> parameter is added. Both were very confusing and while the visitor
> code can become a bit involved, there is no need for new contributors
> to ever touch it.
>
> Move the QAPI_CLONE_MEMBERS into the caller, so QAPI_CLONE can be used
> and there's no need to allocate memory in the migration
> code. Similarly, turn 'tmp' into a pointer so the proper qapi_free_
> routine can be used.
>
> An extra call to migrate_mark_all_params_present() is now needed
> because the visitors update the has_ field for non-present fields, but
> we actually want them all set so migrate_params_apply() can copy all
> of them.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/options.c | 138 +++-----------------------------------------
>  1 file changed, 9 insertions(+), 129 deletions(-)
>
> diff --git a/migration/options.c b/migration/options.c
> index 7a16119ff8..b4773fecc5 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -20,6 +20,7 @@
>  #include "qapi/qapi-commands-migration.h"
>  #include "qapi/qapi-visit-migration.h"
>  #include "qapi/qmp/qerror.h"
> +#include "qapi/type-helpers.h"
>  #include "qobject/qnull.h"
>  #include "system/runstate.h"
>  #include "migration/colo.h"
> @@ -1262,129 +1263,6 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>      return true;
>  }
>
> -static void migrate_params_test_apply(MigrationParameters *params,
> -                                      MigrationParameters *dest)
> -{
> -    MigrationState *s = migrate_get_current();
> -
> -    QAPI_CLONE_MEMBERS(MigrationParameters, dest, &s->parameters);
> -
> -    if (params->has_throttle_trigger_threshold) {
> -        dest->throttle_trigger_threshold = params->throttle_trigger_threshold;
> -    }
> -
> -    if (params->has_cpu_throttle_initial) {
> -        dest->cpu_throttle_initial = params->cpu_throttle_initial;
> -    }
> -
> -    if (params->has_cpu_throttle_increment) {
> -        dest->cpu_throttle_increment = params->cpu_throttle_increment;
> -    }
> -
> -    if (params->has_cpu_throttle_tailslow) {
> -        dest->cpu_throttle_tailslow = params->cpu_throttle_tailslow;
> -    }
> -
> -    if (params->tls_creds) {
> -        qapi_free_StrOrNull(dest->tls_creds);
> -        dest->tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
> -    }
> -
> -    if (params->tls_hostname) {
> -        qapi_free_StrOrNull(dest->tls_hostname);
> -        dest->tls_hostname = QAPI_CLONE(StrOrNull, params->tls_hostname);
> -    }
> -
> -    if (params->tls_authz) {
> -        qapi_free_StrOrNull(dest->tls_authz);
> -        dest->tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
> -    }
> -
> -    if (params->has_max_bandwidth) {
> -        dest->max_bandwidth = params->max_bandwidth;
> -    }
> -
> -    if (params->has_avail_switchover_bandwidth) {
> -        dest->avail_switchover_bandwidth = params->avail_switchover_bandwidth;
> -    }
> -
> -    if (params->has_downtime_limit) {
> -        dest->downtime_limit = params->downtime_limit;
> -    }
> -
> -    if (params->has_x_checkpoint_delay) {
> -        dest->x_checkpoint_delay = params->x_checkpoint_delay;
> -    }
> -
> -    if (params->has_multifd_channels) {
> -        dest->multifd_channels = params->multifd_channels;
> -    }
> -    if (params->has_multifd_compression) {
> -        dest->multifd_compression = params->multifd_compression;
> -    }
> -    if (params->has_multifd_qatzip_level) {
> -        dest->multifd_qatzip_level = params->multifd_qatzip_level;
> -    }
> -    if (params->has_multifd_zlib_level) {
> -        dest->multifd_zlib_level = params->multifd_zlib_level;
> -    }
> -    if (params->has_multifd_zstd_level) {
> -        dest->multifd_zstd_level = params->multifd_zstd_level;
> -    }
> -    if (params->has_xbzrle_cache_size) {
> -        dest->xbzrle_cache_size = params->xbzrle_cache_size;
> -    }
> -    if (params->has_max_postcopy_bandwidth) {
> -        dest->max_postcopy_bandwidth = params->max_postcopy_bandwidth;
> -    }
> -    if (params->has_max_cpu_throttle) {
> -        dest->max_cpu_throttle = params->max_cpu_throttle;
> -    }
> -    if (params->has_announce_initial) {
> -        dest->announce_initial = params->announce_initial;
> -    }
> -    if (params->has_announce_max) {
> -        dest->announce_max = params->announce_max;
> -    }
> -    if (params->has_announce_rounds) {
> -        dest->announce_rounds = params->announce_rounds;
> -    }
> -    if (params->has_announce_step) {
> -        dest->announce_step = params->announce_step;
> -    }
> -
> -    if (params->has_block_bitmap_mapping) {
> -        qapi_free_BitmapMigrationNodeAliasList(dest->block_bitmap_mapping);
> -        dest->block_bitmap_mapping = QAPI_CLONE(BitmapMigrationNodeAliasList,
> -                                                params->block_bitmap_mapping);
> -    }
> -
> -    if (params->has_x_vcpu_dirty_limit_period) {
> -        dest->x_vcpu_dirty_limit_period =
> -            params->x_vcpu_dirty_limit_period;
> -    }
> -    if (params->has_vcpu_dirty_limit) {
> -        dest->vcpu_dirty_limit = params->vcpu_dirty_limit;
> -    }
> -
> -    if (params->has_mode) {
> -        dest->mode = params->mode;
> -    }
> -
> -    if (params->has_zero_page_detection) {
> -        dest->zero_page_detection = params->zero_page_detection;
> -    }
> -
> -    if (params->has_direct_io) {
> -        dest->direct_io = params->direct_io;
> -    }
> -
> -    if (params->has_cpr_exec_command) {
> -        qapi_free_strList(dest->cpr_exec_command);
> -        dest->cpr_exec_command = QAPI_CLONE(strList, params->cpr_exec_command);
> -    }
> -}
> -
>  /*
>   * Caller must ensure all has_* fields of @params are true to ensure
>   * all fields get copied and the pointer members don't dangle.
> @@ -1404,7 +1282,9 @@ static void migrate_params_apply(MigrationParameters *params)
>
>  void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>  {
> -    MigrationParameters tmp;
> +    MigrationState *s = migrate_get_current();
> +    g_autoptr(MigrationParameters) tmp = QAPI_CLONE(MigrationParameters,
> +                                                    &s->parameters);
>
>      /*
>       * Convert QTYPE_QNULL and NULL to the empty string (""). Even
> @@ -1418,9 +1298,9 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>      tls_opt_to_str(params->tls_hostname);
>      tls_opt_to_str(params->tls_authz);
>
> -    migrate_params_test_apply(params, &tmp);
> +    QAPI_MERGE(MigrationParameters, tmp, params);
>
> -    if (migrate_params_check(&tmp, errp)) {
> +    if (migrate_params_check(tmp, errp)) {
>          /*
>           * Mark block_bitmap_mapping as present now while we have the
>           * params structure with the user input around.
> @@ -1429,9 +1309,9 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>              migrate_get_current()->has_block_bitmap_mapping = true;
>          }
>
> -        migrate_params_apply(&tmp);
> +        /* mark all present, so they're all copied */
> +        migrate_mark_all_params_present(tmp);
> +        migrate_params_apply(tmp);
>          migrate_post_update_params(params, errp);
>      }
> -
> -    migrate_tls_opts_free(&tmp);
>  }
> --

* IIUC, qmp_migrate_set_parameters receives @params from libvirtd(8)
or such external QMP_ caller; And the function sets those @params
values to the respective field in the current migration state
's->parameters', right? To do this:
     1. It creates a temporary MigrationParameters object 'tmp', by
cloning the 's->parameters' object. @tmp = s->parameters.
     2. it merges @params values into the 'tmp' object via
QAPI_MERGE(, tmp, params).  @tmp = s->parameters + @params.
     3. migrate_params_checks if values in @tmp are valid or not.
     4. migrate_params_apply copies @tmp values into s->parameters.
<=  do we need this migrate_params_apply() really? Couldn't we do
QAPI_COPY(s->parameters, tmp) OR QAPI_CLONE_MEMBERS(s->parameters,
tmp) here?
     5. migrate_post_update_params() - checks few updated values and
calls respective functions   <= we could remove this one too.

* Could we remove 'migrate_params_apply()' and
'migrate_post_update_params()' altogether and do the entire update
(clone -> update -> clone-back) operation and post-update actions in
one function (qmp_migrate_set_parameters), rather than scattered
across multiple functions?

Thank you.
---
  - Prasad


