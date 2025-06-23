Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818CDC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 16:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTjc3-0002IH-Hu; Mon, 23 Jun 2025 12:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uTjbu-0002GJ-5V
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:01:34 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uTjbq-0008Sw-QK
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:01:28 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so3207736f8f.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 09:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750694484; x=1751299284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DU4bZBou9LAAVdVrr6Ld25ONMj3wdbLa4mOlTx6S01A=;
 b=TrPXt2KQuYxN/fMZha157/I+Bfd0pTwK4Wr2r3g623okHsd5SSQ/WfFVFvxWdioKEo
 dbWRM0UBRoHErnDgA0ecawT87ns5ORoLYR5wXhu/WSSsylvuOjiAbun0Joy8A8i65QgQ
 Mj/rvG7s4flROO83vr7IByH2iqOiryLy4pOuRcPt9AH53QeW3rbha5i0nvwmKMa0BphV
 +WYbR6WmVyUz6ravXEESSDj6LS2ZWTrQxueEh9+YvN6XJxqH1mrkLfF4qpH2ZZHsO8PG
 F9DkQd6y7A0PT1Sgk2UFB1u0c+DH61zAf0+moVvahrJPmQGXKxoHlzhJaEDup6j2mceg
 9Y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750694484; x=1751299284;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DU4bZBou9LAAVdVrr6Ld25ONMj3wdbLa4mOlTx6S01A=;
 b=rUZZGjIYDfqFbqlNJ/DTvA36zomhC2HYgdmCYn1Jpzq6CYFJz9AUA0osrV9R+dvHcn
 IzsgfPxj58ZJUH3IaAI5v2V2tdUsJ9DDbZY6n92fhRAapXJ8CFxs+c9TaLmaa044ey0K
 BrJVjN3Aj/zp1yoGpwV14xcyeA5KcUhWD5LmSEP3MV1LkGLBQ+1a8QV3UgbdVW6cjK6T
 alFNmXWsVAy+vtI2duhIf7tWQ1F0xGLT3QcjgIOonp0YHn8dekTWP1mJlvufPbtVrf9G
 Ui2uI/zDEh5nH1IVMqaamJ9uIFqpYplmk1Rbxyxykqqux12bkN1setxuZI0KVfIeQ7M3
 bcUA==
X-Gm-Message-State: AOJu0Yz2/K3Ag46TxEZZ2o53VTGCOOiojXs1CV16gNtk1Dq8sRkR8FwR
 CJMD6K7ZYf5M7xlZUiDSVOtCZZGZxnvrZfwXnQ6cz76lMu9g5p5XPW7fvQShZWieBy8=
X-Gm-Gg: ASbGnctayxYTiHDe/HKQ0QvpPOTZY835l+o2TIvsZrmLoHyUAUahaI9GfLU9jRlsSnA
 U3pnSm0U69j/DtO3eQKPykCuzSQF5AeWYtCKhr+C9Ld5EOBvDcRCTZR+8dR4c64Y5MkiEdQ2/cp
 NaEFgw7lW3j+oMhkuhjglri4Slf+38H9Lee0lIRm9dx9ZWp2P/rTN2n9EP47VmRSDZxV6jcjJuJ
 75rmpy1rSYgUvKtuS6bCR54Tcc86axYq7YoTDpwj0VpgydHX22zvhGyom36z8Xfucwqm6AtPDld
 LuVK+qvNoEJWv7oT/znkldZYMGqIFXWR9Mds5O3Cb6r19o6oeT2NWNz6Nls9d7o=
X-Google-Smtp-Source: AGHT+IHpdekcjHe9tuPT5sbNvfpbZHtyMeUZcldY1trbSwYzgaJ0IVd+AXhTwUozst+QxUc436Rf0g==
X-Received: by 2002:a05:6000:2f87:b0:3a4:e238:6496 with SMTP id
 ffacd0b85a97d-3a6e71ff6f8mr20020f8f.18.1750694483186; 
 Mon, 23 Jun 2025 09:01:23 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1190b68sm9598520f8f.86.2025.06.23.09.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 09:01:22 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7E1DF5F815;
 Mon, 23 Jun 2025 17:01:20 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 qemu-arm@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Roman
 Bolshakov <rbolshakov@ddn.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,  Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Cameron Esfahani <dirty@apple.com>,  Cleber
 Rosa <crosa@redhat.com>,  Radoslaw Biernacki <rad@semihalf.com>,  Phil
 Dennis-Jordan <phil@philjordan.eu>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 26/26] tests/functional: Expand Aarch64 SMMU tests to
 run on HVF accelerator
In-Reply-To: <a8a4d2f7-2341-4cdb-8ca9-8deda337434c@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 23 Jun 2025 17:18:26
 +0200")
References: <20250623121845.7214-1-philmd@linaro.org>
 <20250623121845.7214-27-philmd@linaro.org>
 <87sejq1otw.fsf@draig.linaro.org>
 <a8a4d2f7-2341-4cdb-8ca9-8deda337434c@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Mon, 23 Jun 2025 17:01:20 +0100
Message-ID: <87ms9y1m7j.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 23/6/25 17:04, Alex Benn=C3=A9e wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>=20
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>> ---
>>>   tests/functional/test_aarch64_smmu.py | 12 +++++++++---
>>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tests/functional/test_aarch64_smmu.py b/tests/functional/t=
est_aarch64_smmu.py
>>> index c65d0f28178..e0f4a922176 100755
>>> --- a/tests/functional/test_aarch64_smmu.py
>>> +++ b/tests/functional/test_aarch64_smmu.py
>>> @@ -17,7 +17,7 @@
>>>     from qemu_test import LinuxKernelTest, Asset,
>>> exec_command_and_wait_for_pattern
>>>   from qemu_test import BUILD_DIR
>>> -from qemu.utils import kvm_available
>>> +from qemu.utils import kvm_available, hvf_available
>>>       class SMMU(LinuxKernelTest):
>>> @@ -45,11 +45,17 @@ def set_up_boot(self, path):
>>>           self.vm.add_args('-device', 'virtio-net,netdev=3Dn1' + self.I=
OMMU_ADDON)
>>>         def common_vm_setup(self, kernel, initrd, disk):
>>> -        self.require_accelerator("kvm")
>>> +        if hvf_available(self.qemu_bin):
>>> +            accel =3D "hvf"
>>> +        elif kvm_available(self.qemu_bin):
>>> +            accel =3D "kvm"
>>> +        else:
>>> +            self.skipTest("Neither HVF nor KVM accelerator is availabl=
e")
>>> +        self.require_accelerator(accel)
>> I think this is fine so:
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Thanks.
>
>> However I wonder if something like:
>>          hwaccel =3D self.require_hw_accelerator()
>> Could fetch the appropriate platform accelerator for use in -accel
>> bellow?
>
> Then we'd need to make it per-host arch, and I'm pretty sure hw
> accelerators don't support the same features. So I'd expect a
> rather painful experience. WDYT?

Aren't the features a function of the machine type rather than the host?
Shouldn't an -M virt machine look the same on TCG, KVM and HVF
regardless of the underlying accelerator?

I guess there are cases like split-irqchip which affect the
implementation but hopefully not the guest view of things.

Do you have an example?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

