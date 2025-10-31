Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DFACCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEttS-0002fu-Ez; Fri, 31 Oct 2025 14:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEttN-0002eG-Tt
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:30:31 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEttG-0005oQ-VZ
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:30:29 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-63e0fa0571fso3264423d50.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935413; x=1762540213; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yce9kG3WCCPS7KgQ5TmpoUJOI415Pn1nKPG8ztlcxKU=;
 b=RzE0lHa33TiAZY4oAOug69Ts+AOJdr6q0N9SA8vdNgwErYbAmgA161l1vs+MADkOmy
 +TXJLGgEYOkGu+1ICgVUcu2zBRlTzoxu5vl5qQmbBBZl6a9cSZydO8utIXTmtlysWwPE
 6HMkpssmvAYSlTBbQFIRagohORucC2nTAZPIpgPDofbyBYv47cGzRqcoPe+XFbiotKOd
 7GuBg6zGJwyHmCszbE0wNImJ8gqJj7nKGRCXCjDicglVh11mDaXK7o02Il8HFIGZecWo
 8RGvY+DaMIITFljhWCDmuGxM86BYyMP8CMcouslCdPQbvRetLsD7pD3Iiw6hOb9tItc2
 ao/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935413; x=1762540213;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yce9kG3WCCPS7KgQ5TmpoUJOI415Pn1nKPG8ztlcxKU=;
 b=gDWM3xaloDdIYthgZHiyZzI0cbrBKT2qICtGDm/4R39ynW7X62ZJXYsr298UacgOyU
 SK3T+ypVY/z9Ev4B2RSyoU35lWFAJVNfT79mRZgE2vUHnyTlhRODNbEPEZzavMN/lbFE
 PwmNIRy1ph0k9CHM9Lnmng5AAMXy/0j9cdgS/2CcqJICBeMbLTcBo+FjY7KKRZ/uSB1g
 XHHyTu4VNrge1CIAv0MDdS0vMCAHCtiiK68KQfajnlIVAcEvHKV3nZzWo04MVlbBNfQE
 adb+MlZPrvigNDVVbGyXynDs8KdLu5MaYglx5FiPDzZ7Wmu+ythEFcTMRk4F5ks30UXG
 aJgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf92+A1Pt6P+wmlQUDcw2L3vWPxtKwc7/ESdXampQi1ilQhlQYTm5aiMUV7CxGfnxDJ0yx4QG0knt3@nongnu.org
X-Gm-Message-State: AOJu0YwscpT1VBLTeCoHPzzFYhB5UqNn+wAXK5hjOdK3tDYevFA/QZit
 sG/cLDKeriuP/KKG3Oo31/Pf/DRTzbktcRtjS8pTlI/zzQGp9f2FyL2Ida7H2iE32s7gO7Q+SPQ
 93pfmD9TvgEqlUEpuyjNVAi1SEKdLkDZWl+FVXA4/Ag==
X-Gm-Gg: ASbGncs8Ilj1g/fpBrak2gII/kAiEKQtVbIltGwIrRB23L2AqvQ5p8zGmqQBotBn32y
 80ejO7dp6eTCLeb2GsqjxdxWMEOOUInx3Q5HFKLudV1zvcTLGRqiE2SrmwYhiJIGKms4j8ZP0La
 Ul7uhBSdf6W+xdhQnaYXSAReQomPCujilVqPRSygg5UE4vx8CLsm8i9mq+DSmJcAOUKI79Ctukj
 KxYc9ZWNA1x7aa5JVjtxhjokE1aVpcNlGFpFGugvi4xlVidVimVjqjF0tyq5fSKJEas1jqI
X-Google-Smtp-Source: AGHT+IGhMPGWy6khEf0ta92V6QMmBH1G3tDe78XoC+Mhpk4wKdWSy/h5T38n+kwEmoGXQtz55xL7auagtVz2jkej1Uw=
X-Received: by 2002:a53:c059:0:20b0:63e:22b1:21a0 with SMTP id
 956f58d0204a3-63f92271f90mr3131274d50.9.1761935413360; Fri, 31 Oct 2025
 11:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <20251029142311.2986-1-shentey@gmail.com>
 <CAFEAcA-CGQ2JwDoBVZNhQyBMNKXbZsy2Ds+=m0MAPq0hrsWHhA@mail.gmail.com>
 <CAFEAcA_sbvMEJ-oTxTYOutgUrH0iapNcJrsZd3=Ov6wNn-NE3w@mail.gmail.com>
 <a7f5d348-1243-4c52-8dc1-66e2c3da40ae@linaro.org>
In-Reply-To: <a7f5d348-1243-4c52-8dc1-66e2c3da40ae@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Oct 2025 18:30:02 +0000
X-Gm-Features: AWmQ_bmyzSqXOjI_5lqTovyn34HNCDRzT95MEicduE6UtrcoGug9An2nTPSNN2g
Message-ID: <CAFEAcA8+=_8peJR37xoM4zarUu9cy+56rOkyF7iONFb866Ebtg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] KVM Support for imx8mp-evk Machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 31 Oct 2025 at 18:18, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 31/10/25 18:12, Peter Maydell wrote:
> > On Fri, 31 Oct 2025 at 16:57, Peter Maydell <peter.maydell@linaro.org> =
wrote:
> >>
> >> On Wed, 29 Oct 2025 at 14:23, Bernhard Beschow <shentey@gmail.com> wro=
te:
> >>>
> >>> This series adds KVM support to the imx8mp-evk machine, allowing it t=
o run
> >>> guests with KVM acceleration. Inspiration was taken from the virt mac=
hine. This
> >>> required a device tree quirk for the guest clock to be kept in sync w=
ith the
> >>> host. Without this quirk the guest's clock would advance with factor =
<host
> >>> system counter> / 8Mhz.
> >>>
> >>> Testing done:
> >>> * Run `qemu-system-aarch64 -M imx8mp-evk -accel kvm -smp 4` under
> >>>    `qemu-system-aarch64 -M virt,secure=3Don,virtualization=3Don,gic-v=
ersion=3D4 \
> >>>    -cpu cortex-a72 -smp 4 -accel tcg` and `qemu-system-aarch64 -M imx=
8mp-evk \
> >>>    -accel tcg -smp 4". Observe that the `date` command reflects the h=
ost's date.
> >>>
> >>> v2:
> >>> * Mention various tradeoffs in the board documentation (Peter)
> >>> * Accommodate for single-binary (Peter, Pierrick) by having CPU defau=
lts
> >>>
> >>> Bernhard Beschow (2):
> >>>    hw/arm/imx8mp-evk: Add KVM support
> >>>    hw/arm/imx8mp-evk: Fix guest time in KVM mode
> >>
> >> Thanks, I've applied this to target-arm.next.
> >
> > ...I've had to un-queue it, as it breaks "make check":
> >
> > test:         qemu:qtest+qtest-aarch64 / qtest-aarch64/device-introspec=
t-test
> > start time:   17:06:52
> > duration:     3.70s
> > result:       killed by signal 6 SIGABRT
> > command:      MALLOC_PERTURB_=3D155
> > UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:=
print_stacktrace=3D1
> > PYTHON=3D/data_nvme1n1/linaro/qemu-from-laptop/qemu/build/arm-clang/pyv=
env/bin/python3
> > G_TEST_DBUS_DAEMON=3D/data_nvme1n1/linaro/qemu-from-laptop/qemu/tests/d=
bus-vmstate-daemon.sh
> > RUST_BACKTRACE=3D1
> > MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:p=
rint_stacktrace=3D1
> > QTEST_QEMU_BINARY=3D./qemu-system-aarch64
> > QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-daemon
> > ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1
> > QTEST_QEMU_IMG=3D./qemu-img MESON_TEST_ITERATION=3D1
> > /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/arm-clang/tests/qtest/=
device-introspect-test
> > --tap -k
> > ----------------------------------- stdout ----------------------------=
-------
> > [...]
> > # Testing device 'fsl-imx8mp'
> > ----------------------------------- stderr ----------------------------=
-------
> > unknown type '(null)'
> > Broken pipe
> > ../../tests/qtest/libqtest.c:199: kill_qemu() tried to terminate QEMU
> > process but encountered exit status 1 (expected 0)
> >
> >
> > I think the problem is that you're trying to use ms->cpu_type
> > in the fsl_imx8mp_init() function. This doesn't work in the
> > device-introspect-test setup, because it is just instantiating
> > each device for test, not running a full machine.
> >
> > I think the way we usually avoid this is that if an SoC
> > device object needs to know what CPU type to instantiate
> > it has a QOM property, and the board model tells it.
> > (Annoyingly this then means the CPU instantiation has to
> > move into the realize method where the property value is known.)
>
> Correct, this is the same issue I tried to address with the Raspi
> machines and I noted your comments:
> https://lore.kernel.org/qemu-devel/CAFEAcA961WKB4fxwAS0WHXXKwYEO7TnmovD4z=
-BPGehr6sxBQw@mail.gmail.com/

I think it's different, because for the raspi case the SoC
object is trying to create a CPU type that it can't:
  unknown type 'cortex-a72-arm-cpu'
(because it's the arm device-introspect-test and that CPU
is an aarch64 one)
whereas for this one we are in the aarch64 test, but trying to
use a NULL pointer as our type string:
  unknown type '(null)'

Single binary vs compile-everything is probably a red herring here.

thanks
-- PMM

