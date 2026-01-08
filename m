Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22F8D185CC
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 10:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdngI-0001pt-AD; Thu, 08 Jan 2026 05:55:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdngD-0001gW-Lr
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:55:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdngB-0007LA-2k
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:55:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767869744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ctFAEPPCpwCUWENrNwmIu9vhq1CiEf93zL7ZTHLARB0=;
 b=dD8peiDe1cFAN/e41/XyrCzw27ek1hMwWIpsTO5ZK/Zc+StaMw4b/C73rCEnwQufyIlXgC
 86OS0TrWxy1ut1e5/5evpSsZdi0IWLy92TYFkerT3sODOzn+jyj5cFu6Jhwo6khFgsjDxS
 83Va0NDPim9Z7mL9ISKpVFtOjX8QMgo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-LYDO2DQ2MCi7KSCtO1HP5w-1; Thu, 08 Jan 2026 05:55:43 -0500
X-MC-Unique: LYDO2DQ2MCi7KSCtO1HP5w-1
X-Mimecast-MFC-AGG-ID: LYDO2DQ2MCi7KSCtO1HP5w_1767869742
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fcf10287so2276246f8f.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 02:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767869742; x=1768474542; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ctFAEPPCpwCUWENrNwmIu9vhq1CiEf93zL7ZTHLARB0=;
 b=HwVlktfVq16HG6hEMo7FcGIiXxiOqMzf1k047KrzXY0I0VcvMa+vI5f157xAtfuwD3
 Fo+zN7Iz5bcN/RrZsXtDWXHXD0M1ngIAx7MYMrdLDIyrV2BELQ5h37A99typnVt5LkDA
 ZU2fPOlEAIFa7oPqGe8ettdLCyz7mtD2IySwy/WlvF5XI2RqoYAg7Q+zLpVVpqeWMbeG
 lZgw3kgetiebAbJ1jJdDvPro3YdbMXCsf65qPiqM4WmKq792MDNp9FxEkVeyNGGjdR17
 NboRJDA3/k4dyJ6ozGBdQnzWjR1YDfKzSdnDb/m9Vwxc/btjEG/QQvnaPUC+hlAepalE
 14rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767869742; x=1768474542;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ctFAEPPCpwCUWENrNwmIu9vhq1CiEf93zL7ZTHLARB0=;
 b=dJrxxqY3TSLduPIEq980n6EmkDKfo3RSLeJXlnK7JAah8cDLRCe/uxOoJ+eTdNouL0
 +mgMVxKTW7PVKwMq9JtVe5AZZTrNMrkhygdBIuXYPUYFynGZmQxDhzHva5EsPFHycc0H
 fss0zQgQ7lt3+wHe1kr59ZtBrW+hbOUy/20ikRIFQwCbjHCbP1eXgu91X70nOpeF8J+5
 33TQZ0NbnRINQ/6pb9o0CcbksBNBqajspYaXSjeIyuny/L+M2gifjm2jwdmDY7zuUn1P
 j8dHEcaVxRXDDEzlM5KojZGldiOGaISAs/dcOhnNTSmR74ps2jgF9wxktf4rmswgN7f/
 qbQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5lI1hC7JwTBSzwfTsvHHAnVsqhxflk0DzJoJ0FAsprf0mJ4wdAogPHqJpPD6QWSyzGA0i+PPVxl1t@nongnu.org
X-Gm-Message-State: AOJu0Yz4bkEppGn3zKWS0usTTSEKb1P35Zy8ifW3nMUwfpDaiUOS1x0q
 DCxcwQkOdP5DQDrVEnc8tcgQyLZv1EiI2MU620VI5ABiHVwoz0diJvw0ZWeM1eiLKlgVrjcZ94A
 OSF01IkBW5R7TwAlXRtRbIuuWZJpeOFxPc8l6QzAK1qnYwiyG8g3HItm5
X-Gm-Gg: AY/fxX6cPWs31KVCf0Ustz2jInTA/jdLH3oAWdTNaGZFV7mJtKxXr8l0XE2CftQG+ro
 PtiSMPT01sHAZthdAJHjVaERPv3r92WzynwkqYbwKuCEfcH1iZAjwfz96aB5s1szGJvbT/xWtLV
 fFzK+9cwV4xdRJa8dBBwi7yQCpmkBM9c81m1MDirydBAnSdKbVBDBHLLIPlct2jHgH7C2UrFSTW
 ErlyF2JJe8JkO9psMzPE2ycOWEs/k15ueMX7WBtNwH7jDB5MhhpnGEV8EfCXZPAYOC1sG/rIrOq
 ypVoZbTGXqxnF5g/avL/Yj/NDaQC2C31ci9mKUDymhXe1gUmoodWuFMQ3L7H44QPuqK//VNpyKX
 dQFcb2qw=
X-Received: by 2002:a05:6000:2881:b0:431:35a:4a8f with SMTP id
 ffacd0b85a97d-432c37d2e4bmr7168602f8f.47.1767869741723; 
 Thu, 08 Jan 2026 02:55:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdnEP6Tuu1p7MsnKYTYINebMe3Pejwd8GV5zHip2zbL8wqYzvE1MgbsBeA0hvYOGWh+BO10g==
X-Received: by 2002:a05:6000:2881:b0:431:35a:4a8f with SMTP id
 ffacd0b85a97d-432c37d2e4bmr7168579f8f.47.1767869741308; 
 Thu, 08 Jan 2026 02:55:41 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df90dsm15067487f8f.20.2026.01.08.02.55.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 02:55:40 -0800 (PST)
Message-ID: <91abcf07-8763-496b-8f91-2aa15b700b7a@redhat.com>
Date: Thu, 8 Jan 2026 11:55:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/50] *: Remove ppc host support
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-10-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Cc: qemu-ppc@nongnu.org
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260108053018.626690-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 08/01/2026 06.29, Richard Henderson wrote:
> Move the files from host/include/ppc to host/include/ppc64,
> replacing the stub headers that redirected to ppc.
> 
> Remove linux-user/include/host/ppc.
> Remove common-user/host/ppc.
> Remove cpu == ppc tests from meson.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   host/include/ppc/host/cpuinfo.h            |  30 ----
>   host/include/ppc/host/crypto/aes-round.h   | 182 --------------------
>   host/include/ppc64/host/cpuinfo.h          |  31 +++-
>   host/include/ppc64/host/crypto/aes-round.h | 183 ++++++++++++++++++++-
>   linux-user/include/host/ppc/host-signal.h  |  39 -----
>   common-user/host/ppc/safe-syscall.inc.S    | 107 ------------
>   meson.build                                |   4 +-
>   7 files changed, 213 insertions(+), 363 deletions(-)
>   delete mode 100644 host/include/ppc/host/cpuinfo.h
>   delete mode 100644 host/include/ppc/host/crypto/aes-round.h
>   delete mode 100644 linux-user/include/host/ppc/host-signal.h
>   delete mode 100644 common-user/host/ppc/safe-syscall.inc.S
Reviewed-by: Thomas Huth <thuth@redhat.com>


