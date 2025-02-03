Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23C5C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 18:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf1JO-0004mw-Fi; Mon, 03 Feb 2025 13:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf1JM-0004mk-Vj
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:36:45 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf1JL-0003zT-Fv
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:36:44 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3862a921123so3278690f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 10:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738607802; x=1739212602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DMSW7CjZE4d4GtnWNZjPtSGEh8Rt594ZfpOCRcPOkdc=;
 b=LuptaPRbPBPcacypT2yhaBlYDcSNOL3I5XuTsHAAAc53pzvzEyxy9AC5cY68oRR8aF
 sV3Um4lkkrpUR9QgYUca3WSgrsJddB2zi58m9df4OuIh9lJbDz0toizpIrb0BiMOjkP7
 yDIdrrAgXzlOomwHGh/NSTKk4I6UZQ2RxJqhpRaXkMv2kSmjZHTFxw53RxZRrVAFICIm
 2MtusphlKUdlIjDciGriwveyk4xfWSS36UYKtMsug0QKh/dmtQAnOEv7UQSKc7ONESAQ
 p6rP7n2VtJ8yilNW2JDySidQifcklmDzGq4qJZ+fMPC7gOFajKc7SQCDvpvlOrJAlp9Q
 SSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738607802; x=1739212602;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DMSW7CjZE4d4GtnWNZjPtSGEh8Rt594ZfpOCRcPOkdc=;
 b=GTC/lzjFyC9n7gVtAD5+qNc8ShxBqAgiQ8k71zA7ymDezfmn6EU+CByeOticvs1JKK
 Kn/5vnGuUk3l5+IxDZWqW3IhYQ/+QazASCstIpDdAIbL+RT7Fw08fPQj0+fUEsisjtTh
 TEVupJGjJ6M6f/396LCan5G6lpauXCyoDuO0xRCP8A0llD/VdfT0Wco61riXGMkSzjAy
 1K0/r1qNMRZvxin0qKnnvtXnBD6IiZX9gE/hVzMP/t7vRow2InpZ6CXIFeA67C0Pj4BF
 pUESzOUhv+eq4HTgUGX7YZoE80Fsn4oO3OmPeyVn+m71zBgDgL/6tOb6/RxAlI2PJYMg
 888w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw4ZFDbhqwQpT2Xmagt5zrDS6NpcbEzyJJV9Q6U+FIbw544AOk1gpw3WdvSVMxVA+DH4MaCGCXiRjV@nongnu.org
X-Gm-Message-State: AOJu0YwdnYoinklGZBdThAm9kigXq3W2BUJhf1PPdpaPZ24FYxrQevlx
 VNqSkKv1E+K81xN8UQWeIH5ejc4X58iq2H+VSM2iGY1Wx1lC7s1wiQ+M0yVxZyY=
X-Gm-Gg: ASbGncvjFVpUjagB9GoYwVIvAi+S/2FcnF9AmoZgK5evR2JY+3IBVi+zU3b8XOdJxYa
 mqy1xdLsFMBgzjItqATINh4cszNRGtfK3j6UuMoJw+z4h9TGeWfNnlyYhfMnIRMVOB1f01DmwcK
 ArbvEygk5MQ1jExnPGIcqAzUe48iQMHfnYwsya61MPOYuoEC+lTD/jy9tZe4UYhcCtzdMiJfa71
 y6NwklWSga11j0rz1GX7aevy3wKzhzcx5G7DgwaWeiQiFFy0ZUG4MWSEcvUAvKBLXTotT5Nd7Fv
 QHgaEASeaM8MWpqu9ql6q8UnlueOGQsnuFqtZs7xbHctz+2Xd9tNltbDn/w=
X-Google-Smtp-Source: AGHT+IGw5SXPZ1TKN1Pa95+BnK0AxNDxDImhRstRnhjn9TJ5Oe72LilrsoRN83q9ythCnnFSWK4ikw==
X-Received: by 2002:a05:6000:1fab:b0:386:416b:9c69 with SMTP id
 ffacd0b85a97d-38c5194a58cmr19847211f8f.16.1738607801729; 
 Mon, 03 Feb 2025 10:36:41 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c0ebfdasm13678272f8f.17.2025.02.03.10.36.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 10:36:41 -0800 (PST)
Message-ID: <9d5663cd-baf9-44b1-88fa-2ebc55736006@linaro.org>
Date: Mon, 3 Feb 2025 19:36:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] meson: Drop tcg as a module
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 thuth@redhat.com
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250203031821.741477-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 3/2/25 04:18, Richard Henderson wrote:
> The fact that this is only enabled for x86 probably means it
> was done incorrectly.  Certainly the set of files selected to
> go into the module is woefully incomplete.  Drop it for now.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/meson.build | 11 ++++-------
>   meson.build           | 18 +-----------------
>   2 files changed, 5 insertions(+), 24 deletions(-)

💗

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


