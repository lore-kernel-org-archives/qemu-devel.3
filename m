Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D548C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 08:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujCei-0002Vd-3E; Tue, 05 Aug 2025 04:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ujCeg-0002Qb-Cf
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 04:04:18 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ujCee-0001u2-9L
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 04:04:17 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-24009eeb2a7so41913385ad.0
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 01:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754381054; x=1754985854; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LXMDaEo4BJL2dMLIAuzlGj21wSzNnwv+TLEJtelUu68=;
 b=Zmwq+i2noHHVhZ8qSSp/6kbMes9ph13R78PNzEmryIsk9gyfsDrelas/ex/sCi1rbW
 pYJG7MDbX3DycFkowIm7g9lHvypPe3Trb2Wje1njY8OxMDwn3vfjFnW6v8vlgQkp7yFc
 GlrQyaTqmd8OUdni4t4hxV98gcnhD5jcfhzabJ/tb2bNtAs6e1y3EmNUVfvwXBDR23En
 oMDLOEZDsV5hewqUFzrYgW2pyf1q68q4QBXIqaKple/IOVNogJtvCjsZ24bCcL0FOnyC
 y4mWXIoQiMaXOgrxFwP+kAjB0hyGiMhUdZMOyWXP3zdS2yo1IwTjy/MsoBs5jF3Pje44
 LRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754381054; x=1754985854;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LXMDaEo4BJL2dMLIAuzlGj21wSzNnwv+TLEJtelUu68=;
 b=w1fD082J962Gj+DKPsmF2upWOLF7/CR3deY+H9nP0WQsUgOgESWfUcITFniPjzEcDU
 vjlXnph+3dl4yE3RcUtG0pNsPRzNGWwvnvxTjrEkqqD02oTpf0kSJ8HMP+dd2DuFS+CN
 4bj954wI8bZhvXdpxUjSwXWo9BO9+cyg2Cnpyqd9HHRj6GrmCz6Q99FqI7ofxYYQncBO
 cj+pTVifunpdNjpkB2QlzoIe8Dlfc+1sGA9Ifk9s5Z72xvGwcd0PRMeI58ys0OxyHowt
 hfyjJz/l276kOEgc6O/RvauVepwOnWx1+OkYymdmn0rt0BXOMaKegwF+SfMR+RN4/ylb
 qJdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBAag/LMjFpZfYgkI5KogVtBinvv/gm9ieQ+FIFTU9sCsJ2NIHb08wo2QQFttj+YbbKKNsq2Vcdx/k@nongnu.org
X-Gm-Message-State: AOJu0Yyh+1oBNj3OyWHsziRHasJHSpZMulKAbuJh3456h4IolLQlL8Dj
 0uPZSIHbRaZo5YkBIxV0XngKh3K1z0R2ZpdvGlpikNMK9S2EQ6RcYX0cO/fbuKKx+UY=
X-Gm-Gg: ASbGnctB0fnnZAGOFH9hRvuxCzjxnKCONOFQp/FlVyc2IpI+N5zVtlS7Z9tLViGw8Qf
 3VE0PJLf9GexS2Cy8tlJvNgi9KcbXMKm17Sl8RkE93JDhuYeI0QOc+a3gH0Z7Izq6Ecc9JBPzDm
 +NBQ0Q7odbwmYMf0yMn55BM3b7vvR09RKIDACKQc4vBwloJ10ynG1+19pXu10qJ6/4ffPB52PED
 OS1N2bomsllCa3u34ntZMJEb92+uMqRQJRnDSrvwI0uffvRxzf6vzXi06Qb0ZLwewlefjzH0eGR
 kkp5lUkQjj1bsq8x0/21I1kaaOZzzrEPr4rrMx/zioRVqiscoz4ZtxfeASZgEg1Z/tOL6++zL2w
 Y2IZkA9+88iS0UHsL3O2QRLcxNBA45/DoOBU0HoGc
X-Google-Smtp-Source: AGHT+IGAXeoDZ2NToANIfJRp3IRm4yxeS4ipJBIVjWzOEWeNguDh+WIVPVKj2mr7Mk64fSsYkKAU/Q==
X-Received: by 2002:a17:903:2111:b0:240:a21c:89a6 with SMTP id
 d9443c01a7336-24246f58785mr129071695ad.12.1754381053907; 
 Tue, 05 Aug 2025 01:04:13 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899b5f2sm125967755ad.125.2025.08.05.01.04.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 01:04:13 -0700 (PDT)
Message-ID: <a38ce19f-7520-41c4-b6e9-54d4ba8c14cd@linaro.org>
Date: Tue, 5 Aug 2025 18:04:08 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/arm: add support for 64-bit PMCCNTR in AArch32
 mode
To: Michael Tokarev <mjt@tls.msk.ru>,
 Alex Richardson <alexrichardson@google.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250725170136.145116-1-alexrichardson@google.com>
 <befab3c0-024c-43ca-8d5f-bddf960e9a21@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <befab3c0-024c-43ca-8d5f-bddf960e9a21@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/5/25 17:44, Michael Tokarev wrote:
> The mentioned commit:
> 
> commit ae2086426d3784cf66e5b0b7ac823c08e87b4c57
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Mon Jul 7 09:15:47 2025 -0600
> 
>      target/arm: Split out performance monitor regs to cpregs-pmu.c
> 
>      Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>      Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>      Message-id: 20250707151547.196393-4-richard.henderson@linaro.org
>      Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>      Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
> The thing is that this commit not only split out parts of helper.c
> to cpregs-pmu.c, but it also modified the code quite significantly,
> which is not even mentioned in the commit message.

I most certainly did not modify the code significantly.
The code was moved from several discontiguous blocks, but that's it.


r~

