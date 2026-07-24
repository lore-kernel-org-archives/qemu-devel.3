Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35F6C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 13:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnGP2-0001A9-GW; Fri, 24 Jul 2026 09:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wnGOq-00017n-ON
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:57:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wnGOn-0003DF-HD
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784901432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1dQOBuMI9sXL4Mip3rFFIvGFdtw19KvQOKzFVyGg/DE=;
 b=PCbncmcWzwYvZzYnk35LrMDusbSvVdrnfWIummmL13LkLVGYAXefDYxrEnNLtEN/4fstlI
 CEyRkmQeUT8c4baBQ3T6jNYbfUcjtbsmEQ8zOQDng0jw1kszRvMWEcGpTSl62vvlVN7vwW
 a6c6ufmyKvwfEEc1na+mEKAS7ZdwWo0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-yrl9JPKfNXy707gX65ymEw-1; Fri, 24 Jul 2026 09:57:09 -0400
X-MC-Unique: yrl9JPKfNXy707gX65ymEw-1
X-Mimecast-MFC-AGG-ID: yrl9JPKfNXy707gX65ymEw_1784901428
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5aeb72bda2aso319822e87.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784901428; x=1785506228; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1dQOBuMI9sXL4Mip3rFFIvGFdtw19KvQOKzFVyGg/DE=;
 b=Zm2mlDf9yrHhEjSkYJmM4R5x2LMRp9cQLgnH9gkDeXaN4BMzgXktPuGNk9z/JOFiUE
 8TFyvJbHGkgR6oKP9Ecn5Ggl5zWdxaPEAnuGFsLNIGyVW0cWViHITWiSd8wumPhKhkda
 OSzCEpYOwTm89XrMZrpwXuDZS16zGPEpzYxfJPpWJQ96Jk1Unh0T/CEB3bcSsehXqZOp
 yZcHmNb8UvzqF7ltf5wSJi6TXWlr+fIJpjecsFi7WDf3RE9U2QQp4UBAlcJi+6J14Iyf
 el+7bFe51jRsQ7nevQxZYu76udPWIouikqC/HOdEiW/rraIg5kAZSas6if1qDZ6YhSy4
 GECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784901428; x=1785506228;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1dQOBuMI9sXL4Mip3rFFIvGFdtw19KvQOKzFVyGg/DE=;
 b=epuOfnUtz7gN0MA4OQ7sgh1go4Cb7T1TaK4LJXWDokLB66tDwvmbb8vcpxpOcnDTXu
 31jXeHyk0t9i11QhHO76XZ22Ar8lT+KaDrCr0lTzITQKT6fNQe0M4pNBkkpEte9n14oO
 4VLy5nvc7PP1eKK3+GD6GZ6MroTpUWm+ZHnqTxkr2/etODed2IJzEWOs/4Nuc6/In560
 6tq0/R8SapzhtwxeZL1z6ZNUSTzchz/PtJ9YzUnXTwUzbdqrQqhROi06IxzuTcpArfSX
 w3TT8hSaL3vfDC8DD2fjaSl7Wgq5n59VWEyovPYpXEq68PwkwVpE1znG8J2teH8paqE8
 ybHg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXxq+B6xWum9MviRaZM1Ef+X2JSEmhx9nBl3iYGEiQpaPDNwLMAm9JEhrhvHHHw2t44OoUb44577UC@nongnu.org
X-Gm-Message-State: AOJu0YzqxErmq25AiPFLmuqODS6J+BBYBiRanHUibG4jbTBO7C/j5vu0
 cfZWypgx8ST0mTqN+PqDnFX3OWURiX5Cw965FdFFiLIc2MG8JYkSb3yGXcoQiw/iFxXOAas5M3a
 BKjexda4ewXhRIxYlrFjO7V/8KmwxVew2qQsOzAtwq52IYGBueK0EhHIq
X-Gm-Gg: AR+sD12wzBxlDvwZw/bjX6ib17PAgtOF5X7FtWlEXQ+3LDCF8Xk70xa5MHbzDlJ/UcG
 wmTr4L7UhS7Q774/vSSCq8BHGOoiT4KxAsAHmC0HL9Md1XHOMVKGoZLI2arF9+2HfLH9APENS8Q
 snYWSn+w2A0LIbTsdNt9U7d3alFnhjrQ4/V6nunNob2138/epC/3uYoyMbhl9Txc98hsazYp0+I
 lRrSMP1C4Q8duJQSSQ5voR4OpuDe4r7FsQ/vJFRqjvQmCW9KIxtZRDSTyAVeUPsry8AHJMCxsnY
 6v+n6o9yeTennbpnZgHlAaG/3jFOmZTI8TJA5RhRbtSlsP2+oorDdLMKF+wdXKdbTQaf
X-Received: by 2002:a05:6512:23d8:b0:5b0:eda:de25 with SMTP id
 2adb3069b0e04-5b2b2e53023mr953351e87.6.1784901427577; 
 Fri, 24 Jul 2026 06:57:07 -0700 (PDT)
X-Received: by 2002:a05:6512:23d8:b0:5b0:eda:de25 with SMTP id
 2adb3069b0e04-5b2b2e53023mr953338e87.6.1784901427003; 
 Fri, 24 Jul 2026 06:57:07 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9f5361bsm1536264e87.84.2026.07.24.06.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 06:57:05 -0700 (PDT)
Date: Fri, 24 Jul 2026 09:56:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex@shazbot.org,
 richard.henderson@linaro.org, berrange@redhat.com, philmd@mailo.com,
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com,
 phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn,
 shan.gavin@gmail.com, qemu-s390x <qemu-s390x@nongnu.org>
Subject: Re: [PATCH v3 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
Message-ID: <amNvIMizFp7Au2c3@x1.local>
References: <59882c5b-545d-4768-8bf4-723fed97a801@redhat.com>
 <al-eCtxGjG4HHEbl@x1.local>
 <6210e178-a93f-4411-810a-41edb1fb656e@redhat.com>
 <20260722015422-mutt-send-email-mst@kernel.org>
 <amDyvgR09OJssENX@x1.local>
 <20260723015708-mutt-send-email-mst@kernel.org>
 <71d88d00-5b41-49d2-b649-8a6ea47abc4d@oss.qualcomm.com>
 <20260723045428-mutt-send-email-mst@kernel.org>
 <amIbUYN3teCLXTh-@x1.local>
 <b05b40b1-fffd-4be5-9289-b5bc92c16cd2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b05b40b1-fffd-4be5-9289-b5bc92c16cd2@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
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

On Fri, Jul 24, 2026 at 11:42:09AM +1000, Gavin Shan wrote:
> On 7/23/26 11:46 PM, Peter Xu wrote:
> > On Thu, Jul 23, 2026 at 05:05:08AM -0400, Michael S. Tsirkin wrote:
> > > On Thu, Jul 23, 2026 at 10:52:11AM +0200, Philippe Mathieu-Daudé wrote:
> > > > On 23/7/26 08:04, Michael S. Tsirkin wrote:
> > > > > On Wed, Jul 22, 2026 at 12:41:34PM -0400, Peter Xu wrote:
> > > > > > On Wed, Jul 22, 2026 at 01:58:18AM -0400, Michael S. Tsirkin wrote:
> > > > > > > On Wed, Jul 22, 2026 at 10:53:27AM +1000, Gavin Shan wrote:
> > > > > > > > On 7/22/26 2:27 AM, Peter Xu wrote:
> > > > > > > > > On Tue, Jul 21, 2026 at 03:37:53PM +1000, Gavin Shan wrote:
> > > > > > > > > > If Peter is fine with two variants for x86 and non-x86 architectures.
> > > > > > > > > > I can post (v4) for further review. That will be something like below
> > > > > > > > > > and let me know if there are any other improvements are needed.
> > > > > > > > > 
> > > > > > > > > I have a generic question on the "unaligned access for x86": I think the
> > > > > > > > > question is about the one Michael raised here on unaligned access may break
> > > > > > > > > x86 here:
> > > > > > > > > 
> > > > > > > > >      https://lore.kernel.org/qemu-devel/20260617022330-mutt-send-email-mst@kernel.org/
> > > > > > > > > 
> > > > > > > > >      3. (theoretical concern) also on x86, unaligned accesses are
> > > > > > > > >      possible on guest and host, so converting an unaligned access to a
> > > > > > > > >      series of aligned ones can in theory break devices.
> > > > > > > > > 
> > > > > > > > > Is that a real problem we need to consider, or can we start with unified
> > > > > > > > > approach and leave it for later?
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > I'm leaving this question to Michael.
> > > > > > > 
> > > > > > > Knowing what I know about hardware designers, it's something someone
> > > > > > > somewhere does)
> > > > > > > It can be made a separate patch, just to show - it should be all of
> > > > > > > ~10LOC.
> > > > > > 
> > > > > > It's only about removal of anything that might be controversial for now,
> > > > > > thanks.  I also wonder if anything would break, then it's more solid proof
> > > > > > that per-arch change is required.
> > > > > 
> > > > > Repeating:
> > > > > 	I think there is exactly 1 kinda reasonable case. A 2 byte read/write at
> > > > > 	offset 0x1 within a dword. This maps nicely to even classical PCI byte
> > > > > 	enable mechanism and so yes it works if your CPU can initiate these
> > > > > 	things, and it's atomic.
> > > > 
> > > > Isn't this out of the CPU arch, dealt with at the bus level?
> > > > 
> > > > It looks we try to be clever with modern PCI code by optimizing this
> > > > access -- not saying we can change that, I know it is too late after
> > > > 20+ years -- relying on hw behavior that was done that way to support
> > > > legacy hw, in particular broken I/O accesses.
> > > 
> > > Not sure what the question is.  We were dicussing how to emulate unaligned
> > > accesses from x86 guests if they happen.
> > > On an x86 host we can do that easily, and it's just a couple of LOC.
> > > Though Peter Maydell dislikes host arch specific code. But I hope
> > > if it's a separate patch on top and it is visible how small it is,
> > > he will reconsider)
> > 
> > Yes, if we still want x86 specific change, it would be better to be put
> > separately.
> > 
> > Said so, I don't think the e1000e LEDCTL test illustrated what might
> > break..  Isn't that only an exmaple showing unaligned access is
> > "supported", however nothing breaks even if we use 1B*2?
> > 
> > My question was more about a real breakage, hence whenever it happened
> > "it's more solid proof that per-arch change is required".
> > 
> > > On other hosts we can't emulate them 100%, we either need to split
> > > to byte accesses or over-access and mask. Byte accesses feel safer.
> > > What qemu currently does with memmove is clearly not safe in the
> > > general case.
> > 
> > We should have another option that is not arch-dependent but keep the
> > unaligned behavior.
> > 
> > For current master, AFAIU we do unaligned access for both ram_device and
> > rest. Say, even with ram_device_mem_ops, it has both .unaligned=true for
> > both .valid & .impl.  I think it means indeed we have unaligned behavior
> > even for ram_device.  It also means what matters in regards to the Realtek
> > bug was only about aligned access (with subpage presence).
> > 
> > I think it means we can always keep unaligned to stick with
> > memcpy()/memmove(), but only use atomic ops for the aligned cases of
> > 1/2/4/8.  With that, I think we can also remove ram_device_mem_ops and fix
> > the bounce buffer issue.
> > 
> > I think it means we'll stick with memcpy()/memmove() for all archs for
> > unaligned, which is again not safe... but that can be an existing but
> > separate problem to solve too.
> > 
> 
> Lets see if Peter Maydell and Michael are happy with this option. At least,
> we will have unified qemu_ram_move() for all architectures with this option.
> Note that qemu_ram_copy() won't be needed.
> 
> I'm putting note on what's to be done in (v4) if this option is to be picked
> up. Let me know if there are missed points. It's basically combing what's done
> by ram_device_mem_ops to upper layer (e.g. in qemu_ram_move()).
> 
>   address_space_write
>     address_space_to_flatview
>     flatview_write
>       flatview_translate
>       flatview_write_continue
>         flatview_write_continue_step
>           memmove                     // (A) to replace it with qemu_ram_move()
> 
> /**
>  * qemu_ram_move: move data to ramblock
>  *
>  * @dst: destination where the data is moved to
>  * @src: source where the data is moved from
>  * @n: length of data to be moved
>  *
>  * Move @n bytes from @src to @dst with the assumption that @src and @dst
>  * can overlap. The access is atomic if the source and destination buffer
>  * aren't overlapped for a well aligned and small-sized access. Otherwise,
>  * fall back to the standard memmove().
>  */
> static void qemu_ram_move(void *dst, const void *src, size_t n)
> {
>     uintptr_t test, len;
> 
>     if (src == dst || n == 0) {
>         return;
>     }
> 
>     /* Overlapped buffers */
>     if (src < (dst + n) && dst < (src + n)) {

s/&&/||/?

It's a bit weird to request memmove() for overlapped, e.g. I don't know if
P2P can overlap too when some fuzzer fills in some MMIO address shifted for
src/dst.. but I think I get what you want to simplify and it looks fine.

Otherwise it looks good.

>         memmove(dst, src, n);
>         return;
>     }
> 
>     test = (uintptr_t)src | (uintptr_t)dst | n;
>     len = test & -test;
> 
>     /* Unaligned or oversized access */
>     if (n > 8 || len != n) {
>         memmove(dst, src, n);
>         return;
>     }
> 
>     switch (len) {
>     case 1:
>         qatomic_set((uint8_t *)dst, qatomic_read((uint8_t *)src));
>         break;
>     case 2:
>         qatomic_set((uint16_t *)dst, qatomic_read((uint16_t *)src));
>         break;
>     case 4:
>         qatomic_set((uint32_t *)dst, qatomic_read((uint32_t *)src));
>         break;
>     case 8:
>         qatomic_set((uint64_t *)dst, qatomic_read((uint64_t *)src));
>         break;
>     default:
>         g_assert_not_reached();
>     }
> }

[...]

> Yes, I think one preparatory patch can added in (v4) to replace memcpy() with
> memmove() in the following paths, extending commit 4a73aee8814 ("softmmu: Use
> memmove in flatview_write_continue"). With this replacement, qemu_ram_copy()
> won't be needed in (v4).
> 
>     hw/remote/vfio-user-obj.c::vfu_object_mr_rw
>     include/system/memory.h::address_space_read
>     system/physmem.c::flatview_read_continue_step
>     system/physmem.c::address_space_write_rom

Now after a second look, I think it's safe to drop
address_space_write_rom() in the change list because it always directly
manipulates the real RAM (that plays the ROM role).  I recall it was used
to be used in debugging path, but at least now when I look at master branch
it's not.  So we can drop.

I see you already ruled out address_space_read(), I'm not sure if it's
about having that __builtin_constant_p() early check: I think it's still
better to switch that to the new API too, then we get rid of implicit
assumptions of memcpy() over builtin constants.

Thanks,

-- 
Peter Xu


