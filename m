Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D81C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 19:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEYQh-0003p4-3C; Mon, 12 May 2025 15:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYQe-0003oo-ST
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:03:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYQY-0006pu-No
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747076580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=C9JD1Nu3JmfWRC5/S8nZ8mn1ezcFc41GJw8wqDaIDQXS9NiXx6QLby6jCL1MkoiiZVXnl7
 huaTemnvBicynQB7eDvhEsMUBKG+7Z9haGslvLJsqrOJYC0a/SgTpgSVjEbhmYv9RYc+cg
 Bt6rr3yluRjq2Xrk67UhCXR6v3EMiGc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-fKXNIOceNmG5SsvGOUT1dQ-1; Mon, 12 May 2025 15:02:59 -0400
X-MC-Unique: fKXNIOceNmG5SsvGOUT1dQ-1
X-Mimecast-MFC-AGG-ID: fKXNIOceNmG5SsvGOUT1dQ_1747076578
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a0bcaf5f45so1411751f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 12:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747076578; x=1747681378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=keYsNMjBX9XxqBc3m0ZByoAQvxdXxJmLPNb27y3fGlP2g1sxji66tseFapjGEA9S+N
 9EOuEzx32pAbJE6TciSoo4RZEXSS6CeombprVy9fH9bbobjSQekSoJRfJFnnk/rI8RIl
 5O270/wOjzT7VeBnNnuTK7KseaHec6RHdbP9wd/Q5TFXs7Ww1AtAXwvjbEJeokvT/uB7
 0abSVIuX7EBokuTvqkuvZOrI/XeRZ/1V2Xrf/bzrXlDBqDK6X6YZg4dWynG1FxyDFHol
 qwhqP+xYyx7B9Eyms8OBmRjfb5onMZ6O2HzzmUq0tlCKQC3CBtLUuia2KADC0d7VBhna
 fe4A==
X-Gm-Message-State: AOJu0YwhHlmF2k5nWfKkK6aO13iFnobzmb207UqSHj9zSlxxcFJyvb6C
 E0xZN6MGaSpQ914wlz6/S/9C7zzpZKBaU8eu/fk+DOgwzb1sruDTmxS+iRnRGKyglUbuZPlgJ8/
 H9jYYh79zoTgK4Y31DrN14/Lw+xtDnstkOC0JWCogPRWYTJBbvy9vcULsMX++
X-Gm-Gg: ASbGnctnqR8U4HvwYmXndC7f8B5J46CGWJCNAli8CL6I6oFhuriSzULEsG73u4O93+5
 nDG8QT0+sNSWR6LvCqb5p3fxerhmAuBO6hE911hz0Sc6DWQ0cl/DcMpl6bI5XlYy8zdDgEWmeoV
 yjs7snMiaX7bZDImplD36Fzka9HBKO1FDVMAAHm4kWGANEwkFep89+RHocaF2hyJHb1CRanG+5K
 sVySFI7MpOAHFV1VRlzdjNvVEJLNMTzDeC6o71BEob8eg9VNvqVreRZBo3654DsjD/yx5aekzse
 QteBUFDlmYpFI5Q=
X-Received: by 2002:a05:6000:2902:b0:3a0:aed9:e34 with SMTP id
 ffacd0b85a97d-3a1f64eecc6mr9768160f8f.48.1747076577948; 
 Mon, 12 May 2025 12:02:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/+HGER5LTUacggyNiy4HFGeNGthHzqFlbXskYNxH2Ol9w4LcB3g6Cqyu29GN0k/OwyNiLpA==
X-Received: by 2002:a05:6000:2902:b0:3a0:aed9:e34 with SMTP id
 ffacd0b85a97d-3a1f64eecc6mr9768127f8f.48.1747076577524; 
 Mon, 12 May 2025 12:02:57 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.45.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f2a79sm13183019f8f.48.2025.05.12.12.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 12:02:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: qemu-devel@nongnu.org,
	Chao Gao <chao.gao@intel.com>
Subject: Re: [PATCH] target/i386: Make ITS_NO available to guests
Date: Mon, 12 May 2025 21:02:54 +0200
Message-ID: <20250512190255.178968-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <8c1797e488b42650f62d816f25c58726eb522fad.1745946029.git.pawan.kumar.gupta@linux.intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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


