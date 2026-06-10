Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58841CD98C6
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 13:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXJOX-0001Yj-Tl; Wed, 10 Jun 2026 09:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wXJOW-0001Xr-25
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 09:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wXJOT-0005sL-Nn
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 09:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781099696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BJ5HprEQ81WBkWA9RsbQK3f/bSWBwYP+yxtI1LSoq2c=;
 b=Zg1oMzDMRhgDoJNOHf0MDciLn8Glx+9uJSeJw8JfYPXCxptQlrCsGidD+TespxNDCmwfAE
 GxxRergAgclJW4c3e6AvPDs6WujACGWOPVbi5RjmupZuds/DVvjXuxjaBrstUJMI5c7/vf
 BQFBzkvN6iVJqNtNL6QD7o6rJkEqOsE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-GxLp29e8PyuZvaN556z_-g-1; Wed, 10 Jun 2026 09:54:55 -0400
X-MC-Unique: GxLp29e8PyuZvaN556z_-g-1
X-Mimecast-MFC-AGG-ID: GxLp29e8PyuZvaN556z_-g_1781099694
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso4432400a12.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 06:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781099694; x=1781704494; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BJ5HprEQ81WBkWA9RsbQK3f/bSWBwYP+yxtI1LSoq2c=;
 b=dqaKoalqz500YLxGapTNWgNqpjJQf2qDwmJsl44EwT5t+0ZR6EiOLLXGq0gcKrd7Qq
 Vxeuo4DTJTOGWHjO+9aDJ8x7j2RIl+wOweZhyLRXUOB0JPRd4V73uTmQHqoqQXqPimpj
 7VYGKVY9eIfHBnXqxXKHEpD0gvD9wgBP5eakFvZf/bBXhM9IlVfKiwxZDFNIyrtK8V6G
 Z3+s1ayeHzxP/UN11rM0kPuIHEdU3yi17+D+D9Jiesavh2clYLntAmmStZblS/XDta84
 7KsOmejIrUO2quiSFFFpii1ccyjl3t3abbhu0bt5OJ+9s6P5ptOPekrGh9c3ZqWZNhqt
 q3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781099694; x=1781704494;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BJ5HprEQ81WBkWA9RsbQK3f/bSWBwYP+yxtI1LSoq2c=;
 b=KrNiKQptDPYyw06B7iydv6aJIdsAhV7bba/1D7tMmL9wewsfVuzT273uraPLjX45Xl
 4z+Yhtr3CCCiT2hy5pY9YhyQ8Ac43K88rNI2rEgUJmifJwog6FxqWh4PgH6mC2JK/KLa
 rGLgh5yBQAcKTsXUQHqkwV9Xvmz/CEINzaLF6tFNZgZ+0RvHRuFGpQzWbDu6eLNLzvOl
 H+Y7fd4t9GKtuZoVWrOVr89A0KDzrM/jUiz1TLLLrX/oCBZfC1Ww++3YBGREqvxNKPBP
 bLCf7SLKEVSt6FQVVeJTebZRqs+lI8jHGiDmn/ZS7+G0pteml8cILYOb7SlvwUK2K5/r
 odxQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+1pEvB4Yj0YzWMzrs0Nk9HvP3QH13Q8Lc4p7nbaDE9zZDCkWSRIebsdHXnMOJtX6WJLosli0VgvZ9o@nongnu.org
X-Gm-Message-State: AOJu0YzHO64NJ1gQUOkwIAbeFJLmsFxXyoFsvOmQkQALvNCaZDdiD3Ix
 srEfXz9nNrg+BNmmNUkMK/byqzyk3kh24UFXQsOBDdqyX73o9WmmY3bjjDYanbxcBGddSWAhcw0
 63aXEdM9STZbRQWXqjFedOohiX0iQ3DWzXuN7zwXvBBpZo9nAZ8z0r+1J9oHbQ+0Q
X-Gm-Gg: Acq92OG9iTtyroLU/aKrmtpvF7S+1rv/FcOptbFeYxDw2PywhCXkqrgb8JIiFdBxvk1
 yH3mEkaGqL1eEuQkzeeGgZsUHgLXqcN1cGXE4BZ+bsukXxGamZAP+HSgmFkOieL1Vt3HUSTjxhn
 V8PQTpntHvkXCF4ETE5Bgq/i1cv3EQkOUmnXbKjM9WJ3qoox4qvaFaJK04GpcV82WneX5mU6zU9
 qJuO87rdXoRBRh/sMVjFMuS1RoW3fiazcbYQXRQv8OqoiaMiqaBvLCHJWTycwX/Y5BVCHsUVDUP
 Q8m9HEEe++yqEDUeA/OCVMX9bFR5FY4gcwPN7j4EQ7tX7Zm9UtPNAE/00h+frM3yHJkneO/T/VA
 JPiqfx5UCCBFCpbyr0YtkD6sU4n81PeUnib0caEnv8DbxsKwdQzL+jpdD2jJYvB7D5J+R+tK7Dw
 I=
X-Received: by 2002:a05:6a21:3949:b0:3b4:6026:6c5d with SMTP id
 adf61e73a8af0-3b4cccfde39mr30804300637.5.1781099694070; 
 Wed, 10 Jun 2026 06:54:54 -0700 (PDT)
X-Received: by 2002:a05:6a21:3949:b0:3b4:6026:6c5d with SMTP id
 adf61e73a8af0-3b4cccfde39mr30804260637.5.1781099693569; 
 Wed, 10 Jun 2026 06:54:53 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df03498csm24388719a12.1.2026.06.10.06.54.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 06:54:52 -0700 (PDT)
Message-ID: <e7cc9f2d-ccb4-442f-a1ed-7c5474395099@redhat.com>
Date: Wed, 10 Jun 2026 23:54:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
From: Gavin Shan <gshan@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pavel Hrdina <phrdina@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jugraham@redhat.com, shan.gavin@gmail.com
References: <20260608001821.850921-1-gshan@redhat.com>
 <aiaDgG26a6TUrKuM@redhat.com>
 <07ca74b4-52a8-4187-a57c-7c3277e574d3@redhat.com>
 <aiky9d9IwACIyKEC@phrdina-thinkpadt14gen4.rmtcz.csb>
 <674d5e21-88fa-4a10-a83c-eb6f7ce7032f@redhat.com>
 <20260610080947-mutt-send-email-mst@kernel.org>
 <eb0f0da1-11dd-4437-94fd-a65af55851e1@redhat.com>
 <20260610082637-mutt-send-email-mst@kernel.org>
 <5d8cbd4b-3725-437e-88a3-e0af32164815@redhat.com>
Content-Language: en-US
In-Reply-To: <5d8cbd4b-3725-437e-88a3-e0af32164815@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Hi Michael and Peter,

On 6/10/26 11:00 PM, Gavin Shan wrote:
> On 6/10/26 10:27 PM, Michael S. Tsirkin wrote:
>> On Wed, Jun 10, 2026 at 10:19:31PM +1000, Gavin Shan wrote:
>>> On 6/10/26 10:12 PM, Michael S. Tsirkin wrote:
>>>> On Wed, Jun 10, 2026 at 08:55:10PM +1000, Gavin Shan wrote:
>>>>> On 6/10/26 7:54 PM, Pavel Hrdina wrote:
>>>
>>> [...]
>>>
>>>>>>
>>>>>> You did not answer the question that Daniel was asking, how will user
>>>>>> know that max-bounce-buffer-size should be used if it's necessary to fix
>>>>>> guest system hangs and how will user know what magic value should be set?
>>>>>>
>>>>>
>>>>> Sorry that I missed to answer Daniel's questions. For this specific case,
>>>>> user need to enlarge the bounce buffer size when seeing the following error
>>>>> message. We can add an explicit one in address_space_map() if the existing
>>>>> error message isn't obvious.
>>>>>
>>>>>     qemu-system-aarch64: virtio: bogus descriptor or out of resources
>>>>>
>>>>>     void *address_space_map(AddressSpace *as,
>>>>>                           hwaddr addr,
>>>>>                           hwaddr *plen,
>>>>>                           bool is_write,
>>>>>                           MemTxAttrs attrs)
>>>>>     {
>>>>>         if (!memory_access_is_direct(mr, is_write, attrs)) {
>>>>>             if (l == 0) {
>>>>>                 error_report("Running out of bounce buffer size , enlarge it with max-bounce-buffer-size");
>>>>>                 *plen = 0;
>>>>>                 return NULL;
>>>>>             }
>>>>>         }
>>>>>
>>>>> As to the value user should take for max-bounce-buffer-size, it is really case by case
>>>>> and decided by user. User needs to try 4096, 8192, ..., 0xFFFFFFFF to figure out the
>>>>> smallest value works for them. The worst case is to set 0xFFFFFFFF.
>>>>>
>>>>
>>>>
>>>> This is not at all reasonable. All kind of fixes are possible but
>>>> fundamentally, bounce buffering data path is by itself already a
>>>> bad idea.
>>>>
>>>> I have no idea what does bounce buffering device ram accomplish.
>>>>
>>>> In the end, qemu still simply reads the memory from/to the buffer.
>>>>
>>>> My suggestion is to first of all look for ways to mark the
>>>> memory as direct.
>>>>
>>>
>>> As I explained to Peter Xu in another reply, we can't simply mark the (RAM
>>> DEVICE) memory region is directly accessible. The memory region is initialized
>>> by memory_region_init_ram_device_ptr() in hw/vfio/region.c::vfio_region_mmap().
>>>
>>> The  accesses to the memory region is handled by 'ram_device_mem_ops' where
>>> {ldn, stn}_he_p() are used in its read/write handler. They're different
>>> from memcpy() since the data endianness is well handled in {ldn, stn}_he_p().
>>>
>>> Thanks,
>>> Gavin
>>>
>>
>> What is endianness set to, for this region?
>>
> 
> The endianness of the memory region is set to that for the host.
> 
> static const MemoryRegionOps ram_device_mem_ops = {
>      .read = memory_region_ram_device_read,
>      .write = memory_region_ram_device_write,
>      .endianness = HOST_BIG_ENDIAN ? DEVICE_BIG_ENDIAN : DEVICE_LITTLE_ENDIAN,
> };
> 

How about to treat the RAM DEVICE memory region directly accessible in
address_space_map() only when HOST_BIG_ENDIAN is false, something like
below and I don't hit the guest hang issue with the changes.

diff --git a/include/system/memory.h b/include/system/memory.h
index 1417132f6d..9daca55251 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2908,7 +2908,8 @@ void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
  int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr);
  bool prepare_mmio_access(MemoryRegion *mr);
  
-static inline bool memory_region_supports_direct_access(const MemoryRegion *mr)
+static inline bool memory_region_supports_direct_access(const MemoryRegion *mr,
+                                                        bool check_ram_device)
  {
      /* ROM DEVICE regions only allow direct access if in ROMD mode. */
      if (memory_region_is_romd(mr)) {
@@ -2922,13 +2923,14 @@ static inline bool memory_region_supports_direct_access(const MemoryRegion *mr)
       * be MMIO and access using mempy can be wrong (e.g., using instructions not
       * intended for MMIO access). So we treat this as IO.
       */
-    return !memory_region_is_ram_device(mr);
+    return (!check_ram_device || !memory_region_is_ram_device(mr));
  }
  
  static inline bool memory_access_is_direct(const MemoryRegion *mr,
+                                           bool check_ram_device,
                                             bool is_write, MemTxAttrs attrs)
  {
-    if (!memory_region_supports_direct_access(mr)) {
+    if (!memory_region_supports_direct_access(mr, check_ram_device)) {
          return false;
      }
diff --git a/system/physmem.c b/system/physmem.c
index 7bcbf87573..2e6b72b124 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3724,7 +3724,7 @@ void *address_space_map(AddressSpace *as,
      fv = address_space_to_flatview(as);
      mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
  
-    if (!memory_access_is_direct(mr, is_write, attrs)) {
+    if (!memory_access_is_direct(mr, HOST_BIG_ENDIAN, is_write, attrs)) {
          size_t used = qatomic_read(&as->bounce_buffer_size);
          for (;;) {
              hwaddr alloc = MIN(as->max_bounce_buffer_size - used, l);

Thanks,
Gavin



