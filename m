Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884F1CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 14:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruCVQ-00080i-6s; Tue, 09 Apr 2024 10:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruCVN-00080V-44
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:31:21 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruCVL-0001Xd-CW
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:31:20 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56e6f4ee104so1511430a12.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 07:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712673078; x=1713277878; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SWeaZ3UzNtUymQPKimedE7d1DoRZIeh2HZSCfAJ0WMY=;
 b=VHVXd2AB3Qg8rgC8UA+VfmsKvrbnT3P1PQFyfEgUxSO2xOrr8oXJF0z5gvbCFcq1J2
 nDfsq07zrhp1qWMo1qKMnV74kuaZaAm01aN3kYPAGEPmjZl2xZE2DyCHsTxCvIkACfkO
 gBYWfR0vfJUNsSZO3yo0URKLjeM9OLzaqbNPgsot+g6RLK4qk9l8XvczJvmCCWpPKQok
 nKdtU1yB2nZSN4+6Gdl7d593+LOa+prOShW38hVfMAt0kTtSkIS2q69/gVSvz3x1jfVf
 Eob35ChkHeGuR68OPigmo5kIIR0YxlNAhRk4xufEUQqqQiaYToRC0b9I2/1PCVSCIHry
 kbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712673078; x=1713277878;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SWeaZ3UzNtUymQPKimedE7d1DoRZIeh2HZSCfAJ0WMY=;
 b=fzw+y/pcZKlLM/QNvACLOLfQDwNh+9/pR/8IZtqowpla4EkTKJ47/JSgauAzoXlD7X
 oo5nVslo8alDimi+PS4qAWzKmKEITN/rI9JaxKwCmqoi7VzFQxDumzD9YRSnoihlXBmj
 7qHSOKSirhJGF5KvP8n5DFzRHP7g9V2vHX5vi0ufFBIZLxk2Wu9P5ciALeTBSm41O0cB
 KG+ENslKoxF6UOMKDjOIs9ctjW+CCGxmjoKL5s57IGllCKOsd9UBZaAoul6/z0BE8EpW
 jgGzSvV79Ak4Koc0oduSyJb+JLFJ0mRhT9oIclfUItpA83Y36ZlTjqlUM6Eb8hXrKCJk
 r3Cw==
X-Gm-Message-State: AOJu0Yy+H3D4tQbRazo/E9J71vNQQqhPmnx4SFJ2lBf2VgJrNFDZC6gH
 XpUrGJVIsL3QlPA9j2w8j8LEyN/H1dVn7AzpSa2Ks53ut6oUAJjMp8QSBfJszHI=
X-Google-Smtp-Source: AGHT+IH1yurl4/dQIdvZ008M3dVx5hU0TzLMpy+9JzGyIMYpmWL09QX5oUYrdOXQ43Ug6SrGzu4ULA==
X-Received: by 2002:a50:d4d5:0:b0:56e:2f39:c5d2 with SMTP id
 e21-20020a50d4d5000000b0056e2f39c5d2mr8655944edj.7.1712673077676; 
 Tue, 09 Apr 2024 07:31:17 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 b93-20020a509f66000000b0056e0376286bsm5468010edf.24.2024.04.09.07.31.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 07:31:17 -0700 (PDT)
Message-ID: <678996e0-6920-45b0-a37f-6f6fa1bf1904@linaro.org>
Date: Tue, 9 Apr 2024 16:31:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 v2 0/3] hw/block/nand: Fix out-of-bound access in
 NAND block buffer
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Qiang Liu <cyruscyliu@gmail.com>,
 qemu-block@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Hanna Reitz <hreitz@redhat.com>
References: <20240409135944.24997-1-philmd@linaro.org>
 <ZhVOGxCG9zfludIs@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZhVOGxCG9zfludIs@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

On 9/4/24 16:18, Kevin Wolf wrote:
> Am 09.04.2024 um 15:59 hat Philippe Mathieu-Daudé geschrieben:
>> Fix for https://gitlab.com/qemu-project/qemu/-/issues/1446
>>
>> Since v1:
>> - Addressed Kevin trivial suggestions (unsigned offset)
> 
> You already kept the Reviewed-by tags, but looks good to me.

Less work on your side ;)

The changes seemed trivial enough to keep them, but better
be safe than sorry.

Thanks!

Series queued.

