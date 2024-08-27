Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CC2C5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 18:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj183-0008Cq-F4; Tue, 27 Aug 2024 14:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sj181-00089t-OD
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 14:41:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sj17z-0006hr-B1
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 14:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724784073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wn9djoDD9/eWgp2BXZAnJXDeErD3h/q8b0IDShHzQd0=;
 b=YA/uDniQvpEOsdrsIXrr5BqWDLDy32NXQwwKZQmM1HnPthNm7j7E3u1g5I/nlXjioRVt4+
 aQHS4sIYcPrw1S+J94ikPduGIeyiw09WygAWfKlTy0dhIfLZnf59e1ldI3WDvJBbI65/GM
 sQxK1/ISR2PtLywoLWqbDhCG+anqKwI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-PCaeJ9AOMBKiDUVHxfP7Pg-1; Tue, 27 Aug 2024 14:41:12 -0400
X-MC-Unique: PCaeJ9AOMBKiDUVHxfP7Pg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7a1dad7654dso784887585a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 11:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724784071; x=1725388871;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wn9djoDD9/eWgp2BXZAnJXDeErD3h/q8b0IDShHzQd0=;
 b=TiocirfdQyKHFBMPUHQA89dOFaKT/37yedARJ+hyDhUPU/dnjOUdrTrZz4eRznnUwN
 Du0fUnnUKTotb46mPZFNwo3+WGhEWL8K2azN69mhXsntBTqRzb/qiRfF5d93KvSpx5du
 PaPIGNv1lzmGNgs0zXe7RBuO5ByauXe5kE1+hoJBe9yRnXeAMp1/RYeaoz82TBbqNXBY
 eCRX4Jf+TKWPqJ3U0FZgcH6qn10VBLB4mm2A7boR3qIPbQbZbrVsD9xwGQuRpglylp02
 h6VWelMMhhmSXAgEl7JLa2hcv37ZZG2enExwT4wAIohmi5MLVj3cK5iPRdtsMnEm/+gu
 iIXw==
X-Gm-Message-State: AOJu0Yy/SSUhDOlfHOsxQbIe04zKWMJ5BMXMQ5tsgWe6roZrMv3wbiuC
 Xih3l3HoyzfY+0AXdRA54zGm3RJioYc1bop/7yKc2wo0ysd/soM3GPqAaCYq4E9c29yKhd81T1Q
 4f+YLMEYWtFcBH507/dqNaDL2Ouf7CgSM/Awkn6mgUVozyJ35Kc/2
X-Received: by 2002:a05:620a:468f:b0:7a2:32e:3c47 with SMTP id
 af79cd13be357-7a68971867bmr1265933785a.34.1724784071567; 
 Tue, 27 Aug 2024 11:41:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC/QRPOFjf9iNSIVLpKKtiV2AWWpUaonw+2KIhF9fcdvRRLUzWuJccaJKYpcp9ntt6jflSmw==
X-Received: by 2002:a05:620a:468f:b0:7a2:32e:3c47 with SMTP id
 af79cd13be357-7a68971867bmr1265932185a.34.1724784071207; 
 Tue, 27 Aug 2024 11:41:11 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f3fd278sm574298785a.110.2024.08.27.11.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 11:41:08 -0700 (PDT)
Date: Tue, 27 Aug 2024 14:41:06 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v1] softmmu/physmem: fix memory leak in
 dirty_memory_extend()
Message-ID: <Zs4dwmYdZ8wmu8WE@x1n>
References: <20240827083715.257768-1-david@redhat.com> <Zs4TcHvfwhBFSWvQ@x1n>
 <03dfba8f-19b3-4ff4-9de7-9211c2a26f56@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03dfba8f-19b3-4ff4-9de7-9211c2a26f56@redhat.com>
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Aug 27, 2024 at 08:00:07PM +0200, David Hildenbrand wrote:
> On 27.08.24 19:57, Peter Xu wrote:
> > On Tue, Aug 27, 2024 at 10:37:15AM +0200, David Hildenbrand wrote:
> > >   /* Called with ram_list.mutex held */
> > > -static void dirty_memory_extend(ram_addr_t old_ram_size,
> > > -                                ram_addr_t new_ram_size)
> > > +static void dirty_memory_extend(ram_addr_t new_ram_size)
> > >   {
> > > -    ram_addr_t old_num_blocks = DIV_ROUND_UP(old_ram_size,
> > > -                                             DIRTY_MEMORY_BLOCK_SIZE);
> > >       ram_addr_t new_num_blocks = DIV_ROUND_UP(new_ram_size,
> > >                                                DIRTY_MEMORY_BLOCK_SIZE);
> > >       int i;
> > > -    /* Only need to extend if block count increased */
> > > -    if (new_num_blocks <= old_num_blocks) {
> > > -        return;
> > > -    }
> > 
> > One nitpick here: IMHO we could move the n_blocks cache in ram_list
> > instead, then we keep the check here and avoid caching it three times with
> > the same value.
> 
> yes, as written in the patch description: "We'll store the number of blocks
> along with the actual pointer to keep it simple."
> 
> It's cleaner to me to store it along the RCU-freed data structure that has
> this size.

Yep, I can get that.

I think one reason I had my current preference is to avoid things like:

  for (...) {
    if (...)
       return;
  }

I'd at least want to sanity check before "return" to make sure all three
bitmap chunks are having the same size.  It gave me the feeling that we
could process "blocks[]" differently but we actually couldn't - In our case
it has the ram_list mutex when update, so it must be guaranteed.  However
due to the same reason, I see it cleaner to just keep the counter there
too.

No strong feelings, though.

-- 
Peter Xu


