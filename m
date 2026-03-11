Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947851125850
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0M77-0006io-CY; Wed, 11 Mar 2026 12:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0M6n-0006HP-1t
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:08:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0M6l-000743-CK
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773245306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=eBrjzVVD0zLJ6B9y8zZmBzsOWwTyHWBoar812uanhfOQzcRPVDvImsTcZunmscg/CNDoKm
 VIdotFyuPKT2E0yNatlPLnp6qDSjPyMnt+mcjdlCz3dlUpr5mpGD8lAba9tkTveexDj2z3
 AD9cDBhOus1HmeKc1QK9o3MrOPEdxxk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-AOSqldGwOP2sOfMFsbQrIg-1; Wed, 11 Mar 2026 12:08:25 -0400
X-MC-Unique: AOSqldGwOP2sOfMFsbQrIg-1
X-Mimecast-MFC-AGG-ID: AOSqldGwOP2sOfMFsbQrIg_1773245303
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439b3011be7so25441f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773245303; x=1773850103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=JLPVFIMiVgR6Q0uLHoPod98ejwX/bm40sKdLRPPHpXdcYytssfdiG41cLRzZvuzyM9
 99puMxxMEpKCNAYl87xPC2oAlMPGbbVHWmQt5Cx6ml4tX95wkhcmQ9D/G0U+O9bLGj4c
 xG5CyTCTM1KTwixAe2NqzA+DnsKerHxSPp1CcmJz+DXkurXnXfadDZsxbiCJzghARkJj
 F2sQPBsi0NhzpUMiZiiyzVOPYkJqD124TKvcYSwB6ViADOOs/kJmnaEQqWqq8SlsmC1D
 J8xhMjfEqlSDnAF/wHp1+YX0Y/0NWeQlnDAGPhoua1rE9yOsazWmvxWk91PGVyKwzOCN
 d6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773245303; x=1773850103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=ug6maV7jChCv9uhXgOIa9HGMGXCpHtenYDmsq/gibJC2yMIcTyhY2cREIr67xy1CJ8
 HsNd2zXpjYARnqOCEqmMpjR6K+eMueQQ+COIW/A3E/KIRzQk8h4FJYG1vcIbttQLl4eg
 1E49ELY4NFl5aDCAvrTMAPBuiGJXyRdvV8fadpYW0z+51Vx3iV8jVpmHj1klLKE8SnhV
 w1dk5v6eSYA+SFWMKhL/E0gcmJlYp2JrxjN9EgHM5Uply46FswVjfzk8jqmMzPzwZ+7l
 WcV8J1MtEa6MaNiPuxlA6U5yW3GRiIP3gJROy0oB3OhNu4uIiHHYmMUl5oMH3PFK38XU
 Xx1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9zZfRByrIfdX/o/hd0E+xu/+akPp5l/WwTNs0Y8rOmz3ku/02yNfpBXUzk4tQxHXuCMiiNZme8JAi@nongnu.org
X-Gm-Message-State: AOJu0YzigSrCz3O3rkIfLET5l6+efbhHmipTAOcy/JDTNuv7MuRpYXYh
 yS35L+325YWmwnsiXZ98XnqtCZMissS4vlL5zrSlOtcNEmHeohMLPuo9FuqszJdDy5b1MV/fm1B
 x1IZQanJjYV8VKUX25qp4BYbJ/r7AWfuk6DyVUHROg4Hm5q1h9Vq8a4N2
X-Gm-Gg: ATEYQzyuSeAHEBfl9zsXCUR3gehWLQxO7wV8xJTOxoAP88NryBZVugNqQ1m5IC/VOmf
 PIIwVKWkxIdsqDGmia01OBtzGMpyTvffgDP2GTpnxH8GM/+QV2I/8OJOkGvofFGAuGsC+UEM+mR
 /pFJy9B/eykQZIQ9VE5Dpw2j3un/wfidU9+WttbGvCpf/0rcWc1Xbo+SSuVY47grPSLSOBa8xQT
 COkHtHPGiTjzYMceWaeFygxTW2xDsBZr6aX+Uyiuc2jaO/BnsQDGxV7kg4XlscZY1GgJMSJJ4Re
 VmW+jdIYn0JKzjwaeYkdKLv8iFzDLXPxrSZhrI4dA+yCSXMK3z5py7Q7JPh+o0vYPb8zkafD/DI
 mNENGN4kiU8SkLOq8Z/a2/bhAZJ/A6lKqEI07vPaXOxU2heBgvdk2Lrzsbb+JZ+6VjxXJmUMdCG
 alr1L8QP9+TRB63wxfKhTrYGPoEk8=
X-Received: by 2002:a05:6000:26c9:b0:439:b59e:5e6a with SMTP id
 ffacd0b85a97d-439f8204ad6mr6007651f8f.14.1773245302745; 
 Wed, 11 Mar 2026 09:08:22 -0700 (PDT)
X-Received: by 2002:a05:6000:26c9:b0:439:b59e:5e6a with SMTP id
 ffacd0b85a97d-439f8204ad6mr6007585f8f.14.1773245302219; 
 Wed, 11 Mar 2026 09:08:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19aec5sm232987f8f.4.2026.03.11.09.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:08:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Alyssa Ross <hi@alyssa.is>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eric Auger <eric.auger@redhat.com>, Miguel Luis <miguel.luis@oracle.com>
Subject: Re: [PATCH] target/arm/kvm: fall back if nested unsupported
Date: Wed, 11 Mar 2026 17:08:19 +0100
Message-ID: <20260311160819.555999-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311095405.26297-1-hi@alyssa.is>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


