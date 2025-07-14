Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26ED5C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 09:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubFs5-0001lf-2u; Mon, 14 Jul 2025 05:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubFnl-0006mA-By
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:49:00 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubFng-0006XJ-8I
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:48:47 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-70e3c6b88dbso28025647b3.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 02:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752486522; x=1753091322; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J62FOrGwQiYWoHbjwT12ZlIj36Ip+EeX6b8O8GgYZUw=;
 b=Ajd69L8VQ1ycH6ZSgIMWODo3WlU3uNe/sXi3tZFxDFBbIjW/gvA9aV9B+XUJpPLAYL
 /DXx/qlxYzRtyKKn+mQYCDtR3Ky3SYVpHwMFsWPrb5qzDKbO/qqiP97V53B8N1JLWdEo
 3+0+WYLRofwwvTyHN7i8IEdwDx6XWER7aaNHlbfq4iJpQXJi93aH9BGfb36tIDtMUfna
 2SkgoKRycu0AGdhAWbgTvKLKf2kqKJu8uNQ08OCSlfctDScaKFrexCFyrMUNholWJHgf
 kDeuLcLuA3sqR0qEM7x85XdXM+WJipWmnPJot83JuleMytlS5rRxz3rn86mzqFnX4b/m
 ob+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752486522; x=1753091322;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J62FOrGwQiYWoHbjwT12ZlIj36Ip+EeX6b8O8GgYZUw=;
 b=qHOnnBupdtJtKK5Kk5iSXyslNHr127t9bcT0zf3rSfnl383h9HabDMDOaau72itQlq
 jcQJjAYFEK3gkts0TQQCoitbPtnPP38bjuZcg09rIciAKkwzk94fVBZVFBxp1oWnlvVt
 JhXdqCftFcLJ2HmXRjkcGPX5BcdfRe2lH99ympvscvJ3V1xvyxospDhZJqYdFUAYzjrU
 Uq47E9ksOg6sK2jnrtfC5u7x+XdbpXDWv1QZNGthB8ewBc/+aOp+4NvUjFIp/ApJtJgz
 EJHOz80ihPe9y7TRXQT+FVH6iIJyzhCQrji9Es1WXkY9f4XfSgF6UkBFeYnkpp0l6gmA
 H+IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSy+JRDlLx87PpiVLa3Nknh/nn/EtJWeB/JHPC9ZRk3LLNGhnJ9FbqQpoLhvDA+m9Px/dCsDBktMgC@nongnu.org
X-Gm-Message-State: AOJu0YwTmbQV2EnB/ZtDogAQEv00cXOEwchT0tPEiszfo6ASUX8sv2yn
 B08YNoxKOtiQY1uWZYDFuOEI8q2VLDb3yIqa0ys7vzXl+BRFgmChoDTWtj8dDKupg2Ep/RNS3dL
 tsED/879ZGXWIVmfrBj0hdo0ObtxOQtjF5N2b4Bugig==
X-Gm-Gg: ASbGnctbMfnvcg20uSG1B4WOtosD4nA4agyqGhBj1KgW2Bik0QdSZKsOvJ9cOgGhGR5
 djTNVM+LlTQP8IvlvUBTsr6SGTd8HFaRr2DOFroWsn1QwFffdHxUc6EZb41/llJKVSdp8L2vuJa
 8vW2IPV1vykFXkA5Yt5bQnvDFlooaHibz4ercq2H1tOdi6abAYWEWgD6HXVxvVKeocq+dYLmA92
 dTWSHgwj18wzqpObQc=
X-Google-Smtp-Source: AGHT+IEVnm8ogGI2KGwMnLR6JMgzRhsdOoYDbfrELBpguA7dwbIhePUZcjPveZP2B7tCNmGa40lja+b2W5CZBZ1L/xo=
X-Received: by 2002:a05:690c:f05:b0:710:e7ad:9d41 with SMTP id
 00721157ae682-717d5d7aa0fmr184697497b3.12.1752486522407; Mon, 14 Jul 2025
 02:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA816sEoqZOzSwX9q1zzJEQ_mMpenLW7fBu5MEbM=aFymQ@mail.gmail.com>
 <20250710123945-mutt-send-email-mst@kernel.org>
 <rwmbufb2zk6grtmrksfthav6ntm7ddsodqfrpjwjt6njbacx62@7hikurlwh3kl>
In-Reply-To: <rwmbufb2zk6grtmrksfthav6ntm7ddsodqfrpjwjt6njbacx62@7hikurlwh3kl>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Jul 2025 10:48:31 +0100
X-Gm-Features: Ac12FXy5-YqO_N79aWTq0qBgwopg-1mjP13k2f7GOi_OAjiUq2tZBsRKLaI1S_0
Message-ID: <CAFEAcA-jqjuC+a7AH1wgde8=y_yTc_iE-MriwzT+RZMP7U070Q@mail.gmail.com>
Subject: Re: vhost-vdpa potential fd leak (coverity issue)
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 14 Jul 2025 at 10:19, Stefano Garzarella <sgarzare@redhat.com> wrote:
> On Thu, Jul 10, 2025 at 12:40:43PM -0400, Michael S. Tsirkin wrote:
> >> Q: should this file be listed in the "vhost" subcategory of
> >> MAINTAINERS?
> >> At the moment it only gets caught by "Network device backends".
>
> Maybe yes, but it's really virtio-net specific.
> @Michael WDYT?

You could create a new virtio-net subsection if that works
better (and we could move the two virtio-net* files
currently listed under "Network devices" into it).
The aim here should really be to ensure that the people
interested in reviewing/queueing patches get cc'd.

-- PMM

