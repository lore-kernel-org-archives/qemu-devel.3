Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3676ACA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 13:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoM0s-00013j-SA; Tue, 19 Aug 2025 09:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoM0q-00013W-V3
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 09:04:28 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoM0l-0005XJ-FW
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 09:04:28 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e94ea56725aso458288276.2
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 06:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755608662; x=1756213462; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TKb5ifCj9uuXxIjK+VdPqq69kyEQ2giNTh/2C1a4dcA=;
 b=XvnC8T5s2bTPIIBw/0gjRsngQgF3vH9EeitLAUz+fx5YJiNh7X7vrOOu6NDAL6N5rm
 s4Z2nX52Qukl6dNmVS3KEXttM9K98toJk5sgakMKDgAiUWPWwwyVC6Kj0IQg/9XA/evA
 N+eXJlf90fZmm6y/kog0a0n6wTbSDN8WVmSbtIhUV/LLVk1VlkNZt3mILpkvwj7FdYWv
 o7Yc7PC9yxUs7y7qsEqMJO9pTGKFgNmkRe5SQLUSG1xlcTDl9NGJL72WTN12yBW/yx9t
 7Sghpgeo9/GcvTWXp5uIXCAq/TlJZY5+VUBQkKk1wS9tM5apvJzmPBjB2MbGg26yvdz9
 r+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755608662; x=1756213462;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TKb5ifCj9uuXxIjK+VdPqq69kyEQ2giNTh/2C1a4dcA=;
 b=dH/9Y+lG3YH9AlwT2vNaL4GpARvCRtQPF+zJVqyGvN3ccsIncuAoSA6DD6CiN/vxMc
 ahzmqhIGyMGjnVUVCfwYPA9QCQMfqraCMAuwbkp3Y2HPUBu9L7aePQ637IFYhnDG4AyZ
 5zBNKc5orgGTvg9jr6NFusZGlSjnf6k+EIHWCIjsMxUXUPcTeowFjL93CBYKAaJu0yFP
 XuZ9BlJDSsmp49ccj5e1ceVynw2Eo50SUxpMe9gl1ObiPLHcJ5WpmcZE+4di7jRQQuMg
 aIzsdO4QwGfE+SNPxh7Tjenjy1sXl2bmjTsdrhjZTIfMlBCktdRuvKF3nB/M8bw88pj4
 B7FQ==
X-Gm-Message-State: AOJu0YzhTWL5kXmT2p8OoqVO6N7jd3iTBTgiffs+S9jeqn3Gs5tutkO5
 y6fKN190q7+57tdEi5ecFPUZrS9b2Bbyx/VEJ+mSoGrmCWAS9hFj7Dbigg+SgvJtppcxa9DYGe+
 CaY3ZQhVYdQ418xflq3arm+cy0csV1P90g0UcBZgM1Q==
X-Gm-Gg: ASbGncs8UcO2J/wMuajnzljfFLilTtyKA0jhcA6VRKpsMiMIw0HGUZMZMvmH2FmpIRV
 gAA+DZRryCI4YVdbtv9Y3e8iWAf70NwEnXOQJKdh6r7GdIpz9Cv1A0R13S8Qq8dbaoO26X8EkTq
 I5F0a/tlO3dE2i5+igHV6g6h2dIocRUY8UodC3N9EH9PbGJixgoq25uoOSjgNJ0lK9k8x66psfy
 rwDkw2z
X-Google-Smtp-Source: AGHT+IG6sH6xvrOWm855Rmzpn4+yDFGPqf212PzkOE23uiw04fhNNFnpbz/fkAfJ3jaCXL64Mi7tQ3288hblhFp3hOE=
X-Received: by 2002:a05:6902:6d09:b0:e93:4b5c:d50d with SMTP id
 3f1490d57ef6-e94e6284bd7mr2925126276.25.1755608661629; Tue, 19 Aug 2025
 06:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250808065419.47415-1-mohamed@unpredictable.fr>
 <20250808065419.47415-3-mohamed@unpredictable.fr>
In-Reply-To: <20250808065419.47415-3-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Aug 2025 14:04:10 +0100
X-Gm-Features: Ac12FXxK80mEuyo7WyK8Me7SjAMiQLCmGhaBx70oD8yBVCiLtEXx4lq77CVjSk0
Message-ID: <CAFEAcA9KXrjPmMoHDg6zoAwUsWJzqU_BUQAzuiGX2uHgDx3q1g@mail.gmail.com>
Subject: Re: [PATCH v5 02/18] hw/arm: virt: add GICv2m for the case when ITS
 is not available
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Ani Sinha <anisinha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, 
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, 
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Fri, 8 Aug 2025 at 07:54, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> On Hypervisor.framework for macOS and WHPX for Windows, the provided environment is a GICv3 without ITS.
>
> As such, support a GICv3 w/ GICv2m for that scenario.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This breaks the bios-tables-test which is run as part of "make check",
because the ACPI tables generated no longer match the golden reference
output. If the ACPI table change here is intentional then the comment
at the top of tests/qtest/bios-tables-test.c describes the process
and sequence of patches you need to update the reference versions.


$ make -C build/arm-clang/ -j6 && (cd build/arm-clang/ &&
QTEST_QEMU_BINARY=./qemu-system-aarch64
./tests/qtest/bios-tables-test)
make: Entering directory
'/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang'
[1/28] Generating qemu-version.h with a custom command (wrapped by
meson to capture output)
[2/8] Compiling C object libsystem.a.p/hw_pci-host_gpex-acpi.c.o
[3/8] Compiling C object libqemu-arm-softmmu.a.p/hw_arm_virt-acpi-build.c.o
[4/8] Compiling C object libqemu-aarch64-softmmu.a.p/hw_arm_virt-acpi-build.c.o
[5/8] Compiling C object libqemu-arm-softmmu.a.p/hw_arm_virt.c.o
[6/8] Compiling C object libqemu-aarch64-softmmu.a.p/hw_arm_virt.c.o
[7/8] Linking target qemu-system-arm
[8/8] Linking target qemu-system-aarch64
make: Leaving directory
'/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang'
TAP version 13
# random seed: R02Sbd44a41112c6e2df4635231a2a1f3510
# starting QEMU: exec ./qemu-system-aarch64 -qtest
unix:/tmp/qtest-2147871.sock -qtest-log /dev/null -chardev
socket,path=/tmp/qtest-2147871.qmp,id=char0 -mon
chardev=char0,mode=control -display none -audio none -machine none
-accel qtest
# starting QEMU: exec ./qemu-system-aarch64 -qtest
unix:/tmp/qtest-2147871.sock -qtest-log /dev/null -chardev
socket,path=/tmp/qtest-2147871.qmp,id=char0 -mon
chardev=char0,mode=control -display none -audio none -machine none
-accel qtest
1..12
# Start of aarch64 tests
# Start of acpi tests
# starting QEMU: exec ./qemu-system-aarch64 -qtest
unix:/tmp/qtest-2147871.sock -qtest-log /dev/null -chardev
socket,path=/tmp/qtest-2147871.qmp,id=char0 -mon
chardev=char0,mode=control -display none -audio none -machine virt
-accel tcg -nodefaults -nographic -drive
if=pflash,format=raw,file=pc-bios/edk2-aarch64-code.fd,readonly=on
-drive if=pflash,format=raw,file=pc-bios/edk2-arm-vars.fd,snapshot=on
-cdrom tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2
-cpu cortex-a57 -machine ras=on -smbios
type=4,max-speed=2900,current-speed=2700 -accel qtest
acpi-test: Warning! APIC binary file mismatch. Actual
[aml:/tmp/aml-0EHGB3], Expected
[aml:tests/data/acpi/aarch64/virt/APIC].
See source file tests/qtest/bios-tables-test.c for instructions on how
to update expected files.
acpi-test: Warning! APIC mismatch. Actual [asl:/tmp/asl-48FGB3.dsl,
aml:/tmp/aml-0EHGB3], Expected [asl:/tmp/asl-D5NHB3.dsl,
aml:tests/data/acpi/aarch64/virt/APIC].
**
ERROR:../../tests/qtest/bios-tables-test.c:554:test_acpi_asl:
assertion failed: (all_tables_match)
not ok /aarch64/acpi/virt -
ERROR:../../tests/qtest/bios-tables-test.c:554:test_acpi_asl:
assertion failed: (all_tables_match)
Bail out!
Aborted (core dumped)


thanks
-- PMM

