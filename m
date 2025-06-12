Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCDCC71143
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 07:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPcXY-00071H-RE; Thu, 12 Jun 2025 03:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPcXX-00070w-Bi
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 03:39:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPcXV-0006P9-TM
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 03:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749713996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jyfclqkv9g5I5cSR+ECGEHSp27JRi/Dx2MjH1UDDGhQ=;
 b=WWS5zd0ob1PCukDWXlFD6L6MqH0JcS3YF8XNXAIe/7uiZ6DjfffFgltXrs9S7eiM2dBW8J
 gXcnKNBjFw1jlhit4VgPkLM1V6ZM88K6cT3NPMRAQ11wiie3L3pIOOuyNnocUDNALcwhza
 bCS3JK9hU3o4EFa9MO4eDE8gWqa/4GA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-sPNW3AEsP1OT_s1uicZMWw-1; Thu, 12 Jun 2025 03:39:54 -0400
X-MC-Unique: sPNW3AEsP1OT_s1uicZMWw-1
X-Mimecast-MFC-AGG-ID: sPNW3AEsP1OT_s1uicZMWw_1749713993
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f6ff23ccso356277f8f.2
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 00:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749713993; x=1750318793;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jyfclqkv9g5I5cSR+ECGEHSp27JRi/Dx2MjH1UDDGhQ=;
 b=MXLl826eLQeTSj9dpAXuHd2bO2Pf2eUPoZqH3kPqqLZQAzcDVEeopHWnDaeD9Y5Enq
 Fj/Arq9I8Yd1/jmoY4lKfEmt/zfae8phvMrO2B9UvQgic/s9EyH+QbIIAk71BKxYzQZB
 bjzGo2P+kHdQrqbgIHHzqgI4+lya1TxMDmO0G2LFThkbWdXWQ5rGv9RccZC9ws8V0Src
 BDsrgF90mrY/K3UdRtdRghVNbX8xyicx+4HfMQPOcuqsreIyMWsL+/Rcby8KG0oFl8nr
 q10TpgnZ9Ad8T4W3uK43xgqX5LARc0vxznJ95N92JbMl7okxMEeYOxd+8vfWnqVlNVzm
 lqRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL6zTQ8334hE2yWRkRrl3P4e8/ptXTut/Ixhi54GYxaN6ydRtFPOleqhdL8n6K9jodukAVb0Qw4Crc@nongnu.org
X-Gm-Message-State: AOJu0YzYTyYGvfhkoYrahOQNdo7elLnynLnqbWSZz/UdE4Htq2PZKtui
 XXNEwAaIx2ng5pGX/GwUrVIQMNkH/xlr90FWpJpcupDGg8qBbAnNGv6MkkWAfEIWHdKE/p31Y4w
 Rnm5uUuxqA3U99+Zurd/vVsDp7ZrIwXwcg0Kg5dKqBi313kZMpTGTx0/cCTUZ+Nqb6GNlLDzzz8
 +F7OYKwIVnFvBNRxDExdV3XnVh0uDQrfw=
X-Gm-Gg: ASbGncv2mVeDylcwpkTr1zWUqjpeFfp1yQtWqBhO3+6QawAvgfbn1rzZNE/qKFDEU8C
 uTJmIUzv7+Iync1Tdto7/fUmmjq3CBRLojHEOIUm5DN7SjmSNc08qibsggpqyIOg8ICsnJUbCO1
 gNEA==
X-Received: by 2002:a5d:64e9:0:b0:3a4:f7af:db9c with SMTP id
 ffacd0b85a97d-3a558a43b5emr4944224f8f.59.1749713992767; 
 Thu, 12 Jun 2025 00:39:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2IVnGMJCnwsL7wsPIX3aIGjP6OxrKIOmkgg6ZR2+08XS10UasBnXgVNDDmescJyDhnaK13nwxXAPAQ2LqLJ4=
X-Received: by 2002:a5d:64e9:0:b0:3a4:f7af:db9c with SMTP id
 ffacd0b85a97d-3a558a43b5emr4944208f8f.59.1749713992446; Thu, 12 Jun 2025
 00:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250610202110.2243-1-shentey@gmail.com>
 <20250610202110.2243-2-shentey@gmail.com>
 <CAAjaMXbtcyB3J3AvGh8ZW3MSi41uMaE+TkZwipCs5pg6wvYJ=w@mail.gmail.com>
 <CABgObfYgoYBJmZjin_Wj8JeEviFMM+vFa_QX_8Np+1n9apq4kw@mail.gmail.com>
 <CAAjaMXZ5S7GUPmhwxsyuVmF4tvUh3vgjnK8OLKv-A+h7JCPqBA@mail.gmail.com>
 <9C43F9B8-6A5A-40EA-88B4-C5B8B17B9F5A@gmail.com>
In-Reply-To: <9C43F9B8-6A5A-40EA-88B4-C5B8B17B9F5A@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 12 Jun 2025 09:39:41 +0200
X-Gm-Features: AX0GCFu8W0jpAtL1sa6todOY1hM005Tk7scgUnuFa-eYsDT31POjL87RPcqTo3I
Message-ID: <CABgObfbJbAg=tJ5CzUntexKFnfQzBKteh2jK4pebQfWY86B-Yw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust/qemu-api: Add initial logging support based
 on C API
To: Bernhard Beschow <shentey@gmail.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000fa914b06375b08fc"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000fa914b06375b08fc
Content-Type: text/plain; charset="UTF-8"

Il gio 12 giu 2025, 09:37 Bernhard Beschow <shentey@gmail.com> ha scritto:

> So the idea is to have a log_mask_ln! macro instead, since there isn't
> really a point for a macro that doesn't add `\n` at the end. Correct?
>

Yes, or both.

Paolo

>

--000000000000fa914b06375b08fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 12 giu 2025, 09:37 Bernha=
rd Beschow &lt;<a href=3D"mailto:shentey@gmail.com">shentey@gmail.com</a>&g=
t; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">S=
o the idea is to have a log_mask_ln! macro instead, since there isn&#39;t r=
eally a point for a macro that doesn&#39;t add `\n` at the end. Correct?<br=
></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes=
, or both.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><d=
iv dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
</blockquote></div></div></div>

--000000000000fa914b06375b08fc--


