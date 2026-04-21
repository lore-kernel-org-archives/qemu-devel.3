Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AA5F8FA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 12:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFAdm-0004SQ-3t; Tue, 21 Apr 2026 08:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFAdi-0004QM-KI
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 08:55:44 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFAdh-0007ZL-14
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 08:55:42 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488b0046078so38877685e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 05:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776776139; x=1777380939; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LdOYyljqs+0qqKByZ2HK5DZmkxXYxzWDn5moLcQb/5s=;
 b=iPwmiPgqg9fmiTmUNFyqXbZehFHuL6nnWobP+dySKnPSKjm+SHxiABX7dmLuUBqAJh
 4c9rX7rv3s0JdrW/CXp4BiWo+n2P6jVzUwNtqRuWv6H3DDOIgyh59M6wei5WN3VLkbkx
 o/fAwyIvuRzdVo3QAjKukFsfXR3uudwUT/noCEzENNYoJjcVit6Ms6nDqdtRawy9NpbZ
 4PsWHajseRMfRIke2JnVSYegG4Q/ApF3wCQ0F68HqqjxEHlzrx8PPs6kgI6Ytg1yq/cp
 Kea8UWy69O63FJuQUrKcer07uQcogxHMvp33dDBhdcWVnYlaLh4uwZhhUHtfPJ70Dm1E
 5h4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776776139; x=1777380939;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LdOYyljqs+0qqKByZ2HK5DZmkxXYxzWDn5moLcQb/5s=;
 b=PMIlPW/qKLQ7aPwu/1omGV3rJWLcUUfNSaTfi7tm5KF8WIMouQtc8lDHUsgYfjxame
 5DfuB5VYmzRIth0py2KXEpR3cTVeNPENo5ftyoFEuBf/Tw20FKkE/D8paBYn+Z/fkJ5L
 dfHJ0gKYjc8A2/1dzcsYgsuRQ1xuoWroNPG8xbSFHfJ/mUcd3KZvk93O7MAbdcl/0zHJ
 hP52JlaF20nYL612Q86CKqynOqt/kNbFY9NW+Jnx8Sxrbk/U0nFGdazZhAPJJqpzI1Jj
 j1AZ1XVgIirS8bOwvOOvjjwAQvQR9u8jG74XheY45poZNfqM5Jaw/6umxs55HhpR5Xxl
 g7GA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3PTBUPiOAqosHKEmZCg3WK0bQwHd5Q5VCqO0JiBi8RsTUVu8iKNLgocmZ49pV+0pfZIOrwFnxkKAk@nongnu.org
X-Gm-Message-State: AOJu0YzNNP1OAn61AQcSsyU/DU5W0X2abKkwdu6QCRoasLJGOrWXRr5X
 3qi5N0vr77ek46AmUUjOKhewxq/QySexTVZeLEbcHFhWKqZx5v0bXgZZHoe4+P5F8WI=
X-Gm-Gg: AeBDieu5sJQkKnsS5ExFFhQGDfhtJ93tzJem/m0xqYKDQtQsmw+P1HrVqcHkuxgHdnh
 Fzzh3Jivx9Pyus6tbazJeBaUe7/gk017vwjrtPCp+dCEtgijzFn2k7Ux4HK8bNDzn9jF7TC2/9N
 m7K4UgeTgbnV7GfXl8lIdM3rb7o/fJD4dxegtypuKOikzliDf6uR31474ddxNR/+ivZhxZkuFev
 iF6GsoDwdDjMyn+lxXhD6GAXfo59EMZqQRn7zxGRaR3gIQuUYTjh0b+md3zZgN8FWtnyZDRc03e
 hLPDwru7WCQ1qWZ4H++PdVDR/viR2Xc34bkCt6S6Q9FRA56ahFJWkQ2cM2YsgKR6vBVj2X7mySq
 dJTkOwuTzMnW/mrWY14ZDXdg1PqVrk3UibW+d19rxLYpBRzLuuG9bp1rw085Z2jgi6WBZPlFsrM
 +deoMqzrQIBmmVEiFD7QuSRO/PPutFUzYbQDP/qNR1QS0y9n7Wi3A7ygjU7bll286JzuDp6fehB
 w==
X-Received: by 2002:a05:600c:b90:b0:488:b99b:4177 with SMTP id
 5b1f17b1804b1-488fb78ee4emr246458685e9.25.1776776139137; 
 Tue, 21 Apr 2026 05:55:39 -0700 (PDT)
Received: from [10.193.39.66] (140.170.88.92.rev.sfr.net. [92.88.170.140])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7bf7besm128756345e9.34.2026.04.21.05.55.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 05:55:38 -0700 (PDT)
Message-ID: <85722c50-873f-4452-ab48-d426a5d81089@linaro.org>
Date: Tue, 21 Apr 2026 14:55:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ppc: remove duplicate include
Content-Language: en-US
To: Osama Abdelkader <osama.abdelkader@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, "open list:amigaone"
 <qemu-ppc@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
References: <20260420164058.335872-1-osama.abdelkader@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260420164058.335872-1-osama.abdelkader@gmail.com>
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

On 20/4/26 18:40, Osama Abdelkader wrote:
> hw/ppc/ppc.h is included twice
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>   hw/ppc/amigaone.c | 1 -
>   1 file changed, 1 deletion(-)

Patch queued, thanks.

