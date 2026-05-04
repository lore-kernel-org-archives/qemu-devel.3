Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74191FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 15:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJuqN-0000Nq-HI; Mon, 04 May 2026 11:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wJuqF-0000Mg-8t
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:04:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wJuqC-0006VA-8r
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777907051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0eHFt55FffaFT86IQUCWqszwh6vPcUzs0gsaG7C/Iaw=;
 b=hfup859YxIx2IV5ofdxvLYvh72K+I1r8CvZj4YQKyiNEFQXSvde1C4cBVDV1Q8s8AdLZ9D
 5MfE3L2yAErl3OZotNrdF1GQ+nZ8tt/Opb5X2k/SLwtyyI2aM2ryayaGzXY3k/UtDVrnHj
 kwSrSHNGv+NQmZ0UK4MYBtrQilxroTw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-eTt1iI31OmmGfrn21JyY5w-1; Mon, 04 May 2026 11:04:09 -0400
X-MC-Unique: eTt1iI31OmmGfrn21JyY5w-1
X-Mimecast-MFC-AGG-ID: eTt1iI31OmmGfrn21JyY5w_1777907049
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-44d79da8cf7so1017413f8f.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 08:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777907048; x=1778511848; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=0eHFt55FffaFT86IQUCWqszwh6vPcUzs0gsaG7C/Iaw=;
 b=c7veV0YkblJV7BibWFFcEh3smopf5Ji3Qefhc6nNTjbUiF4wL1CrSvNjJIRCshtnpg
 HO8MB6x0npbzBTBGoiAGWn+8H0skSoMZn0336fcrleufW2qG4Hj1k9qWAiVG2YMEgap+
 WGi827HKnMw1kr9vEMDIBM7yHku9LFAkCTs80B0APjmVh2i4oIeMwTSXAv0BB98v0UZD
 27ZKa4FTmyLcJfJMLs0jwC5C62bg0ciTA+wKTmQlAlwmGP03b2YbUIaudUfj8tW/ooye
 ini+a7IjDRA8p2U1RmR/a9WDLcU1WBMtLfjPLnIeRIWfs8gf4iut2T6eutxErRm5ulgX
 05Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777907048; x=1778511848;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0eHFt55FffaFT86IQUCWqszwh6vPcUzs0gsaG7C/Iaw=;
 b=Am1EXKhvh3UliozMSrSZEeAbRLSMiaCPBMSCv/H/lLhV51D+TZmxbMLIkLyEAIJctS
 wvVAbjH8TUeaOfyPtfOIf5o4M6l0YW2hzrr10erHVVUCsSMcXXbAgquK/q+qblL2A4lo
 t1RovKO0p+U3d635udZz8J9r54H//TkixbJkZXNmL+iQCydrBlEo2cXY4PdW5dsUkBX3
 85qeeVc3RHAWWNus87GxxetovA11k9ItxL/kn8Jlk/fvLCOejLc21pvETebQkHvmquXu
 GULqS5Kw5alRaUKSd5LL6ZaKRYHAB+O0wLuagRMUaE3E8vEzVNOH0KMpQI/3O3C7HBRM
 YQuA==
X-Gm-Message-State: AOJu0Ywve+kFZxYzaMWP+AV+5BOCXR9U2Cn36XwaNwndX7ESMgS6Fbyb
 eEYUwTAPx8uBJ/H8GDFLuxZfN9QnfUnwVAxersgUSlUBGxIISeMhiu2ppktu1QT2Z7BJxrIg2OH
 pijKdKIOs8LWZ8bHQo5fzIvMaV8KKQ0b4QBOViCiiUFULcxqGYe0RI4oW
X-Gm-Gg: AeBDievfrmaxM6sHbrx8a+DDKfubT18xeycFA3l9Ni3wL/kVP6v8+eZoBsJi+UvGSan
 FZW1R9uUXFQ3k0dGNL+ddG54fqBBWCi/0SbQVu+oSGIRgvKutw1SsHBXWoofbNcyGMYPPaO9Rj7
 YaiHlffY6Z/ZVGwRzIrInGNlFOF2zK1LQWCbxwD+uW5cnRQeI983ndIgrpLIWruu94B0LL2tNk5
 e3mY4b5AvP3j4mGJk8oi/DDTci6O4NaggkMYpYrh2xE6g9IjgWXOP44zezx2alr8szsY1WeOE3/
 1rjIOV8Y4rCKZxVX7LFnFR08ESU6XGZAtg46MhM6/un7xhAGKpxbyS0DOaXKrZzC4/ht6n94xH0
 WFzFJukWbnI9xYbWUzsY77POM80ALUr3vYEf2Wif2TzqrjVimM+p/kW5hdCzCkh2o8KFEJg0=
X-Received: by 2002:a05:600c:444c:b0:488:7ff6:1f75 with SMTP id
 5b1f17b1804b1-48a9866aa1amr171219315e9.21.1777907048376; 
 Mon, 04 May 2026 08:04:08 -0700 (PDT)
X-Received: by 2002:a05:600c:444c:b0:488:7ff6:1f75 with SMTP id
 5b1f17b1804b1-48a9866aa1amr171218775e9.21.1777907047867; 
 Mon, 04 May 2026 08:04:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8ebb3dc1sm294157895e9.14.2026.05.04.08.04.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 08:04:06 -0700 (PDT)
Message-ID: <df4a35d7-3be2-449a-8163-bf5f78fed27c@redhat.com>
Date: Mon, 4 May 2026 17:04:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio-user: avoid leaking duplicate device name
To: zhaoguohan@kylinos.cn, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Cc: qemu-devel@nongnu.org
References: <20260424032209.297458-1-zhaoguohan@kylinos.cn>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260424032209.297458-1-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 4/24/26 05:22, zhaoguohan@kylinos.cn wrote:
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
> 
> vfio_user_pci_realize() assigns vbasedev->name before connecting to the
> server, then assigns the same name again after installing the request
> handler.  The second assignment overwrites the first allocation, so only
> the second string can be freed later by vfio_device_free_name().
> 
> Drop the duplicate assignment and keep the first name allocation, which is
> also available on connection failures for error reporting.
> 
> Fixes: 36227628d824 ("vfio-user: implement message send infrastructure")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
>   hw/vfio-user/pci.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
> index facc79727acb..e7573d4a9f08 100644
> --- a/hw/vfio-user/pci.c
> +++ b/hw/vfio-user/pci.c
> @@ -280,8 +280,6 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
>       vbasedev->proxy = proxy;
>       vfio_user_set_handler(vbasedev, vfio_user_pci_process_req, vdev);
>   
> -    vbasedev->name = g_strdup_printf("vfio-user:%s", sock_name);
> -
>       if (udev->send_queued) {
>           proxy->flags |= VFIO_PROXY_FORCE_QUEUED;
>       }


Applied to

     https://github.com/legoater/qemu vfio-next

Please base future contributions on this branch.

Thanks,

C.



