Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C121AFDEE46
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzU5-0000eR-Dx; Thu, 23 Apr 2026 15:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFzU0-0000dX-Ew
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:13:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFzTy-0007V2-8S
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776971579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zSPMVIsETMCCRcRnLlbQIG+Fw+GAkSsMNcI9CpUPrxc=;
 b=PhZ6hGxtQgvnwrMsAQJ+wZ798MgretG+jeHaN8ll6aF5GGCeZlIbInceQ4ZpSh3Kd7bBRc
 TFMPl5J7Wrz0GHXOUvuSNLz78rsE7ztEs6zZSYnf44XcVGUrnZlIU/Kbryew9BRFAQ2Gw5
 0jjZ+QbPYKmV25HSb0cwK/CWU2ramag=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-yfLV5qSXPQGeG98njBRNlA-1; Thu, 23 Apr 2026 15:12:58 -0400
X-MC-Unique: yfLV5qSXPQGeG98njBRNlA-1
X-Mimecast-MFC-AGG-ID: yfLV5qSXPQGeG98njBRNlA_1776971578
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50da529ff48so165899931cf.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 12:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776971578; x=1777576378; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zSPMVIsETMCCRcRnLlbQIG+Fw+GAkSsMNcI9CpUPrxc=;
 b=evO1caVkwBBt9UycwRScZbr1dyWZmCbzoRQhdu9+WPljvw1JEnMfB1h7titVFURi0v
 iTjEIbgsSGoNANwm/EW4KXklZRTXe8N0g5aClwlk1blTnBhPiFf1dHYF/+Dy3YogI1RE
 QxjmgY3r53p6P8uf5oBE8M5cvfT8d2HToyPuU1TDjAvCSztMJ7/zdPOsLgEv9yi5dHds
 2/ixcwjQdT7hmW5zjN2S0XwO7dsAEZyZPctpAu9I7Rzof5iGkQZYTBjQ4bmZHfQ59mMb
 M0I+210aZH9An/Iq3rzcES6DtnH9XzHGhkCM/DXKSbRfY6WeNHXPb25HdMWrBkGUFbku
 wl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776971578; x=1777576378;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zSPMVIsETMCCRcRnLlbQIG+Fw+GAkSsMNcI9CpUPrxc=;
 b=UMpPvqW6Y3xavxLJO0JAbbs4lSJkf9dxk3a7hiUoKK9PRkFytDs9zrceIse7zuLRII
 qN1534UXV8B28FO3FOmIt5C1RkxZ6XvFeBkuH5iIQwK6i8E/aiX8yrIYAlqWRxJRB4v9
 FzQD/IGT+3GK0mrudsOXR/D0rOyzrEozlHxR0b6ktBgMudTXEuu9zPEPKgMmFsYAxdw7
 SWDyIGnxZr2Hwar5Aca5vactsuAvvAibdqKAZg/ieyMHeWa1Ij4GXmJ6Bx9ytShsecGQ
 +Hz8pyLC8lhLskoyGXMLRwAmqlxdozIu6JoKaPkN3dWSx+eP99FV1kwhtcTtpFfPY2q/
 C0yg==
X-Gm-Message-State: AOJu0YzIpDQIQfNBh1BRz+VCF/qACQFbljncCfIcSppEayTHdCYzb6Ll
 zTskt0hqgZbbddWi1YrXeWNSw0WAnY6TU7SMywJA0FIG0avbccwbcfcYc/rWTkfKgfCkHCsQLgH
 QuqQate+rIw3AnVlVsiGuLZiV3tFfTgOBmcsC0OGpoJ22IdQIno5ZOwrM
X-Gm-Gg: AeBDiet+lsCWusx+Wc/39BsQClp+gS3LS6/WWpJ5JhSpJdEL49Sz8ZVnNkXuMp8V828
 IKeMMBApC3WfV8LKBcp8Ba72uittB0GgFPK5LbdkYupA1v0FDfEM2p7g56mi0ib1pWWSStxJKm4
 D3KmfdIRHLhJ3HXVa/WF5Lj1/wC2mfZvZWb8YuTgG/sgoT/cpFAAVyn8X8r21MHQ6DkaBu/8WtU
 48SuvZHbqKBVTooIDXXr18/8wDH8AXjOCpYAMq2+blIgEW7X6oLVxb25fBFGyDQKcFYNPRvZ0hD
 IlCkVYmy4ce5lONWQpb0lj/AxYqXB0HQHEfQAAHnYQQzTA0e2IWyBBfkhY9CrWsqj39Uq+JIFwe
 5E0kuztIjHXI0LRNdHUjNvnBKG4JBbfqVC1UdlH0YmFnmXfiiOkFHX8gqBA==
X-Received: by 2002:ac8:5a02:0:b0:50d:a6a0:8f04 with SMTP id
 d75a77b69052e-50e36c4189dmr418057951cf.42.1776971577668; 
 Thu, 23 Apr 2026 12:12:57 -0700 (PDT)
X-Received: by 2002:ac8:5a02:0:b0:50d:a6a0:8f04 with SMTP id
 d75a77b69052e-50e36c4189dmr418057461cf.42.1776971577150; 
 Thu, 23 Apr 2026 12:12:57 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e40aab60dsm157183021cf.18.2026.04.23.12.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:12:56 -0700 (PDT)
Date: Thu, 23 Apr 2026 15:12:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Pranav Tyagi <prtyagi@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2] migration: Fix blocking in POSTCOPY_DEVICE during
 package load
Message-ID: <aepvNu6ko5KfFY3a@x1.local>
References: <20260423094438.43556-1-prtyagi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260423094438.43556-1-prtyagi@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 23, 2026 at 03:14:38PM +0530, Pranav Tyagi wrote:
> The package_loaded event is not set in case MIG_RP_MSG_PONG does not
> arrive on the source from the destination in the return path thread. The
> migration thread would then be blocked waiting for package_loaded event
> indefinitely in POSTCOPY_DEVICE state. Where as, in such a condition the
> source VM can safely resume as the destination has not yet started. The
> pong message can get lost in case of a network failure or destination
> crash before sending the pong.
> 
> This patch removes the package_loaded event and uses rp_sem, instead of
> kicking multiple events. The error is detected in case of network
> failure or destination crash and rp_sem is set in the out path of the
> return path thread. This will kick the migration thread out from a
> condition of indefinitely waiting for rp_sem. The migration thread then
> fails early and breaks from the migration loop to resume the vm on the
> source side.
> 
> Fixes: 7b842fe354c6 ("migration: Introduce POSTCOPY_DEVICE state")
> Signed-off-by: Pranav Tyagi <prtyagi@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

I assume Juraj has looked at this already internally, in that case you can
always attach his R-b directly when post / repost.

If not, then it becomes a sincere request.. :-D

Thanks!

-- 
Peter Xu


