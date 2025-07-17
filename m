Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C67C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 15:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucR06-00059P-T6; Thu, 17 Jul 2025 11:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucP3Q-0008BM-5K
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 09:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucP3M-0007un-9s
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 09:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752760416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=hF6isSrCp0MAqcL83XiTrA9Y5/5rEcJH6y7LNtoyZBS5BcNbeaT/xGMQkD1/j8ZDLtwRn4
 wtNgtRg+4ZrrAwXMzcE8/s0RIJpqhOPONDzmYUrVOTnD4NqW6+YqKv3ywsygMq4iyPNGjq
 Z2NuAG/LVp9P982XsufRCT2M8iE8Yts=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-pVNwgKc7MWm1g3OEEUpj7w-1; Thu, 17 Jul 2025 09:53:33 -0400
X-MC-Unique: pVNwgKc7MWm1g3OEEUpj7w-1
X-Mimecast-MFC-AGG-ID: pVNwgKc7MWm1g3OEEUpj7w_1752760412
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-451d7de4ae3so5642375e9.2
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 06:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752760412; x=1753365212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=pDwi3QZQZnw8M9eK2mGav4L43Cj7Y3Av02bDzY9z4cK1kiDNpYXRji9frLdDT+dMcl
 XMXCm/vuFI3eHguY/7JrsUWOhzoRFWnrqbwWhNl+jCRZ3sVa/gh+N59eewFAryZL6hKC
 rL4fxer1u9qSY8gRs4u4PaHdbFUES+sq31EGfP/3cyE7UGu2chaCmCCRNLUhO2kn/nAP
 UQVVxTTSGqL1pWXqf7ynLYR8PqYxe+lE9hPYOgV0fuXpb0AbURU+SOC6tUCDZyGNikRK
 pjgGCuQ/MmMdzvvkdKsff0Zvf8O68BOdajiFEkP4h+gNA0OoBEUQGThCXUwaFH+5iGKT
 cDhg==
X-Gm-Message-State: AOJu0Yzn0zTsSFwXNtwvf5psi14Q9bjyJSYSVhMVK0jAUJKwFNPdv9tF
 g5ZKeuFnrvwlvN1fA03nAGBWirJDP3RZ1WikAiwGVwvG2wLWBrSlO4Kl07lEPojJ2Si7h/76bTS
 P6Hh5MfH7tbuxnjSmythIH6EJ5EOScgGKElup3JSGzKVMaV8OoqHWKa5y
X-Gm-Gg: ASbGncvgfbcSfqMNgBTg7+aUSqZbCHoPPSK6xOS/90VyV7gDG9kEbExB/5EcoYjE6IV
 TiMHNNUocnh/QZ8eXNonJPovQyjhwfwBBvQgw71763//O3XKhjZKpjOx2TzTPDcpwAhi7ZfiWAs
 oB8iua66RKy1j5bhPVcSyhciyKFWQviPXOynhoFNapTlwtmoepdWpmAUUcDfp5VfMQKw29971cO
 eoKdlQacDvjxH/QRP6XqIW3O2T9kCDuWbFq6cdBc1uS1axxeOnUIEGZOxiDesEqcvf7dgxnIZdo
 ijzMh4Sw/jnNJ2/ZRkCVXtOmoKMxFa8LYmj8JFcdn/U=
X-Received: by 2002:a05:600c:6295:b0:456:191b:9e8d with SMTP id
 5b1f17b1804b1-4562e047133mr76455395e9.11.1752760412412; 
 Thu, 17 Jul 2025 06:53:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVwHQhdQ54asTnU5TidJzmmjsXJ2wOgqzCjzlPXgynDVhJQhRSDgA6ztMnEpZ5NlAOzzbfnw==
X-Received: by 2002:a05:600c:6295:b0:456:191b:9e8d with SMTP id
 5b1f17b1804b1-4562e047133mr76455105e9.11.1752760411990; 
 Thu, 17 Jul 2025 06:53:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc201asm20662291f8f.22.2025.07.17.06.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 06:53:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] i386/tdx: Remove the redundant qemu_mutex_init(&tdx->lock)
Date: Thu, 17 Jul 2025 15:53:30 +0200
Message-ID: <20250717135330.343030-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717103707.688929-1-xiaoyao.li@intel.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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


