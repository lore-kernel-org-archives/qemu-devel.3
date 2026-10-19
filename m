Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3807ACCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 08:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIj8R-0005va-Hq; Mon, 19 Oct 2026 04:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xIj8K-0005tY-Ju
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 04:54:16 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xIj8H-0008QB-2q
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 04:54:15 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a1ddc7c9beso7540565e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 01:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792400050; x=1793004850; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=16/kep8BGb5ez3FlDTh94zREThdgTmlrT7fGEqi2f/o=;
 b=csxjsN67iQZ55SbWCDEwQDhi9xKKOf5gqpFfNjiKPE2Y1nLZXkG3smGgVHuFRqQaRO
 424Ybx21zdqqBXCFRpSYK4KtfEAs82E32AWExdq/yLA1kRNeHa65E3j87CVepSdJq4pd
 asBXBccJ9kHZyOP4EKgFUg/iNMHjJ+kpMuhhM8YSNxmb8JNoOrUB8vkfPcv/n0vzzaYT
 BI68PSBILr0cIO6O4qoRpnAwRzRNurjObMwh04qX0/gvtIOEvjH9wu5rG1bzWHrdl11D
 JAct5a76d0At7hcRt46c17J+WDMG6u97MenWSFG7M+2TJclu+gpibL1WrLIxNF4XAlEG
 MXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792400050; x=1793004850;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=16/kep8BGb5ez3FlDTh94zREThdgTmlrT7fGEqi2f/o=;
 b=cvCmxYkGIqLG4Gn+q/y8PPe6elW3/egg6ZH6A4x0WBr4RvY36xBkJwA2A2enbWZ+BF
 A/n13c22zSSMyC6etxrFvWG9ROlFMFEouAKCihJS51GtVroIgZ/kgxvVmS16oOxJ+75z
 wgl4cTUhIedxU7E+GTszqstzkzsho3HS1vMtVMXdprc99TTmco0vblR+9m+T78o0uRxy
 IgJBEqwT/bQwryHMC8MyndIh7o3MjnyReq4WUXRZcWmCj/+4vibjl/0hb3UoBF5ZdbK9
 /oZdMcWcst1MvUaJxotxilHOXvc72P5jT7+buU714OIfg4R9SGf9/iBOwuqeoM7oxhf7
 GZhw==
X-Forwarded-Encrypted: i=1;
 AKwUvByKA6P9bU82QQaQZggEl9/K09Qor7y77P4vf2mzuEHGwkglv7qPOZFzeuMZX0VzRG5i8Yg44k9ck9TA@nongnu.org
X-Gm-Message-State: AFq9FYKUAWE3NOrPJS3RDiFYk9BkrtFFl1PluXRZuyml5KEEUZ/UpY4Z
 j47egEtcXdINXe3SANzSG8ex0XzinVmyFAOfDeIIT6fQxn0b3p7omzQQGO7TiqI11kp7QPLqNV1
 6Y0s56rE=
X-Gm-Gg: AYBFou0KWyilmOTzI8lGtZNDZIi1IjMEosCNwDOCwdL3z3MuTOe53bYwGZhzq3jzpcb
 S0VO8PCfmC1Xu8hl7gTvmGkykbW8rZ8DaTvA/jM3L4USXnj82T0rkKDtM4X6B9yGAonaL8Er6pY
 CakK40wSOXpcqHxMS56Qme3l31yQp7gvvHOD5H9AmyH5TX9poW5PT6cnQxy1I7t6g0LnUZT8+EW
 QPXvscWn6vV+fE6jLBwZ9S34wFRDrGXxp2/13kznroZk1ugw5MaDtu+1XRy1L1h+IGGbNHjpGs+
 pvIbyUNkC5dO04gY+gcej0VQlIL0pZSdVV/twPqMMjgHNXs46Q0jYZXDME+3AjAtiCA7fc5eijT
 wAGL4ksyiU7BvKCZQlOeu38pVhdBdVyrExY4ZGClRMYNn/xJyDhNFUufmlfB8Ph7KgNsi63Hl1q
 Hw9cOw3dWZHL7xGMzgvuZMLwUvJsTp/NvTa1RoGjXunIwJklmSnKE4ca007ZwfC89CSHPAkbUJd
 zQWH009xfyDqy/wRYTB0/1JpGrEdYy7WvI73NH2Kyo7fGYdL9mNn5O/yg/29A==
X-Received: by 2002:a05:600c:8b6f:b0:4a1:88de:9e8b with SMTP id
 5b1f17b1804b1-4a1d75e380dmr143423785e9.5.1792400049826; 
 Mon, 19 Oct 2026 01:54:09 -0700 (PDT)
Received: from [10.89.180.227] (cust-east-par-46-193-64-64.cust.wifirst.net.
 [46.193.64.64]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1cca30aa4sm118156715e9.2.2026.10.19.01.54.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 01:54:09 -0700 (PDT)
Message-ID: <8031d08f-0b47-4ce8-9154-3ddf9d5432b8@linaro.org>
Date: Mon, 19 Oct 2026 10:54:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] Linux user next patches
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Andreas Schwab <schwab@suse.de>, Helge Deller <deller@gmx.de>
References: <20261017203031.3107-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261017203031.3107-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

On 10/17/26 22:30, Helge Deller wrote:
> From: Helge Deller<deller@gmx.de>
> 
> The following changes since commit 8ee6c77176cfee03be0ec7665b6652b2f31f1531:
> 
>    Merge tag 'pull-ufs-20261012' ofhttps://gitlab.com/jeuk20.kim/qemu into staging (2026-10-13 22:01:07 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/linux-user-next-pull-request
> 
> for you to fetch changes up to 56ab4a7356ac7b6a18a4283d51e868e2cf366588:
> 
>    linux-user: don't print core dump message by default (2026-10-14 21:14:06 +0200)
> 
> ----------------------------------------------------------------
> linux user patches
> 
> One patch from Andreas Schwab to not trash the guest console when
> warning about unhandled core dumps.

Applied, thanks.

r~

