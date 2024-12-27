Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815F3E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 17:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tREOo-00015z-Jy; Fri, 27 Dec 2024 12:45:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tREOl-00015V-DC
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 12:45:19 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tREOj-0000E2-5L
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 12:45:19 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4368a293339so31351685e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2024 09:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735321513; x=1735926313; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6yWtc11tXMSiWWKkHWZl0BlhZp9OCaPi6P2fPcoTJ6Q=;
 b=XQUj5/QqhO0OgiPcvINq5/mNsFH3i3RjNEilOSU1+U/KOpQUDxkGChYXbdfjeRoIBn
 FiW5WYLdF8XAG7UA6UNmakB59WbDo2vJfyzo0TYN3lU8SmU6tlEIbzcU0MWVSFzDT4L5
 LevBv4D7611tayPR714nIFyOfwSVBc9tVQcABEPXfyFNPJbTy4J1QCRdIYrYr8cW6BW3
 +mym7fIEdsE8U+WfrXZQT+7Guta7/P7FisqUMwpG4uaQIJIr5yLde5WjgZfLgrhToqyB
 06JoZZTVJRTu+m+v3dZNgFfaH1AR+bMLqqmzuj13xlndOsy4kV55hwafEIIrJiE2fVaZ
 4zgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735321513; x=1735926313;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6yWtc11tXMSiWWKkHWZl0BlhZp9OCaPi6P2fPcoTJ6Q=;
 b=iKNF4foEWKMBE1o2p7XTVcSMSMChfUKX0ZzjV0wm7LkKAv8af9CKdiXNTrzea+IJJK
 YpXwbABYnOp56MS97t5i4SobEmYYbq7xZSpFaF7SMb5Gn+spefBv9WU0C4HQTZOJ8mkU
 VCLIet3YvyMXxLTETOon0A0G7esr8seKNlbOksulK8OM35XSFVYfiTMB96lp8mYEkT7S
 I9fM+jsghQAfSQaLFzThZICyIpj2QsJKCQb+vylvRsed8kKCbSus9OVtBfKtNgsqc/yL
 0eeXqWaWEtP3SzqYbzl6gMz0Id8ANOsO7NGOZet6hzX89FFD8AkKUQhOz/ZIbG2mVzPd
 Ua8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCURKwyiOpiyAEWJL2MTZSbi/dC0MK+2DBhhRGSH8Gs0nmZj2+TEe0F9Uil0TjzLXxN3oJZsHpQ0sKFh@nongnu.org
X-Gm-Message-State: AOJu0Yyu55D5Zhui4GKhgJt6rfsdGJsGv2gxOSRXfSDE00UqPaA10DdW
 7cPk8s7QhEvhcuuElAOON13RbmY66x8wnAWJ0a9SqvbEHy88w/kD1RBSwrPCjC4=
X-Gm-Gg: ASbGncuP06iThSfa7fMmj8VStTxX0XBrPcFw1yg1AoNJ4JtSR+lL/c4lGChRmmhYmpH
 PO698j8JJ9vizRXqJfUHHhXQtOvhTodarfmMR2V5wMaRL0moQUNAgtpDjWt5bTN03e/EGT9+BpG
 Igo409M9mOsXcwKWN3JAmTZvme0DpWu/6Poynn/D1/UIFj6nWDGYJ9L/sx1+VlGUeS93+baBBTi
 iXpwU7FZxJ8bDJCrOo8EDpxjq6XEyT6fz3DvQchIEjJ75lKAck211HzLft8zudn9cz4uqC+hgaQ
 bTJZwk2ZqnGTIX3TDaQ8SJOS/+vTbg==
X-Google-Smtp-Source: AGHT+IHI8n0LLRUTshNlIYKW/WQJKh4LmnvMCjQNjZJbit5nK9/SsEmAr//hhh511nkmWAMbNeSFrw==
X-Received: by 2002:a05:600c:4f0d:b0:432:cbe5:4f09 with SMTP id
 5b1f17b1804b1-43671247b46mr211386095e9.4.1735321513095; 
 Fri, 27 Dec 2024 09:45:13 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4365c08afcbsm281964585e9.21.2024.12.27.09.45.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Dec 2024 09:45:12 -0800 (PST)
Message-ID: <e332da74-d815-4c46-804f-a850d2ee12dd@linaro.org>
Date: Fri, 27 Dec 2024 18:45:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] hw/usb/hcd-xhci-pci: Use modulo to select MSI
 vector as per spec
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: richard.henderson@linaro.org, thuth@redhat.com, zhao1.liu@intel.com,
 imammedo@redhat.com, akihiko.odaki@daynix.com, npiggin@gmail.com
References: <20241227121336.25838-1-phil@philjordan.eu>
 <20241227121336.25838-2-phil@philjordan.eu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241227121336.25838-2-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
> QEMU would crash with a failed assertion if the XHCI controller
> attempted to raise the interrupt on a higher vector than the
> highest configured for the device by the guest driver.
> 
> It turns out the XHCI spec (Implementation Note in section 4.17,
> "Interrupters") requires that the host controller signal the MSI
> vector with the number computed by taking the interrupter number
> modulo the number of enabled MSI vectors.
> 
> This change introduces that modulo calculation, fixing the
> failed assertion and making the device work correctly in MSI mode
> with macOS's XHCI driver.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
> 
> v2:
> 
>   * Switch to modulo arithmetic for MSI vector number rather than dropping,
>     as per spec.
> 
>   hw/usb/hcd-xhci-pci.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
> index e110840c7a..e5e7330387 100644
> --- a/hw/usb/hcd-xhci-pci.c
> +++ b/hw/usb/hcd-xhci-pci.c
> @@ -74,6 +74,7 @@ static bool xhci_pci_intr_raise(XHCIState *xhci, int n, bool level)
>       }
>   
>       if (msi_enabled(pci_dev) && level) {
> +        n %= msi_nr_vectors_allocated(pci_dev);
>           msi_notify(pci_dev, n);

Should this be done at the MSI layer in the callee?
(I haven't checked the MSI spec).

(Cc'ing hw/pci/msi.c maintainers)

>           return true;
>       }


