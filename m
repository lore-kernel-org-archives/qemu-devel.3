Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E301125850
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0M1y-00013J-HL; Wed, 11 Mar 2026 12:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0M1K-0000f1-Cz
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:02:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0M1H-0003bB-Qg
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773244965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=X1XAVLq1T9y9FSD0rXbOHxkRGFH+6OFU8fIpvHXKJ3yS/hNx47583DTVuSuLDYJmlWWB15
 aZ3nfIjxYCn8vYQRHbQQCj1Qy/DLPNvHPVGkgh5DFuEBVa3L57rpGvxLB1whEp5y+x7kPY
 lDobVD3hSKhZuUuJ/YVhN6Y40YfR0Wg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-ojVE54oLM3aCLiSRo0hqpQ-1; Wed, 11 Mar 2026 12:02:43 -0400
X-MC-Unique: ojVE54oLM3aCLiSRo0hqpQ-1
X-Mimecast-MFC-AGG-ID: ojVE54oLM3aCLiSRo0hqpQ_1773244963
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439b5511d5aso32482f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 09:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773244962; x=1773849762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=CRI1fKWrZZy70odBdH7jcDfNnejW5xl3SWNSphzbkzNKQglO6kOQgWaSkhijZL5I7R
 z3YVR1dzH1CRp38NLfBUCgGpbNKUTIRGnLB4+pM20mfRqEjKpci8kKCt6WcNmUJ2gmgk
 YjLkxVFCKuZfxK8T+/PXmhXmjx/o4PpwqDBE1NKqPZQhKlE58+2lI9gLCM5WA/GOotaA
 gvGxUgZFNf/GOfq6mt+HdoP93ogqCKou9Bv5/UOOXYHEsK6picsQDbcFigEAw63ljqUX
 WOcEpew8HvsZaSbeH284WTr7KuDkimsh2SSOXQL3Phxtm4wDlcXmhoe4LvWGVm6RVH72
 9+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773244962; x=1773849762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=VIp80bSZvVuww/F3gspEY3IEJtpdB1/7dH0ZqX0FsnLUCt+QehYp8ek1fR+QOSDOCE
 PSgX7zOLSIZoHjyn3cZySRKVYmX8H7A3tLpSd05gMvs8hyb/Y9WDlXcuDFQtNoEsYe9v
 e9dYZyGcDmAqKZ4YXJ41Wm3LkkHCDihu5F+CQibEFIxeEKN1eNHJ8fzhXcqpabld8Gui
 h0QcRZRvCBuxFxfY3lR4/JUAEwcdOYUqa+76n3gPup6yG/1FQ3f+vCXvM/5oNcTolKlM
 SXQPzH2osKNF3IbzR1jUAkrgvbVOSlD/8BCI/G628CSzCSmohwNgeCahdbXasOXrghmQ
 2pIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh+CHayg1uAux5Sv9W7bQ5JgVa2tX5vgnFnDZ9DoeZNwFY1UewOzIzhpcmsAiOGTAAxI+qXlX0NtuM@nongnu.org
X-Gm-Message-State: AOJu0YzqVqdcSQjZjog9H8z4s/DdLrLTk54xyOkeYhklrO+Xrh4jIGcI
 QSVJvSA1wgpJLUSemaOE+Nb4kMIEet069WHXn13W3X3v3oIVQAoBHeCuyhF1kDNvn20G6KUgxYE
 fLP8le8ZooC4wLboBV4rT147wr4eIf2iZaQekYbEh3qbqnUaTyysJv/iM
X-Gm-Gg: ATEYQzyawKf1uY9DGmBeSyi3sFSQGm1aBqsT13w/qUZkKgla4LZf0bsiY4dZ7OCURJ3
 1KZ6ZkPu770fys6qqaXcky+h0G+usqH3QP4136qUtOhh6UZ5ZHiIIqPfyhezXs0r89eCZ0Esr0A
 0JGp+/Kr9BhuJsl2lg8YdUT80juGZ03ACqoKQTfCyYBLc28DXAFGqG++/+XEy2rN3sVKsS4s3bJ
 nJ2O3dLnGhaZwO+EJfHgF1P/qlj7b46LonDqhM8xp9EilsU0BTGSCbZP5+vTHDN+Q/JbwfBcdyj
 1AzI0Yr7jnPdHJmY8i7f+w2//nOlolupZJmHJoJY7CUOJ75MENG1XXQS/Heo98s3GleMON6fI2P
 n+QYglA4Vgl6L4VNuz9wpmuDtSuGPpOpB3iO8zU3HTeMr16lGiC5wNd0qA0f/OJUF2n83BkSeRD
 /oiuCl5bfKoaCVtl4yFQ+4nd1Nhdw=
X-Received: by 2002:a05:600c:4710:b0:485:3471:cffb with SMTP id
 5b1f17b1804b1-4854b0bfdf0mr58593195e9.15.1773244961579; 
 Wed, 11 Mar 2026 09:02:41 -0700 (PDT)
X-Received: by 2002:a05:600c:4710:b0:485:3471:cffb with SMTP id
 5b1f17b1804b1-4854b0bfdf0mr58592365e9.15.1773244960916; 
 Wed, 11 Mar 2026 09:02:40 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b0dcf2asm33869355e9.8.2026.03.11.09.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:02:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] meson.build: stop checking for inotify_init()
Date: Wed, 11 Mar 2026 17:02:38 +0100
Message-ID: <20260311160238.551773-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311124008.1070746-1-mjt@tls.msk.ru>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Queued, thanks.

Paolo


