Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC07EC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 09:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF90v-0002l6-Ly; Thu, 06 Jun 2024 05:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF90f-0002dK-CH
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:02:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF90d-0000qH-WC
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717664531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=aJ2V8/i9VqCyvlJIeG58mOskC0uyTGtJ0yH1bA8CvxJbEiA4hbYOtWrWxKpEQ20QlLGFjK
 9+UGBzoT/45UotE94whrwr4lJYgkFMhySs/p/7F98Ig7sHgmX3fmJ1Mzn26eJkpExb1Xbz
 YEIl1EzSXeYzoFTGZUjl6No5hWcq+Ak=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-6o5zcfepNva-FsKYMrHUSg-1; Thu, 06 Jun 2024 05:02:09 -0400
X-MC-Unique: 6o5zcfepNva-FsKYMrHUSg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-57a941a787dso547140a12.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 02:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717664528; x=1718269328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=dddulatVswi47d3xa4pz2O+wDaASwNTuR+H00Ym7yqvf9rMy8Al92Yk8tqdsCCnzdN
 MaxKvAset+2wgvOQXUuhNEK/ATkYTUEAAdDmYoz5ALNoVyzqGLqvux2JB0Rcs33//ikf
 6pjgtKHTvCcyyZmgyhJM/NMzjWQc2rIh7YG1e3lvM2m8b10JloByA3nr51oG8KJ+yznN
 vvzMZwRmZWk7wO+lgu+JlGi/8RAGaBlxAAa0u0ddadeBFJFFoxoGhvEGkG3nrvIYjBDE
 NZCvMuWp68gah/Fs8xcrxt8APkNuzBBOqmJ+LzPteRfOfieAmeWbOhicsS/Hrte+lSAX
 ezVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaoBsxsgH8IW8Mxi4Z3MyW4pNI+gJXLkfsOpOPCDXm7FKSmhzUnfAiEGCCYOZ/TQWaXGS+ztPr1AlxJ0s8nVQvZzBiy3w=
X-Gm-Message-State: AOJu0YwETblbR7f1+1p5n+lxgPnQX7ii2SHGQyLnVg2qnxt3jb5HpQbw
 1FPnLEw9mXvBEDFVYvzyxEoeHkWY8PhbYvnxiy6wjPXmiSix3ND8MIxDdbXljByrv4TwO7+OZ6S
 biipFUunoqNPvtkBRsal0yzNUm58vLy7UodHtDU1ARrW5470vH8Og
X-Received: by 2002:a50:d4db:0:b0:57a:242e:806b with SMTP id
 4fb4d7f45d1cf-57a8b6acd8emr3741209a12.18.1717664528744; 
 Thu, 06 Jun 2024 02:02:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6YmfUtIhRjw2q+aHPRZl05el050ktlV96IF5ANgA9+rFX2L7xkzIeJzLwf2U/z4GRTy8xUg==
X-Received: by 2002:a50:d4db:0:b0:57a:242e:806b with SMTP id
 4fb4d7f45d1cf-57a8b6acd8emr3741189a12.18.1717664528363; 
 Thu, 06 Jun 2024 02:02:08 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aadf9d8ddsm742166a12.1.2024.06.06.02.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 02:02:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] docs: i386: pc: Avoid mentioning limit of maximum vCPUs
Date: Thu,  6 Jun 2024 11:02:05 +0200
Message-ID: <20240606090205.2463843-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240606085436.2028900-1-zhao1.liu@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Queued, thanks.

Paolo


