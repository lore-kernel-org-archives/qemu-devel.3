Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E163C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGVL-0007aQ-MW; Wed, 12 Aug 2026 17:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wuGVK-0007aF-9J
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:28:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wuGVH-0000iK-SR
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786570129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rHcJp8VQEJt1vuD+GwMaxhOl12/E0A4xZW33KXwOoLo=;
 b=fiY6nsO8j+TxRP1uS3mgLkPE2ze4to4xXHKAFAeMGwW1yy+O90uOOLF+WZXqPttu8mNS9Y
 6SjZNH8xJpXRYqf6EBQDixM0w3J3EXm/1tn/CQEBjEVX2vPzQNtqssYDFQWV4g6jQUjsJt
 4t9/4p9g4KvSkcrq1eHdiodaVZT4noA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-JOgxofrcMNeie3WmO9xLug-1; Wed, 12 Aug 2026 17:28:45 -0400
X-MC-Unique: JOgxofrcMNeie3WmO9xLug-1
X-Mimecast-MFC-AGG-ID: JOgxofrcMNeie3WmO9xLug_1786570125
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-495529a93f9so642155e9.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786570125; x=1787174925; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rHcJp8VQEJt1vuD+GwMaxhOl12/E0A4xZW33KXwOoLo=;
 b=Y2oYcrcXSomYrRuzPwBsAAUvsobFQgJVBB1mr4mEPuj2uHfGM/2o3TdK4nrfcjn9YM
 +458+y0oU8+Z3UkI+LvFEkqGg26RJfK+0NGESkHhe5jlZo9lMS4e3raABRnMYRz4qnz4
 byG5qjOLPuPAK/Zx8SuOy/oaMtvNiOLG4TntqhC60ZKykXD9YDHTJo+gxJ9DrjMvoydj
 m+QKQfG6lcoLzxqkvJqNf1FlKTqCEEAX8l/ngL6cSPUULqHIVTi3DM/0lsLlrL968v8w
 /kY26O3ZMMFq3xiPgijr6FBtJmpbWCDPcE8fc7gdvRv2tOJzEx2v5CnsYLsTeFJqawLJ
 Gk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786570125; x=1787174925;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rHcJp8VQEJt1vuD+GwMaxhOl12/E0A4xZW33KXwOoLo=;
 b=U18jOfYf3igkHeok1ue8Z+y5PARIer5MnP0hs0eJ1FshPFATsYUNSp2A8nBzruiqyo
 14Xre/hbsVGKyS/fLUf5nqMnXDefHEab6CB2ISJSB5ivDAQdxS0tBJcO0uoUdBYdlqkr
 ed+yLrTTdDfe9TFmDPnxlD13iYf+h2lXAfNBjKLfZzl4fjzdBibiu29Aj7P/tYCDtYOa
 wQWsqnyF8NXarx27rlfLYBVF4EPDqze1vKWRboATKILdCZQsp/B+t9xpq4S+t2AZSBGu
 CQRZdjnYPS/I7RQkXx4frA29R3TGTKWNnHMvmFndbLxZ7O5/6Rj7Ds0mRvzP3W2nBnnu
 pGYQ==
X-Gm-Message-State: AOJu0Yy+DLqWuapZsyiKiXt9eUHLDmyA2HKEl+WCeiNkPmXe9mSodobw
 wVbxUgk7dTt+2vrpdkIpKIDZ5gvQ1aVGNh59CqBOSh0g7SX96Ww+QnIhceM80zrcbK1HmNrQ1Ca
 fwc1WtE9YNYpW9p+QeC/OpTGC4elDmhXEP1Tmvdy4srddWyhirTBjEAQS
X-Gm-Gg: AR+sD11GUOKIu7BLweraKIh1sylv4PJgNB5Y13bmuVpUzINPZ6CGTiHg/Z9NxGi//2F
 DHFrOxw+hUK/AGVRNBjSCWy07QA+/Ne/tE4+uyl2V3EgNwsEAreDYXmoy//9r4BS09qhOffxBYZ
 7FyKBsqBrx6bza5TKcjcHkekwe5jwmw/+HmFDlIUil5/skUSDrQ7ZpKTR1PRoypcdtI9IPXyiIG
 r6vFNaSe/epYAOU2i60i7ynSt3pSXebZbvsY6wSs13NvsrSDxgYqmE2m7YxltUHNb4qS66w+Urx
 9KwDOi8ngmJf46P5Vna75BvsX7e24BWQcn3FJi5rO7jNFTHS5f6+9dJ8SRxkVhYv6TS5Jzyv3ee
 ABsI5icKNQFjylk8uCLqPug==
X-Received: by 2002:a05:600c:1914:b0:499:5210:c537 with SMTP id
 5b1f17b1804b1-499821c59b9mr4226525e9.1.1786570124701; 
 Wed, 12 Aug 2026 14:28:44 -0700 (PDT)
X-Received: by 2002:a05:600c:1914:b0:499:5210:c537 with SMTP id
 5b1f17b1804b1-499821c59b9mr4226195e9.1.1786570124234; 
 Wed, 12 Aug 2026 14:28:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-39-98.inter.net.il. [80.230.39.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4998216d082sm7762585e9.13.2026.08.12.14.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 14:28:43 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:28:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH v3 02/23] net/vhost-vdpa: Include missing 'qemu/iov.h'
 header
Message-ID: <20260812172827-mutt-send-email-mst@kernel.org>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
 <20260812211708.92824-3-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812211708.92824-3-philmd@oss.qualcomm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Aug 12, 2026 at 11:16:46PM +0200, Philippe Mathieu-Daudé wrote:
> vhost-vdpa.c uses methods declared in the "qemu/iov." header.
> Include it otherwise we get when refactoring unrelated headers:
> 
>   ../net/vhost-vdpa.c: In function ‘vhost_vdpa_net_load_cmd’:
>   ../net/vhost-vdpa.c:714:24: error: implicit declaration of function ‘iov_size’
>     714 |     size_t data_size = iov_size(data_sg, data_num), cmd_size;
>         |                        ^~~~~~~~
>   ../net/vhost-vdpa.c:714:24: error: nested extern declaration of ‘iov_size’
>   ../net/vhost-vdpa.c:742:5: error: implicit declaration of function ‘iov_from_buf’
>     742 |     iov_from_buf(out_cursor, 1, 0, &ctrl, sizeof(ctrl));
>         |     ^~~~~~~~~~~~
>   ../net/vhost-vdpa.c:742:5: error: nested extern declaration of ‘iov_from_buf’
>   ../net/vhost-vdpa.c:744:5: error: implicit declaration of function ‘iov_to_buf’
>     744 |     iov_to_buf(data_sg, data_num, 0,
>         |     ^~~~~~~~~~
>   ../net/vhost-vdpa.c:744:5: error: nested extern declaration of ‘iov_to_buf’
>   ../net/vhost-vdpa.c:748:5: error: implicit declaration of function ‘iov_copy’
>     748 |     iov_copy(&out, 1, out_cursor, 1, 0, cmd_size);
>         |     ^~~~~~~~
> 
> Fixes: bd907ae4b00 ("vdpa: manual forward CVQ buffers")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  net/vhost-vdpa.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index c526c2b2dc0..1052361a4ab 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -17,6 +17,7 @@
>  #include "hw/virtio/vhost-vdpa.h"
>  #include "qemu/config-file.h"
>  #include "qemu/error-report.h"
> +#include "qemu/iov.h"
>  #include "qemu/log.h"
>  #include "qemu/memalign.h"
>  #include "qemu/option.h"
> -- 
> 2.53.0


