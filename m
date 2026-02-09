Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B471EF0704
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 03:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpHmd-0007kH-5X; Sun, 08 Feb 2026 22:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vpHmb-0007k2-4A
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 22:17:53 -0500
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vpHmZ-00019s-F4
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 22:17:52 -0500
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-8c7146b0854so424013385a.2
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 19:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1770607069; x=1771211869; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Yrihy7m7R30/wsWkuTp3J7G3LZei4OIo5nmGEHyvNrI=;
 b=N3bwd3WlmE17UTGrmvivUDs7ncGGCxJA14xJX2qaedZLoxr0QFo2ZAcLaRwL0Jc4ys
 bS8ZrMxSioEwk0LKDahj/ff7OR4Wg/Ru0npcX2NphUj51B6w8YFa1XOxaWkcCIE0hMb3
 TfrEjfe3C9rhCyBmpnitIdMVtUCKgZSij6emD3hqiKkE3XBN63F1RjhLoxvy8oSZhr0I
 zdvcGcy4EypkXF74y6BZdQVwVPLooQGOq3SRAUJi55x07BvvEsXDkUt0mvzXm+Idy+N6
 n6OnJLJ1Hce+W6aa8epHK7+chJa378qEbkG9mI2srOoGn627ZzY+Rad11cf9nzGkM8lG
 1eXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770607069; x=1771211869;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yrihy7m7R30/wsWkuTp3J7G3LZei4OIo5nmGEHyvNrI=;
 b=AZIpkI8qgWlKfVv5qcVdl+nBk50fFVaKrPLDsdykCgAWGXJLgTefv5ENmPlw6a1vQ6
 pcz0TNlN9XtEptqGWnAlH0IM/5YYRn0agv15G+Gg/SqsZUel3wZJ16UxYhrN4YtH4xPx
 wNgximAQLpJdfjFUpA7GbBopHtObx9kwzm7zlH5nuR7ugw2CUe80CmpvJ3DAzt4NGrBb
 sd/p8ahfvvvH24lt/6IixtkMee9vxYAhDgdJXgTI22M9gafxPXFy4wqhR3x7p21Ag06x
 L567a4qZrznW5ZQbtP1LdEPMMg/Bz0trd0sASwknYsERap/S6oI1NKfTIYx/XCs5oKfd
 1rrQ==
X-Gm-Message-State: AOJu0YyTbDQCIQxHf42RqM9LptU5q0JGHVHUc/+3YN41hYHgAofhBHIM
 CiZOhVu1yzMca3e1EyP/wFB6H9cNfree7MkzVEF0GJPOGXLI6sj57nAHvbCQMxHPsp0=
X-Gm-Gg: AZuq6aIrXb4DR3dMXLvoJV71NGUVIwudjHJuNO3b7TSp90Ep4cRJVzhxuY4GijHcDTL
 VUj9wy8b/GssX+bQdBS4sOXevq4PA2ubVN2iRXx/DKmDKCIm0d5YfS4wW5RyDUbgw3P8WSLts0Q
 vIqD2VdNZE4Ekz8Gu71b0mIsVUvrNryVbodnO5HFoa/eG0ir1x/ztx2XM/blgV8ftjF8CWBWqGv
 6C5168yJG9SbGsYzK5q5Se87MJ5DHlznkf/5zPdCLQNgJHZChUKSrkMiyL7P87D2cpUdkSEdgFq
 dKowuUBcRQYUGDOGw8d0eY73uyUWVY4Uu32PudHafNUdNKU7+v92vnDcZKl91f2F3+/3SG98XK/
 Kdbq0JUkYP6C7vuuq+iZ/xvyVoxQ3Ft7zAHSLxMqnLry5Rav22pjn17aRCQ9b9iZLWzVPECAi3a
 75lNwSOC5F9rHTWTgJSpuVPUZLHMih9/mxG7SZ3XZ3iqeqWIfjCAwfnRIkMkdhd4aTmaBrLw==
X-Received: by 2002:a05:620a:370f:b0:8c5:3045:3e7b with SMTP id
 af79cd13be357-8caefeb71a6mr1246935485a.26.1770607069324; 
 Sun, 08 Feb 2026 19:17:49 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F
 (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cafa3bf1a2sm780895085a.47.2026.02.08.19.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 19:17:48 -0800 (PST)
Date: Sun, 8 Feb 2026 22:17:46 -0500
From: Gregory Price <gourry@gourry.net>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, linuxarm@huawei.com, jonathan.cameron@huawei.com,
 nifan.cxl@gmail.com, anisa.su887@gmail.com, mst@redhat.com,
 armbru@redhat.com, lizhijian@fujitsu.com, ppbonzini@redhat.com,
 peterx@redhat.com, philmd@linaro.org, david@kernel.org,
 imammedo@redhat.com, xiaoguangrong.eric@gmail.com, venkataravis@micron.com
Subject: Re: [PATCH v2 0/2] Performant CXL type 3 non-interleaved regions
Message-ID: <aYlR2loIsnf8Q6YR@gourry-fedora-PF4VCD3F>
References: <20260204150002.669-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204150002.669-1-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=gourry@gourry.net; helo=mail-qk1-x72a.google.com
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

On Wed, Feb 04, 2026 at 02:59:59PM +0000, Alireza Sanaee wrote:
> The CXL address to device decoding logic is complex because of the need
> to correctly decode fine grained interleave. The current implementation
> prevents use with KVM where executed instructions may reside in that
> memory and gives very slow performance even in TCG.
> 
> In many real cases non interleaved memory configurations are useful and
> for those we can use a more conventional memory region alias allowing
> similar performance to other memory in the system.
> 
> Whether this fast path is applicable can be established once the full
> set of HDM decoders has been committed (in whatever order the guest
> decides to commit them). As such a check is performed on each commit /
> uncommit of HDM decoder to establish if the alias should be added or
> removed.
> 

Tested this on top of Jonathan's most recent draft branch, works nicely
(with obvious fixups mentioned here). Has been working nicely.

Tested-by: Gregory Price <gourry@gourry.net>


----

Jonathan the HACK patch was giving me issues with registers getting
plopped in the middle of a CFMW, not sure if this is the right fix or not

Fixes: 9a1b11bc03 hw/i386/pc: Add Aspeed i2c controller + MCTP with ACPI table

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f9d0bb3b41..9c244d40a7 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -957,8 +957,8 @@ void pc_memory_init(PCMachineState *pcms,
         memory_region_init(mr, OBJECT(machine), "cxl_host_reg", cxl_size);
         memory_region_add_subregion(system_memory, cxl_base, mr);
         cxl_base = ROUND_UP(cxl_base + cxl_size, 256 * MiB);
-        pcms->i2c_base = cxl_base + cxl_size - 0x4000;
         cxl_resv_end = cxl_fmws_set_memmap(cxl_base, maxphysaddr);
+        pcms->i2c_base = cxl_resv_end + 0x1000;
         cxl_fmws_update_mmio();
     }


