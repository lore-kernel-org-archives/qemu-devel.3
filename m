Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29649E65D3F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 09:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEQMR-0004aS-KK; Fri, 22 Nov 2024 04:53:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tEQMQ-0004a5-Ml
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 04:53:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tEQMP-0008Dk-6U
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 04:53:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732269236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jKbJg8lRLYNEG72KGkfM1G64spxRHB2oNQZpN0p9rfY=;
 b=MpI47kFu2PaFHO3vvyVz58Mb/OasaaDm/44a0AkdGuPX9+nl1NrPgDGuEjXettAfVmxKAX
 ZGV82tzqLFG+NJJzTgR0/OHpyB4H/CqRHJOigK7JAwTGQdeG0H7Het+2CVvanzd26Cd9qc
 OdmPQPhJfcWvP4Qtl9q/JiabTdBWGmU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-ftMX8PvAONCTs_mcd7-S3w-1; Fri, 22 Nov 2024 04:53:54 -0500
X-MC-Unique: ftMX8PvAONCTs_mcd7-S3w-1
X-Mimecast-MFC-AGG-ID: ftMX8PvAONCTs_mcd7-S3w
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4316ac69e6dso14528105e9.0
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 01:53:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732269233; x=1732874033;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jKbJg8lRLYNEG72KGkfM1G64spxRHB2oNQZpN0p9rfY=;
 b=qvh4yvcHQeBdz0HEShvd1cX8n1YT2HVdY+yX5HtrnzXbnSUXxz24cqnk9hYfNV4wFk
 qEISmVIoJz190/omkYBtJmpP1mGfZU6Mh3a8DX6Vx+soqPdkOaMUExP+zeRPaW1vog6O
 wYRVQ/in1yXOLLCeSnx1KxYCVBOiIpmL+fPbyhCh4LiiXk5pxSO09iXZp/Mbof8Nij0f
 ryt3VjIcEQwqcV+X1VXVW6nsbef10dWKIdk21Nz/KJu/3RFEVeKvvr59mOy/HGJLdLfv
 ejRizlPvN3usvCDpCRCHtJuOVcoL3ph+W7dXesjWlgJA/bTJdEVdUiiXgOqGDxsaxQLA
 lV2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlAJuJvKebUNJusmwv2v9Ar2lgI6YKfEPo5oz1qsXLHsSEJHc5UarVGnOeKMeI8eqvOZ9500sBEaas@nongnu.org
X-Gm-Message-State: AOJu0Yx2VJzm533iU3ShpqCK66kAeL0oW+mam03lUX9bHDhNc2wUYmeo
 kOHMY1IkjRyzYfgXGcUvYy4mzr4Ar3KNpu6uEw6rMG4oNnP8blQA9prp7OSa6aa+BO2QUqFYL3p
 bpZN/mXrkQV0F6op9qbxzO/+06IW6C+HnXTIoBYR8E7SQaLn9CY+gjZdlXOHNejl7/jgvukDDV/
 FiVzipnkhxg8aepB0PDRzFDQg0Ubo=
X-Gm-Gg: ASbGncvcQ5dFrWYZ82RH8RJiIhGSibD7GvD1EiDRYyUmhUn2c+gAf/g7tbFNDfCvkYh
 qfwS2WHnNCe8XDKjlVXPk9fvQcXUdNgGq
X-Received: by 2002:a05:600c:3ca9:b0:42c:b45d:4a7b with SMTP id
 5b1f17b1804b1-433ce4914e3mr15242045e9.25.1732269233015; 
 Fri, 22 Nov 2024 01:53:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAgZI7c5V1p0Njf5/rmiU1oI2i9xJrO+V6kfbsFZkOxkV7yXZeDhqOrL794xZSB9hdCl7ZWcBHOMdQD8eVDyw=
X-Received: by 2002:a05:600c:3ca9:b0:42c:b45d:4a7b with SMTP id
 5b1f17b1804b1-433ce4914e3mr15241875e9.25.1732269232718; Fri, 22 Nov 2024
 01:53:52 -0800 (PST)
MIME-Version: 1.0
References: <20241108070609.3653085-1-xiaoyao.li@intel.com>
 <5f8db586-cdda-4d00-be02-f9880a20e1a3@redhat.com>
 <1e210331-e458-4709-9506-b83abf89ebed@intel.com>
 <af349a3a-8a15-4263-9a93-180320daaca7@redhat.com>
 <db7f2f59-6cfe-4e90-ae63-1faeb870726b@intel.com>
 <3af19d21-2f18-4890-9a23-8e24a503cc33@redhat.com>
In-Reply-To: <3af19d21-2f18-4890-9a23-8e24a503cc33@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Nov 2024 10:53:40 +0100
Message-ID: <CABgObfYrQmjeB8NbQWK3qj8s2XxM4ymA72LPNCJ++MK=N=3cBw@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Initialize nr_cores and nr_threads early and
 related clearup
To: David Hildenbrand <david@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Brian Cain <bcain@quicinc.com>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, 
 Max Filippov <jcmvbkbc@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000045b53206277d5ca7"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--00000000000045b53206277d5ca7
Content-Type: text/plain; charset="UTF-8"

Il ven 22 nov 2024, 10:44 David Hildenbrand <david@redhat.com> ha scritto:

> > I think we can check if qdev_get_machine() gets a valid result. If not,
> > fall back to assign nr_cores and nr_threads to 1.
>
> That sounds reasonable to me.
>

Another possibility is to add a cpu_realize() function that sets two
properties and then calls qdev_realize(). It touches all architectures but
not in the sense of adding new code, just changing it. And it is more code
to write though, so if Xiaoyao prefers that I apply v1 I am okay with that.

Paolo


> Cheers,
>
> David / dhildenb
>
>

--00000000000045b53206277d5ca7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 22 nov 2024, 10:44 David Hildenbrand &lt;<a hre=
f=3D"mailto:david@redhat.com">david@redhat.com</a>&gt; ha scritto:</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
&gt; I think we can check if qdev_get_machine() gets a valid result. If not=
,<br>
&gt; fall back to assign nr_cores and nr_threads to 1.<br>
<br>
That sounds reasonable to me.<br></blockquote></div></div><div dir=3D"auto"=
><br></div><div dir=3D"auto">Another possibility is to add a cpu_realize() =
function that sets two properties and then calls qdev_realize(). It touches=
 all architectures but not in the sense of adding new code, just changing i=
t. And it is more code to write though, so if Xiaoyao prefers that I apply =
v1 I am okay with that.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmai=
l_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
Cheers,<br>
<br>
David / dhildenb<br>
<br>
</blockquote></div></div></div>

--00000000000045b53206277d5ca7--


