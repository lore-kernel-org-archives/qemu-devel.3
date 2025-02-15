Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B2DC021A0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 08:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjDRH-0002Cg-KY; Sat, 15 Feb 2025 03:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tjDRG-0002CW-Lc
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 03:22:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tjDRE-0002xV-JN
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 03:22:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739607729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=toyqc7tktzE1b2NwBepmBYC9Fc+/B8mATGi47Mt63XQ=;
 b=Us08cdap3GUVqwNXKG4JDzdGBa1STOYATcoVnJ8SuqGcdvHZftZGyOufQ7cheox7EyCd5u
 YRMUXNvnUho9lqx4y4b1UawRZjSr5zw6NHLGzSsh3vA9aULgwTWdc/6oHyPLCuvancBvTP
 CHAqfKrue+af30sIUdcAmDLpmQ7yPbk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-kx8Bzp8FMyS7q7CUsgNFdQ-1; Sat, 15 Feb 2025 03:22:07 -0500
X-MC-Unique: kx8Bzp8FMyS7q7CUsgNFdQ-1
X-Mimecast-MFC-AGG-ID: kx8Bzp8FMyS7q7CUsgNFdQ_1739607727
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5ded802b571so1899728a12.1
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 00:22:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739607726; x=1740212526;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=toyqc7tktzE1b2NwBepmBYC9Fc+/B8mATGi47Mt63XQ=;
 b=FQmfKaNdR4Z/XWkEY7LVxxafrtaPG9HlmYSVHNfl7L1on9wpppmOvdkhGV1OcUqQFw
 EXswxhc/B2asnOZ+vfUUEj8d97JhZFYTA1X/5/l82/1KabtJSYkg/H6RbcIzSJBJgKmj
 iyw+lGvYNNQ99HGmcgsAE8gZUWsXbTlqy1mrXH+cIFV7p5vwDGAhDCamz8hj0A/yZ5kH
 g6Dt5i63d7mJ7c7KvDSA2X46Q4qTrgfJ0Jm9qJiGnKYDZta+0hf7w82KO8weSG8Hjikw
 4zJUKYcgZ1p31ZI7KxQZAh/hy+yk7wE5e1zSjO6pwv1fjwT9e8HS9SQut/VrnACXn6PZ
 0tFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7akZ3ASFfOhDjyVtO6+r4C05zhpIZ3yoIs4E86An/jTABzmIjjmG1U/2OlwKszJr2vS8z+7AUgri1@nongnu.org
X-Gm-Message-State: AOJu0Yzzr+1RCICcQxJabmd4f60dQGi//0UTF82iGV4gL2HrZvCenU86
 vQg7C72xMWkBsvduDFjRkvW5tYT1AOjjaEu/6fJW7jjOQtGwhiNKw+M98w/PWrxDyTGsveKq3+n
 RHXbw7skj2IkWNBF7RLe1wKaPOafmDZT+hLhK/4pOc3mx+6tlsUKXDB+LX1oc+HH7GMqjM/rTTf
 EhZI9RWgfI06wjneGc0w+Y+TMzrIA=
X-Gm-Gg: ASbGncuCmP1Pd/nj2ywAOpI6flIJD93ngryyNpSpLW4V5czymUH12qcrpZRbtfvXNnk
 DL04728u1jjlj1mrgGmEI317eMtLiFCoAKqz/t+jUxYMWV7lwdUw+oYYNe1cLLTA=
X-Received: by 2002:a05:6402:50d2:b0:5d9:f9b8:e7fb with SMTP id
 4fb4d7f45d1cf-5e0361ccea1mr2177392a12.22.1739607726586; 
 Sat, 15 Feb 2025 00:22:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFkNeEFDwIyTPEMcv83zaxvCpRaU9hYusxO5nsLPbD4fiNg1Iy+mX1wTfHtj7yNNOXT25XCOVq2IDyCH2DcnU=
X-Received: by 2002:a05:6402:50d2:b0:5d9:f9b8:e7fb with SMTP id
 4fb4d7f45d1cf-5e0361ccea1mr2177372a12.22.1739607726304; Sat, 15 Feb 2025
 00:22:06 -0800 (PST)
MIME-Version: 1.0
References: <20250212164923.1971538-1-kshk@linux.ibm.com>
 <CAJaqyWeHB_+ATn3cvtVrpiFp4NjNLoKpPP1ijs4C7eyRL7gpKQ@mail.gmail.com>
 <CAPpAL=w-0kgngVYiep2+K_WEGnuv1T_mTFTUbz9JPmH93HHzBg@mail.gmail.com>
 <0ea941fd-e293-4307-a9ed-16e3055279e9@linux.ibm.com>
In-Reply-To: <0ea941fd-e293-4307-a9ed-16e3055279e9@linux.ibm.com>
From: Lei Yang <leiyang@redhat.com>
Date: Sat, 15 Feb 2025 16:21:29 +0800
X-Gm-Features: AWEUYZmV5FJn7kigtcdzrqRNQm7v1yNMzt04FoywGtDBmvtW5N231XwxEBsBKtE
Message-ID: <CAPpAL=zA8RHS44SgK9QHJiESKp4SLFty-HUTXff2SnbbN+4EKg@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa: Fix endian bugs in shadow virtqueue
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: mst@redhat.com, sgarzare@redhat.com, 
 Eugenio Perez Martin <eperezma@redhat.com>, mjrosato@linux.ibm.com,
 qemu-devel@nongnu.org, 
 Sahil <icegambit91@gmail.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Feb 14, 2025 at 9:02=E2=80=AFPM Konstantin Shkolnyy <kshk@linux.ibm=
.com> wrote:
>
> On 2/13/2025 20:24, Lei Yang wrote:
> > I tested this patch with vdpa's regression tests, everything works fine=
.
> >
> > Tested-by: Lei Yang <leiyang@redhat.com>
>
> Could you point me to those tests?

Sure, the test scenarios include ping, mq tests under netperf stress,
hotplug/unplug, reboot,shutdown, pxe_boot etc.
>


