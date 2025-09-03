Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4977CA100B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 05:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utgAV-0000R7-EC; Wed, 03 Sep 2025 01:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1utgAT-0000Qz-Nl
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1utgAQ-0008MO-SQ
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756877780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kNC+xX/szxMmoPS07+v8qNtRKS8tBAwMXEkzw99xfME=;
 b=aDyBgazMLI/HMJzKKMsCePlOKKota4370/rtt3u9iLfTONxboeqr6FdTeT3DH/A5m2nMxB
 eMrRE7F9Ml/n/F60fVVR8MjQlfCFrDDWEkGCZOENDtrVEGeF2/gQ/1iqE9QuZ3pQHYZuty
 whqggmPU8+xWPcMHbaVNS5ajlc6YE9w=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-Jw4qKbLVM1aeslDhW8vEAQ-1; Wed, 03 Sep 2025 01:36:19 -0400
X-MC-Unique: Jw4qKbLVM1aeslDhW8vEAQ-1
X-Mimecast-MFC-AGG-ID: Jw4qKbLVM1aeslDhW8vEAQ_1756877778
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7725b77b795so2997668b3a.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 22:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756877778; x=1757482578;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kNC+xX/szxMmoPS07+v8qNtRKS8tBAwMXEkzw99xfME=;
 b=qrnk0UbbK2Go7+5EaVXDeNo2jPwNxjgleCaZq3gvOojsuxaDEpgfC6fQgHK927bUPX
 VW/IFjejV5fytzNDnso7i6snGUKhyrJTgufHinrIBvtj3IUUoc+xu1Ye2OameSaz2SKP
 6XIgoubjiotUOeffU2pqFV2OeqReWHECWtalCNpiLrjFGkQvBbyi4qrb0lregYDbjFB1
 QJ+dlO3uBkL8Qf0QqvEwfkb6Icg2caRacpLqzPC/YBijFxfIkVP7Sxxfg9BNOQu4R3jk
 nBOuWjQN7/m0HujE2BF7E7W4bYFnPjIPbhGf6DN24UbG/erkNwHGQeLmR8YanA5orJeS
 6GBA==
X-Gm-Message-State: AOJu0YwUSK84iCmBdZDEE5w4lLVssZpBlynIEuGot6+aoROqAdvz0Yzf
 TI52YK5nktoFDhVT0CJ5CmnnTpfk5Xy7H/Jg0XFzdgeXXIS0IRGhXf2+NXBGZZtjWaIvgkYABDR
 yknIrTbaudCtE7B9DKoEh9T7849rC9LLuIibamRAUnfE9qNP4R82Cr2qM8DvwTDJFT+eFFQjNUy
 ObvgoSzPRF4yJXvO+GtVdpDSk77xNs53M=
X-Gm-Gg: ASbGnctI8j+n3xNN9HYrstNfEcF5NileYCuRu+8NxxBYW2kP9faGY6okLllBvn+7giR
 Egy3MkPfZpTTz4T7LjeFVfJDWAh3+qRzHXmGgacfSlqcyW+1sHv8qGLFG7kcTNm9JDkbMIN9xbM
 QjCiYQuQO3njsUKydlAH3PyQ==
X-Received: by 2002:a05:6a21:33aa:b0:248:ace6:7577 with SMTP id
 adf61e73a8af0-248ace67867mr1019991637.9.1756877778468; 
 Tue, 02 Sep 2025 22:36:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6WyrMxUaldpXEFU7NQlI0t1N6x5WW3s2bQNLPOyXSjdL2qp2Dbmg3AtOysKmPfy9y4gc9uBLHqsTG+/2UFpU=
X-Received: by 2002:a05:6a21:33aa:b0:248:ace6:7577 with SMTP id
 adf61e73a8af0-248ace67867mr1019963637.9.1756877778053; Tue, 02 Sep 2025
 22:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250823160323.20811-1-vsementsov@yandex-team.ru>
 <20250823160323.20811-15-vsementsov@yandex-team.ru>
In-Reply-To: <20250823160323.20811-15-vsementsov@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Sep 2025 13:36:05 +0800
X-Gm-Features: Ac12FXy2S8gUZRsG7awGyqBooJz-yjCAzfZ5pHwZ8OSVWBNHRf-Xo1SwVjbA9Kw
Message-ID: <CACGkMEsWa62Su9jP7-swP9t4WjTfoNG9UoqG7_KHtoha4_WR+g@mail.gmail.com>
Subject: Re: [PATCH v2 14/20] net/tap: refactor net_tap_init() into
 net_tap_open_one()
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, leiyang@redhat.com, steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

On Sun, Aug 24, 2025 at 12:03=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> net_tap_init() is used in one place. Let's move net_init_tap_one()
> call to it and simplify outer loop code.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  net/tap.c | 54 +++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 31 insertions(+), 23 deletions(-)
>
> diff --git a/net/tap.c b/net/tap.c
> index 83a1c9250a..57939ed16f 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -674,31 +674,37 @@ int net_init_bridge(const Netdev *netdev, const cha=
r *name,
>      return 0;
>  }
>
> -static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
> -                        const char *setup_script, char *ifname,
> -                        size_t ifname_sz, int mq_required, Error **errp)
> +static int net_tap_open_one(const Netdev *netdev,
> +                            const char *name, NetClientState *peer,
> +                            const char *script, const char *downscript,

I'd stick to "setup_script" as we have "downscript".

And we can save several lines of changes.

The rest looks good.

Thanks


