Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F93C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 20:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viej4-0002eW-4f; Wed, 21 Jan 2026 15:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viej1-0002c9-Pa
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 15:22:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vieiw-0007Ip-JD
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 15:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769026960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gx32nnrG8amCxYcgz29bbuxnIQeU8m6EhOk/v6pg4Ug=;
 b=du85cQEcdz57aH4hC4GG1XKAIrf5Qnx2Cj3weLL6lY5OaNmUOxPWzNF5KVVssfu6PyW6aQ
 kIK6UkaZFTk0Xmk8QbeUoW7n95I0/UtOQCFxryGv9mt3rjic0QRPnweaKgwgvDdZiSTeFa
 Utj9IM0ivmsd7WaF8J2xdsmueA25aQQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-eWGI25ApN4-G4LyObNV5iQ-1; Wed, 21 Jan 2026 15:22:38 -0500
X-MC-Unique: eWGI25ApN4-G4LyObNV5iQ-1
X-Mimecast-MFC-AGG-ID: eWGI25ApN4-G4LyObNV5iQ_1769026958
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5014c9ee70bso5379831cf.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 12:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769026958; x=1769631758; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gx32nnrG8amCxYcgz29bbuxnIQeU8m6EhOk/v6pg4Ug=;
 b=KL4wdP4Lvh6mFQHvw60lvrry0VBe4lHj/B2G6FGnutD2HEA1JIuPy+oc9gGNrnGgls
 ge5KyKr48Q7CRtEpweLq0oUUsfn58Zb6oqjQwcpK2c0i3XeaiKmsbUM7glnOvaZ/XYS7
 wQ9Fn74fb27+ilIvltzCsJlskj4jPe97QkrvPwdx05SpA3Zr6ptjB4Fnl/KCUmpvzjPn
 zgn2CiJoKt/xzFDepHoyVhamg74CqKzcGt+TneJ5P+wbBkIdb4lRLzpuscIfUq2Go3s6
 1Vw9OtPz6a/akKZVTz81D/kUqL1jhyHvTY307mnCEsT1HfwQpZn79VBOX9Y7MTLl2Dg6
 VRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769026958; x=1769631758;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gx32nnrG8amCxYcgz29bbuxnIQeU8m6EhOk/v6pg4Ug=;
 b=ZvL+CfzbjzRJWqxIPwZgMqjO9ZjiMRPmDrUfdeUPa3Rkz5F4H4Xz19omk/6GA7pUXx
 V4cRgyNV+xIqrJyAhl01z8CBZIvj0OKIr+abeX7UXAUl1yoCR3osSEoO8kN6d+W5W0qL
 x9Rv8UiXQnUf1PkL5OFAyaLqQWxiY/SdHi/+IRcbBxqYC3CNdy3IJyqoSnrJ+304KOt2
 MmEZSG1/7iHPcFZqJckmM9oKfX2oaTGJiZ8M8Ue4EGPvA0yHlX7yiFnITyYEFaFM8XrA
 LhtVclg+cALjV47QLumURjXyAPELxJeEP88u2UtS+nTuTBmhhWGu1kPGEkLBlsNXJxph
 4VXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzgeP4BwBqcDI9kJf/o66mqdeQerYHMe0bcQDBOXP4v1JVUMDdX5v+I0YfGUwGUuK5Yexnryl6xjBx@nongnu.org
X-Gm-Message-State: AOJu0YwcDiTEXiJHX7h9gm3TyRpMJCjXSv19UPoCZJDf4bXQiqGclf1k
 g0rIgTzBTidVEutIlVF781Cdp6lHgFnWhqXWX9IAk79DclBVGDrC4KeiPhioL4jU8spl9UMRPND
 7YG5bFZchotSwolD6kofBeOGGlJ/t7QrP56pqap3xZOXlPWZek+cG8rfJ
X-Gm-Gg: AZuq6aKfwxxvsik9dmFK6DFHq8mb8u5oTxlPrkKLcVu3JWIaTpHKbQVWCEj47RSIdr2
 UQICDoRCpYTRBhC6thYyA0jOcZEYWEaRte3A2asFoXj9i5sjwi41vZsTvSVlVYa1CutjTXnu1Bu
 ExhCle93rrDwxQGo9th944gtVCbzEEYzCsTAG8NfSUCreX/w9AQmNGrASTRwhfREqq2e5/fmPMM
 YSjOJ1sSF1FAFBp8tvUjaJohDO7mA+sTdtPa/ivbQcFrtVbE9u1VMDUIy+mDEU7YWFJRzKSW8yt
 SSKJh5GZD1r0HdAe1dGoNCmFwvBT4x7WmOpc72l5JkZmrn+/CpWsxEN77PSnAzYv9PbPuzgTF3b
 pCT8=
X-Received: by 2002:ac8:5dd1:0:b0:4f1:ab66:7c43 with SMTP id
 d75a77b69052e-502a1fa2386mr272547651cf.74.1769026957994; 
 Wed, 21 Jan 2026 12:22:37 -0800 (PST)
X-Received: by 2002:ac8:5dd1:0:b0:4f1:ab66:7c43 with SMTP id
 d75a77b69052e-502a1fa2386mr272547121cf.74.1769026957524; 
 Wed, 21 Jan 2026 12:22:37 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1d9f480sm119700511cf.13.2026.01.21.12.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 12:22:36 -0800 (PST)
Date: Wed, 21 Jan 2026 15:22:35 -0500
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Juan Quintela <quintela@trasno.org>,
 Zhang Chen <zhangckid@gmail.com>, zhanghailiang@xfusion.com,
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
Message-ID: <aXE1i9xJ81EWokYz@x1.local>
References: <aWl6ixQpHaMJhV_E@x1.local> <20260117204913.584e1829@penguin>
 <aW6xNcsz3RIqHeE5@x1.local> <20260120110811.7df19a6c@penguin>
 <aW-mCye_eFmy5f4B@x1.local> <aW_Rqbc2Swg8vkXY@gallifrey>
 <aW_ccMSY4xJlRVn2@x1.local> <aXArDHMRAohmUt51@gallifrey>
 <aXEG73I8tJyhpn69@x1.local> <aXENdA6DP5j0ETIU@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXENdA6DP5j0ETIU@gallifrey>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Jan 21, 2026 at 05:31:32PM +0000, Dr. David Alan Gilbert wrote:
> Right that's true for postcopy; but then the only way to load the stream into
> that buffer is to load it all at once because of the vmstate problem above.
> (and because in the original postcopy we needed the original fd free
> for page requests; you might be able to avoid that with multifd now)

Only until now, I recognized that COLO wants to make sure the checkpoint is
either completely applied or none applied.

So the specialty is COLO does loadvm on top of a running VM, meanwhile COLO
may decide to not loadvm afterwards if checkpoint wasn't correctly
received.

And yes, to cache all device states with current section header definition
in the stream, we'll likely need a size.  We can still parse the stream as
you pointed out previously, but I agree a special SIZE header still makes
sense.

I suppose that answers my question indeed, thanks!

-- 
Peter Xu


