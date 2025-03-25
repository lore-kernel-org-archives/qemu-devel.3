Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462D9C36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 23:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txDsq-0007KC-BR; Tue, 25 Mar 2025 19:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txDso-0007Jd-AK
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 19:40:34 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txDsm-0005Am-N9
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 19:40:34 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2240b4de12bso60227605ad.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 16:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742946031; x=1743550831; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WbRXjp/PkWRSGIONZ1VUFU0BcxgTM3fv9Qy3wBTHg1w=;
 b=XFLIR6bnnW7n233C6cYwa8xfSy/5jxV+bgh+FtF9P/u/GY1pJ7HSbNW0QqtPE28gPr
 Oi+d3IWMWYyAiPpMM6VQQ+fJDnUK+txmSMa1LAEtL9CZnP4pOGGXP8yTZTOwujamm+fj
 hTExzz7of79IVIbJUVLloNRJDmEEf6JsPsn9TwotFl8RZsmBLzP+qMJlqi5qrKr22DR1
 VYliObRksW5SM3DMut4FaJKzm73tE+FB8m/18yEwwrb5u31MvAmu7D7auugmmEvph38g
 4NcJWPY8C+R6zX0CuiuZeGRfl0flHjl5xWljxS5+bKgMKh+y1kduyh4B48Rpeoic75TR
 O/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742946031; x=1743550831;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WbRXjp/PkWRSGIONZ1VUFU0BcxgTM3fv9Qy3wBTHg1w=;
 b=OlWSjKyfvw9tlp3WTY4B/eiFgrJOQk43MIik/ETeN0YYmtNc9+Ew/ieI4TTmBpoxIu
 gjhvN77KRr22pBMLdD73FHIvS5BBn0KFOf469fDDae/PpBNiCsGp4ywUZRuLVct27bid
 lk2vQn0lcHwtFJJ/uE8l6YHgn7KfP+vntq9HdfJHg3GgDKPOMbWp5zypHzvwTKnKAmp3
 yXo3AdGPngj+CbtSsuCAjV8zmw50u1iwBZhpXevKm9HgP9U2bwUt7CHXyPrjNp7G4CtB
 52gHLW8vzFvpYH2/iunGOfs3Vpf4RF4pxwOTzu5mkiWaUaIe+mKnr/63klKXd7ft/5en
 R/BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU/PxACtpxkMUpwC+jhXBL1O9B+d0qfLf1Bwtujw192pkVfUw4RMBM/taX4PSChPfkdp/wfwtVUIKG@nongnu.org
X-Gm-Message-State: AOJu0YxM37eDEQYhFzEYksyMtg0fMGVhkgy+2eTjii/1cVnFcvXGqo4b
 mDEiPT7BCe31F9UT50UiWaaHdE3fg2l+GVgpB51hF1tPiWNTFrb1MDJPmc+OyrMtJJIUOGffggN
 G
X-Gm-Gg: ASbGncvbCmvwnaXrw3UyFKGmtcKH72fTBbN+nugPAzxr8ZL9t+VAOXBRvmlRgHU4E4n
 O7jUtbgasNwvPLiWHMJDf0vVIsftjqgY4uy5UM/snGfDsS0BQEe82CItglirnLAlSD2+r6PHQD1
 0+M81Fl6GX4ljvg96db1SSLOOpV2ncEJ5SW05VZCWhP8C2miXTl5V5aSM4QYxVUOHobHPgvnt3Z
 PifpMQRrqfZpFY80dMo0aQNdRqwnzjzaC9pNLgjzqMMLcfnpyN4qc52K8GnBXSo1JG+As388n58
 DtJj1w6O1gk8w7Fx50X2s0Ay2rUX2IZ5vzyIdEOhY9r1bsVE1lwiNcF2ECT7ye0oGgZJd1zF0bJ
 08nmEucxZ
X-Google-Smtp-Source: AGHT+IGUw/Gz6m4eCONOEn6IDSAXKA596yMP4OBhO0R+QDCiG4dp+CkK+cnhdnHmF31VvQsLA/VTTg==
X-Received: by 2002:a17:903:22cb:b0:21f:f3d:d533 with SMTP id
 d9443c01a7336-22780c5267amr254757465ad.2.1742946030662; 
 Tue, 25 Mar 2025 16:40:30 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf576c95sm14986253a91.2.2025.03.25.16.40.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 16:40:30 -0700 (PDT)
Message-ID: <4669c66b-728a-4c6f-8973-0cfb9d0daddc@linaro.org>
Date: Tue, 25 Mar 2025 16:40:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] target/avr: Improve decode of LDS, STS
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, pierrick.bouvier@linaro.org, qemu-stable@nongnu.org
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
 <20250325224403.4011975-3-richard.henderson@linaro.org>
 <390926c0-b449-41e9-9b25-f19837df810b@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <390926c0-b449-41e9-9b25-f19837df810b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/25/25 16:13, Philippe Mathieu-Daudé wrote:
> On 25/3/25 23:43, Richard Henderson wrote:
>> The comment about not being able to define a field with
>> zero bits is out of date since 94597b6146f3
>> ("decodetree: Allow !function with no input bits").
>>
>> This fixes the missing load of imm in the disassembler.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 9d8caa67a24 ("target/avr: Add support for disassembling via option '-d in_asm'")
> 
> Isn't it:
> 
> Fixes: 9732b024f79 ("target/avr: Add instruction translation - Data Transfer Instructions")
> ?

Not really.  The trans_FOO for the insn itself does read the immediate.  It was only later 
when we added the disassembler *without* the immediate read that was buggy.


r~

