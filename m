Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2361FCCFA1E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 10:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI2oH-0002qd-9l; Sun, 09 Nov 2025 05:38:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vI2o6-0002ok-RI
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 05:38:03 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vI2o4-0006rg-N6
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 05:38:02 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b727f452fffso360325366b.1
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 02:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762684678; x=1763289478; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aPghzuZe2b9EV6oDLfVN2VbZOgOe4MvA27gFZZNsJPo=;
 b=u/W4ckYFPlhIFZwVDi7vQdU8dFmOswsyunBKCjpn4Tf52cR8JbcctubYqnwSDrwtLA
 T8zPYZrqSaPNSqXfqxu81Zkte3NuLQmkE3NBUTVKiX5pF8Q6R00ZoMqh82DpEdUJIDCp
 /Rt9scUNyJLj382kC6dg+5qPpE/+Yf1hGh8BjVLc7jOGIRl+rX3F6LZm2hILG8Y+SVt7
 f5DzuBREH1X5TMeND0ZDGd5Rh8DVAkFYxADjeEC8tfFeyyU3UMySyVzin2pL4oIgps24
 ydAvF3i3vN+L6efIViiI1EWi669l+smTjCgYYWumEiAlhjfdmNTS0vHRwOv+1z+Yv6gK
 Wx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762684678; x=1763289478;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aPghzuZe2b9EV6oDLfVN2VbZOgOe4MvA27gFZZNsJPo=;
 b=KRfnzL1QkvKe6GMKAOdjcUm8ghtkH6Yvjs2/ApzOPq++HEnoSlZpPMACoTwdBKneUS
 X8mvQgLZuEXVhyQtVJf6n6LT3IL1c4iugu03fNlDRdgIdo1FpL1+NxyJCR/PnCLhkEF4
 N/dFTupIHrCX/hBQZ6G/KFvWJhbJh0ym59X0VRqJcCFmDzXSMHGoKAvZ0KcWD11zDeGU
 9tGXOzNdJm3lyeMKLZK+TU6I2e6dj8eQnoVLnwKTbU7e4gfVAcQoEGm5NULHX2R5fElZ
 aNAR3uhctJg1K3QmsZUpw3PEJvrEoLkWiN+/Mqome+SkP+jr50/qOzb4SMPH3obDUxB+
 4t1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoWcgTgHnPTlsaZgf5lAbj3eiaKIsbqfX6O6Jhp7PBf++w9QB3tMHGRelqQ8yXZGN/iSTEzlxVuvBR@nongnu.org
X-Gm-Message-State: AOJu0Yz7sg7QtpUsbjqUYCIt5Ve4UhE+W7JWisZdnccPuu1h0bSeynYr
 IN/of974QV+6OKt9GULvwUomxBmn9f3eeguw3j89dLTE/6D5RifWw8nhhmXLNDmWzLqd4j4VlVe
 JeItN
X-Gm-Gg: ASbGnctpzM4cr2tFeWsVE3Q1ttUOhWYjpLI7cduCpWGf7ksT7VjlUluMXLVVuisHOsV
 PNM9ifQ/3Glpc0vKIM4QT+P9FpAxt88C6+plF3u7mB35/Nf9QVktweUVWBKno2dRkVBEkOnNt8W
 Iu5jvANvX4XKcTSt7OU+UV6LzOxOLhoDz/70KHoWzqiyK8Pr1JexX+5eGpAhXsepP2Kp92Va/ey
 gf3bszXHcaM7OspbT+7aaQwNkp+eaeQpWv3jCsitD7y/fBX8wwofuQC+lC1FJndAMtoysZJDUbc
 eurvjEcg7Q8eYAW1Cwr+f4qRhxXUyGg3idUVVNJ3daI3T2P0FgqMj4r/rejSY/yqK3i9/RCqgm7
 vFXO3DW/ZQZYBBd6ueoV1XV+fEhJPbVt4N9R3NYh9+lhyaxkzOCEO88JGT97RKbcLMxUn3Fxklx
 PTHjW8RoNElisBis2ryVCGnt+juDQL1I1o5coddqgVEBANFzQ=
X-Google-Smtp-Source: AGHT+IENPDAmIaVO+mmgexxIDcb8p9AeIMZpKKTdj9dZZlKsdNBnzaY7S5haWmQhpdN09fIGgsFBWg==
X-Received: by 2002:a17:907:72cd:b0:b72:6d68:6663 with SMTP id
 a640c23a62f3a-b72d0c6363dmr858688266b.31.1762684678011; 
 Sun, 09 Nov 2025 02:37:58 -0800 (PST)
Received: from [192.168.2.7] (tmo-086-152.customers.d1-online.com.
 [80.187.86.152]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bf9bc214sm801977166b.52.2025.11.09.02.37.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Nov 2025 02:37:57 -0800 (PST)
Message-ID: <9dce8244-b84b-45b6-abfc-b4561c3fa3d8@linaro.org>
Date: Sun, 9 Nov 2025 11:37:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci: Make msix_init take a uint32_t for nentries
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20251107131044.1321637-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251107131044.1321637-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 7/11/25 14:10, Peter Maydell wrote:
> msix_init() and msix_init_exclusive_bar() take an "unsigned short"
> argument for the number of MSI-X vectors to try to use.  This is big
> enough for the maximum permitted number of vectors, which is 2048.
> Unfortunately, we have several devices (most notably virtio) which
> allow the user to specify the desired number of vectors, and which
> use uint32_t properties for this.  If the user sets the property to a
> value that is too big for a uint16_t, the value will be truncated
> when it is passed to msix_init(), and msix_init() may then return
> success if the truncated value is a valid one.
> 
> The resulting mismatch between the number of vectors the msix code
> thinks the device has and the number of vectors the device itself
> thinks it has can cause assertions, such as the one in issue 2631,
> where "-device virtio-mouse-pci,vectors=19923041" is interpreted by
> msix as "97 vectors" and by the virtio-pci layer as "19923041
> vectors"; a guest attempt to access vector 97 thus passes the
> virtio-pci bounds checking and hits an essertion in
> msix_vector_use().
> 
> Avoid this by making msix_init() and its wrapper function
> msix_init_exclusive_bar() take the number of vectors as a uint32_t.
> The erroneous command line will now produce the warning
> 
>   qemu-system-i386: -device virtio-mouse-pci,vectors=19923041:
>     warning: unable to init msix vectors to 19923041
> 
> and proceed without crashing.  (The virtio device warns and falls
> back to not using MSIX, rather than complaining that the option is
> not a valid value this is the same as the existing behaviour for
> values that are beyond the MSI-X maximum possible value but fit into
> a 16-bit integer, like 2049.)
> 
> To ensure this doesn't result in potential overflows in calculation
> of the BAR size in msix_init_exclusive_bar(), we duplicate the
> nentries error-check from msix_init() at the top of
> msix_init_exclusive_bar(), so we know nentries is sane before we
> start using it.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2631
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Technically this fixes an assertion, but only if the command
> line is daft, so I didn't think it worth backporting to stable.
> ---
>   include/hw/pci/msix.h |  4 ++--
>   hw/pci/msix.c         | 10 ++++++++--
>   2 files changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


