Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59007C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXj0V-0000BJ-H0; Fri, 04 Jul 2025 12:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uXj0S-00006w-0E
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:11:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uXj0O-0008Kb-OF
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751645474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HgxPOI9RVjIp72gb7XHSpbJiWsRqlhocYcjpy2vAbQA=;
 b=N4E+nCUhix9e/gD/Ju6/gp/whgGolkfO/CymqNg69062VUPf5hU7pmhyNbQzSs7LnOx55o
 eUQjZOYcL1EqHeHygIihdatTXpGMzPc10oIGEwLwRH1aOI8zRst1NUya07wE4Zy9iJ/Kc5
 XrMwTF76qtxCgny64r/16uMYDCSlTMc=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-hQdECSdSMuiFhySMw_XN-w-1; Fri, 04 Jul 2025 12:11:13 -0400
X-MC-Unique: hQdECSdSMuiFhySMw_XN-w-1
X-Mimecast-MFC-AGG-ID: hQdECSdSMuiFhySMw_XN-w_1751645472
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-2e8f1365181so777555fac.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751645472; x=1752250272;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HgxPOI9RVjIp72gb7XHSpbJiWsRqlhocYcjpy2vAbQA=;
 b=wNBzXyduCD6Mcd7tzNqcE6Ry1FkIdlNFaYSS9C0p1oqYIWmCrqnLrRPqq1toGWpY2d
 M4P4XPz6FVBwXE/ynnus3+/2aVpSYiqCaRtsd4i8hTSPR7WwzPl0QcMnq1KUCxHi6BbV
 JCg3uhUUzYbvIwjvjfKu+avetrLgQRLvEJfqkZUkDbgH8jv5T12onyz1pGhCILTj0ivS
 Y5QUIlwuof1okd0fG3ifzbKAAkxTNL6x4yYepqePiPRTOgGkY/7miRpzWgbjETQDeq2X
 zy0fgwYa7LX8Dlni5y2Q44V5Jv1C5sZym9qBUXuMB5p9EAjMpGckdpWxSUcjYG1KJvke
 yhfA==
X-Gm-Message-State: AOJu0Yyz3ZvAE1oW+bngN5p0rC0Ck/EHjEVk32I0LQUxbIu1UDVSTsLn
 Kteqlh9aRuGGS2h4yS8+IG20pG0PiDdjROIEw0bF9h+OroE/S+YaCQNcYWOTlXiqEnKzP0lS46N
 mmcXZgKsdbAASLaYXjTRaax23FDTO8z4J47Bcu4tFvLNFv/AnpwTKADR+
X-Gm-Gg: ASbGnct4AptceQc5v0gZXs2kHo52XKrAqcDi+ro8TfcE0d86t4Wuyg4YC3/Zp6PpMl3
 x5HHN4I/e7t6aIKHGNUl5JR+GClAnX5fmSvNVVUAv5lwFoo29O2jVvMdxIiGMN6b74P2jYYUOra
 RaxtdAGC13kkqEAtrCr8OVUWknQC1yoXzs23VIrU1QGJoPU57HDOvp06P87vMz5ywiRZAXMFBqL
 TkFT5jOcaqCeAWGcdgHQqq7IfPPL4DPVNC1aZJeKYkCPz4SoljeFzUxIJKYoHriRcsvmBkhPEx2
 P4Sxe7PcGFiGWQ==
X-Received: by 2002:a05:6871:741f:b0:2e4:4617:f6e1 with SMTP id
 586e51a60fabf-2f796b79ab4mr2208600fac.2.1751645472541; 
 Fri, 04 Jul 2025 09:11:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIMrd7CZ3R80qVPjF6p18E8Gq1Ti4UPJUXHHMX/3+d0floSRQ3a17ORWIisklY2cezBWzO7w==
X-Received: by 2002:a05:6871:741f:b0:2e4:4617:f6e1 with SMTP id
 586e51a60fabf-2f796b79ab4mr2208575fac.2.1751645472153; 
 Fri, 04 Jul 2025 09:11:12 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78f95f19asm579964fac.0.2025.07.04.09.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:11:11 -0700 (PDT)
Date: Fri, 4 Jul 2025 12:11:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v2 11/24] migration: Use QAPI_CLONE_MEMBERS in
 query_migrate_parameters
Message-ID: <aGf9Gyen03fL8s43@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-12-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630195913.28033-12-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Jun 30, 2025 at 04:59:00PM -0300, Fabiano Rosas wrote:
> QAPI_CLONE_MEMBERS is a better option than copying parameters one by
> one because it operates on the entire struct and follows pointers. It
> also avoids the need to alter this function every time a new parameter
> is added.
> 
> For this to work, the has_* fields of s->parameters need to be already
> set beforehand, so move migrate_mark_all_params_present() to the init
> routine.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


