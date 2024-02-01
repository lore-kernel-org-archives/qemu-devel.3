Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC2BC47DB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 03:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVNhU-0005P0-Ua; Wed, 31 Jan 2024 22:25:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVNhS-0005Oa-Lk
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 22:25:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVNhR-0004xk-34
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 22:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706757911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iuBgQvtngscXgAZQ9vARoiG2WB12h8/S5zY9JpDFdx8=;
 b=e81LaUv6pVQPmCPQhX/CgPzL6SP6ONspIdS1iHjfR8CxooaFJaOtJcXWLJ5GHU8LYlZy/b
 xwIyJ97PC2WcHmSG3BzQXcKh23A93CGmE/cJHWqxxvrBTtX83l4dzkixl+dp5aENt8f6aG
 2KiYREdRgiHZkC8bhBg8I+aCqn8EXEQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-UbrjoiaQMUKF9nLr6X7mgQ-1; Wed, 31 Jan 2024 22:25:09 -0500
X-MC-Unique: UbrjoiaQMUKF9nLr6X7mgQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5c683944ab0so75441a12.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 19:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706757908; x=1707362708;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iuBgQvtngscXgAZQ9vARoiG2WB12h8/S5zY9JpDFdx8=;
 b=Dznm/pfRZDWCroY8xnkQeMBcCJlIqbrdhWc1TtcLSMylm3oB6WtEnUbHo+pChhcUtl
 FkfOdupILdIqb1bz8jK7Rjt+L/W1z4rC0DpxSoM+P2mj1C94VlssYqf3ttskOJUmRFNS
 k+z5ga5pEPLpOB7ef/i462ILtVl2/biDqaZYhaPk5Ja7wrA+X5LZw6X+DkwhPj+bqKTF
 APjS5H66+0MwII6ZJV213bFWfbo6bZeAZadpYeQTcqyBJFjppMOKsiAth0omqqOhKdvY
 xEPZpPEC4bkHhDOpXmo3E9q2WBV0fyOfb/5blnO2s/STzZ9TQ+hXFQVAt0xsEZxR5pV3
 2ftA==
X-Gm-Message-State: AOJu0YyyodfIuSX6sUzt7jAMIBZQBPVEqj9Ic971wfgPOyoiEpr1Vk2w
 446cUl069lNT+4ZQe2RZcw829phgkkqa0hyMVOJT28loHJ50oan2bnElV+xqjygN3MDJDQYmbrx
 Tir0InufkNcJK/7FFl9sV5aXKsHQV8NMEKWMPN+1d0WSJPzzZvwHg
X-Received: by 2002:a17:90a:fd8b:b0:296:1126:7078 with SMTP id
 cx11-20020a17090afd8b00b0029611267078mr727168pjb.3.1706757908313; 
 Wed, 31 Jan 2024 19:25:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxjPTiuxByR3oXkmKsq7Ve1CN80V9hI5dyK0DZdhl5/G38JHk9mgU33bC+io7hmSyOhYKjpQ==
X-Received: by 2002:a17:90a:fd8b:b0:296:1126:7078 with SMTP id
 cx11-20020a17090afd8b00b0029611267078mr727153pjb.3.1706757907974; 
 Wed, 31 Jan 2024 19:25:07 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXr7dBBsjOARADSDHvyncAS/uLyj5UJ0XCtNU4ZCBVcft3BNXt58mwtJLTcNHqHq3gF3UBsIeNJcKSf4QVirlKqV3kls5MT3quQ0EBWJqu5JpElv75cGWNKMs2tZS0d/zgUM3vLirnABmCDSoWnlCeBj4+soCRS9kk92rbJjzTb7LWXE3yFcXXxQ9d+
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 nt7-20020a17090b248700b00295c8c120dbsm2340094pjb.20.2024.01.31.19.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 19:25:07 -0800 (PST)
Date: Thu, 1 Feb 2024 11:25:00 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Hao Xiang <hao.xiang@bytedance.com>,
 Yuan Liu <yuan1.liu@intel.com>, Bryan Zhang <bryan.zhang@bytedance.com>,
 Avihai Horon <avihaih@nvidia.com>
Subject: Re: [PATCH 1/5] migration/multifd: Separate compression ops from
 non-compression
Message-ID: <ZbsPDMePqeWPyyTy@x1n>
References: <20240126221943.26628-1-farosas@suse.de>
 <20240126221943.26628-2-farosas@suse.de> <ZbdFzFxysMg274Rw@x1n>
 <87mssoe2fj.fsf@suse.de> <Zbi2XDfeJHcUpUp9@x1n>
 <8734uedff0.fsf@suse.de> <Zbn1mcXXGKdTTz6O@x1n>
 <875xz9lk4t.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875xz9lk4t.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
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

On Wed, Jan 31, 2024 at 10:14:58AM -0300, Fabiano Rosas wrote:
> > I am thinking the p->normal is mostly redundant.. at least on the sender
> > side that I just read.  Since I'll be preparing a new spin of the multifd
> > cleanup series I posted, maybe I can append one more to try dropping
> > p->normal[] completely.
> 
> Just for reference, you don't have to use it, but I have this patch:
> 
> https://gitlab.com/farosas/qemu/-/commit/4316e145ae7e7bf378ef7fde64c2b02260362847

Oops, I missed that even though I did have a glance over your branch (only
the final look, though), or I could have picked it up indeed, sorry.  But
it's also good news then it means it's probably the right thing to do.

-- 
Peter Xu


