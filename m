Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFADC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 15:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWdFT-000156-Og; Tue, 01 Jul 2025 11:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uWdFP-00012c-3i
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 11:50:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uWdFN-0002lT-95
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 11:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751385011;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P/uTjjueacCrk9iWxrSPigoGAnsDBOasrqX6cOjFTgQ=;
 b=JDurwOBng+16w3h68hxvdltCnpiYTMhwt67qbk0e5LJtU4qJeG96+d2Ah+rM5Q5RvSL2bF
 kVRPD15MnP96cEKywR4sgmx/LGTwhGW02sn7NyX31UPmDUdMH3CQ095pzrf65XPWKnzX7I
 5RoaLxJN4+1P6brl81qFM6rgK4mx6MY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-sToQIaU6PZKwP-YZHPraNQ-1; Tue, 01 Jul 2025 11:50:09 -0400
X-MC-Unique: sToQIaU6PZKwP-YZHPraNQ-1
X-Mimecast-MFC-AGG-ID: sToQIaU6PZKwP-YZHPraNQ_1751385008
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-452ff9e054eso27999445e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 08:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751385008; x=1751989808;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P/uTjjueacCrk9iWxrSPigoGAnsDBOasrqX6cOjFTgQ=;
 b=JDhY0o83J4AJ4BQbqbI/ZlwURFEa4ww+Ck4TibQJky+rOBfUYuy7fnTzbYrGpDndw3
 qLWlEnKM+4vOYG8gtwQrtKmkKzJ64LKausHgQH5ZtWFrtRcfq7y6dYBJ0Ak7LXMrr7mS
 oLKzUiSfAqRP/cxt3NoldvDO3OLhcS7MzvSaFs/kBakefOBC6sDpBurCwHBPdbp2HVI4
 63YSLHxuYrdSibUqg1IXGM7+OIEDtWZrwgbKlAwj61u5IKJCXr+zonZEpwPRe0y2wdYb
 VS1WLzFbs3JM5fkaKnMd1HXjXV5cwhGZAMJJyq/9LuJTcF/w3s8ENmnSrbUdDqypuuKR
 IenQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtYRLt3FfNFS2LM0Ko67Lk5vlpGiyGrAwnJc42lBiMt//VkHzlT2+kfCcfQfZaJ5C1AwshRurufIdQ@nongnu.org
X-Gm-Message-State: AOJu0Yykng+x+Uap+upzseoZsCezmL4e/CzXHArhwj2VeQgNSObpl/L6
 R6lrabT2yUTs4pAPj+Ob7PzyZVvjAOZMUnumJvKP8dDp1KrsaUB4kCmC2aB7cJB0UY9PbENV8NU
 /HcPkxizJDtH+ViX2r4hb/hx9smrLOuOss6ND3dOYNjsMeJPV4vlnW8uP
X-Gm-Gg: ASbGncsf9OXhUZHbt9J1j3Oq2QCZtFhEhfP1szaIeeGHgL6IclUJX9gtgXIK0GSXmkl
 kGoYRd66U2Cumsz/RHyCDoi6P0HYsoeKfxhbLeoxCMDfR7Ye1fFEfVzN7f3++PwLllKI4D22PDy
 tFek0VcYJ9UtuPOyl0fHfwuZ7E05TquEfaQ9EzHfs3xRzZ3DqNN1+1dTN6u1uTkjZ3tL7/Qkmtd
 d22BFNPGAqAslOB6VWlDcslbldWRFoQcE+RIDDcPc5alXaGAZvfmRzCQGU+i/gguu2ajLS9c8I+
 K/O8Srd2NYADfxiUTSj8MTgRL5HpNGZavEHEdxkD0LrtkMrIqLaS1LHdPRmK495cPUT7Og==
X-Received: by 2002:a05:600c:5491:b0:43c:fe90:1279 with SMTP id
 5b1f17b1804b1-4538ee85900mr166291365e9.21.1751385008181; 
 Tue, 01 Jul 2025 08:50:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSjaCcv20JTLT5Z7l8zZE31W6uvOWaFUFaBFf+SLQsvyeRfijy3L3xJoCafOP1uED7rnpNlg==
X-Received: by 2002:a05:600c:5491:b0:43c:fe90:1279 with SMTP id
 5b1f17b1804b1-4538ee85900mr166290895e9.21.1751385007628; 
 Tue, 01 Jul 2025 08:50:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a40766csm171425715e9.32.2025.07.01.08.50.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 08:50:07 -0700 (PDT)
Message-ID: <93f59259-c720-4c54-8829-fb13cdb8abdb@redhat.com>
Date: Tue, 1 Jul 2025 17:50:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v16 1/5] hw/cxl-host: Add an index field to
 CXLFixedMemoryWindow
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Fan Ni <fan.ni@samsung.com>, Peter Maydell <peter.maydell@linaro.org>,
 mst@redhat.com, Zhijian Li <lizhijian@fujitsu.com>,
 Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: linuxarm@huawei.com, linux-cxl@vger.kernel.org, qemu-arm@nongnu.org,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250625161926.549812-1-Jonathan.Cameron@huawei.com>
 <20250625161926.549812-2-Jonathan.Cameron@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250625161926.549812-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/25/25 6:19 PM, Jonathan Cameron via wrote:
> To enable these to be found in a fixed order, that order needs to be known.
> This will later be used to sort a list of these structures so that address
> map and ACPI table entries are predictable.
>
> Tested-by: Li Zhijian <lizhijian@fujitsu.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
>
> ---
> v16: Tested tag
> ---
>  include/hw/cxl/cxl.h | 1 +
>  hw/cxl/cxl-host.c    | 9 ++++++---
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> index 75e47b6864..b2bcce7ed6 100644
> --- a/include/hw/cxl/cxl.h
> +++ b/include/hw/cxl/cxl.h
> @@ -27,6 +27,7 @@
>  typedef struct PXBCXLDev PXBCXLDev;
>  
>  typedef struct CXLFixedWindow {
> +    int index;
>      uint64_t size;
>      char **targets;
>      PXBCXLDev *target_hbs[16];
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index e010163174..b7aa429ddf 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -24,13 +24,15 @@
>  
>  static void cxl_fixed_memory_window_config(CXLState *cxl_state,
>                                             CXLFixedMemoryWindowOptions *object,
> -                                           Error **errp)
> +                                           int index, Error **errp)
>  {
>      ERRP_GUARD();
>      g_autofree CXLFixedWindow *fw = g_malloc0(sizeof(*fw));
>      strList *target;
>      int i;
>  
> +    fw->index = index;
> +
>      for (target = object->targets; target; target = target->next) {
>          fw->num_targets++;
>      }
> @@ -325,14 +327,15 @@ static void machine_set_cfmw(Object *obj, Visitor *v, const char *name,
>      CXLState *state = opaque;
>      CXLFixedMemoryWindowOptionsList *cfmw_list = NULL;
>      CXLFixedMemoryWindowOptionsList *it;
> +    int index;
>  
>      visit_type_CXLFixedMemoryWindowOptionsList(v, name, &cfmw_list, errp);
>      if (!cfmw_list) {
>          return;
>      }
>  
> -    for (it = cfmw_list; it; it = it->next) {
> -        cxl_fixed_memory_window_config(state, it->value, errp);
> +    for (it = cfmw_list, index = 0; it; it = it->next, index++) {
> +        cxl_fixed_memory_window_config(state, it->value, index, errp);
>      }
>      state->cfmw_list = cfmw_list;
>  }


