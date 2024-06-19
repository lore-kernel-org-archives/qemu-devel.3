Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C602C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 10:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJsGF-0001Ly-6a; Wed, 19 Jun 2024 06:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJsGD-0001Kx-U9
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 06:09:49 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJsGC-0003z8-7H
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 06:09:49 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52bc3130ae6so6790841e87.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 03:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718791786; x=1719396586; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kPIiuV9XeMyFnlI7yPEVH3ZhnTArwk4geNowAafyMSg=;
 b=d5lHgxOhKF0/2eeyrM3E4Kg2fsooilV77zH9P0LADTy83v5iReNnXYq3CAXBz2f5Tm
 9J/rSMYmja8q4OL/1NPc25QewM9YUwUQDYlXx/nC8eOm/KmXC9etRhJXuA+FxywCWkWH
 8XDJJdBZuEXOUJ16BD1SLioON5W9YIw+nf7MdA4sw3iV85HG3ddKvR5s7TQabxD6TvDn
 fh/WgeB2KJXNB+Vpid8NIKrGan4GIyjt37KGVAPgAKN6VyE8KzmiCAWHlg09jGx2CCp1
 hd4WwhxpDGLA7ojOI5qe6PDXyIm+uNO7q7UbQbTl1BzRyGGOP55u82nNMnuZffWBJRcy
 DUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718791786; x=1719396586;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kPIiuV9XeMyFnlI7yPEVH3ZhnTArwk4geNowAafyMSg=;
 b=ohXoMGMVkC2oZ0MZNXEJzi3ZC50dlWeLSDh1p96GsX6GPI/D5Lxdyy3KMGTkIICwiE
 CLAMvfvf2xdcpCoz5J3ma7k2ct/W1byzzJ1tnPEJ8kIMCznggzzClxdVbR655cwQIpXE
 vJzx/7GRqh65Ym02S2Ye7Tp3ZkGe6GIeREvitKRpIx1Q0pgzXRVMTBjJK1MB5BM0ouTI
 l158mUBUpfMijkSenJDRhebmC5GxpdVIhcyUfzx7aKC9NLdy/IrEx1Yo4Njjb/yVGhGA
 /xcbbsc9vYSkxZf1G10qM53ZWSZNwb4V4u5TUe8lgblfm2JDYGAsTsGfWH8chxyAM09N
 T2ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrpOqnVh5YXAp3nwMkYNlbrFhRcsVswsu0xxfxVvdJISmBCkt/mmijbgFbsyikbvggnoyC/GBNfCWMndFB7+qJWHXC5Xw=
X-Gm-Message-State: AOJu0Yzz9Fl2eisysQZ4ut4nDwRmV0sNTKj7SPPY7rb2QaEEl9rKKD7w
 +QtrQqmH6IdmXwRRZ4ARCqP5yjjDloXb8ra3xVC/eXdLDV3mh3+CHUfHMPYky80=
X-Google-Smtp-Source: AGHT+IHtvul+7qlzmcDx61BMMq9v/cZ8VsNaawFpi8/zc35J3FrKjX0cAi7HwaUTchQSBV64MduwVQ==
X-Received: by 2002:a05:6512:b16:b0:52c:a809:62e9 with SMTP id
 2adb3069b0e04-52cca8b4c62mr1572792e87.0.1718791785888; 
 Wed, 19 Jun 2024 03:09:45 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.133.105])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42286fe9230sm258161305e9.17.2024.06.19.03.09.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 03:09:45 -0700 (PDT)
Message-ID: <661fce24-5d14-4483-ac0c-f88b7f3cb997@linaro.org>
Date: Wed, 19 Jun 2024 12:09:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] Deprecate the qemu-system-i386 binary
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20230425133851.489283-1-thuth@redhat.com>
 <5fc11d22-275d-cc8d-bf9c-f1c015cbee23@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5fc11d22-275d-cc8d-bf9c-f1c015cbee23@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

On 26/4/23 12:59, Paolo Bonzini wrote:
> On 4/25/23 15:38, Thomas Huth wrote:
>> - CPU types have different suffixes between the -x86_64 and -i386
>>    variant (see TYPE_X86_CPU in cpu-qom.h) ... do we need to care
>>    about this in the new qemu-system-i386 symlink run mode?
>>
>> - The code in target/i386/tcg/sysemu/smm_helper.c looks like it
>>    maybe needs a runtime switch, too ... or is it ok to leave this
>>    hard-coded to the x86_64 version?
> 
> Yes, it would have to switch based on the CPU's LM feature.
> 
>> Anyway, I'd like to get some feedback on this idea here... What
>> do you think of the idea of getting rid of the qemu-system-i386
>> binary this way in the future?
> 
> I wonder if we should take this a step further and rename 
> qemu-system-x86_64 to qemu-system-x86!  Distros can if they wish create 
> symlinks to both qemu-system-i386 and qemu-system-x86_64.

Is it simpler to *add* an experimental qemu-system-x86 binary, then
once it support both i386/x86_64 modes, remove (symlinking) the other
ones, or rename qemu-system-x86_64 and start with a symlink?
(I know we are very reluctant to add new binaries due to distributions
shipping them even if experimental).

> Then we would name the CPUs "foo-x86" and alias them to foo-x86_64 and, 
> if they don't have LM set, to foo-i386 as well.
> 
> Paolo
> 


