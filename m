Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46F1E6FE47
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 05:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smoFS-00078A-BC; Sat, 07 Sep 2024 01:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smoFP-0006v7-37
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 01:44:35 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smoFN-0002Gi-Mj
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 01:44:34 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5365aec6fc1so1371241e87.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 22:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725687872; x=1726292672; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=soCPIGr7yuSltBprg7t/kM9Cb4es8bfLgfTSaamqsHY=;
 b=uBaZdtuzHLERxSI5vBrj45PJ82uYJwosYm52hoB00juUXOcXmYF6ALHZ/tlTBbCuik
 Qa9GBnfRxJY5vo7Oca3XY0mixdoxWGbzbh6dd+oVIu4ey1MxKTyLcQOFI1axIiOWvmXv
 iKcgYnURVD0McGRe60kPSoLT1gd+BSoGIrlol596OUVQlixRUATTl40iQWX9HU6SkAqF
 JwYfWzC+dZXXQI6rnVZdZA2B+MINkkpRTaVi33GpkUq2nGA77DS8ZWiuteOZPeCiD3dF
 lzYtyV11vwv+JU6cOtLGTxXAxUY27COdHFgL6VM7B09PUkDaowiMbKaUvAstWLr63tqC
 1sEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725687872; x=1726292672;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=soCPIGr7yuSltBprg7t/kM9Cb4es8bfLgfTSaamqsHY=;
 b=kpAugdnbFYknDQrifoIL+f7Nlg6c+f5T6Luw3BtaJDmuw0aCIKgOMs6uMNcA2/olNn
 a2DLmt+n0mQSi+wqQTa8s6/LMxb4GBg4ypkQyaAh144V2EUOTZ+AQa7kP+Wd0PIKmfyf
 LsrBG1N00psLonQHtmh6pVObBn7XrkmT/0p3O30Pbpmo2aMsUew0KWDQHzpMdt1fRSKS
 Yjoda9yA6wRyjVRPemQUtU7y/g3r9/S0s8N4fS+RyQFJr3eg8HgfJUtRdTG6ugKtDXAW
 8pWc4A3+BRUNhTHHCmN9nFnW36T8n4FsV+CqYOgD6j0TngWmovj1eBNWQ9QrThU8mGsK
 nZKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT24+FtLkMOYxUMt2WjVLe/YLoXF4bsGIGoEZ63MwBZopPT7Ur2pai0kDKNgt5UEsFsieDPsXQhTXt@nongnu.org
X-Gm-Message-State: AOJu0Yw2BVImPQqO+1vE+aNmtU62PfkcPUiqSCGg0aOEmFCjwQzXz0Hu
 X+Ns9oiAs5+fGMJi+y4CWQ7zNvL6L1VleBeYq5YDtsRFnoZe7CMH/lgTREdh3dI=
X-Google-Smtp-Source: AGHT+IF3PkQ9QwQgK8eNLVTMTw17Hov9E8UJfqwGbKiefru64IjGLnPtFMK6rSp4AMpZnDWv9JQ2/A==
X-Received: by 2002:a05:6512:3c96:b0:52e:fc7b:39cb with SMTP id
 2adb3069b0e04-536587b4153mr3326398e87.26.1725687871993; 
 Fri, 06 Sep 2024 22:44:31 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.174])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25ce9732sm29995466b.151.2024.09.06.22.44.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 22:44:31 -0700 (PDT)
Message-ID: <9f4cba51-5aa0-4942-a7a0-6bd3eb29a7b6@linaro.org>
Date: Sat, 7 Sep 2024 07:44:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as a reviewer of VT-d
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>
References: <20240820095112.61510-1-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240820095112.61510-1-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 20/8/24 11:51, CLEMENT MATHIEU--DRIF wrote:
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Patch queued, thanks.

