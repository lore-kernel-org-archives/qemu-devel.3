Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26661C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 16:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx8Ln-00080j-QY; Wed, 17 Apr 2024 12:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rx8Lm-00080b-Rx
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 12:41:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rx8Ll-0008QP-8l
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 12:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713372090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VHXnoyWoAbJt96nuSjdNj4rWeS2DeH0mare3tH4a/iI=;
 b=I3PiUHTpQjW8QdRuE1VhAg6XZC7uvlRWpZxz2ejeMfNFmxuvNvtV+yG9PolyhEiA5qEYFt
 bpY1ORt2a5CSpkyV+zB6ndGWmHR0aU/hv4Xdyju3YsoBeOhnyKpbYErRCTao8VzCt7dySB
 SmYXG0taEUGsTsNgpv0RmDCaqklnk7o=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-ns1De-FyNZysvofISVJNTA-1; Wed, 17 Apr 2024 12:41:26 -0400
X-MC-Unique: ns1De-FyNZysvofISVJNTA-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6ebae6e13dfso18676a34.0
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 09:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713372086; x=1713976886;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VHXnoyWoAbJt96nuSjdNj4rWeS2DeH0mare3tH4a/iI=;
 b=UfKkJb+SqJtSCVRspRNaAY7tqmPHKjtyByYNTDE4riR6SHyIg+Kub4b8Vd3qV3O2GV
 yraOKsfjF2Ig30YB5NhcJuea9XF+DqvwGsDlgvC48NzAhEykJrh2TMu+2pJuh5HDD8jL
 KFSTf2MuUed7zho3mwhcD8rlDdr+fZLBpDgi7U8nSlcF/j2rLvw2TWtEKyiSUdGbcpj2
 jNmF5+xjevkkvAjoIBUyYiuenf4mJS40vMEAuQ5BV5KB7Hn6oTkKvRsQ1VZQgrC7yGEl
 IAxWiT0/MSJSIaiWu3cAM1wqrnCPvAQISvmIDwDtdLLQbLZ5cMCwXqtUVICqmhkMg5cT
 xIgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUON46so9/l76MOBUTpVAR0fTkFVorjpsrDB9vHwR1/334f9hy29jimDmeSRgfDQmIa94x/VXMhxhzN73EJxfV6sP+36ZA=
X-Gm-Message-State: AOJu0Yw1KkgMOUd+G/ASPoYaAWAxeZjhid5uhT+QDka3xL3agQPV1XDs
 bwmAFyLrLhJ6tgY8PbSaJ8EgyfUT4cQEUnnyZo/aq1Ndh5Les/BEnweh8EPLWBSbpkDMqyv+Ll+
 qqlzh1LyysiQ2sJaOXxKRF76FWtCNHNCHmiuNDhuZnv1iEmH4Yvn5
X-Received: by 2002:a9d:798f:0:b0:6eb:7c89:6d99 with SMTP id
 h15-20020a9d798f000000b006eb7c896d99mr10203509otm.2.1713372085974; 
 Wed, 17 Apr 2024 09:41:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0tJi+SpezV41ShOMBOlfrSqkly/WPaJ+jQh4CbWVbWFK+zSJcb+jqD81jetp8FySS3c5/kg==
X-Received: by 2002:a9d:798f:0:b0:6eb:7c89:6d99 with SMTP id
 h15-20020a9d798f000000b006eb7c896d99mr10203495otm.2.1713372085560; 
 Wed, 17 Apr 2024 09:41:25 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 de39-20020a05620a372700b0078d55a24a3bsm8535074qkb.102.2024.04.17.09.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 09:41:25 -0700 (PDT)
Date: Wed, 17 Apr 2024 12:41:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: zhanghailiang@xfusion.com, farosas@suse.de, qemu-devel@nongnu.org,
 chen.zhang@intel.com, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] migration/colo: Fix bdrv_graph_rdlock_main_loop:
 Assertion `!qemu_in_coroutine()' failed.
Message-ID: <Zh_7s8dDmn-CjCNd@x1n>
References: <20240417025634.1014582-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240417025634.1014582-1-lizhijian@fujitsu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 17, 2024 at 10:56:34AM +0800, Li Zhijian via wrote:
> bdrv_activate_all() should not be called from the coroutine context, move
> it to the QEMU thread colo_process_incoming_thread() with the bql_lock
> protected.
> 
> The backtrace is as follows:
>  #4  0x0000561af7948362 in bdrv_graph_rdlock_main_loop () at ../block/graph-lock.c:260
>  #5  0x0000561af7907a68 in graph_lockable_auto_lock_mainloop (x=0x7fd29810be7b) at /patch/to/qemu/include/block/graph-lock.h:259
>  #6  0x0000561af79167d1 in bdrv_activate_all (errp=0x7fd29810bed0) at ../block.c:6906
>  #7  0x0000561af762b4af in colo_incoming_co () at ../migration/colo.c:935
>  #8  0x0000561af7607e57 in process_incoming_migration_co (opaque=0x0) at ../migration/migration.c:793
>  #9  0x0000561af7adbeeb in coroutine_trampoline (i0=-106876144, i1=22042) at ../util/coroutine-ucontext.c:175
>  #10 0x00007fd2a5cf21c0 in  () at /lib64/libc.so.6
> 
> CC: Fabiano Rosas <farosas@suse.de>
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/2277
> Fixes: 2b3912f135 ("block: Mark bdrv_first_blk() and bdrv_is_root_node() GRAPH_RDLOCK")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

queued (and cc stable), thanks.

-- 
Peter Xu


