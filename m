Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C076FC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2QJR-0007QP-7k; Fri, 04 Sep 2026 05:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x2QJP-0007Pq-Ig
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 05:34:19 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x2QJN-0004o3-KN
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 05:34:19 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-69c600f76ccso974601a12.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 02:34:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788514456; cv=none;
 d=google.com; s=arc-20260327;
 b=MOI6M/GJFv8lMyY3/M5h81aFrqNTgB2j+N4iQlsvxoMuSH2S7KmM99NIFW6H8swaiF
 VgaCBpJFRZwwXXkg5fmo2Q+P2nVUwPvnsYbByCL3l4qqJedZmZ0N/LnJsnbo1vnf498b
 U+ZDfFr6li4ofd32INF/GWHPFiO50FdGK2mc9P1buDy0YoHWeLQkiV/cbDwnrNyTH0AN
 vPzmd1DCv3WR8VJf+bCcG6MW1WlL6hB+fkuB5/TVYBcfk04gcqwY5nCvfYp6U2XOKFHB
 WHFKMh4RtRD6NHVgOhgSItDwND2fizc6WZAU5A3J1eRCWTBIm7HjJ+Tbs3D4tQSaBmzk
 kmfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lUO/MyQnDLrJzWdEDIpQWxebpjC1uaCOl8bmgpaSGpU=;
 fh=WpoE+J7qjWbQBvF/7d4VGMKYu4dLmbF3eo9l8GCnJSc=;
 b=JDlNnJcrKJxOFn2sqp1EsqAVvjzB14IIhEzo/H3v1OslyAQvOpsrf72Smw1yIHyAxM
 IjNxeYHPfM3jmWlcgVs/6XWr+m0D6QiLyktsBBqKYIdlWNKJwiM7RzQB2nz7QB4F9Aeq
 O0kAknAWQ9b+AwzIR8xxrNkVO680IMmtij0hdX48j5EbuFwNUbxZP70d0T3AdmECrGU6
 jljQTBzVkT+6xKod+VEV4Awek/16lzRqOST6/Kc3R3B60HFuzpEPt9kGIQIRrsoNfODU
 TEjdBXI2xqcHXORu6yxJAvpQv3W+v0LWJJc/cayAaJ4Dc1s6xzW21Ae1nqamNxF6CC+q
 sDWQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788514456; x=1789119256; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lUO/MyQnDLrJzWdEDIpQWxebpjC1uaCOl8bmgpaSGpU=;
 b=cedKonshsAtV4+Ld2LDSRZKQIUIFfirembfT/vJz+/V/4iT+3vZIyC7RNGo2nZZaYI
 ATWf5RC3I/rpsKGaazGkoR7Xecv+HCDQ6E3yg4C2uZcJCQT83ZuTXQEre2eSuiXynJTr
 O8QSVE0lW+ILGZ7KrapuTWkOk8viZ5e8JVb/fNeFfat3ukEhNH4Vf3oxH2UYE4uYzvi2
 kH0FvqRiTHzrtNe0070FHEWjNQE9UripxZPxJu92SnTxCO4MHM4aEesDsU7u6OJvA2dM
 PP5K8UdvdldDN63Z3/RJjbBm5/KIOST0T+mQD9Ac6K+TlE312XSn5w45dPm9F6L31X3+
 +dZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788514456; x=1789119256;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lUO/MyQnDLrJzWdEDIpQWxebpjC1uaCOl8bmgpaSGpU=;
 b=dbMZTefIRokDgh6VUr7pwZh8zZ5tSwuDdz6MawvGvyEHG7rnJdSUoaB3Sxq4WHmDAo
 obqR/cgyuhEtOKyxBVYToIKzd4CHugWHfsIcnuTNzilZhZF386Jpicy4pGT9mZZPT0No
 JJVE4wf6XotiDVWlHT9C4Z1JLNqumAFCP6Lw2srFcPrvFe5IVY5MwKsu2nXke7NGDhgS
 YrZ+NF5kLT5qj8mxBJAcjKFEf21xsZRHikg5kwN476spHE8E6FCkKGBHicIQZ1yUtgV2
 u2kW06izQXIhOBHXHQchWOZmDLNm8mGJY9cG+TOmB5I/P4ZAoFsimCd+8zWQz/T+fEuX
 Afbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxu30HzIKkPED3a5xQPR6WTW8NzXFBJboT0TBVqeWs0lOM3D+lC+nfE/YgiWqlCBHxMkfZMFywAeIzS@nongnu.org
X-Gm-Message-State: AFuF++n2Nb0xytsDoQJMF2MfdN3PhWN/Pde11QDA4wV2U3cr57Dwlw2y
 8z/snNUkHYNvrgy2VYZb6+onQfJuuLRLG7pzrj/21NEuw32rgDFaAm9yNKqTzPwFesxzdXqy9f9
 PtVmRbk+8oP8X/vPiK01Lf8+XO3t+qJE=
X-Gm-Gg: AYBFou2aNJfoNnPIu4y3ydIQbdaFGntR/gIsxj4V/u74Un83kG/SLwGr6NtLRtKXNhp
 QH0f2n/pBQz7gpzY7aKsP6iKhOMnPlATUCJXaGVOGIlpG5RMh76wyFvLF6ALFCVnt5RFFWkr13K
 dFqc5qx+vE6ue/eGj0nxKH9HcvFIKzjkMMBo7zmKcnpbV6E5vDxacIM11sePo+p9wFwjXbpoRvh
 xlenaMtIP+NcTmnM+WxkJxmOL2nPGiFD5x5CKNfZ53NL057zNXgc8OwFh5DyyznKAjQy2XwT3aP
 dgSnjkzKpanFmQNRiJM4d0Dhcx4Xcrlfm2x+FsXcF3C3
X-Received: by 2002:a05:6402:2551:b0:6a7:ee54:f893 with SMTP id
 4fb4d7f45d1cf-6a7ee54ffefmr690461a12.23.1788514455775; Fri, 04 Sep 2026
 02:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <4b4f77ee-21e9-405e-a1da-21506afa1c5b@oss.qualcomm.com>
 <app_CnHimOrOymMH@redhat.com>
 <CAE2XoE9A1WzOe43-qd1v9i6K9kSru4R2kEE1-2TrztoM=8NZJw@mail.gmail.com>
 <CAFEAcA_4TZxYhFbHfJZCas7bvh_KZjNp2aKzx3LPaXTQFuoQYQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_4TZxYhFbHfJZCas7bvh_KZjNp2aKzx3LPaXTQFuoQYQ@mail.gmail.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 4 Sep 2026 17:34:03 +0800
X-Gm-Features: AcwNN1Xl5YU06-cV8wugPb5R-s1Ye_KtlkKcNzDGisDZ5zUAIPWIPbSxMYkoaPc
Message-ID: <CAE2XoE8FTYQMDZFdjf=gayR7H0MJrO=thUcFXddRWBd3_2KQZA@mail.gmail.com>
Subject: Re: [PATCH 00/47] single-binary: implement dynamic filtering for QOM
 types
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000cff137065aa4f861"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
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

--000000000000cff137065aa4f861
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I was wondering if maybe one way to approach that is some
> "disambiguation" syntax on the machine name; so one could write
> "-machine aarch64:virt" vs "-machine riscv64:virt" (or whatever) to

That's the Proposal B: target only in -M or argv[0] (alternative)
Do not add -target. The target is always embedded in the machine
argument, or inferred from argv[0].

- qemu-system-aarch64 -M virt: single-target from argv[0].
- qemu-system -M arm:virt: single-target from -M.
- qemu-system -M virt: error (heterogeneous not supported yet).

There is no global option that selects TargetInfo before -M.
Early option parsing still has to read -M (and argv[0]) before
machines initialize, the same as proposal A reads -target.

  qemu-system -M help
  qemu-system -M virt              # error: heterogeneous not supported
  qemu-system -M arm:virt ...
  qemu-system -M aarch64:virt,gic-version=3D3 ...
  qemu-system-riscv64 -M virt ...

at:
https://lore.kernel.org/qemu-devel/CAE2XoE_-ewv3iC_MZ2sM1eKG=3DCUKM7MZa-ppJ=
V0Vk1rE1h+19w@mail.gmail.com/


> disambiguate when just "-machine virt" would be ambiguous; but if
> there's only one machine of that name then just "-machine foo" would
> work. That extends nicely to truly heterogeneous machine names:
> "-machine my-mixed-machine" wouldn't need the user to explicitly
> give it a -target option or otherwise say that it includes aarch64


Seems this direction is fine, May I post experiment patches with this
direction?
The machine-filtering is still needed. and when the target is not specified
by machine parameter. The default TargetInfo will be target
SYS_EMU_TARGET_NONE. And it means emulating heterogeneous machines.

> and microblaze CPUs. (We'd probably need to put something in to
> prevent future machine name clashes across targets, so that the
> only clashes are our existing legacy ones.)
>
> This rests on the assumption that the only thing we need to
> disambiguate is machine names, i.e. there aren't multiple
> targets with user-facing (i.e. not easily renameable) device
> names that are shared.
>
> -- PMM



--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000cff137065aa4f861
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>&gt; I was wondering if maybe one way to approach that=
 is some<br>&gt; &quot;disambiguation&quot; syntax on the machine name; so =
one could write<br>&gt; &quot;-machine aarch64:virt&quot; vs &quot;-machine=
 riscv64:virt&quot; (or whatever) to<div><br></div><div>That&#39;s the=C2=
=A0<span style=3D"color:rgb(0,0,51);font-size:13px;white-space:pre-wrap;bac=
kground-color:transparent">Proposal B: target only in -M or argv[0] (altern=
ative)</span></div><div>Do not add -target. The target is always embedded i=
n the machine<br>argument, or inferred from argv[0].<br><br>- qemu-system-a=
arch64 -M virt: single-target from argv[0].<br>- qemu-system -M arm:virt: s=
ingle-target from -M.<br>- qemu-system -M virt: error (heterogeneous not su=
pported yet).<br><br>There is no global option that selects TargetInfo befo=
re -M.<br>Early option parsing still has to read -M (and argv[0]) before<br=
>machines initialize, the same as proposal A reads -target.<br><br>=C2=A0 q=
emu-system -M help<br>=C2=A0 qemu-system -M virt =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0# error: heterogeneous not supported<br>=C2=A0 qemu=
-system -M arm:virt ...<br>=C2=A0 qemu-system -M aarch64:virt,gic-version=
=3D3 ...<br>=C2=A0 qemu-system-riscv64 -M virt ...<br></div><div><br></div>=
<div>at:</div><div><a href=3D"https://lore.kernel.org/qemu-devel/CAE2XoE_-e=
wv3iC_MZ2sM1eKG=3DCUKM7MZa-ppJV0Vk1rE1h+19w@mail.gmail.com/">https://lore.k=
ernel.org/qemu-devel/CAE2XoE_-ewv3iC_MZ2sM1eKG=3DCUKM7MZa-ppJV0Vk1rE1h+19w@=
mail.gmail.com/</a></div><div><br></div><div><br>&gt; disambiguate when jus=
t &quot;-machine virt&quot; would be ambiguous; but if<br>&gt; there&#39;s =
only one machine of that name then just &quot;-machine foo&quot; would<br>&=
gt; work. That extends nicely to truly heterogeneous machine names:<br>&gt;=
 &quot;-machine my-mixed-machine&quot; wouldn&#39;t need the user to explic=
itly<br>&gt; give it a -target option or otherwise say that it includes aar=
ch64</div><div><br></div><div><br></div><div>Seems this direction is fine, =
May I post experiment patches with this direction?</div><div>The machine-fi=
ltering is still needed. and when the target is not specified by machine pa=
rameter. The=C2=A0<span style=3D"background-color:transparent">default Targ=
etInfo will be target=C2=A0</span></div><div><span style=3D"background-colo=
r:transparent">SYS_EMU_TARGET_NONE. And it means emulating=C2=A0</span><spa=
n style=3D"background-color:transparent">heterogeneous</span><span style=3D=
"background-color:transparent">=C2=A0machines.</span></div><div><br>&gt; an=
d microblaze CPUs. (We&#39;d probably need to put something in to<br>&gt; p=
revent future machine name clashes across targets, so that the<br>&gt; only=
 clashes are our existing legacy ones.)<br>&gt;<br>&gt; This rests on the a=
ssumption that the only thing we need to<br>&gt; disambiguate is machine na=
mes, i.e. there aren&#39;t multiple<br>&gt; targets with user-facing (i.e. =
not easily renameable) device<br>&gt; names that are shared.<br>&gt;<br>&gt=
; -- PMM<br><br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=
=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =
=C2=A0 sincerely,<br>Yonggang Luo</div></div>

--000000000000cff137065aa4f861--

