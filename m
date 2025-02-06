Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2324CC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 21:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg9mj-0007TY-1m; Thu, 06 Feb 2025 16:51:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tg9mh-0007SR-7k
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 16:51:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tg9mf-0003Uj-IA
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 16:51:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738878699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z8OslSE7RuCCGiALMLvSu1dhInhzdW1yaaMdr2s42U0=;
 b=RCTyyhRCIFZ/xjjeZiASY0hSKcswPmp5Emk2RrxLPQ3b2dAIfoPkDsLsY/54qEG+cmlyxZ
 eSE5eePujV4PH+7YN3PP/1bg8j2oHoJ4kX3ps/I2MUfLck3jR+UApKPlsT1eLeqkqkqjRg
 k7VD5UjWBzeneY2+NlN3RtQy6ggugfM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-eezbKWwfOcikl9RRYUzh-A-1; Thu, 06 Feb 2025 16:51:38 -0500
X-MC-Unique: eezbKWwfOcikl9RRYUzh-A-1
X-Mimecast-MFC-AGG-ID: eezbKWwfOcikl9RRYUzh-A
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6e2378169a4so33770236d6.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 13:51:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738878698; x=1739483498;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8OslSE7RuCCGiALMLvSu1dhInhzdW1yaaMdr2s42U0=;
 b=jQOha13POcfByXiXB4hDfRqAz+KaqeOzqL2ErJTzQo5z/d7CD0/gg0Co/xN+76jgNG
 DJLtSs4Vz3nu0Gsk20jtaRyjSP5d1GqxiN58MJLzidenA8I2NWzXVxpPir+SHc+dVA8E
 l/r/lb09vInYMVfyvCJW/nyZfa3eP7cU/gIHF8q0EKdhwn/kZwoXY6mUi8BVL3jRfzEn
 08+ZK677P/32bQXbI0PxbTxe/oaRjrBprdWBgqzBs2Uq/A/XmyEdOmXWyfBdXva2vFOW
 Pr+TLkzpJrvYyIYr1SrqnrlpOhfQtbDOk4UdOiWv0jjBfU3hLEeRwmlcobXCbqsRSyHu
 dGjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFi1RWdOc3JBL4c0Lfe/XEJ1CRP9ANaa/1iOVxR17Ol/CG8UHakhXx9kVgRxbMqFUmmIhXB5r9idtN@nongnu.org
X-Gm-Message-State: AOJu0YyDJ+MayIRIi86Biegt3o+xFCymv92QZy44YXTv2DmdAhiNxkkp
 CjHBnuk2JDxmhJuA9N1oZJCMJPv8fG/JQrhjGO7rsmJnGyQjOpbRdJprFJM9TfYr3xMaHmROMLf
 M/9u3kd3nrm26P2i6wAgiB4VjjiPQXeIfs+54Bg2XqXi7Oa1ZKd3X
X-Gm-Gg: ASbGncsNtLismXCpQ0kaKTwIlnDgLeMYOs3/Dh85xsBZliSE8k632BxHGyYF1x4zjjs
 bnxQiRuSvm7MWBRee9URV8X9MVeEKoxCGolKSdJBtphFYtgyDJrhlh/OOoTj/a5yZMC0hc6VF0H
 6zHTZKCDP4pQC8seLS6f6XaVAewsk7X6J6vqqW+6E5FK+TYL5drzYQpVJpZkRp0Sp2F3Ia1vCm2
 GTFpPrQdUKpz0rbAMV3FckkWkn0CBjDIlvqjfpebL2VglS1WUoa7eHTK+o0RwlHmsVu6FwktHS+
 etwXTnsuCPkmdHuZYodRTQ2r30ZkxJvrN/eeLE94CxRWixZC
X-Received: by 2002:ad4:5dea:0:b0:6e4:1e16:b63d with SMTP id
 6a1803df08f44-6e44563af59mr9989456d6.21.1738878698141; 
 Thu, 06 Feb 2025 13:51:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTtedig/hNdvavkMUUEcYhsmkFHh5+ti7xYYzl0LSEH8R01RxLFODh/CyGGWEXjYkx9gL8ww==
X-Received: by 2002:ad4:5dea:0:b0:6e4:1e16:b63d with SMTP id
 6a1803df08f44-6e44563af59mr9989286d6.21.1738878697898; 
 Thu, 06 Feb 2025 13:51:37 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e43bad7989sm9818536d6.122.2025.02.06.13.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 13:51:37 -0800 (PST)
Date: Thu, 6 Feb 2025 16:51:35 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/33] migration/multifd: Allow premature EOF on TLS
 incoming channels
Message-ID: <Z6Uu50gzSIgKsiLA@x1.local>
References: <Z6Iy0wY-lsx3M71M@x1.local> <Z6I0mzWEsl5y57Zj@redhat.com>
 <87zfj0mcmy.fsf@suse.de> <87wme4m8ci.fsf@suse.de>
 <192db6a6-f3ff-4cf9-8537-b849fb3a97b3@maciej.szmigiero.name>
 <87tt97ma9l.fsf@suse.de>
 <ac6f56c0-58d9-45a4-bbf4-6b28649a8952@maciej.szmigiero.name>
 <87msezm75y.fsf@suse.de>
 <eba9c2d2-5a20-489c-aa89-8adde2781c7a@maciej.szmigiero.name>
 <87jza3m12b.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jza3m12b.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Feb 06, 2025 at 02:32:12PM -0300, Fabiano Rosas wrote:
> > In any case we'd still need some kind of a compatibility behavior for
> > the TLS bit stream emitted by older QEMU versions (which is always
> > improperly terminated).
> >
> 
> There is no compat issue. For <= 9.2, QEMU is still doing an extra
> multifd_send_sync_main(), which results in an extra MULTIFD_FLAG_SYNC on
> the destination and it gets stuck waiting for the
> RAM_SAVE_FLAG_MULTIFD_FLUSH that never comes. Therefore the src always
> closes the connection before dst reaches the extra recv().
> 
> I test migration both ways with 2 previous QEMU versions and the
> gnutls_bye() series passes all tests. I also put an assert at
> tlssession.c and never triggers for GNUTLS_E_PREMATURE_TERMINATION. The
> MULTIFD_FLAG_EOS should behave the same.

Which are the versions you tried?  As only 9.1 and 9.2 has 637280aeb2, so I
wonder if the same issue would hit too with 9.0 or older.

I'd confess I feel unreliable relying on the side effect of 637280aeb2,
because fundamentally it works based on the fact that multifd threads need
to be kicked out by the main load thread SYNC event on dest QEMU to avoid
the readv() from going wrong.

What I'm not sure here is, is it sheer luck that the main channel SYNC will
always arrive _before_ pre-mature terminations of the multifd channels?  It
sounds like it could also happen when the multifd channels got its
pre-mature termination early, before the main thread got the SYNC.

Maybe we still need a compat property at the end..

-- 
Peter Xu


