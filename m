Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EDBFA1FEC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdjb-0005c7-Oe; Wed, 22 Apr 2026 15:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFdjO-0005Mo-An
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:59:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFdjL-0000t9-Dc
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776887963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dNVs4KwZGxfBYtbtkIlgL20Gm/TzeiKisi1HuPyvt7c=;
 b=AX63ERloRzQzPKZ9b4Fuq/mcavzLowpTz+M1qiX9g2OUJmndODr5NJ3K/58+3562Gc2Umz
 665LloA6juCIml8WeIYuM2UXi+7XJ6I9h7/+I4zWLsy+uZOagMoQF5Uy3fCTivOo/hhQ5N
 al9lZb463wNz2JkfEaLTdiuHRtWunyc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-dsZ1dmZJPiio_bYlUNhh9g-1; Wed, 22 Apr 2026 15:59:21 -0400
X-MC-Unique: dsZ1dmZJPiio_bYlUNhh9g-1
X-Mimecast-MFC-AGG-ID: dsZ1dmZJPiio_bYlUNhh9g_1776887960
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d812c898cso159329611cf.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 12:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776887960; x=1777492760; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dNVs4KwZGxfBYtbtkIlgL20Gm/TzeiKisi1HuPyvt7c=;
 b=U0LLcZ4JS6Ijzf3DSqZYXBPtbCF6BwRgtJT/J9GieG32gizreegGho4lzXXMg2fZqd
 gGxBlJeJVY13gMOcuakFuQNkOXLfZELME1blYadslhkBasaNrMHF3cS4XWEWRFunHFgo
 AKj6GtTvHJG+af1TsoK5VHTx8wR8oI3fQOSkZePw7fbPhc/CPZEYWbi0Xn9/vcbJeCUB
 fFewyc762ZiOVb2/b0jO64DH6wqh67Frwc35kuh2q4OdwbMYI0tvHHrcw/PYuj+ifErz
 IbKdEvYMIgfGOjkqCHITIudo+Q4ezmN1Jt4o8Dm9a4w4mZu+ENVxzJ9NUzVvZKm6++RU
 19nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776887960; x=1777492760;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dNVs4KwZGxfBYtbtkIlgL20Gm/TzeiKisi1HuPyvt7c=;
 b=g7y3FoYuofCau5FV5r7/29UornDzAk4WvNHDPdGzx1YGwC0LOOEgr5EgaFa/I1gDM2
 qZLNbB921HqaQV+mlBd4TAqwVjrn836YbKVRtLH/4MnxQw4I04BxjmPuUjXhjeHemeqM
 PzT3s72FadideT678mJStPjoeke6qttyuVhhgUbPDPuOrWKWzk1i/JxcLTmnPbXaSjlh
 MicJ1uVQNvUmLWOnfLX6lNc6jm5DnXoiDvRPqwhdUi78+oDJUvPN8Jh6IQ6Cxv+XhWVr
 PwdMwTuM+Tnfsomg/YLMi5pTHtNL2ii/sF+kG3W/ffvlG03Qd5BMIanqnbbixm6p1Kbu
 IAfw==
X-Gm-Message-State: AOJu0YzOeM6FvMbfB7Nt6DtTyV+O4J27AB4RCb6Xuzh1a5rwpv25IKgY
 zIrP9Ez59E86Bl7DLL3aBAjpYrMTPK5HDcTmlaz1/h7RkhrpPmAz1rvySN64X8wys6paGyPIz7C
 bF9WK7PTf8i5RXq5j4u+oQyO6IVnX7OaIwN9ffWpSQqnirlcIsgRvK6Qt
X-Gm-Gg: AeBDietEK5ic3XLsFubohV5roDCmrUkVJjJ1oRmSS4Ud1nm1m4OQbr5+vJz6t2qcZkv
 HaYfpxZ+Z8Z4uSCwguHSz2hgkciCaWrxJFMI2G4DgHbKyKyZ8iOZlVmlhCqhjj+000K+0s1yVne
 xlJSa9HH65JVZS6ULuN1TVWS+kOA9ilrmaD+wdifIPJisLyROBcWK+fsbiHTidOMQn61vLiaqFq
 MENxAeDoxZCgpD+rAXUgb+DOPBxLtVtasjovmVTiWv5oTnqWjx2j1OHFoq+TxuT/nEaMS+yG+kh
 OnSARrUP5HICHMyKcZvSmVxJ2bXGeeVDEBK/xyTXhnY6rbwq3BQwTwF+ewe8Ve4sbW3GWKaAeSL
 IA4mEDwdsLG9XMwz1itdf5JOCLMe/5Z5SOoNE36eqsgrm6CPBARw6yx2ZTg==
X-Received: by 2002:a05:622a:8a06:b0:50e:6182:b3d with SMTP id
 d75a77b69052e-50e6182154bmr130470611cf.21.1776887960180; 
 Wed, 22 Apr 2026 12:59:20 -0700 (PDT)
X-Received: by 2002:a05:622a:8a06:b0:50e:6182:b3d with SMTP id
 d75a77b69052e-50e6182154bmr130470271cf.21.1776887959673; 
 Wed, 22 Apr 2026 12:59:19 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e392e4db4sm140403131cf.11.2026.04.22.12.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 12:59:19 -0700 (PDT)
Date: Wed, 22 Apr 2026 15:59:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v3 2/2] ui/vdagent: Use VMSTATE_GBYTEARRAY to safely
 migrate outbuf
Message-ID: <aekollHNEWxQBln_@x1.local>
References: <20260422082214.10390-1-armenon@redhat.com>
 <20260422082214.10390-3-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422082214.10390-3-armenon@redhat.com>
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

On Wed, Apr 22, 2026 at 01:52:14PM +0530, Arun Menon wrote:
> From: Arun Menon <armenon@redhat.com>
> 
> Migrating a GLib GByteArray is now possible directly using the newly
> introduced VMSTATE_GBYTEARRAY. It uses the standard GLib API calls to
> create the array, or resize it.
> 
> This is safer than implementing a C struct and manually updating the
> data and len fields. This commit uses the VMSTATE_GBYTEARRAY in vdagent
> to store the outbuf variable.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> Fix-Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Same here.

> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


