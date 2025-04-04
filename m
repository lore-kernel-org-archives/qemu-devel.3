Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D291CC3601B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 08:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0cHh-0001nW-CE; Fri, 04 Apr 2025 04:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u0cHe-0001lI-Ph
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 04:20:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u0cHa-00011H-7d
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 04:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743754805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nyJkllHF9w9teB/a21LPDrwM+6qyc7/QrCICaFfzSlA=;
 b=Oo2URMVMo0c2Oowb2nnvi6bAQfpu2lzTm4LSUlhm2Q55vI003YZGPSJzt5PCvCNPoBP11+
 gp+7iYHozVT9OObDxfPkWIMsRd+tkStkiDmCYye1oj4rYCU0Pp5l/xuS8/ypVB7Jn+ApIJ
 X5Iztd2RyXNqqZtgn3IgKLeKgiFN/4o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-Aka4k6otMJGeBCsikBMjog-1; Fri, 04 Apr 2025 04:20:03 -0400
X-MC-Unique: Aka4k6otMJGeBCsikBMjog-1
X-Mimecast-MFC-AGG-ID: Aka4k6otMJGeBCsikBMjog_1743754802
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf172ff63so10417075e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 01:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743754801; x=1744359601;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nyJkllHF9w9teB/a21LPDrwM+6qyc7/QrCICaFfzSlA=;
 b=FNb2yqokrn6e/5pvSBNwNozv+IyI1z6heW64YF+hlFTk/8OoEy1yflKpyhuQjPyDjP
 rBa1AR+VKWXLp+1Zg79IqYnWu3s7C3m7PY2TT05IY40uNKlZtMNahUitDjsprx8om7DI
 AuVczzneLs9gQ68E8h6dHSNUo+gti7j6OZhWlWwsXr1vNERFscPUlkE+2rsFrk6mX/iw
 b/oFQFH1tAF1XRUO59kNLxDhhfglGctNIjQ0vdRI671y7O+uwHeol6sSRbe6dHbs+HMd
 FL0Sa87HhJpIQtntFpnLIjN62/9eBWDVhPG5FHJKVaEWmNfzas3OtfRQnkjylPWxzEU0
 jMgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWki4PjpggYeVQqJhPZvLy7Q4+BfOpHnBsLw+UtNtTNPe1lzv6MgPmK5iWqZZQWh+IK0fX9Tv8uFJkc@nongnu.org
X-Gm-Message-State: AOJu0YwUFMz+zTsCkiOjNiRUfy3e6ZvBoZ7sGfPtgXgh0Ozfl37CpN0c
 lJVJsB1jIydsEmc0HfyUW0vH6V9rufYtUuv3wC/dQSoGEsK5h13v/KEXQTBnQVi9xqeoZED4eUw
 2sYHXF3rh7vAt4A6hXKrwK3MK5yztrb9sWk+GabjUvNRm4CMjlQP4ibCEEAkspV9QzsDkWdLkfn
 y6N6l9t/XyVnmQKj8mdCfc4ACin7v3lLfuxl0=
X-Gm-Gg: ASbGncsymtjWkz8rAe4E6mkQQTIwtPeyZr2n8+ZhgCLhoHRJb+kIWJs+z25jMhU0YO4
 sWdCem5JIwvwKFkswiVDRb9TBDlmy/afQs2Q2YUoGWD5EGQyJbO0ZZueTilXKipGovKtstFQNin
 Q=
X-Received: by 2002:a05:600c:458d:b0:43c:f616:f08 with SMTP id
 5b1f17b1804b1-43ecf85d1d7mr19925855e9.8.1743754801549; 
 Fri, 04 Apr 2025 01:20:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeLwPR1sLWSx0ALoj8Uv2ltuOTqq+CcUURw25QPvHOPAhWQEzQt01192TnZGDpDhfPSIPEeHFmsoBzvKLRcnY=
X-Received: by 2002:a05:600c:458d:b0:43c:f616:f08 with SMTP id
 5b1f17b1804b1-43ecf85d1d7mr19925405e9.8.1743754801091; Fri, 04 Apr 2025
 01:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
In-Reply-To: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 4 Apr 2025 13:49:44 +0530
X-Gm-Features: ATxdqUG5I0X0FIaA4dkvs3JEZ5wySShEAzpUzxz4v0nM6OWoWz_4VgvwQgS7EgU
Message-ID: <CAE8KmOzbtMwwTF662e_xo77EQ-nK-QOcqYDfmirkX-m8faAcxQ@mail.gmail.com>
Subject: Re: [PATCH] migration: add FEATURE_SEEKABLE to QIOChannelBlock
To: Marco Cavenati <Marco.Cavenati@eurecom.fr>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
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

On Thu, 27 Mar 2025 at 20:03, Marco Cavenati <Marco.Cavenati@eurecom.fr> wrote:
> Enable the use of the mapped-ram migration feature with savevm/loadvm
> snapshots by adding the QIO_CHANNEL_FEATURE_SEEKABLE feature to
> QIOChannelBlock. Implement io_preadv and io_pwritev methods to provide
> positioned I/O capabilities that don't modify the channel's position
> pointer.
>
>  migration/channel-block.c | 48 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> +++ b/migration/channel-block.c
> @@ -30,6 +30,7 @@ qio_channel_block_new(BlockDriverState *bs)
>      QIOChannelBlock *ioc;
>
>      ioc = QIO_CHANNEL_BLOCK(object_new(TYPE_QIO_CHANNEL_BLOCK));
> +    qio_channel_set_feature(QIO_CHANNEL(ioc), QIO_CHANNEL_FEATURE_SEEKABLE);
>

* IIUC, when _FEATURE_SEEKABLE is set, the channel I/O sequence
eventually makes underlying preadv(2)/pwritev(2) calls, which use
lseek(2) to adjust the stream r/w pointer with the given offset,
before doing the r/w operation.

* QIOChannelBlock has '.io_seek' routine corresponding to the lseek(2)
call. It is not clear how setting QIO_CHANNEL_FEATURE_SEEKABLE helps
for QIOChannelBlock streams.

Thank you.
---
  - Prasad


