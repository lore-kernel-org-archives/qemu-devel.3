Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAD1C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 13:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiD5x-0007vT-O8; Wed, 12 Feb 2025 08:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiD5w-0007vC-MH
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 08:48:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiD5u-00037f-7m
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 08:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739368081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9/puN7vrhMr6vemMc/OFxxdS8KpLR+4QfCf5x2OLsRg=;
 b=erI2fPj/qvtwO6wn5DQ1WGoCnMoiEmjjPjVk3x3DISyQpD0SvTLHJ+OOX4TIRJIYoxADpO
 oio3GurcSvb6v1uvy4fnQI+yPO6QnMqwjszcdpCsQYyglS8CjIovFOSSi4f9P8dixSlUsj
 D9WiRKZn5ValPjcTo+8fAj7PkuRr9j8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-TFQK4zl1Oy2JPA0-A3IaRw-1; Wed, 12 Feb 2025 08:48:00 -0500
X-MC-Unique: TFQK4zl1Oy2JPA0-A3IaRw-1
X-Mimecast-MFC-AGG-ID: TFQK4zl1Oy2JPA0-A3IaRw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38dfede57feso362929f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 05:47:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739368079; x=1739972879;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/puN7vrhMr6vemMc/OFxxdS8KpLR+4QfCf5x2OLsRg=;
 b=RtwCgkvpwrVmfb6MWcev1iFdvn5Dh55JMuOfRBUW+21xDm3oUAC15oocg4fcrgng8B
 JpY888utnuVNLhESJKz2u0Vx+NeHlvpH6KDrAmYluVUaVCWpSGu6y49Rl6DyuYXymGj8
 hwN1RpxJTXYAeAVNLvzFRe2A3t5EX+Ur6iSdfuoE2LOfM7KfE4hBu5gjxxA/Now0DqCB
 JDQukY1lpxKWiuRonfGyHFAeBPmNSiN7yHOhbs8fkSCH5KrLDYbE4xahorS8Lg4rnvlL
 6pPXS5U662KSM5mFwljaTrv97tEuMmQdvvy92/hCdGl0dU1ICK/ifQuaRtZhvjayi5E2
 bs0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJCCZz1jurrgFl0Iic021IZshjCb8WRkAzSeiCv/ksHK/pXbY3C7D/asBD3GRFEOsl9SGwVWSnp7a+@nongnu.org
X-Gm-Message-State: AOJu0YzRTFZ4kb1P2LbAWwVCBw0Znlspng+g5rwbvnq7XSNdNw5E90M4
 7rClsmQXf0A9xUbTfnamixEHakVwg2dzVcyVT22SmviNkUpXKMq8vQx+ar765Vzv9i2XZ1KBt4R
 stO8UpvsNTxHnKlv8JAf1xlYZdFvO8I3e3tsTb9d1gl3PwQPXRpWwoVy9lakqNrMac2f4YpMHlz
 2Bh6sRKT5ZKmWfQo+xh2fvWqgZR/8=
X-Gm-Gg: ASbGnct+CbQu4+4bbvv0gvCkLA3/eAkqb8WTUPFfnnxUQY2i1NbAC7gIhjIoWmYqrU4
 4JGth30cq2nU7mVh/p9g4G4yRx8lLQK9+3LiTxFUYTsuLtGl6p1cU0ATzZ5ln
X-Received: by 2002:a5d:47c3:0:b0:38d:de92:adab with SMTP id
 ffacd0b85a97d-38dea28c762mr2519668f8f.29.1739368078864; 
 Wed, 12 Feb 2025 05:47:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4CjbaWLQBFit+3pcBhLtMHDkckx5fSXOsWQbLyirQxcQWTaGKSGSPEleMLuaKaoJ1h6ek9PxFvum5IybmXeE=
X-Received: by 2002:a5d:47c3:0:b0:38d:de92:adab with SMTP id
 ffacd0b85a97d-38dea28c762mr2519654f8f.29.1739368078564; Wed, 12 Feb 2025
 05:47:58 -0800 (PST)
MIME-Version: 1.0
References: <20250211214328.640374-1-kwolf@redhat.com>
 <20250211214328.640374-4-kwolf@redhat.com>
 <b7b2ab97-acd3-4008-abd6-3da874541113@redhat.com>
 <Z6yecuOmtQKYUwLj@redhat.com>
In-Reply-To: <Z6yecuOmtQKYUwLj@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Feb 2025 14:47:46 +0100
X-Gm-Features: AWEUYZnyYP0TlHPxSEhYNXFBX1Fm88a5IJusHoC7KUH-CBYrBfe4ix0i9jBtfUg
Message-ID: <CABgObfb-MXHYY4eM5LUbiRdOqWFG_CEcM-Xkv+v_dNWMwThKHA@mail.gmail.com>
Subject: Re: [PATCH 03/11] rust: Add some block layer bindings
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, manos.pitsidianakis@linaro.org, 
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Feb 12, 2025 at 2:13=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote=
:
> Yes, we definitely need some proper bindings there. I'm already tired of
> writing things like this:
>
>     return -(bindings::EINVAL as std::os::raw::c_int)
>
> Or even:
>
>     return e
>         .raw_os_error()
>         .unwrap_or(-(bindings::EIO as std::os::raw::c_int))

This by the way seemed incorrect to me as it should be

     return -(e
         .raw_os_error()
         .unwrap_or(bindings::EIO as std::os::raw::c_int))

(leaving aside that raw_os_error does not work on Windows)... But then
I noticed that read_raw() also does not negate, which causes the error
to print incorrectly...

> Which actually already shows that your errno binding patch does the
> opposite direction of what I needed in this series.

... so my patch already helps a bit: you can still change

    if ret < 0 {
         Err(Error::from_raw_os_error(ret))
    } else {
         Ok(())
    }

to

   errno::into_io_result(ret)?;
   Ok(())

and avoid the positive/negative confusion.

Anyhow, I guess the first one wouldn't be much better:

   return errno::into_negative_errno(ErrorKind::InvalidInput);

whereas the second could be

   return errno::into_negative_errno(e);

But then the first is already a special case; it only happens where
your bindings are not trivial thanks to the introduction of the
Mapping type.

Paolo

> My problem is when I
> need to return an int to C, and I either have an io::Result or I just
> want to directly return an errno value. So we'll have to add that part
> to your errno module, too.


