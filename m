Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD38C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRv3-0007Pq-Iz; Thu, 16 Jan 2025 10:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYRv0-0007Ka-PR
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:36:27 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYRuz-0003au-0j
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:36:26 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ee786b3277so1538466a91.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 07:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737041783; x=1737646583; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HVyLAXQ0C0qJ8NwejTb4xyIbJGMi6KcFy9Lm6IEydpA=;
 b=Y/M4cxs6bfQdbYRkCI+IeVUFkHqinRStaFmn+CAKxLFiBIdtCWAJ6xEurebipOfWnm
 UhTx6yON4zF6d5hAxzkVKJDI6hIq0HcwWlP5VwnoOv4WdQGiImUjr8ndTdr6yKFOhgbA
 5SFtYSauV+Eq3QUkEEO7icEjdeUFfHO4diiSmKBfhs7aF/HhOE+ems8XEvZQAML7rJwk
 89F/x/q1eAmqG70mhzdKMVeLt2p3TrliZU+JDoDvnO+hf1aJdb3WzoLFGP1a3jSl1/+I
 ujUkk0NRYmlU3qujW5pMWmF3RE1CzzGdY9VWly0zhAoxtv2EYPPRcTnPHSc18l1vusqO
 VcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737041783; x=1737646583;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HVyLAXQ0C0qJ8NwejTb4xyIbJGMi6KcFy9Lm6IEydpA=;
 b=LTDOdtUz4QLy+BAKCrNDt/0nVJhLMKCkG+vVt6qlBQcyIixakUZG8oeKqN2lPJrQ/9
 QTowVXrWqVTCBYTNa21JBHPNxSS7ph2XSSbsEfvo3nL7jgjgKeqGVEDZcw3N59XqTHTD
 kym5vJsv6MmljtSuAdBDIoiJbFsroyAfHr5J+Qw9FDiYHEBOglzkiOKLKpXinY0qi9La
 FKpsc2JKtf1vynsVQthCv3igzy61f38uv2G5aYI6PZwaAoMbf70i7H0QaeUgYpgq67QS
 lKcXUYVLp6Zl38PtEqFYmoGs7Ir3VulKN4tfukirh6ocyksD0baLG6YKNbcam/HhtNJk
 i1Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBcQ243T0wCnzhRP+ydJ2BJprqq0fZR2mGDWRo0BapucB2pmFlgWc87ZMfq9SqSDj9M5fjYXEjwc2q@nongnu.org
X-Gm-Message-State: AOJu0Yz8HPeoxFJKaRj6FZWig4hunES0j3JSmAPazgiNzenATkhW/b4P
 bs2MqEmDcElsILlG0o8JtSYIkeniDWds7LyL/xoe7AfuSbk9hFRFk/KwlNAEFDiCRkBwswAMOYi
 o
X-Gm-Gg: ASbGncswedpSSI28qnOTGTo1jwJv50fftuMIjLnVM8GYWzFjqI+/gjha67e26+he6ce
 HVg/qcUKVneXNM9XYl2dinyf9VE9x9Uo1DyrBubO9nQJPLM9tKg81z6CvxaZZHOV1M5LE+jL7oQ
 rZ4ITfM6uahr1QL9cGIEZXUsZp7CulsPnBlVLH7tGUKvd5BkIt3tcLPEix3F/FUc8t51iFmiFDb
 VdJbosK/oO/Xi0/ghZ83Xc2LeP5JQqSJx6PfUx1C33WPPb0auCKKDiN67Xr7Ie7COkUCLWinta0
 sxBzjCrvZhnWt7fv6HbMpoc=
X-Google-Smtp-Source: AGHT+IHLMZ7LJQKt3dtQF1jjJCAxEHgSATwMMdc0EZLdIgvXEcdQafsPAqLzXIDvK6S7CGuWY+mQ+w==
X-Received: by 2002:a17:90b:2f46:b0:2ee:bbe0:98c6 with SMTP id
 98e67ed59e1d1-2f548ea6488mr47948247a91.8.1737041783010; 
 Thu, 16 Jan 2025 07:36:23 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f72c14ffaasm3468756a91.4.2025.01.16.07.36.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 07:36:22 -0800 (PST)
Message-ID: <09f20e10-04fc-463c-890d-9fb28d57499f@linaro.org>
Date: Thu, 16 Jan 2025 07:36:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: Add missing /proc/cpuinfo fields for sparc
To: Helge Deller <deller@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
References: <Z39B1wzNNpndmOxZ@p100>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <Z39B1wzNNpndmOxZ@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 1/8/25 19:26, Helge Deller wrote:
> Add some missing fields which may be parsed by userspace
> applications.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> v2:
> - fixed cpu name and type depending on currently active CPU


Queued, thanks


r~

