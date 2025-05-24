Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADEAC54FC6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 14:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIq9W-0007QV-0A; Sat, 24 May 2025 10:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIq9V-0007QN-54
 for qemu-devel@nongnu.org; Sat, 24 May 2025 10:47:09 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIq9T-0008RU-Lf
 for qemu-devel@nongnu.org; Sat, 24 May 2025 10:47:08 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so10172855e9.1
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 07:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748098026; x=1748702826; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FbanT75Na8ktjlwvlK4+vsloX+tP7oq5R3VgAASwAj0=;
 b=nu/yPnP7W4acZycSZsjRZ1hQCK76XB+pO7yg7s+AVQlZDQUYkHnPd/IKiLC6we8i+w
 wQUcSWb4WBNXRebk1ZqqUZWQ/OvNGKqjmZUg0/ZDoCgzSfCr1TfzbVaWwXvVi502rRKk
 pzPGCbtEZDHNkvoJXUcBBICv202pMOmk9tjHJiKP7/3dI5FQ8PoQBRuHN9y+kQQqRTtC
 RPy8Q6PN9VPz4SrfRSt/Tq6ibs3aYufZ0sRI8DerXeUT0dj+BV4GU2uURiG/f09R0ofO
 72g8/68Rjnfrn+kcF4rDluz/IZrFXizzZhtVeMZUvZTDxFxY2H8VORM56ECsWdJ+5RtI
 vU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748098026; x=1748702826;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FbanT75Na8ktjlwvlK4+vsloX+tP7oq5R3VgAASwAj0=;
 b=rMvQeW1FfDm3hJr3eXQcz5HftsX/9zCIphh4BY956++MIg9L66Vf4/4q9TIty6mrPZ
 aubSPIoehR4A2Ys0aAiaQ7TfNE60/VorVhZ/nWjIf/gJDEIqJ+iCJVDGGGF6C2otP4Vv
 ERlI7TXLXxVObfue16PO0jIiIMAf4IufqolxmHBiAI3oQUnRNHWf3EewX1yrCqGV5wdQ
 Yzg+IG5uC4+q/Emnza5juL9FZ/NiRIa1MIuXsTZ7xj7tvAQun420lw/CV/+180Ey/cTR
 61QuyOE6o5sjeQqQ0vnbnw0oR7xFLMEibipQ4bHPaf8R9MMBtxEs7pEuYOpTII6JyRxp
 nG/Q==
X-Gm-Message-State: AOJu0YzLoF80Px2cWfuAZsitzHV/kqmOXxPVfiStyB+5m+8RHfJQRc5K
 ImEn8PpQZ/4pUSKGabKPZ5GFvRoTgkbt9a4k3TwrZHtk5uosXOnbbBRIUS/A9WhEN7259cBYemn
 H/H1s8bD5gg==
X-Gm-Gg: ASbGncs4lNE3FY20PaJXuqIGK4QrLlGinuQ+gjNppjc6mocCebUBIMnNTVN5TdCaIJf
 s+GZ5U6NTlY61Pw8Fa8Am7HbRRlcH4pG6CZ1Z3mXFdrN5MjArxBtgc8YKo/c6jX4P8qpMoWO73s
 NHzH4JMA6Z370HRbL24WF9JuCVi3SCwHzt3FbT2TCIu3Uw+sWbC7KVMHtokHWzPVKr/UT1rAUIV
 B0mLl6dulzfRHzwtMin6Dn6go9QQSK5+Fuxw+8YPy2iwrc8mD/7T2rwlDPJxK4Iv9CJ/a92d8a7
 ZiDtbfHH6aAdV2NiuKYIhppmRtfYu41Izb5+bbYIEHD19VS5VEMqtOFZR3LdVOQJ1w==
X-Google-Smtp-Source: AGHT+IE5yTrA1Enqm2vOdm2RBZws1TKek8i2K7vEzBIP300fyoDd+kKj/c7r7rlqb6MImkfV9wgFbg==
X-Received: by 2002:a05:600c:1e09:b0:43c:e70d:44f0 with SMTP id
 5b1f17b1804b1-44c91fbb42emr22976605e9.19.1748098025748; 
 Sat, 24 May 2025 07:47:05 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6f05581sm179167695e9.13.2025.05.24.07.47.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 07:47:05 -0700 (PDT)
Message-ID: <c6497274-5542-4a39-82ed-ca0093421c18@linaro.org>
Date: Sat, 24 May 2025 15:47:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/test_mem_addr_space: Use set_machine()
 to select the machine
To: qemu-devel@nongnu.org
References: <20250521143732.140711-1-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250521143732.140711-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

On 5/21/25 15:37, Thomas Huth wrote:
> From: Thomas Huth<thuth@redhat.com>
> 
> By using self.set_machine() the tests get properly skipped in case
> the machine has not been compiled into the QEMU binary, e.g. when
> "configure" has been run with "--without-default-devices".
> 
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   tests/functional/test_mem_addr_space.py | 63 +++++++++++++------------
>   1 file changed, 32 insertions(+), 31 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

