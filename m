Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A34CCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 19:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwQj9-0004O2-86; Wed, 10 Sep 2025 15:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwQj1-0004NP-4D
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 15:43:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwQix-00051z-8F
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 15:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757533399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xn6qh8E11LvWQdt3rELR7B7HtzctxUZmGYCUkKXU0Yk=;
 b=JeUTsAk0koqhgebFfcim92nhqwCH8vBNDWGw1B76JQn6Kdl3GXzgL//a+oS9QWcXqNftxF
 7oMHvbYySs9WmH8Vq5XwHgB+IKmkLR9bi2pqu/xLR6bIvFxaum+hnyXujnPzaLOQ/3ChwR
 Cs4t6fxKR1yz7PZYDTDrZu4v6/EIHng=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-kIbiZeKPNzmfrfOwBS_mxA-1; Wed, 10 Sep 2025 15:43:18 -0400
X-MC-Unique: kIbiZeKPNzmfrfOwBS_mxA-1
X-Mimecast-MFC-AGG-ID: kIbiZeKPNzmfrfOwBS_mxA_1757533397
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-807056330b6so881857485a.0
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 12:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757533397; x=1758138197;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xn6qh8E11LvWQdt3rELR7B7HtzctxUZmGYCUkKXU0Yk=;
 b=UMYOl3YNj9YUjqo4pPbmBw+I9NimC1uv7W0/PVe8V+ntB6Az/4dV33Y4vnLPRNIl83
 d69QelHN96eRPen1vLUgr+MFvNrKZlJbpGehDr5EteWsZfP6eQlsYnhTDTN4leiz02rQ
 HYFj5Cu8u5NYQZYwg0j1I1ZQ5PnTSz2TkFFjI82LMWixWqr1IVbQ7scSD6oAU1nziz69
 prtsCMuE0USIPOb/x9Wmq66QBT67NG8IuZA5RxK+8oI/gu0OWeJwyNbzyff8hIGRm8HA
 xOeB/EYXMDmhytO0YdGez2IGSsTUKx13yxWK0f853FBWI3UWbmhbOrWCfzdOadHSrnEv
 1H7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVwRTtN+ecDBTNadAeyrVm/KCv7Aj9hIyA79B/hCGM8kF48MNC9qE39mTqv6IPtqzLbWKSUuwDhCiL@nongnu.org
X-Gm-Message-State: AOJu0YyZWFRUEAcdc9pvPFKAMMfTLAvf6txFMVwNf3HsHC8me/dS0Ol7
 PIE4lJcCpKPcoceaN+RFsSGyIMWlNlEOVdMfUhTa/psQV8ElxSIjxdQdueyZQ8u+cSQRkMG6sls
 2Xqukjoy0javUiL1zDiw8/Wlh2GWvBIgFQknd9IOPEwHrpLyGewjr78wR
X-Gm-Gg: ASbGncvmnpgPjtWkvzaZYKLliUEObVI1pVoTjxJ4QhPALKo0lLrcScXpUKhcrURGDIG
 jyF686exdBGYOmtdTsZvHUZ120Iee8iyRv+uG/0twx3cTKsTM0bxcWIyOxWTJeHGlAFiBMoaSEK
 gQXhRyDSrEOeScicAtSbi7RcOsfyXe3Ncc7r9zC+QiQMN/vx6JmD5gq3qUBcAprhfmQYeej46pE
 SJm0aDd/J0LwoIcnxIlDRReX/7rvCtSXi8orcLnIHWUvZmO6r2n2+Ci1GwTgDBbRuzgNnE69BOa
 2VH2bjIBSwvUvRIFKS4kO4k+bdlHLPfL
X-Received: by 2002:a05:620a:4455:b0:815:fa79:a979 with SMTP id
 af79cd13be357-815fa79a996mr1384596385a.2.1757533394190; 
 Wed, 10 Sep 2025 12:43:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwrQbwkWv0s53nPJcWdlhJSADcCm4K6n5qKirJko/PhzBeS9MBxVGu/dHUH4beap5Jei7VOA==
X-Received: by 2002:a05:620a:4455:b0:815:fa79:a979 with SMTP id
 af79cd13be357-815fa79a996mr1384585985a.2.1757533391185; 
 Wed, 10 Sep 2025 12:43:11 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-81b6019f4b3sm340086085a.70.2025.09.10.12.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 12:43:10 -0700 (PDT)
Date: Wed, 10 Sep 2025 15:42:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: berrange@redhat.com, farosas@suse.de, steven.sistare@oracle.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 1/2] migration/qemu-file: don't make incoming fds
 blocking again
Message-ID: <aMHUwhe4SD4cONF8@x1.local>
References: <20250910193112.1220763-1-vsementsov@yandex-team.ru>
 <20250910193112.1220763-2-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250910193112.1220763-2-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 10, 2025 at 10:31:11PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> In migration we want to pass fd "as is", not changing its
> blocking status.
> 
> The only current user of these fds is CPR state (through VMSTATE_FD),
> which of-course doesn't want to modify fds on target when source is
> still running and use these fds.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Thanks,

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


