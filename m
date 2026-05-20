Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB620CD5BAB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjS8-0007th-MW; Wed, 20 May 2026 12:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPjRw-0007t2-Oy
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:07:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPjRn-0001m7-Nu
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779293221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lg1GDOVW29f3Ep+49eDdlKR9rCS4L4LaSDdzA1RY0D8=;
 b=LmsAIfFq0r5tgOq14RYY5iQ32QMnmWoRtQIFb2110tmCrxWbcvs7OAKeFzbTOiptffT6mA
 okDkfLD/Uw0694lOtNOna5R8r/BsV6E9RscaKpL2V925GXo1RladsvN87NA46hR1YURUYG
 BrLxjiyqPpgPl+bswRxJDKMLzjnhIOg=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-dqOykyQwMzWOY_wre0bTxg-1; Wed, 20 May 2026 12:07:00 -0400
X-MC-Unique: dqOykyQwMzWOY_wre0bTxg-1
X-Mimecast-MFC-AGG-ID: dqOykyQwMzWOY_wre0bTxg_1779293219
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-479d602f323so13055260b6e.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779293219; x=1779898019; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lg1GDOVW29f3Ep+49eDdlKR9rCS4L4LaSDdzA1RY0D8=;
 b=BSqnztx8/QLAQHcxlMMDkdfgRlm4bc98cCJKvnaB3l5ODefc3CojZnfUyn8H+O70JA
 APeRBLujp0IwUJ24y/ic0mNpiBZO4U9yC9RAiroGQbai/yShLKlu4mrD9+JqRxTMmqsj
 wNj1oci9AwR9xnTThL0YPODJn9u0JGW+H1QxcpNoRHG0CmCEwYUAMtGSOh/iNcX9T8ik
 3Lm5hLLF876qqsB7yhNtPv6C+jXEs6aivWY0ow0AHt/RNJCThS9PTyJDE5JdfZpuRG7J
 qBqWlMgLmh59621tSktnvjlo0ZPi3hNJx0yZM+owYEeqiHotLySkcqQooemQaXwNmOCL
 AGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779293219; x=1779898019;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lg1GDOVW29f3Ep+49eDdlKR9rCS4L4LaSDdzA1RY0D8=;
 b=ONjAset7WH/tOXcjh5SFifX2MGfBCnR+tlzl+p33GcFg+KmhtBDozTG9o0XeKiVd6d
 PN/zoPvszfSS5SOkWe4slkL0pllHnM2y7Ms161iH+lvfDsTjGhMxftrwz7/nNdnnO74q
 lmvAIVhhRitN3l/D2x0F+r8brm3r0V1oE76rQ3s4dU2BTUZ4WvZ75Lqe0JG5KeDtEdgQ
 +/Pw1X74XSqvmkSA4pKfqBqLqyrfrg7vDTzF6Qp2nZ0UHXO5+tP2rgt9PLMPAcM5ViJT
 7SuTk7LznGE3X9cTApwKb4TzB0KgW47ryV/r5b3582Pf+2gRFK8mGud4uyxoHD0YFu8Z
 vjYQ==
X-Gm-Message-State: AOJu0YzYoekmEEEHpEnujhOqkhuCRovgiEBvcOIGjzQ/AGfcV8T4hT2u
 1Ojz7OaZsgfwBXa/yJe6TWsscBNK722x6qu51RuzLsgwQG6aDQFcTxzGMeNsQTqv44RGFhUrPwa
 WRKrcR2ixDUIoCpdlF5lxBmes1bFP1KZ4BPKA5KApLaHnUHrOET61/Z9H
X-Gm-Gg: Acq92OE8/xWdNFo+9EGdNg4fA85WTgZVvAz4ZEkvFdSI02sr4SRs7mduvsIe+ZUdpXZ
 YtxrPKmcWgO3A6RUWBcK+bBED4yry0gZB9jDP2at0//cWN28v0zKwtmZCowydOZJGQMwnQ6OPRZ
 xbk89zuKtN/7jFMkLZXG437WDN+Z3OuTI4BUd6ZM4R96ws6OD8JxF5Lu6Utzd9SIB2VjsoonUg8
 yqEtug4Hzx4SPdGpwMf9BZi9TkObvyijqdSsoR0w5/l4+CpiconfT31jTndbgGWEoNORxlByPDf
 7oOSjOjREWxitMi/Uw4rabqf5s6cyB04Nx5Uk78eOuT49V+lJHJOA/Vox0Km3b0ruyjmsGckIXi
 A1IwxT9R0LhfSMEk06kjhy15TrPELcJUDR30iAWHqphAtr5c=
X-Received: by 2002:a05:6808:3a14:b0:45e:f0af:5148 with SMTP id
 5614622812f47-482e572b473mr15642749b6e.30.1779293219392; 
 Wed, 20 May 2026 09:06:59 -0700 (PDT)
X-Received: by 2002:a05:6808:3a14:b0:45e:f0af:5148 with SMTP id
 5614622812f47-482e572b473mr15642704b6e.30.1779293218874; 
 Wed, 20 May 2026 09:06:58 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51645687d30sm207716421cf.4.2026.05.20.09.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 09:06:58 -0700 (PDT)
Date: Wed, 20 May 2026 12:06:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 05/15] tests/qtest/migration: Use precopy_unix_common
 for ignore-shared test
Message-ID: <ag3cH5vK8NHK_zMg@x1.local>
References: <20260505160915.25558-1-farosas@suse.de>
 <20260505160915.25558-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505160915.25558-6-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 05, 2026 at 01:09:04PM -0300, Fabiano Rosas wrote:
> The ignore-shared test has the same code as the precopy_common test
> but inverting (probably incorrectly) the order of a few event
> waits. Change it to use the common code instead.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


