Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D053CD3424
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 04:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKTdu-0002Pe-Pg; Wed, 06 May 2026 00:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1wKTdt-0002PH-Bk
 for qemu-devel@nongnu.org; Wed, 06 May 2026 00:13:49 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1wKTdr-000699-6A
 for qemu-devel@nongnu.org; Wed, 06 May 2026 00:13:49 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3650a628473so3968123a91.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 21:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778040826; x=1778645626; darn=nongnu.org;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=AK3zMwVO3WE3Y00R1JNOuZCh4QPSwgne75XPkrfDBak=;
 b=Vg99/qz+D8WcZxXBZYZTrXNbnTSD1c+sew8RIKeeirTXp1kjFCqMVB/2ILzYm12Xvp
 mQTs8eieCv+kk0up3CnymXdNp+l5Hqk5VGWuTn2/kDBGbuvkQvDVgZxCDeevmd+7alfo
 LazQKPr36o/ufWkpo7I9RuO6Wun2bk/qxYFreFe+saTjbvZVFJvg+v2kXdtMCc787ZhR
 k7xx8u3gwUFw+O5QB4wAkP5at1wxosM4YU2XRywUANxO2x+TWJMJYhx/aFpuaW6urF+a
 xVEJlA+VKn0fwO8i1we7cXSBYA62vhxN3CNOaKmuYKzfXojIaBaCfm5643sawnY59+1P
 pveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778040826; x=1778645626;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AK3zMwVO3WE3Y00R1JNOuZCh4QPSwgne75XPkrfDBak=;
 b=ExZg8kc+4WsnknydqVAcuoGeqc61eeQ31BeF6FhkU7pMIyszqgeKvBalInBmk4U9tD
 2E+zOtUjOcuhWxWRCQzbZTWe97YTi7CtivUqm9wyFqJVc6rFeoH8mE/2qoT4+SeMKL5/
 w2358idgVzhLaWFK2JWHcBAu1YTIdVbazC5ifAkGwZdhDQmjCZmwM0g84jbgdvrI/Vpa
 xmkDLW33ThxLgqLhMblVc+qT5XAmgI+IPHtsFusyfr47aNiDES680ZpEpoQlgmlyi1pC
 VQ1EEILHQe9F/2FVSEpIOHaEFqcN+LMSqZT3AORvutUUnWV42ZtjR9jKWcym581AkN2+
 cd/g==
X-Gm-Message-State: AOJu0YzIDl6ZJSkmZF6+L/1EWihcPQyxm6pDq6cX6QLyVbb4D0DP+pVb
 QXmJWjEzibv5cDL/D/swcd2xrSt4r9IKMpgSNMYJWxziU74aGvnX4trH
X-Gm-Gg: AeBDiet8hDq4ZD6CXr0h46n7fOaWL0BMSNkZf31ITyk6g4r1JAvQoCWSS7Zgv8sb+AW
 c0VdIzUyuQW7el7Cvx8mQxebIpaSHLnol62qxh3LPUqQuoS0NiLoBkgztBXODBuZ0TGoA6d93jZ
 34P9y7OQwb1mwzEBgAz3oczbMJ6xlxejaB6y8eWf/iVshKdjlEx9DOqUdkS7X6ymbhfnSgFAzGf
 R2F1T9RlnnjJ4LEzS82mIvyX/dpPd29qyyqY1RCn9E2Ayxt6GPT2+Hd3aPsfB2KYs00zeUf+p6l
 irIUpsxHtxD66JZgJGSIgoyBw820mma6bo/Vs/KSDyc04CBsKPpNjzukFOtAbXbesGY8vdZNxye
 uzXEmjY6MST1bBo32cCnQan8fO1Z4+Ta1WD2P6TU9rWM0nKowZbwB7AqDlr0R0WWJvNdFoNWnL0
 k+GDYDtxVjDDP9ez2ZqQ62K0Sc/b1x4jxF6Q4TjkZuFKPUGIpwqy/tCZ6gvg==
X-Received: by 2002:a17:90b:4e87:b0:362:ded3:bbcb with SMTP id
 98e67ed59e1d1-365ac77546emr1614461a91.25.1778040825448; 
 Tue, 05 May 2026 21:13:45 -0700 (PDT)
Received: from smtpclient.apple ([202.55.186.124])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-365b0560fa8sm329934a91.1.2026.05.05.21.13.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 May 2026 21:13:44 -0700 (PDT)
From: =?utf-8?B?0JzTqdC90YXQsdCw0LDRgtCw0YAg0K3QvdGF0LHQsNCw0YLQsNGA?=
 <munkhuu0825@gmail.com>
Message-Id: <B987731A-F30F-4B6F-8069-86BF3377910D@gmail.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_DCFE8011-BCAA-4ADD-8C82-5914F24140FA"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fix memory leak in ohci_service_iso_td()
Date: Wed, 6 May 2026 12:13:25 +0800
In-Reply-To: <CAFEAcA8s+YW9n78=75VMetVP-10mMiTkzrxCHgHK7kdvP-50jg@mail.gmail.com>
Cc: qemu-devel@nongnu.org
To: Peter Maydell <peter.maydell@linaro.org>
References: <20260505110036.47574-1-munkhuu0825@gmail.com>
 <CAFEAcA8s+YW9n78=75VMetVP-10mMiTkzrxCHgHK7kdvP-50jg@mail.gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=munkhuu0825@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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


--Apple-Mail=_DCFE8011-BCAA-4ADD-8C82-5914F24140FA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On 5 May 2026, at 21:14, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Tue, 5 May 2026 at 12:01, <munkhuu0825@gmail.com =
<mailto:munkhuu0825@gmail.com>> wrote:
>>=20
>> From: heropd <munkhuu0825@gmail.com <mailto:munkhuu0825@gmail.com>>
>>=20
>> Fix a memory leak in ohci_service_iso_td() by calling
>> usb_packet_cleanup() before freeing USBPacket.
>>=20
>> Signed-off-by: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com =
<mailto:munkhuu0825@gmail.com>>
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3463
>=20
>=20
>> ---
>> hw/usb/hcd-ohci.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>=20
>> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
>> index 6ed8046fc2..43c49a42ec 100644
>> --- a/hw/usb/hcd-ohci.c
>> +++ b/hw/usb/hcd-ohci.c
>> @@ -748,6 +748,7 @@ static int ohci_service_iso_td(OHCIState *ohci, =
struct ohci_ed *ed)
>>     usb_handle_packet(dev, pkt);
>>     if (pkt->status =3D=3D USB_RET_ASYNC) {
>>         usb_device_flush_ep_queue(dev, ep);
>> +        usb_packet_cleanup(pkt);
>>         g_free(pkt);
>>         return 1;
>>     }
>=20
> I don't really understand the USB subsystem, but something seems
> odd here. The case when usb_handle_packet() can set the
> p->status to USB_RET_ASYNC is when it has added it to a queue,
> either directly ("QTAILQ_INSERT_TAIL(&p->ep->queue, p, queue);")
> or by calling usb_queue_one(). The usb_device_flush_ep_queue()
> does not (as far as I can tell) remove the queued packet. So it
> seems wrong to me that this code path frees the packet, and
> also if we call usb_packet_cleanup() it will do
>    assert(!usb_packet_is_inflight(p));
> which I think will fire.
>=20
> It's possible that we can't ever actually get to this code --
> the usb_handle_packet() has a claim "hcd drivers cannot handle
> async for isoc" and some assertions about that, which suggests
> maybe that the intent is that we won't ever return USB_RET_ASYNC
> for an iso TD. But if so, we should be asserting that.
>=20

Thanks that makes sense,
I tested the USB_RET_ASYNC path locally and usb_packet_cleanup() does =
indeed hit the inflight
assertion there
OHCI ISO ASYNC branch reached
Assertion failed: (!usb_packet_is_inflight(p)), function =
usb_packet_cleanup, file core.c, line 657.

>> @@ -756,6 +757,7 @@ static int ohci_service_iso_td(OHCIState *ohci, =
struct ohci_ed *ed)
>>     } else {
>>         ret =3D pkt->status;
>>     }
>> +    usb_packet_cleanup(pkt);
>>     g_free(pkt);
>=20
> This one's probably OK -- is it the one that fixes the repro
> case in the bug report?

Yes this one should fix repro bug in report

>=20
> thanks
> -- PMM

For the async path, I can leave it unchanged for this fix, or add an =
assertion since ISO TDs are not expected to complete asynchronously.

Thanks,
Munkhbaatar


--Apple-Mail=_DCFE8011-BCAA-4ADD-8C82-5914F24140FA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dus-ascii"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 5 May 2026, at 21:14, Peter Maydell =
&lt;peter.maydell@linaro.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">On Tue, 5 May 2026 at 12:01, &lt;</span><a =
href=3D"mailto:munkhuu0825@gmail.com" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: =
0px;">munkhuu0825@gmail.com</a><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">&gt; wrote:</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: =
solid;"><br>From: heropd &lt;<a =
href=3D"mailto:munkhuu0825@gmail.com">munkhuu0825@gmail.com</a>&gt;<br><br=
>Fix a memory leak in ohci_service_iso_td() by =
calling<br>usb_packet_cleanup() before freeing =
USBPacket.<br><br>Signed-off-by: Munkhbaatar Enkhbaatar &lt;<a =
href=3D"mailto:munkhuu0825@gmail.com">munkhuu0825@gmail.com</a>&gt;<br></b=
lockquote><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Resolves:<span =
class=3D"Apple-converted-space">&nbsp;</span></span><a =
href=3D"https://gitlab.com/qemu-project/qemu/-/work_items/3463" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: =
0px;">https://gitlab.com/qemu-project/qemu/-/work_items/3463</a><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: =
solid;">---<br>hw/usb/hcd-ohci.c | 2 ++<br>1 file changed, 2 =
insertions(+)<br><br>diff --git a/hw/usb/hcd-ohci.c =
b/hw/usb/hcd-ohci.c<br>index 6ed8046fc2..43c49a42ec 100644<br>--- =
a/hw/usb/hcd-ohci.c<br>+++ b/hw/usb/hcd-ohci.c<br>@@ -748,6 +748,7 @@ =
static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed =
*ed)<br>&nbsp;&nbsp;&nbsp;&nbsp;usb_handle_packet(dev, =
pkt);<br>&nbsp;&nbsp;&nbsp;&nbsp;if (pkt-&gt;status =3D=3D =
USB_RET_ASYNC) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;usb_device_flush_ep_q=
ueue(dev, ep);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;usb_packet_cleanup(pkt);<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;g_free(pkt);<br>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
1;<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br></blockquote><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">I don't really understand the USB =
subsystem, but something seems</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">odd here. The case when usb_handle_packet() =
can set the</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">p-&gt;status to USB_RET_ASYNC is when it =
has added it to a queue,</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">either directly =
("QTAILQ_INSERT_TAIL(&amp;p-&gt;ep-&gt;queue, p, queue);")</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">or by calling usb_queue_one(). The =
usb_device_flush_ep_queue()</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">does not (as far as I can tell) remove the =
queued packet. So it</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">seems wrong to me that this code path frees =
the packet, and</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">also if we call usb_packet_cleanup() it =
will do</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline =
!important;">&nbsp;&nbsp;&nbsp;assert(!usb_packet_is_inflight(p));</span><=
br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: =
solid;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">which I =
think will fire.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">It's possible that we can't ever actually =
get to this code --</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">the usb_handle_packet() has a claim "hcd =
drivers cannot handle</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">async for isoc" and some assertions about =
that, which suggests</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">maybe that the intent is that we won't ever =
return USB_RET_ASYNC</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">for an iso TD. But if so, we should be =
asserting that.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"></div></blockquote><div><br></div><div><div dir=3D"ltr" =
style=3D"line-height: 1.5; caret-color: rgb(29, 29, 29); color: rgb(29, =
29, 29); font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, =
sans-serif; font-size: 13px;"><div dir=3D"ltr" style=3D"line-height: =
1.5;">Thanks that makes sense,</div><div dir=3D"ltr" style=3D"line-height:=
 1.5;">I tested the USB_RET_ASYNC path locally and usb_packet_cleanup() =
does indeed hit the inflight</div><div dir=3D"ltr" style=3D"line-height: =
1.5;">assertion there</div><div dir=3D"ltr" style=3D"line-height: =
1.5;">OHCI ISO ASYNC branch reached</div><div dir=3D"ltr" =
style=3D"line-height: 1.5;">Assertion failed: =
(!usb_packet_is_inflight(p)), function usb_packet_cleanup, file core.c, =
line 657.</div></div></div><br><blockquote type=3D"cite"><div><blockquote =
type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;">@@ =
-756,6 +757,7 @@ static int ohci_service_iso_td(OHCIState *ohci, struct =
ohci_ed *ed)<br>&nbsp;&nbsp;&nbsp;&nbsp;} else =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
pkt-&gt;status;<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;usb_packet_cleanup(pkt);<br>&nbsp;&nbsp;&nbsp;&nbsp;g_fr=
ee(pkt);<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">This one's probably OK -- is it the one =
that fixes the repro</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">case in the bug report?</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"></div></blockquote><div><br></div><div>Yes this one should fix =
repro bug in report</div><br><blockquote =
type=3D"cite"><div><br></div></blockquote><blockquote =
type=3D"cite"><div><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">thanks</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">-- =
PMM</span></div></blockquote><br></div><div><div>For the async path, I =
can leave it unchanged for this fix, or add an assertion since ISO TDs =
are not expected to complete =
asynchronously.</div><div><br></div><div>Thanks,</div><div>Munkhbaatar</di=
v></div><br></body></html>=

--Apple-Mail=_DCFE8011-BCAA-4ADD-8C82-5914F24140FA--

