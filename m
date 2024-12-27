Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95558E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 17:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tREQo-0001mq-HT; Fri, 27 Dec 2024 12:47:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tREQm-0001mT-HW
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 12:47:24 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tREQk-0000MH-P2
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 12:47:24 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361c705434so54066545e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2024 09:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735321641; x=1735926441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Upq4/NuPbhmDhqEHgrsPOVaGPGFZdhsJYWJrZ1fSvAk=;
 b=TXh2F9mcz2lWrIz5zrOXO3PEIi5JV6MfucGJQpuzdprM5GSJD33j2L/dg71ToD9M0q
 bDsPh5e9k9YUGgOa6Rvj8gceANeGHmBVcUeJWt2GGuoLSTnZt2NTTmEQ53KxyltOUQCO
 2X9mRpCTv1BD3BsT5Fzc4ZgWVwzeo1mKij52gYJMl+ZJ0v9ERIJeQiq4LQdanAqX8PQg
 MRgtAoKWEI/DfmYAFM/3eu6C/6BnvqIyk66EqADBZ05R8qGq+DtcFqzzDb11iE5nd1kU
 0NVxjRc/aFj9Mc5757KxBX8IwqqSYRivaFj6AuNPbsoOMJSjTnRcIKlnej+wKCF09CdQ
 4gYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735321641; x=1735926441;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Upq4/NuPbhmDhqEHgrsPOVaGPGFZdhsJYWJrZ1fSvAk=;
 b=p2qKoSeJ4q0MpP3OHygGUJUj2udF+ShgPvqwTEuF5q1GAvLor0cgJnE2U7nF+UVXQy
 A7BvLWEQWil8gsl125BgUIMcFA3dCKtJvxBLHLjDEwzwZlxwi4ER+pk3LWvR/rrkUQ4c
 tn/DhPFK/oMwb0uByHdlkbAVMg/JkKWqsEc9cc7pY832ohqtm5Co2KQ2nradW/1nTznh
 /bKcz3MvFm9G6H8rh4iqX22N5NmEEroVPsajbupzCVl5e1tmUPJ0uDoPGIYbK+Aaiy3e
 j0v+jelVVI+9ZE8ITyI4lXJUPVnErnJsom3pg2yvp+SlRuPkYBrUOzc8nCaMxlHYL4bP
 Z5qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc/4ShjjIJ8q1g4oqWquyj+Az9QKkmFT3uOa32kE8/B+XfF0P1Vps05U3dfd38vanp226yO2TkWjZ0@nongnu.org
X-Gm-Message-State: AOJu0Yw/r0aAdKivhNvRkwkdrz0MSkD3x+5dmZm+0i32ZQ54mAtrJA3p
 nmv7jCWxQ7nqPkF7v3OWFCCDrlr10qBWYMWz8i71o349SJ38D7nrEavmTDKhY9A=
X-Gm-Gg: ASbGncvMBJMtaQ+z+PbDXgBXs+Ksl+lBCkJU0lQBrf/iSKfqLU0/MFqkLzHzdSZ384m
 xkWNFiVkz9/swiXBiYFdgBqj2NI7KoL4pUjUCK8ppxrOwXiTtCt/UXPLtr2gsD4k8iI7HQgiMiL
 +YspgBOIUEohiGVnDOKvWeNaSujhbmT8jKjKjbLnV7vC4b7UojVt9NieRXJFXvaIS6TxHCMLWMO
 vC1/UqlkQ5PSWmXf/ErVc0nWFdkOKXo0bo7BYiL6v2WcAilDy/WfbVOLWd/PF5oCAKYTE00Z3V7
 xQMh0XWAa/D0XMOkVjuVXsMgJJt9mA==
X-Google-Smtp-Source: AGHT+IEaOjFlHSDOsetW+YE+0bu17iB/3jrslQVywdvI8GfnxKEu9JeMBs+pd7Bu1ct73WRYfYcmww==
X-Received: by 2002:a05:600c:4f09:b0:434:a711:ace4 with SMTP id
 5b1f17b1804b1-4366864636dmr247794425e9.17.1735321640991; 
 Fri, 27 Dec 2024 09:47:20 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b119ccsm305620085e9.24.2024.12.27.09.47.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Dec 2024 09:47:19 -0800 (PST)
Message-ID: <4e9f481a-6f93-4f2a-b449-2f4777293893@linaro.org>
Date: Fri, 27 Dec 2024 18:47:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] hw/usb/hcd-xhci: Unimplemented/guest error logging
 for port MMIO
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, thuth@redhat.com, zhao1.liu@intel.com,
 imammedo@redhat.com, akihiko.odaki@daynix.com, npiggin@gmail.com
References: <20241227121336.25838-1-phil@philjordan.eu>
 <20241227121336.25838-5-phil@philjordan.eu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241227121336.25838-5-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 27/12/24 13:13, Phil Dennis-Jordan wrote:
> The XHCI device code uses tracing rather than logging on various code
> paths that are so far unimplemented. In some cases, these code paths
> actually indicate faulty guest software. This patch switches instances
> in the read and write handlers for the port MMIO region to use
> qemu_log_mask() with LOG_UNIMP or LOG_GUEST_ERROR, as appropriate in
> each case.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>   hw/usb/hcd-xhci.c | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


