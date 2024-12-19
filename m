Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE4FE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 17:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOKMT-0002WX-QS; Thu, 19 Dec 2024 12:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOKMB-0002GD-4p
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:30:52 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOKM9-0000mk-6P
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:30:38 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361c705434so8154785e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 09:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734629436; x=1735234236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FHozw9de/NvfPGX8IMwamoRKsGIkL6+8Xqk2d+A6kH8=;
 b=CcCtx19mwkiZsmrFiDazZqemFPagJHRZF1rKKne0zeP9n3Z8tOoYuor8lQDRL+4hAj
 P8tvS1w6Pkuxkw+12muuj3pX43Aj/b7BmvedFXiOQbBOMRoPNbKbrc8FsMEQ3cdZ1eJh
 De0QezrPSJiOcN1oD0XP5PsQmRt/kenFMirFP6UE8v3vkRiGmPFH/h3IkFHiPbemn4XX
 eU4PDNh1096WqepEsZ9qHtXC1l/zZregPLunbDdoGTZzHwsygOPQ76C4DYoguFYlv47R
 qqBOP6qYdKzDjZ7NVEa2cgc0y4TesUXn7ygKQ7Wd0okIn7wb+ofbdRrMyVkTotwDrVB/
 KtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734629436; x=1735234236;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FHozw9de/NvfPGX8IMwamoRKsGIkL6+8Xqk2d+A6kH8=;
 b=fwI2KJUvTM9Zy5yk9VK4NKPtoWrFKdJHy+YiFEVPw2pd2Gz7LB/V/YPOqhFhmMFPV8
 huwBhP0I1C/xo4PofD2bmRYT4aeMYRDeym1Cyv1CNbhNeJHK+ZuEwsjpb8FKxvtF6pi9
 Cb1CV25AzDeaxTSE+IJ64W9RbH9G8jCsdgccsNFT5SRCGK4Jysb9p7mR5e6M0PkKmVU9
 Iyb4UoMbgVPPsnI6A2GZcD6uPwFyb57kULHGYIiZoMh8dxSnTJFwJ+IzJ4tGTShbq2VU
 h03h40Ev8Vmpi/1FAig4RYb0vGAkiFi1wxzWPiJ39v3s43NTCoRssLK3wmobMlNvTFlX
 WjWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR3fhhAeuHUemKildzUT2XIMyXUMkOZC+JrdH3f4gT8LYUSSbjaaklTgCcNrK8WgvJ98cGeg0usZjH@nongnu.org
X-Gm-Message-State: AOJu0YyjSzElgHnUAnCHrh72kHFGevhm8cTmL13yFJ/P1t6k5EHb6Hq+
 xmiCAAtiUfbYVCpIfQvvORtjb2LxBWiAj0QCIk8+C2KTeukYId27Ye8cR9lZi+M=
X-Gm-Gg: ASbGncs4/iwXg1hSeB/qWhTgWPhN8fnCZaSjYfrOxluOnUo70h/1pUOsKYUTrvTyHZg
 NCdR63mJplGNoNevrSqeEsODUHXzBdL+V7FFYjG4idtCL7ADIVoa+fx8qx0Ramr5Qmo8Lzxwu7e
 RP8doPm4DDLc3W1vIHP739RMpLmG1LDjnXoAF1KQsMfluYOECBxAyfkgf2ojRqYzZn4umRZBXh7
 9NiOfQRdfJLLuj0wfzCPtFt/7prwhvXLnpzBN4pTadmItHFeN56fCxZjRMZgM9EpVfZ5xU=
X-Google-Smtp-Source: AGHT+IGMc+NJHehstVIw9mDm4wDLjS2kb5W2EfaT3IzYxpHnuZGrK3pbLa5r2CQOFSJkffQaSuW2Sw==
X-Received: by 2002:a05:600c:468a:b0:434:9499:9e87 with SMTP id
 5b1f17b1804b1-436553fe17dmr60200645e9.25.1734629435607; 
 Thu, 19 Dec 2024 09:30:35 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611ea3d5sm24177795e9.5.2024.12.19.09.30.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 09:30:35 -0800 (PST)
Message-ID: <e19caf9c-f8d9-49dc-8ac6-26925400d9cd@linaro.org>
Date: Thu, 19 Dec 2024 18:30:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/27] util/qemu-timer: fix indentation
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-riscv@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Beraldo Leal <bleal@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Weiwei Li <liwei1518@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-arm@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-s390x@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20241218162104.3493551-1-alex.bennee@linaro.org>
 <20241218162104.3493551-17-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241218162104.3493551-17-alex.bennee@linaro.org>
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

On 18/12/24 17:20, Alex Bennée wrote:
> Purely cosmetic.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   util/qemu-timer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

