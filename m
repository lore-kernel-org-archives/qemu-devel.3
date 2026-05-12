Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B610CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 19:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMsMo-0002F3-0H; Tue, 12 May 2026 15:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fatihsenerr@gmail.com>)
 id 1wMsMm-0002Ec-Gn
 for qemu-devel@nongnu.org; Tue, 12 May 2026 15:02:04 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fatihsenerr@gmail.com>)
 id 1wMsMk-0002JO-9J
 for qemu-devel@nongnu.org; Tue, 12 May 2026 15:02:04 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso4733478a34.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 12:02:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778612521; cv=none;
 d=google.com; s=arc-20240605;
 b=JDCi+DVqNiLsWDggInBU0bS1Wn3ZODphNnx+Fu9aWDWCa6MzkX+4ATz6w1P/2ZXzMe
 cupLh0HUuIv5JKCUYM7v0YQmC3lH3EXe7lWDpE754HPE4jIyj1HmFOtMrJaUXmAC0z5p
 Ctoruey/rNcOW/Pkl65qYOiKp6Bo+P1WTVVWhzctDPcWptby9c/kFPbUrHPSZP5Rwp9g
 hg9TRagntLm8xe8kKterCLVm9MyPuSgoTyAfsYph0Qw5wzlT/h9R6crJPtrW8nrljd6e
 kbzN9vSBfVZB3xtGmeBmQxRqFUEF495qYrYDOGKVjAqmdVCnMSND2R0YoNMIWBakeqZR
 AfxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dIoSCxOVWjkMAxIfDUC/PT8ISlITx9QduUlE2vO/mWQ=;
 fh=Qpl77bHkcE0bYSjiKXT9vs9obKUyn+uhBwvH7ERnfRM=;
 b=IgBNu8Ncbi3Ybb8SJh/YlczbpxSAsu3R5vHTKyYTrnPsGsYGwDxl0gV5sMCrdp4McV
 lcGL/ppIBkKWSLwIiEzesF6E7GIbJl7BlN/tkq0Qfn+Ehsf1QKR196CaJ0bESpyPGkUn
 t3IQhpGVum7Lx2OOb1oIJVfUCyRU53lgQBnJc9cbLItVFwOcgFDrQIbMyPcN5OoNypSP
 nt/0N57lbGSXeZ9m6BJmWSO8ErP7sPWwBzSXOIKkdZLpT099MzHjDXMOTGf5Y3k6z+71
 roYVlMcTQAtp9l6QbpxLITStr8ElA9dCOg7k3KwN82oDq9VIqkaSCymUenxWj4XS00Is
 rcJA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778612521; x=1779217321; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dIoSCxOVWjkMAxIfDUC/PT8ISlITx9QduUlE2vO/mWQ=;
 b=j0FCNf2+8zAOuuDyG9Z+GfYa1SfcHZuS2UuUAZsSrNAZ+PiAtTCFjn0YQIiQdenDPd
 dDwbut2HRhfFN5AHnd+MXvCx8l9bZrFSNrrBZ81Hb2QngAKrcWF1C3QqtCANUeVG3lWU
 l971qpWK8GdfCuCNYmpFCmwortdSThTZblWKj2FmEiErTFiXASy6QC6QdQpHQndRUDdL
 XzFvo8e4s9WLQmqJS07DrpTXIN9qfO0lEpdt/3HAzfaK4Rdatd0HwefW38GKa31Gi/wJ
 O4zMhHahSFRhP4zDkV0HNyQ7jKpamJLF/mqeUan/aiwP7PJnfI7VV09u9uKyAgkDbGBF
 0PYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778612521; x=1779217321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dIoSCxOVWjkMAxIfDUC/PT8ISlITx9QduUlE2vO/mWQ=;
 b=k7uyTNQufmnR2hrGhH1E10dsEztiwrCZsCKV2lFZbDtRp28nB44C3tyxwg9fKewGbg
 C3C5JkB8iF1yW9YmZroIoON488RMhVxYj3Wy3B89Qq+OEW4mu/gFOaZb2OBFG1O8MHcq
 Rx3upAL3zwfuL8OjnXifxwsXxi/u9jwqMSwApuDzQr+l/0WpNt5MXCYN5Z5doqzUYlVC
 96sTYwKCSo/vksNRJ/DhOfE/HqABEzNNpa86qaDZrzIa8Sq6JxcbSnS0dcdRaeEUZtNn
 gHoF+NKW3dObUwy+/Yw1FELudEZ5eQoedB0SAgIHYLelwiSpgjvLw18gU7W0JIvLITQe
 7AXg==
X-Gm-Message-State: AOJu0YzALKptxpEv0VtC9QTD7NbBftjhKuYqM/UUt0EIkSnMpkB24bXa
 wV1lQVWKopQVAI07RgZbsL9RpedjrnqMP95rexiA2ZZZoQe6H94mprENA5/rTamRTdEyJHeqc5U
 KB4yZrSo9qSiOtMFsptvGg+RPNh0vtIY=
X-Gm-Gg: Acq92OFHRiRkg/u0UBY8aM80TJLqm+gImSkkQyE1mYXFTv77R7YbKTPa+lbODBHhTdj
 vEbkGLUVjP94V2lTckS5UiX6oFdhSiEBU5qPJHf+BZWRa4R4TS2a48BSZNfHFj93f1fGpJSC/oV
 /G1PVsS29+t0ZkT5esrufteseb1B19V+T5D/kpYAdDObhIvAbPhOU2QNBaDOMUSrZnklN7h2hGO
 x8lZZkCZ8+rtjkBfXVoMYkKiFV3Iwl6UV38GlhE8GhvgIlGH3nB1Zn+8X4qQQfKeEnR2m9Yxxaq
 ieIQMHAZjKb/w8xdgNXUgT/AEZFVhPuO2sHNBcdBFtFLvxRCUSVu/vu6GRq+WySFZthZYVCKzo1
 FWg==
X-Received: by 2002:a05:6830:6af9:b0:7dd:9b19:a875 with SMTP id
 46e09a7af769-7e36615e5c4mr12967778a34.2.1778612520576; Tue, 12 May 2026
 12:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAA1wZPc_RPc5NpN6Bg+4fW+PtbFSmR5uXGg4-bcvK4khOANUWQ@mail.gmail.com>
 <agNkab2farpJHSNt@redhat.com>
In-Reply-To: <agNkab2farpJHSNt@redhat.com>
From: =?UTF-8?B?ZmF0aWggxZ9lbmVy?= <fatihsenerr@gmail.com>
Date: Tue, 12 May 2026 22:01:49 +0300
X-Gm-Features: AVHnY4L5AfhB4wNOIZwsiEDn4-q4hyqB2cgYvYtKTHHK_MrGoLjSaZkwV-3MMCI
Message-ID: <CAA1wZPdQ0ZAFx9TLQT4vD9fxU-MBdNfZ8opg=0tq8SRvFndNeQ@mail.gmail.com>
Subject: Re: [PATCH] target/i386/kvm: Fix Live Migration failure on Intel Ice
 Lake after OS upgrade (Ubuntu 20.04 to 22.04)
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000007b6cae0651a37fd1"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=fatihsenerr@gmail.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000007b6cae0651a37fd1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the clarification and technical insight.
We understand that this migration scenario is not considered fully
supported with host-passthrough across differing kernel/QEMU environments.
The environment was originally designed around maximum CPU feature exposure
and performance requirements.
We are currently evaluating moving away from host-passthrough for future
upgrade compatibility.

Thank you again for your response.

Best regards,
Fatih

Daniel P. Berrang=C3=A9 <berrange@redhat.com>, 12 May 2026 Sal, 20:33 tarih=
inde
=C5=9Funu yazd=C4=B1:

> On Tue, May 12, 2026 at 11:02:37AM +0300, fatih =C5=9Fener wrote:
> > Dear QEMU Developers,
> >
> > We have identified a critical live migration failure on Intel Ice Lake
> > platforms when using *CPU host-passthrough* in OpenStack environments.
> The
> > issue specifically surfaced after upgrading compute nodes from *Ubuntu
> > 20.04 to 22.04*.
>
> IMHO that is not a valid usage scenario.
>
> host-passthrough is only supportable with live migration if both sides
> of the migration are *identical*. That means same CPU models, same
> microcode version, same BIOS version, same BIOS settings, same kernel
> version, same QEMU version. Vary any one of those factors as it looses
> any guarantee of live migration safety for host-passthrough.
>
> If those requirements can't be guaranteed, then we have a wide choice
> of named CPU models that support migration across hosts with different
> setups.
>
> > *Technical Analysis:* The migration fails with KVM_SET_MSRS error while
> > restoring MSR_IA32_PERF_GLOBAL_CTRL (0x38f). On Ice Lake CPUs, this
> > register reports 0xf000000ff due to the 4th fixed-function counter (Per=
f
> > Mon v5).
> >
> > We observed that while the source host (20.04) allows this value, the
> > target host (22.04 with a newer Kernel/KVM) enforces a stricter mask of
> > 0x7000000ff. Even with identical hardware, the migration is rejected
> > because the target KVM treats the 4th bit as reserved/invalid.
> >
> > *Proposed Fix:* We propose intercepting the MSR write in
> > target/i386/kvm/kvm.c to mask the value back to 0x7000000ff if
> 0xf000000ff
> > is detected. This ensures backward compatibility across different kerne=
l
> > versions and stabilizes migration on Ice Lake hardware.
> >
> > /* target/i386/kvm/kvm.c */
> > for (i =3D 0; i < cpu->kvm_msr_buf->nmsrs; i++) {
> >     if (cpu->kvm_msr_buf->entries[i].index =3D=3D 0x38f &&
> >         cpu->kvm_msr_buf->entries[i].data =3D=3D 0xf000000ffULL) {
> >         cpu->kvm_msr_buf->entries[i].data =3D 0x7000000ffULL;
> >     }
> > }
> >
> > We have verified that this fix stabilizes our production environment an=
d
> > allows successful live migration between hosts with different kernel
> > versions on Ice Lake hardware. We are looking forward to your technical
> > feedback on this implementation. If there is a more architectural way t=
o
> > handle these MSR bitmasks upstream, we would be happy to discuss it. Be=
st
> > regards,
> > --
> > =E2=97=8F Fatih =C5=9Eener - fatihsenerr@gmail.com
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--=20
=E2=97=8F Fatih =C5=9Eener - fatihsenerr@gmail.com

--0000000000007b6cae0651a37fd1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"gmail-p1">Thank you for the clarification and =
technical insight.<br>We understand that this migration scenario is not con=
sidered fully supported with host-passthrough across differing kernel/QEMU =
environments. The environment was originally designed around maximum CPU fe=
ature exposure and performance requirements.<br>We are currently evaluating=
 moving away from host-passthrough for future upgrade compatibility.</p><p =
class=3D"gmail-p1">Thank you again for your response.<br></p><p class=3D"gm=
ail-p1">Best regards,<br>
Fatih</p></div><br><div class=3D"gmail_quote gmail_quote_container"><div di=
r=3D"ltr" class=3D"gmail_attr">Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailt=
o:berrange@redhat.com">berrange@redhat.com</a>&gt;, 12 May 2026 Sal, 20:33 =
tarihinde =C5=9Funu yazd=C4=B1:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">On Tue, May 12, 2026 at 11:02:37AM +0300, fatih =C5=9Fener =
wrote:<br>
&gt; Dear QEMU Developers,<br>
&gt; <br>
&gt; We have identified a critical live migration failure on Intel Ice Lake=
<br>
&gt; platforms when using *CPU host-passthrough* in OpenStack environments.=
 The<br>
&gt; issue specifically surfaced after upgrading compute nodes from *Ubuntu=
<br>
&gt; 20.04 to 22.04*.<br>
<br>
IMHO that is not a valid usage scenario.<br>
<br>
host-passthrough is only supportable with live migration if both sides<br>
of the migration are *identical*. That means same CPU models, same<br>
microcode version, same BIOS version, same BIOS settings, same kernel<br>
version, same QEMU version. Vary any one of those factors as it looses<br>
any guarantee of live migration safety for host-passthrough.<br>
<br>
If those requirements can&#39;t be guaranteed, then we have a wide choice<b=
r>
of named CPU models that support migration across hosts with different<br>
setups.<br>
<br>
&gt; *Technical Analysis:* The migration fails with KVM_SET_MSRS error whil=
e<br>
&gt; restoring MSR_IA32_PERF_GLOBAL_CTRL (0x38f). On Ice Lake CPUs, this<br=
>
&gt; register reports 0xf000000ff due to the 4th fixed-function counter (Pe=
rf<br>
&gt; Mon v5).<br>
&gt; <br>
&gt; We observed that while the source host (20.04) allows this value, the<=
br>
&gt; target host (22.04 with a newer Kernel/KVM) enforces a stricter mask o=
f<br>
&gt; 0x7000000ff. Even with identical hardware, the migration is rejected<b=
r>
&gt; because the target KVM treats the 4th bit as reserved/invalid.<br>
&gt; <br>
&gt; *Proposed Fix:* We propose intercepting the MSR write in<br>
&gt; target/i386/kvm/kvm.c to mask the value back to 0x7000000ff if 0xf0000=
00ff<br>
&gt; is detected. This ensures backward compatibility across different kern=
el<br>
&gt; versions and stabilizes migration on Ice Lake hardware.<br>
&gt; <br>
&gt; /* target/i386/kvm/kvm.c */<br>
&gt; for (i =3D 0; i &lt; cpu-&gt;kvm_msr_buf-&gt;nmsrs; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (cpu-&gt;kvm_msr_buf-&gt;entries[i].index =3D=3D=
 0x38f &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu-&gt;kvm_msr_buf-&gt;entries[i].da=
ta =3D=3D 0xf000000ffULL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu-&gt;kvm_msr_buf-&gt;entries[i].da=
ta =3D 0x7000000ffULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; }<br>
&gt; <br>
&gt; We have verified that this fix stabilizes our production environment a=
nd<br>
&gt; allows successful live migration between hosts with different kernel<b=
r>
&gt; versions on Ice Lake hardware. We are looking forward to your technica=
l<br>
&gt; feedback on this implementation. If there is a more architectural way =
to<br>
&gt; handle these MSR bitmasks upstream, we would be happy to discuss it. B=
est<br>
&gt; regards,<br>
&gt; -- <br>
&gt; =E2=97=8F Fatih =C5=9Eener - <a href=3D"mailto:fatihsenerr@gmail.com" =
target=3D"_blank">fatihsenerr@gmail.com</a><br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <a href=3D"https://hachyderm.io/@berrange" rel=3D"noreferrer" target=3D=
"_blank">https://hachyderm.io/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.org" rel=3D"noreferrer"=
 target=3D"_blank">https://entangle-photo.org</a> :|<br>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer" target=3D"_=
blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0~~=C2=A0 =C2=A0 <a hre=
f=3D"https://fstop138.berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://fstop138.berrange.com</a> :|<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature">=E2=97=8F Fatih =C5=9Eener - <a href=3D"mailto:fatihsenerr@gmail.=
com" target=3D"_blank">fatihsenerr@gmail.com</a><br></div>

--0000000000007b6cae0651a37fd1--

