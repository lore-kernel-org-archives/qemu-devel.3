Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AB6CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 14:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBCMJ-0002Nz-Jg; Mon, 28 Sep 2026 10:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBCM9-0002NZ-55
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 10:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBCM7-0005wK-Ka
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 10:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790605762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=azbmMCLaaW1NuDjp9xQ2sBlZxKmhXSjGRPSyAZD2ULw=;
 b=H6OeV6dJvrxMjE7+WE+kBzdSgtXQa9jo+O1uPU1jNsPn6WNC3lU+Xbr6e0lz7yaO+hj1jo
 +wLn8XKwX/SV/gztPojo7K2d+iE9D+Ja5ZGOCui68DArXM/eO/7WWWuDK99pOrfeJRQWKl
 +7PX+It6VnoCpLvXIfurjiuq+612U3Q=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-akNxktxQNUqyzdKvMfLlQA-1; Mon, 28 Sep 2026 10:29:20 -0400
X-MC-Unique: akNxktxQNUqyzdKvMfLlQA-1
X-Mimecast-MFC-AGG-ID: akNxktxQNUqyzdKvMfLlQA_1790605760
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9143a95c6b9so2105456d6.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 07:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790605760; x=1791210560; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=azbmMCLaaW1NuDjp9xQ2sBlZxKmhXSjGRPSyAZD2ULw=;
 b=dSGhKruRzp3Yksa4iT1ID7vh2CONOppPY5mXEG5HO+lbV3bVIOqod9WSC5VpiXAZDf
 3AfmfNzj1WQvw5b+HKuQs7J4UPYOW6bdk8cSnCkzcWwBlwvdQzkG8pIqaJdOai8unHK0
 Pu5rhR5XF+MXjumZy+fUTCJrWRnDqgBvt8OdJc34bApei2VQfCNCy+5AKhAW7hZ/GQK7
 P/HToclnz1uTyN80Y+yw4I0F+2VemhuxQbJ9dlwAIg7BBMqJApej6oeThEVSxeERp84Z
 QggsqQ4/26I5is6AqaQoFwxIpgtivtgewZni92AioaPUYkGZHk1EXGyYY/QmLUfmbgYa
 Tvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790605760; x=1791210560;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=azbmMCLaaW1NuDjp9xQ2sBlZxKmhXSjGRPSyAZD2ULw=;
 b=maIoislt6OFYp8YXxtf0K8wCV21yzN4Awt7DXKPI5J5lPepW2eXNmHCmH+ZrGWGcur
 T1jfaGI6r3gHC6HhUB4UoMTPfPT6r20U9yiAz9DzMEMUcYO1hsCNLYp6QBA2bXIlGLxu
 vsh5iEs1ODGJ5nXcFOt5j6J5aO3GvvUvOlPE8EGiqy3xgdynardj1lgJmZIdHpBGjiYM
 TMwDLPjCmsZr+JZoCi3KtRKnGvoikdNx1BzY20wKRS+PikY1KjFeQZnadbnCMQBzHo7b
 sFrthFK7VXC09ZGpL9myirl6YVqZTvy6OTzPIGsnStoi0fltzzPFHuFeUT4SX2oDMTWX
 vCgg==
X-Gm-Message-State: AFq9FYJAuEvvemMIGS2292vA9KAKCoDGSzsvJez3L6VY5Dx6OqN6UUUy
 NGtaFEL4jmd5BTIaOMfilyaf8zYiL5qnN7IxQ/IgE0yd9bdK+dYVGKs2ctWzlTm/B6kOqAZ1gWP
 1rBk5uunrhl4a+22JPb3UGXEiTwO1yT4Wa9Zm7mVI/rNEtJuTtBJKhmdy
X-Gm-Gg: AYBFou29EdzupDyQq+kKqLiDukNFYLsXaKbuRpAOHC8ZotE+JZWfnd/tY2FvgfiFuX/
 D0xwPS0e1qJbwpPorNznAEt299y0sZ/wqEUh2BP0VpO8braIzxNAFrZhAzLJnP7Dxay54TtKfzI
 g/C8yjeQ5WoyESzvMJF8A14vSiIwTwb6iB/RsAFGJDKGEs68Ov9+uf5I+djXM3+he6DagVo6wE1
 pasGglGdjOzJAJlIcHhZoKzvLF8cLOAjLa1+sBYd1kqYUr4XBD/Lm9dAMS/OazuYvD7b82mKGQE
 lvG2GKX/hUEd8j0S48aT5I6grdETvsiEKJOlkTtPX+bO4avoT9QjW6Ez6wRCU23BLjg6b20=
X-Received: by 2002:a05:6214:f23:b0:915:e765:a286 with SMTP id
 6a1803df08f44-915e765a4eemr75129666d6.19.1790605759780; 
 Mon, 28 Sep 2026 07:29:19 -0700 (PDT)
X-Received: by 2002:a05:6214:f23:b0:915:e765:a286 with SMTP id
 6a1803df08f44-915e765a4eemr75129086d6.19.1790605759185; 
 Mon, 28 Sep 2026 07:29:19 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91430dd2858sm81582056d6.21.2026.09.28.07.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 07:29:18 -0700 (PDT)
Date: Mon, 28 Sep 2026 10:29:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, bchaney@akamai.com,
 mark.kanda@oracle.com, philmd@oss.qualcomm.com,
 vsementsov@yandex-team.ru, maciej.szmigiero@oracle.com,
 dongli.zhang@oracle.com, mst@redhat.com, clg@redhat.com,
 den@openvz.org, sgarzare@redhat.com
Subject: Re: [PATCH v7 03/16] migration: forbid snapshots in CPR migration
 modes
Message-ID: <arp5vSgEhzX2gTsY@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
 <20260918-up-vsock-vhost-v5-v7-3-6ef9ef033c35@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260918-up-vsock-vhost-v5-v7-3-6ef9ef033c35@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

On Fri, Sep 18, 2026 at 04:46:54PM +0300, Andrey Drobyshev wrote:
> The savevm/loadvm operation doesn't make any sense in any of the CPR
> modes.  Saving VM state implies saving its RAM entirely, while the whole
> point of CPR is avoiding that: in cpr-transfer and cpr-exec modes RAM is
> preserved in place and never put into the migration stream (see
> migrate_ram_is_ignored() in migration/ram.c).  As a result, a snapshot
> taken with such a mode set has no RAM in it, and loading a snapshot with
> such a mode set fails in the RAM loader.
> 
> Currently nothing stops these operations from firing with a CPR mode
> still set, e.g. after an earlier CPR attempt.  Reject them early in
> migrate_can_snapshot(), which guards 'savevm'/'loadvm' HMP commands as
> well as 'snapshot-save'/'snapshot-load' QMP commands.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


