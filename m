Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCBCD74961
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 07:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWV5Z-0007m6-DT; Fri, 19 Dec 2025 02:39:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vWV5Y-0007lx-4b
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 02:39:48 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vWV5W-0003n3-B8
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 02:39:47 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-7bb710d1d1dso2356895b3a.1
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 23:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766129983; x=1766734783; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:subject:references:cc:to
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g1R3txfV5umEDebIavAWkdMvbkrb6tm0YQK/N40boXc=;
 b=NPK8sUUza+aE1cCacRfcyUjEFBVyM+tB15dfYxkCBHm2G6qD/8H/cK6pG2hnPvkyUc
 y+WypemEO/r8krAfPe7x64x7incsMDHZyN6UU+hl8ztYnoBUYLDcDo9MUN8tfF7b8nLa
 a6T1mGvBPID9QImnsiwSvYCbfLPN02YZZaKV84xqma5K/oEGt238WrD7b8VpxG4q9IHD
 1lBTyf2WkebrQOtKgzMDNTQHiBAB2PJrrwIgVqHlwPJSDdxHfNCaJQYBx9ica+KBLYLW
 AAc+nOxryIVJaNc4LW/BdH+on1VsUYi3HOaOilxRp+4xk6S4HTfQLcVZL/ThdxSM0zil
 C2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766129983; x=1766734783;
 h=content-transfer-encoding:in-reply-to:from:subject:references:cc:to
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g1R3txfV5umEDebIavAWkdMvbkrb6tm0YQK/N40boXc=;
 b=JYwAwaxYZtBt0GkC4ofBG9bzJzewt3Cq9h5sMjo0yjbQfdhMf3zJJopBRfmKJtbSu3
 Wt5HQsc6arS+tHIuUftH422Mdzj3rHd44Z3+jkV66GuaNwcEvc0vJ5roeNMqMJJD7wCy
 UZDprYPWhglTViug8FR7QXn6u3Y4vftdYz5VisxmvfcICHq1+1beIMQqq6rJkSbMF9vg
 5QN1UeRcdFv3paB8LJaSmWQtPlgdiN3DC0IrqbaeANI/Hmo9cMPGIkaB4h9rTZ6/eedh
 CZHD59v3rGB1SbbMdqT5rqEw/IZYW+DaLxPAssuVT5Fxb0lNMtICvDgd30KAU4jw9xMJ
 EoWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBB215g5yQ5tz3kaPAdIoiebq6GJjkUx9AjdBCb6+h1kgfjsqtKuBMtejv/1Xhujp+OfF+C9cz2kou@nongnu.org
X-Gm-Message-State: AOJu0YzUGRvcXGDfNIsGD2uedycr/ZMOIXrhSNM52bUdfmVI6TToA/v6
 Z6TkN68jQdKaeFXF1clTiuCwggw57NXYg6INRYRuDU4pg7gH6Ho+PgkG
X-Gm-Gg: AY/fxX7+6i6TD8gy3NjIbQPqpueVtBaDm/NRar1h1ko8TY826hkS8ra04F28eHunA37
 DCHWB5GA+hYnao9nF1M+OiWWUw+kjCYyB5KOYu5gyFgTxrbTcav1QMPhKPRh03qIhcgroyMusM7
 VkLv2kmVdnbznaSUDXH9LDfMdrKKF+e0XcrAihiWRL9XkDEI1p0ogM2D0bgvU72pdGhUwvj8UcH
 QkIgKTxJGdcE4RWq8B+tMk+fu9Ff5zArunPUCant6xdvvQYy0p5Vc/0WSf+VAtbISsPkLSmkvu4
 MEBk80i4kaYDuvwmqKuXY2ufk5c4PxxcWTVDijnuaZdVznLPrWqC9UkmcLgxOxymrtoXX8n7Bfz
 /tJe13Y0OqQ7QRSH+Vqx8i5m0qs6OX5VXOkuHHAbt/8QpX49Clcv4PspRnl2cv5nwuisvhCskwZ
 e3s+nt6NT0AN6DXDymVUPChfi3n9dH1gF5a5hfjw==
X-Google-Smtp-Source: AGHT+IFxGaCEZEb0DIy9o9ViW8PkLFtswNs8Z6dH3DE1ZIuLZFXV4Eai5N2TNmH8pksGMPI+dRpvmg==
X-Received: by 2002:a05:6a00:1d16:b0:7b8:bab9:5794 with SMTP id
 d2e1a72fcca58-7ff64cd8d51mr2076591b3a.26.1766129982913; 
 Thu, 18 Dec 2025 23:39:42 -0800 (PST)
Received: from [127.0.0.1] ([218.81.29.112]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e589b0csm1509577b3a.56.2025.12.18.23.39.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 23:39:42 -0800 (PST)
Message-ID: <18b5ec30-2a35-49e8-86ee-c0d4d7e149cf@gmail.com>
Date: Fri, 19 Dec 2025 15:39:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: sergeev0xef@gmail.com
Cc: halip0503@gmail.com, qemu-devel@nongnu.org
References: <20251218183122.408690-6-sergeev0xef@gmail.com>
Subject: Re: [RFC PATCH 5/6] target/riscv: Add PMU events implementation for
 `virt`
From: Chao Liu <chao.liu.zevorn@gmail.com>
In-Reply-To: <20251218183122.408690-6-sergeev0xef@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pf1-x441.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 18 Dec 2025 21:31:20 +0300, Aleksandr Sergeev wrote:
>diff --git a/hw/misc/virt_pmu.c b/hw/misc/virt_pmu.c
>new file mode 100644
>index 0000000000..afba06de0e
>--- /dev/null
>+++ b/hw/misc/virt_pmu.c
>@@ -0,0 +1,142 @@
>+/*
>+ * RISC-V Virt machine PMU emulation.
>+ *
>+ * Copyright (c) 2025 Syntacore.
>+ *
>+ * This program is free software; you can redistribute it and/or modify it
>+ * under the terms and conditions of the GNU General Public License,
>+ * version 2 or later, as published by the Free Software Foundation.
>+ *
>+ * This program is distributed in the hope it will be useful, but WITHOUT
>+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>+ * more details.
>+ *
>+ * You should have received a copy of the GNU General Public License along with
>+ * this program.  If not, see <http://www.gnu.org/licenses/>.
>+ */
>
The virt_pmu.c requires 'SPDX-License-Identifier: GPL-2.0-or-later'

...

>--- /dev/null
>+++ b/include/hw/misc/virt_pmu.h
>@@ -0,0 +1,91 @@
>+/*
>+ * RISC-V Virt machine PMU header file.
>+ * Copyright (C) 2025, Syntacore Ltd.
>+ *
>+ * This program is free software; you can redistribute it and/or
>+ * modify it under the terms of the GNU General Public License
>+ * as published by the Free Software Foundation; either version 2
>+ * of the License, or (at your option) any later version.
>+ *
>+ * This program is distributed in the hope that it will be useful,
>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>+ * GNU General Public License for more details.
>+ *
>+ * You should have received a copy of the GNU General Public License
>+ * along with this program; if not, write to the Free Software
>+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
>+ * Also add information on how to contact you by electronic and paper mail.
>+ */
>+
The virt_pmu.h requires 'SPDX-License-Identifier: GPL-2.0-or-later'

>+#ifndef RISCV_VIRT_PMU_H
>+#define RISCV_VIRT_PMU_H
>+
...

Additionally, some code lines exceed 80 columns in length. It is recommended
to run `./scripts/checkpatch.pl` for further checks.

P.S. The file virt_pmu.c is a new addition. Does the MAINTAINERS file need
to be updated? :)

Thanks,
Chao

