Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C73CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 15:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEUIg-0007xN-21; Thu, 30 Oct 2025 11:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEUIb-0007ug-J4
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:10:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEUIO-0004zy-H1
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761837028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLCJFMFmLLXYO0xxJ0wcxdVAZPqT6sl16eTV5Q1svic=;
 b=Qi+WYl9YZLV1DzTvIseWRTPJpNm8RhB7IVP7sT4S+2mFkrgaxTUU0sYhiK8i+d/7xmBVER
 TR3HMFOpEcc4N3P222BYAts7o/XS8BmAdO0mvkvVtSzxv60EPDqELnypHZ11glEMddnFBa
 /fT2MKXPCbJNZYW1YCQjrt/wXwf/baU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-0XUvqDMAO22Tw8Yts8Cmzw-1; Thu, 30 Oct 2025 11:10:27 -0400
X-MC-Unique: 0XUvqDMAO22Tw8Yts8Cmzw-1
X-Mimecast-MFC-AGG-ID: 0XUvqDMAO22Tw8Yts8Cmzw_1761837026
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8a15d36c209so300158585a.3
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 08:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761837026; x=1762441826;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JLCJFMFmLLXYO0xxJ0wcxdVAZPqT6sl16eTV5Q1svic=;
 b=Hr7f/2UvXsFafR/rDCg0LN9iotphO7yeF+H4XvJ08HQPCRXs3oBPUL/sG6rUTL7U2B
 7ZSw91EYsJ+84ZEpsT4x868p7eRgZ0Qi6BXYnMS7Q9dsY4McerUDPAWcQ9rq9cp6z0sN
 7Y/7OnPDuTrvlLe+icp5fqxNn5BjPt/nljCmYkRW86DVK4+mEkdYchZ5J1C4mcbgGeLc
 WRppUm4H429ePMAp7QaePmIA4XbMejeLZ16rUKfMqKd09AWZWnWnqsKr3PeYGR8q1B2F
 quU0rwpbBesw9uP1lhhP0JHDWcOGbpIIcm353oX6K/Kaj0JqBYK5vItBkTFCoFY996Mf
 OH3g==
X-Gm-Message-State: AOJu0YyyevbmrblTMW0B+g4tG3dq/L8foKhSmFmBzCxZ71Vy8Dw3QexU
 yXuKmZ1NwUwEkW96cU4W7LcY1DHMTjMZdDhJoWsaoWTJqTtOSP9thaxxc2rT+UhzpiGW5PKu7SS
 No6J/4Iq6hO4GopgPw6ANhNCGFZYSw/skJ3Oe3PDYLdXAPuwaHgJOs3Xj
X-Gm-Gg: ASbGncvC9OvNFU4f0w6LgtsSgUyMqOMgGmyXn46YeErm4soi8L4Gaman180WrrhGj2T
 XX09Tbv2TX8g4sFcZ1slGrBMVev9TvOb19zIKEnm8OhDciEudScvvg5sDJjCqw0hIok67bpIh3g
 VDiYSdpcP4lpWWWuu6f+BCbQ0j8fdZ2364R25Vp3cGyBKyThGzRFdEbvFtK/cYhjvEMI1Fey5nt
 //VUn7MhTsrvH+Q+TIIuqHFSHqeXYtIX7/OUV6byqMzGKvXOXtE4cZiGIUMqGPX1w7JbVCrf6+O
 PRJIfy/cWULfyuly32yKf1j+YU1tf0q4DTnbJTMidpc/JS4KszKNYbz9iVDflQ5hkWY=
X-Received: by 2002:a05:620a:2544:b0:89f:4306:2a50 with SMTP id
 af79cd13be357-8aa2de73b28mr457484485a.42.1761837026203; 
 Thu, 30 Oct 2025 08:10:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaMBiCEqqGVJK8jInLhluLyBbEL0+y/90iCSr+b6bBly3jpJE1yUgCZHBVUVX5gGwBefI8Rw==
X-Received: by 2002:a05:620a:2544:b0:89f:4306:2a50 with SMTP id
 af79cd13be357-8aa2de73b28mr457477085a.42.1761837025539; 
 Thu, 30 Oct 2025 08:10:25 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f25c8b517sm1280191185a.45.2025.10.30.08.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 08:10:24 -0700 (PDT)
Date: Thu, 30 Oct 2025 11:10:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Amit Shah <amit@kernel.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH] scripts/vmstate-static-checker: Fix deprecation warnings
 with latest argparse
Message-ID: <aQN_3oHmOdtPuwUb@x1.local>
References: <20251030092638.39505-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251030092638.39505-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 30, 2025 at 10:26:38AM +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The argparse.FileType() type has been deprecated in the latest argparse
> version (e.g. the one from Fedora 43), now causing the test_bad_vmstate
> functional test to fail since there are unexpected strings in the output.
> Change the script to use pathlib.Path instead to fix the test_bad_vmstate
> test and to be prepared for the future when the deprecated FileType gets
> removed completely.
> 
> Reported-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

queued, thanks.

-- 
Peter Xu


