Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294C7C83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 09:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufEm5-0002Yk-6k; Fri, 25 Jul 2025 05:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1ufElu-0002Vj-PE
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:31:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1ufElr-0003Xv-Et
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753435876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xdJR03+6vmW7dLiuQ0jADDl3N4/4pkTzYi5yocmoVG0=;
 b=cRsV1eypAmxqSAH5Mt0Jnht2LU/OQgmEyCTCMqMZs1AnqlnTVkIJMAgLf0cwJQifjZYfvy
 nJkHalxyEtFNXDzRR+8XRVwu5hxJFF90rgLCs5jAM1F2kVqR7dWRG5QbpRnD2y1iRIFyBU
 ykcPDNBslAwWS6+4G8kcZXVEOwG8tWI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-7W-eYJ7xMfyGd41Tx0cbMg-1; Fri, 25 Jul 2025 05:31:14 -0400
X-MC-Unique: 7W-eYJ7xMfyGd41Tx0cbMg-1
X-Mimecast-MFC-AGG-ID: 7W-eYJ7xMfyGd41Tx0cbMg_1753435873
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ae9cd38721aso173980866b.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 02:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753435873; x=1754040673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xdJR03+6vmW7dLiuQ0jADDl3N4/4pkTzYi5yocmoVG0=;
 b=IAa+ZGKwOolG0bI529/mxhmb/QvSn0DmcgomQgmYNDgr6HQEpjOAlQ/A75UxO9l2ns
 Eo7nSJqicyq+BUnghkZ3suhsqfAXhK9CquHA6OuS6P0UtyWpJWapqXtIO8+Nm3mfIi4V
 yatr47tgRW4Acv9nWwc7D7BNoI+eRJj/s0STywItSph6HEb1NtPbeHj7P7tfEKr+/JQq
 sA5M31fy+BJp9buGzPzwZ44zo/ztzNLbUJcsQh3oJxzi5MTnpVFkoAca6PZxr3uYTC7+
 YfndMCYxQ+6Ns92f45AmSzH7QpeWWhyAXeUBPPfwCKkIncbZmcgG1dEw6WZMEREWzayI
 bL3w==
X-Gm-Message-State: AOJu0Yx5tzLYx0h3T//Rn3I8KwTJTXHBl05caXkwkzNkIhMZPy/ONSyv
 8GfBWuPlb6RRXrgITrABatpuPpn+ywmQFqD/8Rrced/6lgtWZpzdlTKh6raya2bGnQi9Ip2IqC6
 eMiBaonQckAUZobdDyjrGzVEHmiVyd/+0a9LDJ0wzD1JFQT4BTNmktbJVzEIU55lxRjgNDo0Bcq
 zvgGgozo7ObGb8XrAHq6t5rPWyJ7TIxbg=
X-Gm-Gg: ASbGncsmQDcI2oAJqs98eRHAgaxEp1S9dDSc69vaxQmRmnI4Z+aRvvlT/BUFyuIFZJ1
 2FI2uiHkm2R1vNibrdfMWwEn1rzbeaPne2N69OZ3/nZMb+SqM9wgl7tNlPYGSvRIBaCJ1j6+/CS
 nWQZO/6MRLAhj2SAATa2SW/A==
X-Received: by 2002:a17:907:c1f:b0:af2:b9b5:1c06 with SMTP id
 a640c23a62f3a-af61c8aa24fmr135234166b.14.1753435872957; 
 Fri, 25 Jul 2025 02:31:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPHAxLYvw1bnRIc7gerZjv2Uw7xhF3p0qyiCW8gfT8nkoXjpmsubxCrY6zBr0QH1j8NmBHetqlrbJZXnNt8qM=
X-Received: by 2002:a17:907:c1f:b0:af2:b9b5:1c06 with SMTP id
 a640c23a62f3a-af61c8aa24fmr135230766b.14.1753435872559; Fri, 25 Jul 2025
 02:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250724125928.61045-1-hreitz@redhat.com>
In-Reply-To: <20250724125928.61045-1-hreitz@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 25 Jul 2025 17:30:36 +0800
X-Gm-Features: Ac12FXzuDstt968WBww2w7gkb8V_UlOJAwlUo5yRNdEUFJ_CBIga153krsHg4w8
Message-ID: <CAPpAL=whSGf12R8=hxW+SdNWZZLVKqH2duR1838mGUNHFNeQGg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Do not abort on log-start/stop errors
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
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

Tested this series of patches with vhost-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Jul 24, 2025 at 9:01=E2=80=AFPM Hanna Czenczek <hreitz@redhat.com> =
wrote:
>
> Hi,
>
> vhost_log_global_start() and vhost_log_global_stop() abort the whole
> qemu process on error.  Not least because vhost devices are generally
> outside of qemu (i.e. use a foreign code base), that is not great, as we
> can basically be forced to abort because of bugs (or maybe even properly
> behaving, just unexpectedly so) in other code bases.
>
> In case of vhost_log_global_start(), the solution is simple: Ever since
> commit 3688fec8923 ("memory: Add Error** argument to .log_global_start()
> handler"), it can just return proper errors, so do that instead of
> aborting.
>
> In case of vhost_log_global_stop(), we cannot return errors; but we can
> just ignore them.  In the worst case, some other process will keep
> logging into shared memory we have already unmapped.  That's fine.
>
>
> Hanna Czenczek (2):
>   vhost: Do not abort on log-start error
>   vhost: Do not abort on log-stop error
>
>  hw/virtio/vhost.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> --
> 2.50.1
>
>


