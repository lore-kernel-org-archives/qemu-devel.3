Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A55CCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 19:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAvqI-0008UB-TP; Mon, 20 Oct 2025 15:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAvq5-0008Pr-Hc
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 15:46:44 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAvq3-0007zZ-AE
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 15:46:40 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-63c12ff0c5eso9571481a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 12:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760989596; x=1761594396; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=efnUBJtoAcHsI48xwqaiqY4Xn8auHKuUpGyKZ6tVUok=;
 b=NRFSuHX3NOPyGeIaDjLpjnjLLC03mvVEPxmvt42lzsfJMoRo8jbswhIcGkxHVNsj7g
 6DgJvp49bPFFifv6YJvPyj0VY/guBce/6ILcFheS0PN1O7QQL3+1C/yzRVM6r/1SRCDk
 dqPFnP9lFF4aX0Jt2gV62Anot7zCYoQMAIZIkmL/sttkeRbYWMWROMtoGdRxLyeyk5bg
 Gsdzk1exLQQn5hcOP3U0k20u0mWzWbQ/XvL4onc3+bBH6PbzTw6rn2wKru8Ygy39ewku
 80AQmvTXj6C6fh7wARRP7tRx/aXDlI66Sftiy23e3uU8m2bBSwzdAxsfqM+99F2N4CvR
 afZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760989596; x=1761594396;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=efnUBJtoAcHsI48xwqaiqY4Xn8auHKuUpGyKZ6tVUok=;
 b=Iog6ZgNVXyzF2H9A3CitLToLzQ5cHl9nsKmHV1jsQ7OsIcrbUhvciDtFwkEt8rOnNY
 XdELNlcKf66hpRaAmLjefQWoEEKtZbQUsf7ilnUuMD1Vpl/FEvre55Y8aOLTG0tv6icM
 6Xa8/CITh2QxRG7w4MrHrWzwBCYeYgPFVvOGJLbe6RVKRBXxdEtCbu6NYPHJo/p8LQeL
 JiH/KfpzrzUZw6nY80HKCeR9/7sEHnMBXKnNnTmHQt0jkQbcYPliT4Cxar3VbU8+gdLi
 FUzsSpIymVQk4kTtNrzXZaaWs7JqTPryAF3XLMWqe7C/WrfMA/oINjjuI5Xn72A05uoN
 NJ1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYDLebypPePkyBvb4LJN0RPM05eXjXRJfPCxvDLdKab0vzgjsvNgIi2MLqppUX1Eyxo4BS9+9oj5vE@nongnu.org
X-Gm-Message-State: AOJu0YxzScrZT5sNar59MUfaHrCuYNxiEpJsRpVkfj0oiWiDvywA9uwC
 DxHt62nGMNp2WCyqubTfDe8qx43R4pmi7K2kXwXYniCkSpmijoIB+OivR7/zoXjX/Fw=
X-Gm-Gg: ASbGncsID6g124sBd5t5idzD84UlBhqv4/Nlkv2LwRuwv9AbBc5OWUESN7II/v5rQJF
 G12CXrIPRMoz8P4Hx/VRfA98blSnmv3vSQmcT8QcZxkMANHJwiUY1Po16VsKv/+1tBRN0IyuPtK
 9cxVkSNzCsdtF8lG9ilmoVZ1JMrJvm2dZdcLKMw8KxaeNOT6GDywa93HNAnSMqXVAOoCLADJEaj
 nu8GTZ0DMP1qwPLV4yqgEBNasO0uTQSgdbecOOL5NrBRFwkfKI7gaTJ7bg3b/WrRuDESpLZ0XGB
 mElLU7p0892Vg1atwjJtUE6VUhLh23kKyDKqu73jItJuImMbtXlu8qgIqIy4TcnM0FevqybTXhF
 SHdAfW26ckjb8Z8DwxZ+093YrX2byGL4UDzcYgFGrceeNGb0bXCjzDCcK0QLmcj2zbEbWrqFD1u
 +IEpvQku8Lp/LTy4hKAFiuswZrYi5Iu2s0C6k332P8XjU=
X-Google-Smtp-Source: AGHT+IGKNPeOWCexedf8W0yQ2J+cA9hb5DaBazNrSblbC5ZakbQtDuB3PFdEi8rc1GWigbJs9xFjjQ==
X-Received: by 2002:a05:6402:3585:b0:62f:4828:c7d5 with SMTP id
 4fb4d7f45d1cf-63c1e283083mr14893785a12.16.1760989596561; 
 Mon, 20 Oct 2025 12:46:36 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63c48ab52b6sm7550303a12.10.2025.10.20.12.46.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 12:46:36 -0700 (PDT)
Message-ID: <6c502b49-5e5a-4a97-aca9-ba5ea1e59fcf@linaro.org>
Date: Mon, 20 Oct 2025 21:46:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/16] hw/ppc/prep: Always create prep-systemio
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1760795082.git.balaton@eik.bme.hu>
 <b5b0150b6c579b10682f6482e7832cf381ffb759.1760795082.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b5b0150b6c579b10682f6482e7832cf381ffb759.1760795082.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

On 18/10/25 16:04, BALATON Zoltan wrote:
> The prep-systemio device models the system control ports of the 40p
> machine which is not an optional pluggable device but part of the
> system so it should not be disabled by -nodefaults but always created.
> 
> Additionally remove some line breaks to make lines related to one
> device appear in one block for logical separation from other devices.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/prep.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


