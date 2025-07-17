Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523A6C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 15:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucQVS-0006JU-6o; Thu, 17 Jul 2025 11:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucOV0-0004XI-8E
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 09:18:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucOUu-0003hE-LQ
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 09:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752758282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=saVOoAaBPzlGE8ivOOCoL9jhD6Hp4gymnmDKeMLNyag=;
 b=UfQcoF1pELJQlrLg4pRmqx1/XWwRxsJF919hRrfyL0wZzTjy0Z4PpDENQyqJCZO5J9gdN5
 hZLsnuLtW+yx5+TF4Ly2uvPbJtUWzcm8rSgvEllhGFKse8lJ8DXoUi+BVOpbzBdY5UT53z
 phD4mFo6GrHITG1exYIMz7YCiMsWn3g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-SsfVS_zsNAOd3mxjGTKqww-1; Thu, 17 Jul 2025 09:18:00 -0400
X-MC-Unique: SsfVS_zsNAOd3mxjGTKqww-1
X-Mimecast-MFC-AGG-ID: SsfVS_zsNAOd3mxjGTKqww_1752758279
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a503f28b09so575470f8f.0
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 06:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752758279; x=1753363079;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=saVOoAaBPzlGE8ivOOCoL9jhD6Hp4gymnmDKeMLNyag=;
 b=thWNK4e8e7BRQnoeLDG+S3rTgbLlPk5VsjmJNOwPEX6FYBIxNeom6zxrNUYn5hltJF
 vtXucl+reQGcoE+P1VWmktxX74O49ksikayy2U/iYU9MVtx80ox5VPctAaZs73EIarPg
 Rq3V312MQjRGaRcWgPxr56QkpJCLkOsvd0SdpG9SG2Id9nVOEBezUBKvuLRMUYNws5BP
 XZrJ6D/xu374+GwXSZY+2XS2/f0BnnF1B4Rbec91/6gA/U/+mQUJoasu9jyF4qBiAhw1
 xt9j7TN6A845LfovyjhYmn5VNag14QDPnn1GzYFi8xpUpp2sCKhfoZAvjrKxVV6Rd98J
 TBdQ==
X-Gm-Message-State: AOJu0YyXyrPnfcd35J05sTMNphR34lTgmBM8OxMLHq7zAm0eYz67lEsw
 PSlkoOOMwE9N1NL584FeAxq0x9IfE3AQf5b9Z/gP1qar61/fjfOPGfniHllO1qRQEnhaMcwRBMi
 1+y20ejSDWP7lxHwZMBJskSdIVd9vi+JgBdhVovbvxrrcQqB7/dQiZGZOgXeVMIHNzPebgNqWmq
 u/0oBKkppYpSbDjaifKY6nVrLDYBiSzEQ=
X-Gm-Gg: ASbGncvyEhgZK8Cc8aqtIH0NqZCeRMyz59MIfD1d7D24KewsDwV54XpP5yNexiXuK+1
 sdtbBSV35QzVvlfiYWuM/AJ7rXlgM2d6CrtEtBFwTbQAXDiFBW4PzzbuddpkDuby46/TAMUQ3WW
 LF9VYNSTMYXkMWVisArM4=
X-Received: by 2002:a05:6000:2f82:b0:3b6:17a8:60c0 with SMTP id
 ffacd0b85a97d-3b617a8646dmr1187403f8f.25.1752758279206; 
 Thu, 17 Jul 2025 06:17:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCyI0q7dONXjcg7BOL6znD1t9pr8Z9llYXKHEw1eXU3Bsv/l1FmIdLg6kYwSiJPR4REkHyvruJLIMbA2fM/e4=
X-Received: by 2002:a05:6000:2f82:b0:3b6:17a8:60c0 with SMTP id
 ffacd0b85a97d-3b617a8646dmr1187374f8f.25.1752758278693; Thu, 17 Jul 2025
 06:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250717062727.305466-1-pbonzini@redhat.com>
 <CAAjaMXauWy1sk+JkjTRzAf8yA72Xk=Qbt4+yw7XNPfx=q4WTZg@mail.gmail.com>
In-Reply-To: <CAAjaMXauWy1sk+JkjTRzAf8yA72Xk=Qbt4+yw7XNPfx=q4WTZg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 17 Jul 2025 15:17:47 +0200
X-Gm-Features: Ac12FXw2vgLmU20aP5Fc3Vy8ENP9vn-hhCrtJHtPx4kib9-8pJcxMiHHKSde_58
Message-ID: <CABgObfb_7vzL21HNd5MecEM3iHM+LxCJ42D8D7K-OJSQ_p4_kg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] rust: use attrs crate to parse #[property]
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000944c3a063a1fd6cb"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--000000000000944c3a063a1fd6cb
Content-Type: text/plain; charset="UTF-8"

Il gio 17 lug 2025, 11:18 Manos Pitsidianakis <
manos.pitsidianakis@linaro.org> ha scritto:

> Looks OK to me but are we sure it's necessary? This dependency is just
> a syn::parse wrapper under the hood. Even serde's derive macros use
> syn directly:
> https://github.com/serde-rs/serde/blob/babafa54d283fb087fa94f50a2cf82fa9e582a7c/serde_derive/src/internals/attr.rs#L276
>
> I'm not against dependencies mind you, but this replaces just a few
> lines of code.
>

It depends on how many copies of the procedural macros parsing code we have
(hence RFC).

If you introduced a #[device] or #[object] attribute, for example, it
probably would make a lot more sense than for #[property] only. Besides the
shorter code it would also provide more consistent error messages across
the attributes.

For just one macro, what you have now is fine. I did this series mostly to
have it ready and check that attrs respects the same MSRV as QEMU (it
didn't :)).

Paolo



> --
> Manos Pitsidianakis
> Emulation and Virtualization Engineer at Linaro Ltd
>
>

--000000000000944c3a063a1fd6cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 17 lug 2025, 11:18 Manos =
Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@linaro.org">manos.p=
itsidianakis@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Looks OK to me but are we sure it&#39;s necessa=
ry? This dependency is just<br>
a syn::parse wrapper under the hood. Even serde&#39;s derive macros use<br>
syn directly: <a href=3D"https://github.com/serde-rs/serde/blob/babafa54d28=
3fb087fa94f50a2cf82fa9e582a7c/serde_derive/src/internals/attr.rs#L276" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://github.com/serde-rs/se=
rde/blob/babafa54d283fb087fa94f50a2cf82fa9e582a7c/serde_derive/src/internal=
s/attr.rs#L276</a><br>
<br>
I&#39;m not against dependencies mind you, but this replaces just a few<br>
lines of code.<br></blockquote></div></div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">It depends on how many copies of the procedural macros parsin=
g code we have (hence RFC).</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">If you introduced a #[device] or #[object] attribute, for example, it p=
robably would make a lot more sense than for #[property] only. Besides the =
shorter code it would also provide more consistent error messages across th=
e attributes.</div><div dir=3D"auto"><br></div><div dir=3D"auto">For just o=
ne macro, what you have now is fine. I did this series mostly to have it re=
ady and check that attrs respects the same MSRV as QEMU (it didn&#39;t :)).=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"=
auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D=
"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
-- <br>
Manos Pitsidianakis<br>
Emulation and Virtualization Engineer at Linaro Ltd<br>
<br>
</blockquote></div></div></div>

--000000000000944c3a063a1fd6cb--


