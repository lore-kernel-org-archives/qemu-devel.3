Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5F1109C033
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Qvt-0007FZ-2I; Wed, 25 Mar 2026 12:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5Qvq-0007EQ-Uw
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:18:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5Qvo-0002VX-60
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774455486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uv4jitKEdDB1lTSeUCCPXMYKYQ4dmtfytmy7qvHYPcw=;
 b=Nrn6TamSfuAQT01VxWeorw1vf/hAPUQB4hWjriRQYlHUQ60ORKSDtrM6bUL3dIOku9CcUu
 2cQIU3hbze6X/DEh/9MocedG2898BYXZsEri6k0fIeMdr79CHMh+Z6TLMuIkpyGZ4d5y8N
 Uu7amtMr8QiXioJ56KLIGilVvq+P0TA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-G28FG5GGNCmkb8UAXVkMLQ-1; Wed, 25 Mar 2026 12:18:05 -0400
X-MC-Unique: G28FG5GGNCmkb8UAXVkMLQ-1
X-Mimecast-MFC-AGG-ID: G28FG5GGNCmkb8UAXVkMLQ_1774455484
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cb52a9c0eeso28233485a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774455484; x=1775060284; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Uv4jitKEdDB1lTSeUCCPXMYKYQ4dmtfytmy7qvHYPcw=;
 b=lMm8Lt1r2lrDuH3Yjuefb4alKsjSw5mhX9ybrW05/rFy3sVivPsxt9dis8X7FakZty
 qxAfqKbcWb1p4b0LU+IMxcBEu+1UpE1IVLJL929JmAsM6zRVtvhYgJ440SVSzRTNV/Ei
 h3siuy7J/R53dNujKMzq2XDWfY+HMRPXUNk8CLOnpgB0p0kk8oPkNxyG1QgfjhEfz7Xt
 eLHsanq3Cr/utKBIpreqSJ18g+WL2bE29Jv2Mu2YLsrS/CqPqYftlBnspQl5K2vMzIb4
 hGJFj56EqzTPTYDAAP1stAc63rwXsLz487Tghmb9ttHioGvgZPuKt8egnM2Q1fdNOoWx
 MFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774455484; x=1775060284;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uv4jitKEdDB1lTSeUCCPXMYKYQ4dmtfytmy7qvHYPcw=;
 b=pKZRuTyeIsLVlt/dB3pLXHE5nT7gz1eNIs7LUWpNrbuydEdbUUQFN7tOf/1S4P9Q/N
 l+shL1C7AC7awNNJinfB++FwIxfbcQkUEO359ki/NzuxvDluQpvpNhYX9h4jsBB/Otse
 D16o9tDjwQ6oVU1PN688clcQSl1c5VPBJBCd1enUo95Fu7WxKBKTgdc0f5KnKacy7HgA
 JoHqQpvn2zovWxlAqcA123EF+ZL1LlZWXr2JKqlSQ04OPe16yALn91FvN0xW3wlH/heW
 IinVHArKk0DotZ8gTY4GpgG0miVVy5rK5IHsqGtfhHsSBt8/whCKzYG91dj4xWxe7uEO
 MhaA==
X-Gm-Message-State: AOJu0YxPxkOLe9VbBfV/noWbdUUPtEHluKT3UGTG5PChVPNKAm98aBqS
 WkU5MoRy6Uj2e4ONiR+DIJHi5uEspBuafnF2ItJySNDPy2yLp4CMqregFs1UMQEph7QTPmxXDjG
 L8LZAxBlqv0I6NFY0saI2JXahDInK0TW4RT1b6Jeo1KyBxUqMjrJkAFgP
X-Gm-Gg: ATEYQzxiB1qQGuEwClHkMTu5yJTbo/tNEC2ZCo/pzswGx963xcFCyYFm9ObgpJaCU2w
 1c4s4SQQ9tHmJ9nBt663tEyhwfKf6nQ8Udzxf4aAL23h4LVNNFo180p/r9fkxf1eK5V6YPt0oUH
 0kbHU/ueMqYijyy6vubuZXUiW0NCV3otT2Z6j1eUF0LurPob+bRBBDrV+mFmh4czZW9ckHFErJA
 Rh+OFM9x8YZPrx8dkj2Su8OipC5KJm2GOXwOevyTNPAC4sQ2sWSJif2hSFk3o2YsBYHcwY7bSyL
 oUfcrfzSNAnTkvpZj6XS37ppsA92M7o4nKtdNPG5FncBnio+mTy02pVArfkcfDJnNRbcmhm7we+
 aCQ/B1Nzm2RX1PQ==
X-Received: by 2002:a05:620a:4481:b0:8cd:88c7:9f96 with SMTP id
 af79cd13be357-8d0010a02efmr601113685a.67.1774455484471; 
 Wed, 25 Mar 2026 09:18:04 -0700 (PDT)
X-Received: by 2002:a05:620a:4481:b0:8cd:88c7:9f96 with SMTP id
 af79cd13be357-8d0010a02efmr601107285a.67.1774455483876; 
 Wed, 25 Mar 2026 09:18:03 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e39f050sm21287985a.1.2026.03.25.09.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:18:03 -0700 (PDT)
Date: Wed, 25 Mar 2026 12:18:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [RFC PATCH v1 01/17] vmstate: fixup the use of AUTO_ALLOC flag
Message-ID: <acQKuhoriDk2uPaw@x1.local>
References: <20260324194333.30004-1-farosas@suse.de>
 <20260324194333.30004-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260324194333.30004-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Mar 24, 2026 at 04:43:16PM -0300, Fabiano Rosas wrote:
> Please add this fixup this somewhere
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/savevm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 34223de818..db0721996c 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -869,7 +869,7 @@ static void vmstate_check(const VMStateDescription *vmsd)
>      if (field) {
>          while (field->name) {
>              if (field->flags & VMS_ARRAY_OF_POINTER) {
> -                if (VMS_ARRAY_OF_POINTER_AUTO_ALLOC) {
> +                if (field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC) {

Oops.. I'll squash this one, thanks a lot.

>                      /*
>                       * Size must be provided because dest QEMU needs that
>                       * info to know what to allocate
> -- 
> 2.51.0
> 

-- 
Peter Xu


