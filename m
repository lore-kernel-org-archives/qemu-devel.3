Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A854BCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgEM-0007VQ-PI; Thu, 28 Aug 2025 13:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1urcVX-0007fn-2W
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 09:17:39 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1urcVU-0004CZ-Im
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 09:17:38 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3c6ae25978bso709052f8f.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 06:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756387054; x=1756991854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0vamIKvabXpI1+PvGekPp4TWc9HBmdPfmuJOD+hIUzA=;
 b=Hez4QhCRPmFrR723jyq0hjr3HYaBi1KLevo1To3fhjVpJiKEvVvuhsXdPxFO7umiA4
 mCVIoiJFvYqeRbhlB/aMvh/21dWd+XmkNTmw8SY3RN9fHlnFlfl4VHC98tudNaU/HytL
 jFOgu9EKOMeYmh7101STyUSHYbzNjEdhUzxjeYJrmqAFvsSpZtQn44b2cUe1NaIlhdxg
 5eP8ubLkY22QKYuxXKWzydY6GFObBD684+/rKyVpKaklPxD24Awhjgps1CsKoCVTGl8M
 EFIhoqiXmRoPPPHruLGz99UfYQZlYRhyD0WHVhzKJTxfZrpYQ0igf74WU75tyG3M+n4I
 21Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756387054; x=1756991854;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0vamIKvabXpI1+PvGekPp4TWc9HBmdPfmuJOD+hIUzA=;
 b=s+x1RQZm/sjWF828+7cvP5XRBa7vT6eJvdzPa+p4GCipXeWqAvw5C8jm67spQjY/MW
 1Gp3rDO2pXaSfSogtZaexZg1FnlcWmZSJmI7tt61jS8tRnUE1BbVnzNdVu1qjPMihJIr
 gu7fQb+1yuBzTa6zB8i905WeMUdhVO+rrakH+lLyInlymYZu+BGNdpPzdIhxuSnJaw0t
 qzbccC6x+hbAYzH1R0UeD+yUYmGDU/uP48A10eQVk1wuigP1j/F0VgkXVzJCzA6f9jsH
 1S/pzYkz1P6JiG+KVMbH9tZpXcKEnGFOytuNjJkdy7zHfxpuEtmXu50QJZzSUY9Xpov5
 NMEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSTz/+yYH63Kxl5d5Y21dDaIPqvUjfDxurX6V8KnPsd9weXv0kuEDkd7dQW8z1Dbdz8vkIjnAgnQqN@nongnu.org
X-Gm-Message-State: AOJu0Yx93YIK3FqPw7U1zxZEkSm5ZswpDVLUnFFViWpvFQwMfg0RwATE
 0yVOHCsVsXZLOKqZBNgHgpnySHqpdD6EAlPoQFp2yw4q7KQwfF/bseGRz9c9HfdhP8g=
X-Gm-Gg: ASbGncsqP08Ng496fpnqE42jEkUqASTfrtaDKODAVK2q2hdlEFVL/cZjAUVJlF2gK7t
 YXbWmt8Rel9uZDXPE2kbmPGFI/Vs/T+cgugFibP3aY9da/uMtaWw69wecdrQgSU06yY+H+5N7bf
 vpY+QJtTvKKYMlZQqpmdbvoOAqA0kKP36QdKP///m3cvPgGVy0I4yHU6btRUxmUDdnR5NQQMCEF
 jFEiwsiUcBLAVH3SQb8d2/OwzcTz1aoYi9kBETcMUeVSp28YRrvqAMl4Eqv2v0klM/ggbcDmu46
 uR8HAM9EwE1Ct2ctIIRYW3py18Xm4gvXCnU1Ehh+qPjbp6cOvAts/gwlVf+B/WcCbmia65WCqZT
 h2mk/vxDxiO6Avf1c6i5USWs6SrC+IhgDgA==
X-Google-Smtp-Source: AGHT+IHxhVfDXNRpvGiAkalOgsdDa5LsoZt1Vj1M/2AaaqISki+b8Fv4Nxohd6tBW4vuPr6BFcncrw==
X-Received: by 2002:a05:6000:2505:b0:3c9:fc3c:3aa3 with SMTP id
 ffacd0b85a97d-3c9fc3c3e07mr12647602f8f.40.1756387054041; 
 Thu, 28 Aug 2025 06:17:34 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b66cdb5d1sm53278655e9.8.2025.08.28.06.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 06:17:32 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 283A35F832;
 Thu, 28 Aug 2025 14:17:32 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  BALATON Zoltan
 <balaton@eik.bme.hu>,  Peter Xu <peterx@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,  John Snow <jsnow@redhat.com>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Nicholas Piggin <npiggin@gmail.com>,  Daniel
 Henrique Barboza <danielhb413@gmail.com>,  David Gibson
 <david@gibson.dropbear.id.au>,  Harsh Prateek Bora
 <harshpb@linux.ibm.com>,  Alexey Kardashevskiy <aik@ozlabs.ru>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Paolo
 Bonzini <pbonzini@redhat.com>,  David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org,  qemu-block@nongnu.org,  qemu-ppc@nongnu.org,
 devel@daynix.com
Subject: Re: [PATCH v7 1/2] memory: Update inline documentation
In-Reply-To: <CAFEAcA8A97ocOfv72KeSEgFkchmAOfc=GiX8QmvRui5=DDF=qQ@mail.gmail.com>
 (Peter Maydell's message of "Thu, 28 Aug 2025 11:11:54 +0100")
References: <59e70978-8895-f513-1b5e-1dc599e288ff@eik.bme.hu>
 <Z4AjkXbZeu3T94Y1@x1n> <Z4AldAcucTyqZ0HJ@x1n>
 <811633f6-6bf8-4a22-a21a-789e9a4747d7@daynix.com>
 <Z4E6TnKaUt8FMWIv@x1n>
 <9bb5f964-f930-4428-b800-8b589920fe1d@daynix.com>
 <Z4U30j9w1kPnKX9U@x1n>
 <5dc54c92-0382-4a70-9dad-588572698eed@daynix.com>
 <Z4aYpo0VEgaQedKp@x1n>
 <CAFEAcA_mpWZO8V9cE74bKzveEEZDXkqE+XbOFFdhmKUKO3dmSw@mail.gmail.com>
 <Z4a3GxEbz1jjCDc5@x1n>
 <CAFEAcA87oYqMj1t+yriXHLuTg3G-=eRwOvt4-n4uJmeNujTBxQ@mail.gmail.com>
 <d9acf231-829e-4a9c-7429-282fcc2ae756@eik.bme.hu>
 <2fe8b128-dda1-40af-89ac-e86ba53138f5@daynix.com>
 <CAFEAcA8A97ocOfv72KeSEgFkchmAOfc=GiX8QmvRui5=DDF=qQ@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Thu, 28 Aug 2025 14:17:32 +0100
Message-ID: <878qj3zitv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 17 Jan 2025 at 06:19, Akihiko Odaki <akihiko.odaki@daynix.com> wr=
ote:
>> Let me explain my and Peter Xu's solutions by listing object references.
>> It will abstract the details away and allow applying the analogy of
>> other reference counting systems like Objective-C.
>>
<snip>
>> "Weak" references
>> -----------------
>>
>> Next, I'll impose the restriction that prevents circular references. To
>> avoid circular references, we'll stop counting references for one
>> direction. In other words, we'll make some references "weak". Weak
>> references are prone to be dangling (in Objective-C or other platforms,
>> such references will be usually replaced with nil-like values).
>
> I'm not sure this is really how we think about the lifetimes
> of these objects, though. In particular, we definitely don't
> ever expect, for instance, the link from a memory region to
> its owner to be dangling.
>
> I think what we actually have is:
>  * the thing which really has a reference count is the
>    device object
>  * this device owns various things (irqs, child objects,
>    memory regions, etc)
>  * we expect that when we destroy the device that all these
>    other things it owns also should be destroyed
>  * some parts of the system have free-floating memory regions
>    which don't have an owner
>  * parts of the code have to deal with both the "MR belonging
>    to a device" and the "MR not belonging to a device" case

The virtio-gpu blobs are a special MR which we handle clumsily at the
moment as they are backed by separate thread (virglrenderer) and we need
to jump through hoops (c.f. virtio_gpu_virgl_hostmem_region_free) to
make sure it is done with the memory before we can free the container.

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

