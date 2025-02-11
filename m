Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32828C0219E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thsjv-000826-VW; Tue, 11 Feb 2025 11:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1thsjk-000811-Cj
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:03:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1thsjc-0005Ob-OJ
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739289817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/M4Fwk3b3Kjumwcf86tLlHOQslpi2LRYEfVcBgrcA3c=;
 b=Tv1kyIuxIvVPlTVC5Iikc23R7Brbl9qtu5AL7DCHgpi4Dt4Kpx/9XgWuB524/oBCHnrmyF
 03/7SF55E6fYqEMLTekIP5UYRCGN7131EbyoBRUe8SULHfaxT4Wou+gGujp9RsMGHTGIpb
 E7Cj/n4szBKKTwNrIly5Y4fAKhlJGlA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-hxxNCUhOPsa4Wgsu1SFoxQ-1; Tue, 11 Feb 2025 11:03:35 -0500
X-MC-Unique: hxxNCUhOPsa4Wgsu1SFoxQ-1
X-Mimecast-MFC-AGG-ID: hxxNCUhOPsa4Wgsu1SFoxQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38de12153d4so1351982f8f.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:03:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739289814; x=1739894614;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/M4Fwk3b3Kjumwcf86tLlHOQslpi2LRYEfVcBgrcA3c=;
 b=MUHf4ApFBYp0lgqcUNRTPE1T9H/XR5+gSPncn3hGgBamKNImmRDYW9Ebp2Ajr4b8MB
 Aw5a8ZdFI8iOkFC8uB9Ozrd83H122tGmk/bv7fZ/3ywpX2sUTK+/dSTtslodJ2vCMizL
 pRXIfvPJH22jvJYi1pLMq1avBrLnXLoMSsB4nFmUztMg3+/tNCjymC+AdS0bZ/+ljRT7
 TiSOWK+LkNlTaUfUgIrbBavZ9nBcd8yfKCJ5xWnh/o+PeghloevV6kdyVgSTAMYo0XTH
 DDWINeiLMdDneEuadAKjvQ4rxG0m4rqHVLUhhy9u/e9Sr1rMYZSFay28E0Er89K8HfOG
 PeOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQKMH/r/hL2oX7FmKNMwUvc/XxMfzWVfYcPUQ+1Y3189NWALL/fgwdzv7uucim74KtBVnbMVmA34+o@nongnu.org
X-Gm-Message-State: AOJu0Yw1X3+wDlxpo83wql59Sds2YFo0HvsdBC4/TmjrUMyTCiEgY5/4
 eM44t+ruVIFJoKm+My+jcgUWvfVE/EuT+PCFe+D0YPEK4VnfIz4cFZT8AHZJuMXyQ/xg1ZaJZHq
 KCAFynH85tWtLEVwjg602sirOVa3iPga8gqhMzzV06eajzSzOwprr
X-Gm-Gg: ASbGncvhgvyKTqrVHoQMEtVNjVYgG8ImlHLLw+CTK+FB3pT0tPSon3+l5audVbWulp8
 MIOhRVlV+X4PMTsm8RcotuhpsAYEvdO98Vc6NLJDfDdLch2kB97U/a/aciyft+xUr06ctKfdA3E
 0rzqV9+8NBVw9Ym3yHTCF57VQeJcBf2O8Snz8y0wjIEXh/yem1kQ2Ibny/EusoXQt9MwJbUEt93
 nqU6NbeOc/DtK6qqyWX/6QUWzUidbsv/sfmrvQFLcvMfxa5kOHsAd651r26kpWI4jo1zuUC57RC
 hoFOw7RwHE6S+PSidgcGxbUI/4CD5EBY8LPHfOA9l08RWmOOaRYjLA==
X-Received: by 2002:a5d:5985:0:b0:38d:d92e:5f79 with SMTP id
 ffacd0b85a97d-38de937f4f4mr313688f8f.33.1739289814207; 
 Tue, 11 Feb 2025 08:03:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsaAz+x5hhGTSvF8Mx92umCNWVTWGERmESa0JUeetMohiK0Ktv2clNRdgGAVoeV6W3hPYX4g==
X-Received: by 2002:a5d:5985:0:b0:38d:d92e:5f79 with SMTP id
 ffacd0b85a97d-38de937f4f4mr313563f8f.33.1739289813154; 
 Tue, 11 Feb 2025 08:03:33 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it.
 [79.46.200.29]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd44c5e3dsm9781657f8f.62.2025.02.11.08.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:03:32 -0800 (PST)
Date: Tue, 11 Feb 2025 17:03:27 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] tests/qtest/vhost-user-test: Use modern virtio for
 vhost-user tests
Message-ID: <m7wcdiqer5xg2wppoaxzgvvksxerahstbzwgj7pxnh54ke255z@uterepknqiqm>
References: <20250203124346.169607-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250203124346.169607-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Feb 03, 2025 at 01:43:46PM +0100, Thomas Huth wrote:
>All other vhost-user tests here use modern virtio, too, so let's
>adjust the vhost-user-net test accordingly.
>
>Signed-off-by: Thomas Huth <thuth@redhat.com>
>---
> tests/qtest/vhost-user-test.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
>index 76d142a158..bd977ef28d 100644
>--- a/tests/qtest/vhost-user-test.c
>+++ b/tests/qtest/vhost-user-test.c
>@@ -1043,7 +1043,8 @@ static void test_multiqueue(void *obj, void *arg, QGuestAllocator *alloc)
>
> static uint64_t vu_net_get_features(TestServer *s)
> {
>-    uint64_t features = 0x1ULL << VHOST_F_LOG_ALL |
>+    uint64_t features = 0x1ULL << VIRTIO_F_VERSION_1 |
>+        0x1ULL << VHOST_F_LOG_ALL |
>         0x1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
>
>     if (s->queues > 1) {
>-- 
>2.48.1
>


