Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C068CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZjuy-0002Mc-HQ; Wed, 17 Jun 2026 02:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wZjus-0002H5-OI
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 02:38:28 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wZjup-0007DE-Mi
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 02:38:25 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-490b613a17bso48763115e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 23:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781678302; x=1782283102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9l/hy1xbCfLWccES+CpuB+eSfsZvaN4g5AqB1Qo27yQ=;
 b=c59Ro65dqDcOCZUOVxRGOelInsj6Fw3hT6xy3RKjCLlkf6Ykfd0ZdYFvv7yETSTXPN
 t1y+teXYlg6JwhzV50pypOeZ+1Fg4pedCVvn3Ug6vlCzjsJAnVAR6vjwkSpr+u28Fe3V
 Jbo15wzdXb+Kp/zjFu9temP1nuffyiZ0W+8lCgoQv2BRjVfiIUS01/obFMRBK2kT4kqr
 okyRtZPvE2dwC6qaXihUKNnOMFOdssdYylMbguYrGqk3dUCJ9UJs52RmrUd6DBE/E3pw
 sJugnx5OPX49hyjxYyLIAiDZiZBp8nWmPeDg7LIKxOOuNWhKdbELURSqJjWVBRGWyciw
 0+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781678302; x=1782283102;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9l/hy1xbCfLWccES+CpuB+eSfsZvaN4g5AqB1Qo27yQ=;
 b=DUbixnztiQYCQvVqdqUq6IYy/99NjwwOeEjAbkLgHXXcMtZtc9Ea9Qm1An1tJYX8yF
 kZ7ev14EDIsL6ayts3NM9fBRY16v9JPHwqUb1DfqO8C/F1hZMXi1IHRtMvLjodIfILll
 zBXXywjpo0yaIJO9Dtk7O4TVDx+WHXxEf5nb4eD2tEc1ukf50gmtV6qIh9THcoTsTrOy
 BKNN3I6ZbIR0GkG8S3mkrPHFF+BFylfVTT5hqbxH8Q09/vLi27qEIFjnoSK47KJmY/KN
 DYOYnW4rNjLzhR+216u0nB6+vpqxEQxQC3JXkOfE06+x10StUhDBTcVfKSHC7yrAopIJ
 WFIw==
X-Gm-Message-State: AOJu0YyTUZgFVed1a8xyRSYBt/dpxrObBW6ZVzbSLduof4vgDNS2wClQ
 wnyA/QJCgOpsb8l4X8cPnwbOfqKgDa4hc6uVyAPsfOMFGhWLZay8jV6sUgT/0aZYZBUxm4Dq80Q
 +NwmAeiQ=
X-Gm-Gg: Acq92OHkpDk6CEKqIBOEqqBHXMZwA1zxOVV8NUNqpJoR5uVSaZyw2EdR2hh2RY8eby2
 +eDURZMiSBCoGyIbRF9yfFwD7NILYfaKMiAcSyBLnybj4hnjAk+jVQQHQW9DBZ6mn80ziJ88/Q/
 suXD6+oNd9KJ+cWpbNMnTBuhMC8tJSVrgoAgrreY5JEKJ6ah2qIKj81dRM+M8NHzp+bj3nzKl/M
 sSMhRO69e1p56iAUphETtke2jXccC6XitRT9HPL/mUfOQZomSsjRkbM9peGXLApkw+k4PPcMsVH
 ytvx2q1jnDFWWyxN8PwiqFJ4ixi9S2Pvg0bjpZoA1Nq6YfKIWHXhd8/+WMIHv71uYCEheRtnw7U
 cBU8Q1nQHaSP4a46mkEtB3dzrYK0z79VYby8gmQTr6dlFlP+TcCaTGr56uhao80Kv5FNyNEpKd8
 OZazGMVr1vRvGebMQf9Wq1Z4cn9Vh1DRSNUvDjWv4IWJH21ncvayqCghtgvhQXUQnQziSrjLQsw
 mQm5gE/duNMldPgMw++yhMUoP/N3NDhxj8QSskUQoJuQtWKafmmlrm2lXDxz7noKYFvW8gKcj5j
 ybERekvO5uZWdyztzL/5A0lX5t/VxlkyKQ==
X-Received: by 2002:a05:600c:34d2:b0:492:34f5:94cb with SMTP id
 5b1f17b1804b1-49234f5956bmr7272465e9.26.1781678301772; 
 Tue, 16 Jun 2026 23:38:21 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-135-183.home.otenet.gr. [2.86.135.183])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa97a07sm235174985e9.14.2026.06.16.23.38.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jun 2026 23:38:21 -0700 (PDT)
Date: Wed, 17 Jun 2026 09:36:57 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@oss.qualcomm.com>
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 2/6] accel/kvm: Replace legacy
 cpu_physical_memory_write() call
User-Agent: meli/0.8.13
References: <20260616020839.19104-1-philmd@oss.qualcomm.com>
 <20260616020839.19104-3-philmd@oss.qualcomm.com>
In-Reply-To: <20260616020839.19104-3-philmd@oss.qualcomm.com>
Message-ID: <tgrjrw.24dyywuesg7bx@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 16 Jun 2026 05:08, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
>cpu_physical_memory_write() is legacy (see commit b7ecba0f6f6),
>replace it by address_space_write(). Both if() ladders only
>differ in the address space argument: rework to have a single
>address_space_write() call. No logical change intended.
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> accel/kvm/kvm-all.c | 12 ++++--------
> 1 file changed, 4 insertions(+), 8 deletions(-)
>
>diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>index 96f90ebb240..f4f0e64fbd0 100644
>--- a/accel/kvm/kvm-all.c
>+++ b/accel/kvm/kvm-all.c
>@@ -3178,16 +3178,12 @@ void kvm_flush_coalesced_mmio_buffer(void)
>         struct kvm_coalesced_mmio_ring *ring = s->coalesced_mmio_ring;
>         while (ring->first != ring->last) {
>             struct kvm_coalesced_mmio *ent;
>+            const AddressSpace *as;
> 
>             ent = &ring->coalesced_mmio[ring->first];
>-
>-            if (ent->pio == 1) {
>-                address_space_write(&address_space_io, ent->phys_addr,
>-                                    MEMTXATTRS_UNSPECIFIED, ent->data,
>-                                    ent->len);
>-            } else {
>-                cpu_physical_memory_write(ent->phys_addr, ent->data, ent->len);
>-            }
>+            as = ent->pio == 1 ? &address_space_io : &address_space_memory;
>+            address_space_write(as, ent->phys_addr, MEMTXATTRS_UNSPECIFIED,
>+                                ent->data, ent->len);
>             smp_wmb();
>             ring->first = (ring->first + 1) % KVM_COALESCED_MMIO_MAX;
>         }
>-- 
>2.53.0
>
>

