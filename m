Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0CECD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYq9e-0007Mo-Ig; Sun, 14 Jun 2026 15:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYq9Y-0007LD-JO
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:05:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYq9W-0001ZR-Fi
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781463949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kd/cVzIWFHB7r44xSVIcmQI+gRNtFJnJ4HnNWjvlc+o=;
 b=iUv9EdCOUMXgJjxZn9CXhpoe3xY06UcBWnpsD4cSGoAHZYYEKLbcX4Xe7BteDQpCNe1k8I
 PTomVemjNg5BZW2ENRcBwEdcDC2pxsCcK6CKiUzM9M3JVtCj1ZfU87wpcKxIzn0hcm25C8
 TUinXSAvnW8mBUZVMY4LsT2x0yUxRXk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-xSnCLaXcMFuKwg_ztYlUCg-1; Sun, 14 Jun 2026 15:05:48 -0400
X-MC-Unique: xSnCLaXcMFuKwg_ztYlUCg-1
X-Mimecast-MFC-AGG-ID: xSnCLaXcMFuKwg_ztYlUCg_1781463947
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45efa2f7009so1709301f8f.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781463947; x=1782068747; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kd/cVzIWFHB7r44xSVIcmQI+gRNtFJnJ4HnNWjvlc+o=;
 b=lGl/E9xRfYmwQGM3EFgZMBNVAqYwpsRimHr4zX0iQMsRr7bMVB5IW76YIyIj1xfm3t
 i7Mkv6/VnizigRh7yU8PKLdYVxQ9rKEFnXaAhouzMIsRL8Jc+9VhKhIG/EJ4Bms9cQKa
 YjZMzWVvhujqoHg5yTPV2mI4eFW8eZKWIY3yaucU8Q8KOp+Lv+XFTqHuBGEZ1SzLSoiT
 5+r0zcu4x3anzUZ159bb0SmbMzoxwFMxUq3qC399erkdvTZRg+KVqfds4YGgLEL0av09
 ZysiHvxSFaIobv09TDB/qeS5FXJD2T/E/+emih7tbrAop0E958slIY0U8XDchDe34Hb1
 akAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781463947; x=1782068747;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kd/cVzIWFHB7r44xSVIcmQI+gRNtFJnJ4HnNWjvlc+o=;
 b=qmZdrAN6elaviWp8zrvv208j2wh0dgozr/V9TtQECKGa580Ve50UultJOrhd9zEykr
 Gxbjjp0A1ScVjHm87fr5lhCi12Xdgjp+hFgGhdff+NXbjOtEsxD6Bhe829DSUzRxMvp6
 7ma4M5Rz7A994Gc18CXDrV+65rbgRjD3DUC/uLna51AhTdTdEJCgIri1C6Z66fOgWD1P
 JtUpU130QkfAcvCFGXAAmAFSlm11A0ty/7cMAZd+0CWzaBGrfltSBM91WL9Rlyd07lbW
 qJwoUtR/YyIenRztYjPrJz52eMGhdk5CCBj2GIOqk43vKM8GyPv8Nn05w/BZUBXAU3mF
 lytA==
X-Gm-Message-State: AOJu0YzWsHWZmK2qpsx/6l3EzbEDoMwvB5XkRBkRxtjJnuCTPQlwFBnL
 vYgxHT0tt7CMcArZh0cBSdhkHgi/BR6Rzf/1iVTjukPwBK8Etvz9fao9iPpfFPQZlsFOVFA/MwY
 Fr/WVY9wC88ZyjVmPizd3ePZnAgQIrvdWP/HasY6kS5lmbdJ4Bxh2W/YbJhLRDSTvoSnqTY6L4+
 WBzD7YtUXTIt6A0fFxU3Z1wnKGGQONTPtu+Q==
X-Gm-Gg: Acq92OGBlsbAcuIgEi9jpSyKXvgkyJot7S17QwG9lbuUm8VjSLLbTlrlem/HBAZRf17
 DI7QCxPaMn1iIhd90lV32QXWCVAISGKa8hS16kzsIizA5TpEqIzJ+DfCGsLMVp7mHov+tbQmT2t
 bXTss4YU/lfzyFg3qHDIWqdhgKZaMdcyRD+Ma9JUXM2HVJf9F783yhQnl+ZcIJ89OVB83bhbE9k
 16nGv76uu+EoYZjC9vbnglUdA2n7Zk7dtHhC4JM+TlzT8b8YQDGI/rUraMwgHldjquVM3vMv2GV
 fdq9bI8wFGkKQNGUFH5elc345sFxa9Yl02CxWzhDv7Zjt5tF2R/G0k7t2X6Nk2E9Tzq1W8ufHgJ
 Ywt+Cl4P7xLzzp0gRm0O8rotB4bHJNtjEP7ycnsQA8xg=
X-Received: by 2002:a7b:ce9a:0:b0:490:bb3e:30c2 with SMTP id
 5b1f17b1804b1-4922011e03emr65403955e9.18.1781463947181; 
 Sun, 14 Jun 2026 12:05:47 -0700 (PDT)
X-Received: by 2002:a7b:ce9a:0:b0:490:bb3e:30c2 with SMTP id
 5b1f17b1804b1-4922011e03emr65403635e9.18.1781463946770; 
 Sun, 14 Jun 2026 12:05:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f263950sm27204743f8f.7.2026.06.14.12.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:05:46 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:05:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 qemu-stable@nongnu.org, Sairaj Kodilkar <sarunkod@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 002/106] amd_iommu: Update command buffer head ptr in MMIO
 region after wraparound
Message-ID: <3c98e446af825b5806c1e5cd1244b2431b15e884.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

When processing a command, amdvi_cmdbuf_run() increments cmdbuf_head and
writes it to the emulated MMIO register space before checking whether it
has reached the end of the command buffer.

If the incremented value reaches the end of the buffer and the tail pointer
is zero, the loop exits and the COMMAND_HEAD offset still contains an
unwrapped value. There are no errors in command processing since internal
cmdbuf_head state is always correctly updated, but the spec defines the
CmdHeadPtr field in MMIO Offset 2000h Command Buffer Head Pointer Register
as RW i.e. guest-visible, so it should be kept consistent.

Wrap cmdbuf_head before updating COMMAND_HEAD so the MMIO-visible register
always matches the internal command buffer head pointer position.

Cc: qemu-stable@nongnu.org
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260512150044.334867-1-alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 197e452e3c..5d6a405263 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1475,12 +1475,12 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
         trace_amdvi_command_exec(s->cmdbuf_head, s->cmdbuf_tail, s->cmdbuf);
         amdvi_cmdbuf_exec(s);
         s->cmdbuf_head += AMDVI_COMMAND_SIZE;
-        amdvi_writeq_raw(s, AMDVI_MMIO_COMMAND_HEAD, s->cmdbuf_head);
 
         /* wrap head pointer */
         if (s->cmdbuf_head >= s->cmdbuf_len * AMDVI_COMMAND_SIZE) {
             s->cmdbuf_head = 0;
         }
+        amdvi_writeq_raw(s, AMDVI_MMIO_COMMAND_HEAD, s->cmdbuf_head);
     }
 }
 
-- 
MST


