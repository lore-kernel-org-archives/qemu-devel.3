Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CD1E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 14:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNCNX-0008Dp-Ir; Mon, 16 Dec 2024 09:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNCNT-00089s-8S
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:47:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNCNP-0004Ts-LN
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734360431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wXxm1QGkZxePbCD3T63ML04Tz/xcL0REDa/acNJJVKk=;
 b=Zf2Vhko1sqcOw+PlUCzsOVp1W3y66OB0TbuYkFivRbWKzZ0FuLEfbKWRm1t69gWMRc/hP3
 p1Us0C9LJ4Bkv2zsGh8GeR/5wfyn2afUhHvV8QJaVrlD3gD7uE2GqxVtbhHlP4rLHv757X
 1gcgekKYTLSzkFA5iftJhQksLtzHP3U=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-hiDzsJHYOC-jdCFbBS2RXw-1; Mon, 16 Dec 2024 09:47:10 -0500
X-MC-Unique: hiDzsJHYOC-jdCFbBS2RXw-1
X-Mimecast-MFC-AGG-ID: hiDzsJHYOC-jdCFbBS2RXw
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-3a819a4e83dso45082875ab.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 06:47:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734360429; x=1734965229;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXxm1QGkZxePbCD3T63ML04Tz/xcL0REDa/acNJJVKk=;
 b=Txb2qcO8g/jhSq4XS9AwKChdNuuEeGJvTA2k9iQ95F+B7Nd29nCqO9BnGUT3XNzHcX
 YtMK451HU8SdjHz0CjTEi5DhgKmB6xOBP16qnv4p5XHPz+j987214cumV6a4KjaQAV4D
 M95t3ydsulshvzR17qMqHfSIohP52wPN4T388sqHouG7freaRTHIg53Q2IrhHq5wc8WA
 VlIWzy+VtiMNAbgheiNQX3JMISVwNaeu0z/cOYEO9BYvo23VFRnUrWq5qyIMdN2HtjEn
 Cp/ww8xUflysN3p5heviteEzt50CFsuBy5kqpdUbbOPfufuqGbpM55cLHDFgeUgm/zsT
 mamQ==
X-Gm-Message-State: AOJu0Yw0mgesjR24Toyrn6KknfBfBkXdER7XiXw0MrWz3t5uC7XyXZql
 +PyjJAiesYWutC0xKmlITJD4ao/QdXVL4ZvRie9XgLyzmoDxueYAk2+X0kpZv6CFPFiDAxanFuT
 O5dZM/EGBU5InBLOFyEMuX3RsHOYr+Gm7dDQ0pTCQXqDgEx6bpZC/
X-Gm-Gg: ASbGncvOINI2HbNnznomaqfcChTP88zpTf6gjvUXcwl4HxYn0weevi2SmNJcze6tukC
 HH/wTQzSDn48EbiYRmMl3SW6FGBz3p/Dvm0wj4IEP1FPgDoE8CjppBTlb1HN+E6w3P7Al83Yb3I
 jfvPY/o1hA1jSsjfL4FUG5sbFWMy6j12LNB8+vuxYJbALo3whRVHiLv5RZNUuJFpXZ6IqCeO0/v
 cmp7QqKDosIOaYookTQrPFlSqojfPx728us3XL3W41pt/X8jX7ppkf1WRx84FSo91Qv2pv8s4JF
 a2P2/fPFXOZTDtrkOQ==
X-Received: by 2002:a05:6e02:20ca:b0:3a7:80ff:4a6e with SMTP id
 e9e14a558f8ab-3aff5b52049mr98899165ab.11.1734360429554; 
 Mon, 16 Dec 2024 06:47:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHk9LBdFVZw5pU84nl2+dAmeIKZiMGXQoNws1tQ8VekwiyBfVdmwy8Vjd/CIXTCtT0qlD7wBQ==
X-Received: by 2002:a05:6e02:20ca:b0:3a7:80ff:4a6e with SMTP id
 e9e14a558f8ab-3aff5b52049mr98899055ab.11.1734360429267; 
 Mon, 16 Dec 2024 06:47:09 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e5e32a33d8sm1234829173.82.2024.12.16.06.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 06:47:08 -0800 (PST)
Date: Mon, 16 Dec 2024 09:47:07 -0500
From: Peter Xu <peterx@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 71/71] docs: Constify all Property in examples
Message-ID: <Z2A9a-CK4Cl6Z1Y2@x1n>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213193104.2515757-1-richard.henderson@linaro.org>
 <20241213193104.2515757-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241213193104.2515757-2-richard.henderson@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
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

On Fri, Dec 13, 2024 at 01:31:04PM -0600, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


