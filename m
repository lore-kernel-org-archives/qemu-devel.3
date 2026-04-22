Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527D8F9EDC9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFXRZ-0003BF-UU; Wed, 22 Apr 2026 09:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wFXRY-0003Av-BB
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:16:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wFXRW-0005GL-RJ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776863797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=860R9eWIOYXneAY2sPdd0exnaOMOCGXpnx4bC411+sc=;
 b=W9s1AxkQjRexaiB0s9XP61oCGPQ8Jmqtrt4/BmNF3BZozTT7dwWTlCJsoIFXIMqXgoykQc
 RXpOqy4lWWlC0xSv7NZdIeJoE6gs+/rlkki4pe4FpqvYr1+/LbFP4H6jpc0n4D8lwqQ1l+
 iebrDbNkszBT89WlCx2z17bSiS8+6V4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-TmfVoUTSO7Kq71TNYHDAfw-1; Wed, 22 Apr 2026 09:16:35 -0400
X-MC-Unique: TmfVoUTSO7Kq71TNYHDAfw-1
X-Mimecast-MFC-AGG-ID: TmfVoUTSO7Kq71TNYHDAfw_1776863794
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b24a00d12cso55421165ad.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 06:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776863794; x=1777468594; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=860R9eWIOYXneAY2sPdd0exnaOMOCGXpnx4bC411+sc=;
 b=TuBuAEJBoFOFVr9rypMkI6zcLeiBrWPQ6zb4TFCdoHz6riCfr+XucWQ2SJDizwdeKM
 GdXtE6qvU9iaAkh6JjHuKqctuVzanYPYxDLrPeClGSP4SmXVuQCxiNsktPFgu55l9mNh
 uOWwuJ6zAXCsfbvzeOOsMIJm7tjNl2zqgYVw5JXzA+Q5LsjjH7DxTkpYXm23OATJcjg5
 oHHavrVepLYU8vb+v+J+XWw3CHWlHdA+JnqDmLB5zOJ3qR+EOscrs4hJDrUWi4G81zOQ
 XI6EMpQ5Tywzr+iDLvVcxKDKobHoOb6wMBW+FrgBFk7N8M2spVsQtdJqIauhzwdwS8ls
 Yfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776863794; x=1777468594;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=860R9eWIOYXneAY2sPdd0exnaOMOCGXpnx4bC411+sc=;
 b=BshY5so0CB8M2K6ULNXyKkp9d1mkG3fDyLJf9hABXOezJhOGjStXKj2lkrt20aTrIT
 PLz/lZyCQELCUuVZn0Io2zEqHFAx5oZEeqJDFRcjkSYGJVWf+tuX/q4ygK+FWmOi53+H
 Tp/BFKOlQ8iIviQXu3oU0bqxzFhanRv0oePUnhEXVzl10rGlaNecGonfVemSY7dX6C8j
 sFCoQDCZ6w+lKb2lQXSS5xdATgB/InCglQDpWkiGJ9UARwx9gqYa15SEKhCUtjFHlot4
 lOxqomQFKB18s29ZGMO6zoJFihHTSHY8Q32NAHGm1er01oUREwW9bjMRae2HSdB0Ja+w
 O/Qg==
X-Gm-Message-State: AOJu0YwUs3KJqwm8tgW0IPMQIOGICe9M+8sgbtMhnbL7XqBcv1Nlt5Bn
 JPaao1cqpK9jC9jC4wurfX0qi9hrpwxiUriqD9pP0M3K7ZFldiKeEDUcJROIzX2GliQWitUVZEe
 m4Fx+f5HnbL9lEwr/i2eVSWgbKT0NfwjrilKdegIJ/deSSXIau2Kf1Z90
X-Gm-Gg: AeBDiesXc96lmNldaM3VsWMOydEWjO8ycifIRiH/exx484ETOR6uaLYlynC3Ie/xEKv
 msUadt+sZ6F+owqx1qYPd4ipCPEE8ol9HfLFOhocf93It8OqSkmyZ+r0m0xO1KbjHOMBrL4JXdf
 b2CsoQyaon6T3MbYbcooCcbHFxjL5GfxRY6x2Z6RoCZoqHTo/yRK4M04lpAAccxq1hBd2phi5dy
 DnLoVhXMWoSJVJs5vpbZpCun2Mc9JWdZOzSDEb1M6M6T1Sl3AdKH65HbL9LlZmo5iR4YsX2OkKt
 +5zsSiK5QDPlJWQ0G5KSbHFfM4S7bjuKgZk656jsvDqL/xc8d3NNfXMQ4LWxHkIdWV6Vy+Oqgcb
 4u5fgRluRuLXKa7VJvs1FVkVO4+6wvmyTHg974FxrSLbn3B04/SIq3+qk
X-Received: by 2002:a17:902:8d98:b0:2b4:5fae:cbd8 with SMTP id
 d9443c01a7336-2b5f9f83117mr166360535ad.37.1776863793555; 
 Wed, 22 Apr 2026 06:16:33 -0700 (PDT)
X-Received: by 2002:a17:902:8d98:b0:2b4:5fae:cbd8 with SMTP id
 d9443c01a7336-2b5f9f83117mr166359005ad.37.1776863791434; 
 Wed, 22 Apr 2026 06:16:31 -0700 (PDT)
Received: from fedora (193-179-61-20.customers.tmcz.cz. [193.179.61.20])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab28e35sm165036365ad.64.2026.04.22.06.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 06:16:30 -0700 (PDT)
Date: Wed, 22 Apr 2026 15:16:16 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Joao Martins <joao.m.martins@oracle.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, Kirti Wankhede <kwankhede@nvidia.com>, 
 Zhiyi Guo <zhguo@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v2 07/16] migration: Introduce stopcopy_bytes in
 save_query_pending()
Message-ID: <aejKAjyhKJMew7f-@fedora>
References: <20260421202110.306051-1-peterx@redhat.com>
 <20260421202110.306051-8-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421202110.306051-8-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 2026-04-21 16:21, Peter Xu wrote:
> Allow modules to report data that can only be migrated after VM is stopped.
> 
> When this concept is introduced, we will need to account stopcopy size to
> be part of pending_size as before.
> 
> However, when there're data only can be migrated in stopcopy phase, it
> means the old "pending_size" may not always be able to reach low enough to
> kickoff an slow version of query sync.
> 
> It used to be almost guaranteed to happen as all prior iterative modules
> doesn't have stopcopy only data.  VFIO may change that fact by having some
> data that must be copied during stop phase.
> 
> So we need to make sure QEMU will kickoff a synchronized version of query
> pending when all precopy data is migrated.  This might be important to VFIO
> to keep making progress even if the downtime cannot yet be satisfied.
> 
> So far, this patch should introduce no functional change, as no module yet
> report stopcopy size.
> 
> This paves way for VFIO to properly report its pending data sizes, which
> will start to include stop-only data.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/register.h |  7 ++++
>  migration/migration.c        | 65 ++++++++++++++++++++++++++++++------
>  migration/savevm.c           | 10 ++++--
>  migration/trace-events       |  2 +-
>  4 files changed, 70 insertions(+), 14 deletions(-)

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


