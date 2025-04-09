Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC69CC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 06:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Omg-0006Mt-6F; Wed, 09 Apr 2025 02:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u2Ome-0006M2-J7
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 02:19:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u2Omd-0006d3-5P
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 02:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744179571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PK0CeIQwZjwEqoxDrg3K7d2fj+Ttzpy6cWIKrjPYUpA=;
 b=aYRdnI6lO0cYohTe3ndgO43k8OcjGQoSlkbGzOVoXbqz8Z3irRK7JSyMTo2V+EhOEKM9Vu
 LlQ14vdCwHRe2qcR2hvRSITbgJRQnj03n1HaxNRHkcIqBtCxyFand413iZaVLJwp01JePV
 ZxEiUsLoiTGnGv9IVjFgKME6GLMEsT4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-7XCrA2rVNfKcxoIvZ-Ziuw-1; Wed, 09 Apr 2025 02:19:27 -0400
X-MC-Unique: 7XCrA2rVNfKcxoIvZ-Ziuw-1
X-Mimecast-MFC-AGG-ID: 7XCrA2rVNfKcxoIvZ-Ziuw_1744179566
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac2aa3513ccso534240366b.0
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 23:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744179566; x=1744784366;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PK0CeIQwZjwEqoxDrg3K7d2fj+Ttzpy6cWIKrjPYUpA=;
 b=nTTlL2g+U/iyK+jxiDzhUv4Vlz/nsO2d3PBDsYBT+lTcNoqhE2bmWuu8pHnKIRBvqr
 pSBglt5CS5058e+NywEwcHqxRXa6oZRVGwfcdDfg0qiOdRXLS4J5pDpXkNmG5S6pCzHt
 wz3axm5LgszjA6B+Rge3R71Ya54OqhgNEfCFV8H/qqHw4eEOlBcx/ZH8Vrvifgb4Hg57
 MKRYBtTsCbdGshbQ2s7BIwdFh8fdbcsfA6L7LLFeOCx7HIp9Em3MomTI85RQy6qALtrN
 m1vsDyu8oiYvQGBQshCYmdDUiRhNOkl5zjwOaubx5UnjUyP4/TwwiBiBbjDiMoo1exdJ
 /ASQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEXmLoxTVZdwvIKqOu4kL42nMN0+etUE1Hto+T8TzvhFrTX6kH7zORH0oPOIXRnTy19nGBiY0hZeVJ@nongnu.org
X-Gm-Message-State: AOJu0Yx1fef82ZgPw7kbVCt+AKqHGmgaRKlJY1IM2kl1wZSnsvEkAH4p
 jaJvobSTh69DlXb3f6fuTMf1ClZ+AKXtgEqoFOoI+rpWnP7dR7+fo9eZCeMzKCPtDMItjk1bhqI
 UtA9VaK8bExPiF6IpD6cWjqisUXf3TtmdPZLnLN333kTMOPukrDyj4N6+JXRALRDckpOuufudQt
 +0e2iC5SkwRlhOuq/7w3Z2YgXGmew=
X-Gm-Gg: ASbGncuTt4TegEuKlY75ccpTj50TZUgVZlssuOzSUC4N4Tc/Xw5BvJer1sFyCWAT28t
 gimmgG09hrmNWMoGge1/wJUWmRCj9R+NmHhWnjqNbWrYfpsx86EPPKj1eTcXLXPHODUJhtQ==
X-Received: by 2002:a17:906:6a2a:b0:ac3:eb24:ab26 with SMTP id
 a640c23a62f3a-aca9b734e25mr156347766b.51.1744179566462; 
 Tue, 08 Apr 2025 23:19:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8HFHJFmyrm5e8Rn1/sSzXpX6wvh2/UdgibNSEkckiPov17qdvdj6ERG0/Koz49PstAQVeMGSem3N+V1wMXbc=
X-Received: by 2002:a17:906:6a2a:b0:ac3:eb24:ab26 with SMTP id
 a640c23a62f3a-aca9b734e25mr156346666b.51.1744179566151; Tue, 08 Apr 2025
 23:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250408061327.2590372-1-lulu@redhat.com>
 <20250408061327.2590372-5-lulu@redhat.com>
 <CACGkMEuFrODdop0TCFPLT9oDrAuNMtZ2S3Dpu=mQ+afJpO6a5A@mail.gmail.com>
In-Reply-To: <CACGkMEuFrODdop0TCFPLT9oDrAuNMtZ2S3Dpu=mQ+afJpO6a5A@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 9 Apr 2025 14:18:49 +0800
X-Gm-Features: ATxdqUGDNkgIXUb5Wq_0mA0B2Hqxw_7oAo060MRa0-5yC1aCyOOPfbmwS_PQou0
Message-ID: <CACLfguWv7uA+4yuHWjyoGDGc9VLEizhuxwWMc5ogQm5HQWLs8g@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] virtio_net: Add third acceptable configuration for
 MAC setup.
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Apr 8, 2025 at 2:48=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Tue, Apr 8, 2025 at 2:14=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > For VDPA devices, Allow configurations where both the hardware MAC addr=
ess
> > and QEMU command line MAC address are zero.
> >
>
> Let's explain why this can work.
>
> Thanks
>
Sure, will do
Thanks
cindy


