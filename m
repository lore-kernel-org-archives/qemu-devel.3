Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F42C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 18:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucSwn-0003wV-BB; Thu, 17 Jul 2025 14:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucQOL-000358-SW
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucQOB-0003gC-AI
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752765540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=eeumtU4sMBiuTBGghaE+IqWwXFaVKxJ/+4ihNWkMoWR9HWjc4zG8z/Qk/uT0zR5+AsQXrr
 d3naWGpZ9e8SsoV5JLT6BdJ3M9MGEcsJ+GxRAo7nwmqNlscXpMVx5uXCjZV/Kbi42kue1J
 i4r0QWf0xWO4gBynGQz24kBTgXoeCME=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-NGa2K7heM5ioGXJogxlgYA-1; Thu, 17 Jul 2025 11:18:58 -0400
X-MC-Unique: NGa2K7heM5ioGXJogxlgYA-1
X-Mimecast-MFC-AGG-ID: NGa2K7heM5ioGXJogxlgYA_1752765537
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-454dee17a91so9080985e9.3
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 08:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752765537; x=1753370337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Aic+ijWbv/yOGT5M8SQG6zkwv6in5mqHYnitVIiDsix2/S1pe8ccHU2wVd9V1aHUY2
 C8eKzIvtc7lYp+JLRouW84SrAHHppq3j0XrI3VS2yCI7AUvsI13Xjb6/9bNf/II0aVrd
 nAsVrv2CBrqO6yZA6dEzQSK/lJTiVOPKejYpfVOsDoBahsVl5mDSQNcCWJKZb4FK4Bbg
 kJpj7zKhZYq5DLdW5gLNOpOR9zClKD4ov8TedtAoKm8zXQk3MNx993oYCc0Afrya/UxB
 O/3nacLUKaVE8mYbNcoUqMaZa9ffDOmXTq93SUEw0tUbjunsBB/ls5DuJFfH0w3jy9F6
 SIiA==
X-Gm-Message-State: AOJu0YzYd3UWr4q1v9ETEeNAI2Ya8utuIDonLEvp/vXACwcL+p7zOCYA
 DY+MxEiHbuUDNpj6cgCGWPn38980IlfiNIanCTDsnb0OAQrxPK2q2Ra/NYMOA4cmdajPr6Gwq6X
 uOKFZA4N6NNvsqZgiHqGWRqbHZfcFd8GAezl76L0wYxLKMfnBGFQ+heTb
X-Gm-Gg: ASbGncs0Txqa+rpk3+OfR4NM51yzS8772ysoGx7wQj/fhaZzXk6NUNGSZpjZ2U01Fid
 UNw6O5o2jN2JRLyX2Mp4J7oVTtnSqsxv0p3D8KFxQlWun100BidI1XO0g61OaDTDIyspIeK1edQ
 fB3SI65MLuzY2+ARAGmAqllo81UaCSQgKbnoUU2HWaU1tnlt+TIVeCP+u5FjysyLESFmlh9lDVm
 nw7NbsVspWuaB0lgRkp3Wa/ePIfe0IkmqgLGKn4T//gBtjmsJiSQFgzfu7eP4w0OvbJhMh5ku9e
 7w+fPmDMBgNAuragI+FJPW+NStXMdqKOiCRz/JAuI4Q=
X-Received: by 2002:a05:600c:6299:b0:456:11cb:b9c7 with SMTP id
 5b1f17b1804b1-4562e3a3752mr60871285e9.25.1752765537027; 
 Thu, 17 Jul 2025 08:18:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE9/GP7GpjkIp2xEwiCdW46rL2uCZpuk5DN08FzWHs76bORqw0EYd8Lk8gKL5uXDL095xzIA==
X-Received: by 2002:a05:600c:6299:b0:456:11cb:b9c7 with SMTP id
 5b1f17b1804b1-4562e3a3752mr60870995e9.25.1752765536610; 
 Thu, 17 Jul 2025 08:18:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45634f85767sm25507785e9.24.2025.07.17.08.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 08:18:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 roy.hopkins@randomman.co.uk
Subject: Re: [PATCH] meson: re-generate scripts/meson-buildoptions.sh to fix
 IGVM entry
Date: Thu, 17 Jul 2025 17:18:54 +0200
Message-ID: <20250717151854.352270-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717131256.157383-1-sgarzare@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


