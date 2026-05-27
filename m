Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297E1CD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 06:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS7ti-0001qn-6c; Wed, 27 May 2026 02:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wS7tf-0001pA-De
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:37:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wS7tc-0005V3-7A
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779863858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=99hv26laU3xOjDxYBDwbdj8sZVc8KA0FHocO0j3PfOc=;
 b=brKlfogeUhurMiJZjW2M7HTeeVd3cbg0CJyTzZH4MdiviTeiIXRRdnVsF887pXd4yrRrYr
 3lOue79DUK4JVabyWL0QhR2TTI5P70oSD0+BESoZEsnOxq5pjEo0z480JNB8cY+YJkwBhd
 U9IAFyW9jDuu2GlbY5TNNVUlwBDmwb0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-Wfvr75rrM0O39CP-hDlKDQ-1; Wed, 27 May 2026 02:37:36 -0400
X-MC-Unique: Wfvr75rrM0O39CP-hDlKDQ-1
X-Mimecast-MFC-AGG-ID: Wfvr75rrM0O39CP-hDlKDQ_1779863855
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-44d9ace59efso6690082f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 23:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779863855; x=1780468655; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=99hv26laU3xOjDxYBDwbdj8sZVc8KA0FHocO0j3PfOc=;
 b=QP4iV6Cs82rhyFAMN+32+BaV0uitoquC7v0uos7nn07OO/8rT+zFaIO2BhEkGKXk70
 4bTLs8cnKb3+O+CYJD8Fo2bPpNNdqTGc7HwH17XmQzhhv3ZFoERCm3g7kpEsY113eYTN
 P8TP5+QGVaRRIMwXwfbvb1wp3zlJvK65q+5QBNJxrC+5AicUz2j0a89dOAGnqALx1w9S
 GTxNrMcWVuAJSHjy0WSEbw9AlMQY6oK4+DSHb+AAqQCO73MpH9ytXc6fHoavFPz0raXb
 9lydT6LV02Ctakr3wZQqJAhLoTznr6F/hkVsaIqcc6mDGoUKzD83x60BXckobUJI9++G
 6DGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779863855; x=1780468655;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=99hv26laU3xOjDxYBDwbdj8sZVc8KA0FHocO0j3PfOc=;
 b=GBpVEYUjUxto7ny6StBn9/+E33IPvCisuyFmWehoyJeLHFLZQpY4vvyQh0wAONcDmY
 eB2zIBxYQvGWk8D+OjUASgN5e5+eSiXTpRI/27zhYgQGzI32EOEJHQ2dRQqkPLi4bybG
 4FnFgRZA71PylZylp+loCTuAzlkFPrqGytsM9CIbbWWclXp8cmyAIRGnZrN2bbIa5jZl
 YOyvs9Jfj6j6KzZyX/qMyCMYyRzYUIaoU3QyouffaPSwR6H2zCmtHVwI94H2JEWF0xTR
 DpvYPKGwypSSVYb91vsKk3Ba7o2kF/Li9PrRDdTSHCk4DlqEiQjQ+N2Sy3R7msSzQHO7
 Wlug==
X-Forwarded-Encrypted: i=1;
 AFNElJ+WqDTAZExuGOcg0cefvq6U75erAPcIYlabtoHzQxI1XnEggLiSlccC40FzuZSybfK5ooscqYuiHP5T@nongnu.org
X-Gm-Message-State: AOJu0YxyNCPAanievTPfi7TYOb4f8y+YBoQyRMPklnZgEx0vjCjf78AV
 YnjG2qc99iMpVFRkKD9afk3RH04jLWbfMYytFTO/+SjbCtooKpFStOwjCuKR7oTw0Kd4lEXqt3T
 gnbkpMV8seCJb0RPvfg14LyHt6ui7yMFYc2a8oXs8MMpXy2Is+9Z4esoa
X-Gm-Gg: Acq92OFKZZWICAJL1gLP+snOz4zAny+6uzYLAHik0IMRTugjgyzYFm3SL1oGJns5hb7
 YCCBFObvTgJQ8QXkZVfm8AgdUU6V4Fo4AUUfETQRNLiowH5/FKeKsA/2up5dIBZNjXU82RNfVn0
 PZSU5ZIzjzyjuDpeYeSYgQNSYVeoo6nePc8exU1lXj/SA4bY212uEB2XxQCk0ta0pnA5qbwAXY1
 Ak1RwMGXkmfrteUpDZhLg69uEkJ2SSKgfru0ebBX67i1TyfsX489fDf1k+D543DBOuHQ82d/dEj
 pozzaVFr8PCB3uC6GdMlcjDP26d9lYVq+Tsl6Aw/tN+NkZtD1ppiI/PTxiihi8XGnjHAe9aKRzv
 xTWF7nu2nQkJyqQ8CVwf0JzmQCnEuINXJK7Cs3mhB9NvTIxQftB1VoCaq+Tpn0h5OeJbrMX8=
X-Received: by 2002:a05:600c:6209:b0:490:601f:d776 with SMTP id
 5b1f17b1804b1-490601fd9admr239463775e9.3.1779863855056; 
 Tue, 26 May 2026 23:37:35 -0700 (PDT)
X-Received: by 2002:a05:600c:6209:b0:490:601f:d776 with SMTP id
 5b1f17b1804b1-490601fd9admr239463355e9.3.1779863854687; 
 Tue, 26 May 2026 23:37:34 -0700 (PDT)
Received: from rh (p200300f6af2a6100f239e076bbd76784.dip0.t-ipconnect.de.
 [2003:f6:af2a:6100:f239:e076:bbd7:6784])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904561a33dsm342690905e9.11.2026.05.26.23.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 23:37:34 -0700 (PDT)
Date: Wed, 27 May 2026 08:37:32 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 kvmarm@lists.linux.dev, peter.maydell@linaro.org, 
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org, 
 skolothumtho@nvidia.com, philmd@linaro.org, maz@kernel.org, 
 oliver.upton@linux.dev, pbonzini@redhat.com, armbru@redhat.com, 
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Subject: Re: [PATCH v5 18/18] arm/cpu-features: document ID reg properties
In-Reply-To: <20260519132905.145643-19-eric.auger@redhat.com>
Message-ID: <1cc64955-1bc3-452b-b783-664acb2f8dea@redhat.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
 <20260519132905.145643-19-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Tue, 19 May 2026, Eric Auger wrote:
> From: Cornelia Huck <cohuck@redhat.com>
>
> Add some documentation for how individual ID registers can be
> configured with the host cpu model.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> docs/system/arm/cpu-features.rst | 106 ++++++++++++++++++++++++++++---
> 1 file changed, 98 insertions(+), 8 deletions(-)
>
> diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
> index 10b0eff27e..6203757781 100644
> --- a/docs/system/arm/cpu-features.rst
[...]
> +2. Additionally, the ``host`` CPU model on KVM allows to configure optional
> +CPU features via the corresponding ID registers. The host kernel allows
> +to write a subset of ID register fields. The host model exposes
> +properties for each writable ID register field. Those options are named
> +SYSREG_<IDREG>_<FIELD>. IDREG and FIELD names are those used in the
> +ARM ARM Reference Manual. Their availability depend on the host capability

^
ARM ARM

Reviewed-by: Sebastian Ott <sebott@redhat.com>


