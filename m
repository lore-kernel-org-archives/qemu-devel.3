Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFC8C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 08:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiqea-0005PR-0Q; Mon, 04 Aug 2025 04:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqe2-0005E3-Pd
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:34:20 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqe0-0000Ji-CB
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:34:10 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso24542355e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 01:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754296447; x=1754901247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x/WfSKRonRXsvo37zCvQV7CedRXawAyyZawGAhUjX5s=;
 b=UFsgKc1/B+HJgBlW6p6nVC86qabxTsTEB77WNERBaxlQmK7DM6OWYxgEgd0gwUvAWG
 as5fv0Prpfn2fPYeXZxy+Vi2LaZTQn1d5R+qfRcM+iPJQLXt6L8dZ+lfMCz5GJFNPFsu
 b3uW6UsyihfGsDOeQECR6qH647632A/at5elD3FX7F+lB8CG7xGF1ItmAM35u0gjkSgG
 dSDvf3Wp47V9MAQxHbZGftgWlnMmqxZKZsjrJt3B41O9/yMLc4SXbQwshrFRMBQ191Kj
 PcZqEfid5olG6EcHBTjM0I+h9dajlw8tIwGebC9uSmq3r8O4/cptMZDP5aeiELBhhSq9
 /3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754296447; x=1754901247;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x/WfSKRonRXsvo37zCvQV7CedRXawAyyZawGAhUjX5s=;
 b=jFTZNJUjhaMf3sL/nPtD2i/f/91JIv0x+NYbrtAsOMjo5O/7zXacRjfKklV8xG2LgV
 Tp9v+NUpy0lkYFeFCLJ5hXCbkOsMjPNvdAVLJp849B88m19WaGdGDvrNjrXAEut76KIE
 u/dcFVVENLNtLUuEjTEBT5VxmGpfoCs1h6Gs8WCTVjCjPk4dvsPui3KJmOUX6Y/NQCw6
 WKvAUeGAa5MOnWP0fJCuxqWm7jFzDCJstMR73zrk7z4Wip06FA8kbvPKYHL9d7Sqh1Yv
 40N5AmajtCPHTTtd1ydlJPDnN1+SKzbDpB0ykqkl97FSLh/65xpIXpLSpNsiQf877QzG
 iCnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+SFFMB8ou8EXQXSC/MaPZ2a7+TB6PzE5HmVswmX1vyP+ykdzLekjSH/u40NAW+kHKBLo+FErk+fJT@nongnu.org
X-Gm-Message-State: AOJu0YwJ7Co4bTMdEpeARbVtkBIEHtS1nEoha/v/r0RQU14IjXtM4CdN
 NYScQDB6zh9blobtcN8B3uTKO0BwBCL4A0WBCYWGmNSI9fyUH2qZ5KF4NBIOgMtOLuo=
X-Gm-Gg: ASbGncupxH6kKX0pHJ7N2yhW4QfoRrTUnhSRfRTh/Ml3ayux2bLHqkR8OU/0ZZc3wwL
 gUgiwNTLOqsdUXtr1NcPhE0xP59pYY+M3vJ8ua8YKT3nMhgrobScdiUXMtaUW/9ZDdLjqKgXLFM
 z2dgDK4243QPDeNDBTR7tP4VvXzkhRYXz2ATM3yqwlhHocouU2GL725rRcN6FqQAYglWCNTeGYT
 p6A4kIsiyT3dBOnPo/83gALjHZvf8QOTJxo1bLCrOh4DRW70trfvooGXbocEK3anGipGshmpfso
 Y8zNBpdysflbfV5BXC+qR3RLpSdLpVUmAny+3xgNk8mlu/0ChP4D6AUWK1nErbRj3N4WbZwh/Ij
 ZHONWRzxRbgVS4VBl2FRcme47iA2q5ViasDBR5Pz8Nz0vM4GkHNYNM0eveZcR9KXoWVtqBuc=
X-Google-Smtp-Source: AGHT+IHnhqQXX50natA9ygtRXB4+D8IXBvp7YLffUIcmwXltoYmaU/7p8EaxO0Io7VMEDPm9veuqdA==
X-Received: by 2002:a05:600c:4f56:b0:455:ed0f:e8ec with SMTP id
 5b1f17b1804b1-458b69ddf95mr61171245e9.9.1754296446717; 
 Mon, 04 Aug 2025 01:34:06 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459db13fc9fsm26660145e9.7.2025.08.04.01.34.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 01:34:06 -0700 (PDT)
Message-ID: <39cbef79-1412-4076-a43f-6392a76e29ea@linaro.org>
Date: Mon, 4 Aug 2025 10:34:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/24] tests/functional: Move s390x tests into
 target-specific folders
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
 <20250801151251.751368-20-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250801151251.751368-20-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 1/8/25 17:12, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The tests/functional folder has become quite crowded, thus move the
> s390x tests into a target-specific subfolder.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                         |  6 +++---
>   tests/functional/meson.build                        | 13 +------------
>   tests/functional/s390x/meson.build                  | 13 +++++++++++++
>   .../test_ccw_virtio.py}                             |  0
>   .../test_pxelinux.py}                               |  0
>   .../{test_s390x_replay.py => s390x/test_replay.py}  |  0
>   .../test_topology.py}                               |  0
>   .../{test_s390x_tuxrun.py => s390x/test_tuxrun.py}  |  0
>   8 files changed, 17 insertions(+), 15 deletions(-)
>   create mode 100644 tests/functional/s390x/meson.build
>   rename tests/functional/{test_s390x_ccw_virtio.py => s390x/test_ccw_virtio.py} (100%)
>   rename tests/functional/{test_s390x_pxelinux.py => s390x/test_pxelinux.py} (100%)
>   rename tests/functional/{test_s390x_replay.py => s390x/test_replay.py} (100%)
>   rename tests/functional/{test_s390x_topology.py => s390x/test_topology.py} (100%)
>   rename tests/functional/{test_s390x_tuxrun.py => s390x/test_tuxrun.py} (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


