Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49094C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 14:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viZWS-0008AU-Db; Wed, 21 Jan 2026 09:49:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1viZWJ-0007xf-3P
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 09:49:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1viZWH-0005BG-Jz
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 09:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769006956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FLa0kkFrKbYh7alYxl6Kcao/LKAMMi8l8jUkHIgd37w=;
 b=IQxH2AESktEUchfn0SplDl63RohJPPEFgZjkfCxDEn8haSnM/v5NMu25WROtGpAkoEfUhJ
 Ifnm1cyzw5eqwysn+WQu6H6CK92bASbSsv2fa9zVRK1cvbnqXZR9/l8H05HdfO9PXDxA2o
 iutQZBlV0dX7l/YjLrWxi8BxLZTInWo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-s5SW4Y2fOBa62grproLhMw-1; Wed, 21 Jan 2026 09:49:14 -0500
X-MC-Unique: s5SW4Y2fOBa62grproLhMw-1
X-Mimecast-MFC-AGG-ID: s5SW4Y2fOBa62grproLhMw_1769006953
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4801ad6e51cso57590955e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 06:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769006953; x=1769611753; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=FLa0kkFrKbYh7alYxl6Kcao/LKAMMi8l8jUkHIgd37w=;
 b=kNbI5Mf1BSPa+4pf7HU1ooN0coIttVxYQt6uB9q3rr+31Q0eWIxFYWibWGAPB8Whkn
 TtissdGOCabQ7jeG8A4DemKJYNM4/bqDDvHwv5hJabkEOQ+13MJaflN5EriOgme12Os5
 Y3CbC8aPIrVur5KE+5fycJNnN5JAJ1/FJcBBv5K3RwSoli0/qCLgFEi+xs6FeUS2Uxev
 tg1hpQL+zMuygitmDUdiwt+wUiuuggZRRMRtDquR/oYqarY6qXVdz+n0tPmbxdg6t52w
 EtEQVefJRtx6CPxTUx3SdweEQJSIVDufKFpWROx0jxigUHdCn9Dyf0xInQfUER5W+8bP
 nTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769006953; x=1769611753;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FLa0kkFrKbYh7alYxl6Kcao/LKAMMi8l8jUkHIgd37w=;
 b=jDN5iEymgeYMVw6jvYw4qgFULczZkpuU3Qb2mD49hiHtM+FgdX/aH0BBHdi9WY1gHI
 bNh5pWqH4ZC/geD8vEJC13BOjLdEOJwB4SyTNkiA7cqqqr47pSju4EnHojqf5+DSQ29H
 2umxEFhBentm5lJ4IWpFmga6kUtjfcYKJqx0i4HiX4vqBW5sw6Sh70mJiQvnCpXslPff
 mpMW43iGK/ZEiTJOj1Em4vpLt/i8lTA/fquZwqOfeg+HqmyAVjT3wUth9SyBioMm6KcM
 SYgmrQuoHXlFUkESjJJwMkETPanw/63wOZM8c/wMrcvqJHk0Um00ZY+b1f+2DdOKJMzP
 Q3gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWROWZg9J2w8v2JqTtvdo9lIbWlsAd8Z1S0/lQvUmFhWIqoTUNwbzWjqLV8i8DnPsFPqCPosV1LTYE9@nongnu.org
X-Gm-Message-State: AOJu0YwZNN9BlRhtCe3j0ZwP0kNziQNnqEZRbP+Ey2pEb7vTc476DXlA
 30Re1LFPaYVEoAnSXqunHUsHl6sP8sMPtFuwtyzo13jPUVZ77eygYfhHv5c8rlzGaKk+74Fy2fS
 0htd+kGQGY3Q+6X5vKg64hxHXQBzOUuKcRLhT+cPvA3jqvplBGIAFHaKs
X-Gm-Gg: AZuq6aLpEfIUFFA5sDVYiAOf2u3tW+jnLD/lH4z+IPbnY2hEut1hfRpV/Aly5ROjx79
 Bvxe3xn70w5GUj7ewo8kWu5lURXEd3Lqs4NMv2it0skCgVY0A0FbThcXlsjUeQL9M/bxjQM2Gsr
 fT64+//R7HCW7t77am4l5fbaRKcIXCPuOScdTCOo+kjMPSyPibeCKBYIyqobJWRCW8wcsgKkRNX
 Oli2R7H/ROGdWtRTXCJyM7ZBzlNcSaf3yN3if1hOqdYslEAPEyQ/1d+Flwm33woNcd6gBUG2VLw
 5qYIZsjEgNreU8qRXp3eiRvj/pzhSceksAFf7z4P/WqvoSFXWaMxOqi6bGQ70IQHMAgm6ERduac
 vYvYYEiXoLlu+olXud8EEruJ9Lg2wksgwx6idoFLFEnlrwDdVS4xr+gtF6zU=
X-Received: by 2002:a05:600c:a00f:b0:480:3b4e:41b8 with SMTP id
 5b1f17b1804b1-4803b4e42e2mr112453715e9.33.1769006953463; 
 Wed, 21 Jan 2026 06:49:13 -0800 (PST)
X-Received: by 2002:a05:600c:a00f:b0:480:3b4e:41b8 with SMTP id
 5b1f17b1804b1-4803b4e42e2mr112453565e9.33.1769006953116; 
 Wed, 21 Jan 2026 06:49:13 -0800 (PST)
Received: from rh (p200300f6af31d00062ddfb9151537832.dip0.t-ipconnect.de.
 [2003:f6:af31:d000:62dd:fb91:5153:7832])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8795f1sm320263365e9.6.2026.01.21.06.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 06:49:12 -0800 (PST)
Date: Wed, 21 Jan 2026 15:49:11 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 2/2] arm: add DCZID_EL0 to idregs array
In-Reply-To: <20260105154119.59853-3-cohuck@redhat.com>
Message-ID: <6757a74e-a0b9-7ef9-bf16-b9dbb3012096@redhat.com>
References: <20260105154119.59853-1-cohuck@redhat.com>
 <20260105154119.59853-3-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 5 Jan 2026, Cornelia Huck wrote:
> Continue moving ID registers to the idregs array, so that we
> eventually can switch to an autogenerated cpu-sysregs.h.inc.
>
> This requires a bit of care, since we still have to handle the EL
> specific part (DCZID_EL0.DZP). The value previously saved in
> cpu->dcz_blocksize is now kept in DCZID_EL.BS (transparent to
> callers using the wrappers.)
>
> KVM currently does not support DCZID_EL0 via ONE_REG, assert that
> we're not trying to do anything with it until it does.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Sebastian Ott <sebott@redhat.com>


