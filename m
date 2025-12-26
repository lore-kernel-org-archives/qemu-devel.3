Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C57EE8FDA8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 16:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZAZM-0002sE-Vx; Fri, 26 Dec 2025 11:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZAZG-0002rl-HW
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 11:21:31 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZAZF-0000k2-33
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 11:21:30 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so43846545e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Dec 2025 08:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766766087; x=1767370887; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1cCJOKIEYSbO0/Y44S5VuT7d7zzBKEBq9Hl5ClNUtR0=;
 b=r7dlR+ry6MOXR7TZXmLnntZVT/FoLm7FbwgT6unCCX1FPUVdmZSU7Lxpm37xc9lYX8
 G1DZiUBlw6u9w6Smw5sdUDuSfAfwuIZmCOq1SQV6W3CiLBBwNS5Xs9R0IL/Ho2AsnMFB
 Uv0f+kt9fp2oAAS3u4KFnYKki9Y91nO+UsUQq773dsb0i+yIlPpwJ3PohKvCRM+RyoV+
 e2jYU6M7jayDtr3cvxWWPVepJQUU2BRKcAMH17fMnAEmCytI8sRd2lha5Rpb9c3VqNqO
 TOzgE9lLu2ERH4VmdoL+a8JWm+g1j79z0hDNJnWr1aNkcgeVhCTvk2jtuQPRVYbmpGyH
 E+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766766087; x=1767370887;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1cCJOKIEYSbO0/Y44S5VuT7d7zzBKEBq9Hl5ClNUtR0=;
 b=acrAz0lFyii8BLPFAMrdsrLZNouhT405CNcjZE2q2Xg4kQAxYfBfDZW60AZ+2gMm6g
 4H1ZoD8BhT105FNQ5iUezqBlHnt+UfA6Bf7scbfRGe3o1St4eXDFMzEtfVEq3wymZrIZ
 fOGnUwRgquMOjPRBMVZC6rpX8ExxS06ZeCkLOYeHPnfxWO83YSBnznRCFwtxLWWtmUhK
 JR0BEjKuUm0hLKCQFQWSz1abrcJKjgMQkhzcOGGPnz6nCI2ZXBaMPUDckrHF3Ln0bRBT
 UM/3RQ70lQMqDfUI10/U2IQHRxRHrk5pNfnXgZv7fYvtKuhdPzdHvlR6x5j35YngRnEV
 H2gw==
X-Gm-Message-State: AOJu0YxkHyA0UR6RPIJx0VUCQWSoQf4Dv4uDteqBhrCh1vY9g7nbKZEv
 QrA0M9GEcBZU4HYBV0id71OO1XFc/6pOr6hRoxqUvLyisN6Wcsx8nu8hbkCUfiMeYFo=
X-Gm-Gg: AY/fxX6SmTKlZJwz00Aikp68uEsub/Aoh4PN+rXDu9Rdt72ZHlFGUc/O9kSvKovZhUD
 PVwpriOb4BG+e5n5Wamueq8w69Tv90YgFfNp0bHwR6RoUG1Qr+nLw4cZlDPrYk05zf4oQY/Wp//
 3l9OugHm5Rdmj7G3yCeJtRFoEOzlotI8LMHLaW2YyzazddRtzTBaLylvMcgRr1b0P8tO5e8B15n
 nc3pNShcAUm6vuKsmkiu8M2mrtlADlqSXrLZt8iOnzYezBrzyBRbv51w+zJs2ZW/PrCmbVR3dNH
 mNldRrgviLa11FC0RWmhDtt3de1frDWaCRUKzxPDHzlxTTc9bDlSdQKmu55CgmXXrp//H10Tu4f
 XRWCKsLyHOmqbAR5rZKRVXNbY0FH4bpCVpC6WTFej1Jrk7qIIWZFRr4q4q/cw++d5Vx7v4PQp6x
 xsaJ3nJOApV5ea+gDi0bRhxWnaGUU4s3iesaFk8bTT2dy7yLzCUzFIorxPjNARnByz4MH6aO+k
X-Google-Smtp-Source: AGHT+IHsld3KdywM1Y9ZVuk1CEaORTKByEXFWt/nti91dT6/8XYwin/gF3sGGJHdDz7dqhOfj67wUA==
X-Received: by 2002:a05:600c:1c28:b0:45d:dc85:c009 with SMTP id
 5b1f17b1804b1-47d1954586amr247567895e9.10.1766766087542; 
 Fri, 26 Dec 2025 08:21:27 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be273f147sm459683975e9.7.2025.12.26.08.21.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Dec 2025 08:21:27 -0800 (PST)
Message-ID: <132ef8e0-0fa0-494a-905f-788c11a2b7a0@linaro.org>
Date: Fri, 26 Dec 2025 17:21:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1] target/i386/gdbstub: Replace ldtul_p() -> ldq_p()
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250325154528.93845-1-philmd@linaro.org>
 <87zfh8119v.fsf@draig.linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87zfh8119v.fsf@draig.linaro.org>
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

Hi,

On 26/3/25 12:26, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> When TARGET_LONG_BITS == 64, ldtul_p() expand to ldq_p().
>> Directly use the expanded form for clarity.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Queued to gdbsub/next, thanks.
> <snip>
> 

This patch got never merged, is there an issue with it?

