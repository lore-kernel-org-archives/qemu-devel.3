Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B6EC3601E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 02:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1bw5-0005TK-Ld; Sun, 06 Apr 2025 22:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1u1bvr-0005Sl-9p
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 22:09:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1u1bvp-00072N-FI
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 22:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743991787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RUXcWeUng/hGlbEM3cQ11vIzc8yuo14l+iA895elNUs=;
 b=Z03/Bpnmde93xDV8DLIJK6PSrayCFZ3uGs5/SQivUjbyy9Huo7Oi6LSamgd1r+rzAuc2bj
 PCfSuuRbaAe1tzw7Af6tsDhP1k8eBArtgsMiamYf+D5/ZCYFArJdJYQtU0zn82ik6vNLvM
 NX81YesTtChhVXv3pxO/xdc5pZjozXQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-hJ-ck1D8OVqxKEbnzyk1VQ-1; Sun, 06 Apr 2025 22:09:44 -0400
X-MC-Unique: hJ-ck1D8OVqxKEbnzyk1VQ-1
X-Mimecast-MFC-AGG-ID: hJ-ck1D8OVqxKEbnzyk1VQ_1743991784
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-224191d9228so46818535ad.3
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 19:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743991784; x=1744596584;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RUXcWeUng/hGlbEM3cQ11vIzc8yuo14l+iA895elNUs=;
 b=ijcdjLR2Yafdd5k8RYO53G8I5qnBuf6S97C+5fsUqTdWaGqvtdSHjWy4Kw7Sol4/jp
 DabLFOPeJa/IJHR2NMV1GDLBLk2LN0A7hM7Bz49V/4LjWnDZhn+oEdJYHiN9sJapWWtW
 GisoU7cNi4AlMzZT2DKnWktn8NZUAabD+r4ILKCKaLPzIrAi6ClgdR136GJ5+eGn7cWq
 TOWfNlg/359IfWAKgKqVmwQcNf5Yiib66RSWA7RYq+mOJH+GJf+euUa7weUicfI0OMUv
 YE8xFqIi+d2j1OklWhLx5bT2drn2yODhDIz9UkoFPSIn71QxWzftLoKlEn48LnmWHSdi
 YLAw==
X-Gm-Message-State: AOJu0YzBRMjGDLyuWKkWVABYLKajIRC7BoEKXiaRW0xprdBLttsLJ49b
 iQfvmnVYN2iSFwa4yx7L1QnzfS7xODuSP2D77/tTmBd+JF+1XCmYIz50ekUNyv4ljyJ2K/kw49s
 MtXMN62pYLmX7hJJO0uhzVpzNq3UrQIEVSypcS3zLKCg242e0QtK5UxDIGuQxFwr2PPpTOD3RxO
 mcpMSYbDrVROwikAzWvppDKbxDYDc=
X-Gm-Gg: ASbGncu1SeYqUjOz4vjftr1uNueHNmx2bb6HRzKG1XY6S+kIrMDWZ21phh6kEnbdrxa
 +42sSlgwg2Yj0XijejM+Xj0NlFcS0jJip3qyxcrwrwwhJI8+RGspGobEOZ5ZwinbpBEg4yg==
X-Received: by 2002:a17:903:41d2:b0:223:668d:eba9 with SMTP id
 d9443c01a7336-22a8a84af74mr129133395ad.10.1743991783836; 
 Sun, 06 Apr 2025 19:09:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbsP5/Gi33wPz4mosyS1W6xOAkwuM4GdNz5EIZdS00/lTFInImZ/sioZK6WZHzPW0r08ZLmi79+9Q6jZvox7w=
X-Received: by 2002:a17:903:41d2:b0:223:668d:eba9 with SMTP id
 d9443c01a7336-22a8a84af74mr129133135ad.10.1743991783481; Sun, 06 Apr 2025
 19:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250405-mtu-v1-1-08c5910fa6fd@daynix.com>
In-Reply-To: <20250405-mtu-v1-1-08c5910fa6fd@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 7 Apr 2025 10:09:32 +0800
X-Gm-Features: ATxdqUETg5LcVSdw55XnjUKe75DKTJrwRSJY06QagFKpoJ9t4gyYWs9R88GOYQ8
Message-ID: <CACGkMEtLno7e6WVWAAoQnF-HpP18Q6TTEN3BxFqcBDS9x0m=cw@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: Copy all for dhclient workaround
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Antoine Damhet <adamhet@scaleway.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, devel@daynix.com, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sat, Apr 5, 2025 at 4:04=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> The goal of commit 7987d2be5a8b ("virtio-net: Copy received header to
> buffer") was to remove the need to patch the (const) input buffer with a
> recomputed UDP checksum by copying headers to a RW region and inject the
> checksum there. The patch computed the checksum only from the header
> fields (missing the rest of the payload) producing an invalid one
> and making guests fail to acquire a DHCP lease.
>
> Fix the issue by copying the entire packet instead of only copying the
> headers.
>
> Fixes: 7987d2be5a8b ("virtio-net: Copy received header to buffer")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2727
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> This patch aims to resolves the issue the following one also does:
> https://lore.kernel.org/qemu-devel/20250404151835.328368-1-adamhet@scalew=
ay.com
>
> The difference from the mentioned patch is that this patch also
> preserves that the original intent of regressing change, which is to
> remove the need to patch the (const) input buffer with a recomputed UDP
> checksum.
>
> To Antoine Damhet:
> I confirmed that DHCP is currently not working and this patch fixes the
> issue, but I would appreciate if you also confirm the fix as I already
> have done testing badly for the regressing patch.

Considering we are about to release, I'd prefer to do the reverting
first and refine on the next version.

Thanks


