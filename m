Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC24C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 05:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBQPa-0005ta-Kb; Tue, 29 Sep 2026 01:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBQPU-0005rY-QV
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 01:29:51 -0400
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBQPS-0001qa-Pw
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 01:29:48 -0400
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a6063d7dc4so4590243a12.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 22:29:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790659785; cv=none;
 d=google.com; s=arc-20260327;
 b=RlBxb4iXrnwPYNgQS8wsfxQojWBqjaN0FIQcAI4gxwbjSELqaaueojZ628u5iV6DQs
 z2VVVVz5+Fk/fDzwe/h57D8v0IiBCWLKFB5mm8Er9GiLV/wYbPX6oG0Fo4K54D2TS/Ab
 seBc88Jb3rPHKWLinBdmgaHCFCSQ8rMHdQEGSLGC0xk1noALTNddhXt1mAer7RgbcBVL
 5Zja8yvpHWd6/KMYLoFMQbVuJa8wdT+yDxJPywUfDE07t7r2uUT+5Y8BYgdUdcmfmy5n
 Jh5C1oo9zqa6bE3YfOGytZLXHbyc2rT6j2IT1uWx4X29QjLIwBD8hUCY8jgb1612z30p
 0g+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=xV5ttRcpYOm4eTqxOEwdri0P3mUYdyXck72/42+CiY0=;
 fh=/XhB7PTqpds2+yqfZ8mzcKXS0fqCEV1XQQIG8MCCxOU=;
 b=MPaKYDKK4PQfHI2GdhRXCRAXMGFU+r0hrgHUby/zqTaQlMLk24VESZw9QYDwmRsBAd
 JS8J7nu693N0TwgY7k4Ak/RJGw6G2/z1z4QTi2OauNGVM85qvDnL1vlkcJL82NMmH/vg
 3XrE7rgaADe/C1Srm/YN+x9w9YLU4Z3jZFcA33KbTH+oncAcqonGzxX/Q0Zc9oWlOvS5
 z+u1N1Gq40JJXI6cNZUPUg4AbkgeuZRzf6u7AeZa4DUGX6RuTFyiGT92xYe53i3FRE+X
 /79zJT4VNjtaGshzL6zy0hNkGTW98zOWyKaKLWz+e5F35/pFRZFlcgx8DeQ/rKS3KNc4
 GAcA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790659785; x=1791264585; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xV5ttRcpYOm4eTqxOEwdri0P3mUYdyXck72/42+CiY0=;
 b=BgTyLnyUnvvMBYn9DZ+sHxS2v5VhPjKsSzIBIVlZiXq8+bM+SMK/5UpsTI7e4zzj4B
 nfuoQ/fGI+dFt29CUsqlQ6K1b7tgyuBbPBlUvWaMHjTD3qwXSvQkPaHTPFDjKybdA04j
 6JN06BcWsbTHsvoFTdyYWMPEikCNJzHxn233weY4ERJliaAoOS69mYlhPlEKKUQw/kro
 Sz8Kj2J11PgjlMX9Bu6RxbhOP6ULc+rtsKPFhQolj1CgljQE6q0ZBZS7j0xBdDxCO6rt
 K/jbZbnB7/FfiZa9sZdYnXPc6P7pTWcti3UoQ9N377sAMc+ejJn0lHdlPuF9NEnrYu4H
 kOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790659785; x=1791264585;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xV5ttRcpYOm4eTqxOEwdri0P3mUYdyXck72/42+CiY0=;
 b=lN6dZxADBKekpSUvLWr3PYF7qv6DWNy1Zvj2b/52XQwfobfYJfr4v8Vx3WfQHY15G0
 /12Iwp6EuT2aOBPLvQL1iKOAmH2vHxYQjIBopaBF7V463K2x7QpwhQ9iqk+7pgHmPsVn
 ePsh876E7R+yaZRmrx2qTinAZ51gwjabz0BqLcBWSMCnlsLQt3xlsn8ob4aOBOegJuAZ
 3pcoYnmZWOx32t5JsHBlrFoIjg3tkFdUF9PDvps0D7gTV0Bv7ZdxdqaLin3MHzm/pHdt
 iWYofEanqSHGyoVDbmpWFG1x7+m4yBwIqv4KA9Ig/2JJyXCyrr40FyyRKyu4IUBxumnX
 ZKVQ==
X-Gm-Message-State: AFq9FYI70GEOxfozDGUB3afao2mRs9c5OFGpsOlD1sd0KNnTVLRyZH9x
 cTUusNcIa7hCBCTFFH1/DTNaszXCQ9dXLRueugbpHyHfm5z7zJD7P3sTim9KFsWcLqRrVcA78MR
 oxOifEUizI7JvxRrGB1f8YjfElxkVkoM=
X-Gm-Gg: AYBFou34GGe1gztRx2HlX7NXX2EbNGRfWbwt4WumkkpIq05+FznugxXqClg5IfEeBtG
 0t0iEWVQwX46A2sY75nTxlYqt6uHpMhYRbVRv5LHeIbFvh0MFvWqJl84+TXzAcWIBDGRHFEbXd0
 V1odAmQYT/y0QcIp2Yt9pZiVLTczUVLzanToEdX85kcg8yMFZMdluql/4HazTWupTPm8yQqaapI
 liLyWgMxW//GmSOSfcQlmGDMEYLL2biAHgB7EmYRl008NMoG3CXhyIst+KwYPZVzWqTxiqE77V3
 5OhaQbQRWm3ey4HA3UbdT2Qrw5QYHTnR2vRKlizNX1mfFCwLefaxEwbapaSIZmslgw==
X-Received: by 2002:a05:6402:1d4d:b0:6aa:734b:1a33 with SMTP id
 4fb4d7f45d1cf-6aac90a25d0mr12269867a12.45.1790659784584; Mon, 28 Sep 2026
 22:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260928052051.251-1-luoyonggang@gmail.com>
 <20260928052051.251-5-luoyonggang@gmail.com>
 <0c156b42-3476-4ac3-bd29-f4e878108f0c@oss.qualcomm.com>
In-Reply-To: <0c156b42-3476-4ac3-bd29-f4e878108f0c@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 29 Sep 2026 13:29:31 +0800
X-Gm-Features: AclHuK-hBYjfdyUtFue77G6Rrnmj0ZHq-R9b0MFpLMGayDCYUEm7imkFjKaFk54
Message-ID: <CAE2XoE9VC6YfqsOQBM_KLrdaKpU-=bD9CscCDGi63EsQt-EhFg@mail.gmail.com>
Subject: Re: [PATCH v2 04/24] target/rx: name guest trap numbers RX_EXCP_*
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 Chao Liu <chao.liu@processmission.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Stafford Horne <shorne@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Eric Farman <farman@linux.ibm.com>,
 qemu-riscv@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>, 
 Glenn Miles <milesg@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Song Gao <17746591750@163.com>, qemu-ppc@nongnu.org, 
 qemu-arm@nongnu.org, Michael Rolnik <mrolnik@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x10.google.com
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

On Tue, Sep 29, 2026 at 1:26=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 28/9/26 07:20, Yonggang Luo wrote:
> > Add RX_EXCP_* in cpu.h for the guest trap numbers stored in
> > cs->exception_index.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >   target/rx/cpu.h | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/target/rx/cpu.h b/target/rx/cpu.h
> > index 64ba48a7329..521e494172e 100644
> > --- a/target/rx/cpu.h
> > +++ b/target/rx/cpu.h
> > @@ -71,6 +71,16 @@ enum {
> >       NUM_REGS =3D 16,
> >   };
> >
> > +/* Guest trap numbers. */
> > +enum {
> > +    RX_EXCP_PRIVILEGE_VIOLATION =3D 20,
> > +    RX_EXCP_ACCESS =3D 21,
> > +    RX_EXCP_ILLEGAL_INSTRUCTION =3D 23,
> > +    RX_EXCP_FPU =3D 25,
> > +    RX_EXCP_NMI =3D 30,
> > +    RX_EXCP_INT =3D 0x100,
> > +};
>
> Thanks for splitting in a previous patch, but we want to
> add the definitions and replace the magic values at the
> same time (i.e. the changes in rx_cpu_do_interrupt() in
> the next patch go here), but also s/21/RX_EXCP_ACCESS/ in
> update_fpsw, etc...).

Do you mean add a single enum value in a single commit? so it can
be tracked clearly.
So when RX_EXCP_ACCESS is introduced. all usage of 21 will be replaced with
RX_EXCP_ACCESS?



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

