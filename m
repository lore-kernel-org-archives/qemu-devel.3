Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A13C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 17:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaHGm-0005sx-Op; Fri, 11 Jul 2025 13:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uaHGW-0005rO-EQ
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:10:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uaHGU-0000Jt-C7
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752253825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2BQ23q8rO/4JwlQZO7v+InvClXfpIIGFsmYUMuDuGeI=;
 b=YCyTOb5BcQz/SrsiRSrs+ncXzZQF6mhhZ35gsvuVcghIkDCXtyTFqvG8CR4Vz9S+nVYhLT
 NHEu5lzHInybTeQ4cklXGB7NYgU+zHzaXdl04vAsFBdpYcnQ4Bs79YwOUxnQE0BijLEkxb
 wsZU2itzJf8Wb9XlJuDSDAhTMX9RMBM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-s9uCEaYtO4-sFMibmJ5VUg-1; Fri, 11 Jul 2025 13:10:24 -0400
X-MC-Unique: s9uCEaYtO4-sFMibmJ5VUg-1
X-Mimecast-MFC-AGG-ID: s9uCEaYtO4-sFMibmJ5VUg_1752253823
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-454acc74f22so14996085e9.2
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 10:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752253822; x=1752858622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2BQ23q8rO/4JwlQZO7v+InvClXfpIIGFsmYUMuDuGeI=;
 b=V1RqDY/zN7Gg0dN0EkYOMvmNYLxZbYhDk3wcbBejGMIZXuu3HRcNGuggYTSor6Jm2G
 FPix3wJoEU4K4G8FcI5Y3Koavch2sZma7E5dY0/qtZDS29XnBlqzReF7kh7Yf+xtS4gY
 SJrYptdqQ3LqliY+B/Bg4p217IHTwF3NV9re0OYJjQitAtCiPv8psLny4sn30tjmdIJH
 zTEuR1D6CapZlU9ECEyBkOhH+aWtQK8gpac4DD4xuJlw+R8WlTGJKcZWW5CSj49T6ytu
 hZVjcL2nCexYsXHQ91+/B2hpQAKHDYzW1H/WE64kRBBzjeV1edK9mM/ThCku4zIM4Mpv
 Sk/g==
X-Gm-Message-State: AOJu0Yy8KigjPc3WwjO6d4XPj61bSpUAtf0YMNe2g9YQVttEFkp9OB+i
 Un2YVgMqETkjp2bulw3mNpjTEnUkLivUFT0QzATmunFrn0z+TIPL3BfrpbV9T0tDyqKD5AP9kBz
 Pyigf37YODVSGuF7Fqu8Y3nDepk0HU/1zFYGNBqWSZtjeRLI19ALQXZnyrfDgSKFo
X-Gm-Gg: ASbGnctB1r5iHYVIcl93MGkRDxkgCvmlA9sUvCQoEhN0ICLo21u5t5jYyVluuTA3yoj
 cmVESJRdOmUpcSDrKJk96QClmR2GCWftznQLlswFKZk/pqw2MlpD3tyF1fNSWXYnvNErVsOIZD9
 QMVUiKM8k68cB5xz+xs+OgoleQE6pkcfEQNKPAdVDH1Io2/FKnNmjOZmr/FoluctNp5ZkJxTogf
 5zA/SdBQLwZZlk9ZU5g4xExpXfVsaRUhJ0QvHHFhKwpOaLulT1jsjyO+eexeaEET1V8Z5eKsgXe
 6F2Hxzv5CvpLphaFwFOA1s3hKS/LoO1dFouwHc5wjTjn
X-Received: by 2002:a05:600c:4e8c:b0:453:606b:daea with SMTP id
 5b1f17b1804b1-45565ed6221mr29690095e9.20.1752253822060; 
 Fri, 11 Jul 2025 10:10:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvZHqUmb4lfYVRykyJM2NP3n8/BzdQr832ZsSR905aWn6hDITOmsFaYjRTuxQdWrPnIVKbyg==
X-Received: by 2002:a05:600c:4e8c:b0:453:606b:daea with SMTP id
 5b1f17b1804b1-45565ed6221mr29689815e9.20.1752253821580; 
 Fri, 11 Jul 2025 10:10:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.202.169])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc9349sm4905153f8f.45.2025.07.11.10.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 10:10:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3] rust: add qdev Device derive macro
Date: Fri, 11 Jul 2025 19:08:01 +0200
Message-ID: <20250711170800.503561-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711-rust-qdev-properties-v3-1-e198624416fb@linaro.org>
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

> Add derive macro for declaring qdev properties directly above the field
> definitions. To do this, we split DeviceImpl::properties method on a
> separate trait so we can implement only that part in the derive macro
> expansion (we cannot partially implement the DeviceImpl trait).
>
> Adding a `property` attribute above the field declaration will generate
> a `qemu_api::bindings::Property` array member in the device's property
> list.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Applied to branch rust-next of https://gitlab.com/bonzini/qemu, thanks!

> This patch depends on patches that haven't been merged yet to master

And especially on bumping the minimum supported Rust version to 1.83,
like the pending vmstate work which is sitting in the branch.  I fixed
the conflicts and rebased it on top of this patch.

Paolo


