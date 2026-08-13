Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C4DC5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuVgU-0007zM-FO; Thu, 13 Aug 2026 09:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuVgQ-0007z1-Bu
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 09:41:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuVgM-0006Rl-7o
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 09:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786628475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=emdw3IBP1nPWPvAparUmaabAqDito9IF8rp11rvxFmE=;
 b=ecB/fHMbwtw0GNCOX3q+JiDFOtCFtSvMYWczEf+ljTxLOTTXjZaucCnTPXv96QjFjMKNdq
 nBIaY+2Z9/yxRxt6dGdIT0d5FNsUoks8Jj8JmozlgFnn4YS81R0PIC9J+Oil+ezrdNxgp9
 JF7U0jLm4Nmb36LKIZrRwO43O9/BLew=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-XZtK5KjDPKGXsKYZm38yaw-1; Thu, 13 Aug 2026 09:41:10 -0400
X-MC-Unique: XZtK5KjDPKGXsKYZm38yaw-1
X-Mimecast-MFC-AGG-ID: XZtK5KjDPKGXsKYZm38yaw_1786628469
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5c0fb008616so973938e0c.0
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 06:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786628469; x=1787233269; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=emdw3IBP1nPWPvAparUmaabAqDito9IF8rp11rvxFmE=;
 b=CvKICUzTUFtlWP+bS5zwpLrCzY2zFE79WsBAO9aIHdMP6Rs9oxFpdGArK0e9c2CNBU
 3oW8LkAZYkkknWXzHjwtNP4dy+8Z/+OwwUB/aic/uXyiiJqDOP+In+FTqVjMDEhV93/+
 Rx/ySXEZ7YYMiyvoEUvYsDCj4tbEWMuPjF9+PI4RizU8TbJnEiW7M4O6siWn8hEF2ai+
 48ZxKrf2YDd/zeNduoLhMAZRI5/QVCHtrIrRgdsniPmS613/p3+yBvnQXltzNqvBvYAr
 gKXjMLPqJKdevdvEqTke9KoHkAM9loX+oRdI28uYdcMH8oHaH2dYRd8vVPV/SfXqFA+o
 5dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786628469; x=1787233269;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=emdw3IBP1nPWPvAparUmaabAqDito9IF8rp11rvxFmE=;
 b=R3BpOV4rdYXkK2a8uMF1H7qcZk71oPAGdL+M4SOlCMfME/tLsYOlZntAVr0IAXM/yH
 Q461ve3g/HkmEECdCy8OVlj58XIAiJwZDAu10w22wxAOjTwCJYuexlzZNmv7+6E4xWrX
 cY0selgEVd17fTVR3hlk5c5CYQxklcxZ6D8llmzqWkmfCGkmI2WSJP8sp8snPjPSBPqf
 +QBZPhaQDX4mM0nZU9DB2KyXmxPOBeRVBCGTO3+7otONKWS7RVwWxQjF+nbg/IjbBobG
 xjrTkQwpjGkNzSijeXao/MOhqd9NzrNoV2eri4gn/nhZXjIWij5kVFm2nTRbrwenQpwE
 dx0g==
X-Gm-Message-State: AOJu0YzPn2JsQReSnvxY/sFKwsbGmsa7TZd/mQuI3hLfhv+2w0kEfYGQ
 cEfa1s39ch637IN8zStaNbbjuayFiu27UG3F36qF0VpH0q1HGKtKCp8PCkpO9AuKSpOMFMn89gN
 XbzbVTdqU65edN6KV6ARrPgQRZTngn9QZUP+9t5akn0ezgj8+U1CUWhHx
X-Gm-Gg: AR+sD107MdtFJe7aJhvl5A5wtIHA5U7CrhwUar8z6EVUayLOEVFoNXW8dRx095M0mdn
 ysmg7P6pxvhQSQlp+MjoEEuan0TReZ4kJMXvaRgznOpDRIWtTDoW2/ryj8R5wQdXMAF1oKY6oKK
 RWGr5NjS1VOyLYy4Bx+yT46pG3qZIRhz9SwivKInB/Zs4VjvgNXJVa0MSctkb5tsOSyYMQnR3os
 gKCyNJpYMTFywYOAWbMm/xdDaQ78ZiAqk1Cz7asqqF+rAvaUOJYvNldrRWApU/bUYaJ/Sy2fI/h
 wHKJdIT73pVgsuXCd7sELMh8zz2qhZYBIRRgto+V00bgPYrf685bQS56u1nTjPaFS3RAZSGm
X-Received: by 2002:ac5:c74c:0:b0:5c2:a30a:1a08 with SMTP id
 71dfb90a1353d-5c57bad1c3fmr560184e0c.2.1786628469068; 
 Thu, 13 Aug 2026 06:41:09 -0700 (PDT)
X-Received: by 2002:ac5:c74c:0:b0:5c2:a30a:1a08 with SMTP id
 71dfb90a1353d-5c57bad1c3fmr560171e0c.2.1786628468547; 
 Thu, 13 Aug 2026 06:41:08 -0700 (PDT)
Received: from x1.local ([2605:8d80:6cc9:637f:db7f:22cd:4098:82fd])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c57ba66ddcsm703469e0c.4.2026.08.13.06.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 06:41:07 -0700 (PDT)
Date: Thu, 13 Aug 2026 09:41:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PULL 00/10] Next patches
Message-ID: <an3JcZvNNS8o_UFg@x1.local>
References: <20260812151444.2611689-1-peterx@redhat.com>
 <f0a852af-1859-4133-9d96-be8b9231888d@linaro.org>
 <an26zg9zVW-JrV9f@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <an26zg9zVW-JrV9f@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 13, 2026 at 08:38:38AM -0400, Peter Xu wrote:
> On Wed, Aug 12, 2026 at 03:01:14PM -0700, Richard Henderson wrote:
> > On 8/12/26 08:14, Peter Xu wrote:
> > > The following changes since commit 84f07211cc5b4fc6a371559bf8a5de4fb068e648:
> > > 
> > >    Update version for v11.1.0 release (2026-08-11 10:04:46 -0400)
> > > 
> > > are available in the Git repository at:
> > > 
> > >    https://gitlab.com/peterx/qemu.git tags/next-pull-request
> > > 
> > > for you to fetch changes up to 2375e9b1239eb6ad794eaae29245b94f429c87c5:
> > > 
> > >    migration: Fix rare hang of migration_channel_read_peek() (2026-08-12 10:42:09 -0400)
> > > 
> > > ----------------------------------------------------------------
> > > migration/mem pull for 11.2
> > > 
> > > next 11.2:
> > > - Dongli's patch to add cpr-transfer support for HMP
> > > - Fabiano's doc update for migration on security issues
> > > - Gavin's fix for MMIO access support for memory APIs, reverting ram_device ops
> > > - Sam's migration test build fix for !ASN1
> > > - Peter's a few migration hardening fixes
> > 
> > MacOS build failures:
> > 
> > https://gitlab.com/qemu-project/qemu/-/jobs/15865084063
> > https://gitlab.com/qemu-project/qemu/-/jobs/15865084064
> > 
> > ../migration/ram.c:4291:54: error: incompatible pointer types passing
> > 'ram_addr_t *' (aka 'unsigned long *') to parameter of type 'uint64_t *'
> > (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
> >  4291 |         if (usub64_overflow(total_ram_bytes, length, &total_ram_bytes)) {
> >       |                                                      ^~~~~~~~~~~~~~~~
> > /Users/gitlab/builds/qemu-project/qemu/include/qemu/host-utils.h:552:70:
> > note: passing argument to parameter 'ret' here
> >   552 | static inline bool usub64_overflow(uint64_t x, uint64_t y, uint64_t *ret)
> >       |                                                                      ^
> > 
> > Note that ram_addr_t maps to uintptr_t not uint64_t.
> > Which should be functionally the same, but is probably
> > an 'unsigned long' vs 'unsigned long long' mismatch.
> > 
> > Perhaps we should just be using __builtin_add_overflow via a macro instead
> > of inlines so that we get the full functionality of the types accepted by
> > the builtin.
> 
> Ohhh I almost missed this email... somehow it lost all CCs include myself.
> I'll see how to fix and repost, thanks for the hints!

So for this one I plan to squash this (will repost in a minute):

diff --git a/migration/ram.c b/migration/ram.c
index 85feff578c..b6eb842746 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4263,7 +4263,7 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
     return ret;
 }

-static int parse_ramblocks(QEMUFile *f, ram_addr_t total_ram_bytes)
+static int parse_ramblocks(QEMUFile *f, uint64_t total_ram_bytes)
 {
     int ret = 0;

@@ -4271,7 +4271,7 @@ static int parse_ramblocks(QEMUFile *f, ram_addr_t total_ram_bytes)
     while (total_ram_bytes) {
         RAMBlock *block;
         char id[256];
-        ram_addr_t length;
+        uint64_t length;
         int len = qemu_get_byte(f);

         qemu_get_buffer(f, (uint8_t *)id, len);

After all, whole migration treats ram_addr_t to be u64, at least on wire.

For the long term, do we want to fully expose __builtin_add_overflow(), or
the new macro would do something more than what __builtin_add_overflow()
does?

Now when I think about it from the root, I tend to like what Xen defines
with ram_addr_t:

/* address in the RAM (different from a physical address) */
#if defined(CONFIG_XEN_BACKEND)
typedef uint64_t ram_addr_t;
#  define RAM_ADDR_MAX UINT64_MAX
#  define RAM_ADDR_FMT "%" PRIx64
#else
typedef uintptr_t ram_addr_t;
#  define RAM_ADDR_MAX UINTPTR_MAX
#  define RAM_ADDR_FMT "%" PRIxPTR
#endif

I don't know how we supported 32bit host emulating anything larger, but
logically it's doable, then IIUC uintptr_t won't be enough allocating
anything >4G? If emulating 64bits is too much, I still think it seems valid
to emulate e.g. PAE 36bits on a 32bit.  I didn't check how it was done now
or before, but logically it sounds that it should still work.

Meanwhile, we should never directly use a ram_addr_t* to be a pointer - it
simply is not, but only the address space qemu uses internally for
ramblocks.  That also implies to me that this seems to be a bit off.

Thanks,

-- 
Peter Xu


