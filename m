Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB21C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wztih-00039Y-EK; Fri, 28 Aug 2026 06:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wztig-000372-F6
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 06:21:58 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wztie-0003XQ-Rg
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 06:21:58 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c2074710751so102857666b.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 03:21:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787912515; cv=none;
 d=google.com; s=arc-20260327;
 b=H1ZSBfiDgENtXYpoMAayvU6JlcRNWUyxmXII9EVLoUoqZbjYzXHF21uVRfY5T1PPAz
 I5bHjw/AG0zo4roBee0dxqZVlM8xixNzud+e8u943+bMyOSWhL52SmjddRkOTq7lmNa6
 f/FpaJOhLasdaIMo/HHcsMdPbhiKnWq6v2WyC35XPxWzg8BZ3+6ndwuXyBhOxKlgAlSe
 5oUIKwENqLBSX5aWjcKoWAh31ay3D+ssiijMBDW5Z3BI5S8nSaGYLBkbv5KDrS3Ula9M
 T69BnTLQHSaFePomPZJV7WPQimJLdzsOe1pSmz7AcJ2vO+AKi9/APNMJvFHDrbbTL45/
 n/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iOgFjmurBo+vQH4uZ/wrcBoAmGvzMwHTc/M4IC4/eVg=;
 fh=orjNIa438wHugFGPNg3Bbd+M7L4r13hWQausNpg9bVI=;
 b=EG0s+k3kldKq7HkvDpRYa20BGZFUkBfXXigAwMaXTemVHutIzqtGvOqXPrqYh8kLbe
 NeV7yXwKXOzaWw9JdBSbbSfdRZP6aDU/+zKBbMrnJ4NXV9M39v34/E+2War1ZZoosIl7
 grpkYi8kBGeBoE1fM0fZzSN1kBJo8CkqxJqqys7G133bsNqG+oIlDD0rcY37zxFOuJTs
 Nt326WQKfN+N02eGa2ODXT9zDPPpwyTH+dGXVmjo7viI3jF/ujIBKs+ctlHbFZy4fsqQ
 YDMGpc/xfZZgbmrw3Li8fxpwSkSZSEmXOxfOM2PmKxPzRvPT4wxM+RJYg6/+KR2lvPEh
 JS+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787912515; x=1788517315; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iOgFjmurBo+vQH4uZ/wrcBoAmGvzMwHTc/M4IC4/eVg=;
 b=o8vgqcy/XoSqwbMWJXz0bTnX17vLEIOyNJM20rZ6e6En38YN1fyBJ1T89ZkW4QORgw
 RScv+HaA+ustBXd0YAO7NHCxCGGnCTpcHUC2zORjof07LrHF2Vhkqv0cKrjtqDWDpmwX
 RRvzp5m9GJ8wDcGx4q4FWG1yae5zTB9iShFz+D5k9sdJOYAgvvriaApFTT91T+9b1v17
 6V+Vj2uuBsyecg1b0t1JI0BrXN45QmPvWz+/h1QMswGfqwi31QTLBCmdDnlrtup/ah21
 h6wZJy4SyyQn0FVTGW+0RYXV4vKOGG+OpmZ3zgLIllQXiW+e93HtViARN/gfvxMPv5Rx
 QytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787912515; x=1788517315;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iOgFjmurBo+vQH4uZ/wrcBoAmGvzMwHTc/M4IC4/eVg=;
 b=VBa9FNwI2PfrSjsrXb9+P6e9fyEQT2mLb/utJsdFNgLTJW7onebGZx+y0jT1wrVzFE
 dvbrH1PcCvI+JTXX+KyKbuEh/OjE4vDlNTPD09MHjeLJlbPVmJIbke3YuDYpD700rhKh
 fv6xGnQU3MJgk9F4Hy3wSc++G9jJrqWO59HU5O3cIvCQiomaPfwyk9muJkOSU1dVGZ1k
 t5xld2j8YLlG6O1EDE31BP+i7+fpXw5lA/+EDWSg39A5xXJ7aY2tf+rXQa4uwBy7JeRn
 pVEbFSF/wE3t1bC3dexg08vSgMmL4/rkcjnPdUvu0b80gr79EijgrKOPQelCTOSU+L35
 NlMg==
X-Gm-Message-State: AFuF++kVMS8Eo5zYeH74geBYpUo9616D05GzASTlSTu3d3CeYaxeDEzb
 VOgCMq0i/OSmU9SYp+7N4ptGXwuCpr7uTuRuhch57NcyVPNSq2QsNbPI+kPMCtvx1Z4hyJIaAAf
 e96A4h0I5tt1hY9WQnOsvRT34ivG1i3ehlGm3ARC42w==
X-Gm-Gg: AR+sD11bF30+uTmhvactABZeZhm056kQhVsjXO72oKHfF37yL/C2InEQw2cLXuXs8Mb
 vPJv0qQhd0trclDVpLC1VlytKDsCptuDjY+0QYaN/RX5LNNFYp8PYIA2GE3orezzF3NZe8XusgH
 udCnZEYXM6ikoB8TXqYGLXj5nrHoaev140ePVQXehRFPIoV+fJRdsYJyCN1jtGqDEoWb30cn1e/
 YtASHz3oKgVvS3OiSOpJ7BUYVc8E+ZJhLJYyAjfNxs7B8A0z0yCikcd2h2RH5rCOc+LjP3PxqhH
 S+cN8TGvLllcvRwVp7csjneTP9LRm4wNA1BO7LdAwHqK
X-Received: by 2002:a17:907:9618:b0:c16:66dc:3ab7 with SMTP id
 a640c23a62f3a-c2556db59a9mr403520566b.10.1787912514969; Fri, 28 Aug 2026
 03:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE_-ewv3iC_MZ2sM1eKG=CUKM7MZa-ppJV0Vk1rE1h+19w@mail.gmail.com>
 <23f04b70-b78e-4234-ac97-2feba4d38b0d@oss.qualcomm.com>
In-Reply-To: <23f04b70-b78e-4234-ac97-2feba4d38b0d@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 28 Aug 2026 18:21:42 +0800
X-Gm-Features: AcwNN1WCvUIHL12K3uOYgO0eRVD1rc3L0b_V0EMiyaDcGyEsqzjDHOinkOx08-s
Message-ID: <CAE2XoE86KSO8KYUkM9nz2ktPD4dnLxbiUXW3H7-dzjr0VDNZWw@mail.gmail.com>
Subject: Re: [RFC] single-binary: merge experimental qemu-system before
 filtering
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-level <qemu-devel@nongnu.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Type: multipart/alternative; boundary="0000000000005826fd065a18d25e"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x631.google.com
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

--0000000000005826fd065a18d25e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> The 'heterogeneous emulation' comes after (and only after) that.
> It is a disruptive change, I don't want any of the current


Hi Philippe,
I mention  SYS_EMU_TARGET_HETEROGENEOUS because I need to handle command
lines `qemu-system -machine ?` or  `qemu-system -device ?`   that is not
specified -target. and then
we still need to list machines and devices and not error on it. That's
raised from the v1 review of my draft patches.
Now I think SYS_EMU_TARGET_UNSPECIFIED is a better candidate. that's not
related to  'heterogeneous emulation'  at all.

--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000005826fd065a18d25e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span class=3D"gmail-im"><br class=3D"gmail-Apple-intercha=
nge-newline">&gt;<br>&gt; The &#39;heterogeneous emulation&#39; comes after=
 (and only after) that.<br>&gt; It is a disruptive change, I don&#39;t want=
 any of the current<br><br><br></span>Hi Philippe,<div>I mention=C2=A0=C2=
=A0<span style=3D"background-color:transparent">SYS_EMU_TARGET_HETEROGENEOU=
S because I need to handle command lines `qemu-system -machine ?` or=C2=A0<=
/span>

`qemu-system -device ?`=C2=A0=C2=A0<span style=3D"background-color:transpar=
ent">=C2=A0that is not specified -target. and then</span></div><div><span s=
tyle=3D"background-color:transparent">we still need to list machines and de=
vices and not error on it. That&#39;s raised from the v1 review of my draft=
 patches.</span></div><div>Now I think=C2=A0SYS_EMU_TARGET_UNSPECIFIED is a=
 better candidate. that&#39;s not related to=C2=A0<span style=3D"background=
-color:transparent">=C2=A0</span><span style=3D"background-color:transparen=
t">&#39;heterogeneous emulation&#39;</span><span style=3D"background-color:=
transparent">=C2=A0 at all.</span></div><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br=
>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div>

--0000000000005826fd065a18d25e--

