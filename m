Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8C8FDEE3F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzoa-0002w0-9E; Thu, 23 Apr 2026 15:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wFzoX-0002vW-IE
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:34:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wFzoU-0005Xc-EL
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776972852;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GkLfao2xAgaGyUdnT/LSwmf9hfjaa+/2pnA8xvVqh2A=;
 b=bTva8HcZ/htK4tgVkSDA4oJmcR9gPu9Zsj22ubKtDGS+XF6b/vGy1MWDBlQw9+n0Mkgngp
 WHus1dYWB5k2Nt6BGJIDuSFaUAZ14GKq5RUA4KXsdgzVXZGxZeSu4dddhJ3bearL6IDRGB
 YIvQTXrm4RTumvlh7rEW8EKUAP0V14U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-ebY3KaIyN5G2MLD5fXyrtg-1; Thu, 23 Apr 2026 15:34:11 -0400
X-MC-Unique: ebY3KaIyN5G2MLD5fXyrtg-1
X-Mimecast-MFC-AGG-ID: ebY3KaIyN5G2MLD5fXyrtg_1776972850
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-486fa07f2bbso50190155e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 12:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776972850; x=1777577650; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:reply-to:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GkLfao2xAgaGyUdnT/LSwmf9hfjaa+/2pnA8xvVqh2A=;
 b=Bk8rMYlJqCzy8HcGW1kBkGL+x4h4BAWapTrdkvZrb67wCyP4jgdnrw+1HCpEZV3t14
 dOemLR3E86i6fYFd1Oi2NDFjVY/bR2rjp33xx6fIF415qvBMd4IkBl5OvSQq6Mr/4bry
 mAz4tt3ck7quoztXDekOrXFHynB+mJi0sIWckGr/MHIzOFtAhNWNN1DuJqxP5aF1KNzG
 9ecJTbM8A0UGXmS1tIUt+tvRUysIkH9SynvwWKbHyETM9V+fC1cT7raHjIKdfVUBKuvo
 MKAfs/NWRouQCiogXe/oNotOCIVNh7uxYFSSsycAtuWk3wtS0BSA+BM0YZYTAnjyp4bS
 XJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776972850; x=1777577650;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:reply-to:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GkLfao2xAgaGyUdnT/LSwmf9hfjaa+/2pnA8xvVqh2A=;
 b=bATKRCFyv8ZaXwocEZOP+aHgmow/x0qAggbR5fT2vbK0ZVxtRgi8U5TT3oUuHk/UYL
 nxdpt/A8rCnApqTKEdJIJijpT51Vg+cO8OiYv8R8ZmI9T5LT28tHWSYbt6lZX3MHho2b
 tw3ZS3q+ubRFeHshakxDLpHdwmM/Xpb03pLzcF8mv576I6eXbOvmKHNWQYP7jBTc2gcy
 l+txl0Tr9cKz0gSrNVqRNyRtME7ETekiLbYhVlCAvUqzsWkXysandeVESl2vvotkS1sK
 ft/KZMWH1Ob+uZ2zBh+6FG6zYyLNTUT287X71g7NnwEhcmUzwHMMAEr4V1Zwsd8D0/eq
 9Jow==
X-Gm-Message-State: AOJu0YwEvfAYFgC4/2rvor+bbURTl8banBc4JJ1NnyrjMI0zRd4ZaQDJ
 w4XknmHdjm+Io5HB2IB8+7FN3hqx0uvatW/eGTuUjsPMna5MFRoa6VbOk3/NlLgjJKEJDqQvnJ7
 fIXwbG8sYRUpDdY+/w+iKEEzMD9ky2Cp2vqs7fUYHDJDe5wuQ4ZRCPFov
X-Gm-Gg: AeBDievY8ffw57L3BOWAKigXuHTis2AKMQ5o9W2vZR7WUJOKoAE2HIgmtifsHXhoPtf
 VnHBbtB5z9esNAvuLosP4FWZEXnswvMZnKrDfmdAwC3660BwwO/kkd8Ed55zDy5j2RWxFZhD3m1
 f5sd4q03FpXxAhgG9te0flP2wdz/jgaHAKjcASF2HOQITorqgfg59S973MTCWpnG6ckapq5J4Bc
 myGSelPnLi4orTWlQpESjUnha7C2N3O+SqRE9mfPuBQZSmjWbEhYI5X1QNai2Eszki59eIExQQG
 7hwJchfiPWSx9kdc46FVgj8y3fuHO9klGxGpkl16aQxNyHxQ/rlEAFMHHtfuze07XRfd8DKQMaF
 CUbGwyq8/bbUtfq5BiBAD/LHNhB0nHQ==
X-Received: by 2002:a05:600c:888b:b0:488:c80c:c236 with SMTP id
 5b1f17b1804b1-488fb73d525mr338717565e9.5.1776972850094; 
 Thu, 23 Apr 2026 12:34:10 -0700 (PDT)
X-Received: by 2002:a05:600c:888b:b0:488:c80c:c236 with SMTP id
 5b1f17b1804b1-488fb73d525mr338717255e9.5.1776972849649; 
 Thu, 23 Apr 2026 12:34:09 -0700 (PDT)
Received: from redhat.com ([2a02:8012:f011:0:f1ce:ac56:d2cd:7c2e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7a06f3sm198648655e9.22.2026.04.23.12.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:34:09 -0700 (PDT)
Date: Thu, 23 Apr 2026 20:34:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Li Zhijian <lizhijian@fujitsu.com>, Fabiano Rosas <farosas@suse.de>,
 Zhang Chen <zhangckid@gmail.com>, Juraj Marcin <jmarcin@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 3/3] qio: Fix qom-list-properties crash on net listener
 object
Message-ID: <aep0Lga4YVvLWFTe@redhat.com>
References: <20260423183212.468047-1-peterx@redhat.com>
 <20260423183212.468047-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260423183212.468047-4-peterx@redhat.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 23, 2026 at 02:32:12PM -0400, Peter Xu wrote:
> The QIO net listener object will crash with raw object_new() then
> dereference the object, like what QMP command qom-list-properties would do.
> Fix it by moving mutex init into instance_init().
> 
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Link: https://lore.kernel.org/r/87a4uvw066.fsf@pond.sub.org
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  io/net-listener.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


