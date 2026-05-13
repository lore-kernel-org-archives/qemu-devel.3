Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0A2CD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 07:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN3jc-0007kr-0t; Wed, 13 May 2026 03:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN3jY-0007jT-Kp
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:10:21 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN3jU-0002cj-Ng
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:10:20 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48374014a77so57555155e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 00:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778656215; x=1779261015; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IRWC9NKkGHMyilLLpQJoe8yRrQVfAULorGrdogB7ZUY=;
 b=qv//EkBr7POoysuF4MQPRg61a/nz0o5Q2j3/tDmg9ktByy/ONw/T94It6GM9/yEWtt
 3p6HgfFfqq/0F5OAYxGCE4bBIV/F30mbWc5mKBYjUerIrFqdw5U2RKsY+bLz4wsiuzdS
 ZFAUOw2EXly7KmGBNzbN2kTYAebdtgxmBlY7vX/MRW7KlnaiTXc893P8HfaLgbCK9P7A
 j8icRq9QNF7lJZFL+ieIG8uKgqzkrM+X2/f4DfhJEYR7O6Gv0mAGgxHK3eXyMskZUDY1
 yPXTizumc7+8/OGKU0iuk/gmQP8c66Sfhbg7UI1emB3ThXqMIPzeCMxjyan4iMmftUc0
 pPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778656215; x=1779261015;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IRWC9NKkGHMyilLLpQJoe8yRrQVfAULorGrdogB7ZUY=;
 b=BF7YTDq7+ScQNnrXyNnQBLr/7ePtwBGMsdJYMB+bvOBn5sSTZj0GrTQqoxdHbNh+4D
 8u+opJ4xDrGT1nJWanNUABkwhNU9VFHNgnpltxccm37IygFI3oXGL/GUEfh2fFObgOSC
 gYvHE55OsugAVUe2I3un1vXsMFc8g0t/BhShHxFdhpvxw+aBoOgEWHKS6bTnwpwVQmwM
 s5VNEv3XCWH/d12BvLq3sxbbXOezJsgKDE5yz38mdiRDc/eCWOAMo2Z97f2uXTyomQQL
 1SoZXERq5v2Q1fiq7xgCYsQ3C/FINHsNQBlIExpK/hc/eEFnpc/n4+LCr7zUR1VHIrJj
 wXtA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+RbEJnxnAiVGhWF2+/b9fez9vDsoolqjZO6XXWrHtplsOAHM3hOq9M7hocx+M7HMT0Ssi7ghxUbnQf@nongnu.org
X-Gm-Message-State: AOJu0YwyPVhUj01Z0TVCNGxE0j+k6BoEMnmdviT6/Y1qbuKIrFGS6/Lg
 f027YlBAa9/c7tftkovEhGWYfhCHl8KmiBir/YjZpRGhCdWdxuDzImxQqZwokB+tmlo=
X-Gm-Gg: Acq92OEJFz6i+J3yC/++NLnL+3egluksp6Cify8fF531rhUtiBSOAw7CqPY6qldCCtU
 MZw3bF76L3UvVJGbYMHjDgRvsJ0ksYTR0SzcmIYx1mglkypZMBhy7rAArbl+baCVJh74C+n0Wut
 vBNGDifHQHCtwHAvwv6ZCZewPi/7H4RCMiDsVcqSsfx3Ak8LwpIJvjQM8BejrhAc2kUE9zscWw7
 kSt/ENE9QsXyp5D2nesX9dMWqqYKyXFkk8BbkHUjya4Pnl2HNZDxXB417jFt38xemhmUJ71k9YI
 KYxeSPqeHBDCy0ldbuc+wsMLNbFDeNzwwbgku7G/ZNI/wlc0xcy+8ZzDS9fkP+sXsBFU7p2iG3E
 R1bLMjyiRlMd5M9YXrAPyKlzRQFBkYMeCa08CqJpHxvbxTKUz8xAyI89VqBJ/UQE5Qo7S3f9zmi
 0Qdim6as5FMud6LRGBcP2M/2RwmFAcX+OF1fdO/zIqIdQb7ZyKU2LP2ahnuqbupsIRog==
X-Received: by 2002:a05:600c:45cd:b0:489:1ff1:74d3 with SMTP id
 5b1f17b1804b1-48fc9a3abcdmr26529665e9.20.1778656214793; 
 Wed, 13 May 2026 00:10:14 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fc8d68b14sm52597065e9.12.2026.05.13.00.10.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 00:10:14 -0700 (PDT)
Message-ID: <253ecaac-ac2e-43a8-97e8-9251f114df3f@linaro.org>
Date: Wed, 13 May 2026 09:10:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: MAINTAINERS entries that aren't S: Orphan but maybe should be
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 integration@gluster.org, Zhao Liu <zhao1.liu@intel.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Milan Zamazal <mzamazal@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Mark Kanda <mark.kanda@oracle.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Glenn Miles <milesg@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Ben Chaney <bchaney@akamai.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <87y0hwbvbp.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87y0hwbvbp.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 6/5/26 14:01, Markus Armbruster wrote:
> I'm cc'ing reviewers and lists mentioned below, and frequent
> contributors to MAINTAINERS.
> 
> There are a number of MAINTAINERS entries with S: other than "Orphan"
> without M:

...

> Unless somebody steps up to server as M: or at least R:, we should
> downgrade to S: Orphan.  Volunteers?

'Network device backends' (net/), 'eBPF' (ebpf/) and 'Network devices'
(hw/net/) patches are left unattented on the list since 6 weeks, all
maintained by Jason (first 2 listed as 'Maintained', last one as 'Odd
Fixes'). These sections don't have co-maintainers. Shoud we be worried?

