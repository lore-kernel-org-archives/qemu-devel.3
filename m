Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05BBCCF9EE
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 19:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDShK-0002R7-GH; Mon, 27 Oct 2025 15:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDSgx-0001kU-Cz
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 15:15:51 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDSgn-00054v-P0
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 15:15:42 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-475dc6029b6so23539815e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 12:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761592525; x=1762197325; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hLDjgARgb4G8/diqafQwHm/46INREYCion0kHAnoOBE=;
 b=rHlwWt51nUe1K/S+DArs/IQshYPeE0fEGBfYAzy7n0ja1k2CgTPxkePMAzLPJV/Z+S
 6VK07f33fobNz01XyrsOl9P5P+K3mao9qyVukg5+J5pMNJqVt/IkG7c594XZaNW+N+VC
 AGcmBQMm8fF4OOj1Ztu0qgZqQICXXwChCRsQgdR24+iP+53bL9MLKFS5iNlAKvIhvhC/
 TERnixdwTurf7nge/pcsCVkMLL+SGDeYWHMVaQ44WmLMaO1K52kpdGrzl76kimrGPH/A
 /lFeWK0YxRrialcLzTu7oEmAnq0kvjcij1r+UP7KRP8GAEP+Utr9XvvMpGWq4D8Mlmob
 OlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761592525; x=1762197325;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hLDjgARgb4G8/diqafQwHm/46INREYCion0kHAnoOBE=;
 b=oN4adMUME/ffKyGkRFlKP2XmhDcynHy7AGSODhK8vUJYC7z5EmqKkaFHfZbXCaLPkr
 jwZrtF4YAJHip8/G0dw1CSUWDoaB1td2sBtfFPm+NcWZUtYkixI8EIY9TD+t6NJu+an9
 +qhYuich0AYZVy4KbeXRwYObsjOii4xG91hP4Yw2xTxSEEeSvNSuRd+RjmNiwaMpFqn6
 pZOTCjYHUjyOiKW9TlFJot/P0+RWBY/7iCKevabwfwdlrdltkpzpLu609Qf9jnImbpZe
 aGIvHTwXTrgqxUyWzPp2eCTJHbyGzmDY8e1Alpa50wfD52lQvAZRNhDH7WTeXNqcnab1
 FHgg==
X-Gm-Message-State: AOJu0YwLZ+g7nuhLHJ3nz9TG417bd1R+SKK6fPWsrXsg7vCbnftkRbQV
 tgKTx4G3QBdeC4nrLsI8RHtOkx6GuX5BULiXiTO8ctBkYZI+hTJfuBGZtSwV334sGEI=
X-Gm-Gg: ASbGncvyX08bXbOdFZ7C6tzGBc+RUNcSoa2Yq+7byIjLJrd3uhoJOilZzVVY4QDslm+
 mAb0KF/rJfHFZZikHdDoL0guMSeFYtBTVADwGqAFcneOdnzNSNAC5y45RgbCrzhmd0ylFA0ce+B
 d/AnM25XtZE7kJkkMcjc6+8sFkydClLyv3opq/V8YiJyDtRI6gS39JA3Qnm2DyLWdY4dKkGtgHX
 M1lgijhPywVjayxcRkb4r6B6jQSwJhoQC/Ln3QBNlQ6zASpDFqV8azpDBv3BYNlTgh5Yuuw5Q3W
 Xrnv+ZF5+CxVXLeYb/HiAhLkZKICnQYtYNHtZWtecZGIEpdOZ5TbwJcNkKh+QTvTFfB8cbZgDSQ
 TBnDJB4NTPreL8Mp74dZQgdRB1VIQCADUnXSey+EgY2a6D+K5qEcO+bEJ5MItkSgcYsEXWpkzRy
 60zitJF3hPcee+F2sl/2DsWzhd085WcgRontMWkBBxVu4+iMrbRnD9vA==
X-Google-Smtp-Source: AGHT+IFTqNgOAf6NMQsq8F59VmRm975mS/Re/Sysryah+BZbF17J/f6K3XKQE5oQPYQ4kLSP25+hpg==
X-Received: by 2002:a05:6000:4285:b0:426:d5ac:8660 with SMTP id
 ffacd0b85a97d-429a7e8ae0bmr716541f8f.58.1761592524796; 
 Mon, 27 Oct 2025 12:15:24 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df62dsm17165611f8f.45.2025.10.27.12.15.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 12:15:23 -0700 (PDT)
Message-ID: <8d8d99bd-a167-4867-b8bb-6f807d89a30a@linaro.org>
Date: Mon, 27 Oct 2025 20:15:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/uefi/ovmf-log: Fix memory leak in hmp_info_firmware_log
Content-Language: en-US
To: zhaoguohan_salmon@163.com, kraxel@redhat.com
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 GuoHan Zhao <zhaoguohan@kylinos.cn>
References: <20251023063106.9834-1-zhaoguohan_salmon@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251023063106.9834-1-zhaoguohan_salmon@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 23/10/25 08:31, zhaoguohan_salmon@163.com wrote:
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
> 
> The FirmwareLog object returned by qmp_query_firmware_log() was
> not being freed, causing a memory leak.
> 
> Use g_autoptr to ensure the object is automatically freed when
> it goes out of scope.
> 
> Fixes: c8aa8120313f ("hw/uefi: add 'info firmware-log' hmp monitor command.")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
>   hw/uefi/ovmf-log.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Already merged as commit b6478122f059274b19805e14d12f76d2c0272ad4.

