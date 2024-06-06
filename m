Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A31C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 09:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF98R-0006b5-5m; Thu, 06 Jun 2024 05:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF98P-0006Yb-BQ
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:10:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF98N-0002CL-RG
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717665010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hInEEpOj7E0cVlTApX+9OugLawCx8dqYlcnwpECgt8A=;
 b=dzX5mFOqECfM7RSIb0n7y2mYqdQ7XoLHHUg4eQJgqgqTwsp5N3lUwho/tMC220aE/kUmb/
 qxJJ1SesLPIykTyJr2UUlCO24bZV+3+6G4B6IpaZ5WYYMBa4Gv7N6PQ9mCq85Gvsd2Uil8
 mCWd2zJ0+h6+c41nLmcAgL/YlpqSMwo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-2zsHT9IxNXu3Vyj1UKMdCA-1; Thu, 06 Jun 2024 05:10:07 -0400
X-MC-Unique: 2zsHT9IxNXu3Vyj1UKMdCA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-57a5086b835so162270a12.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 02:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717665006; x=1718269806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hInEEpOj7E0cVlTApX+9OugLawCx8dqYlcnwpECgt8A=;
 b=n1zVXhPsM2YfEp0Lx0otWNZCB227DaX30TBuposB+zmx4Q2ZDWgwFEJNbGKEKKXRH3
 8t8M1pzGEEFIVBu90YD6IVGKrjIKbphKGwlInq84pvn+HAVciBCc9LNybZ46NbhyQMc/
 hWpfQXoxAHhkrjiHq7tfSJ2sjLVW9GqNlzyQT9dxnl7FmV1/1pkX/u2cbTyJOZLACsUF
 DwIxbCuXf190Ry+ZdgppYJS4Mbe8lGpptRTqSP7EXkdgmJaHtv/4FIwWF28jRUKDYBjR
 FCHeU/1oIt2RXpisSkpLaq3XviOEJYDW5/u0W58KtCLEG5l7yf0Uk9Vu5ukQaPVmbctL
 JMAA==
X-Gm-Message-State: AOJu0Yxy85Gu3wTfemsYRy3nZXSIv00y0+XUmT5wGcXTnWHQ3iG/w1uZ
 ZKwtRbW5kScH14lQzlWxVUToUtmmev3xenIqvHQSCvgnq4VEQTqAvCn4+gVpcAneZYk5LJJs501
 d63wex8RIjLWRU5SdvTONvtJ6BeJGGeldvoECv/exxSF0en/Z/uAY
X-Received: by 2002:a50:d5c9:0:b0:578:2148:61f5 with SMTP id
 4fb4d7f45d1cf-57a8bcb3199mr3064761a12.30.1717665006286; 
 Thu, 06 Jun 2024 02:10:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdMyGB8aa914d0DSiiHc6ryIQ/pQbaL6sm6w86WwEt173JhUbjLZfHzHLm7ke+/4VwpSqRmw==
X-Received: by 2002:a50:d5c9:0:b0:578:2148:61f5 with SMTP id
 4fb4d7f45d1cf-57a8bcb3199mr3064738a12.30.1717665005855; 
 Thu, 06 Jun 2024 02:10:05 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aadf9d086sm746316a12.18.2024.06.06.02.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 02:10:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: John Allen <john.allen@amd.com>
Cc: qemu-devel@nongnu.org, yazen.ghannam@amd.com, michael.roth@amd.com,
 babu.moger@amd.com, pankaj.gupta@amd.com, william.roche@oracle.com,
 joao.m.martins@oracle.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
Subject: Re: [PATCH v5 0/3] Fix MCE handling on AMD hosts
Date: Thu,  6 Jun 2024 11:09:05 +0200
Message-ID: <20240606090903.2464525-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603193622.47156-1-john.allen@amd.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Queued, thanks.  I added a note to the commit message in the third patch:

    By the time the MCE reaches the guest, the overflow has been handled
    by the host and has not caused a shutdown, so include the bit unconditionally.

Advertising of SUCCOR and OVERFLOW_RECOV in KVM would still be nice. :)

Paolo


