Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5905AC5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 22:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMDmV-0002rS-7q; Mon, 02 Jun 2025 18:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uMDmS-0002qV-BI
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 18:37:20 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uMDmO-0004tp-U5
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 18:37:19 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-311e46d38ddso3872182a91.0
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 15:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748903835; x=1749508635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dW8H1hqGsiQB+qTug59UNo1hf5lIkfclvoCGfLgg2tA=;
 b=KJrM6qYNClDcsGJvPguuHSHcAK4oaxQnCS1GC9RvJYz9mQy6N9ov7dEIvTTvPzyR95
 3Yr11IFUOU6Arir/yQziiLlLYe1O3+DIulg3Ue/1FnA+eOQFlWTHoo5PD9bVfO15VSiN
 IW/RDXRSJQ/N9dGvI00YbGvSkPxWqlTNAZRFS4IyldBD+CeBFDQTb0jDVwYFmfhcrd0c
 LDG4t0LXkv69hAZcBT5Qzuvuj7ny6YtVkeDUzizEZr6wIaJB5xsleLnYYufpD98fq9m/
 mEHQTgPc6WThMVGrGxeau1oY+1EMqLYFZPbv5pA9DUqEWMS+tnFPH3Ly/Zwjcjs+cWrC
 AxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748903835; x=1749508635;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dW8H1hqGsiQB+qTug59UNo1hf5lIkfclvoCGfLgg2tA=;
 b=pnDUxlNrjIjfD6EVGmQxu8nDD3OD8suSFpMyff/UX+RbXQ02kJHgFcVxT6HxYYmxMo
 z+yNaZBzNmAZ4Z+bTXRuMAGfTgiEcLjrBEu95xBTmSZ7ALwNF6XeEWplfhnL4IUSO/O4
 ZZLTe9FW2R8h4abUTS2D9HzzWtbwKJZ0wdkIGV8wZN5rsImmzwHznOC5ekd2MxPz2VcP
 Mg/TU8p0a+P4i6/xzpd5S6vC8kZKX+/svod63GK9SJr/TCPL7V82LrtHPeuMn1nFCika
 LZIS7qfY9aI3SN2qumT8XV/zuh8CfpM7p8MNEJWobFlrvb6XhD4y8LQjbcso46HvIpxC
 gNag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMBsCvdNNCsYUmjYnVlObXajwgHYEkCNKBVO1pPj+ih4HiuiPD8mfVxZe7p8SG+kRNScL5Fuu4IOzH@nongnu.org
X-Gm-Message-State: AOJu0Yz1eKbcdXSYPYV601pI5qYE5rdoIG3cF9bfZRElVD2ge0+1zUTY
 hLZ9bct/vNxL5nKbZ0m4GIiKaOCLMTOA7oP7fab3IDZPHM8KUd5c9qXmWKrKfgOw9d4=
X-Gm-Gg: ASbGncutI8rneyStmRVxXBoUTKOf7nvMPuK0VS31JNFaRgP+ukrfA/lBP8ctrAzS3tb
 xBLG6nA1itZapqzqQRCgELnxGLKn/x6/SyhcDKhSPSMseeQgQ2EzkyWl7nh+RvYWY+aBnVPpmOg
 Tdt3RL4jREaC0UwkUSOBiuUGLEqjlZeWW64glooTCRA/1f1xhnAtXOcvPDlmOKhcENgbELi0dQg
 cIJV47lvTOVmFJas1/yvgoxA6VjzN4l7bAOj7yFqNmrQdPEHzIsUpVxaBYn3DavzdOEHbSm7P2W
 EqdlKxj3ZJm/2WPstpQaxtninu12mCKSdDdzXqSWYAVE2i97S2yerZxjApbxbZJx1020NqqwPjw
 =
X-Google-Smtp-Source: AGHT+IEORVvm5tfle5qubBgcPqZ7zcBWefwEEm2FXEaBnBJJ3Io+yXsB1asoo/ou43GIMHAHd01JgQ==
X-Received: by 2002:a17:90b:1343:b0:30e:8f60:b4c with SMTP id
 98e67ed59e1d1-31241735a7dmr24986021a91.16.1748903835232; 
 Mon, 02 Jun 2025 15:37:15 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3124e3c1146sm6121966a91.35.2025.06.02.15.37.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 15:37:14 -0700 (PDT)
Message-ID: <c54469ce-0385-4aea-b345-47711e9e61de@linaro.org>
Date: Mon, 2 Jun 2025 15:37:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/77] hw/arm: remove explicit dependencies listed
Content-Language: en-US
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
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <e1abbc4a-7071-419e-ab49-64828e682064@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

On 6/2/25 2:11 PM, Cédric Le Goater wrote:
> On 6/2/25 22:53, Nabih Estefan wrote:
>> Hi Pierrick,
>>
>> For what it's worth, those files were also breaking on Ubuntu and Debian for me.
>> I had to explicitly `sudo apt install libfdt-dev` for it to work
>> again. I don't believe
>> it was installed at all previously, but QEMU was building and working correctly
>> without it being explicitly installed.
> 
> yes. I had to install libfdt-dev/el on some systems too.
> 
> However, for the windows (on Linux) build :
> 
>     ./configure --cross-prefix=x86_64-w64-mingw32- --target-list=aarch64-softmmu,ppc64-softmmu,x86_64-softmmu,s390x-softmmu --disable-docs --disable-sdl
>

Thanks Cédric, I could reproduce it using the fedora-win64-cross 
container. After investigation, it's related to having a target-list, 
and in a specific order (hum, hum, feels bad). I observe the same 
behaviour when building normally for Linux too.

Those 3 commands work as expected:
$ ./configure --target-list=aarch64-softmmu  && \
ninja -C build libsystem_arm.a.p/hw_arm_raspi4b.c.o
$ ./configure && \
ninja -C build libsystem_arm.a.p/hw_arm_raspi4b.c.o
$ ./configure --target-list=s390x-softmmu,aarch64-softmmu && \
ninja -C build libsystem_arm.a.p/hw_arm_raspi4b.c.o

This one fails:
$ ./configure --target-list=aarch64-softmmu,s390x-softmmu && \
ninja -C build libsystem_arm.a.p/hw_arm_raspi4b.c.o

I will investigate more, but I strongly suspect there is a bug in the 
meson libraries patch I wrote, with a variable being reused when it 
should not.
Sorry for the inconvenience.

Regards,
Pierrick

