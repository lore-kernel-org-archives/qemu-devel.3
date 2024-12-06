Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EBDE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 14:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJZKP-0004aq-9r; Fri, 06 Dec 2024 09:29:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJZKL-0004ZZ-64
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:29:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJZKJ-00037e-PW
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:29:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733495341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WuBfDqRzTmalrjhIj0wnHu8EZWo3fAKR972eaIibV+c=;
 b=hPxxJs34EmnVBuSW5fxmuIIg2lJmUgNRrUpdMxi+8IW9hsfgX5XL3IONNKVlj5F89E16hh
 d9HDeycMgbSB6lgUYR8aVIZGrX9JnIX90xXdQO94V0zagzxY4k0OzH99d6ja1Bd5hZ2ZgE
 Y1NW9tzfyf6vRONvIGMY5uMmsKzYdxk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-dl1ctMHJNMuRqDJWSk-wbg-1; Fri, 06 Dec 2024 09:28:57 -0500
X-MC-Unique: dl1ctMHJNMuRqDJWSk-wbg-1
X-Mimecast-MFC-AGG-ID: dl1ctMHJNMuRqDJWSk-wbg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3860bc1d4f1so1257041f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 06:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733495336; x=1734100136;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WuBfDqRzTmalrjhIj0wnHu8EZWo3fAKR972eaIibV+c=;
 b=CcI/5LJkDCj7RBS7ivTadnGZT+EfIciKKz15f10j4LtOvHZFpU+XGxCtO6RsWpKR77
 63p6B/8s3w3aUrbLPJoF4S3EWJdAkhtlQLPcEIjYeukTUZgIvwdw35EMV/h3OTSzmQTr
 i0scS7EmoBLf9rCNe4AoolrXQQmGvg+D1kOt1lkPRirGwQowgz0UZ9sIkCJUoG5rDuGj
 kztpskc5rX1b8wJBwPAPxHflY6FbadFxUNKDS+R31bNu5Hh79p7BxhKJlBNPejqDoNi0
 DRMQ1VKHtdh8SH5fcj/VmyuAesso2ZrI3oOYufhKjY+5GJsgZ0hck4hM1O9q1A2hXEHF
 M8ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeZZ/nyrQgbgiwEj/k3b79+pDCIR8/9V1PVlj9YcsqpDdhF9fnVQZhTVwYww7vnm2i+hLfoxwDFNK2@nongnu.org
X-Gm-Message-State: AOJu0Yw3pUMzl1452N8tYTo0/FIF5Yhbap0D5YJT4decs/SiD/ex7DfZ
 f9/4cNG6CELKNnjY04Lff313L3/Ruzb735rMMSvpAMElPTFAEIpPLUAQcvKW23XC8NK8+4wCcfJ
 2RaKKZaQEc0aipXXiRHGxYZxO+PDs8c+pPJ2bPOOMQLcd5ygr3L9noVwzg20xqYNtDpq+Bk1sfE
 4zaPnRlbXEVZYc2rPm6HzCZtX/AYE=
X-Gm-Gg: ASbGnctwA5u7SKOSkNKU1mtr5wrpWahckFD2msgHxxVXBawg+fJckyVqkFM4x46Omlk
 cXuvv6MIrxhIYyzGGmCcWJHDHvplIHPPN
X-Received: by 2002:a5d:47ae:0:b0:386:32ca:aa12 with SMTP id
 ffacd0b85a97d-38632caaac5mr74224f8f.49.1733495335900; 
 Fri, 06 Dec 2024 06:28:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnW02DorhxxRcOrG+5XQz6s+euuI8xPo0tyMTc1FMir6vnGk1H8t8qwKvhgYc0yulTDUc+ScX1aTmb+9n4Qmo=
X-Received: by 2002:a5d:47ae:0:b0:386:32ca:aa12 with SMTP id
 ffacd0b85a97d-38632caaac5mr74210f8f.49.1733495335628; Fri, 06 Dec 2024
 06:28:55 -0800 (PST)
MIME-Version: 1.0
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-7-zhao1.liu@intel.com>
 <b34733f3-1525-4e35-8c07-f84ad56b01e0@linaro.org>
 <1f008c2a-aaf6-497d-becd-f36f5d9aea17@redhat.com>
 <CAFEAcA9SCfMcrhpd_x0LmgwtD-5XwT4TY+QXBJMOjWbdtBPCUg@mail.gmail.com>
In-Reply-To: <CAFEAcA9SCfMcrhpd_x0LmgwtD-5XwT4TY+QXBJMOjWbdtBPCUg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 6 Dec 2024 09:28:44 -0500
Message-ID: <CABgObfZSR2s5AYEAcJfsdF0jKQGf_AVcDafKQq47qzLmBuX0RQ@mail.gmail.com>
Subject: Re: [RFC 06/13] rust: add bindings for memattrs
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000b3465806289ad5f3"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000b3465806289ad5f3
Content-Type: text/plain; charset="UTF-8"

Il ven 6 dic 2024, 05:59 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> > is still decently packed and simplifies things a lot.
>
> The old struct is 4 bytes, and the new one is 8 bytes.


Yes, hence "decently" packed. But I think in both cases it's passed in
registers, and for 64-bit machine that shouldn't change anything.

Paolo

We do
> a lot of directly passing 'struct MemTxAttrs' arguments around
> as arguments to functions (i.e. not passing pointers to them),
> so increasing it in size is not completely free.
>
> thanks
> -- PMM
>
>

--000000000000b3465806289ad5f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 6 dic 2024, 05:59 Peter Maydell &lt;<a href=3D"=
mailto:peter.maydell@linaro.org" target=3D"_blank" rel=3D"noreferrer">peter=
.maydell@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">&gt; is still decently packed and simplifies things=
 a lot.<br>
<br>
The old struct is 4 bytes, and the new one is 8 bytes.</blockquote></div></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes, hence &quot;decently=
&quot; packed. But I think in both cases it&#39;s passed in registers, and =
for 64-bit machine that shouldn&#39;t change anything.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div =
dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">We do<br>
a lot of directly passing &#39;struct MemTxAttrs&#39; arguments around<br>
as arguments to functions (i.e. not passing pointers to them),<br>
so increasing it in size is not completely free.<br>
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--000000000000b3465806289ad5f3--


