Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AE1CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXhH-0007KX-HC; Wed, 22 Oct 2025 08:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vBXhE-0007JW-1s
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:12:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vBXhC-0006KD-5Q
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761135121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O1Ns62Il11dff67zEJEgsd6ELKS8+Lx43eNF7ALkIgY=;
 b=dtOTz6WBPML9Zjl1IkDEALXHgaqQOIXzEFzf62aIwrqOQQQARq3/yDcnKpvnO1XAkgaR0/
 NtEC3ZCO+WYO8r0X2zXMHypVLgEOpZ+lLhyo9VteqX90QmEVLyZ2CHypu9sN12KRlbB9Ud
 B81YYQL3z0dWe6F2AyAwZvCwkf8fJ/8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-7wk0L4gINlqZRqdkS8T-Ig-1; Wed, 22 Oct 2025 08:10:42 -0400
X-MC-Unique: 7wk0L4gINlqZRqdkS8T-Ig-1
X-Mimecast-MFC-AGG-ID: 7wk0L4gINlqZRqdkS8T-Ig_1761135042
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-78e5b6f1296so197093986d6.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 05:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761135041; x=1761739841;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O1Ns62Il11dff67zEJEgsd6ELKS8+Lx43eNF7ALkIgY=;
 b=RU9MEhvbmt9ZVWMZYRTC5R2IMR3rT8Q0RhxF4z8nV5mhnlSpNpxC1XiAeaAzOv2yrw
 FiRU868UeT53nJ77teKsR9qX5UxD/cm4W9+9nlmHMV5v/wpXPyJ18RGboMB+wZrnDFJH
 Idfa0zR2BncHg7IvlwuwbOnOpn2KQdWchQrT9uwNIeln8szqnQVRdRpTIvPwcdY8hDvy
 daTqFhj1oWGMze65eO4XybuMWgOnhq9Pbz6Uvzy4cca8X6BI20Xxn6Tgw29Ulkvmhaja
 MNTNI8vM6Lc6kHZCLPwmMjnIXM4D+lsOIfblhCFzTXJPm2AKi+IspF75oRTg2v3cowVu
 XzvA==
X-Gm-Message-State: AOJu0Yyu0tdmnWEEFEdBlbZIbr4sY//OMK31uz1QkDV8rp4d3xHpzCvy
 3U155tr46ikIw5WCRU9+lLXBaxOFZifbXhL2gJrpxfHsQ1uAINcHLwQ3uHPyKp1n7ngR3/YhPjq
 jNvCodnbw0dI8kmYFBW+HTJvir64DJs8m54e4y7GqKPbKnxdBQk3BgZ38
X-Gm-Gg: ASbGncviHd0tj1NH9FW9LzhIcK8tj4IK2eG7s3NaOP6gsexgpe/Ey1fz9gXSkXQaqHp
 tS3kGPtHXPVhDbdjsRhJp8VUPt09v1vJyiCfkRVoOMEB+jIEvgJ2M6+6rC6HZebrjLA+A89Z6Or
 wkWIv5seRQjYRtlEV0WaH3nTCMyznUgTqhJk/Y2gZstSG0jdMWELVESqft4PTwDNa6ZeGiVdHUq
 vgLJLNNTXQwP8E/2q2HMy6WD8aC5p2yS6xZ8j+Zb5OLPIGxTH8Hzso2VO2zT0MYHBPxXHhYyG/8
 Wl0bCKfh/BwpRKX8y5tRQzEcr+C47AuB6ik2QL2VJqScD0uW043gq7OnP4a0f6BfxA4nIcFVd2Y
 AbPU=
X-Received: by 2002:a05:6214:2a87:b0:87d:e5dd:38ae with SMTP id
 6a1803df08f44-87de5dd40efmr84211706d6.9.1761135041678; 
 Wed, 22 Oct 2025 05:10:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqCDslirHqdpfO22qOm9tEQYWnZ7iFtFe7CbTLed/NQcipuaiCs18Kd9HIt0acLFNIpHzwow==
X-Received: by 2002:a05:6214:2a87:b0:87d:e5dd:38ae with SMTP id
 6a1803df08f44-87de5dd40efmr84211356d6.9.1761135041314; 
 Wed, 22 Oct 2025 05:10:41 -0700 (PDT)
Received: from leonardi-redhat ([151.29.47.252])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87d028ad9a7sm86701066d6.48.2025.10.22.05.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 05:10:41 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:10:37 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roy Hopkins <roy.hopkins@randomman.co.uk>
Subject: Re: [PATCH v4 2/5] igvm: fix off by one bug in memmap entry count
 checking
Message-ID: <fjw5ao27rwi2gaujth7xt22fjylpwoqd6qfuucltwpoznhjkx5@givogb6n44tt>
References: <20251022084439.242476-1-kraxel@redhat.com>
 <20251022084439.242476-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251022084439.242476-3-kraxel@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 22, 2025 at 10:44:36AM +0200, Gerd Hoffmann wrote:
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> backends/igvm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 723d45b755a0..055bbba745ad 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -567,7 +567,7 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
>
>             retval = ctx->cgsc->get_mem_map_entry(entry, &cgmm_entry, errp);
>             while (retval == 0) {
>-                if (entry > max_entry_count) {
>+                if (entry >= max_entry_count) {
>                     error_setg(
>                         errp,
>                         "IGVM: guest memory map size exceeds parameter area defined in IGVM file");
>-- 2.51.0
>

LGTM!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


