Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7422BC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 11:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzDCC-0003yI-EN; Mon, 31 Mar 2025 07:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzDCA-0003y3-JD
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 07:20:46 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzDC8-0005WK-Vc
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 07:20:46 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so27037075e9.3
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 04:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743420043; x=1744024843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w3y5HdCfApOj2BAeh4w248vwX3FXmLG55TM8DM6uuak=;
 b=OrMKXQUm6IRijKJjKyAQLt+llpQqFf81Ts3HcOoAeEbgpZVplMo8OkkUuBIyj2LEzZ
 EZ0vEnQuAncloGB/LAmp7+AVyA8Qqnsl/A1Tml4kgnMdzJ2bv8vAQmx+2GsFyycSsNHm
 KIKWRtkGm33TsBSUxKQrQRM2VjLJLZYfT395at5c4WY/PM10hgOdPTKZIZAa/JXhzkgi
 F0c28M5EpTd1Wa0bl8Nyo/eOsZqx+7ZnpU8oMPuF7ZzFiMcAuWB0CLDiZFAJP+cZqlI0
 rbtFhJbPkvQx81ZrTkZEMCnU9zO2ijGLBJsa6jnjwbkIlmrTEfR+daDCgTgZg3W9hMnx
 P3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743420043; x=1744024843;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w3y5HdCfApOj2BAeh4w248vwX3FXmLG55TM8DM6uuak=;
 b=Owe6XuOAam6zd02ndtUuoc+ANclIuDMSKj9Eo87DI7EAc4VxR/MMbOzEPaOUTBXQef
 vY9t6sCuJyCaWnRfhaXqdUU7OGx5f7f3h75ZMew3cFEbOkJofrdd+cqhhYxuzYaQHIQq
 QhqEtS7gns0CEiLDZZbb7y+QaFqx7gpBd+vcXYDT7kBijrZtznD6lwXE8/Xj2BoGYcI/
 15KXChy0fw81FZWGdNcmvS1yS8KkmYQMT25a3ThtObY/GvMdSaYdWLM/cwsaq2fuLQYp
 w6sImAVxl/lHxsrMfyMXKROLw0JfAsgMF7xrmbwUnTUtHtEdCRiaEgrdgi7mpsWHDnVe
 +kmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtlFEJi3Ul61CDCtCtZPxly53oJVuhO3sriMiSnpFipROlCYi5ZjJczkbglpmDT2Jg3AUkpDAF861N@nongnu.org
X-Gm-Message-State: AOJu0YyAFhx4rB8gwLY1s6qZ4qK/cdzkjIIhlUD1p4vb9afQMI0qm/8h
 dcQZ9mHiCBQ8mlQQ7bxGKQDVt1mKfRpuJZCTjzBmivuBCQV7r5OprVZPMs7iUyn80vHIXtZ0vKB
 6
X-Gm-Gg: ASbGncuwLh6BTRKOfpfSQuC1aZeMxsXmcjheIx3vaLtIYtFqh7TIoMZDKQC+rSlWGIq
 AnKGGOjRj6qsrbuDCNrXIKjtPwEU5/9fZmTexMCAvJxOhv05GESUGs3qMlo1m6Dm+tbc8T4lfQZ
 RDhvVh7QwSkvkZMsaULsemGDFXkFDh8J20xej58xBJVXusMSbj5nZG9sh7bBEDyiCIfX7twnG4a
 2xhANbtQaFtYtjkTrKZmQEVbsJrBVuOEAlWysL+KKayRWDIe80DkGRNZPT52plhyotjhOEEsns8
 B5dumGU/PPwwzS81oILPjziSFw0NaStRii1CZnOjFTeG2WtH6YCh9Q48+xKZU4ytECVNBbWvOVr
 nk90qDjU9lYfk
X-Google-Smtp-Source: AGHT+IFHC4TXxtvlk93gEfhmxF9h0fTb5e0S+rwoE6asebrtxfUoDd+VMZ4Mg0G/TnIBzEmmzqgEbA==
X-Received: by 2002:a05:600c:4fd4:b0:43c:fbba:41ba with SMTP id
 5b1f17b1804b1-43db62b583fmr60042965e9.28.1743420043336; 
 Mon, 31 Mar 2025 04:20:43 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8ff02e75sm118637395e9.30.2025.03.31.04.20.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 04:20:42 -0700 (PDT)
Message-ID: <cbd18e0d-e230-4a88-b097-0248948362dd@linaro.org>
Date: Mon, 31 Mar 2025 13:20:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/scsi/lsi53c895a: fix memory leak in lsi_scsi_realize()
To: Zheng Huang <hz1624917200@gmail.com>, qemu-devel@nongnu.org
References: <73cd69f9-ff9b-4cd4-b8aa-265f9d6067b9@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <73cd69f9-ff9b-4cd4-b8aa-265f9d6067b9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 28/3/25 04:21, Zheng Huang wrote:
> Hi,
> This patch addresses a memory leak bug in the usages of `timer_del()`.
> The issue arisesfrom the incorrect use of the ambiguous timer API
> `timer_del()`, which does not free the timer object. The LeakSanitizer
> report this issue during fuzzing. The correct API `timer_free()` freed
> the timer object instead.
> 
> =================================================================
> ==2586273==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 48 byte(s) in 1 object(s) allocated from:
>      #0 0x55f2afd89879 in calloc /home/runner/work/llvm-project/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:75:3
>      #1 0x7f443b93ac50 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5ec50) (BuildId: 224ac2a88b72bc8e2fe8566ee28fae789fc69241)
>      #2 0x55f2b053962e in timer_new /root/qemu/include/qemu/timer.h:542:12
>      #3 0x55f2b0514771 in timer_new_us /root/qemu/include/qemu/timer.h:582:12
>      #4 0x55f2b0514288 in lsi_scsi_realize /root/qemu/build-fuzz/../hw/scsi/lsi53c895a.c:2350:24
>      #5 0x55f2b0452d26 in pci_qdev_realize /root/qemu/build-fuzz/../hw/pci/pci.c:2174:9
> 
> 
> Signed-off-by: Zheng Huang <hz1624917200@outlook.com>
> 
> ---
>   hw/scsi/lsi53c895a.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Queued to hw-misc, thanks!

