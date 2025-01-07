Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D43E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 18:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVDxp-0004Ot-26; Tue, 07 Jan 2025 13:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVDxm-0004OC-Pp
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 13:05:59 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVDxk-0006u7-Od
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 13:05:58 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso110235945e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 10:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736273155; x=1736877955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JB4okT009rU8j6+qdrOZKtR9cK4WM7WBxut5Gl1Vaq4=;
 b=kaOgWuNOfjZX6Iziris61zonodb26vVR3fDbT3vI6GUiJfTna9F4CJrR78raQcnSQg
 F5REZCo50t296q1COVYgwqbPnN2g0rWIfitt/zD/OftaiXKbe4B6FZ2A/6xm1Ufmux9l
 KhAg7IdOylP8kBCA2ZikOte/ERbI73nMrWRrGSOfFgpe+UX/Q68qN+bwaEnKehFBFVzh
 0nFL/fgwLuW+YQwpl3cE8geCfMzGzMyTaiJgeuuHvUZDBe0+H14BJRBksW/zJe2wCcE/
 VsP7D6NBIRcbsxk2UkdbpaayN2tfZJNxqDZDH/7ktvJVBoU8Nc+4TV1uONbe1EKYoTzu
 Fzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736273155; x=1736877955;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JB4okT009rU8j6+qdrOZKtR9cK4WM7WBxut5Gl1Vaq4=;
 b=QWnHeYABKqj+AUbbWoAnY96Gk4YkVzMDy5o+oJINBWTeOyEmqazHCkKCB3DVdR2G7k
 v3db235t7euC0sG0WiHx2BccVdK7rVhFtwXeorGyG91pcaDQ06/COkvcpNwmcqPbZwtO
 ilM+P3F7mOTnngnuVLaEuVnwiPlrVq2I4/QzBt0TSL7srpUPOsIprBocMXwokGgx03Kd
 RzLqAyDHgH14mfjuz4JWQvkGR7+sLmRAaVMjCjmhA5LFzUqQDx1n8VRaWrKmqsyZJY31
 w8rdWpMj1NQXmm0Da2LNpm+0W8UPBMDuOoAr2xIDZKUalCCIWlBeTgOKc4H/fNH3Mk8s
 ZFcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuyu8kvDPy0Gzgqv5Ll+2ctjarNcqyDEcy58ap6StqFaMd2fyZmOWE9uqA50Sm8Ju6zEaL2ORhuW2Z@nongnu.org
X-Gm-Message-State: AOJu0YzrQWEzJL+oErPF/StpwYamDPgOPDZZfT9oCFXnnw85DnAFvi5c
 4CQ72DgyOiAL/dFLoqQw0FBJ7m1Ql49I6bWF4eByg6pVB/njPCyfQDSEo1t0ees=
X-Gm-Gg: ASbGncvoTx49VF2XgP+64s91FqDYFpxRPKpExXtAdpubwVDwYFiJAP6bQol441uJXWW
 E8cYSZ3HIH5Y6CK5jzWHab+L1chmgeUw8M+SqK/fBqyc8Ft5rr+YldjlSvENUc3XS+LXtSWDwKD
 0X0tP73krDpZhDWU9bwVPHxvgrlY/UYw3QwL9liiXqCyK6+aAUX7qlWwFSS2WbW5O7Czxz8696p
 a4bfQGH1A3hxrbLsYRgwkbFGHK2+pWquDmXQ47hzQqOfZI7dNk6IA8=
X-Google-Smtp-Source: AGHT+IEv6cEbPMSWMXY2Sz5nFztpSautdpf55Jb1ubZGzwB4OVyQmyWZWdodSYiO70vtn9ZNIwLTZg==
X-Received: by 2002:a05:600c:468d:b0:436:346a:fa9b with SMTP id
 5b1f17b1804b1-43668b499aamr459800365e9.20.1736273154848; 
 Tue, 07 Jan 2025 10:05:54 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436dcceb8c6sm14950545e9.0.2025.01.07.10.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 10:05:54 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 652E35F869;
 Tue,  7 Jan 2025 18:05:53 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stafford Horne <shorne@gmail.com>
Cc: Rob Landley <rob@landley.net>,  Peter Maydell
 <peter.maydell@linaro.org>,  "Jason A. Donenfeld" <Jason@zx2c4.com>,  QEMU
 Developers <qemu-devel@nongnu.org>,  Linux OpenRISC
 <linux-openrisc@vger.kernel.org>
Subject: Re: or1k -M virt -hda and net.
In-Reply-To: <Z31k3zNN3pOdGWWK@antec> (Stafford Horne's message of "Tue, 7 Jan
 2025 17:31:11 +0000")
References: <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
 <Z0Cyx3i3z7Zl7XPm@antec>
 <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net>
 <Z0GSETLeT5w8B2DX@antec>
 <87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net>
 <Z0LMqEqcdjkAxnN-@antec>
 <57c5207c-3aca-47cd-bfd3-3d7eb7be3c0f@landley.net>
 <Z2lgL31ZeSkO59MZ@antec>
 <8807078a-0673-4b27-8d58-4a2a3ce4987d@landley.net>
 <39511711-b86a-4ac6-8bd6-8dab824b693e@landley.net>
 <Z31k3zNN3pOdGWWK@antec>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 07 Jan 2025 18:05:53 +0000
Message-ID: <87y0zmbita.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

Stafford Horne <shorne@gmail.com> writes:

> On Tue, Jan 07, 2025 at 05:56:52AM -0600, Rob Landley wrote:
>> On 12/31/24 19:19, Rob Landley wrote:
>> > On 12/23/24 07:05, Stafford Horne wrote:
>> > > > The kernel config looks like it should have virt block device
>> > > > support, but
>> ...
>> > > =C2=A0=C2=A0 -device virtio-blk-device,drive=3Dd0 -drive
>> > > file=3D${DISK},id=3Dd0,if=3Dnone,format=3Dqcow2
>> >=20
>> > -drive file=3Dfile.img,format=3Draw,id=3Dhd0 -device virtio-blk-device=
,drive=3Dhd0
>> >=20
>> > My -device looks similar but -drive is file=3Dfile.img,format=3Draw,id=
=3Dhd0
>> >=20
>> > No idea what if=3D does? I haven't seemed to need it...
>> ...
>> > Thanks, I think this target is good for release. Now to figure out why
>> > sh2eb network isn't working after the restore (it used to!). Nor is
>> > microblaze's network...
>>=20
>> My test harness appends -hda filename.img to the qemu command line, which
>> works for all the other targets, and is awkward to turn into
>> -device lots-of-stuff,file-filename.img,more-stuff inside a shell script.
>> (At best it's a special case parsing and rewriting qemu command line
>> plumbing to turn "generic" into an architecture-specific workaround.)
>
> Hi Rob,
>
> Sorry, from the laat email I was under the impression that you had everyt=
hing
> working as expected.
>
>> In THEORY I should be able to do something like:
>>=20
>> root/or1k/run-qemu.sh -netdev user,id=3Dnet0 -device
>> virtio-net-device,netdev=3Dnet0 -device virtio-blk-device,drive=3Dsd0 -h=
da
>> README
>>=20
>> And just have extra arch setup that then accepts the generic appended to=
 it.
>> But in practice that says:
>>=20
>> qemu-system-or1k: -device virtio-blk-device,drive=3Dsd0: Device needs me=
dia,
>> but drive is empty
>>=20
>> Putting the -hda before the -device doesn't help. (And even if it did, t=
he
>> result would barf if run _without_ -hda, which should also work.)
>>=20
>> Having -hda by itself is accepted by qemu, but I don't know what bus/dri=
ver
>> gets added as a result (or1k kernel does not find it).
>
> I am having a hard time understanding the use case.
>
> As you know I use the following to wire in the buildroot image which I tu=
rned
> into a qcow2 disk using my tool:
>
>   https://github.com/stffrdhrn/or1k-utils/blob/master/scripts/qemu-or1k-m=
kimg
>
>   -device virtio-blk-device,drive=3Dd0 -drive file=3D${DISK},id=3Dd0,form=
at=3Dqcow2
>
> But I think you want to use:
>
>   -device virtio-blk-device,drive=3Dsd0 -hda XYZ
>
> I have not used -hda before, do you have it working with other targets?
>
> According to the qemu docs in qemu-options.hx. I see:
>
>     Use file as hard disk 0, 1, 2 or 3 image on the default bus of the
>     emulated machine (this is for example the IDE bus on most x86 machine=
s,
>     but it can also be SCSI, virtio or something else on other target
>     architectures). See also the :ref:`disk images` chapter in the System
>     Emulation Users Guide.
>
> I think, since we don't have a "default" bus in openrisc this doesn't wor=
k so we
> need to specify the -drive explictly.
>
> I checked the x86 machine code and confirm it seems to work like this.  T=
here is
> code in the system setup to look for hd* drives and wire them into IDE.  =
There
> is no such code in openrisc.

Yeah don't use -hdX as they are legacy options with a lot of default
assumptions. As the docs say: https://qemu.readthedocs.io/en/master/system/=
invocation.html#hxtool-1

  The QEMU block device handling options have a long history and have
  gone through several iterations as the feature set and complexity of
  the block layer have grown. Many online guides to QEMU often reference
  older and deprecated options, which can lead to confusion.

  The most explicit way to describe disks is to use a combination of
  -device to specify the hardware device and -blockdev to describe the
  backend. The device defines what the guest sees and the backend
  describes how QEMU handles the data. It is the only guaranteed stable
  interface for describing block devices and as such is recommended for
  management tools and scripting.

  The -drive option combines the device and backend into a single
  command line option which is a more human friendly. There is however
  no interface stability guarantee although some older board models
  still need updating to work with the modern blockdev forms.

  Older options like -hda are essentially macros which expand into -drive
  options for various drive interfaces. The original forms bake in a lot
  of assumptions from the days when QEMU was emulating a legacy PC, they
  are not recommended for modern configurations.

>
> -Stafford

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

