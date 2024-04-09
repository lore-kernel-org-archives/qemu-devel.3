Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511E5CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 03:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru2OP-00073r-Gq; Mon, 08 Apr 2024 23:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ru2OO-00073O-5M
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 23:43:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ru2OL-0000c2-Hd
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 23:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712634204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yTibT1/LWcjSGgxLSnK7W6f3bwe/q5tcgf2rSYqDkeQ=;
 b=h1O6qu03tuwhwl4K7Xk62TCJhHDpjocn1v8/cUMPcK77SLJaRpiQp7v2Bq6nlh5qJsBSk8
 gJ32Q0gwOUzh/Pl6PhtW1E28Kw5pRgNbCrdPM+wl/MAj6gfsQjJAD8IaRG1+/i7I6MKFNq
 9HUzHRFsvaabdWV65alaXJAJeW4rtTw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-ifJGRw2yPLCI2v-eTUj03w-1; Mon, 08 Apr 2024 23:43:23 -0400
X-MC-Unique: ifJGRw2yPLCI2v-eTUj03w-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2a2e6197371so4556055a91.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 20:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712634202; x=1713239002;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yTibT1/LWcjSGgxLSnK7W6f3bwe/q5tcgf2rSYqDkeQ=;
 b=MJOZEEXTweyP+LPwzhIiw6fcTNDg7+Ai8GgUdHLDTGM0GB2vnTjz9KXgue+LMIA1xR
 KQzY+KXy94lVL9M1exel4GBKQVpsA1y/bJ7g7+6B4h9Fi6Jh4Xj1H3L9QaKe70dX8UYd
 0fT+pJ0HncWK1A8i2i/v/flCCx4EhOpadObilC0C9hB3PhhS9sAyeh4dKua+y3PcK4EA
 dfck6rSTwVEdSrzH4Rv+xa0rtNhjxwwjMJJbzkxDG65d6geiq86b+CcCguXErprStFxw
 hEX4kScGXlzw8462mjb6qFoNQxAZqztBgBuUviBSjv9elpv9F1XxCBvt4+csi5Jg+juf
 caQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn7dDyT9PZP361XMfSj2HAExQhixMOgQ1jWyc4MEaFn1pLXHXEtH9TAR0TFMl1I7Z8nNft/jqcZzrLDQVu1DFBju3Evno=
X-Gm-Message-State: AOJu0YxfNlUTdK+N+Nzo/71srBDxR4YfL4O35blvW6+vsnIdu444IHm3
 3R4tLgJe1omg+ZrAMPEQ/zxqYfA99WcSwf0D8W73yhZ6bQf6fb+rU04U5SF+eAAnM7vOxspja8u
 Yf+bp+meUReKaq6DqWKiV4fW6e9ytu+qmt+rySq6dcnqHMnYIOC+fDikyyP69YqFvIAxYSJiu05
 Ku93qL3g4AENLfen+tiv+b7ttLNuYF7sJEr2Yr+mSC
X-Received: by 2002:a17:90a:ab97:b0:2a5:3637:1968 with SMTP id
 n23-20020a17090aab9700b002a536371968mr3687244pjq.9.1712634201908; 
 Mon, 08 Apr 2024 20:43:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0KvPTfonf8R7VOPVgqyDpVSSnbFjV6xwk48qsgOvsOOjT2WYUbtqANMbeYz+UQKr4y5MnV2cr/hHNdcT0b4I=
X-Received: by 2002:a17:90a:ab97:b0:2a5:3637:1968 with SMTP id
 n23-20020a17090aab9700b002a536371968mr3687234pjq.9.1712634201608; Mon, 08 Apr
 2024 20:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEsrT4xxW-KzLm=rTqXf0P+u2=0fy03z3EsHZFEqQePjJg@mail.gmail.com>
 <20240408073311.2049-1-yuxue.liu@jaguarmicro.com>
In-Reply-To: <20240408073311.2049-1-yuxue.liu@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Apr 2024 11:43:10 +0800
Message-ID: <CACGkMEtZ-3PBETsOHhUe=pm7avpU1tJQbtfQoxc2K7Jm+NsHeQ@mail.gmail.com>
Subject: Re: [PATCH v2] vhost: don't set vring call if guest notifiers is not
 enabled
To: lyx634449800 <yuxue.liu@jaguarmicro.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Apr 8, 2024 at 3:33=E2=80=AFPM lyx634449800 <yuxue.liu@jaguarmicro.=
com> wrote:
>
> When conducting performance testing using testpmd in the guest os,
> it was observed that the performance was lower compared to the
> scenario of direct vfio-pci usage.
>
> In the commit 96a3d98d2cdbd897ff5ab33427aa4cfb94077665, the author
> provided a good solution. However, because the guest OS's
> driver(e.g., virtio-net pmd) may not enable the msix capability, the
> function k->query_guest_notifiers(qbus->parent) may return false,
> resulting in the expected effect not being achieved. To address this
> issue, modify the conditional statement.
>
> Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


