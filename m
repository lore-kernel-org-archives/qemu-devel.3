Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99186D65C5B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 14:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVszn-0007j3-NQ; Wed, 17 Dec 2025 09:59:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVszm-0007il-5u
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:59:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVszk-0004K3-HW
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765983555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IQbWGjPqJldFxTVj3El9AfYilahJ3ZHQINMJ/6XEnkc=;
 b=JBqrCBlNNEjCyJNzoSvRP1juE9MGqgonNoHCjP+1Md/i82mS8rN84YHzTKS/D5PVWWe4uR
 7JWu2Y3eA24VFqe830sl6FzgzFWCI9bPnB+hDBWwb8N5Z+NPJMnV9/gWzk0eZhaEMx9wIg
 K6bUEbKsKJEBY2B5LRAI/whEyWSlao4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-blbpMG8fPaC03QalFH-LBg-1; Wed, 17 Dec 2025 09:59:14 -0500
X-MC-Unique: blbpMG8fPaC03QalFH-LBg-1
X-Mimecast-MFC-AGG-ID: blbpMG8fPaC03QalFH-LBg_1765983554
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b51396f3efso1099947185a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 06:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765983554; x=1766588354; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IQbWGjPqJldFxTVj3El9AfYilahJ3ZHQINMJ/6XEnkc=;
 b=Dp0mtvm/vyUV1YQxGGeGbDQtSUDg5x7cUt80VXqt7pqLB4ZQnE+5Rm8rXZEQvReGAI
 eU1zvnGb+AHVqox0G+Z3t2JwKM6mM0g03Q13UPIho4UPNRok6MgEmscWcOc3vqxoJwzO
 yvdXbbRmlzEIAdBlJyEZxMrO4FgPzm5FpKp5oObu05Q8mdGgSbqrUQ7nHeuMqecNa9h6
 HrZtFeQfSe9HSkGgrgSiK8ckCCABYl0P1Ca0ahr0UDi0sqF3XYAwlU1jCRe7ISXQ0VE/
 z2+3IBzKMAEu4TqJjmj0hZzG1KpHFNlalAfUTICqadOkEyQknIXWn6YGbvNDoM7vwKOS
 FvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765983554; x=1766588354;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IQbWGjPqJldFxTVj3El9AfYilahJ3ZHQINMJ/6XEnkc=;
 b=wi9eeN7uWDekfsdVMN9PoKSTROLdqW7lb+7LZ24Rbi1VYjWK3jkEvvQpOg83FTRLmT
 pz65d2MTci4W8gMyAe0yeKCmWkNyCo2YpTZg71GstuEEh7VziOyc/Z2+qyPqLp1lyuQR
 CmZZ2liOwH3VcbYoubz+Rr7JaHEOJoiDj8KyKI5jd2GTkVHEDe7WYPwZ2YG+rm+O7lYX
 0HovOK8GgIdUe+WT6vLWb3LHS3rPH3WEahrfqh7YQn3jfGqpv0HU/3Fjubbmv12xc350
 KaYKHYFsaqxxNvyoF1tfE03H2N7LDqreCiel0ZoMgSMCzdX/9FOt5HXI8WGnAPwH/24S
 1NMA==
X-Gm-Message-State: AOJu0YwNFB7HXEBofbGBNXBKrLoVdaXRgBTmgCRwLsNafQ+e0Xoo9BAV
 J1kwu6hIpUWtylNfIZzKtKVkTqrEDmFhxxmJOzzU7UN9BwvDcA+iWW5fsi4ihKNDbptERFFcmaL
 ONEEZDF3pBQAf4wtFIR1L4Xfx9I75Ap1ZWxq6HEKrjDdNFknsN6rGI7yU
X-Gm-Gg: AY/fxX79B3LiajOtbyXNVhncovSLklSfDlQck0R0J6JVIUJDBDQuyus6IGgt9aSqzNS
 /Bx5eiXmCsOSupVsIa0wLfl2F/U1HMtOTrowX8pd9aQgf+PdBq1i43wtx490TNHTjiXCwEWCXuu
 Ogk0PIxDCfVKjnALkk4yzyvcAnbpDGzVZMHMDeLhsGmvX4SOVlsRlvnRq1SNvIhoozdOvN0gwYY
 WUHwyG3Itei4PJ/5NUzLT+ocaC3KwZAjfaaL+Md3866pC6r1oeE1jBKJlRt2kih1b+KZve1EBEd
 V5axqbPoJqs/AvVmJVsKhO/7orpZXJ7S7r1inKdw4DtixcXrTeGkqHrbsOT14qaeHehRKwB2u9c
 /P9E=
X-Received: by 2002:a05:620a:4723:b0:8b2:7558:409c with SMTP id
 af79cd13be357-8bb39fbc81dmr2725963485a.36.1765983553588; 
 Wed, 17 Dec 2025 06:59:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNsiDr5jVrSMJO0lR28wFPTiyvbrD6/QYVYwwJjbRNO84QEWpt2qeleNqOj3CAHhFTm2/XTA==
X-Received: by 2002:a05:620a:4723:b0:8b2:7558:409c with SMTP id
 af79cd13be357-8bb39fbc81dmr2725959285a.36.1765983553134; 
 Wed, 17 Dec 2025 06:59:13 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8be31b669desm405570985a.39.2025.12.17.06.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 06:59:12 -0800 (PST)
Date: Wed, 17 Dec 2025 09:59:11 -0500
From: Peter Xu <peterx@redhat.com>
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, mst@redhat.com,
 sgarzare@redhat.com, richard.henderson@linaro.org,
 pbonzini@redhat.com, david@kernel.org, philmd@linaro.org
Subject: Re: [PATCH v3 1/1] migration: merge fragmented clear_dirty ioctls
Message-ID: <aULFP1kbeT2yceiV@x1.local>
References: <20251216080001.64579-1-xuchuangxclwt@bytedance.com>
 <877bum36ed.fsf@suse.de> <aUGIPj1JNpd8HZ-V@x1.local>
 <29bc82b4-99c3-4275-b4a8-cfc400f0e44d@bytedance.com>
 <aUKuWISfpQeld_AF@x1.local>
 <65dc5a3d-fe3f-48d9-b7e8-c04346308fa8@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65dc5a3d-fe3f-48d9-b7e8-c04346308fa8@bytedance.com>
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

On Wed, Dec 17, 2025 at 09:43:24PM +0800, Chuang Xu wrote:
> On 17/12/2025 21:21, Peter Xu wrote:
> > On Wed, Dec 17, 2025 at 02:46:58PM +0800, Chuang Xu wrote:
> >> On 17/12/2025 00:26, Peter Xu wrote:
> >>> On Tue, Dec 16, 2025 at 10:25:46AM -0300, Fabiano Rosas wrote:
> >>>> "Chuang Xu" <xuchuangxclwt@bytedance.com> writes:
> >>>>
> >>>>> From: xuchuangxclwt <xuchuangxclwt@bytedance.com>
> >>>>>
> >>>>> In our long-term experience in Bytedance, we've found that under
> >>>>> the same load, live migration of larger VMs with more devices is
> >>>>> often more difficult to converge (requiring a larger downtime limit).
> >>>>>
> >>>>> Through some testing and calculations, we conclude that bitmap sync time
> >>>>> affects the calculation of live migration bandwidth.
> >>> Side note:
> >>>
> >>> I forgot to mention when replying to the old versions, but we introduced
> >>> avail-switchover-bandwidth to partially remedy this problem when we hit it
> >>> before - which may or may not be exactly the same reason here on unaligned
> >>> syncs as we didn't further investigate (we have VFIO-PCI devices when
> >>> testing), but the whole logic should be similar that bw was calculated too
> >>> small.
> >> In bytedance, we also migrate vms with vfio devices, which also suffer from
> >> the issue of long vfio bitmap sync time for large vm.
> >>> So even if with this patch optimizing sync, bw is always not as accurate.
> >>> I wonder if we can still fix it somehow, e.g. I wonder if 100ms is too
> >>> short a period to take samples, or at least we should be able to remember
> >>> more samples so the reported bw (even if we keep sampling per 100ms) will
> >>> cover longer period.
> >>>
> >>> Feel free to share your thoughts if you have any.
> >>>
> >> FYI:
> >> Initially, when I encountered the problem of large vm migration hard to
> >> converge,
> >> I tried subtracting the bitmap sync time from the bandwidth calculation,
> >> which alleviated the problem somewhat. However, through formula calculation,
> >> I found that this did not completely solve the problem. Therefore, I
> > If you ruled out sync time, why the bw is still not accurate?  Have you
> > investigated that?
> >
> > Maybe there's something else happening besides the sync period you
> > excluded.
> 
> Referring to the formula I wrote in the cover, after subtracting sync time,
> 
> we get the prerequisite that R=B. Substituting this condition into the
> 
> subsequent formula derivation(B * t = D * (x + t) and R * y > D * (x + t)),
> 
> we will eventually get y > D * x / (B - D).
> 
> This means that even if our bandwidth calculations are correct,
> 
> the sync time can still affect our judgment of downtime conditions.

Right, it will, because any time used for sync has the vCPUs running, so
that will contributes to the total dirtied pages, hence partly increase D,
as you pointed out.

But my point is, if you _really_ have R=B all right, you should e.g. on a
10Gbps NIC seeing R~=10Gbps.  If R is not wire speed, it means the R is not
really correctly measured..

I think it's likely impossible to measure the correct R so that it'll equal
to B, however IMHO we can still think about something that makes the R
getting much closer to B, then when normally y is a constant (default
300ms, for example) it'll start to converge where it used to not be able to.

E.g. QEMU can currently report R as low as 10Mbps even if on 10Gbps, IMHO
it'll be much better and start solving a lot of such problems if it can
start to report at least a few Gbps based on all kinds of methods
(e.g. excluding sync, as you experimented), then even if it's not reporting
10Gbps it'll help.

-- 
Peter Xu


