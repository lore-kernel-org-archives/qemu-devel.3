Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5001CFED2C6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 03:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Wqh-0001eU-L3; Wed, 11 Mar 2026 23:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1w0Wqf-0001e8-SG
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 23:36:33 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1w0Wqd-0007E0-To
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 23:36:33 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-661be3380adso829953a12.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 20:36:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773286590; cv=none;
 d=google.com; s=arc-20240605;
 b=DHSrZCl9jqfMK8RlEuDDtP7zlSWgWGtIXHY2N0ukBny4lLXVE/F4hJiu4r7Hj++shR
 j8Xk+tj1sq0wJDQmtH/roJjNNoYGRmXiCZMPmZWB3e1hUdz1gVQIp/M1oX+mDp4ZwclY
 Q7OYqoE0LROw5zwj+XRp5o9xDWE0XG8BUYzrCO4bIuoW7MTM87Yiyq2IUeEueNJSFFFb
 iwnl7oHZXt0i168NE6aHWR4/6ZovfEOnTKUtI5mEZxtIMLChQqU/ZbQ5jKwwie68uf+x
 pqq3lm4GEFeXqsgndjAqcv+JKDjySxerulktrMsmTH5PqtJWi1ZtBA/k1V74tfiOMwnM
 T45w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3aZIRHDPoHLin/h8vcVQZYWyYev8siTQWlYPsRStsGM=;
 fh=VEMD7nxqOXjDQQle7MI4kK88odUxh+FwiV66Qzd+4lA=;
 b=FFyVlVoTM8kpSC7jdbz53f1LlMxrwLEWf3bGGaKIRtuddNUPKgromowoC4bLF9rtiu
 nCd92u/cNlGToCIFaMPEGV/r7UBmBsyIRAkVkAUOFkp4ifBry4nX21Y2oYIurF/vp0vL
 PnGnofPdVhmunP0v4tjTuv7GeF5Traa+ABlOQPWXr7Zf5qM1iP2y+/p1vaSOKniAfKXU
 WAaHZGlxNStEkSru+g8bIwwS1IimIV48LTP4Gn+HKsUiod1oSzfFU39oDuIuwvEpqRjS
 EiUVYeCeBY+WmiHcRRbQJ3knjHvFvfUIhctCK8ziT1bo6gTV9zBG07ZBM0eVfI5sNhKS
 2BJg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1773286590; x=1773891390; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3aZIRHDPoHLin/h8vcVQZYWyYev8siTQWlYPsRStsGM=;
 b=AZlZUalpJw6Tz8vfCzYNZtppTByGAYNr3sU5rRieFS/k844fYhyS9wE6X7bbD9xibx
 YjQTkOj5l/SQ9kcrmH4wiF7fL44hc82LNXUHMyI7UNe33fLCwsiSwjKItExVINQxK0EJ
 O3MRpQM0p6YhzAwP5+iS7ofJxzV5WJHPBHTfpH8RUkpRdD9Yf7MszKj0WVpkJJikrM3k
 6wh+DydbL1vMnRy5WF5N/d6N2XA1Cb2CWPqWOTSo1Flb7QRC76TFp5oQo4d1x1yXVeAh
 XrsMlH16G35MTzt9Afhb82hwlDSPhA1nJOdwwdwtbNaaoFra++RgfLkbTs1p/iSTJgmi
 xtmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773286590; x=1773891390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3aZIRHDPoHLin/h8vcVQZYWyYev8siTQWlYPsRStsGM=;
 b=SQUWXAGangYIFgA5CFfxm7oMBJuqugXHFo1FeJTa1Lk2DVJgTVFHPkDtEQc3O0zmK9
 4FMZYFh+M946yyi3EsUvtgvHcoTfkVMHLFXDyf91MmNhOgp8/MaeKOb1zk4asjikKfb8
 YFMyHeeGRkxmRPMMc8XtSn7p6hfdJxsSYWSTcn6mb2Vtzuxt/j6SIds1WPzv4gsjrNYq
 z5cRW3JDxNs9b2x4r/scDysgWTVC6JxfcHTfz4qhsGOzlMqmxYrw6V3qz9cqr7bul33S
 S8hNyx5HQ1V3tYbDZTKLFE6lMO/YOU1RZeMb99E8Rq0g2Ny6Sczn9yO96Lj9sJdJexTx
 a8Mg==
X-Gm-Message-State: AOJu0YyEQM3qBv9wYEZAgVnTz/+ie3kYsfiitSO7yQEQkUSODpMTsRZI
 mBKiwmLrLYIOvPcBKHg34+91iQamjXaG86CC4RBZBEsOr2EfHw34V6j9fgJ9/FKKDOXRHU+9ynp
 V9nWcK2HAuPpvmtdGnZr1EDB57m6TkenhhszOMwt7pA==
X-Gm-Gg: ATEYQzzbhdolQl/HAtBuPfLSaOE/z/ZMppGv/hs77EVHexf/yaYaBcTBVlOon+9rnxH
 Nru8CNf0CT+9B0szx21TzDI8hIpa0lwoNzXWjcSsz7LAlahZzP82lluVg2TYqHlLKbxpze+1pp0
 OdbT62/zJb3vTIoxjvbZnyBedURJDdjP8pgiyqP3F4V829shET0FZIfI/w0d/KEjYNKw7c71An/
 LeJPlQkb13SLHufJUwsavjq/VHXFq3qHBhJk0sTp+EGRx/UAT6tlN4+JhqO57WvJHShwABIN4WO
 VlpuBT+58g==
X-Received: by 2002:a05:6402:13c9:b0:660:48f:22b9 with SMTP id
 4fb4d7f45d1cf-663194c5ccemr2519463a12.12.1773286590338; Wed, 11 Mar 2026
 20:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20251209160117.1239596-1-frank.chang@sifive.com>
 <CAE_xrPjvVPqamRqsaqtuvPj930endqTcxRwknY-0_L8FQ_O9bQ@mail.gmail.com>
 <CAE_xrPiutr4Px6yTvf51Rn19-jSFnpBs4sQiKG0OjG+72Xj4qg@mail.gmail.com>
 <CAKmqyKM2++LhEGV9BAsnqzmQOipbR3AD-M1qApPAj5AZRcc51w@mail.gmail.com>
In-Reply-To: <CAKmqyKM2++LhEGV9BAsnqzmQOipbR3AD-M1qApPAj5AZRcc51w@mail.gmail.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Thu, 12 Mar 2026 11:36:19 +0800
X-Gm-Features: AaiRm50AWOv7eEjA2ftfLab7WWYTH51xY5BjemMNFEqi_B1N9Ur-SA60fp0XMkw
Message-ID: <CAE_xrPg0W=9O2ZpBkU83F5bt_4rQF22hNRNn5XUZtU5HNZMSWQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix SiFive UART spurious IRQ issue and misc updates
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000004d69b4064ccb75bc"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=frank.chang@sifive.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000004d69b4064ccb75bc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 8:11=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com>
wrote:

> On Wed, Mar 11, 2026 at 12:30=E2=80=AFPM Frank Chang <frank.chang@sifive.=
com>
> wrote:
> >
> > Gentle ping.
>
> Hey,
>
> Sorry about this but I lost these patches and the ones from the other
> series you sent that I haven't responded to. Do you mind sending a new
> version?
>

No problem. Thanks for reviewing.
I've sent out the v3 patchset:
https://patchew.org/QEMU/20260312033201.1619554-1-frank.chang@sifive.com/

Regards,
Frank Chang


>
> Alistair
>
> >
> > Thanks~
> >
> > On Mon, Jan 19, 2026 at 4:13=E2=80=AFPM Frank Chang <frank.chang@sifive=
.com>
> wrote:
> >>
> >> Sorry, the title should be: "[PATCH v2 0/4] Fix SiFive UART spurious
> IRQ issue and misc updates" instead.
> >>
> >> ping
> >>
> >> Regards,
> >> Frank Chang
> >>
> >> On Wed, Dec 10, 2025 at 12:01=E2=80=AFAM <frank.chang@sifive.com> wrot=
e:
> >>>
> >>> From: Frank Chang <frank.chang@sifive.com>
> >>>
> >>> This patch series fixes the spurious IRQ issue in the SiFive UART on
> Linux
> >>> introduced after commit [1], which changed character transmission fro=
m
> >>> synchronous to asynchronous.
> >>>
> >>> Currently, the txwm interrupt pending status is only updated when the
> >>> asynchronous transmit handler runs. This can cause the txwm interrupt
> >>> state to become unsynchronized between the SiFive UART and the
> interrupt
> >>> controller.
> >>>
> >>> This issue has been observed on resource-constrained systems, where
> >>> Linux reports spurious IRQ errors. In these cases, the asynchronous
> >>> transmit handler is unable to drain the TX FIFO quickly enough to
> update
> >>> the txwm pending status before software reads the IP register, which
> >>> derives the txwm pending state directly from the actual number of
> >>> characters in the TX FIFO.
> >>>
> >>> The remaining patches contain miscellaneous updates, including
> >>> implementing txctrl.txen and rxctrl.rxen, update IRQ when rxctrl is
> >>> written and remove the unused ip variable.
> >>>
> >>> [1] 53c1557b230986ab6320a58e1b2c26216ecd86d5
> >>>
> >>> Frank Chang (4):
> >>>   hw/char: sifive_uart: Implement txctrl.txen and rxctrl.rxen
> >>>   hw/char: sifive_uart: Sync txwm interrupt pending status after TX
> FIFO
> >>>     enqueue
> >>>   hw/char: sifive_uart: Update IRQ when rxctrl is written
> >>>   hw/char: sifive_uart: Remove ip variable
> >>>
> >>>  hw/char/sifive_uart.c         | 46 ++++++++++++++++++++++++++++-----=
--
> >>>  include/hw/char/sifive_uart.h |  3 ++-
> >>>  2 files changed, 39 insertions(+), 10 deletions(-)
> >>>
> >>> --
> >>> 2.43.0
> >>>
>

--0000000000004d69b4064ccb75bc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 12,=
 2026 at 8:11=E2=80=AFAM Alistair Francis &lt;<a href=3D"mailto:alistair23@=
gmail.com">alistair23@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Wed, Mar 11, 2026 at 12:30=E2=80=AFPM F=
rank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" target=3D"_blank">=
frank.chang@sifive.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Gentle ping.<br>
<br>
Hey,<br>
<br>
Sorry about this but I lost these patches and the ones from the other<br>
series you sent that I haven&#39;t responded to. Do you mind sending a new<=
br>
version?<br></blockquote><div><br></div><div>No problem. Thanks for reviewi=
ng.</div><div>I&#39;ve sent out the v3 patchset:</div><div><a href=3D"https=
://patchew.org/QEMU/20260312033201.1619554-1-frank.chang@sifive.com/">https=
://patchew.org/QEMU/20260312033201.1619554-1-frank.chang@sifive.com/</a></d=
iv><div><br></div><div>Regards,</div><div>Frank Chang</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Alistair<br>
<br>
&gt;<br>
&gt; Thanks~<br>
&gt;<br>
&gt; On Mon, Jan 19, 2026 at 4:13=E2=80=AFPM Frank Chang &lt;<a href=3D"mai=
lto:frank.chang@sifive.com" target=3D"_blank">frank.chang@sifive.com</a>&gt=
; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Sorry, the title should be: &quot;[PATCH v2 0/4] Fix SiFive UART s=
purious IRQ issue and misc updates&quot; instead.<br>
&gt;&gt;<br>
&gt;&gt; ping<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Frank Chang<br>
&gt;&gt;<br>
&gt;&gt; On Wed, Dec 10, 2025 at 12:01=E2=80=AFAM &lt;<a href=3D"mailto:fra=
nk.chang@sifive.com" target=3D"_blank">frank.chang@sifive.com</a>&gt; wrote=
:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com=
" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This patch series fixes the spurious IRQ issue in the SiFive U=
ART on Linux<br>
&gt;&gt;&gt; introduced after commit [1], which changed character transmiss=
ion from<br>
&gt;&gt;&gt; synchronous to asynchronous.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Currently, the txwm interrupt pending status is only updated w=
hen the<br>
&gt;&gt;&gt; asynchronous transmit handler runs. This can cause the txwm in=
terrupt<br>
&gt;&gt;&gt; state to become unsynchronized between the SiFive UART and the=
 interrupt<br>
&gt;&gt;&gt; controller.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This issue has been observed on resource-constrained systems, =
where<br>
&gt;&gt;&gt; Linux reports spurious IRQ errors. In these cases, the asynchr=
onous<br>
&gt;&gt;&gt; transmit handler is unable to drain the TX FIFO quickly enough=
 to update<br>
&gt;&gt;&gt; the txwm pending status before software reads the IP register,=
 which<br>
&gt;&gt;&gt; derives the txwm pending state directly from the actual number=
 of<br>
&gt;&gt;&gt; characters in the TX FIFO.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The remaining patches contain miscellaneous updates, including=
<br>
&gt;&gt;&gt; implementing txctrl.txen and rxctrl.rxen, update IRQ when rxct=
rl is<br>
&gt;&gt;&gt; written and remove the unused ip variable.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; [1] 53c1557b230986ab6320a58e1b2c26216ecd86d5<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Frank Chang (4):<br>
&gt;&gt;&gt;=C2=A0 =C2=A0hw/char: sifive_uart: Implement txctrl.txen and rx=
ctrl.rxen<br>
&gt;&gt;&gt;=C2=A0 =C2=A0hw/char: sifive_uart: Sync txwm interrupt pending =
status after TX FIFO<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0enqueue<br>
&gt;&gt;&gt;=C2=A0 =C2=A0hw/char: sifive_uart: Update IRQ when rxctrl is wr=
itten<br>
&gt;&gt;&gt;=C2=A0 =C2=A0hw/char: sifive_uart: Remove ip variable<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 hw/char/sifive_uart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 46 ++++++++++++++++++++++++++++-------<br>
&gt;&gt;&gt;=C2=A0 include/hw/char/sifive_uart.h |=C2=A0 3 ++-<br>
&gt;&gt;&gt;=C2=A0 2 files changed, 39 insertions(+), 10 deletions(-)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; 2.43.0<br>
&gt;&gt;&gt;<br>
</blockquote></div></div>

--0000000000004d69b4064ccb75bc--

