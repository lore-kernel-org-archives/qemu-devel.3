Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8B4D38FEA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 16:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg3y5-000304-9v; Wed, 14 Jan 2026 11:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vg3y2-0002yk-IY
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 11:43:35 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vg3y1-0001YE-6o
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 11:43:34 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42fb2314f52so27244f8f.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 08:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768409011; x=1769013811; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=22ETz79dVkynmbgsp+owFkPUJPN6T9Xv3fHS7bmF/bg=;
 b=tSuMi4w/3+vMm3kS2NJ9UPV2S4teqdaSQYHd4tN9arPKv5QgAdnMWXmdde7iAuSL+o
 2jaxYxCvd37jP3Gyaxf21uiMVR6phmkKwZnK2gXiS/Db2sOAzzEeUR2adQVh6qxW7bJD
 vb0iNUf5i+p4KnA02BImv46dFMrmDm7zoeOc44bbu0iY6z1rkBJ2QBMKIZ8/XnjrIgnj
 vGWfrGocslnI4s5QUaWPoEGTWa0QZesNcdmEOkLQqDgwREr+Ooq8MUwrbIhHVkQwaICk
 X0Ful+5OrztNT6EVCphAS+GCeiN0lX3kwZQjJN81lStr3hh9czwHobAtstGyyfBlnfA8
 rE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768409011; x=1769013811;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=22ETz79dVkynmbgsp+owFkPUJPN6T9Xv3fHS7bmF/bg=;
 b=jKq1JT5hm0H6Ad5PaeNKx/2vaXu3RKe6OMtOnEZHT5Rw1jFVk0E5VzPSMo9x6rgDw+
 AHnsFOrvSqC9HqZmPQb2BDXQYSed96pJdFzcMOPnLob73guQ+YID7XHhhJLZjdMBb8bu
 YhKZL/DO6f9b+qPlfp03zAjjetSgdyKEtcFedMM4HF4vvY7OfEzT9hHL46WJNy1v0Ai3
 5ZqGVqbe4oHyEPIuBEMLIxRXiFLi8XNuTzTlc+HG+BJ69Mq/B2jlw0q/HmnXxlCsMWx1
 bCg9QadahjXzsHkCmp6bxTV10DdZ96Ry5pafggo8KlL/OY0sOAXD8+iUyxtF0KCTe0oU
 arWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIhQIFeNjkOBo95SqVB2F8gWdVGuAVcb5jbIbDnCWTaT38Cu95pmFUTLznA0OKu+H0f1VEoy2VNnsT@nongnu.org
X-Gm-Message-State: AOJu0Yxj1O1AnS1jaP/OLoN0QzkHpy99sGlrbwf7N9e1OpgCxNOPR1YC
 XgDm+sAMjqHE/1eJRefWFO7xNwYmVyoZWs5h/9zmVLgtDtiEdXu6CFFl1dp9Wb1Y5LYpLQrXMoy
 +iE3ZjIw=
X-Gm-Gg: AY/fxX5lSr5Bnyhh59nFbkuDwf0542WqWoSV1QnNsb3JEo6N5n8z7t52bterfmpOPyk
 QSJzTOdexhMTvKqxUzEKx+Lacyg+6EMcPNY/CU7WkstuWMbBUtGEQtTkck3o+1wTxBaOGcTiHHD
 IQj/Iv2QBAx3f0Dmy2JbvK2Tn0wfg0xhvdVWUPOBrqCngFOFf3/i6bb5x0cq8dwuEjQQjmZPV6y
 KZ95pVi6+4jGARW8BhbvQBegTvIMLCpXa0hpfDQScsMdZQiGyUvM+praZHUUntQKPsh/SnpEQtr
 UvRrToT5GKu1vokcOtfXoW8aK64Zz6GIy7Ge1vxxua7jaCfURknyAgfov0kF2voTLSRMuiQYigj
 tJ3Fxg5/+ivnhFhhjYHZIu/ybavuJIEy3UnCGWb24/sWqS96bwiaUeuzFSH9k4ISRsKynVJozU+
 DEhOWOQVfqhYq7RWKDRrKSsiv7VKrV1nvnCjzHELIGArQsobcmCCXNuA==
X-Received: by 2002:a5d:5885:0:b0:431:3ba:1188 with SMTP id
 ffacd0b85a97d-4342c3ed5b8mr3820431f8f.3.1768409011276; 
 Wed, 14 Jan 2026 08:43:31 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af6d8ad2sm244414f8f.32.2026.01.14.08.43.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 08:43:30 -0800 (PST)
Message-ID: <8a3470cc-1969-4c4e-9908-794fd5c5479e@linaro.org>
Date: Wed, 14 Jan 2026 17:43:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] hw/uefi: add pcap support
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20260114110406.3500357-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260114110406.3500357-1-kraxel@redhat.com>
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

On 14/1/26 12:04, Gerd Hoffmann wrote:

> Gerd Hoffmann (2):
>    move pcap structs to header file
>    hw/uefi: add pcap support

Queued via hw-misc tree, thanks!

