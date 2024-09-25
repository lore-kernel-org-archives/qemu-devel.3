Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E84CCF9E7
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 19:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stXWT-0000SJ-Lj; Wed, 25 Sep 2024 15:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1stXWI-0000RY-RU
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 15:17:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1stXWH-0007Bq-DD
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 15:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727291867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qr4KuqU53p9E7o/jifHt5fIgdBcintWUz9Gvoz+b6Gg=;
 b=AvkBEoqehT5JwjntHrK5Wkjm2JdsPJoBAalvbN9/SgLuyL1Uz2id36YuFx4QFjWfF5LKNA
 fLSiPpyfLSJWhAu17kK0OSW2qwzaH8pAyGCylCjdM0/9Pd1CCUYGvUPBzjQ/y8eC3KrjiI
 TX62Mx2VTbnMXEWMIK9HbJOmTbbb9vA=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-Or_mOfrFMSWYTJHJK7tszg-1; Wed, 25 Sep 2024 15:17:43 -0400
X-MC-Unique: Or_mOfrFMSWYTJHJK7tszg-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-718ea25967eso228772b3a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 12:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727291862; x=1727896662;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qr4KuqU53p9E7o/jifHt5fIgdBcintWUz9Gvoz+b6Gg=;
 b=MrZltdhqFqycKGFggwNJ2jBBYD0YE+0FPe1ZIQxfxOAkxm4c+gftu+el/41MG6VXSG
 wsD4UVztrTtGTkIkJdRYgzYej7F6cAGbR9rXJAuQGp6UpWKXcJvbe1gYT5+q6DLcYL3c
 tp2C5IbV+y9Je3j9p+3WOTWscxhiKcAwUVqLGXQ/2I9HlhZrft/QZi0i4PCAfqQ+VVhs
 blFPTBWAxlF4t0qSrAk1jLtaEU2EBCC3T9kIAX0X6YxVI1pT9UBLEDKndn/kZGqHjO+Y
 909ypO4FL4Xt0EwbarOvkkATtVeIY7jbyT7HvVHQlxTEyfGc87RBYn/5Kc+nUZk0YiaU
 4ELQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpX3KRkoe7gXfzfwDIA6pg3o/zS8xzddAzo2OtZisLUV0bZ/JiU6c57ESd9JQ5fWInrCr1XyZhwqxG@nongnu.org
X-Gm-Message-State: AOJu0Yw55yZXy83UTrSyjrK8kLBLucXXBG1tb4ZSAN/o26Iwpbc7y2Z8
 D9d+tF42lOoaDI46+k0L0ohxs2UukPqe9SGFikogn1XHbnom3F3kDbAnQRHuCNrdCnZJagDmlpN
 0fXfbluxulC9aAMNWioPmMPYzGMIycw6nDgCnFIVC4y1Vz+sry+Xk
X-Received: by 2002:a05:6a21:399:b0:1d2:bcba:7c83 with SMTP id
 adf61e73a8af0-1d4e0c00760mr5069530637.44.1727291862085; 
 Wed, 25 Sep 2024 12:17:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7EzkK22QnIRsSLBf5LDL3mHgjwn1K5oxJRRv5Q226TMv3zQcytbTLQrFTjOWcZO8KaP/I3w==
X-Received: by 2002:a05:6a21:399:b0:1d2:bcba:7c83 with SMTP id
 adf61e73a8af0-1d4e0c00760mr5069511637.44.1727291861805; 
 Wed, 25 Sep 2024 12:17:41 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc834fdbsm3080217b3a.20.2024.09.25.12.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 12:17:40 -0700 (PDT)
Date: Wed, 25 Sep 2024 15:17:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 1/7] migration: Introduce structs for background sync
Message-ID: <ZvRh0RhkUC-eLbjo@x1n>
References: <cover.1726390098.git.yong.huang@smartx.com>
 <531750c8d7b6c09f877b5f335a60fab402c168be.1726390098.git.yong.huang@smartx.com>
 <87msk7z4l3.fsf@suse.de>
 <CAK9dgmb_rK5HJOGTG=KXKgH=e2e8JV8aqoOWUHBEyjnc-+kiqg@mail.gmail.com>
 <ZuxxOObKqS_G0Ela@x1n>
 <CAK9dgmYaE=poiwLQqD6qbjJQdgPLMn8cW8VO47xYFTBkNiUVLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK9dgmYaE=poiwLQqD6qbjJQdgPLMn8cW8VO47xYFTBkNiUVLA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 20, 2024 at 10:43:31AM +0800, Yong Huang wrote:
> Yes, invoke migration_bitmap_sync_precopy more frequently is also my
> first idea but it involves bitmap updating and interfere with the behavior
> of page sending, it also affects the migration information stats and
> interfere other migration logic such as migration_update_rates().

Could you elaborate?

For example, what happens if we start to sync in ram_save_iterate() for
some time intervals (e.g. 5 seconds)?

Btw, we shouldn't have this extra sync exist if auto converge is disabled
no matter which way we use, because it's pure overhead when auto converge
is not in use.

Thanks,

-- 
Peter Xu


