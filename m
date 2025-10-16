Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D334CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 19:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9U5t-0003Zd-DL; Thu, 16 Oct 2025 15:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1v9U5r-0003Yr-Lg
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 15:56:59 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1v9U5o-0005LT-F9
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 15:56:59 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-33b9e390d74so1130516a91.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 12:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760644614; x=1761249414; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=vTQxPDLwUpmZFh6MiUWMMVm9/EBUd0e7wk+hxHI54c0=;
 b=NsnDsnr4i48VgSmNCAyja8GkoaoSPaHsbQgoDGi/YnuxTmyxnjfOdPLQ8kalE7YRlt
 oV7dczXmgz2fJevvMQH5hMiqxIv87p8mDRPIojWGfZjUN3bf+FkD3h8PzaRSYQXmrFQZ
 3r0mLf7PlBTRQQNawrjM/CujHufbUKUllF8z0ySAr5b7BX/ZvVvVjccT9Ge+LVdPH8ra
 DY3uNhLBU9FnzDG5FZgU4zU+eJ5O49VWdMksfZPlttRhpPrFrNyBpYfi0v1VYZN8fz9k
 5twmO1+0xVzmQyFcUHyQzg4GiLFrCOo+zPP3zrHT11erFv6Em602TGfB37JptyyDVbC4
 yHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760644614; x=1761249414;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vTQxPDLwUpmZFh6MiUWMMVm9/EBUd0e7wk+hxHI54c0=;
 b=lxEVeSE+en/PJyxbB/L8WnBeMdD3F48qyuNKPB0VgrIDREeGxTKVcKGR6Su9R3OgJv
 3Sin3w5eOCXQCWePKtUp+YdpTclfchL0H5mMgAj6HrQqIHPqhK68aLWc0hgpV0CdRpEb
 Za7Tm4GM7J3nLbZqIYAanV1+LdBLWuRRC551mhMg+TKxBar1wTZ63rEW0+UF822qHg0D
 aF7qrVGHK24jCgIrECECXkjdhBVQ6ua8WtDfvecG3e9QHq0NO53fmDiAKCmiSVRBlxZy
 J7aubUl1nTjh+3ausi/CV3H80QuGqLchXepMrL+YV2cvtu+rayE/um7pd69AcR5acFrD
 T1vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb3Bm3JpCFuN/7IijcLzUs0GQvK8F98cT11EYrapET/0KfDQXwH1+TWfE1zAkd2B9DXv4lJA9XALv+@nongnu.org
X-Gm-Message-State: AOJu0YxAv0/WgL9pqYc1+ZEXHCuAmizz1/5E3+vGZAIMT8Znz7XsMGP4
 1BvlhRPMBzJ/B45jXhkcr/qMW4EhMgE3CF0V1+Dn9CHk17isu6QBya2J
X-Gm-Gg: ASbGncvG3haLzeeVeFCzbGtP1rN8sMJWNznNncCwLYcqlLmbo2j760z9WF0DwB2gbN6
 OiyAdJzPFJwCT5TNaJ9lfOSCi81i5IANOVwiZO5dVcvFHrm55Mau3w5E1xgvn2vGX8M8IPFNuBR
 YixWzbTEL5gmQgpg+r/biHjJQpG4vfeAHhdJ2RKaErFezZGwxy4K0+ySDK3NHESr02jwBzdelge
 m3AsCYoMay0FyxkVcKgrNaxcKvG81QjjG6C7z81bnAqO2/f+DT5iadRiTGiCty6mMumvxB9DE5u
 rm55mhF+n6vR0/DVuz32xfIIe281ULt+ocK0sU/ya+iUNAaRoHvjDZm0gxjHSv7l4EntolB1Bgw
 MC1tlbmtfoyEtPoFD0BXLmH2gkdH1Zixoq/kWeo7rTAKXthnRe7Xqhkd6Is5EENyFRw5vfxvmYJ
 tQZtPyGe0cRMWkZ0V6BmGrxK3+VhkdgFJ4ZJEb4yBmLMn8HPiZ
X-Google-Smtp-Source: AGHT+IFfg8W10bQHJxpehfLEoevfXn4cH0tsWmNXnrFJnm+eakwPVKEkZtQ9fd2Gc+Eqa7PYT13oUg==
X-Received: by 2002:a17:90b:270a:b0:32e:8c14:5d09 with SMTP id
 98e67ed59e1d1-33bcf86287fmr1137409a91.7.1760644614034; 
 Thu, 16 Oct 2025 12:56:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33bd79b2ee4sm274810a91.1.2025.10.16.12.56.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 12:56:53 -0700 (PDT)
Message-ID: <ac484dc1-4ab5-49ba-a5a2-b4b292d7165a@roeck-us.net>
Date: Thu, 16 Oct 2025 12:56:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Reverts needed to get qemu 10.1.1 and 10.0.5 working for me
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-stable <qemu-stable@nongnu.org>
References: <cf07f156-6d93-4631-8f8b-6bdaae488519@roeck-us.net>
 <12f3164f-291e-4415-b724-299a23dec746@tls.msk.ru>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <12f3164f-291e-4415-b724-299a23dec746@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=groeck7@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/16/25 09:46, Michael Tokarev wrote:
> [Adding qemu-stable@ to Cc]
> 
> On 10/15/25 13:33, Guenter Roeck wrote:
>> Hi all,
>>
>> I lost track what exactly I reported, so here is a summary of reverts and
>> patches I needed to get qemu 10.1.1 and 10.0.5 working for me.
> 
> Reported to where?
> 

Oh man, I didn't expect this kind of push-back. I so regret sending this e-mail.
Please just forget about it. Sorry for the noise.

Guenter


