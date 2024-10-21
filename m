Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA40BD0E6CD
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 08:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2nsK-0007xD-1F; Mon, 21 Oct 2024 04:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t2nsG-0007um-Hz
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t2nsE-0005Ce-2X
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729499684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KKo+r6t/x9djfPmI784QlQOfkufBFGpF6QbYJkAYTyg=;
 b=C93Ju6bqaYUQ79k5Is0ypnN6N2V60TwNby/kOBNkLqKgYmQ/tT9nOXp81dda/yWhIalu10
 eKHM8ENmIZZsnwvIsguNUUxwjpJc6e0fMkLHapvF04vsJWN3Xv0ol4mtj8BK9Sb1EtJxgO
 5piHYck2A3Lu03ERh+m65ANFnqOPSlg=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-ycbf6NiJNdWIyEY2rF4oPA-1; Mon, 21 Oct 2024 04:34:41 -0400
X-MC-Unique: ycbf6NiJNdWIyEY2rF4oPA-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-71ea6b901fcso4337466b3a.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 01:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729499680; x=1730104480;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KKo+r6t/x9djfPmI784QlQOfkufBFGpF6QbYJkAYTyg=;
 b=qqTf1tpOMTfyRsCTTFbwe39WoiaR7F628PHOSfM5I3LH7wOHbSjzo9hvSRpVhiuwDq
 3j2gSQLHZtB05JwIuUGHPx2x+QU4SrGJ0lsX4QMM5f2YSDo9cc0t8K45trhRO0b8N2QI
 Uo7t41ODmqDd6l2q6Tvsjyp7mOjdO4dcLTd/T/4JvHuWpXDy61IWsNBq6OAoqx+WpUqg
 djPp4Gal4wMQsIp+U1B4HXZSDn+bJ5uYcLhI98izXkVO0d+C74+X2t4MP1BYgulu0FTq
 mCMT+0dUhmfT80dYCFRnyQ92RfgQ72ryoF9iLZmzKGSFJPn0UjS889IPgq0JaycYTTsj
 3hiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8BSzo966OOxiemG9nV/V3psxTjdcPI8aLsy5d/mFNJnbFHSQicIkznZiEl3u9fmSgQZOhv6fYkSP3@nongnu.org
X-Gm-Message-State: AOJu0YzYoujvwhCzX8oKAaLy/D8iMt5ukqXX3LTtaYgYMrZksT0D6t/a
 4DDL41X3uwOnKNvMSVyKZncY4srVFVPmenIZsrJE49QGF9DiTMYFJF1Ph0WX/oL9fYFzG4KNIWp
 wwEmQ6Kcupou1MnnJj7+fYoxD5oC7NiBivmhax+gm15n8LKATUCDl+iqWXKZPVoiZL37dP4YVkN
 jpOJ7nckXq0zouHn4mSZjfDapRpi+JL4QJ96wOc+DO
X-Received: by 2002:a05:6a00:2e1d:b0:71e:51ae:d765 with SMTP id
 d2e1a72fcca58-71ea3339d8cmr14237999b3a.27.1729499680089; 
 Mon, 21 Oct 2024 01:34:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEJQOvpLMT0t4eu743aBsobWNZpRhfRmolZxheKU6WCea6eZXLifcXzrxSBYE7526ut8C4eVd29NThHyycH3o=
X-Received: by 2002:a05:6a00:2e1d:b0:71e:51ae:d765 with SMTP id
 d2e1a72fcca58-71ea3339d8cmr14237988b3a.27.1729499679680; Mon, 21 Oct 2024
 01:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20241008-mask-v1-1-679ae2720bd5@daynix.com>
In-Reply-To: <20241008-mask-v1-1-679ae2720bd5@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Oct 2024 16:34:28 +0800
Message-ID: <CACGkMEuk0VeCDwsv8NJm-iBHDxgQVRFB5ny-9=WPXatC9oKWMw@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: Avoid indirection_table_mask overflow
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Oct 8, 2024 at 2:51=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> We computes indirections_len by adding 1 to indirection_table_mask, but
> it may overflow indirection_table_mask is UINT16_MAX. Check if
> indirection_table_mask is small enough before adding 1.
>
> Fixes: 590790297c0d ("virtio-net: implement RSS configuration command")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/net/virtio-net.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>

Queued.

Thanks


