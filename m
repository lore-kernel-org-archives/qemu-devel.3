Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A896DF8A16D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 12:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDLuD-00029Q-2O; Thu, 16 Apr 2026 08:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wDLuB-00028z-43
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 08:33:11 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wDLu8-0001dg-2p
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 08:33:10 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso121698465e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 05:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minio.io; s=minio; t=1776342784; x=1776947584; darn=nongnu.org;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=bhWPmSl29koGu6yjQv9BlVR/ASNb8SfqTfWNowox1yg=;
 b=SMiqIHSdnAfRSr/xK8I+lAfXUFeC4/iJ+cRShHldWsSiB0AjjXOZqemXUYm0WrXIIp
 sxDrmobk+E9CkT54KmmKJn4xvIBxOOKxsIeZgE6HElq8XZZEXS8U2IChhSY5w9Ygzugx
 UT3DKNi/b76M6s2h9tP+81HqftXAW5hmp88bSA00V+iPi8ZWy7B8cD6fqFeHlQp4jpM8
 yfVOu7mtxQyXYYa/Tz6NrbACVRodjjBsviTC0LNGBFH3Kv3S1xtpB4V65q3kkp4mgpv+
 xr97LaZelWodZECnsHlLfuRcbMdCON/JsJE4jCGAHgBOPN6zoNS//BJObIFRbph8pa7h
 YBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776342784; x=1776947584;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bhWPmSl29koGu6yjQv9BlVR/ASNb8SfqTfWNowox1yg=;
 b=OCrfXXADk1EJh3mT59hL7R5xZDU9cjDZABKMFMxuu3LwUcCdDwHcBeDSqfhd8L+NUN
 JcW9T5jnGjaDMWu7FEU1I2T+BOBEIZeEAOPk0RLOKsOImzMaMHHT1Gs5U9RpDVl01PHx
 +cLc871vZ9zbmYFZdKR4z9AlN/l3LM3jzQsH2GzH2K6W8enoKxfgSBESun45a/roj7K5
 PEvnlXtiiVDO5w9xcIu2jKpQNaSxZ55UcYpHHelGI+7N5BJQeM2KZjTWp9Ufgkqg/b+s
 tnXNIw0DrxmNGvDlIFArXrpuEv/Jzq/4KLJVlBxvIktEte5CMHYqWXXt4B7B2q71eRRD
 bgUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+GjbEzFfkSQWOngXz08RlBpSOW7IUWYLZq+OH9dNRGIT/3SYNZMhBj8g6lApv4TEda39eLsHZeOdKo@nongnu.org
X-Gm-Message-State: AOJu0Yy2n0o4RXbboIATxcZLg3NNMxAFxSoUsWG54rr0gUzvkACF18KB
 Cva1eiXU4HG1OJdsCzOTm1PvvTXtIRFAeSDuSRdNxiWj5Wf8VHGdcflcXfCxBd9kStY=
X-Gm-Gg: AeBDieudCfz2R+mbnpTAZeNFYku12BjkQTULo+UfrBf9mZRt/t81doav8UWhTMgTDzG
 vw2QbnUx0zbDTO8Zo/QTohrBk+SfbnoFFN/JT/p6fNhJPYp4bGJksNs8nWqqHcghlGEzqCBo0tN
 aHLGBX8Sv8q6MHgE15YLkRUnnWJ0FCImImX6Q7B675+BFykaxjpILX087JGxfSY24nXP1XipwVt
 Dp41AuMaLA4H3zer0rggA9T23W1xHfLDTy/QkgCiPT0JjVBky502oI0er3mwPvm/EBfUTI8G7/Q
 0IphGaRdlRLp+kMpvzUxxRjIZDw8aX2/cn9LcWYYv+XVTfLMJbW9VaLLOnBieLKtLI5K9tkMkOW
 B8chFFq/c1vxQ3DZE8V4D8UN19ptpamlf5afOfT4NGxdhf9pGnbcAcdA0YeILk9OrfbxejkRO0X
 U79hpO5ZC8WzZ5F3n23UtkrSjO1ae4SxTLxnTXIM8iBXZOoSzOiJni4+4iTXSckKPq53YzI3CO3
 kYlMBbNs3faHT336ZSz+BYKhJYrYnTafrHHoEG4zg03eFD8rJSNB6LyFi8N4xS6/rgfGdBJIqIE
 g0ffxPjE
X-Received: by 2002:a05:600c:3149:b0:488:ae6c:42c6 with SMTP id
 5b1f17b1804b1-488d684319emr354488295e9.14.1776342783668; 
 Thu, 16 Apr 2026 05:33:03 -0700 (PDT)
Received: from smtpclient.apple
 (2a01cb001411480081c71bdfaa902de5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:1411:4800:81c7:1bdf:aa90:2de5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f58236bcsm45514465e9.12.2026.04.16.05.33.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 Apr 2026 05:33:03 -0700 (PDT)
From: Matthieu Rolla <matthieu@minio.io>
Message-Id: <5C45F063-C631-4EB9-9E28-4C60F1CEB385@minio.io>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_54120EB9-BC3C-489C-A960-4E28EA09AE3A"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 0/2] NVMe namespace hotplug and drive reconnection support
Date: Thu, 16 Apr 2026 14:33:03 +0200
In-Reply-To: <2160c130-eff7-4068-8377-6c28b89ac046@linux.ibm.com>
Cc: John Meneghini <jmeneghi@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, kbusch@kernel.org,
 mr-083 <matthieu@min.io>
To: Nilay Shroff <nilay@linux.ibm.com>
References: <20260409060155.94704-1-matthieu@min.io>
 <ad0lMYOrRa-K1Ach@AALNPWKJENSEN.aal.scsc.local>
 <20260414124221.GB111076@fedora>
 <0743e428-cde4-436a-9af4-7477271fd8ab@redhat.com>
 <2160c130-eff7-4068-8377-6c28b89ac046@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.400.21)
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=matthieu@minio.io; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Apple-Mail=_54120EB9-BC3C-489C-A960-4E28EA09AE3A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Thanks Nilay for testing on pseries!

On the terminology,  agreed, v4 of the namespace patch uses "out-of-band =
namespace attach/detach" wording as Klaus suggested.

On the backend concern,  the drive_insert patch has been replaced by a =
new series implementing a QMP blockdev-attach command (per Daniel's =
feedback).=20
The ability to attach a different backing file is intentional, it allows =
simulating disk replacement where a failed drive is swapped for a new =
one. The guest sees the same device name but with fresh storage.=20

This mirrors what happens on real hardware when you replace a failed =
disk in the same slot. The risk you describe (stale page cache / =
filesystem metadata) is expected and handled at the guest level,  the =
filesystem detects the inconsistency and the storage stack (e.g. MinIO) =
heals the data via erasure coding

Link to v4 patch (serie 1): =
https://lists.nongnu.org/archive/html/qemu-devel/2026-04/msg02612.html
Link to new patch (serie 2): =
https://lists.nongnu.org/archive/html/qemu-devel/2026-04/msg02613.html

Thanks again for your time.

	.=09
Matthieu
www.min.io <>
matthieu@min.io <>=20

> On Apr 16, 2026, at 12:11=E2=80=AFPM, Nilay Shroff =
<nilay@linux.ibm.com> wrote:
>=20
> Hi John,
>=20
> On 4/14/26 7:34 PM, John Meneghini wrote:
>> Adding Nilay who has done a lot of work on nvme hot plug.
>> Nilay please take look at these patches and let us know if they can =
work on powerpc
>> I'll set up a test bed and try this out with x86_64.
>=20
> Thanks for looping me in.
>=20
> I tested this patch series on pseries QEMU, and overall it works as =
expected.
> For the first patch (NVMe namespace hotplug), the functionality =
behaves correctly
> and achieves its intended goal. That said, from an NVMe specification =
perspective,
> the operation appears closer to a namespace attach/detach rather than =
a traditional
> =E2=80=9Chotplug.=E2=80=9D I understand that in the QEMU device model, =
this is framed as a hotplug
> event, which is likely why the terminology is used here, but it may =
still be somewhat
> confusing when viewed through the NVMe spec lens.
>=20
> For the second patch (drive_insert), the implementation also works as =
intended on
> pseries. However, I have a concern regarding how the backend is =
handled. The flow
> effectively removes the backing storage using drive_del and later =
reattaches it
> using drive_insert. While the expectation is to reconnect the same =
backing store,
> there is currently no enforcement of this. As a result, it is =
possible=E2=80=94perhaps
> unintentionally=E2=80=94to reattach a different backing file. If this =
happens, it may lead
> to inconsistencies with the in-memory state maintained by the kernel =
(e.g., page
> cache or filesystem metadata), especially if the original device was =
already in use
> or mounted. This may potentially result in data corruption or =
undefined behavior
> from the guest=E2=80=99s perspective. It might be worth considering =
whether some form of
> validation or restriction should be added to ensure that the same =
backing store
> is reattached, or at least to make this behavior more explicit.
>=20
> Overall, both patches are functional on pseries, but the above points =
may be worth
> addressing.
>=20
> Thanks,
> --Nilay


--Apple-Mail=_54120EB9-BC3C-489C-A960-4E28EA09AE3A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><div>Thanks Nilay for testing on =
pseries!</div><div><br></div><div>On the terminology, &nbsp;agreed, v4 =
of the namespace patch uses "out-of-band namespace attach/detach" =
wording as Klaus suggested.</div><div><br></div><div>On the backend =
concern, &nbsp;the drive_insert patch has been replaced by a new series =
implementing a QMP blockdev-attach command (per Daniel's =
feedback).&nbsp;</div><div>The ability to attach a different backing =
file is intentional, it allows simulating disk replacement where a =
failed drive is swapped for a new one. The guest sees the same device =
name but with fresh storage.&nbsp;</div><div><br></div><div>This mirrors =
what happens on real hardware when you replace a failed disk in the same =
slot. The risk you describe (stale page cache / filesystem metadata) is =
expected and handled at the guest level, &nbsp;the filesystem detects =
the inconsistency and the storage stack (e.g. MinIO) heals the data via =
erasure coding</div><div><br></div><div>Link to v4 patch (serie =
1):&nbsp;https://lists.nongnu.org/archive/html/qemu-devel/2026-04/msg02612=
.html</div><div>
Link to new patch (serie =
2):&nbsp;https://lists.nongnu.org/archive/html/qemu-devel/2026-04/msg02613=
.html</div><div><br></div><div>Thanks again for your time.<br>
<br>
<table>
   <tbody>
       <tr>
           <td style=3D"padding: 0 50px 0 0;"><img =
src=3D"https://cdn.bfldr.com/Q955TODV/at/f5h9pjj8f8t3ng5t6vxs2n/emailsigna=
ture-logo-standalone.png?auto=3Dwebp&amp;format=3Dpng" height=3D"34"></td>=

           <td style=3D"width: 1px; padding: 0; background-color: =
#D6DAE1; color: #D6DAE1; font-size: 1px;">.</td>
           <td style=3D"padding:0 20px 0 50px;">
               <div style=3D"margin-top: -6px; margin-bottom: -4px;">
                   <strong><span =
style=3D"font-family:'Geist',Arial,Helvetica,sans-serif; font-size: =
1.1em; color: #353638;" color=3D"#353638">Matthieu</span></strong><br>
                   <div style=3D"height: 6px;"></div>
                   <a =
style=3D"font-family:'Geist',Arial,Helvetica,sans-serif; font-size: 1em; =
color: #353638; text-decoration: none; line-height: 118%;" =
color=3D"#353638">www.min.io</a><br>
                   <a =
style=3D"font-family:'Geist',Arial,Helvetica,sans-serif; font-size: 1em; =
color: #353638; text-decoration: none; line-height: 118%;" =
color=3D"#353638">matthieu@min.io</a>
               </div>
           </td>
       </tr>
   </tbody>
</table>

</div>
<div><br><blockquote type=3D"cite"><div>On Apr 16, 2026, at 12:11=E2=80=AF=
PM, Nilay Shroff &lt;nilay@linux.ibm.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>Hi John,<br><br>On 4/14/26 =
7:34 PM, John Meneghini wrote:<br><blockquote type=3D"cite">Adding Nilay =
who has done a lot of work on nvme hot plug.<br>Nilay please take look =
at these patches and let us know if they can work on powerpc<br>I'll set =
up a test bed and try this out with x86_64.<br></blockquote><br>Thanks =
for looping me in.<br><br>I tested this patch series on pseries QEMU, =
and overall it works as expected.<br>For the first patch (NVMe namespace =
hotplug), the functionality behaves correctly<br>and achieves its =
intended goal. That said, from an NVMe specification perspective,<br>the =
operation appears closer to a namespace attach/detach rather than a =
traditional<br>=E2=80=9Chotplug.=E2=80=9D I understand that in the QEMU =
device model, this is framed as a hotplug<br>event, which is likely why =
the terminology is used here, but it may still be somewhat<br>confusing =
when viewed through the NVMe spec lens.<br><br>For the second patch =
(drive_insert), the implementation also works as intended on<br>pseries. =
However, I have a concern regarding how the backend is handled. The =
flow<br>effectively removes the backing storage using drive_del and =
later reattaches it<br>using drive_insert. While the expectation is to =
reconnect the same backing store,<br>there is currently no enforcement =
of this. As a result, it is possible=E2=80=94perhaps<br>unintentionally=E2=
=80=94to reattach a different backing file. If this happens, it may =
lead<br>to inconsistencies with the in-memory state maintained by the =
kernel (e.g., page<br>cache or filesystem metadata), especially if the =
original device was already in use<br>or mounted. This may potentially =
result in data corruption or undefined behavior<br>from the guest=E2=80=99=
s perspective. It might be worth considering whether some form =
of<br>validation or restriction should be added to ensure that the same =
backing store<br>is reattached, or at least to make this behavior more =
explicit.<br><br>Overall, both patches are functional on pseries, but =
the above points may be =
worth<br>addressing.<br><br>Thanks,<br>--Nilay<br></div></div></blockquote=
></div><br></body></html>=

--Apple-Mail=_54120EB9-BC3C-489C-A960-4E28EA09AE3A--

