Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B34CCA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 02:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoCM6-0008WS-Gy; Mon, 18 Aug 2025 22:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uoCM4-0008W4-QY
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 22:45:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uoCM2-0003Uw-Rv
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 22:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755571538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tHKZkz5SM8be58wZf5eHOjciNJIxtJr9tDIA2DZa9YM=;
 b=FuByg68BtyFqTU+doM1vbgShARp6eyZq2DBHi160SSKtTC3cvzfmVY6p7Adiqph1O7x8Xq
 yl6IZHoAtmgdwGdWyQh4RsDPFCwYPLPPRbrqg5Lb4TbaDavo7v1Y8YpKu6ItNEtNXYhkDw
 Lk/NGBstq+TYVkN0xsZy3ojpbOFqeMw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-45ZhKrZSNtq98ES0EiBqAw-1; Mon, 18 Aug 2025 22:45:36 -0400
X-MC-Unique: 45ZhKrZSNtq98ES0EiBqAw-1
X-Mimecast-MFC-AGG-ID: 45ZhKrZSNtq98ES0EiBqAw_1755571535
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-323267bcee2so4542590a91.1
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 19:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755571535; x=1756176335;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tHKZkz5SM8be58wZf5eHOjciNJIxtJr9tDIA2DZa9YM=;
 b=q5QkcBzhCDkAUM3MOWBM1JbNptYkA5kFD08Ya9fqnji2ejb+T7yZTzkd1FngzKipDY
 OdYnnC0OAzIH7kftHXFDjpLeJ9hX4puDRAQVtuSejl2tJZIwG1xy0JSWveSiSWELlksP
 sWJn0oxc8FXNPgtU1L9TNwvA/c2EbzxlL3LY7Td1Wp9kNAG+BJ/qv67bJV91L+Jx0zfP
 1Gjvm8r1pzCtgOA5KSJQpJU/bwEykLb2XzGcOQoTg/drwcZD5bpSpxg85KYxPocZkMK+
 V1IONszYbxALSiCDadnTxMPXI6dIm3YOE2CyYERwby4J0WFOqPTEEyDmh4s9lrXi6gjY
 gmJg==
X-Gm-Message-State: AOJu0YxUnMt2qj4DaVxfF4C7TzV32NYDPq+e8K8p4Y+tKEOeBliSokFR
 wDBo3bzXTd49aF9Q0+0xE+z1SZqFOEzx2nkTK9zoNRIO+ASR2oASYTG0LdBj9G0e0h4eK2jYxSD
 k7tCAbKdGyinEflgQfKiHXwh6qJ081GcQ3jCGC/d1C7D4ABI9JKmEdoQ9SdM2bwIIlzmvH7ooYY
 DVlDjR8roNegOAZveXk8qSxs8oFbeytxg=
X-Gm-Gg: ASbGncsUuh3xYaLFOjV8ozRlQ4puKATz++k9cK63U0DSfYkErjE6mBbiew+6v9jW2Ar
 3uNZbuHIhD2k8SlBBQ9NjfjfMel1edG1EQpbJhHlxaxvBjXqzeBp1h4Ne2/LdfgwAcIS2uSOb49
 AMtw2Dc9ZYI3kLlhqB+AF9VYc=
X-Received: by 2002:a17:903:388b:b0:243:80d:c513 with SMTP id
 d9443c01a7336-245e02b9f53mr11887255ad.4.1755571535390; 
 Mon, 18 Aug 2025 19:45:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcJ/O5MPkJamCb6REebNYiu6FRF3kV78yfqw98JmrTwXvG/cZjC22WvuNppzKjUWGN6ZIaw5zYx3QY95qCjKU=
X-Received: by 2002:a17:903:388b:b0:243:80d:c513 with SMTP id
 d9443c01a7336-245e02b9f53mr11887025ad.4.1755571534889; Mon, 18 Aug 2025
 19:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250818140645.27904-1-vsementsov@yandex-team.ru>
In-Reply-To: <20250818140645.27904-1-vsementsov@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 19 Aug 2025 10:45:21 +0800
X-Gm-Features: Ac12FXwXte1-Xu1RTDLTyZI7jzomOu13Ni0mfNyvqR2S394aPW8l4YW7lHxULRQ
Message-ID: <CACGkMEvHXy0=vwAGS+2S7jCa5TjLxOso-SYb15TTE5q=VtPA2A@mail.gmail.com>
Subject: Re: [PATCH 00/19] TAP initialization refactoring
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Aug 18, 2025 at 10:06=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Hi all!
>
> As preparation for further development of TAP live local migration
> (passing open fds through unix socket),

I'm not sure I understand this, but I think it has been supported now,
or anything I miss?

Thanks


