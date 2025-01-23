Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E7EC02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 20:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb40D-0007vM-52; Thu, 23 Jan 2025 15:40:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tb40C-0007ux-3z
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 15:40:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tb409-0007S7-Ba
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 15:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737664831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XZWdeiPg9u/A1guqGRT6c+JJ4h4r3msOZv6spyXi9Qc=;
 b=UWB+g9T/B/BG/aMf4YwUvhclOijMU0Spuvq8vyJShnVWGLBWjZqnOSZA9WyJCAq3K7oZEE
 Xxi8jl7d0IQ0zGgXR3yUbnV7twzwl0sjizcXBEdHBP/xJFg/VO82zX6GehmS6qGUeH6BsO
 QlVQ/aOQ5XZld/+g5GDlZG6X4i6sw4Q=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-8Pz5nBO4NG6Msq9njEHLPw-1; Thu, 23 Jan 2025 15:40:29 -0500
X-MC-Unique: 8Pz5nBO4NG6Msq9njEHLPw-1
X-Mimecast-MFC-AGG-ID: 8Pz5nBO4NG6Msq9njEHLPw
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4675c482d6cso25033691cf.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 12:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737664829; x=1738269629;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XZWdeiPg9u/A1guqGRT6c+JJ4h4r3msOZv6spyXi9Qc=;
 b=rRZEkwMKqUikjYAaOEZTGtGR89IQsvA3afWG0gK+FSiaY0XZE07dfUgJqmoPar/SIa
 /vP05LldJ6sskB9vYHP1gGb/OGeX1E5LKcRkbWVrvtwy5T0zbZpKqOBQL4mF0tLOCgGa
 VEJQR8hzZfV/Z7JTV2mHAjVhAKWQ1euOKw+GGH+FMFYYfxLE1ERXQSUdhNcYyEOV8csP
 ttBLK0FpH+xDeF8+nJ7ZsTe9mHhNm4uWj0XF7FE2xIdbCdQ84lr9/oyEBlvwoBM93Z5W
 T4gw7wBr6Jh3f5+FtDo1pPfFDC7blJseYleNHQOieofFdxgUni8OCczBfv4mX1IzG/D2
 7/iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOozIJMAUOzUKNueIDV85pIuV/VlR057yz/g1KfHd9MbvaIQq2maDh7lXGwIU+RnOMsw1OArBvjesp@nongnu.org
X-Gm-Message-State: AOJu0YyCVA8Di9Q14FdsFeQ07rkiyAFOYJV5lxXeEi5AeD5TTQC7uzP0
 zT7NufIgD/wBA3taIKKsm7XQuBechHZZqppIy4M0DHdWrsgf27wrwv8F0e7PQZ62zcevz0wu6hz
 jyfxhnl1EyknkobCo4BR+BAUSNH8xtc0yCE8FQQEupUeDBd9BnA37
X-Gm-Gg: ASbGncuuOJWQfVUskSp9z+3F4mqQSU+B3Uy6rVGl5YHIlqJnL3QVdM1hdIp0w7WUB8v
 hTHcmFDGSDRWKIIsSihQMqgAyZMWDz/1AM8tUUkimjJ9MOvs8OQyVZaGi5Q0PoqqwczNqV1t0Qc
 rmPDUGKVuD9xqANwEmgaeNt46jHM0uxhHpYKAflW5oRzLUcRKrp4Pkm7sSwWYM2Mp+UMOM1REdv
 lMUVqPWu0D6uw37ROZ1ASzlohAutmHXFcB0ykRoX9JWmWgnGBpq8v161RL19Cnq1/gUot5osL13
 V+CfQw/kB6p7BexsLibWh+LschhJs5M=
X-Received: by 2002:a05:622a:1306:b0:466:a6e4:4c1a with SMTP id
 d75a77b69052e-46e12b918a4mr447054281cf.31.1737664829284; 
 Thu, 23 Jan 2025 12:40:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/0KQsrwWUyIKFc+AdQlRMUmjO25/mJk52VUN3znCe/HKcW02+3x4Y1QARB3h+BoYK1+PxYg==
X-Received: by 2002:a05:622a:1306:b0:466:a6e4:4c1a with SMTP id
 d75a77b69052e-46e12b918a4mr447053991cf.31.1737664828937; 
 Thu, 23 Jan 2025 12:40:28 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e6687e3c2sm2639791cf.17.2025.01.23.12.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 12:40:27 -0800 (PST)
Date: Thu, 23 Jan 2025 15:40:25 -0500
From: Peter Xu <peterx@redhat.com>
To: Shivam Kumar <shivam.kumar1@nutanix.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH] Fix race in live migration failure path
Message-ID: <Z5KpOayak2EA3ajB@x1n>
References: <20250110100707.4805-1-shivam.kumar1@nutanix.com>
 <87frlqerxp.fsf@suse.de> <Z4U_emPVDfTb1VmF@x1n>
 <0C92F4E5-56EE-4036-927C-2F06F9F29252@nutanix.com>
 <Z5EfapuXuV7oFL7A@x1n>
 <35F19D15-7FD0-43D1-B6A0-2FBB5FD9313B@nutanix.com>
 <Z5Jt434QBy92NnBM@x1n>
 <CA955950-188F-4FA7-9405-D7BBC81EB84E@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA955950-188F-4FA7-9405-D7BBC81EB84E@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

On Thu, Jan 23, 2025 at 06:05:28PM +0000, Shivam Kumar wrote:
> 
> 
> > On 23 Jan 2025, at 9:57 PM, Peter Xu <peterx@redhat.com> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> > 
> > |-------------------------------------------------------------------!
> > 
> > On Thu, Jan 23, 2025 at 09:53:16AM +0000, Shivam Kumar wrote:
> >> 
> >> 
> >>> On 22 Jan 2025, at 10:10 PM, Peter Xu <peterx@redhat.com> wrote:
> >>> 
> >>> !-------------------------------------------------------------------|
> >>> CAUTION: External Email
> >>> 
> >>> |-------------------------------------------------------------------!
> >>> 
> >>> Hi, Shivam,
> >>> 
> >>> On Wed, Jan 22, 2025 at 10:54:17AM +0000, Shivam Kumar wrote:
> >>>> There is one place where we set the migration status to FAILED but we don’t set
> >>>> s->error, i.e. in save_snapshot workflow, please check qemu_savevm_state but
> >>>> not sure setting s->error in this case is possible (or required), as it seems a
> >>>> different workflow to me.
> >>> 
> >>> Yes it's very different indeed.  I may not yet fully get the challenge on
> >>> how switching to s->error (implies FAILING) would affect this one, though.
> >>> I mean, in qemu_savevm_state() it tries to fetch qemufile errors with:
> >>> 
> >>>   ret = qemu_file_get_error(f);
> >>> 
> >>> IIUC we could also try to fetch s->error just like what migration thread
> >>> does, and if it sets means it's failing?
> >> Yes, I can just set s->error in qemu_savevm_state.
> >> @@ -1686,7 +1686,6 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
> >> -        status = MIGRATION_STATUS_FAILED;
> >> +       s->error = *errp;
> >> But my question was: is migrate_fd_cleanup called (where we will set the status
> >> to FAILED if s->error is set) in the snapshot workflow?
> > 
> > I see what you meant.  It's not called indeed. We may need to process it
> > the same as what migrate_fd_cleanup() does.
> > 
> > So far the snapshot code reuses migration code in a partial way, so it's
> > not crystal clear where the line is, e.g., obviously it still moves the
> > migration state machine but it never shows "active" phase at all (even if
> > it has a major chunk of duration that it's actively migrating the data to
> > the snapshot files).  Here the state machine only goes from SETUP to either
> > FAILED or COMPLETED.
> > 
> > From that POV looks like we should duplicate such s->error detection logic
> > here on deciding whether to switch to FAILED, if we treat s->error as the
> > internal "single failure point" for migration.
> I hope setting the state to FAILED at the end of save_snapshot might work:
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1722,7 +1722,7 @@ cleanup:
>      qemu_savevm_state_cleanup();
> 
>      if (ret != 0) {
> -        qatomic_set(&ms->failing, 1);
> +        migrate_set_error(ms, *errp);
>      } else {
>          migrate_set_state(&ms->state, MIGRATION_STATUS_SETUP,
>                            MIGRATION_STATUS_COMPLETED);
> @@ -3054,6 +3054,7 @@ bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
>      RunState saved_state = runstate_get();
>      uint64_t vm_state_size;
>      g_autoptr(GDateTime) now = g_date_time_new_now_local();
> +    MigrationState *ms;
> 
>      GLOBAL_STATE_CODE();
> 
> @@ -3149,8 +3150,13 @@ bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
> 
>   the_end:
>      bdrv_drain_all_end();
> -
> +    ms = migrate_get_current();
>      vm_resume(saved_state);
> +    if (migrate_has_error(ms)) {
> +        migrate_set_state(&ms->state, MIGRATION_STATUS_SETUP,
> +                          MIGRATION_STATUS_FAILED);
> +    }
> +

I actually am not sure whether we need to postpone the FAILED update until
here for save_snapshot.

After all, merely the whole qemu_savevm_state() takes BQL, then there's no
way to race it with another "migrate" (QMP command "migrate" needs BQL too)
at this point.

OTOH, it also feels weird to update state in qemu_savevm_state_cleanup()..

Perhaps we can keep how qemu_savevm_state() would update FAILED state, then
we only need to update FAILED for precopy in migrate_fd_cleanup()?

We can still check for s->error in qemu_savevm_state(), though, because
after switching to a heavier use of s->error maybe we can fail the
save_snapshot() too with some s->error set (even if qemufile is still
working).  Then we may want to fail the save_snapshot() too.

Thanks,

-- 
Peter Xu


