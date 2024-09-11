Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F177EE49BC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soPK3-0003Wd-MP; Wed, 11 Sep 2024 11:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soPK1-0003MA-Ab
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:31:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soPJz-0003Zq-Kq
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726068713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CaMQdbefYuizmguUTnOZIRMqjWntIqA7fbV30r6lE5g=;
 b=A2NAO8anmUWkLz9XCuLvxOoldWS/3VnnysuGOjyPTDRcsnB4BimdBtT7sad6wtW7KZIrXj
 GL0x3UjXhVnFXLXlCNbO5rfPnWiZN9Jb/VcPDT9Ak0C70FUEimOHob+Oqh0+5dSYk0wWzI
 QF9saR+Sv7htynEwhg5faAVOzNGj2CQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-npRKtdJjMxml1dyD-aHZCg-1; Wed, 11 Sep 2024 11:31:52 -0400
X-MC-Unique: npRKtdJjMxml1dyD-aHZCg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-374c79bf194so2695f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 08:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726068711; x=1726673511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CaMQdbefYuizmguUTnOZIRMqjWntIqA7fbV30r6lE5g=;
 b=sSvOL00FXbCZDOCyfBpLGUMEfWS89SO76SoPoHIb1/GOaEhiQoR5uKb9XVCgIQmcu1
 NK1u32oCcZO3qHIil7Z0OshHQo484Ys8J+KcZM6yRXt/4F0Hgl33Cc/nET0Pp8qD6zza
 xwvxnB1UAKHZp5rdyDbP64mfmDIv2Qw+2f5SEVmkLs7OjWLKp72T/WIrd0UbPY7x/eA0
 EF0GPYHFc9MfOQlr8MEqEYjeQvqtxoOuVKJgYY+J1zHKITQ6yfLLhes0T8/6GftGSYVT
 3eaC0Ltin0Uw2TG6SbgL8eIlGh1Z9w3a0LdsO6AxRBSMhBE/XfNyKC52MiDgRcDZZTx8
 0fWw==
X-Gm-Message-State: AOJu0YwHObzImBOby5XCciJ2E5HR0Z9ZFvhsQ72lXatpANRwO1ghB7q2
 tS4famjLlTuh73EfqFuBBg/c+REZrzuYx0bzLJAkQTX5rgDKRJ3ck6c0mbEAqSc12nOxPMoJKUM
 +wZc97+c+3CDKOoUb/2qUvEpKidJVrYQokkEM6cSG04vrHd9JPeNPV2bUtqy5fbTEHOjytnwMSN
 QT9ub2tziicn7QMNMlucco7W0HnhE=
X-Received: by 2002:a5d:4907:0:b0:377:284d:9946 with SMTP id
 ffacd0b85a97d-378b07c8664mr2369470f8f.30.1726068711067; 
 Wed, 11 Sep 2024 08:31:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHRfWF527FeYHCddt1n05EtBH4zERIxG7Q+1uWrFATnZ7iBPf5Xy8s2QGZKAICJaBGcD9BwI0E30ZqZrUwsz0=
X-Received: by 2002:a5d:4907:0:b0:377:284d:9946 with SMTP id
 ffacd0b85a97d-378b07c8664mr2369455f8f.30.1726068710582; Wed, 11 Sep 2024
 08:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240911123342.339482-1-pbonzini@redhat.com>
 <20240911123342.339482-17-pbonzini@redhat.com>
 <9698518.P2rk1vUAfu@silver>
In-Reply-To: <9698518.P2rk1vUAfu@silver>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Sep 2024 17:31:39 +0200
Message-ID: <CABgObfYroV9a78OBGCXYo0KivCHcCT4VK12A3b_HuT63Wn9VMA@mail.gmail.com>
Subject: Re: [PULL 16/17] virtio-9p: remove virtfs-proxy-helper
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Wed, Sep 11, 2024 at 2:57=E2=80=AFPM Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> On Wednesday, September 11, 2024 2:33:41 PM CEST Paolo Bonzini wrote:
> > It has been deprecated since 8.1; remove it and suggest using permissio=
n mapping
> > or virtiofsd.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
>
> Just wondering Paolo, you received Greg's and my emails on this patch?

Hmm, yes I did but I missed it. I'll send a v2 of the pull request.

Paolo


