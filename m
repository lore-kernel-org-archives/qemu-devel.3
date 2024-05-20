Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE42AC25B77
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 20:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s99LX-0007Wa-OB; Mon, 20 May 2024 16:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjsamp@gmail.com>)
 id 1s92PP-0003Xw-6T; Mon, 20 May 2024 08:46:31 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mjsamp@gmail.com>)
 id 1s92PN-0002wZ-38; Mon, 20 May 2024 08:46:30 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a59ad24baa2so66299066b.1; 
 Mon, 20 May 2024 05:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716209184; x=1716813984; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qL3hM2Jpw3wUfBeVBGw9BMujfU348G+aKDKHbr4d3JI=;
 b=DjYQiWwgRc+eNP0UYmH8/Bgqh/99Od2SHYZWMTjhspzLfEAzJmigO0ph+w1I5ch++j
 kKd6Hr7lNy2wlQ60bOiKWmC6w8xKkhiH36rWQoxTD5b3dE0cbz38yKEB76anQmhbdp68
 erxZOnSSKNSDeG36rZj5rsAtNj/UaAMo7QrFLYMN42eqZoxY6cHYDRz6G/fX9mmD/zN2
 SrIb76VfYK5DRnEUvKCLzR4NzGxivo9P5eANJDbSGcLrg2OZR0shlnVWRbq5xJKZ3+WW
 MJIZKHq+yvCPFFpVaEIhd/ZGqbVcij7yPoqebWMN6l7hjUh/n08490+spKj7YwoCDYVF
 V/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716209184; x=1716813984;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qL3hM2Jpw3wUfBeVBGw9BMujfU348G+aKDKHbr4d3JI=;
 b=feVmX10iM1b6m7OQTyk73qq7T1+Iw3rFrpOCsL/yMb5eBVwlWQSBjrgepeydtfxfNB
 Ekg/ga9Y8Pd+1iBP6ktGP1SslJ86NVKcm/pZzibfmrZjzIIisWPVHCOg2fi4yRPLrTRd
 zs80/FqDk4TEm6rM6SuhsqTIQAO12gULYeIR4KYib4NYK8FfIjPIcRd+96hvYG6quPQF
 nzrM1q1bS4QvpTgZWgzY4rjpE0rmQGZR7fHvQr0yrLOhTJXAacRKkQIZPsdCduze5MAv
 i7dahSjpHU7oRaI3JopNf493aCSE2vfFOvneemO7Fb8V40ZuROz73DlGuiDQnOJOlJyR
 Ywug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkvR+OfstnkUopb+GpR78xwNYQJhCsjVEExmhU1+nO9RmToy4T5neF/UrPGSHaqicy0u2uri2+KFry7HEwJibdQGjS
X-Gm-Message-State: AOJu0YzgxfPFglr/zMymcy5cepESe9Gr6Db9amdZAWnI0WewBK2jAjjE
 hpxCnpOgHDZTp+SiqYYwl97TP4fRzEN5S82UG1ohmx3tGKGtcKUSb4CucUUvnLcktQM2YhFBR7q
 aRj7NEZ1JAIo2BtEmRakDD9mh6BBBF2oC
X-Google-Smtp-Source: AGHT+IGZ8gcECf6HXK9EkjUIdy5wHBhd8odeXPd0ZZNcTuiihmWa+qPxYwH66QQwMXOeRDjUn61ijbgB9RVzUXPRWXo=
X-Received: by 2002:a17:907:7e8b:b0:a5a:8aea:343f with SMTP id
 a640c23a62f3a-a5a8aea36a3mr1327385866b.6.1716209184429; Mon, 20 May 2024
 05:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <CANf3G5GuQp--XSkEjk+pbqz2tbgmXtohoyD1F2tp0z9V9wO2WA@mail.gmail.com>
In-Reply-To: <CANf3G5GuQp--XSkEjk+pbqz2tbgmXtohoyD1F2tp0z9V9wO2WA@mail.gmail.com>
From: Marcos Jean Sampaio <mjsamp@gmail.com>
Date: Mon, 20 May 2024 09:46:13 -0300
Message-ID: <CANf3G5Ezz4JtPyM1x4y=97H5q4d0=JaPjsjARnHwv8LjYwnfKw@mail.gmail.com>
Subject: Fwd: spapr-vlan hotplug
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com
Content-Type: multipart/alternative; boundary="000000000000cc5f2e0618e21667"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=mjsamp@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 20 May 2024 16:10:57 -0400
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

--000000000000cc5f2e0618e21667
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

---------- Forwarded message ---------
De: Marcos Jean Sampaio <mjsamp@gmail.com>
Date: s=C3=A1b., 18 de mai. de 2024 =C3=A0s 18:02
Subject: spapr-vlan hotplug
To: <clg@kaod.org>, <danielhb413@gmail.com>



Hello guys,

First, I would like to thank you for making this software possible! Many
thanks!

I just installed and ran AIX and PowerHA on QEMU successfully using virsh
and virt-manager. I shared my experience on Youtube videos and also on my
github.
It worked pretty well after some adjustments but something that I still
can't do is hotplug a network interface. I've tried using virtio and
spapr-vlan but in both cases the new device is not hotplugged. In the case
of virtio it allows me to add it but isn't recognized after cfgmgr. In the
case of spapr-vlan it just will be recognized and active in the next boot.

virsh attach-device --live aix_7200-04-02-2027_node01 netdev.xml
error: Failed to attach device from netdev.xml
error: internal error: unable to execute QEMU command 'device_add': Device
'spapr-vlan' can't go on PCI bus

netdev.xml content
<interface type=3D"network">
  <source network=3D"default" bridge=3D"virbr0"/>
  <target dev=3D"vnet5"/>
  <model type=3D"spapr-vlan"/>
  <alias name=3D"net5"/>
  <address type=3D"spapr-vio" reg=3D"0x00005000"/>
</interface>


I also tried add it using qemu-monitor and have the following message:

virsh qemu-monitor-command aix_7200-04-02-2027_node01 --hmp "device_add
spapr-vlan,netdev=3Dhostnet5,id=3Dnet5,mac=3D56:44:45:30:31:55,reg=3D0x0000=
5000"
Error: Bus 'spapr-vio' does not support hotplugging

Is there any other way to do this or it isn't working for network
interfaces? For disks it is working very well. Below you have my
environment details.


My videos
https://www.youtube.com/playlist?list=3DPLWNnbCzUTMSY6c6rjKtGuSAzHCPONExv2

https://github.com/mjsamp/AIX-on-qemu-ppc64

Environment
Lenovo ThinkPad E480 Intel=C2=AE Core=E2=84=A2 i3-8130U CPU @ 2.20GHz =C3=
=97 4 8G Mem
XrayDisk 240GB SSD
Ubuntu 20.04.6 LTS (Focal Fossa) 64-bit
Kernel Linux 5.4.0-181-generic x86_64
QEMU emulator version 4.2.1 (Debian 1:4.2-3ubuntu6.28)
libvirt QEMU Driver 6.0.0-0ubuntu8.20
AIX aix_7200-04-02-2027_1of2_072020.iso

Regardings,

Marcos Jean Sampaio

--000000000000cc5f2e0618e21667
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">---------- Forwarded message ---------<br>De: <b class=3D"g=
mail_sendername" dir=3D"auto">Marcos Jean Sampaio</b> <span dir=3D"auto">&l=
t;<a href=3D"mailto:mjsamp@gmail.com">mjsamp@gmail.com</a>&gt;</span><br>Da=
te: s=C3=A1b., 18 de mai. de 2024 =C3=A0s 18:02<br>Subject: spapr-vlan hotp=
lug<br>To:  &lt;<a href=3D"mailto:clg@kaod.org">clg@kaod.org</a>&gt;,  &lt;=
<a href=3D"mailto:danielhb413@gmail.com">danielhb413@gmail.com</a>&gt;<br><=
/div><br><br><div dir=3D"ltr"><br>Hello guys,<br><br>First, I would like to=
 thank you for making this software possible! Many thanks!<br><br>I just in=
stalled and ran AIX and PowerHA on QEMU successfully using virsh and virt-m=
anager. I shared my experience on Youtube videos and also on my github.<br>=
It worked pretty well after some adjustments but something that I still can=
&#39;t do is hotplug a network interface. I&#39;ve tried using virtio and s=
papr-vlan but in both cases the new device is not hotplugged. In the case o=
f virtio it allows me to add it but isn&#39;t recognized after cfgmgr. In t=
he case of spapr-vlan it just will be recognized and active in the next boo=
t.<br><br>virsh attach-device --live aix_7200-04-02-2027_node01 netdev.xml<=
br>error: Failed to attach device from netdev.xml<br>error: internal error:=
 unable to execute QEMU command &#39;device_add&#39;: Device &#39;spapr-vla=
n&#39; can&#39;t go on PCI bus<br><br>netdev.xml content<br>&lt;interface t=
ype=3D&quot;network&quot;&gt;<br>=C2=A0 &lt;source network=3D&quot;default&=
quot; bridge=3D&quot;virbr0&quot;/&gt;<br>=C2=A0 &lt;target dev=3D&quot;vne=
t5&quot;/&gt;<br>=C2=A0 &lt;model type=3D&quot;spapr-vlan&quot;/&gt;<br>=C2=
=A0 &lt;alias name=3D&quot;net5&quot;/&gt;<br>=C2=A0 &lt;address type=3D&qu=
ot;spapr-vio&quot; reg=3D&quot;0x00005000&quot;/&gt;<br>&lt;/interface&gt;<=
br><br><br>I also tried add it using qemu-monitor and have the following me=
ssage:<br><br>virsh qemu-monitor-command aix_7200-04-02-2027_node01 --hmp &=
quot;device_add spapr-vlan,netdev=3Dhostnet5,id=3Dnet5,mac=3D56:44:45:30:31=
:55,reg=3D0x00005000&quot;<br>Error: Bus &#39;spapr-vio&#39; does not suppo=
rt hotplugging<br><br>Is there any other way to do this or it isn&#39;t wor=
king for network interfaces? For disks it is working very well. Below you h=
ave my environment details.<br><br><br>My videos<br><a href=3D"https://www.=
youtube.com/playlist?list=3DPLWNnbCzUTMSY6c6rjKtGuSAzHCPONExv2" target=3D"_=
blank">https://www.youtube.com/playlist?list=3DPLWNnbCzUTMSY6c6rjKtGuSAzHCP=
ONExv2</a><br><br><a href=3D"https://github.com/mjsamp/AIX-on-qemu-ppc64" t=
arget=3D"_blank">https://github.com/mjsamp/AIX-on-qemu-ppc64</a><br><br>Env=
ironment<br>Lenovo ThinkPad E480 Intel=C2=AE Core=E2=84=A2 i3-8130U CPU @ 2=
.20GHz =C3=97 4 8G Mem<br>XrayDisk 240GB SSD<br>Ubuntu 20.04.6 LTS (Focal F=
ossa) 64-bit<br>Kernel Linux 5.4.0-181-generic x86_64<br>QEMU emulator vers=
ion 4.2.1 (Debian 1:4.2-3ubuntu6.28)<br>libvirt QEMU Driver 6.0.0-0ubuntu8.=
20<br><div>AIX aix_7200-04-02-2027_1of2_072020.iso</div><div><br></div><div=
>Regardings,</div><div><br></div><div>Marcos Jean Sampaio<br></div></div>
</div></div>

--000000000000cc5f2e0618e21667--

