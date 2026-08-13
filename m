Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F39CC5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuX0P-00006r-45; Thu, 13 Aug 2026 11:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuX0O-00006f-3b
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 11:06:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuX0K-0000jj-VZ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 11:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786633558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/lMsXCB5Z6ufqzJ+9dDe/Rj1Ait1z22Lv4L9W/5wNFo=;
 b=bxjp9hnabeklAVlT2sjfCGQb8oNM9KuMOWdXlADHU5jDAsYZwgumN0uRuutV/cYJjt7Zul
 TrvrOVBs25ccq2amsz9ti4wy6ddB7y7res9G6pYlnx9ogOhgL4wNLr5gZIfemZdH7kOF80
 62R6x6y84bbcMtDHaV/Bxtb8ZGx7SjI=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-8tQa6GhOMYe2NGBIMxO2fQ-1; Thu, 13 Aug 2026 11:05:51 -0400
X-MC-Unique: 8tQa6GhOMYe2NGBIMxO2fQ-1
X-Mimecast-MFC-AGG-ID: 8tQa6GhOMYe2NGBIMxO2fQ_1786633550
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5c2ae99c28cso276258e0c.3
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786633550; x=1787238350; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/lMsXCB5Z6ufqzJ+9dDe/Rj1Ait1z22Lv4L9W/5wNFo=;
 b=I66BDizowMn3NYT1L9HUrMYvk33ZEKHmfW7I+roD60NcDYNchX/wEPDduOdqZUgO+l
 DCoiAaIgdNqgo6gwZmyXOCzxG0uxjizuYJNSaW4tTORqb8a6H0TaTDHjZdOsMIQ20NMC
 sjQjJ1Y3m9xkX08LnRSrWtM9MlMrJp4LzXKcY4cDs6fH+8yccABPQ+zMYClkw4Q15cZv
 FJXwL7MeffNNakvSekt561KWpQO7dfuiGIuOzaCp9Lfzs9F0cX2ChDdcqsalGR2f6Uar
 NFR6lvvN785nrRu+3ag9yU26P3zli65zr84WgmONJ2KdemJ+oufi8w36vO3tFGvndZxq
 X/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786633550; x=1787238350;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/lMsXCB5Z6ufqzJ+9dDe/Rj1Ait1z22Lv4L9W/5wNFo=;
 b=bMcFupirEZLmQBafOw0aYa1OthU7kxTkrFb5qursnhrfgS0brEvhunfd1oX8wxcf8S
 hlUTvhTJJ65v0niA14jeYyHWlM7cJ10+rOEoUjHFCcgi0Qu65Tat4ht6/jvEjxQlXmZI
 rfb7SYNSFN1qHzucmXIsyEsBEWjO46IqDf2gES65j9k55xqC9nzl28N41G33J/uYXtcR
 ExJ9iuItPJoUdjYCx1yCtaJjY/v3QG8gyebNJhSzWyzb57liSPHz2xtYWeyaQ0tvM17S
 Pqea2QYQ82De89op7wQpSv8luihcc4w+gGsvljzQUqk+wag9bZGoleCwIoBMsOv21dIn
 Fz1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqrEWwjEtTHlT1oU6ReJEBJTIhlfAeJjIlEQVCdN30WstoXm6viijIEih30yurZaP+2A+A61mjT/TsK@nongnu.org
X-Gm-Message-State: AOJu0Yx9vi4VCGtxjcIY71Q/A2otpYODAtvGIh5o0i9sNF3JVBEzA5Q8
 Czkiu74FEWMnUg68A2suNn/IOEdOCen5vRHMI9AH7Japy0zi/1DfLkoFxJ9TvADUfV+xTwWQtIV
 l2sNLdaqAX8JNjv3FrqolE0hVhIQSuXUC9+OABRAumCciwm3IZPU8bXSk
X-Gm-Gg: AR+sD12muOCwgujkYqi9eZuRODVaaBirvsyNxFOXZ5DIvnAaP5TPUcR0kVQs8F9+5NW
 9CxqpaKwQ9XumThMSnXaalKwjXIDUAnW8zcUn0Gu/NuJMrdV1I5vkobbLreB8N0hwvLbtK6BYxx
 esB/Wb+LgTB7eQCEw/7CLD1Jtllqifk+V3tpNZJzWhVxfJhyasnBZVh7RjqRYrbFwCr1rZL2PhQ
 mk7rR7hfSQ3U8E2sNahrYVfRkzF6LuxcggBeJMrLqRrctWG1KbOM82K5s+qPGGm6UA0FWuJBENX
 tPpcCUx9zKoVrXMKp/IcyYQFqWuo+4Ics+SYP03rVf1mXGlbOP7UT3m65Bpfw1wNUljw
X-Received: by 2002:a05:6123:148:b0:5c1:25d4:e29c with SMTP id
 71dfb90a1353d-5c579708bfbmr753795e0c.0.1786633550104; 
 Thu, 13 Aug 2026 08:05:50 -0700 (PDT)
X-Received: by 2002:a05:6123:148:b0:5c1:25d4:e29c with SMTP id
 71dfb90a1353d-5c579708bfbmr753776e0c.0.1786633549428; 
 Thu, 13 Aug 2026 08:05:49 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c57ba66bfbsm919682e0c.2.2026.08.13.08.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 08:05:48 -0700 (PDT)
Date: Thu, 13 Aug 2026 11:05:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PULL 00/10] Next patches
Message-ID: <an3dSch6yhK52d2X@x1.local>
References: <20260812151444.2611689-1-peterx@redhat.com>
 <f0a852af-1859-4133-9d96-be8b9231888d@linaro.org>
 <an26zg9zVW-JrV9f@x1.local> <an3JcZvNNS8o_UFg@x1.local>
 <f6f159d5-4740-49b6-949c-cdcb1ec3c71f@linaro.org>
 <e02f8fb8-3ee3-4471-9748-8a26b95134a7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e02f8fb8-3ee3-4471-9748-8a26b95134a7@oss.qualcomm.com>
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

On Thu, Aug 13, 2026 at 04:51:39PM +0200, Philippe Mathieu-Daudé wrote:
> On 13/8/26 16:14, Richard Henderson wrote:
> > On 8/13/26 06:41, Peter Xu wrote:
> > > Now when I think about it from the root, I tend to like what Xen defines
> > > with ram_addr_t:
> > > 
> > > /* address in the RAM (different from a physical address) */
> > > #if defined(CONFIG_XEN_BACKEND)
> > > typedef uint64_t ram_addr_t;
> > > #  define RAM_ADDR_MAX UINT64_MAX
> > > #  define RAM_ADDR_FMT "%" PRIx64
> > > #else
> > > typedef uintptr_t ram_addr_t;
> > > #  define RAM_ADDR_MAX UINTPTR_MAX
> > > #  define RAM_ADDR_FMT "%" PRIxPTR
> > > #endif
> > > 
> > > I don't know how we supported 32bit host emulating anything larger, but
> > > logically it's doable, then IIUC uintptr_t won't be enough allocating
> > > anything >4G?
> > 
> > ram_addr_t != hwaddr or vaddr -- it's just an internal token.
> > 
> > So a 32-bit machine could put 1G of ram (identified by ram_addr_t) at 8G
> > (hwaddr) just fine.  But obviously it couldn't put 8G of ram anywhere. 
> > :-)

Yep, I should have described it as allocating >4G in total, rather in one
shot.  So it's about the address space we can allocate that is limited..

> > 
> > That said, Xen was weird in that it used to be possible to have an i386
> > qemu command-line talking to a x86_64 dom0 kernel controlling x86_64
> > guests.
> > 
> > So, yeah, now we should drop this ram_addr_t distinction and always use
> > uint64_t.
> 
> 🩷🩷🩷 lovely 🩷🩷🩷

I can throw a patch, just to double check one last thing: we don't support
any form of 32bit hosts anymore, am I right?

-- 
Peter Xu


