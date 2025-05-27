Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E49C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 13:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJtuS-0004D1-EP; Tue, 27 May 2025 09:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uJtuJ-0004Bi-JB
 for qemu-devel@nongnu.org; Tue, 27 May 2025 08:59:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uJtuA-0004H4-Vr
 for qemu-devel@nongnu.org; Tue, 27 May 2025 08:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748350779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tHP+79d/DV77sMVtEEjtWziCBjpMknkpjcNFa9waqTs=;
 b=XYs9stjeLwcDAt1hoCHoI9IEE5YNpeg9oI9nulZzAWIVNeNU+dW5byx6mloChUD72/aIkq
 Hwvq4tfgGVNuQBcjv2lgyLiC1ekojrU3nFuHHOn8R8eULwZtdM0vFwpJ43rn5nDa0dj0hk
 X1YBp5Zgox12eynxEzTxQ2BslKE1Elg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-aHifZdv0NCWjLiZj0Nm4zg-1; Tue, 27 May 2025 08:59:37 -0400
X-MC-Unique: aHifZdv0NCWjLiZj0Nm4zg-1
X-Mimecast-MFC-AGG-ID: aHifZdv0NCWjLiZj0Nm4zg_1748350777
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43ceeaf1524so15553725e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 05:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748350776; x=1748955576;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tHP+79d/DV77sMVtEEjtWziCBjpMknkpjcNFa9waqTs=;
 b=UGhLtRmPJs2MhmqFjXt2uZ8dy98fApz6/N+r3WmTtlJFzh1CQNV42PHhmSSV8g9sY3
 n8xNegzSG5OrNAq2/Qpu57o8+fvPkriOSfjnkor1cTxFFyPBWaAXy25lCW9Q/A6gvkfb
 chS4nWAk2cCc1TykrmAZdkMK5TKCWFYYBcK4aJHXz27ujbXQphPl1j7QJqGSEps7gjdi
 43MWjx6dH27k79CCflc7QJ1jEiRCr1mVAzrojcMeSSw680Jgohgtj0MxtUgs3kaXrvNm
 GCpeIl/7mQByW+cZO+ofIdZMPFvd0oHvPYl5c05Z3AqcyPqzhsTfQB3Xaq1+hZDlchIJ
 UoUQ==
X-Gm-Message-State: AOJu0YzrvveU0TwSGnnXvNhRgOghdwULhFS+CS+0ydT4Ki3O9tGLSfoD
 ZtenMMmQzfjS0p0Ixo2XDo2FpSM/3+2aDHC6ku6k+KunCsG70x9u2Qua2EzsPQ8R02gDbhOm857
 8hWowhnjkgQNBrTHCm/q/v2BQVV3ks+/DJAJlOhE67icyVkCfoM4p2H90
X-Gm-Gg: ASbGncvwJWcyBSOvNXLuX8NgG67NOIVtWFbk+FTDeRa+rH+x5YdXgbHD6EsJntLNb50
 LaxpNDBfmwssfmRl6AAgHA0pbwcW9PB/VFWAG+EM5DoUwL3Q/MnZ00iiG1OZi58ZeS/VxpYMFT6
 NZOji+Rw7xYqUqtp5o4vULiftdkqxVLcxilDtVd/QzkiAbssX2rtC6OifiCjTN075Cd1tdNNiCv
 3VMnNvZrY6jtmudEXkFfE8i9ZUvzfViwjqHf/grA9/EI6KqTs1Z8wZxG1bDjKFyJmkq38YCK9nl
 tBE=
X-Received: by 2002:a05:600c:1ca7:b0:442:f4a3:a2c0 with SMTP id
 5b1f17b1804b1-44fd1a621ebmr5346365e9.13.1748350776637; 
 Tue, 27 May 2025 05:59:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz3APAR5IXFmcQc/u0mMcMcUSjw81lkfs1JtIef7rgOC23rGGtZfDYymxyiCIwH2C00dq57A==
X-Received: by 2002:a05:600c:1ca7:b0:442:f4a3:a2c0 with SMTP id
 5b1f17b1804b1-44fd1a621ebmr5346135e9.13.1748350776272; 
 Tue, 27 May 2025 05:59:36 -0700 (PDT)
Received: from fedora ([2001:718:801:22b:127f:d708:eb60:538a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f38142b8sm264896315e9.30.2025.05.27.05.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 05:59:35 -0700 (PDT)
Date: Tue, 27 May 2025 14:59:33 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v5 1/6] io: Fix partial struct copy in
 qio_dns_resolver_lookup_sync_inet()
Message-ID: <i6zld5slqgcihv6nspwbl42txlq5xx3c6q6ji3eyskqqpt7xjs@joaipxpw4vgz>
References: <20250521135240.3941598-1-jmarcin@redhat.com>
 <20250521135240.3941598-2-jmarcin@redhat.com>
 <cc7ea274-cb94-451a-b31e-00f6e51a2a8c@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc7ea274-cb94-451a-b31e-00f6e51a2a8c@tls.msk.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Michael,

On 2025-05-25 20:15, Michael Tokarev wrote:
> On 21.05.2025 16:52, Juraj Marcin wrote:
> > From: Juraj Marcin <jmarcin@redhat.com>
> > 
> > Commit aec21d3175 (qapi: Add InetSocketAddress member keep-alive)
> > introduces the keep-alive flag, but this flag is not copied together
> > with other options in qio_dns_resolver_lookup_sync_inet().
> > 
> > This patch fixes this issue and also prevents future ones by copying the
> > entire structure first and only then overriding a few attributes that
> > need to be different.
> > 
> > Fixes: aec21d31756c (qapi: Add InetSocketAddress member keep-alive)
> > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> Is this a qemu-stable material?

it isn't necessary to backport it to stable.
`qio_dns_resolver_lookup_sync_inet()` is used only with server-side
sockets and the keep-alive flag¸ which is the only one not copied there,
is not supported on server-side inet sockets without other patches in
this series.

In case you went ahead and included it in your stable tree already, you
can keep it there.

Best regards,

Juraj Marcin

> 
> Thanks,
> 
> /mjt
> 


