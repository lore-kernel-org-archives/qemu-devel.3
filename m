Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A67C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 22:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubRkO-0002q6-4U; Mon, 14 Jul 2025 18:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubQqD-0004ai-0w
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 17:36:05 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubQqA-0002E8-VR
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 17:36:04 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45618ddd62fso16555545e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 14:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752528961; x=1753133761; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IFteLS0V4c4i6gGYb4295S8Sf5+R90q2vU9r62EaS8g=;
 b=wxldCuW8YQJLtdYIqsp7k+ufj+IsVMVkH8XkfLPhPSkyWCgFRRQaRsRgIA4OuQQwQV
 W5mgwvXEIsrhnjt/FJOeA8iJcmNdcG3mCB6kpIl1ZzYWXvyiPTjurKD6t1Riy9rdis+s
 4tW/1Xi4/nvs2Vi8rhirfXw9pByPqM9p57+j4YiVMKtAkISUoZVkNoy7TY8xhuDhrA/F
 E6fYq3D6Ve6mwo2xF4aQNY3+kXiMMmfK4/ATzxa6dwZ1P/K9mrYhNCQX5XIBFYwVONOd
 FhK9mSzM18/mRuTh0OJvmwQ0ow/EwGr5nZGuB6Q2oy0rYNICGPU92d4d6PdqjwisY2TE
 I6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752528961; x=1753133761;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IFteLS0V4c4i6gGYb4295S8Sf5+R90q2vU9r62EaS8g=;
 b=EtBdFyV0AfYa7m9HlUCRxuWqdyfVkFwByoF3OfnFUm7HCVRS/J3QHI4B/GIYPaJlMF
 uu13wE2f+ONHWcXavY/QguF0SzXHIyl4N0zYsh1WMAG0OpmWioBb9OSB81gYxSp6m+Fk
 rpJ9O4Wo2GA2UN4bHdMLQDSixi5h+9dZmd8B3vol1apcr/StdzhynUjQ+I5Tapi9QFhQ
 L0UsVTKUTV1ORlxAXfMOqAqxnFKUIwKLDWrmJmETWVESzjVV4DKENJUfLNVvTY2SWPu7
 KplxVqKWsLSabXdhdxZfL1IyrxmuRRUS6z/33FkvJLDgmjjLfaMFw0c4St2KUy9H0r9S
 8m2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmTGUsLt7KBtoG3MbpJB1R6cuQSlG3mh7PhLCsD/jhcga2R3sX9RhobMXCPoiavOJCsCL/0sGRHBfw@nongnu.org
X-Gm-Message-State: AOJu0YzKYMnf/KDgSPbUDHK/JnfzqqoQL8ipDKuI9vngGtezkNOOzHik
 1DhC2UbjcT3OTZ3qf40SWfK4Oaszqgxewyy5MsaxIBwvd4ZShvjdsPFQmsL7UqFXq8c=
X-Gm-Gg: ASbGnctUGsx8nAGGNCgq8ABAch35ACB2M56EtMB6HDW8vPd7nT6d5jqB/13fhFMFm4I
 YlYPDPDhx9Ue2Ot9157mZb0f9WQx469t4f0TZdE2XGyVEotVNna7zDe04DKLnyI0AGQBSjmlyZk
 276H5bKTGKOs4w3X4Zudh1YBXUiDiqBjjDJYl+31vL5L8FPYfSuavh/xced2hGBHDdmc4l8YqVr
 +Rt6Y81jXSdq1z1pq1eQxVu5Al0Fk4Y0VDZWb5NcvSAnyG0347L6D8uZte0ppWhh0z5q/3J8/WO
 QSf048kJsfUChpDVj69ouJXeajfnbfRKa0NW28BJD0GJKWUoZqA4hBijxncJ1roi0gFEmV4FCBu
 cDEFE9iTQ/z8N+WeDx8w0i9oToMNvTt2zk9YGjpCs49UYKUnG6wgXOv+/lJ1rJgqT80s+0FA=
X-Google-Smtp-Source: AGHT+IEyA+ESg/pEAYMU+/ldk+7dylKHvBXVZntzUd/lgGEH+fjYAD/PwEEcVQfHHR60K4GVZrhw3g==
X-Received: by 2002:a05:6000:1a8b:b0:3a5:25e4:264f with SMTP id
 ffacd0b85a97d-3b5f2e1bb21mr11256222f8f.31.1752528961062; 
 Mon, 14 Jul 2025 14:36:01 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d77asm13688251f8f.58.2025.07.14.14.36.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 14:36:00 -0700 (PDT)
Message-ID: <c9c3ac80-e88e-4779-902b-707fb5c9f959@linaro.org>
Date: Mon, 14 Jul 2025 23:35:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] pc-bios/dtb: Remove device tree blobs
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250708204806.1898-1-shentey@gmail.com>
 <20250708204806.1898-4-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250708204806.1898-4-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 8/7/25 22:48, Bernhard Beschow wrote:
> Now that the existance of a device tree compiler is enusred, it is possible to

"ensured"

> always generate the DTBs from sources. This avoids checked in DTBs to become
> inconsistent with their sources.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   MAINTAINERS                          |   2 +-
>   pc-bios/dtb/bamboo.dtb               | Bin 3211 -> 0 bytes
>   pc-bios/dtb/canyonlands.dtb          | Bin 9779 -> 0 bytes
>   pc-bios/dtb/meson.build              |  16 +++++++---------
>   pc-bios/dtb/petalogix-ml605.dtb      | Bin 9882 -> 0 bytes
>   pc-bios/dtb/petalogix-s3adsp1800.dtb | Bin 8161 -> 0 bytes
>   6 files changed, 8 insertions(+), 10 deletions(-)
>   delete mode 100644 pc-bios/dtb/bamboo.dtb
>   delete mode 100644 pc-bios/dtb/canyonlands.dtb
>   delete mode 100644 pc-bios/dtb/petalogix-ml605.dtb
>   delete mode 100644 pc-bios/dtb/petalogix-s3adsp1800.dtb

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


