Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE71C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 19:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sClCf-0002kr-3Y; Thu, 30 May 2024 15:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sClCd-0002kc-Ui
 for qemu-devel@nongnu.org; Thu, 30 May 2024 15:12:43 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sClCb-0000I4-1d
 for qemu-devel@nongnu.org; Thu, 30 May 2024 15:12:43 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52a54d664e3so439654e87.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 12:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717096356; x=1717701156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=brRm19wb4uJvm7hKFji91uvETQkKBNaqx5vzVfwT2Zg=;
 b=vKf115B38slKmTmnDoMNSgQSbv25JA2cetvI14SDTXFwG0lCmGBqH1goXiPGIgPCfb
 h19SLLfsbeoGlpzCziEGkQ71dWeF5Mw1YnIjNKra3OewC6/9FJ7S20tjs0klJ63owDuV
 c6kkOr2XgugbFZ0jame4bWwJBQTVqRqbasrQyKjsx/e8WB78150+x0zHUKpoJ65Y+vo0
 L06kiNuM1aG0ntJN7h8jZwua+b7izsyDlf+HI1OUG1JvdyuNI4nJsLU9dCJrnYLy4n4b
 hW0ahVYfjzrC8aHQhzuSFG9bRWsrpZWeH9G7b4DG3VoXklodlWdPK/WRXTaZjHB+bb9K
 Ofpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717096356; x=1717701156;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=brRm19wb4uJvm7hKFji91uvETQkKBNaqx5vzVfwT2Zg=;
 b=ATgYJCoV7IXzAC/jN5y082W5xExCf1UE+ADtDpuj+UYExlYBC85l5vv7wA6M9UPSVE
 gKqplm3UlHi6AQklUoOzGGpVIXFx+5+bNz6N57rNN+gJQlpve4RWLtpy2jZp4PWJG64O
 jDX3E+4oqQ++8EKvA7vZfN5QE5YSvAiS9h6Xo2XeTfGJtgCeAgnJleVKjtGAMfX2T/Oq
 f7REH5ys7/bTl2URhr4ZeWzy2CQfPgcCCROz0rKaqxtGyL7WIGxNCZ3Ye+fFWWdATEoR
 PNOT8jzXlqZlCFbjqvWorTlL+Ut0T5OYXPzN/nwMo1u0KEZ1+EQ1lNlywd7zw3xkSLRl
 uuKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXOMqSa2GZJ+4mEdItXhD6AmitU8N96+h0hRWzwCbUK2CHhCNonctNfq25Layie2N2xY6V6H5RKTPCgyxgxnFB3Tb28D0=
X-Gm-Message-State: AOJu0YzisL4Xc5aqNZBEVoIvxDhDU7ffoxroy6+nPsDSPfza2PZvsepS
 Sci15cax+x3ejDiEGhhAnXpzArdf4eLr3zIem8K5Pv1SIofAFgqEu9QY4AZDVMw=
X-Google-Smtp-Source: AGHT+IHp3OzCIvJ2Xl7S9QGV9Uf0Ay+UuWi0GUL/qnRG0Jk8adICM8PRtlEFE+bKWepxXXFiBdfqhQ==
X-Received: by 2002:ac2:4316:0:b0:52b:829c:34e4 with SMTP id
 2adb3069b0e04-52b829c36dfmr866722e87.59.1717096354144; 
 Thu, 30 May 2024 12:12:34 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67eb341aa7sm5483666b.188.2024.05.30.12.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 12:12:33 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 15F145F8CB;
 Thu, 30 May 2024 20:12:33 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cord Amfmgm <dmamfmgm@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org
Subject: Re: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
In-Reply-To: <CACBuX0T6aPHEQzgqDJs14NvOTPj9ngQ4Avw-dZ8yn4q4fGbnqA@mail.gmail.com>
 (Cord Amfmgm's message of "Thu, 30 May 2024 11:03:50 -0500")
References: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
 <CAFEAcA9aum5+z3sr-OpCHZRWxFtZGS_kGOjjmRh7H1TBTZuFRQ@mail.gmail.com>
 <CACBuX0Q3TMvmxuuAHfVY679wpKF+0N+-aw=A7PLiba7ndc5v+w@mail.gmail.com>
 <CAFEAcA9XvHOF22m-9ZFtKLAaShE5gVjsy-AxQyBwVAkRZ2QW6g@mail.gmail.com>
 <CACBuX0Rzh9g4BEei8=vk0vOr7BwEZqom4LBGLcqH_omnBy9fLQ@mail.gmail.com>
 <CAFEAcA9V1J4w00PJB+Ct_3z2KGHcfGs_C8OqX8mdnW_bLxbUiQ@mail.gmail.com>
 <CACBuX0SR2cuFu+GaFGxp5rD_b+4HnNHfhQx2Csdw8L8QN+T7AA@mail.gmail.com>
 <87zfs7d7i6.fsf@draig.linaro.org>
 <CACBuX0T6aPHEQzgqDJs14NvOTPj9ngQ4Avw-dZ8yn4q4fGbnqA@mail.gmail.com>
Date: Thu, 30 May 2024 20:12:33 +0100
Message-ID: <87mso7cdwe.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Cord Amfmgm <dmamfmgm@gmail.com> writes:

> On Thu, May 30, 2024 at 3:33=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>
>  Cord Amfmgm <dmamfmgm@gmail.com> writes:
>
>  > On Tue, May 28, 2024 at 11:32=E2=80=AFAM Peter Maydell <peter.maydell@=
linaro.org> wrote:
>  >
>  >  On Tue, 28 May 2024 at 16:37, Cord Amfmgm <dmamfmgm@gmail.com> wrote:
>  >  >
>  >  > On Tue, May 28, 2024 at 9:03=E2=80=AFAM Peter Maydell <peter.maydel=
l@linaro.org> wrote:
>  >  >>
>  >  >> On Mon, 20 May 2024 at 23:24, Cord Amfmgm <dmamfmgm@gmail.com> wro=
te:
>  >  >> > On Mon, May 20, 2024 at 12:05=E2=80=AFPM Peter Maydell <peter.ma=
ydell@linaro.org> wrote:
>  <snip>
>  >  >> > And here's an example buffer of length 0 -- you probably already=
 know what I'm going to do here:
>  >  >> >
>  >  >> > char buf[0];
>  >  >> > char * CurrentBufferPointer =3D &buf[0];
>  >  >> > char * BufferEnd =3D &buf[-1]; // "address of the last byte in t=
he buffer"
>  >  >> > // The OHCI Host Controller than advances CurrentBufferPointer l=
ike this: CurrentBufferPointer +=3D 0
>  >  >> > // After the transfer:
>  >  >> > // CurrentBufferPointer =3D &buf[0];
>  >  >> > // BufferEnd =3D &buf[-1];
>  >  >>
>  >  >> Right, but why do you think this is valid, rather than
>  >  >> being a guest software bug? My reading of the spec is that it's
>  >  >> pretty clear about how to say "zero length buffer", and this
>  >  >> isn't it.
>  >  >>
>  >  >> Is there some real-world guest OS that programs the OHCI
>  >  >> controller this way that we're trying to accommodate?
>  >  >
>  >  >
>  >  > qemu versions 4.2 and before allowed this behavior.
>  >
>  >  So? That might just mean we had a bug and we fixed it.
>  >  4.2 is a very old version of QEMU and nobody seems to have
>  >  complained in the four years since we released 5.0 about this,
>  >  which suggests that generally guest OS drivers don't try
>  >  to send zero-length buffers in this way.
>  >
>  >  > I don't think it's valid to ask for a *popular* guest OS as a proof=
-of-concept because I'm not an expert on those.
>  >
>  >  I didn't ask for "popular"; I asked for "real-world".
>  >  What is the actual guest code you're running that falls over
>  >  because of the behaviour change?
>  >
>  >  More generally, why do you want this behaviour to be
>  >  changed? Reasonable reasons might include:
>  >   * we're out of spec based on reading the documentation
>  >   * you're trying to run some old Windows VM/QNX/etc image,
>  >     and it doesn't work any more
>  >   * all the real hardware we tested behaves this way
>  >
>  >  But don't necessarily include:
>  >   * something somebody wrote and only tested on QEMU happens to
>  >     assume the old behaviour rather than following the hw spec
>  >
>  >  QEMU occasionally works around guest OS bugs, but only as
>  >  when we really have to. It's usually better to fix the
>  >  bug in the guest.
>  >
>  > It's not, and I've already demonstrated that real hardware is consiste=
nt with the fix in this patch.
>  >
>  > Please check your tone.
>
>  I don't think that is a particularly helpful comment for someone who is
>  taking the time to review your patches. Reading through the thread I
>  didn't see anything that said this is how real HW behaves but I may well
>  have missed it. However you have a number of review comments to address
>  so I suggest you spin a v2 of the series to address them and outline the
>  reason to accept an out of spec transaction.
>
> I did a rework of the patch -- see my email from May 20, quoted below -- =
and I was under the impression it addressed all the
> review comments. Did I miss something? I apologize if I did.

Ahh I see - I'd only seen this thread continue so wasn't aware a new
version had been posted. For future patches consider using -vN when
sending them so we can clearly see a new revision is available.

>
>> index acd6016980..71b54914d3 100644
>> --- a/hw/usb/hcd-ohci.c
>> +++ b/hw/usb/hcd-ohci.c
>> @@ -941,8 +941,8 @@ static int ohci_service_td(OHCIState *ohci, struct o=
hci_ed *ed)
>>          if ((td.cbp & 0xfffff000) !=3D (td.be & 0xfffff000)) {
>>              len =3D (td.be & 0xfff) + 0x1001 - (td.cbp & 0xfff);
>>          } else {
>> -            if (td.cbp > td.be) {
>> -                trace_usb_ohci_iso_td_bad_cc_overrun(td.cbp, td.be);
>> +            if (td.cbp - 1 > td.be) {  /* rely on td.cbp !=3D 0 */
>
>> Reading through the thread I didn't see anything that said this is how r=
eal HW behaves but I may well have missed it.
>
> This is what I wrote regarding real HW:
>
> Results are:
>
>  qemu 4.2   | qemu HEAD  | actual HW
> ------------+------------+------------
>  works fine | ohci_die() | works fine
>
> Would additional verification of the actual HW be useful?
>
> Peter posted the following which is more specific than "qemu 4.2" -- I ag=
ree this is most likely the qemu commit where this
> thread is focused:
>
>> Almost certainly this was commit 1328fe0c32d54 ("hw: usb: hcd-ohci:
>> check len and frame_number variables"), which added these bounds
>> checks. Prior to that we did no bounds checking at all, which
>> meant that we permitted cbp=3Dbe+1 to mean a zero length, but also
>> that we permitted the guest to overrun host-side buffers by
>> specifying completely bogus cbp and be values. The timeframe is
>> more or less right (2020), at least.
>>=20
>> -- PMM
>
> Where does the conversation go from here? I'm under the impression I have=
 provided objective answers to all the questions
> and resolved all review comments on the code. I receive the feedback
> that I missed something - please restate the question?

I can see patch 1/2 has been queued and 2/2 is still outstanding. I'm
having trouble finding the referenced entry in the OHCI spec. The only
one I can see is Release 1.1, January 6th, 2000 and that doesn't have a
section 4.3.1.2.

I think discussion should continue on that thread.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

