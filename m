Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB31DC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 16:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twkx5-0008CZ-5C; Mon, 24 Mar 2025 12:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twkwf-00088w-Nr
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:46:37 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twkwe-0001Jy-7e
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:46:37 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so3949624f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 09:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742834794; x=1743439594; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0vAzguKoUlaqukb3a5bBrPgEoer/5AHQ4RTT+MsA2MY=;
 b=ZEkEw13GwMEaSbIeOoLcqL5nKiCWTsV4VcFjtw2QSDnWl+f782HEWhVbIMYJoFafl+
 dj99VUq9NAhCqTtpgI+GQwlECs5IdmLc+4tIIIHP65caadl4F+SuXQEN9KIGfLlNQFqS
 iJKc00YgDPIpt7S8HOJnd0Ou7kyKxKgVk6mev7hIXL0gcfaJxoJ419jnIgeohVAfzy+S
 FUs34/LyCeeMPIW2AwPH77p0II3TY0ywFIUHm0ulhWdKNgaVtOpT+4+Hogalcp5KzdR9
 SETn/y93/HfoD6xi3xGV/GU9XSOwtA6WG+kRogGh0kdvJf9fYVZY1jgmmN/8G1LtnzUO
 eEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742834794; x=1743439594;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0vAzguKoUlaqukb3a5bBrPgEoer/5AHQ4RTT+MsA2MY=;
 b=oPIgnoAD9Uz6RbF4UyuC6e+Dn8Wo8e2CrL2aK1jqDRiUnE3PbDb8oC6CTBxZcj4Ulg
 GSNk683c6p/u2EnmjonwnWK6UWbMGJxYqOozfHMARpAECkrddo14JTfZgs2Tsv477LdW
 WpG/SLMiAGNz2cj0E1uwoBN5KJMi6iu+S55Q41PM1QjAXiWiwYzBZR4zDUlrmoyKYji7
 rPhd1Pfq3YiYYuWfoIyE5sljna5OERd2P+CmKHKRtU5uZ71Qe+OHQdhjXHRH7X1OiwhX
 DVcRxevfFO9H/xemvlGtkM7WY16TtEzOTpjjFAv8XfH3OqZK4hhaJnyGvq5t2P6ALSP5
 h7Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8htasM7ulQhIS2hV/c6NxmzUAOvMuPen680c/99oOaUwmjp9h07l6zUufqw4+D2pHhwfNfY6rR8Kk@nongnu.org
X-Gm-Message-State: AOJu0YxM6ZAWNgdlksmEID9xzCAWI5Ycu0mWduPCrXXy/4XTjGt/jyrB
 GPGI3oTB6GwF7ywlpFqqaP44Nmpk1WpWov3/zKcjUePMTTouSK+gxiCSeJN+Yuc=
X-Gm-Gg: ASbGncubG/zCeyLj8CIZsMOEzUyTgEE6KuMufsDfeCgEp3mt5PVMLHTEeEK92tp+lNW
 B/wUl5Qdr20aN6Qns02RyZWP3OCTyuB3xFmCBNcDfLpJlmWZF/v1rADRsruigfA7y+ZV900rCfX
 BXobpE+sB+r4J5/wFdMDUPNcMw+Hl5ebgjwFyarvbGI/ysdk8j4Gu+4haAY5C+rE+Bu/3x8N/WA
 a9cB0lFObwIOd4O/kxANB5JW7xC3rAfkStckolG3sZ309uQ/THmhGMJvDpgqP9WdkHGP/mIWRBR
 7fyofZKZqDIKqfqMrxFljseGayOtpxnuTmZTmuUaUgOtgHpqehelVB608HI8oDEMcYd67gpV7a/
 7qDNHoknk7Sgdz6yMpg==
X-Google-Smtp-Source: AGHT+IFa/QvSiWwk60KYmLR44qWmv7WRDWhcq3tOWBTYHwDtIZzipKGkp/SRYYa4Q1nBKb/vX32/hQ==
X-Received: by 2002:a5d:6c64:0:b0:390:f9f9:3e9c with SMTP id
 ffacd0b85a97d-3997f910184mr12312616f8f.25.1742834793665; 
 Mon, 24 Mar 2025 09:46:33 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9a3f81sm11637654f8f.35.2025.03.24.09.46.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 09:46:33 -0700 (PDT)
Message-ID: <729ee2cc-ecaf-41d0-afbd-25f51952dbeb@linaro.org>
Date: Mon, 24 Mar 2025 17:46:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] include/gdbstub: add note to helpers.h
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
 <20250324102142.67022-12-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250324102142.67022-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 24/3/25 11:21, Alex Bennée wrote:
> We've not yet deprecated but we should steer users away from these
> helpers if they want to be in a single/heterogeneous binary.

Why not deprecate?

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/gdbstub/helpers.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
> index 6f7cc48adc..9b3a535b03 100644
> --- a/include/gdbstub/helpers.h
> +++ b/include/gdbstub/helpers.h
> @@ -2,7 +2,9 @@
>    * gdbstub helpers
>    *
>    * These are all used by the various frontends and have to be host
> - * aware to ensure things are store in target order.
> + * aware to ensure things are store in target order. Consider using
> + * the endian neutral registers.h if you want the architecture to be
> + * included in an eventual single QEMU binary.
>    *
>    * Copyright (c) 2022 Linaro Ltd
>    *


