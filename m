Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0524710F3DCD
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7DSC-000458-Q2; Mon, 30 Mar 2026 10:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7DSB-00044r-Qo
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:18:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7DSA-000135-KT
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774880333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=EuipPeEfFR3UMnfwR3izNkw97/jqrV4Z9pMzMpNtCnGORuv2bJn685q31698WA3smqcEY4
 YIyZQeo7JxZjYnnsWrx01c7tRSKhLZ8mg2nlfhNMQDlsRZJPXbS/q5t0nL0bqOAmvH24Dl
 nRs9xGh5Y0pZ2IPThzoTOeuXSOFkD/8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-MTAtQRexON2EtqUFOdI1wQ-1; Mon, 30 Mar 2026 10:18:51 -0400
X-MC-Unique: MTAtQRexON2EtqUFOdI1wQ-1
X-Mimecast-MFC-AGG-ID: MTAtQRexON2EtqUFOdI1wQ_1774880330
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43b3a675316so2184125f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 07:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774880330; x=1775485130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=goXqYXI3IXXkkRXR68lm744J1pL/5+hVOVGIMAc8SoXM8WzpP2HaPRQWFN5DEWgroa
 qrGdu6h4iWO3jwrq16OmmR3W2mjQIUibBN40RqS2sT5+jB8n2SBVHeAckySNHLFCelU1
 bZJgvyCclcGe7uOJQKsmkov6zHGxKW7Bae9yNwbyDMi+agc08k4f6Owo6XoTNDuAwWmN
 EYQoqbe05DPalYodOIpj9mi3Ecabyvz6mKcOiOO26Wk4iY5WGaov2BzP74ZRH3w6iDyt
 9UNHJkspTLt0CQfEAG1wVQHpmH9b4WFyGwuUG/siFDFK5yxc+23LpABZ82X0kHPleoxm
 EbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774880330; x=1775485130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=rnc2HF034FY69CGxF4S64V1CWaiPo41PBXvrraV2Cfwt8HiqpuMGl0MkEMPRkVykJH
 +8o+IjFyesdJce8nov3t5OJEN2V8UJ/uoPajxizVqtxl7KZ1vPL3EWYqFWp+BNLIedNg
 8MUupH7LceL9FHDPGKEIqfyBwXJ79nR52kQy3ty5457xUPF2OdzCsG/+BPlyvV7AsPMq
 XehLy8zKqFGA7wL4FRx8W43dJVWB3ldfzkdJztEY0a6CkJTFl6EXhEWH8hcwUa/fwKfO
 lbHPKPu4YkbtSautSrikMsotJuPay0IsH9z7esWvVIZ7gSemw0sns6NbNf0Byxo2Dyox
 27mg==
X-Gm-Message-State: AOJu0YyNXPEbTlI7lDhP0lFb9uuaE5C+C4SvlITc0KwXAe3alXCZkcE0
 b40mXs4A5xPOnIyz4AEcot4FdeoNqr4EMvv2+fdfr+eIcQffza3Ab6mu94/HVZ9eVZhaol+Cheh
 4EnlMTIppWp6yU5s7hI+8XdYWtvRUsqpjE5GOuFdO2hNnyIr3KF3PEuCz
X-Gm-Gg: ATEYQzyTVUms3B9MVgbOxVAHOIfVd1Qxmmugl1jOShCCd4XulyT/GgY5uo/PnAh16xz
 1pmE+NVwt5I3qwJ1yiJ9VNELgWf2l+Um2gAK9aGlxtW5ud4r25/LSj1oYaLQ0daM5e5iZd1gZXe
 PY1lMS+I+HxEUBUNWjseUpRmGbJo2zE7DKcimvR40ToeWMdi3AQHJ8+0DEukX0zDi+zjMSV4sAS
 jC7a+SyBJollTiC9xaCz1lOEAOGBXljgbHsvR1p9u/49m6dVhK+MH8EQyCMYlmneCzb2j5xl9Zq
 TIaMXjxO+4uzWGLdGaWzPVNqJQOzhYlJ6hkXpZNNvCSAw9nzsJV47ZvdRxXZ06p2qbKoB97mttE
 9WwbL5zuulAOpHwcGvnVnZ2RQYZz9/dCwyNYNzo0kSWNxhKeWYpkk/qchK/sw+0SBPSY+QnWVtA
 ozmevdAGDVdz+xWK9Lau6LjEGG
X-Received: by 2002:a05:6000:2282:b0:43b:4ef0:e17 with SMTP id
 ffacd0b85a97d-43b9e98139bmr23224653f8f.7.1774880330409; 
 Mon, 30 Mar 2026 07:18:50 -0700 (PDT)
X-Received: by 2002:a05:6000:2282:b0:43b:4ef0:e17 with SMTP id
 ffacd0b85a97d-43b9e98139bmr23224571f8f.7.1774880329889; 
 Mon, 30 Mar 2026 07:18:49 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf257b72dsm19992364f8f.34.2026.03.30.07.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 07:18:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stepan Popov <Stepan.Popov@kaspersky.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] meson: add missing semicolon in pthread_condattr_setclock
 test
Date: Mon, 30 Mar 2026 16:18:48 +0200
Message-ID: <20260330141848.287135-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330131406.87080-1-Stepan.Popov@kaspersky.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


