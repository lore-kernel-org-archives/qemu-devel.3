Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FA9D3ABEF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 09:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSXQb-0005Tb-1f; Mon, 08 Dec 2025 04:21:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSXQZ-0005TL-Ql
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:21:07 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSXQY-0002rs-9o
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:21:07 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so38844425e9.2
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 01:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765185665; x=1765790465; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7NAIU9C4BHs7hMQ6EQVXABrX7NHbV/vrmmg/GkIcue0=;
 b=XCc/k+XTskq/JosnuWRm5dp/FQW7qKXBRJRJ+K054EsDmCOK5y5hvkyqnkXBJureuT
 DzqnGVvY1KyAY1n5SQZlZinEEGA/hM/Js57NCKvyECP2LsZF7VjPqJNzRL9SzvHT4rAa
 Y3KqYB76Gmc9qyyr6JxwebMNHH7Ve8yNF0bMkgoNm92C221y1LJP5XuO57fOmSZfm6d7
 yDKpk2L4Q6oqniwWOsUPV/9VdOingAifdU78b1M1rCAANW1zXcwGWICeTgVq9shzkCPg
 X4WepjLKxrwstVj8NMDwLyr5WFU/FlapJ2v3C5Zk5PaLHkhR9ABH7tADov7hpkQlg9tI
 dP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765185665; x=1765790465;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7NAIU9C4BHs7hMQ6EQVXABrX7NHbV/vrmmg/GkIcue0=;
 b=KwlsSyqmtfWL4lfIjmyPn5jCBTq1pGlgE659gVsm54viykBwRztnUexcdkVLj0x6E1
 ny0BsHGNtuKtuYfvQnsppS0R3c9sBW6kyAotOODotv5WfK4tgS0Cg83ap81B/zn7yWz+
 6KcAHmhvYVZ7JEStWss2XiaaYo4EplAmkq5cuVGCYQ7szT3DSQfmm3Dv0ggfmtxM3Vc8
 WrSd4nxr+T0zTWGpiOmpGY7aWcsmvgDyufBhWJ3t8OPe2bqXAmoHMO3+cgZW74X2e0QC
 H+aYAuA9ye7oWY/28qq9PVOHT1+H281rUYLOXzm8REq7WYGJJqATSc0Vbx7ZuOoh406h
 F9cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiRTF6hWw5rf+KjOhxpRyyN207UHDMhGbyK6o6YcPy4NrNOVi7ZGT3g+yE+9Lv4hz0j2JiS3O1zKkj@nongnu.org
X-Gm-Message-State: AOJu0YwGu/x/I93KzN15Kh2NjjR7nu4wKW7a8JNTXbesqaGeD+7U7HGm
 FklQCGlAx71dXIUaLJ4nRPEiKT3RtCr3WGvHCDgOCvGFtqOP3WajX7AofhVKpxqVPL8=
X-Gm-Gg: ASbGnctUVuxdgNruK++NDngDo+ot7ykyeAYr6YQKupqWa4B/c/E5LuKuKAxQhr1NgZ5
 +APMx6HgCqgaP/OjPR+deyO5IewAE2GjIPisn9oyAW3IfztraNFxEYNu2Xvu7mKsoflORUKhgU5
 Vq6Jvbs1X91NKHSDgOUPAb7u1gZ78eszb9+IiRaHJQ1WM7X1FjsX1qGZN5G9TwoWsK/BebdgJmh
 w6LeR/Fm52E74bg0A5089DbbFDwzptE/CGDut+r/i0CiMlHwTIlBT66Ql15xycWPozFIkjPY6A6
 Z+YJHPLjHq3JekJhtAC+9D/S1ydXaNl5YtWXgWWDL4dm1UzynbfsHYtfPTuNHTyewSGsNLwQpH0
 Lj0UjVIUBvPhflSSNcxM+RPeM+fdYehEMlohoMC0lHi3aZ68eW/1x5o93sssHA7gITmq9bmyeAz
 ubpDEmizO3OuCQ/eiGUuc6OlCACeKLrOIaMHWk6xhHmD6o/yCc8SJJrh/okneaO98S
X-Google-Smtp-Source: AGHT+IF6LOiF1xxt7B7hcM69auQdTFgyceX0KmqCYnDTpJX84pnPI0lWMsz7uqi3TUE4aRpmBHJ3ZQ==
X-Received: by 2002:a05:600c:528d:b0:46e:53cb:9e7f with SMTP id
 5b1f17b1804b1-47939e27a9fmr69219465e9.18.1765185664822; 
 Mon, 08 Dec 2025 01:21:04 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4793092ba4fsm233874475e9.4.2025.12.08.01.21.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Dec 2025 01:21:04 -0800 (PST)
Message-ID: <fa437f12-a844-4aeb-b9e4-2e494bd50c08@linaro.org>
Date: Mon, 8 Dec 2025 10:21:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] docs/devel: Correct typo
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster
 <armbru@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alano Song <AlanoSong@163.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
References: <20251204194902.1340008-1-alex.bennee@linaro.org>
 <20251204194902.1340008-10-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251204194902.1340008-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 4/12/25 20:49, Alex Bennée wrote:
> From: Alano Song <AlanoSong@163.com>
> 
> Correct typo in atomics.rst
> 
> Signed-off-by: Alano Song <AlanoSong@163.com>
> Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> [AJB: fixed author entry]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   docs/devel/atomics.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


