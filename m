Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CE3CCD184
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 08:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v62wd-0002JT-0L; Tue, 07 Oct 2025 04:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v62wb-0002I7-6K
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:21:13 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v62wX-0002X8-Ex
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:21:12 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so4047661f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 01:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759825267; x=1760430067; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j73d4DXCW/YVG+Y2q+r1IWRSP9IkyKBSZba71VLcPEA=;
 b=RgxfHPFFYSttKJV+Lnf4pJrAB8na2fpyYcfNihZvaxELR/wxMmZ5ZmD4DcsfvYqjNE
 dLT30T3qbV7ViwPwg3DCkDNKX/68oQNNA3jz0s6/C9bWOLPG/mTkBY7qT0ov3Wag2i5A
 Nrw1XVKYNU54bkgOI2M4dc3G1/tOI17DAuYrFKMpBLXTSIYn3J/mRXb+a7wwbWLsrD3M
 manux2UGo3NmANqfXnzEczlBlvFgB33mJFzye8sqTeDNM8gm5a1khtLWy9U/Xbk7PPOJ
 XmL4W5Iv04GahuN5ictIRaMfbIa9u1gK8mZv57rDhv0U8GHJEuRA2ZdPyoyHbv/5RPkk
 YIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759825267; x=1760430067;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j73d4DXCW/YVG+Y2q+r1IWRSP9IkyKBSZba71VLcPEA=;
 b=QH+5q2zfq7k7M/mmsFKnfAC4LykBtHqFYA7efbu20mQAjuFTxd/3fe+ZPgqHtHcWh6
 soHg29ByPyipFNOudbBDgiy2b2mlvT1f/9/d+kV1eA/LzlJ0/cu3ykj8yelkX7/5YCvX
 ZTRWcGIVsoQUZ+SYPZlagxS1h5vB1knPyozWjBzZ7psT4xedWGT0PMxCE69W8BNs8pgS
 h8sfASaRuL8+yZdayYKlY84CLjncRc9IoAmQrBi+ZWgz5whdn8A+vjG4EehR7unGAGts
 NZPvHl/U/KVPvKm1KAzgkfkfpIotest8d0ZbM5hdkIcpx/VAn47jlsDfDYMOyFLzhMy5
 p2Rg==
X-Gm-Message-State: AOJu0Yy5Hn/uzZo15IH+5tT5BNoH6+pQU8P3UIBbDaFh8RrST2ZjA/BI
 ocNwwfGyBHCVCQynlhqD48zxJe61aVsz3buhZAzHzfky4jvBkVDu3drJ/EuaU+5CoK4FkfkOWTG
 PNqU0+yzy3A==
X-Gm-Gg: ASbGnctS/CJB3avwaBEw/aGCVZoxj90X5GFQh3ZfEetcBO5zYXmwWs07cN38la5rnCK
 /1nj3fkXrp00afba53QpkcMJgKzXiJwA1xbHpCznj8veGe8SIZtwPsNxPiOuAUAX8ZRuXvIwVCf
 6HaN6C8nFKlmLpb4J5cEb6UR5FQKNvnXcSBmhlpyG8tPcJYNrGgW5QmYBMM15MBpoPmEX9doKzr
 OdRUtYsMhyleuI/ovcXbbA74qMMtBnCCcA+KZnwVspKoKHXY1bnbxKGci90bt8AQ0BDUMtxeDTF
 RYH/+NfspbJKIVxAP5LU4IgsmowBAd1j2sKgjUlJnd2K0RjTgHA8L2dgOe6bDsBoYcHHYR3169H
 6zgimMJDi/mHHy8h+5ufr1VjjwHFhyRPsU3i9gR8N4xbx5BA0wgo3e+DsrYWbkDZengZCUdlg9P
 ibWPLM6cbV4eOIJoI8Kg==
X-Google-Smtp-Source: AGHT+IGIdq35LR5OYIzoUlt3WNRPbXUrl4pXMpQ59D1Irsn/syFYfBL0q8hR0hEI9bRSVp3aEIsZlA==
X-Received: by 2002:a05:6000:2dc3:b0:3ec:b899:bc39 with SMTP id
 ffacd0b85a97d-425671aaf41mr9710309f8f.58.1759825267465; 
 Tue, 07 Oct 2025 01:21:07 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f0846sm24719598f8f.45.2025.10.07.01.21.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 01:21:07 -0700 (PDT)
Message-ID: <7ed880e0-94bf-41c8-b3a3-8c41505dd0d4@linaro.org>
Date: Tue, 7 Oct 2025 10:21:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] target/ppc: Have gen_pause() actually pause vCPUs
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, bharata.rao@gmail.com, benh@kernel.crashing.org,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20250924173028.53658-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250924173028.53658-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 24/9/25 19:30, Philippe Mathieu-Daudé wrote:
> Probably due to a type, gen_pause() keeps vCPUs running.
> Fix that.
> 
> Philippe Mathieu-Daudé (3):
>    hw/ppc: Do not open-code cpu_resume() in spin_kick()

Patch #1 queued, thanks.

