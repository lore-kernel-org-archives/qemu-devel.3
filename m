Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EF2E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNazh-0003UI-KG; Tue, 17 Dec 2024 12:04:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNaze-0003OJ-LW
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:04:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNazX-0000ta-PF
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:04:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734455052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tQDvVBt2IMPoLvNk/glKL6naDwGiberdwSxNAmeFte4=;
 b=Gia4cYdtknECqHt6/75Who4PrMirKL1+CwhseZ2eTBsaq4tTbLsh9EerkDp9cWAQ64B5OC
 X3umAoTt863djypwXPqW7yC0fsCmLNLYaDuKgYHwqhCAkBnHndHUGepq6xrqxoMwRttEs3
 MdMmtHtldG0RQC/sR672SNvmU2n9sv8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-b0IoZTrLPXy2It4VA2-Tzw-1; Tue, 17 Dec 2024 12:04:10 -0500
X-MC-Unique: b0IoZTrLPXy2It4VA2-Tzw-1
X-Mimecast-MFC-AGG-ID: b0IoZTrLPXy2It4VA2-Tzw
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d88c987fc7so96930796d6.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 09:04:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734455050; x=1735059850;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQDvVBt2IMPoLvNk/glKL6naDwGiberdwSxNAmeFte4=;
 b=TiPBrWKPrrN36vhI3ULBoWr1vHwan5v0yvx0yhc0usYrZwmzUEHe6Dtg2YiHbSxAae
 hmSUNIIKBof7Ayf6Rdzq1rVsPt9gFNiaBdpPsHNWxnTCXgHX2QG9zlWWRie9N9EWt5R9
 a5hudUQMBOe0FKEhUQre8ZEcj0h4xcZ6DKuhIYuXUD0ygCl+rkK8JNhcs2bIZsA68Tyb
 qqj3/M6D4QSaBbvZibS9zhHHa7Hbn/NRcH6Gye08ojs9539CKLZpXYd106z+U4vcbeTT
 2fVnzpOtPUA8BZrDqUb0dHhndqIolmv9I7fGm1KmhOqklpQmViY3eKyPmpgqCPqkSSV4
 DSDA==
X-Gm-Message-State: AOJu0YzvNDaiq4+Emga1LJb7SWe6PDs7eI4FxY7QIW4sjvyRshUYxNXf
 qmnTZ91NGJ6rsfGC4aUcItpysd59Zdp374uujDsGen8spsmZM0X1qiSz49MYxk2kSbSB/+YUXkQ
 1gzFoOaUuhy3AM4hrl2dvQ21VadS+sRSMfDxbriHTM3TA3FYnSciZ
X-Gm-Gg: ASbGncsgI1btujKdYu1AxGWRSx3iibQxJN8u+pTCxsDnV+Mxsr4+oHfoDHsWoEqgFJz
 H3mPIYvxwz3ZyA9sV4mgy6nhHGNIWPb8CDZytNO0u0YQRJEiQjiQpL5/KoIljPyxtNWfU7tZW53
 p2pQxVxSpZb6igOb7g0FMzp/5nfFVdzYtS71au9U5WK+GkMxsnNxjfT803iv8+JYFhHBPqYGahe
 ErS9CA0KwTHRN3o/frTFUzzqhOWIJsv0djSyilwALTngoOXE3yTPWo7rowoU7qfbBQ474uTVV8I
 edYfhKHe+dvvzz4+ZA==
X-Received: by 2002:a05:6214:e8e:b0:6d8:871d:49f1 with SMTP id
 6a1803df08f44-6dc9686f932mr304223706d6.44.1734455049824; 
 Tue, 17 Dec 2024 09:04:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhvYc2LcystLttUiLmRYBCbNH0AZUoMLKE4LHGxn2uEtYTrCKg6YtL9Scg5BPbQGQPWhlniw==
X-Received: by 2002:a05:6214:e8e:b0:6d8:871d:49f1 with SMTP id
 6a1803df08f44-6dc9686f932mr304223096d6.44.1734455049451; 
 Tue, 17 Dec 2024 09:04:09 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd26e469sm40341266d6.59.2024.12.17.09.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:04:08 -0800 (PST)
Date: Tue, 17 Dec 2024 12:04:06 -0500
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hyman Huang <yong.huang@smartx.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH 8/9] migration: Drop migration_is_device()
Message-ID: <Z2GvBnucMGFXv9tb@x1n>
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <20241216094638.26406-9-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241216094638.26406-9-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Dec 16, 2024 at 11:46:37AM +0200, Avihai Horon wrote:
> After being removed from VFIO, migration_is_device() no longer has any
> users. Drop it.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Thanks for working on this, Avihai!

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


