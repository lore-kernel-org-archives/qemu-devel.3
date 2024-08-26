Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97738C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 16:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sicC1-00053M-Lg; Mon, 26 Aug 2024 12:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sicC0-00052T-IF
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:03:44 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sicBy-0007uC-SL
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:03:44 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c0a9f2b967so1463421a12.2
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 09:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724688221; x=1725293021; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=14it0eO+52b0RZg0yuiC2+vq6gGreJQ9XqUNruwpWSU=;
 b=QHg6tbIjCLmrj6nK9TxVQ8b93GnoWpB3zTCUWZ4XbVESWf5O+oC4bRX8rhmG8U72Y4
 XnecZkB57duzMPK48VXJ35skLwhKK/b2fbvRSAQjAXac319OGQkprQk0y/I25PfdfJxq
 amVRGRcDq9QEjsdVZmDlpfQUF4Wf6DOFsnCHpxlYcwoe3WM6MtlIaZTONiHAMxYoaPuh
 JtyqcU8aBSofgkt9LKLc0Xtkx89AxfPx9CmKslKLM9gPsJ+csg7KvYppSlbF364yiSfU
 AWRtTU/jTU+Kclmx/9eKAH30fsR5gnbt3A1GoFpGo+lhVNAVD4EBSzVmjw5Dt4eIgFwJ
 RtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724688221; x=1725293021;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=14it0eO+52b0RZg0yuiC2+vq6gGreJQ9XqUNruwpWSU=;
 b=SsWYPTP57TAhUwBet57dVr+xc8la/7nh6DyzXHPWUaNNNVCNx0ue0NYRWUbxIcTcEL
 Q0v4sUZDBkGruWkjqQ1J7l7mWbI0slBHSxcZ1qHBxvL4zHcSQv9qs4SfBWP8W0EbVNBE
 UJx37YY89Z1P/GVMgcdNs1M1dTb1zF34n7HvZW5mGTfvTdGeEeie2nUXkgcIQ4QuCg3M
 FROKSn3tVoOOhUVxDgqq541dWxd/hSqLrkG/pS7Ki85lfO8q7Y8SSmAZc+RHKvjN4vo+
 uI2S82eE2AzEDvA5/6r/U5JrAzuKPA1y9aFSE1iMlVLtv2TX7uSeVZzgH3U0ozALfALL
 FYsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxyE87Q5Ec/tbFFNK32fiF+NdKnaAZJka6v3bBoRAw9NQ3BT8KdWP0hT9MTASVTxVQIR98x8MSBNPX@nongnu.org
X-Gm-Message-State: AOJu0YxgbQUUrPbp0VN0d6p6qpJ6udjY9F72gWwzgjNWjSy1jLfmS0oN
 tSrlOQCnIwrBT5LzgAvZQswQci9YJo2nYOHap2SG6gsqzvPULzbiJNrHcKT8emw=
X-Google-Smtp-Source: AGHT+IEF9e3Xac/R75uR7aWBx8UGNV/Aetbffvnv/nI82RcJ/+XkhekPhHHbAyEvHFmRiXGlVilamQ==
X-Received: by 2002:a05:6402:2692:b0:5be:f101:9296 with SMTP id
 4fb4d7f45d1cf-5c0ba2a47d0mr45168a12.8.1724688220902; 
 Mon, 26 Aug 2024 09:03:40 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.241])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c04a3eb338sm5774013a12.54.2024.08.26.09.03.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 09:03:40 -0700 (PDT)
Message-ID: <53e5f5b8-c0f7-4f98-990d-46b2ee76c519@linaro.org>
Date: Mon, 26 Aug 2024 18:03:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 03/10] hw: Remove device_class_set_parent_reset()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <20240813165250.2717650-4-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240813165250.2717650-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 13/8/24 18:52, Peter Maydell wrote:
> There are no callers of device_class_set_parent_reset() left in the tree,
> as they've all been converted to use three-phase reset and the
> corresponding resettable_class_set_parent_phases() function.
> Remove device_class_set_parent_reset().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/qdev-core.h | 16 ----------------
>   hw/core/qdev.c         |  8 --------
>   2 files changed, 24 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


