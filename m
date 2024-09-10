Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B983EDE9B4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 20:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so7Nm-0006D8-0T; Tue, 10 Sep 2024 16:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so7Nj-000626-RJ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 16:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so7Ni-0004l8-BS
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 16:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725999753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UYF0ZKWpHFsPEUD6OVEl5KXpR3TmwNFArxks4a2lGM8=;
 b=Cw28KxKpRtvshb4F72NlzjF1skleFgC9BcyeQVZDtLQ/myXdhJAqhaNyfGJk0W2j0iJPwI
 t2Ux+B9UfdDzM2F5nAMCdBv5bGBIujBCoR+gRMpw+faMoJg0x0QWcrZgXETpGlP/hSGD3T
 8BbjUB0SkiaJy3DByBZEVO//HXtDxoU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-qbT8XK5mOsahL-fQ0G9Z8g-1; Tue, 10 Sep 2024 16:22:31 -0400
X-MC-Unique: qbT8XK5mOsahL-fQ0G9Z8g-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a8d15eff783so218682866b.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 13:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725999750; x=1726604550;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UYF0ZKWpHFsPEUD6OVEl5KXpR3TmwNFArxks4a2lGM8=;
 b=ASCM1ec70blrJEeLbyaQwbtHINM43GFqXv5JhWZXH+0GlCnE4jR9s4hr2/b636ejM1
 vPPBAEaAJk36h++9gGD+DK15Uyp55R/htTHEbmbhgWWe87F3ST9r94KoH7i/PvwgZ7eT
 j/fj45OdmsvzA1LCejbOig4qAx3yhuqM8aS3uKcP0/jFe4dDlpEOe2MVANg1tZ6/FIYH
 nnHmGxjAa9Mkmm1SjqHZ2FMwnhQ2y5cX+jhPcJoK3FXoxUCXSFCaL/InsIwKXfwWFiYs
 HSV+0w2RkfGJgs268YUmWd9LGhFQrIYZYBiF4NoxX3XvDUyV+ztGQkunumWZBtsoIfjY
 BUhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjFXGPflvwHiIonie6eh/K1MJXIAk7I5fOXNI3eh+Dzo+opUAFn0v9irf2cGFdGASr5Igc9Q7ogM2c@nongnu.org
X-Gm-Message-State: AOJu0Ywn8ad+XCgspKZscZZhpTug4e1ALOB0U/8B9FQYD44fkknmY8iE
 cJ9wqnyfCd/g/RxJRDmsCWC4kkZMz/fDgFxvp34nxkaWWre4iRO7OxUCw4b7bjHd9LP+DsJFwRB
 J2iXX+1PvXUx1LAHgD4chu35cTUeSOY5TFGrilFt3QTdRyenlSJZ0
X-Received: by 2002:a17:907:9807:b0:a8d:2d35:3dc6 with SMTP id
 a640c23a62f3a-a8ffab2a201mr171369766b.26.1725999749716; 
 Tue, 10 Sep 2024 13:22:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvZ8OLT5nsRrv1cEDosG/4ozRJWxYJVlFu/oF5QlV782yuOtsNdITI3v9+RGIrsc1O3+gA1g==
X-Received: by 2002:a17:907:9807:b0:a8d:2d35:3dc6 with SMTP id
 a640c23a62f3a-a8ffab2a201mr171367566b.26.1725999749082; 
 Tue, 10 Sep 2024 13:22:29 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:f5ce:2d9:5bfa:9916:aa0a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d65cf6sm518157966b.222.2024.09.10.13.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 13:22:28 -0700 (PDT)
Date: Tue, 10 Sep 2024 16:22:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as a reviewer of VT-d
Message-ID: <20240910162203-mutt-send-email-mst@kernel.org>
References: <20240820095112.61510-1-clement.mathieu--drif@eviden.com>
 <20240910131304-mutt-send-email-mst@kernel.org>
 <9c523e4c-9405-4d81-a2db-517863ec23c4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c523e4c-9405-4d81-a2db-517863ec23c4@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 10, 2024 at 08:29:25PM +0200, Philippe Mathieu-Daudé wrote:
> On 10/9/24 19:14, Michael S. Tsirkin wrote:
> > On Tue, Aug 20, 2024 at 09:51:47AM +0000, CLEMENT MATHIEU--DRIF wrote:
> > > Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> > 
> > Using index info to reconstruct a base tree...
> > error: patch failed: MAINTAINERS:3672
> > error: MAINTAINERS: patch does not apply
> > error: Did you hand edit your patch?
> > It does not apply to blobs recorded in its index.
> 
> I suppose you process your mailbox in FIFO order so you might
> notice it before reading this reply, but I already queued this
> patch since it was languishing and trivial:
> https://lore.kernel.org/qemu-devel/9f4cba51-5aa0-4942-a7a0-6bd3eb29a7b6@linaro.org/

Thanks!. You can add 
Acked-by: Michael S. Tsirkin <mst@redhat.com>
if you like.

> > 
> > > ---
> > >   MAINTAINERS | 1 +
> > >   1 file changed, 1 insertion(+)
> 


