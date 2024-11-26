Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7239D5A6CC
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 02:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFlk6-0000G9-KI; Mon, 25 Nov 2024 21:55:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tFlk0-0000Fl-G7
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 21:55:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tFljz-0006Gd-1U
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 21:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732589748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/KHLD1/7KJo1WV1fRWNUiwhhdyTufegTPPvHjp4tK5E=;
 b=UCttYhuCO6USpDdrAMfjW2Vs70seinmvCyLKaxXRROg5yhFpTKn4IygcgVcOCscnuCgBMO
 lcOG4hlcEvdkR8tK5+v/C6jcnBOA1obScRDpVrlgwRmixQjq4AjFIJlta0bMAJod4kVUyR
 1pOoQ5x8BKt8fC2/0vyhm3SnazxRjS0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-A7vkwwcQO-KV4gd813FGiQ-1; Mon, 25 Nov 2024 21:55:46 -0500
X-MC-Unique: A7vkwwcQO-KV4gd813FGiQ-1
X-Mimecast-MFC-AGG-ID: A7vkwwcQO-KV4gd813FGiQ
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ea65508e51so6508249a91.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 18:55:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732589745; x=1733194545;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/KHLD1/7KJo1WV1fRWNUiwhhdyTufegTPPvHjp4tK5E=;
 b=HsxM/19fXkJfAQM5B931Z/1MYeQr9VZY0jkwvMFPbbaYsWNCtCrm04DU2Fu1PBwJdg
 SKhCLrrG5yZG/VTX0PZwHofNmcT81tB36w+Mvi+VpF870H/xDk7/vfZuc8vVvbWVFbpT
 0qMVPhatRsIrqxWUXPTAQ/wFTqMlaCQtlscAymw27ZxWnc5Wi6nlq+PVWPWJkOfCwyOL
 NZY/TqbaRHkabU9hNzIg5qMdzuB8Dk5bYEeYKkLAtKlsxq2qMHf76cEprB6QsNwrDjhG
 iG+7rePRjGlNfelzAZv05KZTEFDoS99tO827urFetz3BP7IA24hwdjVgNyAo8wvel9Iz
 ZTiA==
X-Gm-Message-State: AOJu0YyjwMSJdXJQ6KG6GVjgmfdyXGuWyNw5Kb9/V3AJXSaaB3ow0Mtg
 1DhphmFYGIpNrxfth5DM8XJgwyOhwzuzo5gcyVFKjI/5oc/YBicpex+mt//LpjLXcT76vi+LUYx
 w4dYaHj4fJ11/NEEQmepuO0jIu76EUC7X36Lm4Itkl/zdorXyUoPWCbqnzk5WuWWcN0X4YkpO2I
 /TAgesJi5FPPHIXpe4ioJQyylgHW0=
X-Gm-Gg: ASbGncs+1bhF945uzkuMZUhFGnfn2V9yZJrWmYo4qajS83u2TJi5pkaCAOPLjWHgvpk
 YrHcvm7hoUlAfaWo3PgwtgdzwsXLCkw==
X-Received: by 2002:a17:90b:2692:b0:2ea:9309:75b3 with SMTP id
 98e67ed59e1d1-2eb0e0201b2mr19873436a91.2.1732589745111; 
 Mon, 25 Nov 2024 18:55:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfj95H1NnmLvzOuZG3wCLfHomCCmskjecSudXLH4SLNSEUQA+W9y29cVgsdTTqyyxIYu6ciTjbFnw/pURvTrE=
X-Received: by 2002:a17:90b:2692:b0:2ea:9309:75b3 with SMTP id
 98e67ed59e1d1-2eb0e0201b2mr19873418a91.2.1732589744671; Mon, 25 Nov 2024
 18:55:44 -0800 (PST)
MIME-Version: 1.0
References: <20241125060809.15543-1-jasowang@redhat.com>
 <c8d00883-2fd6-419b-836d-4bcc81065112@redhat.com>
In-Reply-To: <c8d00883-2fd6-419b-836d-4bcc81065112@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Nov 2024 10:55:33 +0800
Message-ID: <CACGkMEsF3iQs7xn=eVXR7UQKjh2qVRLFZBZUi1N6qvL6amxctA@mail.gmail.com>
Subject: Re: [PULL 0/6] Net patches
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Nov 25, 2024 at 7:06=E2=80=AFPM Laurent Vivier <lvivier@redhat.com>=
 wrote:
>
> Hi Jason,
>
> "[PATCH] virtio-net: Add queues before loading them" is missing from this=
 PR.
>
> Thanks,
> Laurent
>

My bad, let me do another pull request for this.

Thanks


