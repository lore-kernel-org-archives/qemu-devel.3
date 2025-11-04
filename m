Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E456CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGKAQ-000656-Ub; Tue, 04 Nov 2025 11:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGK9L-0005rZ-C5
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:45:01 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGK9H-0001DQ-NC
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:44:49 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b719ca8cb8dso228725366b.0
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762274685; x=1762879485; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QNaUOObV524kDt6FbGD+R0SMCZN1ZSuzVPtvd7pwwK4=;
 b=S9UcWievqZHxCp78uBFxveR2myY7ib0giqxN9/oPQMEJLp4wvDUPBikupgYhd12zRY
 8up+8jHGCQCedNyNH8SJ94Emtnz2D1wIFgh//ZI8adl5/Ye6ShUHK1pdVwUfSlS38nUW
 PU0ImHBHGurQsdKXwTf+bdu8UZM9VBvcww7UYnmbUaGHDm6GKsAdbGwY9iPZHl/prjZV
 he2GBtYcOdntTyXG4yoZGnoD1n+s8N3D0eoDoxfpMOLP9k+C0LZNudoN9xVE8M042TMJ
 kA9OF9+KqczFZjjH/KTQBnWqVwJ4ntRDyFZDQUrJev+WbOrPjlSoPkRsGIWs4/R59UyK
 cKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762274685; x=1762879485;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QNaUOObV524kDt6FbGD+R0SMCZN1ZSuzVPtvd7pwwK4=;
 b=ONN1YiwIY+PerOdcdi+ot/+iAJX4UCS+UBoci5iLMymztxWUdSfBcb3ZhyswdyYu3T
 obdqFWrT9BvntVZtCYAbJI5U1V2jPEhS3gZQ1kMHxlqvTsCL/aug/11cewI/+XgiTap5
 QUtI/m6PGyI0bYTlvMjFgduTi3hXMFalEijis28tTaY5Kk2g6TCsVcUz+EHRdQgBjWr0
 dWTSsBQlstGlYKM5OySPigcdW+A8o7Ub/wkcA73E7uzCETAHWirK0khyReLgtcrSWGdY
 SR5jC+zs449B1Dq5gxxe66QtLvb1PePnPHky34OJNRTWyDPz+rCyQtmO5DEwrZhcrToH
 6PFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjD184yQ3iWFJElu/TlHy3b+QVwpuyKVOFBX59e2VmTZ9dD0xs+QW8vJTLQFTflhT48NZzLROIdQ+T@nongnu.org
X-Gm-Message-State: AOJu0Ywr+e+fpmhyW9x+eFDT8t4acnHeuoh/hEwkxuLqkP/zzj6h8WTt
 BtPL5SNapln6QKHz/WZKUhuwt3+rEaj1UKPzgrxMy3K7Nfn3vaWwok/AOMgfdIscn5HJKgKiADZ
 U43520gA7ow==
X-Gm-Gg: ASbGncs/zIwYnDvAUUpVOHnxoOUNM2vRQ/Hw6Yaw9bFYjQ6xsY7NeoNASCMx5MrH5XY
 0AYEr3Lm9VUIIRYyvUAuNeN8QQ9rjaAFXEOK9qS/sFqMSfd4sfGcvb+c8y1VYn5GH3cW+UWTp/0
 7W/q0AsOF4srINsu6AX908IwkWWQSkKLo4Tg2JR024PMuPLusRET1kfilaHbRsoBQUHFTG096iV
 nb/F8q8dUCEzJu7rfNDfAOmrH4wLM+LVnVXjS3mzOaMiwFL2Z372t02E45ecAMGyoXxOWPhRgEb
 VzU3N4uIuwPEVOCi1pYLl0NzrskICPkAwVCtdmE134hIb2Dvjxp9zTqzl2sf4vjHC+EWnoiP2lO
 BwkRs8S1HQ1cS49xL9pb5BBAfVewg4zlvhihkzDFAMLpPMBZa8FkAGHmhBN4Zt/WKEbfxnju7Mn
 9MNvfjnHU2Tw1GYXAXChyGuCh1GvowCQ==
X-Google-Smtp-Source: AGHT+IHU27deO5w5HCzcS+pVkBpawhzXcUeX1I4C6mdARczKbf+gde4sWR/Sx2pMtwECDH8D9CIVLg==
X-Received: by 2002:a17:906:64a:b0:b32:8943:7884 with SMTP id
 a640c23a62f3a-b7070624338mr1256166566b.45.1762274685020; 
 Tue, 04 Nov 2025 08:44:45 -0800 (PST)
Received: from [172.20.148.75] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723fa0219fsm253336066b.56.2025.11.04.08.44.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 08:44:44 -0800 (PST)
Message-ID: <397eb924-34c9-4349-812b-528342be12c6@linaro.org>
Date: Tue, 4 Nov 2025 17:44:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/net/e1000e_core: Don't advance desc_offset for
 NULL buffer RX descriptors
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>
References: <20251103175851.428816-1-peter.maydell@linaro.org>
 <20251103175851.428816-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251103175851.428816-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 3/11/25 18:58, Peter Maydell wrote:
> In e1000e_write_packet_to_guest() we don't write data for RX descriptors
> where the buffer address is NULL (as required by the i82574 datasheet
> section 7.1.7.2). However, when we do this we still update desc_offset
> by the amount of data we would have written to the RX descriptor if
> it had a valid buffer pointer, resulting in our dropping that data
> entirely. The data sheet is not 100% clear on the subject, but this
> seems unlikely to be the correct behaviour.
> 
> Rearrange the null-descriptor logic so that we don't treat these
> do-nothing descriptors as if we'd really written the data.
> 
> This both fixes a bug and also is a prerequisite to cleaning up
> the size calculation logic in the next patch.
> 
> (Cc to stable largely because it will be needed for the next patch,
> which fixes a more serious bug.)
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/net/e1000e_core.c | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


