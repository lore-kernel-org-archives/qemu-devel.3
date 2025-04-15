Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA49C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 11:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4eDB-0006Sz-0C; Tue, 15 Apr 2025 07:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u4eD3-0006RK-MP
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 07:12:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u4eD2-0006UN-84
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 07:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744715526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=QKGxHrj6JmF2GXpT+kw9ed834RrpeQhPfnAr4hs9IC9o669AuNdlruD9gelj/xOWmikkuX
 pEZ7MqcuS7p3BigVZV8dllydkjOp0CCsdFmNBdpSwEQlBQabvUfhS8hzyroxioKctjnkRo
 Upo/c1essLi/0aUxvI9bdErTbaPVwNE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-aGgQ3BvYNWavf7_ucEP2Dw-1; Tue, 15 Apr 2025 07:12:05 -0400
X-MC-Unique: aGgQ3BvYNWavf7_ucEP2Dw-1
X-Mimecast-MFC-AGG-ID: aGgQ3BvYNWavf7_ucEP2Dw_1744715524
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43e9a3d2977so42897565e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 04:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744715524; x=1745320324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Cy7FWIoH5k7USh9bhtktZqjn4fjphpHQPUOrWhSXrcnIcvsvfl/KQO+wJNTtT089o0
 neDU9d/z4t7HdYI3MSUV4XBZoHWN5KC9i6Vs/il1dcD7SiZibPkkwtFt6/n0Ae+55l9G
 tXXPJycEa/m+vk+m6OipsptipVWbnfUwEQ4b5z7Hx/HBIuLtkSTkZS/7JNoGsfZBQcuX
 EmhGau8X0Of4MVcZiU1L8vE4wExTH55tLo77Cq7UzkBxjSzR4vf0AWxBjLYDYTOKVRhG
 l9byytZdB6Z6/B/cBGKYhvqJ3NMxIAuCVWLlK8WJH+UOo5W0g3i3icI7bPqW/hpcd+6C
 /sug==
X-Gm-Message-State: AOJu0YzEE8bppSSTCFvxfrTz5INF++sbWbW7e3tEZ9PHtg1tUC5pr2Bt
 H3cgHMrmbeI1rdQDDq/s+8eH1/KBiDWx6YsrKco8Yuy+MJZxBXcwemdCURieRNBmcU2Pn3Hm662
 XW3n7bl2PdhfmSH26HqintvRtzvjhdwhmEQmpacTY0RBafn1rExEv
X-Gm-Gg: ASbGnctDrBeIBSUiwr4jmhCMwNIPNJQoafhf6upsrsDbsTcmBBNQatO7m8JpKAKkwYT
 xAjgpavqq3MAZ6Z2NlNeTVe0wNmRyI6KCQC1vux4CGaxum5adU6OFifgUsfpniyigQZE8IImf7A
 Nykz3fOJObFterXE32TssFYG8mv9w4iF0M2GR0IJQ/eMe2frQ+jctXZC+h/UWD20ztjMVyLkSL8
 lnO0poLwqxUix6wvzPU0EXznfO+5+ULUVdyYbKrIHy14vPj5L1mP21Xs83xLCCs0o2TUGavYVl6
 U9QIMqJHfVGxa+s0
X-Received: by 2002:a05:600c:8707:b0:43e:ee80:c233 with SMTP id
 5b1f17b1804b1-43f3a9b485amr127713265e9.32.1744715523839; 
 Tue, 15 Apr 2025 04:12:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgA6kQy3E2LGCgxlhxttRwhpUwSkRHP3sSW/YI3zJhc6Bt7IzDZxktcu+Yi0hij35Yon4ttQ==
X-Received: by 2002:a05:600c:8707:b0:43e:ee80:c233 with SMTP id
 5b1f17b1804b1-43f3a9b485amr127713005e9.32.1744715523456; 
 Tue, 15 Apr 2025 04:12:03 -0700 (PDT)
Received: from [192.168.122.1] ([176.206.109.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f207c90b4sm212974125e9.38.2025.04.15.04.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 04:12:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Rakesh Jeyasingh <rakeshjb010@gmail.com>
Cc: qemu-devel@nongnu.org,
	pbonzini@redhat.com
Subject: Re: [PATCH 0/2] pl011: Refactor DR register handling in Rust
 implementation
Date: Tue, 15 Apr 2025 13:12:01 +0200
Message-ID: <20250415111201.732420-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407181327.171563-1-rakeshjb010@gmail.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


