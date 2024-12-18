Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB07CE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 17:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNxW5-0007Zw-E9; Wed, 18 Dec 2024 12:07:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNxW4-0007ZU-M7
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:07:20 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNxW1-0003Yw-TY
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:07:20 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43622354a3eso47090775e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 09:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734541636; x=1735146436; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=84Xp02vd965R6EVhlhdL+FhhEbC0vWzwkssxj/nxppI=;
 b=rurhmHGW5uTIQDT7jMoSKouI/m2r+pOoRWpgvk84PTq7q2dvNtFoiI+XrTo/R23l5O
 4a1dVHQqxb1t+ifUlQfAl0bVitbSZ7hEHzuR+PL/XajCrm6VV7t3cIJaeUnvSmVgd9qW
 H5a2/HageUNGXkRAf64cCdBNdv4B+3NB1mz5WYmAfoqz5TfbfLLbwn4M49+YqnVhWIzA
 XmPmWw9sTYQzE6HDOSmvrpmVAxyM+VLJqeYmE6skQPIsdG0YMrAg4wcvbxSOdlOV+gKg
 fQH4w+RnqbYYVEJt/eItr7DIImCiJtk2DbFdhSPUjvhDFSQuHCPDhoseBxt3J6KWfg/l
 vEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734541636; x=1735146436;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=84Xp02vd965R6EVhlhdL+FhhEbC0vWzwkssxj/nxppI=;
 b=WEzrOVh+uLbHaLBsg8c9TfR63WOvDgWpzZzuSce+FTNQwgguRx6OYFjxaI9TTXAx3Z
 iOrCmI1pld4kAvPJE2w5C6QZtcoGZ9ZBCp2T4fcLIzJipAvHADol5Q5xwDfNR+3wWvb5
 HORVQIvadlSXfCtTj/YtmpBw4wDw4V0+J+ICFqo2x36rTKxkLEgqViKwWZH0CYWH/STw
 0WAfX9g45NtMCVc6shvpVx+JTrAxaUrPFj3rlhYEg5WoEDQ+TjG8Bzi/Qn8HY9tYk8F+
 NmY3cs2RHieVESNS7bAh2vGdu9CQYJZ1+tDO23uv3XOW/A8/NppdBwAO+i1n5vQBS2go
 EU4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2KPSVgNoTYRQEuFnuH/42yfCot940/Lev7zJ2/WsPtdRpCBWkqVBGz5khwxjg3LNmRQ0GrmQVxoj/@nongnu.org
X-Gm-Message-State: AOJu0YzOdRfP9jM7e85Hcjlq3ZrESB+HE/3iG3jkdjhQ30t4Btkmb5WF
 D1O2gHVrTl46zB9zIMVpImiyKRZ8E2IC6dIIPQkM5gLjsvmEeCgy2Jhl0Q2bdbc=
X-Gm-Gg: ASbGncsWeoK0GU4T7Y/efQ+O1WTEIdHOUazpmtOrwlnIF2gwlDYDPfFIcZogiKDc4jA
 ClOvUEmqs26dm/ETZoHIYJfyPC4+34VPSBdeFAC2C2eQt9X9Qex+IKRIWkAa1m2DrGh58Fr+lIT
 7r0JUYBQ7jn6VJKqgwW9zFO6YJY3j/m0Lq/6kp1qM0bpKLcVPFW0GhyrSVj4/EzrxuE8BHtuqfh
 j/cUdX/ts/RDFltVPH+eA8bF5waL3E0zzJlWBs735UICyZhVEvNcUA1vf++dwbjeFL1PFnl
X-Google-Smtp-Source: AGHT+IEgBsMsJq+hHwD0O44Y0o0aaOd3ofWzK08cLIPdBnnYipgVFHsDw/GjhdUOmRJDYKCm05ZQaA==
X-Received: by 2002:a05:600c:4fd3:b0:436:346a:fa9b with SMTP id
 5b1f17b1804b1-4365c7c9707mr97695e9.20.1734541635603; 
 Wed, 18 Dec 2024 09:07:15 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656afc125sm26909535e9.6.2024.12.18.09.07.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 09:07:14 -0800 (PST)
Message-ID: <f4988fd0-62c7-41ec-baab-2433aee78f04@linaro.org>
Date: Wed, 18 Dec 2024 18:07:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/27] tests/vm: fix build_path based path
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
 <20241218162104.3493551-25-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241218162104.3493551-25-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/12/24 17:21, Alex Bennée wrote:
> We no longer need to go into the per-arch build directories to find
> the build directories binary. Lets call it directly.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/vm/basevm.py | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


