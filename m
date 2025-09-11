Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B79ACAC593
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 13:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwh7P-0001lp-1X; Thu, 11 Sep 2025 09:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwh7K-0001l9-Bq
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 09:13:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwh7D-0007YV-7k
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 09:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757596405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YN3OFDkOUp1GA6cUxj1GuOwxUSwN3QnGIgwQPVwANks=;
 b=YVfuzsz8SwzULA8BwBlZw8E19Fx+VixHsDAetrYGLUN5ZqgCDvlDLagDv14ygUxsIWzvY6
 de/0PwRrP9yoNHQ902dZtbcVLbhpQpyFOrvZU9XS6zdFgf1b7XWlXh+/n9KMoFwXv3JdXw
 f/Uy1kFqXEBo4yuGPTgVsrOOeGdFt2w=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-GRCTDswPOiWvmK0sJt3pDg-1; Thu, 11 Sep 2025 09:13:23 -0400
X-MC-Unique: GRCTDswPOiWvmK0sJt3pDg-1
X-Mimecast-MFC-AGG-ID: GRCTDswPOiWvmK0sJt3pDg_1757596403
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-7211f13bc24so13677516d6.1
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 06:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757596403; x=1758201203;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YN3OFDkOUp1GA6cUxj1GuOwxUSwN3QnGIgwQPVwANks=;
 b=uAWTwn7cT68rsieNbfsRnBONPlbKYf5qUEmNLUUwRLRNYqBNxnavntrrxQ01aInYw+
 EyhRyOq4HdWw6K2cVLjGcA09vzM1kSWt9sQMKW7B0tfJ9RrCizxDHIV4GmOA2kdKZ5EY
 ABIeAvbjCcJq7GI/F5micJRUGlGJWx3MDl51Oa/4vGIe1g5MIwQdnzNxXsLL5SiIjSQ9
 9YWz63qOZ12En0xvij1uOd1hsCnNDDXuqywM+o1m/GDmm5d1mDDZ6Lq9+R78j1Gz7Y0w
 xSEmsDTI53mGLxkhLRWSrHEdoXW6Km1JBNtDDTi4gV9c9f6E0x8H/iQPCzyikae/2J/f
 Eu1A==
X-Gm-Message-State: AOJu0Yyl+wn+zCmIAjIHDgo2SVUby2wqyp7fW/VXFJHK37FicAVKPx0L
 byj/MTT4BeWuiOxY/1X9e1EXKqcAHP7c9SH0P8d4dAu0znmUO2gyIV9AuJ9zS6hHJjbQAQ9Pshg
 JTgAN2mXzJ3UpKp1luZ4tYHHPgBB8Zqv78S+8DY6Qdoog3i5qaT04+BkEdZBFtqBJqlrE1aFvIq
 4gp1+QbjWoDaboXNgNyH0Oasz7iOfvEGjfYRcYGA==
X-Gm-Gg: ASbGncudRC/qduHGKmqLUvcCrs9BHJ3xyo6eHF4G9Wla1kF0KfU83WJL/cG3QPyetX4
 JWWi8tb38vw1o8Qa4IQ2d+WqEWpFgMeCmb28//4XBe1VNFl/Z8TAPQGi/UhneAc5WC9zGHM2JnJ
 0L8xMAOy4xkxIoFeccyD0sz5su++ECbQOL1zTaJxeae5kwTmpjoSx+cpfnj8qonz9xG9j7VPL/A
 smLkMhP5FENU3EzhMUu5EiBP8Itm6VKPxf2m5Rr+8YGsYcyeAsN4RpKKHEe3T+JDt478jaJB1CM
 C34+5Ks8xUZ1C4YWYWtjLGQfBUkBBDrS
X-Received: by 2002:ad4:5caa:0:b0:737:a36d:77e9 with SMTP id
 6a1803df08f44-73924e23439mr218914606d6.17.1757596402939; 
 Thu, 11 Sep 2025 06:13:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEI7ACU4aW0EQytRDFRPjMkMvKDU4xmV6FSUQFUkGCnEZuDfV9H2or1opQTCnQXaZbSAIx/g==
X-Received: by 2002:ad4:5caa:0:b0:737:a36d:77e9 with SMTP id
 6a1803df08f44-73924e23439mr218913896d6.17.1757596402321; 
 Thu, 11 Sep 2025 06:13:22 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-763b680037bsm10700946d6.29.2025.09.11.06.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 06:13:21 -0700 (PDT)
Date: Thu, 11 Sep 2025 09:13:10 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 0/3] migration/tls: Graceful shutdowns for main and
 postcopy channels
Message-ID: <aMLK5nT4CVPrcZCB@x1.local>
References: <20250910160144.1762894-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250910160144.1762894-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Sep 10, 2025 at 12:01:41PM -0400, Peter Xu wrote:
> Fabiano fixed graceful shutdowns for multifd channels previously:
> 
> https://lore.kernel.org/qemu-devel/20250206175824.22664-1-farosas@suse.de/
> 
> However we likely forgot the rest channels.  Do it the same for the main
> and postcopy channels.  This fixes a warning message when running unit test
> /ARCH/migration/postcopy/preempt/tls/psk.
> 
> Thanks,
> 
> Peter Xu (3):
>   migration/tls: Gracefully shutdown main and preempt channels
>   migration: Make migration_has_failed() work even for CANCELLING
>   migration/multifd: Use the new graceful termination helper

Please hold off the review on this one.  Juraj reported the issue wasn't
resolved by the changes, and I can also reproduce.  I'll have a look and
repost..

-- 
Peter Xu


