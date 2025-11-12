Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D858CD4853
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 22:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJJV6-0003eU-Nh; Wed, 12 Nov 2025 17:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJJUv-0003T5-RO
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 17:39:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJJUt-0003z2-HS
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 17:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762987165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B//TevpXXjhWRyszXurqsZaSm2zfABSTuptxJ0Wv53g=;
 b=aniiR2YkEvYyBOLeCM3QqGGHOHGu5sczp5zRm3AGkSVhuOXU/UEGcnkPwszVRIrGTz3e6m
 dcU1QnXbcUnb78LF2MlfJxng7fuzuK2qOSnRG/f7UgtiU/iWFOu3YUFwuBzbDWRDQSrFtK
 a63KgC19nQzQgvyv30piBJUNK4r+eHY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-uNbqh7JwM32xdiBwK0DWuQ-1; Wed, 12 Nov 2025 17:39:23 -0500
X-MC-Unique: uNbqh7JwM32xdiBwK0DWuQ-1
X-Mimecast-MFC-AGG-ID: uNbqh7JwM32xdiBwK0DWuQ_1762987163
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-882380beb27so6362556d6.3
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 14:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762987163; x=1763591963; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=B//TevpXXjhWRyszXurqsZaSm2zfABSTuptxJ0Wv53g=;
 b=fYKeDb0XirENWBuy2SWrRiXL0u3sRSJrkWskYY6nQpw0OgvegadWDZVwonK9aOMOpj
 qiOAWnEZ5H7HOX0OSAVExZhs8wrVy5rk3qz4P5Ke8YvkHccMBbm3QdSQvvK28w+oHATS
 V2ifxKVRpGUoZs5czJFbxUbX5tB8yGHFz+66DUODiz0kb3Zotz7GfBsKZhHossXQGqVb
 LJieJ7b/gRGeU9aQv5x04PIULRkAvgjcEHTF8X94yuKMvmD6vGGoJKhpJ5Idmi9n/c39
 ZYc2fHXJFX1Ov4aFhKe0e2eUcunmOtIySQoln2gejt+te+vuZ2HuaTx7mqQGu3TrJoZm
 C6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762987163; x=1763591963;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B//TevpXXjhWRyszXurqsZaSm2zfABSTuptxJ0Wv53g=;
 b=EszTPc7/eQSC0X+wZV2TMiQ+uRpmdML5rU6hVpKoioVrn0Nt1tSXAb4ifzPt0QwL2O
 FgGm9nOwPhcixoo0O0gzPmnJiLO+moha8iI9ys7s8H/lQEFO4BwfxSYhhznax1+YcUio
 gyZwswDWL0xJFq3Lz7C0hnBht5HVnjumAWR7Pbzobr2F1YxzHSclgJ1ZpKPhmjrF232A
 L1tYBF2HhQ9KoJ8rVFCIybmaj5TpQWpjlbA4m5KIeUIhouqayfoUNAm0y84IOX35GYGa
 VbseqLg84SjwZqtLUd8SKPZKBEelJj6TDIwVgx7hBPdQBV2QqtYvgVqrH16eD7e6eRJn
 aPAQ==
X-Gm-Message-State: AOJu0YxSfpD2abIbDxXHEbNWw/xnxe/CF5mLZKee2WEBj1v8Hu3gJhe9
 RVwybXVou0+0kikj6JpmkaIty6MBptZwrYlFWPO4g3rZ/AscvZHHgKcvXXixyym5jlBLDIgiOrK
 VzXtzOii90vCeJQuGrbdAj5QinB0PxKYymRkfExBOAXFGd88IW36DCst8
X-Gm-Gg: ASbGncszF++Rs0q1bfg99Lz4X/gJjM/WLPr54wCoK3lBYjG6HN4KBA7haaXDM8fuhyX
 l9zgybb4xbtbl2pzURQl6psjhfxtgnOFgk10BjH8COpXTxj17e5iDVBk0OB4nLf3XRb20yTEKk+
 Km9RlTyqtWzE1SR7dAzyBB8DtXaaptRWi8ukTI4x798UMMKMpsST0qFKctA1BGlYpRXKGYaJRGJ
 YcGzp9Y5v/rEVf8VUZkhDFMbZeFhE2+oDq4sgxMehRG22uRa0J89VcqpNp9F2MX/09zu1z2yR7J
 qwTOxUgwYlWZDcWpuGdTLXsu/NQBsBnx0Pu/XJ3kvLi9MP4H4HKhjhUr95MtlOBXpIc=
X-Received: by 2002:a05:6214:212a:b0:880:4789:8fa3 with SMTP id
 6a1803df08f44-88271946688mr78748606d6.30.1762987163166; 
 Wed, 12 Nov 2025 14:39:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsicMjG4FFIc4/iQEwniixgjxtm/6y6Tg6nc2jhNpN6w4O8BIcXNlCpeCa5buaBQMBNheKyA==
X-Received: by 2002:a05:6214:212a:b0:880:4789:8fa3 with SMTP id
 6a1803df08f44-88271946688mr78748236d6.30.1762987162606; 
 Wed, 12 Nov 2025 14:39:22 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8828655f8f2sm507316d6.41.2025.11.12.14.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 14:39:21 -0800 (PST)
Date: Wed, 12 Nov 2025 17:39:19 -0500
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] memory: Make FlatView root references weak
Message-ID: <aRUMl0pOXwrMUsKT@x1.local>
References: <aQE_M1qsr78RrQaw@x1.local>
 <376f8d41-6ffb-4e1b-b50b-93a0f307d017@rsg.ci.i.u-tokyo.ac.jp>
 <aQIxA8MzkSO7qm4Z@x1.local>
 <13cb4e7e-1949-4dc6-b5d6-a976f6f280e4@rsg.ci.i.u-tokyo.ac.jp>
 <aQuuhSL6rXmyqm8x@x1.local>
 <f1e40576-67ef-41e7-8131-6a022c9d5fc4@rsg.ci.i.u-tokyo.ac.jp>
 <aQzf4F6RgkzYWkeM@x1.local>
 <6d9caf51-df32-4c83-9b62-1c99dfea2e50@rsg.ci.i.u-tokyo.ac.jp>
 <aQ4g_UsDhTBYiQSZ@x1.local>
 <e7cb25c1-d43d-4729-8b43-6adcc343149b@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7cb25c1-d43d-4729-8b43-6adcc343149b@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Nov 08, 2025 at 11:07:46AM +0900, Akihiko Odaki wrote:
> On 2025/11/08 1:40, Peter Xu wrote:
> > On Fri, Nov 07, 2025 at 11:16:56AM +0900, Akihiko Odaki wrote:
> > > On 2025/11/07 2:50, Peter Xu wrote:
> > > > On Thu, Nov 06, 2025 at 11:23:32AM +0900, Akihiko Odaki wrote:
> > > > > Generally speaking, we will not necessarily "always" get an issue report
> > > > > when things went wrong with memory management. A bug in memory management
> > > > > may not cause an immediate crash but corrupt the memory state which you will
> > > > > find only later. The end result of memory corruption may look random and
> > > > > result in a hard-to-debug issue report. A user may not even bother writing
> > > > > an issue report at all; this is especially true for this kind of corner
> > > > > cases that rarely happen.
> > > > > 
> > > > > There should have been no such a hazard of memory corruption if the code did
> > > > > exactly what the documentation said in the first place. The consistency of
> > > > > the code and the documentation is essential, especially for this kind of
> > > > > complex and fundamental code.
> > > > 
> > > > Do you have encountered such case before?
> > > > 
> > > > I wasn't expecting that, because what you were saying looks more like what
> > > > Linux kernel would have a bug in mm.  QEMU is still special as it has the
> > > > default unassigned MR trapping everything by default, meanwhile normally
> > > > what is moving is MMIO / alias regions rather than real ramblocks.  It
> > > > means when things go wrong we have much higher chance to trap them
> > > > properly.
> > > 
> > > When I said "memory management" I meant the methods we use to allocate and
> > > free memory (the Linux equivalents would be kmalloc()/free()/kref), not the
> > > MM tracking or unassigned MR trapping behavior you mentioned. The unassigned
> > > MR trap and MMIO/alias movement are a separate concern and don’t change the
> > > underlying risk.
> > > 
> > > Concrete example: imagine an alias is allocated with g_new() and freed
> > > immediately after object_unparent(). If that alias accidentally becomes the
> > > FlatView root, destroying the FlatView later will call memory_region_unref()
> > > and produce a use-after-free. We cannot predict what memory_region_unref()
> > > will read or write in that scenario — the result can be arbitrary memory
> > > corruption that surfaces much later as a hard-to-debug, intermittent
> > > problem. Users often won’t file an issue for these rare corner cases.
> > 
> > OK I see what you meant now.  Yes it's a valid concern.
> > 
> > > 
> > > > 
> > > > I also confess though that I'm pretty conservative on fixing things with
> > > > hypothetical issues.  In general, I prefer fixing things with explicit
> > > > problems, so we know how to measure and justify a fix (depending on how
> > > > aggressive the fix is and how much maintanence burden it will bring to
> > > > QEMU).  Without a real problem, it's harder to quantify that even if such
> > > > evaluation will also normally be subjective too.
> > > 
> > > Regarding your preference to fix only explicit problems: I understand the
> > > conservatism, but here are the facts we need to weigh:
> > > 
> > > - The documentation claims we may free aliases because
> > >    memory_region_ref() is never called, yet there is code that does call
> > >    memory_region_ref().
> > > - The patch adds code to align behavior with the documentation.
> > > 
> > > The significance of both potential impacts (the behavioral divergence for
> > > devices other than pci-bridge, and the added complexity needed for
> > > consistency) may be subjective and hypothetical, but that applies equally to
> > > both sides.
> > > 
> > > In this case, the long-term reliability and maintainability of QEMU depend
> > > on having the code behave as documented. Correctness should take precedence
> > > over simplicity.
> > 
> > Fair enough.
> > 
> > Let's then still try to see whether we can brainstorm something that can
> > still at least avoid the "let's clear a remote pointer in a finalize(),
> > because it looks safe" approach.. I'm not sure if I'm the only one that
> > feels nervous with it.
> > 
> > Fundamentally, if you can remotely clear a pointer, it means it's not used
> > at all. In practise, that's correct because as I also discussed before I
> > don't think RCU readers use flatview->root at all.  It was almost only
> > because we have some very light references on flatview->root.  The major
> > "hidden" reference is actually the key in flat_views hash, however I don't
> > think it will have any stale root MR VA as key, as long as after a proper
> > commit() completes.
> 
> "As long as after a proper commit() completes" is what we are trying to
> avoid. Think of the following sequence:
> 
> memory_region_transaction_begin()
> object_unparent(mr)
> g_free(mr)
> mr = g_new0(MemoryRegion, 1) // reuse the storage for another MR
> address_space_init(as, mr, "as")
> memory_region_transaction_commit()
> 
> address_space_init() will use the value keyed with the dangling pointer in
> flat_views.

I agree with your analysis, however I don't think such use case exists in
practise..

I added below and qemu's qtests run all smooth:

 void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
 {
+    assert(memory_region_transaction_depth == 0 &&
+           memory_region_update_pending == false);
     memory_region_ref(root);
     as->root = root;
     as->current_map = NULL;

We can either keep the assertion (until it'll trigger any time, but I doubt
it..), or we can also solve this by other ways, I can think of two right
now:

  (1) Make sure address_space_init() skips the last two steps to update
      topology and ioeventfds if memory_region_transaction_depth>0.

  (2) Introduce one more field for MemoryRegion, which is to allocate a
      globally unique KEY for the flat_views hash, only needed if the MR
      can be root candidates.

(2) will need more work, as we may need to have some way to make sure the
allocator will not generate duplicate KEYs (hence u64 counter may not be
ideal, as it may provide duplicates when wraps over u64.. even though I
also don't know if people will hit it at all..).

So I wonder if we can just keep the solution (0) above, which is to assert
it.

> 
> Removing a dangling reference is safer than leaving it. Some code that
> assumes the reference will not be gone may get surprised and cause a NULL
> dereference, but that almost always result in SIGSEGV instead of memory
> corruptions. Such segfault is as easy to debug as SIGABRT triggered by
> assertions.

Yes it'll be easier to debug indeed.  However IMHO this is still a bad plan
to wait for it whenever overlooked.  It'll still be a disaster if a
customer crashed on the NULL pointer reference somewhere, so IMHO we should
avoid the first crash from design.

I confess I also added some assertions above.  However since we don't have
a huge lot of object_unparent(mr) use cases, we can walk all of them and
make sure the assertion will never happen.  IMHO it's still slightly better
than remote pointer resets.

I also wonder if you have good ideas on above, hence a better solution than
proposal (0,1,2) to avoid what you raised as problems.

Thanks,

-- 
Peter Xu


