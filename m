Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72965EC01A9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 08:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4b30-0005pX-RR; Mon, 23 Mar 2026 04:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w4b2y-0005p5-A8
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 04:54:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w4b2w-0003Nx-9N
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 04:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774256039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Ptb0pE8B9wTLlTOZ5oIDS5nyWQzMPaj6KXlQDNKl6n8AuqAKCsp0dDrGhEbKkFeQB4Vsb9
 3b/NSx+hFR91ssrPAIqBv3NMxNzstjG0BxEhQKKqxHBw44eIfca07tlJeLUr8pl9rpTPkn
 ToGyysKDEuOVGjOEEf54OXy2p9A8V/4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-9LkRvFMBNDSAtv83oHh8Dw-1; Mon, 23 Mar 2026 04:53:58 -0400
X-MC-Unique: 9LkRvFMBNDSAtv83oHh8Dw-1
X-Mimecast-MFC-AGG-ID: 9LkRvFMBNDSAtv83oHh8Dw_1774256037
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-485375aa56eso22650795e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 01:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774256037; x=1774860837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=CRsYYiuABTbnQPGN44Ibj8jxCicntwC4ROqw0lnX9ckkkf5HWpDycCb+cCo9yMSXSZ
 j01XXgnoufaNp8iFyS96dJsntf5mJgKGR5AB0YgeVaeDBxlGwEBuqWH1tHeBbJjUfwXe
 NfupBJa3UFpW0uG2nct4C935WWgnjXpRUuZDVdkJqr6YSsxAOCGBMkjlm5aaNryM6DYR
 HqVDFfSd8N2UHoo8ojlrDxEMPEaIdOwXD+pB6YCOwOCmKAHgWsBQyxXPP+w1JoS1v6d8
 Sfhg9YyM0O/vZ6jJOjEDXdHCygxIx/NiT+MesosOkzlpOu9zLSKoMBNSyJLWYOjFGPOh
 3FcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774256037; x=1774860837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=eBCwjijOuQmZ4rIYIFTKlfIPbv3VtR2QQ4xJ783eHoiYCYrBmqFuDQ2VnMIsfxc/Er
 0q3Ne298W0NRCicBa5J2v6KDxfcELrHTq/HyLn3jVIIQ/k4330KREZLPo4t7fu/k4TCB
 jr2xLyBnLKBHGDjJKIWAdz1CY4G4c5vsjkD/leh8byiqGrkoQbXGHLG+TyM/2SYjz8B8
 J4O0CARP3e0nTnn8a/z9fyPcHAjfGjFz82JbEIK0biPjjjED4QZ6HLuNsD9daDniV+hM
 gnZ1QdECDfVFLWY6v6dNV0IsWHzGztrmH0cxwsQ4qD49afQ5k2GQy6ZI+HZYy0LvNEzs
 +zgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbActy9X50MABgOv8Nj7R46hrEyqMJ1sEWY9M3N1z4iBEH/P91zv1ahAXcVNPyAQhM4yi0s9h6mZA3@nongnu.org
X-Gm-Message-State: AOJu0YyU/XkRsT1K8GOVGH83clKk2+B8aKvM+diowYAAGxZmMyYquVRx
 hrsULBw2Nyo9txhV/wj60gw0rnBYs796t8gbdx+EfPfYApnaUW0bnxpEivSHFJna4OpbJloCGxK
 3bN++JZcCntoHeG1GGH6cYdHxxZTs/osbOVIvA3c+evfaS7znEWXpFU9K
X-Gm-Gg: ATEYQzxuVNqfs4dkIUcVf5WmFsdNC9iffQcNKqwZO1MDxX8yHSbG9qnea7CalruRhYu
 Z45zUNbKpq4/CtVCEU3f7z4kiKGjJUFcao71vUogato8UusSjvs9kbHXdFK12EwCEuhW8+jBAFE
 2m5IexdtmtP1kMxZ/sz3AQ+/u+p6eMoL9BkBlZea+JkT+OpQ3XTCnNv+BHpWisq9GpHV6FoVOz4
 uqrnfhpfq1B+MgctmJry7/nBD+GLRsihkSOIqjQh2syn2CP+AY9IPHtZvygkqHzD042zh1Ib0su
 zBxwk2WSldf4IQYRjXtnxL2mh2Z92Yw9VMjfCgJuE9njLW+1ZPmkaIvUMotRAPJS3tO38OAZFUT
 Yw6qJFj4aKsMYwqw3puUZKLE9lyCq01iWQ8JnGHfIFIN+3eM7/ijWlPMtw4L4+Pok00AlNdWwx/
 2bdjkDSFUaK8dsbmimJ3Cc9kEe
X-Received: by 2002:a05:600c:a00b:b0:487:e2d:f649 with SMTP id
 5b1f17b1804b1-4870e2df6b2mr2325875e9.26.1774256037039; 
 Mon, 23 Mar 2026 01:53:57 -0700 (PDT)
X-Received: by 2002:a05:600c:a00b:b0:487:e2d:f649 with SMTP id
 5b1f17b1804b1-4870e2df6b2mr2325695e9.26.1774256036650; 
 Mon, 23 Mar 2026 01:53:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm29852540f8f.32.2026.03.23.01.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 01:53:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Alyssa Ross <hi@alyssa.is>
Cc: Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/functional: preserve PYTHONPATH entries
Date: Mon, 23 Mar 2026 09:53:54 +0100
Message-ID: <20260323085354.2083292-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323084739.1013748-1-hi@alyssa.is>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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


