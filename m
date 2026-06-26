Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDC5CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd0yV-0007Up-DW; Fri, 26 Jun 2026 03:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd0yR-0007UD-89
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 03:27:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd0yP-00088v-NA
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 03:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782458855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=niIMWCOxj0jyzvwil8DC+bw8lLMbfqm+6cZraZQfO0A=;
 b=T3E/tm7bQvsvSBnq+h9Zb3PCkBLGHjUMlzRG0VdX0Ka1YNryEF1s8bTX+MxBLxfNSL/kdI
 /jQzSY6qcSZNiZel0NIODek9ppHRVcavMJBXCETTUxnYZZfpg+ZaHxL44I36sXN8B/HTZV
 1ITZyNLtk6zDHhU8xZsuElOW6n09Uhk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-FBNBlbdBOYaT8IHGAaxhAw-1; Fri, 26 Jun 2026 03:27:34 -0400
X-MC-Unique: FBNBlbdBOYaT8IHGAaxhAw-1
X-Mimecast-MFC-AGG-ID: FBNBlbdBOYaT8IHGAaxhAw_1782458853
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4625b4f54c6so439426f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 00:27:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782458853; cv=none;
 d=google.com; s=arc-20260327;
 b=tBEnUXGtoQTOclLAjoWryj+kbwRgRgxOA/otK8dRhCJPWmBhwu/CmAFPjCB/klKaVd
 aFLw5kJbUj4/XuiM0pjGmWtZ/e0ZOIprjHekapmpDtY6lTy0LcCMF2EU/8DpT6TVn7Ax
 aTWdn8GdlWDABRzGxXh7+yuS3GOXfott1MFSquQe88z0FLyVLMUAxCboNRiYjecc1eV2
 pqvsC48k4cdBFq3HV36mhfc9JXkrg1osgGDFczP1Bi9LcREeLW/lAN2XyVVu4kA+KYrX
 8eXSvZRm//AyFpXlkW2q12RInxqP1sl30CULanaRnrl9wNAdhUQ+pkK58PfxL12oeErZ
 kxiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=niIMWCOxj0jyzvwil8DC+bw8lLMbfqm+6cZraZQfO0A=;
 fh=Y6ZVa2DAQ7N99Yz30qJegDSPM58qw0hum3KbRozMzY4=;
 b=QNhk+qEd/BcvetVf1o10dmrYcDdH10nTCWg0114MTJnkjSDpClVOzR0e/2VrYuQVcJ
 WWdZ/xqSZ67aCFJZ9kwMOS/KkRdYEK8wOosrsnCBWZ8uSqjaQdcuiMQsWBIuLyEFAeXQ
 ya6o8fxS6odpWAubhH6D6zvycAL4/SBtrGPwz2+lcOrlgtivVq8F1n8k2BwzB+mZzZg+
 ONUJ/qh+KAwofyb1kBHR1QFGYf4xfKJwYusFeDMBiT6S0Mgfz8+2OHGX8d+eU5doYkv5
 EOEz8x4ZONpVYpsO6DjYSqC63I59s0vK2E2h6RSM+YzODTPmmKF1uvOapGIjTeRTEHFB
 gA4g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782458853; x=1783063653; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=niIMWCOxj0jyzvwil8DC+bw8lLMbfqm+6cZraZQfO0A=;
 b=p4bpbcjRyu+CFClunK9L7fkPpAw/8BpNTYefPvjxEbe0m/Z2CDexkeZc5UJXaqpsPY
 AfHm7Zb7ELf413eLHSOfPybDUpU/2Q2yMGUKP5fUbZOeY5mn2cva6QMOpxhfQ5cnGeW/
 j3z2wZ6M7Sa+DaSsaArRhqi/jZWN/k3gbumKf3lftsMkmtR0+a7BKHVJdYAvL/QX8Agz
 yxLDrXXcUPvntjA7SG4foolYpoW66vYjJQbo84akuWBBr+PGXsl5yTR8l+FFj8jQYg9j
 iDRugdyJqntSv7w8dkzIQzAk6Wy31aE4waQpEC0sLQ8d1SedyA4VkGqjaHnLFcK1v3vy
 DrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782458853; x=1783063653;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=niIMWCOxj0jyzvwil8DC+bw8lLMbfqm+6cZraZQfO0A=;
 b=qgl9c+wmRGxuvHntxKJFEGvaITNgogasi8gC3bXcWEN+2844f3Krs+MJB4ltZ29XdP
 86ixXlHJZHs9bbPXoQoTxM+7rp3edF2tE55wRSR4ITki5bmUoR5mz0dxfsTlQeOIdK00
 wF4HF7e6BdObt3qT08QJA+ccqqUTOBabACmno2LEJBTqwjuu7RND7XMdh9PuDso6i6tS
 9b94h6WkLvXcNy1VCnjJKN43NpWx3UvnkbFDdCSSgV7kMNUZvTBmGCtNQf+V0fuzH/cG
 1mKGWR8KRB5V6kJCASKD3ghCGCMrW2Yo1/KxmKO5n5SmGZKMdUe0fvblEpl2Qn1rJzWl
 VXcw==
X-Gm-Message-State: AOJu0Yw65iHJjYUCALKqgALcp3vc74ZJfrjfou5Ad2oXQdP3M6LP7Gdv
 q8XxkDeeIiAGOn4jj2radZFCI6EB3+7D2ntKKrGFadhDknCGbdlSrPrknMkYoBCFWykuAvFZcJZ
 F6by6XlIel0slsBJO7WIHjsk9RghzInlz5YkWRP8Arfrb/rKcSSV2FWUyDXJlAaksC+rTvz+Z8k
 32ME7TMMhySlx5wbnDFvinRIsYIROicDw=
X-Gm-Gg: AfdE7cnMb/Rmly/uNPKEVvS3EV+iStFxoCzTZ3A5LAS/uUGlc0bZNXNEpbpTJi1FSiw
 6UZzgHZFNCRmbaNRiU0S3XwYqzkwiJFRaOwMU0nRuusPKNCfWpj9+X2+lUG0/peVRRc9WLcsRAK
 sV2iHjvFrgWg0I9LZSFFQLMmRZL2cWMTuB0MKSXNbWp2OWr4Ep0hG3PiNW/LLtfpnbVmoOvgo01
 4PZF4HPV4up1UQihuzBDFULpf5eLZDr38ruH389isHGynMSzcOTbI7Lamx8grdjxFJWVg==
X-Received: by 2002:a05:6000:4025:b0:46e:fce3:d674 with SMTP id
 ffacd0b85a97d-46efce3db5cmr2284189f8f.26.1782458852848; 
 Fri, 26 Jun 2026 00:27:32 -0700 (PDT)
X-Received: by 2002:a05:6000:4025:b0:46e:fce3:d674 with SMTP id
 ffacd0b85a97d-46efce3db5cmr2284160f8f.26.1782458852486; Fri, 26 Jun 2026
 00:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
 <20260417105618.3621-17-magnuskulke@linux.microsoft.com>
In-Reply-To: <20260417105618.3621-17-magnuskulke@linux.microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 Jun 2026 09:27:20 +0200
X-Gm-Features: AVVi8Ccj7AuyELz4kfG1DwAaBwB74z_0XLtDZ9_lgC7GitRjJPKb632UuFYl0r0
Message-ID: <CABgObfbgqcSYekjGkuDCUibQc8j4iyGPbajU_-VdPsGkLZgiLQ@mail.gmail.com>
Subject: Re: [PATCH 16/34] target/i386/mshv: migrate LAPIC state
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <liuwe@microsoft.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Wei Liu <wei.liu@kernel.org>, Alex Williamson <alex@shazbot.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000bad5930655230afa"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000bad5930655230afa
Content-Type: text/plain; charset="UTF-8"

Il ven 17 apr 2026, 12:57 Magnus Kulke <magnuskulke@linux.microsoft.com> ha
scritto:

> +#ifdef CONFIG_MSHV

+ VMSTATE_BUFFER(hv_lapic_state, APICCommonState),

+#endif


This breaks migration across releases for everyone else, and also across
builds that have different --enable-mshv. Compile-time defines are almost
always wrong in VMState definitions.

     DeviceState *vapic;
>      hwaddr vapic_paddr; /* note: persistence via kvmvapic */
>      uint32_t extended_log_dest;
> +
> +#ifdef CONFIG_MSHV
> +    uint8_t hv_lapic_state[sizeof(struct
> hv_local_interrupt_controller_state)];
> +#endif
>

No, this is called common for a reason. You need to implement a subclass
and handle migration in there.

Paolo

--000000000000bad5930655230afa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 17 apr 2026, 12:57 Magnus Kulke &lt;<a href=3D"=
mailto:magnuskulke@linux.microsoft.com" target=3D"_blank" rel=3D"noreferrer=
">magnuskulke@linux.microsoft.com</a>&gt; ha scritto:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">+#ifdef CONFIG_MSHV</blockquote><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">+        VMSTATE_BUFFER(hv_lap=
ic_state, APICCommonState),</blockquote><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">+#endif</blockquote></div></div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">This breaks migration across releases for everyone else, =
and also across builds that have different --enable-mshv. Compile-time defi=
nes are almost always wrong in VMState definitions.</div><div dir=3D"auto">=
<br></div><div dir=3D"auto"></div><div dir=3D"auto"><div class=3D"gmail_quo=
te"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0DeviceState *vapic;<br>
=C2=A0 =C2=A0 =C2=A0hwaddr vapic_paddr; /* note: persistence via kvmvapic *=
/<br>
=C2=A0 =C2=A0 =C2=A0uint32_t extended_log_dest;<br>
+<br>
+#ifdef CONFIG_MSHV<br>
+=C2=A0 =C2=A0 uint8_t hv_lapic_state[sizeof(struct hv_local_interrupt_cont=
roller_state)];<br>
+#endif<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D=
"auto">No, this is called common for a reason. You need to implement a subc=
lass and handle migration in there.</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Paolo</div></div>

--000000000000bad5930655230afa--


