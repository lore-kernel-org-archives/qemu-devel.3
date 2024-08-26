Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BE4C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 16:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sicMn-0001oF-FL; Mon, 26 Aug 2024 12:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sicMl-0001nm-PK
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:14:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sicMj-0000yl-Un
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724688888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZpRLCKM3Btjdkv+aOdUFm74OdlhvLcl+QvzTmUo4ZgY=;
 b=HP3WSj0BucwPIKnR0tv7ScCyCpR0ec7MNV866Sm5hc8+C9JHTmCr38Z6EdJirW3gzIx3gb
 GdLHjt/YdFJxEPulxk7ZekmBaAmOOvuBtLRXxpABixbtQ6TKdU2RxeNpcukRTux/aJKt6l
 48sb90LXUqmgV9U5tyAcvl46RBKsa74=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-FbHfDJIFMxy2vewh5_JbhA-1; Mon, 26 Aug 2024 12:14:46 -0400
X-MC-Unique: FbHfDJIFMxy2vewh5_JbhA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7a1de7141f1so583205985a.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 09:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724688886; x=1725293686;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZpRLCKM3Btjdkv+aOdUFm74OdlhvLcl+QvzTmUo4ZgY=;
 b=oXQec8N9FoR6q2dHLnubX81wk9wKHOBzTB9OMV1pAGhclNKhQkn/FKkL7hIC9WWdgT
 TZNeNx5iLU9PY7hnLccACXtWEmcXqBeGN7uukjbsYayYqdA43dOYYNXYzDxME6ueTFLH
 BTuF5csWQNTH/qZNqrfIwxnBzANPoqHJ6d9bF44eU371oXMmOZgbbmVkhHGfXwldolKY
 tCN/Z0czZ5pk1l04hPh6M4uCTaVZmRrBhFiMofrTifqyNN8E3ydqp18Feazet5CS3Bia
 H4Zw3s+v/YcL84L6s1V6p4LSrMRUZA5p29PA2+zydimP8u+4/hg74oGlwtaYM4tHyoqx
 Da4g==
X-Gm-Message-State: AOJu0Yyx/hchFWbvX/JnRypb+SSvP/PZm7QeFNAYQykDuP/sKaqnA13L
 AeKUr2pIVnhK5armXIxiQf6IU5tapoLKlIItQANMaYjXmeakKhm2xsX6EHHxxRcvqAAOozPss72
 /dF73mXCvMGBqQNjWXIbM2wbWVaRHSmpjGVHqIg7YJUOen/VbGG7g
X-Received: by 2002:a05:620a:2988:b0:7a3:5004:43dc with SMTP id
 af79cd13be357-7a68971ed3amr1290975985a.40.1724688886279; 
 Mon, 26 Aug 2024 09:14:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJo1qfSNPgWYfWIfsg7VP0sl/3lkp/+55Y9ezQ5Jp2yclu8Zja6efssD+iMVkWxyAWbz4Y2w==
X-Received: by 2002:a05:620a:2988:b0:7a3:5004:43dc with SMTP id
 af79cd13be357-7a68971ed3amr1290973385a.40.1724688885879; 
 Mon, 26 Aug 2024 09:14:45 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f3645efsm469895785a.69.2024.08.26.09.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 09:14:45 -0700 (PDT)
Date: Mon, 26 Aug 2024 12:14:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v4 14/16] migration/multifd: Standardize on multifd ops
 names
Message-ID: <Zsyp8_pvhlLoWeqS@x1n>
References: <20240823173911.6712-1-farosas@suse.de>
 <20240823173911.6712-15-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240823173911.6712-15-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Aug 23, 2024 at 02:39:09PM -0300, Fabiano Rosas wrote:
> Add the multifd_ prefix to all functions and remove the useless
> docstrings.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Some of the comment might still be helpful, but yeah the dups aren't that
helpful at least.  Maybe a generic doc update on top of this one to
MultiFDMethods for each method would be nice, but that can be for later..

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


