Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5596DE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 17:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSgG0-00041l-C9; Tue, 31 Dec 2024 12:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSgFy-00041Y-0L
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 12:42:14 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSgFw-0008Bo-At
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 12:42:13 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385e1fcb0e1so5546656f8f.2
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 09:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735666930; x=1736271730; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BVdc+X4IC5/CS9NxvUk6MBG0JaFVkTNeP0S8meh/UPE=;
 b=vZfnB52nom2qvz40X5vloXsg+57C6XHAgrKEWQ5DLE6aXHloD7kfn0vM06aj2xqRH+
 Z8Yg5VQSTbPC3FX8c3qnZWp8IXml00wgxptHdHVIc+Ae4j09bQHrrOpK1UmGMYxAGRiS
 iRENwTnHv4yzF8tnrj9Vpkns8FQrZt259tGFBbjC7NXakQGXhQDmMLTQBzJfxVCyRJac
 H2lNo78XxtoG6gCsmNvTp+JS2zV+/w2WM69z5rXGzU7A6JierXwwOy2RW3p1z3ywirS2
 1GO/tuaB/IWjndPFJAUmxdEzgwivI64cGWxiKF/2EQPzcBk5Qa1SQ7EFXfTvoH1wqroH
 NDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735666930; x=1736271730;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BVdc+X4IC5/CS9NxvUk6MBG0JaFVkTNeP0S8meh/UPE=;
 b=RTGecOZW2GOkKYobrwqy0KuoeIynUmVSOTqhPn3X1BQvLsu+kXsytKTvmu3si02pnV
 JYnPYZt+kQ2IY8d2JrWbiITLkX5olPhrcZQISY+1sJEgILVwcIMgdmLLXR5hX0OsO73T
 XXs62YZw9ZeCoB24z6e5kSw8Nncisne1AOIg7kV/S8zfHcyU1DwmeCIpXCPgQ/gkFsV8
 pQGhd+djKsLiPrhwBWPi+bfEm2WgnAdBj4BaTM2hPvckU3dEn0A7YeCNxFHzlfu7+CFJ
 M/opiRMKnHTfgHj0FK1Hs2t/fOuNluvuhOIsWDyTLt5fCqR/33T0kHc0prMyiZZib3E/
 oMnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxWQsnEEOXXDepqMgTp4SWbfNDlvbP15CrQfNg8VemyyhQl5l7re3eIE4EoyHu9zUMrw8PSfJJK6A1@nongnu.org
X-Gm-Message-State: AOJu0Yw0lvnIR05Tndbap0KjrZpx2wTmh8Zoh4VRFidrbaZr/d/AHJjC
 slpahrTyHmvJ2n4EJbe4e1kPw8aLIxGw8/MXV9WIYuMgzYcLK3vN85/+SFu+eD8=
X-Gm-Gg: ASbGncvHwSCct+tyg2IQCFAfFLLKXNvsHPV+DYKizPBQyLzmVxR7Kkg5qHCYs2/v74p
 rW8YXMd6yqizPMDX4PXZ7aicg3dy5bfMUwfnGsqr9VAw08NitvEsy6EIr/NKyT3fw2umRi8MpJJ
 LqFAfU/lrAyN8QemNLB2bpXwCHJUUb2iyZfdh2y6t+94ClrfUbBHoskjcSfXPoMOxt+VMlLJcne
 6UPU+a7FtHS05WIT1VY76u9qIyDbnoI4vErzdVqgK+rxJN6EP+9FmuwJvmdLYLSJ4b3CPyOqWhx
 PHs9n6RsV7E205/v7UEA0X+B
X-Google-Smtp-Source: AGHT+IHyTHsU8XvYSbyjdjBWnchPm/3CR9BQDV5vKKilgbbTm+BriUz9ffjzTP5WM8sFION5hdK7SQ==
X-Received: by 2002:a5d:5f4f:0:b0:382:6f3:a20f with SMTP id
 ffacd0b85a97d-38a221f11ecmr36701004f8f.11.1735666930432; 
 Tue, 31 Dec 2024 09:42:10 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828f8fsm32845427f8f.12.2024.12.31.09.42.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2024 09:42:09 -0800 (PST)
Message-ID: <a1ff93bb-8d07-4bf6-b6b6-0fd8f61d20ff@linaro.org>
Date: Tue, 31 Dec 2024 18:42:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ping (2): [PATCH v3] net/vmnet: Pad short Ethernet frames
To: William Hooper <wsh@wshooper.org>, qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Phil Dennis-Jordan <lists@philjordan.eu>, Jason Wang <jasowang@redhat.com>
References: <CAGCz3vsusRSsT8-Fi3a2Z4aeQMtxCzDZ73D8ZgefxVZvm=qY6Q@mail.gmail.com>
 <20241102205653.30476-1-wsh@wshooper.org>
 <CANto9c7n-vZmTDV=eKTTNVN+JA_PGyar=KbibtLhvmfHf8xYkA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CANto9c7n-vZmTDV=eKTTNVN+JA_PGyar=KbibtLhvmfHf8xYkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Hi William,

On 30/12/24 22:05, William Hooper wrote:
> On Sat, Nov 2, 2024 at 1:56 PM William Hooper <wsh@wshooper.org> wrote:
>> At least on macOS 12.7.2, vmnet doesn't pad Ethernet frames, such as the
>> host's ARP replies, to the minimum size (60 bytes before the frame check
>> sequence) defined in IEEE Std 802.3-2022, so guests' Ethernet device
>> drivers may drop them with "frame too short" errors.
>>
>> This patch calls eth_pad_short_frame() to add padding, as in net/tap.c
>> and net/slirp.c. Thanks to Bin Meng, Philippe Mathieu-Daudé, and Phil
>> Dennis-Jordan for reviewing earlier versions.
>>
>> Signed-off-by: William Hooper <wsh@wshooper.org>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2058
>> Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
>> ---
>>   net/vmnet-common.m | 23 ++++++++++++++++++++---
>>   1 file changed, 20 insertions(+), 3 deletions(-)

> Ping?

We missed this patch because:

1/ maintainers were not Cc'ed (Jason now added)

$ ./scripts/get_maintainer.pl -f net/vmnet-common.m
Jason Wang <jasowang@redhat.com> (maintainer:Network device ba...)
"Philippe Mathieu-Daudé" <philmd@linaro.org> (odd fixer:Darwin (macOS, iOS))

2/ it is buried as a reply on a previous patch, see [*]:

"Send each new revision as a new top-level thread, rather than burying
  it in-reply-to an earlier revision, as many reviewers are not looking
  inside deep threads for new patches."

Anyway, now queued!

Regards,

Phil.

[*] 
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#when-resending-patches-add-a-version-tag


