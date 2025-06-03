Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AA3C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 14:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMSzY-0003nY-GZ; Tue, 03 Jun 2025 10:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMSzB-0003kS-Rt
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:51:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMSz4-0003NS-Bf
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748962278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=YVu1Tumw3gf7nz3yKSwlBHmGVMetIA3SKj68DKWDVNw9prcCtTw0m1YFY89pPFIp+OjNqm
 Wb5VbhL/iIU26ivo39WuuFSYmrJ1ni6wWXWX21fsxZt6lHG4nS0K7GfVZiWGnrtEatPAyR
 W8HdxXEEMX0Mf9g5hnvynR4YvwXYh7o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-E5JiUPG0Nyy6MYtmUWSvAQ-1; Tue, 03 Jun 2025 10:51:17 -0400
X-MC-Unique: E5JiUPG0Nyy6MYtmUWSvAQ-1
X-Mimecast-MFC-AGG-ID: E5JiUPG0Nyy6MYtmUWSvAQ_1748962276
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4eb9c80deso2420371f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 07:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748962276; x=1749567076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=gcHIOH06aUySDj/psBNBkkLTDbe2Q1x2E0d02uH95t02osGq3yZ5N7ncl6h5agsYme
 vi3DlIcMziNleEpGDetSKfgFLvpm9OrROgFHFUhhnY/qmZV60qWe14IxNwv8oHY4cXg5
 c1fNrSEBeIfU6fvgxoA57T2iNtSw0iODHouYCWRgHbzwgwqocZ1Fs/hgofzmSsLjfFeK
 Tgo2FV6vOq7ZZks0xyOPZxaqKT8pAXHuf1VC4w5hruMm+ZSUMGxhOK6STVj4JZ/KNUPz
 Te8VY5eum5gWkmIkFwt3JuMDMzGQWauU34qydVOP1+TXu/yFHMJHAo32q+FchpzSaRAY
 YMfg==
X-Gm-Message-State: AOJu0YxEHhf97wKtzka2A3OD9VPWdhM64metbQBnv6cy5T5RZeE+GesM
 eItgLZC2JvKKAs0ZTE1XktJ2oIDbwZ4YUoqh70HqZj7q7KSo4YP772xRH72n+q14hSfXyxbavgz
 pgMoHUokibVzXas0j/jhmLQ+lROJ3kFjfPBrLLyGGrfAa0TIW4ZZIUS52
X-Gm-Gg: ASbGncsR3Bx9gyER1yChZtGbs7CE+tzvEl3iW+nOmFGqFNjRv01XQX6NzBZJFNV+nYP
 ew8jDCaMk5tFwPocJOr6Yg2SXNwxqD4mFICGlPaLyjJRsqywfbXSPs4cstdv/IehhPvkcMrDgnH
 Wge8ISf2aModFo5s2mPlirUwHOHmc/FwZx+KNoPPLqairxpmn8KrngyuVuV0sI63pd3EheOgeoZ
 rA7YCTWk1qlWTwG6fhMpNp42WkbwwzuDTd3euz7RZ2fiDfeJXhnYKqMZx3wX2Vww3+efge7mHnS
 VY42sN8kAjQ25w==
X-Received: by 2002:a05:6000:18af:b0:3a3:71c2:f753 with SMTP id
 ffacd0b85a97d-3a4f89d30ccmr14362339f8f.34.1748962276130; 
 Tue, 03 Jun 2025 07:51:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8fNopi5NyoTXLlC4AZLXhT/194ywbQp7tWzagVBrK7R5JBANrlouyYCf3ZnlQcTzzZyHpyA==
X-Received: by 2002:a05:6000:18af:b0:3a3:71c2:f753 with SMTP id
 ffacd0b85a97d-3a4f89d30ccmr14362307f8f.34.1748962275727; 
 Tue, 03 Jun 2025 07:51:15 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451e505d40csm23657935e9.0.2025.06.03.07.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 07:51:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, clg@redhat.com, nabihestefan@google.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 thuth@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] meson: use config_base_arch for target libraries
Date: Tue,  3 Jun 2025 16:51:12 +0200
Message-ID: <20250603145112.72239-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602233801.2699961-1-pierrick.bouvier@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Queued, thanks.

Paolo


