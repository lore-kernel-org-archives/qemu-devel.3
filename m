Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFD1CE8E6B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 12:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3wxG-00024o-08; Thu, 24 Oct 2024 08:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3wxD-00024C-3l
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 08:28:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3wxB-0007Sz-9L
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 08:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729772914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AAT7Hxc+iGl1Qt/9IXDFCeZ6dAiIxI4tkwA5K5eMJtI=;
 b=i0xl8aw+1vPyQxoF9ULa5NsondYgOIHjTs8myLtbdiOcwWfcfNm1Hu55vFQMfiosiCfjbg
 8vOEm4HitMZXeczd5qwzuAJVYFQ7YncJj2/cuINS7PP7PLcGFOftjSivE1sc0whBJARYPe
 7Hp9CHUS6Nf0fvJTmdwFgo65NkPeV28=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-YzS1fC-yN5qBew8JT-kzfQ-1; Thu, 24 Oct 2024 08:28:33 -0400
X-MC-Unique: YzS1fC-yN5qBew8JT-kzfQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b15c2e3ca1so113962685a.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 05:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729772913; x=1730377713;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AAT7Hxc+iGl1Qt/9IXDFCeZ6dAiIxI4tkwA5K5eMJtI=;
 b=RoALWOHSQgjQ4BJbkSqvRR/OMI+fJ9WK8hsxnbaYbHgaP33ka+MXWS3PRaLWCk1hi6
 2OURGyC4SDBGDAnstOW+EuhROiEZJdDfXI1f6IlY95lqd4gKCVfe7cT8w+1VVcSIAyL9
 R5/slIUYAw7OUv9dqEGIzZHDSnhv9VoFY8dlgJSAiQYyjGOBA1wyNbzI14lzJT8qrLML
 7ZpS/eyqou7lAvpEqLZKGoeo2nTwXPh5MADt9B4Y6mRG8FwqSEMzhiT1cMDX3TFmAO17
 KcQHOpfNH2mTIM4f1S/KKz+LB6F1CuYez9UfFMAvi+vAMCNEzDuMzAq+PhC9mw/yQbB0
 u+ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNyzpqEuYqhyFEgLqef6/BMMyDt5UvJEXyZ6cKxFvrbMxQxvQqIPHzntmYaq+5REkbsUF7YsoDcg9i@nongnu.org
X-Gm-Message-State: AOJu0Yw4yOb/lfCba39M4U051UzGRFRylidBxsteXvd2pT0LzxxmjDaU
 qyOd0b47Lh2l7AosSriLzR6fpSq0RhV9eWjYQ9pyg4wqV+ypHI+aN9mEJytb1hrBXlXd/i3zl0L
 q6Bf+OmbtmcsYfUI60yBEzdsdn8JZyY+taXqPh3XxiJoGr99fml4a
X-Received: by 2002:a05:620a:4090:b0:7ac:d663:f664 with SMTP id
 af79cd13be357-7b17e5279bcmr703303085a.1.1729772912987; 
 Thu, 24 Oct 2024 05:28:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRZZHDfdLuN3SplkVMGZT7vbALKsux9mPZRDlQ1/lfOoDdp1YOsYmBR2Y66jH5srFzSLeyRw==
X-Received: by 2002:a05:620a:4090:b0:7ac:d663:f664 with SMTP id
 af79cd13be357-7b17e5279bcmr703301485a.1.1729772912665; 
 Thu, 24 Oct 2024 05:28:32 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b165a8800csm482451985a.125.2024.10.24.05.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 05:28:32 -0700 (PDT)
Date: Thu, 24 Oct 2024 08:28:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v3 0/5] Guestperf: miscellaneous refinement and enrichment
Message-ID: <Zxo9boa0OXqXv94S@x1n>
References: <cover.1729562974.git.yong.huang@smartx.com>
 <87sesmdfl4.fsf@suse.de>
 <CAK9dgmZU+KuJmvqXYjcyFPOQkcH3v-ZfdZEQ6YobTJW7MkPyfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK9dgmZU+KuJmvqXYjcyFPOQkcH3v-ZfdZEQ6YobTJW7MkPyfw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Oct 24, 2024 at 10:06:51AM +0800, Yong Huang wrote:
> Indeed, we could document how to build and use the guestperf,
> refining it to be more convenient to use.

If to do so, please feel free to add a "test" entry in devel/migration too
no matter to put the doc there, or just add a reference to where the doc
locates.

Thanks,

-- 
Peter Xu


