Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD95C87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 00:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujSDa-0007Xh-P3; Tue, 05 Aug 2025 20:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ujSDY-0007XJ-Pu
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 20:41:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ujSDW-0000qn-M9
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 20:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754440875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WFHrbQPDjvEy1rLPKjpIHqvtevWkH34Ut1i0YjKrGq8=;
 b=GiIKmEyKupOB+bca0Emy7UjvE4E8rIBqxnGvl2eFaQoGEgv4vhsX3eAY5eOfTyxOKBSzkU
 yKrqmeu9Pj+aXJrA4wFbKgbDyxEbGF2pxqIjxat9B/l4lNnDxMfYQeKQkYFPXGNLp3axvT
 HghFdm8qIZG8a5a8AXznjKP+zq7l25Q=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-2acK042IPrO4L49Jit5Qxw-1; Tue, 05 Aug 2025 20:41:14 -0400
X-MC-Unique: 2acK042IPrO4L49Jit5Qxw-1
X-Mimecast-MFC-AGG-ID: 2acK042IPrO4L49Jit5Qxw_1754440874
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-71a0e9ab539so5653237b3.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 17:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754440874; x=1755045674;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WFHrbQPDjvEy1rLPKjpIHqvtevWkH34Ut1i0YjKrGq8=;
 b=lSyH5GWsQAMDlFM2xpIX2gf6uEDLqSq6JOr6cqbcJNDb4YU1KpYdV9CaAO/S3I8DRm
 bEHHStw7qXRSTk08qfHhQdFQdiwQoHgKr4i/rR1IkFtzTZWLsF9C4JWBVKjUGWlf/yRz
 scPPmPL1mnhk/16llhFl/LgHrVAgF7dwVz2DtiXfG/hEBGW/2zVLoCEr5XwJECO+FjId
 k1Zf9FDIdESNAjzACT5XTkwz+s2S3z4wrEsBKAQ9LQBhof08Wtzx1E/8Uu2aqneICzek
 yuYPVOF0aM2rNrRaIGwx2EDE7M7a0o8r32sv69xb/Q6TYTW32CZjz0d9v4MCxIA8hLti
 Q8pw==
X-Gm-Message-State: AOJu0YyKoWViSF5RavWqlxYWiTeTkRUivuAS4C4ewf8ApElbY6vmcTFU
 R//vgepxg5umuJLV5Ml78UHs8RjorVntYV5N+Y247OI+nSRc9l8NLvCoH2RSV5irfUfRc2t/Ew9
 OWjQvq710kxmJc+DEnuWiMU0iMH8utk7HfxyYrTmljqXfkCFhgHRqPLiY
X-Gm-Gg: ASbGncuVljqI1Mm+lfvWKvpbl501+7h398BP8RUTlHeIA7pLMv0ptvcfmZJvp6KuBCC
 kQWsgKm6w3W4YlzOmmL/bxh34s+8ZtsqI8EHCfVBVc804IXVf2pv9wT5keLRaDaYVCqotvKgJZr
 0GLYwhPxIWwVLMWDOdEtqhu+q++1SZ6B/RStHOg1v+iphmXuE1NUoe/kpamjdAivot8HpRNdqwg
 4A8iCSwOTu6EpFFyjEYFYA4uiNMSYp6Y8bIIalN4THHqUDjmLFKm0A0Jb6zzNrt0hl23UFqfzYz
 pUIehily08BYmHglK3nlonTtORXMh70HSVXPYBLxsgNwRGWwuoGuXq7cIsTA2SWZhw9LuvCIc+b
 OxMKbFCRSI673Mi9FhN4cFA==
X-Received: by 2002:a05:690c:c04:b0:719:d8dc:343f with SMTP id
 00721157ae682-71bca9e4cf6mr11290387b3.15.1754440873803; 
 Tue, 05 Aug 2025 17:41:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG054+KX7sivlybdNsXXQVZVzA6mOHN73EV+rbB57HT2mnraoQ3vpZG1LAG01lZpr1eqcTe3g==
X-Received: by 2002:a05:690c:c04:b0:719:d8dc:343f with SMTP id
 00721157ae682-71bca9e4cf6mr11290147b3.15.1754440873473; 
 Tue, 05 Aug 2025 17:41:13 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a3f8409sm35863267b3.28.2025.08.05.17.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 17:41:12 -0700 (PDT)
Date: Tue, 5 Aug 2025 20:41:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 1/2] migration: simplify error reporting after channel read
Message-ID: <aJKkpvqdyR7la9XA@x1.local>
References: <20250801170212.54409-1-berrange@redhat.com>
 <20250801170212.54409-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250801170212.54409-2-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 01, 2025 at 06:02:11PM +0100, Daniel P. Berrangé wrote:
> The code handling the return value of qio_channel_read proceses
> len == 0 (EOF) separately from len < 1  (error), but in both
> cases ends up calling qemu_file_set_error_obj() with -EIO as the
> errno. This logic can be merged into one codepath to simplify it.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


