Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDD4C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 12:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEpRl-0004pO-Rt; Wed, 05 Jun 2024 08:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sEpRk-0004oe-4N
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 08:08:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sEpRi-00064Z-EM
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 08:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717589329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2v9Z4zn5H16gf2IEP0RcvQSdt1WbgFyv76Fd0JybRQE=;
 b=LeCc5d7CS3IeSLm5jVZJ1kwowtAjoBAnBnQwT2wNAW8kUA01OiiDhlvFYFskHO8H74c6UM
 EkqqCeAYWWEkmNZBwueA/b9bzyyZSQAXjS12pL7/JIfEYeGPcrDznfBIjlh35bjh+A8xww
 Me/bMhHW4Sr1LjefY01KppA5g92MBCM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-Ei5xy4jcNc-wwKbRQNkKrA-1; Wed, 05 Jun 2024 08:08:47 -0400
X-MC-Unique: Ei5xy4jcNc-wwKbRQNkKrA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57a7946685aso1555054a12.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 05:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717589326; x=1718194126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2v9Z4zn5H16gf2IEP0RcvQSdt1WbgFyv76Fd0JybRQE=;
 b=iECIFokWN+D7q08T9Q54f8/BJ8KUBWd538qDh2dxQlbB3LdM+BPbmij/JvIepeEv18
 5nXNyXZvgf9Ab1XUlFsHCoiwxr/ZWJHOgBJ/7Y+/aGG6mS6OQ8YiNsxQvFk31a8YPE+z
 ZfRbRnRV1PgTUFZwDSl0hZQ343YA5VbS8i70x7PBkBSd9G2fNJLqsHie7BdYMk/gCIog
 E5mS0YfSkQZ+AWIO5mMACXRupBcDFYufcqRDcriAM3BxUYGgyRJzpOvIgAYl3NJMTOPp
 gGNz89KpmTaswFY5fevP0dispPijHH3uYl+1gjdj59QAA94Vw17zwxoAfbg6mLP/mLYO
 tcNg==
X-Gm-Message-State: AOJu0YyoiIIaUD74PUHN0FS2+R6ovyYnKEVz4J881x8lN1p6ob9F9rqu
 paTFFA8RCX+Z+WTCpUNEqr7m00uYUlBTRxr9gC1Lu0pYOvHAykB5W9Y9W68cThLe3cZsiNIHKZZ
 TVj6oXs4MC4bCPMmvAPRFFtrVUrfVMKpcLpDisiSFhfv1h9s8/9a2iWnz6Wjcai9J4BjeBt8f2a
 51B3Z0mVzgrPaBu+6KfGSzXjPjk0I=
X-Received: by 2002:a50:ccc6:0:b0:57a:27e5:2a8a with SMTP id
 4fb4d7f45d1cf-57a8b67c31fmr1805736a12.8.1717589326248; 
 Wed, 05 Jun 2024 05:08:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+JxuJ520EzT+4QtY4uXVm+JfZMvYvj6q9jh0fTRQVgJJ52LosO9DfGMFok6kJpKaWnybVCz6cTTo87EWHuIc=
X-Received: by 2002:a50:ccc6:0:b0:57a:27e5:2a8a with SMTP id
 4fb4d7f45d1cf-57a8b67c31fmr1805731a12.8.1717589325928; Wed, 05 Jun 2024
 05:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240603151825.188353-1-kraxel@redhat.com>
 <20240603151825.188353-2-kraxel@redhat.com>
 <CAMxuvawqf-0dKPsZP2UTcDWPWQ+8FKbZ=S4KX02hQO1qeeGVMA@mail.gmail.com>
 <tmtartaqh2ac4azfq4cgwh22uuc4pnrnxjpcpky24xzjrkwb5c@ung7cyha4ppa>
In-Reply-To: <tmtartaqh2ac4azfq4cgwh22uuc4pnrnxjpcpky24xzjrkwb5c@ung7cyha4ppa>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 5 Jun 2024 16:08:33 +0400
Message-ID: <CAMxuvay6qMGCSc7eWzs0Nu7x=VOyG6D56Jb9sNe+azh80GFe1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] stdvga: fix screen blanking
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Anthony PERARD <anthony@xenproject.org>, 
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org, 
 Stefano Stabellini <sstabellini@kernel.org>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi

On Wed, Jun 5, 2024 at 11:36=E2=80=AFAM Gerd Hoffmann <kraxel@redhat.com> w=
rote:
>
> On Tue, Jun 04, 2024 at 10:27:18AM GMT, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > > +    if (is_buffer_shared(surface)) {
> >
> > Perhaps the suggestion to rename the function (in the following patch)
> > should instead be surface_is_allocated() ? that would match the actual
> > flag check. But callers would have to ! the result. Wdyt?
>
> surface_is_shadow() ?  Comes closer to the typical naming in computer
> graphics.

If the underlying flag is renamed too, that's ok to me.


