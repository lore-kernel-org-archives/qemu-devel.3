Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3426C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 09:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seWhG-0005LT-Ny; Thu, 15 Aug 2024 05:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seWhE-0005Dh-Ok
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 05:23:04 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seWhD-0004cX-5n
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 05:23:04 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2f029e9c9cfso10567701fa.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 02:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723713781; x=1724318581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kdNTyQl42Gi+arOw9W4QiaJRA/RNsTztNO5/pHzUnjY=;
 b=br82nu07tzZIqGvgmZIRda771Fo7pPzbun1C9waXoTs6CFbavpDaG3Iwvdi2MrRoT1
 n2Stkr9221ut5W48jUDRdlX3jw9jpp7ZrfqK34Bay75HVsCP9/lis8+WHjxYpodc+zS/
 3OmKCz2S/uw7f/Roq+EQt8TXzxzg/yxVfoGJSUWO6r7toy0KvKFFuoNcEy3HDTDw/3km
 Do9w3bdhZpLmtdVArSSZoEoXsBNiBdO09pvuoVfZIMkbWwNBkrzeXDLfCq86vin5YCF9
 86CunRLCtTOJkHORQFKvs0zG56N3tWkJeV8TzueLiMLbStiKHaXLeaqY4+G0BIXeD/x0
 mJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723713781; x=1724318581;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kdNTyQl42Gi+arOw9W4QiaJRA/RNsTztNO5/pHzUnjY=;
 b=Bw0YbAqUXdUpjTR2Wrhc4IoveNoJqkD/FQcOfhJoReo9zA5F7AhLOFSj1BlruBcpi3
 HneyuNiUVkv3c9pkVqDhKi6zTlD444gl6tXHZiSZmXF9EYz+8G/wNhbLJIVrQtaR/nfW
 drzw6NxtWOn5nw5+7yUHyhKAYFU/7x75B4InHH6cbVXmaLWNHsZC8XfmiH4HO/hh0Pf/
 Vixnwizmbo5ZlNm7Inb/7FkFmjbEkmbMkZ4m7KtXWCSHMcbGRkwOePLz4Rbo+Ap7erKJ
 POw5AF9nhzrZPOBwXr7P/jQOpgFQoZcMIqoDKSOdaPbb2CUO1nH6uvZUj0DWQanjPBBa
 4jlg==
X-Gm-Message-State: AOJu0YzOQ5pGUIO3+/g+rORG8n+PRBCowwowzX8HfZnUE9UTkaAbwzSc
 tUcjl7s9oRLw7VlYoqGDtkxXuoSvX3UybA3jCjSfWCuHXF4s1Wh+AmF0rzOtO9xwthO0QEQLEHE
 wmRQ=
X-Google-Smtp-Source: AGHT+IHQv1rXTyIvxb0264DMh3E4GuhNaKTFk/H8iitjlEHyuljyWe70qD4+pYt3H5lQapdgfhn23g==
X-Received: by 2002:a2e:4a12:0:b0:2f1:750d:53a7 with SMTP id
 38308e7fff4ca-2f3aa1d827fmr36726761fa.8.1723713780706; 
 Thu, 15 Aug 2024 02:23:00 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838eee50sm72330966b.93.2024.08.15.02.22.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 02:23:00 -0700 (PDT)
Message-ID: <a4b40fd4-3431-4b75-8d86-20ad8acd46ae@linaro.org>
Date: Thu, 15 Aug 2024 11:22:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 0/4] linux-user/mips: Select correct CPUs
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier
 <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>,
 YunQiang Su <syq@debian.org>
References: <20240814133928.6746-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240814133928.6746-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 14/8/24 15:39, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (4):
>    linux-user/mips: Do not try to use removed R5900 CPU
>    linux-user/mips: Select Octeon68XX CPU for Octeon binaries
>    linux-user/mips: Select MIPS64R2-generic for Rel2 binaries
>    linux-user/mips: Select Loongson CPU for Loongson binaries

Series queued.


