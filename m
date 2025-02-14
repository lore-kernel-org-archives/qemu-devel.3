Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250F7C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 15:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tixNX-0007oS-JK; Fri, 14 Feb 2025 10:13:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tixNW-0007nt-0S
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:13:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tixNS-0005md-Ob
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739545992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aR8/hBAZ4OV184SBag+/sdgtJ+8zVwvJXLsrG2oibRk=;
 b=d9msayUk397JRtNQowwPLb8Ra/JRvc5EcmbxcBqVSCn1S5x982lThvT1J6bngjKhML4ty0
 op5GMMut6lAz38ecaH0Bj5gauy+T+JVIG4wPzdEhAqCswufC6OF+bLKLHwEmU0CuMYDbVv
 CW6R71KwRfJtuphKFnMNCK1C8sIxuzA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-169sKoI0Ng-Ag_fCwsA_CQ-1; Fri, 14 Feb 2025 10:13:11 -0500
X-MC-Unique: 169sKoI0Ng-Ag_fCwsA_CQ-1
X-Mimecast-MFC-AGG-ID: 169sKoI0Ng-Ag_fCwsA_CQ_1739545990
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-471b46a2657so24618771cf.3
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 07:13:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739545990; x=1740150790;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aR8/hBAZ4OV184SBag+/sdgtJ+8zVwvJXLsrG2oibRk=;
 b=cPn1AdZ0W3F0Fb9Vd5Agbbu8w5nvpc86SyVy0wnkdws+CcgVTxQXeFYfaP144M6sUj
 wmRENYJBUnnWJDgfHPmckaKTfk7vixq4qzrRHACpNN2Oo8DZ5gR/ndoT1eyF02Btz0me
 yb1Yu8nxZ9ojOFTycZg2PslaPeuF1lgsVmwgvQ7dDZc5a/ZLREl2iiRsDv5/ty50vr/A
 ZOIGZiHf2C3WdiO+ZGRPoa/8me6Ud5/e7hponqEn6A7UuVLzJ6YjrGiRSBfUeNOTlm/U
 ZhzipaihNczqbQxbUNq+7CHl+vt+0s5GMjVt7At2R/R0Zu1Ygg79X/N0hudTjxmMJnMV
 3Kjw==
X-Gm-Message-State: AOJu0YwpAsBtmIU51Xmqm1kqgzo1NZw9LTwkqzc/SAcB53ZyNFS4b6/V
 SycpGkesoVM+WXxFvbOxisdC5Zw8cUJKcY3/fT91nsC5Rv0QQ9iouMN2XKoMSd1D0i80uHo8X7t
 wEyaEBxDjOEB/kVHo/5Nx3EJCtQts61qVSeiszPy3MRMQFjN6PTy3
X-Gm-Gg: ASbGncvEEoEU1/i7SMCLYySU8V/OWkMm1ILGr66nCBgsAXuJ4mHtktKLUQwKGg62e4G
 OsMnUNFcVB95XDtyE31zVu2xJf1m+BQcbU+lM1WtgoBvLLdvSpCGazeoatDoYLY/cm7X7za1IAQ
 uG1u7qO9PWSZXVMqKMHf35+by9LgQP+RoE8RfYH0dmEHmUaiIe2IEQ/duLXe34Leb6WRcZpB2GE
 Ti086hhf6cVv2hQ/3fLbkbdYnRaBH3htt5HXr5nX+SYu422L8Hkq5R5264=
X-Received: by 2002:ac8:7d85:0:b0:471:8d66:cd68 with SMTP id
 d75a77b69052e-471afe00a92mr162105491cf.3.1739545990646; 
 Fri, 14 Feb 2025 07:13:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxIuXMyzZJZ6TFSv93LoslICqAO/rOV31ysBj8PNfwGU19yedE1r21SuMfHTvmAlZHPJ+X8A==
X-Received: by 2002:ac8:7d85:0:b0:471:8d66:cd68 with SMTP id
 d75a77b69052e-471afe00a92mr162105161cf.3.1739545990302; 
 Fri, 14 Feb 2025 07:13:10 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-471c290a0d0sm18884201cf.0.2025.02.14.07.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 07:13:09 -0800 (PST)
Date: Fri, 14 Feb 2025 10:13:06 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v3 6/9] migration: Don't set FAILED state when cancelling
Message-ID: <Z69dglBo1WkMBqwc@x1.local>
References: <20250213175927.19642-1-farosas@suse.de>
 <20250213175927.19642-7-farosas@suse.de>
 <Z65eTACUqiKQaaz1@x1.local> <87jz9svhlj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jz9svhlj.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Feb 14, 2025 at 09:25:12AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Feb 13, 2025 at 02:59:24PM -0300, Fabiano Rosas wrote:
> >> The expected outcome from qmp_migrate_cancel() is that the source
> >> migration goes to the terminal state
> >> MIGRATION_STATUS_CANCELLED. Anything different from this is a bug when
> >> cancelling.
> >> 
> >> Make sure there is never a state transition from an unspecified state
> >> into FAILED. Code that sets FAILED, should always either make sure
> >> that the old state is not CANCELLING or specify the old state.
> >> 
> >> Note that the destination is allowed to go into FAILED, so there's no
> >> issue there.
> >> 
> >> (I don't think this is relevant as a backport because cancelling does
> >> work, it just doesn't show the right state at the end)
> >> 
> >> Fixes: 3dde8fdbad ("migration: Merge precopy/postcopy on switchover start")
> >> Fixes: d0edb8a173 ("migration: Create the postcopy preempt channel asynchronously")
> >> Fixes: 8518278a6a ("migration: implementation of background snapshot thread")
> >> Fixes: bf78a046b9 ("migration: refactor migrate_fd_connect failures")
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >
> > Not like migrate_set_state_failure(MigrationState *s)?  Not a huge deal,
> > though..
> 
> I thought we had agreed over IRC that it was best to hold that until the
> other MigrationStatus work happens?

If we touched this anyway, IMHO no hurt to add a helper too.

migrate_set_state_failure() can then be renamed to migrate_set_failure(),
take a Error* instead so it might help that effort too.

> 
> Anyway, looking closer at this, there are places that handle CANCELLING
> beforehand (_detect_error) and places that only set FAILED after
> specific states (multifd), so a single helper will require more
> churn. Let's postpone that please.

Sure.  Let's go ahead with this.

> 
> >
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> 

-- 
Peter Xu


