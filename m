Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92465D0E6C3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 11:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNqqv-0001wy-Ck; Tue, 25 Nov 2025 06:04:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqqt-0001uI-JE
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:04:55 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqqr-0002i9-3P
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:04:55 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42b31c610fcso4590360f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 03:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764068691; x=1764673491; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iO0kN/gBhlAMM/PU4SCRVIu6yBy8I5UFDsqZzOpyzrc=;
 b=HoeV1acFOZWjUpPxeQH/MAMBM9gICnwv3nMAMzVULnPhyAz9UwFIn5R9EJyp/mgbVP
 400qegW4lGARwGu2x+//ZL98Qm4WKERZU957eyspWHudmpHKF2voygDVZ1VHoSAWVX+N
 h/sULGcZGrqccQzreNx0FbS6sYLfBCtg8AtxQ0Lysh+fzDpyVwew2M+khpj+W2O8VOp/
 3W+1kB6psxU901pGaG5WwuMt+exKjlDGKTf+1P6TxF1U24FKnQ/1RC5BNWg+c5GWPnlj
 3aFllRCM/j8XGee1k9aCLp+a/KGb0eumqOxiR5I6CtEASnIg7qa+bB6B6g3kBc3UIMug
 TZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764068691; x=1764673491;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iO0kN/gBhlAMM/PU4SCRVIu6yBy8I5UFDsqZzOpyzrc=;
 b=Bm3z/53qBZ2IFoOweez5T1VNyG1eecYjbTobpdTAuhcUKqpuNAfU8lVfxL1RhmQjy/
 CCvxrNKEKxqaOz+EZlfoZbildL9/JJ0Dk3opaZciyBuamDDRSwT8FAaGExdk//WuVP6a
 embQE2JP9hUldFz/fL1hD9s/yKgEcLi6ZxgbnOvRk5UJUNCCvSB2YfD8cvJnttymVByt
 poRy39bX2915DLCk2GRzy6QV+qogTtmu4wP8MMjIt1TbAgpPNaAR40phQvwIeJf+MFAv
 A5Orc4dgifDM74Jw831fIzzHXQ/oKfE3FuvUheno8aB/g6tvXYb5exmqAvndxI//joaq
 oJDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpzBNOUL23eFwwNTAztFS+QdmWjYAM1T/Cvdgr1bdcolYYJRsjfE1ipLbA2mNfRJSIA3GF6Yss3ZKt@nongnu.org
X-Gm-Message-State: AOJu0Yya3qrzZnkC8ftjsR4g0Iu4HABnGsd22+erNfvqDZqjBK0JREDO
 5+5N3Aoh6NpUZh9uMFhZw10Xn+FFDZva9zjl274c16DOfSb311nADwYRdejGGe2nU2k=
X-Gm-Gg: ASbGnctKFj46MKw6dXOucFu3SFd6ooMD/4uW7ytUQYNAiMIHYuJiGcwoZoUoOJlj17t
 qVDvOxTd0uTqq2VpY+1mv95t0yQ/PNa6pQN4u5pZYwORDLxU9Dd+k1zeDn+vucpip1ClROPZLLE
 Bxjkq8M7OFudw3APneAYxbuliOOWGLEKYmVPtXxs9Nc3Im6MGttTTj4y8peFzKOBLx5BBrHPzsB
 43Dou5NDxRrWv0Q7pyynS4jE/HmgijnFkQEC2BaFB3zcKNsMaRGPet1EEPHnEJHS1fUyNHplzHB
 wC+SkrU28r/aCSwfLE3j6kJp7SCFacyNKHzjplFJwCBDOZZXmyyDr1+8Xlgn3HXuPectz7Pt2t3
 b+y9UjW/pSTVt/ZU8gkLJhphzVcu8VeCUb5K3vpJhKZPSrZ7xGQO9ChUHdsYbmUGQl+ADZKMkEe
 N7NKkkjMuGo7CZBRmcoXohKllVQPsAs12NGChluAM9CD/cwvkTpDkQAQ==
X-Google-Smtp-Source: AGHT+IHo+evcKWCvQ8KvL2ckUe1Fj0vCJbznl5VEwtakxRb9+8MQ9HGTEE8pQfQB5yP5912/N7XKwA==
X-Received: by 2002:a5d:64e5:0:b0:42b:3963:d08f with SMTP id
 ffacd0b85a97d-42e0f23179fmr2346393f8f.26.1764068690042; 
 Tue, 25 Nov 2025 03:04:50 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb9190sm33531898f8f.33.2025.11.25.03.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 03:04:49 -0800 (PST)
Message-ID: <738331f7-138b-4908-90dc-157e7bece253@linaro.org>
Date: Tue, 25 Nov 2025 12:04:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 05/12] target/s390x: Use little-endian variant of
 cpu_ld/st_data*()
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
References: <20251125105434.92355-1-philmd@linaro.org>
 <20251125105434.92355-6-philmd@linaro.org>
 <b33a0b0a-6e69-4304-b5f5-dbd68fd241a5@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b33a0b0a-6e69-4304-b5f5-dbd68fd241a5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 25/11/25 11:58, Thomas Huth wrote:
> On 25/11/2025 11.54, Philippe Mathieu-Daudé wrote:
>> We only build the S390x target using little endianness order,
>> therefore the cpu_ld/st_data*() definitions expand to the little
>> endian declarations. Use the explicit little-endian variants.
> 
> Wrong endianness in patch description?

Oops. Code change is correct however.

