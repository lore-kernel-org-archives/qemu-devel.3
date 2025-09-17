Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1510CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 13:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyrsV-0001jh-2G; Wed, 17 Sep 2025 09:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uyrom-00053R-Pe
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 09:03:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uyrol-0005we-4J
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 09:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758114195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o0OFplTQWizPetRjTZMgOxEbv1WufdVL1LhjWNq7w6s=;
 b=G7prdQ/1XMGW1hoXYZQa6OuB2V7Q+pO/pTTCPVY56oh7LtG/VqtIE4MRh7gQ4JWBPQC/GV
 enbfhV9F6z67HhZ4SOFfn6mqUdMYXsVdhuwp2GLKEMmVFDphZ3AozKbouECxQPJjfKLiCr
 YwVwymBMDez3c5HycT1AsizeKif92lg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-2Fs-sGe0MbG4ZTr6Rqgi0A-1; Wed, 17 Sep 2025 09:01:15 -0400
X-MC-Unique: 2Fs-sGe0MbG4ZTr6Rqgi0A-1
X-Mimecast-MFC-AGG-ID: 2Fs-sGe0MbG4ZTr6Rqgi0A_1758114073
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3eb8215978aso2557245f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 06:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758114073; x=1758718873;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o0OFplTQWizPetRjTZMgOxEbv1WufdVL1LhjWNq7w6s=;
 b=Kk2/Tfg27qwO6/Pu7zTFf+O7KWBWQ1nUIhJZ12MyyuDb/fAm6XVUcWGbJSeWQgQvhj
 es7GkRZARsX6eM/mjxogHzwITGfXOdsYhl5LyHVbOtiGiJittPVQhVkYAKITrz1INk7W
 kkRiTKuK6QMvK0prI86+WaKzIVCPog+6DxPy64+pDv14614QPl1JYTGNXfd3AhU82w0n
 kUgWP5xSYI0cPSGTiksdyKpSa2yqubZ4MojqcjiJmph7YWJnYsxTRdIqXndufjD+wvAL
 RQjY3mbFuyo/CQQCu6zrtueyW28skMChiP0QvcJ0a8Wee8N9j3Ht2awLUxHuKhOf2+Pw
 jmug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIoTd9OHLpvL9bOl0w6RvYxiIo8oAwjNi3jOuL2G0GrbsDrsM6s6kGhuzuq3VaQbtT5S9lw8ZrMzIv@nongnu.org
X-Gm-Message-State: AOJu0YxKNGcbCfShGdCURolPXtHrUhyaTIlC3oliAa1CBK7DjCsibspD
 16H9OVIjUBRpt9Vr4vN5jt73PiBOL8jkOI78cjljKZVEo19P0D8laRYmNE8eLK75inNKJaXW52I
 uocPDuw96XNmIzVHY+lNyT+c3ZEQK8VOu2NZKtSH1LqdgPtpX+A3Y7s8C
X-Gm-Gg: ASbGnct99gMa84NgiSRhMfH57XrCqIMscHbODyNQRHFzxW46OxlONrAFV8tjhuIUdO4
 t+QdBWxnVEG2/1yzzNuWFA0OXMvs/EfjQAjQkk0j9Z1EbBPHfr/hGXfW5ou097ns8kTZRmRplW3
 8e+BKoY5mMs4gpiD9Xiiq5i6aivENQsUqCogtq8hcZ4Gkk0tOyRT36GUhZXf9qucLfb1joCo4qf
 FPniWZlXHtjV3yRQkQ4dx8P3b6PTt9Q15MpNG40eqdRTxedDEPbbQ3hVXdmVHg1ruU7Lua9L++D
 +bHid/Rbhdx/H7TFnIYBcRIE4kJxMkRenO899IlWJSPdV8KXm3cHtGSO4pZza0Z15hsV7pJc9mG
 rlHj8CInhANhurrazJ7WuFWCMkAAqR8dIUiz/DhVrA2JhOZuvTL3ObCetBwzuPLVohQRQ
X-Received: by 2002:a05:6000:26d2:b0:3df:b9e7:359f with SMTP id
 ffacd0b85a97d-3ecdfa16a23mr1790003f8f.35.1758114072893; 
 Wed, 17 Sep 2025 06:01:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBOI7hlxfn74Qx+yJrZCb0vrh8HQnbKL7+dDSCC4Vwl5DmfGUqaw3apBxnyUXaT4/R+bP8+A==
X-Received: by 2002:a05:6000:26d2:b0:3df:b9e7:359f with SMTP id
 ffacd0b85a97d-3ecdfa16a23mr1789848f8f.35.1758114070849; 
 Wed, 17 Sep 2025 06:01:10 -0700 (PDT)
Received: from ?IPV6:2003:cf:d721:7588:1cf1:5127:fd96:3013?
 (p200300cfd72175881cf15127fd963013.dip0.t-ipconnect.de.
 [2003:cf:d721:7588:1cf1:5127:fd96:3013])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ecdf0bbf24sm2802576f8f.63.2025.09.17.06.01.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 06:01:09 -0700 (PDT)
Message-ID: <ef822991-5af9-4ac7-9bcd-15f521579f8f@redhat.com>
Date: Wed, 17 Sep 2025 15:01:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] export/fuse: Safe termination for FUSE-uring
To: Brian Song <hibriansong@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bernd@bsbernd.com, fam@euphon.net, kwolf@redhat.com
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-4-hibriansong@gmail.com>
 <20250909193358.GE218449@fedora>
 <CAKWCU7VFbJius06j1pXvP_5aSpmhmaJq6Z41H4efWFmeMjr4OQ@mail.gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CAKWCU7VFbJius06j1pXvP_5aSpmhmaJq6Z41H4efWFmeMjr4OQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 15.09.25 07:43, Brian Song wrote:
> Hi Hanna,

Hi Brian!

(Thanks for your heads-up!)

> Stefan raised the above issue and proposed a preliminary solution: keep
> closing the file descriptor in the delete section, but perform
> umount separately for FUSE uring and traditional FUSE in the shutdown
> and delete sections respectively. This approach avoids the race
> condition on the file descriptor.
>
> In the case of FUSE uring, umount must be performed in the shutdown
> section. The reason is that the kernel currently lacks an interface to
> explicitly cancel submitted SQEs. Performing umount forces the kernel to
> flush all pending SQEs and return their CQEs. Without this step, CQEs
> may arrive after the export has already been deleted, and invoking the
> CQE handler at that point would dereference freed memory and trigger a
> segmentation fault.

The commit message says that incrementing the BB reference would be 
enough to solve the problem (i.e. deleting is delayed until all requests 
are done).  Why isn’t it?

> I’m curious about traditional FUSE: is it strictly necessary to perform
> umount in the delete section, or could it also be done in shutdown?

Looking into libfuse, fuse_session_unmount() (in fuse_kern_unmount()) 
closes the FUSE FD.  I can imagine that might result in the potential 
problems Stefan described.

> Additionally, what is the correct ordering between close(fd) and
> umount, does one need to precede the other?

fuse_kern_unmount() closes the (queue 0) FD first before actually 
unmounting, with a comment: “Need to close file descriptor, otherwise 
synchronous umount would recurse into filesystem, and deadlock.”

Given that, I assume the FDs should all be closed before unmounting.

(Though to be fair, before looking into it now, I don’t think I’ve ever 
given it much thought…)

Hanna

> Thanks,
> Brian
>
> On 9/9/25 3:33 PM, Stefan Hajnoczi wrote:
>   > On Fri, Aug 29, 2025 at 10:50:24PM -0400, Brian Song wrote:
>   >> @@ -901,24 +941,15 @@ static void fuse_export_shutdown(BlockExport
> *blk_exp)
>   >>            */
>   >>           g_hash_table_remove(exports, exp->mountpoint);
>   >>       }
>   >> -}
>   >> -
>   >> -static void fuse_export_delete(BlockExport *blk_exp)
>   >> -{
>   >> -    FuseExport *exp = container_of(blk_exp, FuseExport, common);
>   >>
>   >> -    for (int i = 0; i < exp->num_queues; i++) {
>   >> +    for (size_t i = 0; i < exp->num_queues; i++) {
>   >>           FuseQueue *q = &exp->queues[i];
>   >>
>   >>           /* Queue 0's FD belongs to the FUSE session */
>   >>           if (i > 0 && q->fuse_fd >= 0) {
>   >>               close(q->fuse_fd);
>   >
>   > This changes the behavior of the non-io_uring code. Now all fuse fds and
>   > fuse_session are closed while requests are potentially still being
>   > processed.
>   >
>   > There is a race condition: if an IOThread is processing a request here
>   > then it may invoke a system call on q->fuse_fd just after it has been
>   > closed but not set to -1. If another thread has also opened a new file
>   > then the fd could be reused, resulting in an accidental write(2) to the
>   > new file. I'm not sure whether there is a way to trigger this in
>   > practice, but it looks like a problem waiting to happen.
>   >
>   > Simply setting q->fuse_fd to -1 here doesn't fix the race. It would be
>   > necessary to stop processing fuse_fd in the thread before closing it
>   > here or to schedule a BH in each thread so that fuse_fd can be closed
>   > in the thread that uses the fd.
>


