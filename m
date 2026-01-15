Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5693D41178
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 11:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgLwa-0003lI-0N; Thu, 15 Jan 2026 06:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vgLwJ-00037Q-1G
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:55:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vgLwH-0002w3-Ce
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:54:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768478095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u0th5VhGu7rvQfZUpVYyawCPX/KrPrzZgrw1SuOK/ko=;
 b=E2GgOFjEspiOKl4Bufr1gezZ5TNu68Z1Kvi1/AHGdAumbaiUPw8mFIiWDKnwoTaSt3SGvT
 K4RBDcexT6PBrz460Ymy2KDGHw3bPgHWe4OGAyxNdWfGChaBYnynXpFqZtF1bUErYFXPOg
 xlYsB4kProe3PGwFWFkiAGlJXYQUZco=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-LNDe5RbyPnuJhFb1RLkNnA-1; Thu, 15 Jan 2026 06:54:54 -0500
X-MC-Unique: LNDe5RbyPnuJhFb1RLkNnA-1
X-Mimecast-MFC-AGG-ID: LNDe5RbyPnuJhFb1RLkNnA_1768478093
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47ed980309aso9132165e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 03:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768478093; x=1769082893; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u0th5VhGu7rvQfZUpVYyawCPX/KrPrzZgrw1SuOK/ko=;
 b=THw4dha3Kox4XJtBegGH4wzeinLteIAr0YrRT27r3rcE/ywRvEu76HELaeDPPKaC6X
 rTx5jMWWve4vdENEO6sTNgExwPJWIv6aV4lcaukjRMiVWJAEdBSuNtJ24ovsRFqqt/Iz
 cchwmPbMGlBQfGfV5DIZ3zN3AX/ZLorg6serqO65UV7cFYfbGcqJUQp5rBGC2Ys+PxLc
 ynygeD/9/nPpBC86OP3FNys0/Z/LjdkOrcEicCegDMSE0Ge9ZZd3Oi4zLc35Qx4B7ZxF
 x1mAFDtx5SLcnWIk9bbn3wdCn3TQCoP/YIn0qZkdDd3Y5fTzmUsk2yKsD9cyWTjh9qqn
 3a8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768478093; x=1769082893;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u0th5VhGu7rvQfZUpVYyawCPX/KrPrzZgrw1SuOK/ko=;
 b=p9Yf8D+6TC8UAAiYCtg4IYJcndUOQYfi12kt8tinSd8qpvxFlQOHQU6VqSiXDkW9rC
 6pOxk2bHJ2d3A9ogBadtnbK+YfTDcfEw5olZMFxCeqDW230YAPPVxA6x/qAKhsR/qtWD
 YBYkQSlM66X/2v9JEHAtHIMU6kF+FVfgzL2tBPKRSyXdH0T6PYaEFr4Epu6sInxAQ8vg
 quirc56Xx14Sq0he2C4Q7T/C2ox5I3N1vxAc2Gkjfb7qdz8+TU79EET4sBU6dXMkcWie
 +YOCQH0sOH+h0xpnPBZ2ACvb4gIiC8JhrQ9jSTCK7xUzja4HwymB4XUwVPtXoHO81vOD
 k6Lw==
X-Gm-Message-State: AOJu0Yx/w85N6mMqcupd+nlfDGzlu4fWZkIyNsc1tZEgJ3+mefBo3t7y
 tdJBPjNm7MwDbblhhY9fgxQWFtPdsUTH3e/OIJdhJ7BlJPT2z4X0Xv+aY+fnjTFo6mPikvw7Svy
 L9LxJcQFY81VXlj3rTsVPuVin6o3JhSesvSf2xmWWBZLj0PivYTA3WoBqplA3SqlvQfgm75Q5qp
 Lx9kG0AYW0UbN3pvqmHUIZXPkXvXq51d8DA+y768Xmag==
X-Gm-Gg: AY/fxX5YdsYTzL5ZcXlDTmqbCu/Afx7GXXo34Cg6JTMS/qiVdx2Fvs7zB1WaPB0BpJY
 TltnvkU9hV59T2PXZm2O2B3Uup4Sxz0xgIMPmUDXc3XshA+SbakhIztjGQ78oplgrpvHmZul1kF
 nzjwnY2GdPiNZTN/ldF599h2YQ9cNCrJepU8HBay0N/nBvgvePYPDlNeF4GsoEh55uL1JRMq5pA
 quBfufJbTnpPD2WTbQ3yRTg3kY9a8xxnvCsvqV2JtbVC30yr8Iv6SB5
X-Received: by 2002:a05:600c:64c6:b0:477:9d88:2da6 with SMTP id
 5b1f17b1804b1-4801d7881femr2250375e9.0.1768478092841; 
 Thu, 15 Jan 2026 03:54:52 -0800 (PST)
X-Received: by 2002:a05:600c:64c6:b0:477:9d88:2da6 with SMTP id
 5b1f17b1804b1-4801d7881femr2250055e9.0.1768478092449; Thu, 15 Jan 2026
 03:54:52 -0800 (PST)
MIME-Version: 1.0
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-8-farosas@suse.de>
In-Reply-To: <20260109124043.25019-8-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 15 Jan 2026 17:24:35 +0530
X-Gm-Features: AZwV_QjAK5xJUSMjsceCzT8HQroWZM5gvoe0LDIO4Wvu9_NJYz1hkLe0nM9kPWo
Message-ID: <CAE8KmOzLG1QzPqw4H989Ws0-1LjcQzcXHJ8QbX06rVGsRQEKyg@mail.gmail.com>
Subject: Re: [PATCH v3 07/25] migration: Free the error earlier in the resume
 case
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
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

On Fri, 9 Jan 2026 at 18:11, Fabiano Rosas <farosas@suse.de> wrote:
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1811,8 +1811,8 @@ int migrate_init(MigrationState *s, Error **errp)
>      s->setup_time = 0;
>      s->start_postcopy = false;
>      s->migration_thread_running = false;
> -    error_free(s->error);
> -    s->error = NULL;
> +
> +    migrate_error_free(s);
>
>      if (should_send_vmdesc()) {
>          s->vmdesc = json_writer_new(false);
> @@ -2087,6 +2087,13 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>          migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_PAUSED,
>                            MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
>
> +        /*
> +         * If there's a previous error, free it and prepare for
> +         * another one. For the non-resume case, this happens at
> +         * migrate_init() below.
> +         */
> +        migrate_error_free(s);
> +
>          /* This is a resume, skip init status */
>          return true;
>      }
> @@ -4015,13 +4022,6 @@ void migration_connect(MigrationState *s, Error *error_in)
>      bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
>      int ret;
>
> -    /*
> -     * If there's a previous error, free it and prepare for another one.
> -     * Meanwhile if migration completes successfully, there won't have an error
> -     * dumped when calling migration_cleanup().
> -     */
> -    migrate_error_free(s);
> -
>      s->expected_downtime = migrate_downtime_limit();
>      if (error_in) {
>          migration_connect_error_propagate(s, error_in);

* Looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


