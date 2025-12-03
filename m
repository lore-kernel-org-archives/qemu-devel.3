Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37BCD12D4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 11:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQlQl-000834-M5; Wed, 03 Dec 2025 06:53:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQlQj-000821-VC
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 06:53:57 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQlQi-0004Ll-Ft
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 06:53:57 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42e2cf93f7dso2707508f8f.1
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 03:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764762835; x=1765367635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hQHNPRh9myThNQh0yjqSvFuq9dLmY4oCQUZxr4Wllec=;
 b=bg0PFGNLXDcuUxyE+wr8+FYdBDRr3IdgKaSPbXNHgzu8agqgiquK5pqdM74ZpPs4Vd
 B3B1wsoOzCfeuXDXA5JyaLgLL6uop2cIvjeJaX6+zhLtw5PkE0FVF+Z45Onb3wAfpWcN
 FLpdEWsrrL42sDmGKb3e0Xstd/DOKODtT31eSynn8Pyyn+kdWphaQaFNT2CLt78LadYh
 zYkrM8oE+D32pRjBtoVp+TJnrlUayA5lJd76z3DlKoc1yLnMVQrRl6t/BxmgIyZd5qic
 X94/Efd7Y06bT17Tq29idWqclR6qa8NHf0pqRJ4+nPUPYs/UKYK0czlUGEKlXMw0hnZO
 f6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764762835; x=1765367635;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hQHNPRh9myThNQh0yjqSvFuq9dLmY4oCQUZxr4Wllec=;
 b=bZRdn+Wiy7wcPWUMwPyOS6VeZ3c9H00Jswgx1v7wCTEG2ywxOyzXyUdeUNct3LPRcY
 657K9oRTLSmkfo3usewLBqzaDplgf4zIMr3NtIK2Q3qUE8JYFCLLHEDlh1d8SOa3d/6y
 Gat5EtGkIPLyR5xSHfBmT9KmeMuZhtIOPW/GpRnnWFFGrzSgVPZrFN5DDw7/6jyuw/ic
 VR8UiCcw+NDHp9fIihtVroA2feaKjSM7pFQPG3AUjneTDQCNtS/JCrBiC/Tmz4MAe32s
 yhS0TZou0j4rJX5kybMJssqPUp/hLqi/VBZxpoCtffxP7C4nTkP+ucxsnMb2/vqGNNv6
 G9fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/rvqH2P9jengt5xLfdYzV71CS5+l/JFZJObrxG3/kDiQ8+UeshtHSpwxWeBhUL9xYLcIVl84Z7s7l@nongnu.org
X-Gm-Message-State: AOJu0YyQuHGXxi7c5McYDJjDhJR8Gctp2gnjcJameGLFLHsA9zQzqHY/
 aaad16hRxyVgHKrZBg3szQLCIKPdJTv9Oj7XKe9rQ7YOsndkQWVMWZ28iqy6ywxkFcU=
X-Gm-Gg: ASbGncsNipgXuolBYJ4d+rKMufjfotmjuw3KUkwxHiQKQeqS9eE48qQKA/QdkVsYAa1
 lEJ5V1lohsi94LIRDQpJaGQPEZmpA+9FrxS5MUJCoW86mdDqFBxdxr7DhG00YE9f1mNBlLDNQi+
 1/eNUw1kibexjHX/OUkUsZ43D3kwlISefK30JitQHWXO0J4J3Nc8UAq8Lx26j6xOlEXsWTrTYpm
 z9hlSEkKalGCxFRiDhyoCwomXwdRQr8VHhrnWLL7MYYQFkMice+xjvSkKUBC+JzAnmCd7Dq7JBu
 Nr6mZqSjExbmBSlLoV3R0DopxzreezWckpsfH+z+FPXwzrA+wQ3WoqJA0dbsgCG8fULTHTDPIlk
 EThS8XHnPRXNLyVTKMfEv3+lpxFi3kvhHJy/xZHXzGmyjhDWYUL7X+nqof02tNO4wQo5VQ5hwYc
 N3rGnknYJIdF43WUTfNvys5DKbmZGgGmtfDWN+OytQ9eUMB5pdjVj5Sm1VYSwMpuP9
X-Google-Smtp-Source: AGHT+IEwA2D5a4lovf9Rt05xknad08uDjkTCx4OKuk9wmgyasA8JWgbNQmrpqKo0EKMjDHOA0Hx87g==
X-Received: by 2002:a05:6000:220e:b0:42b:2e65:655f with SMTP id
 ffacd0b85a97d-42f7317da33mr1827313f8f.19.1764762834764; 
 Wed, 03 Dec 2025 03:53:54 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5c3022sm39480969f8f.4.2025.12.03.03.53.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 03:53:54 -0800 (PST)
Message-ID: <88c37ed0-2e1f-4a6d-8032-f153309eeaac@linaro.org>
Date: Wed, 3 Dec 2025 12:53:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/14] riscv: Add support for MIPS P8700 CPU
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
 <d11d7f92-d992-4d4d-8456-707cf42f93b6@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d11d7f92-d992-4d4d-8456-707cf42f93b6@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 3/12/25 12:24, Djordje Todorovic wrote:
> Hi all,
> 
> What is the status for this? :)

Series looks OK for being queued by Alistair (RISC-V tree).
QEMU tree is now freezed until the next release (v10.2.0).
We now all wait the tree to re-open for development...

Regards,

Phil.

> 
> Best regards,
> 
> Djordje

