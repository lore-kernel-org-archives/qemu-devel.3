Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151B9CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 14:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCJ14-0002kF-Jx; Fri, 24 Oct 2025 10:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCJ12-0002jN-8L
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 10:43:40 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCJ10-0002Zh-FU
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 10:43:40 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4710683a644so17947935e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761317016; x=1761921816; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MeXAehse69IhwBgE2ta5MNN1CuhQA28c4e5HiOGylrY=;
 b=Y8S1Y9qz5Ql2504ASiFt1+g1MtW1F4WEOAsSDzdcgaCFnzvsz8X6aAqPo7QIB+rzTo
 qA+fnYy8NIlZAFknSrhALZtpPL17PMCTAeQqURE/NqiGayX3Yl2AS9IAQsbemwqBGXtP
 3DHniuLhfU1p02wR/jpN6lxqk2sIEcNEQyauCapRRChoXfCQLdDZp4Mr1TkbHKEtA33G
 kFRdgrW9VrrDDPNH1hVdLZJVpfPxrLUtHA6UaS/QsZTXn5ifnnx6F8beDozJVWRWlHSI
 O55Kj30xGVDbGdm6Ou5xJomF8xZtmDJoS3goIDMlJN5KBfY+9/cjsix0/M4BMywDQQZT
 ho/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761317016; x=1761921816;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MeXAehse69IhwBgE2ta5MNN1CuhQA28c4e5HiOGylrY=;
 b=XsJh+V2i/+5394JZbLg969600NG+kDX1w8cRXeCWqw99UbQXr5qU8mnszjTgR6kScO
 0vm7kIGdUC8SIcr7BkXE0BD5Asymw05/rOmD9l6UF7FXmCl2zDyOrPcRM0yaqk9cQkwY
 A6110JmS6wPRZ8tok0lz/kmwtspOgN9gJqlm3G1RJO97zJrlkyWP2esyJDZpgpl+nGLm
 wx0eDj7HWSt3NaJxU0ZD5B2WhQu8g4/fnb4q/BL2uVz5GzFwTPLuZEgU1fGD59P/T54Y
 oG+eJK4vaB5cg8X+dVe5T010JZpuZdQ2X43zCAfkjX/IqlzBAtgXGUvZ0Q4STe7f3C7p
 Vq/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi9J+ihwNCAXZu+lXP6BrhfrCP8dM5ccRa3Sf8JlistG0nOYw4yr5npJCaNEKjMvXWz0M4X6Tg7glU@nongnu.org
X-Gm-Message-State: AOJu0YzvxFqzoQxz9Knu02MzlU8tSyfFb6F/OW7dmffkDWOLwA014JMX
 7/o/fWjVVKuvqpvWmyyMYJ3TINFKVerkMq7+8bdzAaoW2oSYR0coD/yKflpobvWDYPw=
X-Gm-Gg: ASbGncvU0+o2xh2dPvtWzMRq6KvCsKhvfQ+ECVpl9ok2Jy1+kyZ0HTMWRhtQv5L5RI+
 6okjFoLU/qcm9RsJi3V+H7kNJKU5n//Eg/6I65n4VyowADrpfEBFsyYPYFMaZT+xivk2I1NPp+/
 s1S/3A4X2K82CPOXOxPHK/RnYhx+8ks/NWJ1Tf4o5xBQa3TS2auXspyJFUG6o7+IlFhwma8hssy
 CwIMN8AdA6WQmnkNMGqY7R+n2lqjoIG+suLtCVyOYsZvXRi7MjZn7Hdgjlajj+mDVVTidO+nuQ0
 dX5uYAjvU45Qr2oT2IlVJ3v0SMMsVf1IHkglrMNG88TI2jjM6Q0Kb6xuwrshqMXgLZhAbZ9q9Uy
 LGu8jQF3679f5AhRs0QNemzmxxsiV7VPexJufaitNwTT3XahAyDPqJ8di6xd2r8QoKr7MoGbvPD
 IRCAxyJO0rURr6wTIq8OQ3tAPUheA8sGCkzzvrqh8YpOQ9LTr4J5biew==
X-Google-Smtp-Source: AGHT+IHcLsBPWNUVB3dq2PvtLXk70B2+RU9HdkJgTtEzGy9Zvy80VUahV92lsDfZ2Do2sVjxLbjcuQ==
X-Received: by 2002:a05:600c:c16b:b0:45d:5c71:769d with SMTP id
 5b1f17b1804b1-475d5680454mr21077855e9.8.1761317016459; 
 Fri, 24 Oct 2025 07:43:36 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c427f77bsm157026255e9.3.2025.10.24.07.43.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 07:43:35 -0700 (PDT)
Message-ID: <04aad62d-321e-4b37-ad11-4f785f7c3d81@linaro.org>
Date: Fri, 24 Oct 2025 16:43:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 04/24] hw/uefi: add include/hw/uefi/var-service.h
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250304124815.591749-1-kraxel@redhat.com>
 <20250304124815.591749-5-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250304124815.591749-5-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Hi,

On 4/3/25 13:47, Gerd Hoffmann wrote:
> Add state structs and function declarations for the uefi-vars device.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Message-ID: <20250225163031.1409078-5-kraxel@redhat.com>
> ---
>   include/hw/uefi/var-service.h | 191 ++++++++++++++++++++++++++++++++++
>   1 file changed, 191 insertions(+)
>   create mode 100644 include/hw/uefi/var-service.h
> 
> diff --git a/include/hw/uefi/var-service.h b/include/hw/uefi/var-service.h
> new file mode 100644
> index 000000000000..f7ceac4ce243
> --- /dev/null
> +++ b/include/hw/uefi/var-service.h
> @@ -0,0 +1,191 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * uefi-vars device - state struct and function prototypes
> + */
> +#ifndef QEMU_UEFI_VAR_SERVICE_H
> +#define QEMU_UEFI_VAR_SERVICE_H
> +
> +#include "qemu/uuid.h"
> +#include "qemu/queue.h"
> +
> +#include "hw/uefi/var-service-edk2.h"
> +
> +#define MAX_BUFFER_SIZE (64 * 1024)
> +
> +typedef struct uefi_variable uefi_variable;
> +typedef struct uefi_var_policy uefi_var_policy;
> +typedef struct uefi_vars_state uefi_vars_state;
> +
> +typedef struct uefi_vars_cert uefi_vars_cert;
> +typedef struct uefi_vars_hash uefi_vars_hash;
> +typedef struct uefi_vars_siglist uefi_vars_siglist;
> +
> +struct uefi_variable {
> +    QemuUUID                          guid;
> +    uint16_t                          *name;
> +    uint32_t                          name_size;
> +    uint32_t                          attributes;
> +    void                              *data;
> +    uint32_t                          data_size;
> +    efi_time                          time;
> +    void                              *digest;
> +    uint32_t                          digest_size;
> +    QTAILQ_ENTRY(uefi_variable)       next;
> +};
> +
> +struct uefi_var_policy {
> +    variable_policy_entry             *entry;
> +    uint32_t                          entry_size;
> +    uint16_t                          *name;
> +    uint32_t                          name_size;
> +
> +    /* number of hashmarks (wildcard character) in name */
> +    uint32_t                          hashmarks;
> +
> +    QTAILQ_ENTRY(uefi_var_policy)     next;
> +};
> +
> +struct uefi_vars_state {
> +    MemoryRegion                      mr;

FYI this is missing "system/memory.h" which is indirectly included,
otherwise when refactoring unrelated generic headers I get:

include/hw/uefi/var-service.h:50:39: error: field has incomplete type 
'MemoryRegion' (aka 'struct MemoryRegion')
    50 |     MemoryRegion                      mr;
       |                                       ^
include/qemu/typedefs.h:68:16: note: forward declaration of 'struct 
MemoryRegion'
    68 | typedef struct MemoryRegion MemoryRegion;
       |                ^

No need to post a fix, I'll with my refactor.

> +    uint16_t                          sts;
> +    uint32_t                          buf_size;
> +    uint32_t                          buf_addr_lo;
> +    uint32_t                          buf_addr_hi;
> +    uint8_t                           *buffer;
> +    QTAILQ_HEAD(, uefi_variable)      variables;
> +    QTAILQ_HEAD(, uefi_var_policy)    var_policies;
> +
> +    /* pio transfer buffer */
> +    uint32_t                          pio_xfer_offset;
> +    uint8_t                           *pio_xfer_buffer;
> +
> +    /* boot phases */
> +    bool                              end_of_dxe;
> +    bool                              ready_to_boot;
> +    bool                              exit_boot_service;
> +    bool                              policy_locked;
> +
> +    /* storage accounting */
> +    uint64_t                          max_storage;
> +    uint64_t                          used_storage;
> +
> +    /* config options */
> +    char                              *jsonfile;
> +    int                               jsonfd;
> +    bool                              force_secure_boot;
> +    bool                              disable_custom_mode;
> +    bool                              use_pio;
> +};


