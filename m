Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92653CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 07:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0xoa-0001c9-KU; Tue, 23 Sep 2025 03:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0xoW-0001aY-L5
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 03:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0xoO-00058E-4Y
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 03:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758613901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=CBNtnEJatmO7unBqDJPdqh9Y4QwLG7xEktgJHQj3jn+/0CdJheLD5y4dL0QjctCQdOo2/H
 bksclq2mmOa8ggtqe6vg+aJ6nB1BY9NlL/oDkdg5Omb9QIiiCH4JUuB8Ai3WQbrguTdM/L
 NfZFadpXlP1cCbIpwUsNacvlwWgXJ1A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-f8Y33y8FPmi5n142AyyxIg-1; Tue, 23 Sep 2025 03:51:39 -0400
X-MC-Unique: f8Y33y8FPmi5n142AyyxIg-1
X-Mimecast-MFC-AGG-ID: f8Y33y8FPmi5n142AyyxIg_1758613898
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-632ee8486fcso1466186a12.3
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 00:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758613898; x=1759218698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=q631hD72AEkhu03e999tNdg9isIwLcjpDfqKu6s/s2j8sbaVpGHdgVaRAg+l1HBBIz
 3eGJ8hxEvdhZUtHVxgvrB3XJ720v9PdKi8M8Y80OjRTXzEAZReAB/JVwZiHPcyt+h6wG
 fVldyT8mL1CwzjcuO0ESnJMlD1Je//xnUjYLdtgqBH4Nt2WJTpYNJZYne20dXNhUtAey
 e0WAUvrFnurTSt3cwyfWHrZi82aV0RubIxAFPDYEgZ2/HSUYHa0YYGlR1zrP+HwuUbpG
 eE+BGOLKir6IqRpGIuV1QdK436OBfa+3p213lwmpAG9RqzYcRKOm+R4e9gm2h7SDeBfc
 +vjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfNXSRufhlWSxxNGZwf0a/65I1K/i14mBqmch+JtUuZPGcKNT+UowZVKMKf0whUJJ+rM3mbyOQBhYg@nongnu.org
X-Gm-Message-State: AOJu0Yxy3lndoZuyxN2W86ZeSc4RFPN2tuQAdKBpr+gj1nC9WdBi5T5V
 R+YxAK58If3COcb3fK6I9b8kdaTX7wegjC1Iz/0/VfM9hTa/5vQszLpyP3aPhVM8d7eemqOgHXd
 +cxRBbgpRuem4ol133zz2s7lRuv9fSuQ3e6cj9MPvg6rdU+YDgHLW2Wb5
X-Gm-Gg: ASbGncv4DTEkYWaR+WxG+mexdEXE4fpAAohQKu2Nrzof7pG/1Br47H8vJKvBG77Fx+O
 i4Cxft8X4ZW+qxxhqsOiqRuJZRwJuKoHeTSXXvFhdoKz7viJ4hSyxBeog9gUpbHm9DjHb/c9ige
 1/ZgKRMAJziwvM4MrimyrsX4e5IPC65o3UjtKxxeAfvFL2USWTw9ISAq0M7JB4zyPr2VqbtihRl
 L5sDBfLiZqSKT2Iu9Svz8nc/mTmOJuBbNxT7UFzXsGprQedCo17BhYVbjqTIPDVw0VuElsO2m7l
 ItIntpfudsSSLXHD0kUEcqR0KfJ6Fv/J5Ep0bpvTISw+kWxMulKxbZDKTISnaHzFjAnFkJ/nRxL
 9fc5rjawzFrFNruf49JL3uXI44c0YtcBuZgCTejcLY3sG7Q==
X-Received: by 2002:a17:907:d91:b0:b2e:13a:8d75 with SMTP id
 a640c23a62f3a-b302ab33ab4mr135598766b.32.1758613898281; 
 Tue, 23 Sep 2025 00:51:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2PeKe2akn0K57bYEKnScjXMFiKE7N/XpVy5p726qyaC4MRFbv2NlHDs52lzZIvOOiT94VdA==
X-Received: by 2002:a17:907:d91:b0:b2e:13a:8d75 with SMTP id
 a640c23a62f3a-b302ab33ab4mr135596466b.32.1758613897828; 
 Tue, 23 Sep 2025 00:51:37 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b290caba5a6sm692046966b.65.2025.09.23.00.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 00:51:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 00/12] rust: miscellaneous cleanup & HPET #property
 conversion
Date: Tue, 23 Sep 2025 09:51:32 +0200
Message-ID: <20250923075132.90995-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920160520.3699591-1-zhao1.liu@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


