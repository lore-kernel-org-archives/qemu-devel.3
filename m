Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AD2CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 19:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEX2Q-0001rG-0z; Wed, 07 Oct 2026 15:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEX2P-0001r6-BT
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 15:10:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEX2N-0004si-8o
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 15:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791400245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r8XwEofau+bzhB+ZlpOjh4fKtLHN8BF9ds+7im5aQKM=;
 b=c7nOW96hNm954NSYb3ptk5L00CGTIg/fHYf8MMPO9cwcyOaYJWpi8R5b6yLGWk/o4VTUVR
 tnQH38KPktYkb+PAOqEvisp+RzGtSPNxmnFgi3Lk0eXqQGhLm194XU1iys/rfk9U3X1Bb2
 yolRB3nlAb/xSX6WGD6NaZ759ZPFJCU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-lBu7AZ29M6W0Gu1HdAqPQQ-1; Wed, 07 Oct 2026 15:10:44 -0400
X-MC-Unique: lBu7AZ29M6W0Gu1HdAqPQQ-1
X-Mimecast-MFC-AGG-ID: lBu7AZ29M6W0Gu1HdAqPQQ_1791400244
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9195c59ac8cso105827326d6.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 12:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791400244; x=1792005044; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r8XwEofau+bzhB+ZlpOjh4fKtLHN8BF9ds+7im5aQKM=;
 b=WA3oNjZwSpQsZEKaCzjlDTror1MKqoffEzeXq117JoWvQxalkoSd7AbB8sx5y1ZK8L
 uiaoozLKMa29GiMwcuMDYYWbf6eeZ+p4MqVAarT18PP8UxsIgrdBQDV0Hs2I+YhqS4fZ
 KO85tC+MIA2aMWVvAd8YDi0uGJIHSD+RBjHgtIsZlxmq5br+xsX6/MwMRodLA03aKN3x
 4OjzfTPwd3tTrEvGHaLk6TgXtyYvc60wpoA8lmMqEhBFuk8NnmbadWH1RZa6wz0XxHRx
 rUSdz1tEAgZ9YS4cUCb9VFHcU13HYbzz+unw0SX9y/IlQEZG1vK4QxedrEP3umy97LhE
 hFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791400244; x=1792005044;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r8XwEofau+bzhB+ZlpOjh4fKtLHN8BF9ds+7im5aQKM=;
 b=KNNLPZghpO9yRIW/ZHmQLZCsdaO1rKl9QDs4HY4WIXqG3JB3dnnex1GqczxCGCPCqH
 F7WVB8tqcLJR0T9bUApYdfyuhqXtbnCTM9RZjPC3Dver1x5gwJU/RqOzJXtjSsBdwpME
 KYysW/VajUwThcri738qsXRAwmTgsG/Nh3VVn9hTvSAAgJok8EYNWSxrOa5FDmLddHgU
 55Ze1csa8/yumOOr7lNN6nc2WkKiprTJ63azqQfWbte3sHaIz517q3pFLjdsPuIA8Fv/
 teQQWqequGomA3iP9eKlNu2BImI8Ga08y1UVU8uVPpDsV8DrRuy5GknnPReS57SvB0N+
 g05w==
X-Gm-Message-State: AFuF++mnR7/WdH6yYLGv+0m03sq98mTJA4Y4PL1MCvCOKvFM95CcbCzF
 fPI0c+evW8P+W06afNC1fKcBfItx+k92zg5hjwfK9wk61faNCaHLG8GN6B3UM8GMsLeD8u+Aoyc
 iRBU7ieZBktvTqkt60jrs81MFHlgyRa55OuolFWlYCqMSGIIcSMOep+VW
X-Gm-Gg: AYBFou0Ck3A49EFKADD7/1nin5rtBGpeBDy4DmJKlqkKCtYXk1IIJ0u5zWzXAPsFrwc
 ouAO0qHNWynMSCinFgIv7ipmzuAOrXV+td84V6pclAQl2oDiZuBcb5uRCEI436nXQjqEX4UGhIw
 sOfXuFwWdMK86aRjFG5e8jcrDd/CJFKgMvqwJd7Hnxzanifj1C1QSZJaWrq1NtTr19R88NbKRtc
 S3X3Pn4WPvGIdCixSdf9qbJ/Trmq6N6dkpipeljSVSpQPV9XXG2PC7A0fXl1zat7W9te/odTFd5
 aSgjXP3WBNZLYsWVJhPJNEEFeU7Ko03P+sMqQNFqHhmc87RiefWNLZRE2PLn9To0MxaXPRA=
X-Received: by 2002:a05:6214:2b0f:b0:917:a742:477 with SMTP id
 6a1803df08f44-919978169c3mr65810806d6.21.1791400243740; 
 Wed, 07 Oct 2026 12:10:43 -0700 (PDT)
X-Received: by 2002:a05:6214:2b0f:b0:917:a742:477 with SMTP id
 6a1803df08f44-919978169c3mr65810296d6.21.1791400243225; 
 Wed, 07 Oct 2026 12:10:43 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91996cb5bd3sm27612656d6.11.2026.10.07.12.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 12:10:42 -0700 (PDT)
Date: Wed, 7 Oct 2026 15:10:41 -0400
From: Peter Xu <peterx@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 2/4] migration/postcopy: set destination postcopy-active
 in the run BH
Message-ID: <asaZMSjK7qqACgBF@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261002110258.1835979-1-den@openvz.org>
 <20261002110258.1835979-3-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002110258.1835979-3-den@openvz.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 02, 2026 at 01:02:56PM +0200, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> Commit 7b842fe354c ("migration: Introduce POSTCOPY_DEVICE state") made
> the destination enter POSTCOPY_ACTIVE in loadvm_postcopy_handle_run(),
> before it schedules loadvm_postcopy_handle_run_bh(), and only the BH
> starts the VM or moves it to RUN_STATE_PAUSED. Management reacting to
> the destination's postcopy-active event can therefore still find the
> VM in RUN_STATE_INMIGRATE, where blockdev-add creates inactive nodes
> and attaching a device to them fails with "Block node is read-only".

Yes, this is a fact that we have two "status" during postcopy phase, "query
migrate" and "query status".  I don't think we have clear definition on how
they can correlate, and if there's strict order of state changes..

Pure question is, why not the mgmt listen to the vmstate change event
directly (or both)?  IOW, I believe mgmt still can have full knowledge of
the status quo depending on how mgmt is implemented.

> 
> Move the transition to the end of the run BH, after vm_start() or
> runstate_set(), as process_incoming_migration_bh() does for precopy
> COMPLETED. Without a return path the listen thread enters

True, it is still reasonable to at least keep them aligned, that if we
update vmstate first then always do that.

> POSTCOPY_ACTIVE directly, and the fast snapshot load path switches
> right after scheduling the BH; in both cases the state is no longer
> POSTCOPY_DEVICE when the BH runs and the transition is a no-op.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Juraj Marcin <jmarcin@redhat.com>
> ---
>  migration/savevm.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 5ec09d4889..bc1bc98a0e 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2263,6 +2263,10 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
>      }
>  
>      trace_vmstate_downtime_checkpoint("dst-postcopy-bh-vm-started");
> +
> +    /* Already POSTCOPY_ACTIVE without a return path or in fast snapshot load */
> +    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
> +                      MIGRATION_STATUS_POSTCOPY_ACTIVE);

I think the "if" is good here, rather than relying on migrate_set_state()
behavior.. I actually want to change it, low priority but still: the
current "if old state is not specified silently ignore" behavior is error
prone.

>      qemu_event_set(&mis->postcopy_run_event);
>  }
>  
> @@ -2277,11 +2281,6 @@ static int loadvm_postcopy_handle_run(MigrationIncomingState *mis, Error **errp)
>          return -1;
>      }
>  
> -    /* We might be already in POSTCOPY_ACTIVE if there is no return path */
> -    if (mis->state == MIGRATION_STATUS_POSTCOPY_DEVICE) {
> -        migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
> -                          MIGRATION_STATUS_POSTCOPY_ACTIVE);
> -    }
>      postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
>      migration_bh_schedule(loadvm_postcopy_handle_run_bh, mis);
>  
> -- 
> 2.53.0
> 

-- 
Peter Xu


