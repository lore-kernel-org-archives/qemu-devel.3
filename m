Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1494C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 16:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukPXh-0003OO-5y; Fri, 08 Aug 2025 12:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ukPW7-0000ed-V5
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:00:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ukPW5-0005w1-O4
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754668823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t4d2vNvuny4A0g0c38QyAitFG/+yWVgkQb4NvRj80Sk=;
 b=eCtlUejtGdhGnMIwUhwhPd5UD5hkGIL9oBr4bXff5mwrgfvwVn+bane5PgGrOiGR9xxWGB
 VXWB+eRyE36KEPjg+9k7XGEmqGhzZqomxR6gmFJPWxJ5iV3CQmjV7CPhYTEvwmzKsGNT5T
 06yJ+/NYjyRaZ+LUd5trQhoZv6rC/9E=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-8geJmPlmPyijraYWrjTdlw-1; Fri, 08 Aug 2025 12:00:22 -0400
X-MC-Unique: 8geJmPlmPyijraYWrjTdlw-1
X-Mimecast-MFC-AGG-ID: 8geJmPlmPyijraYWrjTdlw_1754668821
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-71b58de76caso31635917b3.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 09:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754668821; x=1755273621;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t4d2vNvuny4A0g0c38QyAitFG/+yWVgkQb4NvRj80Sk=;
 b=th3X/ElhZuN1+s/WGgqiR/SGg1W5fNmgDpJGpnKUQ7IeA7DmzMobsU1kZx8rCozNdf
 wo/nncjH1dcJMWwi59naQzjSnHLN2w2azkLw6bFTo1bkprLz6EiV8/rJf7iODxIZNZQ+
 yeBSgTqajBBbmc6tK96FvqyJQpipWW1SkD2yc4X+cmr6azIwpUTb+iWaS3S/A4fUlurp
 T4tdPvmY23ElN1+Y+jklbplgE9hN6Fo7/buR1ODGjJYCUER+CDEYh0pg0trHAvZ1mUtA
 cngstKjyEJIaTnRMeYi80Imvb8CqxcT1S0bB9nWxRLgCCnMvKtWgZDEGxkauiH3an1bi
 XWCQ==
X-Gm-Message-State: AOJu0YyHRKrLGeg7Z6fRLQww/LfnhffVXn4oq0A3Hb7IEkVIneKj8mKE
 /j0y/GYCxpclVHH3t2BOwHPE/f5u1g3YgGrTI/kc61k9osYzZRumHm1bmq4WBlsiJiKdL116fFF
 uC9+3H9it4W80TAR/pymZ/gerJwZCw982H93Kc6PcXk8H5LWOcEAnkBbH
X-Gm-Gg: ASbGncts7/lBnWB0ghAIyKCr4SbHTDY0hGByt8U5aBxqkeOo9xkOYtwDx4CUUQGlppf
 jV+/G6HU9Hnaiy35rMGaDQcI9/93pfdjeiLiJsL0n7Dc8FIl/+m1SZZFoPzWEfF/Kj/h8KUhGSc
 8xzTDgxMdLq+jO/zojBEvniqTNvk4PgVVOewP37DGrqbnc8gqilTel5refecCkZF2te2lQh8hN9
 bMBCyTFR28IwbtJkCNXP78ZF4R2eG07aRIk2UtlzcAo7W68V3YbCM/i7yqxP8yPtU6pDeJdHXnr
 lpiQ1Tf5uRXrRuso3nKqsaQDZADZld+m
X-Received: by 2002:a05:690c:6710:b0:71a:400c:a454 with SMTP id
 00721157ae682-71bf0ef44a0mr44235057b3.41.1754668821350; 
 Fri, 08 Aug 2025 09:00:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR1VVPtov1suzMo8+4Vn2ZlEga2R/ps28K81ZmbWzlYmJNdKwDXimnTj7W85aC/4b4Vkp2+Q==
X-Received: by 2002:a05:690c:6710:b0:71a:400c:a454 with SMTP id
 00721157ae682-71bf0ef44a0mr44234417b3.41.1754668820822; 
 Fri, 08 Aug 2025 09:00:20 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71bf9bd4710sm2788767b3.79.2025.08.08.09.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 09:00:20 -0700 (PDT)
Date: Fri, 8 Aug 2025 12:00:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [RFC PATCH 2/4] migration: Fix state transition in
 postcopy_start() error handling
Message-ID: <aJYfB3mVzALiCu3P@x1.local>
References: <20250807114922.1013286-1-jmarcin@redhat.com>
 <20250807114922.1013286-3-jmarcin@redhat.com>
 <aJUSeOIKfQ47uliY@x1.local>
 <ftnfp4glpvoe3hwycvzqc2q3soyrmblshllfxgnjt7dlmpryvp@sqjom56wab5j>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ftnfp4glpvoe3hwycvzqc2q3soyrmblshllfxgnjt7dlmpryvp@sqjom56wab5j>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 08, 2025 at 11:44:36AM +0200, Juraj Marcin wrote:
> Such function could be useful. I could also send it with the above fix
> together as a separate patchset, and send it also to stable.

Yep that works.  The 2nd patch as a cleanup doesn't need to copy stable.

Thanks,

-- 
Peter Xu


