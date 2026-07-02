Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2295EC43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 17:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfL1O-0002VT-75; Thu, 02 Jul 2026 13:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfL1M-0002UY-UY
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:16:16 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfL1K-0003zG-FQ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:16:15 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-847921eed4aso2230101b3a.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 10:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783012573; x=1783617373; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jhKH15kmpSRpeRDkTEr6nESwKUZkMx8V4+qy5Mza+r0=;
 b=V4D3U4Mdu9fUGkhPSYAVn3QYn8Q7z1pR3ODBg020pQSNMyhyoyQtzr8XYBiT/497J6
 HWacJO18q4MXn6gEFUj0uawsAwt+oxbNkhgzHSJqkESEQQkuoPL/t3/N3T3m/LsqpA/r
 p11T+zeC//hEKpO2zeGVvX0dGx6d+D6TUz/A+jP9szS8270jZKn5U0/3YjQPsETFNMZW
 hi5qIGLlj4N0A887RwVYqV/JSBpYpuvlsEx+L5xwsbMRB+vvnBbXGbaIew/y8XJj/JbU
 szFkT7XI2uWRhfGArJRTASHjNh5xn6xjdSN4FTCYYsifty9Utvw2Hvh7Vf1465NKcbhk
 yr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783012573; x=1783617373;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jhKH15kmpSRpeRDkTEr6nESwKUZkMx8V4+qy5Mza+r0=;
 b=I5bG5vJ6FKRcIZxhZnx2oXLl4BmT0mWn0FQEWCPmERiA1/WpaR+kmxUh1rXIfuOnE0
 +xLvJCW5EiWOGBFz8XayPOw+vvFFaCXmb0SppkGlE12kQ0hENFQ3gkwWVsanYzyBizRr
 7kKFpH9KYbHNN0fFm6eJm73CRBnnZ12UFHM2SKk5qELuKpDQWxIgf+FvfzfL4FxX0ikQ
 FqKOpog00UPoMJHG9FyssjUF1tF9Ezw3zwUw7mxBmdISQow3dzCy9XciOVcvfubEif1D
 13xwVk0aw8HJOgmT2gvUu+ToVg5u8+C01TclYKEoGU8x2/OMFIMTRYntJjEgyqQgVil6
 42aQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrkFYxhyuP9WJyEKK/j1to7V1bpgQpm06Cej+K100mDJ3hYbXCqNp2hdpK1+pYXfFx+qfgjoJmvKXYo@nongnu.org
X-Gm-Message-State: AOJu0YzhEa21+fYtLXdsD/vXkjnE7QBaz6rc35qtA3RHKrTUaWvqZqzu
 8nW9jR4YxVEaSKzw8gsh8lR8DO7MlH3CuZRogOsWQQl+eQ6s60Qe0G8AP/cyCAfChJo=
X-Gm-Gg: AfdE7clTlu6VW0xLILie7oQdkzXWhUvlJqvBs2fJf+ljqM/91ZQxObF2MraPSiHkpzM
 d/4QRbLE1v/3v8jnGvD+6HlRqlT0wT3hcMFjaug+XcTaysjn/ebCvmso3sAUZlhsf6BwzkxOikV
 bG0j6LeFR5RRu/X6Ef8ODgtJgCIKXgbync3Ri+ozqIQhxwfkcA/P5DSCS/zywvOcIszCLIJcZc5
 Lfx26STykFOd0UppYUq6Xge/KUC9MlEayjX+75E8kjbUOa/354PvKGPcLW87H664djn+8gMifvk
 S91SMs+/j6Vx51DkvjeKlOJ++AgB3l4rbJ7QqXWEVTO+HquLxLCj/X6D2cA9D+PreV4nZjDvP8y
 gsy8N7ffuXtNkveQOa1gUWElTwQ7yl1VeMcXT+I8eRgG34dH3WzLk2MSOqGiDoNMdU0CA7lM/Jh
 a1WmyIeZ1vFOEVixcmQtDmmmP+zGERf9yKzp7a3xaxrl/PAnvdbTzbhfXxaA==
X-Received: by 2002:a05:6a00:2a0b:b0:846:eabd:9e9b with SMTP id
 d2e1a72fcca58-847c51637b6mr6578106b3a.45.1783012572603; 
 Thu, 02 Jul 2026 10:16:12 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847cb78d69csm1652313b3a.25.2026.07.02.10.16.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 10:16:12 -0700 (PDT)
Message-ID: <6da0f656-fc48-46be-aa0c-12b2d9ecae62@linaro.org>
Date: Thu, 2 Jul 2026 10:16:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/33] accel/kvm: Always define
 AccelOpsClass::supports_guest_debug
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-9-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-9-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/30/26 15:00, Philippe Mathieu-Daudé wrote:
> Whether TARGET_KVM_HAVE_GUEST_DEBUG is defined or not,
> kvm_supports_guest_debug() still exists and can be called.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   accel/kvm/kvm-accel-ops.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

