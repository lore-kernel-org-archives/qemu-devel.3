Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F087AE7C706
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 07:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpLoo-0008Lm-9y; Mon, 09 Feb 2026 02:36:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpLol-0008KD-9V
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:36:23 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpLoi-0004Wq-BU
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:36:22 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-81f4e36512aso2510651b3a.3
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 23:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770622578; x=1771227378; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nJk4/9dPSKF9qC/64ioINKn26uLgaBXWSqZ7nFwYowY=;
 b=H9+ZGCIbHe3fKlMpWbbJ+x4Vn19F+tQZIhz+zq8AGrAYZY8+J0IldxBu0qWVldFUEk
 qXBOigze634B19LNbvHrZRPoeJacRFdod7kjPN4OatzNFyU+SJCckGdd5f/KEjFIe95M
 +KOfmQXW60RgGsj7tkAe9yENKoAvwZN9zURIQiJyYh38Fr28uluMYtJo7LQ5rCiRzma6
 53t/PxUuVXnWRM7K4SRJtyS0YLo1EN2JH4Tfp4iVQClO0we+4r5zMjktC4n+FDcaCgmY
 VaWnESzFooMlLFUy1Yp6TJcCHlMHD7eOihFwLc1+/WtUmlAb6gbCBb+9DVrpZlslit2+
 7yug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770622578; x=1771227378;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nJk4/9dPSKF9qC/64ioINKn26uLgaBXWSqZ7nFwYowY=;
 b=IOHyj5biyXxoVC742NbP9g6H+/yn9h46rGup4il7FC/V+5zeGn2RKUtcLV20wGfQ5G
 qG1AnPxAjoyo5DAZPCgGZE4YqwcaXyVFXgz56E7uzht+SEWumjuaVoigSmXuQxu+jtFb
 WUTDE3FuhW4l/yJekw7gwWF7tMq3eMDJXo5md6olwG6WgRpkYxlQpd/CfQ2a/z2a01kD
 IcBiiE5kDE2E2WdB6Si65WPj7qOIGlgqc26XNKAaXQDLXn9W8UnB6T30PL9EnwWYCrPF
 dSL1QB6HaDri9BAzLhXsgXK2sgtVj8Am4Smr01lwC/XGCPI5WgKOQjsywplHB5u9DkDY
 LGvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv0Zo2C+cI9EmrPY9V6zRXrG/Edze8ZWWb8NjUg37H5vIKoi5Q51f2t9f5uouV6irMoFHSId5r0ON9@nongnu.org
X-Gm-Message-State: AOJu0Yw3Rl9iYLAbOocOnCwpHrfLYDMrrHFko3PMrKTCw94gax0rPXrt
 /PWwO42A9pTg8E8Wt46MuRNcI5rtMoarm6AwJspOxnejfVQozvnyBYDhPnefvaJmZLA=
X-Gm-Gg: AZuq6aIC9uNLpRtgshNdr8vgdZNZ+llTiQipI89kl77rWr7u8i2x3IqgGpEgkjAc2iN
 N8h8wXmvvNkWoT1xFhPj71YnXe+fBS9Pr7NYmWQ7fvQ5tsD3NDk01biYSG9jiGFLq1iRdyCfNlb
 uI/djt0qkTe3JT32lSV9rQ/Cp3CGznKW8rxIxyu9sUtmf+aFzTdYTi8dQhC1oQrJjZ05hYvfkJc
 kImaNCUAt1KRbw4VirRWWCiFC9Abdi47oJ1xJScPkvvWK0pT0b7+Fo5xRu6VSQtWZvmQEPq0h5N
 BiTK5vJ/iSkdWmKImqDXGEeYwliJuBiKr9PscN0rYX1gLsDZ5MUPVgDBGvC+dGsz5HDyGiGsPg6
 5AqaPrpDWaqo7kT9TUB90GLFra7nOQ2IAqd9NN9hgzEcMbM5fgQpH/S9SLGpYf0BczsYRkgthoT
 HPrbjUcrzURBRcfUNpANHoTcgZ9oBzEDygyyr4qFKuv9FPemjcxsSX8eC/6Afq3I8asf6RTuCeO
 Q==
X-Received: by 2002:a05:6a00:a22a:b0:81f:b3d1:2d17 with SMTP id
 d2e1a72fcca58-824416f79d4mr9254145b3a.35.1770622578024; 
 Sun, 08 Feb 2026 23:36:18 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:7b35:2dcc:ff07:8193?
 ([2001:8003:e109:dd00:7b35:2dcc:ff07:8193])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824587621dasm6174219b3a.54.2026.02.08.23.36.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 23:36:17 -0800 (PST)
Message-ID: <3f9d0ea1-8414-47c1-961f-724046f54e16@linaro.org>
Date: Mon, 9 Feb 2026 17:36:11 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] target/s390x: Implement DIVIDE TO INTEGER
To: Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260204121026.645382-1-iii@linux.ibm.com>
 <20260204121026.645382-5-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260204121026.645382-5-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 2/4/26 22:07, Ilya Leoshkevich wrote:
> DIVIDE TO INTEGER computes floating point remainder and is used by
> LuaJIT, so add it to QEMU.
> 
> Put the main logic into fpu/, because it is way more convenient to
> operate on FloatParts than to convert floats back-and-forth.
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   fpu/softfloat.c                  | 142 +++++++++++++++++++++++++++++++
>   include/fpu/softfloat.h          |  11 +++
>   target/s390x/helper.h            |   1 +
>   target/s390x/tcg/fpu_helper.c    |  56 ++++++++++++
>   target/s390x/tcg/insn-data.h.inc |   5 +-
>   target/s390x/tcg/translate.c     |  26 ++++++
>   6 files changed, 240 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

