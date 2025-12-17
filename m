Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD74ED65C7B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 17:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVuuT-0001te-7C; Wed, 17 Dec 2025 12:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVuuR-0001si-D0
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 12:01:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVuuP-0002UT-Tx
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 12:01:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765990912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=THNcI3H9DQNp8JDUpfsVkcgnJpn1TgFE3TT1umGdKHs=;
 b=KFEHvf5SRSHlHKwVJ1R3cQdeJ6deuRKu/4qN1CiMWHZNYW8PrXPsxFb2mKwVJlaiGuhNGF
 dvapK+h1FBd1ykteLnd3kI6jjh5nuMP8HvzBB5zm3g3Gaifq32LSVQgSGxQ6cALgQPrnY4
 gjiaii64Wt4tlLU49GQVA7SLpwnKOVo=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-znzV4yqQMbqtGEIPCncW2A-1; Wed, 17 Dec 2025 12:01:51 -0500
X-MC-Unique: znzV4yqQMbqtGEIPCncW2A-1
X-Mimecast-MFC-AGG-ID: znzV4yqQMbqtGEIPCncW2A_1765990910
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a0f4822f77so90250175ad.2
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 09:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765990910; x=1766595710; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=THNcI3H9DQNp8JDUpfsVkcgnJpn1TgFE3TT1umGdKHs=;
 b=fwgSaWTpHZ3MZeOVEI/LKP5leJITjL7tHx5Q9HHfT5S9i1pE/Jqu8OokVdI1nE+63+
 AecHOUlD28zwgm+si4kr3NIHBdDpO/K4cOH4HIfyn9iH+UuHCbt3DG3e4TOC1lbCere5
 mjMWraZsFzTltDeNRifPba5UlXgIhhbPoAWMp6Mvw7WxLRCKn/KsS6LI/gYzGFmk4hOQ
 J8hSsDeSOcAA/3yjlML4TtLaS/khtNAy1JcQ1SnVHypIJpyk7IpQv0Iw1zKBM+MUiCZP
 OKgxkCJJqvWc1ws8s2TfF47o0Mmn1UHcQgT+0ddafA0nyoqe6k3k2OyiGtLU3DZ98+sX
 TE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765990910; x=1766595710;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=THNcI3H9DQNp8JDUpfsVkcgnJpn1TgFE3TT1umGdKHs=;
 b=wag+/XBPriX8VqBVHvo+ZWIWx478Z8iHdNvVyB+JWqViWxRgM5Ado+cO5VqTfh2rhj
 amHXE6sNgbRa6TgHgG8jBJVewvLBpU4WkRwRAlzQmKoP8B48T2u7B+nDIPASMn7FzUx/
 a+hlZYe9JJv154MFqpZbybFD1alUf6xlSXeDvQx4CRmfHWRBwVmOjURvMQz4u7dDK7hP
 zRRkbenriy4Zl0cAbA9GuOb2qnsABEZkw8KNkt0E37701fxec3oNOO5+7RmqDidugsX7
 U8SsiDXinn+IS8QjGSwdFEG6Y7ICslDzx4MNLGz2uL7B9zBE8Aoe2GqCDLDhTkjb03pY
 LhGw==
X-Gm-Message-State: AOJu0YzxW/iAgOjpDLv0cevK8Cmn9oc69zmeFxZ1NfqfxZtynub7ORfv
 wwo68+oXn8qWOLrSawxqU7GJXcZPv0hvUwZi8teTzabi6ISo6rbH7tRL+ssLazkthrIEA/7j4Ii
 ojLAYPw+cpHQqZbEE8IKwGjOZhfzU0c/GTUbL3RoSeiiN202H8hNDRQXx
X-Gm-Gg: AY/fxX63/R6xQTOaHEvTcyVFaRAAS2qaX7xUqpIbNCggTcXeeqoVTjIPeSs8C4mG/JJ
 5XPbl52mUgCM+qwpfF0rvvD/y4vXXVzyedZbPs6KE8lud7iWHJngZF8TQTqZZ9SmAisvf58h1w6
 46zvyE7tP5tMhPKwWhYRd7g+rlUUm5S9AzVC1E32oRvF7pDWW8cuY6V68C5OZgbpstezZhKc3uL
 330zPBSyZic3jyH0f5LWgNigBmTbIZwbLAPpujIkefNe/Aiaca+ossuL3p6HRhmuItUKnRkOUkC
 CP5c0vwJyzaCftJx9J5JuCUaRrJj9gHyCGFR+WNYkSzqEOkQcFajRtJFautD0lf2oS2pf6gn/wh
 I084=
X-Received: by 2002:a17:902:dac2:b0:2a0:98a2:3ccf with SMTP id
 d9443c01a7336-2a098a23ebdmr153445275ad.40.1765990909822; 
 Wed, 17 Dec 2025 09:01:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjWDuqr4VzyYNOM+3izdAo+eCGUilsOQjXXOWJ+82OJ//nmlpALx/iNwOy51rjvrRAtu7HDQ==
X-Received: by 2002:a17:902:dac2:b0:2a0:98a2:3ccf with SMTP id
 d9443c01a7336-2a098a23ebdmr153444675ad.40.1765990909164; 
 Wed, 17 Dec 2025 09:01:49 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a0833e24easm148875155ad.100.2025.12.17.09.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 09:01:48 -0800 (PST)
Date: Wed, 17 Dec 2025 12:01:42 -0500
From: Peter Xu <peterx@redhat.com>
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, sgarzare@redhat.com,
 richard.henderson@linaro.org, pbonzini@redhat.com, david@kernel.org,
 philmd@linaro.org, farosas@suse.de
Subject: Re: [PATCH v3 1/1] migration: merge fragmented clear_dirty ioctls
Message-ID: <aULh7yGbhqm2w1ld@x1.local>
References: <20251216080001.64579-1-xuchuangxclwt@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251216080001.64579-1-xuchuangxclwt@bytedance.com>
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

On Tue, Dec 16, 2025 at 04:00:01PM +0800, Chuang Xu wrote:
> From: xuchuangxclwt <xuchuangxclwt@bytedance.com>

Another trivial thing to mention: Chuang, while preparing for repost, you
can either remove this line (you already have From: in your mail header, so
this isn't needed), or change it to your real First+Last name.  Otherwise
git log will collect this instead of your real name.  Just FYI.

-- 
Peter Xu


