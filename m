Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A691FCFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 14:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxoue-00057W-6H; Mon, 07 Oct 2024 10:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxoub-000573-UJ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 10:40:37 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxoua-0003Yw-GL
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 10:40:37 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7ea06275ef2so828525a12.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 07:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728312034; x=1728916834; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B0cW/xbTHMGvG89kfr1yqT6J981mLr2mziWkiv7fAos=;
 b=qPUJBzKzUZNcKaggLvLcTWjenuvEJWfKaYCtnq55fWeQHtupx0uk3wpl2hRWJl4HNJ
 o7efN8Q2iMOAyp1vF6MSqfgPNm1FfF2PPrdVIWqnUKQRxvu8xy9bmClADmY0vw6J8gco
 KHoc8/Hsny9VI2//1gSN/l6wZ6BPjGrpiwI6pxzKaQdHx2dXY5Sx9BFpgAsMmzfeFXzW
 BUlLXKNomUO9VA6rqVBgJTerm0d3YqHVHNhGz4p4KKy3r8u7QAepAdVzEo6SgUA/dCQh
 yBIFSWi4+I+QGKUZv3x8pKew5qDRoZtR2bQVSQTuyzXiLm0ZYi+xg2gHnt6qaeCio5qv
 XG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728312034; x=1728916834;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B0cW/xbTHMGvG89kfr1yqT6J981mLr2mziWkiv7fAos=;
 b=PJVYvSE2kaXISiBL5bYTKRW5jYLClfv6seKfpY2vucV88GOZq1I4pbjh+jFzC5twLJ
 njeJgZdbrUPskgG/hLgMBSJ1xh18D+LnI7LEt9g/8HsE9d4XBYeTlWZcmoIiPzclsKdE
 edhA2QG/Rdao16S7YF/89DT5b6hOlcDVMi6Qj3sEniXtuwHlI5x//tK4Yf4wHG5BkF82
 M4pLfTknvLEO7wUMte2Sz2ILr1WGk5PBQ9F809vLBykA8xg21fK/JLzxxN3u4NG75wrs
 gWv3ELrK6lGjNDSsCRMSz7EyU6qpPcS8UVBmk/H61a7n5lGA0xJ2eXQX2Gcs6qH+2imO
 iy3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNw2lNyxzK+Lqg2VKk6nC6/K4VKaOMgMb9+X08ilHqwxkQQCsMyqB+XtznC47DOD+eI6DVnG1nPjya@nongnu.org
X-Gm-Message-State: AOJu0Yx4B4vH/leo487AlpeUDtOUZITh8QBv3y9YfVtSQKs7Dxvd0+79
 b8tqD7CYPsoYlNMdLx41SL/XjRo0rlQYpSajhWzli97aOn3WrWp01eSaBAvB2gBw0VJycVdMAU+
 s
X-Google-Smtp-Source: AGHT+IFk/uolp9XLOAdU3u/FY6iX0phehBX4cDAKAkgxfZaZbEJN43fTUoFJsr8OtALAmhjRpXjx5A==
X-Received: by 2002:a05:6a21:3511:b0:1d5:1520:7e25 with SMTP id
 adf61e73a8af0-1d6dfa4868fmr19281207637.28.1728312033924; 
 Mon, 07 Oct 2024 07:40:33 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e1e83cab7csm7268959a91.3.2024.10.07.07.40.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 07:40:33 -0700 (PDT)
Message-ID: <17794b7c-c337-44be-96ed-d647a28864fc@linaro.org>
Date: Mon, 7 Oct 2024 07:40:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/25] misc: Use explicit endian LD/ST API
To: Pierre Muller <pierre@freepascal.org>, qemu-devel@nongnu.org
References: <20241004163042.85922-1-philmd@linaro.org>
 <5a1606e1-649f-4bda-83e9-aff8c9dfd9f4@linaro.org>
 <d2071e32-c35b-4cd1-a93e-a117c27a9ec1@freepascal.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <d2071e32-c35b-4cd1-a93e-a117c27a9ec1@freepascal.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 10/7/24 00:52, Pierre Muller wrote:
>> While we have never supported rx or riscv in big-endian, but there's no reason that we
>> can't, and those target/ patches make things harder. Since target/ will *always* have
>> TARGET_BIG_ENDIAN available, I don't see that we're saving anything there.
> 
>    Isn't this also true for the sparc CPU?

Yes, I'd forgotten about that.  Indeed, Sparc v9 has a couple of PSTATE bits that set the 
endianness, exactly like Arm and Power, which qemu has not implemented for system mode.


r~


