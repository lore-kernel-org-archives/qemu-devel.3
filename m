Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39219CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 17:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBcl8-0008My-Pl; Wed, 22 Oct 2025 13:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vBcl3-0008L4-Tw
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 13:36:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vBcl1-0003Ah-DH
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 13:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761154577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=SSLMorobJ4gholRaUwzyGcxjT/VyV8bAAcK6VUrwKUDZy92bYL/Hl5TG/iyunNI3ZhS25u
 GUv+nblRopWkoxRh5+K4vwptXyG/F8x9PV5YOMx9OvTEY1RdpQ0YUXYDiVTpEK5bvxLVvk
 RazPyGRsqjT5ncbFp8sdlgdzexAsW/E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-qU5IJ1hpNZagnsW5-WJEWA-1; Wed, 22 Oct 2025 13:36:16 -0400
X-MC-Unique: qU5IJ1hpNZagnsW5-WJEWA-1
X-Mimecast-MFC-AGG-ID: qU5IJ1hpNZagnsW5-WJEWA_1761154575
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47111dc7c5dso6622125e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 10:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761154575; x=1761759375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=ImdybmZOEDmrOTRnw2FigN58UkaZnGwZBWJ94V25nzNCetK76qCoFY2rgoiZS4wXeO
 bL3s8/XnG9rVCon/CQ3ql6qC5qNFugdTeMpwLqr1YC3aiAr5lPMFIPmnAVj7FOjpgoY+
 MNbwa4LgFHNCOPpfXDBIptwaf6jZ9dkhCe4TeE6vdFcQHalmZJS8zHJDbmwj9ZYnB3ED
 aKDwzQt3S2mWkcGrL939S85G82s2mrx6z3IY2ItVUu+AgR21nyrwPeWd1ST7923i99ug
 c4ylpiJX9yzZ3hT+jAeYcImU7MEU8gNksI8gukue2zDXkMV/Ymc9WK3yuBOYIQ9B0lAv
 +EgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI8WoQRn8gNnFRHV6MharSRTB5EHy/kSe1gNz1llKTDBqwuLosJdwgZCbVRjOZ3rvte/xWSaTx/uCr@nongnu.org
X-Gm-Message-State: AOJu0YyPEoMWnbzycmSoRX6I+MmDXAWE6CFmtA2T0ejU5DnI0CBQPVrD
 pTgKXR1qkUtFblcNc+KXmzkaQZp0OjrHIkZBsIy0np8x6kU0VoTghI4VcNCr/h97exWwh8F89lh
 WW96BVnuNl4I3sbfj5YIRmqtGjGDHfheHWjHccyYBEzywSNnneWZ2mbTf
X-Gm-Gg: ASbGncslaqHTUOZOtfCP01xcWnsEwXVV25uebn4huYeKxOiIJY+wMUK9Aco+uzL6lgz
 t+pwAKkoLkta1diyirSMpBPh+kKsk4OnXKkDv6wkC1mEliZhNpXutk2eACCdeupjA4v1Jw3j157
 NduYW6hEJz50nslWI/yOOj4B2ko0SF/kpsF8L8kwpCvm6HLyQOiH83RqsvOkhTT1LecWCcudY4M
 0+u3H3m7tLXBHcFg7ZiDmvTdPrYfyrt/LplZ3Q7o+TenFl7pLJ7My0MvaXRltova/3l2jtJdL5C
 uNKzTytO3KKHjA3tXz+5spkdCXELrI/ICKjOU7vFu545vJXRRw8S9pDeyxWsfxVj+B/bQBzm3mD
 2GpH8vdt1sqP17pRBzqoCFZAQdywwV3bqY7iilSJhf2no2e8yW5be/IbPwmCqt60/tH0qiUmyv3
 ZfPg==
X-Received: by 2002:a05:600c:c3:b0:46f:cdfe:cd39 with SMTP id
 5b1f17b1804b1-475c6f69890mr13693425e9.16.1761154574705; 
 Wed, 22 Oct 2025 10:36:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFasCleFY00GBTgRhugdydahErUK9wtBsmAM57Qf2Mi4Ap8L9ovv/tQBeqyBs31CTc1xL/6dg==
X-Received: by 2002:a05:600c:c3:b0:46f:cdfe:cd39 with SMTP id
 5b1f17b1804b1-475c6f69890mr13693325e9.16.1761154574302; 
 Wed, 22 Oct 2025 10:36:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427e1be5d6csm25899885f8f.0.2025.10.22.10.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 10:36:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: pbonzini@redhat.com, fam@euphon.net, farosas@suse.de, lvivier@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] esp.c: fix esp_cdb_ready() FIFO wraparound limit
 calculation
Date: Wed, 22 Oct 2025 19:36:12 +0200
Message-ID: <20251022173612.3774498-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925122846.527615-1-mark.cave-ayland@ilande.co.uk>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


