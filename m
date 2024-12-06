Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4A3E77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 16:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJbPM-0001Lw-5F; Fri, 06 Dec 2024 11:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJbPL-0001Ln-5D
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:42:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJbPI-0001kY-7A
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733503337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J1Cht0/tTBxm7iVczRft/M32JM+fHb+OseXbHUxmC3o=;
 b=h83oIcJ1Edl5QNhOsThYzuUFPDozihVkIaTWpncEbktgi2X5vSCDxY/lm2cCK7HqguWEpj
 tid8cmBiKMnEZujlGRRv/Kzb6/nq3ge3Fpf24GUC3LMSUsA3MEOD5NBPnlzipI0LyAOX5o
 civCIfL3sCAaul3pG/4edtoURjGIwwM=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-AMMd13UBNT25C2ZIgr7GEw-1; Fri, 06 Dec 2024 11:42:15 -0500
X-MC-Unique: AMMd13UBNT25C2ZIgr7GEw-1
X-Mimecast-MFC-AGG-ID: AMMd13UBNT25C2ZIgr7GEw
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-84386a9b7e2so385772339f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 08:42:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733503335; x=1734108135;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J1Cht0/tTBxm7iVczRft/M32JM+fHb+OseXbHUxmC3o=;
 b=lw0+T3GI4EITu5h1LGaUECdkVcDaH0TwuyMXmftC/o7GokgI7A9FLdojct9PQlAxE5
 dpi0QCFH0Bc2mMvZ24bokbxzswKjCBhmXAcbpt0NCWbsTzMQvJoaLByJqH6zrizK7w9B
 iq1MhKu1cDdScENb6JwUpFWpvzya8R18pYd0yUiI0rFSU5nPYkODvqD0RCenQwoKQ3FA
 sC5hAqmCy/LUKLNurqgnQy+R2/Qrx9LsmLsDHRcWoNUaHTmgcBlC4sz3vJvJp9hX0t7u
 bbJws9wEL2hxvFwAP9LAU09UllROaNUdqw8FHpomsmXpsHS8tmKDXJtMON0OMFgS+YMM
 wMIA==
X-Gm-Message-State: AOJu0YwjhrYMgFVqCOwLMAzOr33cCZbrWci89dANWURVu2RvS56VVYbz
 fE2V8/HzpskxpcIglpLJrQsZWS9HDUKbDmjT8+zCm7QLNn3ERFM+GgKKP0ywITwWl1kUctMtClW
 FatT0vPtZ+feB0f2p1HWZDHFc67awFcMH9w7XEvUmdzTLG1vGdX5L
X-Gm-Gg: ASbGncsqqgLkpnxL7P4DZz/MT5Hj2CM+bZlmtnTvc29IPmEA8DLhTbVa0fIZDjQIP5m
 fNhGkmerFvsvwhHMnR2H5FSeaSRCXlowJNfAO9w1pbw6IQq+XNu84tV9deiZiWsRqMFYVxioMRK
 4+/L10pUB6vI1TyMccswgtA32eFYxvTX8vKAcUg9I9yGLKW4XxkTdKjNxa+heczIa7+Ak2Ay+zn
 uqoucdkZuUOlcAUCZwPSjNRHYJdDMD7+wr0G8O64m8vY+vMvDxmxuZmV+zDX4aYxCjDU7UZh9zF
 J1gL8FhGpb4=
X-Received: by 2002:a92:c26f:0:b0:3a7:e83c:2d08 with SMTP id
 e9e14a558f8ab-3a811e391c2mr39137545ab.22.1733503335121; 
 Fri, 06 Dec 2024 08:42:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEA1veSt1hj5jWesg1FicO9h0najvji2fzJys8SQPsRRajyEdmF8NAe7QSsmAqqJF+WPas1JQ==
X-Received: by 2002:a92:c26f:0:b0:3a7:e83c:2d08 with SMTP id
 e9e14a558f8ab-3a811e391c2mr39137425ab.22.1733503334831; 
 Fri, 06 Dec 2024 08:42:14 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e28611e13fsm881504173.59.2024.12.06.08.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 08:42:14 -0800 (PST)
Date: Fri, 6 Dec 2024 11:42:11 -0500
From: Peter Xu <peterx@redhat.com>
To: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH 2/5] system/memory: support unaligned access
Message-ID: <Z1MpY7ZIAAoBDbZU@x1n>
References: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
 <20241108032952.56692-3-tomoyuki.hirose@igel.co.jp>
 <Z04lW_CdYBPJRah3@x1n>
 <2de74447-00f7-4bcf-81f3-c8461ec19a67@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2de74447-00f7-4bcf-81f3-c8461ec19a67@igel.co.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Fri, Dec 06, 2024 at 05:31:33PM +0900, Tomoyuki HIROSE wrote:
> In this email, I explain what this patch set will resolve and an
> overview of this patch set. I will respond to your specific code
> review comments in a separate email.

Yes, that's OK.

> 
> On 2024/12/03 6:23, Peter Xu wrote:
> > On Fri, Nov 08, 2024 at 12:29:46PM +0900, Tomoyuki HIROSE wrote:
> > > The previous code ignored 'impl.unaligned' and handled unaligned
> > > accesses as is. But this implementation could not emulate specific
> > > registers of some devices that allow unaligned access such as xHCI
> > > Host Controller Capability Registers.
> > I have some comment that can be naive, please bare with me..
> > 
> > Firstly, could you provide an example in the commit message, of what would
> > start working after this patch?
> Sorry, I'll describe what will start working in the next version of
> this patch set. I'll also provide an example here.  After applying
> this patch set, a read(addr=0x2, size=2) in the xHCI Host Controller
> Capability Registers region will work correctly. For example, the read
> result will return 0x0110 (version 1.1.0). Previously, a
> read(addr=0x2, size=2) in the Capability Register region would return
> 0, which is incorrect. According to the xHCI specification, the
> Capability Register region does not prohibit accesses of any size or
> unaligned accesses.

Thanks for the context, Tomoyuki.

I assume it's about xhci_cap_ops then.  If you agree we can also mention
xhci_cap_ops when dscribing it, so readers can easily reference the MR
attributes from the code alongside with understanding the use case.

Does it mean that it could also work if xhci_cap_ops.impl.min_access_size
can be changed to 2 (together with additional xhci_cap_read/write support)?

Note that I'm not saying it must do so even if it would work for xHCI, but
if the memory API change is only for one device, then it can still be
discussed about which option would be better on changing the device or the
core.

Meanwhile, if there's more use cases on the impl.unaligned, it'll be nice
to share together when describing the issue.  That will be very persuasive
input that a generic solution is needed.

> > IIUC things like read(addr=0x2, size=8) should already working before but
> > it'll be cut into 4 times read() over 2 bytes for unaligned=false, am I
> > right?
> Yes, I also think so. I think the operation read(addr=0x2, size=8) in
> a MemoryRegion with impl.unaligned==false should be split into
> multiple aligned read() operations. The access size should depends on
> the region's 'impl.max_access_size' and 'impl.min_access_size'
> . Actually, the comments in 'include/exec/memory.h' seem to confirm
> this behavior:
> 
> ```
>     /* If true, unaligned accesses are supported.  Otherwise all accesses
>      * are converted to (possibly multiple) naturally aligned accesses.
>      */
>     bool unaligned;
> ```
> 
> MemoryRegionOps struct in the MemoryRegion has two members, 'valid'
> and 'impl' . I think 'valid' determines the behavior of the
> MemoryRegion exposed to the guest, and 'impl' determines the behavior
> of the MemoryRegion exposed to the QEMU memory region manager.
> 
> Consider the situation where we have a MemoryRegion with the following
> parameters:
> 
> ```
> MemoryRegion mr = (MemoryRegion){
>     //...
>     .ops = (MemoryRegionOps){
>         //...
>     .read = ops_read_function;
>     .write = ops_write_function;
>     .valid.min_access_size = 4;
>     .valid.max_access_size = 4;
>     .valid.unaligned = true;
>     .impl.min_access_size = 2;
>     .impl.max_access_size = 2;
>     .impl.unaligned = false;
>     };
> };
> ```
> 
> With this MemoryRegion 'mr', the guest can read(addr=0x1, size=4)
> because 'valid.unaligned' is true.  But 'impl.unaligned' is false, so
> 'mr.ops->read()' function does not support addr=0x1, which is
> unaligned. In this situation, we need to convert the unaligned access
> to multiple aligned accesses, such as:
> 
> - mr.ops->read(addr=0x0, size=2)
> - mr.ops->read(addr=0x2, size=2)
> - mr.ops->read(addr=0x4, size=2)
> 
> After that, we should return a result of read(addr=0x1, size=4) from
> above mr.ops->read() results, I think.

Yes.  I agree with your analysis and understanding.

Thanks,

-- 
Peter Xu


