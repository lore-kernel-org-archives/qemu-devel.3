Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4920D19501
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 16:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkPRH-0003i7-PY; Mon, 26 Jan 2026 11:27:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkPRG-0003hr-0I
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 11:27:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkPRE-00026T-57
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 11:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769444858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CLGAalpr1BOvNDsXKZ3un1OQRRPheBpFMA7ID+WNbe4=;
 b=Ks3RFLLv3uFQtohFzlvT4QpYblI1in9QLSZo1WpkDGDhpuVyfP1kVIKh9X6+aeCrOAq62y
 HPrSw88edzCgafquMyOOLDnuTPrIo0zbscZjsPwlKMi5xxhwSmrdEVR7vdKLXHwXhYq/6K
 1UEX7ZUh6HERcnszn+YkWITUAAzT9U8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-PpG0IBt9Nju1upRPo5EcYQ-1; Mon, 26 Jan 2026 11:27:37 -0500
X-MC-Unique: PpG0IBt9Nju1upRPo5EcYQ-1
X-Mimecast-MFC-AGG-ID: PpG0IBt9Nju1upRPo5EcYQ_1769444856
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88a2e9e09e6so219833836d6.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 08:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769444856; x=1770049656; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CLGAalpr1BOvNDsXKZ3un1OQRRPheBpFMA7ID+WNbe4=;
 b=Tlth3jLH3c2JevHNdb6MBlyYSMMY+p2gXjYzHBcsnjTZnbDVDQZBLLNJfAjhfVFRCD
 i0H4ZffaEzZzjNzHbYLgkZ+FndhCzn+cx59lDJ8nijjB9nFLZEDlmm/YOh+wUpdIHj9G
 2oHOil3R+SA6Kh/rLlbKXcUtUhnTp07G0LnT+InE9X4buVdPUTFmqhd8fQK2o8kEVT01
 MVX/XVwl9ONqO4ruQF02MCIeDkNOAbMyhtD/FA4IDGo4hN/Vm+MyRxZ4v96JW1ZTUsDS
 MclCUEGaLBwtVJS+9YCvVhk9naxnog+OauiSSXXTSXTYpDXafVSi2cPthdIncqMmeHcD
 l1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769444856; x=1770049656;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CLGAalpr1BOvNDsXKZ3un1OQRRPheBpFMA7ID+WNbe4=;
 b=TcdNuLw/RMMTkrAyMlHyMKazlCfbtnVPmhZydukbWDBoBePqCZhv9IxHrt2y33sdhV
 aKR8KxSMSis+kQgZecERnA0/ycUwqgddTVy7roGaidtSBk8HFrKifwXOrwPxeumGl6o3
 BDXtp81zgBOnAgOwbYeRE4pqxk0z++U9LQAmm4Yi+QVDmBPvoxzcam+k6x0+GUdI4xoy
 CR9yBV5iNfeg6VlzeN3RmG2XZXDOkTyLojFIO719vr5/IyTbHEtRVlxOrfnNM2uJjqje
 O6h9Rj3Ldv3DdlVYwupFSxXTJGfFfyVIHe3JBr0a16eNa9cwDHPAtjLZCBs4QDbkQHE3
 XTYQ==
X-Gm-Message-State: AOJu0Yz4q/8/0fk9JqTAbcnr8g6UXpY7tjTjFM3ciTuZC3zQDHNryOWW
 +tQUKXc8MK18JKSDIridwj4hTOPeht9Zw4wt1MlXLBhDlxyiHH4jF4Ek9yoqinOSspo9gYDkERg
 pEDTarEd86/P5V1a0yAVM1OH9cl8h7hLN034paKtmNOo8+VpUUr446ZjG
X-Gm-Gg: AZuq6aI2qOwH9layOH13YpXadx2pN/6rD1j5EZ+nA6P5rFqE92fsGXeOXCItzCANIQa
 gx5NjpaKftthxsSkqWLEysAkJMIrZ++a2wWHQhZWqOuwMy6UFsDshRqYwCzurRkXXis4jsq5pUR
 o+6/fi4bvq2sDxmrbcv/b1ymAl83JnnvZJbKYhhpDcVURbru74fz780DIuS4/gRwJhsdYvF6I77
 +ZXoElv3G3ZmU99IxUZz1uycpnAI6SemzhHEeAgv3tKU1sdxG7eB/ArQzvkLAWJH3IXJQgziOYe
 L6Hy6FAZchYCtWoboIq8GZBb1uzJF0Y1r/2HmzZZs50qbJkI+JMAtgcqyHp4BHhph4qxZixI22V
 niio=
X-Received: by 2002:a05:6214:1c4c:b0:894:3c27:1765 with SMTP id
 6a1803df08f44-894b06cb1d8mr72607556d6.6.1769444856366; 
 Mon, 26 Jan 2026 08:27:36 -0800 (PST)
X-Received: by 2002:a05:6214:1c4c:b0:894:3c27:1765 with SMTP id
 6a1803df08f44-894b06cb1d8mr72607086d6.6.1769444855854; 
 Mon, 26 Jan 2026 08:27:35 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894918b1436sm100656686d6.35.2026.01.26.08.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 08:27:35 -0800 (PST)
Date: Mon, 26 Jan 2026 11:27:33 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] migration/options: Fix leaks in StrOrNull accessors
Message-ID: <aXeV9fpBm_kKNi6t@x1.local>
References: <20260122232456.12722-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260122232456.12722-1-farosas@suse.de>
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

On Thu, Jan 22, 2026 at 08:24:56PM -0300, Fabiano Rosas wrote:
> Fix a couple of leaks detected by Coverity. Both are currently
> harmless because the visitor in the setter can never fail and the
> whole of the getter is unused, it's only purpose at the moment is to
> provide a complete implementation of the StrOrNull property.
> 
> Fixes: CID 1643919
> Fixes: CID 1643920
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/2280325023
> ---
>  migration/options.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/migration/options.c b/migration/options.c
> index 9a5a39c886..9dc44a3736 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -225,6 +225,7 @@ static void get_StrOrNull(Object *obj, Visitor *v, const char *name,
>          str_or_null = g_new0(StrOrNull, 1);
>          str_or_null->type = QTYPE_QSTRING;
>          str_or_null->u.s = g_strdup("");
> +        *ptr = str_or_null;

Yep, fixes the leak.

However does it then mean a get() can internally update this Property?  It
used to be NULL, now it's QTYPE_STRING "".

It may make slightly more sense to me to have zero side effect on a get()
call. Say, keeping *ptr==NULL after get() returns (as before), while we can
use a temp string ("") for the visitor.

I randomly checked another get() provider, e.g. get_drive() does that.
Should we follow?

>      } else {
>          /* the setter doesn't allow QNULL */
>          assert(str_or_null->type != QTYPE_QNULL);
> @@ -245,6 +246,7 @@ static void set_StrOrNull(Object *obj, Visitor *v, const char *name,
>       */
>      str_or_null->type = QTYPE_QSTRING;
>      if (!visit_type_str(v, name, &str_or_null->u.s, errp)) {
> +        qapi_free_StrOrNull(str_or_null);

This looks correct.  Or, simpler way is we only do g_new0() after the
visit_type_str() successfully returned (and pass a temp char* into it).

>          return;
>      }
>  
> -- 
> 2.51.0
> 

-- 
Peter Xu


