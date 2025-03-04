Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A5DC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 23:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpbqq-0001p1-Ms; Tue, 04 Mar 2025 18:39:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tpbqp-0001oW-3O
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 18:39:03 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tpbqn-0002X9-AN
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 18:39:02 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22113560c57so117543375ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 15:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741131539; x=1741736339; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DEEWjiQbr8uOzvWkeTTdYqoPdX00N856DWEpC5Odfow=;
 b=spZWRw8dZUiABuTlVtgGevPqbM52GlPbCEengGLwTBafSu+l9iyPnaZF7EEJGvOkVQ
 0F1fJrif2cLpoRlE/WiqymFBYEsL0F+uL0tYMDBg19TyhKbPKrlPThAYrtacchzZC8dH
 v3e1MU5aJSqkSCM7166ni3E9M/4Z9U5GZ981SySv9EqhyXcpNH7DB/y34b6gZwwQaJnY
 jvxaUwrhrMYCN1mawpHiuIs4d+WhCzAaRzYB4CWscVr6v7wRKWtKaQvwq6ZOFNF6yRVM
 kHbBC+1nopQ0M5rcEhzjiVJZXu0B/MtvwrPUCEXBQNEJFx6UxEgaL30Bu+ZX39VjPr0+
 to9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741131539; x=1741736339;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DEEWjiQbr8uOzvWkeTTdYqoPdX00N856DWEpC5Odfow=;
 b=kCB5ztj1qMsLPXRbk4e5RwBAR7mVbhZbGpf550XRg0Q5qV7eSMElxuHGF3dta+qIq3
 uic3lUnbFeHB6Jz1vKolOY+BnQ/bVapv18H3B9MSoPBPdbdKdLZHh2B+dOz/K3sdnHad
 U3YjUdgXKit+6Hm+qUxmoeQTUggJ9jCCFSMbibM2AY5tKw5nMwAhypvh1LBlGzgcXPna
 PV0insdaiVRZ1tM4CtkziFQ+3W/5oL/1T9w/GA5CW0rhO8BzixvRzzK3txwIgimC195w
 ED8KQlSmo0rd4722vEGVYc176fSMRQC+52W2ImiyMUHYS3I+DiLTeDEMaAjASdCrMXAx
 2HKA==
X-Gm-Message-State: AOJu0YzecV6YQDssMI6jIN3oEVcPbXejdhBkWbPFNtlWAaMDC+SQlAcy
 ok6Y8lmZ414yv5r15S17+wePItPlJXmmVu4/ZyOUwP8HD4AUZB5CZQGFvu7P9T2sWLkBiEUk3Af
 p
X-Gm-Gg: ASbGncuAFpEZhJB5ZtmBK4Pq4kSRitV7AXy/KVJWTh42kdc18XtdR8IJ0Kn05eOR0Fz
 +lTpaooXd5Al49TghOK/MNlZ9zT9EEia8xD6S616c+JwykCqe70Hv8BFAJAOszkbGplOzZmPUt5
 6hjA0sWkYeGTIG7kouJyIAjtYcpKW2OLovl5OvxWsbct6/+F7rdHKWkxYDxZevbaXqE4nPpTJes
 FIC5Qk+YK/51iP+4CsJRAz6c9D6BaG8DtcaY7YMt+xg3ZJbipIEKbOl4Pn/wBUVjSRnxCRrWekK
 08NUnHmIrf8kJ85VO3Ywa2py5J+WbaQXnLlFvqy/Hsm+TTe8tbjwh4Xmgw==
X-Google-Smtp-Source: AGHT+IFf/dT60DWsP3uvp06Nk2qc0fXHUxl9K1fIo+Y5Dq/aVvNte/172u2iJ8rOvNVfDcHFb0fmBQ==
X-Received: by 2002:a05:6a00:3e11:b0:736:3e50:bfec with SMTP id
 d2e1a72fcca58-73682b7338dmr1258462b3a.8.1741131539471; 
 Tue, 04 Mar 2025 15:38:59 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aee7dec415asm10784535a12.54.2025.03.04.15.38.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 15:38:59 -0800 (PST)
Message-ID: <7544439f-473e-4e1a-97e8-1c9900c059c8@linaro.org>
Date: Tue, 4 Mar 2025 15:38:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Windows plugins MSYS2 regression
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <cc07f761-4c89-4eff-96c2-00ba54633634@linaro.org>
In-Reply-To: <cc07f761-4c89-4eff-96c2-00ba54633634@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

Hi,

the issue was identified, as a change in ld, and needed changes on mingw 
side (see GitHub issue for details).

Meanwhile, for anyone using MSYS2, it's possible to revert this change 
by downgrading binutils, and recompiling QEMU:

pacman -U 
https://repo.msys2.org/mingw/mingw64/mingw-w64-x86_64-binutils-2.43.1-1-any.pkg.tar.zst

Regards,
Pierrick

On 3/4/25 11:50, Pierrick Bouvier wrote:
> Hi everyone,
> 
> I noticed some time ago (between Feb 1 and Feb 3) that QEMU plugins
> segfault when calling any API symbol with MSYS2 in mingw64 environment,
> compiled with gcc.
> 
> I reported this to MSYS2 project [1], suspecting a faulty compiler or
> runtime update, once I could identify that it's not a regression on QEMU
> itself. Indeed, older releases now segfault as well.
> 
> Recently, QEMU enabled Windows clang builds as well, which are not
> impacted, so QEMU plugins are still available this way. The regression
> is *not* related to this change.
> 
> It does not impact upcoming QEMU release, as the problem is not located
> on QEMU side, but is worth mentioning in case someone would create a bug
> report for this.
> 
> [1] https://github.com/msys2/MINGW-packages/issues/23577
> 
> Regards,
> Pierrick


