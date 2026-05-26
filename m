Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5A6CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 21:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRzdc-0007sA-Pv; Tue, 26 May 2026 17:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRzda-0007s0-JR
 for qemu-devel@nongnu.org; Tue, 26 May 2026 17:48:35 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRzdY-0006cv-Mh
 for qemu-devel@nongnu.org; Tue, 26 May 2026 17:48:34 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43eb05b1875so5895755f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 14:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779832111; x=1780436911; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NkxC3Jy5820gswRM40t3ICpf4xC4ZYOyyQPXnYANvUE=;
 b=As6PAR3nSR6PB46FuJv2vho3V8uXq0MwlrTd5xI+b37uqk26wO3M/XvDPQfyRZizsk
 KwSYqa1nZe2x7oNePliYDnpwhajPO2yxrcxV6Zzwn2CnhB/a2La6vJhJlDq8PhtXZBYe
 HjmG1NkkqVlcW6nd7P89LvmXKumC+XB3KywxaI4Sy8pksZOKNzlU+J6iSruVbedgVJDo
 u+PHPDg9qNoZf+by9MqpHPLA0ooYPUQa8duh4xZHliU+vtIrnhGNBjRA76XBD+7RIMLa
 toWZeqInpA2ixJAWfpG2ZI1JWEWi/nDJil6fzqb9kin/Eubr7k0RxzwDKmvGibF/m2eN
 jLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779832111; x=1780436911;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NkxC3Jy5820gswRM40t3ICpf4xC4ZYOyyQPXnYANvUE=;
 b=fWnG+vqB24wQJD/+TZwQ7jtrAZjLlbwftdnzuEok5+cDb8ZdW4qw22GgsC8XyqQ52O
 W6DucocbyZ84PFMO3LQR/bZ/U9Vk145LQV/KU9qYT9E0EDEkwp3Um0EdNGzKB91eIt+N
 n1xFCvE7xBprUxtOFVNMfmR2x2M2Y+C17XnUImuam9HYf4gLHWMykjsoHUMnc19IIU86
 WTr6HMZO58QpF2eRe3MRJBKLA1MVMaYhgGd+40DUmWg4j3TP456/qWD2FOQMJN1fZ7aY
 W2ak5ssYUAa6lLjh128boHjvOV9Ra3MY5gmzNvQg32YNceUqIiG0nRHN2eFdM350gyeC
 QHRA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/mDqvHpGeiEDAu1DCfUL0ppWnRdGDtr/SYDWyAf9OCX0QtuWFFPxWW3LUAOG2B8ZdzJMhbaKe7dnGg@nongnu.org
X-Gm-Message-State: AOJu0Yz1XOqbcTmc84B23x7yBPiX5eKQWqk1APH6xz+TaOBj1UFdsD/P
 J025iLKMTReQAzhPMlxl+NJCU1QSjTD2EsWUKiL8U5jzD50FT9lSWpxSgzX/QIrYrMg=
X-Gm-Gg: Acq92OFOj2xAqk3E9RwV6dxzYYw3P7TSIdPPDkntvi9mssqDmagpJTKrf7zbXHjAqwh
 EH5x+1Uc0qL6UY8ivonQQ2N7NwdFuOiaDLqsqAfwtcNW/6cjjoxlLv+Pf8AuM2u3/Iqclm3kJKu
 Z4Qb7Exw9oeRJqeEeRzcEEIngl1Q4tXWcYxfBp9LjDXNzirEFoTB3Hf6M9Wkm8Cy5Mbh5DxRt0q
 E2Zy/PRR9vAAY527pOFmEV9I6WeyqHpBg3WWelXlK4qDE3WW4woEi8Qt1Za300xshGHCdxJopcA
 569A9hszY4n+Fb+1YzCXePb4rTTJS56trvVE4gAwEGMr3RD1yKhG8NivxTBgKyvUEe1C4mbG2YD
 Vzf/ken8IdE4qLIjbiS79jKzG6Bkr5IGJQQnG9SRlvhl+iwek981nOa1ImYePgLUsQNQl9MfoOg
 sYDqlKM19b2qz4ft4ula+SXNLG3Zcp8qqNhLL/2eslMVf5lLkfumkdW1z/phRt4Mrnz37wBxcRY
 X4H
X-Received: by 2002:a05:6000:4b01:b0:45e:cd0a:b06a with SMTP id
 ffacd0b85a97d-45ecd0ab0c4mr18142015f8f.26.1779832110744; 
 Tue, 26 May 2026 14:48:30 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5c2323sm1166485f8f.34.2026.05.26.14.48.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 14:48:29 -0700 (PDT)
Message-ID: <9d64ac0b-607e-4680-9753-94bbf1990194@linaro.org>
Date: Tue, 26 May 2026 23:48:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: on ai generated and code provenance
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <f0bc9023-28c4-4685-b0cc-fc7ad4e6d371@redhat.com>
 <CANCZdfrn61yr5k=3=E_zE11dw3j2vVsg0PPn0PZ7RAa2agM8kQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CANCZdfrn61yr5k=3=E_zE11dw3j2vVsg0PPn0PZ7RAa2agM8kQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 25/5/26 19:15, Warner Losh wrote:

> AI's primary issue is verification. The folks being flooded can't verify the
> good from the bad in the flood and tend to have a knee jerk reaction to
> protect themselves: ban it.
> 
> Unstated issue: How do we help people that want to contribute grow their
> skills using AI so they make submissions whose quality if good enough to
> be worth our time to verify and review. It's an industry wide problem, along
> with how do junior engineers become senior in a world of AI doing the grunt
> work they used to learn from.

While it seems easier to start contributing with new code rather than
contributing reviewing code, I strongly suggest junier engineers to
start reviewing before posting patches. That would help to unnarrow
the maintainer funnel problem. AI could help them there too. But
maybe I'm opening another can of worms by suggesting that direction.

> Warner

