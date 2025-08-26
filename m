Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFC6CA0FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 18:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqyLM-0005oq-5L; Tue, 26 Aug 2025 14:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uqyLJ-0005ni-Kj
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 14:24:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uqyLA-00057q-Dz
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 14:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756232651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u9uAnYy1lqTsGfhVnhBsTvOYZu8mfrRkbTlkzadZb/I=;
 b=TCFTJiKIE6Oa+xkERYroRGaieWFqwCsji5E9+rrgP943/njlugb0MjJ9GB8RV19RBSuPS8
 5fHeb1/NDyYeenKwNsBrjnwV1xmvrVpU+qdGGUrFEJTUaalUhQZ4hzyDvBD7HyFnCwb0u4
 6WxmGVv9torwedXdTLqr6litDjJ8XAc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-JQWyDv_VOiS8ImCsly7ssA-1; Tue, 26 Aug 2025 14:24:09 -0400
X-MC-Unique: JQWyDv_VOiS8ImCsly7ssA-1
X-Mimecast-MFC-AGG-ID: JQWyDv_VOiS8ImCsly7ssA_1756232649
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7e870623cdaso1264970285a.2
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 11:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756232649; x=1756837449;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9uAnYy1lqTsGfhVnhBsTvOYZu8mfrRkbTlkzadZb/I=;
 b=bMWDTBTDaQthDPFkSaiokIQbxIM1dzXnwn5QaA5ZDGBck+fygllShRjWv6JhdhPgWe
 nVZhnBe01lpKa9yHco5e9J2pAfNVpKlN153+4VQITPgLQXtudKhYjlYfT3P1OPgruJSK
 3ssb/bjXUVubWiM5+a0ZoYUnK2KEfTVjIfqYshEfxC1Q0NnZ32UCzbWu50R7lSzBC4+o
 lfZrnYawNNs4WSK8kTLjRpgBDEtfPxd8CVDIeFfQPeoZKaHHvfmfGu7EcASHZfdzTZUA
 Ll/6wCvH5ZbNbwDJbcXZpIbhR4kozS/2moIkrq7cM8vAy9R0Kl/T2SUXXWAI7EqWqmLM
 cyqA==
X-Gm-Message-State: AOJu0YyZ+rFk4kZ8tqp+x35eBIyp6ojML04Rc0vGzNKNCCyascjaNQLl
 FeSmg4qNzw7uwfpi1ix5+aRV1s9iz+IPGAoQLAPbsJ4IEPJm+MXm+UZA2/2/WchCIVtFIWihMOs
 XFGovE3epaiz/LpTUNLnSX9ct955bEC5HZL+EsXExVY4uy8Ub+NXtVyaTeYLaUXMH
X-Gm-Gg: ASbGncvyV9f9kXqpkKXV9kSsDjZf88SQomvdzeZlDMMIVXR+5tS8pHY/2g0lus3/QOp
 iYRbia/gjmM2cjJ6fw04Bc38tg1Vm7mem8BspnC+sMaJZEJKzj9NmcRyKAdhVDydJBSqSYefw7u
 CvYt9FP9ugxnjxrmtmEmFGcQ9E0NIGnXWJBlLCX9XwtSLecUx0ZRa7zTpwo+hHud9dZFkCIl/Ff
 n5nhR/brwENeohdTWLX7xnJ0Q/e54/zON0TW2dZzOOcjrLe6XycGCJRXv5I1qY5lUvNj8ydg3O1
 jkOGiaEEdarI9I7aCOB+4ktks19KPXOR
X-Received: by 2002:a05:620a:171f:b0:7e8:8f76:2114 with SMTP id
 af79cd13be357-7ea10f9496dmr1910583185a.36.1756232649036; 
 Tue, 26 Aug 2025 11:24:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjPVFHXXO6QfL6TvOS5A0VZ8YEPpv1+TX3vrHOjyUvXHWRn1WvZRTK3ZACaro4PD5Pnava4w==
X-Received: by 2002:a05:620a:171f:b0:7e8:8f76:2114 with SMTP id
 af79cd13be357-7ea10f9496dmr1910580185a.36.1756232648620; 
 Tue, 26 Aug 2025 11:24:08 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b2b8caab26sm77342891cf.19.2025.08.26.11.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 11:24:08 -0700 (PDT)
Date: Tue, 26 Aug 2025 14:23:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] migration: Fix state transition in postcopy_start()
 error handling
Message-ID: <aK37u8DSP4tGFcLI@x1.local>
References: <20250826115145.871272-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250826115145.871272-1-jmarcin@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Aug 26, 2025 at 01:51:40PM +0200, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> Commit 48814111366b ("migration: Always set DEVICE state") introduced
> DEVICE state to postcopy, which moved the actual state transition that
> leads to POSTCOPY_ACTIVE.
> 
> However, the error handling part of the postcopy_start() function still
> expects the state POSTCOPY_ACTIVE, but depending on where an error
> happens, now the state can be either ACTIVE, DEVICE or CANCELLING, but
> never POSTCOPY_ACTIVE, as this transition now happens just before a
> successful return from the function.
> 
> Instead, accept any state except CANCELLING when transitioning to FAILED
> state.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 48814111366b ("migration: Always set DEVICE state")
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>

Thanks, Juraj!

Reviewed-by: Peter Xu <peterx@redhat.com>

> 
> ---
> In the RFC[1] where this patch was discussed, there was also a
> suggestion for a helper function migrate_set_failure() that would check
> if the state is not CANCELLING and then set migration error and FAILED
> state. I discussed the implementation with Peter, and we came to a
> conclusion that instead of patching such clean-up on top of the current
> error handling code, it might be more useful to do a larger refactor and
> clean-up of all error handling in the migration code.
> 
> Such clean-up should reduce the number of places where we need to
> explicitly transition to a FAILED state (ideally to one, or only a
> couple of places), and instead only set an appropriate migration error
> using migrate_set_error(). Additionally, it would also refactor
> inappropriate uses of QEMUFile errors where the error is not really an
> error of the underlying channel and migrate_set_error() should be used
> instead.

Fabiano: we discussed something around the FAILED status before as well.
If you started working on something in this area, please shoot!

> 
> [1]: https://lore.kernel.org/all/20250807114922.1013286-3-jmarcin@redhat.com/
> ---
>  migration/migration.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 10c216d25d..32b8ce5613 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2872,8 +2872,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>  fail_closefb:
>      qemu_fclose(fb);
>  fail:
> -    migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> -                          MIGRATION_STATUS_FAILED);
> +    if (ms->state != MIGRATION_STATUS_CANCELLING) {
> +        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
> +    }
>      migration_block_activate(NULL);
>      migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
>      bql_unlock();
> -- 
> 2.50.1
> 

-- 
Peter Xu


