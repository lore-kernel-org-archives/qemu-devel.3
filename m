Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F49E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 12:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLiMq-0004O2-TR; Thu, 12 Dec 2024 07:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tLiMY-0004MD-BX
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 07:32:15 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tLiMU-0005wm-ID
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 07:32:13 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5cf6f804233so725060a12.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 04:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734006727; x=1734611527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rryo9QOGHZWk3odfntLuAGrtXKMIOLQcx/zcX4OcaDo=;
 b=rP3TWeYawc5McMYp1D3WuYqJ4p/Sr7bk0jzT8y2zv1AUoaix87qWxuIDAcat0sHc6Q
 H6da+EQflKTtjlatxkFJ7nBjIchCZa8lGjLOz3HEq5mfEXuQ8xjWx5YODWtYHOLEaGq4
 uZWcA7knJebGz3qiKmBW0SLJpuPKiUMErwmR/fExwRkil/v6MrEZ25GQ6YQN+yUxdkQ6
 UnR+dOwfwOvkrGnI15dKN3WDidspx206yeG/l79A5cpoFNcEd9SpugTuqc0LaOkpPxlF
 wjmZvxA3cvP2PVh20iyBtV+jAuVHtxTZ7hJiVJargOjiW7zsboxv5dU24fcteXs3V9k/
 REOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734006727; x=1734611527;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rryo9QOGHZWk3odfntLuAGrtXKMIOLQcx/zcX4OcaDo=;
 b=Jtcnxn/x56aI6LEKelMjbxirHgZzWVM3FSIlmtYDzZHvcwqZL/I7YUN2MHXAGWKYkT
 OI1BcDWFcQ2hdNA3p4pK837aY7HCY3vXzg2DceWONUaavttIbZsBJZC8e9CPnMKyXRqV
 aigp+sdg/vxKHGCkjlOlZHovZ0YB9YrSKF555BQZ0d1CLPsQJ2nS1sPvhxRyM6S7mxre
 7W5l6IaKrfYhIVuWNV9tINNMKxxa0RY4pEfGLSbJk+614aqWUNBlGXVymEI2/UVRLItH
 u6OsFXY76OWau8Y7OEgYSmFrEJL+8KKMIiumPWCVowqteDI4Lq09Qn367wr56hqEVRwk
 pQ7w==
X-Gm-Message-State: AOJu0YzgDIm7rV3fL30ZuqM8UCPbAFbGeTBYON+zmE5JsoyWznh0oL5E
 FjcG2K4zYMum5vJA+mXNcqjcnfGZGV1GGiO1Wa22eU4I4rPXYfN9S3nlhqjAF24=
X-Gm-Gg: ASbGncs4QIikgxwP9pF9Y3ofRBr8GnXrDD5Miq7e49nIWnzdQ1OYGhIcFfTNoQ8qJU4
 nmj4AJ9KwvuKC6ksQ3yiVIuMq2yCDVYvxcD0QxBN0VCCWgj2cKVUL3fL1Oiuc7cDtr4Z+WsS8tN
 0CWRb1A/rYvoMePhb7rEJXHtpD9Okbgs8Tcpa4MNyJ4HNfCDOadr2qBEn6MIYM+Oid5+TheWeTJ
 2HHLCF321UB+wAD0nMWAMhPHeDj3PnlM/JxWFvvKzhgEi40CAiC4m8=
X-Google-Smtp-Source: AGHT+IEMNwKMF5XqilWAi/SyxKdw/LuJfcpu/iO3LoKkCQbmDUbgfuqP3Pt6HTc4gwh7tqatZYOnlg==
X-Received: by 2002:a05:6402:35ca:b0:5d0:e877:764e with SMTP id
 4fb4d7f45d1cf-5d6334f69a2mr70443a12.24.1734006727130; 
 Thu, 12 Dec 2024 04:32:07 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d3f1323f99sm6497588a12.34.2024.12.12.04.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 04:32:06 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DD03D5F8CF;
 Thu, 12 Dec 2024 12:32:04 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  "Daniel P. Berrange" <berrange@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-s390x@nongnu.org,  Halil Pasic <pasic@linux.ibm.com>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Weiwei Li <liwei1518@gmail.com>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Cleber Rosa <crosa@redhat.com>,  Palmer
 Dabbelt <palmer@dabbelt.com>,  Leif Lindholm <quic_llindhol@quicinc.com>,
 Eric Farman <farman@linux.ibm.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  John Snow <jsnow@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Harsh Prateek Bora
 <harshpb@linux.ibm.com>,  Aurelien Jarno <aurelien@aurel32.net>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Joel Stanley <joel@jms.id.au>,  Bernhard
 Beschow <shentey@gmail.com>,  qemu-ppc@nongnu.org,  qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,  Laurent Vivier
 <lvivier@redhat.com>,  qemu-arm@nongnu.org,  Wainer dos Santos Moschetta
 <wainersm@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Markus
 Armbruster <armbru@redhat.com>,  Bin Meng <bmeng.cn@gmail.com>,  Pavel
 Dovgalyuk <pavel.dovgaluk@ispras.ru>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Beraldo Leal <bleal@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Radoslaw Biernacki
 <rad@semihalf.com>,  Nicholas Piggin <npiggin@gmail.com>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 20/20] tests/functional: extend test_aarch64_virt with
 vulkan test
In-Reply-To: <d2a73820-58fa-41d0-8f38-68b0ad53fa7d@redhat.com> (Thomas Huth's
 message of "Wed, 11 Dec 2024 07:58:00 +0100")
References: <20241210204349.723590-1-alex.bennee@linaro.org>
 <20241210204349.723590-21-alex.bennee@linaro.org>
 <d2a73820-58fa-41d0-8f38-68b0ad53fa7d@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 12 Dec 2024 12:32:04 +0000
Message-ID: <87bjxhrsjf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> On 10/12/2024 21.43, Alex Benn=C3=A9e wrote:
>> Now we have virtio-gpu Vulkan support lets add a test for it.
>> Currently this is using images build by buildroot:
>>    https://lists.buildroot.org/pipermail/buildroot/2024-December/768196.=
html
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
<snip>
>> +        self.vm.set_console()
>> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
>> +                               'console=3DttyAMA0 root=3D/dev/vda')
>> +        self.require_accelerator("tcg")
>
> Same, please move to the beginning since it can skip the test.
>
>> +        self.vm.add_args("-accel", "tcg")

Actually this could run under KVM if we have it for Aarch64. Can we
represent that?

>> +        self.vm.add_args("-cpu", "neoverse-v1,pauth-impdef=3Don")

I guess in that case we'd use -cpu host as well.

>> +        self.vm.add_args("-machine",
>> +                         "virt,virtualization=3Don,"
>> +                         "gic-version=3Dmax",
>> +                         '-kernel', kernel_path,
>> +                         '-append', kernel_command_line)
>> +        self.vm.add_args("-smp", "2", "-m", "2048")
>> +        self.vm.add_args("-device", "virtio-gpu-gl-pci,hostmem=3D4G,blo=
b=3Don,venus=3Don")
>> +        self.vm.add_args("-display", "egl-headless")
>> +        self.vm.add_args("-display", "dbus,gl=3Don")
>> +        self.vm.add_args("-device", "virtio-blk-device,drive=3Dhd0")
>> +        self.vm.add_args("-blockdev",
>> +                         "driver=3Draw,file.driver=3Dfile,node-name=3Dh=
d0,read-only=3Don,"
>> +                         f"file.filename=3D{image_path}")
>> +        self.vm.add_args("--snapshot")
>
> Any reason for using double dashes just here and not for the other comman=
ds?
>
>> +        try:
>> +            self.vm.launch()
>> +        except VMLaunchFailure as e:
>> +            if "old virglrenderer, blob resources unsupported" in e.out=
put:
>> +                self.skipTest("No blob support for virtio-gpu")
>> +            elif "old virglrenderer, venus unsupported" in e.output:
>> +                self.skipTest("No venus support for virtio-gpu")
>> +            else:
>> +                self.log.info(f"un-handled launch failure: {e.output}")
>
> s/un-handled/unhandled/ ?
>
>  Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

