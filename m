Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3376D70DEB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 19:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGjr7-0001ew-PQ; Thu, 28 Nov 2024 14:07:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tGjr3-0001eO-NT
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 14:07:10 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tGjr1-0002XP-It
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 14:07:09 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ee4980f085so231182a91.2
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 11:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1732820819; x=1733425619;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+bdT7cryshk73Z7rWwiV/etY/KAKdWdiNT6xbiDjOp8=;
 b=YAyQ297YXAz+WdUB34QzxYkTtpAnbB7IgeJqVNA/A/+iNkcHAyTybH3KZ7nD6C53as
 YCSLQ2gl/0UhuOvL+7J2HEUzJGhyMmGI1e3oyRt/wFIl9bgk/aPjmGDQkI19jIa2auJZ
 Sla6WJg4pigillM0/mPBtLuaufTNDANFZHhIm+Fyilv7xIULXlxkalP/4bzT1QNkp/pS
 lQmlx6hBqBiL/Q5gUG4zg/2ZaR7XtlN5mtCoO/EcOmZCk9ovYj3lGlKUsWz+iWd9o526
 Wx2KWw/kfXoRde3W6xHRgqhc31JmqrFcrYTRBaNJzW7ZaVSS/LZxCLdrsQPJ9AhVRzZh
 CjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732820819; x=1733425619;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+bdT7cryshk73Z7rWwiV/etY/KAKdWdiNT6xbiDjOp8=;
 b=gcEqpdEB9loMQYhA4PrfG5xiWOGH8wlJJceI6xwcJ05/ohPilSEDdSIQvjU/eGPykK
 6tUN3RnRG8/mjfwbEKI/u/S3YNlcevSf5kB1G7PtxWvQwzEeduzlklq4o1DRSwRUv4t7
 ln9UctjWsiWXTDLU8+zjkimitgcBCbwZd5U84hCsgyM2/gNIRTn1pHn9HlOLfU3CSw6A
 xw49GMWYJBgdK5x20kor6t0ZryGpJ8e3VpPzfOV1mfZXdvXzJli7OlKSZh5DnCFyWz97
 A6I1YDe2Ag5zXPNIin2uifkFthXH3YPR5VHBz5B0ExZukTFd2U9NyCuu3CqWCpUgno/N
 /WKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD7rOTHHOK1qTu1NJVhETe4nzPCybqOxd3PJE/LQ+606UaYdZyF2IMPznEec4FMcMAxz6pK6j3D7Up@nongnu.org
X-Gm-Message-State: AOJu0YyqKf5Y3SynGtx5PUJQMaYJixiI82QKKGQK/S+JwBYVnbLVv+GK
 l3PVrCes3bNzsFudp9mLg7lWciXm5JPWANf/fOwHZ94kgBIdv0VtH5NnyssvVQ3RxNZVIi3eqF2
 oPUiUn+rxTrP2qc6akrfwhHdFLASfbPrWUHj2
X-Gm-Gg: ASbGncvKjgj5g+mH6u5xCQsFsj7GFfSKryyZ3MrNKpaXIymyfneW2diM3t6JH8Ptbfx
 ZL+RZY0HR/OviRzMztWHdKFHLeG5SIKY=
X-Google-Smtp-Source: AGHT+IETqFmDBJ51a/UjIriTDnpzITx8e9HRHkxCnqHR1i4T26vNY3vFP2smDLjFoeUQ47T1TKQlYkArGvYf3tp/YqQ=
X-Received: by 2002:a17:90b:4e8e:b0:2ea:4578:46e0 with SMTP id
 98e67ed59e1d1-2ee08ec815amr10685317a91.17.1732820819201; Thu, 28 Nov 2024
 11:06:59 -0800 (PST)
MIME-Version: 1.0
References: <20241113144923.41225-1-phil@philjordan.eu>
 <b772f6e7-e506-4f87-98d1-5cbe59402b2b@redhat.com>
 <ed2246ca-3ede-918c-d18d-f47cf8758d8c@amd.com>
 <CABgObfYhQDmjh4MJOaqeAv0=cFUR=iaoLeSoGYh9iMnjDKM2aA@mail.gmail.com>
 <CAGCz3vtTgo6YdgBxO+5b-W04m3k1WhdiaqH1_ojgj_ywjZmV7A@mail.gmail.com>
 <e9404dd2-56d2-4c6d-81f2-76060c4b4067@linaro.org>
In-Reply-To: <e9404dd2-56d2-4c6d-81f2-76060c4b4067@linaro.org>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Thu, 28 Nov 2024 20:06:47 +0100
Message-ID: <CAGCz3vtxjKH0H8BL4ES_phNK8=Dy4Jzg3d7dLyNxuBQaSjTPQA@mail.gmail.com>
Subject: Re: [PATCH] i386/kvm: Fix kvm_enable_x2apic link error in non-KVM
 builds
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Shukla,
 Santosh" <santosh.shukla@amd.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, mtosatti@redhat.com, suravee.suthikulpanit@amd.com
Content-Type: multipart/alternative; boundary="000000000000636c870627fdc9f7"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::1029;
 envelope-from=lists@philjordan.eu; helo=mail-pj1-x1029.google.com
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

--000000000000636c870627fdc9f7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Nov 2024 at 17:46, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g>
wrote:

> On 28/11/24 17:38, Phil Dennis-Jordan wrote:
> > Paolo, could we please apply either Sairaj and Santosh's fix at
> > https://patchew.org/QEMU/20241114114509.15350-1-sarunkod@amd.com/
> > <https://patchew.org/QEMU/20241114114509.15350-1-sarunkod@amd.com/>
> > or mine to fix this link error? As neither patch has so far been merged=
,
> > 9.2.0-rc2 still fails to build on macOS, at least on my local systems.
> > I'm not sure why CI builds aren't jumping up and down about this, but
> > neither the Xcode 15.2 nor 16.1 toolchains are happy on macOS 14.7/arm6=
4.
>
> Just curious, is your build configured with --enable-hvf --enable-tcg?
>
>
It's my understanding that both HVF and TCG are enabled by default when
building on macOS - they both show up as "YES" in the ./configure output,
and the relevant -accel works; at any rate, specifying them explicitly made
no difference with regard to this link error. Your question did however
prompt me to dig a little deeper and check which of my test configurations
was affected.

It looks like the critical setting is --enable-debug. I think that changes
the exact optimisation level (not -O0 but less aggressive than the
default), so it's not unreasonable that this would change the compiler
pass(es) for eliminating constant conditional branches.

So yeah, when I build latest master/staging with --enable-debug on macOS
and my --target-list includes x86_64, QEMU fails to link with an undefined
symbol error for _kvm_enable_x2apic. This happens on both arm64 and x86-64
hosts, and with various Xcode 15.x and 16.y toolchains.

I have to admit I'm personally not a big fan of relying on the optimiser
for removing references to these symbols, but restructuring the conditional
expression like in Sairaj and Santosh's patch seems to allow even the
optimisation level used for debug builds to do it, so I guess I can't argue
with the result. :-)

Phil

--000000000000636c870627fdc9f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, 28 Nov 2024 at 17:46, Philippe Ma=
thieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org=
</a>&gt; wrote:</div><div class=3D"gmail_quote"><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On 28/11/24 17:38, Phil Dennis-Jordan wrote:<br>
&gt; Paolo, could we please apply either Sairaj and Santosh&#39;s fix at<br=
>
&gt; <a href=3D"https://patchew.org/QEMU/20241114114509.15350-1-sarunkod@am=
d.com/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/QEMU/20241=
114114509.15350-1-sarunkod@amd.com/</a> <br>
&gt; &lt;<a href=3D"https://patchew.org/QEMU/20241114114509.15350-1-sarunko=
d@amd.com/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/QEMU/2=
0241114114509.15350-1-sarunkod@amd.com/</a>&gt;<br>
&gt; or mine to fix this link error? As neither patch has so far been merge=
d, <br>
&gt; 9.2.0-rc2 still fails to build on macOS, at least on my local systems.=
 <br>
&gt; I&#39;m not sure why CI builds aren&#39;t jumping up and down about th=
is, but <br>
&gt; neither the Xcode 15.2 nor 16.1 toolchains are happy on macOS 14.7/arm=
64.<br>
<br>
Just curious, is your build configured with --enable-hvf --enable-tcg?<br>
<br></blockquote><div><br></div><div>It&#39;s my understanding that both HV=
F and TCG are enabled by default when building on macOS - they both show up=
 as &quot;YES&quot; in the ./configure output, and the relevant -accel work=
s; at any rate, specifying them explicitly made no difference with regard t=
o this link error. Your question did however prompt me to dig a little deep=
er and check which of my test configurations was affected.</div><div><br></=
div><div>It looks like the critical setting is --enable-debug. I think that=
 changes the exact optimisation level (not -O0 but less aggressive than the=
 default), so it&#39;s not unreasonable that this would change the compiler=
 pass(es) for eliminating constant conditional branches.</div><div><br></di=
v><div>So yeah, when I build latest master/staging with --enable-debug on m=
acOS and my --target-list includes x86_64, QEMU fails to link with an undef=
ined symbol error for _kvm_enable_x2apic. This happens on both arm64 and x8=
6-64 hosts, and with various Xcode 15.x and 16.y toolchains.</div><div><br>=
</div><div>I have to admit I&#39;m personally not a big fan of relying on t=
he optimiser for removing references to these symbols, but restructuring th=
e conditional expression like in Sairaj and Santosh&#39;s patch seems to al=
low even the  optimisation level used for debug builds to do it, so I guess=
 I can&#39;t argue with the result. :-)</div><div><br></div><div>Phil</div>=
<div><br></div></div></div>

--000000000000636c870627fdc9f7--

