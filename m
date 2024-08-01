Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095E8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 13:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZVPH-00044w-Ef; Thu, 01 Aug 2024 08:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZVPF-0003vY-02
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:59:45 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZVPD-0000nz-Br
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:59:44 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-368313809a4so1233879f8f.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 05:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722517182; x=1723121982; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=reWrZU/QJhlSWLyInbA0OjyEvus8Fj5OWJF3KGaYwP4=;
 b=m7A3zDxr8gq2BthJPH2vN+VRDdWbv9ZpD9m8VKcZR/MRc7YPCKY3KgDacCBNKFt9iK
 1k4kUKpIjLx/fw3COWVCBxEFH/1eXqCQpZ6euVSiYl53GWXCKJTjNzI0XKGfAaqqIFR2
 ZjelxNl8u9a262SsADVyumzCQNE3IaZlLWtfCYLXT8zQa8LxJrSHSLLfi/FdGDHWCky4
 wEuDONnHqkjm6QKdquJ/kJKlJajA1jmFXqHYWuXHE1OMvvXsAWvC17hmZFEV+vLMmVTP
 jd9QNxopgCwzcRI+cW+k83TQb2g+tWK9NLy3GW8iNYKCauH5VrhcHwW6ps0FBMHKY7ps
 klcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722517182; x=1723121982;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=reWrZU/QJhlSWLyInbA0OjyEvus8Fj5OWJF3KGaYwP4=;
 b=H6lwTEE2nvpHJj0PVo0cB/oMkzA7uw26QPfFZYYclnRzK/it3dFviYqScdB4xEis0M
 TN9WkyHlPJFOjew/JgpmVmvmzTggpdEITIt7wr4nMNIcbGoQKe1+HBt8rq1REpKGxrsn
 xuoxlKxfMN+H32KjCL8iVtnnzg5QVCAFAlx1qLRZojC4mtngjw86wLrpogauAivqeo6H
 p1srAxN3iGTnKV5Pw9TvqHSnssZ5jhH9AAykAiyNatNL6oB4M/AaW0AXHvkr0HMfCi2G
 rMVwV8DktEY9DVLIbfq0uvtsNyS5EVyrAiP22Lr+4WEGQoN908sNlxmj/XMfm4wBGNri
 HSww==
X-Gm-Message-State: AOJu0YzoEFnimnYsKoWmyKlslxVSM+B++q6YJRZ4vTzSIgr+dI9aObz+
 t6aJJYH3gH8lbSZdUnhKXMV1JktScIqbcpaIiOnKjV0Iyx/OJpHkD77oXh9GpZY=
X-Google-Smtp-Source: AGHT+IEnKobr50cUvKpNW3LP+tEde2Lwq8dMN/vsZsHAj9TorGHmI2pf873uTdTxjhnLjEz93nmnWA==
X-Received: by 2002:a05:6000:1b0b:b0:367:940b:b662 with SMTP id
 ffacd0b85a97d-36bb35d6147mr1226150f8f.31.1722517181543; 
 Thu, 01 Aug 2024 05:59:41 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36857d66sm19329382f8f.83.2024.08.01.05.59.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 05:59:40 -0700 (PDT)
Message-ID: <68710de3-02da-4fa3-936c-62c85197893c@linaro.org>
Date: Thu, 1 Aug 2024 14:59:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] tests/avocado/tuxrun_baselines.py: use Avocado's
 zstd support
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20240726134438.14720-1-crosa@redhat.com>
 <20240726134438.14720-11-crosa@redhat.com>
 <a7f2d78a-4de6-4bc6-9d54-ee646a9001fe@linaro.org>
 <CA+bd_6L7o05mENKVuLLfMFK9OF6ckU23ue0xmxiWO5oiT4ZEbw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CA+bd_6L7o05mENKVuLLfMFK9OF6ckU23ue0xmxiWO5oiT4ZEbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 1/8/24 05:39, Cleber Rosa wrote:
> On Mon, Jul 29, 2024 at 10:39 AM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> On 26/7/24 15:44, Cleber Rosa wrote:
>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>> ---
>>>    tests/avocado/tuxrun_baselines.py | 16 ++++++----------
>>>    1 file changed, 6 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
>>> index 736e4aa289..bd02e88ed6 100644
>>> --- a/tests/avocado/tuxrun_baselines.py
>>> +++ b/tests/avocado/tuxrun_baselines.py
>>> @@ -17,6 +17,7 @@
>>>    from avocado_qemu import QemuSystemTest
>>>    from avocado_qemu import exec_command, exec_command_and_wait_for_pattern
>>>    from avocado_qemu import wait_for_console_pattern
>>> +from avocado.utils import archive
>>>    from avocado.utils import process
>>>    from avocado.utils.path import find_command
>>>
>>> @@ -40,17 +41,12 @@ def get_tag(self, tagname, default=None):
>>>
>>>            return default
>>>
>>> +    @skipUnless(archive._probe_zstd_cmd(),
>>
>> _probe_zstd_cmd() isn't public AFAICT, but more importantly
>> this doesn't work because this method has been added in v101.0.
>>
> 
> While it's not the best practice to use private functions, I just
> couldn't accept rewriting that for the skip condition.  I can make
> sure future  versions (including 103.1) make it public.
> 
> Also, these patches count on the bump to 103.0 indeed.

Then either mention it in the commit description to avoid wasting
time to developers cherry-picking / testing this single patch, or
move it after the version bump, avoiding bisectability issues.

Thanks,

Phil.

