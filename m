Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E89CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNQi-0007c5-Ev; Sat, 30 Aug 2025 11:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1us1e9-0003Wd-AL
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 12:08:13 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1us1e5-0008G2-W8
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 12:08:13 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45a1b0c8867so20108755e9.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 09:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756483685; x=1757088485; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1bdT+FbwQxM19QOto7Jq7CUzlonVbULRUD0RULaYVII=;
 b=zG/USa3IVwZUGUd4UBo+/9ilPwrS8uJIbzbf1c5FV7STdChLKxaGo/SrcxLAV+WVDg
 7TOiKpx2HULpOvs+vMRqIIQEkJ3Dk1v2IwhQOVdF7LHQP1wgMmww5R5RXrsJt62Isk8c
 mF9zPdJmZYho5lqoBBv0jQ1txu8RVjahDHZtfuiw2NuG/rPAQQLFS9cssZPnybp7lnOR
 d+bZcW7Hnmh7bxnQZP/1zaO8M3jMrUrcPS6uBnBLd82L3d6qWeufLb3qNcyM/GpwN8Cf
 mYDploP6NtQHMjTH6NqRl8CW8LRHZl5lJreLiDvNcUR0n8RWn0OsrmIKvJBZOrbTN62C
 iPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756483685; x=1757088485;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1bdT+FbwQxM19QOto7Jq7CUzlonVbULRUD0RULaYVII=;
 b=ULK+vxMOco6dzwBGNDglviKYt4RIxHRBy6Qhd/yaetT5t/SxDlqtKZt/FAh/zP0gtV
 etlhhP1TrnvRijeLbUXFZ5q3QFL85R/2xBFdNToWLxaPmjxiYcNGQ5EUnQw8JaNvdtRW
 VRdI+RjvtoM0BxKRFP2ucQNDtpBdE59KyPyaVRX25nrBVFfSc81zeZ+IWaoebYBR40G0
 BX07uPJ2/7WuKdSLSOgkRJks5/iykER6iw3vHwyDnXE9CT4vG6ASXrn11ftjKH7ATMLn
 cCinsRbIgI7zQmeonbejDSVTyLXJsdMAkG+NB7eU6NrNXp68BllwQTGz+nV+aFbl9QQc
 fCHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzvcJFVHc0POTi9tu72SqBQP9E2HZ9akn/cy5cpXXk8nblmSazwOIYZzuVJfirO18zgI5ZzfJ1Siq8@nongnu.org
X-Gm-Message-State: AOJu0Yw6ewjdXrJ7QwEYOKdS0vc5rA/DT6zarQ/auhLNLHQp97vj8K+8
 pF9A6E40Okgts1ojChIC3M9DM3szPw32AzNUeRw3vFJqYJLJZJAVGGjz2oGe0rdmUu8=
X-Gm-Gg: ASbGncvGHfFMpdliAEb1RHlqawc9HAgkKAqRNvo1/XCEBVPopwsx5vyRaYX0/yeO5F5
 7JPO9keYC+srrela5mXo/QGxqnn9wwRnTCSdVuEIgkv1Rfk27ePhq9o9ANiActyfieT4jMSnqG7
 J0koAA4GOfNgf94vGXF9I1pUMq4Iiyon8gJ7kJucmteppzEwKLxnJ8+L76lq0TKUWIprMIaEaXD
 L1WK03iL2METsmeyicQ1Zzn+5Z81G1dph8X9XVXr6CcCF8dFWijOO27PxKCgtO7sc3jzmPHU2k/
 DIj4FlvG4vrPeAE34hGTXodYMloiiSu1PwXCmGVx4urlVClHKa8NIX13xkvyh8j1gCLRbliJTAg
 8ZtgfSixFGMhG1nxQY3D6mjgdMUji0G/Ez8OSgGSC91IsGbnnwYp3LRYGr2Mi9Vjv//IRETb6iO
 he
X-Google-Smtp-Source: AGHT+IEM+6KpH6oDUzr0lN//poUNxfYzzFtom4jkhcoo9PhxlshbvSyejTGCBWR7JZlwHIjOgAAtbg==
X-Received: by 2002:a05:600c:4715:b0:456:302:6dc3 with SMTP id
 5b1f17b1804b1-45b517d4c47mr230804695e9.26.1756483684854; 
 Fri, 29 Aug 2025 09:08:04 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276c751esm3847062f8f.16.2025.08.29.09.08.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 09:08:04 -0700 (PDT)
Message-ID: <472194f0-5853-4c7f-8b52-3c85e902097d@linaro.org>
Date: Fri, 29 Aug 2025 18:08:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] hw/i2c: add support for PMBus
To: Titus Rwantare <titusr@google.com>, Corey Minyard <minyard@acm.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley
 <joel@jms.id.au>, Hao Wu <wuhaotsh@google.com>
References: <20210708172556.1868139-1-titusr@google.com>
 <20210708172556.1868139-2-titusr@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20210708172556.1868139-2-titusr@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Hi Titus,

On 8/7/21 19:25, Titus Rwantare wrote:
> QEMU has support for SMBus devices, and PMBus is a more specific
> implementation of SMBus. The additions made in this commit makes it easier to
> add new PMBus devices to QEMU.
> 
> https://pmbus.org/specification-archives/
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Hao Wu <wuhaotsh@google.com>
> Signed-off-by: Titus Rwantare <titusr@google.com>
> ---
>   include/hw/i2c/pmbus_device.h |  517 +++++++++++
>   hw/i2c/pmbus_device.c         | 1612 +++++++++++++++++++++++++++++++++
>   hw/arm/Kconfig                |    1 +
>   hw/i2c/Kconfig                |    4 +
>   hw/i2c/meson.build            |    1 +
>   5 files changed, 2135 insertions(+)
>   create mode 100644 include/hw/i2c/pmbus_device.h
>   create mode 100644 hw/i2c/pmbus_device.c


> +static uint8_t pmbus_receive_byte(SMBusDevice *smd)
> +{
> +    PMBusDevice *pmdev = PMBUS_DEVICE(smd);
> +    PMBusDeviceClass *pmdc = PMBUS_DEVICE_GET_CLASS(pmdev);
> +    uint8_t ret = 0xFF;
> +    uint8_t index = pmdev->page;
> +
> +    if (pmdev->out_buf_len != 0) {
> +        ret = pmbus_out_buf_pop(pmdev);
> +        return ret;
> +    }
> +
> +    switch (pmdev->code) {
> +    case PMBUS_PAGE:
> +        pmbus_send8(pmdev, pmdev->page);
> +        break;
> +
> +    case PMBUS_OPERATION:                 /* R/W byte */
> +        pmbus_send8(pmdev, pmdev->pages[index].operation);
> +        break;
> +
> +    case PMBUS_ON_OFF_CONFIG:             /* R/W byte */
> +        pmbus_send8(pmdev, pmdev->pages[index].on_off_config);
> +        break;
> +
> +    case PMBUS_PHASE:                     /* R/W byte */
> +        pmbus_send8(pmdev, pmdev->pages[index].phase);
> +        break;
> +
> +    case PMBUS_WRITE_PROTECT:             /* R/W byte */
> +        pmbus_send8(pmdev, pmdev->pages[index].write_protect);
> +        break;
> +
> +    case PMBUS_CAPABILITY:
> +        pmbus_send8(pmdev, pmdev->capability);
> +        break;
> +
> +    case PMBUS_VOUT_MODE:                 /* R/W byte */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VOUT_MODE) {
> +            pmbus_send8(pmdev, pmdev->pages[index].vout_mode);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_VOUT_COMMAND:              /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VOUT) {
> +            pmbus_send16(pmdev, pmdev->pages[index].vout_command);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_VOUT_TRIM:                 /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VOUT) {
> +            pmbus_send16(pmdev, pmdev->pages[index].vout_trim);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_VOUT_CAL_OFFSET:           /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VOUT) {
> +            pmbus_send16(pmdev, pmdev->pages[index].vout_cal_offset);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_VOUT_MAX:                  /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VOUT) {
> +            pmbus_send16(pmdev, pmdev->pages[index].vout_max);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_VOUT_MARGIN_HIGH:          /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VOUT_MARGIN) {
> +            pmbus_send16(pmdev, pmdev->pages[index].vout_margin_high);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_VOUT_MARGIN_LOW:           /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VOUT_MARGIN) {
> +            pmbus_send16(pmdev, pmdev->pages[index].vout_margin_low);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_VOUT_TRANSITION_RATE:      /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VOUT) {
> +            pmbus_send16(pmdev, pmdev->pages[index].vout_transition_rate);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_VOUT_DROOP:                /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VOUT) {
> +            pmbus_send16(pmdev, pmdev->pages[index].vout_droop);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_VOUT_SCALE_LOOP:           /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VOUT) {
> +            pmbus_send16(pmdev, pmdev->pages[index].vout_scale_loop);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_VOUT_SCALE_MONITOR:        /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VOUT) {
> +            pmbus_send16(pmdev, pmdev->pages[index].vout_scale_monitor);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    /* TODO: implement coefficients support */
> +
> +    case PMBUS_POUT_MAX:                  /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_POUT) {
> +            pmbus_send16(pmdev, pmdev->pages[index].pout_max);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_VIN_ON:                    /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VIN) {
> +            pmbus_send16(pmdev, pmdev->pages[index].vin_on);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_VIN_OFF:                   /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VIN) {
> +            pmbus_send16(pmdev, pmdev->pages[index].vin_off);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_IOUT_CAL_GAIN:             /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_IOUT_GAIN) {
> +            pmbus_send16(pmdev, pmdev->pages[index].iout_cal_gain);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_VOUT_OV_FAULT_LIMIT:       /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VOUT) {
> +            pmbus_send16(pmdev, pmdev->pages[index].vout_ov_fault_limit);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_VOUT_OV_FAULT_RESPONSE:    /* R/W byte */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VOUT) {
> +            pmbus_send8(pmdev, pmdev->pages[index].vout_ov_fault_response);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_VOUT_OV_WARN_LIMIT:        /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VOUT) {
> +            pmbus_send16(pmdev, pmdev->pages[index].vout_ov_warn_limit);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_VOUT_UV_WARN_LIMIT:        /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VOUT) {
> +            pmbus_send16(pmdev, pmdev->pages[index].vout_uv_warn_limit);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_VOUT_UV_FAULT_LIMIT:       /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VOUT) {
> +            pmbus_send16(pmdev, pmdev->pages[index].vout_uv_fault_limit);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_VOUT_UV_FAULT_RESPONSE:    /* R/W byte */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VOUT) {
> +            pmbus_send8(pmdev, pmdev->pages[index].vout_uv_fault_response);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_IOUT_OC_FAULT_LIMIT:       /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_IOUT) {
> +            pmbus_send16(pmdev, pmdev->pages[index].iout_oc_fault_limit);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_IOUT_OC_FAULT_RESPONSE:    /* R/W byte */
> +        if (pmdev->pages[index].page_flags & PB_HAS_IOUT) {
> +            pmbus_send8(pmdev, pmdev->pages[index].iout_oc_fault_response);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_IOUT_OC_LV_FAULT_LIMIT:    /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_IOUT) {
> +            pmbus_send16(pmdev, pmdev->pages[index].iout_oc_lv_fault_limit);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_IOUT_OC_LV_FAULT_RESPONSE: /* R/W byte */
> +        if (pmdev->pages[index].page_flags & PB_HAS_IOUT) {
> +            pmbus_send8(pmdev, pmdev->pages[index].iout_oc_lv_fault_response);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_IOUT_OC_WARN_LIMIT:        /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_IOUT) {
> +            pmbus_send16(pmdev, pmdev->pages[index].iout_oc_warn_limit);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_IOUT_UC_FAULT_LIMIT:       /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_IOUT) {
> +            pmbus_send16(pmdev, pmdev->pages[index].iout_uc_fault_limit);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_IOUT_UC_FAULT_RESPONSE:    /* R/W byte */
> +        if (pmdev->pages[index].page_flags & PB_HAS_IOUT) {
> +            pmbus_send8(pmdev, pmdev->pages[index].iout_uc_fault_response);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_OT_FAULT_LIMIT:            /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_TEMPERATURE) {
> +            pmbus_send16(pmdev, pmdev->pages[index].ot_fault_limit);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_OT_FAULT_RESPONSE:         /* R/W byte */
> +        if (pmdev->pages[index].page_flags & PB_HAS_TEMPERATURE) {
> +            pmbus_send8(pmdev, pmdev->pages[index].ot_fault_response);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_OT_WARN_LIMIT:             /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_TEMPERATURE) {
> +            pmbus_send16(pmdev, pmdev->pages[index].ot_warn_limit);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_UT_WARN_LIMIT:             /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_TEMPERATURE) {
> +            pmbus_send16(pmdev, pmdev->pages[index].ut_warn_limit);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_UT_FAULT_LIMIT:            /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_TEMPERATURE) {
> +            pmbus_send16(pmdev, pmdev->pages[index].ut_fault_limit);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_UT_FAULT_RESPONSE:         /* R/W byte */
> +        if (pmdev->pages[index].page_flags & PB_HAS_TEMPERATURE) {
> +            pmbus_send8(pmdev, pmdev->pages[index].ut_fault_response);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_VIN_OV_FAULT_LIMIT:        /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VIN) {
> +            pmbus_send16(pmdev, pmdev->pages[index].vin_ov_fault_limit);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_VIN_OV_FAULT_RESPONSE:     /* R/W byte */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VIN) {
> +            pmbus_send8(pmdev, pmdev->pages[index].vin_ov_fault_response);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_VIN_OV_WARN_LIMIT:         /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VIN) {
> +            pmbus_send16(pmdev, pmdev->pages[index].vin_ov_warn_limit);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_VIN_UV_WARN_LIMIT:         /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VIN) {
> +            pmbus_send16(pmdev, pmdev->pages[index].vin_uv_warn_limit);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_VIN_UV_FAULT_LIMIT:        /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VIN) {
> +            pmbus_send16(pmdev, pmdev->pages[index].vin_uv_fault_limit);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_VIN_UV_FAULT_RESPONSE:     /* R/W byte */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VIN) {
> +            pmbus_send8(pmdev, pmdev->pages[index].vin_uv_fault_response);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_IIN_OC_FAULT_LIMIT:        /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_IIN) {
> +            pmbus_send16(pmdev, pmdev->pages[index].iin_oc_fault_limit);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_IIN_OC_FAULT_RESPONSE:     /* R/W byte */
> +        if (pmdev->pages[index].page_flags & PB_HAS_IIN) {
> +            pmbus_send8(pmdev, pmdev->pages[index].iin_oc_fault_response);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_IIN_OC_WARN_LIMIT:         /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_IIN) {
> +            pmbus_send16(pmdev, pmdev->pages[index].iin_oc_warn_limit);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_POUT_OP_FAULT_LIMIT:       /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_POUT) {
> +            pmbus_send16(pmdev, pmdev->pages[index].pout_op_fault_limit);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_POUT_OP_FAULT_RESPONSE:    /* R/W byte */
> +        if (pmdev->pages[index].page_flags & PB_HAS_POUT) {
> +            pmbus_send8(pmdev, pmdev->pages[index].pout_op_fault_response);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_POUT_OP_WARN_LIMIT:        /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_POUT) {
> +            pmbus_send16(pmdev, pmdev->pages[index].pout_op_warn_limit);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_PIN_OP_WARN_LIMIT:         /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_PIN) {
> +            pmbus_send16(pmdev, pmdev->pages[index].pin_op_warn_limit);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_STATUS_BYTE:               /* R/W byte */
> +        pmbus_send8(pmdev, pmdev->pages[index].status_word & 0xFF);
> +        break;
> +
> +    case PMBUS_STATUS_WORD:               /* R/W word */
> +        pmbus_send16(pmdev, pmdev->pages[index].status_word);
> +        break;
> +
> +    case PMBUS_STATUS_VOUT:               /* R/W byte */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VOUT) {
> +            pmbus_send8(pmdev, pmdev->pages[index].status_vout);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_STATUS_IOUT:               /* R/W byte */
> +        if (pmdev->pages[index].page_flags & PB_HAS_IOUT) {
> +            pmbus_send8(pmdev, pmdev->pages[index].status_iout);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_STATUS_INPUT:              /* R/W byte */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VIN ||
> +            pmdev->pages[index].page_flags & PB_HAS_IIN ||
> +            pmdev->pages[index].page_flags & PB_HAS_PIN) {
> +            pmbus_send8(pmdev, pmdev->pages[index].status_input);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_STATUS_TEMPERATURE:        /* R/W byte */
> +        if (pmdev->pages[index].page_flags & PB_HAS_TEMPERATURE) {
> +            pmbus_send8(pmdev, pmdev->pages[index].status_temperature);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_STATUS_CML:                /* R/W byte */
> +        pmbus_send8(pmdev, pmdev->pages[index].status_cml);
> +        break;
> +
> +    case PMBUS_STATUS_OTHER:              /* R/W byte */
> +        pmbus_send8(pmdev, pmdev->pages[index].status_other);
> +        break;
> +
> +    case PMBUS_READ_EIN:                  /* Read-Only block 5 bytes */
> +        if (pmdev->pages[index].page_flags & PB_HAS_EIN) {
> +            pmbus_send(pmdev, pmdev->pages[index].read_ein, 5);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_READ_EOUT:                 /* Read-Only block 5 bytes */
> +        if (pmdev->pages[index].page_flags & PB_HAS_EOUT) {
> +            pmbus_send(pmdev, pmdev->pages[index].read_eout, 5);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_READ_VIN:                  /* Read-Only word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VIN) {
> +            pmbus_send16(pmdev, pmdev->pages[index].read_vin);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_READ_IIN:                  /* Read-Only word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_IIN) {
> +            pmbus_send16(pmdev, pmdev->pages[index].read_iin);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_READ_VOUT:                 /* Read-Only word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VOUT) {
> +            pmbus_send16(pmdev, pmdev->pages[index].read_vout);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_READ_IOUT:                 /* Read-Only word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_IOUT) {
> +            pmbus_send16(pmdev, pmdev->pages[index].read_iout);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_READ_TEMPERATURE_1:        /* Read-Only word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_TEMPERATURE) {
> +            pmbus_send16(pmdev, pmdev->pages[index].read_temperature_1);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_READ_TEMPERATURE_2:        /* Read-Only word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_TEMP2) {
> +            pmbus_send16(pmdev, pmdev->pages[index].read_temperature_2);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_READ_TEMPERATURE_3:        /* Read-Only word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_TEMP3) {
> +            pmbus_send16(pmdev, pmdev->pages[index].read_temperature_3);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_READ_POUT:                 /* Read-Only word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_POUT) {
> +            pmbus_send16(pmdev, pmdev->pages[index].read_pout);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_READ_PIN:                  /* Read-Only word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_PIN) {
> +            pmbus_send16(pmdev, pmdev->pages[index].read_pin);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_REVISION:                  /* Read-Only byte */
> +        pmbus_send8(pmdev, pmdev->pages[index].revision);
> +        break;
> +
> +    case PMBUS_MFR_ID:                    /* R/W block */
> +        if (pmdev->pages[index].page_flags & PB_HAS_MFR_INFO) {
> +            pmbus_send_string(pmdev, pmdev->pages[index].mfr_id);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_MFR_MODEL:                 /* R/W block */
> +        if (pmdev->pages[index].page_flags & PB_HAS_MFR_INFO) {
> +            pmbus_send_string(pmdev, pmdev->pages[index].mfr_model);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_MFR_REVISION:              /* R/W block */
> +        if (pmdev->pages[index].page_flags & PB_HAS_MFR_INFO) {
> +            pmbus_send_string(pmdev, pmdev->pages[index].mfr_revision);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_MFR_LOCATION:              /* R/W block */
> +        if (pmdev->pages[index].page_flags & PB_HAS_MFR_INFO) {
> +            pmbus_send_string(pmdev, pmdev->pages[index].mfr_location);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_MFR_VIN_MIN:               /* Read-Only word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VIN_RATING) {
> +            pmbus_send16(pmdev, pmdev->pages[index].mfr_vin_min);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_MFR_VIN_MAX:               /* Read-Only word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VIN_RATING) {
> +            pmbus_send16(pmdev, pmdev->pages[index].mfr_vin_max);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_MFR_IIN_MAX:               /* Read-Only word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_IIN_RATING) {
> +            pmbus_send16(pmdev, pmdev->pages[index].mfr_iin_max);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_MFR_PIN_MAX:               /* Read-Only word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_PIN_RATING) {
> +            pmbus_send16(pmdev, pmdev->pages[index].mfr_pin_max);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_MFR_VOUT_MIN:              /* Read-Only word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VOUT_RATING) {
> +            pmbus_send16(pmdev, pmdev->pages[index].mfr_vout_min);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_MFR_VOUT_MAX:              /* Read-Only word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_VOUT_RATING) {
> +            pmbus_send16(pmdev, pmdev->pages[index].mfr_vout_max);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_MFR_IOUT_MAX:              /* Read-Only word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_IOUT_RATING) {
> +            pmbus_send16(pmdev, pmdev->pages[index].mfr_iout_max);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_MFR_POUT_MAX:              /* Read-Only word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_POUT_RATING) {
> +            pmbus_send16(pmdev, pmdev->pages[index].mfr_pout_max);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_MFR_MAX_TEMP_1:            /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_TEMP_RATING) {
> +            pmbus_send16(pmdev, pmdev->pages[index].mfr_max_temp_1);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_MFR_MAX_TEMP_2:            /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_TEMP_RATING) {
> +            pmbus_send16(pmdev, pmdev->pages[index].mfr_max_temp_2);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_MFR_MAX_TEMP_3:            /* R/W word */
> +        if (pmdev->pages[index].page_flags & PB_HAS_TEMP_RATING) {
> +            pmbus_send16(pmdev, pmdev->pages[index].mfr_max_temp_3);
> +        } else {
> +            goto passthough;
> +        }
> +        break;
> +
> +    case PMBUS_CLEAR_FAULTS:              /* Send Byte */
> +    case PMBUS_PAGE_PLUS_WRITE:           /* Block Write-only */
> +    case PMBUS_STORE_DEFAULT_ALL:         /* Send Byte */
> +    case PMBUS_RESTORE_DEFAULT_ALL:       /* Send Byte */
> +    case PMBUS_STORE_DEFAULT_CODE:        /* Write-only Byte */
> +    case PMBUS_RESTORE_DEFAULT_CODE:      /* Write-only Byte */
> +    case PMBUS_STORE_USER_ALL:            /* Send Byte */
> +    case PMBUS_RESTORE_USER_ALL:          /* Send Byte */
> +    case PMBUS_STORE_USER_CODE:           /* Write-only Byte */
> +    case PMBUS_RESTORE_USER_CODE:         /* Write-only Byte */
> +    case PMBUS_QUERY:                     /* Write-Only */
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: reading from write only register 0x%02x\n",
> +                      __func__, pmdev->code);
> +        break;
> +
> +passthough:
> +    default:
> +        /* Pass through read request if not handled */
> +        if (pmdc->receive_byte) {
> +            ret = pmdc->receive_byte(pmdev);

This returned value ...

> +        }
> +        break;
> +    }
> +
> +    if (pmdev->out_buf_len != 0) {
> +        ret = pmbus_out_buf_pop(pmdev);

... is overwritten here, is that expected?

> +        return ret;
> +    }
> +
> +    return ret;
> +}
Regards,
Phil.

