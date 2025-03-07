Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A25BC282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqgUr-0006SU-Sz; Fri, 07 Mar 2025 17:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tqgUf-0006Pl-FM
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:48:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tqgUc-0000h1-Bq
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741387710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ek5+xg41EaS7IN5ZmwoPe8zmBRif1Lf4faAlJF7bo/s=;
 b=cKmSEpJOYt0YwrUvihiThsT4cGajzka0z6VqLNvf4U4jK+a5APEUd8xXVfi8XpUzPqMejr
 QKZuajQEHnKj6EO1uqQW/L3M76gwmXbZ7a5z2z6Fwf/T+BZy4cyTZicPDXUX3+hFEKj83Y
 Qk5fxMSOt3WkK/NhBIsFVKJxlKsXcg4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-y71RpOvZPQ-lgM0vCnu8_w-1; Fri, 07 Mar 2025 17:48:29 -0500
X-MC-Unique: y71RpOvZPQ-lgM0vCnu8_w-1
X-Mimecast-MFC-AGG-ID: y71RpOvZPQ-lgM0vCnu8_w_1741387709
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6e8a2052e33so85909806d6.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 14:48:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741387709; x=1741992509;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ek5+xg41EaS7IN5ZmwoPe8zmBRif1Lf4faAlJF7bo/s=;
 b=WRPprP1fn8JpOPFFY9RRX9y7WzdxOrXS3gQRIQ2KtZs4fMuP6tyQmFEV1FqBfWusrI
 eHQXJmY5IzGdGRXhTB8Znojd/CjxX/ZIJFB2VxoG8lbVQH6P09nSsvko0Vbu295H4wiK
 OPqu6ILLdf9XOYoBCEIaYhxWut5/9h1/GyeukFG4zOJrNJY2ltBsjNXQHXHAX9DokZo6
 DBhEiloYbPqiurIbAgo1L0nLIeMbPFnn7amSwcg4ZcSKZVwXWu75Nd2vjwUNRtlJG3wj
 76rQRytyp/pRthO8fbMheCyHI+lDKBGwYOnxJ/CxX5LRy0mmaPuyWB98R6Nz8iaeIqNP
 pNBA==
X-Gm-Message-State: AOJu0Yy1IuHD+3zMxhimOYZMTiOy11NntlFmDnU7M3n53F4kBw31wXZq
 p/p+POIIO/5ORgTeQHRSBOoRjzuOsz/9g6l0NTo62+mUBg70Jgt8qRcv5Tu426xWnB4HB3qz/K3
 iKix7i0KpWK8RMMqVnGyOJTpdxSINbe7d3MJWqDIGt3qUjiuNorKQ
X-Gm-Gg: ASbGnct5AShsZspbGzDEbhaAVD8X/FxRdFLGMO+XQkP1vaXez+M5XbZvtv96XX6T2fJ
 Sj8dOHtOSO0kjES7zq8GfcRb0Zqw5sbPC8wBr5cz7PppZXa/kHiURq4/1Ucot2dqY14+IAmLljp
 3unhUDKwTFPRhukqzZffzgByRxkec+Mi7CRmjOFWU/uY7fEOQXUUMPTr0KDxVdg/kJdBGW1TN9L
 NNvkgQF+lkfQkXO1niC3R9bEnq7FC+bn5CDGkPHq7Y/5KqWfVweC0JuO0pV20pJtqIhNMjbEUur
 eXOTsbg=
X-Received: by 2002:a05:620a:6501:b0:7c3:c46b:d941 with SMTP id
 af79cd13be357-7c4e16775femr906729885a.6.1741387708754; 
 Fri, 07 Mar 2025 14:48:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTkiKkSib6k/2+F9ZZ2+zNWDJqVirem2AD1D0GYVX9EfJLwB59xUhDBb1v3A3sK2dgP/DYRQ==
X-Received: by 2002:a05:620a:6501:b0:7c3:c46b:d941 with SMTP id
 af79cd13be357-7c4e16775femr906727285a.6.1741387708442; 
 Fri, 07 Mar 2025 14:48:28 -0800 (PST)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c3e54ffa60sm299251185a.76.2025.03.07.14.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 14:48:27 -0800 (PST)
Date: Fri, 7 Mar 2025 17:48:24 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v7 5/5] migration: add MULTIFD_RECV_SYNC migration command
Message-ID: <Z8t3uKo54T_Xls_O@x1.local>
References: <20250228121749.553184-1-ppandit@redhat.com>
 <20250228121749.553184-6-ppandit@redhat.com>
 <Z8G9Wj3DWSgdLkNQ@x1.local>
 <CAE8KmOxenqyqOxEFozgP1gBZPtneEqcbop9F_f+VW3ukPfw37A@mail.gmail.com>
 <Z8XBowkG72G-l3L4@x1.local>
 <CAE8KmOyssf_2RYBw2LLpxP2Z5bmtyU==Qs+4HWp=mOVb9o82-g@mail.gmail.com>
 <Z8cPnxqOvp1hFpx8@x1.local>
 <CAE8KmOw1CCQUt0wyELVhy5j-CfwVuA2XNsecW=y6rwJv7dempw@mail.gmail.com>
 <Z8hJeneeuKqD1i8Q@x1.local>
 <CAE8KmOyKiEt9t0vUwVyqD7tx01vkm+NHA1p1tmQnJ9mKY0Za7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOyKiEt9t0vUwVyqD7tx01vkm+NHA1p1tmQnJ9mKY0Za7w@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Mar 07, 2025 at 05:15:03PM +0530, Prasad Pandit wrote:
> Hello Peter,
> 
> On Wed, 5 Mar 2025 at 18:24, Peter Xu <peterx@redhat.com> wrote:
> > > On Tue, 4 Mar 2025 at 20:05, Peter Xu <peterx@redhat.com> wrote:
> > > > I think we need the header, the ram is a module.
> > > > Do similarly like qemu_savevm_state_complete_precopy_iterable() but do

[1]

> > > > whatever a vmstate hander wants, so it'll be with a header.
> > >
> ===
> diff --git a/migration/migration.c b/migration/migration.c
> index 65fc4f5eed..da2c49c303 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3401,9 +3401,10 @@ static MigIterateState
> migration_iteration_run(MigrationState *s)
>      if (!in_postcopy && must_precopy <= s->threshold_size
>          && can_switchover && qatomic_read(&s->start_postcopy)) {
>          if (migrate_multifd()) {
> -            multifd_send_flush();
> -            multifd_send_sync_main(MULTIFD_SYNC_LOCAL);
> -            qemu_savevm_send_multifd_recv_sync(s->to_dst_file);
> +/*          multifd_send_flush();
> + *          multifd_send_sync_main(MULTIFD_SYNC_ALL);
> + *          qemu_savevm_send_multifd_recv_sync(s->to_dst_file);
> + */
> +            qemu_savevm_state_complete_multifd(s->to_dst_file);
>              multifd_send_shutdown();
>          }

Please move all of them at the entry of postcopy_start().

>          if (postcopy_start(s, &local_err)) {
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 0b71e988ba..c2b181b0cc 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1602,6 +1602,37 @@ int qemu_savevm_state_complete_precopy(QEMUFile
> *f, bool iterable_only)
>      return qemu_fflush(f);
>  }
> 
> +int qemu_savevm_state_complete_multifd(QEMUFile *f)

I still like the name I provided because it's more generic, above [1].

> +{
> +    int ret;
> +    SaveStateEntry *se;
> +    int64_t start_ts_each, end_ts_each;
> +
> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +        if (strcmp(se->idstr, "ram")) {
> +            continue;
> +        }
> +
> +        start_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
> +        trace_savevm_section_start(se->idstr, se->section_id);
> +
> +        save_section_header(f, se, QEMU_VM_SECTION_END);

Maybe it should be SECTION_PART.   So we provide all iterator a chance to
do something right before switching to postcopy but before VM stop.  RAM
can register.

> +
> +        ret = se->ops->save_live_complete_precopy(f, se->opaque);

Maybe we don't want to run the whole iteration but only flush.  I think for
simplicity we can make a new hook.

> +        trace_savevm_section_end(se->idstr, se->section_id, ret);
> +        save_section_footer(f, se);
> +        if (ret < 0) {
> +            qemu_file_set_error(f, ret);
> +            return -1;
> +        }
> +        end_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
> +        trace_vmstate_downtime_save("iterable", se->idstr, se->instance_id,
> +                                    end_ts_each - start_ts_each);

We do not need to account 

> +    }
> +
> +    return ret;
> +}
> +
>  /* Give an estimate of the amount left to be transferred,
>   * the result is split into the amount for units that can and
>   * for units that can't do postcopy.
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 91ae703925..e3789984a1 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -70,5 +70,6 @@ int qemu_load_device_state(QEMUFile *f);
>  int qemu_loadvm_approve_switchover(void);
>  int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>          bool in_postcopy);
> +int qemu_savevm_state_complete_multifd(QEMUFile *f);
> 
>  #endif
> ====
> 
> 63/63 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test
>      OK             164.02s   79 subtests passed
> 63/63 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test
>      OK             164.99s   79 subtests passed
> ====
> 
> * Does the above patch look okay?
> 
> ====
> Guest not dirtying RAM:
> ===================
> 2025-03-07 10:57:28.740+0000: initiating migration
> 2025-03-07T10:57:28.823166Z qemu-system-x86_64: info:
> multifd_ram_flush_and_sync: called
> 2025-03-07T10:58:04.450758Z qemu-system-x86_64: info:
> multifd_ram_flush_and_sync: called
> 2025-03-07T10:58:04.711523Z qemu-system-x86_64: info:
> multifd_ram_flush_and_sync: called
> 2025-03-07 10:58:05.078+0000: shutting down, reason=migrated
> 
> 2025-03-07 10:59:44.322+0000: initiating migration
> 2025-03-07T10:59:44.394714Z qemu-system-x86_64: info:
> multifd_ram_flush_and_sync: called
> 2025-03-07T11:00:20.198360Z qemu-system-x86_64: info:
> multifd_ram_flush_and_sync: called
> 2025-03-07T11:00:20.279135Z qemu-system-x86_64: info:
> multifd_ram_flush_and_sync: called
> 2025-03-07 11:00:20.571+0000: shutting down, reason=migrated
> ====
> 
> Guest dirtying RAM: $ dd if=/dev/urandom of=/tmp/random.bin bs=256M count=32 ...
> ================
> 2025-03-07 11:04:00.281+0000: initiating migration
> 2025-03-07T11:04:00.359426Z qemu-system-x86_64: info:
> multifd_ram_flush_and_sync: called
> 2025-03-07T11:05:51.406988Z qemu-system-x86_64: info:
> multifd_ram_flush_and_sync: called
> 2025-03-07T11:06:56.899920Z qemu-system-x86_64: info:
> multifd_ram_flush_and_sync: called
> 2025-03-07 11:08:02.376+0000: shutting down, reason=migrated
> 
> 2025-03-07 11:09:19.295+0000: initiating migration
> 2025-03-07T11:09:19.372012Z qemu-system-x86_64: info:
> multifd_ram_flush_and_sync: called
> 2025-03-07T11:11:24.217610Z qemu-system-x86_64: info:
> multifd_ram_flush_and_sync: called
> 2025-03-07T11:12:35.342709Z qemu-system-x86_64: info:
> multifd_ram_flush_and_sync: called
> 2025-03-07 11:13:48.947+0000: shutting down, reason=migrated
> ====
> 
> * When a guest is running some workload (dirtying memory), it seems to
> take a little more time before switching to the Postcopy phase.
> 
> > Let me know if you want me to write the patches.  That's almost the only
> > thing left to make it clearer..
> 
> * If the above patch is not okay,  it'll help if you share your
> version of it. Meanwhile I'll split the patch-2 and re-arrange other
> patches.

Please see above, if that doesn't help you come up with a final version,
I'll write it.

Thanks,

-- 
Peter Xu


