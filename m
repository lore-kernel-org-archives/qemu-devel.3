Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031A6FF60C8
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 06:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7SGj-0000j7-Og; Tue, 31 Mar 2026 02:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w7SGc-0000hq-5L
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:07:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w7SGY-0002a8-OR
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774937272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SOMNRPZtXE9cpNpBdcolJkPdPk+qioaOp51N7BXgYlQ=;
 b=czzbXlwbLtg8oBjZhcNXOdut4ZdYq3JwWAciNB9+yhN0dYT6aW9apS3rZsGL6dv5SYkqvw
 liBBXK5keRghAQtCDTBGfX1Yu8jXmO9zXZ5zfnpXvqlkyRg/0xK99bLMvcRgW9Qh0ve4KM
 xg7l0vJyPWjpBOsoZyOeuz0PR0mbiFQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-aLj4PYkaMPyfw88jQQNtpQ-1; Tue, 31 Mar 2026 02:07:51 -0400
X-MC-Unique: aLj4PYkaMPyfw88jQQNtpQ-1
X-Mimecast-MFC-AGG-ID: aLj4PYkaMPyfw88jQQNtpQ_1774937270
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82c70d1f65aso3455681b3a.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 23:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774937269; x=1775542069; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SOMNRPZtXE9cpNpBdcolJkPdPk+qioaOp51N7BXgYlQ=;
 b=qQ/osgi+Ek5BhY6JJrlVateTjfxKql78XPclJLicXACzRgnvxwoz3XnFQvh66ZEY76
 Rg5taUmCk6uOKLUOxpM3RQ6U4Rl5NgMnUEeozHrVUKM3xBTMzASp0WqToAfFq8vNmPFT
 dfuQV88rUBIdeTjY28X64jDc0PalmP7WUFhnCJ7czAzU/yf5+48uyYHCwmjFAe0cDWgt
 eunemC1mDh0FCdMeuWuX7gewCns9ShM1gTWI8bXmUL4odptvaNtxks6kwg9DnUfqQmkv
 79Gw0QwBvl4IwQtGMggPP/o6WgzDgYjbW1QAS6N5rwBd9BX4s1lXns3Vc8VuOgx7jpcN
 4dvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774937269; x=1775542069;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SOMNRPZtXE9cpNpBdcolJkPdPk+qioaOp51N7BXgYlQ=;
 b=O1TTF3lYSRX9NThodb6eIneZtX0ioq9bsXqDYfjGZLqss0t66HQnQ5K1g3BNxvGMgB
 FrzwSGroFQhyP/IlM4nODKwfOZ1pwSZtI5ahQmqqLrL0J+Lct0OTbW6D2WTZn3u83Q3Q
 qivdzh4DM3S4+M0IhYjhA4oPznV8oBkqOx8wttM+sSV7+mGqOs1X0jzIY2Ro2KyZZgyb
 EPbKhrk2agx5WPmgHL3ZOTQB5W4FIZa682mvYg/RnRVUF3dxLwqv5Njo++hR//CvCVbt
 ylCQ5QimSpiDGDXlxQQ0OH/0Dp8G6odtrbX8yaF5V43gk8nL+/wfYhvLijmiltzVrA3l
 o4Sg==
X-Gm-Message-State: AOJu0YyZ/j1QvfrMaXc4F5eKtiGkQbCEts0ygn4yl1d+GpacArc681ZO
 PFZKgT/oGC3YpWAkwsxKf+TyCV8CvL3gGLXGtdPBaD6rHoy+mJiI8T0uY45QL83eIxR6dp+UMek
 OtDqSX19MvLj7disQGtCsOwPtNDLKT+PWTZNCnNmawMZbrJETBhiK5/0r3kMVLcBk
X-Gm-Gg: ATEYQzydfqPicbAoLWrMd1EStLE7VoJoqGucNloTHjdGj/coVVdH+Lo8frxCgKPqb9i
 5Yp1FEAjzRltWWmEwiWEAXR9tgFniZ31XfUrKPQ22a5t1GO1hFAEUhdl5s79RJKpIz9l2ZnGM9m
 3e1oYZFyInAJ//z7PEr17PN9AN7Ez3EkE3Gxn4bLFrD29hBQ0luPTQ8g9slUImdXh+8p0DjMC3U
 eVt3ox+8pOFqxyDuE94DtjgjqeDKsd8UPazVV4iVfngZOwmwlEnXs1RpxWK3tqD+bcrLhTg+7hG
 HQhbMiN9YpB3eaQCTcbSFNJCm4ZB1PJ4A/kjlp4n5EDnmkqhcq/e3DwVZUFJ6LWtIWVcn+EEe/X
 ysgG8TQR1+mRmgLK4AwnUgrxPjwn0Zu2GNY05/Za2Qhsw++gKnROnndyWSLVfSQ5j/ZI4crv/RK
 8=
X-Received: by 2002:a05:6a00:8d3:b0:7aa:a2a8:9808 with SMTP id
 d2e1a72fcca58-82c95e650a6mr15395843b3a.20.1774937269448; 
 Mon, 30 Mar 2026 23:07:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:8d3:b0:7aa:a2a8:9808 with SMTP id
 d2e1a72fcca58-82c95e650a6mr15395823b3a.20.1774937268994; 
 Mon, 30 Mar 2026 23:07:48 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca843b818sm11144762b3a.6.2026.03.30.23.07.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 30 Mar 2026 23:07:48 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 3/3] igvm: fix parent object type in IgvmCfg struct
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20260330-igvm_fixes-v1-3-03587a5a808b@redhat.com>
Date: Tue, 31 Mar 2026 11:37:34 +0530
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9B544E78-E4CD-488B-BB87-A33998910CAC@redhat.com>
References: <20260330-igvm_fixes-v1-0-03587a5a808b@redhat.com>
 <20260330-igvm_fixes-v1-3-03587a5a808b@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
X-Mailer: Apple Mail (2.3864.400.21)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 30 Mar 2026, at 6:13=E2=80=AFPM, Luigi Leonardi =
<leonardi@redhat.com> wrote:
>=20
> IgvmCfg is defined as an Object but, currently, its first member is an
> ObjectClass.
>=20
> Replace ObjectClass with Object.
>=20
> Fixes: c1d466d267cf ("backends/igvm: Add IGVM loader and =
configuration")
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> include/system/igvm-internal.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/system/igvm-internal.h =
b/include/system/igvm-internal.h
> index =
76ae1bc3be9249cc1796bd7eec77dd9084358f98..7f131c4d0392214e4d53ca84d60713b3=
c1493334 100644
> --- a/include/system/igvm-internal.h
> +++ b/include/system/igvm-internal.h
> @@ -19,7 +19,7 @@
> #include <igvm/igvm.h>
>=20
> struct IgvmCfg {
> -    ObjectClass parent_class;
> +    Object parent_obj;
>=20
>     /*
>      * filename: Filename that specifies a file that contains the =
configuration
>=20
> --=20
> 2.53.0
>=20


