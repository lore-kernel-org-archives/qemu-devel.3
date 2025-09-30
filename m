Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808D7CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VJo-0006fh-81; Tue, 30 Sep 2025 04:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3VI6-0005T2-WB
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:00:57 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3VHr-0000re-16
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:00:52 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso4359798f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759219233; x=1759824033; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qQCDKdcXs3mVaLepnz+ss4TJuz/AP/r/Ob1RAeTW8yM=;
 b=SHR0ywMmbxCar+o2oEEBE2Yk4P6095Mq+SBUYWeMxwnM7rsodOCSYKb09UjaKM3Jwa
 /3FsY3zYLjMjzz193IqDqZT2/QU28py4Bco8SbLXPqVBhmggrBkeHxBv25X5rwS/OSZb
 cU4TmPDeRQ3OC53HjH7L1/fvfSAbiSEspHpG5v5xhtIY0JT1xUVgjJogULHMnDbgFmic
 Q1tWLessOAENjm+o6AvsU4mDp3rNDUY3NviFj+DjGUjCzD433lPkfXVQcfpt7VHHvut1
 ng9fktP3Ryu4f0IK8IKOUzFOlrS1bHt5jcEBwkrjHdhTqZQ9dv+oojlmYY0Z2QHn+mXo
 Iscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759219233; x=1759824033;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qQCDKdcXs3mVaLepnz+ss4TJuz/AP/r/Ob1RAeTW8yM=;
 b=XRAnQE/4dZXaJJhxxuT9QYKiRY3xUz95gkAgcqXTaSBj790u+x79VX1h1jJhCtcQYB
 ZTB+ZdxRKepPr1gwYCY5XoIU54vURuCBXFfr2+mosCaAszku90zImMb7hrOKhgTohQhY
 ZDy7slixcVfwq3/ZGAJBUZe3cDhmDCnu6JtCFteOuaBmdj8dR6Scu5u9GMWnaX10DTlI
 vH7gpt1Zg2ysLAlvkJa8i+Vc4Z5ZwKgbDEswb6sv/5rbFd8SZyHbQWmPL6euFwhdyKRK
 hODfTyMhqCU3GAdHTau7ykjygMcNM1kS703ar30g7bZACV9vu6+QlhJmf6L/YVvxv9kc
 W2EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtcdGiuCsl9XYvNNtZ9tFuubx1na7QYC7vRQdCJxVPVfFmzdDPxFWPj1AJrqy3io4R6AgTfGuIxBYA@nongnu.org
X-Gm-Message-State: AOJu0YzOL9dYhVdHhgLdTTsh4Ga0sSJvtRwP30texIebhi+YXKdEDNc7
 WkbBJ+uJC82CdGzdA4bBAw7ip15BjAi9TIyBaxOcfZa/LjpGxLxhq+GHZBzAlpk2aHs=
X-Gm-Gg: ASbGncuI0wHxk0/FRQepkhwLzzGVGnYe+OPGCSqjEFiraw6t/1GjsvHGxK0Im/xxWCh
 T1fup3uOQjHvt8AOuJ29ZzmtdIqwJQYSsVNtjkqGwzyUC/exyMLay8VWMb/E1vg2CcDAXgc50zW
 OcorUYuPMDPTTBxEiDRZPxpvGsdZZn9h4m6sqYTok82qDtr0/WXFh2tZR+Q7i19dQ8pE+k1R0+N
 sotU6ZvrPE73zczaerYJaGQ1uRMjAsEKJST4OGN/nKHp7YwuckJj7hMYfKi+ldoQ39c/1uF2W1O
 cym18mCTuxCK3BwaAsp5gLW/6fhehtqxfkd8FAzHI43J0jGh/4MPGGsHZRptX3wFtGV9ay4VJj2
 ABYa8kqtABa0Vr7lDIEE/EJEl3jocEMByB7apIXyt21Mu6g4p+aAr/Pxvsn5Oh3e+DTsVIO4XFO
 Y4VHtu3Gm41cG4quNQlHZKDwGKD9bbWuwUiDo=
X-Google-Smtp-Source: AGHT+IFoppn58DEl50aWpaOnqx/cEm3HRbP67s70C/Ucry1yukNCbcikDdo8azKuJ8QMPZm29sNPqQ==
X-Received: by 2002:a5d:588a:0:b0:3df:22a3:d240 with SMTP id
 ffacd0b85a97d-4240f26169cmr2998754f8f.4.1759219231360; 
 Tue, 30 Sep 2025 01:00:31 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb74e46bcsm21680470f8f.8.2025.09.30.01.00.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 01:00:30 -0700 (PDT)
Message-ID: <94426ef4-cbb6-4d3f-b0b0-e876e020110e@linaro.org>
Date: Tue, 30 Sep 2025 10:00:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] subprojects: Update .gitignore for syn
Content-Language: en-US
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
References: <20250930075351.1853721-1-zhao1.liu@intel.com>
 <675a6965-7c32-4b4d-8d27-88acac0c440d@linaro.org>
 <aNuSUHztLSchfd0o@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aNuSUHztLSchfd0o@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 30/9/25 10:18, Zhao Liu wrote:
> On Tue, Sep 30, 2025 at 09:50:24AM +0200, Philippe Mathieu-Daudé wrote:
>> Date: Tue, 30 Sep 2025 09:50:24 +0200
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: Re: [PATCH] subprojects: Update .gitignore for syn
>>
>> On 30/9/25 09:53, Zhao Liu wrote:
>>> The commit a530a8d4ac39 missed to update syn version, this is because
>>> the code base of its v2 patch has fixed syn version, so that the fix for
>>> syn were lost during the rebase from v1 to v2.
>>>
>>> To rectify this mistake, update the syn version.
>>>
>>> Fixes: a530a8d4ac39 ("subprojects: Update .gitignore for proc-macro2 and syn")
>>
>> IIUC the subprojects is in commit 9a6d6ae8afb, so:
>>
>> Fixes: 9a6d6ae8afb ("subprojects: update proc-macro2 and syn")
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> It's because the subject of a530a8d4ac39 mentioned to fix syn but it
> actually didn't :-).

Commit a530a8d4ac39 mentions "update", not "fix".

The 'Fixes:' tag is helpful for downstream forks, to cherry-pick
relevant commits.

> 
> Fixes tag for 9a6d6ae8afb is also fine for me.
> 
> Thanks!
> 
> -Zhao
> 


