Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6661CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 20:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoSZD-00061p-7Q; Tue, 19 Aug 2025 16:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoSZA-0005yZ-Ey
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 16:04:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoSZ9-0003hT-0F
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 16:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755633858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xomHNblM5I4WzgqJ2lk8kqNs6YIItYB36HH3WLutV/Y=;
 b=XLZCYlzTGnjldZjGj+aek3/LIs4T9fEtdUVYwHYe62yQot8MIzlrZsR5B+uO3voxLecOrV
 XMbcdVKBlcPsFeWqFOIh0Ydh/qjv2DREX4kmChdybaHxyVf9ihNUSj8TdwJHJtfwz55/iL
 9YHXxyMkdMr1HTLfq6IESsZy9oicKyA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-MPog7P63NZqs_RXRZ6Wfiw-1; Tue, 19 Aug 2025 16:04:16 -0400
X-MC-Unique: MPog7P63NZqs_RXRZ6Wfiw-1
X-Mimecast-MFC-AGG-ID: MPog7P63NZqs_RXRZ6Wfiw_1755633855
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2445806eab4so59750825ad.1
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 13:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755633855; x=1756238655;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xomHNblM5I4WzgqJ2lk8kqNs6YIItYB36HH3WLutV/Y=;
 b=wtcAMyKepfkSsx6RelA6EHX3i0TftZlXusojlQsNaRq8lTzlP7kL9p4qxXJeoLldCb
 jzMkaYh49mlGPlppvD7vyyv3d+JQCwDRCFXY2bvyymgnH9H0SeZ1HzEMPkPZioRWxuaI
 fdTfjLgdBH1ZhHAZFnYzsy3NwryOFjwy5Czrup97isClDS10LhN5PjKq/oCjACK7z5kX
 yQ28sG7KXdjF1FBY36k/vXrFLF+VW+F4qqA0uUBNqJkWTZSQ+oZJh41Gfn+IPy7qH5Iv
 TdVWIoeRXqgWO7t+t6tk4vkv+44ay65szmhtFCLuHVuTvKVcSKRRAf1zY9HOnZU2ZLzW
 N7Lw==
X-Gm-Message-State: AOJu0YxMRLgbrZrbHJ3eFna6Xusnr+EMpaJfZ6YOI4kM/P0C13hxfAZq
 fTEdfxC6+n7zUj/iMmiHK0m203W3vMapzqs299enW8G6alnTBZKfAYLBLfbmDDq+U9OsdZxSesW
 TpfNW3hLw9X13dbDjF53UgcNFnu6Ho6wZE9jUEe65Sv0KDh0f+wgcFSjdnC59rCJpWzWFV5s3qR
 ltjf1h9811GMHuaXsVFrTxR40D/Eo+T5k=
X-Gm-Gg: ASbGncsXU35VHJmGFQpAPJwZg/Xt7XqjfPFSPAwZpfKHo5li1jXhS3+AXSSx2c/1nN9
 DkKkUYR0Iq+wq5On0xWW76hnzsiV5CoO5fN7G1a+d0zhKy987/Rb+X3hKX+vELCkeIP9+XDFp7A
 Ae8T6i0w7qzbXtn34fBNbEkwUn3M1i0gA0Vbpx7BDQV1XuMA6fwITV
X-Received: by 2002:a17:903:2342:b0:240:468c:83e7 with SMTP id
 d9443c01a7336-245ef10425emr2881225ad.3.1755633855377; 
 Tue, 19 Aug 2025 13:04:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu4YnCvOOeYV4CQISeuvlbMwdY2fh4VTrL/lpE+b9E47YZJa+JARxokKnZXh0CVvWiC6E9kgDbEhdL0Me41Q0=
X-Received: by 2002:a17:903:2342:b0:240:468c:83e7 with SMTP id
 d9443c01a7336-245ef10425emr2880875ad.3.1755633855008; Tue, 19 Aug 2025
 13:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250715143023.1851000-1-berrange@redhat.com>
 <20250715143023.1851000-8-berrange@redhat.com>
In-Reply-To: <20250715143023.1851000-8-berrange@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 19 Aug 2025 16:04:03 -0400
X-Gm-Features: Ac12FXx0MAfgjSL3-jKBXzN300C9q_UZwJBLf1y7rLvlkRCOjztdFwHQj5YC4vM
Message-ID: <CAFn=p-ad+Bv7-LUUOn_YdZF9qhW_OyHku+HRc7P=WgorSqVv9w@mail.gmail.com>
Subject: Re: [PATCH 07/14] iotests: drop compat for old version context manager
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Thomas Huth <thuth@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 15, 2025 at 10:31=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> Our minimum python is now 3.9, so back compat with prior
> python versions is no longer required.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>


