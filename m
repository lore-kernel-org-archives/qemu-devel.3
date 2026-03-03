Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651F2EDEBE6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 19:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxV3X-0005m2-NX; Tue, 03 Mar 2026 14:05:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vxV3V-0005lK-Sj
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:05:17 -0500
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vxV3S-0004Rx-Lc
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:05:17 -0500
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-2ba9c484e5eso5633557eec.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 11:05:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772564712; cv=none;
 d=google.com; s=arc-20240605;
 b=Q+43IFsgqhGM/x3/ZqxgoaM654FXilO8wKTeg9MzsTsDAXKG4ZrslgXvqMLc5sTKly
 PP5cLwJoJ/IGsPGrGh9vZ0QxO5qAroXL2Gs3oX8B/1cEd+diqYMo2OAhncjEhW8eNU73
 z5FBj+luHrrvrj/eHBdPZLhi73TBUtacv700Rz3z5HwQy5EYgWHaRWZt12I7weFCSzNK
 sW2n4ZkINrXDz4XHQZ11JewcNE/zcge6cH34pCAo9Cu373VIFWwH6MCUwCkQxMQ1TK16
 WuCN1EpJiSnGtOKlh8hWKo/36uBLVQPW4tqh/tNVvWxj/DTxLbJS/uZq+4BGGNwifWZS
 dexA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/JU+Yglg3bp3vp0f6IoRqu/4RbRUFFqO6dRbMWFLiNY=;
 fh=82RydcbdAql7fhbq7RYqN7Rlqd/aGBUQJq1T6XQ45DQ=;
 b=S46r2DSfiB5mAERJSKk9un6eCSBQ4KZjP9V1khrN7ufE1Yj8kvaPafgyvOyTfdYoqV
 QXam1XzFzieDhRCotEZ20XvVtFn4EdFslVwhgvMAv2kLU0Og+R5LpOcIItZGwvwxt6il
 JKGRCxdIQL8lZGJocJl1LymAlvAefekULBZccE5VkoZ6/UDLceR0WyccdI5IeASosd2Z
 DE90+f5GL2TiXhhRkEF8SZYLoCVHmKOX5fE8vW8CJzmjXS0Ts8GHk9TvKavHcxnWbWdT
 3xUn+jjqA8PZsvPOSi1lk2DrU93DuggCu93ivLOH6HfWR2VXpeTxpGJPvgu9SGUj/BS8
 dQHg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772564712; x=1773169512; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/JU+Yglg3bp3vp0f6IoRqu/4RbRUFFqO6dRbMWFLiNY=;
 b=YjKDvC6fSHWzmrthPXRWZmv4AUZETfqzSfNo64bMhCINidmxQIqpnllNpvH5hQx+Nz
 h40YipB+3P2nJZzfJSMLUyPH88sHQhZfuo7sBCOQBBN+gqEaPsrhWyR0FlmmHsB3Mm99
 OzzcFcxtb5OhjVqRZBYlFx1qYmwqjJSuWDZ8FPMN6/lMDY5Sh6ND1YY67jAjR977snmf
 YPwJqP1zGsxqrI60Z0VECbMZoE9SXaULSAxgfSk9rt+5r32ySubgTqx/eWSbYHLXUN8j
 eIpNmDNWt9XszrpUOsqQkkVMUdu+Z/v1wfXum8ovcLLN5kb8tUVSEc1xOqyMGLNT+pkG
 TZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772564712; x=1773169512;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/JU+Yglg3bp3vp0f6IoRqu/4RbRUFFqO6dRbMWFLiNY=;
 b=X0/vTg4lUwtJNYD3pdOATPXN/rLRVDjLvvo/AmKOj/604E9zlLoVy4vkf35Lq7kh8r
 pejXiXZBbrOSnVmULL98obYL9bZ/EWcfGm2AFHYJpP/RmtAlqqwemkXrZg8POLiVLvYl
 /8OkRFxmKL0p5yVkw2uHxtdoyCo1laY/C65YqjHYFVmbE8D+Q+9aSkXylrgrINFSDi6Y
 B25EtZXd+fZHRC3zZCxdpu9xsVnB5pyontnvi2bkj/jjtWaHIJtCwJBPUq2BMmJol8wQ
 WMK5jxnuPvnWhtKv5fdYruzApsmTx1jv/686WPkLHHlYJUPOY1ARppweVU19Rqg0zv/K
 63+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrCtJbNL9CMnOtAOOOGAuHGFvMtHPPR7wfUzX4AXHVGIfw8F1NgohMLvUHU2wIt3OVZa+TLokb2/+g@nongnu.org
X-Gm-Message-State: AOJu0YysS0SFsH/X57Ar7JfMhPf7nQ5MZVhZZ13q5JpmMCjOv88ZRn2V
 Y99oh9FYTH/vCEpy/jV+SbYUSpt7Qn/HdeqP7PExUxEZRRGwzO6ULP5iKgsPt7l6ff/atAsTB56
 FWgXxg3T2iJZa2SfE+Y36igJosjPv6Zc=
X-Gm-Gg: ATEYQzyI6UI1ybVkuJZk01e/o1BG5ysfIga2XniRtvit2NENWDaEj1LVqbjrnn+NQRr
 0it3a8iVsZyghtNoJUgHI27HADunQVLtan8lcPa8n91lU35LAlHyYczuUxKudwQEg/SBbHhXtnS
 uQ6XdYDTZZYQUy0f/48FHSHPXYsTY1lcaU57HTA7MpHsKT7qh0ZuuasyhsLSaIJKX04GddiQPgN
 npb4kPw8dhDnFkjMf2mj7yCQFJZBXmmuYfTdCHx0lhvNDC+62hXpz94hoplcAPAHZ2a5g780PbT
 Z2IUVJ0=
X-Received: by 2002:a05:693c:290d:b0:2b8:711:ae6e with SMTP id
 5a478bee46e88-2bde1b504famr6969935eec.1.1772564712037; Tue, 03 Mar 2026
 11:05:12 -0800 (PST)
MIME-Version: 1.0
References: <20260212104432.4168886-1-kchiu@axiado.com>
 <CAFEAcA_u5B2RdVEaGycCQ6gCx1pQuT8rvGVGZpoKLTK+2s72+w@mail.gmail.com>
 <69691e3b-1605-4a5a-8ad5-0eec56ce3eed@axiado.com>
 <CAJy5ezpcvp0Qy-P9gE46oDtsxZxNO=xMV1k-GC3WF4yY3gARGw@mail.gmail.com>
 <CAFEAcA8mC4TkicLy9bcS8NYMDNcSUjsataGGmkMpViw4wBvmCA@mail.gmail.com>
 <CAJy5ezqTAMr=A3uAfmuWLepK66AdLRu4Q8AmFMh4+4q2HtDrkA@mail.gmail.com>
In-Reply-To: <CAJy5ezqTAMr=A3uAfmuWLepK66AdLRu4Q8AmFMh4+4q2HtDrkA@mail.gmail.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 3 Mar 2026 13:04:59 -0600
X-Gm-Features: AaiRm50rASURkUYUGmVXx2oCdg77jdACm8Kf9EFJ8kIirhbydSVlcyBo4SwOCJs
Message-ID: <CAJy5ezogVjNxHLFVBp9wd332kwyR8peBHMEjoALg6pYfVk1q8g@mail.gmail.com>
Subject: Re: [PATCH v1] hw/char/cadence_uart: Add BXRS register
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Kuan-Jui Chiu <kchiu@axiado.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 pbonzini@redhat.com, marcandre.lureau@redhat.com, alistair@alistair23.me
Content-Type: multipart/alternative; boundary="00000000000000a1d7064c23624f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1331;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-dy1-x1331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--00000000000000a1d7064c23624f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 12:59=E2=80=AFPM Edgar E. Iglesias <edgar.iglesias@g=
mail.com>
wrote:

>
>
> On Tue, Mar 3, 2026 at 12:44=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org>
> wrote:
>
>> On Tue, 3 Mar 2026 at 18:32, Edgar E. Iglesias <edgar.iglesias@gmail.com=
>
>> wrote:
>> >
>> >
>> >
>> > On Tue, Mar 3, 2026 at 2:33=E2=80=AFAM Kuan-Jui Chiu <kchiu@axiado.com=
> wrote:
>> >>
>> >> Hi
>> >>
>> >> I was referring this commit of upstream kernel which xilinx added BXR=
S
>> >> register in Cadence UART driver
>> >> serial: xuartps: Adds RXBS register support for zynqmp =C2=B7
>> >> torvalds/linux@3816b2f
>> >> <
>> https://github.com/torvalds/linux/commit/3816b2f886d0918d8a8ae593b2db203=
ab905a889
>> >
>> >>
>> >> Peter Maydell =E6=96=BC 2026/2/16 =E4=B8=8B=E5=8D=88 06:53 =E5=AF=AB=
=E9=81=93:
>>
>> >> > Where is this register documented? The cadence_uart.c file
>> >> > references the Zynq 7000 Soc TRM UG585; its URL for that
>> >> > is out of date, but looking at the copy on the AMD website,
>> >> > there is a table giving the register summary for the UART:
>> >> >
>> https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/UART-Controller-UAR=
T
>> >> > and it lists only registers from offsets 0 to 0x44.
>>
>> > There's documentation here for zynqmp:
>> >
>> https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registers/Rx_FIFO_by=
te_status-UART-Register
>> >
>> > I haven't looked to carefully, it may be a register that didn't exist
>> in the version of the UART on zynq and was added in the version of the u=
art
>> in the zynqmp.
>>
>> Thanks. On the subject of Xilinx specs, do you have an opinion on
>> https://gitlab.com/qemu-project/qemu/-/issues/3297 ?
>> Our Xilinx AXI ethernet device model lets software write to
>> the PHY registers for the PHY ID, and it's not clear to me
>> whether these registers are supposed to be read-only or not.
>>
>>
> Yes, they should be read-only, there's probably more registers and fields
> that have the wrong access restrictions as well. The PHY model is super
> simple, created just to get guests to not get stuck on boot or fail to us=
e
> the PHY...
>
> IIRC, there's been several attempts on list to create a better MDIO/PHY
> interface with shared PHY models but never got merged.
>
> Cheers,
> Edgar
>

For example:
https://patchew.org/QEMU/20170922171323.10348-1-f4bug@amsat.org/

--00000000000000a1d7064c23624f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 3, =
2026 at 12:59=E2=80=AFPM Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.igle=
sias@gmail.com">edgar.iglesias@gmail.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><=
br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_att=
r">On Tue, Mar 3, 2026 at 12:44=E2=80=AFPM Peter Maydell &lt;<a href=3D"mai=
lto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
Tue, 3 Mar 2026 at 18:32, Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.igl=
esias@gmail.com" target=3D"_blank">edgar.iglesias@gmail.com</a>&gt; wrote:<=
br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Tue, Mar 3, 2026 at 2:33=E2=80=AFAM Kuan-Jui Chiu &lt;<a href=3D"ma=
ilto:kchiu@axiado.com" target=3D"_blank">kchiu@axiado.com</a>&gt; wrote:<br=
>
&gt;&gt;<br>
&gt;&gt; Hi<br>
&gt;&gt;<br>
&gt;&gt; I was referring this commit of upstream kernel which xilinx added =
BXRS<br>
&gt;&gt; register in Cadence UART driver<br>
&gt;&gt; serial: xuartps: Adds RXBS register support for zynqmp =C2=B7<br>
&gt;&gt; torvalds/linux@3816b2f<br>
&gt;&gt; &lt;<a href=3D"https://github.com/torvalds/linux/commit/3816b2f886=
d0918d8a8ae593b2db203ab905a889" rel=3D"noreferrer" target=3D"_blank">https:=
//github.com/torvalds/linux/commit/3816b2f886d0918d8a8ae593b2db203ab905a889=
</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Peter Maydell =E6=96=BC 2026/2/16 =E4=B8=8B=E5=8D=88 06:53 =E5=AF=
=AB=E9=81=93:<br>
<br>
&gt;&gt; &gt; Where is this register documented? The cadence_uart.c file<br=
>
&gt;&gt; &gt; references the Zynq 7000 Soc TRM UG585; its URL for that<br>
&gt;&gt; &gt; is out of date, but looking at the copy on the AMD website,<b=
r>
&gt;&gt; &gt; there is a table giving the register summary for the UART:<br=
>
&gt;&gt; &gt; <a href=3D"https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-T=
RM/UART-Controller-UART" rel=3D"noreferrer" target=3D"_blank">https://docs.=
amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/UART-Controller-UART</a><br>
&gt;&gt; &gt; and it lists only registers from offsets 0 to 0x44.<br>
<br>
&gt; There&#39;s documentation here for zynqmp:<br>
&gt; <a href=3D"https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registe=
rs/Rx_FIFO_byte_status-UART-Register" rel=3D"noreferrer" target=3D"_blank">=
https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registers/Rx_FIFO_byte_=
status-UART-Register</a><br>
&gt;<br>
&gt; I haven&#39;t looked to carefully, it may be a register that didn&#39;=
t exist in the version of the UART on zynq and was added in the version of =
the uart in the zynqmp.<br>
<br>
Thanks. On the subject of Xilinx specs, do you have an opinion on<br>
<a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/3297" rel=3D"noref=
errer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/issues/3297=
</a> ?<br>
Our Xilinx AXI ethernet device model lets software write to<br>
the PHY registers for the PHY ID, and it&#39;s not clear to me<br>
whether these registers are supposed to be read-only or not.<br>
<br></blockquote><div><br></div><div>Yes, they should be read-only, there&#=
39;s probably more registers and fields that have the wrong access restrict=
ions as well. The PHY model is super simple, created just to get guests to =
not get stuck on boot or fail to use the PHY...</div><div><br></div><div>II=
RC, there&#39;s been several attempts on list to create a better MDIO/PHY i=
nterface with shared PHY models but never got merged.</div><div><br></div><=
div>Cheers,</div><div>Edgar</div></div></div></blockquote><div><br></div><d=
iv>For example:</div><div><a href=3D"https://patchew.org/QEMU/2017092217132=
3.10348-1-f4bug@amsat.org/">https://patchew.org/QEMU/20170922171323.10348-1=
-f4bug@amsat.org/</a></div><div><br></div><div><br></div></div></div>

--00000000000000a1d7064c23624f--

