Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AA8C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 19:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9r5X-0003oA-36; Tue, 29 Apr 2025 15:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9r5M-0003md-AL
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 15:57:45 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9r5K-00066X-MI
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 15:57:44 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so6626263b3a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 12:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745956661; x=1746561461; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ajI0pffcCD2NgnCBDC6qvjxGhr9EFlH7LU/Hm9VINtY=;
 b=HkVI9J3s+FhcMwKifhB73LIb9WsGKa/HhNDTXY6lqDAyJPelYxUQMIMzO6iGrjFtUw
 BxbP0zC1lfSRt9f0zCOLrgwraox/UdzmtVHPSAPleg6ELwIYSLfaYVrb9Qh1/j4PC3so
 RtMvpIMsE1OQ0Qf0FRVwbGf8Qa3ehWztNDLJQem8+cLTR0gWRUpdYM6e7K00j+3wd8GP
 0rAVmr+RE7S8a8EKDkwa8tr97+pobJ8SY6ucZLHmun2lcORUcxCOSEWvUE8mzHRjMjsr
 OCN14OnrW2m318GuTOcvdaHCqCEsqWthsqrnwbqZGYjU1K+/qbMGfeKK8sgNruaKvWRh
 9G1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745956661; x=1746561461;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ajI0pffcCD2NgnCBDC6qvjxGhr9EFlH7LU/Hm9VINtY=;
 b=i5OlgPJzNA2RZFio1bzJrAU7WeSG84kzRW1pt3+XeewyMjiI/0WrDn3nipMazOLcO0
 81cH92urZamCLFS1EVCy9+957nrMkb7mPEZ5LKAyqk4zXKIyfmmOPXlAWDy9eueG7Iqf
 0rLJBmiar5pi7QZQMJpKcbzYTVaHlQxt0t39P7YX9IfOAdad0M38YKYQJi56NdFeEtNM
 XyuxNvkICve7nxcKiB3s1KRE9Rj7Bud28w+3DdA98Rlw/yAySzJ/r6D7+XZuY4KWcWVy
 hraSbfGXLrSl/tra5iVfYEfjXGa8dhpryLPJJcVznByYd0BNiAgY9ATsevH5rUOUeSmL
 nYMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq24CamKtpfQp6xQEiwMYHZqGSSPAwX8HUJM5L0elZuboP+Q10ETkyng+roxPzkdmncNx3zeU2RHeZ@nongnu.org
X-Gm-Message-State: AOJu0YwitrjmBqNzKttet3x0Kjf6+FaozoqXS59P9Xo6JulOZxGjC7+8
 koEYTD7o3OYrA+J9qPJvIwhyc3oXg3rT83z8RjvTFLKCP+QbYtglyAcys+l2PCA=
X-Gm-Gg: ASbGncvsmO/yMPE259A/kL1btT9jTHQRptB1zuf8zTPB0KicKaVNY64cMoBshwHjxEE
 N7BOzGe6bUepRZGhzeARq1okunRqrR0pA1WKq0kqIo38A0lLKvsyrXaX/xGQnzG4k6BBZEW2ykB
 G6YRO/fpshvpXWbbtu4nMM3630hzXTI+s4g6IS+80BM47lB6TVAOhroPb8xlPQ/MjecRQidf6m4
 W8Ylgow/9ZflKGUZJFZOlfpTHwedyMhd4UMPShxjmwLee9TE1/KNbsjUU+qvpF8sTphrflabAqt
 GBvUtsbetCsfAL7V+kl/Pw+zCENAitwxa/PHg4e749amEWptn957Jg==
X-Google-Smtp-Source: AGHT+IHxT2h9BH1xDCmHU5N1T83lQiOLHRIA8/lCVzMwwYU8XSTLtT1dsrYsn/W8nGH6fwqBuVn+qQ==
X-Received: by 2002:a05:6a00:2d0b:b0:736:3fa8:cf7b with SMTP id
 d2e1a72fcca58-740389cda1fmr668420b3a.13.1745956661011; 
 Tue, 29 Apr 2025 12:57:41 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740399209besm83108b3a.58.2025.04.29.12.57.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 12:57:40 -0700 (PDT)
Message-ID: <41c2ee8e-d077-46c9-8106-e979e7cb80bc@linaro.org>
Date: Tue, 29 Apr 2025 12:57:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, stefanha@redhat.com,
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 peter.maydell@linaro.org, thuth@redhat.com, jsnow@redhat.com,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org> <aA9ChuXrkmx1Igy5@angien.pipo.sk>
 <8734dswnm3.fsf@pond.sub.org>
 <2cc27344-8cfd-4435-9d41-79b86f61d537@linaro.org>
 <875xinnzok.fsf@pond.sub.org>
 <ae321f41-9405-4a6a-915e-969303c08d9b@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ae321f41-9405-4a6a-915e-969303c08d9b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 4/29/25 2:35 AM, Philippe Mathieu-Daudé wrote:
> If a distro wants to name a binary 'qemu-kvm' it can drop the
> -target option and hard-wire its target_info() to a distro-specific
> TargetInfo implementation, or &target_info_x86_64_system.
>

Having updated my Debian stable to next stable (trixie) last week, I 
noticed that qemu-kvm was removed [1].

I don't know why, when or how, but it's just an example that things can 
change, and people can survive to it.

[1] https://packages.debian.org/search?keywords=qemu-kvm

For the concerned other distros, if at least one packager asks us to 
provide a "./configure --default-target", it will be an excellent reason 
and opportunity to do it.

But before that, let's first build this single binary, let's see if it's 
useful, let's see how to use it, and eventually, let's see how to 
package this and cover corner cases.

