Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCEACD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 13:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMnVm-0004Lx-0z; Tue, 12 May 2026 09:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fatihsenerr@gmail.com>)
 id 1wMi4r-0005sQ-RA
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:02:53 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fatihsenerr@gmail.com>)
 id 1wMi4p-0006Y1-Bp
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:02:53 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-691de293326so3113103eaf.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 01:02:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778572968; cv=none;
 d=google.com; s=arc-20240605;
 b=LH2b9tSjlEL5WYROKvoNTzS1u8GtBSxxRJs42SJHpQu4hBJBStXoyT2DeB7xe2S7Tf
 XRiAD7WzNN1WoEnR1P2SdR2UWqjVDzSA/Wlup4ih6XDzAWUQLCtwdS+qhZQAib7wGWce
 IpHiRJSMBsm4R040RpxAd/gvae8Etbnc1nMVDUsPcP5ZPl2q7/Jpdeuk4HSLEFYQ6A8X
 gwRmWBdoVYiKIVT4G/UY8GRklOgCSP6Onmj2y+JMnz1yI8Yhrtz9WeHHOapKn7HIcy8b
 ZymRq5c9QtHFpY+qPtfeXDk2YofP6r3sBidp4/xms3nZBN+yTsDJdEB15I82FRH7ljim
 dpdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=eUtbQVc3kzc972liDjaFTI7YjYlU6i874GWY/X4ctw4=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=eIIzOEKv2cBiI7VNqoGDglUqSi1wx3CXxYV0NmHkwMvAumsaQDA50h91l99SK3LTcc
 nV9SjOEJmVpDwmBbWyRVE5HqyrsKsLf8opdDrcxN1xMr8CSD0KLar3iRRessxPRuMaaA
 7tOkw+rzwdj1rLNMGGjq8A1CCesJHcfm4cxSq1hKcddWExJkEnXYaF4p7dZAXnmRR38u
 7cyIHb6A0stWgrUu138geWWwagoePXpSk2wJSjDuQ648D6tX0O7S9+5w5oiFqf6cyXQw
 wLlIeS/iK9LS2oh1h2c+PMKGlPP0pmFzpuFj0JEr1BsyDEyRDgxSXofUhMJjQ/5U44lN
 puaw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778572968; x=1779177768; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=eUtbQVc3kzc972liDjaFTI7YjYlU6i874GWY/X4ctw4=;
 b=V4gZUu6dZDTZBjeby7AdJxanxA52/o4knQLq15HEOvve8D1FjZv4xE/LZGofLNrhuY
 AL/azNaiOX2iI5zYB516VaY12VOVP/9wZduhKnBKCHtkjMJhogKo3smG3ry70A+FilAM
 fUDlD+MscmSSEm7uI4Fyh862Lti1aASX0+3vm8in/cN2LFWKSuT26hthYACYDXNylKr5
 HFRh2ghIj0oVXa6jxOmGHKkvobIC/uy09A7pnClLlc/Hyb+MnjfobMJu2MvKj6WNyZ7/
 XQlFmVxIMP7QI5KA1Jve6hQK0qG/rRfEDD1PpI9M8inttix+YafiUa+FErXMYNa4HRD2
 xqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778572968; x=1779177768;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eUtbQVc3kzc972liDjaFTI7YjYlU6i874GWY/X4ctw4=;
 b=l42ZahMBnsyW1uF+10mHupu41IgGTiUn2kQNsuX64OEqAcWQgbqMYH3noHrQ2zKPwW
 c8OTZ6BnjISoXBoztmXlAOPXpo/2iXsB180x5gA1NfOJRe74VOzYe44cW1V9u8D2W6//
 rSfp0xdCtiRhOSbLXxJ65d1R/TA7pQsSAGhiYiu8jxWbBZxMDEbyYG2ivugvuDqpQ442
 AV3x+/l4rocHAwhZgPd5LldgSNDnbgY0z4GRr0bXbomEInWXccpTXkQU0Z0LHtjZrlbw
 H3ga8EGEEMasn5iCt6oibvXs4J3Pj8zO1u5Y5zrg9Gi2tMXsmxgSUXSymq7JcSUiyaFK
 96Jw==
X-Gm-Message-State: AOJu0YzqMpQ1U1mDeo15BUfdvWBWD7EpqgFhYAb1G8ViZ7BH8H6kUJmr
 F8soCsncg0I+zNOeeCMwRblvNlcbYUlZRlAyHHKmWIxG9DibILZ+8N6ekhvqmyIp+JxYk1xQEpx
 me3JdexNDwwBDMQRJ8mbufBauJ7A3KOMZMHaKv1s=
X-Gm-Gg: Acq92OFHdh+4SXRT4kZ5ykXETHrxeGgIbUpO1OHi1oGZjqOAou/QmMooZA6potiEWdC
 wtH9cM8nXlkev7YvqCtXXoR/5bdezSVKHc/go+ZpHIy7ogmdRaA2U/FWtc461LSlL0OFycJDznF
 LtVLYMrN5zneyw5utjKfQBGYOaGZ1sqqYUbx23Lb8/X42gc7vklbZD/nqDT28OG0o/jsY3Zk7uz
 NJAhVahoW7+M30Y6Qt79soWe6Q1jLm8lkUM/wWBbp/Ygv8t2P7JKiUwdwhHa8Dq1VaO/dp1K4JD
 HUBV+GErTUAmWFTliqOVXq5+j8L5f5aAtlx1ruibJNqejgT7PIiv7aS/2qcRbx/g/Qo=
X-Received: by 2002:a05:6820:220b:b0:69b:544f:b2df with SMTP id
 006d021491bc7-69b544fb409mr4548717eaf.17.1778572968157; Tue, 12 May 2026
 01:02:48 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?ZmF0aWggxZ9lbmVy?= <fatihsenerr@gmail.com>
Date: Tue, 12 May 2026 11:02:37 +0300
X-Gm-Features: AVHnY4JGSDM72NfWv3J7JpTpAM3MmG3SJyarTnro_nA53mlCo2ZL8FwBGc_b5oo
Message-ID: <CAA1wZPc_RPc5NpN6Bg+4fW+PtbFSmR5uXGg4-bcvK4khOANUWQ@mail.gmail.com>
Subject: [PATCH] target/i386/kvm: Fix Live Migration failure on Intel Ice Lake
 after OS upgrade (Ubuntu 20.04 to 22.04)
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f9671206519a49f7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=fatihsenerr@gmail.com; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 May 2026 09:50:49 -0400
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

--000000000000f9671206519a49f7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear QEMU Developers,

We have identified a critical live migration failure on Intel Ice Lake
platforms when using *CPU host-passthrough* in OpenStack environments. The
issue specifically surfaced after upgrading compute nodes from *Ubuntu
20.04 to 22.04*.

*Technical Analysis:* The migration fails with KVM_SET_MSRS error while
restoring MSR_IA32_PERF_GLOBAL_CTRL (0x38f). On Ice Lake CPUs, this
register reports 0xf000000ff due to the 4th fixed-function counter (Perf
Mon v5).

We observed that while the source host (20.04) allows this value, the
target host (22.04 with a newer Kernel/KVM) enforces a stricter mask of
0x7000000ff. Even with identical hardware, the migration is rejected
because the target KVM treats the 4th bit as reserved/invalid.

*Proposed Fix:* We propose intercepting the MSR write in
target/i386/kvm/kvm.c to mask the value back to 0x7000000ff if 0xf000000ff
is detected. This ensures backward compatibility across different kernel
versions and stabilizes migration on Ice Lake hardware.

/* target/i386/kvm/kvm.c */
for (i =3D 0; i < cpu->kvm_msr_buf->nmsrs; i++) {
    if (cpu->kvm_msr_buf->entries[i].index =3D=3D 0x38f &&
        cpu->kvm_msr_buf->entries[i].data =3D=3D 0xf000000ffULL) {
        cpu->kvm_msr_buf->entries[i].data =3D 0x7000000ffULL;
    }
}

We have verified that this fix stabilizes our production environment and
allows successful live migration between hosts with different kernel
versions on Ice Lake hardware. We are looking forward to your technical
feedback on this implementation. If there is a more architectural way to
handle these MSR bitmasks upstream, we would be happy to discuss it. Best
regards,
--=20
=E2=97=8F Fatih =C5=9Eener - fatihsenerr@gmail.com

--000000000000f9671206519a49f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><p>Dear QEMU Developers,</p><p>We have identified a c=
ritical live migration failure on Intel Ice Lake platforms when using <b>CP=
U host-passthrough</b> in OpenStack environments. The issue specifically su=
rfaced after upgrading compute nodes from <b>Ubuntu 20.04 to 22.04</b>.</p>=
<p><b>Technical Analysis:</b>
The migration fails with <code>KVM_SET_MSRS</code> error while restoring <c=
ode>MSR_IA32_PERF_GLOBAL_CTRL</code> (0x38f). On Ice Lake CPUs, this regist=
er reports <code>0xf000000ff</code> due to the 4th fixed-function counter (=
Perf Mon v5).</p><p>We observed that while the source host (20.04) allows t=
his value, the target host (22.04 with a newer Kernel/KVM) enforces a stric=
ter mask of <code>0x7000000ff</code>. Even with identical hardware, the mig=
ration is rejected because the target KVM treats the 4th bit as reserved/in=
valid.</p><p><b>Proposed Fix:</b>
We propose intercepting the MSR write in <code>target/i386/kvm/kvm.c</code>=
 to mask the value back to <code>0x7000000ff</code> if <code>0xf000000ff</c=
ode> is detected. This ensures backward compatibility across different kern=
el versions and stabilizes migration on Ice Lake hardware.<br><br>/* target=
/i386/kvm/kvm.c */<br>for (i =3D 0; i &lt; cpu-&gt;kvm_msr_buf-&gt;nmsrs; i=
++) {<br>=C2=A0 =C2=A0 if (cpu-&gt;kvm_msr_buf-&gt;entries[i].index =3D=3D =
0x38f &amp;&amp;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;kvm_msr_buf-&gt;ent=
ries[i].data =3D=3D 0xf000000ffULL) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&g=
t;kvm_msr_buf-&gt;entries[i].data =3D 0x7000000ffULL;<br>=C2=A0 =C2=A0 }<br=
>}<br><br>We have verified that this fix stabilizes our production environm=
ent and allows successful live migration between hosts with different kerne=
l versions on Ice Lake hardware.=20

We are looking forward to your technical feedback on this implementation. I=
f there is a more architectural way to handle these MSR bitmasks upstream, =
we would be happy to discuss it.

Best regards,</p></div><span class=3D"gmail_signature_prefix">-- </span><br=
><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signatu=
re">=E2=97=8F Fatih =C5=9Eener - <a href=3D"mailto:fatihsenerr@gmail.com" t=
arget=3D"_blank">fatihsenerr@gmail.com</a><br></div></div>

--000000000000f9671206519a49f7--

