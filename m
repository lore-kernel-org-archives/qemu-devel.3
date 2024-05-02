Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB51C04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 09:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2SdH-0008UE-Pt; Thu, 02 May 2024 05:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2SdF-0008TR-CW
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:21:37 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2SdD-0003iu-MA
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:21:37 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a5883518135so855159266b.3
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 02:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714641694; x=1715246494; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oAbYGWt5zjYYzH2pNkpcFQLfB9E0YHfm9bg1vc9Zmw4=;
 b=mxbHvvf+K+1ZjrtpUza43hR8A8Fr5p4kZYKunmIeReKTPIMk3F8loL3VTV81kd3wno
 0YznCpPamDWg6qkEuOuQrssMCNzyAf0gazHblZ7fj4lnZr5vffCmt/Q9LFDJbi5PUCsh
 51Zsbp2mFySWj4H3rVG+2JLbHJ/Ll5tZp19SUwoKgdNq8To/MN/In2cTgEQAdOQj6C4c
 5LjPt7EfTDz4nMkXiHC9AFPncw1u6MB8ATgroDhKu5NXRiNDrrktmpIkRT4GaNKGREXg
 VM9/VnUweOBv6geKkqdTfQUloLJ/ipaErsvMo6qcetGdZO6RYSuowv5UuSci6/w6mqZs
 nnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714641694; x=1715246494;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oAbYGWt5zjYYzH2pNkpcFQLfB9E0YHfm9bg1vc9Zmw4=;
 b=V3EACo2TDAQNmr7eU0S4hZHUMKBuhbThmN+Tf/P3c7gLdk2Nk85vkYEQmYxQJvlPvx
 zNxbaDxspgnf5mnXLoGc6gq0LlW+NmzwqLNMyKzrS/SX2wLe1DaWVI0D3z6zXNIF39dD
 kMtno8aWrULE5t9YnfzdNoNdq7rl1uT98wN2F4piSvNryfJ6uKffGgBUHoqMbZbSTyum
 8d9TfhGoUp01Kg/uzOvzLaDPM0AUpK1Xj9jZb+ECqFWsnZ+sgVxHFpXp5BOh1pT8Lkv8
 E/SJwtgu8CMjiBOzWuSkWspRyes+9jzzmFHyRDHtKKrKMGcbXWC8rBrSE1aiX/7lIi/d
 t2hg==
X-Gm-Message-State: AOJu0YywUxaY/6SsYnB01+pt3yQNxU525dzbT7RsMJuIDORDkF/UXPWi
 1s6KoV8E2WLKPaMjFN5Iaz7vPMcff1m8POvGhl3+hsTYTUwtfNWUuFU3Bnfs0+s=
X-Google-Smtp-Source: AGHT+IHrJKnbMeTLPbEE7VovkA6bkUcRbHwLK5fxk24Frv+I9oTgnEQAKGbyIoPFpa8PXsFOJvRzfw==
X-Received: by 2002:a17:906:f84c:b0:a52:71bf:925c with SMTP id
 ks12-20020a170906f84c00b00a5271bf925cmr3356256ejb.62.1714641694075; 
 Thu, 02 May 2024 02:21:34 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.215.106])
 by smtp.gmail.com with ESMTPSA id
 bj22-20020a170906b05600b00a5903973662sm323410ejb.29.2024.05.02.02.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 02:21:33 -0700 (PDT)
Message-ID: <fc6ef6ae-f380-4096-bdfd-094d1a7a3aaf@linaro.org>
Date: Thu, 2 May 2024 11:21:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration/rdma: Allow building without on-demand paging
 support
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Yu Zhang <yu.zhang@ionos.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Jack Wang <jack.wang@ionos.com>,
 Li Zhijian <lizhijian@fujitsu.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Galaxy <mgalaxy@akamai.com>
References: <20240502090547.87824-1-philmd@linaro.org>
 <ZjNYhGQTFBQHZgga@redhat.com>
 <8c487804-a706-4149-abb3-c2495247f09f@linaro.org>
Content-Language: en-US
In-Reply-To: <8c487804-a706-4149-abb3-c2495247f09f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 2/5/24 11:19, Philippe Mathieu-Daudé wrote:
> On 2/5/24 11:10, Daniel P. Berrangé wrote:
>> On Thu, May 02, 2024 at 11:05:47AM +0200, Philippe Mathieu-Daudé wrote:
>>> On-demand paging support was added in libibverbs v1.2.0 in
>>> commit https://github.com/linux-rdma/rdma-core/commit/e500adc7b1
>>
>> That is 9 years old, so I'm surprised any distro we target still
>> is so outdated. Can you say what distro you're seeing a problem
>> on and what version it has ?
> 
> This is Oracle Solaris 11.4 SRU, released 2 weeks ago:
> https://support.oracle.com/knowledge/Sun%20Microsystems/2433412_1.html
> 
> I'm not sure how to detect the version, I'm seeing downstream
> patches applied on top.

Regardless, we can't expect any rdma library version to work,
either we ask for some version, or we check that symbol is there
and reject if not as "your rdma is too old", so the user can
choose to build with --disable-rdma.

