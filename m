Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C17CCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 07:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSVW1-0006YH-MP; Thu, 28 May 2026 03:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSVW0-0006Xw-8L
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:50:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSVVy-0008Je-KP
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779954649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7K16OglaZRffhLLSHn5FoEWQHA5S/DRRDMm3U91gOYA=;
 b=NpWMVUNPnIz5KOTSRJi/MeDzN02bh5v0tnwJIvUHP3oOXKq0j02cnSdH59FKXZIJyy4UMp
 N8+Ur41EjALSHbu2A47AI77tdVkOq4M+kAGPb0Q8EVip6OnLmm65hEbxwT9nNq5reQ7rDU
 V5DfVjsFNBEM5cG7aa6hzW4J8E/3qSA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-sGwSV4KLMGGsn_L2DTLlTw-1; Thu, 28 May 2026 03:50:47 -0400
X-MC-Unique: sGwSV4KLMGGsn_L2DTLlTw-1
X-Mimecast-MFC-AGG-ID: sGwSV4KLMGGsn_L2DTLlTw_1779954646
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-44d9ace59efso7308298f8f.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 00:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779954646; x=1780559446; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7K16OglaZRffhLLSHn5FoEWQHA5S/DRRDMm3U91gOYA=;
 b=X0n86xx+YuAccpXdDOJWUF6ZUYWnfoz8ueFP+gJUtNsrfWQx2JWBQk660zzDrJIhxc
 gy+v2S5buDRSEVRfo+izn1uyJ/f6LSEenGc3rwqNbfW4GfjOUwFYLhuFmpDvISz3rjee
 laDnBhMaPhTlT+POZc8WDn7IfF9oDxZahOIw5FFZi2uac+iiZRFdBIW+V5b/4tJfsXAI
 naSqHLSj5HJYRAHzboyjvDsIFN8UHqHvrzBLBuExZo7ME0HZ4yJX3LCSZ9WCHANpgF3P
 RL9mJQSGbov6U7mXdw3pZ8WkjMqjDfZBROkZ1b8OakF/UPYIRDdKmD2qbH3CL7HRlTTP
 EOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779954646; x=1780559446;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7K16OglaZRffhLLSHn5FoEWQHA5S/DRRDMm3U91gOYA=;
 b=etIkTsePMpHxS8MtRo/xX9CcnRPAmmL4DDtf/bwErD4crJ0tWOZpWq13vZN2yXQYAD
 tIlWirKcwQvc4/92CQC4F0M4n3iII0RLAbxnscX9ZAq4eWpGDvQokWzoNgMxkEy2hRsK
 pHO8UdZW+1r5aJ1QsVDPivupXi3S46bbxKZiuYniTa/lex+f28UOzUPQD8u3XMc+m4uu
 S5Pl8RJHEVkJrUqZNX24YjYiPS1h6rqgzk/Cswu9DODfQDIO6VPQe2kJVzQGfxt8u9nZ
 wMsxBxcCwLa5+nAVJNYsnbNbVdxOYjDzdYVw7+kzJxEyCXBGlGxHv+C68/sY7ZEBTOQ9
 iUyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9DoMPtJ1MSLG8qXcFytdLI+ACVuop9YZYf6GNMy+RwcpggRhu9rDg7umcdf4nV31EaIvdr6lZRdPfc@nongnu.org
X-Gm-Message-State: AOJu0YyHOlirGXmozIMLADhW8ldfWDGLMvR9jgaU9V4Ovqq/RrAIVvuH
 yBUqq3MSp+LzVopDiKvlmqv+RLxCP6xfO8awzQozK/dMjfyYs7NZASQf5hUQXkDV6aYtH4VeaU5
 yokePzFzS+mztJ4yMo8/LdFq+ZZx6T6HiIvTIofdXR+Kv1eaTKZQ1tyRN
X-Gm-Gg: Acq92OE7ez5kWuJWG8D1EdaKYwmYL5tT3ifyrsaOyrWbSKc/PdD72UjK8YEj0pZUXrx
 7EPZpYsqIvu0H8nDOt464CDKgRcqnEoMY05mvZW8P3/45dLnMZnmEM7KeobEf2c6Z4DDQw1YMOX
 snkIVyKHyPIBDS0uCnVNCv6AG7a3yx9qGyoj3T/3S9qs3k7uwa9F1x2o7xG+1m+uyqpoZnMqkFU
 QEV5YjskXvDAbG1QFgO9Xfdl3T3POKg0N9KGEKQBj9vhf7LjNO9MGSTlkVg8D5iBLuxfazi86+I
 0KEP26SGbG2ewbrpVunW43JIEBW5SKniyc+oHWqEz4OThlJWJEnEtBo5LRhlcP0C4BiVOxnWlny
 jDcSx11W8U9b/43vYQTLulA8=
X-Received: by 2002:a05:6000:178c:b0:43d:6f0f:32fe with SMTP id
 ffacd0b85a97d-45eb38b86demr45791150f8f.31.1779954646285; 
 Thu, 28 May 2026 00:50:46 -0700 (PDT)
X-Received: by 2002:a05:6000:178c:b0:43d:6f0f:32fe with SMTP id
 ffacd0b85a97d-45eb38b86demr45791108f8f.31.1779954645814; 
 Thu, 28 May 2026 00:50:45 -0700 (PDT)
Received: from redhat.com ([46.210.234.60]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5a28casm17253363f8f.23.2026.05.28.00.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 00:50:45 -0700 (PDT)
Date: Thu, 28 May 2026 03:50:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] docs/devel: relax policy on AI-generated contributions
Message-ID: <20260528034935-mutt-send-email-mst@kernel.org>
References: <20260528073412.551117-1-pbonzini@redhat.com>
 <6574cb8f-250b-403a-be99-c116a6814075@linaro.org>
 <CABgObfZWHx9qK-mEQ=2xeJWcyKzKE34VHDsAu-q0TSn=RbATtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfZWHx9qK-mEQ=2xeJWcyKzKE34VHDsAu-q0TSn=RbATtw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, May 28, 2026 at 09:43:24AM +0200, Paolo Bonzini wrote:
> On Thu, May 28, 2026 at 9:40 AM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
> > > Revise the policy to permit AI assistance where the ramifications of
> > > copyright violations are at least easy to revert and unlikely to spread:
> > > tests, documentation,
> >
> > Here you mention documentation, ...
> >
> > > +**Mechanical changes**
> > > +**Small bug fixes**
> > > +**Tests**
> >
> > ... however it is not listed in the "limited set of scenarios"
> 
> Good point! Any suggestions for the wording are welcome.
> 
> Paolo

**Documentation, code comments**

?


