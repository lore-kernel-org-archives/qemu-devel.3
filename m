Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959DDCA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBV1u-0005mZ-6q; Tue, 29 Sep 2026 06:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xBV1o-0005kF-HL
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xBV1i-0002kU-RW
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790677530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S/kyQYhOEHeu1aSD+xDtqt/f1uicziJs7lEAd4H9H2k=;
 b=VL+SsyYa77dFf0YNsgUZ3PnPhiJoRkwF0/Tj7qGMXfGIYOo76mTNK86hlkqaFEVBhPtoQa
 6iA3TTCks/kK/jhOXc1Z7+TjHZaPprtxn+a74zbF1QlkgqnnHTURBhr/iDDvrBAK2RF7a6
 HCurGwxCfCnIptLhSegNZ1Slb4PgDLw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-E9rkl8unOIOCKlEPZHcYzg-1; Tue, 29 Sep 2026 06:25:27 -0400
X-MC-Unique: E9rkl8unOIOCKlEPZHcYzg-1
X-Mimecast-MFC-AGG-ID: E9rkl8unOIOCKlEPZHcYzg_1790677526
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49ffde4293cso19680645e9.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790677526; x=1791282326; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S/kyQYhOEHeu1aSD+xDtqt/f1uicziJs7lEAd4H9H2k=;
 b=pEcSnYGjHuZpTXrOGY1LOrtO3H2NnXNXSP94dWYT5KE5Iaq2KSdG+rZYGZUQpEH2MU
 YpP0ilIIGyDjzZ4ET8RrFA+ydEnx7+r/VFqwVn2rC0/l0Ds2V1QbesmHt4XhazSDHHdp
 XtVpg/1hpOjMR944N2ptaB5vewClcuj18jrO+AX68lDXa7LJhXGJ1DxyDaXSzjvnMEcW
 w2RN+9kl0FsE0AGodqKOnPQpD4D1DFvDvf58wD0mWqGICWk89DtfRydtIACuOVG2CZNy
 7znzN5WrfiqKf6MVr5H3vKVCs8j6O4SKi/OIyR8jau6Db4DwqtJKseTgojGvKRotEyWk
 rt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790677526; x=1791282326;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S/kyQYhOEHeu1aSD+xDtqt/f1uicziJs7lEAd4H9H2k=;
 b=g5TAV8Fy8ZtAQCqkRSFlQZ7Z0vDKlhHRvhs+caK5nvkPfl8ViUGROcdHHlbNwpau4d
 +ekfPTBRT2hR81ecVTiXNwxe8Eo3R69g+clPKahhv13La1G1bcfzTcEU3S1lRuSHldbJ
 rPoyjW+E7a2iw5yRXJAPFn0W9oTsvund8BOajXtohzM3/ZMYmIDX9/HTecuOGeFfrr/m
 /vrb5YOrfIX923QMLwd8z6P8GGJEaoL/Q4vLADYzFhhJF9nF/Qj7cDTB/nfDfSYTLb2c
 jnBeGyoRerfMHHU5tdSQZup9Dae/H9z5+qjMSosxIGS8Ivzs1wyWXTPaTtS0i9ywgUjg
 EzPA==
X-Gm-Message-State: AFuF++lLqMjTK6HalCRdtj7k/Hrt6lG0psytEbgbdxR1R4TXaBWuPElq
 3/o2YVtfGoT0/SyMvNreOdljYtdsfKoCicaCSHfNWYMna2k2WiDNjwoB6h1pvdzr6m/QUaaSUcC
 oTc45QOP9DAGZk48sKAXTxlfhgj3TtjHKRNzbRBVthsqf8zQcRNwv5YCv
X-Gm-Gg: AYBFou3SR3DByVrSqKU1vwoKLRy0xHoD1AZZ/kFX7bW0nOEhwzykkb2193QxBPNi96/
 LddrmmfOc5jCGbykUjGgCtNiD0KpNWT8nwfeur8CZ9rCZunZZRQPgNPBHnJk0K1g/6esMZyw88X
 zLNMJ/Wmijs0bUJluNr45A3mzIB1CVQzFbj8r+xZ+AvNXgD9aTc3WOa+yDA5AEKA5HH//Fed3Jr
 VaSW8cD5w+lkRiuYUCYgMhn1HcQ+V58FK7+Psxlf4nPCbl3z4LPhbkx2FNwYAGQhO9Od8I+NtRi
 zwygu/30WnmLeqf1F7Dp05+lr6bq6AmhC+9PmJp51P4a2uEZ1PMUOdylxU2yD4dIDAFCmPG38Zw
 qgcZFoOf7kZ5LfuZW/TkvRLusGgL6kfGqR1A=
X-Received: by 2002:a05:600c:c173:b0:49c:fa20:cbfd with SMTP id
 5b1f17b1804b1-49fe66eb262mr269223175e9.20.1790677525644; 
 Tue, 29 Sep 2026 03:25:25 -0700 (PDT)
X-Received: by 2002:a05:600c:c173:b0:49c:fa20:cbfd with SMTP id
 5b1f17b1804b1-49fe66eb262mr269222765e9.20.1790677525186; 
 Tue, 29 Sep 2026 03:25:25 -0700 (PDT)
Received: from leonardi-redhat ([176.206.38.69])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cf9b150sm63089825e9.7.2026.09.29.03.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:25:24 -0700 (PDT)
Date: Tue, 29 Sep 2026 12:25:21 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Tommaso Califano <tcalifan@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nguyen Dinh Phi <phind.uet@gmail.com>
Subject: Re: [PATCH] hw/usb: Fix guest-triggerable assert crash via short
 CMD_SEND_OBJECT
Message-ID: <aruPGUjhIP6IBqTo@leonardi-redhat>
References: <20260917150503.143821-1-tcalifan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260917150503.143821-1-tcalifan@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ciao Tommaso,

On Thu, Sep 17, 2026 at 05:05:03PM +0200, Tommaso Califano wrote:
>QEMU's USB MTP device has a guest-triggerable assertion in
>usb_mtp_get_data() that fires when a guest declares a large object
>size in CMD_SEND_OBJECT_INFO but sends fewer bytes in the
>subsequent CMD_SEND_OBJECT. The assertion compares the declared
>size against the actual bytes received.
>
>If the guest sends CMD_SEND_OBJECT_INFO with size=1000 and then
>CMD_SEND_OBJECT with only 50 bytes (short, non-64-byte-aligned
>final USB packet) the assertion fire killing QEMU.
>
>To prevent that is sufficient to remove the assertion, becouse the case

/s/becouse/because

>is handled by usb_mtp_write_data() which return RES_INCOMPLETE_TRANSFER.
>

Fixes tag and CC qemu stable?

>Resolve: https://gitlab.com/qemu-project/qemu/-/work_items/3993

/s/Resolve/Resolves

>Signed-off-by: Tommaso Califano <tcalifan@redhat.com>
>---
> hw/usb/dev-mtp.c | 3 ---
> 1 file changed, 3 deletions(-)
>
>diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
>index 1d8cfd32dc..406793fc03 100644
>--- a/hw/usb/dev-mtp.c
>+++ b/hw/usb/dev-mtp.c
>@@ -1813,9 +1813,6 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
>         d->offset += dlen;
>         d->data_offset += dlen;
>         if ((p->iov.size % 64) || !p->iov.size) {
>-            assert((s->dataset.size == 0xFFFFFFFF) ||
>-                   (s->dataset.size == d->offset));
>-
>             if (d->length == MTP_WRITE_BUF_SZ) {
>                 d->write_status = WRITE_END;
>             } else {
>-- 
>2.55.0
>
>

That said, code LGTM, with the changes i suggested:

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

Thanks,
Luigi


