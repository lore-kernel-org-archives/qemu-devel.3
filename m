Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06EBC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 16:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shAd3-0007L3-Ea; Thu, 22 Aug 2024 12:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1shAd0-00079T-55
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 12:25:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1shAcy-0007sA-2t
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 12:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724343935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OdJcmbe8L+a9WkEHnchB6Wv7on+X7D6ahW+jUmz2nsw=;
 b=i9vjxSGBOuh8/htri50Dy9KWKAWsXyN2UOk+hbyqSQeXQQcIiRBCXHLTr1cLoXN7sruTgJ
 DGUNrgz4j2IDSSWG9XC/bpuftOGowOmeOLavLUpdYXAXH92BaecKOE7qhXCFqCB4awxIqP
 0GzuPmIa+APanwah6eUDLDW32CHa720=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-kH1qDISmMoO-UEMbg-CnXQ-1; Thu, 22 Aug 2024 12:25:30 -0400
X-MC-Unique: kH1qDISmMoO-UEMbg-CnXQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a1dc1e5662so129760585a.2
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 09:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724343929; x=1724948729;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OdJcmbe8L+a9WkEHnchB6Wv7on+X7D6ahW+jUmz2nsw=;
 b=bmhVrIBWS/0zg5rzBZPBhey7H9vZL6wPScsNYl0qcU83aVj++UBIvDr3O+qglfBo5Z
 pE3TIb9NmBajVeLhksxq5PX/t6q/cTM8AnyGkT/QZDoVHkP0i1HKgVbzBC1yXtKgzXbg
 EidVMC2OrNeuqEvzMGWS715Kntv0R94A+pDtr/pO9MB67tDG42IYoAozjE0hCQ8UISYO
 KuLfr25OLxQ/vUKQXGwTr0XyJ2GYXhOk+1C5YImx/TRJN85+Xz9UtXuHUva7Pqky6eNo
 0lLM1Nm9+BWhHO0oCUWlA6JlVIbh9/tzVMjSda3IllyBEVP5S2NiSsbPooCtcO484chR
 JiSA==
X-Gm-Message-State: AOJu0YwFpG65FEzyw0PhyyzkeD8jLeVzLzNrTNk4Rvai9zVBggqiYh38
 nFBRCMTlK7jFmbDrx9aEQihxYN4lud/NWIgb0b+c0pqpiwDN76aLAOG1zXjnBGiNb1U1QMmZyyK
 tPUP08fH/QXGh9ay6NIqkp4g6KlInTKDfrZ6hP9B5nXWN8v+M0jcKWKoqi2aY
X-Received: by 2002:a05:620a:44ce:b0:7a1:e2e0:b3a7 with SMTP id
 af79cd13be357-7a680a284dbmr363858185a.13.1724343928756; 
 Thu, 22 Aug 2024 09:25:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfmYB08kufzJJjc5VksXWmAoWalXeFdfRMUZkiGGnCO8vhqlg9JWzzVEBggdZ6FcUx0M9FQA==
X-Received: by 2002:a05:620a:44ce:b0:7a1:e2e0:b3a7 with SMTP id
 af79cd13be357-7a680a284dbmr363855085a.13.1724343928378; 
 Thu, 22 Aug 2024 09:25:28 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f3f7b75sm84965285a.104.2024.08.22.09.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 09:25:27 -0700 (PDT)
Date: Thu, 22 Aug 2024 12:25:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v3 14/14] migration/multifd: Move ram code into
 multifd-ram.c
Message-ID: <ZsdmddpcYuhyCO0I@x1n>
References: <20240801123516.4498-1-farosas@suse.de>
 <20240801123516.4498-15-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801123516.4498-15-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 01, 2024 at 09:35:16AM -0300, Fabiano Rosas wrote:
> In preparation for adding new payload types to multifd, move most of
> the ram-related code into multifd-ram.c. Let's try to keep a semblance
> of layering by not mixing general multifd control flow with the
> details of transmitting pages of ram.
> 
> There are still some pieces leftover, namely the p->normal, p->zero,
> etc variables that we use for zero page tracking and the packet
> allocation which is heavily dependent on the ram code.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

The movement makes sense to me in general, but let's discuss whether nocomp
may need a better name.  It could mean that we may want two new files:
multifd-ram.c to keep generic RAM stuff (which apply to nocomp/zlib/...)
then multifd-plain.c which contains no-comp case, perhaps.

-- 
Peter Xu


