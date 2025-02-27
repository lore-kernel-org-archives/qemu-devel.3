Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81354C1B0FF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 16:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tngzB-0005Zg-7p; Thu, 27 Feb 2025 11:43:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tngz1-00057i-6Q
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:43:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tngyx-0007Ie-Rk
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740674605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i53Ag5FujmT18/QVGuHMetQW3vI1csjVYw9/N72Kp+I=;
 b=dFgdbthvHb8x6dSgabkdBuMXVS70ssn1qJk1K+2lGzNb0X/nbdYbQ9k52iNDr+h7UtBNsj
 mT5Cwvld7TuRDkaUBC7mCuuKIDRNK029YS/RCeOe96TEyjQotO3J9I/FR2uGXr62r3K8uv
 /mcdfoX4qGvHQm6tNnUKywzcedbJ8Ho=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-GIYqIn9VNFetGYA_ti1zww-1; Thu, 27 Feb 2025 11:43:23 -0500
X-MC-Unique: GIYqIn9VNFetGYA_ti1zww-1
X-Mimecast-MFC-AGG-ID: GIYqIn9VNFetGYA_ti1zww_1740674603
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c0a89afcaaso229014785a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 08:43:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740674603; x=1741279403;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i53Ag5FujmT18/QVGuHMetQW3vI1csjVYw9/N72Kp+I=;
 b=X9yxiMH/aWDperNYMlxcG63ZLxh2a4NiZj1DUUSozsRDpkkMmLzlVFAfqWzFvf9C+r
 0aVwfb6CqmpBlwcbITfA96Gso2eGrOzAn3DVc9SSI2eE7Wh9iyQo/SmxkAaPskosy64J
 OC/Nekij1vodegZAneBHB8GbfFfvruThCi3Lp8PUmaR1EHfOwe6TM6seJgLeK9zYHrSA
 rAk6QvpbOEcylMykEY1ZhoChD8NbHFE853ylRb2VQHBWvnn5A6RWIG8sCj4ZDQ9kazvt
 xaYyMncI5sCyx/bAtIiuRgE8ULLxwUu1b775dFj/83Z8PsZ11S9JMGASWDR0Jhp0zJ4l
 FG1Q==
X-Gm-Message-State: AOJu0YxJybWIlj5LHjVvyjZZFyq8MlS6q2TPc1G0PDYcDzH5pDLPtxSq
 COTc9X5QEa/PyOf0vTREmmzNvay0GvfuriKyCfzTx6KmsZ/Wg+Xm38VY5Ft+HoQofgu75kPgiB/
 ErLuafxSBJSoXa5OXznVhUyEsvFcUxG4IzOfro3gJBeyzOSzQR6cX
X-Gm-Gg: ASbGncuuX/wOJ/d6DbWHAgE3EfKmu6RARniMnZPTgHA8DotS1SHHP8xfpbOucDgtspv
 JU5LxBvDU2sYu5ctobrfyh0IVlQxG2LUS3xv+hACtd1QNyUghEjU+V52dcZhq+5IR+cGMZrHDGI
 y59v6/XCLzSiAvk2+CDg8XAvtauZG813KXTxHsYXmW7iDzWmLzPS6zdOswWq4TjXB0KNsJog/Vv
 b1XF/LkMlg8RNtn4Nt1IDJiigp7ppycwNg5iTkFBBqQFp0KzXwvbG2hknh7sJuLoi1J6w==
X-Received: by 2002:a05:620a:179f:b0:7c0:78ec:1ece with SMTP id
 af79cd13be357-7c39bbf4b92mr24440485a.7.1740674602880; 
 Thu, 27 Feb 2025 08:43:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhbvkXmhA6boVJAy8sJ42NRDbBsOghG/UH/qiBbgs5YvRNlS8Fm1HesSdacmOu54LHnn7NnQ==
X-Received: by 2002:a05:620a:179f:b0:7c0:78ec:1ece with SMTP id
 af79cd13be357-7c39bbf4b92mr24435485a.7.1740674602450; 
 Thu, 27 Feb 2025 08:43:22 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1001])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e897634d3esm11570276d6.11.2025.02.27.08.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 08:43:21 -0800 (PST)
Date: Thu, 27 Feb 2025 11:43:18 -0500
From: Peter Xu <peterx@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 5/6] migration: Unfold control_save_page()
Message-ID: <Z8CWJvCxKvDLqsb4@x1.local>
References: <20250226063043.732455-1-lizhijian@fujitsu.com>
 <20250226063043.732455-6-lizhijian@fujitsu.com>
 <Z784ja61Oh1cv0V0@x1.local>
 <fd138e06-29de-4ce2-8105-74a5c9f96f8f@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd138e06-29de-4ce2-8105-74a5c9f96f8f@fujitsu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Feb 27, 2025 at 12:42:30AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 26/02/2025 23:51, Peter Xu wrote:
> > On Wed, Feb 26, 2025 at 02:30:42PM +0800, Li Zhijian wrote:
> >> control_save_page() is for RDMA only, unfold it to make the code more
> >> clear.
> >> In addition:
> >>   - Similar to other branches style in ram_save_target_page(), involve RDMA
> >>     only if the condition 'migrate_rdma()' is true.
> >>   - Further simplify the code by removing the RAM_SAVE_CONTROL_NOT_SUPP.
> >>
> >> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> > 
> > [...]
> > 
> >> @@ -56,7 +55,7 @@ static inline
> >>   int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
> >>                              ram_addr_t offset, size_t size)
> >>   {
> >> -    return RAM_SAVE_CONTROL_NOT_SUPP;
> >> +    g_assert_not_reached();
> >>   }
> > 
> > Not sure if some compiler will be unhappy on the retval not provided, but
> > anyway we'll see..
> 
> There is no problem in fedora 40(gcc 14.2.1) and ubuntu2204(gcc 11.4.0) with --disable-rdma.
> 
> I also noticed we have a few existing same usage:
> 
> 1708 bool ram_write_tracking_compatible(void)
> 1709 {
> 1710     g_assert_not_reached();
> 1711 }
> 1712
> 1713 int ram_write_tracking_start(void)
> 1714 {
> 1715     g_assert_not_reached();
> 1716 }
> 1717
> 1718 void ram_write_tracking_stop(void)
> 1719 {
> 1720     g_assert_not_reached();
> 1721 }

Right.

The other question is what about G_DISABLE_ASSERT, then I found this:

osdep.h:

#ifdef G_DISABLE_ASSERT
#error building with G_DISABLE_ASSERT is not supported
#endif

So yeah, we should be good.

> 
> 
> I also asked the AI/Deepseek-R1, pasted a piece of his answer
> 
> ```
> 3. Why No Warning for Missing return? 🚨
> Typical case: A non-void function missing a return triggers -Wreturn-type warnings (enabled by -Wall).
> This case: The noreturn annotation ensures no execution path exists beyond g_assert_not_reached(). Because the compiler recognizes this, no warning is necessary.
> 
> Conclusion
> GCC trusts the noreturn annotation of g_assert_not_reached(), recognizing that the function’s control flow ends there. Thus, no warning is emitted. For code safety, ensure assertions are active or add fallback code if needed.
> ```
> 
> > 
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > 
> >>   #endif
> >>   #endif
> >> -- 
> >> 2.44.0
> >>
> > 

-- 
Peter Xu


