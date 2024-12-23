Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B80EE7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 17:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPmSN-0001vS-QY; Mon, 23 Dec 2024 12:43:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tPmSK-0001qV-4s
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 12:43:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tPmSH-0004w0-Ly
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 12:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734975774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+LU58GtoA99nwgASryW5US6n0Mb5IIJKSqGQjhffTe0=;
 b=Qva3QxblMiT/1VtTsHOagPh1AcK0fNp8fR7adeNL8QoQX9AscJwAvdz2wD1ploWwvUxDcL
 0DOFNe16MQq8KqCeAx+NpZOhOpqMLL046V/GZryHIHoTd7T8r9aX8gg6v6fBxKkY7/3PQz
 ip0GiyLj8l1M/SUWxZu+prVNc7HQBuo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-2RCbM_97N92U9rqLmUPLVQ-1; Mon, 23 Dec 2024 12:42:52 -0500
X-MC-Unique: 2RCbM_97N92U9rqLmUPLVQ-1
X-Mimecast-MFC-AGG-ID: 2RCbM_97N92U9rqLmUPLVQ
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b6ee0af16dso684477085a.3
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2024 09:42:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734975772; x=1735580572;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+LU58GtoA99nwgASryW5US6n0Mb5IIJKSqGQjhffTe0=;
 b=YuUpx3Prh/+NSYXKtpp5z2Xl+oq0kHwWY82bwa+uVYPMXqyA7Xq5T/McGZULbceJc/
 mLriRkX+zS9QPchHng1bKc7lm4KSGOgbELKKyorgqYDVzesKZi2Md/w7pL9Z7E8IrxmZ
 L69GsbrgUJCaHyixDoZMhD7jftaOD3/0idqEzGd5+uiMQpQSg+Fp82cENqkD9ymWb9gb
 N8zCMhizi7kKe/I5PDKKSBWdATJtaCEW/fkp7Fl5+zAlMmByQ0y5Tq4Ixk7Zrd6njmWm
 iDOtruNnQZl8lFXf+UmAtI5Q9JtKCCjuOaL6x18RuNiNEQ9p7evYyr5UdsOjNftSzRCO
 c2vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7uxLiIlWYV9ANRdmp4esH719swS8lgQFhZ7frJIdE6BaaWohiExTNzp8dAg7TzCKxWbK4ke+qJI45@nongnu.org
X-Gm-Message-State: AOJu0YztqBldBc7/4E/z3imjl8Qb5Jzil6mDTaOTGjCPCEP4OUCvlzxv
 WUyCbAJG2LkP6rDn65mH8deru9jtOQZ4v2/aI10Oi0q5PcVd+O2l03hkDpeB/NKk/CDt9ibIaqJ
 pugpCwc4XpqXsMS1l8ALXlDfLWP3ECeLEJn44Yks9MpqMpNKlcegO
X-Gm-Gg: ASbGnct6pYU3LA0m8p96YoNTlKjO94+bnfx6X78AZOPvt6W6qraYdS132spljwoBcU+
 vPpdpFjsW8NGWAYdZO9RKxwMv73TFRlTlgF4NEjfu7Npr9i6gLFSO/1aNuNifrR6gabuxUivZiT
 Z9ZLspOkz5NPeGKeWA4omZX8rArX9zAQ5GOz6k0K3luEWfaZsWBDnsbNdZ6U/VBM2CICTz6H3uy
 PFgcO52iellqii2JqSIq8X4eKQWv/5y0IhYtzAn1C9P4ffIPRyQtgX6L85CnRX8N1hNYi9v6Tsp
 wFEjCN1c03FJiiMAYw==
X-Received: by 2002:a05:620a:240c:b0:7b6:d88e:f187 with SMTP id
 af79cd13be357-7b9ba7b0884mr1939814185a.35.1734975772229; 
 Mon, 23 Dec 2024 09:42:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfn4h3dDoktm/X4aHRJFIVWTB7m8Z/mcpvVKY0XnlXxKSkXAdAMLkFE1NMdlAEvA4y3kta8g==
X-Received: by 2002:a05:620a:240c:b0:7b6:d88e:f187 with SMTP id
 af79cd13be357-7b9ba7b0884mr1939811185a.35.1734975771874; 
 Mon, 23 Dec 2024 09:42:51 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac2bc1d4sm401081785a.9.2024.12.23.09.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2024 09:42:51 -0800 (PST)
Date: Mon, 23 Dec 2024 12:42:48 -0500
From: Peter Xu <peterx@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Eric Blake <eblake@redhat.com>, Stefan Fritsch <sf@sfritsch.de>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH] dma-helpers: Fix iovec alignment
Message-ID: <Z2mhGN3XDaIXFibM@x1n>
References: <20240412080617.1299883-1-sf@sfritsch.de>
 <dnqsifhslb7mtidrzadsz6254ykmb4bjz2cenzryonz7wbjz4g@vj56wcuwgx25>
 <952a7275-7164-403c-beed-fb13386e65d8@tls.msk.ru>
 <3fd9f735-6243-4081-878d-bb5b61f7dda7@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fd9f735-6243-4081-878d-bb5b61f7dda7@tls.msk.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Sat, Dec 21, 2024 at 12:07:05AM +0300, Michael Tokarev wrote:
> 11.08.2024 20:47, Michael Tokarev пишет:
> > 12.04.2024 18:25, Eric Blake wrote:
> > > On Fri, Apr 12, 2024 at 10:06:17AM +0200, Stefan Fritsch wrote:
> > > > Commit 99868af3d0 changed the hardcoded constant BDRV_SECTOR_SIZE to a
> > > > dynamic field 'align' but introduced a bug. qemu_iovec_discard_back()
> > > > is now passed the wanted iov length instead of the actually required
> > > > amount that should be removed from the end of the iov.
> > > > 
> > > > The bug can likely only be hit in uncommon configurations, e.g. with
> > > > icount enabled or when reading from disk directly to device memory.
> > 
> > Hi!
> > 
> > Has this change (proposed for 9.0) been forgotten or is it not needed
> > anymore?
> 
> Ping #2?

Hello, Michael,

Looks like we didn't reach a consensus on merging it?  See:

https://lore.kernel.org/qemu-devel/CAFn=p-Y1sAXfzx6cWEgeYyMyG3yn1vEpDmV2K8qWtLx4otm4tw@mail.gmail.com/

Thanks,

-- 
Peter Xu


