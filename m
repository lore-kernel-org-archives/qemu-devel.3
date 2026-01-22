Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FDCD3EE86
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 15:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viwtE-0002VJ-2V; Thu, 22 Jan 2026 10:46:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1viwsq-0002KN-85
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 10:46:16 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1viwso-0004UT-2y
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 10:46:07 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a0fe77d141so6818735ad.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 07:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769096764; x=1769701564; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1P3pO9mwWJU7KwcoGKVXusH1FL0E5w+n+ZTDybvnJdM=;
 b=kYClCxBpusN6JPnI80R8xfMpNsdHl28oLFcwjAdleWqRbyxIea88LEE3pTBcO7OOCS
 sJY/HMx2TclDgjfvs75cSvqAD4qbyzUBK2zbYZbnLM2ONmNU5GTLS6xYPUdFObLaP72c
 sJCN9PKpQntTLap733slIhFF9nBCRqNVKuXE/5POnpSAO1At5yvFzWC+Z9hT9Y4jAXQr
 T8s8QMe5eUVF4mErrtdieigL9h17yYw9xweSSQK1pby9j8gwH8ChzyM8K4WCaRTAi+6v
 IiFpxmMxCnDyNQlMQS+lk2/phLeoGkOrIZaLwYOCTe6rr8Fn5GcuAy1NZeWve68KKrK6
 hoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769096764; x=1769701564;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1P3pO9mwWJU7KwcoGKVXusH1FL0E5w+n+ZTDybvnJdM=;
 b=v4C24dTK/DOWxIz5MLqmFH4637SXYY0v/9aLqyUJCNsKhc9pdA75H2PCl56tBMQs4C
 /UFZAR7KzUIJyeKZSGxv7TA8UTk87gblqX1gwOyeznhfW2mN2qUflbMEedOTZuGt1ijc
 VfCq9zwY8+YhjTrObh/h7JAWqrhe47FVZhrFmR3lExqGX4Fa0YbQudhHI5VT7o4hAQgt
 L2JqQWnz2OzmC40KJ976ySiFa+4LipzadewmP8JDv5bez81UguvH/0zcEn5B2rQwZCpH
 yVowUqv02PYQkyTN2cVJk8KST2jAmCufiSZETRb9Ge9u2XvrnisD4Hzmv+oQCJOkerx6
 kdJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZoaon1Cs88IgQMfbz2tYz1gGdJrWeuS/a3QYYAWgS0Ipb/qsY945OL1O0w+JhLna8F9e/OYVEmf/X@nongnu.org
X-Gm-Message-State: AOJu0YxUlR3n6e6AoEKmbOuAGDtV9qGH+Cz4HCLfjuw1V2D8ZHiXJA/4
 oUYNfFBOZVfdO/xTrEAP9NNqqiAY5BtvGYFyG9frEv02NihdPEpzJZ5EOVfqy4jwksc=
X-Gm-Gg: AZuq6aLwdV0kwQMxMKBBBymgw7h1SagaG2mzX/o3DmrfQ7/hYJS1rM5YghGcTDRbOxl
 o2mdvhvU/aSDWthtIbT5XPo6wR18t6h3BUVU//BhzHMwGbEF282kFqRBaSy44vqihie9iv+6n7H
 19KQtAAuKgCI84XmfecDreCSlxX5c4z6/noNJk9lQzqU9OgweSpjBWUhNmqh9F0/yoM8RzruM97
 u3G/KE/DvTWBbtUNGV1T5qp6nklwYyD3g15MvQgltKb69aiGHmcpnf8nNPdhq/bibU1YUxodmwI
 suwuQ68mYrJziHGrlRCqq7yGLNNs+G9c2OLXQvuSP+6FfG1TUq/8z9vu3kJPpkCWOWLdcEPD5Mb
 8xxrjulG2TJAY0kpsDFRM1TJ+03/oWqbYAKK1iYS0+9ic/o191rz39EzVTsyt0STm2n4cj8Xdho
 FV4wpYhyYasYOU9ecotbDlaJpnWzXk5ClA0WUCDdkRD9BcAIiqMTsKSWwo
X-Received: by 2002:a17:903:2351:b0:298:485d:556e with SMTP id
 d9443c01a7336-2a7175170e0mr201410285ad.11.1769096763526; 
 Thu, 22 Jan 2026 07:46:03 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dca71sm183794605ad.48.2026.01.22.07.46.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jan 2026 07:46:03 -0800 (PST)
Message-ID: <82f74c82-c572-4ab9-b527-11ea287056d1@linaro.org>
Date: Thu, 22 Jan 2026 07:46:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Call for GSoC internship project ideas
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, German Maglione <gmaglione@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
 <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
 <aXH4PpkC4AtccsOE@redhat.com>
 <CAMxuvaw04pDNzHyw5+Qcv_KfrhDTiyp+MNxpECp+HfTa5iLOGw@mail.gmail.com>
 <aXH-TlzxZ1gDvPH2@redhat.com>
 <CAFEAcA_u6QUhs+6-cyYm_qttsDiV2zHbsc-_FbTb8QzWXk6+tw@mail.gmail.com>
 <aXICpFZuNM9GG4Kv@redhat.com>
 <CAMxuvawgOvQbwoyCzFBLw++JqR0vFbVUhbv1AJWU6VqK1MM_Og@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <CAMxuvawgOvQbwoyCzFBLw++JqR0vFbVUhbv1AJWU6VqK1MM_Og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 1/22/26 3:28 AM, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Jan 22, 2026 at 2:57 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Thu, Jan 22, 2026 at 10:54:42AM +0000, Peter Maydell wrote:
>>> On Thu, 22 Jan 2026 at 10:40, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>> Once we have written some scripts that can build gcc, binutils, linux,
>>>> busybox we've opened the door to be able to support every machine type
>>>> on every target, provided there has been a gcc/binutils/linux port at
>>>> some time (which covers practically everything). Adding new machines
>>>> becomes cheap then - just a matter of identifying the Linux Kconfig
>>>> settings, and everything else stays the same. Adding new targets means
>>>> adding a new binutils build target, which should again we relatively
>>>> cheap, and also infrequent. This has potential to be massively more
>>>> sustainable than a reliance on distros, and should put us on a pathway
>>>> that would let us cover almost everything we ship.
>>>
>>> Isn't that essentially reimplementing half of buildroot, or the
>>> system image builder that Rob Landley uses to produce toybox
>>> test images ?
>>
>> If we can use existing tools to achieve this, that's fine.
>>
> 
> Imho, both approaches are complementary. Building images from scratch,
> like toybox, to cover esoteric minimal systems. And more complete and
> common OSes with mkosi which allows you to have things like python,
> mesa, networking, systemd, tpm tools, etc for testing.. We don't want
> to build that from scratch, do we?
> 

I ran into this need recently, and simply used podman (or docker) for 
this purpose.

$ podman build -t rootfs - < Dockerfile
$ container=$(podman create rootfs)
$ podman export -o /dev/stdout $container |
/sbin/mke2fs -t ext4 -d - out.ext4 10g
$ podman rm -f $container

It allows to create image for any distro (used it for alpine and 
debian), as long as they publish a docker container. As well, it gives 
flexibility to have a custom init, skipping a lengthy emulated boot with 
a full system. As a bonus, it's quick to build, and does not require 
recompiling the world to get something.

You can debug things too by running the container on your host machine, 
which is convenient.

I took a look at bootc, but was not really convinced of what it added 
for my use case compared to the 4 commands above.

Just my 2 cents,
Pierrick

