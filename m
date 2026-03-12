Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9E81067051
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 15:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0i5X-0004Wb-O0; Thu, 12 Mar 2026 11:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0i5V-0004W9-N7
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 11:36:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0i5U-0006tH-Bi
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 11:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773329795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bK1kXd44p/t6WsnxAF8rHKwD/VkHrlnK4L8c16hzNSI=;
 b=MCThalEKQ9S+honXN7XNTOmgIII2ZBYBKijTNzkEBFgTsDAJxcsDAFPUcivSIxx/A/3Awl
 oGSokNhOxMkoQw7EnJX5vhMAtxo6jt6ppuTibjtD30L/k8RKAZdom8VXKqPv4URkARUZPC
 VCJ17fRY8V0TjcaNQLB9t9aAxLbHA68=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-x2jUwuP5NsmITwDmiqEUZA-1; Thu, 12 Mar 2026 11:36:34 -0400
X-MC-Unique: x2jUwuP5NsmITwDmiqEUZA-1
X-Mimecast-MFC-AGG-ID: x2jUwuP5NsmITwDmiqEUZA_1773329794
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cd7ea0bb20so641772185a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 08:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773329793; x=1773934593; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bK1kXd44p/t6WsnxAF8rHKwD/VkHrlnK4L8c16hzNSI=;
 b=TjXshioJF382NAKxhfXE0oJQJC1/SxJTPVtD6joLCguykKVHSZ3aSaYCDLo9hB2hKh
 5AhuYiwap/g7qUCRMdaDMBvXLWEynQMWd4GksjIl5TV9G133Mt88IZfeLmwO43sh1kKD
 adnlh+OnRNo30VbFN/iayq4Ssx4v4rBqU5qrsyAfhoO08dZr7Hnl5O2NLMItW1SQAsjd
 zozCtY8QmNVq1S8IeyRCupc09RMDOuBZmUudGC4qB1Mu3c81cWNJJQdDefFAeq+/OMMo
 54nkQq3Y6bTzjHlR4l1nFZm9W1pqdzpt7XL11Qa8xUv+/5kJa/h7MosOA5kpsjUE+5ZW
 cCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773329793; x=1773934593;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bK1kXd44p/t6WsnxAF8rHKwD/VkHrlnK4L8c16hzNSI=;
 b=VwX/Bz0w4U0+aySv2CM0F8DW7b0zYINOhLgJII67oxwmtkNh190Xk/2cBfcThb2PUn
 3lAkIla5uAmV2Z9kBbLVM5qm1zC8DK96iXKYAx7SbOzFsPxm+eocgpJ8OpNx2H+Wn794
 WGVqExomNJ7akriuHMiCzX/n3RhF2F83Ikd2xvXoxFbdixyEBVZafh2JNSG2xi+c/oBx
 8mSYmydHXtjFGQof4VI68SnHXeZ+q83QyFm1Yk+Uv8rbxWyDQREYORYPzsGqE5suehsO
 jsOtVYKTQjJAjh1N2PKJbJ3YdH273/VYe/s/0uFVLghSYYivLU8iuUxeZzu6/xDKaRw2
 UyFQ==
X-Gm-Message-State: AOJu0YyS8jXj7BUg8rthoR3tgWKoSzVL1SIHC3FEd5kkJPBIj4sR81W8
 V3FeAvPRYF7eLm3cGa5PT6ijtIPJoqhHHbQ0R0R3Ney4L+xOry8zmPopJ67L2nQdWSxdO+/l2jC
 plaZIsZg6dtlsjscJ/CURhP2NB3MWVc7Kh1dyrrVkjXz8VOagCDgxpcY8WAsJj/JU
X-Gm-Gg: ATEYQzwua5HMV/4hWOphvGjpFPjWLkTOBMJfuVPl5qtAt/qpghs0N7VM8igXiNr+WWr
 GYfaf5RsUHkscA43YKVLy9X7nUbLZAhUpRfnEY+acw9CwJbr38pFSHC/X6n44ghzkdmN7R4U18e
 D7qoHqecy+YnxgFojr9e6NWHvb1vlY2XpxhabcUpoSiHe5hECfeH5JBd4+AtvPcTlO9/hdl1aN8
 vrTZGVwaBwZUDWx3va0J1y/FRcdv+3sTByLBheqvg8T7cUvDKfGJdW7mBFAGs9cgn1y9TrAbDgH
 6oc4/5DXt8TfeBvgH149DgKLMcOTuchnAVDT9en+p6tRidJQKASxiP6mCAZLjimkqVIYlFeH/mM
 R9rKTvFtY4gyV/w==
X-Received: by 2002:a05:620a:4004:b0:8ca:2cf9:819d with SMTP id
 af79cd13be357-8cdb5aa4320mr19329985a.26.1773329793442; 
 Thu, 12 Mar 2026 08:36:33 -0700 (PDT)
X-Received: by 2002:a05:620a:4004:b0:8ca:2cf9:819d with SMTP id
 af79cd13be357-8cdb5aa4320mr19322785a.26.1773329792720; 
 Thu, 12 Mar 2026 08:36:32 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda1fc09e4sm365264385a.3.2026.03.12.08.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 08:36:31 -0700 (PDT)
Date: Thu, 12 Mar 2026 11:36:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Yanfei Xu <isyanfei.xu@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, caixiangfeng@bytedance.com,
 liwenbo.liwenbo@bytedance.com, yanfei.xu@bytedance.com
Subject: Re: [PATCH] migration: check is_active for old-style vmstate
Message-ID: <abLdfsJK4tLx6_8L@x1.local>
References: <62d074fa-6d4a-4ec7-8c1a-63e7a05c31e4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <62d074fa-6d4a-4ec7-8c1a-63e7a05c31e4@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Mar 12, 2026 at 01:25:04PM +0800, Yanfei Xu wrote:
> > On Wed, Mar 11, 2026 at 01:16:58PM +0800, Yanfei Xu wrote:
> > > /old-style vmstate doesn't use vmsd and instead rely on SaveStateEntry/
> > > /ops. Check is_active for old-style vmstate to determine whether they/
> > > /should be skipped during migration./
> > 
> > Would you please dscribe the use case?
> > 
> > We only have two users in upstream tree that provided is_active(), and
> > neither of them provided save_state().  IOW, so far it works kind of mutual
> > exclusively v.s. save_state(), afaict.
> 
> Sorry for the lack of background information.
> 
> We follow the vfio SaveVMHandlers and add an extra vfio SaveVMHandlers
> variant with is_active. In our internal codebase, we set it inactive
> during migration but active in a specific scenario.
> 
> You are right that upstream tree works well. I sent this patch because I
> assumed the semantics of is_active is similiar to the "needed" field in
> vmsd.
> 
> I'd like to get your opinion on this. Perhaps this case we used won't
> occur in upstream?

Thanks for explaining.  That makes sense on its own, but I think you're
also correct since it won't occur in upstream then it means we're adding
dead code into upstream code that has zero use.

I suggest you stick your patch with your downstream, until you plan to
upstream the whole thing.

-- 
Peter Xu


