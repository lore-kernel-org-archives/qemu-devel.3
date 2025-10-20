Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F2DCCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 08:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAlPD-0007Hk-TP; Mon, 20 Oct 2025 04:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAlPB-0007Fe-CV
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:38:13 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAlP9-0000Y8-DM
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:38:13 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-471066cfc2aso36964655e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 01:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760949489; x=1761554289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xetCTpZKQpHH8pu8W3Ukp5Exa3RgxbR248dnMHTcAMY=;
 b=A4DlZ3QRzZ2qmH6Kx9loYrD6k2LbxTAyLeSGsEZ2KufQAKFeOpi8sIw9p9wv6xlgpG
 f5AkhBmJJICQdXo6JK+R2cacEbVhNaZtN2sR6MnEkvuSfnCvAaA6kmAsWDynyz5j2dmM
 cjeQRsdI3DWUoKMeM/kyQk0+jZiA4Zpyd7aanxYuuWXseOnVodbqpVlcF0VHcqFPnOrm
 zuOCFEP4a1eggl6XJNYkAhPh441ShVWOKKtoxSPaNJwvYjeAPJlqnuxJH2gqKPB+xPaN
 5juUPNckb1QWGu6I6VnOeZSG4DwZ12y/gqX5xnYsx56EI6drpbSS4cfA5fGhylISXb02
 yKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760949489; x=1761554289;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xetCTpZKQpHH8pu8W3Ukp5Exa3RgxbR248dnMHTcAMY=;
 b=Qg34thRERoBMH55LgFTc30A9c0SVlXRdv9zHpcwyFoP81k5K/SUDnwfCBgUi0V6iH2
 J6aMsZaWsfD+K5okXTB28OpV4B1c0jvem7CAoDYke6IesZ5tIO4jr2GjTnTAXF38KOyG
 WszlttYxuBzi3koTNec+1kQcBaaQGdmhkjTMasrvjIqb/UCh4X9xQwpSaStIlfJJY9sS
 7TNZ2j0tVdK3oITA6ZxmKS4Z48UdM5xMWgQAvVJG4h+LxrGAXvKDWeyAuNYl98/Mmr6H
 JY5tBPeWpqgnD7DCMQiwxPYSN1IKBzVNnO8cHP9U5w+DvO4iz8mPSHVdRfjlDXyNiFIy
 8Csg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV7SOU1eajpYckrtDvEu48W8jSnLUjC+bYOIWJ5LqGfha8H42OGGWL9t5eXr1JiVsoyV7huUZKfotV@nongnu.org
X-Gm-Message-State: AOJu0Yxn2P+c4u8niiRnSpMxrzY2CFRamGLzkBzSLFNYOIJJiZDo/1+0
 rxwiqb59ZhujJUQ3veTCtFAyN/hmuxt4w4tWLGl2BxAvsE0wt9rz7CmVsn6fqPdGW4s=
X-Gm-Gg: ASbGnct6+GLrJG82lFxyCzsJj5wcyRVcteB4zlx6QtsqdQlnTvsz2Ey06EtJZFKQR1A
 SStoNmYhniln0vBWj9srgExB5ymreKXhmOOKDmLb2sN29klb7FTQARYxsO4fsmQvIXYkkx78wDh
 M8196Y0x6YUkgKcpQH55i670fugdvRauSi9tmcA+oX94PSVWru9S71tmAUOulaP9EBzaLtuD6lX
 Ge7vsfOiJ9Fz+RwsMjbMvDMQ2jjRVX504nEEMsYfTxACmwLTGrWz2npBBF8E+bqffp4mayPysAH
 IHy/lVFMSNtmRiHyrsZljVWN0WS3EUlm31/J6R1QNGeWYm1cspXeqvkIem5lqSp/lCkmy2iXjxv
 raiCX9gZKDfuYt9Vpi058jQSPb+ieGEArp0nKrLqbrarqRV5SLcsyx6GvpScQICaOsNshg51P69
 VBIccoK4HrHBCV3/JrWU/uCNHy5ep0LwY1PGLCvi5ujoI=
X-Google-Smtp-Source: AGHT+IHgYjcYJ+utvC/8VHpW7hZvnCGao+Xt+8hL5kfSJQQwPmBest2aq8ZeHzcl9uR9s9oX65M96w==
X-Received: by 2002:a05:6000:400a:b0:427:492:79e6 with SMTP id
 ffacd0b85a97d-42704d83d9amr7584111f8f.2.1760949489358; 
 Mon, 20 Oct 2025 01:38:09 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144239bdsm264042755e9.3.2025.10.20.01.38.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 01:38:08 -0700 (PDT)
Message-ID: <827b75af-a645-4d9f-bc4b-54a140acc99b@linaro.org>
Date: Mon, 20 Oct 2025 10:38:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] hw/pci-host/raven: Rename direct config access
 ops
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1758219840.git.balaton@eik.bme.hu>
 <07eaef3ca91a8d7c9a4c71fe144ded6e9c4f9211.1758219840.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <07eaef3ca91a8d7c9a4c71fe144ded6e9c4f9211.1758219840.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 18/9/25 20:50, BALATON Zoltan wrote:
> Rename memory io ops implementing PCI configuration direct access to
> mmcfg which describes better what these are for.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/raven.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


