Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FA9D49212
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD12G-0005sP-5V; Mon, 18 Nov 2024 07:39:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD12E-0005rF-2u
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:39:18 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD12C-000455-C2
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:39:17 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3824aef833bso217128f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731933555; x=1732538355; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nBdlZaBZRyVJtXljRLhvjBpO8GxqluKelZaX1eld8Sg=;
 b=MwUqLUxst4sGF85vFZiub3TAzliFvWR6vZlhHAvvSOnddBFwoRALMF0SKVnio9SPTh
 vLksic+jzilYFWZiyhjDzjltoRNsldwnykiiB8ZIdE4enS2KJQaEh5N8cjknzqTUi7jn
 ECTdTDJJ60pNp22DVOVv9Uq1xcyppOgDqGkJyTVbfWqUaOrpsGzaaY/nFGHeUGmT9XKy
 ZvFcRQsfbZw5RmjcrKZ5zbJgBlrvshsNx67tvvy5ZdjCZHq9bjnUa4qBuk2uRfnJx6lG
 xsZS70YCYI0eHtGa+Y388+itiKjJ4+GwgAPKY+eCLuwCu6k4Jqur4ZucFwevp3/T133n
 7Faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731933555; x=1732538355;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nBdlZaBZRyVJtXljRLhvjBpO8GxqluKelZaX1eld8Sg=;
 b=Mutfg4C5x+4TfVafDJGnWWDxZXm/vGnZLqebfA/Ue0QCq0Jab98e2PZt55jW5VCf22
 Qf3HAKvqj0Di5dMAsDAF6CSuTyZnA7DlzZTQvEmEqG59lPkfWdbf0kXH9gnPoVjCRrTQ
 eolc5akLMN4ZwMnnE2J18yazRwTD2GUxYY/ikgPSXJu9sqVf7qhXNRsDZdmwBG3PBxn7
 jTDtX3UmL/aLv+LpR2h+tgUdvkx+zqXI+Fv1EOpE3bmSTWV6P+xsJS/wNfjDjZZ9Ua+b
 nnVgQ7hAhYDWV/cxIvzp/w33/Jt7GltIZvQJ/qDVbTmMtqX2bU03+YeEi7jmeAREmNIb
 u3pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdfZi34kDCGtg+n4YrnPpmJd8+GUQUDc9JE8NSQakhLDh7b6qqhXn4kmuZdRAexZanAUF1aAjVL8Xb@nongnu.org
X-Gm-Message-State: AOJu0YwRixDLsIol53HT2mvt04lu0MWCZMEjUHgdfagOgqZIumuZcJmO
 gnu4GPQjV+BSWu5T0BJDB9F7B34pDJQvYCTj+m87/+itvXzvYR4hA7NfREaZ7Buw6a6PEJH97qD
 S
X-Google-Smtp-Source: AGHT+IHUrKXm80I7Ff2RZH+N52Pj0IN3WBv2v5HghpdGJCXNBJDzVKfTSRpphxlEuLN5H+bVRTCFTw==
X-Received: by 2002:a05:6000:1562:b0:382:2a2b:f81e with SMTP id
 ffacd0b85a97d-3822a2bf928mr9604243f8f.51.1731933554934; 
 Mon, 18 Nov 2024 04:39:14 -0800 (PST)
Received: from [192.168.69.197] ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-382435f6986sm4374519f8f.42.2024.11.18.04.39.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 04:39:14 -0800 (PST)
Message-ID: <8f68c819-acc3-4c01-8949-33805531978c@linaro.org>
Date: Mon, 18 Nov 2024 13:39:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hda-codec: reuse the audio device on format change
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20241114125318.1707590-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241114125318.1707590-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 14/11/24 12:53, Paolo Bonzini wrote:

> Paolo Bonzini (2):
>    Revert "hw/audio/hda: fix memory leak on audio setup"
>    hw/audio/hda: fix memory leak on audio setup

Series queued to hw-misc, thanks.


