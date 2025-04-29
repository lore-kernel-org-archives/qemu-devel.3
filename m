Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80241C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 10:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9htx-0003Do-PD; Tue, 29 Apr 2025 06:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9htr-0003Cr-7i
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 06:09:15 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9htp-0003jR-63
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 06:09:14 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so4925968f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 03:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745921347; x=1746526147; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=t33s/+8g7HOIE704fFCP0GOeizuq8YNytjmdw6nQ31A=;
 b=tHa4ACfAhkTPKmyvo/1LCo7qzZt2LeTwUnCp5OBUmpigkk4vp2BdbivqQDn+T0uqS/
 NiqCA8miCMfkYAQgCsjv1fweQ9nxN3n0XIp7dMcSVUtnwj8eliN4evifU64HZJR4r9uI
 2z6nTyyPzgEBqvyeS6qU7F4nIL3TByNcqIaGEFyDr1IUOiIOH1K0wCyPG/T76o7SFgLW
 wExR4xER0VdsmxY+F3xGVArCt9mKtNqKmfjlYOfEvu1IlS0xbPAIq2JZtjelQErHClx4
 nk/fNpogN/eCSYulWzEFnwk8AtZaKsa5KhmKHl+OFNTdmSjGWnc1v5W2/10K1yoI/pEg
 A+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745921347; x=1746526147;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t33s/+8g7HOIE704fFCP0GOeizuq8YNytjmdw6nQ31A=;
 b=W5YAQN+Mx2GjT+BeaSev05c1j3789t5eP+HVp2Z8trOefzU6QYRy/3GIdI6XqPM6Ny
 vnMSXKxpNxvZF26eW+RKnpnr72GWwqMMIlmHgR5s9XBx9MpIXc9IZ22TgS2ULa12xFsc
 1FcFZ3+0fQCSwaUOTlAQpsEuJAJENw5lPdoFyDIwhjhqSPoPCAnaupnxnW1+iP5q0wYm
 s2PJO26honvOdUDf2UNmrnrpOlNM690xn/KybF+LhWtPYw3LgEB6WJ/bdvdh29kc0lrq
 vtgzCo1LROoh7YUbVBuQqMFJgEg8Z8JRA0G7bJ1X+TL4al39/l6Ytk5eJGzBQ8A7WdOm
 A0Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXG9SBWx/o88bmfgMcDAayqPWgs0TOGdsrUtaOmdpolucAsEI66H3bm2szK5J5PQsY6MOOY5ACXjVd@nongnu.org
X-Gm-Message-State: AOJu0YxKJ4ezGGH15cdCBnaKudKMyxDagbcGHLOKQ34RKlFJRKvuPJ1v
 2gJATdYou7Ykhe2KCE6tSIjJ13fb8Uw4SNbK7NP3cgfTBinVQSSbtJAnp12rexk=
X-Gm-Gg: ASbGncu+uXNrXHzrL3axyZyv1swMxBgLYjBg81sPoO/a2sOgivQXlMHOEhmw4wsM28A
 MjDoqWzxD79hewUKVHjw6JqtoiTcv8xbOi/f7i77GYbUtX1dr69CEzP1xr92V+PwlBUkNMAHgmB
 eV5eUbsESQLipbfpf4Gg8auhr4xem3w8L7Hm8uLLdUopZ7b7s5u7AQd7Bs+7/ID5NesnN34M8r4
 YLzGSI863BZ5Ap2kGs1d8roLdSyRQTMG+7I5d95nEQIE1LK83Otd/6U72WGKkCIhTRucwgagU2j
 Q0mBsUKvpvknjEP6ou7+gpxcrJ7EVAiR9fT4qVPB94HEGvXPfGvU7d89ocO0bYVtuS7RUM68mnI
 EV/0pFA60//f/wA==
X-Google-Smtp-Source: AGHT+IEt24HhEk+S1UZI2mi0XkR05roGAf77aQsU65+aSscQHIjB2O/vqRSvKWpGd0nV+TUhXfFifQ==
X-Received: by 2002:a05:6000:3113:b0:3a0:7f9c:189a with SMTP id
 ffacd0b85a97d-3a08ace2ff0mr1857602f8f.0.1745921347456; 
 Tue, 29 Apr 2025 03:09:07 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cbf04dsm13743341f8f.52.2025.04.29.03.09.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 03:09:06 -0700 (PDT)
Message-ID: <3b0555eb-79d6-4990-98fe-b9dab53ddf32@linaro.org>
Date: Tue, 29 Apr 2025 12:09:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU Community call 29/04/2025 agenda items?
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster <armbru@redhat.com>
Cc: Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Brian Cain <bcain@quicinc.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, cw@f00f.org,
 dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, felipe@nutanix.com, iggy@theiggy.com,
 Warner Losh <imp@bsdimp.com>, Jan Kiszka <jan.kiszka@web.de>,
 Jason Gunthorpe <jgg@nvidia.com>, jidong.xiao@gmail.com,
 Jim Shu <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Max Chou <max.chou@sifive.com>, mdean@redhat.com, mimu@linux.vnet.ibm.com,
 "Ho, Nelson" <nelson.ho@windriver.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>,
 z.huo@139.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 zwu.kernel@gmail.com
References: <874iy85yx2.fsf@draig.linaro.org>
 <eefb308b-5cd8-4b30-bc32-e37f601cb07b@linaro.org>
Content-Language: en-US
In-Reply-To: <eefb308b-5cd8-4b30-bc32-e37f601cb07b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 28/4/25 14:57, Philippe Mathieu-Daudé wrote:
> On 28/4/25 13:05, Alex Bennée wrote:
>>
>> Hi,
>>
>> The KVM/QEMU community call is at:
>>
>> https://meet.jit.si/kvmcallmeeting
>> @
>> 29/04/2025 14:00 UTC
>>
>> Are there any agenda items for the sync-up?
>>
> 
> For single binary / heterogeneous emulation, we'd like QAPI to
> be "feature-agnostic". In particular, using the example of KVM
> accelerator, whether a binary can run with it built-in or not
> should be is irrelevant for management applications: they should
> only check if it is used (enabled).
> 
> The following series is adding KVM specific structures and commands:
> https://lore.kernel.org/qemu-devel/20250409082649.14733-2- 
> zhao1.liu@intel.com/
> It could be interesting to discuss if this can be avoided. But this
> can also be discussed on the mailing list (as it is still currently).

FYI neither Markus nor Zhao can attend today's call, so not a good
time to discuss this topic.

