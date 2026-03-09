Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA72F3C269
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbNJ-0000tK-HC; Mon, 09 Mar 2026 10:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbNH-0000t8-Kg
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:14:24 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbNF-0001Dq-UC
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:14:23 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-439d8df7620so2071909f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773065660; x=1773670460; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gRecQqM7Z/ouMxEManEA9yBySlCjg1jb4derhpHpPP8=;
 b=TkMTbIXLkfKJioRckfbl1mGALCoTONigb8jVejRC8zDMOi3TImzx9rfSLQVMyOZgQN
 0kzd5Rmzq8SqtD9La+BealyTr/tGuWyEUlTfbgtLxtIHej7WB4lmhwnUcmkoQ6lWMfN7
 8iXRCiKF+benc0ECj92CgM+vHcATUd6VzpoKElKO7wSXtEIiGPzjaHdnLOOLSVRJBfqB
 yWwuhObo3oGvDOrk1kXTtWiWn/FZ67YH6SwxGarDyuXYlnbWs3B7zbVgfxuFyba1NpgW
 iONANKkcWrgr5DgTbY8ExpM2WZ+puIZfPhTDn4/Ekl/w+AxynTCW4aM17RSHjyLGVNja
 KwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773065660; x=1773670460;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gRecQqM7Z/ouMxEManEA9yBySlCjg1jb4derhpHpPP8=;
 b=bF5h81OWST8MiO2sUqaFB+exozEOrhJi8JL6xnMj6lzC7JZCvxRoTjTv6a3HBiQxND
 yzpBYyEL6KVPAht0C22iqAjrEkn645bvMcfetZd/V+X1FREzcxZBO0msH6UdRVsSVCvy
 uNsu4uyBEEGHG2B2DIWB/c33IgPnEiWgbjitJqkxjveGS9hPH0bcevy12ja46luCWUb3
 +dCf8WpfIQ5Znh1iMsJr4ynnyITikJTXA4paW8IwO1ACoCwvYOXPknXtP4mG2EKL5zi+
 9IVs9w1m6WszsY+8iOhNRWykBBzjccy2eB0D/JMSPMJpuYuOXsqkf/JArr09ve5MLf2O
 joCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVIeZUBGp2BO6y1YOWfOTnSJGq5cw4outlVC1qrpOrzJMJXUtQFbARl08mHBnPW5b1BqKHEIK5RMn1@nongnu.org
X-Gm-Message-State: AOJu0Yxtf5mRmhQt1Yxbf5pHTyy0CP2Kt1J298cO0wF/ymwuWvAr6Ijs
 EruJZoCxQM1buluSFM13tH1DDOayTyOE7sJaAsiZ/GgAviRiFo32pIxGltLtyNPIdGc=
X-Gm-Gg: ATEYQzy2ICJvHwBpoM2hs91zg+PJh1ZYSpyBiPU/cg8N4rlCPZHHKhlgT3slKTtL1cH
 qxFgtQ1Eb4Y3XpANCaPOz5KPUm0CH4oCwd/9vgVtoh853qbCQjDU5AGrQo+SRKt5lkf3LySc/sM
 N4N9rrW4f+LrroACmtbsAAcmX7rZ3KZMdLfUEaYbETZqHW+riCr5/x8YaB9uXrYZPrX1FX/ceG1
 BTPtQa5e43dmpSnHpkuwaIk4GSlVa5sbrkS55rfWoHWeYJkDOGH5qRumrCS+kItycqEBWSywGHD
 1jhyHvpRWIoEn2wLpIXBAqn6M7slUhjD7Q0X1HWlGXsPgLBjNCEEyBTppeOl8tQ9jMgre4Xcqj3
 ca9RfCywdrC094uLBYp1ifk0cjYYo/YmxdMJuRVfX20ifTuoPjj9/18SiPvbZckTO0qlIeUBbu6
 GBZx99Pzq+uKv0stLJNE8fVotnqBJzPpffOVu4k1TODTed1uNEaseCQaLXw1fKJzlavPQPkpE=
X-Received: by 2002:a05:6000:26cc:b0:439:c550:d920 with SMTP id
 ffacd0b85a97d-439da895078mr19056546f8f.47.1773065660141; 
 Mon, 09 Mar 2026 07:14:20 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae3f267sm25629467f8f.31.2026.03.09.07.14.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 07:14:19 -0700 (PDT)
Message-ID: <74e2838b-d950-4153-b035-0e6f0a0cbf36@linaro.org>
Date: Mon, 9 Mar 2026 15:14:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Fix use-after-free and make format overflow more
 difficult
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260305-nvme-v4-0-b65b9de1839f@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260305-nvme-v4-0-b65b9de1839f@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 5/3/26 07:16, Akihiko Odaki wrote:

> Akihiko Odaki (4):
>        contrib/elf2dmp: Grow PDB URL buffer
>        vfio/pci: Grow buffer in vfio_pci_host_match()
>        tests: Clean up double comparisons to avoid compiler warning
>        meson: Add -Wformat-overflow=2

Queued, thanks.

