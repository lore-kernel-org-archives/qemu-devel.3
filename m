Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49D9C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 10:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Blm-0008Bd-4P; Fri, 11 Apr 2025 06:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3Bla-00089k-T1
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:37:48 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3BlY-0007he-Nz
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:37:46 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so19322725e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 03:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744367863; x=1744972663; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CHWhSV+01riI77FDc0r5gjinccvV6cFnBCGfj9hkXcA=;
 b=NpvtslBzGbA+4yHq0ccV65sD6CWrj5AossSaUNJ12oWJreKLswBt6LozLatSzDyM+O
 nipkBtgKq4dpSa3rlpiYRGipTs7irEicQLpKnue7h+pg3khkGe9SGr5FG0sBr6U+zHKP
 P8QSETBl2TvpNwp3Atm5myN3VzYr9u8cXgDjVD1sfVO6ptk3dORWIchSQUozTKnYAkcl
 YapZNG118UyIEq0+1UsXPRqziyHvqTHSDU3OBSYWAcQA6MZLjjBgTM4RrVxYGxdSJROa
 8sN/RrkFcH15MgciybLiBVpNR17AYeTpBCi053EPmWQ/ou24I3w3T5ZbM+b9MIl3nkG7
 Sl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744367863; x=1744972663;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CHWhSV+01riI77FDc0r5gjinccvV6cFnBCGfj9hkXcA=;
 b=SUDeFsby9sppS3nrNm5yGJXqRKhi9JTYZTIwdRTFgtWAZxjmhgNDG5FE+Lvc+3RrIw
 2mNaE2wGj+Rw07hPzWeSvFDQ0ieWf92aXXAtEsTgfzsSu2GzbUow9A2rHoSO3xmFHtrz
 uEKnS/olE2z/F4cxNwBRHNdvb4TWxwp2bXh4bDgZTlhR0K34HiYnUpzOG+3AJNOVvDoU
 gaeOi3d8G45lyx9tYXtdxewl8KyKvdZfj7xXpGOc2qrSwPVuzP5T7mQkp/jC6sg63F5x
 AdG+8TjW10OJCcQLPavR66nffOQ04HeG2WAU7dzLtRkf2jY99f8yL832lYP/GH8fStrq
 G0mQ==
X-Gm-Message-State: AOJu0YzDh7ScKiuAJJdMocGiQXLLyInumVMTyDcnzXKhQ6Q/vV4q9KYK
 ZM4OvnQf4dfyAcorZL4bRK4C2cXqXKmZ+TFI65a3NNkgSpeQSoA07FXB1/RbH/7+ZiEsVdvdNpu
 U
X-Gm-Gg: ASbGncux5UzlC49vVipRlhjuH7JDcjLiahsiWt0ILOb3nr7EPJNzpg88+Kr/XPZEcxv
 s9AtLzCED2H28aF1HPk3UakkgmOI6TUNQHeZhUbj2thDNzB4WFaVdkY+6Z3x4R4LRc1aQIoF/i8
 kHzZTNWq7WUo/fXcNVLAhEurcwzsdpF8wIxKvvwlnS6HKGrpWt8QvxwJZYfartxepkOxUdB6teW
 3y/8K+7GZFW8tynu5Nekf0upPIgUBy7IevusAWxAuVlPpzizAPfWOzgux2PBQChDfbshK8b7juF
 jX0nfL/cDSuedrBUl4XczYxtihZlLdVyTgskg7EZqQitpyQMBg5ETKBBeaF0K5G/kKq1k/RKmx0
 1gJ3fHUmp
X-Google-Smtp-Source: AGHT+IFMYaPhr2Nulo4U27ZThe5b6ZeOjxCpl+hj7XrXHxZBV8rdlDeY0vNG3hzEbF4In/AHhSR2iw==
X-Received: by 2002:a05:600c:1382:b0:43c:fb95:c76f with SMTP id
 5b1f17b1804b1-43f3a94c64amr19581175e9.9.1744367862880; 
 Fri, 11 Apr 2025 03:37:42 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f207c914csm81651475e9.39.2025.04.11.03.37.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 03:37:42 -0700 (PDT)
Message-ID: <104dc731-10bf-4e79-91fd-7b58e6033bca@linaro.org>
Date: Fri, 11 Apr 2025 12:37:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] usb/msd: Rename mode to cbw_state, and tweak
 names
To: Nicholas Piggin <npiggin@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20250411080431.207579-1-npiggin@gmail.com>
 <20250411080431.207579-9-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250411080431.207579-9-npiggin@gmail.com>
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

On 11/4/25 10:04, Nicholas Piggin wrote:
> This reflects a little better what it does, particularly with a
> subsequent change to relax the order packets are seen in. This
> field is not the general state of the MSD state machine, rather
> it follows packets that are completed as part of a CBW command.
> 
> The difference is a bit subtle, so for a concrete example, the
> next change will permit the host to send a CSW packet before it
> sends the associated CBW packet. In that case the CSW packet
> will be tracked and the MSD state machine will move, but this
> mode / cbw_state field would remain unchanged (in the "expecting
> CBW" state), until the CBW packet arrives.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   include/hw/usb/msd.h | 12 +++++------
>   hw/usb/dev-storage.c | 50 +++++++++++++++++++++++---------------------
>   2 files changed, 32 insertions(+), 30 deletions(-)
> 
> diff --git a/include/hw/usb/msd.h b/include/hw/usb/msd.h
> index a40d15f5def..c109544f632 100644
> --- a/include/hw/usb/msd.h
> +++ b/include/hw/usb/msd.h
> @@ -10,11 +10,11 @@
>   #include "hw/usb.h"
>   #include "hw/scsi/scsi.h"
>   
> -enum USBMSDMode {
> -    USB_MSDM_CBW, /* Command Block.  */
> -    USB_MSDM_DATAOUT, /* Transfer data to device.  */
> -    USB_MSDM_DATAIN, /* Transfer data from device.  */
> -    USB_MSDM_CSW /* Command Status.  */

Since modifying this, please add

   typedef

> +enum USBMSDCBWState {
> +    USB_MSD_CBW_NONE,    /* Ready, waiting for CBW packet. */
> +    USB_MSD_CBW_DATAOUT, /* Expecting DATA-OUT (to device) packet */
> +    USB_MSD_CBW_DATAIN,  /* Expecting DATA-IN (from device) packet */
> +    USB_MSD_CBW_CSW      /* No more data, expecting CSW packet.  */
>   }

       USBMSDCBWState;

>   
>   struct QEMU_PACKED usb_msd_csw {
> @@ -26,7 +26,7 @@ struct QEMU_PACKED usb_msd_csw {
>   
>   struct MSDState {
>       USBDevice dev;
> -    enum USBMSDMode mode;
> +    enum USBMSDCBWState cbw_state;

        USBMSDCBWState cbw_state;

>       uint32_t scsi_off;
>       uint32_t scsi_len;
>       uint32_t data_len;

