Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5FFD1F9C5
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 19:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0mrw-0002Jz-Qj; Tue, 15 Oct 2024 15:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t0mru-0002JD-GJ
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 15:06:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t0mrr-00005s-JJ
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 15:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729019162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QTV5trzBUQpukdF+cuE9QPTllqiIeU4/b6EtuxirOZk=;
 b=dFDD2z8hteB4kwBJQ2NgxrbHxVYj1xbxibSORjsKwByTI6KBVm39QpQ4YbB6xd/HKgSWDe
 wKNR9Mj6PRY/MuKU4Ov1KbnA8mhb7c/M6W9/iLXniEMAdMKems9lT5FaQc0yv8pET2KEF8
 JIk9u8hyM1s+y2SDCIJUfDKokpemBzQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-BzAHuz8jOo-ktlkSekan1A-1; Tue, 15 Oct 2024 15:05:59 -0400
X-MC-Unique: BzAHuz8jOo-ktlkSekan1A-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6cbebfc1725so122682716d6.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 12:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729019159; x=1729623959;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTV5trzBUQpukdF+cuE9QPTllqiIeU4/b6EtuxirOZk=;
 b=i4ksrQKwtowHNqewp8cr/Su76l8qEENw+k2uNBo1eFGuYm4yvAHBXc/QTCenxUZ2RN
 7a9Q7GRVvTpVL2nGRD/S0S4xGP8pmn8ZjttyfFyLlcYUhJmW7Xlw/A+wqDfmcElnNJ7H
 ThBOz0xIpJH87J38FwaUb5H7pdbWd1QMQCul78abAlFyChJF8b/IwWaNhJn8gR2s8z93
 GAYARatqCX87s5ZylV30rZjHZ0eTJihjsjtJIDMvxyTVuDyjnqApmhDpXhn6gVBjjgC9
 koHQZxtyTEaP8wW+1Gq5eLfa9s/9F5g4YB27D/dRGAtLkZz9Q2S1aDPHhFN9PAo9Ggti
 3rmA==
X-Gm-Message-State: AOJu0YxPk+7i8FT3jlaJZN+617PLVa7/nUv6M1OZzlv+GWWwcQKmHJW7
 hdF5ACtM+uLmSgUg+CuFrldF1iSQIHBa71W9IK6veWTXbYJ1VBE1HJmHOXKu9woHM2NYoLH/I92
 3UqjXjI55DRsFVaLpjDuUqVleQUyPSBrIcqHmZnhRKRpHAoFavnIU
X-Received: by 2002:a05:6214:3990:b0:6cb:f6ff:f5dc with SMTP id
 6a1803df08f44-6cbf9cb2efdmr243944646d6.6.1729019158848; 
 Tue, 15 Oct 2024 12:05:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHse5loyAG7M1dqaz0+N5ZVkHf5nOsIOqvXVIbybe0Z67W9aL3+n/hZJkGcesVZW2t5jX8hvw==
X-Received: by 2002:a05:6214:3990:b0:6cb:f6ff:f5dc with SMTP id
 6a1803df08f44-6cbf9cb2efdmr243944376d6.6.1729019158416; 
 Tue, 15 Oct 2024 12:05:58 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc2295af43sm9859916d6.98.2024.10.15.12.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 12:05:57 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:05:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v2] migration: Ensure vmstate_save() sets errp
Message-ID: <Zw69E9nvy8wQjrGZ@x1n>
References: <20241015170437.310358-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241015170437.310358-1-hreitz@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 15, 2024 at 07:04:37PM +0200, Hanna Czenczek wrote:
> migration/savevm.c contains some calls to vmstate_save() that are
> followed by migrate_set_error() if the integer return value indicates an
> error.  migrate_set_error() requires that the `Error *` object passed to
> it is set.  Therefore, vmstate_save() is assumed to always set *errp on
> error.
> 
> Right now, that assumption is not met: vmstate_save_state_v() (called
> internally by vmstate_save()) will not set *errp if
> vmstate_subsection_save() or vmsd->post_save() fail.  Fix that by adding
> an *errp parameter to vmstate_subsection_save(), and by generating a
> generic error in case post_save() fails (as is already done for
> pre_save()).
> 
> Without this patch, qemu will crash after vmstate_subsection_save() or
> post_save() have failed inside of a vmstate_save() call (unless
> migrate_set_error() then happen to discard the new error because
> s->error is already set).  This happens e.g. when receiving the state
> from a virtio-fs back-end (virtiofsd) fails.
> 
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
> v2: As suggested by Peter, after vmsd->post_save(), change the condition
>     from `if (!ret)` to `if (!ret && ps_ret)` so we will not create an
>     error object in case of success (that would then be leaked, most
>     likely).
> ---
>  migration/vmstate.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

queued, thanks!

-- 
Peter Xu


