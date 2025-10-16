Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26E9CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 16:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9QXy-0007Ly-Nq; Thu, 16 Oct 2025 12:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v9QXw-0007Lk-3Y
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:09:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v9QXo-0002Fn-Jd
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760630967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OdjYbkhzSOlDjUOG+2eggtsYF4zIBsjWyS/dyByFN+4=;
 b=hLlC126SsYUtSxPXQEiY7AbiBCnXD+8NeRh08m4Al8AJx1MyMHh31YWLsE1NkMRqoruOb7
 MbfHCaAnRS5dlhw6y4UUEE7uRInX0XNgUDmef3AjSzZMbZKUG8N6L89PIulSzhl59ML/eE
 oXvi+Zz53dDLpn6UZjmjo2gcySBNsso=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-kQdmvR3sNa2jupol2NhnBA-1; Thu, 16 Oct 2025 12:09:25 -0400
X-MC-Unique: kQdmvR3sNa2jupol2NhnBA-1
X-Mimecast-MFC-AGG-ID: kQdmvR3sNa2jupol2NhnBA_1760630965
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-87c1115d604so35071756d6.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 09:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760630965; x=1761235765;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OdjYbkhzSOlDjUOG+2eggtsYF4zIBsjWyS/dyByFN+4=;
 b=BYbeVkSRvYWBgwObhq35T+aUoG7FUbpW5rpM4gV4010Vbedsy7PUh1IdqcTzOg9B+y
 Mkz4f6Kkn5EahohB3pgI4hSWnXkx7qZTIVCY3B4mC7j0Uqufje6Xa/bM2658a8DVBri2
 tGplq13VTkRSzlQDMnv03ZnqIqRMSo9OhcxxBVP0B5mtZrRRFKCqoJxb5bqG+VCMhggf
 fi4+cWi6s78xl/ycE3L3tLqYkhKigvCPYQ9VvlHrlCbxkWUds7Y6N6w/cJ6qNUIgKHYW
 ZMqj27nWPvpnais4sy1PYsEgmpFf5Aumo8WUf6J/zhTLst2fZQ43G4ivcS+5PIaKrpIE
 zp5w==
X-Gm-Message-State: AOJu0YyC6Obk/SR7wI1XyY1ocfv7WPxcnMIddEl+Cs5VLSWUzPLb5Dzm
 JP0C1sNh9KE7QTiPt1ZZDCsYFcy71sfJqbJvFh0/+FovaJaSiI8ETImq8QYTDdFDjRu7MJ3E8HM
 MPzCGO+mu73O4AIvzF3dHoy2mfIntpHlZYNWJrJpS44W1SVSQLLZFBHtF
X-Gm-Gg: ASbGncs/VPZqBR0CTv66LCh8mhggYH3hZEpLtbnFtmpWLWw+Pak1Z9/Eq397jJsughR
 ymqXtmxhXiYPefowj2BTCSHGhjc5bd6EvpqOG+YLUUYOsdUlkDIf9Hmu00Lh8h/e79x1j2fJp/U
 jvyB5Jjv5tSznLP0lT1Oc8cGf7DfKF9b22vQmVx8P4Dd87XPdfCLwUU1fU16UVBkI9RjprLeVsd
 uF0hHssazwMZw0WBuiX9rqq8XJQbgl6A86l+BTOGmL6Yl9jxjtF/kzKFQ1H9FN3cvDs7F8RcsRv
 X0eM3qSv0ET/r2Omd1OmgrIreZ32uwkfg6Lwgtkv6okOrOgR3pcaS8HxrSbSZ9WnKto=
X-Received: by 2002:ac8:5883:0:b0:4d0:e037:6bd2 with SMTP id
 d75a77b69052e-4e89d4150a0mr12163491cf.83.1760630964881; 
 Thu, 16 Oct 2025 09:09:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZTkoyNwLPmNVxUGtlXf/P3MhdFcB3FbwsY7hJ09ESvlWh8Qrk2S6+r7RoViQpqKDNC8KtrA==
X-Received: by 2002:ac8:5883:0:b0:4d0:e037:6bd2 with SMTP id
 d75a77b69052e-4e89d4150a0mr12162841cf.83.1760630964363; 
 Thu, 16 Oct 2025 09:09:24 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e881d04210sm42795101cf.23.2025.10.16.09.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 09:09:23 -0700 (PDT)
Date: Thu, 16 Oct 2025 12:09:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Anton Johansson <anjo@rev.ng>
Subject: Re: [PATCH] migration: Remove unused VMSTATE_UINTTL_EQUAL[_V]() macros
Message-ID: <aPEYshE-INpg42Me@x1.local>
References: <20251016160313.25751-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251016160313.25751-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Oct 16, 2025 at 06:03:13PM +0200, Philippe Mathieu-Daudé wrote:
> The last use of VMSTATE_UINTTL_EQUAL() was removed in commit
> 16a2497bd44 ("target-ppc: Fix CPU migration from qemu-2.6 <->
> later versions"), 9 years ago; remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

queued, thanks.

-- 
Peter Xu


