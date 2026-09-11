Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15861C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x501O-0008Jd-LP; Fri, 11 Sep 2026 08:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x501L-0008JQ-5s
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 08:06:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x501I-0008SL-9n
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 08:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789128374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fkpoIMDXilwSDe2xGVECqGKcWqClJSZ4cg5wV+urSk0=;
 b=P4TLfGQNrX5rCJGK8GmiOxWJceC0nnTfKzOxPQjZ9yd+jJqrBp09GKpu+Ww/wxy84hH+XR
 cABPhAk+YUPhycBbaHI/kl+b4B0FktTqPEUn/ySlwjiS4dwFI/f0n4wewAlqs7rcJqVDkE
 TrFi1/MeE+cevliD1MIPLVn8MpsSimQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-hhDgWFzQOROSDqmV4bxbuQ-1; Fri, 11 Sep 2026 08:06:13 -0400
X-MC-Unique: hhDgWFzQOROSDqmV4bxbuQ-1
X-Mimecast-MFC-AGG-ID: hhDgWFzQOROSDqmV4bxbuQ_1789128372
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9396e0515dcso65367885a.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 05:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789128372; x=1789733172; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fkpoIMDXilwSDe2xGVECqGKcWqClJSZ4cg5wV+urSk0=;
 b=jZ613hWJR8Fbr8qUBOlX7LZVNxTZ5/5erHHBED57pH5Wpm5yVoQR//hpjmQJmlRIpR
 NVQSFkKZ9LSitlaetWfr+E1zBQWzTtGNYEHajhPF5dkIyT/mJawmRxu/cdSiRtpX8QkZ
 EpBPpQoD+uMvDQ9YTF7qnMcqw124HjJF7QkKN4pB5zHGdhN/vLGeUlGyC2r47pmBCQ7W
 2OSuqATLZMmMqe/bcoT85Ks+PyKyFzLDVULcKzsqGyjbSaxe5ShGnEkoMl2LoiN0vf8P
 ktGNct3IiW16AvBuBnBKh4oLkJVFU/6CvI+nHUMhzjwi8SXwfRI2orDHmvB9WTRhzGY6
 Fhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789128372; x=1789733172;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fkpoIMDXilwSDe2xGVECqGKcWqClJSZ4cg5wV+urSk0=;
 b=OqDSbh3c2TcoPVEq26WjAtQrJy6uAx60uKTq1scSkuOwWBZszjtfIxGtqi7DgGrtYN
 Y2XbFahe4j3/JQR5DGXUmLqFLiHrzFav5X9jawK2aj4Yu61aXkFCWbSN+/hxoQoyiE/b
 xl6xUR6FxKsTbYYtlPf0Am9vzcMKNJPcnhh5DwxiAjd0u80+6KBus8/jq03/PUPSMI2i
 y2BBL5U5T1YIqtOrtPm54LTfM1wCHH2QwAInwBNFvt11ot6cvQOr9skFTSKXApNhc24r
 m4725QyOHLUDJyuakWmU+XTzpx3Pev4gGHo27LXiPslwb9I5SCG8+kB43uSU6HCens6o
 wL1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzBoruuM4yg55NcnuWySdmJRlrK6Dau9TEdrnXHScmNFeMNGwmHezhCwHncNnXqwOpC4NEoGEqRWSOD@nongnu.org
X-Gm-Message-State: AFuF++lfmEoSXhU29/Z8xGWMDUbW2uWwLtH3xInTMhVpRuiXfHG2Idma
 v8tgjRKHE4bZPbCQ1r82m8D3y54VRlXzNOlwMe8rRTXR2E94f4PnWuwhE8num86G9x7rIr4UJVj
 yGV9s+18uWscZMuUBo9P/+qLudf4QOUTVftlnqP6zxDUVzfKIFjgf6kus
X-Gm-Gg: AYBFou2L4JFr56Rkw8Iub2T7ZBqy9ndihj3r4cJDc9YK9oSJzAC00yaxA78owh4BXJA
 HPxf/RuPi6mTLBc858majKeuPK+Wd+QgTta0FcFSRWqFyBJ9MtCj1LikLGI4NWt6tYzZ1fU8OMD
 Oo6suBktXQ6QR7g99tpQ98/OV4IMPp98e7zICNydUj6c7EY86aM+9D3Ya/nBIoVYF1B9sQUygqW
 d7mXmjDu065HcoXLRr6//Tbwt1k/QPc/5+ey0KoBDaGZ69owqRakzagFPRxSUKGiZfAwunzrl5g
 htqpnC6brAlvM1oORIZa8KmRv1z/DB37Y9zcDjkagzOx9WRiFYKHm/0uyhbbb1mUToipu2pqaUC
 HOA5FG9xJISsGg7SevqA0Z9YiOCBfHmbd+pDAXfaAUIjZrq+I/0qLJ5uMVpk=
X-Received: by 2002:a05:620a:31a9:b0:939:4bfa:7fa3 with SMTP id
 af79cd13be357-939ea0e6e5amr463769785a.5.1789128372428; 
 Fri, 11 Sep 2026 05:06:12 -0700 (PDT)
X-Received: by 2002:a05:620a:31a9:b0:939:4bfa:7fa3 with SMTP id
 af79cd13be357-939ea0e6e5amr463761785a.5.1789128371753; 
 Fri, 11 Sep 2026 05:06:11 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939e80e4c36sm226435785a.40.2026.09.11.05.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 05:06:09 -0700 (PDT)
Date: Fri, 11 Sep 2026 08:06:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: David Hildenbrand <david@kernel.org>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 pankaj.gupta@amd.com, isaku.yamahata@intel.com,
 xiaoyao.li@intel.com, chao.p.peng@linux.intel.com,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v5 08/12] hostmem: Support fully shared guest memfd to
 back a VM
Message-ID: <aqPusIvLVQv9gmPP@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260908133151.836685-1-michael.roth@amd.com>
 <20260908133151.836685-9-michael.roth@amd.com>
 <eee90083-3962-4bf4-a7be-2e06e02e4e94@kernel.org>
 <g3iq3ku62byofbc4c7m5tzmpcpqrlb4ark7pwvg3fm2jvcbvhg@qi5nnpnulsuk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <g3iq3ku62byofbc4c7m5tzmpcpqrlb4ark7pwvg3fm2jvcbvhg@qi5nnpnulsuk>
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

On Thu, Sep 10, 2026 at 06:00:11PM -0500, Michael Roth wrote:
> On Thu, Sep 10, 2026 at 10:54:09AM +0200, David Hildenbrand wrote:
> > On 9/8/26 15:30, Michael Roth wrote:
> > > From: Peter Xu <peterx@redhat.com>
> > > 
> > > Host backends supports guest-memfd now by detecting whether it's a
> > > confidential VM.  There's no way to choose it yet from the memory level to
> > > use it fully shared.  If we use guest-memfd, it so far always implies we
> > > need two layers of memory backends, while the guest-memfd only provides the
> > > private set of pages.
> > > 
> > > This patch introduces a way so that QEMU can consume guest memfd as the
> > > only source of memory to back the object (aka, fully shared).
> > > 
> > > To use the fully shared guest-memfd, one can add a memfd object with:
> > > 
> > >   -object memory-backend-memfd,guest-memfd=on,share=on
> > > 
> > > Note that share=on is required with fully shared guest_memfd.
> > > 
> > > PS: there's a trivial touch-up on fd<0 check, because the stub to create
> > > guest-memfd may return negative but not -1.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > > ---
> > 
> > [...]
> > 
> > >  static bool
> > > @@ -47,11 +56,31 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
> > >          goto have_fd;
> > >      }
> > >  
> > > -    fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
> > > -                           m->hugetlb, m->hugetlbsize, m->seal ?
> > > -                           F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
> > > -                           errp);
> > > -    if (fd == -1) {
> > > +    if (m->guest_memfd) {
> > > +        /*
> > > +         * NOTE: guest-memfd ignores seal=on/off because it always
> > > +         * implicitly seals the FD by definition.
> > > +         */
> > > +        if (!backend->share) {
> > > +            error_setg(errp, "guest-memfd=on must be used with share=on");
> > > +            return false;
> > > +        } else if (m->hugetlb) {
> > > +            error_setg(errp, "guest-memfd=on doesn't support hugetlb=on yet");
> > 
> > There is a lot of uncertainty how guest_memfd would consume huge pages. So best
> > to drop the "yet" that implies how it would be consumed (and that it would be
> > called "hugetlb").
> 
> Makes sense, will change this as suggested for v6

I'm just curious, any more info on this part?  Any link to existing work
would help.

At least from our side, we look for hugetlb-alike support on gmem.  I want
to make sure what I understand still is valid, and it is still open to
solve the postcopy problem.

Thanks,

-- 
Peter Xu


