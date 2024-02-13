Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD60FC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 16:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZvdI-00083e-Qf; Tue, 13 Feb 2024 11:27:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rZvdD-00082K-Cg
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 11:27:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rZvdA-0004MN-Dn
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 11:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707841654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VdvRDRNfwQhfkK2jwcHcDpAjihMyglqULnhQLVUv3D4=;
 b=SzGQtZY0BNyKedZljPXcK30Td1r4d786JclA0duMRL3bW2vq8mDq0qGKDCPYBq0P+cI2Cb
 uj9ovUy4szeHPW2Rcb13EEuJGur45vQJGrTPfNrDn5hg0waDEutFVEsSeo++7KyzmtheBX
 YiKNFopep3rjVJ8o9aMqBQVK60RXx0E=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-1ThAPe-sPlGKbSmFjeDsQQ-1; Tue, 13 Feb 2024 11:27:33 -0500
X-MC-Unique: 1ThAPe-sPlGKbSmFjeDsQQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dc74645bfa8so1664369276.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 08:27:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707841652; x=1708446452;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VdvRDRNfwQhfkK2jwcHcDpAjihMyglqULnhQLVUv3D4=;
 b=CUoFefni5+sjnurv6nQC9N/cVah9jk1Ch+/DkB7G3JRoPYqFJ6RYX/PZHG7eZOGJCx
 +HEhmVKVoBOuLJLzi3IxSJCwIKkYGpFeD5tIKpcRhmg8za1vK/qww7/S4EVRxCWbOSc0
 5JGDyJHGpZ5Nu0w7heQSm/r3GG37dZo1woCDe77oTELqEsHEuZH/gm1IB0MRjqbXGQqX
 ot0XACbWpdsog2uqfxGUbuw+aav0XKel+UOO4akOsXZ6p0h39kTg9zOMEvpOkx/k5L+l
 w1Xj2NIFwR+xi6wLeqLkNHiM1cjful/ttPSSTL8aTBxR/r/q66KJ14wwa7HdFQDLAmvd
 25rA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA/XhYEJU4nwEONvF3tKf5/Iq9Y2A+YoUZbGFvTbcK63pGg9IykT70p3mmG0CV6JJfP6vIS/94BRg4Hn+ZA8RzgvyyDy0=
X-Gm-Message-State: AOJu0Yx4o/AARC+u6Ui9Go5CWygerPW6qLAsn3uls1/jwH2VAN2P5bR7
 LJG3BnRkZdzfy40V0ovNZQbEI+U7WAirAGVcldGJox7mcJA9otiQK1+N0aSYQklG9AH17clpqoK
 mZipE2R8sdfWVZwnM8tN93NKc7yqldTCHNYkZ7wMPFgyOrP9L/C35yZdU8ig7VJL6RuTn6S70I6
 q5W2YLgiYsgCGhp6XXYR4fA7zZBqI=
X-Received: by 2002:a25:c5d2:0:b0:dcc:6e60:7024 with SMTP id
 v201-20020a25c5d2000000b00dcc6e607024mr2211025ybe.45.1707841652500; 
 Tue, 13 Feb 2024 08:27:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh22WouaWviQ7Luzz5TDi0+fEvh9rqvafjkQWyZjuS3hcEuhAGGLsdITzu1XRuRIaun8KSzN0HcIp2zbJVdLA=
X-Received: by 2002:a25:c5d2:0:b0:dcc:6e60:7024 with SMTP id
 v201-20020a25c5d2000000b00dcc6e607024mr2211003ybe.45.1707841652246; Tue, 13
 Feb 2024 08:27:32 -0800 (PST)
MIME-Version: 1.0
References: <20240201180924.487579-1-eperezma@redhat.com>
 <20240201180924.487579-7-eperezma@redhat.com>
 <9a919f49-cf88-4c72-92ff-f0c18a5593f1@oracle.com>
 <20240213052102-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240213052102-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 13 Feb 2024 17:26:56 +0100
Message-ID: <CAJaqyWc-OCKf-WR+h7-FoQR=iPO=9tXj3zCDDXNTT4TcejAQ_g@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] vdpa: move iova_tree allocation to
 net_vhost_vdpa_init
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, qemu-devel@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Lei Yang <leiyang@redhat.com>, 
 Parav Pandit <parav@mellanox.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
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

On Tue, Feb 13, 2024 at 11:22=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Feb 05, 2024 at 05:10:36PM -0800, Si-Wei Liu wrote:
> > Hi Eugenio,
> >
> > I thought this new code looks good to me and the original issue I saw w=
ith
> > x-svq=3Don should be gone. However, after rebase my tree on top of this=
,
> > there's a new failure I found around setting up guest mappings at early
> > boot, please see attached the specific QEMU config and corresponding ev=
ent
> > traces. Haven't checked into the detail yet, thinking you would need to=
 be
> > aware of ahead.
> >
> > Regards,
> > -Siwei
>
> Eugenio were you able to reproduce? Siwei did you have time to
> look into this? Can't merge patches which are known to break things ...
>

Sorry for the lack of news, I'll try to reproduce this week. Meanwhile
this patch should not be merged, as you mention.

Thanks!


