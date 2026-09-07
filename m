Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B36C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ZJO-0002MX-TV; Mon, 07 Sep 2026 09:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x3ZJN-0002M0-Qh
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:23:01 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x3ZJK-0007cy-UE
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:23:01 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6b8e2d8df4fso1478356eaf.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 06:22:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788787376; cv=none;
 d=google.com; s=arc-20260327;
 b=SNS9xVuVzXVU0bMbgslBdFZk0RNbh+V3IZQWD0QnJM2yVMs02iqdKrm+dj3t5SJMUa
 iwvSsEDrGa3vgv6CCpgFgJ2T6GZvB748G4UAy+HJamEJvw9hArf5nx4eHRHRsK1dSKts
 XMYyTuk5yaxrH/G2jKQHe78BwTfb7l8pQkmn3j/gfBQvg5H50Z6tg12EzOTk4gfYjbZU
 WX+Fmn257GJKPD/+3SM0Sbgr3g6OBEZpWCLVhb8nVulVFytzn2yDfHy1saLT5tRGzfnd
 7jpYw3P+ht56BM8eBYPJR32yHy6vATmYXR5bs6REpNvqa8nDJcl7sPwNYjq4pVaYynro
 AXXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UlmXn5XFwHuu5bAKOSvrcrxBAOgoLVaDqZUm5RWuyMU=;
 fh=bESEkXVLjj/7bpl4lhS4i+Tq8j5rICT1VkoPAENe9+Y=;
 b=lMUZpV0bX4gAkwlmZoehlMmy3YcSWEUipTl2c9+ng9f/yUMNznH4kNoVDEeDWIEV8o
 sUlgTcGZzhfLjriAZa4OHYoemjam5OQwg2uylkU77tUVfhxLKUr5XivRhIOsr5mCtw4Q
 aXi9wpWw6xCkZSUvSJ2PjEbEu1pvLiEE3d7zdKnUqBJ4JTNAJ8j4cEWVNTEcKJINA+jc
 wzFN5aT4IoHoQ2T9W1vbwOkRBB8IrnpklwuIag+iwhPhvKcN7qsj7typmdFNYHzypE48
 V9swpKXEDNoBfVDoxl4dmYfN9hNtLjaAqjXzZPqLZXHoaC5zvVBPU2ZjuTFiB1Hy4GI6
 NXRg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788787376; x=1789392176; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UlmXn5XFwHuu5bAKOSvrcrxBAOgoLVaDqZUm5RWuyMU=;
 b=HbkN4irLTsJN0Ke/lC0VWmSNMB2WfmnQMDpoD1gYChrjvJEwtgBj2TD0B/6jP+8W7A
 ayT4fJ4DhzhXKeh0TmqwQQEU9S71279+gL8dt1ZpRPBy37oLjg6fljzqMk7sXADHy8qx
 lx8joO6QgIN+iTGq2ptbLEmYe6c4RcfbsS24zzM/rxWWroyHmCGJOypk+FzVFlc1EtDe
 ivUbuspy6trU7DkWx5WN0AekaitW5l06oiiycFC1t+yixtl+pPOW7QuKutZKyjfkzmgL
 PEVIW97aktRaGp1z31cubHt73ZMx+M/oG3RLJdn+eT6GgtT+5ihfhhc7STb20Ahez6aY
 EV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788787376; x=1789392176;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UlmXn5XFwHuu5bAKOSvrcrxBAOgoLVaDqZUm5RWuyMU=;
 b=q0vjS5UZnBooXv1+Lxn1QLmL891JNj2kivteVoyGuNoYKSgNVc5/hyxFZCT0fgtLa+
 XO24Kq6n+o7idP54X7n1IVjt341xI1YbDVZg+E5dn3+MIelMRZqSXWBCXG/YYP9NTUn1
 fxqBOHmjwV3qxePD2KO3oElHV6yysAinnuVDSB4s0yZ5vyVxEHt1P6D/UmB5+3n4DM2l
 dZ5mBeGcEggfzMUdZPhWHQTyi8pTtSXbl2afJZLJAnRGV7pLKNvWHYq2Wl8gKOuS8LeU
 KHj83Zkxqp5Gs63rN56NecKQqZT571FG/KaFlZkumR1kDrEDRqGtK5lIkI4heSKTE89I
 NGJg==
X-Gm-Message-State: AFuF++k8UQJ7dIWKcC9SGNSreQKDiT0V6hTpMBlIiNUiIVqpF8YXGMhV
 YL4SqSbEHVGsm19+RCBV6UAR9A4Ovn94qQJRO8fTQCQ51aKnJbDDEA9Mak8d+Jq/wcgtYQSAdDT
 TK9Nq41sHfSGyyJf0pd+Y1Iyr9GD5c1s=
X-Gm-Gg: AYBFou0/oFRxrqoQZxBXaR75ATNAxa4R7fv65UBjnEnP4m0AT2fREJ6rw+KX4lCM1xU
 Muz2m3p9es4klZntSDyYzEoWWwBX2XrbY6HU+LRbf4QJqpnncqPcXa0hDMOLznrjspry2dbwQ5B
 vRN0918TtBAExOuUxWIRhBDJ7O/FocDIZcHXnZmjEOy0NYS57NemPS+AiLzp83AfRkSFb3KXjvz
 OEQER3jaIYNY6XQmlGVpbS/Qbv5PPJlPRMnPcXV+MpVrwh1SZWzQtSDjoet8tl5RnVc9wvey+uU
 KoY5RTROrQ2DX0iNNRb6UwpSSqZF6iu1hb719InI+0JzYDjgTIjyeG5e2uKvLa8xQr93RvAzVDZ
 k
X-Received: by 2002:a05:6820:1798:b0:6b7:46fa:16a3 with SMTP id
 006d021491bc7-6b746fa1addmr11834654eaf.56.1788787376091; Mon, 07 Sep 2026
 06:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
 <20260906-nohmp-next-v1-2-2b21e63974f3@redhat.com>
 <20260907075640-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260907075640-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 7 Sep 2026 17:22:43 +0400
X-Gm-Features: AcwNN1XnN-2oQKhD7NPPvTaTB_Rq_yBoi6aT19bR1t2Pdi1NvCovgqYOfupJBS4
Message-ID: <CAJ+F1CJfjvYWRW1Az=1Q2vUMM+RS56-_a5ugLbepeznHm8pvxw@mail.gmail.com>
Subject: Re: [PATCH 2/9] tests/test_vhost_user_bridge: skip when running ASAN
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Mon, Sep 7, 2026 at 4:03=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> does not look like this patch skips any tests?
>

true, I will update the commit title

> On Sun, Sep 06, 2026 at 12:53:34PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Running vhost-user-bridge built with ASAN with stdbuf dies:
> > =3D=3D2431898=3D=3DASan runtime does not come first in initial library =
list; you
> > should either link runtime to your application or manually preload it
> > with LD_PRELOAD.
>
> so it dies but why? judging by below because of stdbuf?
>
> pls describe the fix not just the problem.

Running vhost-user-bridge built with ASAN with stdbuf dies:
=3D=3D2431898=3D=3DASan runtime does not come first in initial library

The fix skip using stdbuf when the binary is built with ASAN, since it
seems optional anyway

>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  tests/functional/x86_64/test_vhost_user_bridge.py | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/tests/functional/x86_64/test_vhost_user_bridge.py b/tests/=
functional/x86_64/test_vhost_user_bridge.py
> > index c36c62542053..5fedf61c5e72 100755
> > --- a/tests/functional/x86_64/test_vhost_user_bridge.py
> > +++ b/tests/functional/x86_64/test_vhost_user_bridge.py
> > @@ -73,12 +73,25 @@ def configure_vm(self, ud_socket_path, lport, rport=
, hostfwd_port, tftpdir):
> >              "-netdev",   "hubport,id=3Dhub1,hubid=3D0,netdev=3Duser0"
> >          )
> >
> > +    @staticmethod
> > +    def _is_asan_linked(binary_path):
> > +        try:
> > +            output =3D subprocess.check_output(
> > +                ["ldd", binary_path], stderr=3Dsubprocess.DEVNULL, tex=
t=3DTrue)
> > +            return "libasan" in output
>
>
> this is quite a hack

yeah

>
> > +        except (subprocess.CalledProcessError, FileNotFoundError):
> > +            return False
> > +
> >      def assemble_vubr_args(self, vubr_path, ud_socket_path, lport, rpo=
rt):
> >          vubr_args =3D []
> >
> >          if (stdbuf_path :=3D which("stdbuf")) is None:
> >              self.log.info("Could not find stdbuf: vhost-user-bridge "
> >                            "log lines may appear out of order")
> > +        elif self._is_asan_linked(vubr_path):
> > +            self.log.info("vhost-user-bridge is ASan-linked: skipping =
"
> > +                          "stdbuf to avoid LD_PRELOAD conflict, "
> > +                          "log lines may appear out of order")
> >          else:
> >              vubr_args +=3D [stdbuf_path, "-o0", "-e0"]
> >
>
>
> maybe just avoid stdbuf completely.
> i don't remember why we use it, but it looks like merely to
> disable buffering for stdout?
>
> If so:
>
> setvbuf(stdout, NULL, _IONBF, 0);
>
> will do just that with no asan issues.
>

That requires modifying vhost-user-bridge, not sure that's what we want.

thanks

