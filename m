Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FE2CCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 07:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHGeE-0004lP-N8; Fri, 07 Nov 2025 02:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vHGe9-0004jg-8e
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 02:12:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vHGe6-0006Ho-Mo
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 02:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762499548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5U9xVWtKqLEApveFaEW/VyTKspI/ERE5v9dtCwtpDmE=;
 b=GmLdzcr0EB9LugaEOO7lTrgcTrBWUvZK1YU4K/fG8+1VtwKxUMIwfVrl2GfUAZuwOWeGFt
 ryp2LqLR4njzTOyhXWDAbTsk8rHoTRSh7DUv4d54AY6BmZpZY6LbvOl6VLp+9oJpG9yqUC
 VIOVcjyOwGhKAUAslx/hIyz0+qMft4w=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-1QNve5koMyW3pUNW0D3yIg-1; Fri, 07 Nov 2025 02:12:26 -0500
X-MC-Unique: 1QNve5koMyW3pUNW0D3yIg-1
X-Mimecast-MFC-AGG-ID: 1QNve5koMyW3pUNW0D3yIg_1762499546
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-5d7e04f9f20so934518137.1
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 23:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762499546; x=1763104346; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5U9xVWtKqLEApveFaEW/VyTKspI/ERE5v9dtCwtpDmE=;
 b=hcrdNrSzhzAnYL9oClCPEGGdtdCTzNTeS2zGfzWhF64Tij6O0BtLiQuH0nLtTT6R4a
 F4Dj1lKdQcs1LiLXMQLEcLzY4CZeYixuSB/jvh0o5TLqId+YnBywFzUXjnOc5g8P4dlm
 /p19lr4cdoc3q36Jmw9jXwZyb7T64Blqp1q6J5q6ovwboXkug5qN1jVcqVLRY0U00yVw
 RupudZPGrEmC+OJXol2Pjnn+0Skd+qPI8hR0WuZ4H48eKa6iHdFB7xt4CT7JYiEYyC3C
 7mCXnC88rwddY2Cpq2vTA9BIdsYIDjpCY+33D4y0bpA98vysFBUQvUrPJYjnCaevSuwJ
 5N1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762499546; x=1763104346;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5U9xVWtKqLEApveFaEW/VyTKspI/ERE5v9dtCwtpDmE=;
 b=iak5xKxCaQv4bO875Jweo2OmOMhjiTUWqQ79kT60hsGiZpx6A5TMjJToJcHmmNh9ih
 wifStSFUiEP6KyTLZk6fBMfYHG+ASe+CQNdxRDQFMsXn7dUuYQ83m6vMMBrcscssQKlI
 talyknZWeyTmmCQZQoHDFLY/k4EWrZ3SLqKl8Pf+R521qTKOPZS7LzKgCmcNldFDsvA7
 +JhY7M3oy/5zssoFPQdOXQtf0rNtHibpPRlaebvU3KkcYo71Jz+NX2sII6ZdZfu088q/
 R8qX9/xU2b2PSkrTRIRxWg3JK7f1sQwzIwnI8Ud96K+s7k9dAcKPhiASNbnr3lXswo42
 ZbPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXidIcVlVZelJ8gNj+LCqsW68mhK0M4xPWPVsPFDN1JlsJa2tjewcTYfy8jHma2DZuJ65Kjn3L1AZdJ@nongnu.org
X-Gm-Message-State: AOJu0Yz8Z9i7VZiI0zUDxHW/G9zDhyGbZtfoAn3zlSc01bcj9z/Ny9pU
 bo21YnuBIhUhidbUQXHrsecDThSHHgqisVR+w+Jbw30/MwjSNMR9GeiAWlHonAA8pig0UY6w70n
 6cIk2XBtvuY8iuEAHpmKUE0HXbPzNQXoaJKkL1zRc0fAB2WCpy788iEWzv/Mh1JcHP0mjGXbAa0
 cuWhMwa+3Ro+wpc3fSv+eIwiB0Vvi5NCc=
X-Gm-Gg: ASbGncvOQydckKH/5iaJdwolt3u0DABxjmGJQ1pWrZfi/ZWGOFIGi0RRBJ9zIzvZ6iQ
 TxA1uDb8LxsvNGtq4tS/vDI5BFs97mBbiirSfkY883LnhyejePUypnUy5IQgM0n6G8nqFaLY8rL
 zgzwykNM1uQMajqwpxVR0wX3iZk1j8NDnS8oIvbpM1FX5ayAqXBgEdqg==
X-Received: by 2002:a05:6102:e0d:b0:5b2:d28a:8937 with SMTP id
 ada2fe7eead31-5ddb213171emr744980137.12.1762499545956; 
 Thu, 06 Nov 2025 23:12:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmWAd4WcD1DibJR73Bn7iCeJBo/fLwMHvE3lNTOzT9+Hyuop6CWOFRItkkJAyBMKDEKARJ8vqW7V6E0YGInN8=
X-Received: by 2002:a05:6102:e0d:b0:5b2:d28a:8937 with SMTP id
 ada2fe7eead31-5ddb213171emr744978137.12.1762499545620; Thu, 06 Nov 2025
 23:12:25 -0800 (PST)
MIME-Version: 1.0
References: <20251107070723.7491-1-wafer@jaguarmicro.com>
In-Reply-To: <20251107070723.7491-1-wafer@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 7 Nov 2025 15:12:12 +0800
X-Gm-Features: AWmQ_blrMeR_McymElwZ8VSrBtlmNMZCEM69BbTunZXX6QfFocp7UeQvHqNr74M
Message-ID: <CACGkMEsBUUWGuAvECdhMccfxPxXDOherXSBfPPt4bn3=dV3UQg@mail.gmail.com>
Subject: Re: [PATCH v3] vdpa: fix vhost-vdpa suspended state not be shared
To: Wafer Xie <wafer@jaguarmicro.com>
Cc: eperezma@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 angus.chen@jaguarmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Nov 7, 2025 at 3:08=E2=80=AFPM Wafer Xie <wafer@jaguarmicro.com> wr=
ote:
>
> When stopping a vhost-vdpa device, only the first queue pair is marked as=
 suspended,
> while the remaining queues are not updated to the suspended state.
> As a result, when stopping a multi-queue vhost-vdpa device,
> the following error message will be printed.
>
> qemu-system-x86_64:vhost VQ 2 ring restore failed: -1: Operation not perm=
itted (1)
>
> qemu-system-x86_64:vhost VQ 3 ring restore failed: -1: Operation not perm=
itted (1)
>
> So move v->suspended to v->shared, and then all the vhost_vdpa devices ca=
nnot
> have different suspended states.
>
> Fixes: 0bb302a9960a ("vdpa: add vhost_vdpa_suspend")
>
> Suggested-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Wafer Xie <wafer@jaguarmicro.com>
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


