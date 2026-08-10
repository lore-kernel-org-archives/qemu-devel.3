Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AB7C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 15:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtSGS-0005LS-1O; Mon, 10 Aug 2026 11:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wtSGQ-0005ID-LL
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:50:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wtSGP-0008HS-56
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786377008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O2zhm1K4eCq5mPSb3Ty1evscwBNKJ0KaL7VbpdQ40r4=;
 b=OIXp2Nj3DkGzkQ7cS7fAApYltg9mPnPX9SN4sd/AUnrjzQnXxLYS0tHrpz9RpSfzAageuN
 VNroBVykVJSp2YBQjnSUvxgga9wHXxWTH25D4/ckOMAzOSLb4Vq9bCa0P7bJuP3uCQ+7hI
 ML/NtTxy8NIl7UKxj7PssPrS99vlPhw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-1JZdihQiNu-VsKWwub52Lg-1; Mon, 10 Aug 2026 11:50:07 -0400
X-MC-Unique: 1JZdihQiNu-VsKWwub52Lg-1
X-Mimecast-MFC-AGG-ID: 1JZdihQiNu-VsKWwub52Lg_1786377006
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f4bff865cso1185834f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 08:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786377006; x=1786981806; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=O2zhm1K4eCq5mPSb3Ty1evscwBNKJ0KaL7VbpdQ40r4=;
 b=rnzJG/pzYze3U6Rs1IsQ/8iC2D9KNQPKyBWCtqvlOuCqnYB00kniEzLCx2689j8Mxh
 E8V3b7aPQoQkYk0zlEGqVKcm1vOEAy7bhv0WDVekZeeId11eCeChafall+TdgRc0XoGX
 FYTRerHlUYF0vvbP897gSbIm/+rc0ZJ4Tn0yv9pg6r9y9jUdMJ4Va4Wj34s5uhHAajAf
 nvLkVi5iaFHx0LQlMBZTFz9lhA5R/LmZnVhNSgWSIAg3a23C+x9WTaflECPivsaYiHzu
 jP/cfV5xEYXgOjduuLlB7xG/smd3F4EEV3h0H9bOU4hX7i5RRvZXrLkshdBfPX+mH1Ix
 CAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786377006; x=1786981806;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O2zhm1K4eCq5mPSb3Ty1evscwBNKJ0KaL7VbpdQ40r4=;
 b=Hc3T5ojs+r8bq4BHah7bNkzG83HLzxMxRAZVImYlox8ZvMgolZGEtQynFV2b143Q4J
 LYKvyuD4Xlw4aoS7mIIBocOy0z/ZSNH3mUVkdhL0JQtVLo7cKcsli5kxWKyjoFEuyzcN
 YQE1HRASvzlRPveSrABeYdpUrsUTbmAhYAS/vNYKRlAGjinf7CHjvnY6CNC7SQMn0IpO
 BmsU/4LESw6uKDRNTP7Pgp0knSy644ur+wiTB3nYHBRK4x7e+QIF/LMOL85CHHU+drTZ
 nKvoVEFT9ZKvFDQ+3nIU2Q4qajyCG2+yjx/WWAbOd+moRFUNRwll236X9Q0z3+oM2+dm
 z3UQ==
X-Gm-Message-State: AOJu0YziXmUcgqeq0K5xfUrh/RwW7tTRWoKnm1HjxDHPbbTmBF7wtxL9
 DLS+vsFi7Kp0hwfSjCHDninK7lHbwtEQJEa0lGlxprHfaKvIJ5JNcilNWL4kGX3RlsJqRwScr8u
 wTML8SvXQWqh8SiPZ6YW/qCK80uCpDIf+pcePDyvG1CrcC85HT9fLmLQA
X-Gm-Gg: AR+sD11aZPzWbnCU2oXzpk4sI1ZQIEdBDMymgp++9BN3XluHLMTTPIEi/j9i/T5l8H6
 LgJh6HdfiV9sPJPlavKudDPbK7BVFNbYPgMfPpSmyXfvR+XZCWigKkDlo7eK6ayMJs8MMf1nbYH
 FXd6Q8lCn+oAXZ5qn+ic/7mnomTakkI5WcyRnZfYYLbnN/9OyzGhez+LxSYJcTzzU5yZVZIp8sh
 eKoWhemwHVpLslUTM+to5labGkGfGhkKA85QzLikGQ2m2hENabY4xz6FUM1Qq5iyHtYUHLvCLVM
 UrIvv3uzS8WAFNA0j95TSsyHdLZjUQ8kORBuyCYl/bBfVNK6qyLkcqPG
X-Received: by 2002:a05:6000:29d5:b0:47f:2de3:b351 with SMTP id
 ffacd0b85a97d-47fec63538dmr46514524f8f.26.1786377006048; 
 Mon, 10 Aug 2026 08:50:06 -0700 (PDT)
X-Received: by 2002:a05:6000:29d5:b0:47f:2de3:b351 with SMTP id
 ffacd0b85a97d-47fec63538dmr46514483f8f.26.1786377005638; 
 Mon, 10 Aug 2026 08:50:05 -0700 (PDT)
Received: from fedora ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021457ebsm35762953f8f.6.2026.08.10.08.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 08:50:05 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:50:03 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 pbonzini@redhat.com, philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v4 10/11] migration/tests: Add test for fast snapshot load
Message-ID: <annzFudG2ZfbdPJc@fedora>
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
 <20260801023628.22665-11-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801023628.22665-11-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2026-08-01 08:06, Aadeshveer Singh wrote:
> Add test_postcopy_file_mapped_ram() to test for saving a snapshot in
> mapped ram format and loading it using postcopy/fast snapshot load.
> 
> Test is similar to test_precopy_file_mapped_ram() with additional
> start_hook to set postcopy capabilities on the receiving end.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/qtest/migration/file-tests.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


