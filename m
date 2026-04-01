Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A150C10F92EC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 02:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7l8y-0008Tg-5I; Tue, 31 Mar 2026 22:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1w7l8r-0008PV-LF
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 22:17:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1w7l8p-0003je-Rv
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 22:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775009830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YF3JIvzUo5QVkkojcL2L+ODK6UD1MeDnao28KHcLWaY=;
 b=WmfM2/WKjFlv/D0IAu5vIZXH81ski3tGb2OC/xJZ7OPHzjylDpCnQHcPbF0zeBYIaQAY1/
 Nzbbf/oXQlj2QODyi909jY6/0/AUoBAk17aXoVzFAzE9V09ixwmbpNpIW4FlNnJAnXK6WH
 Ax0u4c9ZB5KT9COzjNOFnEaXDpmwk6U=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-BgWTWxf6NG27HYlObYGm8w-1; Tue, 31 Mar 2026 22:17:09 -0400
X-MC-Unique: BgWTWxf6NG27HYlObYGm8w-1
X-Mimecast-MFC-AGG-ID: BgWTWxf6NG27HYlObYGm8w_1775009828
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b2471321dcso126862625ad.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 19:17:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775009828; cv=none;
 d=google.com; s=arc-20240605;
 b=XibBXY/YMb37GYmFilw0/5R89ChkmwjtN86Hldm/Uxi5Ah385rV9HPK/xB3cE3eeXV
 0TI7gwtAmneI3qmdBQQj/Sio0L1byaJWdHV73ekwVWGZoKGNHhr2s3kvSbuIVslEWtk9
 a+0DQjppErUSG4FWe/saI3fP4GWJY2RF0GnwPkhuu4Cr2tx66HhBX4TWpZCluzZ78NFC
 kK3V82LfdTbIBX2H7FC4oXfdq27WggIJgrj2apuHqTYE/e8ZmBqN5GgZRcEuHD9BYeIG
 Yz2BVgHEsQlA5DguI5DdebR0cWUCmN8IpM46XgQEwL07trhfAZI3CFCnLHbXJg9ozbH6
 edkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YF3JIvzUo5QVkkojcL2L+ODK6UD1MeDnao28KHcLWaY=;
 fh=9BXtxKVnQ/q4dHsoWoSKzCM7qvuXLTO9zm/fM+B6Gjw=;
 b=AQ6OowiiIczF2rfzrJ8Wtawv83C7Zwc4Wozi49xUatWZakGc4eeuF8kXRMc+UTsBoZ
 Nc42UQjioadfa2r2QPWIQeKnnL1TQCkQu42rFRTTqR/TNoHjytkf2aIW3gwW1VP/TbEd
 8CfmNvfIGNZfFXyrVQPDX6pfWu9de514cMg1eGQd5KYaKIgV7TXEE8qrf/dxhMvjxqdK
 ZYL6JbI1PvtOYenKYcYUtkaDyYWePchHDT9Vdw2+1uIX4EukKhxJL4GZ0a+xgqlD4s9G
 nCv2IYnmsBRJ3SxAb7KAY3HI31hl6R7PZaIFvXFiE8OKrsZ6WmONRTXT4HHeljLI39EC
 O5dg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775009828; x=1775614628; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YF3JIvzUo5QVkkojcL2L+ODK6UD1MeDnao28KHcLWaY=;
 b=sMCVMZBoNekQAs3zdAENbjpyZy/Ifil565BvGBrltRYNZ/bs/Nu8LXxfieMnjjoulB
 FaZyPJBnZ7OlqnnL+ZUWuBoaORjm21kXdqcT5CmVV1r13Z4YJT/3xL0PXpEuRHRxnb6k
 DC1qhuhLRviiKWdHwp2FSLafZ789CusUfFyNgs1QURwvHq3PrJaKrrA8TNJK7oO7tVg5
 ArrnLE6u7jpOkLTwPlPMSgaWeuxf9zC+IcB9aQVmVfrNePxc2GgUuzbQxWvutVN2VavN
 gI/qsuuTNpp/4dgPdoUd0ktga70neW1Gnru/PdbPMF0Q34YIdEOqneP3lYf/rbqHZVCq
 19BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775009828; x=1775614628;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YF3JIvzUo5QVkkojcL2L+ODK6UD1MeDnao28KHcLWaY=;
 b=UmqHyyl3tdPhMlFZiTK+MpzWvmbfwm4bcsm9diFC6ASgsGyjPu5z8NKPzXFPlFYMXj
 LexZR0hRYEEnzc5zKyGqWVOaEfyX9CCm6GAOGa0MLo/Zt/KHEH5t5WSfEefG+GDEIu4Q
 sts14ZLi3bKDp4dT1j/u0JtliylqI3gpbaFCWSjG5aPebb/7QHEEBdadfIkBxwbp1fW9
 nWVmPcLYTSfDVBsOj6wx0kAaEEeUTm6u4n+QHCx84MKGxy2g1bX4e9u4xFEprKPmPVOV
 llXbXwGjZ1ejcMm7btCRRyW0Hh5GQBouUGZFJAEcfiCoxqQILeNMtNXs2zzZJMHRpqfo
 +pqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyhcMhpM2GD0BY5pLvODh3Z+hYPlLEqYcPk30L+gFfoW+jRwPcXOQaqFW5IZdJ+y6wKeQ3iBCRJLRx@nongnu.org
X-Gm-Message-State: AOJu0Ywpph0Zb6Vg+byzebIR11hG70KSPpibx6C3cRG7ZMNYkWBi82Nl
 +QRyoAFvWCII9YiVm+kmDJ0mRDhLiZDaHAHd6XhqjoAhhBgJb7qTatGMTN0HV02miH6SgBqauKG
 Wyxkx/njuo/jonpXvYryECe93KsJW4iWwl+zB+ehLXwWRQr4RHfXOx9V5/rRT+yvFPYRFMT+a2I
 S9XsmgzPvTdEjlllRn05O/3IJUjJHH0EE=
X-Gm-Gg: ATEYQzzOJyGrLdn8SIQfV5bj5mHgaeVmWYVka3EuU7gt8UL26EF0m+oOJV5yjsbhQaB
 oPWqmNY+f6LY/Qq1HZCATl5q7hRxS+roTS0z1ME18zj35/dvZQdqF+k99apGd117gbOR9V02nqS
 saBDdO5dA8ixMzv3Q9paheU/SyDciRI2E2mThp12N/11fmaOYLOXsUDMzEp3+jwsQpOtXt3oe3N
 2WRsxA=
X-Received: by 2002:a05:6a20:3947:b0:39b:dc44:eceb with SMTP id
 adf61e73a8af0-39ef770a09dmr1664604637.42.1775009828340; 
 Tue, 31 Mar 2026 19:17:08 -0700 (PDT)
X-Received: by 2002:a05:6a20:3947:b0:39b:dc44:eceb with SMTP id
 adf61e73a8af0-39ef770a09dmr1664580637.42.1775009827882; Tue, 31 Mar 2026
 19:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260330090944.1008027-1-lulu@redhat.com>
 <20260330090944.1008027-4-lulu@redhat.com>
In-Reply-To: <20260330090944.1008027-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 1 Apr 2026 10:16:56 +0800
X-Gm-Features: AQROBzBIIpYwIw1xd81yHB0kLvfJFyzh8co5uRSuHyhUgYX7ZQGty2pmhR23Pes
Message-ID: <CACGkMEv=dPRP=pRifudphK8par7VX=JA8Xj5XA-v4ym7doXa0Q@mail.gmail.com>
Subject: Re: [RFC v3 3/7] net/filter-redirector: add AF_PACKET netdev setup
 helpers
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, zhangckid@gmail.com, lizhijian@fujitsu.com, 
 jmarcin@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 30, 2026 at 5:10=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Prepare filter-redirector for direct TAP access through AF_PACKET sockets=
.
>
> Add the setup-side plumbing needed by later capture/inject changes:
> - extend MirrorState with dedicated AF_PACKET fds and a capture buffer
> - resolve the TAP ifname from the backend fd
> - create and bind a nonblocking AF_PACKET socket on that interface
> - store the socket as the capture or inject endpoint based on the
>   redirector role
> - clean up the AF_PACKET resources from cleanup/finalize paths
>
> This commit only prepares the sockets and object state.  The actual
> capture and inject datapaths are added by follow-up commits.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

I think I have the same question as version 1, could we simply reuse

1) netdev socket
or
2) chardev

for packet socket instead of having this?

Thanks


