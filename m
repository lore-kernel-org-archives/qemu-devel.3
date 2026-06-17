Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3790CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 07:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZkTk-0003yU-V4; Wed, 17 Jun 2026 03:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZkTh-0003q3-O0
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 03:14:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZkTf-00065W-Ge
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 03:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781680462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=71q6KxJm7hdqKX1rCp8551OxVrnmXe7EMGMBojwHVCk=;
 b=ZtVLLy0/kqlWmVdDvFmBRTF3os1u/k8XugOphSWj0bQKsgSFg8ZJVrfu7G6tuqqwqBJeIk
 IWPxMRpoeUebHCtmlKeSGgfHbwvG1wjW61mMR+4+g1GgNkUPnH0e3/xHL/ZGbeWqLQnTAn
 SFyw0fa9UxrXezXhiUs3zpYqfIUPRUY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-DdLg2ywrMEClExuJGpmgpA-1; Wed, 17 Jun 2026 03:14:20 -0400
X-MC-Unique: DdLg2ywrMEClExuJGpmgpA-1
X-Mimecast-MFC-AGG-ID: DdLg2ywrMEClExuJGpmgpA_1781680459
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490d3f03883so45068185e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 00:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781680459; x=1782285259; darn=nongnu.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=71q6KxJm7hdqKX1rCp8551OxVrnmXe7EMGMBojwHVCk=;
 b=c4w/aAksNesYnPcaLvL4bu9u1BU3psQnF8w+slyO0lcNUM1ZS13ZvECv1OZrbDviRO
 sLMrZwwHiu5U/wBonjlkvkR1gggGQxMCI43wQR55ucZ4U5FR2fiX3xmSASa8AdTUWmwe
 WSf9ADkdOx8k4XMD6njQJfWFmNBrLeAupca5/7vg0rVuDTCDJ0bRVmMLnHjCyU0W1mNh
 nScZlKezYHbHizdZgSLqMDxGq6R548XLRf5pAXQKTqe6HslR8toFgYzPjvrHFllQYJEJ
 vYKCveXsZux/7YboXYmcm20MEl/5Z1eXzW8WrAhk+CMyEkeJxM3hlQAJhMvlyXS+Bcdy
 Lj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781680459; x=1782285259;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=71q6KxJm7hdqKX1rCp8551OxVrnmXe7EMGMBojwHVCk=;
 b=eCdGCpzTRJBrRPvMxQSyMy0lTDdoUbi8mKEu9AlZRnAYeRtLsNsNAKEKA6Ax2c51as
 YoFjb1As4YXEyjKVxYrNRd+B9oywyewDixdyD1XupkTcUwlAolQOpODjD7SzGSdq/fsF
 QrnIFgW6nnYLQ5XF8n0MxxwP13NyGOC8taAYCRyE+JfzZ0VBG/S8huy2KiTmFfMcyb/L
 SM0kdGNtTPL5Eg8n2VrO1ua31mnLZ+00csHLRMCn67cvV4lsApMVYC8yIulaLeTSxgFk
 XK47k19ROqw5fHLxAXqMWPOYQWrRoP3LQqq/zIx0fEbKJlfHdSwToErsgGYakLACCTPT
 /HtQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kvgIhpm5lt4Zdobzu1j6VCtdm0Rp4dIpStFBvRfb4uJeL/arLAOe7pbSLEvtD2nxJrWFAtASzzasj@nongnu.org
X-Gm-Message-State: AOJu0YwkSBYe0BG01n/uUPDFvzfCyzxDjT1oYGXqtMN6vcCpGdCCrS2s
 E/I4eMvQ5Iimh2qTs2lQC25J1HCiilGOcf4xSBCYV8FiwlRXx9GuOOb+gguNrmTtUSVRkkf1xYA
 5JfO2AWiyvS7HUb93D1K/CgzGVXZS4NSdJKFwYhhhlFUkuqNb5pbKyUtE
X-Gm-Gg: Acq92OEiSUWI45QksJqRYo/rU/OFp6o+irJn1gSfXYanglXxpXh71gnlkDqnEzfAoJ4
 UVNri/ZnfugJz1kj/69ZWR7GloUS+J/yfGqVEn0B6vSeQjEX6bf5GuaaK3Aw6WePasdK8mJ8OQR
 Nx+scgSG4ANWTWkGBi+PwcMhccBr0aEO/cYx4hEHqbaFkPzCWccUhkYYdLO6J7EaR7yGZBZlsWx
 AFp9tUFVC1xcQKyJfnAFZFS1VmvSKSEfPPLA+iwYsxeuBDU+mkik0kThdUrXA5JSGvZwdJxI2ZA
 NnqTHLqdHokbJdKgBEy2kIMrgOXXEqAbJ7cNuhW3AQLtCw3QEBfX03m/aJqtcmp4RpTE0Mo5WkK
 tfRLluALkFpTHdG00OYJ91JYxxggIkuQE
X-Received: by 2002:a05:600c:8286:b0:492:3316:4b34 with SMTP id
 5b1f17b1804b1-492333ba2b6mr44038335e9.2.1781680458741; 
 Wed, 17 Jun 2026 00:14:18 -0700 (PDT)
X-Received: by 2002:a05:600c:8286:b0:492:3316:4b34 with SMTP id
 5b1f17b1804b1-492333ba2b6mr44037405e9.2.1781680458090; 
 Wed, 17 Jun 2026 00:14:18 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a458f2sm129336145e9.3.2026.06.17.00.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 00:14:17 -0700 (PDT)
Date: Wed, 17 Jun 2026 03:14:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com,
 alex@shazbot.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org, berrange@redhat.com,
 philmd@oss.qualcomm.com, philmd@mailo.com, david@kernel.org,
 clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn,
 dinghui@sangfor.com.cn, shan.gavin@gmail.com
Subject: list of memory/memcpy access issues
Message-ID: <20260617022330-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is a top post attempting to summarize some findings related to
emulating DMA and MMIO existing in QEMU memory core
using memcpy/memmove.

Hopefully, this will help inform discussion about multiple
changes currently proposed for QEMU.

At a high level, and in a variety of configurations, QEMU gets
DMA requests from a virtual device, or MMIO requests from
a VCPU, and wants to execute them either on guest ram or
passhtrough device memory.

Down the road this almost always (virtio ring implementation seems to be
a notable exception) translates to memcpy/memmove calls
(glibc e.g. on x86 currently implements memcpy through memmove).

However, memcpy's signature is:
       void *memcpy(void *dest, const void *src, size_t n);
note how neither src not more importantly dest are volatile.
Thus it was never designed either for a concurrent access
by another CPU, or for accessing devices.
(Mis)using it for that gives good performance but has issues,
some of which I am trying to enumerate below.

In the below I say memcpy but same applies to memmove just as well.



------------------




1. On x86, memcpy is different from __builtin_memcpy if
one uses old 1.0 force-headers from 2019. Thus, QEMU
sometimes uses __builtin sometimes it does not, inconsitently.
Likely no longer relevant and should be cleaned up.


2. variable length memcpy can translate 2,4,8 byte guest access
into multiple byte accesses. doing this for mmio is
guaranteed to break devices.


3. (theoretical concern) also on x86, unaligned accesses are possible on guest and host,
so converting an unaligned access to a series of aligned ones can
in theory break devices.

4. also on x86, vector instructions for large (>16 byte) writes
into pgprot_noncached memory are safe and faster than multiple 8 byte
ones.

5. also on x86 it so happens that if you write a fixed-size memcpy this
gets optimized to a single store/load and it works for aligned and
unaligned addresses on that architecture. How to ensure this keeps being
correct is left as an excerise for the reader. But qemu already relies
on this and did for years.

6. on non-x86 both unaligned accesses and vector instructions
for accessing  UC memory are illegal.

7. standard vfio gives KVM VM_ALLOW_ANY_UNCACHED, so even on non x86
guest can
map the memory as as pgprot_noncached/ioremap or pgprot_writecombine/ioremap_uc.
If it does the second then it can use unaligned or vector for access.
This is why normal passthrough tends to work - it never traps to qemu at
all.


But for qemu, vfio uses  pgprot_noncached unconditionally so qemu
can't use unaligned or vector instructions on non-x86.


8. But for nvgrace RAM, vfio has a driver that uses pgprot_writecombine/ioremap_uc.
so qemu could safely use unaligned/vector instructioons even on non-x86.

9. Except sadly, vfio currently does not tell qemu how it maps
the memory, so qemu can not know what is safe on non-x86.

10. on x86 memcpy will sometimes do multiple overlapping stores when
size is not a power of 2. for example, a 15 byte write is done with
2 8-byte stores. This is theoretically an issue
if guest does something super clever with ordering,
but does not seem to be in practice.

11. on non-x86 memcpy will do multiple overlapping stores even
for single byte writes. E.g. it does it to avoid extra branches.
This is causing issues in practice.

12. PCI writes are in order, last byte is written last.
memmove especially writes last byte first sometimes.
Violating that theoretically can break guests.

13. but if we are copying between 2 addresses that are overlapping,
the standard trick (used by memmove) is to compare dst and src and copy
backwards if dst < src, so last byte is written first.

-------------



Some conclusions:

A. on x86, we must avoid converting 2,4,8 byte accesses into byte accesses.
At least for aligned, perferably for unaligned accesses too.
Fixed width memcpy seems to work for this. Whether we should bother with
__builtin to work around broken old fortify headers, I donnu.
I do not have any answer how to check that compiler does this correctly.
If anyone is motivated enough, adding a GCC builtin could be possible.
Given qemu did this for years, I think we can leave solving this for
another day.

B. Also on many architectures, memcpy is much faster for large transfers
than iterating over 8 byte chunks in C.
When we can get away with doing that (e.g. for emulated devices where
we know the concurrency rules, writing into guest RAM), we should.

C. on non-x86, we currently must not memcpy into host devices
since we do not know if it is pgprot_noncached. yes, performance will be
bad for DMA into device RAM.




D.  It goes without saying that casting an unaligned address to unint32_t
(be it for qatomic_set or whatever) is undefined behaviour in C
and so a bad idea on any architecture.


E. also for non-x86, we really should teach vfio to tell qemu whether
it maps device pgprot_noncached or pgprot_writecombine.
we will then be able to do things like use vector ops
(through memcpy or not) for >8 accesses.

F. Arbitrary device passthrough with drivers doing unalined accesses and
when working cross architectures basically is a best effort thing.  It
can't be 100% perfect for all devices.


--------------------

Links:


example of a fix for a bug caused by memcpy to overlapping addresses:
4a73aee881 - "softmmu: Use memmove in flatview_write_continue"
https://lore.kernel.org/qemu-devel/20230131030155.18932-1-akihiko.odaki@daynix.com


example of a bug caused by memcpy as result of DMA:
https://lore.kernel.org/qemu-devel/20260527091711.3901-1-liugang24219@sangfor.com.cn

an attempt to fix bugs caused by memcpy to device memory in response to
MMIO:
4a2e242bbb "memory: Don't use memcpy for ram_device regions"
https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg08129.html

-- 
MST


