Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78C0CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 16:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDlk0-0004Rw-02; Mon, 05 Oct 2026 12:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDljm-0004RW-Ri
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 12:40:28 -0400
Received: from mail-ed2-x0e.google.com ([2a00:1450:4864:33::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDljl-000175-6j
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 12:40:26 -0400
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6afbfed31d1so2172598a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 09:40:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791218423; cv=none;
 d=google.com; s=arc-20260327;
 b=Phzbr5vYYOh59zWhgHq1w25vrV4pmPpvp6r+Sx5XIeVR2zjwRBV0nUqmLQ6ZY4srT/
 wNum1uODXzYwvlGTKgnR3p1AZvrieaOi/E6DjjzhO4jskeDUSOVVHt3PNebA+3zLxy9Q
 PxtVoWwfuhzEmg73PeQfGy/v1as8Af598TPub0Ev00Ghu6XeagPZfKTmLE/kYbLCxo6q
 qe318GHqtnt8+2JrkhQzdUsgLSx3cCsn2M7I/kOBYK+1OUACRJl+w1Cy6dWsbPAaFhFP
 HOcFVmSfhGTqBSBQkCjzdeWqaqwu1Gq1VyTob/8XB80XG+2Wv9wH6VFlsdef82jVs5Co
 HY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=uYdpFCV1QlFS7PrY0+F6CjY1a1t1Vs25LY4j9FW4PtI=;
 fh=IWV5i/bmsnDDiumGg7GH/qn1tjabzJqEv+mL/WiBNIs=;
 b=BLI1NX67+00g7QtdrF1eXdFBMYP1aRr4Y+iIq6ir6/sImPh8RweGQ/CVN2JUYhC327
 zWFdOMT+1nRaOZKqrjfg1Fk6HT+nDgqpL3LbB+6yI7+kBVwnfvZZpJe5opJS5zB4lyc2
 5E7d8kofrYex6UGQKDGMsPYFtpvcRFBEBH7cUoy9p6b8NwlNOau/dOfKGpRTomG1VMd8
 khkqI38UCqShKkUFGWunvk0zG5rAgq/T1a8RC95roNFGj96vzpRDSrscX/UcLs/NWNtF
 2Br9oHa5tU5OPqQOkgkqeuoCK39z4ckKKW4ZUIj2koI8rdLru4/OtD1vLJ65VV1kZ6qt
 My3w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791218423; x=1791823223; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uYdpFCV1QlFS7PrY0+F6CjY1a1t1Vs25LY4j9FW4PtI=;
 b=eaxPn856PPDO8O1bWt6LQu6OH7kaYFRdon9plFOawej0ki3WX8Pw9JRrRxgw2iVHKr
 q46Rkc1w7JsKMpvxOchLcFgSrnsy0SvJsqk8rs/dr2hQ/rsjcH3zwr4zuge94g6M4Np9
 PXPeC9jsU+hvx98Y3RHzd97aDYltEdbY5rhwjHY04SWTc6CdJvRNDWnmYBCPMqQBOBCZ
 2xT5yvMQIezzr3IhcQwey6XaZE3B9u7I9wWelPFX8KeZP2OZOukmVhMNPeclf+Bji0YG
 /C3yFGMHtg6CnYe7esm7NXsMJPvVzLyW//y5tN/LXs8aRFrXo2HooRAGWiR5EaxVMu/X
 aWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791218423; x=1791823223;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uYdpFCV1QlFS7PrY0+F6CjY1a1t1Vs25LY4j9FW4PtI=;
 b=XYIOAD/CtiS/2ag+QQ0tJ/TDbHv0fhTbPhvUc9FS/6OudjninCHjjWNHAimKrFuttE
 XeC4qrnTQrZhRhOsz53cWdebkq+C+Nd9GHPFz+jkJ9dxCFkYz0fKDp/VpN4co4iqQYgt
 6Ga1yKdO+M9DTLw5K27tzEEyCAZwiGEiQcj9J2f83DDRMA5nw5510w0FFPYqMfNLiLhG
 Xx/tRKN0ckv3WCKCjeKJ0xknVXvSbTUVrPFQ/BdW20Hm+/srJVLbhG8K5kNtup5vILGM
 et9Tk8/ff6ODI/WwCadwJDXyrLrevDx+DC6aQLrjzmNHXunrhH0H45EKQ3G20PuiqSg9
 nWxQ==
X-Gm-Message-State: AFq9FYLFKti0NHfquJuqfBK2yvh8A2vz5QJ2OQtAtnVaGxIvjt+xRpuV
 5qs1lCYBBmDQ816tCK1q0iVRGahqEAtm6NEHz9HoFGIp/E2Lr5dXRTa7bUJK2h7Vo6qfTUplaoo
 XARgxoPAY3dcI7G4WjpC7c4V8viw1PVg=
X-Gm-Gg: AYBFou1Kl7uFy818QKUrgKCdOazQAxvrN+WMok1LAF15bDbpdhxakY9x9iaDHAuwKw1
 Zwn5/pby+7/8yAzxbUOkf4L8DRB/53mRFMJtOYYmo60FTLM/9Bu7mLHZ2KzAP0Hi18cArzSGVpN
 Ml1hN3pZMFsSWVKEbJqiDJvrjhRgYFHSGkPhzThCCjtSicUhYXWOsHudq7M5k0eg90Zs908BqS7
 U2LldkeRu5W9pS9r8IKQ8CgJX9zygWlavyKM6X+KbuwZMBLANs2i1YcqWMNI5ut0AnjEnH5iWOY
 MU+ABDvrTD5cvCxKXCyfrxMXEy4QrID2hrVwbbF7l5tedv2RuZqanMI=
X-Received: by 2002:a05:6402:3253:b0:6ae:1a0a:ae9b with SMTP id
 4fb4d7f45d1cf-6af9e2ddbadmr7607106a12.25.1791218423334; Mon, 05 Oct 2026
 09:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20261004072927.1142-1-luoyonggang@gmail.com>
 <0b84bf4d-3b98-4f52-8847-9f89bef92c1e@oss.qualcomm.com>
 <CAE2XoE-joWZwrBy-jLe+=ZP7OGM9cyDrF_5hz7koVPODeys+JA@mail.gmail.com>
 <b2297f92-a685-4399-a755-bbe5a37b9b3f@oss.qualcomm.com>
 <CAE2XoE-4Pdp_n3RgpqJ5se_KTHniMAJAodTLmkfV+0jjou=M5w@mail.gmail.com>
 <c6bd8e8d-3160-46c2-ba4a-2f5a4b93cf38@oss.qualcomm.com>
In-Reply-To: <c6bd8e8d-3160-46c2-ba4a-2f5a4b93cf38@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 6 Oct 2026 00:40:11 +0800
X-Gm-Features: AclHuK-cSpI_VvmzdN3nQwnYXDO56srgYIla2HfAxK2skSi_AsfJ84iq5qJ1rN8
Message-ID: <CAE2XoE9vcFg7zKZon8bUk8cf7MLLO9ZSa+LDQ-85UCSM0v=r+w@mail.gmail.com>
Subject: Re: [PATCH 0/4] target-info: preserve full softmmu target identity
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x0e.google.com
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

On Tue, Oct 6, 2026 at 12:25=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> I guess there is a (good or bad) reason for which sub variants of
> targets are not reflected in SYS_EMU_TARGET enum. We should double check
> that before doing any change, as it might have other consequences.

Just for record, I found the original reason doing this is here
https://lore.kernel.org/qemu-devel/20260205030617.266625-1-richard.henderso=
n@linaro.org/

target_arch() function would reparse target_name() every time if
it was not set to a proper SYS_EMU_TARGET_* value (when using
target-info-stub.c), which is not efficient.

This was found when doing changes to virtio_access_is_big_endian()
function, having an overhead of 50% after switching to runtime checks.
With this, overhead left is around 3%, due to indirect function calls.


>
> >
> >>
> >>> "target-info: Statically initialize target_arch"
> >>>
> >>>>
> >>>> Regards,
> >>>> Pierrick
> >>>
> >>>
> >>>
> >>
> >
> > --
> >          =E6=AD=A4=E8=87=B4
> > =E7=A4=BC
> > =E7=BD=97=E5=8B=87=E5=88=9A
> > Yours
> >     sincerely,
> > Yonggang Luo
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

