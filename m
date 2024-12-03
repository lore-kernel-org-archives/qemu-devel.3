Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D49E74AC8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 18:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIXbn-0005mx-OV; Tue, 03 Dec 2024 13:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIXbm-0005mj-4t
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:26:50 -0500
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIXbk-0004Hc-CX
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:26:49 -0500
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5f1dfb0b44dso1983543eaf.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 10:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733250406; x=1733855206; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rjltRnD0Wl74SHOHQHYkjdLRAYdSAJBoynxiqJ3QTtw=;
 b=x4BSQpGRZdvEvM2/8wyhOvMVxSr9vjPk7OSfi/QExfGTRtfCoSwGtGG10oak3W8nuB
 jxMgSi/xSTRnVncv3rEdoDsjuzTQlKgKK6Es9/nHpFNGx+OEJbeMuZb84y4XVTAJYfZh
 XYzdLkcsB/OnQ55kgZimd/+YNXqKkOaPjX4hoAAK79QffeiW6zTe6shbc5i3mTpue50s
 zuB4Wu6nedzc6TeZx6+wv2SG1jC2ptWFNs1ODYIeC7oUSJgd0+y9+s3e0DXa6H6FfKmQ
 kupxmqPG3jVCmIKNC4M67iGNfzn9I6odk3tRZkX3LzOkl7hz0LyPLw/dXZV63qf8jTT1
 TJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733250406; x=1733855206;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rjltRnD0Wl74SHOHQHYkjdLRAYdSAJBoynxiqJ3QTtw=;
 b=YLXAxZH9I2lrhzzsLdpc2bPyRC25AnV9fNoC04MUwk67P+D0xV5nDLh/EQLh3CDOLk
 AP/5128G/pEyKYAn0wjQqzttjdPtLkUsTjWYiwVe66JHIrx0I8sWjd4SZxPClDZ0NAx9
 LVomhHenOORcAMWEEC2uX9BiG+xk90QKxIidhcjEhRlg1zuntWkkDfa8FI7Oi+IPHqKE
 lo1qtK5VEe2OOC85oAvHNJ5lNQil8wGYOHb20FET1wvFbU4x7AHzKmQfYHbfcypmaYR1
 xjbjWia+zOGuTaxOcH5mhzCBWAG6Z8hKvArOi82HOyZ2ZObGWMscNm7q2ON20Y9FbThO
 n+gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3vfbm/Dy4O3ZD+GeSuESHzrIZmVLn9lzIFhWInAxLD+g9MXd4oyMB9ObNTkK5oQyLLGQ+yrMHEnlc@nongnu.org
X-Gm-Message-State: AOJu0Ywumemf2RqIzoBuAlHnAwzvdKKjXLvnV3DbNawMXsVD8wbwRLq/
 l8zOXhgJaj9/a8MKThlJbeRB8XhVACLiWffJxKntm+dQTvHCxB/8s2RFkaENdow=
X-Gm-Gg: ASbGncsiTsI+Ocqm9PX1t2kbxFh2AjWA5VrxJ5OutAVXK2w5Bi80gtvPp89oDVxEcjR
 H/dJ0i006hLUKnKrKHHsEJ0NjEtAGOx/akrYWbS1+1qKBciMyYCKw861HTEDJHA29SH9f+016R/
 RKWzfN/nFkfdKCn0iuHqhKrfjN0L02NccsJQTjreySuI2kZJjNJdpgxNlkrlCNwbKRZX7n4kaUm
 u3FlxUBPgnXWJZoL2EH2kNOhYil4J1DTId2KEyzuDjAg4Q/g59IJul2T4IikECgdhMx67hL+r2e
 SquBk3KOmb4e1uqfoD0a254ewoVW
X-Google-Smtp-Source: AGHT+IFI3BzRIGdwv2aQeXIoYBtsbiQsFLlZ96Lnlq27Slb3kYd8h4O7f7OUmtr4zVJdrORi/RV5gg==
X-Received: by 2002:a05:6820:50c:b0:5ee:d89f:1d2c with SMTP id
 006d021491bc7-5f25ad40e71mr3077615eaf.1.1733250406598; 
 Tue, 03 Dec 2024 10:26:46 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f21a4cda26sm2930920eaf.27.2024.12.03.10.26.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 10:26:45 -0800 (PST)
Message-ID: <9e878028-cff8-4fca-960d-d66e68334acc@linaro.org>
Date: Tue, 3 Dec 2024 12:26:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include: Rename sysemu/ -> system/
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241203172445.28576-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241203172445.28576-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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

On 12/3/24 11:24, Philippe Mathieu-Daudé wrote:
> Headers in include/sysemu/ are not only related to system
> *emulation*, they are also used by virtualization. Rename
> as system/ which is clearer.
> 
> Mechanical change using sed tool.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

