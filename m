Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CFFE77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 08:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVRYO-0004VH-FM; Wed, 08 Jan 2025 03:36:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tVRY8-0004T4-MI
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 03:36:27 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tVRY4-00071t-3F
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 03:36:22 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21654fdd5daso226126835ad.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 00:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1736325377; x=1736930177;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E4xHtutXBC5GQW4RI3f48TDbe4FsNgFhKRBeexaqSus=;
 b=nQVoxf61B8lL6BR3RvJKo16BzsWjDkxLnnW8jWSDtsy0mrF1MgYh9mKvqf/EA9ocW9
 38eBXcNqgwdfNSCo68ua5nogADuY81g/BqFqoqm9SQ77LwKjmuWRJHwcBVsRlGJy68Im
 juFDT1u9wWWXPeXV7HJZPH/22AXWxYmdb2IeipeKUUVd5rVjqKa3k+GkR1urhX0oL/7h
 9ADRxfF+MnHrDlaDRzTl7k+9Ed1P3Moka8Fb47oqyWb4cYBw/IsL4PdHXdrlhyt3lAdV
 +h/+jHDpzT5CXtn7NXPak3X2Ag3c03xjFjvUyvGeud//yRfhyTTSNjqUpJerBbUINpzM
 bCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736325377; x=1736930177;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E4xHtutXBC5GQW4RI3f48TDbe4FsNgFhKRBeexaqSus=;
 b=k1Dug8CqhObKEm9N7UAZhBzhmQykCZiP0zuOMXn4k6zKGhUcdiWz2FxhJgTJMEwUKk
 n5Tw0J45QxJfqer32XzuKfTfOAcZ0n8lzwDIi4xtTLMjXKeModu48wsp0gampt4J27EC
 98UQpHV0mN6urQ9Htty6KOhwHSfaU9QPDFo3uelc3umBhWiYT95m3SraW6CnSbq1fe2x
 /MHlQ0iSpzZPaNrx1kUXEI2+n/j4fCRLc8/5XH0Jy48MgXWs3YCdsfdypccBcyT7hC92
 42WI8OIkKqkoWObsphjM5YM8VcQ6APwXyUF1WRQvNQuTEueatJNA0c4j78A4JelcKLHY
 NM7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHoS8VpjrE1Mxct4dzWHuqQk1FbfoL3FGOMAFunM0kr94tRNIFXaZQewa+lfLaPb2GsUG8o1KFXAAI@nongnu.org
X-Gm-Message-State: AOJu0Yz6dxUXd58hTpCq5YR/mUBu0qEQIk+On7OFdX0ohZNg+TkT5Cie
 jMCywoml+bwgsJTYXXIjVuzdBh4wnBGGB6q9IThW+3lq9jmv4gZH/1agqIEJq5/DPZxiKbCP9BK
 8PMKdN7DGlpo9UdP5AU/B4ssFAJhkS20uknIiMuuybQGrZrU=
X-Gm-Gg: ASbGnctAlQhWpCDp6OnNawURv6/ZRB4VoB/SkDohYNAhwsgw8/ztlq0Qfvab9+a++6q
 RTA+m8ebgmLIbDD0xRYQws9w20KfikQYVFAKXXw==
X-Google-Smtp-Source: AGHT+IEbRxYN/5ZQ3dnbC5Az9rbp9Pw8CF8VzDX1fCz9AAw1R+8fHI26kaRvGuo2uKONtMlE3jN+4ncj0CezQQMgB7k=
X-Received: by 2002:a05:6a00:1909:b0:725:f4c6:6b72 with SMTP id
 d2e1a72fcca58-72d21ffc066mr3008869b3a.25.1736325377426; Wed, 08 Jan 2025
 00:36:17 -0800 (PST)
MIME-Version: 1.0
References: <20250103150558.1473-1-philmd@linaro.org>
 <Z3f--qO8x45MpiXQ@redhat.com>
 <CAGCz3vtSUD-8pG7GVUAjx0ydOKAh-YxvWDUpcECef7ch7dbeGg@mail.gmail.com>
 <Z3wkO0GP-VxfEcc0@redhat.com>
In-Reply-To: <Z3wkO0GP-VxfEcc0@redhat.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Wed, 8 Jan 2025 09:36:06 +0100
X-Gm-Features: AbW1kvanti1b-skeygZCrYuLKMHIVmDmQEGW6xCnIKME68P_7vIvm60LUs4Tt5Y
Message-ID: <CAGCz3vtdpQ3cCh7j36Nhg89QvnT8gn8JrUftXtX6x59HTZwsNg@mail.gmail.com>
Subject: Re: [PATCH] system: Try hardware accelerators (KVM, HVF) before
 software one (TCG)
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000563283062b2dc137"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::62c;
 envelope-from=lists@philjordan.eu; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000563283062b2dc137
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Jan 2025 at 19:43, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:

> On Sat, Jan 04, 2025 at 12:28:14PM +0100, Phil Dennis-Jordan wrote:
> > On Fri, 3 Jan 2025 at 16:16, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om>
> wrote:
> >
> > > On Fri, Jan 03, 2025 at 04:05:58PM +0100, Philippe Mathieu-Daud=C3=A9=
 wrote:
> > > > As Daniel suggested [*]:
> > > >
> > > > > We should consider to rank HVF above TCG, on the basis
> > > > > that HW acceleration is faster and should provide a
> > > > > host<->guest security boundary that we don't claim for TCG
> > > >
> > > > [*] https://lore.kernel.org/qemu-devel/Z07YASl2Pd3CPtjE@redhat.com/
> > >
> > > Note, my statement above was on the basis that HVF passes all our
> > > functional tests, thus indicating a decent level of confidence
> > > in the correctness of the HVF impl.
> > >
> > > If anyone knows any show stopper problems with HVF that would
> > > justify blocking its promotion ahead of TCG.... say now.
> > >
> >
> > I don't know about showstoppers, but:
> >
> > 1. As far as I'm aware there are/were problems with the virtual IOMMU
> > devices in HVF. It's been a while (~half a year?) since I tried them,
> but I
> > had problems getting guests booted with intel_iommu etc.
>
> I think that vIOMMU is niche enough that we can merely consider it
> a nice-to-fix bug, and not block promoting HVF.
>

Yes, I assume those are mainly useful with very large numbers of vCPUs
and/or PCI device passthrough? Neither of those are relevant on macOS
hosts. (One other thing they're useful with is device driver
development/testing/debugging - real Macs come with IOMMUs so
PCI/Thunderbolt device drivers MUST translate addresses for DMA correctly -
but that's very niche indeed.)

> 2. I think there might also be a few remaining edge cases where the x86
> > instruction emulation on fault/trap is incomplete. Most notably, MMIO
> using
> > SSE/AVX/etc. instructions will, I think, fail. In practice this is a
> fairly
> > obscure use case - I'm not aware of any guest OS that actually performs
> > MMIO using these instructions. I have a patch kicking around that adds
> > support for missing 64-bit variants of common scalar arithmetic
> > instructions with memory operands. I can dig that up and post it - do w=
e
> > have a good way of adding tests for this kind of thing?
>
> Not sure how best to test this, other than finding a guest OS that
> exhibits this ? Others probably have better suggestions...
>

I encountered it while trying the aforementioned vIOMMU; macOS guests
seemed to use 64-bit instructions for accessing some of the registers.

I've just checked, and there actually seem to be some instruction emulation
tests in the kvm-unit-tests project; those are designed for KVM, but I
expect it should be possible to tweak some of them so they're useful for
testing HVF. kvm-unit-tests don't seem to be part of QEMU's regular test
suite at the moment though, as far as I can tell?


> > 3. As far as I'm aware, there's no CI happening on HVF? Or has that
> > changed? macOS is notoriously a pain in the rear in terms of CI thanks =
to
> > its licensing, and the big cloud CI platforms tend to run it in a VM
> which
> > in turn typically doesn't support nested HVF. I've been working on an
> > on-prem solution to provisioning bare-metal Macs to run clean-slate OS
> > images for CI. This has been a side project though and I haven't had th=
e
> > resources to focus on that project to see it through. It might be
> possible
> > to do this in the cloud on Amazon's EC2 Mac Minis as well, but those
> aren't
> > exactly cheap.
>
> The only CI we have is running under Cirrus CI which uses VMs on
> real mac aarch64 hardware, but I don't think we can test HVF there.
>

Thanks for confirming.


> Mostly we rely on regular contributors periodically running tests
> and reporting on problems. This is not ideal, but also not a blocker
> for enabling HVF - it just means macOS isn't a full tier 1 platform
> for us.
>

OK, that makes sense, thanks. At least this gives me a better idea of what
will be covered by CI and what won't when I'm reviewing patches.

Phil

--000000000000563283062b2dc137
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, 6 Jan 2025 at 19:43, Daniel P. Berran=
g=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Sa=
t, Jan 04, 2025 at 12:28:14PM +0100, Phil Dennis-Jordan wrote:<br>
&gt; On Fri, 3 Jan 2025 at 16:16, Daniel P. Berrang=C3=A9 &lt;<a href=3D"ma=
ilto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt; wro=
te:<br>
&gt; <br>
&gt; &gt; On Fri, Jan 03, 2025 at 04:05:58PM +0100, Philippe Mathieu-Daud=
=C3=A9 wrote:<br>
&gt; &gt; &gt; As Daniel suggested [*]:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; We should consider to rank HVF above TCG, on the basis<=
br>
&gt; &gt; &gt; &gt; that HW acceleration is faster and should provide a<br>
&gt; &gt; &gt; &gt; host&lt;-&gt;guest security boundary that we don&#39;t =
claim for TCG<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [*] <a href=3D"https://lore.kernel.org/qemu-devel/Z07YASl2Pd=
3CPtjE@redhat.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kerne=
l.org/qemu-devel/Z07YASl2Pd3CPtjE@redhat.com/</a><br>
&gt; &gt;<br>
&gt; &gt; Note, my statement above was on the basis that HVF passes all our=
<br>
&gt; &gt; functional tests, thus indicating a decent level of confidence<br=
>
&gt; &gt; in the correctness of the HVF impl.<br>
&gt; &gt;<br>
&gt; &gt; If anyone knows any show stopper problems with HVF that would<br>
&gt; &gt; justify blocking its promotion ahead of TCG.... say now.<br>
&gt; &gt;<br>
&gt; <br>
&gt; I don&#39;t know about showstoppers, but:<br>
&gt; <br>
&gt; 1. As far as I&#39;m aware there are/were problems with the virtual IO=
MMU<br>
&gt; devices in HVF. It&#39;s been a while (~half a year?) since I tried th=
em, but I<br>
&gt; had problems getting guests booted with intel_iommu etc.<br>
<br>
I think that vIOMMU is niche enough that we can merely consider it<br>
a nice-to-fix bug, and not block promoting HVF.<br></blockquote><div><br></=
div><div>Yes, I assume those are mainly useful with very large numbers of v=
CPUs and/or PCI device passthrough? Neither of those are relevant on macOS =
hosts. (One other thing they&#39;re useful with is device driver developmen=
t/testing/debugging - real Macs come with IOMMUs so PCI/Thunderbolt device =
drivers MUST translate addresses for DMA correctly - but that&#39;s very ni=
che indeed.)<br></div><div><br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
&gt; 2. I think there might also be a few remaining edge cases where the x8=
6<br>
&gt; instruction emulation on fault/trap is incomplete. Most notably, MMIO =
using<br>
&gt; SSE/AVX/etc. instructions will, I think, fail. In practice this is a f=
airly<br>
&gt; obscure use case - I&#39;m not aware of any guest OS that actually per=
forms<br>
&gt; MMIO using these instructions. I have a patch kicking around that adds=
<br>
&gt; support for missing 64-bit variants of common scalar arithmetic<br>
&gt; instructions with memory operands. I can dig that up and post it - do =
we<br>
&gt; have a good way of adding tests for this kind of thing?<br>
<br>
Not sure how best to test this, other than finding a guest OS that<br>
exhibits this ? Others probably have better suggestions...<br></blockquote>=
<div><br></div><div>I encountered it while trying the aforementioned vIOMMU=
; macOS guests seemed to use 64-bit instructions for accessing some of the =
registers.</div><div><br></div><div>I&#39;ve just checked, and there actual=
ly seem to be some instruction emulation tests in the kvm-unit-tests projec=
t; those are designed for KVM, but I expect it should be possible to tweak =
some of them so they&#39;re useful for testing HVF. kvm-unit-tests don&#39;=
t seem to be part of QEMU&#39;s regular test suite at the moment though, as=
 far as I can tell?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
&gt; 3. As far as I&#39;m aware, there&#39;s no CI happening on HVF? Or has=
 that<br>
&gt; changed? macOS is notoriously a pain in the rear in terms of CI thanks=
 to<br>
&gt; its licensing, and the big cloud CI platforms tend to run it in a VM w=
hich<br>
&gt; in turn typically doesn&#39;t support nested HVF. I&#39;ve been workin=
g on an<br>
&gt; on-prem solution to provisioning bare-metal Macs to run clean-slate OS=
<br>
&gt; images for CI. This has been a side project though and I haven&#39;t h=
ad the<br>
&gt; resources to focus on that project to see it through. It might be poss=
ible<br>
&gt; to do this in the cloud on Amazon&#39;s EC2 Mac Minis as well, but tho=
se aren&#39;t<br>
&gt; exactly cheap.<br>
<br>
The only CI we have is running under Cirrus CI which uses VMs on<br>
real mac aarch64 hardware, but I don&#39;t think we can test HVF there.<br>=
</blockquote><div><br></div><div>Thanks for confirming.<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Mostly we rely on regular contributors periodically running tests<br>
and reporting on problems. This is not ideal, but also not a blocker<br>
for enabling HVF - it just means macOS isn&#39;t a full tier 1 platform<br>
for us.<br></blockquote><div><br></div><div>OK, that makes sense, thanks. A=
t least this gives me a better idea of what will be covered by CI and what =
won&#39;t when I&#39;m reviewing patches.</div><div><br></div><div>Phil</di=
v><div><br></div></div></div>

--000000000000563283062b2dc137--

