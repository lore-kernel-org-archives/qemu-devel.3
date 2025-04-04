Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C397C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 10:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0e4o-0001q2-UP; Fri, 04 Apr 2025 06:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u0e4j-0001pO-Ir
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 06:15:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u0e4i-0006xE-2E
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 06:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743761697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qt77Sr/K4lefEybxKEaSphX2YiUQU7uZRKzdarombqo=;
 b=Ag+hkX/ZXPefpIxPxkSoy0ydIsIfJWFjPpMjFhqWxLpNQJCXIhtV2oiaYTE4aKpcSNdhS1
 Yqbe0ZAoCcrKODkN+B2NEqhOPlQwISlu6LW/R1INuGD1qIm4IQ6/zaKgyQ2yysGe169ePm
 vKdlUuF1QiKB9dTqUlaaRdVD50t9Msg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-FA5kjNE-M3yv0LiXh3ovHw-1; Fri, 04 Apr 2025 06:14:56 -0400
X-MC-Unique: FA5kjNE-M3yv0LiXh3ovHw-1
X-Mimecast-MFC-AGG-ID: FA5kjNE-M3yv0LiXh3ovHw_1743761695
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-438e180821aso8933585e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 03:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743761695; x=1744366495;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qt77Sr/K4lefEybxKEaSphX2YiUQU7uZRKzdarombqo=;
 b=iqYUg1YLrLvJavjw0bfZ4N/cnqlyeS/M7uhCc7zl0465MXtCZYR7AL127OXzQtqXDZ
 f675K2qLsV44boo0j1cGD28gAbK9/ugN7QqmRjDaCZWu7xUUjOuolV+WiVRyBMHn0CYM
 kQ/4Bd3KtJx2y4uyXwPK+JToI88wK0YffSti5oFwpl3yt3PLYsMFyejc2Q0dnaUoDNAl
 YDTC3nInHQL7e3ZEP8kRoqhm3S82m+3jBmR3YiGux6Tca8YaUldGTyPQwizB5cpVbtch
 2zNJoSr8uFt5IrtbM6sdE26kUIpCdRQmgFy7flIHymz+a/a47C2Qf0HJ3kQHDuGu9TJi
 eR1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLipPQo7cyUc6sTIytNQyM8zgRTT4VBwaKbzWZG3ALeMhdXRaYfaHxNKhrF9o7KDTyxtveElG/CuqS@nongnu.org
X-Gm-Message-State: AOJu0YxxBHEPGIExJQW2YQDevEfBanygQmGQF8DfDU4RQOl/27FHbzaC
 5zk89ThGDhrnqiQFAJ644KcSeORoVv81uJKStaOi52z1XOHnFF8Metuq9WHLFuwGOI9JuZxJ43R
 bhlmN71p8XR5RQAEU29VXu+smsUSbsfHX2Wx2wscrmw80uTjZXDxGySbeL2XUYI/zU+hPXt74YQ
 SBrQ3epJzSW2twQ/xNLuPGfGjEqVw=
X-Gm-Gg: ASbGncuH9Z8OHv6HXkeOSsJlUgQTEbwhqwRx1lzioKmkII4vlf/AYOW7BXmi0kP+Gzx
 IUHmPQ3uTfodo7dF+FOlx+1erFr/SRVZp4Ji7MhHDgv78Nk+FbJML1SwK6N3S7LzZB6+q5tB/jm
 E=
X-Received: by 2002:a05:600c:4e8f:b0:43c:fe15:41dd with SMTP id
 5b1f17b1804b1-43ecf81b17fmr22027365e9.6.1743761695286; 
 Fri, 04 Apr 2025 03:14:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF03BBy7YQLKVT9MxmrYMUtmWDNBbdUOhfr2/8x2KKcOB7aLZn2b+HCmyZgFdPZwRDf5ynRIezQv1S2NnmDLyQ=
X-Received: by 2002:a05:600c:4e8f:b0:43c:fe15:41dd with SMTP id
 5b1f17b1804b1-43ecf81b17fmr22027155e9.6.1743761694958; Fri, 04 Apr 2025
 03:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
 <CAE8KmOzbtMwwTF662e_xo77EQ-nK-QOcqYDfmirkX-m8faAcxQ@mail.gmail.com>
 <5ed-67efa080-44f-38bc9540@144005994>
In-Reply-To: <5ed-67efa080-44f-38bc9540@144005994>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 4 Apr 2025 15:44:37 +0530
X-Gm-Features: ATxdqUHx7lp38iC1g1UujGTHnpQF29UtvaXhp-dIDCDUg9cZhFTTosemCd8u1Tw
Message-ID: <CAE8KmOzz2cyHimBXcs79wOOzg2KyKwmSNSXbkJomhGdhwWfKBg@mail.gmail.com>
Subject: Re: [PATCH] migration: add FEATURE_SEEKABLE to QIOChannelBlock
To: Marco Cavenati <Marco.Cavenati@eurecom.fr>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

On Fri, 4 Apr 2025 at 14:35, Marco Cavenati <Marco.Cavenati@eurecom.fr> wrote:
> Almost. Unlike  lseek(2), pread(2) and co. do not have side effects on the fd's offset.
> From the man page:
> > The pread() and pwrite() system calls are especially useful in
> > multithreaded applications.  They allow multiple threads to
> > perform I/O on the same file descriptor without being affected by
> > changes to the file offset by other threads.

* If the r/w pointer adjustment (lseek(2)) is not required, then why
set the  '*_FEATURE_SEEKABLE'  flag?

> It is a first step in making QIOChannelBlock compatible with
> mapped-ram feature that requires it since mapped-ram uses
> io_preadv and io_pwritev methods.

* The qio_channel_block_preadv/pwritev functions defined above, which
shall be called via  '->io_preadv' and '->io_pwritev' methods, appear
to call bdrv_readv/writev_vmstate() functions. Do those functions need
to adjust (lseek(2)) the stream r/w pointers?

Thank you.
---
  - Prasad


