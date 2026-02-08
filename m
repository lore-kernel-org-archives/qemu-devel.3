Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12F8EF06E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 17:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vp8Qn-0007aa-OA; Sun, 08 Feb 2026 12:18:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vp8Ql-0007aH-SS
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 12:18:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vp8Qk-00026e-9e
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 12:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770571119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PPqp42qytRAXbwFvgRqzijBKpHccZN+bOkRm8dlAyRg=;
 b=WvBi2V+JqkSumgYEjTA7PMeZpWSj/4QB7z8jkXop9eZK4O33Soqgn8dKYFiirJl3o45nnE
 5sEp6XFp1GG3UUzqknqvM8+RIsBrcqJlCRInha98idVW9Dfh7VSAkTv5r4dwQH7CtHwCYT
 sRjMWk+EJ312JzxFqZeNtzE/DMYdbF8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-Qe0ViFiCMkqNTwqxOOgpCA-1; Sun, 08 Feb 2026 12:18:37 -0500
X-MC-Unique: Qe0ViFiCMkqNTwqxOOgpCA-1
X-Mimecast-MFC-AGG-ID: Qe0ViFiCMkqNTwqxOOgpCA_1770571116
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430fe16b481so2799546f8f.3
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 09:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770571116; x=1771175916; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PPqp42qytRAXbwFvgRqzijBKpHccZN+bOkRm8dlAyRg=;
 b=frV8Pzxcl4Jdyitagi1EB5t80hH3yJ7g+79NHlBoW8CuwuNRTG7a635/Ze8iaRY5GL
 CmfSxg+QFBdRBm15ujPiobsptgDbythZQe7ijO+fS8ttwILICYETMbo3feVLXdbybe7c
 h8Vzko6IOzCGAZhMQhE7+DTrKT5LP1w5xHCSkh6OClxyiIJfYd54RtOUhSJU8IF/LnT5
 hFJOGVNtLMQT/zyjG5GvSGAnj3FcaAlOYxbYJOsjUVb/lb99tMdcUyCD6mOqvvIxAw7D
 Swc8l0cnt6mgLqNNH0UIpNXpDHF3671dpeszK8cWe4n+uZ6cGWdqX7MKtxhTLy5P52L2
 weaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770571116; x=1771175916;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PPqp42qytRAXbwFvgRqzijBKpHccZN+bOkRm8dlAyRg=;
 b=laQnFf2NIkjbJ0jL0a2N/E9oXUVDyrvT215cbK/GmMzGgg7L69TyUBj2PZVxqDeZPH
 E2kIVAGQSAV9IW+uaxPqrz5TbfAGmwiGne9/91Ggn4MyL6H0kqp6eirb25dsfDJBf/QN
 c7ACc5gHBWyachDaDCYMCds1YINHzOxtsfp1RyO/hozbLvY+1+h9E1PXPPU51efFecUK
 38hr3KAcpL0h3kiIRc0DlC6/LzeYpOWC3pFRfU4xVFkA5NxO50b7HypgbbkSlvXMshD3
 JubYPWUVZT3aJSBCRhRttLIJImLSAmseQhRqJKZn6+sgL6F8ISxqDt3GVoc+Sq2wdrVV
 cisQ==
X-Gm-Message-State: AOJu0Yx52fgQVOeNN3gJQklP3R2y3X3EbMJAUXPJt5OLiuwRzkpUQZ1K
 SAgAd/j8ohZ1l2xqQw+BYbkRGSzvUJ7MHkKXj3kiecp5z/rCUq4pkSygrJTUY7i8+e77wlCsdoJ
 fBTQvEJBO/wAPMFuPngA3IemJoWCJ/MhvzYkAQdR+kpmMw4USTbfi6JgP
X-Gm-Gg: AZuq6aKrIfMrbOBmwoHrgXJsOYam1BWiaJXXr9iy8PU/mQf9twHCbvBKeqUlKh2VwiT
 nf9YELu7xDJeem9uI256noChT46o9eNea9VOjkKKbX36Hy957XEvLE1qRH0x97msFGItrFUU1tJ
 soMGBAlemvsvgQ9OXovGYWEjAi9VwolJ8jsmh2At80Udr/W0lZ3bPgrbremZTKqPdwHkg1Q6E1H
 N7crGq+LAxntWWZMLosrTzQGrKsGelCzs3ehvX9+evMkk3cK3HhMmQ9H3Boi+booG49NFIMsRhJ
 6gLx34CYJfCbO/pOGvdid+WHc13QLSxtFbMeDokp3y9wkAUxsn/9PCoaXK/Txr9jXCKPJLNGd2V
 s/c8VYD8mIxIFk3VlEUtcq6GpNstgbRI20A==
X-Received: by 2002:a5d:64c5:0:b0:435:a48a:1239 with SMTP id
 ffacd0b85a97d-4362923ecfbmr13543817f8f.14.1770571116286; 
 Sun, 08 Feb 2026 09:18:36 -0800 (PST)
X-Received: by 2002:a5d:64c5:0:b0:435:a48a:1239 with SMTP id
 ffacd0b85a97d-4362923ecfbmr13543776f8f.14.1770571115751; 
 Sun, 08 Feb 2026 09:18:35 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4376806626fsm7366282f8f.37.2026.02.08.09.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 09:18:34 -0800 (PST)
Date: Sun, 8 Feb 2026 12:18:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, slp@redhat.com,
 hi@alyssa.is, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, manos.pitsidianakis@linaro.org,
 stevensd@chromium.org, dbassey@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, stefanha@redhat.com,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v12 2/7] vhost_user.rst: Align VhostUserMsg excerpt members
Message-ID: <20260208121818-mutt-send-email-mst@kernel.org>
References: <20260204093758.1250167-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204093758.1250167-1-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

thread borken.


