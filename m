Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460CFCCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 14:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDO9Z-0006on-Qj; Mon, 27 Oct 2025 10:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1vDO9V-0006ng-FV
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:24:53 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1vDO9K-0005Ww-Rq
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:24:53 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b6a42604093so169624a12.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 07:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761575077; x=1762179877; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nPBYYxTVaVn45iIHxdTVVP0QX7bl3gEBjFn9EmLDRyY=;
 b=kDCUqnBoE9n+lX5c//PD23JjFoYepUxhMx65/Qnccf+c3poAZ2DW5qAgz3iesS5ZPg
 5DCr45NfANjINStu8aXcARl8iccQWhO7prkijsywsZO+SAqK3EcJceZhQJl50Frx8565
 W7YUFL1b+q1iHAQ6CpY1U7th4fvy16mKWCwRFA1slLWotbXkjxvkVhs2G8lcHH6UGkpA
 cKgYuPUJQI+/FqYM0dCYGA7O4UK24kABD6SVlENatxPs035NAUiOBc7TzbaE8RFDKqxv
 QFzBmRinODlnxlShc79fWwQM31fUlW/e5dn5sxLkCfiYdxEF9p4+WWMLweTEAmYsBTJF
 1Vzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761575077; x=1762179877;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nPBYYxTVaVn45iIHxdTVVP0QX7bl3gEBjFn9EmLDRyY=;
 b=sTfmEtywKwwyj0iI4wKSR0YiyRoAY68rT4MA5ARctZ/KgoQo4ixutnPZmraraOMbCJ
 MFYttEUmijXYeB/Wdbp1mx8WhMG4JarmPrl+046qIHEqr1ecqfBlGtOqmq5OUz8d8ri2
 c6eDk/KMXsw+ZD0KI5o7Rsd9YM2ctYRNRAMkGZhpiUNRVxXtIoJXCYtYT1sbPl4fTLFC
 pe54NIRYuOjG16ltFTsv2su4jVzFQWaej0DjxwsuMol/jmzJ7Y/MvY9OX9XJMDlwdixO
 Jlmiyf1VrKddXF6gQLQx9YE0WTN8/aEublVuTS4fB7J1/05O2SJ0a+ohNi97EhmtT5Zx
 uOwA==
X-Gm-Message-State: AOJu0YzAJYzHgcTGdoKiQGapR7wBpL0KW7F2H5k1JND7FOveY7ZTjlhx
 my6HdNbaBLEqL3uScqZFvryDe5GUsHQXrLKOYl4zBWMLmK0ChZJpGLEc
X-Gm-Gg: ASbGncsFX/jr65Kk1RbCjSgGCtS53OSk3PIJXzwHc2YSzBeeZSBKx2M14M6pZ26Rjta
 zc9HF+TdsAWsg2d+9Fwj/y7IwJF6NapQPTQ5lPXpGJczfBVlGQ6+NQoVQkpJ5ECyMfdCU64Tc9p
 Ia358oZAOwhfuPazG5KCRjDUid2s1P10Z4/kyHKMSs5cSGnVsjHMOjZf3/fHAvueQFQ/UlIZbUN
 G6bnXGotlCpKB/6NyaBifoDyNhILR5RcYCCA5XqR1EDvBOlsNLOxUuCBFY4B79TXU1FFcW6zQpv
 mnfY3Xoqv24VGOsIqTYRQbuWe7cIuOID7LhYy3xZk6U5uv/RQiI6sWtygS9xn3f3f+lZdBdyAyj
 sBp2Afkx1/x+P3oQ2cN6vSElVjfM0p27ffXIKDgTK0XEpyDi8/kJLVzTng9lhgeVHypsLbrSihd
 ixxFhzzK6jmGnQOXIGc12dpusU2zRrzbbziiEzfsdtrx0ZkZudoLJ+PkRS
X-Google-Smtp-Source: AGHT+IG1NCkw51/TEoqt6D6VxGdQViLBBbzZnJyAFE3YadWPD7VgVLhKge9ItzkSPKNW6sjHVEEsoA==
X-Received: by 2002:a17:903:1acf:b0:27e:e96a:4bf with SMTP id
 d9443c01a7336-294cb35d603mr813845ad.2.1761575077205; 
 Mon, 27 Oct 2025 07:24:37 -0700 (PDT)
Received: from ?IPV6:2402:e280:2177:35:a77f:15f7:4845:1af9?
 ([2402:e280:2177:35:a77f:15f7:4845:1af9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498d09958sm83664495ad.24.2025.10.27.07.24.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 07:24:36 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------0nSzWO5r5GyxmFJwZZI5wKVu"
Message-ID: <38673ed9-4690-472b-9e0f-c8a736247097@gmail.com>
Date: Mon, 27 Oct 2025 19:54:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/13] Pegasos2 clean up and pegasos1 emulation
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1760798392.git.balaton@eik.bme.hu>
 <CAJOT6qN-n7LpVnLO-5CpOUF8z-j1Ogi=6cJBvvKZc-Eh5tHVzA@mail.gmail.com>
 <a410ac54-d1dc-aa67-d1d7-690b2495e9df@eik.bme.hu>
 <CAJOT6qN4QYRdNR-oQV8JSv_074umiHB==_dyemX01+FsNiqPOQ@mail.gmail.com>
 <c7daf4e7-50d3-263c-4fa2-35947e2d3267@eik.bme.hu>
 <26f74e6c-a89f-4be0-aa6c-78ad88e2cba3@gmail.com>
 <993819c9-cf87-ec91-31ac-f8988c8d3d67@eik.bme.hu>
Content-Language: en-US
From: Yogesh Vyas <yvyas1991@gmail.com>
In-Reply-To: <993819c9-cf87-ec91-31ac-f8988c8d3d67@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=yvyas1991@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

This is a multi-part message in MIME format.
--------------0nSzWO5r5GyxmFJwZZI5wKVu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/26/25 10:15 PM, BALATON Zoltan wrote:
> On Sun, 26 Oct 2025, Yogesh Vyas wrote:
>
>>
>> On 10/26/25 4:39 PM, BALATON Zoltan wrote:
>>> On Sun, 26 Oct 2025, Yogesh Vyas wrote:
>>>> On Sun, Oct 19, 2025 at 5:37 PM BALATON Zoltan <balaton@eik.bme.hu> 
>>>> wrote:
>>>>> On Sun, 19 Oct 2025, Yogesh Vyas wrote:
>>>>>> When I run QEMU with the ROM option, the machine boots 
>>>>>> successfully with
>>>>>> the below command:
>>>>>>
>>>>>> qemu-system-ppc64 -machine pegasos2 -bios pegasos2.rom \
>>>>>>                  -cdrom debian-8.11.0-powerpc-netinst.iso \
>>>>>>                  -device VGA,romfile="" -serial stdio
>>>>>>
>>>>>> However, when I try to boot the machine without the ROM using 
>>>>>> VOF, the
>>>>>> machine does not come up and no logs appear on stdout:
>>>>>>
>>>>>> qemu-system-ppc64 -machine pegasos2 -serial stdio \
>>>>>>                  -kernel vmlinuz-chrp.initrd -append "---" \
>>>>>>                  -cdrom debian-8.11.0-powerpc-netinst.iso
>>>>>>
>>>>>> Please let me know if I am missing any parameters or setup 
>>>>>> required for
>>>>>> booting via VOF on Pegasos2.
>>>>>>
>>>>>> Documentation referred: qemu/docs/system/ppc/amigang.rst
>>>>>
>>>>> Maybe you did not use the right vmlinuz-chrp.initrd. Pegasos2 is a 
>>>>> 32 bit
>>>>> machine so you need /install/powerpc/vmlinuz-chrp.initrd for it 
>>>>> (see in
>>>>> the /install/pegasos script that is used with firmware). Even if 
>>>>> you call
>>>>> it from qemu-system-ppc64 which includes both 32 bit and 64 bit 
>>>>> machines
>>>>> but does not make 32 bit machines 64 bit so you still need the 32 
>>>>> bit OS.
>>>>>
>>>>>
>>>> Hi Balaton,
>>>> I am using 32bit images only and looks like VOF boot works with the 
>>>> distro
>>>> provided Qemu (both ppc and pp64), however doesn't work with 
>>>> upstream Qemu
>>>> for VOF.
>>>
>>> That's odd, it works for me with QEMU master so I can't reproduce this.
>>>
>>>> yogi@fedora:~/work/images$ file vmlinuz-chrp.initrd
>>>> vmlinuz-chrp.initrd: ELF 32-bit MSB executable, PowerPC or cisco 4500,
>>>> version 1 (SYSV), statically linked, not stripped
>>>
>>> The file command says 32-bit for both 
>>> /install/powerpc/vmlinuz-chrp.initrd and 
>>> /install/powerpc64/vmlinuz-chrp.initrd but only the first one should 
>>> work. Can you double check you have the right vmlinuz-chrp.initrd 
>>> file? But if you say the same file works with 9.2.4 I have no idea 
>>> why. I see these files on the CD
>>>
>>>   9301172 Jun 19  2018 /install/powerpc/vmlinuz-chrp.initrd
>>>  10534888 Jun 19  2018 /install/powerpc64/vmlinuz-chrp.initrd
>>
>>
>> I am also using the same file:
>>
>> yogi@fedora:~/work/images$ ls -lrt vmlinuz-chrp.initrd
>> -r--r--r--. 1 yogi yogi 9301172 Oct 18 23:50 vmlinuz-chrp.initrd
>>
>>>
>>> File command says:
>>>
>>> vmlinuz-chrp.initrd:   ELF 32-bit MSB executable, PowerPC or cisco 
>>> 4500, version 1 (SYSV), statically linked, not stripped
>>> vmlinuz-chrp.initrd64: ELF 32-bit MSB executable, PowerPC or cisco 
>>> 4500, version 1 (SYSV), statically linked, not stripped
>>>
>>> but only the first from the powerpc directory is supposed to work 
>>> and it does boot for me with QEMU master. You can also check 
>>> following the other way described in 
>>> qemu/docs/system/ppc/amigang.rst using -bios pegasos2.rom which 
>>> loads the correct image from the CD. Does that work?
>>
>> Yes, I had mentioned it in my first mail that ROM option works as 
>> expected. It is only an issue when using VOF with upstream Qemu.
>
> Or if you suspect it's a VOF issue you can try -trace enable="vof*"
>
Hi Balaton,

As suggested, I tried both options in upstream:
yogi@fedora:~/work/git/fork/qemu/build$ ./qemu-system-ppc -machine 
pegasos2 -serial stdio -kernel ~/work/images/vmlinuz-chrp.initrd -append 
"---" -cdrom ~/work/images/debian-8.11.0-powerpc-netinst.iso -d 
guest_errors -trace enable="vof*"

I could see the below trace and the error message:
  vof_getproplen ph=0x13 "subsystem-vendor-id" => len=4
vof_getprop ph=0x13 "subsystem-vendor-id" => len=4 [00001100]
vof_getproplen ph=0x13 "reg" => len=20
vof_getprop ph=0x13 "reg" => len=20 [00000000 00000000 00000000 00000000 
00000000]
vof_write ih=0x2 [22] "Device tree strings 0x"
vof_write ih=0x2 [8] "01b0d000"
vof_write ih=0x2 [6] " -> 0x"
vof_write ih=0x2 [8] "01b0d405"
vof_write ih=0x2 [2] "
"
vof_write ih=0x2 [22] "Device tree struct  0x"
vof_write ih=0x2 [8] "01b0e000"
vof_write ih=0x2 [6] " -> 0x"
vof_write ih=0x2 [8] "01b0f000"
vof_write ih=0x2 [2] "
"
vof_getprop ph=0x3 "stdin" => len=4 [00000001]
vof_write ih=0x2 [18] "Calling quiesce..."
vof_write ih=0x2 [2] "
"
vof_claimed 0x0..0xd80 size=0xd80
vof_claimed 0x8000..0x10000 size=0x8000
vof_claimed 0x400000..0xcd8dfc size=0x8d8dfc
vof_claimed 0xd00000..0x15a1ec0 size=0x8a1ec0
vof_claimed 0x15a2000..0x1b0b90d size=0x56990d
vof_claimed 0x1b0c000..0x1c0c000 size=0x100000
vof_claimed 0x1ffff000..0x1ffff014 size=0x14
vof_write ih=0x2 [24] "returning from prom_init"
vof_write ih=0x2 [2] "
"
Trying to read invalid spr 1012 (0x3f4) at c0013f48

Regards,

Yogesh Vyas

> Regards,
> BALATON Zoltan
--------------0nSzWO5r5GyxmFJwZZI5wKVu
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/26/25 10:15 PM, BALATON Zoltan
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:993819c9-cf87-ec91-31ac-f8988c8d3d67@eik.bme.hu">On Sun,
      26 Oct 2025, Yogesh Vyas wrote:
      <br>
      <br>
      <blockquote type="cite">
        <br>
        On 10/26/25 4:39 PM, BALATON Zoltan wrote:
        <br>
        <blockquote type="cite">On Sun, 26 Oct 2025, Yogesh Vyas wrote:
          <br>
          <blockquote type="cite">On Sun, Oct 19, 2025 at 5:37 PM
            BALATON Zoltan <a class="moz-txt-link-rfc2396E" href="mailto:balaton@eik.bme.hu">&lt;balaton@eik.bme.hu&gt;</a> wrote:
            <br>
            <blockquote type="cite">On Sun, 19 Oct 2025, Yogesh Vyas
              wrote:
              <br>
              <blockquote type="cite">When I run QEMU with the ROM
                option, the machine boots successfully with
                <br>
                the below command:
                <br>
                <br>
                qemu-system-ppc64 -machine pegasos2 -bios pegasos2.rom \
                <br>
                                 -cdrom
                debian-8.11.0-powerpc-netinst.iso \
                <br>
                                 -device VGA,romfile="" -serial stdio
                <br>
                <br>
                However, when I try to boot the machine without the ROM
                using VOF, the
                <br>
                machine does not come up and no logs appear on stdout:
                <br>
                <br>
                qemu-system-ppc64 -machine pegasos2 -serial stdio \
                <br>
                                 -kernel vmlinuz-chrp.initrd -append
                "---" \
                <br>
                                 -cdrom
                debian-8.11.0-powerpc-netinst.iso
                <br>
                <br>
                Please let me know if I am missing any parameters or
                setup required for
                <br>
                booting via VOF on Pegasos2.
                <br>
                <br>
                Documentation referred: qemu/docs/system/ppc/amigang.rst
                <br>
              </blockquote>
              <br>
              Maybe you did not use the right vmlinuz-chrp.initrd.
              Pegasos2 is a 32 bit
              <br>
              machine so you need /install/powerpc/vmlinuz-chrp.initrd
              for it (see in
              <br>
              the /install/pegasos script that is used with firmware).
              Even if you call
              <br>
              it from qemu-system-ppc64 which includes both 32 bit and
              64 bit machines
              <br>
              but does not make 32 bit machines 64 bit so you still need
              the 32 bit OS.
              <br>
              <br>
              <br>
            </blockquote>
            Hi Balaton,
            <br>
            I am using 32bit images only and looks like VOF boot works
            with the distro
            <br>
            provided Qemu (both ppc and pp64), however doesn't work with
            upstream Qemu
            <br>
            for VOF.
            <br>
          </blockquote>
          <br>
          That's odd, it works for me with QEMU master so I can't
          reproduce this.
          <br>
          <br>
          <blockquote type="cite">yogi@fedora:~/work/images$ file
            vmlinuz-chrp.initrd
            <br>
            vmlinuz-chrp.initrd: ELF 32-bit MSB executable, PowerPC or
            cisco 4500,
            <br>
            version 1 (SYSV), statically linked, not stripped
            <br>
          </blockquote>
          <br>
          The file command says 32-bit for both
          /install/powerpc/vmlinuz-chrp.initrd and
          /install/powerpc64/vmlinuz-chrp.initrd but only the first one
          should work. Can you double check you have the right
          vmlinuz-chrp.initrd file? But if you say the same file works
          with 9.2.4 I have no idea why. I see these files on the CD
          <br>
          <br>
            9301172 Jun 19  2018 /install/powerpc/vmlinuz-chrp.initrd
          <br>
           10534888 Jun 19  2018 /install/powerpc64/vmlinuz-chrp.initrd
          <br>
        </blockquote>
        <br>
        <br>
        I am also using the same file:
        <br>
        <br>
        yogi@fedora:~/work/images$ ls -lrt vmlinuz-chrp.initrd
        <br>
        -r--r--r--. 1 yogi yogi 9301172 Oct 18 23:50 vmlinuz-chrp.initrd
        <br>
        <br>
        <blockquote type="cite">
          <br>
          File command says:
          <br>
          <br>
          vmlinuz-chrp.initrd:   ELF 32-bit MSB executable, PowerPC or
          cisco 4500, version 1 (SYSV), statically linked, not stripped
          <br>
          vmlinuz-chrp.initrd64: ELF 32-bit MSB executable, PowerPC or
          cisco 4500, version 1 (SYSV), statically linked, not stripped
          <br>
          <br>
          but only the first from the powerpc directory is supposed to
          work and it does boot for me with QEMU master. You can also
          check following the other way described in
          qemu/docs/system/ppc/amigang.rst using -bios pegasos2.rom
          which loads the correct image from the CD. Does that work?
          <br>
        </blockquote>
        <br>
        Yes, I had mentioned it in my first mail that ROM option works
        as expected. It is only an issue when using VOF with upstream
        Qemu.
        <br>
      </blockquote>
      <br>
      Or if you suspect it's a VOF issue you can try -trace
      enable="vof*" <br>
      <br>
    </blockquote>
    <p>Hi Balaton,</p>
    <p>As suggested, I tried both options in upstream:<br>
      yogi@fedora:~/work/git/fork/qemu/build$ ./qemu-system-ppc -machine
      pegasos2 -serial stdio -kernel ~/work/images/vmlinuz-chrp.initrd
      -append "---" -cdrom
      ~/work/images/debian-8.11.0-powerpc-netinst.iso -d guest_errors
      -trace enable="vof*"</p>
    <p>I could see the below trace and the error message:<br>
       vof_getproplen ph=0x13 "subsystem-vendor-id" =&gt; len=4<br>
      vof_getprop ph=0x13 "subsystem-vendor-id" =&gt; len=4 [00001100]<br>
      vof_getproplen ph=0x13 "reg" =&gt; len=20<br>
      vof_getprop ph=0x13 "reg" =&gt; len=20 [00000000 00000000 00000000
      00000000 00000000]<br>
      vof_write ih=0x2 [22] "Device tree strings 0x"<br>
      vof_write ih=0x2 [8] "01b0d000"<br>
      vof_write ih=0x2 [6] " -&gt; 0x"<br>
      vof_write ih=0x2 [8] "01b0d405"<br>
      vof_write ih=0x2 [2] "<br>
      "<br>
      vof_write ih=0x2 [22] "Device tree struct  0x"<br>
      vof_write ih=0x2 [8] "01b0e000"<br>
      vof_write ih=0x2 [6] " -&gt; 0x"<br>
      vof_write ih=0x2 [8] "01b0f000"<br>
      vof_write ih=0x2 [2] "<br>
      "<br>
      vof_getprop ph=0x3 "stdin" =&gt; len=4 [00000001]<br>
      vof_write ih=0x2 [18] "Calling quiesce..."<br>
      vof_write ih=0x2 [2] "<br>
      "<br>
      vof_claimed 0x0..0xd80 size=0xd80<br>
      vof_claimed 0x8000..0x10000 size=0x8000<br>
      vof_claimed 0x400000..0xcd8dfc size=0x8d8dfc<br>
      vof_claimed 0xd00000..0x15a1ec0 size=0x8a1ec0<br>
      vof_claimed 0x15a2000..0x1b0b90d size=0x56990d<br>
      vof_claimed 0x1b0c000..0x1c0c000 size=0x100000<br>
      vof_claimed 0x1ffff000..0x1ffff014 size=0x14<br>
      vof_write ih=0x2 [24] "returning from prom_init"<br>
      vof_write ih=0x2 [2] "<br>
      "<br>
      <font color="#f66151">Trying to read invalid spr 1012 (0x3f4) at
        c0013f48</font></p>
    <p>Regards,</p>
    <p>Yogesh Vyas</p>
    <blockquote type="cite"
      cite="mid:993819c9-cf87-ec91-31ac-f8988c8d3d67@eik.bme.hu">Regards,
      <br>
      BALATON Zoltan<br>
    </blockquote>
  </body>
</html>

--------------0nSzWO5r5GyxmFJwZZI5wKVu--

