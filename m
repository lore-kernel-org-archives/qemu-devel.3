Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52007CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 12:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoiKe-00044u-CG; Wed, 20 Aug 2025 08:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1uoiKQ-00044K-Tz
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 08:54:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1uoiKO-0007NG-3N
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 08:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755694445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cLTqO0jVi8SAZMgEgWF4NEyyy35NF3FF/Za1/pXtl0g=;
 b=WaAQmty28ibSosQUtAJPtQEBRSDcJ+X+HhP72HRSP+SxTgerQ27uWL/tULGIzj19v6+E5K
 KliGGDTmwUHWeL3Qd12Kp6PLvhlJG3GFwDPZgUvt5/9sKwLDGy3hC1ATjxvuD9CyHEhVbY
 e5Z3IOnRu82NRSNB8leZM7K6WS2McXw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-t5ZtaUG_PGKBIl3DozxneA-1; Wed, 20 Aug 2025 08:54:04 -0400
X-MC-Unique: t5ZtaUG_PGKBIl3DozxneA-1
X-Mimecast-MFC-AGG-ID: t5ZtaUG_PGKBIl3DozxneA_1755694443
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-24457efb475so75212755ad.0
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 05:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755694443; x=1756299243;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cLTqO0jVi8SAZMgEgWF4NEyyy35NF3FF/Za1/pXtl0g=;
 b=G5C2UA72o174Yh0zEbD8d3Mg1ocWB1fnx+W3GX8lgZ3+ouF0rSf2vTHs+WefufRoJp
 yOj5duvPyHaJdlAj6OpJYUKKf6MaI4lUyOCCzTScNPfNBZDh83YWSsTr9tnWdkR6u+D8
 Ym6SHKta460amm8eWTzMkVnKquab2nK9w7DB3j4ILf31ybuEXwr2ZSJiZHLqCWEGlXZe
 13Hgwsz13WiLEZJJuRXZsoxNKExSxhSObxVSsPQJTJxp7eDlh1S2b+1EakId0dSpgn8z
 9e3Ur+rhxc+zMLp9MeZf72rv4cdUmNYKYKZjV4H6UaQ+gL+1zcRtDkhiHfLsenw84cIm
 S3cA==
X-Gm-Message-State: AOJu0Yxl/iqB9RuUhRiKMguK8KXEMdMQxeaLpVDdmpMft+hTS1Uar6Zj
 k81WsiqFAhBgjoquZFxKMNlg3Wf3S0PiJInasHr33hMC5Ulqv6ZT61YDg7eUxP54oTZNUGh4/cR
 H3lKe2j4gTYxszDVqWwlNiDgNKen23GKzCEArr+Qf28473Uzaov663AdDAcIKjoo2PAVhCs23qH
 1ExtrEtStQJttNTL8lu7KYWd0QO2bEt7u1iwvfJ3nPHg==
X-Gm-Gg: ASbGncvNee8lMCCjLM8QqKJlAKacAM2RHNhGkrml+9WipnNXRqOoKCMuCZvgWfDpqCd
 Od1bypYhIzgYvNevVHBhJWJ7vbeQzy/8xxfxs7GYXj0Jcvb5LiAgfFY11fdT+/lXS3bIJ79JolY
 u2QadkmBAcKltEwYAcmw==
X-Received: by 2002:a17:902:f788:b0:23f:ed09:f7b with SMTP id
 d9443c01a7336-245ef278bcbmr35039935ad.48.1755694442788; 
 Wed, 20 Aug 2025 05:54:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtoXJVVDlcZa0UuP7CSngPpqe0A6GMWkkb7q4zGTBE9fS9j3LDlD3yaf8cC9rZDl+2ncgrLQH1JDeUNvb9udY=
X-Received: by 2002:a17:902:f788:b0:23f:ed09:f7b with SMTP id
 d9443c01a7336-245ef278bcbmr35039715ad.48.1755694442433; Wed, 20 Aug 2025
 05:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250820124417.1391747-1-berrange@redhat.com>
In-Reply-To: <20250820124417.1391747-1-berrange@redhat.com>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Wed, 20 Aug 2025 14:53:51 +0200
X-Gm-Features: Ac12FXxqqhNk2hHZG2atNm_jCtAog-sYCISktYsVycPHadGSNqrmYG8PHG7TQKQ
Message-ID: <CAA8xKjV5VnrsmGWcQsYUxFOMLQwHcS_Jp0Lvhgo5bZ19zuD=HA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: list qemu-security@nongnu.org as security
 contact
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 20, 2025 at 2:44=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> The qemu-security@nongnu.org list is considered the authoritative
> contact for reporting QEMU security issues. Remove the Red Hat
> security team address in favour of QEMU's list, to ensure that
> upstream gets first contact. There is a representative of the
> Red Hat security team as a member of qemu-security@nongnu.org
> whom requests CVE assignments on behalf of QEMU when needed.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a07086ed76..3edfb25d5a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -85,7 +85,7 @@ Responsible Disclosure, Reporting Security Issues
>  -------------------------------------------------
>  W: https://wiki.qemu.org/SecurityProcess
>  M: Michael S. Tsirkin <mst@redhat.com>
> -L: secalert@redhat.com
> +L: qemu-security@nongnu.org
>
>  Trivial patches
>  ---------------
> --
> 2.50.1
>

Reviewed-by: Mauro Matteo Cascella <mcascell@redhat.com>

Thanks,
--=20
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


