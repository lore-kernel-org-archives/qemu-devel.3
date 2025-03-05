Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8ECC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpeTa-0000Un-Ak; Tue, 04 Mar 2025 21:27:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpeTU-0000UL-S7
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 21:27:08 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpeTT-00005Y-7O
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 21:27:08 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2fea47bcb51so12569789a91.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 18:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741141625; x=1741746425; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Km404/ihXp5xgEMxUP3ACI0nJ2u8EgVR6qEJGtM07TU=;
 b=nXAyBefGNoH/xpb+gLbNmjFuz6PMO2+ThSouwuPqB3nNdeujKXPvYPYI4R/BZ1cxWZ
 aIqvbJWaeB6xzmQq3gw3z9rsnae1TP9rAreLHcRhg6TxuuW7Po+9q49+aKJ7+KRXdQ+F
 cMlUTMpLzf4+v63S2++wHLOnFlngGuBKuzePpokJEZYfus02LWFSQEdJAJ7jEEbVlWr/
 7omYdSjp39hCqPDTfl257Hv1x+8BXpKU5RgYxSTT/xmpEoXjsluWnnWGJh9t4k3HEiy1
 TN8XxuCvcoRhTMBwHG/JxP/Z2kJhvzyIMUmm7Hhaxue1FkU7FfEcGS5/ULxRT5lBxRrq
 mNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741141625; x=1741746425;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Km404/ihXp5xgEMxUP3ACI0nJ2u8EgVR6qEJGtM07TU=;
 b=Lju4t6FR7iyeggW+5MS4JxMjAWkqxpd9VH57EwB4G+Bof1pVJ1410m8I0T+U7OhtXZ
 Adhw+ElHh1km8eX7bVT/bDpNKIXT9N9i2mCnIMP5BDpxtx3ZnQZto+NsO2L/crFBo8D7
 1q+sxbXJC/ALEVDKjLFsFZBfDad1oHq6KYldhg9L/AUdeHSddv6eJY/UGQ6KWYHrfVf0
 +zOx5uiRaD7Ho5ixHGOi+fyTxK7pCySwNMYbxFH3yUeBhRFfbdLYI8lauFGuAQLGIZEa
 flbKdsCVGJ9Ydqm/iq0I0VycO52rssqH0v2EGnsfRFNuwaGBELiqEs0X7cS7rgIu+wxo
 zz7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHyb2gRVHNpxiQ2f1yMpytj/ywqxX98ADUOltCy5gwOiB9ZY0uc2CG5/A9gip2dimUp+V92hN8Djub@nongnu.org
X-Gm-Message-State: AOJu0YwO3RCK5EBmLwVeRMJc/dvZKMPBriBznCS7QPxEaQBWtCkteyyA
 cGeidVSLzrjRaYQA+TJv7cv2UwKGxLGYMJ+pbVbqZ0r6BQfhCSxGS/11ATJ6TvY=
X-Gm-Gg: ASbGncupUnYo6OOAlH6huzDjXSmjcrbnsYek8c7VRiPbAj54eYkVrkR8Z7z2t7BGfoP
 2Z0L0+Fe9zNA9DFQEIxiuFe4EqOpUeeqUVen2EisGIr7iIfSYVhB8uAtOB5JsF6+xLh4VR7oaMY
 h12JSjCWffNKoYmOQTPQWJWSDaOTrQUXopux4/wYjN0WCcxXjdiHM/WOll+Ofu70+CvMyGFF8jk
 t98KhbyuxjoJ0tu1rJXFYoQKMzq3Un9bhIaJSyvWn8sNL3ymp0Gl76LSEvntXtYmmg33nIA6ZkB
 B8UyosloYJcbVcVRvyklJcxPRy4HeAM1Q5CMbNeqTlR3i3bfw5lqO8dscpUpzl3RDmMslVX33oy
 BOYGRNcZv
X-Google-Smtp-Source: AGHT+IGtDxdxMX+thFDNLsTgVL+nJQyu63yA4pi1q6MawvYnUAuQrwvdqOzw2q0QsMUbfLoD+IS5bg==
X-Received: by 2002:a05:6a20:918d:b0:1f3:45cc:c6fe with SMTP id
 adf61e73a8af0-1f3494b4c9cmr2322743637.21.1741141623928; 
 Tue, 04 Mar 2025 18:27:03 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af26374abeasm1215592a12.60.2025.03.04.18.27.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 18:27:03 -0800 (PST)
Message-ID: <f8143b99-9706-4acf-aac9-2709ab717338@linaro.org>
Date: Tue, 4 Mar 2025 18:27:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/11] system: Open-code qemu_init_arch_modules()
 using target_name()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250305005225.95051-1-philmd@linaro.org>
 <20250305005225.95051-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250305005225.95051-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 3/4/25 16:52, Philippe Mathieu-Daudé wrote:
> Mostly revert commit c80cafa0c73 ("system: Add qemu_init_arch_modules")
> but using target_name() instead of the target specific 'TARGET_NAME'
> definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/arch_init.h | 2 --
>   system/arch_init.c         | 9 ---------
>   system/vl.c                | 7 ++++++-
>   3 files changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

