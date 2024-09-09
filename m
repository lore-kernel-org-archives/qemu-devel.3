Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00094ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snibq-0005GE-W2; Mon, 09 Sep 2024 13:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1snibk-0004pn-0P
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:55:24 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1snibg-0000Rw-1I
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:55:22 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e1a9b40f6b3so5038848276.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1725904516; x=1726509316; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yEKkSaZbdu4RuJmqeqNJ0ZfbmevWjngTAGaMSjyEXYY=;
 b=jc3UID0PEeBILa00gQAQjLjv8TvTyGsOxZYDhjENbf1Nx6owOx32qylix52rnx2w7F
 BWwQsOg0FC7a2YqfrqRygPxBSct+K/B6Hp16Qe9BwX+lW4pqfSgS7QSjknmyKREaFOOC
 p/Hg8nbDtwLajUkUhYduG9OYL2qLplBJ08hpmZbnlVI1xX8+Dhi0c3sisNVILOcgyPYy
 780xRnNIVXGi31ut2jdaq2Z9ipkVbjCEYOR0DubU86aXkVMkZD1UoeHIsaMeJgf8N4IN
 TySIa/f/HL/6EwHfitEh8uasljcwBdbmAOFBe9sihLfoBXnVP1C3wW93MEBkvNaXPTk+
 JPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725904516; x=1726509316;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yEKkSaZbdu4RuJmqeqNJ0ZfbmevWjngTAGaMSjyEXYY=;
 b=TS0mYDGTE9e3rn7y2pwJjpGny/gE3HnKSygC4Qtb0gh5Ci2CccfCRiPuzMpuDGgMmJ
 NplLFmAixY6QlFLRe9/TArsUErniP5KjxmqOzsWF2yBPp3ODDSEW5w73nH+KszX5pkOc
 ewunO8cFJom1o+IFzA2cVR/kM1UujhFfNbI6oSyQXHViTH649tgP+aQ//Uo6qUg8J4L/
 XWAfjKRbOni9fsOcT38eTpUnkZ+epYtcOLSeXcimYiNoF+JOb7OlX+ODtIy1SksTw1cR
 8lv95BA8QJdhy9QgJR9kU+QYRBxOAsKKmWk91aE5nXcMLWC/GlPwhsUY+LnkdTeewr8p
 VZTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgBMLpjaAkoyD7PTZhHWQDCkbeKRJ4ovnwME5VgrBfswSpNEcwfM347YMW1pdh863tLjsb/9dWiOMv@nongnu.org
X-Gm-Message-State: AOJu0YxQI4K0BlZINzAGzN8VhxETrf1Z+WsQQv/zFZNlcSyTEBsGrGFU
 0VkVD/ZMOi/0O7ONBr4mSjV5Rs7GV40rf+ZLNqdXsx39rSoOAHQu/9Zrt2CbocoRH83Nc6Y9gy1
 uZu6w7V1nNSKGxBqjzWd6p4qerBtWpkvZV/UOUQ==
X-Google-Smtp-Source: AGHT+IFpjNbZ33Hq3yrwbgmcjEmTkxpzXwVsg2elh0ni4DBhcNZqQ2sEo23auaT0Ju/KiABN6k4oyjMUMHhs8seA9PQ=
X-Received: by 2002:a05:6902:2b93:b0:e11:7096:5478 with SMTP id
 3f1490d57ef6-e1d34886029mr13388774276.20.1725904515974; Mon, 09 Sep 2024
 10:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240711215244.19237-1-yichen.wang@bytedance.com>
 <20240711215244.19237-2-yichen.wang@bytedance.com>
 <PH7PR11MB59413BDDA018D8FA67775C9AA3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB59413BDDA018D8FA67775C9AA3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
From: Yichen Wang <yichen.wang@bytedance.com>
Date: Mon, 9 Sep 2024 10:55:05 -0700
Message-ID: <CAHObMVY4O01RLBCEGnoZhZj60A27QEV=WKOGXBKWrm+3BQgxig@mail.gmail.com>
Subject: Re: [External] RE: [PATCH v5 01/13] meson: Introduce new instruction
 set enqcmd to the build system.
To: "Liu, Yuan1" <yuan1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Hao Xiang <hao.xiang@linux.dev>, 
 "Kumar, Shivam" <shivam.kumar1@nutanix.com>, 
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=yichen.wang@bytedance.com; helo=mail-yb1-xb34.google.com
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

On Mon, Jul 15, 2024 at 8:02=E2=80=AFAM Liu, Yuan1 <yuan1.liu@intel.com> wr=
ote:
>
> > -----Original Message-----
> > From: Yichen Wang <yichen.wang@bytedance.com>
> > Sent: Friday, July 12, 2024 5:53 AM
> > To: Paolo Bonzini <pbonzini@redhat.com>; Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com>; Daniel P. Berrang=C3=A9 <berrange@redhat=
.com>;
> > Thomas Huth <thuth@redhat.com>; Philippe Mathieu-Daud=C3=A9
> > <philmd@linaro.org>; Peter Xu <peterx@redhat.com>; Fabiano Rosas
> > <farosas@suse.de>; Eric Blake <eblake@redhat.com>; Markus Armbruster
> > <armbru@redhat.com>; Michael S. Tsirkin <mst@redhat.com>; Cornelia Huck
> > <cohuck@redhat.com>; qemu-devel@nongnu.org
> > Cc: Hao Xiang <hao.xiang@linux.dev>; Liu, Yuan1 <yuan1.liu@intel.com>;
> > Kumar, Shivam <shivam.kumar1@nutanix.com>; Ho-Ren (Jack) Chuang
> > <horenchuang@bytedance.com>; Wang, Yichen <yichen.wang@bytedance.com>
> > Subject: [PATCH v5 01/13] meson: Introduce new instruction set enqcmd t=
o
> > the build system.
> >
> > From: Hao Xiang <hao.xiang@linux.dev>
> >
> > Enable instruction set enqcmd in build.
> >
> > Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> > Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> > ---
> >  meson.build                   | 14 ++++++++++++++
> >  meson_options.txt             |  2 ++
> >  scripts/meson-buildoptions.sh |  3 +++
> >  3 files changed, 19 insertions(+)
> >
> > diff --git a/meson.build b/meson.build
> > index 6a93da48e1..af650cfabf 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -2893,6 +2893,20 @@ config_host_data.set('CONFIG_AVX512BW_OPT',
> > get_option('avx512bw') \
> >      int main(int argc, char *argv[]) { return bar(argv[0]); }
> >    '''), error_message: 'AVX512BW not available').allowed())
> >
> > +config_host_data.set('CONFIG_DSA_OPT', get_option('enqcmd') \
> > +  .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot
> > enable ENQCMD') \
> > +  .require(cc.links('''
> > +    #include <stdint.h>
> > +    #include <cpuid.h>
> > +    #include <immintrin.h>
> > +    static int __attribute__((target("enqcmd"))) bar(void *a) {
> > +      uint64_t dst[8] =3D { 0 };
> > +      uint64_t src[8] =3D { 0 };
> > +      return _enqcmd(dst, src);
> > +    }
> > +    int main(int argc, char *argv[]) { return bar(argv[argc - 1]); }
> > +  '''), error_message: 'ENQCMD not available').allowed())
> > +
>
> How about using cpuid instruction to dynamically detect enqcmd and movdir=
64b
> instructions?
>
> My reasons are as follows
> 1. enqcmd/movdir64b and DSA devices are used together. DSA devices are dy=
namically
>    detected, so enqcmd can also dynamically detect.
>
>    Simple code for dynamically detect movdir64b and enqcmd
>    bool check_dsa_instructions(void) {
>        uint32_t eax, ebx, ecx, edx;
>        bool movedirb_enabled;
>        bool enqcmd_enabled;
>
>        cpuid(0x07, 0x0, &eax, &ebx, &ecx, &edx);
>        movedirb_enabled =3D (ecx >> 28) & 0x1;
>        if (!movedirb_enabled) {
>            return false;
>        }
>        enqcmd_enabled =3D (ecx >> 29) & 0x1;
>        if (!enqcmd_enabled) {
>            return false;
>        }
>        return true;
>     }
>     https://cdrdv2-public.intel.com/819680/architecture-instruction-set-e=
xtensions-programming-reference.pdf
>
> 2. The enqcmd/movdir64b are new instructions, I checked they are integrat=
ed into GCC10
>    However, users do not need gcc10 or higher to use two instructions.
>    Simple code to implement enqcmd
>    static inline int enqcmd(volatile void *reg, struct dsa_hw_desc *desc)
>    {
>        uint8_t retry;
>        asm volatile (".byte 0xf2, 0x0f, 0x38, 0xf8, 0x02\t\n"
>        "setz %0\t\n":"=3Dr" (retry):"a"(reg), "d"(desc));
>        return (int)retry;
>    }
>    file:///C:/Users/yliu80/Downloads/353216-data-streaming-accelerator-us=
er-guide-002.pdf
>

This is for compile time detection. So if I am understanding
correctly, we don't need this dynamic detection at meson build time,
am I right? I actually already have similar code in dynamic detection
at runtime, and I will refine that part with your suggestion above.

> >  # For both AArch64 and AArch32, detect if builtins are available.
> >  config_host_data.set('CONFIG_ARM_AES_BUILTIN', cc.compiles('''
> >      #include <arm_neon.h>
> > diff --git a/meson_options.txt b/meson_options.txt
> > index 0269fa0f16..4ed820bb8d 100644
> > --- a/meson_options.txt
> > +++ b/meson_options.txt
> > @@ -121,6 +121,8 @@ option('avx2', type: 'feature', value: 'auto',
> >         description: 'AVX2 optimizations')
> >  option('avx512bw', type: 'feature', value: 'auto',
> >         description: 'AVX512BW optimizations')
> > +option('enqcmd', type: 'feature', value: 'disabled',
> > +       description: 'ENQCMD optimizations')
> >  option('keyring', type: 'feature', value: 'auto',
> >         description: 'Linux keyring support')
> >  option('libkeyutils', type: 'feature', value: 'auto',
> > diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions=
.sh
> > index cfadb5ea86..280e117687 100644
> > --- a/scripts/meson-buildoptions.sh
> > +++ b/scripts/meson-buildoptions.sh
> > @@ -95,6 +95,7 @@ meson_options_help() {
> >    printf "%s\n" '  auth-pam        PAM access control'
> >    printf "%s\n" '  avx2            AVX2 optimizations'
> >    printf "%s\n" '  avx512bw        AVX512BW optimizations'
> > +  printf "%s\n" '  enqcmd          ENQCMD optimizations'
> >    printf "%s\n" '  blkio           libblkio block device driver'
> >    printf "%s\n" '  bochs           bochs image format support'
> >    printf "%s\n" '  bpf             eBPF support'
> > @@ -239,6 +240,8 @@ _meson_option_parse() {
> >      --disable-avx2) printf "%s" -Davx2=3Ddisabled ;;
> >      --enable-avx512bw) printf "%s" -Davx512bw=3Denabled ;;
> >      --disable-avx512bw) printf "%s" -Davx512bw=3Ddisabled ;;
> > +    --enable-enqcmd) printf "%s" -Denqcmd=3Denabled ;;
> > +    --disable-enqcmd) printf "%s" -Denqcmd=3Ddisabled ;;
> >      --enable-gcov) printf "%s" -Db_coverage=3Dtrue ;;
> >      --disable-gcov) printf "%s" -Db_coverage=3Dfalse ;;
> >      --enable-lto) printf "%s" -Db_lto=3Dtrue ;;
> > --
> > Yichen Wang
>

