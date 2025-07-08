Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78359C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFI7-0004bY-1J; Tue, 08 Jul 2025 16:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZEKg-0000AC-Us
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:50:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZEKd-0007y3-Rk
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752004222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=N/8qBNEqVd/EnHVo2q7ZEeTa42k9eL+tK4HQClmIrpM3LnkC8ZXk4Ap5F81ysWd8GdPRVN
 F8Q/fc/ZsGe4huYcaOAh8lC8uZzGg/h1kEDcEdM+fBEUsW6RT9Dn031PNIjNd5nkcBDwV1
 nNdLUGkaZa/iDdQmMEbLd4CsLN1k45o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-70A2BNhAMYKE91NgiTSGcA-1; Tue, 08 Jul 2025 04:23:01 -0400
X-MC-Unique: 70A2BNhAMYKE91NgiTSGcA-1
X-Mimecast-MFC-AGG-ID: 70A2BNhAMYKE91NgiTSGcA_1751962981
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45359bfe631so21253675e9.0
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 01:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751962980; x=1752567780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=oaJndiUq1mcsxLz7xo27N2nUQ3NADvDXgEjA4Xhc10aBH5X4r9mEJJnAghJaP4LnCl
 9qm/JP0+p0p7dh0SfG7n0IvIluCTmtd86QEEqGema+XgrYZEdzEnY/WYMQjcvJynGniH
 D86OWbUJt/KyiT87S6bpNcSD5ur23rEwcCXfSCShrI62IP8ESOjlncAyRa9H2CEnmUEE
 CzVM+8xHXH6uHGXR/3QPxI95qLkcxIFpXOpX6NW3e792y1toa3EGPfglIkap9DP7n9Ts
 df1FfSSOPoiAg0QFlgA1yIkl15g04am6Ui2gsDBxAyPQ3skEszMZb0ifR8yF0EAk0qyh
 cGqA==
X-Gm-Message-State: AOJu0YxLeO7zHEK8MYz0O6bohcGw/4YKKbHXU07PZtR/zpNQmyyAuT/y
 4ywHIMrXj+FYScWLPO9Bp9hoYoMyFEFgPp2qFtFO9caJILcUP/CZ0m6zk8QnQ8xElqdB35MSw7E
 6wke9gEakT/+TKalPHBzFc+vYxyFED05Hd6nleb/w9kVxUc3VYrh987Jn
X-Gm-Gg: ASbGnct7W+aLWL2NGvI9LPHmXTnBEZOzf7m4GTV3Nag6iVzzechTzLWFvTKns1Ij71S
 3C07f71Ct4JPwyPLvnLQg0FIR8PGvQi/RZbKKqXWxtkSXlOjJiCowqyk5vHAEXKLRwUxbdIcaPz
 rhnRpVpG7YyGSbvWuYVNRnBOFYFMCyAxafIFcViR+0omOQ5BDIIP6T4SDjsDflxe3gJoK4z+p9e
 FZmsla2yG00tAezQGVWaRoRlnP9XvhTZLTVwtPQjqkeQAdFIwj8ATiRGdDDVaJYbTPuFEtUv4JD
 9lNJM5AfK0tu1K8rzQhKTEmmSRE=
X-Received: by 2002:a5d:6f02:0:b0:3a5:5270:a52c with SMTP id
 ffacd0b85a97d-3b5dde2c12dmr1503894f8f.0.1751962980527; 
 Tue, 08 Jul 2025 01:23:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoO5r5PAEwXY3US8uMGwHfMflXhkQjvmGjfATC/9KOQfbHkmPGy1gCREThPux5hLq6uYu3XQ==
X-Received: by 2002:a5d:6f02:0:b0:3a5:5270:a52c with SMTP id
 ffacd0b85a97d-3b5dde2c12dmr1503875f8f.0.1751962980115; 
 Tue, 08 Jul 2025 01:23:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.202.169])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b470e928aesm12105531f8f.44.2025.07.08.01.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 01:22:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH] rust/qemu-api: Fix binding path in source directory
Date: Tue,  8 Jul 2025 10:22:53 +0200
Message-ID: <20250708082253.49038-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623073436.1833357-1-zhao1.liu@intel.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


