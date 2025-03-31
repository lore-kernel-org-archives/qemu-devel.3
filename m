Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5EDC3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 09:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzBMK-0004Qn-7S; Mon, 31 Mar 2025 05:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tzBHl-0002J9-Nu
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 05:18:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tzBHj-0006iW-Oo
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 05:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743412698;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=GkjXET07FjM5bbi5/IeeWcYftau8tEhMTEH0O+5LQ5E=;
 b=dJXEEW3zpRly+9vOwkbw643Axap4VayWVDDvriRH/5nGmQHxcbB6oIyOi37L1Fq2DNqcPx
 YczpqkJy3SXHtlDGPAXGkok2sedI+w/KKwtzvDjixRSBraBXM6d0QUPTxl3YxOo9eZlk/9
 1z9y4wpGdtv2p2jD5hWTIl3xFF3/Zzw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-9SmyVgdQO9K20lZiZKGpTA-1; Mon,
 31 Mar 2025 05:18:14 -0400
X-MC-Unique: 9SmyVgdQO9K20lZiZKGpTA-1
X-Mimecast-MFC-AGG-ID: 9SmyVgdQO9K20lZiZKGpTA_1743412693
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E329F1800265; Mon, 31 Mar 2025 09:18:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.36])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F20219560AD; Mon, 31 Mar 2025 09:18:09 +0000 (UTC)
Date: Mon, 31 Mar 2025 10:18:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] rust/hw/char/pl011/src/device: Implement logging
Message-ID: <Z-pdzUBa4CrBourR@redhat.com>
References: <20250330205857.1615-1-shentey@gmail.com>
 <20250330205857.1615-3-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250330205857.1615-3-shentey@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Mar 30, 2025 at 10:58:57PM +0200, Bernhard Beschow wrote:
> Now that there is logging support in Rust for QEMU, use it in the pl011 device.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
> index bf88e0b00a..d5470fae11 100644
> --- a/rust/hw/char/pl011/src/device.rs
> +++ b/rust/hw/char/pl011/src/device.rs
> @@ -8,9 +8,11 @@
>      chardev::{CharBackend, Chardev, Event},
>      impl_vmstate_forward,
>      irq::{IRQState, InterruptSource},
> +    log::{LOG_GUEST_ERROR, LOG_UNIMP},
>      memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
>      prelude::*,
>      qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
> +    qemu_log_mask,
>      qom::{ObjectImpl, Owned, ParentField},
>      static_assert,
>      sysbus::{SysBusDevice, SysBusDeviceImpl},
> @@ -298,8 +300,7 @@ pub(self) fn write(
>              DMACR => {
>                  self.dmacr = value;
>                  if value & 3 > 0 {
> -                    // qemu_log_mask(LOG_UNIMP, "pl011: DMA not implemented\n");
> -                    eprintln!("pl011: DMA not implemented");
> +                    qemu_log_mask!(LOG_UNIMP, "pl011: DMA not implemented\n");
>                  }
>              }
>          }
> @@ -535,7 +536,7 @@ fn read(&self, offset: hwaddr, _size: u32) -> u64 {
>                  u64::from(device_id[(offset - 0xfe0) >> 2])
>              }
>              Err(_) => {
> -                // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
> +                qemu_log_mask!(LOG_GUEST_ERROR, "pl011_read: Bad offset {offset}\n");
>                  0
>              }
>              Ok(field) => {
> @@ -567,7 +568,10 @@ fn write(&self, offset: hwaddr, value: u64, _size: u32) {
>                  .borrow_mut()
>                  .write(field, value as u32, &self.char_backend);
>          } else {
> -            eprintln!("write bad offset {offset} value {value}");
> +            qemu_log_mask!(
> +                LOG_GUEST_ERROR,
> +                "pl011_write: Bad offset {offset} value {value}\n"
> +            );
>          }

General conceptual question .....  I've never understood what the dividing
line is between use of 'qemu_log_mask' and trace points. The latter can be
optionally built to feed into qemu log, as well as the other dynamic trace
backends.

Is there a compelling reason to use 'qemu_log', that isn't acceptable for
trace probe points ?

This is an indirect way of asking whether qemu_log_mask should be exposed
to rust, or would exposing tracing be sufficient ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


