Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDA7C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 20:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT60F-000449-5k; Thu, 25 Jan 2024 15:07:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1rT60D-00043i-Sv
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 15:07:09 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1rT60B-0005yv-R8
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 15:07:09 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5f69383e653so923987b3.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 12:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706213226; x=1706818026; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UUrUxZciJePsgxmm08uzb18AE00Lk717exTxlp550xM=;
 b=Km4i5cVmpZfdVTeqDHWc/lTbiRWNDTox8skuLyqIrWoVZVh4mWc7/I9YyivA1OkkpI
 motxTxzx3GKg/k0ElQ0lXshv5w5ktAx0EWBm+cC1mcxYIm0ftd4RCjfc3tvYzOecd9xQ
 Nq2/Donx2hZDO+ckGTV9eqBNe6RkPZA0N3LjVEU67qFc1TQ/wcaj6Jd/51X0zbGyMeh8
 OYGb2xgg8sLxCg2ZJ/XywAIjMxUCzOORzkkpLxJSqGamgUbbYiAnWnQ8VMB5ibTUx/gm
 0S9u0xy1c9wS2hDeUChplvZCGy3ur/yFQXIVCEmkMz8enVpXHEBc+wR4kZwRpnOYNPoj
 6lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706213226; x=1706818026;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UUrUxZciJePsgxmm08uzb18AE00Lk717exTxlp550xM=;
 b=cWSuNceW+23fCbckscqfq7+GKzepidy+X44wK4E0VzwuEGYHIgl88c9iHjQG3nSZZB
 JVGQc4x+JhOuzHCn0zh5Ne6KIIXp6SwmaG2FgXVHEZ1+ERUjwbpTqHReqo5p+uirAy8g
 hZtOURMlTJjPY82tFM+IRmpa01EUlrYal8CdEgZLML7hSw2TRZdMONT38YiOQtYdVZ68
 Y0vTt1ZbG8oF/7NSVqiPU5dmlq/bLdpaWe5o3DEaDJ5NqvYLreE17+0tR52J7LtTpPu8
 ACllD2yv4Ns0aIuJOzvwlDQ8PVATqFcp1KAHEL49x5mKbZQ2tyTO2icNCIgv3TpM/FcM
 S6Ew==
X-Gm-Message-State: AOJu0YzKxNHOuq9hl2njaXJftXXU8Oe0giOGd9Y9Ys1o/O91vdWFk0vq
 7+e64nX5nDa9NLDpzV+rRLi5/eBMNXB6nAXgQF482mr6VGyWtY/L70wE/W5z2pPi0hUZIk/dKKf
 gBkN1L49fazXFha6IgQ7ErhY8gWq/DvL078Q=
X-Google-Smtp-Source: AGHT+IHaC+PfRumgDJ0OW1G64/VdMUU0qr5QpnVD0EgzJa+JU45jRWwjon0pNu7W751koIWbZPLXr/VkSWWIwlFoc84=
X-Received: by 2002:a0d:d489:0:b0:5ff:cb36:4121 with SMTP id
 w131-20020a0dd489000000b005ffcb364121mr367355ywd.91.1706213226043; Thu, 25
 Jan 2024 12:07:06 -0800 (PST)
MIME-Version: 1.0
References: <20231117173916.3658-1-n.ostrenkov@gmail.com>
 <CAC8KSA1SydreP4hT+3bJS-tZeeFH5_ZWbHCMCAMedM1pYjMP-w@mail.gmail.com>
In-Reply-To: <CAC8KSA1SydreP4hT+3bJS-tZeeFH5_ZWbHCMCAMedM1pYjMP-w@mail.gmail.com>
From: Nikita Ostrenkov <n.ostrenkov@gmail.com>
Date: Thu, 25 Jan 2024 23:06:55 +0300
Message-ID: <CAC8KSA3B47ceDtNW9DySAPGx4wEOqMGnJ5+NzoXqskurPb3SvQ@mail.gmail.com>
Subject: Re: [PATCH v3] hw/usb: fix xhci port notify
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003fdac4060fcab9e5"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=n.ostrenkov@gmail.com; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000003fdac4060fcab9e5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping
https://patchew.org/QEMU/20231117173916.3658-1-n.ostrenkov@gmail.com/

=D0=BF=D0=BD, 18 =D0=B4=D0=B5=D0=BA. 2023=E2=80=AF=D0=B3., 13:40 Nikita Ost=
renkov <n.ostrenkov@gmail.com>:

> ping
> https://patchew.org/QEMU/20231117173916.3658-1-n.ostrenkov@gmail.com/
>
> =D0=BF=D1=82, 17 =D0=BD=D0=BE=D1=8F=D0=B1. 2023=E2=80=AF=D0=B3., 20:39 Ni=
kita Ostrenkov <n.ostrenkov@gmail.com>:
>
>> From MCF5253 Reference manual
>> https://www.nxp.com/docs/en/reference-manual/MCF5253RM.pdf
>>
>> Host mode: Port Change Detect. The controller sets this bit to a one whe=
n
>> on any port a Connect Status occurs, a PortEnable/Disable Change occurs,=
 an
>> Over Current Change occurs, or the Force Port Resume bit is set as
>> theresult of a J-K transition on the suspended port.
>>
>> Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
>> ---
>>  hw/usb/hcd-xhci.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
>> index 4b60114207..1b2f4ac721 100644
>> --- a/hw/usb/hcd-xhci.c
>> +++ b/hw/usb/hcd-xhci.c
>> @@ -2627,6 +2627,7 @@ static void xhci_port_notify(XHCIPort *port,
>> uint32_t bits)
>>      if (!xhci_running(port->xhci)) {
>>          return;
>>      }
>> +    port->xhci->usbsts |=3D USBSTS_PCD;
>>      xhci_event(port->xhci, &ev, 0);
>>  }
>>
>> --
>> 2.34.1
>>
>>

--0000000000003fdac4060fcab9e5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">ping<div dir=3D"auto"><a href=3D"https://patchew.org/QEMU=
/20231117173916.3658-1-n.ostrenkov@gmail.com/">https://patchew.org/QEMU/202=
31117173916.3658-1-n.ostrenkov@gmail.com/</a></div></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D0=BD, 18 =D0=B4=
=D0=B5=D0=BA. 2023=E2=80=AF=D0=B3., 13:40 Nikita Ostrenkov &lt;<a href=3D"m=
ailto:n.ostrenkov@gmail.com">n.ostrenkov@gmail.com</a>&gt;:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex"><div dir=3D"auto">ping<div dir=3D"auto"><a href=3D=
"https://patchew.org/QEMU/20231117173916.3658-1-n.ostrenkov@gmail.com/" tar=
get=3D"_blank" rel=3D"noreferrer">https://patchew.org/QEMU/20231117173916.3=
658-1-n.ostrenkov@gmail.com/</a><br></div></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D1=82, 17 =D0=BD=D0=BE=D1=
=8F=D0=B1. 2023=E2=80=AF=D0=B3., 20:39 Nikita Ostrenkov &lt;<a href=3D"mail=
to:n.ostrenkov@gmail.com" target=3D"_blank" rel=3D"noreferrer">n.ostrenkov@=
gmail.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From MCF5253 Ref=
erence manual <a href=3D"https://www.nxp.com/docs/en/reference-manual/MCF52=
53RM.pdf" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">https:=
//www.nxp.com/docs/en/reference-manual/MCF5253RM.pdf</a><br>
<br>
Host mode: Port Change Detect. The controller sets this bit to a one when o=
n any port a Connect Status occurs, a PortEnable/Disable Change occurs, an =
Over Current Change occurs, or the Force Port Resume bit is set as theresul=
t of a J-K transition on the suspended port.<br>
<br>
Signed-off-by: Nikita Ostrenkov &lt;<a href=3D"mailto:n.ostrenkov@gmail.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">n.ostrenkov@gmail.com</a>=
&gt;<br>
---<br>
=C2=A0hw/usb/hcd-xhci.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c<br>
index 4b60114207..1b2f4ac721 100644<br>
--- a/hw/usb/hcd-xhci.c<br>
+++ b/hw/usb/hcd-xhci.c<br>
@@ -2627,6 +2627,7 @@ static void xhci_port_notify(XHCIPort *port, uint32_t=
 bits)<br>
=C2=A0 =C2=A0 =C2=A0if (!xhci_running(port-&gt;xhci)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 port-&gt;xhci-&gt;usbsts |=3D USBSTS_PCD;<br>
=C2=A0 =C2=A0 =C2=A0xhci_event(port-&gt;xhci, &amp;ev, 0);<br>
=C2=A0}<br>
<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>
</blockquote></div>

--0000000000003fdac4060fcab9e5--

