Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66509C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsKKZ-000193-VZ; Fri, 07 Aug 2026 09:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wsKKY-00018e-Iq
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:09:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wsKKW-000433-0X
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786108182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=OpwT1ecUrzhIISy/FUgnI429GsWJm3GyAIgiZVaaQPg7rPh/ZQATtnGohhTNqA0I3GLDL2
 ia8Cg70rFM+YR5lQa3UawMuuiK5kSTVB2k7GNgtVLZul0QjFL/duT3zkLaZx2RSEIApMDR
 yPzwu65kVKnuHHMdGS8LtTa+RvtMn+8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-m-4WpA1nOUKjVHzncWkx_g-1; Fri, 07 Aug 2026 09:09:31 -0400
X-MC-Unique: m-4WpA1nOUKjVHzncWkx_g-1
X-Mimecast-MFC-AGG-ID: m-4WpA1nOUKjVHzncWkx_g_1786108170
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4954b1c6310so25813445e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 06:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786108170; x=1786712970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=rUPcPmwTbY+sfVCTx8R81SuvxHEUqVgIrgJ38TrzfbTUDZekmEKIQm0GfWfp7y5D9b
 pzT0g7IEHHGI9DqfiYZFug6pd6YVY0KXwWXY7BScpwwz+iDq0Yh3NJmG5WjrIYRYnZcf
 nk999IfBiPpfRWuuHBRgz5btRMVi6EgLuMQUVqUlQoR0Pr+Jv1DZIM7KtZvLHiMtof67
 UMNPHAj1SjerCjMT7WcwRgXcmCShk0puvxDLNFH/t790ZIGglGI8HcwFxo9c8TNe8fvg
 DoQ9+yrhy2TBW/56FuUppWQKNFC/mEdmsikWaHKWkEYbIg4vVBtPxE3nSShbejngyhny
 ZA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786108170; x=1786712970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Cvxvtq9qlYAuapB7v1udLEKrJ5gG/g5GDwTo6B7uxKK4eiJVFKDuz2Ftya1+lonHgj
 GxThVeeqThCiKLx+4GvqaYR3064S1WdOPfQTi8oUPvFHfP2CKvqxJpe+HQXxNhTyq3yY
 Ijn3cjP5TmonASYp4aDQv9te+IaiDThsAiRt7KawNaiMIjVIi1ZdQjn2JhFbAsrpAGQn
 93YW+DP2vI5DdhurAYjfmWYxUsy1N5E/XLfnR2uJEvsTSNwZ1g3a/RPxmMRsqaizd/rO
 +J2hR1z13l29QmB4+dAYXgVxVDSzVxzePYW3NTIaIE76avZ0kDEM4JHc/+3VfxhJ9bGW
 b7wg==
X-Gm-Message-State: AOJu0YxbRcZw6ABCDIMXnjQtUkSujkh7O50uGaBoyVsAy7rw6aUXF5Hf
 rGo3GAM0P9odjDes0Ui6GodOcGPV/00zmwu2m+K6/3rej8UC0+KMHMRkCGuKhfU4Yk0Dt3mikTf
 hOIVnCkioIBaBZHvG+nijxdOktBjC29QVj5NPNkI0NfZFoYQO4hRkhIsw
X-Gm-Gg: AR+sD12gLfH1uJwEpU3sH8iA5LlaUxsCLmATTKkMmm+S1lBhrAEKmp+qfUdg1fDcXE+
 X9IrOwbmCmc2a0Z3evJ+DbOFacm5i1a9EcJmYKfr9xuOEfNi9xFPR5tL0OYseZ6WL2PH3LVLhjj
 iQNNyp/afpC7kYJNLZU+lws/Q/BUQXyXp5AZEELTLkt8y9uwF+EgLza1RCJMGWRQiMeSUDCR0ui
 MOP51uKH84nEFsHq2eAfFtlnXCX2PJN1zu3+PDDjVamp4G0O/CBVL1YTB2fdK0DUQl7mbrV3Zmz
 EDYglRbQE8fBN64zCtIWyIq9ItfJNMmw8SMX3DNidJRUcoZXczW+dK8PE/5sQrA4Hf7PR35vuvq
 +sH4xbyBIEyh0EzG7XcU7H6o4X4CkOl+Ox/+MtL2labruvqdR5Hpyy/Pfg3+/cP4mbQcl7Kg/zD
 l/p/c=
X-Received: by 2002:a05:600c:6a8a:b0:498:ee7:e407 with SMTP id
 5b1f17b1804b1-4994e7d3f2fmr258466655e9.17.1786108170068; 
 Fri, 07 Aug 2026 06:09:30 -0700 (PDT)
X-Received: by 2002:a05:600c:6a8a:b0:498:ee7:e407 with SMTP id
 5b1f17b1804b1-4994e7d3f2fmr258466035e9.17.1786108169666; 
 Fri, 07 Aug 2026 06:09:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48002150804sm5511249f8f.13.2026.08.07.06.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 06:09:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Simon Scherer <scherer.simon89@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org
Subject: Re: [PATCH v2] target/i386: Clear OF, SF, and AF for fcomi/fucomi
Date: Fri,  7 Aug 2026 15:09:27 +0200
Message-ID: <20260807130927.2604124-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807062831.19618-1-scherer.simon89@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Queued, thanks.

Paolo


