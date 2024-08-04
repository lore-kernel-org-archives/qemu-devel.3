Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192F5C3DA7F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 06:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saUi3-0007WC-2t; Sun, 04 Aug 2024 02:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1saUi1-0007U1-1P
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 02:27:13 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1saUhz-0006Y0-21
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 02:27:12 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-260dde65a68so5940862fac.2
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2024 23:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722752829; x=1723357629;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fa53RE9qmjDM6ASl5Q9QVFBNMhQh7fDQJE0ArxuFwI4=;
 b=VbQORVErNiVyKdfCZqbvEU3/qQbZJf2ESpBTG0sbLcfrhQMRilC6+MnpN9E/NzLMtc
 FVAUnp7qYid0ziP2OW0sOoXHJ95dwQcHsTWVNL9ntuyG91B5qzMe4JWnW28Ygoc6+8x+
 stWIoaObLCbHRBmYFudCU+oeYMc/fBp1cFtJ/n1U+BjnZ5hLIq5uOW8/yFZOEXLcsIij
 DjPpoxtTuHmmU7X45/kd4dBIZhAu+5+oMuRAdAr6LHtvAtToHGrS+JtRaoSVvs42IUeH
 ikywjnj+si4zu5vnPlqjXnWg3FktSAcHXzJRwxTDNfVKTQAkVaU6mrWUJW2ocht7bZiO
 uDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722752829; x=1723357629;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fa53RE9qmjDM6ASl5Q9QVFBNMhQh7fDQJE0ArxuFwI4=;
 b=hUBrG8FWGKyHKPoE9KbddxBkRD8GTVF+bkg23ZDVZFG0ZahY/v59Qfj81Hf64c9nFN
 xIwibh/VvsXOcmckZplIxQKMD+KNSJqJntgolzztuMuhQ2zlhob7ZycCcZ4ByTGhFZSx
 zOJcUWeCB3xJgzuiQuVyYWLBSb9ifg0QfswITd6tIjU6Gx7radYqiAJfX0QhGdoXN0ZN
 6Fwi/Gfwv+n5/r9IygzqIzdts8d6fiZ60/jPoUSbOpcqNk40UaQcPlUn82dm60/S5JQJ
 q+y4FZKXNb5+iBq1unHL5+xZGZLSYK8n3+A663G05Oxhv62yAY18Su42wxXnt6F8bnjU
 NAHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNf4oj6pqn38WnwBRINy+dydK+PRTO8Ma/GV8DtNWbNpysOTuBRTv/cCZDI29+QpPFV+12rCZCXc++5LkWa8TlLLrIy4s=
X-Gm-Message-State: AOJu0YwvsnY0rN62MBVBz/GsIBp7a8iDwHcGQ8yyZ5tblozcdkFyLC4Q
 n8/l05Y8F4Q9Z9ZXyif7zQlf8dUQ1yGuPFYj4TxN4u8hTgDsw9Qbr1v250JcRMw=
X-Google-Smtp-Source: AGHT+IH7PXhH/OERVrfKBk9/mQ6/RMQZA4qp27LD4lorIK/Ie4LYdizFuiWZAT+jfQP8zsqf6TntaA==
X-Received: by 2002:a05:6870:c182:b0:254:7a82:cb3f with SMTP id
 586e51a60fabf-26891d4b1bbmr11012791fac.25.1722752829207; 
 Sat, 03 Aug 2024 23:27:09 -0700 (PDT)
Received: from [133.11.54.73] (shio03.csg.ci.i.u-tokyo.ac.jp. [133.11.54.73])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec460c1sm3524415b3a.74.2024.08.03.23.27.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Aug 2024 23:27:08 -0700 (PDT)
Message-ID: <d0dbf599-2aef-4862-acb8-364bba10a4bb@daynix.com>
Date: Sun, 4 Aug 2024 15:27:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v11 10/11] hw/pci: Use -1 as the default value for
 rombar
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <20240802-reuse-v11-0-fb83bb8c19fb@daynix.com>
 <20240802-reuse-v11-10-fb83bb8c19fb@daynix.com> <875xsj42l6.fsf@pond.sub.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <875xsj42l6.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2001:4860:4864:20::33;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2024/08/02 19:54, Markus Armbruster wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> vfio_pci_size_rom() distinguishes whether rombar is explicitly set to 1
>> by checking dev->opts, bypassing the QOM property infrastructure.
>>
>> Use -1 as the default value for rombar to tell if the user explicitly
>> set it to 1. The property is also converted from unsigned to signed.
>> -1 is signed so it is safe to give it a new meaning. The values in
>> [2 ^ 31, 2 ^ 32) will be invalid, but nobody should have typed these
>> values by chance.
> 
> s/will be/become invalid/

I'll make this change in the next version.

> 
> Should we document the change somewhere?  I'm not sure.  Opinions?

I think it is fine whether it is documented or not. As the commit 
message says, I expect nobody will be impacted with this change. But 
documenting this change will hurt nobody either.

Regards,
Akihiko Odaki

