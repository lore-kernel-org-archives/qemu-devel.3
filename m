Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AC2F54AC7
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w52xU-0003I5-BS; Tue, 24 Mar 2026 10:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w52x9-0003H4-2D
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:41:55 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w52x4-0007r9-HM
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:41:52 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43b87970468so192901f8f.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774363309; x=1774968109; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d9nTY42IS1HlSSrDcnTX14DmOYYDGUpXN9zSkrhwb7Q=;
 b=HUN28gNGrAY9slDQ6uLuLYltuEOh1a0Yu+l9De5oMuQiFPkXpv1NvWMx6z6UNLP06y
 BlXfI4iobzIYoVVA2QCLpNypcoV2ydA0DlJQMLAaMgNRK+EOfonXWkZYHvh9gKmAK+I8
 QXa8NqhOpJryuVHCUEmvLU5E/G0y1zzhYFqHcCHRWI+ZED3W2UgACSI8C61ijmorW7V1
 EpnxVXa/XKUKtQ15AWqAVkj+AnqurMrPDVFVlcWrD6LPl6HlbX5yVxPgVEF9g34BpSGI
 kl6pMbH/aF1Zez6blUvf4zPS/80quutzskKQ+DMX7jh6APNAMgf3/UBTnJA4nwYrRe46
 JFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774363309; x=1774968109;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d9nTY42IS1HlSSrDcnTX14DmOYYDGUpXN9zSkrhwb7Q=;
 b=LqwpVCn+v5eiQrhyzGTSgKzTO7YC5V9EYuK80DDCDo0aeubyMWfQWE00ukLoLoWLQN
 2hhTuWXel3EzqXmYdhZ1OppIP8vMEFFMfHGDQFhjqKD126LXsfbUxjNmKdNyUxVhtD7a
 xDP664QNmZ5z/Y29wHaue9kNjQ0/mO0SbGf4idRbhofuT6bg55XeLXx72k3va6zcBkep
 YgcQ8H4RJopAeqzrJY7KpfJmsmJ//d4MhjXifbZMajMgOGx8ujEefdgYhb4/EYcxyuee
 EUb/xL4PacO1HPNrAFJ7mryPXSPpXGk6dbaiVusvo3BN2YF/FheErV4jzJXBTaiQTyUb
 QZ2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrauw+7xgIi0D1mP/anZEr0hl0iHx5YpHPTXrNYhSTIES5Laagthr7zTswV965L3Y+GB71au6dH0va@nongnu.org
X-Gm-Message-State: AOJu0YwLA1cG91OagIFy5UHcASJF51qT3UXZFOYaKhyGpIkS+9c6R2Qs
 zKRSwKrDvMmXu4S0mIAD8vi4W1/9TuZQ28O3UiUufxcxi62cnhkpNI+zD2ZXp0xsNDA=
X-Gm-Gg: ATEYQzwl9Mr2t7ZSWUm6wFzq9FS3nNzADAQj3mOtEwK4C/BnpZrJBipXGcxRtzfn/zz
 sDlW3+gEwOMuh9Ql3Jv62RiWJ2kvMORUAhKF4HKy6UgYp/TNwutdmMpBc+9cm6VQQTU8D+Ks8mp
 JDg5bG/tD4U0O3vhVHOrvbKtLoxzo5gGk6ko+USXS34HtN2fqqIjsK2K2Tl+JscFj5TUJqU/TDg
 nMz4WIPd/K+CB0WLc83kY5tJtbigrurTXucbaE5xwn5tnRDWGvwYXHYvjTf3WSdhzJTNIjgpG7y
 mBTJHJEK9ZkAnRqYaCjpa6WCDbWPYBim8BBGRDMMM7LdZVoiJ87jVlFzRAC6GPndlK/e3sdIN/I
 nuM/ex692Qg/sxObHe5XU3qHs7MPc7XLpcNcR0sVxXRMkiWQbOctNR06JCendH770Ud3bUMnd07
 OU1q/W8dalMjryI8RGaY7zA/ure74Vx1j/a73ZjUWcj+AlgRC7WEdiAOJ+9tRgAS8EZ+WowIj2L
 iyB
X-Received: by 2002:a05:6000:40cc:b0:43b:54c9:85f4 with SMTP id
 ffacd0b85a97d-43b64279621mr26498941f8f.39.1774363308635; 
 Tue, 24 Mar 2026 07:41:48 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64717e97sm40602521f8f.35.2026.03.24.07.41.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 07:41:48 -0700 (PDT)
Message-ID: <838aaebf-7bc4-480c-b799-55b4b791f075@linaro.org>
Date: Tue, 24 Mar 2026 15:41:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Fix error handling for callers of
 load_image_targphys, get_image_size, event_notifier_init, msix_init
Content-Language: en-US
To: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org
References: <20260318141415.8538-1-vikingtc4@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260318141415.8538-1-vikingtc4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 18/3/26 15:14, Trieu Huynh wrote:

> Trieu Huynh (4):
>    hw/core/loader: fix error handling for load_image_targphys callers
>    hw/core/loader: fix error handling for get_image_size callers
>    util/event_notifier: fix error handling for event_notifier_init
>      callers
>    hw/pci/msix: fix error handling for msix_init callers

Merged as commits b06bb02721a98d5b42...08324de90d1036326f, thanks.


