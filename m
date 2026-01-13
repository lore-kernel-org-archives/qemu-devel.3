Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794BDD29DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 05:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfXHE-0006AQ-A8; Tue, 13 Jan 2026 00:49:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfXHC-0006AG-Uy
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 00:49:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfXHB-0002ij-Gi
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 00:49:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768283347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LDyeFnzWIjIZ4rBvcKAALuUy42/VN4QuMuCYXIPeoBU=;
 b=SCPRqsr/tVshrRzf48kJhZWszfyKij+9WUqp4Ua7D09HrOc4WMy5BkWp1F+ZRne8D2K1tl
 fBpWTEB0unPEdUFFu/hLn+1xJYCZszWssZVcFalcOeuZtKNeXiHV2xrwG0BdfnSLco7UC1
 fWagI47iCOhu/m1AbSY86FbEzaLsSHU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-zgvICAo_O6GPLjgj5xQY_g-1; Tue, 13 Jan 2026 00:49:02 -0500
X-MC-Unique: zgvICAo_O6GPLjgj5xQY_g-1
X-Mimecast-MFC-AGG-ID: zgvICAo_O6GPLjgj5xQY_g_1768283341
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fb8d41acso4658629f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 21:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768283341; x=1768888141; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LDyeFnzWIjIZ4rBvcKAALuUy42/VN4QuMuCYXIPeoBU=;
 b=IB/wXoeIlxyZCTBY2IJQu6x+o7fnI59gBcVJnu86nfQPrUNDKngyfGyPUqGAmwuwcl
 t96O+av81haz6WtENN8VGSlj8vcCXFUZbqyX7NftFYmWAusRoqB+ziTSwwHWwv2ScIUt
 suGJbhFxwZL7ituvg3EZpwg54AUtVVmEqSfIN61tWgyoUkAABi80tbBudAKEVriMBPei
 2XeZHMIXnNS1S6RRrO7UXdeu8Pk91jk+BVMUyXz4WwyNgSMbUopiqGgDi72w5bx2iRY4
 n1nAEdJlSQ+g2fU6M7z0VD1yKaIptj1BhNYFfFDTUKpkm1wPcvykd2P9uSbIkQQsJh0o
 Cmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768283341; x=1768888141;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDyeFnzWIjIZ4rBvcKAALuUy42/VN4QuMuCYXIPeoBU=;
 b=NdJjlGmAkqNRUUUjjlVPAAsdTah+gujh2zydQBDokzxh1hqBnmh4Z0bv3d7tdDxFtu
 OG2QdipPLF+fMqv37ELZWyrRUnPoPwQTqqemc8uFwOM8dIl2+szz9NhiCZtV7fEF0D3O
 ttWeTRPvRdwj7uq4V0CtqA1trhnc9q1MP2609D0RJw36goP+mamBVF4BlZh6dYLFJtA2
 cQb5tjwHpptaa4rjwUEVT2swu3X5PAAc1HvVQsQzrWEeYx6L72uP0ewB4f1glVNk/cqC
 2JBlQvfvV8KD5P3ePwtVsU2tVvsm0D8RF3sXAaWNqSIVONONYr5ToYY0dS0R3V0Hsp58
 JJ0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGQW7xXa1fHSzWAMO5/eNhTaiTcGDwiWvcbv98pC7vbGrTzLi76RQAs1cid8Gr+eTLdDWbO+APUrRy@nongnu.org
X-Gm-Message-State: AOJu0Yz+/YD5l4sDBVIX3FIxk6uj6XFtDXG3CucuOwTSjHJk0vbH0JMM
 wyZm7gY/ruT5Yy/6B4zQg9qztoIATNi6KDfZcNDs5ivWcqZl3SKYmad7y31xtKDwJq4Ma9qR575
 YLeR9t94DwjgJgc9n7LLHH3WJu7Qk/pR6SzC7EmDGu5HmYrT2P6wadCmlBaZTH64QzvSBGblxR+
 cg4o67HsBjEbsPi7/rn0mO98oM+TrIiD4=
X-Gm-Gg: AY/fxX5Oyb4UdoUmUVg4mWOxN3kR8K0bQlvQjx8oYwjDt1uHfPp9fsB7lnPRYy6ZKGj
 hrGchJmap58ANa+F9nk7lLoJt4Y5rrehtPLqrWkpCK9cWQ4O3yGhS/P8jWT7IWkfc4JRrgTx92h
 8J/HgFYqc632HOko2BZyV26+malyt1/cXx7GrjzDS2rDQZqoSH8+l83EZR0HurN6zZnkXjp1w89
 r/E8TmUddxHRMR5rzCkBMG3/19xih5W6T+s6AS3awk3BzpsVXb13rzCFCRhp9wxU+Zm/w==
X-Received: by 2002:a05:6000:420c:b0:431:67d:5390 with SMTP id
 ffacd0b85a97d-432c37757demr28869473f8f.54.1768283341432; 
 Mon, 12 Jan 2026 21:49:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGFukhfkyaPtUww0AWcBj8b0or8ycMndfocghC2EaGKCrlGh7OzWaX7f8SVcojkb065CkvQUMYxCIOtdMBkjQ=
X-Received: by 2002:a05:6000:420c:b0:431:67d:5390 with SMTP id
 ffacd0b85a97d-432c37757demr28869449f8f.54.1768283341047; Mon, 12 Jan 2026
 21:49:01 -0800 (PST)
MIME-Version: 1.0
References: <20260112132259.76855-1-anisinha@redhat.com>
 <20260112132259.76855-26-anisinha@redhat.com>
 <CABgObfbA_SODCgRFkX61nt+tdGK7txurUXo3yLbSuMfnjyyG8w@mail.gmail.com>
 <CAK3XEhM2Mc7orgjb827v836e5Yh8w_TFJB_nQd_+zsOUa2dB2g@mail.gmail.com>
In-Reply-To: <CAK3XEhM2Mc7orgjb827v836e5Yh8w_TFJB_nQd_+zsOUa2dB2g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Jan 2026 06:48:50 +0100
X-Gm-Features: AZwV_QjJJ010WDr6jWVBbu1vMhMSEDswohG3w45iKSN7STjNCPLo76leRcvNBJo
Message-ID: <CABgObfZudSpyVmLBZ__1VzSW0Ezst+xWb6TBaw8t7j+8f9auKA@mail.gmail.com>
Subject: Re: [PATCH v2 25/32] kvm/xen-emu: re-initialize capabilities during
 confidential guest reset
To: Ani Sinha <anisinha@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm <kvm@vger.kernel.org>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000067da4d06483e8c78"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--00000000000067da4d06483e8c78
Content-Type: text/plain; charset="UTF-8"

Il mar 13 gen 2026, 06:26 Ani Sinha <anisinha@redhat.com> ha scritto:

> > > This patch is untested on confidential guests and exists only for
> completeness.
> >
> > This sentence should be changed since now your code can be tests on
> > non-confidential guests (or removed altogether).  Same for patch
> > 23/32.
>
> I can drop all the xen changes altogether for now, if no one objects.
>

It's the opposite, if you dropped the changes you would have to make
reset_fds fail for Xen guests. Keep them and add a test.

Paolo

>
>

--00000000000067da4d06483e8c78
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 13 gen 2026, 06:26 Ani Si=
nha &lt;<a href=3D"mailto:anisinha@redhat.com">anisinha@redhat.com</a>&gt; =
ha scritto:</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; &gt; This patch is untested on confidential guests and exists only for=
 completeness.<br>
&gt;<br>
&gt; This sentence should be changed since now your code can be tests on<br=
>
&gt; non-confidential guests (or removed altogether).=C2=A0 Same for patch<=
br>
&gt; 23/32.<br>
<br>
I can drop all the xen changes altogether for now, if no one objects.<br></=
blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">It&#39=
;s the opposite, if you dropped the changes you would have to make reset_fd=
s fail for Xen guests. Keep them and add a test.=C2=A0</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><div class=3D"g=
mail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
</blockquote></div></div></div>

--00000000000067da4d06483e8c78--


