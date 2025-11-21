Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64412CFC50C
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 05:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd5s-0003pk-OV; Fri, 21 Nov 2025 21:11:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vMcck-0004p8-7k
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:41:15 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vMcai-000343-O1
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:41:10 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b996c8db896so2975436a12.3
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 17:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763775527; x=1764380327; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nayq3vwFhbOfQUeH3b4Y7pYi+GhdLqOYrWt2qsos20E=;
 b=xCwzN1BC+p7Mr89M2dM4atb1T0oACU3h7ER8aKZomt9AGOvnbVeBo5kxJ5p0l+0y3E
 AChxQF8vw+VxEuTSppSlv4I6Rw9Us4s/E0/6MjdS2Vf0WK3WnXN9SfYN3ARQ/fuVe+h7
 cRhHXlSm3k8DkIgRz9mykGf0XaQl1I11E7Nlec1BQcWeL+NgNE2Uzlb55NKvYR0u7kJV
 UrB6A2w/u81eQQ0WzTlEjoOzPJWbg3MGJgkc4brppyhfRdrCkTAW6Fb9QZElkozqXucd
 p+atDRDO4INaPPBr/0Q6WZOWT6quJ2B4it56M3168cIKKBFDR1T/CP3oLQgTVXgqPLhX
 y1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763775527; x=1764380327;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nayq3vwFhbOfQUeH3b4Y7pYi+GhdLqOYrWt2qsos20E=;
 b=N4gF++katpv/UBS96LC2GSmBNZUx4VCpVIHVpynE9faOtQqF6h3yVp9gX7N0mJMd+q
 NtP9n9WQxTfAEb1m3gSX/GF3EJK0o/KeNZxzoLFYLD7qV9endGSqADwO/Xif4+LVRa6Q
 FvRVkn13VHcBzJ3y8JyJHzt2GyADvyQ0r6ILsvNEdmXS4mYGEJ8FJ/bARVD+HxECTJ3T
 2IpFBYKeMtcL4epXN0CCp9jS8CCjMbaw4HcYrddKrsZlrsh7fvtQjJFIE5xGs4y8cKc5
 bgSy5f69BcnsYUdCw61iyEsptkLD162KmMctTcpL//wisBz0G+Gld4LJZnmUZ3ziqwgZ
 8jAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViDU31XwSS6GyLVjbo/MleYIJ6SBQIiWpXiksPKBPCGFhmia5mcixTIOUAaCxMdYoSnJC+uTD+NWTY@nongnu.org
X-Gm-Message-State: AOJu0YwZ9a9hJ885c41IIEkEu6qQ+ElJIRoolv33E89c4uexZB04kpvK
 bOqzH2InQGj+NdHeHySVWc6cA4CVyltAaIpL02xYeFFwgX73S1PF5fLagOSwowamiMuTqV+OsVm
 JDksU1T12kQ==
X-Gm-Gg: ASbGnctPacbV6MBnd0vqmJe3yJSXIjvuLkwkqwVj9SHLfjXREW664OmweB9yt4yGb+f
 YXt876m51f6anWWxWuSNfMTUjuWHDYrlgg5LgzgDjSsysylPS/b6evLYIzO3szGCNPlIDXwTUT/
 cxYWdZKpuEx7j/dlnsxHpnBQmpjB73m9Jz7jQwdUSEaaliR2UMqxp2lp6XOdE/MEJRprzOVsvPh
 RAR8dlD1WZDi9egnC3aRIWklXLMnAAUgCxbLHsYniPXvL8Fe0pyHf7tzd+jbJ8IJBhk0rBi6nps
 P9k97XUWCbRoHT1X5yOxUqF3w3dVDiQHGbA8C6HWrQdnJxB8e1rnqeOVxFWUgaQlikxSivDBLgx
 0YmITQzgOoG3lkjg6vXMuvg5t0JT/h6XrbLHKnq895NjPGsfQ1GtrMebrNaQAjgalYDLaKlVOAh
 fuJMZGWy1SMIUu6urKPQsHVqXtQsH/53zwaV31oauB6kJRLRfVS6SkixK5Pe/fAQ==
X-Google-Smtp-Source: AGHT+IGrgGuydrDMcr9UsOXDVSxocsD/+1frN7BoBamsNci7OFie2f3eu2JS1zKgHZ7tvaSiUU3moA==
X-Received: by 2002:a05:6a00:2d87:b0:7b7:6f69:e9ba with SMTP id
 d2e1a72fcca58-7c58c0bab0amr2678069b3a.1.1763735273708; 
 Fri, 21 Nov 2025 06:27:53 -0800 (PST)
Received: from [192.168.1.104] (36-239-243-51.dynamic-ip.hinet.net.
 [36.239.243.51]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7c414c226f9sm6049398b3a.53.2025.11.21.06.27.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Nov 2025 06:27:53 -0800 (PST)
Message-ID: <800fb235-3503-4a92-afdf-77c7103c6c6a@linaro.org>
Date: Fri, 21 Nov 2025 22:27:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] docs/about/emulation: update assets for uftrace
 plugin documentation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Ed Maste <emaste@freebsd.org>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw2@infradead.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Thomas Huth <thuth@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Gustavo Romero <gustavo.romero@linaro.org>
References: <20251111171724.78201-1-alex.bennee@linaro.org>
 <20251111171724.78201-7-alex.bennee@linaro.org>
 <1166954d-d478-4cff-b1af-ba3246216707@rsg.ci.i.u-tokyo.ac.jp>
 <60f547f6-59d6-4e60-aeb3-f096ed1d954e@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <60f547f6-59d6-4e60-aeb3-f096ed1d954e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52b.google.com
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

On 2025-11-21 15:44, Philippe Mathieu-Daudé wrote:
> On 12/11/25 02:38, Akihiko Odaki wrote:
>> On 2025/11/12 2:17, Alex Bennée wrote:
>>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>
>>> Linaro is discontinuing its fileserver service by end of the year.
>>> Migrate assets to GitHub.
>>
>> I wonder why they are moved to GitHub instead of share.linaro.org. They
>> look like plain binary blobs like other files moved to share.linaro.org
>> and don't need a version control.
>>
>> If they are going to be on Git, why don't you put them on https://
>> gitlab.com/qemu-project instead? I hope creating a repository there is
>> straightforward.
>>
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>    docs/about/emulation.rst | 20 ++++++++++----------
>>>    1 file changed, 10 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
>>> index 92c219119e8..4a7d1f41780 100644
>>> --- a/docs/about/emulation.rst
>>> +++ b/docs/about/emulation.rst
>>> @@ -886,24 +886,24 @@ As an example, we can trace qemu itself running
>>> git::
>>>        $ uftrace dump --chrome | gzip > ~/qemu_aarch64_git_help.json.gz
>>>    For convenience, you can download this trace
>>> `qemu_aarch64_git_help.json.gz
>>> -<https://fileserver.linaro.org/s/N8X8fnZ5yGRZLsT/download/
>>> qemu_aarch64_git_help.json.gz>`_.
>>> +<https://github.com/pbo-linaro/qemu-assets/raw/refs/heads/master/
>>> qemu-uftrace/qemu_aarch64_git_help.json.gz>`_.
>>
>> I think it's better to point to a specific commit so that e.g., files
>> can be renamed in the future. This URL will look like:
>> https://github.com/pbo-linaro/qemu-assets/blob/
>> ec68ed241bb303128537ac662d97e38972ff7257/qemu-uftrace/aarch64_boot.json.gz
> 
> Yes please.
> 

If files are renamed/moved, then we probably want to update this URL to 
new one instead of pointing on something obsolete anyway, so I'm not 
sure what is the benefit. Feel free to update this simple patch, so it 
gets pulled in next release, I don't mind the URL, as long as it's 
shipped in.

