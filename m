Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E708CCF9F0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 12:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFAQX-0003T0-5D; Sat, 01 Nov 2025 08:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vFAQV-0003Sl-5G
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 08:09:47 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vFAQQ-0005nv-SX
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 08:09:46 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso2210895f8f.0
 for <qemu-devel@nongnu.org>; Sat, 01 Nov 2025 05:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761998978; x=1762603778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yYQiIR+iMZGwb5yaMQ9UyCDvv04+Ssu3UBQrBpGT1cA=;
 b=lTBUKgIStUUIHW+66Aw9ToQvEpCXAJXm8Q7HdoH2g7RliOpUzEp3RYwuhMJawY+W8y
 gTvtrMNQFr1UtL2bDul0QvwoKaohNRnMZ/Z1ugy2HCTj9Hs/O9mUmIttD76m6tya4iFI
 jn4BCTgkSkoCaKfqHhPp08yhyXpyBe64s3YkHzhqYEy97SyXiFwm4nYQTZ3wypQdIQzc
 MvKlQ1Zt7ZwxVb19wg5eijrxZ8zG6JbznNhirqhrPwNWv1oNkKbbYf326kqji5AxvV2y
 OhE7n6Z9ncqWQC/0z9zY/UwjM0R1s+GntnqVvlSvveZEWO8zEMZT8mjc3e5vE27MbIDo
 N9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761998978; x=1762603778;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yYQiIR+iMZGwb5yaMQ9UyCDvv04+Ssu3UBQrBpGT1cA=;
 b=MNMvKcQjGgRJo+YvX9jh1NN551siz3/SnojC8UmscDl3BUmt7xQSaIUtBC62ldz0nJ
 r1ICyiKc9RmefPHzTsTq7IifXMsqzfJJ0FYQS1aL+bKLDhgpn2pw53pinF06QGm7ireE
 YHDTWraR8hdUTvWpQWHwFkfChyLLAfX8ToLngv5BwggoKxd0ugtEKmgBFwTbhHn0P32M
 +RqpJM9GjsTeEvN3vdv0XmdBqJDSxppkSMRPFhWWJkDWlTDdD2QZzRgy37T8/upUS6sC
 dlmE3MS+sNJMTvkejwIWMcMemBuErO5d7Y0ohcZ0iAAzhEjOXCJf7fzNvm2v52jigvol
 Ihjg==
X-Gm-Message-State: AOJu0YwR2MvLNFZSQF2OefsSEN4XfH6pDtwk+1nPcsBS5R/+p4ZkNFh/
 zQJuH7bK6E2FeYsiLQ3rxaNCnqBwnVVx0d1asuqGQRDSvGV0eG3e0eha
X-Gm-Gg: ASbGncue7xyYGFoLsEYVLgABLp+t/3yVQZC6otsWBKnnUZwLld2kRQykMbow4cRwWut
 nB9sIdklU9kSw19KopMy0s+PrQoqai7pjEjbVuDWWzK8h8p7x97d84R8/7xlppUtZowQBSKl2oB
 0QEY4FSFaBlLwcGG8rwYEj//KxS42HbSfUH5C3yGLauOebMspLVSI0wMmAVWRX9RsP7oNtdto1q
 j4hw1klkvEg22iQIImNbhWYSa6l3v5cpXz+wiD7gOGB0lCQv0xGivRqy9gTZNDkOOGQ+WlyF1JC
 HAsuei/bd7ne6uE+Bdeh4IDp3mGOmvjKfjAxD2dJuzDorMB2NMKMbk48P10meA5kChU5pOL/7tC
 sATrgivdMKHji9dDsWX0DnWOPHzm3QibRB+qZTgeyfcGFdXE8761FDV3lMuyA3lbL+rzg0X3LTL
 gzKwt38Dkb9o33xJArDZ23Ll5Q8lpvXdrrHzvZk5AVs1YlLG4M8/bLrLi/LxIRRdepxlirccYu
X-Google-Smtp-Source: AGHT+IGtH0Ezq3EY09VopRbd5NVBTR8qUQpIAJsCwJVSvRiqUd5rl2Qi7GkMc1sccK9zhy4Lo+9HGQ==
X-Received: by 2002:a05:6000:4381:b0:429:bc68:6c95 with SMTP id
 ffacd0b85a97d-429bd6a6097mr6426272f8f.47.1761998977700; 
 Sat, 01 Nov 2025 05:09:37 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf271400bdbc21c775fcdd84.dip0.t-ipconnect.de.
 [2003:fa:af27:1400:bdbc:21c7:75fc:dd84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429cab8575bsm1388167f8f.31.2025.11.01.05.09.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Nov 2025 05:09:37 -0700 (PDT)
Date: Sat, 01 Nov 2025 12:09:34 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
CC: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v2 0/2] KVM Support for imx8mp-evk Machine
In-Reply-To: <CAFEAcA8+=_8peJR37xoM4zarUu9cy+56rOkyF7iONFb866Ebtg@mail.gmail.com>
References: <20251029142311.2986-1-shentey@gmail.com>
 <CAFEAcA-CGQ2JwDoBVZNhQyBMNKXbZsy2Ds+=m0MAPq0hrsWHhA@mail.gmail.com>
 <CAFEAcA_sbvMEJ-oTxTYOutgUrH0iapNcJrsZd3=Ov6wNn-NE3w@mail.gmail.com>
 <a7f5d348-1243-4c52-8dc1-66e2c3da40ae@linaro.org>
 <CAFEAcA8+=_8peJR37xoM4zarUu9cy+56rOkyF7iONFb866Ebtg@mail.gmail.com>
Message-ID: <75BD66C1-267A-4906-B01B-DECA16B5E69E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 31=2E Oktober 2025 18:30:02 UTC schrieb Peter Maydell <peter=2Emaydell@=
linaro=2Eorg>:
>On Fri, 31 Oct 2025 at 18:18, Philippe Mathieu-Daud=C3=A9 <philmd@linaro=
=2Eorg> wrote:
>>
>> On 31/10/25 18:12, Peter Maydell wrote:
>> > On Fri, 31 Oct 2025 at 16:57, Peter Maydell <peter=2Emaydell@linaro=
=2Eorg> wrote:
>> >>
>> >> On Wed, 29 Oct 2025 at 14:23, Bernhard Beschow <shentey@gmail=2Ecom>=
 wrote:
>> >>>
>> >>> This series adds KVM support to the imx8mp-evk machine, allowing it=
 to run
>> >>> guests with KVM acceleration=2E Inspiration was taken from the virt=
 machine=2E This
>> >>> required a device tree quirk for the guest clock to be kept in sync=
 with the
>> >>> host=2E Without this quirk the guest's clock would advance with fac=
tor <host
>> >>> system counter> / 8Mhz=2E
>> >>>
>> >>> Testing done:
>> >>> * Run `qemu-system-aarch64 -M imx8mp-evk -accel kvm -smp 4` under
>> >>>    `qemu-system-aarch64 -M virt,secure=3Don,virtualization=3Don,gic=
-version=3D4 \
>> >>>    -cpu cortex-a72 -smp 4 -accel tcg` and `qemu-system-aarch64 -M i=
mx8mp-evk \
>> >>>    -accel tcg -smp 4"=2E Observe that the `date` command reflects t=
he host's date=2E
>> >>>
>> >>> v2:
>> >>> * Mention various tradeoffs in the board documentation (Peter)
>> >>> * Accommodate for single-binary (Peter, Pierrick) by having CPU def=
aults
>> >>>
>> >>> Bernhard Beschow (2):
>> >>>    hw/arm/imx8mp-evk: Add KVM support
>> >>>    hw/arm/imx8mp-evk: Fix guest time in KVM mode
>> >>
>> >> Thanks, I've applied this to target-arm=2Enext=2E
>> >
>> > =2E=2E=2EI've had to un-queue it, as it breaks "make check":
>> >
>> > test:         qemu:qtest+qtest-aarch64 / qtest-aarch64/device-introsp=
ect-test
>> > start time:   17:06:52
>> > duration:     3=2E70s
>> > result:       killed by signal 6 SIGABRT
>> > command:      MALLOC_PERTURB_=3D155
>> > UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D=
1:print_stacktrace=3D1
>> > PYTHON=3D/data_nvme1n1/linaro/qemu-from-laptop/qemu/build/arm-clang/p=
yvenv/bin/python3
>> > G_TEST_DBUS_DAEMON=3D/data_nvme1n1/linaro/qemu-from-laptop/qemu/tests=
/dbus-vmstate-daemon=2Esh
>> > RUST_BACKTRACE=3D1
>> > MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1=
:print_stacktrace=3D1
>> > QTEST_QEMU_BINARY=3D=2E/qemu-system-aarch64
>> > QTEST_QEMU_STORAGE_DAEMON_BINARY=3D=2E/storage-daemon/qemu-storage-da=
emon
>> > ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1
>> > QTEST_QEMU_IMG=3D=2E/qemu-img MESON_TEST_ITERATION=3D1
>> > /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/arm-clang/tests/qtes=
t/device-introspect-test
>> > --tap -k
>> > ----------------------------------- stdout --------------------------=
---------
>> > [=2E=2E=2E]
>> > # Testing device 'fsl-imx8mp'
>> > ----------------------------------- stderr --------------------------=
---------
>> > unknown type '(null)'
>> > Broken pipe
>> > =2E=2E/=2E=2E/tests/qtest/libqtest=2Ec:199: kill_qemu() tried to term=
inate QEMU
>> > process but encountered exit status 1 (expected 0)
>> >
>> >
>> > I think the problem is that you're trying to use ms->cpu_type
>> > in the fsl_imx8mp_init() function=2E This doesn't work in the
>> > device-introspect-test setup, because it is just instantiating
>> > each device for test, not running a full machine=2E
>> >
>> > I think the way we usually avoid this is that if an SoC
>> > device object needs to know what CPU type to instantiate
>> > it has a QOM property, and the board model tells it=2E
>> > (Annoyingly this then means the CPU instantiation has to
>> > move into the realize method where the property value is known=2E)
>>
>> Correct, this is the same issue I tried to address with the Raspi
>> machines and I noted your comments:
>> https://lore=2Ekernel=2Eorg/qemu-devel/CAFEAcA961WKB4fxwAS0WHXXKwYEO7Tn=
movD4z-BPGehr6sxBQw@mail=2Egmail=2Ecom/
>
>I think it's different, because for the raspi case the SoC
>object is trying to create a CPU type that it can't:
>  unknown type 'cortex-a72-arm-cpu'
>(because it's the arm device-introspect-test and that CPU
>is an aarch64 one)
>whereas for this one we are in the aarch64 test, but trying to
>use a NULL pointer as our type string:
>  unknown type '(null)'
>
>Single binary vs compile-everything is probably a red herring here=2E

I've sent v3 [1] with a pragmatic fix for qtest in the hope that it could =
make it into 10=2E2=2E If we find better ways to avoid the qtest crash I'm =
all for it=2E

Best regards,
Bernhard

[1] https://patchew=2Eorg/QEMU/20251101120130=2E236721-1-shentey@gmail=2Ec=
om/

>
>thanks
>-- PMM

