Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2407ECF649D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 10:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svE6i-0004SN-E2; Mon, 30 Sep 2024 06:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svE6h-0004Rs-3x
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 06:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svE6f-00087Z-Dq
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 06:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727693900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GAtzX2MHYvAF5IpcKgMWdKBU+HH+8tXpyfYmXoJAQ6s=;
 b=Ir2fnUu7wI84JnsfHHNU88uP4UlK2Wi8tcraAIVUh4KftFVEn/p0w6fc09rKf/bkFN/69X
 B4IDfCQtbJAO3BmNwC07QEtWmwnOCMPNLBrYK8RdJA4VdSBLThVRMZdLPJAkrELxsHAf/N
 hlapQZNAXC2oYDxPsRfOp3L9arYP5V0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-WRDDpXhsPr-2vr2jkcUFxg-1; Mon, 30 Sep 2024 06:58:19 -0400
X-MC-Unique: WRDDpXhsPr-2vr2jkcUFxg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-45b5cdfe76bso51254731cf.2
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 03:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727693898; x=1728298698;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAtzX2MHYvAF5IpcKgMWdKBU+HH+8tXpyfYmXoJAQ6s=;
 b=Xn4u4eLsMrQToi+9RVPdcSjYjB1rrJ0DuwhFT9piIeoqGF60ID/Xqd8kqrxyxgc+aa
 bdEXw79mLfE8C/b4a+QTFDeg3HkQUrPW2Wqn97iZzovtS/w2meK0an9309tphUESJ0t5
 Bcqx1x2Ph4AlkkKNAAl003X2/enSWStlK6Qlv9VZRW5xrR7NoXtc9nfekEwZjOuTiPVZ
 Kl2BX9CL/fEQkvbZgRjDeOeSVwt3ociy1ZOfI1N1qSSmkGb+nnhrFLJ158xhPEKk+jYa
 uChKYM+jzCgpXTf2ixXii/Phb5nXIBpXmWa0ZtlPi2ucV/5RjkmfZaOX/Pa3sEo+uD7B
 XTQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPCfpdsWqY2bAeXRmACSrTBlja5j3hupACS+xQnHIR0wAXC/ApU9Y78NsFSIq6gS6bpT7IluEUWUpU@nongnu.org
X-Gm-Message-State: AOJu0YxA7LlngWSQ5Akw0M8Hatr+md7zj8n/DkzLDz6xF6e+tkxaXCOz
 tceJEJpk7xYZWfIXco6IpP4nHZLkkGvd14l5MLM+Gg8IztkoepfEhIwJ3T4XzaVf2fsJqULdikX
 BXVC92eK8XZYptAAzoT8mNRWK0bFVxP9oNcAba3WTadu26o3hBZiZ
X-Received: by 2002:a05:622a:449:b0:458:2e21:e422 with SMTP id
 d75a77b69052e-45c9f2a304amr212210301cf.50.1727693898551; 
 Mon, 30 Sep 2024 03:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMkQrv/4w3PdYD9LA5NAtf70wfd1FR8hep+dl3nlUy5VteQTPsc1OiSY5/tHRvA05Xgwb2Ig==
X-Received: by 2002:a05:622a:449:b0:458:2e21:e422 with SMTP id
 d75a77b69052e-45c9f2a304amr212210041cf.50.1727693898104; 
 Mon, 30 Sep 2024 03:58:18 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-176.web.vodafone.de.
 [109.42.48.176]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f3533afsm34933431cf.93.2024.09.30.03.58.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2024 03:58:17 -0700 (PDT)
Message-ID: <7d60d882-3b59-428d-b63e-7d7444bd96fa@redhat.com>
Date: Mon, 30 Sep 2024 12:58:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/47] riscv-to-apply queue
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
 <CAFEAcA9Sb-fpNhm-6DPwss5zMpw=nEp31Wt6q1OA6DqCg3wKEg@mail.gmail.com>
 <13ee9889-b503-45ea-a074-ffafbd052c4e@ventanamicro.com>
 <CAFEAcA_nn2fUyo9Pkd8jW2NG1oJLbAJrfiC7sziuhGthqL3=4Q@mail.gmail.com>
 <096029d7-269c-44f8-88d3-6f0c52af58fa@ventanamicro.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <096029d7-269c-44f8-88d3-6f0c52af58fa@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 29/09/2024 22.53, Daniel Henrique Barboza wrote:
> 
> 
> On 9/29/24 12:38 PM, Peter Maydell wrote:
>> On Sat, 28 Sept 2024 at 21:40, Daniel Henrique Barboza
>> <dbarboza@ventanamicro.com> wrote:
>>>
>>>
>>>
>>> On 9/28/24 8:34 AM, Peter Maydell wrote:
>>>> The assertion failure is
>>>> ERROR:../tests/qtest/riscv-iommu-test.c:72:test_reg_reset: assertion
>>>> failed (cap & RISCV_IOMMU_CAP_VERSION == 0x10): (0 == 16)
>>>
>>> The root cause is that the qtests I added aren't considering the 
>>> endianess of the
>>> host. The RISC-V IOMMU is being implemented as LE only and all regs are 
>>> being
>>> read/written in memory as LE. The qtest read/write helpers must take the 
>>> qtest
>>> endianess into account. We make this type of handling in other qtest 
>>> archs like
>>> ppc64.
>>>
>>> I have a fix for the tests but I'm unable to run the ubuntu-22.04-s390x- 
>>> all-system
>>> job to verify it, even after setting Cirrus like Thomas taught me a week 
>>> ago. In
>>> fact I have no 'ubuntu-22-*' jobs available to run.
>>
>> It's on the private s390 VM we have, so it's set up only to
>> be available on the main CI run (there's not enough capacity
>> on the machine to do any more than that). If you want to point
>> me at a gitlab branch I can do a quick "make check" on that
>> if you like.
> 
> I appreciate it. This is the repo:
> 
> https://gitlab.com/danielhb/qemu/-/tree/pull_fix
> 
> If this is enough to fix the tests, I'll amend it in the new IOMMU version.
> If we still failing then I'll need to set this s390 VM.
> 
> By the way, if you have any recipe/pointers to set this s390 VM to share,
> that would be great.

You can also use Travis-CI for testing QEMU on a s390x host, see e.g. my 
runs here:

  https://app.travis-ci.com/github/huth/qemu

You just need a github account and set up the Travis-CI for that repository 
there - only caveat: in case you run out of open source credits, you've got 
to ask the Travis support for granting you new credits (seems like one has 
to do it a year from what I experienced in the past).

  HTH,
   Thomas




