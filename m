Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2700BCED62A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 08:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syS8w-000898-2I; Wed, 09 Oct 2024 04:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1syS8t-00087t-Tz
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:34:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1syS8q-0000h8-UQ
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728462836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l5HKFK89dn5rttwnPrqVrQzyCKq5vCMiAgMxHpkHRhI=;
 b=HngCL/7rZnomoYIcW3iWoDvpjfL41QFq8fDeIrChQ/nmMSebIsGLaJY4rWlm94RYIyi46G
 o20yp5ZWbdabUrEkg7zhTcPSrbIXhFljdFcQa/zGtiyMQ+UcQGFUhSq7d4qrhJX4IzLoV5
 KATsZYoWIM0XLip4N5ramMJmmnGNSKs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-9MfBh2xdNA-35wqIwlIA_g-1; Wed, 09 Oct 2024 04:33:52 -0400
X-MC-Unique: 9MfBh2xdNA-35wqIwlIA_g-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2e2a047d06fso623577a91.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 01:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728462831; x=1729067631;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l5HKFK89dn5rttwnPrqVrQzyCKq5vCMiAgMxHpkHRhI=;
 b=OXRD3YbXf/yJ0E9ePA4gazSBYlrLoxZWMt+w8xpRB89n7mVXqkSa1MYX5p8yr5GtGB
 hAMc/mVBq8Bkc6zS3ypb6dwTYojc2MQ8pSepQwqCGxynVovG3RgdcFgodBK6Ex40mQyp
 knng0Km+FMZrPnMZM6GrOOyuGE0dQN+d/qXKT5rpg7lTQOKZtnAOcG8Hdk6+dWHtZ8Rw
 vSHTaiSPZO0+POjQjVhaB0iC4/5X5F8JJr4DRd6PqCWu4mCj1iAB0i5wiMBodxSyPFCP
 MSn0gXBsgXe7ikGJn5SeESOmX2B9wBriK0ZDYANHxjJiXwSQEzE60PmU0uj8zCIzjstY
 S7uA==
X-Gm-Message-State: AOJu0Yw3H/Th0xeNKbLXOGWqjzDTegF5d0Vp7jVCvtzycRrAfXPvL8Ex
 Yj0+1ubVwqYoevLYwtvig9koEmA6I0f6K9EgDv7OBWibxq63Y7GcaxB4mcRqK1mXPw8kFEWiOhB
 wvVTY23WX2Mza2LCQW24x4IcRkRAXq5QAqlrkfFRQHlqsIyYjD+FDf04bmU/xt5keJFjughm9qF
 eVcgvwdcFFB/wOfMDf/PFXAHcCgFDW1uIlOZVQ4w==
X-Received: by 2002:a17:90a:e518:b0:2d8:9226:aa94 with SMTP id
 98e67ed59e1d1-2e2a22e6ef7mr2162556a91.1.1728462831447; 
 Wed, 09 Oct 2024 01:33:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn44GuRM1nKI+90u+conhBU0XmcD0LuPR1syxDulKscZjNO6DFawphTTUNSy0Nln4LiV7L+EWsce+2UXzigtA=
X-Received: by 2002:a17:90a:e518:b0:2d8:9226:aa94 with SMTP id
 98e67ed59e1d1-2e2a22e6ef7mr2162538a91.1.1728462831048; Wed, 09 Oct 2024
 01:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240918205258.444880-1-dave@treblig.org>
In-Reply-To: <20240918205258.444880-1-dave@treblig.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Oct 2024 16:33:40 +0800
Message-ID: <CACGkMEtppjXh3dT8WZ5ja_XOQX6h+Mi2BM-A+MufDr=oMc-CRg@mail.gmail.com>
Subject: Re: [PATCH] net: Remove deadcode
To: dave@treblig.org
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

On Thu, Sep 19, 2024 at 4:53=E2=80=AFAM <dave@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
>
> net_hub_port_find is unused since 2018's commit
>   af1a5c3eb4 ("net: Remove the deprecated "vlan" parameter")
>
> qemu_receive_packet_iov is unused since commit
>   ffbd2dbd8e ("e1000e: Perform software segmentation for loopback")
>
> in turn it was the last user of qemu_net_queue_receive_iov.
>
> Remove them.
>
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---

Queued.

Thanks


