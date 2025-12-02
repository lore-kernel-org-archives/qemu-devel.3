Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53356D11708
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQSx9-0006Pn-28; Tue, 02 Dec 2025 11:10:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vQSwM-0005LM-HN
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:09:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vQSwK-0000AY-41
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764691758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RjBwMR0+K3Tvu5OmTnXPIXjzgfcP0YSwNSFtSFwgndw=;
 b=P2wJZ6oN/ECcgSBvHr6CkmGj+rIuKGUkZoXmmG1tCtszH5BHbGeNDq8zU34mWOjxaEvzv9
 CfDkjWdMECIPdYl18pVrVGIrVwBVYIlhQboppIPoDGcQ7ygIK9geCjW7KKu5nHIC8ZhGEN
 k5PjN1LeSw5tjnDmgncaDaAY33xyOCM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-s57H2jK-NtiItQAuFQBhyQ-1; Tue, 02 Dec 2025 11:09:17 -0500
X-MC-Unique: s57H2jK-NtiItQAuFQBhyQ-1
X-Mimecast-MFC-AGG-ID: s57H2jK-NtiItQAuFQBhyQ_1764691755
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42e2e2ee360so2054956f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 08:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764691755; x=1765296555; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RjBwMR0+K3Tvu5OmTnXPIXjzgfcP0YSwNSFtSFwgndw=;
 b=XkMdxgH9Dk8L6sK/Kvki4+EzYWhNZSSnDA4f6+urHVPVZajtsUQGvJNslbyad/2oAC
 sG0o9bSkGGN3lE7KXSR4B1IQMZbXYJi+jNHd3qLwYj9tpkq2mhD+/qg4mQdJsOjxhUT4
 PypvIbK+g0d38WYHJm4/3A2nxo5LD9L2gHNo3xNd3QpF8ZiPNST1QMLP2fizQfM7FZNC
 tG1+zGBWa6dJ7Luj3qQ8gcZcxLxYkt4v7bDdUTSxmvEhOEeVnPaz1JvQMmvC/HG1OAOZ
 TNKD6DrVif1WAKG910B2A+/+oIx3xqxEk29CL1wrDJONT2sKQAKCrApeXi9HVCzHBYhw
 /t8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764691755; x=1765296555;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RjBwMR0+K3Tvu5OmTnXPIXjzgfcP0YSwNSFtSFwgndw=;
 b=WdJ6wBoBNzf30lcYuEJ5p8E5zT67tL8DREOARlS9WDgiMcfeMCesZwfopJstYvmfbf
 xB4lyktgreNgKk1AVtenqiBbrgHBJ+a0c1A73onLdP0a9cjPeu0NpqmAaTE1TsQyKRqI
 ab9fImoZqVnDZXCnLlMMvTql+rSibsRqviz0wjLInooQtaVAJ/IHl1H3PN/vQ5OQSCR6
 PeX3n2JxW0m67SGz0dUbfOvlQ8hhHh5HFb2zufbOXreDw1FF6RV4pXNym16Tw0As4cnL
 dNDMkZdvokxId8+9WJNQ3dC6eWcofkqRZVaSCVLdB7L7LY0nXtp4eoI9GoReRbHg3DKt
 Kv5w==
X-Gm-Message-State: AOJu0Ywg9nJPeMiIFGWzyQhXMmWFCjwjEOokHk9rKDzsg5dlQGtEaGDB
 AZYPOJgcIE2gXIyAew5eTwzHAl5qWctAwMl0uePYwmFMWp0ctYL5vgaqdNMV/4gszC1ESBsPdZk
 O/rfOQDoSxJ8BsGY3YJPFORvMHXUQUzA5zzgmKIwsMXOa/lBxbKICnm/5SMW7LUH/kGnqVPmFUL
 WzWqGOjfqXBlMuRryVLrMq4x+zAcb66sMDcSbb3Vs=
X-Gm-Gg: ASbGncvBEFIB0bRy6UnY8VjvxRKBORutn3YfL6UujvQ/pGmlGebzQJXmkapA3fL+Yko
 Tkeli6wvt4o88lsc2TavEjWJtkeJigaYYOO+j2Ld+2iJgRrCmXQNVsbmKscGklJT3H0NMJGy/AO
 wp5/2zn3mGx2IVl+kDVpe9HuJtII7BUkCZYRvz5X9VBqvmUvcv7ibJsPfLpJBTkMYVqk4s0dOuR
 ou800qHwiwA4fdhernLxwem4TMqzkyakLSBkAVi2vCR4Z91Zwm3x/xRWttoag0vNQq5YFw=
X-Received: by 2002:a05:6000:240b:b0:42b:30f9:7998 with SMTP id
 ffacd0b85a97d-42cc1d2d443mr45556072f8f.27.1764691754610; 
 Tue, 02 Dec 2025 08:09:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdOIQng7RzPiaZQ4MSfuiHHsJ7dbiOBLlKWNLin7yq5Rou7RFpz2b+H2UrIdUmytyFqePjzJYLGGVviWXd4yo=
X-Received: by 2002:a05:6000:240b:b0:42b:30f9:7998 with SMTP id
 ffacd0b85a97d-42cc1d2d443mr45556036f8f.27.1764691754274; Tue, 02 Dec 2025
 08:09:14 -0800 (PST)
MIME-Version: 1.0
References: <20251128101555.227630-1-pbonzini@redhat.com>
 <aS8N4_LDyW1DrF_x@redhat.com>
In-Reply-To: <aS8N4_LDyW1DrF_x@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 2 Dec 2025 17:09:04 +0100
X-Gm-Features: AWmQ_bmyP4mCQNs8E6rGs8Ccm9XwyqKufW_PSnVBamG0jVUq0-NI6wJuvrbFcGY
Message-ID: <CABgObfYb6-7QGObFBWWdQBzMtLhmuFNkidq4JYe2wgmiS81zjw@mail.gmail.com>
Subject: Re: [PATCH] block: split qemu/aio.h out of block/aio.h
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000026e8f10644fa5195"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--00000000000026e8f10644fa5195
Content-Type: text/plain; charset="UTF-8"

Il mar 2 dic 2025, 17:03 Kevin Wolf <kwolf@redhat.com> ha scritto:

> Is it really worth keeping a separate tiny include file for BlockAIOCB?
> Maybe let's have a patch to move it and its three functions to
> block-common.h, and then just move this file unchanged into the place
> where it should always have been.
>

Ok, sure! I did it this way just because it avoided the full-tree change to
rename the include file, but I will reorganize it as a content
reorganization + rename instead.

Paolo


> Kevin
>
>

--00000000000026e8f10644fa5195
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 2 dic 2025, 17:03 Kevin W=
olf &lt;<a href=3D"mailto:kwolf@redhat.com">kwolf@redhat.com</a>&gt; ha scr=
itto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Is it real=
ly worth keeping a separate tiny include file for BlockAIOCB?<br>
Maybe let&#39;s have a patch to move it and its three functions to<br>
block-common.h, and then just move this file unchanged into the place<br>
where it should always have been.<br></blockquote></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Ok, sure! I did it this way just because i=
t avoided the full-tree change to rename the include file, but I will reorg=
anize it as a content reorganization + rename instead.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div =
dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<br>
Kevin<br>
<br>
</blockquote></div></div></div>

--00000000000026e8f10644fa5195--


