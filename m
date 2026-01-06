Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59460CEFCE1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 17:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdAZA-00031H-Oi; Tue, 06 Jan 2026 12:10:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdAZ0-0002t0-Vv
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 12:09:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdAYy-0006hW-7R
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 12:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767719382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y6Tny4R56U13KtkzV9k8Z9TNHoL16TdiwzeSTuS58Cg=;
 b=C2EaGfd35rcNZCpBnENPZ2ywSstWLLb1aak4evfVXYGnDmUklInrnkGt7M+PAvPC9BGKUp
 zbnTEvbEGorPAsygde8ncIQ53N2Njb9IZFe/5q7UjxoOecKkGy6dHTiiNE1Vk+Jvk99EHU
 2uXWUTF6PzIjPGI8PhliDrybOQ1wqFI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-KpPUysf8NXC80MM-bDcUQA-1; Tue, 06 Jan 2026 12:09:39 -0500
X-MC-Unique: KpPUysf8NXC80MM-bDcUQA-1
X-Mimecast-MFC-AGG-ID: KpPUysf8NXC80MM-bDcUQA_1767719378
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430fc83f58dso676295f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 09:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767719378; x=1768324178; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y6Tny4R56U13KtkzV9k8Z9TNHoL16TdiwzeSTuS58Cg=;
 b=OYkU5PSP4ofTHs/Ob9IRl06sRJgIF72YMZqfpKL0m4yQGBNYSZfY6Zhk9yVQ4i1TKx
 JQjKJi81KbTE7Y2q7Lp1MQDCgxZg15CYokxcN5nfgHbJTmHBz3uwY1Xrp17Sv31+79UM
 SD2DdoqPZR+ZwHyaGxMYlGQTen/LVcZMqAVJwIVbS9oPcaZqrlre6m8UgPtTxgNmqw35
 6S7mZ7C0O+wUKaP/hUpLL+MZVPkCjkVZA2yJKbbaopIDf7SziCXMrDkDo92hik9Hthlt
 duUnci7p9LeWUMuvKZBOG4c+ipRTPNwGeZgX9MlpsVltBAeMXA/6amcQn97fP99mJRiX
 w0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767719378; x=1768324178;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y6Tny4R56U13KtkzV9k8Z9TNHoL16TdiwzeSTuS58Cg=;
 b=I00RT+bXi66jAavattzd+cpSRqbgXp+F8JrgfmCywYllLD7CnADRsCcCK6QSGovjbv
 oitOjuYKhQ/OviinV5RQNeouJ0WmqOcwLRKG9szJtpudJ17IMSucOvAAMGg7Iu6pm6rr
 cBJbNRXWeABKjh4YDcIFmcCJh7GfgkIruZmQEt835EJIdAKcTj6R0pYJ1TDbWW1HlPVE
 R8CMm47gUu5E/weaye8ghFWN+0HGhJ0hG7lIdQ5J1aDGCppNafDXZpeu4GDjax9H6xOB
 hCVNcEh5+DvjlhzXRygHm+2JLweGslVQNZh5tsoLvez970xIy0Mq8d6EMieamvdz43bU
 VHFA==
X-Gm-Message-State: AOJu0YzmPAuEEkSTCL+Hg4j4rn8RnXKchtnG3YBd+d3uFEMylHDUhpWo
 7GaLCFgq0oqMb5KINccoR0iKU6ebja6xhcEj53gLDVSJ18p0mv28C+jnFot+0YTAl2LT/Afb6Uh
 rHzUAvfZDffX0dyMxzwfIkhGGENSEGKLEyrrqXtf3m7wuFWavkL++OIZYIRPawVttPiNekSU8Qa
 ipQ4o8qdIIqsGzhU5TEQDDRJVMO5iVnys=
X-Gm-Gg: AY/fxX56pr0FiJmDH1Wdmo6xNK+toky1VKLZkd1W4T5COkm3JGJAjtVxlg+62y9YJAn
 aL5T3yArxlGuSZKS/68xG5//BS5+luN4jZ/m3FHb5ZSkqwSLeZsHtB87vAhxXp/bYBvEbAolFpK
 R1xY5aoe9zXSI6Zl1K5FVoaJHxZWm8B90sMcLXWyxaRTKIE1VFHVnLH2gBAeqFJKSyTcNKFEtZ+
 R3dIA/CjY2jQgeIcksvMC1FZYTm6I5nvvsAi6QBflz4c6kpBcNqMNXdVPbCC7PC7cx0uQ==
X-Received: by 2002:a05:600c:b93:b0:479:3876:22a8 with SMTP id
 5b1f17b1804b1-47d7f07467cmr44928315e9.16.1767719377907; 
 Tue, 06 Jan 2026 09:09:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkt4q8CkHoScWnTY7XVsFQbN0D8I00jpPHJjQJbBywozT5S8/Vg3JPuazvT3dzovqNyARza5EGltgAZlhvrAc=
X-Received: by 2002:a05:600c:b93:b0:479:3876:22a8 with SMTP id
 5b1f17b1804b1-47d7f07467cmr44927945e9.16.1767719377496; Tue, 06 Jan 2026
 09:09:37 -0800 (PST)
MIME-Version: 1.0
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-4-pbonzini@redhat.com>
 <2ebaf5b2-1845-4af6-9da1-e4eb59fec0c3@nutanix.com>
In-Reply-To: <2ebaf5b2-1845-4af6-9da1-e4eb59fec0c3@nutanix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 6 Jan 2026 18:09:25 +0100
X-Gm-Features: AQt7F2qZv2g5758Wm809_n3D5KQ-zKt1dbccmo1OVRCdVcYi02lsWlo2hethY-s
Message-ID: <CABgObfZAH9YaZpb9oOYSGr7-URfE=EBaak+jXLVXqXBnU-Coqg@mail.gmail.com>
Subject: Re: [PATCH 03/18] target/i386/tcg: update cc_op after PUSHF
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000008efe9e0647bb3da1"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000008efe9e0647bb3da1
Content-Type: text/plain; charset="UTF-8"

Il mar 6 gen 2026, 16:19 Mark Cave-Ayland <mark.caveayland@nutanix.com> ha
scritto:

> Hi Paolo,


> I noticed that my WFW 3.11 test image stopped working with master, and a
> quick session with git bisect pointed me towards this patch.
>
> I'll see if I can dig further into it.
>

I think s->T0 needs to be anded with CC_S|CC_O|CC_Z|CC_P|CC_A|CC_C before
placing it in cc_src. But there are probably better ways to fix it using
assume_cc_op, I will check tomorrow.

Paolo


> ATB,
>
> Mark.
>
>

--0000000000008efe9e0647bb3da1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 6 gen 2026, 16:19 Mark Ca=
ve-Ayland &lt;<a href=3D"mailto:mark.caveayland@nutanix.com">mark.caveaylan=
d@nutanix.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Hi Paolo,</blockquote></div></div><div dir=3D"auto"><div =
class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
I noticed that my WFW 3.11 test image stopped working with master, and a <b=
r>
quick session with git bisect pointed me towards this patch.<br>
<br>
I&#39;ll see if I can dig further into it.<br></blockquote></div></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">I think s-&gt;T0 needs to be ande=
d with CC_S|CC_O|CC_Z|CC_P|CC_A|CC_C before placing it in cc_src. But there=
 are probably better ways to fix it using assume_cc_op, I will check tomorr=
ow.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote=
_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
ATB,<br>
<br>
Mark.<br>
<br>
</blockquote></div></div></div>

--0000000000008efe9e0647bb3da1--


