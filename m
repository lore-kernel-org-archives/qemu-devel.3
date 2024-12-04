Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F61EE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 18:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIuMg-0004pB-87; Wed, 04 Dec 2024 13:44:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIuMe-0004l8-9b
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 13:44:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIuMc-00087p-DM
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 13:44:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733337880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N4nkV43GDxyeKgRGGVCpT/scHDEkKEQ/N/1GUoU5uMY=;
 b=Uxmp9tmCCWC+LZMPnoULzlE/SnSVjv7lZ4ZPniP5uhtajEpOmTRTVdzYoZW4RFVndFGZIR
 vC1jfLlK4xkTk/QJhzBIIAGkKb7/C6naYU1kS4DwVV5tzfRwWJCiLl19yrEW4Nol6UKjX6
 fS8YNnutuUCNxuhndr50guEUyZKSp/c=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-xRthAEpqPMqvwzdxoJnohA-1; Wed, 04 Dec 2024 13:44:39 -0500
X-MC-Unique: xRthAEpqPMqvwzdxoJnohA-1
X-Mimecast-MFC-AGG-ID: xRthAEpqPMqvwzdxoJnohA
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-85636e5c41cso23459241.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 10:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733337878; x=1733942678;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N4nkV43GDxyeKgRGGVCpT/scHDEkKEQ/N/1GUoU5uMY=;
 b=nRzpMJZbROk7jFi9hBeme1ulLGTmaDAFTjvaerU03H/27nycXAp5Ebivi1ztBgHU56
 tk41VscKuIMpP3lgp798vbc9a4B/Xv34hBWkjm6P1REDzTwfB09xFMixwM+9iNmvc020
 Aqe6Dvs3oEVSJDrKWKTEPcgDZ/0vIiOA4X6wyIpfJaHBjBFPAfxSY0ENh0fInw5kf2Pi
 mK+TtEK3pZwcve7vthw8PS0SFvGuWISXQTDHRdXrdMQww1hEymJgXLaT+ls6fVS82ltT
 A9goHqoTHHlLe8lLJB64LdfnckErGsNvICIb7yt2FFhSl/lmOBlAFq4HZv0E/BOTkMP3
 4T4Q==
X-Gm-Message-State: AOJu0YyH/6iHDakxoOWDXi9W9UUBKM1Vz7JFdYCLqcpvMVAiaKbVZtGo
 fZcePoySKYWz5s41f1pqju2ECLUlMr1Gsl3JWlRjSpWHmtMWbTdyv+sOBtUemVEemEsqzgLqger
 k6ABXnsn96VPuPvZWrmHOZU57vtzOX2X8CFhcv/cfazrg2GCiQmtp
X-Gm-Gg: ASbGnctlM769l5mf/Q23GNfR30AJLZDfDDrGHPA6EmWFNDGlv/khW54eE4juwOxyEqG
 8tyDNAEoLNJbXRRTLNNG3rVdMzyH3WQucheSvHZhXuLNlRonK/qsLW8G+D0ncq36KkVyDSrrBCz
 DlKEqKbYoABt8zZA/KNCPJ62m3F4CL+sNpZV/fQYvlHwpNWpmR2Vhz4sGzQo60cMZQ0xZw2FDH/
 0Wm1Z8Ag6QJSIQDlH2ZNwH6/XaTIzRnRcN3TOUX/ZIJfm1uTN3XdSjf4dYGMpR/jdAKCFR0bCAA
 MFUvIL36/bA=
X-Received: by 2002:a05:6122:2216:b0:50d:44fd:5b68 with SMTP id
 71dfb90a1353d-515bf673fb9mr9291367e0c.10.1733337878254; 
 Wed, 04 Dec 2024 10:44:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHO7c/uws18lR0C1Cirr69J0BsKdzJ5OWeR7zZS2hHyvWGY5Cg1b9JSDsbr/9iF+w1a+1DYHw==
X-Received: by 2002:a05:6122:2216:b0:50d:44fd:5b68 with SMTP id
 71dfb90a1353d-515bf673fb9mr9291346e0c.10.1733337877838; 
 Wed, 04 Dec 2024 10:44:37 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d89ae5a767sm50391096d6.38.2024.12.04.10.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 10:44:37 -0800 (PST)
Date: Wed, 4 Dec 2024 13:44:35 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 5/6] migration: Fix hang after error in destination setup
 phase
Message-ID: <Z1CjE2UYUECkRhJZ@x1n>
References: <20241202220137.32584-1-farosas@suse.de>
 <20241202220137.32584-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241202220137.32584-6-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Mon, Dec 02, 2024 at 07:01:36PM -0300, Fabiano Rosas wrote:
> If the destination side fails at migration_ioc_process_incoming()
> before starting the coroutine, it will report the error but QEMU will
> not exit.
> 
> Set the migration state to FAILED and exit the process if
> exit-on-error allows.
> 
> CC: Thomas Huth <thuth@redhat.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2633
> Reported-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

(I skipped the postcopy patches as of now, until we finish the discussion
 in patch 2)

> ---
>  migration/channel.c   | 11 ++++++-----
>  migration/migration.c | 31 ++++++++++++++++++-------------
>  migration/migration.h |  2 +-
>  3 files changed, 25 insertions(+), 19 deletions(-)
> 
> diff --git a/migration/channel.c b/migration/channel.c
> index f9de064f3b..6d7f9172d8 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -40,13 +40,14 @@ void migration_channel_process_incoming(QIOChannel *ioc)
>  
>      if (migrate_channel_requires_tls_upgrade(ioc)) {
>          migration_tls_channel_process_incoming(s, ioc, &local_err);
> +
> +        if (local_err) {
> +            error_report_err(local_err);
> +        }

What if tls processing failed here, do we have similar issue that qemu will
stall?  Do we want to cover that too?

> +
>      } else {
>          migration_ioc_register_yank(ioc);
> -        migration_ioc_process_incoming(ioc, &local_err);
> -    }
> -
> -    if (local_err) {
> -        error_report_err(local_err);
> +        migration_ioc_process_incoming(ioc);
>      }
>  }
>  
> diff --git a/migration/migration.c b/migration/migration.c
> index 8a61cc26d7..cd88ebc875 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -943,7 +943,7 @@ static bool migration_should_start_incoming(bool main_channel)
>      return true;
>  }
>  
> -void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
> +void migration_ioc_process_incoming(QIOChannel *ioc)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      Error *local_err = NULL;
> @@ -966,10 +966,9 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>           * issue is not possible.
>           */
>          ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
> -                                          sizeof(channel_magic), errp);
> -
> +                                          sizeof(channel_magic), &local_err);
>          if (ret != 0) {
> -            return;
> +            goto err;
>          }
>  
>          default_channel = (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC));
> @@ -977,8 +976,8 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>          default_channel = !mis->from_src_file;
>      }
>  
> -    if (multifd_recv_setup(errp) != 0) {
> -        return;
> +    if (multifd_recv_setup(&local_err) != 0) {
> +        goto err;
>      }
>  
>      if (default_channel) {
> @@ -995,18 +994,24 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>              postcopy_preempt_new_channel(mis, f);
>          }
>          if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> +            goto err;
>          }
>      }
>  
> -    if (migration_should_start_incoming(default_channel)) {
> -        /* If it's a recovery, we're done */
> -        if (postcopy_try_recover()) {
> -            return;
> -        }
> +    if (migration_should_start_incoming(default_channel) &&
> +        !postcopy_try_recover()) {
>          migration_incoming_process();
>      }
> +
> +    return;
> +
> +err:
> +    error_report_err(local_err);
> +    migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
> +                      MIGRATION_STATUS_FAILED);
> +    if (mis->exit_on_error) {
> +        exit(EXIT_FAILURE);
> +    }
>  }
>  
>  /**
> diff --git a/migration/migration.h b/migration/migration.h
> index 0956e9274b..c367e5ea40 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -477,7 +477,7 @@ void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
>                         MigrationStatus new_state);
>  
>  void migration_fd_process_incoming(QEMUFile *f);
> -void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
> +void migration_ioc_process_incoming(QIOChannel *ioc);
>  void migration_incoming_process(void);
>  
>  bool  migration_has_all_channels(void);
> -- 
> 2.35.3
> 

-- 
Peter Xu


