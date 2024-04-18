Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0491DC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 12:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxQXB-00066H-IJ; Thu, 18 Apr 2024 08:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxQX4-00065G-Bd
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 08:06:26 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxQWy-0000ZE-5Q
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 08:06:24 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-343d7ff2350so520921f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 05:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713441977; x=1714046777; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yM9th1h2HdGZE07rNRCCQrkuhW42+eTdSWBG5aiwqL4=;
 b=MLVJlJOpKCllzsHK/D3gB2FrgueflNqU0mlhR5KjYmuHRHXo+xyi5gjOE7570quPc5
 cQucs5bIy09Zak0Sakh2CiLqgO1wAb1s/dP4T7P72lGLzZ2GVaHJ1Jk1CGI9b/0QgJBt
 cA2yXTPsBBA8ytxh7vb7uPzjIpqOxRHGGQZyWDpDNhx1zhcfRtnVEHEWsNPUxnm+soAy
 MLymXdM4SYEbL7IEpqxn8aY+w1zvPO1nI/OIEeHAnYPZQ11zOZpn9nzi8bTyWtH/9Tcm
 QzMMnpZonbeoTVWBhLvT8cOkVWCeZxq6EZ2jkCHnGa+WvIEGDP7CMEIu1Y4cY6ORdQpA
 LM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713441977; x=1714046777;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yM9th1h2HdGZE07rNRCCQrkuhW42+eTdSWBG5aiwqL4=;
 b=fSc/Fiet5B/JWHfXUtxP0IRMHktBnlP1iEB3Q+9+cgs4zIyK0LOCZdEB8icuMQii5c
 nXiCR026mYnXpg+NytlVGgBh1mDwKwgYEUZTdk9tqqo0fgckFg/CHK8quSnB+08K3ZjW
 YAnz0Q6tJgif1GwoepN5l1kwMvIW4P0xFOKMHWavNT6bZ0Amlv+hHKj0IyDbt/yah1EX
 AmtCBQRVGwGmeo/T1e4VZ7t4X4LFB7+pJj3PeameBRAH2iUcBhwwuDySybqW+Ro13QwK
 ERgvPyfWEJRGWXe/p+/0yhgabxgoZxHPHp6OAIPd3Gu+0CYCjDM0B75HFgrwr3TU40QS
 JwSw==
X-Gm-Message-State: AOJu0Yz20Q6Pyx+B7AdqMJx65rQ2fknzyGIIb5ud7EeHZrg5egf7iFqx
 ay7np+8wrD+NsQslQ9WmQ3Z7OrwFWHJGjCJHW4vQivL2HuCwiRpaPfThOrbpufU=
X-Google-Smtp-Source: AGHT+IESB+MPkuVm1ugYa4JhPqKJSR2fvge0kura5dBzqvNq2+6UPD9vZbwvc26MJNj+QS6/awR/CQ==
X-Received: by 2002:a5d:4ad2:0:b0:345:d9ac:cd5b with SMTP id
 y18-20020a5d4ad2000000b00345d9accd5bmr1555136wrs.65.1713441977575; 
 Thu, 18 Apr 2024 05:06:17 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 iv20-20020a05600c549400b00418e4cc9de7sm2041949wmb.7.2024.04.18.05.06.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 05:06:17 -0700 (PDT)
Message-ID: <619e668a-67e0-4d25-aec8-9cc13a5c15de@linaro.org>
Date: Thu, 18 Apr 2024 14:06:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/cxl/cxl-cdat: Make cxl_doe_cdat_init() return
 boolean
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20240418100433.1085447-1-zhao1.liu@linux.intel.com>
 <20240418100433.1085447-4-zhao1.liu@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240418100433.1085447-4-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 18/4/24 12:04, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> As error.h suggested, the best practice for callee is to return
> something to indicate success / failure.
> 
> With returned boolean, there's no need to dereference @errp to check
> failure case.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   hw/cxl/cxl-cdat.c              | 6 +++---
>   hw/mem/cxl_type3.c             | 3 +--
>   hw/pci-bridge/cxl_upstream.c   | 3 +--
>   include/hw/cxl/cxl_component.h | 2 +-
>   4 files changed, 6 insertions(+), 8 deletions(-)


> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> index 5012fab6f763..945ee6ffd045 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -273,7 +273,7 @@ hwaddr cxl_decode_ig(int ig);
>   CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb);
>   bool cxl_get_hb_passthrough(PCIHostState *hb);
>   
> -void cxl_doe_cdat_init(CXLComponentState *cxl_cstate, Error **errp);
> +bool cxl_doe_cdat_init(CXLComponentState *cxl_cstate, Error **errp);
>   void cxl_doe_cdat_release(CXLComponentState *cxl_cstate);
>   void cxl_doe_cdat_update(CXLComponentState *cxl_cstate, Error **errp);

Another candidate ;)


