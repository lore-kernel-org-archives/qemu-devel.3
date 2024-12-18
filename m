Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95897E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 17:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNxbg-0004dY-SD; Wed, 18 Dec 2024 12:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNxbd-0004dH-Gk
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:13:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNxbb-0004Su-Td
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:13:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734541981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5ms1MeWSDRG3hiGwIXy/YgepTAfA3tRusx6cMRM+R+M=;
 b=TNer6xwERXkW/JZdg2LlK43arsF/TlVMKDFOj7r5awgEtevNCn8AYB3MWl+taOKNKJMPdc
 NHc4rEJUuMEey+WvlWseTct+oiI+KGxpDCc+AeEdsyDKHdaD8FwqxpzdxhwQslLOVpd9GG
 Gn7VyAl7ixIHTf67tkDqMUgQE0MRsMQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-A7ymLsHqN22WvNBOkmyrzQ-1; Wed, 18 Dec 2024 12:13:00 -0500
X-MC-Unique: A7ymLsHqN22WvNBOkmyrzQ-1
X-Mimecast-MFC-AGG-ID: A7ymLsHqN22WvNBOkmyrzQ
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4675749a982so127929521cf.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 09:13:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734541980; x=1735146780;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ms1MeWSDRG3hiGwIXy/YgepTAfA3tRusx6cMRM+R+M=;
 b=aqdf5P+TnDyBEcOJ4c72rkkWM6MI1Y0Zlj0ajKyq0G/l4WtChuq0GFg1f5VNe0Bd1q
 N2yhdCD7QneLzxeb+0WdqchrUWqeImJfMAnVKFeaeNWCBgnCILZAQHEhNV+SOr4QTudu
 GQaJDykMAANqhURnX6a9jaWH/doWTJJMFaMkKcUJvvZAJcHXTl6DfvjK2au0w/LwYzDr
 mAJBBGMwfjnQ1DVJv6f9g/B9Emup6BHTcrHTrZsB0follpWG71vNIox6Y+/OqaV0TKoL
 gWnePE/D3JiWzazwNCD6sYkwQzSCFjqgiE7T4qxR2FyPVqUGEY5ddhg+3CKdwc5hzpGg
 k7KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMdRffDI4pIlO/WwdutDpx7k/vTIAbBv7L/HkDNYLr5h7SpXnimrEIqgMejf7RnTsPtT67PwmY4WjN@nongnu.org
X-Gm-Message-State: AOJu0YyG7eMWH2pnhizI2EwFbgx73Xgi9sni2sRW/EZbxcas7BvYl/a+
 3ptaqZJmPQ73YU8ORxj+6OMVZJxlTyxR0Kjkv2wmnVDkU1lzUgec9VC8eMrKAKnUrtkG+YufXmn
 tOfx4OJnP+49SIBeValxiuwYD3dJhqOjbc7WGKWhv9UuBtDDtw3G5Vfn0YgQd
X-Gm-Gg: ASbGncsSXis7VE6giUUlWkB065GvF7/F5BL8BIZz0Ztmasr7ZSfx52yOujPS+aYn5cg
 0IxoWnCFBIo2yiq+SNvYmYxyayD94dV+WXZUoLCkHyMS5oFJfxPuiuQszvN4mFVYwPrNYY75Kcn
 pu6dBzI3dUTmkpGn7QJwg/ASzQbIJnStKenPkBJCP6NtacEUPfC+WHI6QHzIxEiQwekKRsFt1pR
 YEqZ3Lbs0xT1WH25mNlMHLwgURCwtB9E0++9PquahUMt+1A3imuEYP/RU1cLPXc0PZsxsC+wpDj
 30l+zl8gip3g2RJMnw==
X-Received: by 2002:ac8:5887:0:b0:467:630d:85ef with SMTP id
 d75a77b69052e-46908e6f08fmr58763381cf.41.1734541979813; 
 Wed, 18 Dec 2024 09:12:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoqDkSVAjGMhAjeSLAihD3RW71OW/fF7vawJAtiZuYIDKeDk/8p8EkjUH1Hh02+6V8ceGgCw==
X-Received: by 2002:ac8:5887:0:b0:467:630d:85ef with SMTP id
 d75a77b69052e-46908e6f08fmr58763031cf.41.1734541979505; 
 Wed, 18 Dec 2024 09:12:59 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2cc2a51sm52737731cf.49.2024.12.18.09.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 09:12:58 -0800 (PST)
Date: Wed, 18 Dec 2024 12:12:57 -0500
From: Peter Xu <peterx@redhat.com>
To: Yuan Liu <yuan1.liu@intel.com>
Cc: farosas@suse.de, qemu-devel@nongnu.org, jason.zeng@intel.com,
 yichen.wang@bytedance.com,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH 0/3] bugfixes for migration using compression methods
Message-ID: <Z2MCmQ2YAMVb9kSy@x1n>
References: <20241218091413.140396-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241218091413.140396-1-yuan1.liu@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On Wed, Dec 18, 2024 at 05:14:10PM +0800, Yuan Liu wrote:
> This set of patches is used to fix the bugs of incorrect migration
> memory data when compression is enabled.
> 
> The method to reproduce this bug is as follows
> 1. Run "stress-ng --class memory --all 1" in the source side, the
> stress-ng tool comes from https://github.com/ColinIanKing/stress-ng.git
> 
> 2. Enable the multifd compression methods and start migration
>    e.g. migrate_set_parameter multifd-compression qpl
> 
> 3. The guest kernel will crash automatically or crash at shutdown after
>    the migration is complete
> 
> The root cause of the bugs and the solutions are described in detail in
> the patch.
> 
> My verification method as follows
> 1. Start the VM and run the stess-ng test command on the source side.
> 2. Start the VM with "-S" parameter on the target side, it is
>    used to pause the vCPUs after migration.
> 3. After the migration is successful, use the dump-guest-memory command
>    to export the memory data of the source and target VMs respectively.
> 4. Use "cmp -l source_memory target_memory" to verify memory data.

This looks like a good idea to test memory intergrity.  I wonder if we can
do that in some, or all, of our migration qtests.

I didn't check the latter 2 patches but I assume they can also have a
proper Fixes tag.

The other thing is uadk seems also broken from that regard.. we could add
one patch for it, but the testing may be challenging for any of us.  In all
case, I copy Shameer.

-- 
Peter Xu


