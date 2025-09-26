Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AB0CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 06:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22H4-0000Qd-1O; Fri, 26 Sep 2025 02:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v22H0-0000PM-Ks
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 02:49:42 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v22Gm-0003Jm-UH
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 02:49:41 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e326e4e99so9761735e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 23:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758869358; x=1759474158; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KYIqTNYeo6LYi0M0wuMxfzsr71kZLdJRDJuHn7PbYJM=;
 b=v5LVUIO+57CaTKADsw3+dTgP2QSO4WvxntPzxVS3BpTHa2FGLw1NwewGlm8ylAFl/v
 k92TRtHk76/e8eYcKQ36nX2KKv4uI3KEwrnsXhr+W1Us2WT1eYQ/AfOTxFQrbSNY+TGN
 PHo+D6JDylSnGKxW48aFv7JpPK/ghO/lkKhUikOFPRVKEda7pUbGPC8i1J0k5LlWbMnP
 sj5T1IedxILdQ3wCY7NorEM741JiAHXGJ3t5Snqk14yWLkCEEWNBFLiCAkHV9EZdW4Hr
 rQe+qZDYL4rE8m2JQSPRWR3MXh9MzGiSCor5SrjDlstQyr6oJCdXZfDK8MW4wi4ZwxQF
 VJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758869358; x=1759474158;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KYIqTNYeo6LYi0M0wuMxfzsr71kZLdJRDJuHn7PbYJM=;
 b=GLxI4EGTWFLZS5HSAGQt9dCjwHgd9UFTVV/Vxx/4llFDv8oaNVACYymC42YMFs04NY
 mTvUAJTDXa/BDZmEDPCQBma116XQIlwKcKhdJ66HyyQ8NCnjs7wMorcDXTUwsOT1CIfq
 Tb27km27br/oqSUsXI7DSPohOh11OmfrAtmZW5CU3bIGbwsjf/Rg7H8MPhlRJuHjWReK
 InPTqzVWmnFsGsT6jEWSxarlCscoC6DFFu8Q56TK9c//BapRY8IRJvVN4ProOBLyXw9g
 mObNe3sn+U1ZEXUAzE80ETG3urmGur8t2x8aGYClaNcYqrx+CE3cBcB5c5WuNcztZ+Z2
 9VxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+tOzxKeHzj41qMaEtYUTOLAWuK5kY/xiEnPJCq+GyFA/PsQgPan/Kf4eqR0WRyjJlqeihhSae64oE@nongnu.org
X-Gm-Message-State: AOJu0YwVntY3MiAATTonEH7A+7nrq/AEXltNK1yKMki2QoCvcyisAoel
 MlHfVjK20fY4Wm6HfOVnOTISwB/Gnfm4g8cLCs+owEo81UYsFD76H2LKipyQJoYf7uw=
X-Gm-Gg: ASbGnct53I2RId6oSDp9qAO3Ch30PYqsuxl4roQkFm7QCvHqeKbtcnu/7UbJ9GgqfAo
 c2O4UnTRDcz5pIJ4tTAgXz4iindOvPjLJlUyldX56+dQLYfKir1eSImA2qhmwj7WQP9VAPcqove
 0yHKclPSYqeXdwzexf+c9dw6alFbRZnYtDGcw6kMfiJtBXn8kONiv/+H3iCuT1B++vuFrwWUW6J
 sMNcOgACVRQOFb564ZGqpOmwyXnauao7vIynJm08JoD/AiMWb4zfsydPy+cIADjsyT6BCuHVf0V
 NMOys3Kctb0Ev6ynTxrb3UP3IdQQk0Q6nc1fZMlqzUa/DcC1ULlMFIPceNsCgC0xVHGiUVLUH9Y
 FWJdD5HMy0exe9HEzDukR7EtfMwya9hUyGrSnlkpK1igKwfZTsfwWIiw0OmfjuHvjTX7dI8hJff
 yO
X-Google-Smtp-Source: AGHT+IELmlnsm8sHfkKTU5f5UTYLZaYcG5Rvv6klj6he/YjKXtUPF6EPG6VC/ho7HsT23ICtepCiWw==
X-Received: by 2002:a05:600c:a4c:b0:46e:1a60:c995 with SMTP id
 5b1f17b1804b1-46e33c38334mr53897805e9.2.1758869357864; 
 Thu, 25 Sep 2025 23:49:17 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb89fb2fcsm6200050f8f.22.2025.09.25.23.49.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 23:49:17 -0700 (PDT)
Message-ID: <f94da379-eee1-4375-95e6-7349c3c188ee@linaro.org>
Date: Fri, 26 Sep 2025 08:49:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-arm@nongnu.org, manos.pitsidianakis@linaro.org,
 peter.maydell@linaro.org
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250926051542.104432-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Gustavo,

On 26/9/25 07:15, Gustavo Romero wrote:
> tests/functional: Adapt reverse_debugging to run w/o Avocado
> 
> The goal of this series is to remove Avocado as a dependency for running
> the reverse_debugging functional test.


> Daniel P. Berrangé (2):
>    tests/functional: replace avocado process with subprocess
>    tests/functional: drop datadrainer class in reverse debugging
> 
> Gustavo Romero (7):
>    tests/functional: Re-activate the check-venv target
>    python: Install pygdbmi in meson's venv
>    tests/functional: Provide GDB to the functional tests
>    tests/functional: Add GDB class
>    tests/functional: Add decorator to skip test on missing env vars
>    tests/functional: Adapt reverse_debugging to run w/o Avocado
>    tests/functional: Adapt arches to reverse_debugging w/o Avocado

Out of curiosity, do you plan to post the final patch removing Avocado
use / dependency?

Regards,

Phil.

