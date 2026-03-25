Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404A7FEC11B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 11:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5M9E-0002KG-6O; Wed, 25 Mar 2026 07:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w5M9C-0002Jf-JR
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 07:11:38 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w5M93-0003G1-Hi
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 07:11:31 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-661d20c9787so3393738a12.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 04:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774437087; x=1775041887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1bmgkwDGo24tKk/Cbe1rB6xA0y8FbdJyUAky1FS5kTo=;
 b=xw8kgqXWrk+qWtbrO/IrYkb3U+Gci5aJ8IoKO9Um//RzcRJ7aLZDeIM3xSaoi/bTeo
 e+0yNtNGd8ZldphwT6Z+qJKg6+d2h1o7IfyOTStPq/Bf5bgmXSdThgwqICrhrEs+Q63h
 xu4TgOyHGUv8jEPoi53oJNQEGP2w6Asmgb82CTd8qnCvoIa4cJ0pzB88agc2H3wmN7MZ
 QN/nliIqVPCiJoIl7s6v4kcOeKNIgXOImDLGBDQcirhe2RB5k7uvh2aXErjKqzvxDIDj
 zlX/DSczCBbhCTDFZJehBgPCYmJOtyR9W/GzA2mZ7Hw0uWlx58RL8aZtuYXCqAFvbi6d
 kJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774437087; x=1775041887;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1bmgkwDGo24tKk/Cbe1rB6xA0y8FbdJyUAky1FS5kTo=;
 b=jro5S5z9bajwj4vNmL+/k094ULOWMzMO+ONWjdixJAaPUPhmeDOQxQTcR3MsO9Kd1u
 3jUHugj2Vg8RDa5Qogy+/Y8IuUbjDmqUz7NeQHKAGlaaTC0p7RNejJfxT1xy1/SpbOU8
 gbGQJyJVm7i4OVxmj8/6+Ki8nYPV9MLw6U42ybuIG4FAoXbDNNARun3P5BYqR8pprJON
 kWIjN23h6sDiiZOeozqcUUKMgmS/2lus9+XEZPZwr3DtrWUTLI8u/uRD85Szduf+7l01
 lyBoxDkZ6XT/VQHyXja4qHnZ/71Rp15RsOHBVgKEuhIYCj9l6+ThgxLSLiB0w/Mb3fgT
 n3Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBfBk4+qx+Olp04T70FdbtgTt3vQ5D06ufT7Lwmoj1A8JAFND3uNrP7v4me6hH9g+Y3nuaoDNjeua+@nongnu.org
X-Gm-Message-State: AOJu0YyxrkVqKHMpGgAiwpqsBu7kfggeds+CCC7KNF6Tv+VrLXvpgr/E
 1FZKjq5o+p3eTRkpwxsiHO25SQto5EnJD30vQh8w6oeFWMZEfLWDs/ETG64CLf2jWvM=
X-Gm-Gg: ATEYQzxrJKUsw97vIguMCIPGEvPryT2h0PS7ABXbpsH1aJ28gXgLPKb5DcX2HLxIb07
 niemiy0ORVdGpbGUFlfXAg8F1qACIwoYwnjG+ro2jGjTPwWGOu6hZs1k/nhMip+lbU5HGgeEkYX
 9CbThWALHTfrEvQ765reXg+JtkCfEy2bV7dabMWH6i6mwMqA2/ZWUVe4mnbA5wVL5RgRei9MzF3
 q20asEFFwGR2MZfudKNuZAwIQ3MSVo17abPwiHWukTZEoTuBnJB8n1vIq0HR3lRQdAa/eZnNIhZ
 9QtM59nTb5M+EqHa5eEojKJFZIuQoWRWOLi7l7gA2FUsGFONvjCD+g5nR6jg/HhCoZIpjvYnhND
 iCqTloq7sqsT98HjwsFcORU8KuxFRXX93Bus8r0beXQR90qfKcdY5791peab7mVHyreOtkprjsn
 xMPrFbOLzSrmp6+foaIeKfYYuykgnwhtdfEA==
X-Received: by 2002:a17:907:3e25:b0:b9b:1cad:fe98 with SMTP id
 a640c23a62f3a-b9b1cae00d0mr10388966b.48.1774437086765; 
 Wed, 25 Mar 2026 04:11:26 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f440e7sm771589666b.3.2026.03.25.04.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 04:11:26 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5891F5F878;
 Wed, 25 Mar 2026 11:11:25 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,  QEMU Developers
 <qemu-devel@nongnu.org>,  "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Stefano Garzarella <sgarzare@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Konstantin Kostiuk <kkostiuk@redhat.com>,  Eric
 Blake <eblake@redhat.com>
Subject: Re: Cleaning up contrib/ and tools/
In-Reply-To: <39b64118-7faa-4308-a603-d568cc78de47@linaro.org> (Pierrick
 Bouvier's message of "Tue, 24 Mar 2026 11:44:37 -0700")
References: <CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com>
 <ef2a0d92-c7f6-438b-a15a-2712e1c4373a@linaro.org>
 <CAFEAcA-kk29mjGWLrAGjd9AiAW64v0TvWdedZypSH0i43WgQzw@mail.gmail.com>
 <39b64118-7faa-4308-a603-d568cc78de47@linaro.org>
User-Agent: mu4e 1.14.0-pre3; emacs 30.1
Date: Wed, 25 Mar 2026 11:11:25 +0000
Message-ID: <878qbg410i.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 3/24/26 11:33 AM, Peter Maydell wrote:
>> On Tue, 24 Mar 2026 at 18:28, Pierrick Bouvier
>> <pierrick.bouvier@linaro.org> wrote:
>>>
>>> On 3/24/26 10:09 AM, Peter Maydell wrote:
>>>> And for contrib/, easy ones first:
>>>>    * contrib/vhost-user-{blk,bridge,gpu,input,scsi} move to tools/
>>>>    * contrib/elf2dmp moves to tools/
>>>>    * contrib/ivshmem-client and contrib/ivshmem-server move to tools/
>>>>    * contrib/plugins moves to plugins/plugins (or a different subdir
>>>>      name of your choice)
>>>>
>>>
>>> I would suggest plugins/contrib or plugins/community, to make clear they
>>> are the community contributed ones.
>>> @Alex, do you have a different suggestion/preference?
>> I firmly do not want us to have anything that claims to be
>> "contrib" or "community" or similar. Everything in QEMU is
>> community contributed in some sense. Either we care about
>> and maintain these plugins, in which case call them "plugins",
>> or we do not in fact care about and maintain them, in which
>> case delete them. "In the tree but not maintained" is not
>> a category I think we should have, and that is what "contrib"
>> generally implies.
>>
>
> We make sure they build, and test them (manually) on changes. The only
> difference with tests/tcg/plugins is that those are used for make
> check-tcg. I personnally consider both of them as properly maintained.

They are maintained.

The aim have having these more complete plugins in the source tree was
to ensure they where updated as APIs change as well as provide useful
tools compared to the more toy like implementations we use for
check-tcg.

I'm not sure about having them directly in the plugins folder as their
implementation is meant to be separated from the core QEMU code itself.
Maybe tools/plugins?

While we are at it we should consider moving the example plugin descriptions
from About/Emulation/TCG Plugins to the Tools section.

>
>>> Moving those sources will break build folder hierarchy also, which is an
>>> issue for all existing binaries built from contrib anyway.
>>> I'm not sure there is anything sane to do to fix that except accepting
>>> the breaking change.
>> What are we breaking here ? Nothing outside QEMU ought to be
>> depending on the layout of our source tree. When we move things
>> around we'll update the meson.build and the documentation.
>> I don't think we have 'contrib' in our installed-locations
>> layout (tools get installed into the bin/ dir, for instance),
>> but I might have missed something.
>>
>
> I was thinking more about users that might have custom scripts using
> various contrib plugins, or using vhost-* binaries or ivshmem-server
> or elf2dmp. They will be relocated because meson automatically uses
> layout of sources in build folder.
> It's not a big deal anyway.
>
>> -- PMM
>
> Regards,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

