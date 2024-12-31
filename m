Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE52E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 17:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSgCM-0002qZ-9U; Tue, 31 Dec 2024 12:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSgCI-0002po-SI
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 12:38:27 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSgCG-0006sg-PU
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 12:38:26 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so22080715e9.2
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 09:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735666703; x=1736271503; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2zHKdA6GmglYmvo9VF/c6jvg33mu7oV9/twb3oky6Js=;
 b=jmvwL03J6SEFVMetKLsAFg+mRmhCJEzq1hV1KBUXbyjeZ7NdudGgPbGkLuBHCN+Nto
 pwhvvKSDuWVMfJE2MwoNvjMw5a8igXHRarmtrna9zUaL30eGR8pU0agW4Lzb6k796VYn
 fm6kvsGGfnA7DQ/CxVsW5D0ieswZq/i+Kprl6vz1jxXC2egmIYagUDpDzcw0B8IjTxG/
 DdRRd4VaHLFDkVC7ywapo3JbUK72XA/GlAD1JpKGogft8IZIVzCTQ5JIGxB5ZfpCvf4s
 W5lod9G7vxnUG3PhUrhgRoaNovd0qYbcL6h285bwVwWaFB2ZG1W/di9vl3+Xml/UCCX6
 6gOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735666703; x=1736271503;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2zHKdA6GmglYmvo9VF/c6jvg33mu7oV9/twb3oky6Js=;
 b=PTENFRP8Bs6e54VcQ/5W7tX+niWHAg7K1mOhm1DcqQ7+adA1C8BEm/s8lDyi21oJ32
 Q7qbeTw6XJ8ILHViXgVZfO1Ymg6YL5BuCBzObAuP2jJbecTJ4StTC7GqJ4azi8uSZPDP
 iWhg6xXCFB1mg1glHmA+AV1gRUMkmnFJZuud8lJ0XF1rdPTOouoeL6WlIyHkMKRH3Aq6
 fYUDGahF3lyVD7jwtT6AmgEuhUaz2ZRkOnitubr6waaFnGUtilvFg3pD4d/PvjGTxRvD
 U2jCh+Tp+LyzZDIzoYTs78XLhOuKsdzoZVw4EZzRLoNUdfB2pbhsJRP5SAIjQLUYL8DR
 HZfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVClqxa8Y8c8bOF8AgjD7vHGq+E+WPNlRDfhg4tJRT710MZliFrLtwo+BeIuTMPMNPQrl0YYPuyS+Ey@nongnu.org
X-Gm-Message-State: AOJu0YzxVlajFh7Vao1REtUY712t/9DK8S+usNPyTh5LzzoEVPgcYpbU
 s36JQVrt1yAbD0BppGJ2cTLwZ2wuy8fGgp8UoDlN3H+CH4HxJoFGNIYLmwQSyrs=
X-Gm-Gg: ASbGncvAqoRh8L6QC0Wzpe39dk5CpSZcfcBclQ8l8K4I9WClbICXGfE0uJVFgMe+Fqn
 f31amj1TE2yPVJHNrCrd9f/C3e9aDrty8HCyfj3PrsfXrX3xAUXW9jOv5kpigIZmx/xQWn1Mr+D
 OnKIGo/imvaL5+3eD/qKZj4X3hlxBqcmfcjSO7O8ieK3SWujNX+9OfppKD2RmmuU4YZ6LT99883
 lEtFaQVZ2Somq+TYuaUBP57M/KxZoDlyNldzpXBtOPC5BZweBYpw449I7HZe8WdmLbPa0eX6b22
 mFp29PF3dxzLXSSrgXtu4DKP
X-Google-Smtp-Source: AGHT+IG3jpQAd3A2PysVaz2/hhEB4UZETKavf/jp6Rrt1tkCPeX/sOHjxpU2godgVULFdrLreJSrRQ==
X-Received: by 2002:a05:600c:3b9d:b0:436:6160:5b81 with SMTP id
 5b1f17b1804b1-43668643bd7mr335818705e9.14.1735666702630; 
 Tue, 31 Dec 2024 09:38:22 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e2d2sm33846216f8f.71.2024.12.31.09.38.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2024 09:38:21 -0800 (PST)
Message-ID: <cca34349-286b-424c-bf92-128ff92fd9c3@linaro.org>
Date: Tue, 31 Dec 2024 18:38:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fw_cfg: Don't set callback_opaque NULL in
 fw_cfg_modify_bytes_read()
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-devel@nongnu.org
Cc: kraxel@redhat.com, imammedo@redhat.com, wangzhou1@hisilicon.com,
 linuxarm@huawei.com
References: <20241203131806.37548-1-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241203131806.37548-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/12/24 14:18, Shameer Kolothum wrote:
> On arm/virt platform, Chen Xiang reported a Guest crash while
> attempting the below steps,
> 
> 1. Launch the Guest with nvdimm=on
> 2. Hot-add a NVDIMM dev
> 3. Reboot
> 4. Guest boots fine.
> 5. Reboot again.
> 6. Guest boot fails.
> 
> QEMU_EFI reports the below error:
> ProcessCmdAddPointer: invalid pointer value in "etc/acpi/tables"
> OnRootBridgesConnected: InstallAcpiTables: Protocol Error
> 
> Debugging shows that on first reboot(after hot adding NVDIMM),
> Qemu updates the etc/table-loader len,
> 
> qemu_ram_resize()
>    fw_cfg_modify_file()
>       fw_cfg_modify_bytes_read()
> 
> And in fw_cfg_modify_bytes_read() we set the "callback_opaque" for
> the key entry to NULL. Because of this, on the second reboot,
> virt_acpi_build_update() is called with a NULL "build_state" and
> returns without updating the ACPI tables. This seems to be
> upsetting the firmware.
> 
> To fix this, don't change the callback_opaque in fw_cfg_modify_bytes_read().
> 
> Fixes: bdbb5b1706d165 ("fw_cfg: add fw_cfg_machine_reset function")
> Reported-by: chenxiang <chenxiang66@hisilicon.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
> Hi,
> 
> I forgot to follow-up on the v2 and it never got picked up.
> Thanks to Wangzhou who recently re-run the tests and found that
> the problem mentioned above still exists. Hence resending the v2.
> 
> v2-->v3:
>   -Just rebase.
> 
> v2: https://lore.kernel.org/qemu-devel/20220908160354.2023-1-shameerali.kolothum.thodi@huawei.com/
> v1: https://lore.kernel.org/all/20220825161842.841-1-shameerali.kolothum.thodi@huawei.com/
> 
> Thanks,
> Shameer
> ---
>   hw/nvram/fw_cfg.c | 1 -
>   1 file changed, 1 deletion(-)

Patch queued, thanks!

