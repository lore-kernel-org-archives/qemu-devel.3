Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874B7C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6mRi-000871-CK; Wed, 16 Sep 2026 06:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6mRX-00086N-8A
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:00:43 -0400
Received: from qs-2004c-snip6-6.eps.apple.com ([2a01:b747:3006:206::1d]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6mRT-0005D5-2B
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:00:41 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-8 (Postfix) with ESMTPS id
 4336318005D5; Wed, 16 Sep 2026 10:00:33 +0000 (UTC)
X-ICL-RepId: 01a0a9a9-326f-7fdb-9c16-0903d252e3c4
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0IShMFUgddTVYNRw9YHlwUFwlAQ14IXh9MHB0OWAYSAE0KDjYGWQVeCVYDQwU2EhRdRUYDRxlXFFAbRwxVB1deXwoTAF4PD0wLSAFbB1IDRghIA10FWhxHCkABWBpaHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1789552834; x=1792144834;
 bh=f6hNzKyGSig9kg0DP2KxdtgaPJ5beLynypHJ2kzYXXE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=w2clVZzdSu7Ym+umTT+8qNseeTll4p+ze8DRmHoxPaRQ+KdCUEt1Fytdbv2UdLMQ0IHjh3HUGcbVXt1TT4OW2FdlX1N6S1v9DfiTJTFDno7PvW5flu53UQHHE9ZCfnJ/osWI73Cfh/B+v8lgJmnm9OoK+TloBndWnbc0EgLJZOOJq3I166N22EmMLUDVmhxi/+nnNQSULI98tS6aKosTdd5cn5xSk+QNp6J70q44LS4Mq66F/brttTfDkzbPKcJ0NzJNsYeP+Q5GcnLc9cGD9+A+Y6whzAFnbjysMae/Q2CDtwiHETIHzReXymUGfixmB0hH68Q5r5s5WTph5KpERw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-8 (Postfix) with ESMTPSA id
 765D518009E2; Wed, 16 Sep 2026 10:00:31 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v8 00/10] vmapple: making it work on the latest macOS host
 releases
Date: Wed, 16 Sep 2026 12:00:08 +0200
Message-ID: <20260916100021.73825-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDEzMCBTYWx0ZWRfX/oV5o176+jzA
 IJjt7GqhXPktg2Zcop1Nk4bIT5HS/VPlYb0ZzHmXpnTiZDcsvDL9jxU6rdEXp8VF3uD5r9Y9o8G
 E9kD/JHvc46MK4mQJvy2KygkPYlkU2mcmEFidKopYPMB4ZCwX61RDTaCkNjraVQ9D5b/6+yQ9LT
 lo70jKhnxoChk+8zBUttPUsNgC62u6RtSdCgM9njwn2nhd1xmJGFRmi0zcFEhYPVWEHg6jiA7KO
 GVh4CfKsxVjp1rjRE5eu+F14eijH1lpnkx5Fzlih08u7vqRyAAuwfzcEYfhCIntUkTgeMidAcsW
 WOG1+oZIgQV3ygtMHQpfETKIF78KVeJxXd2kZuI/0bEm69kuLDrO3/mW0xiEjM=
X-Proofpoint-ORIG-GUID: QGoA-RAfta890orW3sM2IdWrB8lQRSUS
X-Authority-Info-Out: v=2.4 cv=cMTtc1eN c=1 sm=1 tr=0 ts=6aaa68c1
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=PWwuWOSklEzM4Y2Y:21 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=L2I6vFsG4SoSg74fCx4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QGoA-RAfta890orW3sM2IdWrB8lQRSUS
X-JNJ: AAAAAAABuFT2qmxBsdXCgPFmFWtZFKBJiigoraKQ+g+S3oV0aA+/O27MFT+NZW5HiL3AcKYqQC0965KKy2vJw652Pn9I4574mIT9moxeixAuKAOwpYD3lYn3kkMmdTB0eUdkyadMWopf3SUuXvx27k5ewaxWRwGhAEftoxWirPm7PH5psB49tRjvSB2zQ55AnrGaDzYRmae/9d/aVzxO/A6jiM97bzG2Z+bMxQTmHPqlAucR08JOyawvd7jm8SUkLiqry8NQ36frmXSAj9Zczc3ZKO34OvGTKBFfMVoHk4a7T9LQLgNbJcVoFffca/yu4WsezYNdJN88zidFJHZZhA2eMgrQt1FKjioAUAvts+CKOoqXjhc3UvNihOHksacuCv2+Fql9s7Fp+u0p7IUlPl1SeptQkj1Mfx/Q5oxHnoT74teiAs4M16XfLHvH2hLqj0jPS3XRK1VZRg9XcsktgBZMdyz1QcMFZP9oyEtwl0YOuIPi1LALFPjs7kZUqIq0BU2+zhNtWy4vERVouTbBEGzFC9FAj6T7ANAMM9BIdAXVKbAOtAOMFYq+WS+nrpeqe29c59Z3p8HS5fcCdKM6FecRq9JxhWYbE6Gsgo0bxd0LoK8zsF33Ff0fOoW8G0lyrn5e2Lgn5fYXZcSB4uGXq+bXgh6SbkGH+laXUJTK9obyp8XqkdAwqE6IzKr/bPOU2xuEGAAh0ZBsKG3LT+llfZZVLoC4gfT0vLIpcFsaT8hUrTpAtEOBqt9EJG7AZA3O3OUPqNPI8fR4chayO9Twi39dDPrYqUr2WMZq0a2TNqj9tK8lR/KRX7KiUncrBjc7ZH0NfS+b8sZL10WeAq/8uu39ibEBmIKb9hTNa9+Kw1IZWykA2hscmpPUQQeFkalsROuhvAYh1eBIJWwnir7mljSH8rOjcSaTA4RVaPyW2Z0ySA05XEdDIF1FsKm6jI3y3SzTbblq3bElCdXwSQO5G4UQyka9Ajq
 dGQMrqvn0xEmM5H61ao/s6hs3ItfFpsyu0UFWx2Qei33DOVFQSK1gDQk5gPoYYQkjl6dp8hJ4JV0rE0op6hJkAdgiivSaVxu+Dt3Igetv8yNxsHfEvW7DcynbLDgRMbTJQziVKLnrohovqX/R1Pz37vTQRzTFbDGUlIhveTA0BFlkntfIM6LwYhxcM4PmEaHU04xKA3+PvTLGjXYvNBbV84SSnU5uSXpyTGHV9fiwKTO+jWwJjmyv/1N8ecCBXLfeGLu02isk5DuSpeaOscm7UsLZAch7f28+JT2aSF6ZdKFQMDbD14Psn3YziFpBk3FdK2v7P34poVhgZiJkYvaYde64zYfNX/CqvMPVop/YivcxAbI=
Received-SPF: pass client-ip=2a01:b747:3006:206::1d;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

v8:

Refreshed for new macOS 27.

Now a standalone series.

Added new patch for newer macOS guests - to allow FileVault off.

v7:

Support for newer guest OSes.

Added not mergable patch for private ISA enablement.

Not grabbing a memory reference and still using flatview_for_each_range
for this one, which works fine as live migration is disallowed anyway.

v6:
Rework the patches a bit, with making sure that there's no compiler warnings

v5:
Address review comments and rebase.

v4:
Rebase and resend without the RFC tag as I didn't get feedback.
Drop patch 1 (version I posted was incomplete anyways). Last patch isn't worth it too tbh.

v2->v3:
Remove the Apple M4 support workaround part for now, to be part of another patchset perhaps
Address comments

v1->v2:
Remove some lines that shouldn't have been present...

Lucas Amaral (4):
  target/arm/emulate: add ISV=0 emulation library with load/store
    immediate
  target/arm/emulate: add load/store register offset
  target/arm/emulate: add load/store pair
  target/arm/hvf, whpx: wire ISV=0 emulation for data aborts

Mohamed Mediouni (6):
  vmapple: apple-gfx: make it work on the latest macOS release
  hw/vmapple: aes: convert MAX_LEN to a #define
  Revert "hw/arm: Do not build VMapple machine by default"
  vmapple: add gicv2m
  vmapple, gicv2m: add macOS compat quirk
  hw/vmapple: virtio-blk: allow FileVault off

 configs/devices/aarch64-softmmu/default.mak |   1 -
 hw/display/apple-gfx-mmio.m                 |  58 ++-
 hw/display/apple-gfx.h                      |  16 +
 hw/display/apple-gfx.m                      |  90 +++-
 hw/intc/arm_gicv2m.c                        |   5 +
 hw/vmapple/aes.c                            |   3 +-
 hw/vmapple/virtio-blk.c                     |  18 +
 hw/vmapple/vmapple.c                        |  25 ++
 target/arm/emulate/a64-ldst.decode          | 226 ++++++++++
 target/arm/emulate/arm_emulate.c            | 451 ++++++++++++++++++++
 target/arm/emulate/arm_emulate.h            |  30 ++
 target/arm/emulate/meson.build              |   8 +
 target/arm/hvf/hvf.c                        |  46 +-
 target/arm/meson.build                      |   1 +
 target/arm/whpx/whpx-all.c                  |  61 ++-
 15 files changed, 1007 insertions(+), 32 deletions(-)
 create mode 100644 target/arm/emulate/a64-ldst.decode
 create mode 100644 target/arm/emulate/arm_emulate.c
 create mode 100644 target/arm/emulate/arm_emulate.h
 create mode 100644 target/arm/emulate/meson.build

-- 
2.54.0 (Apple Git-157)


