Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFFDC44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlmMh-0002WN-8V; Mon, 20 Jul 2026 07:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wlmMf-0002Vq-Ln
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:40:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wlmMd-0001Av-7M
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784547650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IstgpN6J15JMjZtfRaOyDhxq9Y0Y1bmwxtSGFea9aIw=;
 b=RY+HmGyGmPRwv8E3cjBRHwaix4e/Yzs+QueZLuYIdiNkIra03kRBMmt8l0OukbVfqLH6Tf
 jae3eEj10MYhvCIZLu+t+DI5V8TjIvd5xW1IfVhJWkwRrbS/pZff6O7iI/WTmeFyR1r245
 c89ixZS9MgnySse0ZZBLLN1ewHrASL0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-bHoeBe-jMSuWcXSVTjr2uw-1; Mon, 20 Jul 2026 07:40:45 -0400
X-MC-Unique: bHoeBe-jMSuWcXSVTjr2uw-1
X-Mimecast-MFC-AGG-ID: bHoeBe-jMSuWcXSVTjr2uw_1784547644
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-472c330e555so4863029f8f.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 04:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784547644; x=1785152444; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IstgpN6J15JMjZtfRaOyDhxq9Y0Y1bmwxtSGFea9aIw=;
 b=ssx5LYZ7AMPZGW52pCJxu/hr+o2tTmNkT8/lRO7Di22t65BoMXCy++FBcM0ljCJzCK
 gX/XQxjlgy9zpQjw7sEOwtsIm3wfg1BUep0jPjMhsPFE+NEVKc1SqV84TXdRZzyCnsWG
 N2VmOrOPfCZfteUhG+Pp62bdgDoRUofSfKNy3E3DgZWUbSVwkfDmRcUvga8xSzjXbDjM
 EwdT+UcoIUT4Ij4J4S+Xw1VEMhfz29aEDm0aL4Y+dkWqiCMym4M2NgbicIwFbU5KRaKi
 +3bO5rGl719YUvXuqFu/iXCyfdGIPgLyo8l2JJz4sWl+qvsUvkd2mIjP7RxIL3VAJFkV
 XAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784547644; x=1785152444;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IstgpN6J15JMjZtfRaOyDhxq9Y0Y1bmwxtSGFea9aIw=;
 b=NWaxW3UNUnvqBMMOMDQq/ExiK/kscR36U+xbe8oemn1LlGF9QK8YsJAk9OQgB8GM52
 WleKAKf0XgAUgowceJzh6834r26DwmjL4yEvqpOW4tYRlsUqCucqvT5VfiFp5ScKLj9a
 kAHZgiVqd0W19QnO08V/SjsqeKWOn+jmORjxcO7bVy5MGOw23ph03TfRQm5rxOsOzTLM
 9n+4OiJjdIHpRZA7GU3R5klBMKY5HHOPyA7ewwxgpWvxA+8uqxyLIawNrczpDCfaoS5Z
 QAOVSDz/x2OIfLuyOuU0CVvWGy/5od9UW0IJ5l7x7+QYqJKX3z+YjICQJ4HR7DJLltaZ
 7uDQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RruuZBo5Bhf3QY9y+5QY8Id1SQ7RtSW/kHcF+I64dtpl193Jwsw3nqvkyfMgb1Yy4ziItNQOYSHu6/w@nongnu.org
X-Gm-Message-State: AOJu0YzZTj4COUuQZGTzqxHrB4ILnqc33v6n58pOK0XzehTdjDOH/0lz
 2my3Jdcl1jak06PVw0Jzu3/J8cn1GsyrEzpSFfSmKCy23OllJq2j+WcdSWRnrKQS3sBzwknfeiP
 Rzp4MF3Hn5ygsRj7UmuDM4k39O3czlaFQYnjlDFC2t55Uk/1xRQPsnglF
X-Gm-Gg: AR+sD13/KoDxwYhlwtXLrEPyYHc2BylVJbDpoj+4VnKCsWRB/Wdy+X/kACKn/AM7d67
 MDHo0J01AiYFytHIcIOLU1vfZ1nBRXgvCp+UGZZNPVs1C756qGfoixW9YDBEZQ4xEah/EsglXOg
 DGtXHRPVsVS143w5mm4CoGonmQk81aGerMM5Ei/U0R6PH19Z61sE33UgfD7fziAPBrOUAnW1IL/
 g3ppZ9qzEIitg1toUFNVosTfYcYYnMWlOJn+GA73z4drTUjZ8YzauZu2MmfjZMaGTi3LyAI6jsF
 xZwWeh9pQWW28FLU6737h9Pu+fuiYHflOuB/CgkS00jXea/kQT4Q7keQ+JS89Peh4/7pfXYUvpz
 x9KzmKwFTLLHdXyp2rxlfe2ncGKSEagV992xenng=
X-Received: by 2002:a05:6000:2906:b0:47f:788c:4c8b with SMTP id
 ffacd0b85a97d-47f788c541bmr3838620f8f.23.1784547644333; 
 Mon, 20 Jul 2026 04:40:44 -0700 (PDT)
X-Received: by 2002:a05:6000:2906:b0:47f:788c:4c8b with SMTP id
 ffacd0b85a97d-47f788c541bmr3838575f8f.23.1784547643827; 
 Mon, 20 Jul 2026 04:40:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49469sm30383646f8f.7.2026.07.20.04.40.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 04:40:43 -0700 (PDT)
Message-ID: <71a1d159-3bcc-4bcc-ad31-05d4641456b5@redhat.com>
Date: Mon, 20 Jul 2026 13:40:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] vfio-user: vfio_user_get_region_info: prevent
 excessive malloc
To: Thanos Makatos <thanos.makatos@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: John Levon <john.levon@nutanix.com>
References: <20260720091718.2642-1-thanos.makatos@nutanix.com>
 <20260720091718.2642-5-thanos.makatos@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260720091718.2642-5-thanos.makatos@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/20/26 11:17, Thanos Makatos wrote:
> If the vfio-user server responds with a value larger than max_xfer_size
> vfio_device_get_region_info() blindly uses it in the next loop in
> g_realloc. An value larger than max_xfer_size is anyway rejected by the
> check at the beginning of vfio_user_get_region_info(), however that only
> happens _after_ the g_realloc, and if that value is excessively large it
> can cause g_realloc to fail, so check it here.
> 
> Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>
> ---
>   hw/vfio-user/device.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
> index 1907a6653f..d7cf39dda7 100644
> --- a/hw/vfio-user/device.c
> +++ b/hw/vfio-user/device.c
> @@ -171,6 +171,16 @@ static int vfio_user_get_region_info(VFIOUserProxy *proxy,
>           return -EINVAL;
>       }
>   
> +    /*
> +     * The server can respond with a larger argsz in the reply to request a
> +     * larger buffer on the next iteration via vfio_device_get_region_info().
> +     * Reject values that would trigger an oversized realloc.
> +     */
> +    if (msgp->argsz > proxy->max_xfer_size) {
> +        error_printf("vfio_user_get_region_info reply argsz too large\n");
> +        return -E2BIG;
> +    }
> +
>       memcpy(info, &msgp->argsz, info->argsz);
>   
>       /*

I wonder if vfio_device_get_region_info() shouldn't also have
extra protection. See below.

Thanks,

C.


--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -28,6 +28,12 @@
  #include "migration/blocker.h"
  #include "monitor/monitor.h"
  #include "vfio-helpers.h"
+
+/*
+ * Upper bound on region info argsz accepted on retry.
+ */
+#define VFIO_MAX_REGION_INFO_ARGSZ  (64 * 1024)

  VFIODeviceList vfio_device_list =
      QLIST_HEAD_INITIALIZER(vfio_device_list);
@@ -236,6 +242,12 @@ retry:

      if ((*info)->argsz > argsz) {
          argsz = (*info)->argsz;
+        if (argsz > VFIO_MAX_REGION_INFO_ARGSZ) {
+            error_report("region %d argsz too large (0x%zx)", index, argsz);
+            g_free(*info);
+            *info = NULL;
+            return -E2BIG;
+        }
          *info = g_realloc(*info, argsz);

          if (fd != -1) {


