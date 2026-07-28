Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF15C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 20:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wooPT-0000z8-QF; Tue, 28 Jul 2026 16:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wooPR-0000yd-Vq
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 16:28:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wooPQ-0006az-E0
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 16:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785270494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FFoW+/9yDgOW9KoIeu3Wdgdu+J6msIOVqvm8609v8R8=;
 b=Bc5T1v1DF4TIyvehdT5h2ufOH8LQbMQrKRvbKA01BExKURVcQhw10FVgkBrjUFEXMTTCvZ
 B+krhtL1/S0iStLSR8CHlBAG7RZ5z7JsTEzc0cP9tzyOEAgkaOg46tZtyaqbGn5wVC1y9N
 SS35zr38auBRnbkGGFz0lwKui8nOe+o=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-AFBBPDU_PGSa3IBFjAbROQ-1; Tue, 28 Jul 2026 16:28:13 -0400
X-MC-Unique: AFBBPDU_PGSa3IBFjAbROQ-1
X-Mimecast-MFC-AGG-ID: AFBBPDU_PGSa3IBFjAbROQ_1785270492
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92ac0a54110so42185385a.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 13:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785270492; x=1785875292; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FFoW+/9yDgOW9KoIeu3Wdgdu+J6msIOVqvm8609v8R8=;
 b=ml6B4mDujvTB+EqICwJJVfDhiCSCz8e9OLvfG3UahcpIABdzIE3jCCGV3GbZmPSmz2
 632GQFp6vNOW5ZRbvLYli3BxZoU98QbFsnj2tqU7wQ5rbruvdpWGF9rojSbZru3cjeuF
 jryBRwrrCJc4oHYfTW2I5LbMf9Rum2F6JNEasHkuyriDgAo/qSHHqxADdPxRjd3a0nPD
 jskDxHTXxK6srILxyVNBvYD9G6ay+s6kg3D2BUgPFqMj5zSvcuX6MzTB8pNlZImx/S6g
 1Ylz55refgSU13VgVwR+xttXzA8WqeL2k2Jdejcc/5LUib+vjkqbN/wxkPePogKP6EDD
 HEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785270492; x=1785875292;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FFoW+/9yDgOW9KoIeu3Wdgdu+J6msIOVqvm8609v8R8=;
 b=BtBk+NnxFtBTuCvZZbCO+gubjNArYqgrYYGithpkD36YGI1pPb2M0t9IRAesaIWnu6
 sOcc6WQBoiTMh1gnIyJ0OeCshElo+eHV59abOXcyylEgAQE9eMGHgsStPv+YaI/d+/tD
 Mzb81rrvlIcarJttUkpF1K3N4CHL9Vf9KOHFBLHk9KT/mGDmSEAGDPJJsmg2KQq4nK/B
 /gXaPwlV4iT+9dR52XaWKLH86Jv0/uTtR+6R8+grr76E2Cd95fAHMf0GlNNAZnx7OxQ/
 Xi037b3jphRyd3fUrn4O+YehWeYYJC/ovz8IJRBoH2iMm7OLXpkHNLgXJLNRELnpCEYN
 MKdg==
X-Gm-Message-State: AOJu0Yx0055i07K5aGAqWk6cxGTY0DVsyvyEUf5mq5BItwfQCn6U8URF
 G85jbkLYc58s2FHYjznhRLn6oIV2rxqa0mt9jj5kIrreEDUnu6v3nv+dA3KMFZHIW1kN3+HyKjl
 odo48ph/bRvMqHm6rNVKgPpqa5gJsxmi11xwItsP83CG92OZTVAxlzzZD
X-Gm-Gg: AR+sD10oyuAb61l0mQ0mER7RCELusDX5Fb7Jkb5Hnx0dDfCOT4vYRFHwPYHuv2eAsfc
 UgvIgG2+Gfqas3OWzErRhH4/AGzYnbr2w2AUSJ1dlu7F0UAGzZsBT53C2gPsCYwv/la53lymAi3
 4Md5i0Fp1x9Y0tDfsBXT83j5YWU7K+vJEBbjzOej0G16TPtStBtcQJqmxtBkX8UiFQojnsX2BUz
 MQL4HOImgrmWK1t5rG6qx79zHz6pDiejXZ7DNGRmI2A1ESQao53U/M1kQcNkppmT+MnNajq5u8n
 d1Db3ONVfJtjyoBMwupXWXIRehckxVaaRkBrat5rB2v3Y+ZrKzUImrwm652zY2HNs95b
X-Received: by 2002:a05:620a:268b:b0:92e:e569:dc20 with SMTP id
 af79cd13be357-933027a71d8mr375311785a.78.1785270492394; 
 Tue, 28 Jul 2026 13:28:12 -0700 (PDT)
X-Received: by 2002:a05:620a:268b:b0:92e:e569:dc20 with SMTP id
 af79cd13be357-933027a71d8mr375307985a.78.1785270491820; 
 Tue, 28 Jul 2026 13:28:11 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9081dd6857csm7585146d6.40.2026.07.28.13.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 13:28:11 -0700 (PDT)
Date: Tue, 28 Jul 2026 16:28:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>, Yuan Liu <yuan1.liu@intel.com>,
 Yichen Wang <yichen.wang@bytedance.com>
Subject: Re: [PATCH 3/5] migration/multifd: Replace assert() with
 error_setg() in recv paths
Message-ID: <amkQ0JzADdKbhsOJ@x1.local>
References: <20260728155247.1894355-1-peterx@redhat.com>
 <20260728155247.1894355-4-peterx@redhat.com>
 <87tspiopuc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tspiopuc.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 28, 2026 at 04:51:07PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > QPL and UADK multifd backends use assert() to validate wire-controlled
> > fields like per-page compressed lengths and packet size consistency.  These
> > asserts will stop working with released version of binaries, so may stop
> > working.
> 
> This is not true, asserts are always on. Same for the similar comment in
> the previous patch commit message.

Shall I perhaps replace this to "when compiled with -DNDEBUG"?

> 
> >
> > Replace all assert() calls in the receive path with proper error_setg() so
> > validation failures are reported gracefully rather than crashing or
> > silently ignored.
> >
> > While at it, touch up an assert() in qatzip recv path too.
> >
> > Cc: qemu-stable <qemu-stable@nongnu.org>
> > Cc: Fabiano Rosas <farosas@suse.de>
> > Cc: Yuan Liu <yuan1.liu@intel.com>
> > Cc: Yichen Wang <yichen.wang@bytedance.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Thanks,

-- 
Peter Xu


