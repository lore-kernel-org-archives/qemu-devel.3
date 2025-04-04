Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9682C3601E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 12:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0g0x-0005Rr-P9; Fri, 04 Apr 2025 08:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1u0g0v-0005RT-Gn
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:19:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1u0g0t-0006hD-Eh
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743769150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FOVEc3/kq/cbqlQj7CW1gO5ElwGD9uK9JSThet8Wpow=;
 b=e/YNKB0zfrd1w+Pj2yulYet3gg5RgCPuahvKh5D2GbLHBgu9vZRJUwcqkja1CF1rCjcLGk
 0IthpO5FA4d+iTv3ad6eIqqBlrqARqzr1CTaZpKPQCqu2dg7ulwh3fSrDmG6jOms4sDeih
 7Ff2Nx1bDXMILLbSk60pjiKuT+4pm4g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-NT15UWvuPnamJSDMXd-jTw-1; Fri, 04 Apr 2025 08:19:08 -0400
X-MC-Unique: NT15UWvuPnamJSDMXd-jTw-1
X-Mimecast-MFC-AGG-ID: NT15UWvuPnamJSDMXd-jTw_1743769146
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3913aea90b4so948443f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 05:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743769146; x=1744373946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FOVEc3/kq/cbqlQj7CW1gO5ElwGD9uK9JSThet8Wpow=;
 b=LSTmNrDSFvIxD6U35MNXhBderXa1+vseqUjj5DoRpseLgQWQlKEhxLNmYRcabcLUmo
 Bj5Bt4y5tBqrRL/CNfhn4LPACZJzBGrJlBeB0sJBqK4WvXgfj+i7eGNHH14882gOwbU1
 BmAwS+5UpqqB+lCFB/fDcTXYt8dglJO3j5HZpD4auDfv6HQRPTNv3m2HTciJHwXCHW36
 z3xTAyNQfAlUvb7RqaKxNPgM+j3025+y5BLj1Dmb9es027VP/OOzSGFIBCUZssbLquh0
 f4j+5yqFC4OOnLH8ktFWBa5m0dWv7HTvQ9qXuOoXjnDC/EXXuLNEbfvjFZ3tY2r80ajQ
 1KJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTlBVdd70+tccPYfovBZ/SOvsDP8gHOpAnlvRfSdzkob3oz7RWSr7wjZXxNYMYkpwjzzhjHd4fr+8a@nongnu.org
X-Gm-Message-State: AOJu0YzRjBWjlShiMRAkO32VtWA3euY6LlFFHYumBx9CtWtABXnSJcAN
 ETEAGCoR9+ZZNkJrXoiZa2cr1WdsVZbs4FM9eP/zii1O5MMS8jI88hnu4VbdPleon83N7A5YM1T
 oPYPdBVkHvV2gTotLTDn3Ulh007JLEkDijUOSzt2ceU583jaeaDR1
X-Gm-Gg: ASbGncss19bbfwtNGIvWYWTf3l6kjliYC0qF77qySRuLq9bP3KLbSiVRRcry8lhgP4u
 mDAJ8NNBfvPXRmph20jX7FT2f2getRROMOivM6cTM5Wif6g3QV+q7kcaUjmz5mhG8LLIgFs7mWP
 /nNQTFEAILI3I7wcy88m8RSGpegvBVnp/W7nYwmnzfcx/gWkYS7BH4Fcct9hkdmOmFIud/mbN+5
 +YcSn+Hk/tkjrisCI3ipeDAz3kkdZBu7r4Y8GL2BMdJuetlTxuXYCWMjxkvNa0fzZLNTjXXE8r9
 UTPA+a86Ya1/vj2+OfaiNPPXN8Zc00huHSCt
X-Received: by 2002:a05:6000:1a8d:b0:38f:37f3:5ca9 with SMTP id
 ffacd0b85a97d-39cba97fd3emr2463344f8f.50.1743769145906; 
 Fri, 04 Apr 2025 05:19:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXvhfaV79CZQQmfMQiCMVBk4vDVkbfpa0tHmaLzkNpuWBLgoAqyPenE/fA3DXkxOFxDNoucQ==
X-Received: by 2002:a05:6000:1a8d:b0:38f:37f3:5ca9 with SMTP id
 ffacd0b85a97d-39cba97fd3emr2463315f8f.50.1743769145501; 
 Fri, 04 Apr 2025 05:19:05 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226ee4sm4321197f8f.93.2025.04.04.05.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 05:19:05 -0700 (PDT)
Date: Fri, 4 Apr 2025 14:19:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eduardo
 Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: Re: [PATCH RFC 0/3] Attempt to add GHES for x86
Message-ID: <20250404141904.711f8aa3@imammedo.users.ipa.redhat.com>
In-Reply-To: <cover.1741094512.git.mchehab+huawei@kernel.org>
References: <cover.1741094512.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue,  4 Mar 2025 14:30:55 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Hi Igor,
> 
> This patch series comes after:
>    https://lore.kernel.org/qemu-devel/cover.1740903110.git.mchehab+huawei@kernel.org/
> 
> I'm basically trying to add support for error injection for x86,
> without success so far.
> 
> On x86, the notification mechanism is different: it is via QMP.
> Yet, from what I saw on Linux implementation, it works on
> a similar way to GED. So, I ended implementing a notification
> via GED.
> 
> HEST table build seems to be working OK on it, and the
> error injection notification for x86 is called. Yet, OSPM is not
> receiving any notifications.

microvm already uses GED, so GHES support with GED is fine there  

However ps/q35 have already acpi controller, and I'd rather
add GHES support there instead of adding extra acpi device.
and use GPE as event delivery mechanism (like it's done for
hotplug event delivery)

> Could you help me figuring out what are the missing bits?
> 
> PS.: there are some things at the code that require polishing,
> plus there are some extra printf() there to help debugging.

use tracing instead of printfs

> Finally, we would need to add x86 CPU error event at the
> ghes script, but I'd like to have at least something that the 
> OSPM receives before improving it further.
> 
> It can be tested with:
>    $ ./scripts/ghes_inject.py arm
> 
> (Ok, this would be generating an ARM processor event , but
> I guess Linux would at least mark the event as read, even if
> it doesn't recognize it)
> 
> Mauro Carvalho Chehab (3):
>   acpi/ghes: move use_hest_addr out of acpi_build_hest()
>   hw/i186: add support for HEST table with SCI
>   Add a GED device for RAS notification
> 
>  hw/acpi/ghes.c           | 16 ++++-----
>  hw/arm/virt-acpi-build.c | 12 ++++---
>  hw/i386/Kconfig          |  1 +
>  hw/i386/acpi-build.c     | 75 ++++++++++++++++++++++++++++++++++++++++
>  hw/i386/pc.c             | 41 ++++++++++++++++++++++
>  include/hw/acpi/ghes.h   | 25 +++++++-------
>  include/hw/i386/pc.h     |  5 +++
>  include/hw/i386/x86.h    |  2 ++
>  8 files changed, 153 insertions(+), 24 deletions(-)
> 


