Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC32C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 19:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyZyL-0003vQ-Pw; Mon, 24 Aug 2026 15:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wyZyK-0003uR-21
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 15:04:40 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wyZy9-0002zn-6m
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 15:04:31 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c160420289bso572161766b.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 12:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787598266; cv=none;
 d=google.com; s=arc-20260327;
 b=i54o4+LIiFjM/Slp26d/PQqfSu2JfxbHF1saZ9cghaTlCmlHf/WMX0OH+ORCC3wdZz
 gBWMkG0SlLRH6PCBbRfpEEQrv2DT2m3Z1NWpVRCEuwZtKQMP1ZkyaXbXlFERNP0q6UKh
 HsmgNHEhDY8Q+Qe2Y1Q0PviRo0cbhebp30N32EmD5JEeFwe8GKL9hnCKiWpzc7/e6bpe
 ISNjQncpADXh1gyeWqP5OkM1MxHZ0Baaben4VAQDqy5mXboWPhb0XBEpI7Dttg7scuFn
 4yJ1/FAT+5E5HBDgn71UEW+zYFNRxN4q7FJezrJQfOckXR9z1CPEhX8xQCkycwBaqg3Y
 UbEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=16z9UeUSeMr8MvDpTINfKr5DoOjSiqRCHnr5kWRYKAI=;
 fh=U+gPunCadylYwWuJXQyIApXFNCiyehfSfCYRAw8NMtI=;
 b=UkCWtNo4Ulb/V/ELCvgoL+LDIDyj05N6bHss2P6k2BUMAgs52EDNqkVGsJJj35ai9w
 ttksCLyeEQUCvjgy5eciOeUrQl4M8OsLpkFyJMnwUewW6jWcH40vQHibXc6TqIKiLmpW
 JbJrSZrudBzOsYMhuhGnNUbCTnASKAnRCT66VHz+R5SipwoqAFe9v1UP4LXej0XnDQ6Q
 w5nt5rfpccUw4yPomGKlg79buXQ2ZXczLtbnDlwpZtYqN/VqFcrdMNxDqP/VLveVIPot
 1E+W+RE4Ty1mfZjDY/Avf3X8lHY2GmR11tCqInJJN35WHUBCeEwwhmJvF4gynSevQOAQ
 AthQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787598266; x=1788203066; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=16z9UeUSeMr8MvDpTINfKr5DoOjSiqRCHnr5kWRYKAI=;
 b=i5IkUglTDNcfVH/m4t0ugqhQhuKKt8DgDA/yQKgqVbVj7KYGRSzPOanyo924MfbqSH
 /SD0nIDAZaDLhJMWFMl00gDwIm4bKA39LMamE/vgYgdTlvdk3VDeeijjDHPktz/Wv/tN
 tYVYrHD8eXDdBpOrbXehkvA8cqDV2zcIzbdStzvsO998Llh2g/haMh2WDSsrEggFbePG
 iYOZ96FkWw0XdgBK1zNJSe2PTURP4PevEfQGVuvYmjuI7SwQ+qMYu268EAVmi/5rC7n8
 XTUT42/hQorfiARQ56C/UyzjaVncF+H3VBRdDg7iXq2QA4cu2TKeZ1XliLaUBoArDQl9
 JKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787598266; x=1788203066;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=16z9UeUSeMr8MvDpTINfKr5DoOjSiqRCHnr5kWRYKAI=;
 b=q3MZKHwawSJ6H9nF+HDaPgIeeFKMDIelIJsAjAzUNoV4SoYFj2QO4WwT1PLkTTV3n3
 1Jcbv0DxJluy7Df43igRjv5kMNxcA7CDtZfGTDOJTYZ9M1aWlA9CwKW4urklhVGJJCJT
 MSBxIVwjz/57l/KWYSyMOqrHACkPu8zJE5iAffr7aX2wt8C+26z8+oVvfnQUz71D6brg
 u6QLyU4TchSdtcAP475/HpLFljw3KOlIO8+k/7DfwXJ1lPvrAbMy7xSgaaftYBORU7Wd
 WgU/25HyxLZWLmLkVPfxvyqhrf+fqSIvhKpWtmVgwNH7f2hsxYTvPNrGMcF0bM97V+2G
 1b0A==
X-Gm-Message-State: AFuF++lXkzjEKs2yo5/NNn3aBfhiJ1jeMKqUskrwl6u+/iwZLA9qJBAu
 QPpPkLoFYWWaI6BLiNW0AyHO+IsN+/imY4uIPJkCDiL5VdhKYKz4eWj7o2ufjckeUoC4/GIn/bZ
 6xaL3mDjL3/khXkwwRdogEHNgQ1GJ9tU=
X-Gm-Gg: AR+sD13lX6MdITjUkaJzs6fkNQhPzxJ5SDUztvz2MJSLYbxMtWwsyAY5UvJ0VS+9Qa4
 yBnzg6VZ0w7B3KhO1jZfcU941DNR42R3meVz1i+S+4wTBjkXB/lEwLPc63dvyMANbARVgHHFgCY
 4IhV8L8mPjkoEAjnmPMZ57JszTQBFlE83spBPYmRj/j1/RYIr1IxSBrDOUXTOdbbOIVhPJewKuy
 2/bdMxi+giHJUQwe+RwfMk2PXkDQ6SV+3uASBvTflM0a3ccyNP4+luM1+R6wR6SkbfsE2B2GcQS
 X3mslFoftXTF1Y1Rid1nq+wJny7KQmk7yCEdoR8DCbr6z/1+20VMSu4=
X-Received: by 2002:a17:907:a602:b0:c21:167b:47f0 with SMTP id
 a640c23a62f3a-c246a4ae088mr3658112166b.2.1787598265837; Mon, 24 Aug 2026
 12:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260823150731.896-1-luoyonggang@gmail.com>
 <20260823150731.896-13-luoyonggang@gmail.com>
 <b9f0853b-adda-457d-94e1-add9bb2a2548@oss.qualcomm.com>
In-Reply-To: <b9f0853b-adda-457d-94e1-add9bb2a2548@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 25 Aug 2026 03:04:13 +0800
X-Gm-Features: AcwNN1VpGS6HjZVALaJtNHZsMkMqA2SZOd0xqP28cZFoeWPX1v0HRwlhxBGrdRw
Message-ID: <CAE2XoE9GvZQdikiacN11ryM8o_WwffoUNViMLcQymZXo8+1FKw@mail.gmail.com>
Subject: Re: [PATCH 12/12] meson: link ARM and RISC-V into qemu-system
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>, 
 Alistair Francis <alistair.francis@wdc.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org, 
 Alexander Bulekov <alxndr@bu.edu>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Fabiano Rosas <farosas@suse.de>, Aurelien Jarno <aurelien@aurel32.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>, 
 Darren Kenny <darren.kenny@oracle.com>
Content-Type: multipart/alternative; boundary="000000000000a2ec950659cfa7a9"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000a2ec950659cfa7a9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, a lot simpler, you can pick my patches(you think is good) into your
patch series and repost as a new version, so the review process is easier.

On Tue, Aug 25, 2026 at 12:20=E2=80=AFAM Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 8/23/2026 8:07 AM, Yonggang Luo wrote:
> > - Build qemu-system (and qemu-systemw on Windows) from aarch64
> >   common/system objects plus RISC-V arch objects taken from the
> >   existing riscv64 lib.
> > - Pull 32-bit TargetInfo and 32-only boards from the arm/riscv32
> >   libs so hw/arm and target/riscv are not compiled twice.
> > - Skip linking qemu-system-{arm,aarch64,riscv32,riscv64} and the
> >   Windows *w variants; symlink those names to qemu-system so
> >   argv[0] still selects TargetInfo.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  meson.build | 156 +++++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 147 insertions(+), 9 deletions(-)
> >
> > diff --git a/meson.build b/meson.build
> > index 449d50f2983..b4f435f6a22 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -4250,6 +4250,10 @@ endif
> >
> >  traceable =3D []
> >  emulators =3D {}
> > +target_softmmu =3D {}
> > +combo_softmmu =3D ['aarch64-softmmu', 'arm-softmmu', 'riscv32-softmmu'=
,
'riscv64-softmmu']
> > +have_qemu_system_combo =3D ('aarch64-softmmu' in target_dirs
> > +                          and 'riscv64-softmmu' in target_dirs)
> >  foreach target : target_dirs
> >    config_target =3D config_target_mak[target]
> >    target_name =3D config_target['TARGET_NAME']
> > @@ -4399,20 +4403,37 @@ foreach target : target_dirs
> >                   c_args: c_args,
> >                   build_by_default: false)
> >
> > +  if target in combo_softmmu
> > +    target_softmmu +=3D {target: {
> > +      'lib': lib,
> > +      'arch_srcs': arch_srcs,
> > +      'arch_deps': arch_deps,
> > +      'c_args': c_args,
> > +      'link_args': link_args,
> > +      'target_stubs': target_stubs,
> > +      'main_rs': main_rs,
> > +      'config_target': config_target,
> > +      'target_base_arch': target_base_arch,
> > +    }}
> > +  endif
> > +
> >    if target.endswith('-softmmu')
> > -    execs =3D [{
> > -      'name': 'qemu-system-' + target_name,
> > -      'win_subsystem': 'console',
> > -      'sources': [main_rs, files('system/main.c')],
> > -      'dependencies': [sdl, target_stubs],
> > -    }]
> > -    if host_os =3D=3D 'windows' and (sdl.found() or gtk.found())
> > +    execs =3D []
> > +    if not (have_qemu_system_combo and target in combo_softmmu)
> >        execs +=3D [{
> > -        'name': 'qemu-system-' + target_name + 'w',
> > -        'win_subsystem': 'windows',
> > +        'name': 'qemu-system-' + target_name,
> > +        'win_subsystem': 'console',
> >          'sources': [main_rs, files('system/main.c')],
> >          'dependencies': [sdl, target_stubs],
> >        }]
> > +      if host_os =3D=3D 'windows' and (sdl.found() or gtk.found())
> > +        execs +=3D [{
> > +          'name': 'qemu-system-' + target_name + 'w',
> > +          'win_subsystem': 'windows',
> > +          'sources': [main_rs, files('system/main.c')],
> > +          'dependencies': [sdl, target_stubs],
> > +        }]
> > +      endif
> >      endif
> >      if get_option('fuzzing')
> >        specific_fuzz =3D specific_fuzz_ss.apply(config_target, strict:
false)
> > @@ -4481,6 +4502,123 @@ foreach target : target_dirs
> >    endforeach
> >  endforeach
> >
> > +# Combined ARM + RISC-V system emulator (32 and 64).
> > +# Common/system objects come from aarch64. RISC-V arch objects come
> > +# from the existing riscv64 lib. 32-bit TargetInfo and 32-only boards
> > +# come from the arm/riscv32 libs. Per-target qemu-system-* names are
> > +# symlinks to qemu-system (argv[0] selects TargetInfo).
> > +if have_qemu_system_combo
> > +  a64 =3D target_softmmu['aarch64-softmmu']
> > +  rv =3D target_softmmu['riscv64-softmmu']
> > +  extra_objs =3D []
> > +  target_info_def =3D files('target-info-def.c')
> > +  foreach spec : [[common_ss, common_all], [system_ss, libsystem]]
> > +    rv_src =3D spec[0].apply(rv['config_target'], strict: false)
> > +    a64_src =3D spec[0].apply(a64['config_target'], strict: false)
> > +    extra =3D []
> > +    foreach f : rv_src.sources()
> > +      if f not in a64_src.sources() and not
f.full_path().endswith('_stubs.c')
> > +        extra +=3D f
> > +      endif
> > +    endforeach
> > +    if extra.length() > 0
> > +      extra_objs +=3D spec[1].extract_objects(extra)
> > +    endif
> > +  endforeach
> > +  rv_base =3D rv['target_base_arch']
> > +  if rv_base in target_common_arch_libs
> > +    src =3D target_common_arch[rv_base].apply(rv['config_target'],
strict: false)
> > +    extra_objs +=3D
target_common_arch_libs[rv_base].extract_objects(src.sources())
> > +  endif
> > +  if rv_base in target_common_system_arch_libs
> > +    src =3D
target_common_system_arch[rv_base].apply(rv['config_target'], strict: false=
)
> > +    extra_objs +=3D
target_common_system_arch_libs[rv_base].extract_objects(src.sources())
> > +  endif
> > +  foreach pair : [['arm-softmmu', 'aarch64-softmmu'],
['riscv32-softmmu', 'riscv64-softmmu']]
> > +    t32 =3D pair[0]
> > +    t64 =3D pair[1]
> > +    if t32 in target_softmmu
> > +      extra_objs +=3D
target_softmmu[t32]['lib'].extract_objects(target_info_def)
> > +      base32 =3D target_softmmu[t32]['target_base_arch']
> > +      if base32 in hw_arch
> > +        hw32 =3D
hw_arch[base32].apply(target_softmmu[t32]['config_target'], strict: false)
> > +        hw64 =3D
hw_arch[base32].apply(target_softmmu[t64]['config_target'], strict: false)
> > +        extra_hw =3D []
> > +        foreach f : hw32.sources()
> > +          if f not in hw64.sources()
> > +            extra_hw +=3D f
> > +          endif
> > +        endforeach
> > +        if extra_hw.length() > 0
> > +          extra_objs +=3D
target_softmmu[t32]['lib'].extract_objects(extra_hw)
> > +        endif
> > +      endif
> > +    endif
> > +  endforeach
> > +  combo_objects =3D extra_objs
> > +  combo_objects +=3D a64['lib'].extract_all_objects(recursive: true)
> > +  combo_objects +=3D rv['lib'].extract_objects(rv['arch_srcs'])
> > +  combo_deps =3D a64['arch_deps'] + rv['arch_deps'] + [sdl,
a64['target_stubs'], rv['target_stubs']]
> > +  if 'arm-softmmu' in target_softmmu
> > +    combo_deps +=3D target_softmmu['arm-softmmu']['arch_deps']
> > +  endif
> > +  if 'riscv32-softmmu' in target_softmmu
> > +    combo_deps +=3D target_softmmu['riscv32-softmmu']['arch_deps']
> > +  endif
> > +  combo_execs =3D [{
> > +    'name': 'qemu-system',
> > +    'win_subsystem': 'console',
> > +  }]
> > +  if host_os =3D=3D 'windows' and (sdl.found() or gtk.found())
> > +    combo_execs +=3D [{
> > +      'name': 'qemu-systemw',
> > +      'win_subsystem': 'windows',
> > +    }]
> > +  endif
> > +  combo_exe_suffix =3D host_os =3D=3D 'windows' ? '.exe' : ''
> > +  combo_alias_py =3D 'import os, sys; src, dst =3D sys.argv[1:3];
os.path.exists(dst) and os.remove(dst); os.symlink(os.path.basename(src),
dst)'
> > +  foreach exe : combo_execs
> > +    emulator =3D executable(exe['name'], [a64['main_rs'],
files('system/main.c')],
> > +               install: true,
> > +               c_args: a64['c_args'],
> > +               dependencies: combo_deps,
> > +               objects: combo_objects,
> > +               link_depends: [block_syms, qemu_syms],
> > +               link_args: a64['link_args'],
> > +               win_subsystem: exe['win_subsystem'])
> > +    emulators +=3D {exe['name']: emulator}
> > +    traceable +=3D [{
> > +      'exe': exe['name'],
> > +      'probe-prefix': 'qemu.system.multi',
> > +    }]
> > +    foreach t : combo_softmmu
> > +      if t not in target_softmmu
> > +        continue
> > +      endif
> > +      tname =3D target_softmmu[t]['config_target']['TARGET_NAME']
> > +      if exe['name'] =3D=3D 'qemu-systemw'
> > +        alias =3D 'qemu-system-' + tname + 'w'
> > +      else
> > +        alias =3D 'qemu-system-' + tname
> > +      endif
> > +      alias_tgt =3D custom_target(alias,
> > +                                input: emulator,
> > +                                output: alias + combo_exe_suffix,
> > +                                command: [python, '-c',
combo_alias_py, '@INPUT@', '@OUTPUT@'],
> > +                                build_by_default: true,
> > +                                install: false)
> > +      emulators +=3D {alias: alias_tgt}
> > +      install_symlink(alias + combo_exe_suffix,
> > +                      pointing_to: exe['name'] + combo_exe_suffix,
> > +                      install_dir: get_option('bindir'))
> > +      traceable +=3D [{
> > +        'exe': alias,
> > +        'probe-prefix': 'qemu.system.' + tname,
> > +      }]
> > +    endforeach
> > +  endforeach
> > +endif
> > +
> >  # Other build targets
> >
> >  if get_option('plugins')
>
> Please find attached a much simpler implementation, which only requires
> a single line update as we add new targets in single-binary.
>
> Regards,
> Pierrick



--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000a2ec950659cfa7a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks, a lot simpler, you can pick my patches(you think i=
s good) into your patch series and repost as a new version, so the review p=
rocess is easier.<br><br>On Tue, Aug 25, 2026 at 12:20=E2=80=AFAM Pierrick =
Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@oss.qualcomm.com">pierrick.b=
ouvier@oss.qualcomm.com</a>&gt; wrote:<br>&gt;<br>&gt; On 8/23/2026 8:07 AM=
, Yonggang Luo wrote:<br>&gt; &gt; - Build qemu-system (and qemu-systemw on=
 Windows) from aarch64<br>&gt; &gt; =C2=A0 common/system objects plus RISC-=
V arch objects taken from the<br>&gt; &gt; =C2=A0 existing riscv64 lib.<br>=
&gt; &gt; - Pull 32-bit TargetInfo and 32-only boards from the arm/riscv32<=
br>&gt; &gt; =C2=A0 libs so hw/arm and target/riscv are not compiled twice.=
<br>&gt; &gt; - Skip linking qemu-system-{arm,aarch64,riscv32,riscv64} and =
the<br>&gt; &gt; =C2=A0 Windows *w variants; symlink those names to qemu-sy=
stem so<br>&gt; &gt; =C2=A0 argv[0] still selects TargetInfo.<br>&gt; &gt;<=
br>&gt; &gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@=
gmail.com">luoyonggang@gmail.com</a>&gt;<br>&gt; &gt; ---<br>&gt; &gt; =C2=
=A0meson.build | 156 +++++++++++++++++++++++++++++++++++++++++++++++++---<b=
r>&gt; &gt; =C2=A01 file changed, 147 insertions(+), 9 deletions(-)<br>&gt;=
 &gt;<br>&gt; &gt; diff --git a/meson.build b/meson.build<br>&gt; &gt; inde=
x 449d50f2983..b4f435f6a22 100644<br>&gt; &gt; --- a/meson.build<br>&gt; &g=
t; +++ b/meson.build<br>&gt; &gt; @@ -4250,6 +4250,10 @@ endif<br>&gt; &gt;=
<br>&gt; &gt; =C2=A0traceable =3D []<br>&gt; &gt; =C2=A0emulators =3D {}<br=
>&gt; &gt; +target_softmmu =3D {}<br>&gt; &gt; +combo_softmmu =3D [&#39;aar=
ch64-softmmu&#39;, &#39;arm-softmmu&#39;, &#39;riscv32-softmmu&#39;, &#39;r=
iscv64-softmmu&#39;]<br>&gt; &gt; +have_qemu_system_combo =3D (&#39;aarch64=
-softmmu&#39; in target_dirs<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and &#39;riscv64=
-softmmu&#39; in target_dirs)<br>&gt; &gt; =C2=A0foreach target : target_di=
rs<br>&gt; &gt; =C2=A0 =C2=A0config_target =3D config_target_mak[target]<br=
>&gt; &gt; =C2=A0 =C2=A0target_name =3D config_target[&#39;TARGET_NAME&#39;=
]<br>&gt; &gt; @@ -4399,20 +4403,37 @@ foreach target : target_dirs<br>&gt;=
 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c_args=
: c_args,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 build_by_default: false)<br>&gt; &gt;<br>&gt; &gt; + =C2=A0if ta=
rget in combo_softmmu<br>&gt; &gt; + =C2=A0 =C2=A0target_softmmu +=3D {targ=
et: {<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0&#39;lib&#39;: lib,<br>&gt; &gt; +=
 =C2=A0 =C2=A0 =C2=A0&#39;arch_srcs&#39;: arch_srcs,<br>&gt; &gt; + =C2=A0 =
=C2=A0 =C2=A0&#39;arch_deps&#39;: arch_deps,<br>&gt; &gt; + =C2=A0 =C2=A0 =
=C2=A0&#39;c_args&#39;: c_args,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0&#39;lin=
k_args&#39;: link_args,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0&#39;target_stub=
s&#39;: target_stubs,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0&#39;main_rs&#39;:=
 main_rs,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0&#39;config_target&#39;: confi=
g_target,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0&#39;target_base_arch&#39;: ta=
rget_base_arch,<br>&gt; &gt; + =C2=A0 =C2=A0}}<br>&gt; &gt; + =C2=A0endif<b=
r>&gt; &gt; +<br>&gt; &gt; =C2=A0 =C2=A0if target.endswith(&#39;-softmmu&#3=
9;)<br>&gt; &gt; - =C2=A0 =C2=A0execs =3D [{<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0&#39;name&#39;: &#39;qemu-system-&#39; + target_name,<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0&#39;win_subsystem&#39;: &#39;console&#39;,<br>&gt; &gt=
; - =C2=A0 =C2=A0 =C2=A0&#39;sources&#39;: [main_rs, files(&#39;system/main=
.c&#39;)],<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0&#39;dependencies&#39;: [sdl,=
 target_stubs],<br>&gt; &gt; - =C2=A0 =C2=A0}]<br>&gt; &gt; - =C2=A0 =C2=A0=
if host_os =3D=3D &#39;windows&#39; and (sdl.found() or gtk.found())<br>&gt=
; &gt; + =C2=A0 =C2=A0execs =3D []<br>&gt; &gt; + =C2=A0 =C2=A0if not (have=
_qemu_system_combo and target in combo_softmmu)<br>&gt; &gt; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0execs +=3D [{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;n=
ame&#39;: &#39;qemu-system-&#39; + target_name + &#39;w&#39;,<br>&gt; &gt; =
- =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;win_subsystem&#39;: &#39;windows&#39;,<br=
>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;name&#39;: &#39;qemu-system-&#=
39; + target_name,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;win_subsy=
stem&#39;: &#39;console&#39;,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&#39;sources&#39;: [main_rs, files(&#39;system/main.c&#39;)],<br>&gt; &g=
t; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;dependencies&#39;: [sdl, target_s=
tubs],<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0}]<br>&gt; &gt; + =C2=A0 =C2=
=A0 =C2=A0if host_os =3D=3D &#39;windows&#39; and (sdl.found() or gtk.found=
())<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0execs +=3D [{<br>&gt; &gt; + =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;name&#39;: &#39;qemu-system-&#39; + =
target_name + &#39;w&#39;,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&#39;win_subsystem&#39;: &#39;windows&#39;,<br>&gt; &gt; + =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&#39;sources&#39;: [main_rs, files(&#39;system/main.c&=
#39;)],<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;dependencies&=
#39;: [sdl, target_stubs],<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0}]<br>=
&gt; &gt; + =C2=A0 =C2=A0 =C2=A0endif<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0endi=
f<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0if get_option(&#39;fuzzing&#39;)<br>&gt;=
 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0specific_fuzz =3D specific_fuzz_ss.apply(c=
onfig_target, strict: false)<br>&gt; &gt; @@ -4481,6 +4502,123 @@ foreach t=
arget : target_dirs<br>&gt; &gt; =C2=A0 =C2=A0endforeach<br>&gt; &gt; =C2=
=A0endforeach<br>&gt; &gt;<br>&gt; &gt; +# Combined ARM + RISC-V system emu=
lator (32 and 64).<br>&gt; &gt; +# Common/system objects come from aarch64.=
 RISC-V arch objects come<br>&gt; &gt; +# from the existing riscv64 lib. 32=
-bit TargetInfo and 32-only boards<br>&gt; &gt; +# come from the arm/riscv3=
2 libs. Per-target qemu-system-* names are<br>&gt; &gt; +# symlinks to qemu=
-system (argv[0] selects TargetInfo).<br>&gt; &gt; +if have_qemu_system_com=
bo<br>&gt; &gt; + =C2=A0a64 =3D target_softmmu[&#39;aarch64-softmmu&#39;]<b=
r>&gt; &gt; + =C2=A0rv =3D target_softmmu[&#39;riscv64-softmmu&#39;]<br>&gt=
; &gt; + =C2=A0extra_objs =3D []<br>&gt; &gt; + =C2=A0target_info_def =3D f=
iles(&#39;target-info-def.c&#39;)<br>&gt; &gt; + =C2=A0foreach spec : [[com=
mon_ss, common_all], [system_ss, libsystem]]<br>&gt; &gt; + =C2=A0 =C2=A0rv=
_src =3D spec[0].apply(rv[&#39;config_target&#39;], strict: false)<br>&gt; =
&gt; + =C2=A0 =C2=A0a64_src =3D spec[0].apply(a64[&#39;config_target&#39;],=
 strict: false)<br>&gt; &gt; + =C2=A0 =C2=A0extra =3D []<br>&gt; &gt; + =C2=
=A0 =C2=A0foreach f : rv_src.sources()<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0i=
f f not in a64_src.sources() and not f.full_path().endswith(&#39;_stubs.c&#=
39;)<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0extra +=3D f<br>&gt; &gt; + =
=C2=A0 =C2=A0 =C2=A0endif<br>&gt; &gt; + =C2=A0 =C2=A0endforeach<br>&gt; &g=
t; + =C2=A0 =C2=A0if extra.length() &gt; 0<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=
=A0extra_objs +=3D spec[1].extract_objects(extra)<br>&gt; &gt; + =C2=A0 =C2=
=A0endif<br>&gt; &gt; + =C2=A0endforeach<br>&gt; &gt; + =C2=A0rv_base =3D r=
v[&#39;target_base_arch&#39;]<br>&gt; &gt; + =C2=A0if rv_base in target_com=
mon_arch_libs<br>&gt; &gt; + =C2=A0 =C2=A0src =3D target_common_arch[rv_bas=
e].apply(rv[&#39;config_target&#39;], strict: false)<br>&gt; &gt; + =C2=A0 =
=C2=A0extra_objs +=3D target_common_arch_libs[rv_base].extract_objects(src.=
sources())<br>&gt; &gt; + =C2=A0endif<br>&gt; &gt; + =C2=A0if rv_base in ta=
rget_common_system_arch_libs<br>&gt; &gt; + =C2=A0 =C2=A0src =3D target_com=
mon_system_arch[rv_base].apply(rv[&#39;config_target&#39;], strict: false)<=
br>&gt; &gt; + =C2=A0 =C2=A0extra_objs +=3D target_common_system_arch_libs[=
rv_base].extract_objects(src.sources())<br>&gt; &gt; + =C2=A0endif<br>&gt; =
&gt; + =C2=A0foreach pair : [[&#39;arm-softmmu&#39;, &#39;aarch64-softmmu&#=
39;], [&#39;riscv32-softmmu&#39;, &#39;riscv64-softmmu&#39;]]<br>&gt; &gt; =
+ =C2=A0 =C2=A0t32 =3D pair[0]<br>&gt; &gt; + =C2=A0 =C2=A0t64 =3D pair[1]<=
br>&gt; &gt; + =C2=A0 =C2=A0if t32 in target_softmmu<br>&gt; &gt; + =C2=A0 =
=C2=A0 =C2=A0extra_objs +=3D target_softmmu[t32][&#39;lib&#39;].extract_obj=
ects(target_info_def)<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0base32 =3D target_=
softmmu[t32][&#39;target_base_arch&#39;]<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=
=A0if base32 in hw_arch<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0hw32 =3D =
hw_arch[base32].apply(target_softmmu[t32][&#39;config_target&#39;], strict:=
 false)<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0hw64 =3D hw_arch[base32].=
apply(target_softmmu[t64][&#39;config_target&#39;], strict: false)<br>&gt; =
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0extra_hw =3D []<br>&gt; &gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0foreach f : hw32.sources()<br>&gt; &gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0if f not in hw64.sources()<br>&gt; &gt; + =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0extra_hw +=3D f<br>&gt; &gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0endif<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0endfore=
ach<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0if extra_hw.length() &gt; 0<b=
r>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0extra_objs +=3D target_soft=
mmu[t32][&#39;lib&#39;].extract_objects(extra_hw)<br>&gt; &gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0endif<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0endif<br>&gt; &gt=
; + =C2=A0 =C2=A0endif<br>&gt; &gt; + =C2=A0endforeach<br>&gt; &gt; + =C2=
=A0combo_objects =3D extra_objs<br>&gt; &gt; + =C2=A0combo_objects +=3D a64=
[&#39;lib&#39;].extract_all_objects(recursive: true)<br>&gt; &gt; + =C2=A0c=
ombo_objects +=3D rv[&#39;lib&#39;].extract_objects(rv[&#39;arch_srcs&#39;]=
)<br>&gt; &gt; + =C2=A0combo_deps =3D a64[&#39;arch_deps&#39;] + rv[&#39;ar=
ch_deps&#39;] + [sdl, a64[&#39;target_stubs&#39;], rv[&#39;target_stubs&#39=
;]]<br>&gt; &gt; + =C2=A0if &#39;arm-softmmu&#39; in target_softmmu<br>&gt;=
 &gt; + =C2=A0 =C2=A0combo_deps +=3D target_softmmu[&#39;arm-softmmu&#39;][=
&#39;arch_deps&#39;]<br>&gt; &gt; + =C2=A0endif<br>&gt; &gt; + =C2=A0if &#3=
9;riscv32-softmmu&#39; in target_softmmu<br>&gt; &gt; + =C2=A0 =C2=A0combo_=
deps +=3D target_softmmu[&#39;riscv32-softmmu&#39;][&#39;arch_deps&#39;]<br=
>&gt; &gt; + =C2=A0endif<br>&gt; &gt; + =C2=A0combo_execs =3D [{<br>&gt; &g=
t; + =C2=A0 =C2=A0&#39;name&#39;: &#39;qemu-system&#39;,<br>&gt; &gt; + =C2=
=A0 =C2=A0&#39;win_subsystem&#39;: &#39;console&#39;,<br>&gt; &gt; + =C2=A0=
}]<br>&gt; &gt; + =C2=A0if host_os =3D=3D &#39;windows&#39; and (sdl.found(=
) or gtk.found())<br>&gt; &gt; + =C2=A0 =C2=A0combo_execs +=3D [{<br>&gt; &=
gt; + =C2=A0 =C2=A0 =C2=A0&#39;name&#39;: &#39;qemu-systemw&#39;,<br>&gt; &=
gt; + =C2=A0 =C2=A0 =C2=A0&#39;win_subsystem&#39;: &#39;windows&#39;,<br>&g=
t; &gt; + =C2=A0 =C2=A0}]<br>&gt; &gt; + =C2=A0endif<br>&gt; &gt; + =C2=A0c=
ombo_exe_suffix =3D host_os =3D=3D &#39;windows&#39; ? &#39;.exe&#39; : &#3=
9;&#39;<br>&gt; &gt; + =C2=A0combo_alias_py =3D &#39;import os, sys; src, d=
st =3D sys.argv[1:3]; os.path.exists(dst) and os.remove(dst); os.symlink(os=
.path.basename(src), dst)&#39;<br>&gt; &gt; + =C2=A0foreach exe : combo_exe=
cs<br>&gt; &gt; + =C2=A0 =C2=A0emulator =3D executable(exe[&#39;name&#39;],=
 [a64[&#39;main_rs&#39;], files(&#39;system/main.c&#39;)],<br>&gt; &gt; + =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 install: true,<br>&gt; &gt=
; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c_args: a64[&#39;c_arg=
s&#39;],<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 de=
pendencies: combo_deps,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 objects: combo_objects,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 link_depends: [block_syms, qemu_syms],<br>&gt; =
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 link_args: a64[&#39=
;link_args&#39;],<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 win_subsystem: exe[&#39;win_subsystem&#39;])<br>&gt; &gt; + =C2=A0 =
=C2=A0emulators +=3D {exe[&#39;name&#39;]: emulator}<br>&gt; &gt; + =C2=A0 =
=C2=A0traceable +=3D [{<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0&#39;exe&#39;: e=
xe[&#39;name&#39;],<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0&#39;probe-prefix&#3=
9;: &#39;qemu.system.multi&#39;,<br>&gt; &gt; + =C2=A0 =C2=A0}]<br>&gt; &gt=
; + =C2=A0 =C2=A0foreach t : combo_softmmu<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=
=A0if t not in target_softmmu<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0con=
tinue<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0endif<br>&gt; &gt; + =C2=A0 =C2=A0=
 =C2=A0tname =3D target_softmmu[t][&#39;config_target&#39;][&#39;TARGET_NAM=
E&#39;]<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0if exe[&#39;name&#39;] =3D=3D &#=
39;qemu-systemw&#39;<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0alias =3D &#=
39;qemu-system-&#39; + tname + &#39;w&#39;<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=
=A0else<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0alias =3D &#39;qemu-syste=
m-&#39; + tname<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0endif<br>&gt; &gt; + =C2=
=A0 =C2=A0 =C2=A0alias_tgt =3D custom_target(alias,<br>&gt; &gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input: emulator,<br>&gt; &gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0output: alias + combo_exe_suffix,<br>&gt; &gt; +=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0command: [python, &#39;-c&#39;, combo=
_alias_py, &#39;@INPUT@&#39;, &#39;@OUTPUT@&#39;],<br>&gt; &gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build_by_default: true,<br>&gt; &gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0install: false)<br>&gt; &gt; + =C2=A0 =C2=
=A0 =C2=A0emulators +=3D {alias: alias_tgt}<br>&gt; &gt; + =C2=A0 =C2=A0 =
=C2=A0install_symlink(alias + combo_exe_suffix,<br>&gt; &gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pointing_=
to: exe[&#39;name&#39;] + combo_exe_suffix,<br>&gt; &gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0install_dir: =
get_option(&#39;bindir&#39;))<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0traceable =
+=3D [{<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;exe&#39;: alias,<br>=
&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;probe-prefix&#39;: &#39;qemu.sy=
stem.&#39; + tname,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0}]<br>&gt; &gt; + =
=C2=A0 =C2=A0endforeach<br>&gt; &gt; + =C2=A0endforeach<br>&gt; &gt; +endif=
<br>&gt; &gt; +<br>&gt; &gt; =C2=A0# Other build targets<br>&gt; &gt;<br>&g=
t; &gt; =C2=A0if get_option(&#39;plugins&#39;)<br>&gt;<br>&gt; Please find =
attached a much simpler implementation, which only requires<br>&gt; a singl=
e line update as we add new targets in single-binary.<br>&gt;<br>&gt; Regar=
ds,<br>&gt; Pierrick<br><br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<=
br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div>

--000000000000a2ec950659cfa7a9--

