Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC909C54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 19:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj27S-0006XX-Tq; Tue, 27 Aug 2024 15:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sj27S-0006Wn-23
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 15:44:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sj27P-0004fe-Up
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 15:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724787882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3e5l+AHgSsIOJXQUIGhmoYpQ574AM/gSm2INN6GcI8g=;
 b=SQ/Wy8ovR7FmZUX+Z4cuy5VSqAb/3iyl6G/9kuJiED4kgPacS0IbECZx+Ma7vRkz2Y8pP3
 4Z6DhNMeDSib03Kf5zPEGNlZOLPATJ07N6+8TsoJfINgot223PMUWf4xbIAugbcWYMosO0
 H+Pa6GSuEvy7ZrYJ9S/UAFQomyA8hxA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-mcTED9_dM6iXdtpuFOIwZg-1; Tue, 27 Aug 2024 15:44:40 -0400
X-MC-Unique: mcTED9_dM6iXdtpuFOIwZg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a1d40f49f5so745744785a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 12:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724787880; x=1725392680;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3e5l+AHgSsIOJXQUIGhmoYpQ574AM/gSm2INN6GcI8g=;
 b=SZuTv2akm6eGq/EZUnFaQxP8Npi96jnmhGbmPMNDGFwjrc9kFkFlMqGf2zdoBuSs/B
 PpO4dUHSM6q7ag5g4F40rLtx0FxxqRko/LozuUewp+5jtnVDCUC1HqTXcrhqR4U4vV9u
 wepyO2RCjPUaQ7voJnN+Kq9WgKskk2BSJltzvdFSrMCJBkm6IfF304gWiZJc3YR5iZjk
 E2FfMGFuy5rn2z6eS+lYrJIGIuIx2hj0rODTtQkr6hn7+b8WNDMCUIBZUTrZkSV4WCDz
 keC27Szye/33H+HQLg8ZuZraV3nlHZbivO4GAzVzanw1tGxHqVvDNxanJlbDtCzZIBOo
 /2zg==
X-Gm-Message-State: AOJu0YzUTxL8vcTtShoUT3a8lWxrRte6Xcz9PvfPqDOEX+Sz4Fqx6L1W
 zfKiPqy76TGflTei5csav0GklAsL1j6hEEWVpiSqgGUD4lw0Q1rlBrvSu5rNd0YwZwnvWxAFfC/
 jN6MEKBKF/GVlrthOINmOVvpS7eV6erEQdcFxkkOCTLU+kKa7ET9v
X-Received: by 2002:a05:620a:1790:b0:79f:1869:11fe with SMTP id
 af79cd13be357-7a689763d03mr1692099885a.52.1724787880296; 
 Tue, 27 Aug 2024 12:44:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpyRgeJFEVxlAKg8TAoPQljFfu6ZxB0C9qq5yY3Cy29jiKxtSAByi8ztwht5UOzVXfEGYx6w==
X-Received: by 2002:a05:620a:1790:b0:79f:1869:11fe with SMTP id
 af79cd13be357-7a689763d03mr1692098085a.52.1724787879908; 
 Tue, 27 Aug 2024 12:44:39 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f41cdbcsm575107285a.133.2024.08.27.12.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 12:44:39 -0700 (PDT)
Date: Tue, 27 Aug 2024 15:44:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v6 19/19] migration/multifd: Add documentation for
 multifd methods
Message-ID: <Zs4spTkGlJJuB7LT@x1n>
References: <20240827174606.10352-1-farosas@suse.de>
 <20240827174606.10352-20-farosas@suse.de> <Zs4bL_lRURD7cV_N@x1n>
 <87mskxx0ck.fsf@suse.de> <Zs4ka2-q6JJbL1KA@x1n>
 <87jzg1wza0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jzg1wza0.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Aug 27, 2024 at 04:17:59PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Aug 27, 2024 at 03:54:51PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Tue, Aug 27, 2024 at 02:46:06PM -0300, Fabiano Rosas wrote:
> >> >> Add documentation clarifying the usage of the multifd methods. The
> >> >> general idea is that the client code calls into multifd to trigger
> >> >> send/recv of data and multifd then calls these hooks back from the
> >> >> worker threads at opportune moments so the client can process a
> >> >> portion of the data.
> >> >> 
> >> >> Suggested-by: Peter Xu <peterx@redhat.com>
> >> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> >> ---
> >> >> Note that the doc is not symmetrical among send/recv because the recv
> >> >> side is still wonky. It doesn't give the packet to the hooks, which
> >> >> forces the p->normal, p->zero, etc. to be processed at the top level
> >> >> of the threads, where no client-specific information should be.
> >> >> ---
> >> >>  migration/multifd.h | 76 +++++++++++++++++++++++++++++++++++++++++----
> >> >>  1 file changed, 70 insertions(+), 6 deletions(-)
> >> >> 
> >> >> diff --git a/migration/multifd.h b/migration/multifd.h
> >> >> index 13e7a88c01..ebb17bdbcf 100644
> >> >> --- a/migration/multifd.h
> >> >> +++ b/migration/multifd.h
> >> >> @@ -229,17 +229,81 @@ typedef struct {
> >> >>  } MultiFDRecvParams;
> >> >>  
> >> >>  typedef struct {
> >> >> -    /* Setup for sending side */
> >> >> +    /*
> >> >> +     * The send_setup, send_cleanup, send_prepare are only called on
> >> >> +     * the QEMU instance at the migration source.
> >> >> +     */
> >> >> +
> >> >> +    /*
> >> >> +     * Setup for sending side. Called once per channel during channel
> >> >> +     * setup phase.
> >> >> +     *
> >> >> +     * Must allocate p->iov. If packets are in use (default), one
> >> >
> >> > Pure thoughts: wonder whether we can assert(p->iov) that after the hook
> >> > returns in code to match this line.
> >> 
> >> Not worth the extra instructions in my opinion. It would crash
> >> immediately once the thread touches p->iov anyway.
> >
> > It might still be good IMHO to have that assert(), not only to abort
> > earlier, but also as a code-styled comment.  Your call when resend.
> >
> > PS: feel free to queue existing patches into your own tree without
> > resending the whole series!
> >
> >> 
> >> >
> >> >> +     * extra iovec must be allocated for the packet header. Any memory
> >> >> +     * allocated in this hook must be released at send_cleanup.
> >> >> +     *
> >> >> +     * p->write_flags may be used for passing flags to the QIOChannel.
> >> >> +     *
> >> >> +     * p->compression_data may be used by compression methods to store
> >> >> +     * compression data.
> >> >> +     */
> >> >>      int (*send_setup)(MultiFDSendParams *p, Error **errp);
> >> >> -    /* Cleanup for sending side */
> >> >> +
> >> >> +    /*
> >> >> +     * Cleanup for sending side. Called once per channel during
> >> >> +     * channel cleanup phase. May be empty.
> >> >
> >> > Hmm, if we require p->iov allocation per-ops, then they must free it here?
> >> > I wonder whether we leaked it in most compressors.
> >> 
> >> Sorry, this one shouldn't have that text.
> >
> > I still want to double check with you: we leaked iov[] in most compressors
> > here, or did I overlook something?
> 
> They have their own send_cleanup function where p->iov is freed.

Oh, so I guess I just accidentally stumbled upon
multifd_uadk_send_cleanup() when looking..

I thought I looked a few more but now when I check most of them are indeed
there but looks like uadk is missing that.

I think it might still be a good idea to assert(iov==NULL) after the
cleanup..

-- 
Peter Xu


