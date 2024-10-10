Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89369CF07BE
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 07:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1synzZ-0006XJ-Cq; Thu, 10 Oct 2024 03:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1synzX-0006Wg-IN
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 03:53:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1synzW-0002NB-1U
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 03:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728546825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=DYQz5xQVtW/o/WsxjzJDkPZ+C7H+2vASnxqrO7Zw/8c63uckXgHsOzVfcLXHcRHjf1unoD
 NuFm/fg36MYyALH3FPkA27W19UPQxgOGEnqwLYRGkc3qA3DNhp2u/OmR4/w4YjVXQ9a4ha
 LJRssJbrkUqlCIzvuMnJwDtBkswe75g=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-9tqAzBc_M8ikvXIUe20XHQ-1; Thu, 10 Oct 2024 03:53:44 -0400
X-MC-Unique: 9tqAzBc_M8ikvXIUe20XHQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5c91ec6a169so407435a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 00:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728546823; x=1729151623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=s3lmDi3bmbzAU5mClwsoRbDze9cqT/mZCkY6tt7zWc8gtJiVz7GB4AgwW90Mje0+Hi
 1jYEvHaFYByY3pdqjc0PY/vzg2N+KjMkKBT9mnCU2zacwIUV4RBYIp+iRgtp1OozWhp1
 lKpHx88TuKBe3UOeIBMC55d8QzmNNuG5+nTYbbh258sQXiecK3XtMjPYmza+RfmPxsLJ
 Updu1+3nnOoMurTWcHwSs/DImlCU2lgvELjcz2fEe+7OnvG/O9gfbhyULK647D3i4icQ
 J0yzMfU6s8EJ8RdAqETBb5rd8Kk5fFDs+qtTGFu5AypEw8aVN/Cs8LbdU59DppS5CuAi
 bZAw==
X-Gm-Message-State: AOJu0YzRDyp1Ag4P+rUobtGPEm2mNryJ8cOPSgQjzstscGt7t6n9DIHv
 rXZ1ZuhP/OKfGUMMwpRhe6u77Xto9U8TzGhCxL3Jr23J3C+SUdchzOPktPpAb1nuMTekTc1p1G+
 EVjNdurxWmdT7oF4+s2eIdd1pDbF8OeS4OHLSsShc/e9qZTD4jKXN
X-Received: by 2002:a05:6402:428e:b0:5c8:a117:b31a with SMTP id
 4fb4d7f45d1cf-5c91d5a5106mr3511908a12.17.1728546822814; 
 Thu, 10 Oct 2024 00:53:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuy2gSA4YRtvN57pd8jK4kYT3SgxgnM0SesH3rRnQU3KWnfZ8Zcjc8FyJ3grt61ztt5dtXHQ==
X-Received: by 2002:a05:6402:428e:b0:5c8:a117:b31a with SMTP id
 4fb4d7f45d1cf-5c91d5a5106mr3511889a12.17.1728546822439; 
 Thu, 10 Oct 2024 00:53:42 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c9370d22f3sm420907a12.20.2024.10.10.00.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 00:53:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 0/4] KVM: Dynamic sized memslots array
Date: Thu, 10 Oct 2024 09:53:39 +0200
Message-ID: <20241010075339.1779904-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240917163835.194664-1-peterx@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


