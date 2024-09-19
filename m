Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0348BCF3963
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 17:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srLD1-0004aR-TS; Thu, 19 Sep 2024 13:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srLCv-0004Yj-5s
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 13:44:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srLCs-0000or-8Y
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 13:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726767879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eALNlN7F+UfR00b/ZAMr5648yq0kKRioLFmvjHC0aGk=;
 b=fmO+GDjNR4qWU2qoH6CADX7fNp1lBj8aAJhk0w5XutrTphCniU0OZPDCbMMhr4FixVwjpK
 aVH5f57pfP+nHFySdDaeNUSTMQOU5aiaE2kECUUpjOmAVBCCIIYp94CYMbgQxjFjMnnl5r
 PSVkn4GrJ18XfKu9bGpx4oyjDbhmvBw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-0Usso1WhPIqTLUgd_go1fw-1; Thu, 19 Sep 2024 13:44:38 -0400
X-MC-Unique: 0Usso1WhPIqTLUgd_go1fw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6c35b3a220aso46150046d6.0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 10:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726767878; x=1727372678;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eALNlN7F+UfR00b/ZAMr5648yq0kKRioLFmvjHC0aGk=;
 b=bLRQKdDKtd32vGvgaNbPvhx0IIsBdt/6ZGy6k0sKA8n2zplJuZ7wh9ZoGBayQy9KEc
 N5Iudb0d/Ai72Vzhvfdn2x2xTFF5HoHCO8JFlN4Aib7XtcAFwh2ElOj1Mr7aBV3CkNjg
 99VhaqIPvtv16/WjWMZKA4EoctZ3i2B+z076Vg6qkcKFPHssIh4BnWbpmhBeArK3jzsU
 r311tzfq1fQLCNAYSH44WBFllotBoUjbqPXE5/PlK0QckvV5y48Jmx1Lyk4i8utVgF88
 WY2YbdMdMPoG95XMkI9SRZJdb/ytvQm0NBxk4d2TiEXTs0qkPK5dEmZPDKK3PHa29l/T
 x7mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmCridUQ+jwIPv2Ivf4gL0rVvwlZoW1PzLOt2lTs6d230f+40FamM3vtlP0bzNhXrPwqzLdD66++p+@nongnu.org
X-Gm-Message-State: AOJu0YzwCUoRO33K5vkdxtxN3DQmgIlBIr7pap6HdnfsqT0CbSmBHWt0
 L6nvlHi3iSSBtKhH79DMDh71lOQDMuv42+mTQnQj0H91QVzLUeYA16V1bVNV4D5+UOzxZuRDHdE
 L4bn+HXeYpIjbnP2eN4r19NeBOnS1m8vn7Nt1Up/UUo+OEC7MsCv3
X-Received: by 2002:a05:6214:4802:b0:6c5:5095:3f02 with SMTP id
 6a1803df08f44-6c7bb99bc36mr8713556d6.1.1726767878150; 
 Thu, 19 Sep 2024 10:44:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9b1b2rrpuYeOJaoWFxUtcdWk6KARMcUp4JzFu0ic5tWjy+hiIjeo4VA/D7DK2hcfX6TzTWA==
X-Received: by 2002:a05:6214:4802:b0:6c5:5095:3f02 with SMTP id
 6a1803df08f44-6c7bb99bc36mr8713186d6.1.1726767877739; 
 Thu, 19 Sep 2024 10:44:37 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e494ae3sm9594566d6.70.2024.09.19.10.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 10:44:36 -0700 (PDT)
Date: Thu, 19 Sep 2024 13:44:33 -0400
From: Peter Xu <peterx@redhat.com>
To: dave@treblig.org
Cc: farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 6/7] migration/postcopy: Use uffd helpers
Message-ID: <ZuxjAQJV4mjD2ENH@x1n>
References: <20240919134626.166183-1-dave@treblig.org>
 <20240919134626.166183-7-dave@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240919134626.166183-7-dave@treblig.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Sep 19, 2024 at 02:46:25PM +0100, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> Use the uffd_copy_page, uffd_zero_page and uffd_wakeup helpers
> rather than calling ioctl ourselves.
> 
> They return -errno on error, and print an error_report themselves.
> I think this actually makes postcopy_place_page actually more
> consistent in it's callers.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


