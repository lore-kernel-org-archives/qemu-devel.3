Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C5DE6FE24
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 17:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY5on-00088F-Ku; Tue, 23 Dec 2025 12:05:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY5ol-00087A-Go
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 12:05:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY5ok-0007mj-3d
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 12:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766509500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mzEFDpva6O0R9951+Q99Oxyyeiz4y+gpLa72T0cBWts=;
 b=DMCbA8mMCNS01lbnd8aHMPXegBIyyDaeYqJnZc+yne8TDx5XVqzwUlvPfOjacVnL5g5E+3
 fGeGOcXXo4DunVugeKbdyu2PQCGCs+JEsBhcJRfWeAL6Jgx40344i5eMFuupVxANAyB0Bm
 O9x3Hl851kBF1PTqIreg0IVCBjic1Kg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-lMPQM6VKOveEA1EPvzoaWQ-1; Tue, 23 Dec 2025 12:04:58 -0500
X-MC-Unique: lMPQM6VKOveEA1EPvzoaWQ-1
X-Mimecast-MFC-AGG-ID: lMPQM6VKOveEA1EPvzoaWQ_1766509498
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-88888397482so158025956d6.1
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 09:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766509498; x=1767114298; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mzEFDpva6O0R9951+Q99Oxyyeiz4y+gpLa72T0cBWts=;
 b=FvSZYx3ziATY68T+ISlOSDd+KEBph4GOozIIQhyD3ATpU+gj2TNedQK39KcKgNYrq8
 iSg5KciFLT+nl2M8wNRvstxsX/um7sSpNLRjOqh0WmiHhRC7w3gxEt5+SVhiHvKEByOJ
 B0VKGmiHEr+8Iw1NyTcsR51jnNqZpm3/5LJczvIa7fMx8M5ot3HZ3ISCWfCBgL4bgknB
 Y4s5kOL1dRBfOwyGGcwsVJuX5pC/Mm9gZY4K9logY9yGaBflLfq6i7Upu3jkR4DsTmNR
 AtViukbyOGhGgF1NhLKwVHjMK2ngMBwi/cIkvj1CbYiqZs7Gqo3wjayLEN87nnn5O/t1
 WSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766509498; x=1767114298;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mzEFDpva6O0R9951+Q99Oxyyeiz4y+gpLa72T0cBWts=;
 b=hCLPDFrM5+ow6MC1hJ/+4gw1qliHmDZT4hLPGVc4A5mrD9lhaJxQoWnnqHruh+cYWj
 qwrMe1ZlR8y12yhyX6I5przpZTF6hDTKCwYdytpJ5tR1MQdKKB6eDRD7Rx0c/3fX1vrl
 pGNL6CuSwQKzLgwFuyMjJiiCECw3/C0DtumMI6eWG5Fc/yktM45f0yNrzFEnSsUsWsSd
 IBss6V1HMNOebuj0z9pOW+Lr9UwmEi5xXhMxnSjkneb8/FeZTmW6/96LcagfOBgYhPdr
 dxS/Q2w0FI2AwKrxkwXsJQ+uMOD4PG8NiWdO52KnlN8ib4hWrxwIDMjCGI5WOhz3GJyQ
 AsbA==
X-Gm-Message-State: AOJu0YwQPiZQ/NqE7xtKShBXBoGQod3dpR2tvljYT4It6EjTNOEJM9nm
 M6NFerRjR+c2G36tB0nLceX/sXc2t/3M8smqwVFh7OEnsP/MfQuKxmK8XqY70XHU/P0j2XQCjkp
 SpnQsJsqs25qCgrx+9eZib0APtgBKExgnuR1lWTfmQFtXFroP54VUcEBB
X-Gm-Gg: AY/fxX6M0tCwmVu3FWJwe10RlJi6b0+qcjo/BQdfY/UpRDEqOr177OVPPOkQuZCGdbJ
 RTi+yy/7j16JdeTCo2nxM/0Ds5/9/gkR4lyPVukjsLI5IBR2rl/TmWdBP6OvNdZfwu4OF4QUWhB
 2D+/ZasE7M24oL1ETJodiDmUks/RqTDfQ8XVJY3ul3IPPEDnuNJwM5xsEEkh0Yg4lzX6w+3rRSt
 w81xJGEo1e43vInzurnNwEq7oZ0qOrau1bj60wQCx/AgL63s5fiZsN82CBd/x4/aEztv03nf3kr
 mC+jlFp7aRFGlkrzrt0vdAhyMwvilWEUz05eRn9iaTJXyPXF98z07AKUkrTy5YQA5En/6opfcoo
 iAqg=
X-Received: by 2002:a05:6214:5092:b0:888:6ea5:a90b with SMTP id
 6a1803df08f44-88d7f5b331fmr241469296d6.0.1766509498177; 
 Tue, 23 Dec 2025 09:04:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnwgzgxA+KPk6qDf0uhrpxVmpIv5hU4dW92xFc9Cu6FyqlZtxavEGsYOoZZcR3AAe56yi1iQ==
X-Received: by 2002:a05:6214:5092:b0:888:6ea5:a90b with SMTP id
 6a1803df08f44-88d7f5b331fmr241468716d6.0.1766509497768; 
 Tue, 23 Dec 2025 09:04:57 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88d997aeef5sm112674856d6.27.2025.12.23.09.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 09:04:57 -0800 (PST)
Date: Tue, 23 Dec 2025 12:04:56 -0500
From: Peter Xu <peterx@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 David Hildenbrand <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Fabiano Rosas <farosas@suse.de>, Alexey Kardashevskiy <aik@amd.com>
Subject: Re: [PATCH v3 05/12] memory: Rename RAM_GUEST_MEMFD to
 RAM_GUEST_MEMFD_PRIVATE
Message-ID: <aUrLuH2k0oTdpYNk@x1.local>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <20251215205203.1185099-6-peterx@redhat.com>
 <be8d7863-b803-4647-b69a-f61a1910cab9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be8d7863-b803-4647-b69a-f61a1910cab9@intel.com>
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

On Tue, Dec 16, 2025 at 01:49:27PM +0800, Xiaoyao Li wrote:
> On 12/16/2025 4:51 AM, Peter Xu wrote:
> > This name is too generic, and can conflict with in-place guest-memfd
> > support.  Add a _PRIVATE suffix to show what it really means: it is always
> > silently using an internal guest-memfd to back a shared host backend,
> > rather than used in-place.
> > 
> > This paves way for in-place guest-memfd, which means we can have a ramblock
> > that allocates pages completely from guest-memfd (private or shared).
> 
> Well, the term of "in-place" needs to be changed to "init-shared".

Right.. I'll fix those and keep the r-b.

-- 
Peter Xu


