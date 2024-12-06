Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C60EE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 19:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJdoP-0001iz-9n; Fri, 06 Dec 2024 14:16:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJdoM-0001h5-Gd
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:16:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJdoK-0002H8-F6
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733512579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3SogGEmEGV+SDki1CYddHVpdupUogoduQ367v2cvXnI=;
 b=aM6HRfxZvibCO38JEdErB3sPqL7tjuALwKYd40x1W+PkFO7cmcy/wpm4qLAwBTqnLUfJMt
 faa07qIyLGuvSd9AiQCMo/cvRMIKW3bJA5ilpaYFMQur39sGYmR3Qf8xwkX9/3atbhQz/Z
 fIF0U4qAWxEhlwl8TpYCB/8NNuU2mvU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-xt2jm2WCNFq03lG0TQFAUQ-1; Fri, 06 Dec 2024 14:16:16 -0500
X-MC-Unique: xt2jm2WCNFq03lG0TQFAUQ-1
X-Mimecast-MFC-AGG-ID: xt2jm2WCNFq03lG0TQFAUQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385df115288so1078714f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 11:16:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512575; x=1734117375;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3SogGEmEGV+SDki1CYddHVpdupUogoduQ367v2cvXnI=;
 b=DRFnYy6WJfEaXzia4KisUFu4WOFdz0ndiu6rQETmQAyRR/qtLwRtA7Lty1TxnEWk6Q
 yLmHSlczAAqW9ZXoOZkwJssZ220TbNn+KpBkR8nDMmvq9FZZ3NhmEtEUgo1w34D414kH
 7C8Ac5v6+04ykr6N0mPRfHjO/I3/glI/ayYq5TiWKBsp0UOZINSmnyM3t8ibJINbMwY/
 PiuJp9s7X4661RFl9C9JTwxefjQIQJbtVm0wQMQ/vJGKiqLifS2b7KlBedC/tkygjl+g
 sDTwDSsxDOphcm+nshzuNpqzhnIkNByRElOIjRW9yNDV3VZl6FQIpgfn4GEWy2W0gd8P
 5PFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU18rkm9FmzyWUgaTkFHHU3JT2DemQOwCRNBTjaOdzI9y2IWc+aJhHH/aNcsj356rIvmgQ1VNNJUsBo@nongnu.org
X-Gm-Message-State: AOJu0YzlrBNyfacJWZ5/yJDrpxPIHAr1f6KUh7SmEn7STp4p0/kLK4gv
 xdnfBoufHj+eozbsLB40lv7Ut5wYMBVp3u/31YbhpYNshglqvz/jIB9nXlD+RvyEBuIyB1J/t41
 NH5HtVq0DdWw0gNNqXxeVP8WYDm7YACwEjTqt3I3IGpEOrzLAbsrUhKfwZNhGuSrPo0KIDouFJ+
 dFrHMVQdRylPZA3rPA+04PPg0v5f0=
X-Gm-Gg: ASbGncvY/pUAkBLQS/ZFT/+Hq8Vc861PdrVAGWfEhJEKOxzltjoNlFqT5/hz7e8L1tO
 V2nV0ZT5G3m+REWo5allOU6EYhqQDFA==
X-Received: by 2002:a05:6000:1ac9:b0:385:f16d:48aa with SMTP id
 ffacd0b85a97d-3862b35133fmr3092917f8f.15.1733512575200; 
 Fri, 06 Dec 2024 11:16:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6PX2iMJFmYZj1/YLDSInpjsz6MLlE/fIqOybirbKChbnAHqqMOwPIUwGk25Wnpw11qoAs6x8oe1cWk76WG0o=
X-Received: by 2002:a05:6000:1ac9:b0:385:f16d:48aa with SMTP id
 ffacd0b85a97d-3862b35133fmr3092904f8f.15.1733512574931; Fri, 06 Dec 2024
 11:16:14 -0800 (PST)
MIME-Version: 1.0
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-7-zhao1.liu@intel.com>
 <b34733f3-1525-4e35-8c07-f84ad56b01e0@linaro.org>
 <1f008c2a-aaf6-497d-becd-f36f5d9aea17@redhat.com>
 <CAFEAcA9SCfMcrhpd_x0LmgwtD-5XwT4TY+QXBJMOjWbdtBPCUg@mail.gmail.com>
 <CABgObfZSR2s5AYEAcJfsdF0jKQGf_AVcDafKQq47qzLmBuX0RQ@mail.gmail.com>
 <CAFEAcA_dVnpN2Vn+VAf1XZSAdj183wJhQZ3pVNtb=NHeMOF2Jg@mail.gmail.com>
In-Reply-To: <CAFEAcA_dVnpN2Vn+VAf1XZSAdj183wJhQZ3pVNtb=NHeMOF2Jg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 6 Dec 2024 14:13:57 -0500
Message-ID: <CABgObfaAdDtrLF4tWL17Lmw9UKiLRNVvuiDZsQxc-9Wd8W61Dw@mail.gmail.com>
Subject: Re: [RFC 06/13] rust: add bindings for memattrs
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003e272b06289ed93b"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000003e272b06289ed93b
Content-Type: text/plain; charset="UTF-8"

Il ven 6 dic 2024, 09:42 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> On Fri, 6 Dec 2024 at 14:28, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > Yes, hence "decently" packed. But I think in both cases it's passed in
> registers, and for 64-bit machine that shouldn't change anything.
>
> True. Though it does mean we go from "space to add new fields
> without making it overflow from one register to two" to
> "completely full and no space for expanding it".
>

I guess it's enough to make unspecified the only non-bitfield. Then you can
declare MEMTXATTRS_UNSPECIFIED as { unspecified: true, ..Zeroable::ZERO }
("start with Zeroable::ZERO and change unspecified to true"). For the rest
it is not important to make them available in a "const".

Paolo

-- PMM
>
>

--0000000000003e272b06289ed93b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 6 dic 2024, 09:42 Peter Maydell &lt;<a href=3D"=
mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; ha scritt=
o:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, 6 Dec=
 2024 at 14:28, Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" ta=
rget=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt; wrote:<br>&g=
t; Yes, hence &quot;decently&quot; packed. But I think in both cases it&#39=
;s passed in registers, and for 64-bit machine that shouldn&#39;t change an=
ything.<br>
<br>
True. Though it does mean we go from &quot;space to add new fields<br>
without making it overflow from one register to two&quot; to<br>
&quot;completely full and no space for expanding it&quot;.<br></blockquote>=
</div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I guess it&#39;s =
enough to make unspecified the only non-bitfield. Then you can declare MEMT=
XATTRS_UNSPECIFIED as { unspecified: true, ..Zeroable::ZERO } (&quot;start =
with Zeroable::ZERO and change unspecified to true&quot;). For the rest it =
is not important to make them available in a &quot;const&quot;.</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></=
div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
-- PMM<br>
<br>
</blockquote></div></div></div>

--0000000000003e272b06289ed93b--


