Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C308BC54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWhM-0005dR-7e; Mon, 26 Feb 2024 03:50:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reWhK-0005cr-Di
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:50:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reWhJ-0001C4-1C
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708937452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vvbnA1iv4fmtD7TgV4uyM3krAeiMCL3K4+ahnyDSukE=;
 b=TIP6R+Ck3pyZ2ArNmwxktB4OhSgUEqqQyWvNQMjbO4wylehNcGxAoVV3OkdYYETHMTXk6M
 LmPk4ZY178oMRsqG1IH82wAKL//ylgpFFOhFT8EBy4VIgzPmYpb/6+sAgG4OHfW78yQEa3
 1eDTrM2B1YmqSI3CnCYd5Kb+9W2x10k=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-74NO0isjPluum5I0nZxu3g-1; Mon, 26 Feb 2024 03:50:50 -0500
X-MC-Unique: 74NO0isjPluum5I0nZxu3g-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1dc90a15eeeso1025045ad.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:50:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708937449; x=1709542249;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vvbnA1iv4fmtD7TgV4uyM3krAeiMCL3K4+ahnyDSukE=;
 b=v2L2ZbNBp0RMLhhSRKgJKn9sGtOtNWZD5y9IN0V/EhcCiZA5uc5apiiQ+v1vfO90nu
 hpa9dortt5er6IL8IIpYXk3A+4SOeEuavAcFuP0fUiJ4voJ0JZkSNX6GdVs9Q5bXSNjS
 OojI0xQo9gXMQvM0/NDLaAxkptn2QTzL31XthOKndK5Y7C3nPi2f4ejVEvWgY3smwa/C
 ZJVoxuZkNxy80goA5eB8V0nTF4gT1CV9TyxixaJ1x+xpANJB1DClXvWj2fVgeDAYRIBp
 UMCodxevsH050iHGPbMH+b65RhWHMscepjZ2K1RP4VvXwHA0SP1GR+82VPtVf4C6sqM6
 STfA==
X-Gm-Message-State: AOJu0YypQbSL/kNX/czCQ1Y58T7oRNvevtyDAYjQ4N4UMpi4o47s6W6d
 f/WuB2Eh6ZlSxl40BF87I4Y8DDi+CQaqtE5t+mrOabd7cAQdsC/6PLfcmEq4YwmUsPMTHE2qhTG
 j4jt48JnD1YR4TdBADv0dUSvNvDOTHU8F0wRYqbQmc9ElZoFsw8dL
X-Received: by 2002:a17:902:ce8e:b0:1dc:abe9:829d with SMTP id
 f14-20020a170902ce8e00b001dcabe9829dmr565703plg.3.1708937449376; 
 Mon, 26 Feb 2024 00:50:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG99FV7PVhiLc2grtzPy6Xr7dG9qhdnsKJkd136tXWJCRGp29eo3KsvfI8C9ymuOJMyl3CTzw==
X-Received: by 2002:a17:902:ce8e:b0:1dc:abe9:829d with SMTP id
 f14-20020a170902ce8e00b001dcabe9829dmr565691plg.3.1708937448983; 
 Mon, 26 Feb 2024 00:50:48 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 v9-20020a1709029a0900b001db594c9d17sm3406120plp.254.2024.02.26.00.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 00:50:48 -0800 (PST)
Date: Mon, 26 Feb 2024 16:50:41 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 27/34] migration: Add direct-io parameter
Message-ID: <ZdxQ4fU4RivwMgWE@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-28-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220224138.24759-28-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 20, 2024 at 07:41:31PM -0300, Fabiano Rosas wrote:
> Add the direct-io migration parameter that tells the migration code to
> use O_DIRECT when opening the migration stream file whenever possible.
> 
> This is currently only used with the fixed-ram migration that has a
> clear window guaranteed to perform aligned writes.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

I didn't read into this patch and followings yet.

I think we have a discussion last time and the plan is we hopefully can
merge part of fixed-ram already for 9.0 (March 12th softfreeze).

I suggest we focus with the first 26 patches and land them first if
possible.  If you agree then feel free to respin without direct-ios.  Then
we can keep the discussions separate, and direct-ios can be concurrently
discussed, but then posted as another patchset (with proper based-on:
tags)?

Thanks,

-- 
Peter Xu


