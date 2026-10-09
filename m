Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837B5CA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 12:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF9iy-0004BP-HW; Fri, 09 Oct 2026 08:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xF9iw-0004AY-L4
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 08:29:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xF9iv-0005pa-4B
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 08:29:18 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a16bc2278aso28808075e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 05:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791548955; x=1792153755; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tazyBU4o7mAe1z5RaDRuYKyfD9IYsi93FFaAVLAyCCA=;
 b=RPpV50QfeutVMl6eSOIyk2ftIFM+/cdISQNOTKCrNzr02F5gH2xr7OmV8lb8OvYNDm
 S4F/gAIi0EXxHEpp67ziY3dA+aUIc/+2k1NuXAHqxoMZIgZiQm1SKbgQ+qqr5YzH11NF
 aVVbnSsiuFK7gwsIkquB8nT3i7yjAlGItK7GIBN9zRVrJJ/8tQoDrCjUfSuoopqvv06T
 jI3uKcW3jpy4zU6h/j/oU0KxnXhv1pjrissfoeyNRpo1OpGhOSa6qZg2uMQKLPBRTMyI
 Dv4UVAzKUKFuab2GbImxzGXc0sWl6eIn+zxcUJ6KjjeNWux8YRjr98oQ6co39P6Vr1cY
 iuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791548955; x=1792153755;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tazyBU4o7mAe1z5RaDRuYKyfD9IYsi93FFaAVLAyCCA=;
 b=BBv9Uibk2r9wpUK3yy9lfKZ/ELwzzYIvfiRK8hn0aK+3kz+LRBIgW7A6MPia1y+s+8
 Rwb9xfHQiR1wpcGl3hH4+dKnXmG1657aXK21J+1ssOk470TBdwbMV+SsLkg+OWqwzfv4
 varGVdqWP6w+qnASvGWunApkg4MbabsNTUIkF3D5cDx4yHlMRxWQUvPTC+NHH5geoSPH
 o301bQBtet8FLG6ieVPGvKhs8gBrn6y4sL4ebWSmK+Fz3eLq93si0UF17JdqhoC0IT24
 XnkTGe8NOowHXrKcLmtjlkYcJ3H78CIJ+w3JjW5I+QbLDGX4QFMz74+wwxJNNcUuHZaX
 vbTQ==
X-Gm-Message-State: AFuF++k84d3JNFWQezAHCnM3fpTz2Z/lY0VK1If4AZeofksrFfPH45pP
 LzQTIR02zfEcXkra2mQmWFQi+lt3b7wnRLgxqS4dqjeiy7szzwMe6xw6JcwXSv3qmjvL8rowcSm
 7WlRGmbA=
X-Gm-Gg: AYBFou1VpkFQ+WHIj4kaXyKdQcxs5x4nzVTae3fv0Uf3ART2WoGefI4xjqsEtp62Wgt
 1UWag7ypjfMz21rO2DmtXi+Y1ooJ6Mc5qXcWVe7PTNIRZ+y3hhjXD52wdLa6rih0PXMriuocMuZ
 VQmMGUaTEdNL1eE5zxoTce2GSA/mL7Tk0mCYb9XgFWISJk/A26I9MT+31LsGSNX4k2B811qX802
 jIULzTTQMJDjsV6RWHkpipSed67JhdSl3fndDTLU1K2BvIHd/3zPm9pgnQDEFE7ONtQPxuYslda
 VfTWV3a0UjJsTyC+8jfulf71zK9EU9LajGVLc8FTynM50c2o/xD2XAYXRR0d9g4sXn+Pa9aYsl+
 BiLh5cNbuoOpLP/FVzfBQZk0A3bvSrTA67Ik1Xs8cLb+l1UZ9SDLVXnhi9tVP/dOlTO8uAFok/m
 5JKQoOjkk28oP6fetELi/5pyMsD0OnyYTe4pBePYBpWCyTZ1Cx1OiT4xgTIagrkADWGhkmHaisC
 tjN/0L7qyEzmCPdDsO7GmD4e2MKl4zbwhdZ27GO9VOnuRZpjNAOToY0tAb/KzyRfJjRyvMnQFVI
 15m2s6M1dUrV
X-Received: by 2002:a05:600c:46cf:b0:49e:8191:e5cb with SMTP id
 5b1f17b1804b1-4a18e4a3ac7mr33626135e9.5.1791548954390; 
 Fri, 09 Oct 2026 05:29:14 -0700 (PDT)
Received: from [10.86.151.227]
 (ipservice-092-208-245-012.092.208.pools.vodafone-ip.de. [92.208.245.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bea1fefsm65127185e9.11.2026.10.09.05.29.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 05:29:13 -0700 (PDT)
Message-ID: <5f06eef9-70a6-4713-b324-892cfca97eee@linaro.org>
Date: Fri, 9 Oct 2026 14:29:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/21] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20261007163302.332250-1-kwolf@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261007163302.332250-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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

On 10/7/26 18:32, Kevin Wolf wrote:
> The following changes since commit f9587d4045c67cd0d8d8bdcd5d0bb5b6b395b63c:
> 
>    Merge tag 'pbouvier/pr/plugins-20261005' ofhttps://gitlab.com/p-b-o/qemu into staging (2026-10-06 11:26:40 +0200)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/kevin.git tags/for-upstream
> 
> for you to fetch changes up to cf4f672c11d663f87462cfd99a92124b30804e99:
> 
>    block: Remove now redundant bdrv_wait_serialising_requests() calls (2026-10-07 18:00:36 +0200)
> 
> ----------------------------------------------------------------
> Block layer patches
> 
> - Fix corruption from broken RMW atomicity
> - Fix bdrv_next() skipping monitor-owned nodes
> - fdc: Account for read and write requests
> - throttle-groups: Fix crash when enabling I/O limits on a busy disk
> - file-posix: Fixed O_DIRECT alignment for truncate requests
> - file-posix: add statx(STATX_DIOALIGN) support
> - qcow2: (Partially) fix reopen for read-only nodes
> - scripts/qemugdb: Fixes for 'qemu bt' / 'qemu coroutine' commands
> - Code cleanup

Applied, thanks.

r~

