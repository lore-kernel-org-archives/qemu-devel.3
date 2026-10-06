Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B973CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENB3-00079y-5o; Wed, 07 Oct 2026 04:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEIZl-0005CG-FQ
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:44:30 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEIZZ-0001en-Pw
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:44:09 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c263415982eso182793566b.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 20:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791344642; cv=none;
 d=google.com; s=arc-20260327;
 b=Kz/0k2lGvqyi5InwkYaNJ+GrjP03rHmvrbvV6Hws3bAn6OzWipq0i+d+mAWCqkccF/
 xcxSZG/aEmNiXfrYkzCxEwJVtgGok+S5lZ7qb4GRntlPaS+4D0HfoqA/0vgnTOZqHvrc
 Skpj31s38HJFS0vlYkFxl6P6v92bN03PDGWqHeR8x5e+rbgRqhOXGPYS+Qjbjd+al0Cx
 x6o9v9LgUMXax1+B1Rb7nWuGZxbAgiG6KZTmFWWtXlb5WbRl1LdHLVRp1gqv8k8OX9Pe
 MGeBPYfSa77VOWNUmXT0aBzdR/Qgv8LVodzu9Wp/N0f5VMuHDtWiCenDewJFkAqj5x/L
 FrYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0WMGWsoSFMspoiQjBl2zSHuNESNLE6EKktiP9sjzWFs=;
 fh=B99/hERjj4KcPVb7F0nv+zkC7YWt1dQTEcrMlc9pY2E=;
 b=Sy8jSktCoGIO3cDrxg1WUtH0iURh1+/H8fJGI3C1sAcLFIBZ6pWRI4lt2QQm5wTWuX
 28O+Qda/BPo/j5tIuFnnZZtir6CKYQWXj+Z8fTp1M0vYP7yZXi2pa6L3TZdzXX2o3Bbe
 +svl83drOWoI+HJYivMyT3nld4sL5+Dr+bQsJGM6B5siDQ7z1ZJo5GuPpbOZcD3mX+DK
 RhnzfGXZg6pUGrhT7ziwdyL7YLYoVAGupr0H2mNRsbXVSl2MbtlkrCT0Khd8vbaYWIUL
 UbNm2JX+ebbNRUSbeSjaJxDQL/LUq3lrGS9yWmPhZvVJPwbSLDJwdAriVGxp0Okn6I/f
 Yzyw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791344642; x=1791949442; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0WMGWsoSFMspoiQjBl2zSHuNESNLE6EKktiP9sjzWFs=;
 b=Zo9RzmsH5bLyrZ8YIMVXCCTDjZr1ZSW9K13Lt0Ntb2xK3/dVysBAlQt7Mr8l4+eQG9
 8AFR2a/be7FtZJ4qzyA6WuWBz9IHD4hZ5fGuTv6uoBC/zXxjZCmrKMttCTUniNaeLPmP
 YLW5SqalMD+hI8IdR5+3IKl8l64KWcJEfDnk19UrirCLXa4jm0GU4U8TN7CsYNS7DplF
 Vy58GG1In5g0LwOmb9fpyFTh1XQORTN/vDfcBQOEHN6ZsunJ6IqPURDMCRvt8y0hNbV+
 0jJDx5ZqSkDm/9wu73/xGUyLGNafP5VFhc94bt3myLFPsUGiXPyr6AKiakG9jWHeUVOZ
 lgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791344642; x=1791949442;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0WMGWsoSFMspoiQjBl2zSHuNESNLE6EKktiP9sjzWFs=;
 b=Ktiq9nTNRy8hZTw44qr8JFIZ+HyOPXpGGyic+u7CnlRq4iBmitQPcA0qeUM50Wfb0x
 /9oe7uw3xxuIQM+rFUSETEsWAS5N+/nDzegxxHlEYH5u7X4RfcA0j4ZGjO9upW484pBl
 lwttiMJVPVu8Ym6VeOCrX9FL+ZN5ZHNXJhwIlqRcJXUd2La+ihHF0YQ3QqV4uaPJerVR
 e5DmIwDl4pjI/pu3DX/Gv5RrJ3b1Es/ErlnIgj5Vj4xVBd/M5Jjjrsg59NXSWB8OevAM
 7VM75CMnRVFlocJ4MDINzU18MAZ0qopJkF9DtQRqDdT5KdgxjKvbXx6H0s5iqRq8jIoK
 oVLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5i542bLVkVx2JDM6n4FGbfz0MJEdP0nkRNWb1eEO4RiHU71tP1zrmpwnpjfa8evro/p+NKA6ZjDO3@nongnu.org
X-Gm-Message-State: AFuF++l+VCqvP/Wkpa9Sv2vRcVA0uUshU3+gqBRNx3GnQnZeK2DFHd9O
 bZXaDmfeJNc6quVSvHNdrEmGwaeRU6YeW3AekJXL8x3S3w2Mxa/Un0t6Z8g/MdlcQXuwO3DNPj6
 5URyxFE+ou0PdMADxAb+FYjxhZDN/tbNCP06p
X-Gm-Gg: AYBFou0b/jbW3vVtEb7/Bme4N7JC9Rn89FfEADZgtetdRnWUqSfdD0/ErBPti/O8yo4
 o44EvuFg6SMn4P7J6XUzpNbvbg3YECmB4uwqMx7eZmYuUekghw6ks4QSf++jrv5E1l3rZp6erXR
 VnqzoXLWH8TwwtOECOF0G8U98UziVq13Je20JgID3mjkgSdAty6LdES79yNzBE5e/DJ6SvjnjJt
 6WCAS4qiF/4FRrvBfaWXzcJ5jLzyMfNzvLR5WoVh0itW9UQ7DJR4yEkPPL9BGULdTtqddNDO0na
 y2s97pTBjvknVbF4ElvBQG+oOKLo/nKIo7AC5v6gNZNue42j2xWKPtc=
X-Received: by 2002:a05:6402:440a:b0:6ab:223:f7f1 with SMTP id
 4fb4d7f45d1cf-6aff391242emr11538a12.17.1791312388685; Tue, 06 Oct 2026
 11:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20261004072927.1142-1-luoyonggang@gmail.com>
 <0b84bf4d-3b98-4f52-8847-9f89bef92c1e@oss.qualcomm.com>
 <CAE2XoE-joWZwrBy-jLe+=ZP7OGM9cyDrF_5hz7koVPODeys+JA@mail.gmail.com>
 <b2297f92-a685-4399-a755-bbe5a37b9b3f@oss.qualcomm.com>
 <CAE2XoE-4Pdp_n3RgpqJ5se_KTHniMAJAodTLmkfV+0jjou=M5w@mail.gmail.com>
 <c6bd8e8d-3160-46c2-ba4a-2f5a4b93cf38@oss.qualcomm.com>
 <CAE2XoE9PKNgE1Zz_frOq_DrgqrPL4B8hcq0xO6ywCNTeUnFLvA@mail.gmail.com>
 <63d20cc8-8003-489c-9f08-28369a2f71e2@oss.qualcomm.com>
 <CAE2XoE9uqEcjMsqJXu6Cr+MrposPjq7O6Lnj5cj7uW2nF38uAg@mail.gmail.com>
 <15e9a768-95bf-45aa-8175-1dbd73d5ee04@oss.qualcomm.com>
 <asT-GoQ6xH4-dLET@redhat.com>
 <2dc73982-a162-415e-92a3-48bd0cb018ce@oss.qualcomm.com>
 <c51c23de-fe63-44bb-b8da-611e4ac27cb5@oss.qualcomm.com>
In-Reply-To: <c51c23de-fe63-44bb-b8da-611e4ac27cb5@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 7 Oct 2026 02:46:16 +0800
X-Gm-Features: AclHuK9HHmV_5tGjVh-uUSOjb5_3KJ2Dax1ATYw_ikGWbJ-8GgBFMj9Z-SGMXIk
Message-ID: <CAE2XoE9b48w5xJKdLBnSVuwFngx-+cMpf6rEgDztzZEt=UkqMQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] target-info: preserve full softmmu target identity
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-level <qemu-devel@nongnu.org>, Philippe Mathieu-Daude <philmd@mailo.com>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009c0559065d306ab7"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--0000000000009c0559065d306ab7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

where I do not see it


         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> =E4=BA=8E 2026=E5=B9=
=B410=E6=9C=887=E6=97=A5=E5=91=A8=E4=B8=89 02:30=E5=86=99=E9=81=93=EF=BC=9A

> On 10/6/2026 10:31 AM, Pierrick Bouvier wrote:
> > On 10/6/2026 6:56 AM, Daniel P. Berrang=C3=A9 wrote:
> >> On Mon, Oct 05, 2026 at 11:52:48AM -0700, Pierrick Bouvier wrote:
> >>> On 10/5/2026 11:45 AM, Yonggang Luo wrote:
> >>>> On Tue, Oct 6, 2026 at 2:06=E2=80=AFAM Pierrick Bouvier
> >>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>>
> >>>>> On 10/5/2026 10:04 AM, Yonggang Luo wrote:
> >>>>>> On Tue, Oct 6, 2026 at 12:25=E2=80=AFAM Pierrick Bouvier
> >>>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>>>>>>
> >>>>>>>>> Ok, but I'm not sure it answers the why.
> >>>>>>>>> Could you explain the benefits?
> >>>>>>>>
> >>>>>>>> Which part? keeping target_arch as SYS_EMU_TARGET__MAX for
> user-binary because
> >>>>>>>> The following original code would return -1 for some user-binary
> >>>>>>>> +    SysEmuTarget arch =3D target_info()->target_arch;
> >>>>>>>> +
> >>>>>>>> +    if (arch =3D=3D SYS_EMU_TARGET__MAX) {
> >>>>>>>> +        arch =3D qapi_enum_parse(&SysEmuTarget_lookup,
> target_name(), -1,
> >>>>>>>> +                               &error_abort);
> >>>>>>>> +    }
> >>>>>>>> +    return arch;
> >>>>>>>> So basically assigning any value for the user binary is valid.
> >>>>>>>> SYS_EMU_TARGET__MAX is more explicit as it's related to type
> SysEmuTarget.
> >>>>>>>> -1 is another option but easy to confuse.
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> For why commit e934c624f32f6f44f427d73a2e6a67e983a02ae6.
> >>>>>>>> "target-info: Statically initialize target_arch"
> >>>>>>>> doing that, I am not sure.
> >>>>>>>>
> >>>>>>>
> >>>>>>> I guess there is a (good or bad) reason for which sub variants of
> >>>>>>> targets are not reflected in SYS_EMU_TARGET enum. We should doubl=
e
> check
> >>>>>>> that before doing any change, as it might have other consequences=
.
> >>>>>>
> >>>>>>
> >>>>>> You=E2=80=99re right to ask, and I need to correct my earlier sugg=
estion:
> >>>>>> leaving user-mode target_arch
> >>>>>>  as SYS_EMU_TARGET__MAX is not safe. target_aarch64() is used by A=
RM
> >>>>>> code shared with user-mode builds,
> >>>>>> including cpu-max-v8.c, where its result indexes a two-entry array=
.
> >>>>>> For aarch64-linux-user, the sentinel could therefore cause an
> >>>>>> out-of-bounds access during type registration.
> >>>>>>
> >>>>>> I checked the distinction: softmmu needs the full system-target
> >>>>>> identity, including variants such as mipsel;
> >>>>>> user-mode variants such as aarch64_be use their base TARGET_ARCH
> >>>>>> (aarch64) for this enum. I=E2=80=99ll keep the full TARGET_SYS_EMU
> >>>>>>  value for softmmu and use TARGET_ARCH for user-mode builds, rathe=
r
> >>>>>> than leave the field at SYS_EMU_TARGET__MAX.
> >>>>>>
> >>>>>
> >>>>> That's technical details, but not an answer to the initial question
> of
> >>>>> why we need to change anything for user binaries, compared to what
> exists.
> >>>>
> >>>> The first two patches revert the current static initialization so th=
e
> >>>> token can be replaced. They are not a user-mode behavior change.
> >>>>
> >>>> Compared with current QEMU, user-mode still uses TARGET_ARCH.
> >>>> qemu-mipsel already reports mips, and it still will. Names such as
> >>>> aarch64_be are not SysEmuTarget values, so user-mode cannot use the
> >>>> full target name for this field; keeping TARGET_ARCH preserves today=
's
> >>>> value and avoids the runtime parse.
> >>>>
> >>>
> >>> Why should we need to expose this precise information?
> >>> So far, if those targets were not exposed (and aliased to 32/64 bit
> >>> variant), it's probably we didn't need it.
> >>
> >> Current git master is exhibiting a regression compared to previous
> >> releases.
> >>
> >> For example on 10.1.0:
> >>
> >> $ for i in /usr/bin/qemu-system-* ; do echo -n "$i: " ; echo -e
> '{"execute":"qmp_capabilities"}\r\n{"execute":"query-target"}\r\n{"execut=
e":"quit"}\r\n'
> | $i -qmp stdio -display none -M none | jq .return.arch | grep -v null ;
> done
> >> /usr/bin/qemu-system-aarch64: "aarch64"
> >> /usr/bin/qemu-system-alpha: "alpha"
> >> /usr/bin/qemu-system-arm: "arm"
> >> /usr/bin/qemu-system-avr: "avr"
> >> /usr/bin/qemu-system-hppa: "hppa"
> >> /usr/bin/qemu-system-i386: "i386"
> >> /usr/bin/qemu-system-loongarch64: "loongarch64"
> >> /usr/bin/qemu-system-m68k: "m68k"
> >> /usr/bin/qemu-system-microblaze: "microblaze"
> >> /usr/bin/qemu-system-microblazeel: "microblazeel"
> >> /usr/bin/qemu-system-mips: "mips"
> >> /usr/bin/qemu-system-mips64: "mips64"
> >> /usr/bin/qemu-system-mips64el: "mips64el"
> >> /usr/bin/qemu-system-mipsel: "mipsel"
> >> /usr/bin/qemu-system-or1k: "or1k"
> >> /usr/bin/qemu-system-ppc: "ppc"
> >> /usr/bin/qemu-system-ppc64: "ppc64"
> >> /usr/bin/qemu-system-riscv32: "riscv32"
> >> /usr/bin/qemu-system-riscv64: "riscv64"
> >> /usr/bin/qemu-system-rx: "rx"
> >> /usr/bin/qemu-system-s390x: "s390x"
> >> /usr/bin/qemu-system-sh4: "sh4"
> >> /usr/bin/qemu-system-sh4eb: "sh4eb"
> >> /usr/bin/qemu-system-sparc: "sparc"
> >> /usr/bin/qemu-system-sparc64: "sparc64"
> >> /usr/bin/qemu-system-tricore: "tricore"
> >> /usr/bin/qemu-system-x86_64: "x86_64"
> >> /usr/bin/qemu-system-xtensa: "xtensa"
> >> /usr/bin/qemu-system-xtensaeb: "xtensaeb"
> >>
> >>
> >> but on git master:
> >>
> >> $ for i in $(find ./build -type f -name 'qemu-system-*') ; do echo -n
> "$i: " ; echo -e
> '{"execute":"qmp_capabilities"}\r\n{"execute":"query-target"}\r\n{"execut=
e":"quit"}\r\n'
> | $i -qmp stdio -display none -M none | jq .return.arch | grep -v null ;
> done
> >> ./build/qemu-system-hexagon: "hexagon"
> >> ./build/qemu-system-x86_64: "x86_64"
> >> ./build/qemu-system-s390x: "s390x"
> >> ./build/qemu-system-m68k: "m68k"
> >> ./build/qemu-system-xtensa: "xtensa"
> >> ./build/qemu-system-xtensaeb: "xtensa"
> >> ./build/qemu-system-rx: "rx"
> >> ./build/qemu-system-loongarch64: "loongarch64"
> >> ./build/qemu-system-riscv32: "riscv32"
> >> ./build/qemu-system-hppa: "hppa"
> >> ./build/qemu-system-ppc64: "ppc64"
> >> ./build/qemu-system-microblaze: "microblaze"
> >> ./build/qemu-system-sparc: "sparc"
> >> ./build/qemu-system-riscv64: "riscv64"
> >> ./build/qemu-system-i386: "i386"
> >> ./build/qemu-system-mipsel: "mips"
> >> ./build/qemu-system-sh4: "sh4"
> >> ./build/qemu-system-mips64el: "mips64"
> >> ./build/qemu-system-mips64: "mips64"
> >> ./build/qemu-system-sparc64: "sparc64"
> >> ./build/qemu-system-arm: "arm"
> >> ./build/qemu-system-tricore: "tricore"
> >> ./build/qemu-system-mips: "mips"
> >> ./build/qemu-system-or1k: "or1k"
> >> ./build/qemu-system-sh4eb: "sh4"
> >> ./build/qemu-system-aarch64: "aarch64"
> >> ./build/qemu-system-ppc: "ppc"
> >> ./build/qemu-system-avr: "avr"
> >> ./build/qemu-system-alpha: "alpha"
> >>
> >>
> >> so we need to fix that behaviour change for query-target.
> >>
> >> If we want to be able to expose only the "base" target,
> >> then query-target's  QemuTargetInfo struct could be
> >> extended with a 2nd field that presents the base.
> >>
> >>
> >> With regards,
> >> Daniel
> >
> > Thanks for finding this Daniel.
> > SYS_EMU_TARGET already has the correct variants, the regression was to
> > use TARGET_ARCH instead of TARGET_NAME in target-info-stub.c.
> >
> > I think Richard used this one just because TARGET_NAME is a string, so
> > it can't be concatenated with C preprocessor.
> >
> > I'll fix that part.
> >
>
> Please take a look to the following series that solves this regression,
> and also allows to detect endianness variants through target_arch():
>
> 20261006182558.151956-1-pierrick.bouvier@oss.qualcomm.com
> "[PATCH 0/2] target-info: expose full target variant"
>
> Regards,
> Pierrick
>

--0000000000009c0559065d306ab7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>where I do not see it</div><div dir=3D"auto"><br></d=
iv><div><br></div><div data-smartmail=3D"gmail_signature">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=
=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<br></div></div>=
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@oss=
.qualcomm.com">pierrick.bouvier@oss.qualcomm.com</a>&gt; =E4=BA=8E 2026=E5=
=B9=B410=E6=9C=887=E6=97=A5=E5=91=A8=E4=B8=89 02:30=E5=86=99=E9=81=93=EF=BC=
=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">On 10/6/2026 10:31 AM, Pierrick=
 Bouvier wrote:<br>
&gt; On 10/6/2026 6:56 AM, Daniel P. Berrang=C3=A9 wrote:<br>
&gt;&gt; On Mon, Oct 05, 2026 at 11:52:48AM -0700, Pierrick Bouvier wrote:<=
br>
&gt;&gt;&gt; On 10/5/2026 11:45 AM, Yonggang Luo wrote:<br>
&gt;&gt;&gt;&gt; On Tue, Oct 6, 2026 at 2:06=E2=80=AFAM Pierrick Bouvier<br=
>
&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:pierrick.bouvier@oss.qualcomm.com" t=
arget=3D"_blank" rel=3D"noreferrer">pierrick.bouvier@oss.qualcomm.com</a>&g=
t; wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; On 10/5/2026 10:04 AM, Yonggang Luo wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt; On Tue, Oct 6, 2026 at 12:25=E2=80=AFAM Pierrick B=
ouvier<br>
&gt;&gt;&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:pierrick.bouvier@oss.qualcom=
m.com" target=3D"_blank" rel=3D"noreferrer">pierrick.bouvier@oss.qualcomm.c=
om</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Ok, but I&#39;m not sure it answers th=
e why.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Could you explain the benefits?<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Which part? keeping target_arch as SYS_EMU=
_TARGET__MAX for user-binary because<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; The following original code would return -=
1 for some user-binary<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 SysEmuTarget arch =3D targe=
t_info()-&gt;target_arch;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (arch =3D=3D SYS_EMU_TAR=
GET__MAX) {<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 arch =3D qapi=
_enum_parse(&amp;SysEmuTarget_lookup, target_name(), -1,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;=
error_abort);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 return arch;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; So basically assigning any value for the u=
ser binary is valid.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; SYS_EMU_TARGET__MAX is more explicit as it=
&#39;s related to type SysEmuTarget.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -1 is another option but easy to confuse.<=
br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; For why commit e934c624f32f6f44f427d73a2e6=
a67e983a02ae6.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &quot;target-info: Statically initialize t=
arget_arch&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; doing that, I am not sure.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; I guess there is a (good or bad) reason for wh=
ich sub variants of<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; targets are not reflected in SYS_EMU_TARGET en=
um. We should double check<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; that before doing any change, as it might have=
 other consequences.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; You=E2=80=99re right to ask, and I need to correct=
 my earlier suggestion:<br>
&gt;&gt;&gt;&gt;&gt;&gt; leaving user-mode target_arch<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 as SYS_EMU_TARGET__MAX is not safe. target_a=
arch64() is used by ARM<br>
&gt;&gt;&gt;&gt;&gt;&gt; code shared with user-mode builds,<br>
&gt;&gt;&gt;&gt;&gt;&gt; including cpu-max-v8.c, where its result indexes a=
 two-entry array.<br>
&gt;&gt;&gt;&gt;&gt;&gt; For aarch64-linux-user, the sentinel could therefo=
re cause an<br>
&gt;&gt;&gt;&gt;&gt;&gt; out-of-bounds access during type registration.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; I checked the distinction: softmmu needs the full =
system-target<br>
&gt;&gt;&gt;&gt;&gt;&gt; identity, including variants such as mipsel;<br>
&gt;&gt;&gt;&gt;&gt;&gt; user-mode variants such as aarch64_be use their ba=
se TARGET_ARCH<br>
&gt;&gt;&gt;&gt;&gt;&gt; (aarch64) for this enum. I=E2=80=99ll keep the ful=
l TARGET_SYS_EMU<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 value for softmmu and use TARGET_ARCH for us=
er-mode builds, rather<br>
&gt;&gt;&gt;&gt;&gt;&gt; than leave the field at SYS_EMU_TARGET__MAX.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; That&#39;s technical details, but not an answer to the=
 initial question of<br>
&gt;&gt;&gt;&gt;&gt; why we need to change anything for user binaries, comp=
ared to what exists.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; The first two patches revert the current static initializa=
tion so the<br>
&gt;&gt;&gt;&gt; token can be replaced. They are not a user-mode behavior c=
hange.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Compared with current QEMU, user-mode still uses TARGET_AR=
CH.<br>
&gt;&gt;&gt;&gt; qemu-mipsel already reports mips, and it still will. Names=
 such as<br>
&gt;&gt;&gt;&gt; aarch64_be are not SysEmuTarget values, so user-mode canno=
t use the<br>
&gt;&gt;&gt;&gt; full target name for this field; keeping TARGET_ARCH prese=
rves today&#39;s<br>
&gt;&gt;&gt;&gt; value and avoids the runtime parse.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Why should we need to expose this precise information?<br>
&gt;&gt;&gt; So far, if those targets were not exposed (and aliased to 32/6=
4 bit<br>
&gt;&gt;&gt; variant), it&#39;s probably we didn&#39;t need it.<br>
&gt;&gt;<br>
&gt;&gt; Current git master is exhibiting a regression compared to previous=
<br>
&gt;&gt; releases.<br>
&gt;&gt;<br>
&gt;&gt; For example on 10.1.0:<br>
&gt;&gt;<br>
&gt;&gt; $ for i in /usr/bin/qemu-system-* ; do echo -n &quot;$i: &quot; ; =
echo -e &#39;{&quot;execute&quot;:&quot;qmp_capabilities&quot;}\r\n{&quot;e=
xecute&quot;:&quot;query-target&quot;}\r\n{&quot;execute&quot;:&quot;quit&q=
uot;}\r\n&#39; | $i -qmp stdio -display none -M none | jq .return.arch | gr=
ep -v null ; done<br>
&gt;&gt; /usr/bin/qemu-system-aarch64: &quot;aarch64&quot;<br>
&gt;&gt; /usr/bin/qemu-system-alpha: &quot;alpha&quot;<br>
&gt;&gt; /usr/bin/qemu-system-arm: &quot;arm&quot;<br>
&gt;&gt; /usr/bin/qemu-system-avr: &quot;avr&quot;<br>
&gt;&gt; /usr/bin/qemu-system-hppa: &quot;hppa&quot;<br>
&gt;&gt; /usr/bin/qemu-system-i386: &quot;i386&quot;<br>
&gt;&gt; /usr/bin/qemu-system-loongarch64: &quot;loongarch64&quot;<br>
&gt;&gt; /usr/bin/qemu-system-m68k: &quot;m68k&quot;<br>
&gt;&gt; /usr/bin/qemu-system-microblaze: &quot;microblaze&quot;<br>
&gt;&gt; /usr/bin/qemu-system-microblazeel: &quot;microblazeel&quot;<br>
&gt;&gt; /usr/bin/qemu-system-mips: &quot;mips&quot;<br>
&gt;&gt; /usr/bin/qemu-system-mips64: &quot;mips64&quot;<br>
&gt;&gt; /usr/bin/qemu-system-mips64el: &quot;mips64el&quot;<br>
&gt;&gt; /usr/bin/qemu-system-mipsel: &quot;mipsel&quot;<br>
&gt;&gt; /usr/bin/qemu-system-or1k: &quot;or1k&quot;<br>
&gt;&gt; /usr/bin/qemu-system-ppc: &quot;ppc&quot;<br>
&gt;&gt; /usr/bin/qemu-system-ppc64: &quot;ppc64&quot;<br>
&gt;&gt; /usr/bin/qemu-system-riscv32: &quot;riscv32&quot;<br>
&gt;&gt; /usr/bin/qemu-system-riscv64: &quot;riscv64&quot;<br>
&gt;&gt; /usr/bin/qemu-system-rx: &quot;rx&quot;<br>
&gt;&gt; /usr/bin/qemu-system-s390x: &quot;s390x&quot;<br>
&gt;&gt; /usr/bin/qemu-system-sh4: &quot;sh4&quot;<br>
&gt;&gt; /usr/bin/qemu-system-sh4eb: &quot;sh4eb&quot;<br>
&gt;&gt; /usr/bin/qemu-system-sparc: &quot;sparc&quot;<br>
&gt;&gt; /usr/bin/qemu-system-sparc64: &quot;sparc64&quot;<br>
&gt;&gt; /usr/bin/qemu-system-tricore: &quot;tricore&quot;<br>
&gt;&gt; /usr/bin/qemu-system-x86_64: &quot;x86_64&quot;<br>
&gt;&gt; /usr/bin/qemu-system-xtensa: &quot;xtensa&quot;<br>
&gt;&gt; /usr/bin/qemu-system-xtensaeb: &quot;xtensaeb&quot;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; but on git master:<br>
&gt;&gt;<br>
&gt;&gt; $ for i in $(find ./build -type f -name &#39;qemu-system-*&#39;) ;=
 do echo -n &quot;$i: &quot; ; echo -e &#39;{&quot;execute&quot;:&quot;qmp_=
capabilities&quot;}\r\n{&quot;execute&quot;:&quot;query-target&quot;}\r\n{&=
quot;execute&quot;:&quot;quit&quot;}\r\n&#39; | $i -qmp stdio -display none=
 -M none | jq .return.arch | grep -v null ; done<br>
&gt;&gt; ./build/qemu-system-hexagon: &quot;hexagon&quot;<br>
&gt;&gt; ./build/qemu-system-x86_64: &quot;x86_64&quot;<br>
&gt;&gt; ./build/qemu-system-s390x: &quot;s390x&quot;<br>
&gt;&gt; ./build/qemu-system-m68k: &quot;m68k&quot;<br>
&gt;&gt; ./build/qemu-system-xtensa: &quot;xtensa&quot;<br>
&gt;&gt; ./build/qemu-system-xtensaeb: &quot;xtensa&quot;<br>
&gt;&gt; ./build/qemu-system-rx: &quot;rx&quot;<br>
&gt;&gt; ./build/qemu-system-loongarch64: &quot;loongarch64&quot;<br>
&gt;&gt; ./build/qemu-system-riscv32: &quot;riscv32&quot;<br>
&gt;&gt; ./build/qemu-system-hppa: &quot;hppa&quot;<br>
&gt;&gt; ./build/qemu-system-ppc64: &quot;ppc64&quot;<br>
&gt;&gt; ./build/qemu-system-microblaze: &quot;microblaze&quot;<br>
&gt;&gt; ./build/qemu-system-sparc: &quot;sparc&quot;<br>
&gt;&gt; ./build/qemu-system-riscv64: &quot;riscv64&quot;<br>
&gt;&gt; ./build/qemu-system-i386: &quot;i386&quot;<br>
&gt;&gt; ./build/qemu-system-mipsel: &quot;mips&quot;<br>
&gt;&gt; ./build/qemu-system-sh4: &quot;sh4&quot;<br>
&gt;&gt; ./build/qemu-system-mips64el: &quot;mips64&quot;<br>
&gt;&gt; ./build/qemu-system-mips64: &quot;mips64&quot;<br>
&gt;&gt; ./build/qemu-system-sparc64: &quot;sparc64&quot;<br>
&gt;&gt; ./build/qemu-system-arm: &quot;arm&quot;<br>
&gt;&gt; ./build/qemu-system-tricore: &quot;tricore&quot;<br>
&gt;&gt; ./build/qemu-system-mips: &quot;mips&quot;<br>
&gt;&gt; ./build/qemu-system-or1k: &quot;or1k&quot;<br>
&gt;&gt; ./build/qemu-system-sh4eb: &quot;sh4&quot;<br>
&gt;&gt; ./build/qemu-system-aarch64: &quot;aarch64&quot;<br>
&gt;&gt; ./build/qemu-system-ppc: &quot;ppc&quot;<br>
&gt;&gt; ./build/qemu-system-avr: &quot;avr&quot;<br>
&gt;&gt; ./build/qemu-system-alpha: &quot;alpha&quot;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; so we need to fix that behaviour change for query-target.<br>
&gt;&gt;<br>
&gt;&gt; If we want to be able to expose only the &quot;base&quot; target,<=
br>
&gt;&gt; then query-target&#39;s=C2=A0 QemuTargetInfo struct could be<br>
&gt;&gt; extended with a 2nd field that presents the base.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; With regards,<br>
&gt;&gt; Daniel<br>
&gt; <br>
&gt; Thanks for finding this Daniel.<br>
&gt; SYS_EMU_TARGET already has the correct variants, the regression was to=
<br>
&gt; use TARGET_ARCH instead of TARGET_NAME in target-info-stub.c.<br>
&gt; <br>
&gt; I think Richard used this one just because TARGET_NAME is a string, so=
<br>
&gt; it can&#39;t be concatenated with C preprocessor.<br>
&gt; <br>
&gt; I&#39;ll fix that part.<br>
&gt;<br>
<br>
Please take a look to the following series that solves this regression,<br>
and also allows to detect endianness variants through target_arch():<br>
<br>
<a href=3D"mailto:20261006182558.151956-1-pierrick.bouvier@oss.qualcomm.com=
" target=3D"_blank" rel=3D"noreferrer">20261006182558.151956-1-pierrick.bou=
vier@oss.qualcomm.com</a><br>
&quot;[PATCH 0/2] target-info: expose full target variant&quot;<br>
<br>
Regards,<br>
Pierrick<br>
</blockquote></div>

--0000000000009c0559065d306ab7--

