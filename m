Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0A5CEE351
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 20:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLSGA-00066m-A9; Tue, 18 Nov 2025 15:25:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLSG7-00065a-AZ
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 15:25:03 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLSG5-0001iQ-EL
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 15:25:03 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so37378355e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 12:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763497500; x=1764102300; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lVLwJhZi1LMDqRi6c0kogsVRnq5JeBKZpwF1HGFSb+o=;
 b=gm+yc0snM1Ml1+rHmUOSDTMx5FcBTwr8DPdViYCrVIWpd73bzoVcozgIZDwymzRgfN
 0xaO5nfgHPfmOmwwx2NRTDAhsF0GIlVUCcbVuBikxFu0qxoMD64vQMcBS1+S5BTTF/Xs
 sCvBlvsVl2AdVY0SvgzI9BjBcg5OedQIj9KwPNKhzp4ZOXDd2NTpzNLeqUloSxGfho3r
 LuhutSSHE1DAAcPcgdu5lYWX9a9rZrHojePv7n8cjp4I6g4CFPSR8Ctt5oAf8C0cDVZz
 uxTXnv9YomBVrOvNI+7wfLZnJH1G+vC/x4F71t22NAepcpBtBs96utxeFBOLkunEPh8E
 pFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763497500; x=1764102300;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lVLwJhZi1LMDqRi6c0kogsVRnq5JeBKZpwF1HGFSb+o=;
 b=XlamWFWssDFYeefVR5NV8IxirYRvF7stJg1OtIz3wug3y9YimuXAJFn3vNEksJkqr0
 dfVdu7l4aexSMF8ckXQxWnG65YMHwcmU6pHR8HKfnDYGYOWGO6s5wXwoagFXTtU8N/+U
 zVgcy3OqkA4caD6G5quWKlttxPhHgm6wjEj8EZDFczTRpY8Y810VbOnIDNh2fAsvBoW5
 +EeOz8L83DO3VC/E71+Os9Z6ocJO5NmHw7PuhBqhQScCo+TR/+Hz/QrYkJ9VWDtw5HEq
 ZDXVCtStB/g4tSGhOq6l2m4YFWfc3wyGsAETdXHMJw+JA7FpFnIs+8RhcGusMviEHoBB
 kUPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvmzmtfCMv9ypMhVg/nVgUpNr3g3c5eOCKUqLA4IMg8+JSV7lATuCHF1H7Cc+PBvPPGc+5hqefBM9m@nongnu.org
X-Gm-Message-State: AOJu0YyV4EaOOkH/M8nDDb2OWcV6p2XBrD9xIQ8vgcJ3ZxCPBjogou6A
 gnUDvpoNgRY7ZvZkkkXMa5InhjOD55t6XR4NA8LV5qk5MPHm9J9kCD+wsPY9VkF4lnPTM28hUBN
 x1IneTD9ug5xb
X-Gm-Gg: ASbGncvf2ZRj7Di96ZySOjAzvGyiBC5nlmGkN+sULabF78JKWD7K/baUv1TVziN3XqN
 CGssJTWbE2yuDyYp0JVRinyRQfH2TKmSj7Ad4fr9VljRypt+9wquvgHeYUuLms3fzxbRzm97BMz
 0Rs2chMYFjwXCQ8JPw5CM8wgRFdMbR89ywwuI3hK6Eo5sh+kFL0wvm5/EKzJys9nnoBLySCnse6
 15+b8Y4XvVgClbMWognpELRUkC69N94bzh5yoLzBuJaOxjTx+apGxvyep2PSdXe6ZOOt++BBgs0
 Nwn/s3J5T53ieuNBXgcZ95knVeGayQnNEq9zpHo0DZwSXRYWwdlUM8OLoI+4qg7dHveA6G8E7Ks
 rHh0SeYLHiyrldLppEFupIRh4+x3b+Tnezvk/e+yCqz30DQOGvCaCp+lrrKGCHXojuo92RNa6Pe
 h2GvUlj0zhaBW1fIlvLp8g61r6H8B/iCh/x7qVn1iCBNhcqjIah3CGARkYwsyn2EFT9Y7ASlj3q
 pE=
X-Google-Smtp-Source: AGHT+IGBn1kx87+BqKJPHMigTl8GDgA5r7qUdgx0x+HGLwAVLvIJyy4rf1itRrl1+TS9KZD8g7g65w==
X-Received: by 2002:a05:600c:8b22:b0:459:db7b:988e with SMTP id
 5b1f17b1804b1-4778fe5d9ecmr138532335e9.13.1763497499654; 
 Tue, 18 Nov 2025 12:24:59 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9e1b657sm23328005e9.17.2025.11.18.12.24.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 12:24:58 -0800 (PST)
Message-ID: <d59708ee-18a9-4f42-8eab-d9e3a5c7cf69@linaro.org>
Date: Tue, 18 Nov 2025 21:24:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] python/qapi: delint import statements
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster
 <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20251118200657.1043688-1-jsnow@redhat.com>
 <20251118200657.1043688-4-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251118200657.1043688-4-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

On 18/11/25 21:06, John Snow wrote:
> Missed a spot with isort, which now causes the python-minreqs test on
> GitLab to fail. Fix it.
> 
> (Hint: the commands in python/tests/qapi-isort.sh can be run without the
> "-c" parameter to automatically adjust import statements according to
> our style rules. Maybe I should make a pre-submit hook that makes this
> adjustment automatically. What do you think?)
> 
> Fixes: 5bd89761

Fixes: 5bd89761a4b ("qapi/command: Avoid generating unused 
qmp_marshal_output_T")

See Laurent's tips:
https://lore.kernel.org/qemu-devel/6c69b3b6-f1f0-da38-d47a-dba01e33bd6a@redhat.com/

> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   scripts/qapi/commands.py | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


