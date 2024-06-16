Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF6DC27C53
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2024 18:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIuqu-0006uN-0L; Sun, 16 Jun 2024 14:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sIuqs-0006te-8J
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 14:43:42 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sIuqq-0005hl-G3
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 14:43:42 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-35f1dc4ab9aso3016192f8f.3
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2024 11:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718563418; x=1719168218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=61uU3w5r/LIuL9mGfsdmC7+uInEtZsL4PLydE/0gEyQ=;
 b=as4qR4uQL5Zkrb0gpPFWStPX1h0wlhOXEz5jee2M6ewotppitV4nrPZbneJo6zR6oZ
 p0zwE8tvwQZ017xwPMqVgD03of0OUjYFDsaOZX+lv04VVBQFCn05NQ+bqbvenBKfmAkS
 uCVU9Uz/nx+J6ldvkW4O1w3uyXHhOX5guInUoS+i/ZiDH3q5+ZT77NvQcftH/PN+i7BQ
 3ntUTP1AJyPXogaPnylKqzbYB7JkRrOx0EewkSa2UC1/mYO8zZ7eQ8TrEhStezW6fRK/
 NM1NdhEUvGHRFvdbCNAYjpQ7u2oyQ/goMeFyQfE0G3vx/Tl0uEXDdgGVGvUpMJWnJISA
 0A1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718563418; x=1719168218;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=61uU3w5r/LIuL9mGfsdmC7+uInEtZsL4PLydE/0gEyQ=;
 b=ZqNr5Z8Mh5QY67Z/teA6uSfalTTjZVZYsoVTo0ujMSV13nlXUeLuHHeHwlR9oazHh6
 l75vngFRcoRQez6HxVhWGDagqy/iidAOqQ+aNgZop67vT7XmNJRyKWRrcXrETGaSKrJx
 5Rx96ACrB7PxplW6Psv/dyvy7iSFX9NIraRDvcGovMKOBjg5hxkxwP0QAUyp2XNCrYgP
 vdNXapQvHOP+P+HnN0amrZRpj4VjOUmGwjLMYiOTt1dTTyJLgSSeXcDh/y2r25DS9tnS
 XiDpSc9glXZ2Ehlgr+OAIwvl7h19nyBsNtV5Rf6Rfuz6EU3Jxepm8Ri4GsyR1IVuNT/B
 +Q9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVP7/gRS2N9aAY1CyVCqaCFRSYMFdglvyXKcuXnztiwz+WPR3Hbn0awN01+8lz1NcUM06Ql/bGUy0YNm/kB+LxvS8neY0=
X-Gm-Message-State: AOJu0YxsTOLreQd2iKHtenKLEf22io97D+F2PZqAOqMJPzIvemLgs469
 8KIrtUwiTCRNcSbVKPOg86UC38CsSIm0ou2Xbj98dqYMO4lNG6I9iynK6bmAyhs=
X-Google-Smtp-Source: AGHT+IEldkSREus3vB6BTyry8+OqgS+HADxfRtbrtfhNZMy3m6/pRi886sUQFFDfdu2/VhLJuWDQFg==
X-Received: by 2002:a5d:4a4c:0:b0:35f:1d29:db8d with SMTP id
 ffacd0b85a97d-3607a76374dmr4589048f8f.25.1718563418197; 
 Sun, 16 Jun 2024 11:43:38 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075104a3dsm10173809f8f.112.2024.06.16.11.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Jun 2024 11:43:37 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 429C85F91D;
 Sun, 16 Jun 2024 19:43:37 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>,  Ilya Leoshkevich
 <iii@linux.ibm.com>,  Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Mark Burton <mburton@qti.qualcomm.com>,
 qemu-s390x@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org,  Laurent Vivier <lvivier@redhat.com>,  Halil Pasic
 <pasic@linux.ibm.com>,  Christian Borntraeger <borntraeger@linux.ibm.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  qemu-arm@nongnu.org,  Alexander
 Graf <agraf@csgraf.de>,  Nicholas Piggin <npiggin@gmail.com>,  Marco
 Liebel <mliebel@qti.qualcomm.com>,  Thomas Huth <thuth@redhat.com>,  Roman
 Bolshakov <rbolshakov@ddn.com>,  qemu-ppc@nongnu.org,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Cameron Esfahani <dirty@apple.com>,  Jamie Iles
 <quic_jiles@quicinc.com>,  "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 9/9] contrib/plugins: add ips plugin example for cost
 modeling
In-Reply-To: <db8d82d4-c88d-45ac-bc99-e85a4240add2@linaro.org> (Pierrick
 Bouvier's message of "Fri, 14 Jun 2024 10:39:38 -0700")
References: <20240612153508.1532940-1-alex.bennee@linaro.org>
 <20240612153508.1532940-10-alex.bennee@linaro.org>
 <31ba8570-9009-4530-934d-3b73b07520d0@linaro.org>
 <db8d82d4-c88d-45ac-bc99-e85a4240add2@linaro.org>
Date: Sun, 16 Jun 2024 19:43:37 +0100
Message-ID: <87frtcsp7q.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 6/13/24 01:54, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 12/6/24 17:35, Alex Benn=C3=A9e wrote:
>>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>
>>> This plugin uses the new time control interface to make decisions
>>> about the state of time during the emulation. The algorithm is
>>> currently very simple. The user specifies an ips rate which applies
>> ... IPS rate (Instructions Per Second) which ...
>>=20
>>> per core. If the core runs ahead of its allocated execution time the
>>> plugin sleeps for a bit to let real time catch up. Either way time is
>>> updated for the emulation as a function of total executed instructions
>>> with some adjustments for cores that idle.
>>>
>>> Examples
>>> --------
>>>
>>> Slow down execution of /bin/true:
>>> $ num_insn=3D$(./build/qemu-x86_64 -plugin ./build/tests/plugin/libinsn=
.so -d plugin /bin/true |& grep total | sed -e 's/.*: //')
>>> $ time ./build/qemu-x86_64 -plugin ./build/contrib/plugins/libips.so,ip=
s=3D$(($num_insn/4)) /bin/true
>>> real 4.000s
>>>
>>> Boot a Linux kernel simulating a 250MHz cpu:
>>> $ /build/qemu-system-x86_64 -kernel /boot/vmlinuz-6.1.0-21-amd64 -appen=
d "console=3DttyS0" -plugin ./build/contrib/plugins/libips.so,ips=3D$((250*=
1000*1000)) -smp 1 -m 512
>>> check time until kernel panic on serial0
>>>
>>> Tested in system mode by booting a full debian system, and using:
>>> $ sysbench cpu run
>>> Performance decrease linearly with the given number of ips.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> Message-Id: <20240530220610.1245424-7-pierrick.bouvier@linaro.org>
>>> ---
>>>    contrib/plugins/ips.c    | 164 +++++++++++++++++++++++++++++++++++++=
++
>>>    contrib/plugins/Makefile |   1 +
>>>    2 files changed, 165 insertions(+)
>>>    create mode 100644 contrib/plugins/ips.c
>>>
>>> diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
>>> new file mode 100644
>>> index 0000000000..db77729264
>>> --- /dev/null
>>> +++ b/contrib/plugins/ips.c
>>> @@ -0,0 +1,164 @@
>>> +/*
>>> + * ips rate limiting plugin.
>> The plugin names are really to packed to my taste (each time I look
>> for
>> one I have to open most source files to figure out the correct one); so
>> please ease my life by using a more descriptive header at least:
>>        Instructions Per Second (IPS) rate limiting plugin.
>> Thanks.
>>=20
>
> I agree most of the plugin names are pretty cryptic, and they are
> lacking a common "help" system, to describe what they do, and which
> options are available for them. It's definitely something we could add
> in the future.
>
> Regarding what you reported, I'm totally ok with the change.
>
> However, since this is a new series, I'm not if I or Alex should
> change it. If it's ok for you to modify this Alex, it could be simpler
> than waiting for me to push a new patch with just this.

Its my tree so I'll fix it up. I'll ask you if I want a respin ;-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

