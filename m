Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2446D1268E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 14:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQnvY-0004l1-UP; Wed, 03 Dec 2025 09:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQnvT-0004iD-0d
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 09:33:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQnvR-0001hX-3c
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 09:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764772427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5GEVcoLMRG+UDsw+yf635pEfIhNum5LmNropUw8//tg=;
 b=YPm/WTwrs0XMKb14+wkj90UWcIRfABM9LKNYkicbd+ESGCUFtTg5VcXtzB/o/U0cBeO0yx
 Fdgi5FAU8ap98+vLrPl37wDVcx63TQq8D8yFgvJfhX/Xr5jL5ZwK3IoFQ74VrNukVSdlrw
 mbsoraftDoowL+zz4JtixEwJicouOG8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-qEV9Kv8RMKST1CYh_vxzQg-1; Wed, 03 Dec 2025 09:33:46 -0500
X-MC-Unique: qEV9Kv8RMKST1CYh_vxzQg-1
X-Mimecast-MFC-AGG-ID: qEV9Kv8RMKST1CYh_vxzQg_1764772426
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b2e4b78e35so1317276785a.0
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 06:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764772425; x=1765377225; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5GEVcoLMRG+UDsw+yf635pEfIhNum5LmNropUw8//tg=;
 b=InyfdmDxOKJAoPk/hQYq7dhxiImgL3sTvscC95BYf4Eo8iIkLi9MXHdRoUmyPtAddx
 ds3/Zx6LI9ZnqSgcdf7YH9NC6DJkTxkjP2xKoFFB7kXv7VAOZ8P4tTWb8mgfqAH9+426
 kwn3YmzzYgQV8cnpJBFpFKJefzdkHl002BYjEOrfj1FHw7qosXNlEhGi4s/RwRCrq32c
 drbVCd6u1txKDn/FjCqugiKOloPx86Ivw/rI50icZE1pWv620VqHvbFNZ9A8UF0+f6j0
 BFZL8u2p4uePJ5gZdZ0kPbcN7pxuiYlQ9mipM/JO5168J66TMixkvPIPIjKB7o7lHUK4
 7EWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764772425; x=1765377225;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5GEVcoLMRG+UDsw+yf635pEfIhNum5LmNropUw8//tg=;
 b=Rk6wLS/LNMD5Nz7KjHhITvl3xC+UDzX4P0ePFdn4CIK5eZ3j+l7qDYQsTu1zfEhF3D
 amdZGFaVAfvbrMVjDQEiUS4yn9NYYR8TaD01sjpCT57jFCBsN9gQfVv85+72+D1TiZcr
 bZiz7V/FYXk52SEhHw8gPVGSFbHuzmt7TP7NzH99asrvFCgAmgP4mh/l5KTpRW2/yJh7
 r06D0LtsWFi1jFjU0nnJnnYfLTGa89ApBgW+q6qUpHWnWbAxz0sz8pD4CynIllKQluYm
 rti2TrxmbH04Oh0W77l4dZjNFklH99iQspoTHICjaW/olOCiq0uju/wqxh+1vo6Vql8w
 kVGQ==
X-Gm-Message-State: AOJu0YzhJ5MfUDK0vBzvAO43qNqDzH//gN/QohhaczIaqWZFX1MXgYwg
 L1lgA0RzBf6Kxy3KSUXEJoqyPK0hCE859f5EQP+Xe9JVJ3ar9D9QxUrn7x8Up0MV88eVZV7Zy9l
 Yx7QosRFTU+NauJk6fvdj6OUOwyUJEvDNYcjfyw2e5YM9AMWSrGmkABuFRC4cg8b25995QRjRYA
 gCu67VQPVM1l+DoJX95qJCJiNKVrasqM0fINcxpQ==
X-Gm-Gg: ASbGncsHiZu7fxLZ5EsozTAE0W/FLA8agy2PjHkx4vImyBMLPZ1+q7PdN7WO8lE/KIE
 F2vZCMQyYbbPekAlJtzt5trPF1oABtuObElk7Bq2WxW8oWDXz4sKUNBe4YG/louDUaLMa546j40
 jCBVRIYX4UufYBQiEvydW03bslH0On3jstEptWV8qP2mk4Gvhv0eLiBr4I767PsNPhmXTkqFQDJ
 cWqRCd5/UJxROMrgSNkd/5TUFh8/UCQjgVD+DEFLCZruZWWOzwKLCa5y6NzTEHOm9r90VZc2gni
 JAFqdpGjMhr/K44SF6QfOcziJ56rqhGNiTfAcMSd3YYDG9EDt0LHNte33i17A3CDlfKpxfxc6+m
 NiOc=
X-Received: by 2002:a05:620a:2953:b0:8b2:ea5a:4149 with SMTP id
 af79cd13be357-8b5e699a3afmr303857385a.65.1764772425422; 
 Wed, 03 Dec 2025 06:33:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF233AyYMQVwgqoqFAy63P9ioZHANywtqyW1X998uMn/zTZRsVNYUtL4qsNxDdqfTWgdReT8A==
X-Received: by 2002:a05:620a:2953:b0:8b2:ea5a:4149 with SMTP id
 af79cd13be357-8b5e699a3afmr303850385a.65.1764772424771; 
 Wed, 03 Dec 2025 06:33:44 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b5299a5377sm1296799585a.14.2025.12.03.06.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 06:33:44 -0800 (PST)
Date: Wed, 3 Dec 2025 09:33:43 -0500
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH for-11.0 v2 0/7] migration: Error reporting cleanups
Message-ID: <aTBKR-zsOltzi8hB@x1.local>
References: <20251201194510.1121221-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251201194510.1121221-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 01, 2025 at 02:45:03PM -0500, Peter Xu wrote:
> Based-on: <20251125070554.2256181-1-armbru@redhat.com>
> 
> This series is based on Markus's recent fix:
> 
> [PATCH] migration: Fix double-free on error path
> https://lore.kernel.org/r/20251125070554.2256181-1-armbru@redhat.com
> 
> v2:
> - Added R-bs
> - Patch 1:
>   - update commit message on s/accidentally merged/merged without proper
>     review/ [Markus]
> - Patch 2:
>   - Added a new follow up patch here from Markus to poison Error's autoptr
> - Patch 3:
>   - Rename migration_connect_set_error to migration_connect_error_propagate
>     [Markus]
>   - Add comments in commit log for both migrate_connect() and the rename
>     [Markus]
> - Patch 4:
>   - Rename multifd_send_set_error to multifd_send_error_propagate [Markus]
> - Patch 6:
>   - Make migrate_error_propagate() take MigrationState* as before [Markus]
>   - Remove the one use case of g_clear_pointer() [Markus]
>   - Touch up commit message for the change
> 
> This series should address the issues discussed in this thread here:
> 
> https://lore.kernel.org/r/871plmk1bc.fsf@pond.sub.org
> 
> The problem is Error is not a good candidate of g_autoptr, however the
> cleanup function was merged without enough review.  Luckily, we only have
> two users so far (after Markus's patch above lands).  This series removes
> the last two in migration code and reverts the auto cleanup function for
> Error.  Instead, poison the auto cleanup function.
> 
> When at it, it'll also change migrate_set_error() to start taking ownership
> of errors, just like what most error APIs do.  When at it, it is renamed to
> migrate_error_propagate() to imply migration version of error_propagate().
> 
> Comments welcomed, thanks.
> 
> Markus Armbruster (1):
>   error: Poison g_autoptr(Error) to prevent its use
> 
> Peter Xu (6):
>   migration: Use explicit error_free() instead of g_autoptr
>   Revert "error: define g_autoptr() cleanup function for the Error type"
>   migration: Make migration_connect_set_error() own the error
>   migration: Make multifd_send_set_error() own the error
>   migration: Make multifd_recv_terminate_threads() own the error
>   migration: Replace migrate_set_error() with migrate_error_propagate()
> 
>  include/qapi/error.h             | 20 ++++++++++++-
>  migration/migration.h            |  2 +-
>  migration/channel.c              |  1 -
>  migration/cpr-exec.c             |  5 ++--
>  migration/migration.c            | 51 +++++++++++++++-----------------
>  migration/multifd-device-state.c |  6 ++--
>  migration/multifd.c              | 30 +++++++++----------
>  migration/postcopy-ram.c         |  5 ++--
>  migration/ram.c                  |  4 +--
>  migration/savevm.c               | 17 +++++------
>  10 files changed, 73 insertions(+), 68 deletions(-)

Thanks for the reviews, I queued all 8 patches for 11.0 (with small
tweaks per discussion).

-- 
Peter Xu


