Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59725CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 12:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPJgk-0002GZ-Sj; Tue, 19 May 2026 08:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wPJgi-0002GL-V8
 for qemu-devel@nongnu.org; Tue, 19 May 2026 08:36:45 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wPJgg-0007re-Vt
 for qemu-devel@nongnu.org; Tue, 19 May 2026 08:36:44 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-44ce78ab5feso2952138f8f.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 05:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779194201; x=1779799001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wRTnoBxN0lbRbmFFTzOCk04MZRCz5mKr5D6NYiZN+j4=;
 b=iAdAxxcy2MZWw+u27pqcRup33I9HA/s/ttgjG6b6vaz8/hrYe9rgsSyXXIbz3gjSMX
 ipCJeBxrazmi/HoL+DV2Vnqww7CqSsS77iomVBHYXr5qSoktJu9si8+1qXVHeKsSValS
 q6EgF61z0HDFH/zJhWr0hIRg2L5ipsFN90wzPs55dNw95sUnZyu2iCEE/FsFhgWBY3WU
 Qs2qubg0Qr7xVImGlC5cSYjefBvRhMKgPAiWldusLBCH9k7o+SgT1MnfL8jjABN1TCdp
 ycEQxMh4PxIURGV6YFlcSTXJkcs4PkLMo9maVa2xFYc+ndfJd944WIALNDBIBTwWMAWs
 NKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779194201; x=1779799001;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wRTnoBxN0lbRbmFFTzOCk04MZRCz5mKr5D6NYiZN+j4=;
 b=S7KHrWO3RdmopcpHu2Ew/NwnQskk53ZFWkUF6n8RxBnt3+47/t/r3YQrniFZv1/9KG
 hfn6KiAm0AfZAspWqyUex9v2uswNF8/n70hqG1HavvoNkdbet28sgPfTflDjldFLtZ8z
 iLyKbeLwh3ETmhJo1eR0EgdEaqj/ViOr1dBvX59PndNqKpI2SFggF8QRJDaKO+Y3PnMi
 dCN0dWJcfVjcJJ6yg56xxMYmSWZAkoDy3LiqDiT8D0D6F0aSntlI3p2FoiHPm9XUTvti
 nf8Gs0u8oUkHk+1EBbhmaIWzYCgYcXPvLPuo+OItZbHIMRbOolZI5CRGklKiRZeAcx91
 GehA==
X-Gm-Message-State: AOJu0YxUkrQWGbIx+SNKHguDQP7OZqzwnh/Pa/MPteqOgDm4x0pVeR9+
 A2M0nM+Pz6WqmzRHhtuOyhHjYlzREOw5tGj+uiLApttMNAkX57DTtpJ739xqaSbSJ10=
X-Gm-Gg: Acq92OGX0dVZkxmJF4qVRMycHKiOEZf5Z4BDuNQuyREIe3iEZKMlMe0fORJdwN/c6bn
 UtV06ctyxUBhU80dXNi6r/7AUIN7q8v+3kDZzyNl4rVg1aaA4+IRq/mpUPYq4p3k84bSP4PHnnT
 kMfAuaLXyzeL7GNr9hC2r5PnZTCOZK3109Njb6L2mQWEqH8ceYhzw+Jd/zc6YPCRD+b8720NxoD
 nPltVDg4FHUNw0B7A6Xst7obebdEmHDRy/uh4MKnbc764wNczfpB/DTySIhAHR1xZa/5FS5Kz06
 G1LSDGXY6fcQdD47bO+UQU1rH7L/FiwT1CIGseymtelIYdGObRqewFyBitmpETrnQw8pAoiX/30
 1JGmyKXpI2AKpaTb7I09SrbdzdKNrHfPJJvCLtApmWMuJs7bDN+u1O//nnTc5zjPFFjpV/464CA
 eIove0UlgPGAbtkfshE6JUJc2USf7R1O4IUA==
X-Received: by 2002:a05:6000:401e:b0:449:c5e2:a8b7 with SMTP id
 ffacd0b85a97d-45e5c59ec1cmr30434333f8f.30.1779194200738; 
 Tue, 19 May 2026 05:36:40 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe1a41sm49377493f8f.31.2026.05.19.05.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 05:36:40 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B21925F81D;
 Tue, 19 May 2026 13:36:38 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,  Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 0/2] virtio-gpu: Do not wait for the main thread
 during reset
In-Reply-To: <aeeb9f81-3dd8-4fea-83ae-7d88ec1be971@rsg.ci.i.u-tokyo.ac.jp>
 (Akihiko Odaki's message of "Tue, 19 May 2026 15:29:28 +0900")
References: <20260424-gpu-v2-0-9fd2fc0dd1bd@rsg.ci.i.u-tokyo.ac.jp>
 <87mrxwcxzd.fsf@draig.linaro.org>
 <aeeb9f81-3dd8-4fea-83ae-7d88ec1be971@rsg.ci.i.u-tokyo.ac.jp>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Tue, 19 May 2026 13:36:38 +0100
Message-ID: <87h5o3bmp5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:

> On 2026/05/19 4:35, Alex Benn=C3=A9e wrote:
>> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:
>>=20
>>> This fixes a deadlock I previously observed with the test in [1].
>>>
>>> However, I can no longer reproduce the issue reliably with that test, so
>>> I used Codex, a coding agent, to write a more reliable local test case,
>>> shown below. I applied to Codex for Open Source to get access. The test
>>> case is not intended for merge: current policy prohibits that, and it is
>>> probably not worth carrying anyway because race-condition tests are
>>> inherently fragile.
>> What sort of hit rate where you getting with the race? So far they
>> have
>> both been rock solid without the additional patches for me.
>
> I hit the deadlock in 8 out of 10 trials.

It's taking a lot longer on my system (~ 1 in 100) but with these
patches I'm still seeing a hang, it just takes a lot longer to get
there.

>
>>=20
>>> The remaining patches were written by me.
>>>
>>> [1] https://lore.kernel.org/qemu-devel/20251014111234.3190346-9-alex.be=
nnee@linaro.org/
>>>
>>> To: qemu-devel@nongnu.org
>>> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>
>>> Below is the Codex-written test case:
>>>
>>> diff --git a/tests/functional/aarch64/test_gpu_blob.py b/tests/function=
al/aarch64/test_gpu_blob.py
>>> index a913d3b29c84..52627b4541f9 100755
>>> --- a/tests/functional/aarch64/test_gpu_blob.py
>>> +++ b/tests/functional/aarch64/test_gpu_blob.py
>>> @@ -13,7 +13,9 @@
>>>   #
>>>   # SPDX-License-Identifier: GPL-2.0-or-later
>>>   -from qemu.machine.machine import VMLaunchFailure
>>> +import subprocess
>>> +
>>> +from qemu.machine.machine import AbnormalShutdown, VMLaunchFailure
>>>     from qemu_test import Asset
>>>   from qemu_test import wait_for_console_pattern
>>> @@ -25,8 +27,7 @@ class Aarch64VirtBlobTest(LinuxKernelTest):
>>>                          'download?path=3D%2Fblob-test&files=3Dqemu-880=
.bin',
>>>                          '2f6ab85d0b156c94fcedd2c4c821c5cbd52925a2de107=
f8e2d569ea2e34e42eb')
>>>   -    def test_virtio_gpu_blob(self):
>>> -
>>> +    def launch_blob_test(self):
>>>           self.set_machine('virt')
>>>           self.require_accelerator("tcg")
>>>   @@ -65,9 +66,27 @@ def test_virtio_gpu_blob(self):
>>>                   self.log.info("unhandled launch failure: %s", excp.ou=
tput)
>>>                   raise excp
>>>   +    def test_virtio_gpu_blob(self):
>>> +        self.launch_blob_test()
>>> +
>>>           self.wait_for_console_pattern('[INFO] virtio-gpu test finishe=
d')
>>>           # the test should cleanly exit
>>>   +    def test_virtio_gpu_blob_shutdown_race(self):
>>> +        self.launch_blob_test()
>>> +
>>> +        self.wait_for_console_pattern('[INFO] unmapping blob object re=
source')
>>> +
>>> +        try:
>>> +            self.vm.shutdown(timeout=3D10)
>>> +        except AbnormalShutdown as excp:
>>> +            if isinstance(excp.__cause__, subprocess.TimeoutExpired):
>>> +                raise AssertionError(
>>> +                    "QEMU failed to exit while virtio-gpu reset was ra=
cing "
>>> +                    "with shutdown") from excp
>>> +            self.log.info("QEMU exited before the shutdown request com=
pleted: %s",
>>> +                          excp)
>>> +
>>>     if __name__ =3D=3D '__main__':
>>>       LinuxKernelTest.main()
>>>
>>> ---
>>> Changes in v2:
>>> - Added the patch "virtio-gpu: Run reset cleanup in the same BH".
>>> - My assumption about the ordering was incorrect, so I changed the patch
>>>    to follow the approach used by virtio-gpu-gl.
>>> - Link to v1: https://lore.kernel.org/qemu-devel/20251029-gpu-v1-1-e3e3=
c7eebc9e@rsg.ci.i.u-tokyo.ac.jp
>>>
>>> ---
>>> Akihiko Odaki (2):
>>>        virtio-gpu: Run reset cleanup in the same BH
>>>        virtio-gpu: Do not wait for the main thread during reset
>>>
>>>   include/hw/virtio/virtio-gpu.h |  4 +--
>>>   hw/display/virtio-gpu.c        | 60 ++++++++++++++++++++-------------=
---------
>>>   2 files changed, 30 insertions(+), 34 deletions(-)
>>> ---
>>> base-commit: 14f38a63b9adc02c0ebe3b5ada1f1208abaf21ea
>>> change-id: 20251029-gpu-c3f45747f7ba
>>>
>>> Best regards,
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

