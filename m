Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945F1CCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 14:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFvrZ-0002Tt-Mv; Mon, 03 Nov 2025 09:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1vFvrV-0002T3-MW
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 09:48:49 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1vFvrK-00066E-RI
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 09:48:49 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3407f385dd0so2693421a91.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 06:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762181312; x=1762786112; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=FAOk0U5gF4egRrtfZZEaWs4AoTgM5PyCV8jy1WJQ0rw=;
 b=JalJ8QyHgWVFh355FBTRYNnFeRQhMq8o1VNQSVoacN06lt4i10X/YnadDZq3yhvau1
 RGekCz+Uzi9U4/GU0Fgbgjpvug/VWWsz9X/R9m3dv50IhZ8A3WanpWmRRWXyNjU1WhOv
 vbOx9jtZcdezcnGsQPfaM1aANkelD8WUqil1K7qd7WIAF4NTDNkr8gWoxu3S5j4GjmBo
 hCeTTEgua2k0F0LPHHl35iOzesPNGc0NhT+8H/b2++Jq2kMzTSY4zjdMUTBxOR/nv+Vm
 MrO/PQ1B8khnzIi+8g2IzRY5nmIhz7Dz4+JE9r/TcCh8N5p8fos5rqN8Q0YKjfba5m61
 ZkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762181312; x=1762786112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FAOk0U5gF4egRrtfZZEaWs4AoTgM5PyCV8jy1WJQ0rw=;
 b=VZ9LKcGb5dJMXRxCwd4XW1RvtjTlMfW9MMPJ4x3dCVHUsX4P5SZ+AZ/Nxr/hcrcP4c
 H4MgqiI0Y9QJrFeHy1A6Z3VBre2vBO0jJXEOZtuPVkvl7yhJV2M2s7SlB+XTEAK6uNVk
 gQhaXDilsyvF5Unhg+52G8L7lqiZOP6R0+4dLjsjAtL6T4XRwJWt/wi3f6hiDN5C8cFG
 M3JnXaLdo19+/oBCJLy20voh/iWD9jq2MIC3bWvIjjLjZGozuy5wIDHaGgs2L2UWHRG4
 nXMtRN3G+HzfJFK1SXUayny4lOHo5CBsQUzCydO3RgxKHz8ovrhIo+KPI1H9KubbOz9A
 0IIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyl6YNAsgEAJZIfpWb8mbfSVtPic9iRJ5Hnw6+zcdMFBq/J9UHfdsH9R8wU1KxpYgfN4AHQQwUQQn1@nongnu.org
X-Gm-Message-State: AOJu0YylRqAymVHSJ8/cG/47Yrq6MZt88uRZQQSHafYLzTr1yWa6EEfW
 cLlOehKe/m0O5sq8exZbW0BWWL8rdrCYTWYQlVRyiBaOQdDK3kalm0E/U4jyjg==
X-Gm-Gg: ASbGncsqfijWsfjibDlrQHljJiJ5d8Z3wQ0lXsc5SCect0axLYpvcFCgF/mcqEJMZL3
 UPdxcsEVJrBrD4qwMRh3ly9EC6FDKohiw+P78xjzZCqXclzcL5u6tz9ftbWI0eHDjvwM0W+aDXM
 5RQ3TCbTaLgG9jHU3hUkJc3znWlZQs0WGMlOzp7kHs43sJPVimLlhk2r0B9KRkVE+Ve7dRIewbZ
 Oy7Z6twmZB724Z3pjyomPhvNjT8c+qV6y6HT2gZURwMNHHf25MtMh91GvOFnhxvdFsfD3cJ/WnP
 XHvv6ph5avujUzKNYkKvIuUZR9rZdyeodI0nTN3imVwaDNFfT0KERA9orhGvyRFA0YmGPfZcDUv
 MNoLzh0foUj2Wl9so477RdCDVrcWMkpCcN0efPeQY+eXS/e0I+oqIiENAYv96oKjobzhtBe3bJx
 v1vH9hpCk2nQIo
X-Google-Smtp-Source: AGHT+IH6Vap7GRqyxgpPHd7CAOtgiXhejTz9l7zH09gmHQ3JpEyJ1rSKOmyWiE0Ci6+oc9xSuUysZQ==
X-Received: by 2002:a17:90a:dfcc:b0:32e:8931:b59c with SMTP id
 98e67ed59e1d1-3408308a9b4mr14397425a91.27.1762181311974; 
 Mon, 03 Nov 2025 06:48:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b995a439df3sm5645728a12.2.2025.11.03.06.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 06:48:31 -0800 (PST)
Date: Mon, 3 Nov 2025 06:48:30 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Cc: mark.cave-ayland@ilande.co.uk, sarkarsoumyajyoti23@gmail.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, deller@gmx.de,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3 3/3] i82596: Implement enhanced TX/RX with packet
 queuing and filtering
Message-ID: <7eb3623e-02a2-4287-8a81-653082ea1902@roeck-us.net>
References: <20251103112723.12256-1-soumyajyotisarkar23@gmail.com>
 <20251103112723.12256-4-soumyajyotisarkar23@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103112723.12256-4-soumyajyotisarkar23@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=groeck7@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Mon, Nov 03, 2025 at 04:57:23PM +0530, Soumyajyotii Ssarkar wrote:
> In this patch I have added the following:
> - Rewrote transmit path with CSMA/CD collision handling and retry logic
> - Implemented flexible TX buffer descriptor (TBD) chain processing
> - Rewrote receive path with packet filtering and monitor mode support
> - Added RX packet queue for handling resource exhaustion
> - Implemented queue flush timer and management
> - Added RX state machine with proper state transitions
> - Implemented packet filtering (unicast, broadcast, multicast, promiscuous)
> - Added SCB RU_START enhancement to find usable RFDs
> - Implemented dump command support
> - Added bus throttle timer loading (LOAD_THROTTLE/LOAD_START commands)
> - Enhanced signal_ca with proper initialization sequence
> - Finally, adding self-test functionality
> 
> Changes since v1:
> As suggested by Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> - Removed inline from the i82596_translate_address() function
> - Added trace-events for 82596 rather than using the ENABLE_DEBUG flag
> 
> Note:
> With this patch, and the previous ones in the patch series, we would be
> able to achive proper 82596 NIC emulation.
> 
> Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
> Tested-by: Helge Deller <deller@gmx.de>

Tested-by: Guenter Roeck <linux@roeck-us.net>

