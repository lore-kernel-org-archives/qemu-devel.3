Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7313C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 18:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZahW-0000qE-6M; Thu, 01 Aug 2024 14:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sZahU-0000op-MZ
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 14:38:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sZahS-0000Z1-PU
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 14:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722537533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HtpRxL9zFKQPOMFpdkGTEixDlUXM8Rr9CS7r7HFkInM=;
 b=bFNuj2jR6MPJ4wXsiz+l8fIvLnL25TrGr4TNxVNSb8qepMVwXFQQ6d3tBGXVm0YvLoYrbf
 jbudKMLmbh0PInF91bCDtFJGP6dUFtBJgTUHCTigtE5wL8Iv6z2xVLx+YwsliwbuWObb1A
 d09G00YdUsPEFqtkHpkczjfGPzSKh/M=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-ak23VwbfMUWWdbAPQguWCQ-1; Thu, 01 Aug 2024 14:38:52 -0400
X-MC-Unique: ak23VwbfMUWWdbAPQguWCQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a1d09e4b53so3473885a.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 11:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722537531; x=1723142331;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HtpRxL9zFKQPOMFpdkGTEixDlUXM8Rr9CS7r7HFkInM=;
 b=TCGVGrdgtSbOiPhft6IbkFKPkO8rGK07TOnozBnQGptm06AI69n7LmXVkKuWE542cE
 w2NYlyQIcSx+SuG+IW//szEIQNrZmJ7hfLPx2M8tYRBD14StD3SbvouhTmUPxz3aAYyN
 Vwzep1Ge8DFbwv9zeo6hZ9wZlMiw6TD99e5I4nIJO/NQg7gNMW8e2pGPY09CSDQIdSDi
 PQw0kpfgibEMXCEAdFdk9naI5MW+uXZr7TjrAag5E2GxWJUNa55I49SSNhPF6ULt1+nT
 hEemfJLMQYOQ/qkTOXd+3p35S7wq/SQGrMcd148DEj+bzQO3qrQTn1ca7h8U0nCtgUow
 QJ0w==
X-Gm-Message-State: AOJu0YzqzaGjkFsSD77j8svKb9TRxGLoloog23TV6nCA2cNfm3ER2RPu
 G14CBBIy8PVY/iyzaVAuGJfDeM7/xoiKmh4pSUyq1SwDXe35aO/u3I6C81yBpWmz78L1NLeYYAp
 2JblMTXrHYnjSenon9enWGHYT78qJQU7k5A9RAkEUSvGcGUs65W9UPdDkUepG
X-Received: by 2002:a05:620a:3721:b0:7a3:4fbf:d926 with SMTP id
 af79cd13be357-7a34fbfdf73mr22022385a.4.1722537531272; 
 Thu, 01 Aug 2024 11:38:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrHRmRM6vxHZCU9CeS1UUjYErRWJsTdwUdBUeKAPsmgskfV6stDQRoRFIktZkoRFeVKGRCyw==
X-Received: by 2002:a05:620a:3721:b0:7a3:4fbf:d926 with SMTP id
 af79cd13be357-7a34fbfdf73mr22020985a.4.1722537530824; 
 Thu, 01 Aug 2024 11:38:50 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a34f7724b4sm15257885a.81.2024.08.01.11.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 11:38:50 -0700 (PDT)
Date: Thu, 1 Aug 2024 14:38:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH 2/2] migration/multifd: Fix multifd_send_setup cleanup
 when channel creation fails
Message-ID: <ZqvWOEHfLCqnu4dP@x1n>
References: <20240801174101.31806-1-farosas@suse.de>
 <20240801174101.31806-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801174101.31806-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
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

On Thu, Aug 01, 2024 at 02:41:01PM -0300, Fabiano Rosas wrote:
> When a channel fails to create, the code currently just returns. This
> is wrong for two reasons:
> 
> 1) Channel n+1 will not get to initialize it's semaphores, leading to
>    an assert when terminate_threads tries to post to it:
> 
>  qemu-system-x86_64: ../util/qemu-thread-posix.c:92:
>  qemu_mutex_lock_impl: Assertion `mutex->initialized' failed.
> 
> 2) (theoretical) If channel n-1 already started creation it will
>    defeat the purpose of the channels_created logic which is in place
>    to avoid migrate_fd_cleanup() to run while channels are still being
>    created.
> 
>    This cannot really happen today because the current failure cases
>    for multifd_new_send_channel_create() are all synchronous,
>    resulting from qio_channel_file_new_path() getting a bad
>    filename. This would hit all channels equally.
> 
>    But I don't want to set a trap for future people, so have all
>    channels try to create (even if failing), and only fail after the
>    channels_created semaphore has been posted.
> 
> While here, remove the error_report_err call. There's one already at
> migrate_fd_cleanup later on.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Jim Fehlig <jfehlig@suse.com>
> Fixes: bd8b0a8f82 ("migration/multifd: Move multifd_send_setup error handling in to the function")

Should it be this one instead?

b7b03eb614 ("migration/multifd: Add outgoing QIOChannelFile support")

> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

PS: what's your plan on your other multifd SendData series?  I got a bit
overloaded on downstream stuff and I still have plenty review debts
recently (CPR one of them.. needs follow ups), so just to say I may delay a
bit on reading that one.  I assume it's next-release stuff anyway, but let
me know otherwise.

Thanks,

-- 
Peter Xu


