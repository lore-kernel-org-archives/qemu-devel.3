Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15396D637A1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 20:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVbLj-0007Qg-UL; Tue, 16 Dec 2025 15:08:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVbLg-0007QI-RZ
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 15:08:46 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVbLb-0004im-4X
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 15:08:43 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a0a33d0585so31564585ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 12:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765915717; x=1766520517; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=00NZgZanZk2i8XUGdnK+VCnE3XpUB6MIHPNxnOPtssA=;
 b=DE/8wcZaiPl1qbThots++GtzjRamRSfU0Qoyvx8THyWjTJtN3JVKgQlqC1n6KHJuUA
 SZaleSLq4iVsm3DlwlmrGkrA+KMI7ySH9JR8eDPokP72w8EhqAe+iei9KfzpCLORbrNs
 beuREo+kVMTXTHBn7RkNRU6KIw/pUyUf2vcgufGyKVX7zJ/pHONDMoZKujz2tAvbP/c0
 O85c1TjBKcXK76hR31GWskAIXz/Rwc1LZJDSQkw5SlLg5+WRiCDCfWxFd8q1RcZLELKF
 bIUvgaaHlcu2G0XjSeVi/D/w5Rq7dZ/0AcRA10z91PMFyqe7lzONdbZpDSST0L2XlprP
 Q4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765915717; x=1766520517;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=00NZgZanZk2i8XUGdnK+VCnE3XpUB6MIHPNxnOPtssA=;
 b=A3A6FfRezjI9Ie+i5GdRpeGH1J5yD9vxiBFRQlaJ/6vrZstkmkKErjgxjKc4Rk+Toj
 /7TWTx8iMAP4UZpx91aJhLdZiev4dGHhk8ep5KWhGCkzVV+vHtgqw4Mcne900Q1kx8+R
 9NccKVRvMPtHOoi4A32unPudlsyvUbFxsL/ytGBQpNfeM8GDyYzhEtEpH6uG3ocNx2v6
 OTtclLCSxQ24/m3oJfR84MuGuly2w+WdRJcpiGvCGCF1RTCnbl4P95fjhwqFgV6phL6C
 kldJofxlWzvV8HN5L3y3lYXhPoNRYpMhjxtiMS1N1ZICBslGOsxwRpjovkdUlK5o+Vlz
 LZAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8Uknvd03XJ5pgjthK+r4o33x+mDfVCnZCbAIAkTJAU/Hlkvz40sKSO/RfXbYAotBP2akCKSTPCi/j@nongnu.org
X-Gm-Message-State: AOJu0Yy7Y6hwsm4Deh+FDTc3AH4zOCiTOpS33ipxewI0FpVzqtip7c6P
 vJuIxk+CpToD8o5vvyLtZLNuxs3bP5gupK6IYOwe5ec3Y5b929wb/4B/b1tPz9yyUwU=
X-Gm-Gg: AY/fxX71MAXFpYBsJXgY891hPbwwr/aRFaM08+oKIOyrd3239XOvJnjWnDmv2ulWFfK
 0MvoKYPp0ZKiwhKC5TV8mz/luH5UgoQJ0oxNangLTb9EO+cwyDzMER3ygKLZsDyDXOPYjj/RNJJ
 cCpv+5oiC64LLv3X3zb0nRuHuXQ8q9zC2olohsfqFKinBjoKgIgOWt0U9x8SOTRt2gKz0YOxAyT
 4g/ajoSkWI5inm6cmoIhex8WwdeUyhGs0sHE6ARw1FkDXDjMdv6nH4GuiTkbQzZt33tdYxKirCn
 cox+46fNpQY7JFIhBZ7CAiXFjn674Wii28UjYsjWSHW4ryuSzcIo+LPSfMWHxGEv6q+6gpn89OH
 kDcStBaxwb77amw/WFZ1FOKnFLDDRycUsPPiq8a0C42IQjBv0WPDKk1Ld5YgxRPiumSFHVnMoJA
 1OAqmknrOvg0XWfYIpzdUwPxqzTp1fuQ==
X-Google-Smtp-Source: AGHT+IGkXYEErblLzy/CAmG8q7L4JxQColJWZ/qowusq8vbkl485CU9I/SuixqLz6r8jahO7qNT6xw==
X-Received: by 2002:a17:902:fc4b:b0:2a0:9d16:5fb4 with SMTP id
 d9443c01a7336-2a09d166e1amr110932775ad.18.1765915717426; 
 Tue, 16 Dec 2025 12:08:37 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.245])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29eea03fceasm173287265ad.79.2025.12.16.12.08.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 12:08:37 -0800 (PST)
Message-ID: <32b8a371-b93d-4e40-8168-93bbf4aea243@linaro.org>
Date: Wed, 17 Dec 2025 07:08:33 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] glibc queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20251216142843.519084-1-clg@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251216142843.519084-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 12/17/25 01:28, Cédric Le Goater wrote:
> Richard,
> 
> In case there is still time,
> 
> Thanks,
> 
> C.
> 
> 
> 
> The following changes since commit 9c23f2a7b0b45277693a14074b1aaa827eecdb92:
> 
>    Update version for v10.2.0-rc3 release (2025-12-09 16:44:49 -0600)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-glibc-20251216
> 
> for you to fetch changes up to d7e1df769910da9d832dda86b01fe1363e4f4a3c:
> 
>    gdbstub: Fix const qualifier build errors with recent glibc (2025-12-16 14:28:30 +0100)
> 
> ----------------------------------------------------------------
> Fix const qualifier build errors with recent glibc


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

