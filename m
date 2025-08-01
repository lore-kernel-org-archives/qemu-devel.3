Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61065C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 18:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhuA6-00065h-Ek; Fri, 01 Aug 2025 14:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhsfi-0002GP-Tl
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:31:57 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhsfD-0001Us-5H
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:31:29 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7682560a2f2so2481086b3a.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 09:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754065881; x=1754670681; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PMBW97dYR020kODyfOzISwb1ViVO6GCqGrwFmYO8eF0=;
 b=Yvy6b6DIILGS+hOdpyVdiDBME1WFAuw0j3sMxZ8HvvwvKiSpDz2nxLlajFhcv8lCg6
 GvPZk3TXZXTxU7uTv+34bCE0uoYdli82goCrzAsdcuXYI6yHLm+qJJw6Fn4mlT6LhFph
 tVsMw9jcsjKWFFTrEiYYPJ+uVRq6H1fl9JJvf0K3uoTb6sbx+QEHfO0D0rK/+Bdh3yxn
 Hn3lxqmiwHM900fDqtoutSOeoMqjj2b3/bIRkFrXli78mnQItRX9D4iC5Z6ikYB55ccZ
 noZDCRb1QuEh2GE4x3gjlUi0MkE8bZvx1rcbVbB0ujCpdmhAhRkOt7cejH+xdlWOxNYA
 QCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754065881; x=1754670681;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PMBW97dYR020kODyfOzISwb1ViVO6GCqGrwFmYO8eF0=;
 b=m4aHwpA54xOC+TVTcNpRTUfX2VuOomq7cahjsTCUd26N+lDxmN5fteEJ3DB9EhtMmJ
 9HxzisuYPHSZMoU0/+wmB+mCl4HFYqn6dVkuZ0lE2eBicXtGMp09frASgw2sLUYembCL
 zjEvz3qFg/ixfvdv1UNRvrlrIpgpkJT8zDhASMaMAKPfum2L+74uRCFeX11I7q3LGWIW
 ZNIfXcjQ/omtQQksDsBDGm6iWuI+loerTgbJn9pubsSr35gG8oXa0PZQddKzWzRMYkmx
 JggrjHHCvdGfYrGdy5gAVqnDBfM6pAL8lBfYSj/WKyLwgFse7wdDlp6eQFnPN6jhoZi5
 PtQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUs2Vei+VJFA6p3sXNYa+YxhJyutuerQw8Y+mVThoLCJH3sykQbkPWSutwUXYFhskofXIDvma2jmnI@nongnu.org
X-Gm-Message-State: AOJu0YzIsHN7E23rgea+WtfG7G+fK9PfThL8KlzG4G0vOQpLZ4xUYs/8
 CxKdV4PxW9rssy21VH8rbwQv+ZEmWkQhlQBwM9GtZJ8qJK20V7YkJJuG10XN1kcN/50=
X-Gm-Gg: ASbGncsboz3WKr695VavbW4endu9cH8EH9llcbDdzjrKu/bqvJBiue8FMPt29HRgFnY
 38ohVOq/dNp5uowtHR/eBfCQy75AI86WAA6AHgX5qFjnYKbYSmh3Ts53z25qz9ykCdVJJnWQt+Q
 EtXqf+Lye+5k2Uf3f6x/p2684WX5pn6YM1DtDcJIKTZNRkFpRKkzqve+uJ3p+qqjLbWz0fNm+uZ
 KH4Zi5a35YgfzZCamcdlHNaTowUZgYb5VZoJpkaqMim8eiP5LrubD7VWee2LBsCmDhiT4ZiAZQ2
 fwtYQGZcCCJM0wHZiEw7Ppte/hnO+1B5JmixAT+lNeDlZXO29+WWHXUuJp1KLmUu5KBCL69dERK
 Kkyov1CQ7BW9Sg/GkOBpv7a9kln05tZ2eiqs=
X-Google-Smtp-Source: AGHT+IE89dSRulYtt5XDHOTYLSiufFjTSiYPp19Oh/bizB64yb5TBW6dWkS5sEVywNLlLuHpql+c5A==
X-Received: by 2002:a05:6a00:1acd:b0:736:9f2e:1357 with SMTP id
 d2e1a72fcca58-76beaa8445amr334697b3a.12.1754065880741; 
 Fri, 01 Aug 2025 09:31:20 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f943sm4524936b3a.12.2025.08.01.09.31.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 09:31:20 -0700 (PDT)
Message-ID: <034c953f-dce6-4068-8f93-05e758e67703@linaro.org>
Date: Fri, 1 Aug 2025 09:31:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] single-binary: compile hw/intc/arm* files once
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20250725201906.19533-1-pierrick.bouvier@linaro.org>
 <bfdd8821-a7f7-4648-a389-124426da6d15@linaro.org>
 <144f0930-af30-42b0-849c-99242d3f09ee@linaro.org>
 <CAFEAcA-ycO=AO8UO+X3f6pw34J=iFwW3dpPyMXKm5BzJ11dt5Q@mail.gmail.com>
 <25fe9c70-be00-4884-8d91-53dfff745cb6@linaro.org>
 <CAFEAcA8qHUT-0k6chAFZ61J=YZ7xLvhYgqsgtQiCgkfaxfFRxg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA8qHUT-0k6chAFZ61J=YZ7xLvhYgqsgtQiCgkfaxfFRxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 8/1/25 1:34 AM, Peter Maydell wrote:
> On Thu, 31 Jul 2025 at 19:30, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>> Regarding the "modern" completion support, I recommend you take a look
>> at it. Even though you wrote or reviewed most of the code you navigate
>> in everyday, and thus don't need it, it has become a standard tool for
>> any developer, like sanitizers or omniscient debugging. It's especially
>> interesting since those tools are based on compilers (clangd is the
>> standard for C/C++ nowadays) and not a bunch of clunky regexps.
>> It's even more interesting when you learn a new language, like Rust.
> 
> I do actually have clangd enabled at the moment in emacs:
> but my experience is not good, because typically what happens
> is that clangd runs itself out of memory and falls over
> fairly frequently, or it produces obscure error messages like
> "LSP :: Error from the Language Server: trying to get AST for
> non-added document (Invalid Parameter)"...
> 
> So I mostly continue to investigate code the way I always have
> done, with grep.
>

By any chance, are you using an old version of clangd (or an old 
distro)? It has been a few years since I didn't run into any issue with 
it, and it's quite easy to update it using llvm apt repositories without 
updating your whole system [1].

[1] https://apt.llvm.org/

> -- PMM


