Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587D4CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 18:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBGR0-0004vh-43; Mon, 28 Sep 2026 14:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBGQe-0004mZ-4g
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 14:50:24 -0400
Received: from mail-ed2-x26.google.com ([2a00:1450:4864:33::26])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBGQb-00086f-LP
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 14:50:19 -0400
Received: by mail-ed2-x26.google.com with SMTP id
 4fb4d7f45d1cf-6aaea178c96so3990796a12.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 11:50:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790621416; cv=none;
 d=google.com; s=arc-20260327;
 b=E9GvxcU5am4Nwhs4CvYEAckTWNQryiB7R59z6HNsXiD4qKEtdU72U1yosZoKHzyOw+
 39VZsjPEdd1/6JaK33XoTKX6DTJ3o1ErE4P/HtnH+UEP5WrCWFBWyJv2A1zECiNP2awL
 WZt84MyEC75pTO/rO+JlcgDLe7ujO7+PJ7WHH+7E1AkdrnjWzcqDL/TUktscm1wpPQvv
 fBcz0heaGjn7geQ8yE88RB0f3BDXi4SIq0+hwFWHVpOiIxCHwulpOTFarlML9rtRIRxV
 7k+DMVh6cg1tcfpwcR94OsnLftI4IobjzQSkrOYZkYelEbiTf1YvQKMmC3ubxZ1owF/e
 q1LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=cNWNsOCJ4AlO+zLzUIcfQWq7CBexHD/3GmlH1NAXYOk=;
 fh=7YufJNFtCYoQryYMXT8f0Ii6vzOnN7LSzLH2S9TeTd8=;
 b=r26GaGlRzomz89k3OUJrz2kCvHH/atCWDXdirWzdSmipwIYYTJgYUOkaaGWBBbXvul
 L/Fov3HO/juXpgspxG6Nw279Y9iUBEq6WOf1TUD9CNcR3mCQm0eTVh89jBhW4yUQvL2Y
 vCkOVdOigvpL3z9/s4q6T4jyrIWCiuKBpS22Aje3B1nBagpNUHF0aM4I8iceBYtdGK6F
 xhR6YNyYAp1/hQ2sXBsNrf068pK5uGUkEb6ciX2FUHM0j4CoTseENZ9szlY0mYktOqe4
 NuVoyEF/KGuqaUy5WUOcUJ6RB8LXLvKw48F9Ji3Hxe7gn4dshG3hb/JyGw1+m9Pqm0xc
 4QRw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790621416; x=1791226216; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cNWNsOCJ4AlO+zLzUIcfQWq7CBexHD/3GmlH1NAXYOk=;
 b=iUKfTUP0/CUD0kP5iVjpQrm8/uSwT8a0vwADapKY1k3a3h0+ziaKLph1TwtNMc412s
 oP/in6hdPOL5u6voKZ6Ut2fHFu1gOZWJrgJ19ljLSUbsc/GKv9s+3nJEkF/4MWW1mbuG
 PoMwH2GEQOCaQZqisO4rGHY+yziO7ykB+D1yAb7uvfwXsD7VNF0ZbmHS/u9ChfmJ8cZx
 P2YbrwlJ/k+BtHCmVdZHg72Gsnu4Lc6iLzqsl936O26oVRoudY6Fsj97pO2y/GPRLOlt
 2XexccL3mKdtYcMTGpe16tBIA8eCxO8+krhFVY77nU6iB65zIwbeMY2MXVfnDpZPumsd
 rRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790621416; x=1791226216;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cNWNsOCJ4AlO+zLzUIcfQWq7CBexHD/3GmlH1NAXYOk=;
 b=LUiHUK9b7Jy+m3VcaOnc4ugsLmEDV/WI1TUh2erVUSIcAqyJn/tKqF8mGEy/ak6y9/
 jvkhqJZGQ1NOVa5ZvuxPU3jdy0yZhfO5Z9PBnCPKjfGvMwbYdVYpngcOj8lYbd46f70j
 M3yhcgI2tsy1UtsWGksdRU/PgCCEcD3f6TfevLj9mjTEBzAClO9u2fqGXsQe/cjJSiPp
 E7y26oXqg2S3cxF1aJqFRJh09fkN++TFJ8Cae6+Rw0YcYJhV8pPM092p9+Rr0sili2hX
 iNNmjAd4U/bjApWc/hHMlXmnNuUWl8Zz6UW95kVThNBC85lCrt1i5tzRrHM8SiMHrcvE
 tqTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBztnGygK1+/9wte84vn/MSVZ9IQFjvv/BzCMeSZa0gmEFC+Rxm9cZKUs4U5z/ukoRTeSVCa5mJXLITJ@nongnu.org
X-Gm-Message-State: AFq9FYIfW+0iR0thfBGJ1vOLjIzIfPd51OxpWq1AWKC3nPlzZzla4xn8
 c+NEKrmr73w1hBe/KDgAqoMvMwy1lyRU1NYPNqbntPmXwPdAocGs62nqBP7m72gG506miNK2LlH
 zMreU9P+a4II2/s4HqSVVk/JSEXWMswk=
X-Gm-Gg: AYBFou2vYR3HU6AoivTR+8cM7IYjffKo43DK+y62Kg9TzA96u1K5KjNHgYBNazQ4AZY
 dk792x32aX3yBteu50y5k4AW9dfr0HJDGMQ9viBDM5bnaY2mwiJRm+UbcJ8A7F5BzViGV82BKfd
 991FcdbHoJXFXnOLu/R5gNMxywDxq7vULbl/DDW1BlV0gTf1M+Mm8W8TMcqbWIRXIUos84GLD5q
 9Tn9l0JHeELIiA5XqGd5CcuVy8eGichvX8DhUsmhJIVSF1h/kyWLLuJ4YFfZNDDrExDR5/MTYwY
 Ob2MD4UZn7Rt3uGQbFcRv4NMUKzs0z8BDPoH8v7L5mfWqAw4T9HGW0c=
X-Received: by 2002:a05:6402:52cf:b0:6ac:813a:a1de with SMTP id
 4fb4d7f45d1cf-6ac813aaf45mr2454700a12.31.1790621415614; Mon, 28 Sep 2026
 11:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-47-luoyonggang@gmail.com>
 <aro93NuZBXYGbD33@redhat.com>
 <87e7c5ae-c78c-4a47-b9ba-9851ce5757d9@oss.qualcomm.com>
 <CAE2XoE9qsZZ+AnfGQ797SQj5yXP8SDOZyxYoKP=oh57UPFqq0Q@mail.gmail.com>
 <a4b7056e-1651-4167-86e0-e7eaa3941d02@oss.qualcomm.com>
In-Reply-To: <a4b7056e-1651-4167-86e0-e7eaa3941d02@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 29 Sep 2026 02:50:01 +0800
X-Gm-Features: AclHuK9MjNSmaMmQn-0GfArQrUjas0ym97Kf1QeFVREkyJZ8FhppqJVItRfEd-4
Message-ID: <CAE2XoE_0=iEY4uSQ6dBwHpJOhuQOL5SrVbO3kDjMFSrJwbVoVg@mail.gmail.com>
Subject: Re: [PATCH v4 46/55] qapi: add query-targets
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::26;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x26.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 28, 2026 at 7:34=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 28/9/26 12:51, Yonggang Luo wrote:
> > On Mon, Sep 28, 2026 at 6:39=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <
> > philmd@oss.qualcomm.com> wrote:
> >>
> >> On 28/9/26 12:13, Daniel P. Berrang=C3=83=C2=A9 wrote:
> >>> On Sat, Sep 26, 2026 at 03:00:45PM +0800, Yonggang Luo wrote:
> >>>> query-targets lists each linked target, including none, with its
> >>>> arch, endianness, and the machines that target accepts.
> >>>>
> >>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> >>>> ---
> >>>>    hw/core/machine-qmp-cmds.c | 30 ++++++++++++++++++++++++++++++
> >>>>    qapi/machine.json          | 35 +++++++++++++++++++++++++++++++++=
++
> >>>>    2 files changed, 65 insertions(+)
> >>>
> >>>
> >>>> diff --git a/qapi/machine.json b/qapi/machine.json
> >>>> index 6aaa2af709a..d8cdea6203e 100644
> >>>> --- a/qapi/machine.json
> >>>> +++ b/qapi/machine.json
> >>>> @@ -307,6 +307,41 @@
> >>>>    ##
> >>>>    { 'command': 'query-target', 'returns': 'QemuTargetInfo' }
> >>>>
> >>>> +##
> >>>> +# @TargetMachines:
> >>>> +#
> >>>> +# One registered system target and the machines that can run on it.
> >>>> +#
> >>>> +# @arch: the target architecture
> >>>> +#
> >>>> +# @endianness: the target endianness
> >>>> +#
> >>>> +# @machines: machine type names, not aliases
> >>>> +#
> >>>> +# Since: 11.2
> >>>> +##
> >>>> +{ 'struct': 'TargetMachines',
> >>>> +  'data': { 'arch': 'SysEmuTarget',
> >>>> +            'endianness': 'EndianMode',
> >>>> +            'machines': ['str'] } }
> >>>
> >>> We already have  'QemuTargetInfo' struct which is used
> >>> with 'query-target', that should also be used with the
> >>> new 'query-targets' command.
> >>>
> >>> We need to add the 'endianness' field to QemuTargetInfo.
> >>
> >> Why do we want to expose endianness, and what endianness to
> >> expose? Endianness is a runtime bit state of CPUs. Sometime
> >> this bit is hardwired but that is an implementation detail.
> >
> > For some targets it's, but for some targets it's not. for example
> >
> > mips-softmmu.mak
> > mipsel-softmmu.mak
> > mips64el-softmmu.mak
> > mips64-softmmu.mak
> >
> >
> > mips64el-softmmu.mak
> > mips64-softmmu.mak
> > only differ the endianless
> If you look at git / mailing list history you'll see I spent more
> than a year unifying QEMU endianness. It was too much work for a
> single person so we decided to reduce the scope to ARM + MicroBlaze
> for single binary and we got MicroBlaze unified. We don't want
> an endianness-specific single binary. I'm not sure what you are
> trying to build, you didn't clearly explained what is your goal here.
>
> You can find series unifying endianness for MIPS, not merged because
> more things need to be addressed and not the priority.


Oh it's because target_arch is not setup properly for those arch


From bcffa0d129fd864037b4e0f7b2f46f4889e76509 Mon Sep 17 00:00:00 2001
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 29 Sep 2026 02:47:48 +0800
Subject: [PATCH] target-info: preserve full softmmu target identity

Generate a full SysEmuTarget token separately from TARGET_ARCH, so variant
targets such as mipsel retain their QMP identity while user-mode targets
continue using the base architecture token.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build       | 5 +++++
 target-info-def.c | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/meson.build b/meson.build
index d63174ea8a4..e86daa47228 100644
--- a/meson.build
+++ b/meson.build
@@ -3319,6 +3319,9 @@ foreach target : target_dirs
   endif

   config_target +=3D keyval.load('configs/targets' / target + '.mak')
+  if target.endswith('-softmmu')
+    config_target +=3D { 'TARGET_SYS_EMU': config_target['TARGET_NAME'] }
+  endif

   target_kconfig =3D []
   foreach sym: accelerators
@@ -3374,6 +3377,8 @@ foreach target : target_dirs
       # do nothing
     elif k =3D=3D 'TARGET_ARCH'
       config_target_data.set(k, v.to_upper())
+    elif k =3D=3D 'TARGET_SYS_EMU'
+      config_target_data.set(k, v.to_upper())
     elif k =3D=3D 'TARGET_BASE_ARCH'
       # Note that TARGET_BASE_ARCH ends up in config-target.h but it is
       # not used to select files from sourcesets.
diff --git a/target-info-def.c b/target-info-def.c
index c02d98e6875..54e499712bf 100644
--- a/target-info-def.c
+++ b/target-info-def.c
@@ -28,7 +28,11 @@ QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS_MI=
N);

 static const TargetInfo target_info_stub =3D {
     .target_name =3D TARGET_NAME,
+#ifdef CONFIG_SOFTMMU
+    .target_arch =3D glue(SYS_EMU_TARGET_, TARGET_SYS_EMU),
+#else
     .target_arch =3D glue(SYS_EMU_TARGET_, TARGET_ARCH),
+#endif
     .long_bits =3D TARGET_LONG_BITS,
     .cpu_type =3D CPU_RESOLVING_TYPE,
     .endianness =3D TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITT=
LE,
--=20
2.52.0.windows.1





--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

