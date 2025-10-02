Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39522CCA472
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Ein-00018S-64; Thu, 02 Oct 2025 04:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Eij-00016m-GI
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:31:25 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4EiU-0003l3-UE
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:31:25 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e3cdc1a6aso4513335e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759393859; x=1759998659; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m2F4LWrM6PPoBfnEe3eolI+laUwKY9OULRaSJhYONDU=;
 b=ey97eQQXdKKEgGu24t1wkPQQC4Jz75Uynd5Swh/0r8hCWVtkUFs4JXRw/p7Qk/IwVG
 sHDiOV83gZRbRM4EBoVHV79nBmStK6jsGT+0xGFK29TPXNmr3oIk3Mm4dKXM/TaWZh7q
 7SuUmhtJifGQ9Fq17uqwF8LBEEkEpTlyyZ/WQT80Bmijhu1e7Swftty7KcrHuhDm3Nfe
 ac/iLS8YAD9ky2+AzCfGo/Q37EWBw39M+tvJVCaaHpNw6oKfMJJejKSYKsC2xG/kF9ph
 FCu4DHyxJvufRRFFxjtBPkHvYPDizdvgEXvvup4HTiey37gkdJiSRJBpwtwtp+Q1nP+F
 xgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759393859; x=1759998659;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m2F4LWrM6PPoBfnEe3eolI+laUwKY9OULRaSJhYONDU=;
 b=aZh3vK3sR2hnjnd3pk0M4EbG5c3OKaQlmKbq0wTmCDYzuaojJYo3Ymcj46WS1UNG13
 ZmHzuz4NKdOeduru6n1HKh2+Y0kqfhBZIL2VnpQDFmduTMdC85rXTKP32NihD1DBCXwj
 OQDjlgdcgi+u0oe0RLu4y2dYz5K3M77z4OXU3D/l+PfUHslp16H9NJ1hWAEDLAoimk7H
 sfrEgW/+JS1wzuNjhWpgnbR1Xatn4qYpYcsJwHHq4lHzs5ChzDQHgrCkEeM3By6ZV1+S
 ihla6cnnY8gxR4K2YObCyN2Jm68D9ldTmI/qy1Gxo7Fm9NlLVf14qti9FQbNlVWPbVuw
 PLYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgf/Go44sJISHjjKH36NqR94Arcfs/dxe6k7wXHeLL4+cVxWKYDnhmJNq0HuEwHrS9K6eyeRjxV9Or@nongnu.org
X-Gm-Message-State: AOJu0Yzd/xXDnoGieN3rewEGvwjOZZO9+cnN2ZZDcTJ/w0C8h1hFmGYg
 g07+3AILxpFtMh9BstwY3lCT19zbTsUq3VQGkhVROzLsm8egTA6s+SCv/5LOZj2x84M=
X-Gm-Gg: ASbGncuKS8ofHnltikzJqPVDm8Av5I/tDOe6ZenZUf32V4F7WnodKIVdXaV6A26Al12
 Ww/5VtpPfmeo6DM06jc+pKQT2i7CqrRmpjc1E1b0EqTJlGbExQkl34U+3vC3sI2/8UPcxMVlSCP
 JMnGO0+QHPPhE1oSCln7A16pnaS5ZWOB99jgMf2PrgY+uTqXtEEXfNvTOZ1HKnv+uEKeNSdU98U
 5/1LD4IOmDeKmmUXEJwTzwiLSsTJg6iXXsKXl0/z5LSiZf0JjZqtA1QqdqOJ/dqQoFOUDQg94Lh
 RD/D8CYIxy+kHgDlaHz5eaX7RYn+fYNqF4pTtrh539CMvBkAGojxAfznjeKUA9COuNmIEq6pIXP
 KoY+nftlEYXJyMsE+lbDKmP2OgN+oOvLUmIlb10osVsAAAiMpSbfflZuIZJJrwWvidpoUYHXoBH
 k8A7VfzmTwhJQaZcW9yEOeuGA=
X-Google-Smtp-Source: AGHT+IGZZz56Bg5+xJXr93z9ae0iNNH57hEkjo5QJioXjSy61i7F8IkVdm+7rDZ8Pe1ud8Ex9Qol9Q==
X-Received: by 2002:a05:600c:1f82:b0:45b:92a6:63e3 with SMTP id
 5b1f17b1804b1-46e68bef7e9mr16189415e9.9.1759393858839; 
 Thu, 02 Oct 2025 01:30:58 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a2a808sm72962765e9.21.2025.10.02.01.30.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 01:30:58 -0700 (PDT)
Message-ID: <e176dfe8-b406-46ff-b1f0-95d4285472b7@linaro.org>
Date: Thu, 2 Oct 2025 10:30:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/27] Implementing a MSHV (Microsoft Hypervisor)
 accelerator
Content-Language: en-US
To: Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Cameron Esfahani
 <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Magnus,

On 16/9/25 18:48, Magnus Kulke wrote:
> Hello all,
> 
> This is the fourth revision of a patch set implementing an accelerator
> for the MSHV kernel driver, exposing HyperV to Linux "Dom0" hosts in
> various scenarios. Thanks for the feedback to the previous revision, I
> tried to incorporate those. The changes in the currenct patchset beyond
> the suggested fixes are mostly related to the replacement of retired
> ioctl calls that will not part of the upstreamed MSHV kernel driver.


> Magnus Kulke (26):
>    accel: Add Meson and config support for MSHV accelerator

>    accel/mshv: Add accelerator skeleton
>    accel/mshv: Register memory region listeners
>    accel/mshv: Initialize VM partition
>    accel/mshv: Add vCPU creation and execution loop
>    accel/mshv: Add vCPU signal handling

>    accel/mshv: Handle overlapping mem mappings
Due to my generic work on accelerators, I'll have to refactor these
patches. Obviously I don't want to break your implementation! Can
you add some (functional?) tests? Ideally we should be running
tests on our CI to ensure code doesn't bitrot.

Regards,

Phil.

