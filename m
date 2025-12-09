Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C49D3B7F6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 21:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT4uh-0007vV-Rc; Tue, 09 Dec 2025 16:06:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT4ug-0007vM-Ro
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 16:06:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT4uf-0006Bz-Dq
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 16:06:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765314383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bPVUc1LTF2C9DDm8g5/DYniKgjwK96QAOU5r+Fzi3Qo=;
 b=VVuFeDPriC5dOdJA+uHR32zApS7KfjXS/DqTxR45IUtG5Lmmff9pjY40jDyJjQrkUxBM6g
 siaO3VUp5Qi2s38mecqhx3+RiqaRra07iKitcBQrUcgDc6Z1F3uBb/epNrXkCljRjEtOOi
 T6NFixi+Z4qgajkO69UzElZ5XkGCh0s=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-CNT-fAw3PZSzExavERwlPQ-1; Tue, 09 Dec 2025 16:06:22 -0500
X-MC-Unique: CNT-fAw3PZSzExavERwlPQ-1
X-Mimecast-MFC-AGG-ID: CNT-fAw3PZSzExavERwlPQ_1765314382
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b2194e266aso1173707885a.3
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 13:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765314382; x=1765919182; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bPVUc1LTF2C9DDm8g5/DYniKgjwK96QAOU5r+Fzi3Qo=;
 b=GcTwRgxBVVodSMxmnnDr9sQrx0tqyLhE+aWU/39oo+f/l1SjdkefKPfrT3GC13x/4r
 bxmpQPXHFZ/fx91L8MkMh6+Kh7piNevEiB3fc6o5gF8/UGtllcemDtok3DwlI8ov3bu8
 8QRbmDF5IE2eWPcOE55V3bDaDJcvkj6LlBy7M3tfANY/38W2JGUsjbyfXzk4Uvj2z3Ki
 SiznDt13+wfhbAi/YeJmG1CpYoVbzI4VwOYqSn6HwF+OM/akO1TX5hVYYrHuqOUDiyol
 ZZgVoXMZ+vwBjI2OybjTkr96bzaeOb5A1+sq+zSPbijEbod81wzJ5lVuDhOmY/lx+I4p
 ojOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765314382; x=1765919182;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bPVUc1LTF2C9DDm8g5/DYniKgjwK96QAOU5r+Fzi3Qo=;
 b=f7/STyfTMciGjqbmmWmBWsGrGNNQ8cVaHD4bSIsHsXk4nziZw3C8tPwK7MzPbFsOy7
 kZSxjS0dUMXObVP0Q+RpebdKex7wtr3pUkG4/tGC/fuSFexTkGxPr5tYEbu4Rns1hW7+
 5BYw3h6EzlODyaWxQrhRczIkX7gNmPQsoNkW9Qbb5SNK/5lZ2FHzVY9flWt89ykbv7+M
 XmUZ7fFjHQjiWUhuNfvIdWbRNge0b+sCXh4WlSj0lRKzkekwf8F7SburinzK7WQFmfkJ
 nYRso9sl5e8gkKYQqRuUA6kQ1TTgFujo/mEVIECTBBZu3PgD1oIHGZn3NK0RVatMrOkJ
 qsDw==
X-Gm-Message-State: AOJu0YwA6caPfziB7HprEM9zRkwyPAbUrvP55r4oXwqNVGJcq4nPE16q
 vNb30rb1gKf10PiLpUrBwrWTTRdzSM39391ls/DhqqzJ+Y4uhhedXwUqmhvYyjxFAFotHkzgX1q
 YewoC3rRJgqqK+RmAiNSLivjuQ8mR8bFrog+7NvSTtl1SgNKGjW92zf/k
X-Gm-Gg: ASbGncsarzRmhrzc9sXO1oYDdwl3Cv3YSa8lKJHfFOjAddBBJ7UTDjj17DZfh4UZU7d
 386GeFKTKLU/AGKWwvWS76zfLqW3n4Z73ybupTxWl57HFjoGkqcGgpQ3YDGu6eaYmJW99WmuLL5
 zuKm8ePPZMt30bTz4ahsnqlg3TMpU4AfgpNNK++w3Q48senv9Sp1kTwkcGeBZuUBxGwPuPxfuoe
 ajvqRMAkf97FHnzoQvHJyq2HlnXCiSTt043V6t8i7Wyd2r08PoLq50L93E6Q+kDe2YJ5mbHp7eW
 cnzMVVT4WHi/uuaFphL1jC4UAz1N6gQ6p7QirXat2S/LWQiuTuefXYpPoYidL4tGaAw3LHMYPDo
 WufE=
X-Received: by 2002:a05:620a:28c4:b0:8b2:f182:6945 with SMTP id
 af79cd13be357-8ba3a45824bmr52528185a.58.1765314381789; 
 Tue, 09 Dec 2025 13:06:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGP4P3Dcl+UqaAqsSmBIFLfANfIi2IFBN+q75MQ/yPfYPLR7YVFquDMGkAvTDXIPsVyj7+I6g==
X-Received: by 2002:a05:620a:28c4:b0:8b2:f182:6945 with SMTP id
 af79cd13be357-8ba3a45824bmr52524185a.58.1765314381331; 
 Tue, 09 Dec 2025 13:06:21 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88827f34168sm138432316d6.1.2025.12.09.13.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 13:06:20 -0800 (PST)
Date: Tue, 9 Dec 2025 16:06:18 -0500
From: Peter Xu <peterx@redhat.com>
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, sgarzare@redhat.com,
 richard.henderson@linaro.org, pbonzini@redhat.com, david@kernel.org,
 philmd@linaro.org, farosas@suse.de
Subject: Re: [RFC v1 0/2] migration: reduce bitmap sync time and make dirty
 pages converge much more easily
Message-ID: <aTiPSjseG9SMnBcd@x1.local>
References: <20251208120952.37563-1-xuchuangxclwt@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251208120952.37563-1-xuchuangxclwt@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Dec 08, 2025 at 08:09:50PM +0800, Chuang Xu wrote:
> For a 64C256G vm with 8 vhost-user-net(32 queue per nic) and 16 vhost-user-blk(4 queue per blk),
> the sync time is as high as 250ms, while after applying this patch, the sync time is only 10ms.

This is definitely an improvement.  Could I request for a split of perf
results?  As the two patches do totally different things, so I think it
would make sense to know which provided how much benefits.

-- 
Peter Xu


