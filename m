Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C454CC25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 13:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8K3w-0004jt-Fa; Sat, 18 May 2024 09:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s8K3u-0004jV-7z
 for qemu-devel@nongnu.org; Sat, 18 May 2024 09:25:22 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s8K3p-0006Uk-IU
 for qemu-devel@nongnu.org; Sat, 18 May 2024 09:25:21 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-351b683f2d8so891686f8f.3
 for <qemu-devel@nongnu.org>; Sat, 18 May 2024 06:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716038715; x=1716643515; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5ypU1qw8A/92MExAkNpLGrRIMwdZGY5djcfIkttIu3c=;
 b=dnbS7RphZB9JyCOWlNYpI8NfqOukYjzpIipv4r7bJt83itDBXQZW7J8U/w0Mr6y9gi
 YEj6GiUCJA+q4cQHrhTaJ0stq03P7wkrZlSR6fNc+l+3Tq85M84WeZm2sN+LSSglCOoX
 u8mi4buAtYXkkAfNCZPpHmNI882DPHOuVpazfjESScV0WFcWt5zBymOFTtPDd3mvWO39
 5XBrApA8JIRoMR6h0YP/NWcZB3/0MVYNc+2GDbpmg0bHcDN7nfztmNtqYaSnFRrk+ZsF
 tYqZum5nKONQPNy+2gQp7BcFewZHE0q2uXyp91rIOo++D3kATrY9l13QZ/r3PnLsFMuW
 gC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716038715; x=1716643515;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5ypU1qw8A/92MExAkNpLGrRIMwdZGY5djcfIkttIu3c=;
 b=iI5re7dZgb/ggpO/Gu/TFxHF6uB51jfBv/dTS4Jw7bjlYrvLgdXbo0GPTzQ73lYI/I
 ekegMV9JVMGltFKcYAKRBEgah8chRI1e9dx1O08+VFAxz4tOENR1sn/VoV6DAmxWMtrI
 PbCWRvEaYJcewv5HMN5eJrz5DtrzD/ciwRBoZlrp0Jrp8BK2W/8UHmPq683en8kAbLUk
 0gK+lzuU5NznkWfKC/gNN/Nr1i5m2xJn2ganpYetG47SvvZI6vA09eNsz5agOfWDSWRr
 aqaXXg7UksK1jDq7w1f+spXGfGyud5FM4LeN8i4ixy9MFBSviGKDl9Yz8skaweU53mPj
 XDaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAMFJcgDmi8tTvinGkNPHMYPq0HsBmKAzFPIxCSqyCs3SVxd9YJ6uDHvRZIPRVqkfW0R9kjYnZuQcjdllfkxIEGWVq7w0=
X-Gm-Message-State: AOJu0Yy4/ZEjzH2BpqyDSL7iEh6ZxmnI/E1KXPt9mqy8uAoDtUaZDrNk
 ElB625ua4WTN4jPxrCU3RbszBrJcxhIowjotrGU1gZnZTabwdkhYESXvbw6/HW8=
X-Google-Smtp-Source: AGHT+IHFMSMMucvWj/sI2turgnQkvFVuCrrNoxCqgMH0Pmdl5P//JoLUSBzpegE4LCXITV81DN5CIw==
X-Received: by 2002:a5d:6a91:0:b0:34e:f725:74cc with SMTP id
 ffacd0b85a97d-3504a73ed43mr16714758f8f.34.1716038715233; 
 Sat, 18 May 2024 06:25:15 -0700 (PDT)
Received: from [10.1.1.126] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b8a77easm24138524f8f.53.2024.05.18.06.25.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 May 2024 06:25:14 -0700 (PDT)
Message-ID: <e624206c-47d5-46e4-a9c3-cff354fe64b5@linaro.org>
Date: Sat, 18 May 2024 15:25:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] Fix s390x crash and clean up container images
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20240517122552.584215-1-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240517122552.584215-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
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

On 5/17/24 14:25, Thomas Huth wrote:
> The following changes since commit 85ef20f1673feaa083f4acab8cf054df77b0dbed:
> 
>    Merge tag 'pull-maintainer-may24-160524-2' ofhttps://gitlab.com/stsquad/qemu  into staging (2024-05-16 10:02:56 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git  tags/pull-request-2024-05-17
> 
> for you to fetch changes up to bebe9603fcb072dcdb7fb22005781b3582a4d701:
> 
>    hw/intc/s390_flic: Fix crash that occurs when saving the machine state (2024-05-17 11:18:32 +0200)
> 
> ----------------------------------------------------------------
> * Fix s390x crash when doing migration / savevm
> * Decrease size of CI containers by removing unnecessary packages

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


