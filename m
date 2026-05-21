Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0559ACD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ448-0002kd-0h; Thu, 21 May 2026 10:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wQ43p-0002Ri-1P
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:07:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wQ43k-0007hM-O1
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779372453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GBSn6wb/FRACPuw5VM8/6y917ILNCyEiuNKU8x3jRpk=;
 b=Nh03uZGASTjYUoOnI1qb/S3cf9wvaU/QUZC6JkgS4buRAV7VtPkH7NDj/V+6wh2WBgPrfa
 yA4BzTpcQWeHXXSbb/bVYUM0YaBdBGNcqO+ueHmE/J1P+3tYRFo6N7ycWzSiqbH0Z7XVu+
 zK47HpvPzX08QMf00tS8I2S2MwgpEHs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-O1SD5_brMQeDndKs72Z5RQ-1; Thu, 21 May 2026 10:07:21 -0400
X-MC-Unique: O1SD5_brMQeDndKs72Z5RQ-1
X-Mimecast-MFC-AGG-ID: O1SD5_brMQeDndKs72Z5RQ_1779372439
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48fde68e420so53869275e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 07:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779372439; x=1779977239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GBSn6wb/FRACPuw5VM8/6y917ILNCyEiuNKU8x3jRpk=;
 b=D2AYlFA89FhA5OCZHFWiyFGTxVXOA5ihUhFBl5NWLb9SZyctDffaWnPAOMciqeI+sq
 ZGtNzUEzXC0OCn2IfDHbD0kI80JTESVVe4t++4QPggb3xWv1icc2n5r0d2B+t/o9fhSy
 maU9gRiiwRQ+XV8+9XUIZ6qL2AcSWtPz5AThf9mkAxi7kn0fyBm1yqUQeYkEPTNcELJw
 yuGY/LUAA+iUou18fYqWhaUN7yb8SDNUdRjwhW2+ujR7GAH7OXw7KW3T3Cu7nkqhQAOw
 GsDflit82EHqYYSoEYhmkSTdFffnxXiNxiWH8A1Bb2wK6jZ82dPcGtjW7NQBMiC0Ldoq
 4O1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779372439; x=1779977239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GBSn6wb/FRACPuw5VM8/6y917ILNCyEiuNKU8x3jRpk=;
 b=h0uED1lF4+2yVwK+EEeXIbu20UfjZNOe4Rz3AK6mAag+Z5yvmJqPkRuYfWya09GrkB
 /lU2FOHO83AjeBWpA/L4gdYVzwwXBUno/pzzFL7WNFkRDZGbUbih2Ahqf4G6lYEZXuBu
 5aAolKApYlhun8jIknrrtnjxbLTFX44Ad/NA/IDemkAlyItpWgapKN/gN2Sv8uJ7x/N9
 P/2uEwCD0cxxKpFucTRfTuLoHalB/YsdihGqM1yw9aXDo1ZDKmDxpesvtbaLDmnJaYZQ
 D0+iu92+RJ5BkrIN6WOclCbD3VegLKllMjtfLDIvwI59SAJbyc0Ydfq4dy/q2J7MCreb
 Eeew==
X-Gm-Message-State: AOJu0Yyv+WPPj6Nk0yyZH99vISN6Z58x+w9b0XgXF9PGynKxWYXwVA7D
 j7bLtyROa+Z3/hazHLka5nzxYfg6yyx+sqH+YzcQ8wnyVHURci94qTbefz6b9LiJzXb02ncb52d
 aY/pyziJ6po8C6c2P2OcWOPDAZLvCGt8ie0JjjAqOhXLreCxLXK21LSE6
X-Gm-Gg: Acq92OHTGl72h6KJsQR0dq9L1DEDWoS9eOzDB6EMPhv8wDHf7KnWlOOWpZH2AzGOWJS
 t76G2+rR96tzwWLQDQ4NvVWTL/RMDeQp//FNC3gZlSpKK/CXqpWA97aYWNIq1U+9skdoe4WXxZa
 lgQg1AW9OPpRkbOmEy/9Npkcn9saUQx/k4iM39Crws7NKNGXjM9oQMqSUGq9kWEV+BSSdaKwn3y
 5tMiLVBlWu1teZuDLGF25n83ZdiSkNYHiF1UBJmyLpEofC1i1iE4hLpQpybHhLWqZUJ8m4FGzYk
 b7MDFsZTyEWx5ugcik23bQU4GJtLFiylqbsTJOY+ftLRmvBWEung6sNgz7maIhfFzrf2Av0VDVj
 S70+8/A==
X-Received: by 2002:a05:600c:3395:b0:48a:7965:b943 with SMTP id
 5b1f17b1804b1-490360b11e0mr25857995e9.29.1779372438662; 
 Thu, 21 May 2026 07:07:18 -0700 (PDT)
X-Received: by 2002:a05:600c:3395:b0:48a:7965:b943 with SMTP id
 5b1f17b1804b1-490360b11e0mr25857565e9.29.1779372438169; 
 Thu, 21 May 2026 07:07:18 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903c99d807sm33368085e9.5.2026.05.21.07.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 07:07:17 -0700 (PDT)
Date: Thu, 21 May 2026 16:07:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
Cc: <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>, "Gregory
 Price" <gourry@gourry.net>, Zhigang Luo <Zhigang.Luo@amd.com>, Lianjie Shi
 <Lianjie.Shi@amd.com>
Subject: Re: [PATCH v7 1/1] numa: add memmap-type option for memory type
 configuration
Message-ID: <20260521160716.169137ae@imammedo>
In-Reply-To: <666a7ba1-5d3a-4732-b872-0d9fb2fe8461@amd.com>
References: <666a7ba1-5d3a-4732-b872-0d9fb2fe8461@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Thu, 21 May 2026 18:41:35 +0800
"Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com> wrote:

> Hi Igor,
> 
> Thanks for the candor in this round, and for laying out the
> architectural reasoning rather than just the position. The framing is
> clear: an RFC with a rough prototype demonstrating the device-based
> approach, and the interface decision after that exploration
> converges. That's a reasonable bar and I'm glad to converge on it.
> 
> Two of your clarifications particularly helped me converge:
> 
> - SPM belongs to the memory-device family by design, not as an
>    extension of built-in RAM.


> - The v4 -object/backend-property rejection is scoped to that form,
>    not to any device-based shape -- so `-device spm-memory` doesn't
>    carry the v4 risk forward.

Not sure what you a taking about, with device approach you will use
backend property ('memdev' if i recall correctly) to connect backend
(whatever it might be) to front-end (device model).

> 
> One thing I should mention while we're aligning: in parallel with
> this thread, I've actually been prototyping the spm-memory device
> direction you outlined. I held off bringing it into the v7
> discussion because I didn't want to muddy the interface debate with
> implementation specifics before the direction was settled. Now that
> you've made the path explicit, I can share what I've found and move
> the discussion to the v8 / RFC thread properly.
> 
> A short prototype status and a couple of architectural findings
> below. Some you've likely thought through already; raising them so
> the v8 thread has a starting point.
> 
> (1) Prototype status
> 
> A working `spm-memory` prototype inheriting from TYPE_MEMORY_DEVICE
> -- end-to-end verified on both SeaBIOS and OVMF across single,
> multi-instance, and mixed-with-pc-dimm scenarios.
> 
> (2) Umbrella overlap finding + proposed mitigation for your read
> 
> The umbrella SRAT entry at acpi-build.c:1510-1515 (PXM =
> nb_numa_nodes - 1, covering the full device_memory length per
> pc.c:615) overlaps every per-device entry by construction. Any
> driver that first-match-by-PXM via SRAT walk lands on the
> umbrella's range rather than the device's actual range.
> 
> Mitigation in the prototype: in acpi-build.c, skip the umbrella
> when every plugged memory device is TYPE_SPM_MEMORY. Empty
> device_memory and mixed configs (SPM + pc-dimm / nvdimm /
> virtio-mem) keep the umbrella, preserving Windows hotplug /
> Linux <4G SWIOTLB. Verified in both directions. Honest scoping:
> mixed mode still has the overlap, so this is a partial
> mitigation.

I'd suggest to:
  1: make smp-memory not hotpluggable
  2: when SRAT is built, partition 'umbrella region' region on chunks
    (current hotplug kind and spm kind). that will fragment the region
    and limit what can be (hot)plugged later on (especially if spm in the middle),
    but that will be the edge case, and user can reconfigure QEMU to
    put spm 1st and DIMMs on top.

If we do it like this, then mixed scenarios should work just fine.
 
> 
> (3) Process
> 
> I'll prepare a v8 PATCH series along the lines you sketched:
> 
>    - spm-memory device class (TYPE_MEMORY_DEVICE base for first cut)
>    - drop the `reserved` enum value
>    - commit message with the bigger-picture rationale

ps:
it would be nice to put references to previous versions in cover letter,
so it wouldn't be pain to find them (especially when threads are renamed)

> 
> I'll post the RFC on qemu-devel under a fresh subject so the 
> device-based discussion can start clean.
> 
> Setting the v7 memmap-type discussion aside accordingly. Thanks
> again for the patience.
> 
> Best regards,
> FangSheng Huang (Jerry)
> 


