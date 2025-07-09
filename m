Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D346C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 13:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZUwO-0007OI-9a; Wed, 09 Jul 2025 09:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZUwL-0007NU-P4
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 09:34:26 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZUwJ-0003Wv-Sw
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 09:34:25 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4537edf2c3cso60666865e9.3
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 06:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752068062; x=1752672862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3BtLjJiufxd1sbCojgdZUD+6QFD1z/TFQhALm+l/vs0=;
 b=A5uUtNjhKupPqZ+71yduJ9l0q1Ax8R0mOHWkP1ciRPkttt9qOzJGjuY12EZRMqBh8M
 Zc6T5q+GcaHIXSACJhNzpxMmWGwzK2BqEiZ9uZtpF+kbWJoh8KsqdiOcc62HG9gb/RYI
 m+WvVVb0FPCB2h79/v/Flsbjp3QRZFX3QGJ8ErUMEXNJZCJyMMrtdX/P/3R6wOoWz3k5
 xvsuzIRswphfAY/f1TL6JTgPHSc2YWXDI+e3ffledR1ImIUu7VlD8YGXmQsWUH9UlqB6
 SP9gMKf9nLZFM6kbgs1EJNx3FFusMDvPVGvaumFEyHowMR15YtRLrtwXiTtQRW5J2dmC
 7rvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752068062; x=1752672862;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3BtLjJiufxd1sbCojgdZUD+6QFD1z/TFQhALm+l/vs0=;
 b=IIGCe+NfOPNv1hvq1vm6mjCZ02EaA2+h4FEV2twEQghB/SV43tz83vXtZZIMlXM4DQ
 lTE1wVr/e9yjv/R8Lg6jHtAbxBT2SHC/EzB5Cno+JVHCY9rR8oP62DXQMmfeaF5S+bJS
 Klkuyi1I2VcyBKA160KZFYvDDlHjh6+/oJmRCZlZjLTt+CpBe1lZmn+EnKRYdAxJaVmQ
 8Mjmj/LOnNFqynVSpIKg88QX2+SGEb7f3lToki+j6T1tPn2esmA6HUDPWQXpo5rjqXH9
 iIixyTE1RgEESgWyqk0y64FyTnpVVKFlwafVWAFZl83eN4nURZAA8LXMplW7VXMNThWw
 GEzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7TfhJlCNnQwaQzQCJ6xiptowgxP+ew6+obTvaF6KFIl6Ot0NRi+8wUQIsc/R+MZIMczTuHHpG0aqB@nongnu.org
X-Gm-Message-State: AOJu0YzxU1PR9aubvcDiBQIqFps4RjUMcU0GLrcxbiSNidRlMpNRhCuN
 fPtW1evlhH2HMn5PmMO1rq796PNfRyQTF1w+TQR81AYbKkvfOfye2Ah9vW99icUjdQU=
X-Gm-Gg: ASbGncvVjCDPm4NynnMv/CIDtFbhAvxnbZ4OjnVJR9BlUg86Od3RpNKCTtqtcAdOVFh
 4hntQ3/24E2rb/wkQco+SRjuQ5DpIfcMMThscPo2gecfMAvrs7CdAaLkt4s3pY5FZv6tsQ6ijyN
 67tW9en1/xBc1/P9TegPykbHVBtUxtaupWu7yxqJEJaaondPMxmJ/aY6j+bu4j/2yhGl8F0qwY6
 EzJgVKE3X298HgxC+I3IKmRzc3bM6du6/noUIA+14M/uL6BQ7HoYs287jHajOIFuXBJFAhChQWd
 9TYqvTxGZZYNKOVTOxC8TcVnTq1ocuvDA2lyWlvxfr80+iOdDzPe1fnkNXFVjIQE7ZqJzPRp8qi
 IOAdVLa6lGYHua3Qst4sMp0XHTNOZyw==
X-Google-Smtp-Source: AGHT+IF8YgLHV6eegt8ntmMN/dSqofPjd77o5HBon6r37rlTP+Vu3//Vs4LREEozklCzvnihSDfnwA==
X-Received: by 2002:a05:600c:1d2a:b0:43d:300f:fa1d with SMTP id
 5b1f17b1804b1-454d9d281eamr7732835e9.31.1752068061883; 
 Wed, 09 Jul 2025 06:34:21 -0700 (PDT)
Received: from [192.168.69.242] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d511bd6dsm24026055e9.38.2025.07.09.06.34.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 06:34:21 -0700 (PDT)
Message-ID: <1c4e3024-3ba4-4ab6-a8ce-f5ab24ffe1d4@linaro.org>
Date: Wed, 9 Jul 2025 15:34:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] igvm: add initial support for non-cc firmware in igvm
 format
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Blake <eblake@redhat.com>, roy.hopkins@randomman.co.uk
References: <20250709123007.1039675-1-kraxel@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250709123007.1039675-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Hi Gerd,

On 9/7/25 14:30, Gerd Hoffmann wrote:
> Implement a ConfidentialGuestSupportClass for non-confidential VMs.
> This allows the igvm support code work without sev/tdx.

Is this something we only want in non-KVM builds due to security
boundary concerns?

> 
> RfC: Not fully sure this is the best way to implement this.
> Alternatively we could add this directly into the igvm backend and run
> it in case no confidential guest support object is present.
> 
> TODO: Implement proper reset.
>   - re-initialize memory regions from igvm file content.
>   - load initial register state (if present).
> 
> Usage:
>    qemu-system-x86_64 \
>      -object nocc,id=nocc0 \
>      -machine confidential-guest-support=nocc0
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   target/i386/nocc.c      | 283 ++++++++++++++++++++++++++++++++++++++++
>   qapi/qom.json           |   1 +
>   target/i386/meson.build |   1 +
>   3 files changed, 285 insertions(+)
>   create mode 100644 target/i386/nocc.c


