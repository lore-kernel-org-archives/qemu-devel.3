Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AF3CA6017
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 09:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFTU1-0002fE-NH; Sat, 10 Oct 2026 05:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xFTTy-0002dF-2N
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 05:35:10 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xFTTw-0005nq-57
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 05:35:09 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6ae305e3bd9so665594a12.0
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 02:35:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791624906; cv=none;
 d=google.com; s=arc-20260327;
 b=mTaNnKq8x2Fcc4vjdCE1yBhVY3/7oygr6ltvHso6/gOs5QXKTnAf+u0cDQ5xxDb5o7
 OseysZwbAFU1ijnMm3MZjH5GIamNTElY7DdmR2X//DwZa+eHysrNMSArjvOsnjw0lAHm
 ICSpu3/isOSgoGivsMmzyq8Ww6yd2ZY0WCrzBlwC1ByakK1Y0GVZSHgDVB7Lt3+rxBTh
 3toZrWZecY/bnbOq7U8gyaPbqUe7zPdQXNWf5Mz8VocIGCaRPwd0aGNz7E9BOH0aMe4N
 slvCuLon4f04VbHzK+18bmykZmeihOUY81tU2GdxKlRygb00rsrqulxSv9bo3DoMjxKq
 eYZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=vxD9FfkU6Xbu8Lutb6s8Zo3WMa+ylUcN6yQWbd4+aLk=;
 fh=SE7KO6y7tHDMZGwKLlB1xAumM8lZf5aOKvLvc6R3cWE=;
 b=cyNfXYk/7KnD0HUlAC7OXv2VyKgFbgnfPpSFmDNuSDfsVXDdF2WKS7msq/PGgChbYF
 jWMMuDT+xy2ZT+XQxfILOWRm43MLCmFKDJL4m9vAy70ujB5rimBo8RvL1b0SHLUSUu9c
 YOtsnXNkPF5pj4tmCpiRRPVIyfc7cBjYvHiZSc780yzUoXKuYPPhK3vqUzbq9FRIIvJE
 nRq3yOIDosVAWDFuvpaa91R8M7i1bBB/kRy0X0AfApFjQv8EZms91OxJD3dLyVOeGcMc
 gCQ+/uNLhgFQI4+rDwK21LrEKQtiQ9e3zbfJhsKHwgF76oikzX4rDvlMD4TVG2lZP4Np
 Cl3w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791624906; x=1792229706; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vxD9FfkU6Xbu8Lutb6s8Zo3WMa+ylUcN6yQWbd4+aLk=;
 b=UciSj4PJBa4Y2PqJmRbOORTcHVvHf2ARHfLMQ7pCkyN3JCcMWoegOZXc71OKWAico8
 r+pvU5nAEGsFRcK98jb+NOSZ/pM4EtdZRag+NNPQ4+z7FnZpGnikcQIY6sin0sXZVQ3B
 l9+/zTVfYLpXgi4/k1YJh7ievyniyRkdV4ByeLP7KTZLlsiXu5SSPRf5YzCxJvjTGAf7
 2IUq2cPWBKZXK0xZs+HnaForufMUcxXIStfYe98VOIHF2wtRZTL9msLCf41ktM19zMj2
 7uNCW9GUvPNHZ1/xCGTKyEdlJympjzREeVE0Wi7Gt5qQxjG4jrg3TVLbVShEoYaQf1P7
 9lWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791624906; x=1792229706;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vxD9FfkU6Xbu8Lutb6s8Zo3WMa+ylUcN6yQWbd4+aLk=;
 b=h8iRkVzJJN168pXwZWpucpbq3Um7Dmr7DFVbluQhj+FiWDDPp3gPfYYL1NebcF+9Yk
 wDy0vu1AhAdamml6AdhjgUHbxz4ppxyNVxKINpbqsw8tlPu4+3RHRGxIApTKCZ6bEO3k
 SjY3I6WRSx3WuRXBsF1tZHkpWFUn5Xzs7iI0R90lj3XBaL/n1tV5V4HCn5xv5mdIRJcu
 kQBPNUmZsR4oU8w/3TalGzLhDRk03PrR8ufdqRKcFuGO0kj/KBnJurrbuAuEMtR1/09k
 +UgMC8o+W9zUnz0+qdnr8OawmJ/6rfmTZGk1a3LvxdZblLmo+dh+cawhQtDyvLTSqY6R
 xyfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlc04bwnygioxwD3MYySm0epEoJ+Y7ZZX4e3bmgaTF7TFn7FBrdrM92QGwqSpinouuJbmTKgxMWVl4@nongnu.org
X-Gm-Message-State: AFq9FYJJte7bKwH0hyaCGQ1em3cD4npgg/nNIO513Pj30uG9f6kzRYcc
 TtEKtttWs40GoqPvJ8KIWoe9qx0VXh+tdUX533Ui8n3l+4bPordOeweGUb9nPOmgdKH5sG2Baoq
 C5tFwgYB0xTeWAbzY6SW+sQbjTh5Ui8g=
X-Gm-Gg: AYBFou35ANtpCnDdK88pcsc4gRD/T2jtbENyHP6Yt2F8p8XzOqvhj4eYys2H9ADKq0S
 33j8YlfbTzyHV+pvnL6QTl3WBp1KRLSj44Js/c+sJtfMG5M6uwb7zJF9NoSroVkhN29BsUEnq1T
 Ry/hdiXRXE7K18TcFj9+XsJwGz1VrLeHI7KhXR1R5ejXTXyxoQSvcUyKtXLA/v5BzMNk9nzPhNi
 D0ChFopLEol4duJ1R/le76UWn5lNKPTnU1TiArk+M0Quqv9yp7x5EY64yuNpjvQLAOjGjAVwYxV
 HXmj5HkyfnbjSPno3sLBgKpEsc1yL08grPmhtCCgtNi8W17LS1c2zfSe
X-Received: by 2002:a05:6402:4486:b0:6ac:73f8:2e4f with SMTP id
 4fb4d7f45d1cf-6b17c268e61mr3870711a12.29.1791624905806; Sat, 10 Oct 2026
 02:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260930073935.712-1-luoyonggang@gmail.com>
 <20260930073935.712-5-luoyonggang@gmail.com>
 <374ba010-b530-4310-b20f-65ada56cda6b@oss.qualcomm.com>
 <f8ea6e43-2e6e-48b7-a61c-d9ec2200872c@linaro.org>
 <CAE2XoE97kuRkF4i2+t=tH0d0dXWjCaNmUjUaVZDPekWimSN3gw@mail.gmail.com>
 <e87d9000-6f45-40ec-80e1-f6d0954538f0@linaro.org>
In-Reply-To: <e87d9000-6f45-40ec-80e1-f6d0954538f0@linaro.org>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sat, 10 Oct 2026 17:34:53 +0800
X-Gm-Features: AclHuK9N5U1RFhjLm-C6KKBTbS1R7F2B0-Q6q98mriL4P9vm64FvddRiEl34D_E
Message-ID: <CAE2XoE-aV8asmUQ+FOZjHBEzf5O4uB2h=iWO-AARqpZemY3-3Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] tcg: namespace target helper symbols for combined
 builds
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 Song Gao <17746591750@163.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>, 
 Sunil V L <sunilvl@ventanamicro.com>, Philippe Mathieu-Daude <philmd@mailo.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x535.google.com
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

On Sat, Oct 10, 2026 at 5:07=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/10/26 10:53, Yonggang Luo wrote:
> > On Sat, Oct 10, 2026 at 3:45=E2=80=AFPM Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> On 10/1/26 18:51, Pierrick Bouvier wrote:
> >>> On 9/30/2026 12:39 AM, Yonggang Luo wrote:
> >>>> Use target-specific assembler names and helper metadata for TCG help=
ers
> >>>> when multiple targets share a binary. The generated prototype maps t=
he
> >>>> generic C helper name to a target-specific linker symbol, for exampl=
e:
> >>>>
> >>>>       helper_raise_exception
> >>>>           __asm__("helper_i386_raise_exception")
> >>>>
> >>>> This lets target helper definitions keep generic C names while avoid=
ing
> >>>> linker symbol collisions between targets.
> >>>>
> >>> Hi Richard, do you have an opinion on this patch?
> >>>
> >>> We are trying to see if we do renaming per helper, or if we introduce=
 a
> >>> "generic" way to deal with it. I don't have a strong opinion, renamin=
g
> >>> things or adding more macros and build system soup are both ok on my
> >>> side, so direction would depend on your culinary taste.
> >> I think the general direction is good.  Perhaps the specifics need
> >> adjustment.  In particular, using __asm__ to rename symbols is suspect
> >> and likely non-portable to non-ELF hosts like Darwin and Windows.
> >
> > I have already tested on windows, only not sure about Darwin, let's me
> > create a test on Darwin,
> > because I do not have a CI for Darwin to test it.
> In particular, I saw no use of __USER_LABEL_PREFIX__, which is required
> for portability.

What does this mean?
I am using TCG_HELPER_PREFIX to identify different base_arch
+            '-DTCG_HELPER_PREFIX=3D' + target_base_arch.to_lower()

>
>
> r~



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

