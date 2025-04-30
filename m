Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BB2C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 14:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8YY-0001qc-AF; Wed, 30 Apr 2025 10:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA8Xu-0001kk-Cy
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:36:28 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA8Xr-0008Sn-Ri
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:36:21 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7c96759d9dfso829778785a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 07:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746023778; x=1746628578; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DSWOzj+TetM9ktd4qGCuEiwiPcM/WmhusD0atD6DZmQ=;
 b=Q2L9ctXCVJwnvJ3LmZoj2UBO4kpiM/aVI6vVtzJ0qjzlw6ueYnUhAXm5ghkg2SKbuv
 Abc63FFzCmyFlD8vC41UVysHMwPZAWlE6UNqpNqxzRZ1IA/pLPjQi3+C9u92HaLuwyWw
 YSogOdHmjEwpE94y3nguN0Ile+cwYX8M7o6tWEU3eO9HmnzrgB25gF9CB5Ntv9vnr1wA
 mAen8SKBNzTaqsWVz0jv0y0msZiEzvXiBQY4nN2Zco4sGYqvVaGHTM74QQW3rdXskllE
 xD17CVz1EZupV3TCtd8JMX5PB1TLV6zNoWcNFkoUqBWrq2f4wv2WjvFcZj19u0Pmyg8d
 MGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746023778; x=1746628578;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DSWOzj+TetM9ktd4qGCuEiwiPcM/WmhusD0atD6DZmQ=;
 b=g+za4X4psKkBHQmn5IcqV19XByyYQq3HnagsxW4+AFEQ/+JP8wKf5ZZcCYbwL8+egT
 8+0Te3unSa39RlwL2tLRc63ioR8eV8tIl6v3NF6kJg/QX9kFm/F2qCINc0gCu+0fr2j5
 UjXI9NxgSCieFJJ73QonpXTefJi6+CjR11OmynfcIWkvViWFVXJuj4ApZl38eOwzQbNg
 TxIfl12B0afbiTdHvukLZpL9pmqxOkEiYg6rIQPN2ESqriFdojxQetSbcIZmhjy2BIGq
 V74kwyBeeXFeC4YPsoVBWuu6Dty7UHqU69HbwVdbKq9KmoApkW1JIg9jdlLT2pd35+0W
 Uabg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnvSIChnt/QtqYeRHCmB6bGrNrStCjOe1dANL1KocTBWAST1is9KGWGZTOQRGTfMC2wfQwK21Bqx9p@nongnu.org
X-Gm-Message-State: AOJu0YxtQ1nXvl20tj/El4ySbDtaeqg6Eb0ftlr3E6elgEKZuti9YdjF
 W+Kc79GHuF57Z4WohbHmCjkBvnEgq8r9LZ2PZ3G1xnPcfXmOjwteyVpYEfEuQPU=
X-Gm-Gg: ASbGncsJk8IPqncU80o5DHF6oSvZAuntAcM/faMWv7fAxNOCYR2Xm9EO1Y5cPB5p2co
 npFdIS9YxT91ZYX1AMdur1HhjCK3eKjUXqtBUPixezaAZexmw2pauQHTLbcMB/aGuOgnve8u7z2
 zwbDkx97BfLHEnRWPu5Ty0uaRWHgQZKbWMNQDSVy6QEPoP1icQur94n6PEsQahA/ym3S1mj5YHB
 hYSFFcyDBfy6pMoSY9EdJiR6IZmMWqZK5WPYbGwyN29IrBP7ZVoSsswRvFe/DFJ+l0iDEMyPhHN
 OhRHPZGf2MjF31A8Wh+KLRKmONTJRVOvXEGle+JstxnCZOqN0sPTvpPGwRyQe1+3x+/g+HBhupD
 5j+tnR51i
X-Google-Smtp-Source: AGHT+IEnXWrum4IqIvIoHmZBMWef6cs0JjE7cOYD3ewM+Enstgq/KYi8AhvghsQkEfoEHS81/5q/pA==
X-Received: by 2002:a05:620a:44d5:b0:7c5:6a66:5c1e with SMTP id
 af79cd13be357-7cac7ecb87cmr402633185a.58.1746023778338; 
 Wed, 30 Apr 2025 07:36:18 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c958e9fbcasm861134785a.99.2025.04.30.07.36.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 07:36:17 -0700 (PDT)
Message-ID: <5ce00003-4105-40c7-954b-63336a4325d5@linaro.org>
Date: Wed, 30 Apr 2025 16:36:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU Community call 29/04/2025 agenda items?
To: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Brian Cain <bcain@quicinc.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, Neo Jia <cjia@nvidia.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "Wedgwood, Chris" <cw@f00f.org>, dhedde@kalrayinc.com,
 Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 iggy@theiggy.com, Warner Losh <imp@bsdimp.com>,
 Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 Jidong Xiao <jidong.xiao@gmail.com>, Jim Shu <jim.shu@sifive.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Max Chou <max.chou@sifive.com>, Meirav Dean <mdean@redhat.com>,
 mimu@linux.vnet.ibm.com, "Ho, Nelson" <nelson.ho@windriver.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>,
 z.huo@139.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Wu, Zhiyong" <zwu.kernel@gmail.com>
References: <874iy85yx2.fsf@draig.linaro.org>
 <eefb308b-5cd8-4b30-bc32-e37f601cb07b@linaro.org>
 <CABgObfYmm2RgFUuViDJA_cuqeCUOh_DV5Qar8YLnrbfYVV39VQ@mail.gmail.com>
 <87a57ydj8y.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87a57ydj8y.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=philmd@linaro.org; helo=mail-qk1-x732.google.com
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

On 30/4/25 12:41, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> Il lun 28 apr 2025, 14:58 Philippe Mathieu-Daudé <philmd@linaro.org> ha
>> scritto:
>>
>>> On 28/4/25 13:05, Alex Bennée wrote:
>>>>
>>>> Hi,
>>>>
>>>> The KVM/QEMU community call is at:
>>>>
>>>> https://meet.jit.si/kvmcallmeeting
>>>> @
>>>> 29/04/2025 14:00 UTC
>>>>
>>>> Are there any agenda items for the sync-up?
>>>>
>>>
>>> For single binary / heterogeneous emulation, we'd like QAPI to
>>> be "feature-agnostic". In particular, using the example of KVM
>>> accelerator, whether a binary can run with it built-in or not
>>> should be is irrelevant for management applications: they should
>>> only check if it is used (enabled).
>>>
>>> The following series is adding KVM specific structures and commands:
>>>
>>> https://lore.kernel.org/qemu-devel/20250409082649.14733-2-zhao1.liu@intel.com/
>>> It could be interesting to discuss if this can be avoided. But this
>>> can also be discussed on the mailing list (as it is still currently).
>>>
>>
>> Would it be possible to just mark the commands as "do not autoregister" and
>> then do the registration (for example) at machine/accelerator/CPU creation?
>>
>> I think qemu-ga already has a similar run-time registration model but I
>> don't know why QEMU does not use it.
> 
> I think we covered this to a degree in
> 
>      Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
>      Message-ID: <87a584b69n.fsf@pond.sub.org>
>      https://lore.kernel.org/qemu-devel/87a584b69n.fsf@pond.sub.org/
> 
> But let me try to give you a shorter argument.
> 
> Pierrick's stated goal is to have no noticable differences between the
> single binary and the qemu-system-<target> it covers.
> 
> We have two external interfaces to worry about: QMP and the command
> line.  Let's ignore the latter for now.
> 
> Target-specific differences in *syntax* come from QAPI schema
> conditionals with target-specific conditions.  Example:
> 
>      { 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'],
>        'if': { 'any': [ 'TARGET_PPC',
>                         'TARGET_ARM',
>                         'TARGET_I386',
>                         'TARGET_S390X',
>                         'TARGET_MIPS',
>                         'TARGET_LOONGARCH64',
>                         'TARGET_RISCV' ] } }
> 
> This command is only defined for some targets.
> 
> The value of query-qmp-schema reflects this: it has
> query-cpu-definitions exactly when the condition is satisfied.  The
> condition is evaluated at compile-time, because that's how QAPI schema
> 'if' works.
> 
> Say we drop the condition and instead add an equivalent run-time
> condition to command registration.  This preserves behavior of command
> execution.  But query-qmp-schema now has query-cpu-definitions *always*.
> This is a noticable difference.  It may break management applications
> that use query-qmp-schema to probe for the command.
> 
> Moreover, conditionals aren't limited to commands.  Example:
> 
>      { 'struct': 'CpuModelExpansionInfo',
>        'data': { 'model': 'CpuModelInfo',
>                  'deprecated-props' : { 'type': ['str'],
> --->                                   'if': 'TARGET_S390X' } },
>        'if': { 'any': [ 'TARGET_S390X',
>                         'TARGET_I386',
>                         'TARGET_ARM',
>                         'TARGET_LOONGARCH64',
>                         'TARGET_RISCV' ] } }
> 
> Here we have a conditional member.

This this the single structure member conditional on field
selectable by ./configure (IOW, not host-dependent). I proposed
its removal in this patch:
https://lore.kernel.org/qemu-devel/20250429100419.20427-1-philmd@linaro.org/


IMHO conditionals should only depend on host / static configuration
features, not features modifiable from the command line. (I'm always
confused by KVM features published in the schema, but then you start
your binary with -accel=tcg and still can run KVM specific commands
via QMP, returning errors).

