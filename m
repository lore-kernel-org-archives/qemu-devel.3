Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1552CE7A84
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 18:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smH8k-0006Bl-2m; Thu, 05 Sep 2024 14:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1smH8Y-0006AX-68
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 14:23:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1smH85-0001tN-Lm
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 14:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725560477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aB3uG+jMipBUrase1G0A7DeUtNqHQ542hI4bDrUKD8I=;
 b=Fpq6oFjrW4Pgat3imdS4iw58svj10+m8L6XX7jbiVud82Gxfq1vV3gSoHa79pCvJkgzR1f
 p2QeqDaUBvpBkQlqM6DbkAugXEeaAGOwqip3lvz3jPvr5NOqwW1BsbFVxk8IbzjWyBFOuv
 fGhkQRZUClaWL8H+wKPAo1TYSBVzxL8=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-Ukif7hbhPI2B9ey-fDg-pQ-1; Thu, 05 Sep 2024 14:21:16 -0400
X-MC-Unique: Ukif7hbhPI2B9ey-fDg-pQ-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-82a72792dacso300752939f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 11:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725560476; x=1726165276;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aB3uG+jMipBUrase1G0A7DeUtNqHQ542hI4bDrUKD8I=;
 b=Y/5ALYKcvvsMPmINigZbf8wY0vWC2EnQePgme54oom/VG6oAcZfnO3dowpErmPTYV8
 iw4eB8oSpVidL0aLUqr2oBgSQW8E5CK/k7DkSG6fovDSiAwDajGzgSqJhtMFBV3KWeXv
 v/+qcGu/+7feD9VOWO3MdqupqBVGjEpoChLazXi3n+movbJaEJ6eOQQmY/eRxH13KLT6
 gmpN3exXWno866ssL05JxDRKRqOMBUTPE4UmBNaUlCFoY6AV9s4rtRsiWJ5lF5lokzBQ
 DIKBAaGeTzPtCBOblj7LsgGlVpigDtQMyF3b9IcWtXLjbtsDOqowyAjtp9XhOoYteV/W
 UiCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU6XlaTLG5k9NSqN4Kbe1nlBVtfkSjVjBUe7VJBhpZ1UiTz1CB3cYhB4nzh6Zi3iYRczFDdsAWheVS@nongnu.org
X-Gm-Message-State: AOJu0YxGeaXJsimKcGqr80e2tk3N3/fIto2l7H7iZDEWvPTCBVYXCPFN
 ETws4KrL3yaF7d9uLvzGbJucAqmEyEasoCtV7KeIBsK+uuQXCw4LNXMCJ/eeBQ3LVRd779SMImQ
 zOBV3w2P0FOG8vJQ8c/4ujMS8UfA4p+Yl9ktceyPrXg8wL1Vgkkb7
X-Received: by 2002:a05:6602:168a:b0:82a:1dac:eb81 with SMTP id
 ca18e2360f4ac-82a648a2f46mr1333971839f.7.1725560475871; 
 Thu, 05 Sep 2024 11:21:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOEFVdTjP9kGOV2PBsBv+DVQaJlzqzdUdjVUUPIAqctiHxZvkudZBEHFRv/xGVki4S+mhNmw==
X-Received: by 2002:a05:6602:168a:b0:82a:1dac:eb81 with SMTP id
 ca18e2360f4ac-82a648a2f46mr1333968939f.7.1725560475572; 
 Thu, 05 Sep 2024 11:21:15 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a498c30sm419336939f.38.2024.09.05.11.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 11:21:15 -0700 (PDT)
Date: Thu, 5 Sep 2024 14:21:13 -0400
From: Peter Xu <peterx@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 1/1] migration: improve migration_throttle tracepoint
Message-ID: <Ztn2mfWC8NoxuFY6@x1n>
References: <20240905165146.293586-1-den@openvz.org> <Ztnv9mouMVIbHnIx@x1n>
 <fae6629b-523f-46be-8b45-d3fa9174ed4d@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fae6629b-523f-46be-8b45-d3fa9174ed4d@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Sep 05, 2024 at 08:00:54PM +0200, Denis V. Lunev wrote:
> On 9/5/24 19:52, Peter Xu wrote:
> > On Thu, Sep 05, 2024 at 06:51:46PM +0200, Denis V. Lunev via wrote:
> > > Right now this tracepoint is just saying that the guest has been
> > > throttled, but this is not that good for debugging purposes. We should
> > > also know how much the guest is throttled in order to understand
> > > consequences for the guest behaviour.
> > > 
> > > The patch moves the tracepoint from migration_trigger_throttle() to
> > > mig_throttle_guest_down() where this information is really available.
> > > This is not a problem as mig_throttle_guest_down() is called in the
> > > only one place.
> > > 
> > > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > > CC: Peter Xu <peterx@redhat.com>
> > > CC: Fabiano Rosas <farosas@suse.de>
> > Makes sense to me, but maybe we can further move it to cpu_throttle_set()?
> > 
> in that case we should rename the tracepoint as in that case the
> module would be different :)
> 
>    4     90  system/cpu-throttle.c <<cpu_throttle_set>>
>              void cpu_throttle_set(int new_throttle_pct)
> 
> Will it be OK for you?

Yes. Thanks.

-- 
Peter Xu


