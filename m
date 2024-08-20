Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11A4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 10:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgMDd-0004eg-Ke; Tue, 20 Aug 2024 06:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgMDW-0004O8-W0
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 06:35:59 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgMDU-0005EX-8s
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 06:35:57 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5bed83488b3so3994767a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 03:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724150154; x=1724754954; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yXJem3kW7YDrCLQ7rXd4Lih5la9pkJe8fwNga2IX9P0=;
 b=MC73k/FwK9qsF9Ktm9bB7Y9419mExABx+mn1Bv9jVRVJeGikiFki86IUt/VGJrhdod
 4+/Xk9GQ5GHNuu7+anGSBgarDIP6FA9xE2OUM6vROoicSyxAiVe5+Oupv/5YDVja3hO9
 FtS9VXzbC3cX7vUmy3JPcud6hYQY/yQouAtkY4+5Mv8qVAszZnPo8f6AU5SAl0hr+jPE
 9+s7JozlnsBoCLYLgGdTovXNNaHTdxa0yJlMsrka9cQhmncz0ewXwUWMoYML4hMHyU8t
 UigRZpaLh4OEbbKgrrKKj0jXvfYNIKc1d1TAYTuPybYzt8v4FHk7+lemgHIfilKHlOxO
 2jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724150154; x=1724754954;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yXJem3kW7YDrCLQ7rXd4Lih5la9pkJe8fwNga2IX9P0=;
 b=FALXzaYplttZ4B6+Ur6xwYNMoOIcStZxHKvAFbAFCsTXVXoRLjfFkNQK6Tmbes9Fhg
 gMPiBcLEM0jFf5QLpcHwlzZvouF8nyesmI6y7b4dvuLH+sxtuDrzZASmAn1AueN1mlha
 7pQjrErdbxZzNVibN0h6kEujvUBy20qDpF3pmoJ76YsQF6orSmH7szrQvW0hPfDYDfib
 9sbu49tHy502adaeJSP8ck4Um+K/IdvEX3gBKTTV5yTPaaYdEzjc+6TjHAzaylBjgUDD
 Qe/kxOz5iC7ihcaBtnCn9CyhzEXOLF7iIImxVr35HIK8fYOagJeGY5QPAnZVOUA33nNO
 n3GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjx10TROVgMRb8a+Ift5MWnnBSAvfGQfJFwzRp10pPbSkpAtzgUZyzibe3hlsuUIpvjhfgsjzw56oMNVKlghB89ugr2g4=
X-Gm-Message-State: AOJu0Yznex/DOnVBkGBdMhCiVvcGvRBNO4tpSQ3FPh/0Q5HvMUEXW1BA
 RT+C2DnZfI8r6iLcqpOm5Z8zwmPSIbZBS9DrxevrmqLMJknODKLrHDJ419VobZQ=
X-Google-Smtp-Source: AGHT+IEWEZ7tgKlwyVFYxa4PTm3DHgr9+am7k8gwh7++nwQlnFh5x6v/tQJACV7kixia6lAlblQn5g==
X-Received: by 2002:a05:6402:5253:b0:5be:fa53:f81 with SMTP id
 4fb4d7f45d1cf-5befa531033mr4314684a12.37.1724150153816; 
 Tue, 20 Aug 2024 03:35:53 -0700 (PDT)
Received: from [192.168.223.175] (84.21.205.77.rev.sfr.net. [77.205.21.84])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebbdfa6a7sm6665618a12.40.2024.08.20.03.35.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 03:35:53 -0700 (PDT)
Message-ID: <68598e12-f2d6-40ee-8da4-fa906f9fd0a7@linaro.org>
Date: Tue, 20 Aug 2024 12:35:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as a reviewer of VT-d
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>
References: <20240820095112.61510-1-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240820095112.61510-1-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

On 20/8/24 11:51, CLEMENT MATHIEU--DRIF wrote:
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



