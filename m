Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F0AE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 18:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKil2-0002rm-LJ; Mon, 09 Dec 2024 13:45:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tKikz-0002rO-A8
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 13:45:21 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tKikw-0008KH-NN
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 13:45:20 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-725ad59ad72so3294293b3a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 10:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733769917; x=1734374717; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hhFjzxkR9gOV/Qvk5VEmf56oV91bWJ6nnVCau2LquOc=;
 b=AzuLqT6HpoJDs4ofx4GbBfWLfTPBZDtpGfkRhiIeetCn8+FYzvQLk/PgrAZ8AJtd5U
 yDa/WZlQ0+yMB54USHTJJNMA+RwDfH4vhlZzw95Qq23aPRd6/1nVGgYtcx2ly1b7dR83
 1XvpYHOyOFBUUE58ja5/Jqo7rIAAp8wKecZkooDJbPd1PL6zt24qhuAi9MzYslhz9Pbl
 xV6Xo7Ee9FHjcRSXZMPHyW/W7DnQnRBadT/k9xTMeK4nQLQUo3bLd/skXxjCI5egYd9T
 N1HqsIPKtb2suBCvsbjyNnhHGyIg2j2yftA97LDG80sNh9oxMHUfW+YO2MsK7Ap5OYsL
 bGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733769917; x=1734374717;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hhFjzxkR9gOV/Qvk5VEmf56oV91bWJ6nnVCau2LquOc=;
 b=GRwo7ck5wX4IrTHyjSSh/cyF1g6u9BKD35yotRBGklbcz36Gydb+Oopmra2kqYlYg6
 qmLnuXLewKpplpLb+PQ4i97eGz1QvJTyS7dwb4Cqtu8tDhuQ6ET0OLLZetI07P1NQuJM
 or1Rp8ESLfCDvP+zk5MKTiEQFtTlzd8ulqYYQeZMHPJPZhk3AS+rgIdLop799B9t7bbs
 XKFnQO+IJmA0xU4Fj/jcVRgxgVawTTzb+K6kt1v/Ap9mRURZce4hEJFqyDsPHTO+lO2x
 8UXQ5xh27Fg7JBWIXp8WH9Z70l9xBVsf3TuYJKX7vNbM4fQup+RJmNB7o04JjanR4BF+
 v7xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv3dmV31IWhg3eQRr4w36x8PWmrMpg9B68d2fQYsBBnK72yb3fWYNUMIRbkXWaiK1OaADNSKPw+nF/@nongnu.org
X-Gm-Message-State: AOJu0YxJmeQkp4aP/q7gEX1+cC0U8vWbzgvH2bCthxG5L4mIhSNqx/o7
 Zn/RngmZfVY6lKEejBqiBKjow1sahkzttZxM1pj15W1dyXoQt6TD6q/QvT4Wuu8=
X-Gm-Gg: ASbGncvBzgyixZDpGD00nc8hLeYHQVKgH8DD4LpGvrwdYM94yw8GSl4sRf+TB4jZcOY
 0rh5sFDER/W8LNJuI/w+ln08TvPlTxkQT59IUakbRYocF2ylt9R0gBvzIxkrgQrmQFNfB+I8reW
 7XKtGFYKlOiPwOQoNQYZRU/H3j1HeZRVJzTg53OtEQdLyW6VQpC02VwhbybI4z12krWNQAiWvaz
 +unVdfzTAIxMcXN8wfRoqx8yM6FI8WA722+iGllSijeIIODWHeBxKnhENK5MgQo1asYZNFz2KQ+
 jhTgmNtkJ7P+AYn1MuolzE1pCg==
X-Google-Smtp-Source: AGHT+IFCT4NxeIgThqJcpf2fSScpAl3CQaCzbW34BQV8hwoIkvSJrVZrBlFJ7jdPYKTbzTOUtxvC6g==
X-Received: by 2002:a05:6a00:929a:b0:724:60bd:e861 with SMTP id
 d2e1a72fcca58-725b81a3e13mr22821466b3a.18.1733769917040; 
 Mon, 09 Dec 2024 10:45:17 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725e62e8491sm3028040b3a.71.2024.12.09.10.45.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 10:45:16 -0800 (PST)
Message-ID: <5b798177-c48f-4f69-8b7b-2b63c74c3505@linaro.org>
Date: Mon, 9 Dec 2024 10:45:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add additional plugin API functions to read and
 write memory and registers
Content-Language: en-US
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
References: <20241206102605.961658-1-rowanbhart@gmail.com>
 <55c95bd1-a1bc-460c-b4fe-1f52f8af2c2e@linaro.org>
 <2c0893fa-9d84-4003-861b-91a923f9439f@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <2c0893fa-9d84-4003-861b-91a923f9439f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 12/6/24 16:57, Rowan Hart wrote:
>> I am personally in favor to adding such features in upstream QEMU, but we should discuss it with the maintainers, because it would allow to change the state of execution, which is something qemu plugins actively didn't try to do. It's a real paradigm shift for plugins.
>>
>> By writing to memory/registers, we can start replacing instructions and control flow, and there is a whole set of consequences to that.
>>
> 
> Totally agree! As much as I really want this functionality for plugins, I think
> alignment on it is quite important. I can see very cool use cases for being
> able to replace instructions and control flow to allow hooking functions,
> hotpatching, and so forth.
> 
> I don't really know the edge cases here so your expertise will be helpful. In
> the worst case I can imagine: what would happen if a callback overwrote the
> next insn? I'm not sure what behavior I would expect if that insn has already
> been translated as part of the same tb. That said, the plugin is aware of which
> insns have already been translated, so maybe it is not unreasonable to just
> document this as a "don't do that". Let me know what you think.
> 

In the end, if we implement something to modify running code, we should 
make sure it works as expected (flushing the related tb). I am not sure 
about the current status, and all the changes that would be needed, but 
it's something we should discuss before implementing.

More globally, let's wait to hear feedback from maintainers to see if 
they are open to the idea or not. A "hard" no would end it there.

>> The hypercall functionality would be useful for plugins as a whole. And I think it definitely deserves to be worked on, if maintainers are open to that as well.
> 
> Sure, I'd be happy to work on this some more. At least on the fuzzing side of
> things, the way hypercalls are done across hypervisors (QEMU, Bochs, etc) is
> pretty consistent so I think we could provide a useful common set of
> functionality. The reason I did the bare minimum here is I'm not familiar with
> every architecture, and a good NOP needs to be chosen for each one along with a
> reasonable way to pass some arguments -- I don't know if I'm the right person
> to make that call.
> 

We have been discussing something like that for system mode recently, so 
it would definitely be useful.

IMHO, it's open for anyone to contribute this, the plugins area is not a 
private garden where only chosen ones can change things. Just be 
prepared for change requests, and multiple versions before the final one.

Same on this one, we'll see if maintainers are ok with the idea.

> Glad to hear you're for this idea!
> 
> -Rowan

Thanks,
Pierrick

