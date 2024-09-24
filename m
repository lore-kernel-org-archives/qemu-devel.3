Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6194ECF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 15:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st7lp-0005XL-Sz; Tue, 24 Sep 2024 11:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ndevos@redhat.com>) id 1st7ln-0005WM-3X
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 11:48:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ndevos@redhat.com>) id 1st7ll-0006Xh-54
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 11:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727192881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ogk/caFI0jhiKY134bOmL9tVHNYOUyM1FeeX6GS9OiI=;
 b=SpHlQn3/1iHS4As7oC5gzfV0qBHpmzwL6XRmKZ9xzex6c51ZKS/neWoijKN3Gxxy8Bhwq+
 h2S+ncsO44shCXJ0m8S4A0hoIuyeuqX8cG2VfNS3GqxDIDL4T2LIXRG7AcPVM313IfwKdY
 x9R+IFCJwX7QXMFBysS7IRruVXLUbv0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-eojABHAoP0Oeu9OuWERNTw-1; Tue, 24 Sep 2024 11:46:35 -0400
X-MC-Unique: eojABHAoP0Oeu9OuWERNTw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a8d13a9cc2cso418437466b.3
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 08:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727192794; x=1727797594;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ogk/caFI0jhiKY134bOmL9tVHNYOUyM1FeeX6GS9OiI=;
 b=By5gKEUdkQM7GXlZ5JNdH2uhAUOXVaLdpuu2FcK75wJFnhcCb4Wr0twvsPcoXcbjNh
 Nm4hlx4N/NxQLKXYqp2pvZXNfTtPjv9UjGOJgYOy/WlY/Y4VdsDko25Pw8pT2v0BdtTx
 BiqCWBgJ7ScJdXcXmOG0li/p90wpsHIZV+ytINZQ097teGUOfNRxu3aF9oIZsCmw/C0A
 zOEi3TU7kf/KorQESkNspUDiAGo6i/0iDcuRKRc7N77nFmVIaXLpV4/QwTbuAUMMxMsY
 F3vXXSFHUa/0e/j2C2geLuhwIEXoxky9DaIkgJUyrK6hC0uOhiNiqmFpjfIyQo2CjlBY
 jRIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjzmNvv+c3oXVJzeTnC7AGjkW0BG/rrm/ZULC//c7vdHvBqJ9+wmIjB/fFesJg9UzN2e3CsVLSLvcI@nongnu.org
X-Gm-Message-State: AOJu0YxuMXK5fLd26svLFhpEQ9rJjBl1EuUqoGpzNwUdp7KkGVgBPkLm
 mzAOboMRNeADUy7sBdB2pBVCp6AiJloTlrXrRXBsYI9geLz1bJk4+mI27CbWyxyNM+R58mfRBDV
 qyrGy1A3n6SItPgMhfgg42OKGtwp9jMKMjNGEDoVoANWsxC//cx6v
X-Received: by 2002:a17:907:e269:b0:a8f:f799:e7db with SMTP id
 a640c23a62f3a-a90d4ffd95bmr1346592466b.16.1727192794472; 
 Tue, 24 Sep 2024 08:46:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs+8AJtbZXcqFr8tBR2Zl6/pvBYsdkQLaW5POD0Aa9JMfm8QeWlSnnG1mZbz43kLhsjMr8rw==
X-Received: by 2002:a17:907:e269:b0:a8f:f799:e7db with SMTP id
 a640c23a62f3a-a90d4ffd95bmr1346590266b.16.1727192794027; 
 Tue, 24 Sep 2024 08:46:34 -0700 (PDT)
Received: from li-88bb8a88-b016-11ec-80f1-6c24081bc674.fritz.box
 ([2a10:3781:25b9:1:7b2b:2b2e:2a37:e1d2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9392f4fb87sm96704766b.56.2024.09.24.08.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 08:46:33 -0700 (PDT)
Message-ID: <6e6b125cec9f91261332964c8aef9947d9029843.camel@redhat.com>
Subject: Re: [PATCH] docs: Mark "gluster" support in QEMU as deprecated
From: Niels de Vos <ndevos@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org
Cc: integration@gluster.org, devel@lists.libvirt.org, Kaleb Keithley
 <kkeithle@redhat.com>
Date: Tue, 24 Sep 2024 17:46:32 +0200
In-Reply-To: <20240924132451.47121-1-thuth@redhat.com>
References: <20240924132451.47121-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ndevos@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 2024-09-24 at 15:24 +0200, Thomas Huth wrote:
> According to https://marc.info/?l=3Dfedora-devel-list&m=3D171934833215726
> the GlusterFS development effectively ended. Thus mark it as
> deprecated
> in QEMU, so we can remove it in a future release if the project does
> not gain momentum again.

As a former Gluster developer/maintainer, this makes sense to me. Feel
free to add my Acked-by or equivalent signoff.

Cheers,
Niels


>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
> =C2=A0docs/about/deprecated.rst | 9 +++++++++
> =C2=A01 file changed, 9 insertions(+)
>=20
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index ed31d4b0b2..b231aa3948 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -395,6 +395,15 @@ Specifying the iSCSI password in plain text on
> the command line using the
> =C2=A0used instead, to refer to a ``--object secret...`` instance that
> provides
> =C2=A0a password via a file, or encrypted.
> =C2=A0
> +``gluster`` backend (since 9.2)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +According to
> https://marc.info/?l=3Dfedora-devel-list&m=3D171934833215726
> +the GlusterFS development effectively ended. Unless the development
> +gains momentum again, the QEMU project might remove the gluster
> backend
> +in a future release.
> +
> +
> =C2=A0Character device options
> =C2=A0''''''''''''''''''''''''
> =C2=A0


