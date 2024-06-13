Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DDAC27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 09:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHgKX-0001Vx-A5; Thu, 13 Jun 2024 05:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHgKT-0001Vh-MM
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:01:11 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHgKS-0001KE-3B
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:01:09 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-35f1cb7a40fso766619f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 02:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718269266; x=1718874066; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o1VCbi64ErxRa8XFsS1Txjx8mbFClNEG9vpdGuT0Yvc=;
 b=tPMyTVFbI4+lmHVSShVuX68KUkmHglaLBXivQGMPaIomlz5PDFOHgTKpw08v0qPVjk
 Ng/m1s2G62Bo/dZ98ZFeDHgLqPr2KNtdcs9p4TRKmoabeo6MRNpK4BUdn03kGC3iHJFU
 6KkeRR4iI6871JoVV79oX/euuRmq3OCyZipXT70REZWrhgA2pQTtqpMkFQnIfCn61TWP
 Ba8FIrRz+7HG0AYK0cA1Ud5nz58LapkUoTjnowOcWXZVUFhgYIUmUuzqrqtB1yKV/33p
 KoCTzw4S6aBmztbVKyoLt9vqM0+ZDdIfwDp6dQ9eRZcPPGxhL8QK6Eq8Je2SqzoY+1Gg
 VzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718269266; x=1718874066;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o1VCbi64ErxRa8XFsS1Txjx8mbFClNEG9vpdGuT0Yvc=;
 b=tGiIFJA8AVWD2eLtpzAIyIO+DkxnL/ae6W6oTnhSieM5BOUKZimG4mjsNgmq+2iYVn
 2U5usjjAmRLb/fnB6U+CHXolfagq4Kj5LEeiC64sE3cwmSKyJ5yN7FpnipzqmKqZJep/
 xWsXXJjsLh2LDEX1mGVEasLnqJ56HFvE8fTJFbZYuYUv2Jso8u+XC8u0J6qqwltzfk5l
 xS1D1wHq9ifCQ3DqcSDAWS9wBpPepa5C49BdPk2rtaBia3ADlOW0oGjtTiDZ44+KOEid
 rqm+Am+AsnKZ4RIaCdYyHTYI6CHZ/1tuxeB+kvX5oiBpBy5T+AKwoL2u3RDD37NdMiDF
 7i8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWFxGXQ9GA3NLOsanbJP9c+OnM2S1NNC7wo1ixtoPUR7qqwISDv1EfZPAwBReffWPLySOJSkV+nwl064sdxTBHBUcue24=
X-Gm-Message-State: AOJu0Yx4hi6YJSHOa3VrAKLo+PjRL4Nm/k+Cu6SwoWfrZd+MD5L7kajh
 N4CL5Lia2iXrP3PzWZu3rhtR76g1J8KAc8qOoV2WnT5Ynpbs0PJCFySlOq99WAg=
X-Google-Smtp-Source: AGHT+IFHU/5PQ/94XP6Q/v6hUhBrTkCDuSXwy4b1IMirokLlobC7pHS2TNGNxQ7fNF7gavE+/+j9yA==
X-Received: by 2002:a5d:634a:0:b0:35f:3e9:d055 with SMTP id
 ffacd0b85a97d-35fe89402d4mr2789117f8f.69.1718269266045; 
 Thu, 13 Jun 2024 02:01:06 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.148.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750ad10esm1053683f8f.64.2024.06.13.02.01.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 02:01:05 -0700 (PDT)
Message-ID: <6a09ba76-ce94-4a98-9826-3aac8212bfea@linaro.org>
Date: Thu, 13 Jun 2024 11:01:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] meson: Remove libibumad dependence
To: zhenwei pi <pizhenwei@bytedance.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com
References: <20240611105427.61395-1-pizhenwei@bytedance.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240611105427.61395-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11/6/24 12:54, zhenwei pi wrote:
> v2 -> v3:
> - refresh lcitool after removing libibumad
> 
> v1 -> v2:
> - remove libibumad from tests/lcitool/projects/qemu.yml
> 
> v1:
> - remove libibumad dependence
> 
> Zhenwei Pi (2):
>    meson: Remove libibumad dependence
>    test: Remove libibumad dependence

Series queued, thanks!

