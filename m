Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D684CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 14:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBDGd-0004Yy-3q; Tue, 21 Oct 2025 10:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBDGa-0004Xu-So
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:23:12 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBDGX-0003Cn-Fb
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:23:12 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so45687865e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 07:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761056587; x=1761661387; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lujhmAKv4qj3zqFSyJwljj3Hbz9BgNvxk1iEvf3EvUc=;
 b=uXJ59olNjNURkU6YlY2UI0K/JHPH5mhfy7E0A1LVj9mRtVyK+/xXLya9MdbZqou5dS
 jN8mdNbLclVyYWrbg7/cLwuMTATmFioBjMD/3+sDFYu+EoGfD1bAnaQQ3xEXcdQCui8v
 cJqd7Rt2TuCsIYtWREiFMHOFVjX8ldYD4bi08fy2VNeOr4tnqP1WzCHqr/5DeSQXkcSZ
 J0zW0Vt7zhORd5DIgT6efec1/Bi/9+gq6Qd9FVMan9w2NFzOSwAzB7IuST6TQvX571E9
 TLEDEo3vyFZXsloD33Re6Ds/cwfIEqplL1eGzhuzzh9hqLnIZos94lXHr87Gs3XY/e9y
 BE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761056587; x=1761661387;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lujhmAKv4qj3zqFSyJwljj3Hbz9BgNvxk1iEvf3EvUc=;
 b=IfdjWjlou9Z6DT3d80r6TaVTGdJqvFpuggubGrRJ9KE6EREnBIRwleT7ZE6bcvj3Of
 RnQ9MZcjA6Qc1HQwi7+5gLinEI9cb4Ul49ebhHxHQvA9y9StwDMC73BVVf4NIwWoCaei
 ZeI1pMXL8aRHVZo/MB/pGZ0PJzDQpcbebqtrsNmZxonvxwuGB6vl6Ti96LNRGvRCBxAH
 VnOwR79kh04K/DD4BAd9hfh1vvp6uRqmwokvfLgUvSwC+1RiYS+mAKFKr+A1jyX6uSYK
 uLxRuvKzMar2q2jZRM790Lj56j/lIV17a28F/7PHdby1MAsbuAWKp4vsm7EYBBI4knom
 1yRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL48uNfPDPb+d+TuiXxfRjxgVufPADRZiuo7YEEGYKtn89+++0GDyHdHECR+WpMAoBpuizTfRFwbOG@nongnu.org
X-Gm-Message-State: AOJu0YwKs40w2E9oMDvPYCkWfWKCPkyMq5LeVxBwAqet/XJQNtcn6V4f
 fi1x618FSlICPlEoZNvpm/Z5D1fWhTKI5j6GTvA7zuBpgo2s96l1hhkSLcBmZt9vWXI=
X-Gm-Gg: ASbGncvCuwGfFsFgWc4DpAnEAQcYrJ6RSkI2mtyaVwN6HlEbNwUmjXushX9i2tS+Nf9
 Vj4REzlQZAcjQfruKiVvF4V71SzWB444v4l1mkZLFVX3OakNY3S2D3v3PHJs0QGZu2Qru1HM34/
 QFeNlcCjq6iY5Fh58iF8Xz3/eXJI7iiiIsFX69gCIQb5xDUdVARcCfnefXvdmoqBYJYwbVBQu88
 n1BtOPi1NHTkSHpE1WiFaeQm3dNsfLap7Rofn1z7PylViAIvcRKX9UDPi/VTLdZ74JjdcU3+q/V
 jJjUodyBWu/HFshPVoyNBLiiSttqe6ML28n/qgjGkkJVLFTzrONfX224dpn5T8wS5C00e3BH4U0
 gZWQqVXqdzlDAcaklm/6cIghNqqo/H6MuwK7Fq6lyHIo10oIf3VIIuR4uGYRZmaEPfWsmg3GcLw
 fAHgRELSyEHzSizpUDRan2HT2obC2w4eNoDodUKetckD2qDBQPeU8yEA==
X-Google-Smtp-Source: AGHT+IGpNQZriF03nrUdfXcsadeGS/wWcOcHtxrbwixqf2QWNQLelRmKaF2GA7cZAx1ECPorWCWExA==
X-Received: by 2002:a05:600c:820b:b0:46e:1fc2:f9ac with SMTP id
 5b1f17b1804b1-4711787dc76mr114596775e9.10.1761056586906; 
 Tue, 21 Oct 2025 07:23:06 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00cdf6csm20473949f8f.43.2025.10.21.07.23.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 07:23:05 -0700 (PDT)
Message-ID: <f764e4cf-d134-4c4d-a313-a5b7dd6620d0@linaro.org>
Date: Tue, 21 Oct 2025 16:23:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] char: rename CharBackend->CharFrontend
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Laurent Vivier <lvivier@redhat.com>,
 Amit Shah <amit@kernel.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, =?UTF-8?Q?Cl=C3=A9ment_Chigot?=
 <chigot@adacore.com>, Frederic Konrad <konrad.frederic@yahoo.fr>,
 Alberto Garcia <berto@igalia.com>, Thomas Huth <huth@tuxfamily.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Magnus Damm <magnus.damm@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Collin L. Walling" <walling@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Corey Minyard <minyard@acm.org>,
 Paul Burton <paulburton@kernel.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Michael Rolnik <mrolnik@gmail.com>, Antony Pavlov <antonynpavlov@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Vijai Kumar K <vijai@behindbytes.com>,
 Samuel Tardieu <sam@rfc1149.net>, Gustavo Romero
 <gustavo.romero@linaro.org>, Raphael Norwitz <raphael@enfabrica.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "reviewer:vhost-user-scmi" <mzamazal@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Jason Wang <jasowang@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 Lukas Straub <lukasstraub2@web.de>,
 "open list:Sharp SL-5500 Co..." <qemu-arm@nongnu.org>,
 "open list:S390 SCLP-backed..." <qemu-s390x@nongnu.org>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 "open list:virtiofs" <virtio-fs@lists.linux.dev>,
 "open list:Rust-related patc..." <qemu-rust@nongnu.org>
References: <20251021122533.721467-1-marcandre.lureau@redhat.com>
 <CAFEAcA-jPE_onLYLMxgcAOB7dWRXOLJrWcGPnR0NUdjYytPDVA@mail.gmail.com>
 <aPePcTKl6s4FoLCL@gallifrey>
 <CAJ+F1C+bGKtY6nf3LCXrwhZ2aEdu2npXJ9FapmsqgX0uLL5TUw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJ+F1C+bGKtY6nf3LCXrwhZ2aEdu2npXJ9FapmsqgX0uLL5TUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 21/10/25 15:58, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Oct 21, 2025 at 5:52 PM Dr. David Alan Gilbert <dave@treblig.org> wrote:
>>
>> * Peter Maydell (peter.maydell@linaro.org) wrote:
>>> Marc-André Lureau <marcandre.lureau@redhat.com> wrote:
>>>> The actual backend is "Chardev", CharBackend is the frontend side of it,
>>>> let's rename it for readability.
>>>
>>> I always thought the "frontend" was the device the guest
>>> saw (the 16650 UART or whatever). invocation.html has bits
>>> talking about "virtio hvc console frontend device" which
>>> seem like they also use that terminology.
>>>
>>> If we want to clean up the naming it might be helpful to have
>>> a comment somewhere documenting the different components and
>>> what names we give them and how they fit together (or even
>>> better, something in docs/devel/...)
>>
>> Or something more descriptive like 'CharGuestSide'
> 
> If we are talking about the Chardev frontend or user, that's too
> restrictive. We have generic stream handling code (think
> mux/hub/tests/client/server etc) that do not fit that usage naming.

Isn't it

- backend -> host adapter
- frontend -> implementation used by guest

?

