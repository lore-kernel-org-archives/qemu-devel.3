Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BABC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 23:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMElL-0000AP-Ou; Mon, 02 Jun 2025 19:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uMElK-0000AD-4t
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 19:40:14 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uMElH-0002wc-EJ
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 19:40:12 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso6306257b3a.2
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 16:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748907609; x=1749512409; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qSx9eCDz+npIBRlvx6Em5F+h9fKCBFrhtrkqpcJrRZc=;
 b=K580QvjDT15ib1FS3lY3sRXKtuw3Lrrj3LET/nrI36YoIBdDCq/SPXZMr7S0kg6Y5z
 2407dI6audHfWfs4MuUqSkD6zsaMs+rdiWjGUaVNxwRy7/rK8EEFMVeH08CVnE+rYU4z
 6sBMslxuzvIRprACn9Yf2WBOO6NzkvdpcsTFw5H3K2+0MI5o7bifcu2VP5h1c3QUeQrI
 gCJZrUkkK1mmY/g7T2EBBJ974GNx4R76NVbQ2GVNw3xnATmhW6Fa3qL5QsYtgO39+uF/
 XdT/Eq7slt1vA75H2CjlQlf/V3JSx/nsZfie/ir9dxcGLi/cudHW6R+g+HarGaunQW+c
 0QBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748907609; x=1749512409;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qSx9eCDz+npIBRlvx6Em5F+h9fKCBFrhtrkqpcJrRZc=;
 b=UxFnrO1XB3c2d9M8VdDE1zReHTpYTyywMHEXUZwqEttT3Ku6L+WKu0naVIp4tdPCgA
 jKknJm2tWvPtg35GgIfGEXt6OBeodc/Qsml4i9S7Fzo6mqCyrUy6o43tCZFtuxPibkY+
 1oZi7k4Z1nn7CKzm9phQV3vDLvX7XtyJwdU4u77POq8ZzDN3pVrk/XPV7+yi0BiBEx+M
 IeHgPg3LvUKEp978p8NLsJVcwWR4v3qkD6unPuy59aYAmdkvcuQdCQ8vY7V0f6xV8DCv
 SQ//kGAfKgzkN8xC6e6UsaO0ABs39cy23FwvsPM/QxCSEYKHk/s/9sOWGqomVK3CVJnU
 8eDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSjKLUSDkz3veg4t6eEmCIfBUCrajcK2DfmT39STZaOvnA+P3PZeTiuJ0WP5b4ZXHP+jOpRyhF+3hL@nongnu.org
X-Gm-Message-State: AOJu0YwprptWZNU+59GNqrml5c3tRiWnS+1mZUwJnBu3GF3lJ6/tpDpm
 R1DB4ejg8yWMmexj/C+rSxFwu5iJY0mlo0gdt8KpaD/e0LitU6LZuhc6NYmDE9q6g1M=
X-Gm-Gg: ASbGncvLW/zPP+B9utI+ZqfbGtShjdIrGHHwr6DomWlspt0PbWFA+R2Q5ne/V3ybgwi
 gp8hl6BYMAgE89K9sCo/tolpR5A80nK2eRzrMVbk4slNbXZ34RtJ54xz0VMtnbRgNh9Zd5ihItG
 X81Q/qMm4lkycow7tyeoikIplUg5dgSDTDX9u41ezjAvpWi2s3q0LokQ+jTz4FQxFRfj1FiuM0V
 tMGDryT8MDffuGP7wezjlEZ528nCiW/tBfvR6f4EXqYKOTXiloMz/SatyoHtkNkpazuxkN88rEI
 NKiXaj+FBTGXTt2iBwNn69wn/1ION1e3Yo7NiaPrewGRVY5TESxj8irBQw55TYbr
X-Google-Smtp-Source: AGHT+IEzV3qnHUCQcXRnNVIJXTS4j3IHPyz/qLJXC2KQD95ePN4fVuML29mFQHWUJ+RAZCq8jmC6Gw==
X-Received: by 2002:a05:6a20:4310:b0:201:b65:81ab with SMTP id
 adf61e73a8af0-21ae0089535mr22992884637.23.1748907609358; 
 Mon, 02 Jun 2025 16:40:09 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747affcf83esm8135763b3a.126.2025.06.02.16.40.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 16:40:08 -0700 (PDT)
Message-ID: <20ac0dae-d0ed-4ec0-b934-43eaf91d1551@linaro.org>
Date: Mon, 2 Jun 2025 16:40:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/77] hw/arm: remove explicit dependencies listed
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Nabih Estefan <nabihestefan@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
 <20250530071250.2050910-3-pbonzini@redhat.com>
 <153c342a-428a-4620-bf91-52ebb4507b97@redhat.com>
 <b7e988ef-82da-43bc-8c57-3b49b3bf9529@linaro.org>
 <CA+QoejVhjy26FraUUMRtZtNPRW6u2MM3T=6hyguttPgx8qpkpw@mail.gmail.com>
 <e1abbc4a-7071-419e-ab49-64828e682064@redhat.com>
 <c54469ce-0385-4aea-b345-47711e9e61de@linaro.org>
In-Reply-To: <c54469ce-0385-4aea-b345-47711e9e61de@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 6/2/25 3:37 PM, Pierrick Bouvier wrote:
> On 6/2/25 2:11 PM, Cédric Le Goater wrote:
>> On 6/2/25 22:53, Nabih Estefan wrote:
>>> Hi Pierrick,
>>>
>>> For what it's worth, those files were also breaking on Ubuntu and Debian for me.
>>> I had to explicitly `sudo apt install libfdt-dev` for it to work
>>> again. I don't believe
>>> it was installed at all previously, but QEMU was building and working correctly
>>> without it being explicitly installed.
>>
>> yes. I had to install libfdt-dev/el on some systems too.
>>
>> However, for the windows (on Linux) build :
>>
>>      ./configure --cross-prefix=x86_64-w64-mingw32- --target-list=aarch64-softmmu,ppc64-softmmu,x86_64-softmmu,s390x-softmmu --disable-docs --disable-sdl
>>
> 
> Thanks Cédric, I could reproduce it using the fedora-win64-cross
> container. After investigation, it's related to having a target-list,
> and in a specific order (hum, hum, feels bad). I observe the same
> behaviour when building normally for Linux too.
> 
> Those 3 commands work as expected:
> $ ./configure --target-list=aarch64-softmmu  && \
> ninja -C build libsystem_arm.a.p/hw_arm_raspi4b.c.o
> $ ./configure && \
> ninja -C build libsystem_arm.a.p/hw_arm_raspi4b.c.o
> $ ./configure --target-list=s390x-softmmu,aarch64-softmmu && \
> ninja -C build libsystem_arm.a.p/hw_arm_raspi4b.c.o
> 
> This one fails:
> $ ./configure --target-list=aarch64-softmmu,s390x-softmmu && \
> ninja -C build libsystem_arm.a.p/hw_arm_raspi4b.c.o
> 
> I will investigate more, but I strongly suspect there is a bug in the
> meson libraries patch I wrote, with a variable being reused when it
> should not.
> Sorry for the inconvenience.
>

Fix sent here (was indeed a wrong variable reused):
https://lore.kernel.org/qemu-devel/20250602233801.2699961-1-pierrick.bouvier@linaro.org/

> Regards,
> Pierrick


