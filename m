Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BFCCCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 20:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGkaN-0003cF-KC; Wed, 05 Nov 2025 15:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vGkaM-0003c7-DJ
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 15:58:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vGkaJ-0001oY-HJ
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 15:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762376305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Sh85zAW4Cg0wSLKTl1hIsVn1DQsMW7dse9fEej6Xac=;
 b=Puhqe0axnBCZUKekdu/CBGavbBKc9Sqp5rst3MogTnTuju/qZ1c1RbOU7AQ19fO4ZhhdAQ
 QPkU/EEgWuNHqmXAyw9S4TODD2CZOhikHaJZhe/nP245aSCa2SUqrpq63WkB18xnRlLmG8
 ebmFaz6nu68jDTwkKjKO5cZBRoadAOo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-MqGV2UBANjq0_9FWZGE07w-1; Wed, 05 Nov 2025 15:58:24 -0500
X-MC-Unique: MqGV2UBANjq0_9FWZGE07w-1
X-Mimecast-MFC-AGG-ID: MqGV2UBANjq0_9FWZGE07w_1762376304
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8a6fc271d46so70390285a.2
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 12:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762376304; x=1762981104; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2Sh85zAW4Cg0wSLKTl1hIsVn1DQsMW7dse9fEej6Xac=;
 b=afqpCOlcbxmjtpYpSqVHUC4qkAtnUVm6dmmY4MR0ySVZKUERfSHRfqjb3lY3SNQdxz
 6AFcewyG3uEips8Acgf7ewnqI+DD5wDXOaO1soP0lvz9hmHlAfTAXHROWhyfgYzHpFWb
 E8bA865V3UREIHeATmpbV8hTVWfRNO9V9LCJH1psuf9Yu1aDJVOUFn4hdvDgLvOOZy+S
 5Lt1Foy1npg/kdZdvlWqi9GYZK3HXCWRYy5L+xCrhQPOZfqXLoL0NnmFehq+5DLsWN8N
 A1e2hcjNiKGTwh34ZBKSP5nDBGTArT/Y5OHwBs+YmhscU0h+egp0ZuoPj29tIi+En0gt
 C0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762376304; x=1762981104;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Sh85zAW4Cg0wSLKTl1hIsVn1DQsMW7dse9fEej6Xac=;
 b=eXlHccj7+kRJgm5RMfWdUFUfOAxJpT5qCoJio15jOlHYP8mePBHfa5oby/bC3m2Eqk
 Zz50dGYmJlCawrR3vdcMZVVAnjKdvVteT+mgIdL6cXf1bqUWlGTXIOzTxBhjUYwvAFnL
 WTN1qnVGGMON1CaLbCZXpumPTObzKfPbSr5ku0OM04484IdQyhuU+aU2oEaq6kh9+usH
 kY3UWwnbChkRHRWl1iWMTKJ5z2RRHaalnOX6w9FMLHLAZmgbpTb8Fam9ilC4BRewANq/
 A00P57vlQ6fBdYiq+aC8Bgp5b6h6OxhuJN78fxtSVOi3X4wPbbn/9xMnasaJOSjFERhp
 MA+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkWEszr3ZlmKQMr8MyQYCkhBjd9//h3ZPXKcsoe6i+OCySh6avtFMnbpbBqS94H8vO6FTDfWklK1J5@nongnu.org
X-Gm-Message-State: AOJu0YyIIiDApP201WYfA8bZI3W4dNIXvj/lF/d7xew9Jy1xKvzruC6m
 32d2BnMIotvc6De+OvsuDSlF3kGQ4GcfmW+RAaqZ5ztOpnmamgqrHz1elV0FrZxrfK/EUufC7tb
 5QCFxOJCqSjz72zyLx3+B7IhwmmmHYE+hCwpWk0zJkMGoDUydOWcG9aQ/
X-Gm-Gg: ASbGncsfkeRWxOc09oQvZnLlEH8RNm6AKZlgE9bT+UWp3jHqJr/KyQzMHyyIFwJVw5c
 J9P/4IGh1maYwAYlRLcteJOOU9oAMzYnb2HMTGUKtFEiKKl4hFHUBhY6ukE1fyitvnsNBy06nmB
 2cvE/d40zBhkqIXGadHGWeb9kHWdPPwGfcoutRatiOIkVwDecsJpvzhtZ/PB5RvRucjucXk93aB
 sCNLhe1+pAJqZvLajsTiCLIrLqWj8UkeJhB2UUcIbvAAFOhCCmDhMT0+iOlMOqQYchIvbeKRMdl
 C79BPWOnRsL/Pm0kw8z6Zf1oqG2I3gfaxUjL/EarHDZ12b9zUeFmYS9f675Fk05QMS8=
X-Received: by 2002:a05:620a:1910:b0:8a9:b9cc:b90d with SMTP id
 af79cd13be357-8b220ad924emr539310285a.65.1762376303803; 
 Wed, 05 Nov 2025 12:58:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExnFxIgG6aNnN2ewZwZHZItbO2/70U0HcXNTiJal+SisKWajLQKBxz44sD1N6AyB2SffeebQ==
X-Received: by 2002:a05:620a:1910:b0:8a9:b9cc:b90d with SMTP id
 af79cd13be357-8b220ad924emr539307385a.65.1762376303210; 
 Wed, 05 Nov 2025 12:58:23 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2357dbc51sm43707385a.29.2025.11.05.12.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 12:58:22 -0800 (PST)
Date: Wed, 5 Nov 2025 15:58:20 -0500
From: Peter Xu <peterx@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>, zhangckid@gmail.com,
 zhanghailiang@xfusion.com
Cc: farosas@suse.de, zhangckid@gmail.com, zhanghailiang@xfusion.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: Fix transition to COLO state from precopy
Message-ID: <aQu6bDAA7hnIPg-y@x1.local>
References: <20251104013606.1937764-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251104013606.1937764-1-lizhijian@fujitsu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Nov 04, 2025 at 09:36:06AM +0800, Li Zhijian wrote:
> Commit 4881411136 ("migration: Always set DEVICE state") set a new DEVICE
> state before completed during migration, which broke the original transition
> to COLO. The migration flow for precopy has changed to:
> active -> pre-switchover -> device -> completed.
> 
> This patch updates the transition state to ensure that the Pre-COLO
> state corresponds to DEVICE state correctly.
> 
> Fixes: 4881411136 ("migration: Always set DEVICE state")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  migration/migration.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index a63b46bbef..6ec7f3cec8 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3095,9 +3095,9 @@ static void migration_completion(MigrationState *s)
>          goto fail;
>      }
>  
> -    if (migrate_colo() && s->state == MIGRATION_STATUS_ACTIVE) {
> +    if (migrate_colo() && s->state == MIGRATION_STATUS_DEVICE) {
>          /* COLO does not support postcopy */
> -        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> +        migrate_set_state(&s->state, MIGRATION_STATUS_DEVICE,
>                            MIGRATION_STATUS_COLO);
>      } else {
>          migration_completion_end(s);

Thanks a lot for fixing it, Zhijian.  It means I broke COLO already for
10.0/10.1..

Hailiang/Chen, do you still know anyone who is using COLO, especially in
enterprise?  I don't expect any individual using it.. It definitely
complicates migration logics all over the places.  Fabiano and I discussed
a few times on removing legacy code and COLO was always in the list.

We used to discuss RDMA obsoletion too, that's when Huawei developers at
least tried to re-implement the whole RDMA using rsocket, that didn't land
only because of a perf regression.  Meanwhile, Zhijian also provided an
unit test, which we rely on recently to not break RDMA at the minimum.

If we do not have known users, I sincerely want to discuss with you on
obsoletion and removal of COLO from qemu codebase.  Do you see feasible?

Zhijian, do you have any input here?

Thanks,

-- 
Peter Xu


