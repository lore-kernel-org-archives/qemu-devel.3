Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD70CEE57C0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOyo-0001CV-5h; Wed, 11 Sep 2024 11:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1soOuP-00009b-IQ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:05:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1soOuN-0000lW-JE
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726067122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uoUZeC6LRc7rq1WSj0H2PhIHrG20erxXeEpQDJ7AxZE=;
 b=DSt7vpg/TCrg18g7AgCmpnrmSVg2FmvGNsSpmZt2UuuKqyGvEi5suTM43LnimJ5ByAHBhu
 XPDaIa7NAsVgh/2taCQQUyCk2g7BM0nBAKKKWW7cUTFnZeNU0qkKge18t7Q9S8MpCIbljV
 iFQezALMfaMGa76euw60xQRbW2gL4ds=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-P5rGcSv9PbqPrnMx-8TksQ-1; Wed, 11 Sep 2024 11:05:21 -0400
X-MC-Unique: P5rGcSv9PbqPrnMx-8TksQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7a99fdae7bbso1027986485a.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 08:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726067120; x=1726671920;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uoUZeC6LRc7rq1WSj0H2PhIHrG20erxXeEpQDJ7AxZE=;
 b=UQ+xNKUpWwaPR9hxswiDaC5BSumOr5X2QtF6fH0es0/fWIyYFexkzX/NbkCXnbiQG/
 5XPtr35yb8GB6ZPxsHI9NLMvO283ziHH9XqPSc4tpGu6oqRPJT1A28u4Pi1r8xyJqqVa
 0vuOfvsMIgu82xbqD6PMNsNm60Sf67NiVdqocd+GnMeD0kUBVoeEOfGQBB59kQXjM0Cl
 vJMLRQ+uq6n6L76MoPm5hqYe2XdMIPn4FaZvKIqPqOz1pieRP56NKaTBeWJvuo9dLx82
 IsZHP/VQ1bI6KJWLE0IUvHdoSrCV/sYoQAnYzUPbhiccBnUSRxPYhVti46/360kebejf
 jv1A==
X-Gm-Message-State: AOJu0YwLU4bmnwlGci0p8iwTB+L4g5+5Kc60yvq5IbRyI3DgtAZMxgSp
 llODCx54fpN8GxQntG53YM2LCa8HR2DXv8AJjEne1ymTPZKgimGs/ffsbolcS11mK90mCKKnIcI
 lW3IQP8LFxVkOwMcsJJv86BC2YiFN59EIkG9UA1fYLIL50EvMAjWDeWEhkTGSYQ0=
X-Received: by 2002:a05:620a:2916:b0:7a9:c04a:f50 with SMTP id
 af79cd13be357-7a9c04a137cmr1153467085a.34.1726067120416; 
 Wed, 11 Sep 2024 08:05:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7DkCElsWpQR12tgGU+UPxAWubks45EE+ygNJkSE6Jnrs99zzpLwHCjsbXhr0P9R8lA/W2bQ==
X-Received: by 2002:a05:620a:2916:b0:7a9:c04a:f50 with SMTP id
 af79cd13be357-7a9c04a137cmr1153462985a.34.1726067120044; 
 Wed, 11 Sep 2024 08:05:20 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a796cc87sm431365385a.46.2024.09.11.08.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 08:05:19 -0700 (PDT)
Date: Wed, 11 Sep 2024 11:05:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/qtest/migration: Move a couple of slow tests under
 g_test_slow
Message-ID: <ZuGxrSLgDt5aPPB_@x1n>
References: <20240911145204.17692-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240911145204.17692-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Wed, Sep 11, 2024 at 11:52:04AM -0300, Fabiano Rosas wrote:
> The xbzrel and vcpu_dirty_limit are the two slowest tests from
> migration-test. Move them under g_test_slow() to save about 40s per
> run.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

queued.

-- 
Peter Xu


