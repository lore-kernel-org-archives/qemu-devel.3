Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08F2D19523
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 22:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkVCn-00068k-9g; Mon, 26 Jan 2026 17:37:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkVCl-00067H-LB
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 17:37:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkVCj-0005Sv-Vl
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 17:37:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769467024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1GDmf2ljW/L9iwHXJa0qwSVCxFBVmcHF5n/NYBk8n6U=;
 b=OnBsDY336bawPDmu7QBFQsFqXY3SxMfL6m+Wn/h5HiqeYAaOo7LRLeJ47emz8LI2qnLw45
 ZuCeBBZQR6MBN9MEvkxkBpHFwnmynUZCvAooBQAqx3kYhztDqZ+PxMvtaDzOF4WEgPNxqE
 pZeK5EV4/GUdhDUcvxF0v/UryNw1vjQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-Z55q7gfoOcWYb3bfBkttig-1; Mon, 26 Jan 2026 17:37:02 -0500
X-MC-Unique: Z55q7gfoOcWYb3bfBkttig-1
X-Mimecast-MFC-AGG-ID: Z55q7gfoOcWYb3bfBkttig_1769467022
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-501473ee94fso222571281cf.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 14:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769467022; x=1770071822; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1GDmf2ljW/L9iwHXJa0qwSVCxFBVmcHF5n/NYBk8n6U=;
 b=c2k0eGzhPcBM16gA7ufrowlj55uKtyA184mS3j0mIhQViS26LBjmgm9fgVYxOCtWOU
 Bw7dwxkgmCgPhZM/H9r43A+O42D8ToHNJ4ISlUsfQexncDnHBan4QRIR3a5M5sv2SV0Z
 8ouCxia8KXoaM2fQfDexyOQagazU5D/Gi5nhNZ5E1IiyfvMX7DE8cj6cdZtaBtAp6KUg
 UvF7jB34oIfQb0bweaOZ9SR29+y1yKo1i2gAhiKPhIdKooJEDLBoQjMB/J0TVmwHNldH
 23Yf96TVX1IwIFrW89YcTigYqkY9pvf11Gwhiw7L10YEdlYJw0iNAzmTidiDij46iamP
 VM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769467022; x=1770071822;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1GDmf2ljW/L9iwHXJa0qwSVCxFBVmcHF5n/NYBk8n6U=;
 b=La7ueHjOA0J1lnrQnbNKAT7Zmxvk/3BKHuwEgCSTik5dhd0Vx6uDVnhmiDcdtqoUo2
 HRN1a+i0qz+KdCjcvgrcZ+fS7ECAmYymMiGBIzPr/IO+L0rIWOWQqzlcbwLY4zr6/C4I
 +hwy2mBDCY9kxCJpDIjdjnRIjBmn/Jb5CHdxOKdsUnXX9KdRUxyUo7xBotOD3GVqBtKf
 zAByLkHvH6LCdlCvx3wdvBI1gecZ6pDmM033Qv8XtotqN8ZgC0AssjcQtEjS0L70TL22
 x7duQaAPSrCXZt+tUSrZTqkvBsg6V8tM77VH5qXg3npxS0fWw0bemCQjQln16HafU+5a
 TG2A==
X-Gm-Message-State: AOJu0YyedJZvvBsFAhL/uDhUQjSn1lKqyWur50tmvhbtk34HLKH+XYrZ
 VQo9w23gsZ197xDu3p5qL1dTxoOJosD+E4SfEJFwb3qzwrb6i7ZEfgGh2dhxtG74RrdHET6PPok
 kA11Z0d4VvzpnzVdSOs/XAzeL2hzsfiLLY8dFx7YryyehcvPPnUc9sEdz
X-Gm-Gg: AZuq6aInwdFz3RD7vxsK6o+N90jYM1zp2R4duXklKTdy8z7LLjyU59wM/jjVODqmc57
 zfKF6PvRGkK7AbnPtDG7KrCpzSe8aZ6sHjc3GLTxf0eIaYDcSyLnFbmIvZc9MLI/m/R9i1JchVV
 JfFWDtwcz/HxwuaqjdvRcpskSsYEG03NtHZwUAts5ERccynaXryi85GEN17X2BXZAR9IvoWaaB2
 j2KizCo9OkuRfDOipan5TMp688d7QC7DDAwOFp8do7kicTMmYpvOMSpA7YvOGPGJ/8gnLKr7nCB
 9lTTCKk9YvVXSf7DEZHQ1/DdcPcMjaIriz1eMC02Hx0rf3mKfCfDhDrW4Hs8pBQNsh0bVlynG5U
 mM54=
X-Received: by 2002:a05:622a:50e:b0:4ed:dec2:301a with SMTP id
 d75a77b69052e-50314b7a3d6mr86909261cf.16.1769467022198; 
 Mon, 26 Jan 2026 14:37:02 -0800 (PST)
X-Received: by 2002:a05:622a:50e:b0:4ed:dec2:301a with SMTP id
 d75a77b69052e-50314b7a3d6mr86908921cf.16.1769467021650; 
 Mon, 26 Jan 2026 14:37:01 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8949dcf5c5asm84519896d6.36.2026.01.26.14.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 14:37:01 -0800 (PST)
Date: Mon, 26 Jan 2026 17:36:59 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Prasad Pandit <ppandit@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 0/5] migration: Notifier fixes for 11.0
Message-ID: <aXfsi29uRfzPJUlp@x1.local>
References: <20260126213614.3815900-1-peterx@redhat.com>
 <87y0lkf2tl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y0lkf2tl.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Jan 26, 2026 at 07:04:38PM -0300, Fabiano Rosas wrote:
> Queued, let me know if you want to change patch 2.

Thanks. I have no strong preference.

Considering that cpr-exec's execve() is not designed to fail at all at
least in production, and FAILED after DONE is utterly confusing.. maybe we
don't need to mention it in a doc everyone would read?  I actually instead
hope nobody noticed it's even possible..

I believe that code was there only because when Steve worked on it he
wanted to trap when he typed something wrong by accident when testing
cpr-exec.  It's a feature too special and mustn't used wrong or VM data can
definitely get lost.  From that POV, maybe some day later we can use an
g_assert_not_reached() to replace that whole blob, including the notify.

-- 
Peter Xu


