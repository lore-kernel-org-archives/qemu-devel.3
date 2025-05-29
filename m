Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCF1C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 08:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKZ3u-0004GQ-AJ; Thu, 29 May 2025 04:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKZ3n-0004FJ-Cd
 for qemu-devel@nongnu.org; Thu, 29 May 2025 04:56:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKZ3l-0007Cv-NX
 for qemu-devel@nongnu.org; Thu, 29 May 2025 04:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748508979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BNNeFqUlcByu+PWkrGlLojjnEQaxP9V/jLSabAJZVkc=;
 b=L+gsKy42hlT2P41fs1AWj4k/VyCwMKkcI8j85U5v5NAk3sybSLMqhJIskJSrCkxCTwB/so
 0BJY//b08su+BrAYwfH6eYkOYT3InRDXnfFVpovvcNtTFwkGpv4X/OW/944MWThMpZVjDP
 nke1CvyFO+QX6mU4Y3Xpq5S0zvHjaZk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-Qa9OqHBsMxmZ76rau8H6Cw-1; Thu, 29 May 2025 04:56:17 -0400
X-MC-Unique: Qa9OqHBsMxmZ76rau8H6Cw-1
X-Mimecast-MFC-AGG-ID: Qa9OqHBsMxmZ76rau8H6Cw_1748508977
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a364394fa8so231604f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 01:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748508976; x=1749113776;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BNNeFqUlcByu+PWkrGlLojjnEQaxP9V/jLSabAJZVkc=;
 b=GJOw+1I+4VS0Elqi5eFlcmO2RwFuujt5IpAPwsonNvsXmeflNq31EvQexDFhtGhtxD
 hgbQZYR4pGeKYuaAb9h/8wwe6lsrjhmVVl+pQkLa9mnxwvrag868Aivhf2gphefBfa5H
 7lIPMDRpE6D94v1kpU5QJyENZfoCH4+ajjIo1+vNZQoElgWiw9IO3EmTiB6vXrm+sPn8
 iNRO45wD5869zDBCOe/V7HQVX+5hPKdvgwRb66WIUmBv2sAxaRu6Urlv3mYviMO3yyVp
 pCPkjFGB+FtFTAizUdscsnJvSC4ie3/dFwVJZlrCj3EG+K3Hx/dzgU/9PDdllBTjWBkw
 V1DA==
X-Gm-Message-State: AOJu0YwfXYLXoE5psbkNtDxsJ17cs/LR0Wqt/qC5PG6Jd6iqZqblKVfF
 a4DHtfE97r0foaoKH9kv9UannLX69I/FlJaaBJ/PFUsorICVAPYciG5JymuMALuOQ9GFGe6mBtB
 rPRGNg7fXOXhBzaJttY9UpxWwAaW0pFbnfXKqShaSgBVpos/+SNjepNAlhAdlEq1vpQkoWYXZZl
 EhBiWp12rdPfItCa81FndNaw60U1b5qu+IH6hgaAemEg==
X-Gm-Gg: ASbGncsVR2FtCX8iJxAQpXEafrDUz453T4zLjif3HZ/8b9ZxNv/8q+L+MwQABCJv1BT
 D1F1/dZKf6KI1/wWBta4PTIn8zjXZTO/3V+79E6JpSOyp/UdJFtUrJ8PM0PcRIzNZQ/dL
X-Received: by 2002:a05:6000:290c:b0:3a3:5833:c900 with SMTP id
 ffacd0b85a97d-3a4cb461464mr15322450f8f.8.1748508976215; 
 Thu, 29 May 2025 01:56:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxNc39dZZW+GHRjljY+le8r2EQsQQW/cHk3ceeZuz6e70JSUJXIoJZdVLrxfvnifZKrN8FV+qTnU0INMUYFHc=
X-Received: by 2002:a05:6000:290c:b0:3a3:5833:c900 with SMTP id
 ffacd0b85a97d-3a4cb461464mr15322438f8f.8.1748508975878; Thu, 29 May 2025
 01:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250526142254.1061009-1-pbonzini@redhat.com>
 <20250526142455.1061519-11-pbonzini@redhat.com>
 <aDglrxH6o6spPC2v@intel.com>
In-Reply-To: <aDglrxH6o6spPC2v@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 29 May 2025 10:56:00 +0200
X-Gm-Features: AX0GCFsHkGLWb93F_i-jHjE3WhpQk7dLboBtx7h4u07UTrQUn3cB0VAdebO_cKk
Message-ID: <CABgObfbsM=-P4pS+oE+XkAfW28fP2Uq+oTYE5qMgKWRq8Qvttw@mail.gmail.com>
Subject: Re: [PATCH 11/12] rust/hpet: return errors from realize if properties
 are incorrect
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, May 29, 2025 at 10:54=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wro=
te:
> >          if self.int_route_cap =3D=3D 0 {
> > -            // TODO: Add error binding: warn_report()
> > -            println!("Hpet's hpet-intcap property not initialized");
> > +            Err("hpet.hpet-intcap property not initialized")?;
> >          }
>
> Though here we don't need print warning...do we still need to provide
> the warn_report() binding? Or println!() is enough in Rust side?

I think it will be enough to have Error ** and
LOG_GUEST_ERROR/LOG_UNIMP... but we'll see.

Paolo


