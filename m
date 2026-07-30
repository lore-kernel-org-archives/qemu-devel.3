Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8343FC54FDF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 10:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpOJd-00042V-39; Thu, 30 Jul 2026 06:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wpOJb-00041k-QL
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 06:48:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wpOJZ-0007yP-Qu
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 06:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785408516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xqABIavlrrajkReXncM00EueNjRJQ+FaDQ9dp/u19zg=;
 b=VBVll28YiBv0AG/9r/eHb92w2IpUhF9/eAQapVOocyeFxJJGiV7FZ92j7h/oD2QZtSemLa
 1+xu3bc5icoKkGKdFPUy0xhyf9aQTOSDZVfdXjbjjHvzLL9BVVE+Y6h5aE1KFj7crWp/pO
 /2CuqKtl3EYME0TqtrreDG77AvvY23A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-r-gcOz8VNEyOYAsOaF_lVA-1; Thu, 30 Jul 2026 06:48:35 -0400
X-MC-Unique: r-gcOz8VNEyOYAsOaF_lVA-1
X-Mimecast-MFC-AGG-ID: r-gcOz8VNEyOYAsOaF_lVA_1785408514
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-495474a5fbcso19667055e9.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 03:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785408514; x=1786013314; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xqABIavlrrajkReXncM00EueNjRJQ+FaDQ9dp/u19zg=;
 b=SsOY++xJBk9p0GA/tVYl42rRD6NZ9FdFkGXFLibkLG7KVTjpS/idQq7qGDDqSCWGji
 jfocstfnnxf8zNkYoVs9C2RW7T8cpZJBFEimi6stgsaHwG3Ceen1Mv9NWuSMwhradMMR
 quR0ggXMxvZBBVRq4pP36E2JZSgNB+i1q4iq7CvbFgZX4kSZv8EGtivqPte4qHx0+hsV
 M6NGAOV+hOoOJTq4/l562MaKPhpXVxGc1q0YDy+2pa/FWfZYHPHocpaGPd07BapJlPXR
 dMSrHeLvk4KswbPXJR+oOC4r1gyqz9SFykm3qn73n5lyGcaXCQAKb/tZTrIdNCfAxqVc
 uVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785408514; x=1786013314;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xqABIavlrrajkReXncM00EueNjRJQ+FaDQ9dp/u19zg=;
 b=pMdSFXWu9NoP2j8MWI0fP9m3Nl4OoJqr9KEJLm/19eJcBwsk3F8JcfEk1pjtzP297t
 26ZaTrtoVl9uOsSS7qOTPJSNpQgRFhq5iz5RcICq/Ee3pjQH1oPOfuEPrMn+nmCmej0K
 OYmgOZqn7cQQRW38I0lM0kcs4UQo8XmTbQWAuJLUzuVcuirYphqOLs0Qnx5zLTM4NYFf
 y8hA+Yn3hjwazss+86DjUDEpH3Oasvss9fktc7SEWzjPJwR999HToNwsXoFsb9nk/lmU
 ru9sbphKV5R1GY6Vm/sxr4FIN7AjjdlPPE29IzB1WZfru7nLu9FBjc5BMFZ6B1jb8iba
 6RZQ==
X-Gm-Message-State: AOJu0YwSoZ3EAhdNPhpfpf8yyNev8v4e7wqrOInQfHOvhfgH+DHDQGTk
 bMUn0EZdmoJE2HUinM994AfaA3dc/royzaPxu2dtekSzQ0Ns2VrJOhVC+E1g6LL7dXZuImtT+b1
 FwvXPDNX+igZ6AHh+yyfTWCBhsdpNNM/ragdBKBro/By4n8CShqRqgTmn
X-Gm-Gg: AR+sD13vevPfFqECLOh4kAAeb+k+R+nWTl8azEbO/MN2A069QYDdmfGQtHcMW2PY41s
 10q+1lkVfk6dYnHL3eeO7GfRHjcPS0JZ7yxVnD6qNY237FCe0RszskE3I0dOF4M3qWqlpZJ9RNj
 a13nOkF2E0dx2JmKJ2Qsv3Rys0EYWHeOejvx/CTNsiKe30eiXvzMh4t1PVB62im3or2Mbzt+6s3
 580fQOYeUbLmxhPWvKchPunpDQ1hMtTZkARzbOClDD7lQJtg+6o48lA7M1uFJSFmUwFK5jNeakE
 2KNQyQAqozj11mJ/Axi183MUZZHgmWr6e/m80ZBgI6oYS8MMZnRb2qHs5iUgTe0NmIvQXZs33Rz
 KtUTCsbdxmNN6uF8+bVCM0hY=
X-Received: by 2002:a7b:ce93:0:b0:495:4d2d:82f2 with SMTP id
 5b1f17b1804b1-49800eb6f98mr21410455e9.26.1785408513931; 
 Thu, 30 Jul 2026 03:48:33 -0700 (PDT)
X-Received: by 2002:a7b:ce93:0:b0:495:4d2d:82f2 with SMTP id
 5b1f17b1804b1-49800eb6f98mr21410045e9.26.1785408513399; 
 Thu, 30 Jul 2026 03:48:33 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498011fd5fesm46275465e9.7.2026.07.30.03.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 03:48:32 -0700 (PDT)
Date: Thu, 30 Jul 2026 06:48:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Miku Hatsune <anznu1l@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, QEMU Stable <qemu-stable@nongnu.org>
Subject: Re: [PULL v2 09/30] virtio-mmio: fix QUEUE_NUM_MAX
Message-ID: <20260730064630-mutt-send-email-mst@kernel.org>
References: <65990a19-6a7e-4c1c-9354-0fffa13cbba9@tls.msk.ru>
 <20260728154328-mutt-send-email-mst@kernel.org>
 <75f2277a-8508-4e6e-adfe-92bed9fc1bf6@tls.msk.ru>
 <20260728192047-mutt-send-email-mst@kernel.org>
 <af6d5296-9860-4c5d-a72e-f2eacac3e2e9@tls.msk.ru>
 <23cbb4e8-1467-4a0f-9af7-67e3c64cba7e@tls.msk.ru>
 <20260729053423-mutt-send-email-mst@kernel.org>
 <90d15fe9-9250-486c-9349-441d0c11c655@tls.msk.ru>
 <20260729055600-mutt-send-email-mst@kernel.org>
 <0702c51b-aec7-4688-a2ec-7363ccdfbc73@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0702c51b-aec7-4688-a2ec-7363ccdfbc73@tls.msk.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 30, 2026 at 08:38:46AM +0300, Michael Tokarev wrote:
> On 7/29/26 13:26, Michael S. Tsirkin wrote:
> > On Wed, Jul 29, 2026 at 12:49:59PM +0300, Michael Tokarev wrote:
> 
> > > The old value basically makes no sense.  We returned a wrong value
> > > here, now we return the correct one.
> > 
> > So now, guest read the big value, and it is writing that value back.
> > But since we changed the value to smaller one now guest is
> > writing a value bigger than the max and out of spec and it will fail.
> > Not nice at all.
> 
> Just to clarify: this might happen only after migration (to qemu "fixed"
> the way I was thinking).

read num before migration, write after migration.

> []
> > I'm not strongly objecting to changing the original patch.
> > This needs a bunch of thought though, as we are breaking a
> > fundamental promise of live migration.
> > And given we are in freeze and it's a CVE, there's some urgency
> > to get the fix merged.
> 
> Yes, I fully understand the time constraints we have here.  Also,
> it's fixed for 11.1+, and the release is coming - and once it's
> out, this whole problem is history already :)
> 
> [...]
> 
> > My suggestion would be to propose a cleanup upstream, including
> > an analysis of the risks, and we'll discuss.
> > 
> > Or you can do original development in the stable branch if you
> > prefer, be my guest, but don't expect it to get same level of
> > scrutiny as upstream code gets. If anything breaks, it's on you.
> 
> There's no need for a stable-only solution which is different in
> logic, since it is the upstream version with current logic which
> we must be able to migrate to anyway.  So any changes needs to be
> in agreement with the upstream.
> 
> > > Ofc it would be ideal - from the back-porting PoV only - to just
> > > drop this all entirely and unconditionally report the correct
> > > queue size to begin with, as per above.
> 
> > A discussion for upstream, imho.
> 
> Yes, this is exactly what I'm doing - discussing it here.
> But without a proposal yet ;))
> 
> Ok.
> 
> For now, for the two active stable series, I'll pick up only this
> change out of the two, and even it reduced to a one-liner I mentioned
> earlier (doing `queue_size = QUEUE_SIZE_MAX`).  This is sufficient to
> fix the bug in stable series (the other change isn't needed).  If
> anything will come touching this place (including a more elegant
> solution), it's trivial to revert it and re-do, no snow-ball effect
> is expected.
> 
> And thank you for your patience!
> 
> /mjt


