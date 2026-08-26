Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8A3C61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzFg2-0000kk-6v; Wed, 26 Aug 2026 11:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wzFg1-0000kZ-Fh
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 11:36:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wzFfx-0006Oq-KG
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 11:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787758585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bz9JL44ic2wdq27So47YnE9BwkJfP5p86bmPHFuuuL0=;
 b=VHcGj9c7dNy1lysx5e331/QUutn5DgyUDVrQBGUVtUNAtcEnQY6ukBbxFfJGlWXR0mJiX5
 BtHa9bNn/JHRbqLMrYVhqExzJhTyAUwDsHt6imLg5JxFDZPsfC9ZsQ44VSoSr4NYnF5kmA
 kKAmy/h1WIg//vy1GEeeOywysQBUxvw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-sJg-j6_sN3K_1EiutrtTGQ-1; Wed, 26 Aug 2026 11:36:24 -0400
X-MC-Unique: sJg-j6_sN3K_1EiutrtTGQ-1
X-Mimecast-MFC-AGG-ID: sJg-j6_sN3K_1EiutrtTGQ_1787758583
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e538afe65so127858985a.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 08:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787758583; x=1788363383; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bz9JL44ic2wdq27So47YnE9BwkJfP5p86bmPHFuuuL0=;
 b=de+n/oI0ZVLpH8v9QhczKwdayc2jE4vpCpTlZav/8GGKI0y2cWojS4hczWk6GXaurO
 DMrRutGw6Ni5u0qqU4gxgbpf4mzhYwnwAVICd7fJosthFOnLxYvUVZbRzZGDYyOSqP7M
 VWf10eGDifGdxgglTuIpBRAgRxKTt2phQVM1dan1R1tULuiE4+eOVqjfs5NNyVyets75
 EX/sBTicphw445XfQK7+iCVV0BElN6M6nH8TgOTwu3OjP/PD6F5WaepBvkmXYITH8x3u
 h575qCMGKP7FsAk9NLWfYoePqeP9I5sp39utiOKgKek3Xf1lvjH02VpYa81Y9zeKPT8G
 4OmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787758583; x=1788363383;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bz9JL44ic2wdq27So47YnE9BwkJfP5p86bmPHFuuuL0=;
 b=pQU/3PXtuYQG4FI0sYseh0dhn+4qGf9IBF1ZOun4uMUiCWwhHeYxGL71yfFMi2CwjZ
 vxRB6iSQ2FbVUk4wXXBRztLqfQuaNymq6gh7svRCysn0VwiqNM2FnwNLuoHBqMVjhl1x
 fbBAmofc3Y1RPG7xgtHNf5ZF+S4ehTVGfQMUT4Kee9zjQHVpBEegNf95G+tICzsBCceg
 KczzGIJHz6eaz2x8LZiDrq0TFXLd4KPwEsihkwEn0pV/Ac6zPVSjByp/obG5CKBIaiuj
 uDJTReOz9VyLm41laFXSLwOrmDomy/HIrNdm+RzOD9SPdn8c4g44oRWWx0IkBJCmWC9O
 z+1Q==
X-Gm-Message-State: AFuF++nujoPsG/r8jNmiiK/ZvbVv4X93KpOMxyy8ckPKIeUKCT3s2UL0
 DffDKZY0aBFAIMQgiMbW22DIByzu39rWZvIpjtYlY4iI0RVXLDHHSwC9YQVLEgWsoMY+zn0jtyQ
 9HIjXtIQ/vrF2uLMmW4soLtSSKI98NK7Oa5Wlha7qeO8IeMJW1DmoqpKvHp0qkn9z
X-Gm-Gg: AR+sD13x8X/ii/Frjh72Z97G6+xfT96p8134GMTePx9vgFMHyrn3VCUeYHEBjCUD1mt
 mn+nlrFRXMoSGZPMIWNAac10b6EzUy/aYVfI2MpYDZANhtjUwGUsdOukD8CgDE3J5AvRIzs30us
 1NXR8AMYpi3UJu57Z4Euzx84bOe9Tw+xPR3j2TMcXsX30d2TUjUJ4us6mrVcdQXl/V0QQpu2HOW
 IIZtZCYIDKHJ8P83f/+loLlWxueOaXsTcp2gmxP1raZ7eOmSVKScMBHWxTCAlT69QNhS68wsBCd
 VIsZdW9t889CatZmCUn88CcSNr02nS2IizaOEa3WAjmLFDA1j91KZ/E62xbHVSHiZ32C
X-Received: by 2002:a05:620a:8ac9:b0:92e:76a1:96cd with SMTP id
 af79cd13be357-93780165715mr548764185a.13.1787758583384; 
 Wed, 26 Aug 2026 08:36:23 -0700 (PDT)
X-Received: by 2002:a05:620a:8ac9:b0:92e:76a1:96cd with SMTP id
 af79cd13be357-93780165715mr548753885a.13.1787758582684; 
 Wed, 26 Aug 2026 08:36:22 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9377e36955bsm240037885a.19.2026.08.26.08.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 08:36:21 -0700 (PDT)
Date: Wed, 26 Aug 2026 11:36:10 -0400
From: Peter Xu <peterx@redhat.com>
To: hongmianquan <hongmianquan@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, caixiangfeng@bytedance.com,
 yanfei.xu@bytedance.com
Subject: Re: [RFC v1] migration/postcopy: fix page_requested leak for
 vhost-user shared pages
Message-ID: <ao8H6njSMggANOxV@x1.local>
References: <20260824122655.63646-2-hongmianquan@bytedance.com>
 <aoyYdZj2kEStUTOO@x1.local>
 <aa4c9982-9a9c-38d4-f6e1-481a086df8ad@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa4c9982-9a9c-38d4-f6e1-481a086df8ad@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 26, 2026 at 11:18:28PM +0800, hongmianquan wrote:
> On 2026/8/25 03:16, Peter Xu wrote:
> > On Mon, Aug 24, 2026 at 08:26:56PM +0800, hongmianquan wrote:
> >> With postcopy-preempt enabled, a postcopy migration of a guest with a
> >> vhost-user device can hang at the very end on the destination, after all
> >> pages are transferred (query-migrate: status=postcopy-active, remaining=0).
> >>
> >> Root cause is an add/del key mismatch on mis->page_requested:
> >>
> >> - add: a backend fault goes through postcopy_request_shared_page() ->
> >>    postcopy_request_page() -> migrate_send_rp_req_pages(), which inserts
> >>    the request and bumps page_requested_count keyed by client_addr.
> >> - del: qemu_ufd_copy_ioctl() removes the entry and drops the counter
> >>    keyed by this QEMU process's host address for the page.
> >>
> >> client_addr is a VA in the external vhost-user backend's address space and
> >> never equals QEMU's host address, so the removal misses and the counter
> >> leaks. postcopy_ram_incoming_cleanup() then waits for it to reach zero
> >> forever, which also stalls the source (it waits for the return path).
> >>
> >> Racing threads:
> >>    dst: postcopy_ram_listen_thread -> postcopy_ram_incoming_cleanup ->
> >>         qemu_cond_wait_impl              (waits for page_requested_count==0)
> >>         (postcopy_preempt_thread already placed/woke the pages)
> >>    src: migration_thread -> migration_completion ->
> >>         await_return_path_close_on_source -> qemu_thread_join
> >>         (source_return_path_thread blocked in recvmsg)
> >>
> >> The leak is only triggered when the vhost-user backend faults on a page
> >> that has not been received yet: only then does the request take the
> >> shared-fault slow path and register an entry in page_requested. If that
> >> page is subsequently delivered while the request is still outstanding,
> >> its entry is never removed. (Pages already present when the backend
> >> faults just take the wake path and never register.) So a run may leak
> >> only a few entries (9 of ~244k requests in our repro) yet still hang.
> >>
> >> Fix: key the request with the same host address the removal uses
> >> (rb->host + aligned_rbo) instead of client_addr. The backend wake still
> >> happens at placement time via postcopy_wake_shared().
> >>
> >> Signed-off-by: hongmianquan <hongmianquan@bytedance.com>
> >> ---
> >>   migration/postcopy-ram.c | 15 ++++++++++++++-
> >>   1 file changed, 14 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> >> index a3314d3180..98268b3c55 100644
> >> --- a/migration/postcopy-ram.c
> >> +++ b/migration/postcopy-ram.c
> >> @@ -992,7 +992,20 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
> >>           return postcopy_wake_shared(pcfd, client_addr, rb);
> >>       }
> >>       /* TODO: support blocktime tracking */
> >> -    postcopy_request_page(mis, rb, aligned_rbo, client_addr, 0);
> >> +
> >> +    /*
> >> +     * The page will be placed by qemu_ufd_copy_ioctl(), which removes the
> >> +     * matching entry from mis->page_requested (and drops
> >> +     * page_requested_count) using this QEMU process's host address for the
> >> +     * page. Register the request with the same key, rb->host + aligned_rbo,
> >> +     * not client_addr: client_addr is a VA in the external vhost-user
> >> +     * backend's address space and can never equal that host address, so the
> >> +     * removal would miss forever, leaking page_requested_count and hanging
> >> +     * postcopy teardown.
> >> +     */
> >> +    postcopy_request_page(mis, rb, aligned_rbo,
> >> +                          (uint64_t)(uintptr_t)qemu_ram_get_host_addr(rb) +
> >> +                          aligned_rbo, 0);
> >>       return 0;
> >>   }
> > 
> > True.. this should have been overlooked, thanks for fixing it.
> > 
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > 
> > I haven't been looking at vhost-user path for years, now looking at it
> > again, I do have this feeling that this ->handler() API is a bit awkward
> > and too heavy: what we need is a translation of an HVA -> (rb, rb_offset),
> > then processing it the same as when the fault was generated from QEMU
> > process.  The vhost-user / client code might be more straightforward with a
> > ->translate_hva().
> > 
> > I'm not sure if you agree with that idea, or would like to work on such a
> > cleanup, but if you're a serious vhost-user postcopy user (we don't have a
> > lot on the list..), feel free to take this if this sounds beneficial.
> > 
> > Thanks,
> > 
> Thanks for the review.
> 
> Just to make sure I got the cleanup right: replace the PostCopyFD
> ->handler() callback with a lighter ->translate_hva() that only maps the
> client fault address to (RAMBlock, rb_offset), and let the shared fault
> thread call postcopy_request_shared_page() directly after the translation —
> i.e. the same path a fault raised by the QEMU process takes. Is that 
> what you have in mind?
> We do run vhost-user postcopy, so I'm happy to take this and send the 
> cleanup as a follow-up.

I believe we can drop postcopy_request_shared_page() too. With the help of
->translate_hva() for the vhost-user process address space, the fault
thread, postcopy_ram_fault_thread(), should be the solo place to request a
fault, and it should always be with the QEMU's HVA attached to the request.

That's one major reason that could be a good idea: what has been overlooked
before and fixed by this patch should be unified together in the fault
thread, then it's less error prone.

Thanks,

-- 
Peter Xu


