Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6558BC54798
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 03:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfAHe-0008Kp-Qg; Tue, 27 Feb 2024 22:07:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1rfAHd-0008KP-0G
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 22:07:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1rfAHb-0004GJ-95
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 22:07:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709089618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y9jsza7IbjgUSfOzbVDGzWCcpQPtNO6ZAAbFKPp+SyA=;
 b=iquTm2IDEf+VM9cNo+EpplqvkShYI/OV9VN2yDqCKuDsZEYWxm1q6k/ACK8C4Hrbi3PXbh
 pa1csxQNMCoZutsJBKxCLr71hak+iB6cEiFaZEzfFiP55xXpMdCIUnozoRq21gWIyZYdp/
 0kfy6tYnor+CBWycI0zNAkJ78vCj2KQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-wOIo6WI9Mb-o1vGKEs_x4w-1; Tue, 27 Feb 2024 22:06:54 -0500
X-MC-Unique: wOIo6WI9Mb-o1vGKEs_x4w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1145887DC01;
 Wed, 28 Feb 2024 03:06:53 +0000 (UTC)
Received: from [10.39.192.46] (unknown [10.39.192.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3678DC1EA63;
 Wed, 28 Feb 2024 03:06:50 +0000 (UTC)
Message-ID: <44fecb6d-35d0-f1b8-1572-3506fea19a5a@redhat.com>
Date: Wed, 28 Feb 2024 04:06:49 +0100
MIME-Version: 1.0
Subject: Re: [RFC PATCH 0/5] hw/i386/q35: Decouple virtual SMI# lines and wire
 them to ICH9 chipset
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20240226164913.94077-1-philmd@linaro.org>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <20240226164913.94077-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Phil,

On 2/26/24 17:49, Philippe Mathieu-Daudé wrote:
> Hi,
>
> This is an experimental series to reduce calls to the
> cpu_interrupt() API from generic HW/. I'm trying to use
> the ICH9 chipset from a non-x86 machine. Without this
> experiment, we can not because cpu_interrupt() is target
> specific. Here the interrupt is decoupled using the QDev
> GPIO API. Even if the SMI# line is left unconnected, the
> device is still usable by a guest.
>
> Based-on: <20240226111416.39217-1-philmd@linaro.org>
>
> Philippe Mathieu-Daudé (5):
>   target/i386/cpu: Expose SMI# IRQ line via QDev
>   hw/i386/piix: Set CPU SMI# interrupt using QDev GPIO API
>   hw/ahci/ich9_tco: Set CPU SMI# interrupt using QDev GPIO API
>   hw/i386/q35: Wire virtual SMI# lines to ICH9 chipset
>   hw/isa: Build ich9_lpc.c once
>
>  include/hw/acpi/ich9.h        |  1 +
>  include/hw/acpi/ich9_tco.h    |  4 ++--
>  include/hw/i386/pc.h          |  2 --
>  include/hw/isa/ich9_lpc.h     | 12 ++++++++++++
>  include/hw/southbridge/ich9.h |  1 +
>  target/i386/cpu-internal.h    |  1 +
>  hw/acpi/ich9.c                |  3 ++-
>  hw/acpi/ich9_tco.c            | 13 ++++++++++---
>  hw/i386/pc.c                  |  9 ---------
>  hw/i386/pc_piix.c             |  4 ++--
>  hw/i386/pc_q35.c              | 26 ++++++++++++++++++++++++++
>  hw/isa/ich9_lpc.c             | 15 ++++-----------
>  hw/southbridge/ich9.c         |  1 +
>  target/i386/cpu-sysemu.c      | 11 +++++++++++
>  target/i386/cpu.c             |  2 ++
>  hw/isa/meson.build            |  3 +--
>  16 files changed, 76 insertions(+), 32 deletions(-)
>

This series is over my head for a review, so the best I could offer
would be to test it.

However, even testing it seems like a challenge. First, I've found that,
when building QEMU at dccbaf0cc0f1, my usual libvirt guests don't start
-- I needed to search the web for the error message, and then apply the
revert series

  [PATCH 0/2] Revert "hw/i386/pc: Confine system flash handling to pc_sysfw"
  https://patchew.org/QEMU/20240226215909.30884-1-shentey@gmail.com/

With that, I managed to establish a "baseline" (test some OVMF SMM
stuff, such as UEFI variable services, ACPI S3 suspend/resume, VCPU
hotplug/hot-unplug).

Then I wanted to apply this series (on top of those reverts on top of
dccbaf0cc0f1). It doesn't apply.

Then I noticed you mentioned the dependency on:

  [PATCH v2 00/15] hw/southbridge: Extract ICH9 QOM container model
  https://patchew.org/QEMU/20240226111416.39217-1-philmd@linaro.org/

That only seems to make things more complicated:

- patchew says "Failed in applying to current master"

- in the blurb, you mention "Rebased on top of Bernhard patches";
however, the above reverts appear to undo some of those patches
precisely, so I'm unsure how stable that foundation should be
considered.

I'd prefer waiting until all these patches stabilized a bit, and the
foundation all went upstream, and then I'd have to apply (a new version
of) this particular series only, on the then-master branch, for testing.

Laszlo


