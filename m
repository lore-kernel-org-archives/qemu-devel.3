Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33294C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 08:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBr9I-0001dN-4S; Mon, 05 May 2025 04:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uBr6r-0004ru-Cn
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:23:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uBr6l-0005Tn-Bg
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746433404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HkasCgwT3vDM5F18qpcv2bNXqYAjRrnEvKHPnV1/qvM=;
 b=V9b0Vrp0pfzWO9i/MsPWn8BVGc/RSaszmmEgNFApfMIN+jT86beBGPKqUJ0JGO/mLAzfCI
 1BYKwHc8nnda4XXk0k6oKR9ClKmtv4CPk1VCg9TrhBuRvVL9wL140EC2V4EKaJnUzoOyY6
 OUD+g8enn+DpG23/YnicY/Z2hQiEQ3g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-3uzmeSXCNRO_VyC8MHrSzA-1; Mon, 05 May 2025 04:23:23 -0400
X-MC-Unique: 3uzmeSXCNRO_VyC8MHrSzA-1
X-Mimecast-MFC-AGG-ID: 3uzmeSXCNRO_VyC8MHrSzA_1746433402
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43e9a3d2977so29590035e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 01:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746433402; x=1747038202;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HkasCgwT3vDM5F18qpcv2bNXqYAjRrnEvKHPnV1/qvM=;
 b=Qb75M2wwQ7jSj4GhM0Wh1EV+FLAs9re+eZJmFeBVWAytwIeDdBWdLlCpU6p9A6IgYr
 xBXfanL8mZpftuez6iYMP06PkVxhwWx0V+pNU5y9U6B59MsoAf3th/4879oGdofRRuD5
 oIudc6iAaHzXYd5J1N6AS+BjO18AiQohPrG0URWyylklsItLFJ1Yw1ivdVsBWDyBtob5
 rWop2w/DMVMF0Xb+TlL0dOrr+k39uoYfcApgBE/ivrBkTg2j1NZUSMA8acZOJpIoThv7
 GKstrzu8guXLGCMD+j8wwf1CVDthONHkqp0kj853qSII4/oOcSftYdIyLcd1a3zWQ1EM
 MqOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAAsCQJrVJyYT8BfkgicSnYLQQD3Vl3KdAaaRMGbu6lsK25UnGK+3zofWJtJv5WHIYW7O9trZDH7kP@nongnu.org
X-Gm-Message-State: AOJu0YwfKSoTp54vIrpG9J8jcq79K2Q0VQOeNOBtkumfdF4MQ41YLPiR
 OtA9tP/OH6lkgB4MCh1nG1xbxE4pICTOUL9xc7erGaHa9Y4N+KlC0S86EiGrKVA95vl8Vp2NIFT
 IpoKIM3XKBnYGru7XAx3CYA5fYPYr5+GqMNQnRDEUmvYUzX+Ec9Km
X-Gm-Gg: ASbGncvn6p+lkH9AhrkrQI/1QgzoDnpDcBh4tHPMIGoxXHewk48ehPc7KGnCKsxQutn
 IRTCBEkhyXPXssdLN7Gg8c+xGWI17fYTgqdA+pVuMfKWnWJfphNF9dotuxPZ9Ty9uVEMMdKaeoG
 7BtszH/8cfWeZcW8JJbVbZYitPHTQgc/6kIavhDoBWS58stqLf/RtAODqUSGSHK+QK48KfSjqsQ
 saVswlyUICfdvdqxl3VUQcKBVvnhkTFn379FktDs5erNLl8xk/yZPxMamO6I1AhSxIYY60srB8s
 P6b7tlIPbnKv2k7xKgdZwjmG3EOXqmLyQbIrqclc
X-Received: by 2002:a05:600c:3e09:b0:43d:82c:2b23 with SMTP id
 5b1f17b1804b1-441c49236ecmr40071255e9.23.1746433402011; 
 Mon, 05 May 2025 01:23:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDmODba8rI5LVIElRzoCf56Ez8ntTsOdP8jiz5R0qJQitpz+RM5YH6okzwJNTOwJ/2dOrL3w==
X-Received: by 2002:a05:600c:3e09:b0:43d:82c:2b23 with SMTP id
 5b1f17b1804b1-441c49236ecmr40071085e9.23.1746433401647; 
 Mon, 05 May 2025 01:23:21 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441c8631256sm40251025e9.20.2025.05.05.01.23.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 01:23:21 -0700 (PDT)
Message-ID: <eb7983a7-b6c4-4dc2-8143-6301b19fde1e@redhat.com>
Date: Mon, 5 May 2025 10:23:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/19] hw/i386/pc: Remove deprecated 2.4 and 2.5 PC
 machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jason Wang <jasowang@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
References: <20250429140825.25964-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250429140825.25964-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 29/04/2025 16.08, Philippe Mathieu-Daudé wrote:
> Since v1:
> - Fixed issues noticed by Thomas
> 
> The versioned 'pc' and 'q35' machines up to 2.12 been marked
> as deprecated two releases ago, and are older than 6 years,
> so according to our support policy we can remove them.
> 
> This series only includes the 2.4 and 2.5 machines removal,
> as it is a big enough number of LoC removed. Rest will
> follow. Highlight is the legacy fw_cfg API removal :)

There is one more occurance of "pc-i440fx-2.4" in 
tests/qtest/test-x86-cpuid-compat.c which could get removed now, too. But 
this can also be done in a separate patch later, this patch series here 
should now be good to go, I think.

  Thomas


