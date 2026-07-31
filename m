Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0B3C5516D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 14:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpoE7-0000l3-3t; Fri, 31 Jul 2026 10:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wpoE5-0000jk-Ke
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 10:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wpoE3-0003uE-QK
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 10:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785508118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bOD6ghEHQdWYeaoJ5HXYO+zFF81EUWhpjh7Hh97/9ss=;
 b=JxPo42qpCxgFtuoFRNA9GLvC8SUES526QVotz9NHCxEBfpVcr5nxDlzMYYHSlr042uKwgj
 5XWxEcSKBmCbsQ5m9L1lef/6fMze/2yyTAN4NpFuEXwlXFyNQxC6dVuCugaRGPEnZ0ApFI
 Km4yan2+D2MPc2lZyIqY88YRHk56awY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-Fwiecyt6P8a1S6dopfbBHQ-1; Fri, 31 Jul 2026 10:28:37 -0400
X-MC-Unique: Fwiecyt6P8a1S6dopfbBHQ-1
X-Mimecast-MFC-AGG-ID: Fwiecyt6P8a1S6dopfbBHQ_1785508116
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ec3314f65fso10843236d6.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 07:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785508116; x=1786112916; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bOD6ghEHQdWYeaoJ5HXYO+zFF81EUWhpjh7Hh97/9ss=;
 b=S751tzTDj94a72fHs1gqj51iB/9rq1Y6BxAE6smgr2tCIRpscycCDmsvR1ieBJEh3h
 Ri7Q06/miBMOmwN5rb+UfegKZNV08zXNTZ5PQtiOzmovVgygsHtX7Z+2cxmrfP2xFc7Z
 3QK6hQ8Ozb43tPUfjeN7M8Kv9hshaUEtdOtimlMffgSPbxFsU4kR+hbcSqgnqOJuH9dM
 l9Okj8Y4xA0dLr0Ft80ZEIrIrlqcvq+btFCnmI++jUKl9+T0ErQJRyCdyFpai/CDjcIp
 /rbdtfi+aNCo3SYryD8jm4qELgg6LpJQX1RU8cqahTPWsjzPGjUGL+3GdQ4RAIwB7JYg
 mNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785508116; x=1786112916;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bOD6ghEHQdWYeaoJ5HXYO+zFF81EUWhpjh7Hh97/9ss=;
 b=VXp9DD045fOhCAjXWY3d7lKqAHwkpZ1bPjZEAUq2ZAZCVyeZ9BkPTVpUNZZ0oZyVGv
 NjpdJ/zm0H0DJ6A88RDFa6JLIPN1xnDxAQH+9a/ae3pStrr64EyZFuIEGjzUeaYqoG3l
 xcTMm76gSN0TbNj4i8HCQD2XfY3yQPtC4eMcNlCmZZCBJ7JmOAKQxW22qxuIQxjKRcum
 UAdpMnGk1wp1vrFdUiC5Y9GiFirthG+MwG4v+6Nv946NRN6CJpOsVfZYRPwgD83T1PlF
 4NT5nssSPh8vJ9yRqVz78F425T8mQm5sKr2+bGqmUhXIcB+A43Wh9AOHdpTY4bfkZzrt
 K8Zw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq3bT96qR7OBBC40B3OG8BP9GQnMyVBKxIy1+Q3SlXBBqnUg+1i9W4pyId8L2wWCa7qLI7D8LrnW3gy@nongnu.org
X-Gm-Message-State: AOJu0YxR++QWuVl8QMvrvvKMW6Tb6O6g+8Hh078DZP7lZGTMRGpj5wfd
 87icWv6je61qvQ71XCH6MRjuMtmZW/nbD9h+1Fujt3Kbc1pfcXYYk/i17AC1fq1WP+PucSRqLmx
 7tPcbeUPy2zkuJzoS5TcsUmXOBvRqQ+wT53yS4QunwgGIiTG2MA/hne1Q
X-Gm-Gg: AR+sD12VZOwSxtuDgX/vjJ9c5USdJNxYETVbD1pDVqmaO7zAtUy6oYuTEpziWhGsneD
 3a5SIb2s5u2br2KyOMFoqlB9qykufgd60R7qdG6bun6TE2Wc+FAyGxkYxUE4CWkmpl+6E702gfl
 cTRUTTq3Y3aHJ4g8IQ5hFRZlTEk9zGwnNORQgQbYP7pnAcY0jIQ61uEzA7L4yydlkoK4/ujaOrz
 PQ36NIxH09p39o7OqxK4JEd1KqFt4Zt1hW/hRuq9kVzoio5ZwD497Y6RygO0vSE9arn/PRZkAxk
 kjbL4HmAdyOpxx7IYdz062iAHm07h6w7Hw/MgESK5XYWDl0VqJ9IS454oEKFktID160ikC/Y
X-Received: by 2002:ad4:5c86:0:b0:8ec:235c:7a66 with SMTP id
 6a1803df08f44-908421d1ec4mr44466666d6.27.1785508116171; 
 Fri, 31 Jul 2026 07:28:36 -0700 (PDT)
X-Received: by 2002:ad4:5c86:0:b0:8ec:235c:7a66 with SMTP id
 6a1803df08f44-908421d1ec4mr44466076d6.27.1785508115522; 
 Fri, 31 Jul 2026 07:28:35 -0700 (PDT)
Received: from x1.local ([2605:8d80:6c28:a264:ecff:d5b4:39f6:3dd5])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908432a0ce5sm11393316d6.1.2026.07.31.07.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 07:28:35 -0700 (PDT)
Date: Fri, 31 Jul 2026 10:28:30 -0400
From: Peter Xu <peterx@redhat.com>
To: "Zhang, GuoQing (Sam)" <guoqzhan@amd.com>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 qemu-devel@nongnu.org, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com, Emily.Deng@amd.com, Victor.Zhao@amd.com,
 PengJu.Zhou@amd.com, Qing.Ma@amd.com
Subject: Re: [PATCH v4] migration/rdma: add x-rdma-chunk-size parameter
Message-ID: <amyxDj42371qOyjX@x1.local>
References: <20260330064758.2816891-1-guoqing.zhang@amd.com>
 <ampSFcrRagKtf5y_@x1.local>
 <b454973f-275f-4f75-8367-8b6230d42bbf@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b454973f-275f-4f75-8367-8b6230d42bbf@amd.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

On Fri, Jul 31, 2026 at 07:15:56PM +0800, Zhang, GuoQing (Sam) wrote:
> 
> 
> Hi Peter,

Sam,

> 
> Sorry for late reply. I just got the time and machine to look into this.
> 
> For current upstream code, qemu_rdma_write() len is always
> TARGET_PAGE_SIZE (4KB), which is far less than the 1MB chunk size.
> The mergeable check bounds current_length within a single chunk, so
> current_length can never reach rdma_merge_max(). You're right that
> it's dead code in this case.
> 
> I did experiment with len being 2MB and chunk size being 1MB, where
> the condition does trigger: mergeable fails, current_length resets
> to 0, then += 2MB, hitting rdma_merge_max() (2 * 1MB = 2MB). But
> even in that case, removing this flush caused no issue, since the
> buffer gets flushed on the next qemu_rdma_write() call when
> mergeable fails anyway or on rdma_registration_stop() at the end.

Thanks for double checking this.

While going through RDMA code I do see a bunch of leftover things maybe
used for older versions of QEMU but seems redundant for new QEMU.

Some other example, like qemu_rdma_write_one() has support for
block->is_ram_block==false, but I don't know what's that for, might be
relevant to qemu_rdma_save_page() with this comment:

 * Parameters:
 *    @offset == 0 :
 *        This means that 'block_offset' is a full virtual address that does not
 *        belong to a RAMBlock of the virtual machine and instead
 *        represents a private malloc'd memory area that the caller wishes to
 *        transfer.
 *
 *    @offset != 0 :
 *        Offset is an offset to be added to block_offset and used
 *        to also lookup the corresponding RAMBlock.

So I had a feeling that old rdma code was designed to be able to even
migrate some malloc() chunks, when offset==0, even if I don't know anything
using it.. Meanwhile, it seems also be wrong saying that it's malloc()ed
chunk if offset==0: IIUC pc.ram (or whatever 1st ramblock we allocate) has
ramblock->offset==0 too normally... I'm not sure if it'll be recognized as
a malloc()ed region then in RDMA migration code.

Maybe I can check them up and touch some of those up while looking at some
tickets, I'll see.  I think I have some better understanding of the whole
soft RoCE now, so maybe I can try. If you're actively using RDMA (which I
had that impression..) and if you want to look into this, that'll be nice
too.

Thanks,

-- 
Peter Xu


