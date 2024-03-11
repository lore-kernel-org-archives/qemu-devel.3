Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014D8C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 13:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjfZs-0002yt-LK; Mon, 11 Mar 2024 09:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjfZm-0002y1-Hv
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:20:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjfZk-000430-GB
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710163219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bmoo97+WWTU9JFPbqk1LqEvQWwY/6pvTm6p8bVu9eUA=;
 b=SiPDGkqIuYWi+qJ/XK3D7P/IbfsSQJJbBpFGwBWAzXPIo3TmB8ljngNywSwd7IHBG7rgyO
 Uqa8EZKxpnxyos5nQPYhglF5e2gcVUuqPek4e/n/hkXEmiDjhz2vovCIrun8AGhC96pEep
 2lmmEtMmiUDK3pe4pyeyCp6kBTu07WY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-w6hmiL84NkmguobHIL1mbw-1; Mon, 11 Mar 2024 09:20:17 -0400
X-MC-Unique: w6hmiL84NkmguobHIL1mbw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-78313358d3bso263913185a.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 06:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710163217; x=1710768017;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bmoo97+WWTU9JFPbqk1LqEvQWwY/6pvTm6p8bVu9eUA=;
 b=vQfNf5ZxwYIlchDp3f31pk2If1fb5utTf1fLdYPBykXs3dehP4PPro9h2rpFy/QEc1
 vtv2d+sqx2D+BbUhOzFzFhdzcrST3zhRNeCcqQG2aPkSvuaqXq3VgW5mYfywdJcjRm4G
 kmyMjkKOb8qM9Lot6UnlNXeKEaCi4AI6NnfUv6cBbnhrH1CdAh0vDWUMJu3BX+tQTEA6
 B8I9v+UlPoDiHxmHJeVviciy8qghI5luDXqsfiPE1pnMU4h2BrXHY1vLJpCikhzOyQYU
 AI4WCy1GeC0pXUnTC4r0Ly5ecrNeeBSS06bOCKAHJUW7Szezjq4XqEwlPHCN7viIpVsW
 8/sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWYE9Qhxi8mdC+eGQNrWEYjqWV2PwwE90eWuRhbhQckPmJDwB092MpJslVD90OAsiWPO2fR5SMZvFS5KWnLxsRnb93RvU=
X-Gm-Message-State: AOJu0YyPmBM/FjXylVc3xrTw8X+oNaaoe7mAV7F+fIjcMiLXymPhke24
 N+N3UC/6+mZyEeywzAW27gYezxHRlmUBTLEt8Vmj/aqHyH7076P/uZfxdsze1BL25NByvb7s1a+
 KIftYXi8e6OAs2lew5BP0rM4KtbMNuMtZlUMNzf+dYt/4/HBfdtfd
X-Received: by 2002:a05:6214:b8e:b0:690:d02f:f5df with SMTP id
 fe14-20020a0562140b8e00b00690d02ff5dfmr2665773qvb.5.1710163217057; 
 Mon, 11 Mar 2024 06:20:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDjoF6NhlCTmMyPExHfZwBowXzMrHgbAMraOlcYFSC3eBag5/X+DDqa9fJdDThnXUn8g30jw==
X-Received: by 2002:a05:6214:b8e:b0:690:d02f:f5df with SMTP id
 fe14-20020a0562140b8e00b00690d02ff5dfmr2665754qvb.5.1710163216666; 
 Mon, 11 Mar 2024 06:20:16 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 h13-20020a0cf8cd000000b00690d74d073asm617999qvo.9.2024.03.11.06.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 06:20:16 -0700 (PDT)
Date: Mon, 11 Mar 2024 09:20:14 -0400
From: Peter Xu <peterx@redhat.com>
To: hao.xiang@linux.dev
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 3/7] migration/multifd: Implement
 ram_save_target_page_multifd to handle multifd version of
 MigrationOps::ram_save_target_page.
Message-ID: <Ze8FDnvkPtYNjCbk@x1n>
References: <20240301022829.3390548-1-hao.xiang@bytedance.com>
 <20240301022829.3390548-4-hao.xiang@bytedance.com>
 <ZeV8WaKyKEfw-em-@x1n>
 <CAAYibXhCzozRhHxp2Dk3L9BMhFhZtqyvgbwkj+8ZGMCHURZGug@mail.gmail.com>
 <821fba91ac7c0d4cd481d91b8fc91c94304a677f@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <821fba91ac7c0d4cd481d91b8fc91c94304a677f@linux.dev>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Sat, Mar 09, 2024 at 02:06:33AM +0000, hao.xiang@linux.dev wrote:
> > >  @@ -1122,10 +1122,6 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
> > >  QEMUFile *file = pss->pss_channel;
> > >  int len = 0;
> > >
> > >  - if (migrate_zero_page_detection() == ZERO_PAGE_DETECTION_NONE) {
> > >  - return 0;
> > >  - }
> > > 
> > >  We need to keep this to disable zero-page-detect on !multifd?
> 
> So if multifd is enabled, the new parameter takes effect. If multifd is
> not enabled, zero page checking will always be done in the main thread,
> which is exactly the behavior it is now. I thought legacy migration is a
> deprecated feature so I am trying to not add new stuff to it.

There's no plan to deprecate legacy migrations, I think there was a plan to
make multifd the default, but I don't yet think it all thorougly yet, and
even if it happens it doesn't mean we'll remove legacy migration code.

When repost please still make sure this parameter works for both multifd
and !multifd.

Thanks,

-- 
Peter Xu


