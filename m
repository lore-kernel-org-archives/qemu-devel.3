Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A606DC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 10:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3BVi-0002eb-6l; Fri, 11 Apr 2025 06:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u3BVV-0002YR-6N
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:21:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u3BVN-0005OG-ET
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744366851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=opVVaSGkm+v7J0L+i2NLNRTPU8jBN6OrZqKj37UOzRo=;
 b=gLYpyKcK2ZDx1I6DKuxikgEdvU/WEvIWgdDKtIz14bX7bYHGQRIXrbTNsp6btILYmLXIbX
 rCGTfM836AbwjQ8xp2iL6Ov/cdvqox4zVGv63vxIzbg8gWiz/irLcxqHLXae2yTMMAExv0
 QeFLMf9++S6GpAta9sLOXaSDnitZGLE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-3va141w2OY2_q4R8uvrIYw-1; Fri, 11 Apr 2025 06:20:50 -0400
X-MC-Unique: 3va141w2OY2_q4R8uvrIYw-1
X-Mimecast-MFC-AGG-ID: 3va141w2OY2_q4R8uvrIYw_1744366849
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3912fe32a30so782920f8f.1
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 03:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744366849; x=1744971649;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=opVVaSGkm+v7J0L+i2NLNRTPU8jBN6OrZqKj37UOzRo=;
 b=a/nw2mWvplYEB5/gZK7JCJPVOEBtBvIqMnNY+aE4y8CoQsodS31SznNr8oBdLYjhfy
 T3xIVrQGuPBJqAaTj64QK/G9cchfljNhvHH27sx4vWsW3/Gf9AxbxO/LBrlO6H6C9cuN
 Bzwx7nXocJEQtQ7Vwqv7dw/ib8jy1Aiv447MqilLRVZa0Jv5sOI4Gk5YmA9TKOPK6Yt0
 MjrkIvH6rw56Ug3SY2ibOqTA7ewyAkNqrm8NB1jfWcNkyumfAKmfJ8H/9X/ROvAzfwBY
 BpYyjhAC4tDBJHvOVG8oFXrOLaQQM1Mc2FOBej1psiBEGlZg6uXzbMPBzHNP0KtfwPda
 OCJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJON/LYTHMn8v0ohnVn6fgOa7mqXiYqkD8zJm1buFkXS6kS6mBOySUYcb7JEOhqr3Qs1zglJWinpof@nongnu.org
X-Gm-Message-State: AOJu0Yx+9y3SvoP8Pq+QygcTEfZ0ChQMkrayEGNfyOFFpyV5hCTJlbez
 exi/+dFzNl+ZGplphsDVcKJs7dNoyGdHVMMHYC1ZkgHmuGet2BcM91Vy+HcMP+p3uu1VjbJqBVH
 HiR2slqX3jYdzwxrgamGPqWRXA5HMqYpbqdvHaodYrGH4gsyjhTFqDICaOjuP7F/5DrF5wk3WJE
 FcMcRounpb/ViBD3iQ9WbI4Ivj09Q=
X-Gm-Gg: ASbGncvJSTR+hlnSpgPOdTvFhMQfR9foMc9nBHkCJvfjtV489ba1/l4RCEdg58JeP6T
 HIh5k2t4wl5pbFXIwGtxsKlkwAIoO7BND76hiQoYP1Z7EFnu37gJcDJBs5Lc8wb1Ah939aNE=
X-Received: by 2002:a5d:648a:0:b0:399:737f:4de3 with SMTP id
 ffacd0b85a97d-39ea521f9f5mr1558765f8f.29.1744366849129; 
 Fri, 11 Apr 2025 03:20:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKf6v7/YUjj6H+zE31+d4Bgpyg2EV4H0QfV3OvylyN8w+4ryM3GuN6Pxz+rP7171mpanTm1tqgG06kmMTGvok=
X-Received: by 2002:a5d:648a:0:b0:399:737f:4de3 with SMTP id
 ffacd0b85a97d-39ea521f9f5mr1558749f8f.29.1744366848792; Fri, 11 Apr 2025
 03:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250407155949.44736-1-kwolf@redhat.com>
 <bf72ef35-289c-4ec7-962b-414e3487c176@redhat.com>
 <CABgObfaJw1VSE6pbs2o1oTTGi6nXLtFQG90RG3J9DY1sukZpMA@mail.gmail.com>
 <Z_jsWQElOJyblb91@redhat.com>
In-Reply-To: <Z_jsWQElOJyblb91@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 11 Apr 2025 12:20:36 +0200
X-Gm-Features: ATxdqUHh1AZv40sVVg_vtMblYw7OiK4kHMhUCyGpG8efABL6Iw94QReE4ghIvjI
Message-ID: <CABgObfa7Vp949NA-7Yu6QK8phKy2GwNSZ=ncWebYr=Gz6xP3Dw@mail.gmail.com>
Subject: Re: [PATCH for-10.0] scsi-disk: Apply error policy for host_status
 errors again
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, stefanha@redhat.com, 
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
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

On Fri, Apr 11, 2025 at 12:18=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrot=
e:
> > Okay, going down the scsi_sense_from_errno() path is more or less
> > harmless because status and sense end up unused; even though ENODEV is
> > not something that the function handles, that can be added as a
> > cleanup in 10.1.
>
> Yes, it could be handled more explicitly. I considered adding a special
> if branch in scsi_handle_rw_error() for host_status !=3D -1 before
> checking ret < 0, but didn't do it in the end because the existing code
> already handles it fine. If you prefer it to be there for readability, I
> can send a cleanup patch.

Don't worry, I tried when I thought it was a bug but came to the same
conclusion.  I have sent a patch to handle ENODEV, which makes the
code a bit less mysterious, but that's it.

Paolo


