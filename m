Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CB4D12D55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 12:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQlqh-00026b-Sp; Wed, 03 Dec 2025 07:20:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQlqc-00024g-H8
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 07:20:42 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQlqZ-0003W9-C9
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 07:20:41 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c76d855ddbso1230757a34.3
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 04:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764764435; x=1765369235; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pqW304W3ISjK3sGD+I68Yvprgj2KMjUVAMgE/klyJCU=;
 b=w89JA8GeTlKTjOrYeAqySxuzhufHjCdgBUidyoZ5UNvhoDoJ0tvD8Aik5UNlhvoous
 vcLmrokKJFqGzIn95VZcXojMNE6lQOPDKqfbqc1jSb9S2EyxvEvXk3QCpC0XyjxdtXWN
 CZZeFWBXwRzg5oewSYl0lw26H7z/xdmrU37usKZW/dh+wCQvMM4EQLv38LAPLZxvYnYu
 rsMhJ0PGlqtHwxVgE92JiOlMn9GzwHMFDiYtO9x0wz0z7eQR+Wmh47/OchWpf0y0dlfN
 KLJq5VzZwLpH/t8t/3O/YvLWufuZniSEfOnsMqeEf8HkyruU1MT8RdGygaolt3fpz/YA
 Zx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764764435; x=1765369235;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pqW304W3ISjK3sGD+I68Yvprgj2KMjUVAMgE/klyJCU=;
 b=cgoomDUG6NnBHF9C7t0Mg42qxGhS4Xz2t45/m5ckFh8WiZgCopcD0jujzl6TKEhcus
 A6b9jBMy7/LfKVlYtDLGJr10qhVPloABNSN7A4Lh/zXCSn04xtI49mauXalPtjk/6JLT
 kb5T4ZLEiOEBKrUjNhkTxeoPhOdOGJh6RZXHFJLuSREzQDFvMR4RcGjvPGZBVWOpqtuB
 VJIYZfIe82oTqBhSYKfv1ynlrFWvKb9kXCECqc3RNqdWzotz+r4v370lXV9Ld9++RAPi
 2lQvEDG9JoL9nqARXhQJAGVfLO6d0be11sVQvoX5nszJwMUhw2bYZH4ej1CtXjVTcYIr
 Y2hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7tJgnLr56gQGW2SIOy/o0PbjJsypAfIu9jI6FBzlXO+IHM65BCg4Yr1PwhWSWoWq0wpciXRRDk0ZU@nongnu.org
X-Gm-Message-State: AOJu0YwB4+g17Dc14oUb87AoMjREitqw1pFj4Roru5ON+YpZEq1TiFG3
 TQI+l3oxjjtlMxGepNX21wrMqQwFQnSdQIj9wmEmx2o8g3XT59XS96BNaWgGRR1aQSQ=
X-Gm-Gg: ASbGncs72TjCDnCqJXAHeMlqK8dBfrDQrluDNK3IRfSHu5ix0xrHmXmX83lUA8oRYxe
 QlOT9vMeOAakiEJX3+qskwABTNzILYs+i9ZkCdTGZMpyeuC1eTvmHQyFSbqALE/E6w7lD9PZpQz
 FXZ2WKtwm9nLJ8FR7qVT+wpzSM0D7hhUUhPBvkYGIqt66Fof6Joy2079gsV7LqfdczSWb0kDu80
 5/CVOxEe0ANihRTfv1MZbW+TGlG5LD0qgYS/1UQqdH2g5Tdw4iwSLjthd/tGPTX66q57O2HfLG/
 2PvqJve/yZfoAF8r9VKJznK9P2vMl9KuJUckoKo2s+a7IPZ3BIhc6K4k4yEkZ/MbVHpC3EqQkNM
 d3mDDJvWcVe6fEk6ecozIXonuHHwC+2Aty/Xt7QgF0m4qysJ1uFOyqA8JI9oe5CYzoeARpPQRw/
 acuqlGADShLvAoHv0yxCT3RT6Pyg==
X-Google-Smtp-Source: AGHT+IE9l4JZ658zPs2+uzLZyQzyb7hS4F5V7QTjsc+YBr/5di+AAfdBXfSLJLklq/b5KlwfUaJm8A==
X-Received: by 2002:a05:6830:2e03:b0:7c7:5f09:8792 with SMTP id
 46e09a7af769-7c94dc03b7emr1856765a34.17.1764764435479; 
 Wed, 03 Dec 2025 04:20:35 -0800 (PST)
Received: from [10.27.7.193] ([187.210.107.189])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90f5fe927sm8547799a34.9.2025.12.03.04.20.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 04:20:35 -0800 (PST)
Message-ID: <32712cf5-2df0-4a62-8137-dde4f9328b0e@linaro.org>
Date: Wed, 3 Dec 2025 04:20:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] Error reporting patches for 2025-12-02
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20251202083206.4180561-1-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251202083206.4180561-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

On 12/2/25 00:32, Markus Armbruster wrote:
> The following changes since commit 9ef49528b5286f078061b52ac41e0ca19fa10e36:
> 
>    Merge tag 'hw-misc-20251125' ofhttps://github.com/philmd/qemu into staging (2025-11-25 14:22:39 -0800)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git tags/pull-error-2025-12-02
> 
> for you to fetch changes up to 88be119fb19b8ee04d681ad9048cde9f6a37c631:
> 
>    kvm: Fix kvm_vm_ioctl() and kvm_device_ioctl() return value (2025-12-02 07:46:21 +0100)
> 
> ----------------------------------------------------------------
> Error reporting patches for 2025-12-02

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

