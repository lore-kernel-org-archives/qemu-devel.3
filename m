Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C37CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utRFf-00050Z-D3; Tue, 02 Sep 2025 09:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utRFW-0004ro-P9
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:40:40 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utRFP-0000TM-Nj
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:40:38 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b042cc3954fso322445666b.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756820428; x=1757425228; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e+EscHSP7SD2gZzjWCHGVqr15+Rbxbx8Wq/mTcIkmgo=;
 b=HMHjJX2gongFaQDZWzr92h8s7V7zLrPeXmuejBGsEoyMTcGlrkvPHV8p/wuzgbTNSE
 XDSqdvYokbA9vszOb/mjAT5WdDiPXUI/fupsywW/MUW5t/YRBytgQsi9pkPKFvh9Cr0z
 9zmt1XYnFQT9/Yl9QbacfelP83PUFtXWerw2m5k136DuVushW80CAyYWUogGhjh4t+eH
 xEXD4K+1xAqUCtvRXZkEkaen9JxpXWHhCQxlU+oFkqqBpc2OFStOX3hrVPvde/9Uqes+
 x4gDVWGm6+AcnM4RWR9pItVUUp+jsE+ptfIgCZTGG0BwPGQS5rlQj6jCaec3RuKOB7Hy
 SI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756820428; x=1757425228;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e+EscHSP7SD2gZzjWCHGVqr15+Rbxbx8Wq/mTcIkmgo=;
 b=VCiwdk8iNzjWPIKh3EenZsaEhhjeIpwzab6AvEe/k9q50YzQV0SqiEpNtRWlrN74iY
 O0q3a5Z+weMMKBVLdU4y9ZGpMHgxDrANruL69nBvJEyH01t/zyypqhChwuANrJ1BsCUR
 bQ6z2zAWAiI/cZBowHrmSHn3jIGHtX3RxzhLBcN1P3JXRHQu9ZpIrMi2hSHdDO2u+hl3
 gA6mUlDGcs1b50ax+dD7NRNUZ+vTEkLMVRfpPXYzdboMXqNrHcTstLV9sT0K2pMuAqCj
 tyaa7QO68o+YS8/P26HsHRa3+dg4S2ghKvHWeYMjA1Ih7814qM1fFaEuy9zvNc2GVfUv
 p7uQ==
X-Gm-Message-State: AOJu0YyVNAuBfly0YXXtxamDlUNM8E4Vw9VdM+H4z7aQGiZjP5dXRTM9
 oOT99nUE12WlY/LJkzR67so/nNYPBUdecG3W0nbv/Ym+GLaGU19nMmLhHYiR7GAdN54=
X-Gm-Gg: ASbGncunrt9xZuHcm/oEg0k/BUKaqrv6T8Sn2Ifbqi9EKtLzYcPkTgX106qVqhEDibE
 BXjS7hqzVmcW0xIBO4XtHR6sDQ3NH09oZ9zAXUAfIf0TPPV762q+jXqQQedQ1SQoFFwWeJtHcOi
 tFD0Tx5+o+8HkS+jogqfrfMTdo+c+zy11Sdp8CfMxze7vJATQ6RGqvBx3d6I4r6oZGoJvbYJggX
 IFZkRGtAly5ILNniQFF0C1W8ihJiQK/daGdbw4sBMQjuO3263ro5gwZ+i2akGH5Q7woFGd9Fgx4
 HP7wziSSL0+ncpS9LGs9TTb/VI9EBqRfhRLVZ6CKd2nNYnv/VpMHpYhVQMe2awDNOuSgq2Qb2qF
 VOgWHytxrV0ne7PUiloI5PR0mGPBIgdwC/YIEK83PAbGxZ3WugCKR+4oSn5KlOScwxCoHVErRoH
 OSXz5c2A==
X-Google-Smtp-Source: AGHT+IEPU7mUAUwLlrIQUtD9Tw0O4b4+kXj/nE5COigs7iq+bITyVjq6ItO2AfJJ52jzmPRMXP0tfQ==
X-Received: by 2002:a17:907:7fac:b0:afe:677e:a633 with SMTP id
 a640c23a62f3a-b01af2df4e5mr1238624266b.0.1756820428282; 
 Tue, 02 Sep 2025 06:40:28 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b04148f95b5sm673875466b.92.2025.09.02.06.40.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 06:40:27 -0700 (PDT)
Message-ID: <ec2724a5-278b-4acd-abb9-08d838106549@linaro.org>
Date: Tue, 2 Sep 2025 15:40:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] target/arm/hvf: Add KVMID_TO_HVF, HVF_TO_KVMID
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, mads@ynddal.dk, agraf@csgraf.de,
 Danny Canter <danny_canter@apple.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Cameron Esfahani <dirty@apple.com>, Akihiko Odaki <akihiko.odaki@gmail.com>
References: <20250818041354.2393041-1-richard.henderson@linaro.org>
 <20250818041354.2393041-5-richard.henderson@linaro.org>
 <4312974c-9b7e-48c2-a190-071ea72da33f@linaro.org>
 <5b9e5f5a-b434-479c-8840-dbb4cda1365c@linaro.org>
 <a4a4c7a8-df35-4bd3-9de1-b22ca7bcca22@linaro.org>
 <BCCED674-EAEF-4755-9BE1-116FB36FB5C9@apple.com>
 <65617771-37ce-457e-aa2f-f59bf524bcca@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <65617771-37ce-457e-aa2f-f59bf524bcca@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 9/1/25 01:02, Philippe Mathieu-Daudé wrote:
> On 18/8/25 20:37, Danny Canter wrote:
>> Howdy,
>>
>> On macOS versions/SDKs before 26 you are correct, we had an invalid enum value for 
>> HV_SYS_REG_MDCR_EL2 in the API, but the hv_vcpu_get/ set_sys_reg APIs work with this 
>> value even though the
>> encoding is incorrect. The enum value has been remedied in 26+ (0xe089 as you pointed 
>> out) and has been done in a backwards compatible way internally in the framework.
> 
> Thanks Danny!
> 
> Richard, should we guard the QEMU_BUILD_BUG_ON() macro with:
> 
>    #if defined(MAC_OS_VERSION_26_0) && \
>        MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_26_0
> 
> ?

That's one possibility.  Another is to remap the one broken enum, since this fix is 
described to be backward compatible.


r~

