Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164A5CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN9V-0004Fp-2J; Sat, 30 Aug 2025 11:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uruKW-0007Is-Lz
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:19:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uruKT-0004Mq-Dx
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756455563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=JFFXdwueCYCM4P0zy8YPabll7KNDP7noJxcQRZviqgPnZt+jje7nd/Gbl5Z0KnFnMr0HlP
 q5241jHdAqIAqgoTlgeDXxEDJxFKgLDMIMyLEjEbBuifc04Jtw7h4wUid5vTufV7G81+yF
 NqmmbxZL4I4ML/m9usR8cXXTDw14hM0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-Xnlwbth9NP29gwT0KWCbxw-1; Fri, 29 Aug 2025 04:19:19 -0400
X-MC-Unique: Xnlwbth9NP29gwT0KWCbxw-1
X-Mimecast-MFC-AGG-ID: Xnlwbth9NP29gwT0KWCbxw_1756455558
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3c79f0a5babso780929f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 01:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756455558; x=1757060358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Fp5nKBBMEzwZdR43G3gW2RKfCR3YuSX0gv0VrbfuKE178HmIGt7PDpTHa+4SQBIQXJ
 LS39x1k1ysyBVCTDLIL9mpx16F4PHVZHrKhGMdJRuXnWortVEt2E10h9EPQUSxy3c2C+
 VDtT1Zu/ZIerEPRVGWnLqjqUtobso6DySkg0ZvTbdbnQdVKIwzDNbvbWES6Q00ujS5Cc
 giCujubFN+N+paOhK6N10BpCz/HvErtxj7/L1bXm4cfO9sqrarCjzrPA7NDMlUvc9zov
 8YDN9bdarAmVAcKnqYXr5H+CsiR3JNeTWV6qjup/TzMt0NtO9AdS43dwkYyHuqSW0D1r
 Cp+w==
X-Gm-Message-State: AOJu0Yz21PbIuxYvCHrdZUhlOnO4MyKZ8+Bsr4BdPOGb+7qEEfiuN910
 3nPjJny9VRzIREv1xtSkhoTi3KolKBwKGUeptnL9NT3jaqozDyW41YxsuJDedtXewnJ7wmCt/Mo
 CZDwhggLkyuuWlQG9sA6JE5zEIq4qsEp9+om/BOYLT588GP/fxxfjL7Sm
X-Gm-Gg: ASbGncs7xOlMzjjLxCQSw6C7u89f3zm+yAd+oqkp+mnzRb7L8IAw8vkKYbOwOVHQUgP
 kEdZ+yzUdIajxDlIeTBoJKZFrx5Z2irsqrzQcUCWLR0Bp54n+XEA6o+EZkfy34iB8HYLrCaa3h7
 oLXKtB3GrfmFMS378aMSZJ3/TpkGa9f0/M1aZXlei5G0PyVBD2oCtsstWrFrF+PkJufmvo2st0q
 DJfARe+zXlOHvSDK8jcgjz0xzWfG+Ti3PD3R7lnxM9qDYp2t/5S21ZBcfxboX75sVEuTZUj+m9V
 Le912ELwFPzSGb0HXE5ppaZ63bSxAsryUL+DrmikhxozBueabROqZzUB8QJck193YXu46ZZVwV3
 JY9SLsgB/oYLgz4cr50YKTnd617pe0XrhyRbHDHwmZHc=
X-Received: by 2002:a05:6000:2204:b0:3cc:3d4b:7fab with SMTP id
 ffacd0b85a97d-3cc3d4b8185mr7865097f8f.37.1756455558068; 
 Fri, 29 Aug 2025 01:19:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA7O5y4yULntF+9p/AonOP/mwXYLFprwgNhnfZ6VHS69MzRXArkf86v63diR/R6FlzaPC/cw==
X-Received: by 2002:a05:6000:2204:b0:3cc:3d4b:7fab with SMTP id
 ffacd0b85a97d-3cc3d4b8185mr7865080f8f.37.1756455557660; 
 Fri, 29 Aug 2025 01:19:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf270fc0a8sm2412958f8f.7.2025.08.29.01.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 01:19:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, mtosatti@redhat.com
Subject: Re: [PATCH v4 0/8] Reinvent BQL-free PIO/MMIO
Date: Fri, 29 Aug 2025 10:19:13 +0200
Message-ID: <20250829081913.1424737-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250814160600.2327672-1-imammedo@redhat.com>
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


