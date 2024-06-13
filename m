Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3CFC27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 08:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHfsG-0003UX-8x; Thu, 13 Jun 2024 04:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHfsF-0003UG-0k
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHfsD-0004Gt-4U
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718267516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kiETbwiJAl7wZmSveP0mFGM/c5IkrMcw8yZvL9QdBBA=;
 b=HQ4UlSDzCPboANNYCE3SLAHC2RMq61p3gcKCEWDpQbVl9xestNQyndXxIWkZs5LOeCoGJa
 dWsFYPBgNekhnta8EBJppVQcf0nlJGqbuiuhTdJxVjU2UB6JZbuhjKqLmKSeqAho+fmaTE
 oSOJiHWCeE5+RiK40cqd/VmWmFdAVj8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-R0KyHpAiPTSuuZfuqJ7ECQ-1; Thu, 13 Jun 2024 04:31:54 -0400
X-MC-Unique: R0KyHpAiPTSuuZfuqJ7ECQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52c94ad861aso615744e87.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 01:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718267513; x=1718872313;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kiETbwiJAl7wZmSveP0mFGM/c5IkrMcw8yZvL9QdBBA=;
 b=WNde5+USjmaGMrtIZFmlz32Zy0ba5iBxCcMbngksl97fLdT30aC++cDcTgufOsttQR
 brtHChu3RriTqx88PD7fWx+kRMi4qhcc+Z02vTkKOS/K6CoTlNFKSPfSOO1Ekbpfddvi
 PaA8n0KcFR5fhj+B9sv8O4nAmUDLmim4y0KBYS4uqdoQdF0GID6+BJRsdk+/6nQPuISf
 NzCSRzMTSEyfULmnpYXAfI97T0ByLVTgGCJJ9cEXgOljeVuLdq9L6qJBVoSvtF9p8oJ8
 tcwqfmTGh/XFnrjDI1Vn3dRdMjf3Tivu0dwPwnLqbixHJHoPNNrhc7fKOJAm3dlsJ0Fw
 2t/w==
X-Gm-Message-State: AOJu0Yytkv3ZVi3xuUGX2ZsCmnVgyAKpIL9t6850EcjIeBVPg/qCZ4Dj
 W5AJRkge4sl5JOZ3FbeePVZe9F/2C1A9W7his4/yPGuGOKjAiRTY7Eg6tPXLzGbuKLnBrun3Xcw
 sIRVy1VSmA7w1w/xuVz8ee9d/FSrTh8yVfjTI+HhxoazOgLiPWE0F
X-Received: by 2002:a05:6512:3687:b0:52c:983f:8ad with SMTP id
 2adb3069b0e04-52c9a3fd4camr2630968e87.47.1718267513023; 
 Thu, 13 Jun 2024 01:31:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFnGf4xZpc5Rm1NS/aq41o509MlTp6z0V9DgqPA1oxky4XP8FdKbEhd9txJ49fqUxQUX7Seg==
X-Received: by 2002:a05:6512:3687:b0:52c:983f:8ad with SMTP id
 2adb3069b0e04-52c9a3fd4camr2630945e87.47.1718267512601; 
 Thu, 13 Jun 2024 01:31:52 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-242-210.web.vodafone.de.
 [109.43.242.210]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f641a65bsm14954555e9.42.2024.06.13.01.31.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 01:31:52 -0700 (PDT)
Message-ID: <2624ae07-f61d-4c07-9510-ebbd243670a3@redhat.com>
Date: Thu, 13 Jun 2024 10:31:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Qemu License question
To: Markus Armbruster <armbru@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Peng Fan <peng.fan@nxp.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <AM6PR04MB5941BDF756878B3CA208D07D88C12@AM6PR04MB5941.eurprd04.prod.outlook.com>
 <f06ai.hy2gx5h8080@linaro.org> <87h6dxct8g.fsf@pond.sub.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87h6dxct8g.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 13/06/2024 07.22, Markus Armbruster wrote:
> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
> 
>> On Thu, 13 Jun 2024 06:26, Peng Fan <peng.fan@nxp.com> wrote:
>>> Hi All,
>>>
>>> The following files are marked as GPL-3.0-or-later. Will these
>>> Conflict with Qemu LICENSE?
>>>
>>> Should we update the files to GPL-2.0?
>>>
>>> ./tests/tcg/aarch64/semicall.h:7: * SPDX-License-Identifier: GPL-3.0-or-later
>>> ./tests/tcg/x86_64/system/boot.S:13: * SPDX-License-Identifier: GPL-3.0-or-later
>>> ./tests/tcg/riscv64/semicall.h:7: * SPDX-License-Identifier: GPL-3.0-or-later
>>> ./tests/tcg/multiarch/float_convs.c:6: * SPDX-License-Identifier: GPL-3.0-or-later
>>> ./tests/tcg/multiarch/float_helpers.h:6: * SPDX-License-Identifier: GPL-3.0-or-later
>>> ./tests/tcg/multiarch/libs/float_helpers.c:10: * SPDX-License-Identifier: GPL-3.0-or-later
>>> ./tests/tcg/multiarch/arm-compat-semi/semihosting.c:7: * SPDX-License-Identifier: GPL-3.0-or-later
>>> ./tests/tcg/multiarch/arm-compat-semi/semiconsole.c:7: * SPDX-License-Identifier: GPL-3.0-or-later
>>> ./tests/tcg/multiarch/float_convd.c:6: * SPDX-License-Identifier: GPL-3.0-or-later
>>> ./tests/tcg/multiarch/float_madds.c:6: * SPDX-License-Identifier: GPL-3.0-or-later
>>> ./tests/tcg/i386/system/boot.S:10: * SPDX-License-Identifier: GPL-3.0-or-later
>>> ./tests/tcg/arm/semicall.h:7: * SPDX-License-Identifier: GPL-3.0-or-later
>>>
>>> Thanks,
>>> Peng.
>>
>> Hello Peng,
>>
>> These are all actually GPL-2.0-or-later, in fact I can't find the string GPL-3.0-or-later in the current master at all.
> 
> See commit 542b10bd148a (tests/tcg: update licenses to GPLv2 as intended).

Maybe it could be included in the stable releases before 9.0, too?
CC:-ing qemu-stable for this now.

  Thomas


