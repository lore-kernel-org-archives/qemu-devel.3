Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22259C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 15:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4N2D-0002ND-9u; Tue, 07 May 2024 11:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s4N2B-0002Mj-K8
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:47:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s4N2A-0003x6-9v
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715096833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tg+KBvtfWxWpOJ2vclfrnrqtD66OsA9AfCkIXg0daH0=;
 b=GWi2+6+GotI+oJhroXw0wPR1cxIpgBLTHbpwPNcqcUZgtX4OUjdlRSj+ExpFNAKjIcMd0D
 KetfnOLYBxz0/KSsaKCg7vI8NKFifgBfkl44Z7/HPrMpvW9zFmneh6Bf73EePhE1H+q/c3
 KeQZITal8YrRpQY0a9PJ8ca457wnBPQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-9v_VlEayO9yuBuNEIFSXEA-1; Tue, 07 May 2024 11:47:11 -0400
X-MC-Unique: 9v_VlEayO9yuBuNEIFSXEA-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-43d4e45913cso1855411cf.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 08:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715096831; x=1715701631;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tg+KBvtfWxWpOJ2vclfrnrqtD66OsA9AfCkIXg0daH0=;
 b=OaQ5LRnpJpdAZ0hxpicuCUQjGC9tT9kM9kany+o/VFcNYv6aOouticOfkVaVLIY0G5
 CSirR5/NH9iU82STDBkhQcsTW2ILrNXJzQNoPvGbMG5YlYbOpv7xPR3Tq7nELsvWtN+O
 Gp6qUbXolt1SbLmBJbiA4exLdcld4YkY9Ov0MdXXokTlAPEwXT8mkuueJYYxO2tn+sj7
 LtT3HS3m0DzGXldaCdwC8mH6aaxHvsJypHqgMdvzQR2h0k8wvF2k8y2LW3XFuWfUojVG
 txc8/BBuAL9goaG4nNHDOzSctb2athRtT6HB9B6hMXBwcbfeYsuys7mnGZCm2K76eCNL
 n78w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpdqOX+/bbpMMJ+A1mTmcN4aTx7hInmdiavQkW6IlbjGV4qYbr4YxtNdEZj9GC3swKVg+bHHm/B6nU1VXzr5+gKCuJXJM=
X-Gm-Message-State: AOJu0YxYKDWbtY8wOxPNWFZN8lgr7pen062n49GnDQSLX8NZnH1zcWDr
 c0B2Ie7Gcw97bejzp8OfzPI5qN2sRQIc4BFvuQR+SlWHaGD+rPW2+IXFr1P4rOOc9H5/14CG7zX
 N8WNvTPkGVomVG9lbxeSe6WEQGYv4yEqAcYttrj2YaMVtXSNm2FFs
X-Received: by 2002:ac8:7d04:0:b0:43d:89f6:9104 with SMTP id
 d75a77b69052e-43dbf3c1862mr835611cf.1.1715096831028; 
 Tue, 07 May 2024 08:47:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLjsWyeXd0izdBz+Q8cteDG9KoheOFBogT3saitGf623PDUI3gzH878hMxbWSSajsBkGDALA==
X-Received: by 2002:ac8:7d04:0:b0:43d:89f6:9104 with SMTP id
 d75a77b69052e-43dbf3c1862mr835311cf.1.1715096830423; 
 Tue, 07 May 2024 08:47:10 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 f8-20020ac840c8000000b00434c31fa60csm6490015qtm.92.2024.05.07.08.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 08:47:09 -0700 (PDT)
Date: Tue, 7 May 2024 11:47:07 -0400
From: Peter Xu <peterx@redhat.com>
To: gaosong <gaosong@loongson.cn>
Cc: Fabiano Rosas <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Tianrui Zhao <zhaotianrui@loongson.cn>,
 pbonzini@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maobibo@loongson.cn, lixianglai@loongso.cn
Subject: Re: [PATCH] target/loongarch/kvm: Fix VM recovery from disk failures
Message-ID: <ZjpM-1MImDyQKyHI@x1n>
References: <20240430012356.2620763-1-gaosong@loongson.cn>
 <f9956c18-3530-4fc2-8150-beba7b673f89@linaro.org>
 <87edanlzlz.fsf@suse.de> <ZjJjl2fIU1s24uFD@x1n>
 <87o79oo00b.fsf@suse.de>
 <c9bfd6a4-befb-c17d-a87d-15eeecdfb75a@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9bfd6a4-befb-c17d-a87d-15eeecdfb75a@loongson.cn>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 07, 2024 at 04:12:34PM +0800, gaosong wrote:
> Just remove CONIFG_KVM  would be OK?

You're the loongarch maintainer so I'd say your call. :)

If you're not yet sure, IMHO we should go with the simplest, which is the
original oneliner patch.

Thanks,

-- 
Peter Xu


