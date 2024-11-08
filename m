Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015CED5C0E5
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Qa2-0001eY-JY; Fri, 08 Nov 2024 10:07:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t9QZz-0001WA-Tb
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:07:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t9QZx-0000Cn-JV
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731078435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gUaivA+jjMn6RcuEoEagxvFQ3uj78ss8cuQKbgIXq7I=;
 b=GSh3yDrPBlzubQ4fFREyepIVzJiWljzaP+DRbdTFYm4CUZC1cQ2MR2NKizVsvMm7W3d4W7
 cDWSxbIVdm7RlWw0r3G80hT/El9PzrZEXNZJB5rldKxZ7TIIoEguMe/TzCQokvHg5pU6p8
 rBK17PH/UAC/0jYw7gnaBM34OsK5leA=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-svj566LHPbaKhIcY4ivkXA-1; Fri, 08 Nov 2024 10:07:14 -0500
X-MC-Unique: svj566LHPbaKhIcY4ivkXA-1
X-Mimecast-MFC-AGG-ID: svj566LHPbaKhIcY4ivkXA
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-2885c5af51cso3815128fac.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:07:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731078433; x=1731683233;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gUaivA+jjMn6RcuEoEagxvFQ3uj78ss8cuQKbgIXq7I=;
 b=p0BL8QGsk0is28qHMoik97IBtM9lVaXGw4903VYL0t3260BfntzWIMpLqCTSacYQxc
 UnK613OZA9diP11g6D8+owREzZBfwhizecU9rM6kdtF+hlrRfnkc5ULbCwfW8TPppOFb
 3DgnHRP+5iBywI+6TN+Uo0Kccps5FWVdS2Tng7RZh56A/Y05OpFWF70sPYqiup0o5byy
 Qtiy65u4FjRMw87W9BVho2ukLIc8MqLgn25Mq+ng+kEnIaVOWNVCORQTetdsZ/F83Ypr
 NX4c9GTSuC6piAk7iajGeCf3dmjupdqNJS89vjqSZjlPZ3zd3/Uz6w3aY03pNBcOgyEA
 f5Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAOhrMq0zGbJVdFHgCbn+H/hN3DEy4dpTUd3GCmoveLBhVjx85aryt7gsdA6NBbAUTtP3nzMsRuMgo@nongnu.org
X-Gm-Message-State: AOJu0Yzna0qIS/IW5dPQ5JRK7NGFydBqR8ZeUQm4f3NOi9MZuPRLQ2zG
 nHNxNw+DU1Q80ULXZXOe39vgCVfRl0QLUD1vyY5WlgICIlUA4+ARLs3mwEmbwoeIHBf7SVEuY2Q
 rM6GRsl3WjbD0Phls6eqdVFAEoXaH9zp42XgaUMCoDRfLFYtcXYfA
X-Received: by 2002:a05:6870:e247:b0:261:f8e:a37a with SMTP id
 586e51a60fabf-29560059ea4mr3433372fac.14.1731078432932; 
 Fri, 08 Nov 2024 07:07:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFOu3mfTB1GbqGgrbjL+0MiaHHHy+OWftyRrVvvtTIz86xkWMKFcHozdakIA7hRSU3kzrUkw==
X-Received: by 2002:a05:6870:e247:b0:261:f8e:a37a with SMTP id
 586e51a60fabf-29560059ea4mr3433337fac.14.1731078432611; 
 Fri, 08 Nov 2024 07:07:12 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29546c8eb0fsm984117fac.14.2024.11.08.07.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 07:07:11 -0800 (PST)
Date: Fri, 8 Nov 2024 10:07:08 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
Message-ID: <Zy4pHEY8jBLfJmBO@x1n>
References: <66c05a06-dbb7-49ec-b58e-ccd917d098ea@oracle.com>
 <053dd9b6-e4f7-41c8-abe9-ed02214f0639@redhat.com>
 <cce158c4-3bb1-4771-b2c5-f3ae8a2285d5@oracle.com>
 <5b192b5e-943c-4b2f-ab40-ef54ea578363@redhat.com>
 <00261b15-3eef-439a-8501-574e3bb50d95@oracle.com>
 <d00ab1a4-2b72-4202-b810-adeb53a16f01@redhat.com>
 <44b15731-0ee8-4e24-b4f5-0614bca594cb@oracle.com>
 <99c6d0df-4ced-4fe5-bc87-2682d1ceaa5b@redhat.com>
 <29d21f54-38e7-43a9-86fa-586bd6f957be@oracle.com>
 <115da88f-e3aa-4bfe-8842-530c06c39da2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <115da88f-e3aa-4bfe-8842-530c06c39da2@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Nov 08, 2024 at 03:54:13PM +0100, David Hildenbrand wrote:
> Likely AUX is everything that is "neither explicitly specified by the user nor
> very special RAM"
> 
> So I think hw/misc/ivshmem.c would also not count as "aux", and similarly
> hw/remote/memory.c; both use memory_region_init_ram_from_fd(share=on).
> 
> memory_region_init_ram_ptr/memory_region_init_ram_device_ptr are similarly
> special: we cannot possibly turn them SHARED. But that's also what your code
> already handled.
> 
> So maybe, really everything is AUX ram, except
> * Using memory_region_init_ram_from_fd()/
>   memory_region_init_ram_from_file() users.
> * Using memory_region_init_ram_ptr / memory_region_init_ram_device_ptr
> * Created via memory backends
> 
> 
> Note that hw/m68k/next-cube.c is one odd RAM_SHARED user. I don't know why
> it uses RAM_SHARED to get anonymous shared RAM. Likely a mistake when that
> code was introduced.
> 
> CCing Thomas.
> 
> commit 956a78118bfc7fa512b03cbe8a77b9384c6d89f4
> Author: Thomas Huth <huth@tuxfamily.org>
> Date:   Sat Jun 30 08:45:25 2018 +0200
> 
>     m68k: Add NeXTcube machine
>     It is still quite incomplete (no SCSI, no floppy emulation, no network,
>     etc.), but the firmware already shows up the debug monitor prompt in the
>     framebuffer display, so at least the very basics are already working.
>     This code has been taken from Bryce Lanham's GSoC 2011 NeXT branch at
>      https://github.com/blanham/qemu-NeXT/blob/next-cube/hw/next-cube.c
>     and altered quite a bit to fit the latest interface and coding conventions
>     of the current QEMU.

This might also imply that our current RAM_SHARED is already not crystal
clear on when to use, not to mention RAM_AUX if to be introduced..  Please
see my other email, trying to define RAM_SHARED properly.

IIUC after we can properly define RAM_SHARED, then we don't need AUX, and
everything will be crystal clear.

Thanks,

-- 
Peter Xu


