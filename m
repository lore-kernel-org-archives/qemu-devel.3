Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44EFC88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 17:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x55N2-0000T8-Pd; Fri, 11 Sep 2026 13:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x55N1-0000Sj-PV
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 13:49:03 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x55Mz-0003rD-SI
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 13:49:03 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-482ea739de2so796238f8f.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 10:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789148940; x=1789753740; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zzaGYJbUWOgbJ4+qQwOdw2KwIwcRH2WcLC7ltKieHyE=;
 b=KjRTGX6bkV0FBUlRVywLOExTz/YBUlFMoVErQ16EWyvtwGf4nkc+KAOPH6Snt3pm33
 Ma1U53gEdqQ6p6xh6JPFxNjr8tQJ7/Xodn27/tSsy13lT4avoh4xLVTBD4nBl/Cvq0CX
 ypPUOH4w66n3+oKo6LkvoO05QOFsOCuTkSqkau8YAsCPgxyfMGTXZrzWqxkdzSIBH1kn
 Lcnc0gd/AaDZ6E60DqNqSQlXEb7gVthXhaqD3oibqvc/SxeWSvJDLrvUFr5rwi3LniTw
 5QwN3ha1Ip4XDniHW5gzRzGkemcW0PtqgrX/bA3VpCa1GM24axP3tWEQZta3d8wh/nQK
 xVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789148940; x=1789753740;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zzaGYJbUWOgbJ4+qQwOdw2KwIwcRH2WcLC7ltKieHyE=;
 b=felvdRhl3UW9GhM2j6SSrS3IL1yZypNwt0OY+xuDu9tWgClmT7DyQxtDPBaZ/UHjeU
 3M+C9kZxTzUx0PkcXe+uh/XlcaOHxELETI+FWrIN20R9WvWQymXEUqQyLy4EFQKoLu/o
 y0x5eiXG0SIzXhwqI8UF7A8HIOAwfSk52maEn2zVsMdLwXwlA9s9gznND/K2eXtCPYX6
 PLLsPrf3MKZwIaBVYnUZml0C40Xlw2XlzDFA2vsGCpFHIuPfKlfGXdh2d9eDp4EbM0ew
 zkVE193kFS8ToBUW4QRBNQ8dIXbD/9AKBA4jtOX11X6ho0bzA2JedSWR1v7XEcqPTg5j
 kWng==
X-Gm-Message-State: AFuF++mvg0Spwmji/Tmpjp5I6lXkdp6P0gLtr/MNj2uL89ExbP8kkm9/
 NidUnX908ssyOWfQNfKYJ0lFTDBj6eh3mYw/YYMOl3PhWunU6ciy431BfOqjI3zgXAg=
X-Gm-Gg: AYBFou0LF4bqnGzF8FZoCLkJAy9+OjpfUk1L6eeojKtdMEvapPaPrK8xFAOwJKNj72c
 oS9efWj9Vj9/U6DdZiQdxhJCRkqE51Ze48GAOeiM8oDQt8CgNBSoOkCS5b3MiB6gOmmegSvCHjC
 Xu2E+IqL1vl5zbNS9fVLi032+U4cvg1bdk+B0n4F717UWDyOpO4kGnYAk1ty85zyU1hWFyDjJuT
 rPUfZbeRizPk2Bz1WT1/y0b7tv1OnUSjlusdOeu+gwpYfBP/jP2nNFIh9u7zMXWQNfLTfUCrZH2
 +FC0Z59a5d1q1iQxLn+g10LW/KWS7ZsokRna2/RejmMqczYrknKpSk55VyYYcBF4+la2BeUFv3e
 EC9ZmQYgq6xDQknMsp0DgpTGzQSLSWclY5JNJol2xpxzgddwhlYR+XenCdCXyl32zIKZU5YKMfs
 66oOOk1ZxiX2BXpMhrq5WmelsshBAcdiz4rmzB+CEoaiLbCkXBWi9L1ttRDTuFhxPWql8m914=
X-Received: by 2002:adf:f583:0:b0:485:8c9e:2e30 with SMTP id
 ffacd0b85a97d-486eb309114mr4753585f8f.23.1789148939823; 
 Fri, 11 Sep 2026 10:48:59 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33ea60sm7785034f8f.17.2026.09.11.10.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 10:48:58 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C55325F856;
 Fri, 11 Sep 2026 18:48:57 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Aniket Sahu <asahu1x@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Jared Rossi <jrossi@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>,  Joshua Daley <jdaley@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PULL 102/105] configure: remove cross_cc and gdb detection logic
In-Reply-To: <dab85c9c-4718-48d1-a343-c2e6b5f8e24f@linux.ibm.com> (Eric
 Farman's message of "Fri, 11 Sep 2026 12:16:23 -0400")
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-103-alex.bennee@linaro.org>
 <dab85c9c-4718-48d1-a343-c2e6b5f8e24f@linux.ibm.com>
User-Agent: mu4e 1.14.4-pre2; emacs 30.1
Date: Fri, 11 Sep 2026 18:48:57 +0100
Message-ID: <87a4pn8yra.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

Eric Farman <farman@linux.ibm.com> writes:

> On 9/4/26 8:45 AM, Alex Benn=C3=A9e wrote:
>> From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> We have now implemented the same in meson directly, so no need to
>> keep
>> it on configure side. Also, we have no more Makefile consumers, so we
>> don't need to export all those variables anymore.
>
> (Thanks, Josh, for the bisect work that led to blaming this commit...)
>
> ...snip...
>
>> @@ -1659,48 +1299,6 @@ fi
>>     echo "# Automatically generated by configure - do not modify" >
>> Makefile.prereqs
>>   -# Mac OS X ships with a broken assembler
>> -if have_target i386-softmmu x86_64-softmmu && \
>> -        test "$host_os" !=3D "darwin" && test "$host_os" !=3D "sunos" &=
& \
>> -        test "$host_os" !=3D "haiku" && \
>> -        probe_target_compiler i386-softmmu; then
>> -    subdirs=3D"$subdirs pc-bios/optionrom"
>> -    config_mak=3Dpc-bios/optionrom/config.mak
>> -    echo "# Automatically generated by configure - do not modify" > $co=
nfig_mak
>> -    echo "TOPSRC_DIR=3D$source_path" >> $config_mak
>> -    write_target_makefile >> $config_mak
>> -fi
>> -
>> -if have_target ppc-softmmu ppc64-softmmu && \
>> -        probe_target_compiler ppc-softmmu; then
>> -    subdirs=3D"$subdirs pc-bios/vof"
>> -    config_mak=3Dpc-bios/vof/config.mak
>> -    echo "# Automatically generated by configure - do not modify" > $co=
nfig_mak
>> -    echo "SRC_DIR=3D$source_path/pc-bios/vof" >> $config_mak
>> -    write_target_makefile >> $config_mak
>> -fi
>> -
>> -# Only build s390-ccw bios if the compiler has -march=3Dz900 or -march=
=3Dz10
>> -# (which is the lowest architecture level that Clang supports)
>> -if have_target s390x-softmmu && probe_target_compiler s390x-softmmu && \
>> -    GIT=3Dgit "$source_path/scripts/git-submodule.sh" "$git_submodules_=
action" roms/SLOF >> config.log 2>&1; then
>> -  write_c_skeleton
>> -  do_compiler "$target_cc" $target_cc_cflags -march=3Dz900 -o $TMPO -c =
$TMPC
>> -  has_z900=3D$?
>> -  if [ $has_z900 =3D 0 ] || do_compiler "$target_cc" $target_cc_cflags =
-march=3Dz10 -msoft-float -Werror -o $TMPO -c $TMPC; then
>> -    if [ $has_z900 !=3D 0 ]; then
>> -      echo "WARNING: Your compiler does not support the z900!"
>> -      echo "         The s390-ccw bios will only work with guest CPUs >=
=3D z10."
>> -    fi
>> -    subdirs=3D"$subdirs pc-bios/s390-ccw"
>> -    config_mak=3Dpc-bios/s390-ccw/config-host.mak
>> -    echo "# Automatically generated by configure - do not modify" > $co=
nfig_mak
>> -    echo "SRC_PATH=3D$source_path/pc-bios/s390-ccw" >> $config_mak
>> -    echo "GIT_SUBMODULES_ACTION=3D$git_submodules_action" >> $config_mak
>> -    write_target_makefile >> $config_mak
>> -  fi
>> -fi
>> -
>
> Now we're unable to build the s390 bios used for boot (no idea about
> the state of the other items in pc-bios that were removed here too).
> Surely reverting this hunk (and its dependencies) won't be great based
> on the size of this pull request, so what's the preferred solution
> here?

Thanks for pointing this out. I hadn't noticed the issue as I guess we
don't build firmware in the CI. That said on my current tree:

 cd /home/alex/lsrc/qemu.git/builds/all/pc-bios/s390-ccw
 make
 -Wno-stringop-overflow detected
 -fno-stack-protector detected
 -Wno-array-bounds detected
 -Wno-gnu detected
 -march=3Dz900 detected
 Assembling start.o
 Compiling main.o
 Compiling bootmap.o
 Compiling jump2ipl.o
 Compiling sclp.o
 Compiling menu.o
 Compiling netmain.o
 Compiling virtio.o
 Compiling virtio-net.o
 Compiling virtio-scsi.o
 Compiling virtio-blkdev.o
 Compiling cio.o
 Compiling dasd-ipl.o
 Compiling virtio-ccw.o
 Compiling clp.o
 Compiling pci.o
 Compiling virtio-pci.o
 Compiling secure-ipl.o
 Linking s390-ccw.elf
 Stripping s390-ccw.elf into s390-ccw.img

So it seems to be working. How do you usually invoke the build?

> Fearing the worst, I started converting to use meson directly (which
> is probably a noble goal anyway). I still don't have a workable image,
> as inheriting the common meson cc/ld flags exposes a bunch of other
> problems. Will keep poking, but I'd like to know if there's an
> easier/better option here?

I suspect the easiest way would be to move the rom specific cross
compiler detection into a configure script within pc-bios. Paolo wdyt?


>
> Thanks,
> Eric

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

