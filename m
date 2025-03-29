Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB76DC36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 17:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tya69-000425-Mf; Sat, 29 Mar 2025 13:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tya62-00041V-VS
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 13:35:52 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tya61-0000DR-FK
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 13:35:50 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso22325265e9.0
 for <qemu-devel@nongnu.org>; Sat, 29 Mar 2025 10:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743269746; x=1743874546; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jiDbz2gVon6M1KKayXuXH5OpRXaHUKTqtjS8xEaYOug=;
 b=cwcYrxtEiYUE7JIV7FZUEFdtCvn+Avlrgi/B5D42EFBC/5I3NhvBkNZ0yADKOo4CCh
 isumhFYjfiGryTVjIKOR5pormv7tdgdTZhyr95Q47OWG2IwfqpJLgiAVEvDdC16IK13d
 Rbks2JZNGTq8EmImGWxsx0Jw6N0ElW+ikfmfKrUVDF4veirCMh3C2svj9mYDkhsgOH69
 gsxUWdSsnVfH5sPtpGmDoO9BHniGZ+Y1I5Ir9hBZbKs+Eb43NlcMNBpXuY+7aPhLr+U4
 uIFIbXzpScS+aqwdZLs41p4H4b6dyWyu2UCddBEhowfSbwHNGgDX16yljB8gokwjmYI9
 EAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743269746; x=1743874546;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jiDbz2gVon6M1KKayXuXH5OpRXaHUKTqtjS8xEaYOug=;
 b=a9/Oi1K41WTGhBYZPbaxUSZgR5Jk6l5utEn2APJY6RdamcqALvdM2uGI34CcRiNQoq
 FOok5R1ZEeEzuoXgluy/XcAj6UNL2cM3QTtGtauaBKnhdWknEI2mlVkzGoxOyglXrusU
 tlCS5IukI/3HFijil+JMV1tMjrQFIWNcA0Hn4tNd6qa0M3JLX2YNRGg/OR8PCf9uFwyz
 8HUJCfaXrHSDfnNg/LXeQM4jlgrO7yyzuYMTXg0NquPayA1rse+CSFlbgb0jbrEzRnEy
 t9lyouAt86OHZqwq851VlhBTLuImxu1nfAqfjY6gFzSzMTdg2bzR9AMWrRPIn+LAxasy
 wiMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvQj/NzM9Q3ErWbPMrqE80M+xXf/IOR23fXwSczhseabkcW2LqJ2dDSxWQozMmj3xHo2tAmaxr4KiU@nongnu.org
X-Gm-Message-State: AOJu0Yx+2jfQ6+u0NLSLgnM/7u1jQSL2zsFZYSWCW7WIdH/tzx06jvPl
 GGzPpv7o41fZJ8LX9lhjB5AVPaeMZ3oJDV8q4qtOA5pEAnDjmv+RdscH2iYr/UM=
X-Gm-Gg: ASbGncvb5okkKf+JzOaN6e62GVZFssrgNOcAC9LljR2+a/6Vb/gvMCaAv5MF1bhRgQZ
 a6mugOkmRSlZp/IMKl9vICikbYEisLvPX8mDTkItPn3sEoKv+NI36e4PAQ+Yhp3BjNzuNeN5Fow
 835OS/euy3ejNxpJVZtewQStgq0s23TW25Nu0rkqCrVY/vqUFjW6+qf8ssKEYfcO5U0o2XfcjwU
 X3wIpLZss79B+AIS10NyCCybDLed91Nr+EUJ2kiHhZox1S745QjMi9M2x8qy73S4yMzEYbEknsn
 VFn0btTQrZ3pTnkDLpvhC3zKgFZLOB/70VXuk+eTzUNk/bT9Q9on1+Y=
X-Google-Smtp-Source: AGHT+IGWMEzW/Cz1Eo+jy3onHhBUUAJWG/zVkL0Ew9I7JtiBkSnmbBDOJPsNEer+/vPNLvWz69DS1w==
X-Received: by 2002:a7b:c3d8:0:b0:43d:649:4e50 with SMTP id
 5b1f17b1804b1-43e7a5426d0mr17178265e9.13.1743269745827; 
 Sat, 29 Mar 2025 10:35:45 -0700 (PDT)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e0afsm6352735f8f.65.2025.03.29.10.35.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Mar 2025 10:35:45 -0700 (PDT)
Message-ID: <5e19979d-0527-4e08-a232-e2b6891b8b24@linaro.org>
Date: Sat, 29 Mar 2025 18:35:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Move device tree files in a subdir in pc-bios
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1743262839.git.balaton@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cover.1743262839.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 29/3/25 16:43, BALATON Zoltan wrote:
> Simple series doing what the subject says.
> 
> BALATON Zoltan (2):
>    system/datadir: Add new type constant for DTB files
>    pc-bios: Move device tree files in their own subdir

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


